within NHES.Systems.EnergyStorage.PCM_HITB.Components.PCM_Volume;
model PCM_Chamber_vertsym_2DRTheta "Contained PCM chamber generalizable interact with a heat pipe 
  at location specified by user as node Nr and Ntheta. 
  It is on implementation that any Z-dependencies should be enforced. 
  Convection BCs on the outside surfaces are allowed, adiabatic internal conditions imposed."
  parameter Integer nR = 10;
  parameter Integer nTheta = 11;
  parameter Integer nZ = 6;
  parameter Integer n_HPs = 2;
  parameter Integer n_Thermocouples = 9;

  parameter Modelica.Units.SI.Length R_HP = 1.325*25.4/1000;
  parameter Modelica.Units.SI.Length R_PCM = 0.295275;
  parameter Modelica.Units.SI.Length D_TC = 0.25*25.4/1000;
  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26-73.66,27.74,25,25,25,25,29.5275};
  //parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = {0.3472,0.2,0.2,0.6,0.20.2,2*pi/3-1.7472,0.3472,0.2,0.2,0.5*0.6};
  parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = Modelica.Constants.pi/180*{20, 15, 20, 12.5, 12.5, 10, 10, 40, 10, 15, 15};
  parameter Modelica.Units.SI.Length dzs_one = 0.595/nZ;
  parameter Modelica.Units.SI.Length t_PCM_wall = 0.0025;
  parameter Modelica.Units.SI.Length t_heat_trace = 0.0025;
  parameter Modelica.Units.SI.Length l_PCM = 0.595;
  parameter Integer nR_HP = 4;
  parameter Real[n_HPs] HPFrac = {0.5,1};
  parameter Integer nTheta_HP[n_HPs] = {1,8};
  parameter Integer HPs[nTheta] = {1,0,0,0,0,0,0,2,0,0,0}; //This should be thought of as an index. This is used to point to HPFrac.
  parameter Integer TCs[n_Thermocouples, 2] = {{1,1},{4,3},{4,6},{4,11},{7,1},{7,3},{7,6},{7,9},{7,11}};
  parameter Modelica.Units.SI.Length t_insulation = 2*0.0254;
  input Modelica.Units.SI.Length t_insulation_end = min(t_insulation,0.15);
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 2.5;
  parameter Modelica.Units.SI.Temperature T_Init = 443+273.15-5;
//  Real dAs_2[nR,nTheta,nZ];

  Modelica.Units.SI.Length drs[nR, nTheta];
  Modelica.Units.SI.Angle dthetas[nR, nTheta];
//  Modelica.Units.SI.Length dzs[nR, nTheta];
  Modelica.Units.SI.Volume dVs_HP[nR, nTheta];
  Modelica.Units.SI.Volume dVs_TCs[nR, nTheta];
  Modelica.Units.SI.Power Q_heat[n_HPs];
  Modelica.Units.SI.Power Q_gens[nR, nTheta];
  Modelica.Units.SI.Length l_shell[nTheta];
  Modelica.Units.SI.Area SA_End[nR, nTheta];
  Modelica.Units.SI.Area SA_shell[nTheta];
  Modelica.Units.SI.Temperature T_ave_r[nR];
  Modelica.Units.SI.Temperature T_ave_theta[nTheta];

  parameter Modelica.Units.SI.DynamicViscosity mu =  5e-4;

  Modelica.Units.SI.Power Q_conv_r[nR,nTheta];
  Modelica.Units.SI.Power Q_conv_t[nR,nTheta];
  Modelica.Units.SI.Power Q_conv_net[nR, nTheta];
//  Modelica.Units.SI.Power Q_loss;
//  Modelica.Units.SI.Power Q_net_trace_and_loss;
  Real Nu_r[nR,nTheta];
  Real Nu_t[nR,nTheta];
  Real Gr_r[nR,nTheta];
  Real Gr_t[nR,nTheta];
  Real Pr[nR,nTheta];
  Real beta[nR,nTheta](unit = "1/K");
  Modelica.Units.SI.Temperature Temp_Profile[nR,nTheta];
  Modelica.Units.SI.Mass m_total;
  Modelica.Units.SI.Temperature T_TCs[n_Thermocouples];
 // input Modelica.Units.SI.Power Q_heat_trace[nTheta, nZ] annotation(Dialog(tab = "General"));
  Modelica.Units.SI.Power actual_total_heat_trace;
  replaceable package Insulation_Material = NHES.Media.Solids.FoamGlass constrainedby TRANSFORM.Media.Interfaces.Solids.PartialAlloy annotation(Dialog(tab = "General"), choicesAllMatching = true);
  replaceable package PCM_Material = PCM_Materials.PCM_HITB_2_Sin
    constrainedby TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                                                    annotation(Dialog(tab = "General"), choicesAllMatching = true);

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D conduction(
    redeclare package Material = PCM_Material,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=T_Init,
    T_b1_start=T_Init,
    T_a2_start=T_Init,
    T_b2_start=T_Init,
    exposeState_a1=true,
    exposeState_b1=true,
    exposeState_a2=true,
    exposeState_b2=true,
    redeclare model Geometry =
        NHES.Systems.EnergyStorage.PCM_HITB.Components.PCM_Volume.Cylinder_2D_r_theta_interior_pipes
        (
        nR=nR,
        nTheta=nTheta,
        drs=drs,
        dthetas=dthetas,
        dVs_int=dVs_HP + dVs_TCs,
        dAs_1=ones(nR, nTheta),
        dAs_2=ones(nR, nTheta)),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.GenericHeatGeneration
        (Q_gens=Q_gens))
    annotation (Placement(transformation(extent={{-18,-40},{64,44}})));

     //   dAs_2=dAs_2,
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_r[
    nTheta]
    annotation (Placement(transformation(extent={{-70,-8},{-50,12}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic
    adiabatic_theta[nR]
    annotation (Placement(transformation(extent={{-14,-88},{6,-68}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic
    adiabatic_theta1[nR]
    annotation (Placement(transformation(extent={{-14,48},{6,68}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Outer[nTheta](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    length=l_shell,
    r_inner=R_PCM,
    r_outer=R_PCM + t_PCM_wall)
    annotation (Placement(transformation(extent={{78,-8},{98,12}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial[nTheta](T=293.15)
               annotation (Placement(transformation(extent={{220,-8},{200,12}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection2[nTheta](
      surfaceArea=SA_shell, alpha=hc_air)
    annotation (Placement(transformation(extent={{192,-8},{172,12}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall[nR,nTheta](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    th=t_PCM_wall,
    surfaceArea=2*SA_End)
                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-42,-54})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection3[nR,nTheta](
      surfaceArea=2*SA_End, alpha=hc_air)
                                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-42,-116})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial2[nR,nTheta](T=293.15)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-42,-144})));

  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_State port_b[n_HPs]
    annotation (Placement(transformation(extent={{4,6},{24,26}}),
        iconTransformation(extent={{4,6},{24,26}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall End_Insulation_2[nR,nTheta](
    redeclare package Material = Insulation_Material,
    T_start=293.15,
    th=t_insulation_end,
    surfaceArea=2*SA_End)
                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-42,-84})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder Radial_Insulation[nTheta](
    redeclare package Material = Insulation_Material,
    T_start=293.15,
    length=l_shell,
    r_inner=R_PCM + t_PCM_wall,
    r_outer=R_PCM + t_PCM_wall + t_insulation)
    annotation (Placement(transformation(extent={{140,-8},{160,12}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder Heat_Trace
                                                                     [nTheta](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    length=l_shell,
    r_inner=R_PCM + t_PCM_wall,
    r_outer=R_PCM + t_PCM_wall + t_heat_trace,
    Q_gen=Heat_Tape_Input/(nTheta))
    annotation (Placement(transformation(extent={{112,-8},{132,12}})));
  Modelica.Blocks.Interfaces.RealInput Heat_Tape_Input annotation (Placement(
        transformation(extent={{-56,-46},{-96,-6}}),iconTransformation(extent={{
            100,-20},{60,20}})));
initial equation
  Gr_r = zeros(nR, nTheta);

algorithm
  dVs_TCs[:,:] := zeros(nR, nTheta);
  for i in 1:n_Thermocouples loop
    dVs_TCs[TCs[i,1],TCs[i,2]] := -D_TC*D_TC/4*Modelica.Constants.pi*l_PCM;
  end for;

equation
  m_total = sum(conduction.geometry.Vs.*conduction.materials.d);
  for i in 1:n_Thermocouples loop
    T_TCs[i] = Temp_Profile[TCs[i,1],TCs[i,2]];
  end for;
  for i in 1:nR loop
    for j in 1:nTheta loop

        if i == 1 and j==1 then
          Q_conv_net[i,j] = 0-Q_conv_r[i,j]+Q_conv_t[i,nTheta]-Q_conv_t[i,j];
        elseif i == 1 and j == nTheta then
          Q_conv_net[i,j] = 0-Q_conv_r[i,j]+Q_conv_t[i,j-1]-Q_conv_t[i,j];
        elseif i == nR and j == 1 then
          Q_conv_net[i,j] = Q_conv_r[i-1,j]-0 + Q_conv_t[i,nTheta]-Q_conv_t[i,j];
        elseif i == nR and j == nTheta then
          Q_conv_net[i,j] = Q_conv_r[i-1,j]-0 + Q_conv_t[i,j-1]-Q_conv_t[i,j];
        elseif i == 1 and j>1 and j<nTheta then
          Q_conv_net[i,j] = 0-Q_conv_r[i,j] + Q_conv_t[i,j-1]-Q_conv_t[i,j];
        elseif i == nR and j>1 and j<nTheta then
          Q_conv_net[i,j] = Q_conv_r[i-1,j]-0 + Q_conv_t[i,j-1]-Q_conv_t[i,j];
        elseif j== 1 and i>1 and i<nR then
          Q_conv_net[i,j] = Q_conv_r[i-1,j]-Q_conv_r[i,j] + Q_conv_t[i,nTheta]-Q_conv_t[i,j];
        elseif j == nTheta and i>1 and i<nR then
          Q_conv_net[i,j] = Q_conv_r[i-1,j]-Q_conv_r[i,j] + Q_conv_t[i,j-1] - Q_conv_t[i,j];
        else
          Q_conv_net[i,j] = Q_conv_r[i-1,j]-Q_conv_r[i,j]+Q_conv_t[i,j-1]-Q_conv_t[i,j];
        end if;

    end for;
  end for;

  for i in 1:nR loop
    T_ave_r[i] = sum(conduction.materials[i,:].T)/(nTheta);
    for j in 1:nTheta loop
      SA_End[i,j] = ((conduction.geometry.rs[i,j]+0.5*drs_one[i])*(conduction.geometry.rs[i,j]+0.5*drs_one[i])-(conduction.geometry.rs[i,j]-0.5*drs_one[i])*(conduction.geometry.rs[i,j]-0.5*drs_one[i]))*dthetas_one[j]/2;

        Temp_Profile[i,j] = conduction.materials[i,j].T;
        drs[i,j] = drs_one[i];
        dthetas[i,j] = dthetas_one[j];
        beta[i,j] = conduction.Material.linearExpansionCoefficient(conduction.materials[i,j].state);
        Pr[i,j] = conduction.Material.specificHeatCapacityCp(conduction.materials[i,j].state)*mu/conduction.Material.thermalConductivity(conduction.materials[i,j].state);

          if i == nR_HP and HPs[j]>0 then
            dVs_HP[i,j] = -Modelica.Constants.pi*R_HP*R_HP*l_PCM*HPFrac[HPs[j]];
            Q_gens[i,j] = Q_heat[HPs[j]]+Q_conv_net[i,j];
            else
            dVs_HP[i,j] = 0;
            Q_gens[i,j] = Q_conv_net[i,j];
          end if;
    end for;
  end for;



  //  Q_heat[k,1] = port_b[k,1].Q_flow*HPFrac[1];
   // Q_heat[k,2] = port_b[k,2].Q_flow*HPFrac[2];
      for l in 1:n_HPs loop
    Q_heat[l] = port_b[l].Q_flow*HPFrac[l];
    port_b[l].T = conduction.materials[nR_HP,nTheta_HP[l]].T;
    end for;


  for j in 1:nTheta loop
    T_ave_theta[j] = sum(conduction.materials[:,j].T)/(nR*nZ);
      SA_shell[j] = dthetas_one[j]/(2*Modelica.Constants.pi)*(R_PCM+t_PCM_wall+t_insulation+t_heat_trace)*l_PCM;
      l_shell[j] = dthetas_one[j]/(2*Modelica.Constants.pi)*l_PCM/(2*Modelica.Constants.pi);
    //l_shell[j,k] = dzs_one[k];
  end for;

  for i in 1:nR loop
    for j in 1:nTheta loop

       // Q_conv_r[i,j,k] = Nu_r[i,j,k]*conduction.conductionModel.Q_flows_1[i,j,k];
        if i < nR then
      der(Gr_r[i,j]) = -Gr_r[i,j] + (Modelica.Constants.g_n*cos(conduction.geometry.thetas[i,j])*beta[i,j]*(conduction.materials[i+1,j].T-conduction.materials[i,j].T)*(conduction.geometry.rs[i+1,j]-conduction.geometry.rs[i,j])^3)/(0.5*(mu/conduction.materials[i+1,j].d+mu/conduction.materials[i,j].d)^2);
      Nu_r[i,j] = 0.75*(2*Pr[i,j]/(5*(1+2*Pr[i,j]^0.5+2*Pr[i,j])))^0.25*(abs(Gr_r[i,j]*Pr[i,j]))^0.25;

     // Q_conv_r[i,j,k] = Nu_r[i,j,k]*conduction.Material.thermalConductivity(conduction.materials[i,j,k].state)/(conduction.geometry.rs[i+1,j,k]-conduction.geometry.rs[i,j,k])*conduction.geometry.crossAreas_1[i,j,k]*(conduction.materials[i+1,j,k].T-conduction.materials[i,j,k].T);

        else
          der(Gr_r[i,j]) = 0;
          Nu_r[i,j] = 0;
     //     Q_conv_r[i,j,k] = 0;
        end if;
       // Q_conv_t[i,j,k] = Nu_t[i,j,k]*conduction.conductionModel.Q_flows_2[i,j+1,k];
        if j<nTheta then
                Nu_t[i,j] = 0.75*(2*Pr[i,j]/(5*(1+2*Pr[i,j]^0.5+2*Pr[i,j])))^0.25*(abs(Gr_t[i,j]*Pr[i,j]))^0.25;
                Gr_t[i,j] = (Modelica.Constants.g_n*sin(conduction.geometry.thetas[i,j]+dthetas[i,j]/2)*beta[i,j]*
                (conduction.materials[i,j+1].T-conduction.materials[i,j].T)*
                (conduction.geometry.rs[i,j]*dthetas[i,j])^3)/(0.5*(mu/conduction.materials[i,j+1].d+mu/conduction.materials[i,j].d)^2);
          //      Q_conv_t[i,j,k] = Nu_t[i,j,k]*conduction.Material.thermalConductivity(conduction.materials[i,j,k].state)/(conduction.geometry.rs[i,j,k])*conduction.geometry.crossAreas_2[i,j,k]*(conduction.materials[i,j+1,k].T-conduction.materials[i,j,k].T);

        else  Nu_t[i,j] = 0.75*(2*Pr[i,j]/(5*(1+2*Pr[i,j]^0.5+2*Pr[i,j])))^0.25*(abs(Gr_t[i,j]*Pr[i,j]))^0.25;
                Gr_t[i,j] = (Modelica.Constants.g_n*sin(conduction.geometry.thetas[i,j]+dthetas[i,j]/2)*beta[i,j]*(conduction.materials[i,1].T-conduction.materials[i,j].T)*(conduction.geometry.rs[i,j]*dthetas[i,j])^3)/(0.5*(mu/conduction.materials[i,1].d+mu/conduction.materials[i,j].d)^2);
       //         Q_conv_t[i,j,k] =Nu_t[i,j,k]*conduction.Material.thermalConductivity(conduction.materials[i,j,k].state)/(conduction.geometry.rs[i,j,k])*conduction.geometry.crossAreas_2[i,j,k]*(conduction.materials[i,1,k].T-conduction.materials[i,j,k].T);
              //  Q_conv_t[i,j,k]= Nu_t[i,j,k]*(-1)*conduction.conductionModel.Q_flows_2[i,1,k];
           //     Q_conv_t[i,j,k] = Nu_t[i,j,k]*conduction.conductionModel.Q_flows_2[i,j,k];
        end if;

    end for;
  end for;
/*  for i in 1:nR loop
      for k in 1:nZ loop
        for j in 1:nTheta-1 loop
        dAs_2[i,j,k] = 0;
        end for;
        dAs_2[i,nTheta,k] = 0.3;
      end for;
  end for;*/
  for i in 1:nR loop
    for j in 1:nTheta loop

        if i < nR then
           Q_conv_r[i,j] = Nu_r[i,j]*conduction.conductionModel.Q_flows_1[i,j];
        else
          Q_conv_r[i,j] = 0;
        end if;
          if j<nTheta then
        Q_conv_t[i,j] = Nu_t[i,j]*conduction.conductionModel.Q_flows_2[i,j];
          else
            Q_conv_t[i,j] = 0;
          end if;
    end for;
  end for;
//  Q_loss = 2*Modelica.Constants.pi/sum(dthetas_one)*(sum(End_Insulation_1.port_b.Q_flow)+sum(End_Insulation_2.port_b.Q_flow)+sum(Radial_Insulation.port_b.Q_flow));
//  Q_net_trace_and_loss = 2*Modelica.Constants.pi/sum(dthetas_one)*(sum(conduction.port_a1.Q_flow)+sum(conduction.port_a2.Q_flow)+sum(conduction.port_a3.Q_flow)+sum(conduction.port_b1.Q_flow)+sum(conduction.port_b2.Q_flow)+sum(conduction.port_b3.Q_flow));
  actual_total_heat_trace = Heat_Tape_Input;
  connect(conduction.port_a1, adiabatic_r.port) annotation (Line(points={{-18,2},
          {-50,2}},                       color={191,0,0}));
  connect(adiabatic_theta.port, conduction.port_a2) annotation (Line(points={{6,-78},
          {22,-78},{22,-44},{23,-44},{23,-40}},          color={191,0,0}));
  connect(adiabatic_theta1.port, conduction.port_b2) annotation (Line(points={{6,58},{
          22,58},{22,48},{23,48},{23,44}},
                                       color={191,0,0}));
  connect(convection2.port_a,Air_PCM_Axial. port)
    annotation (Line(points={{189,2},{200,2}},   color={191,0,0}));
  connect(convection3.port_a,Air_PCM_Axial2. port)
    annotation (Line(points={{-42,-123},{-42,-134}},
                                                   color={191,0,0}));
  connect(PCM_Outer.port_a, conduction.port_b1) annotation (Line(points={{78,2},{
          64,2}},                   color={191,0,0}));
  connect(simpleWall.port_b, End_Insulation_2.port_a)
    annotation (Line(points={{-42,-64},{-42,-74}}, color={191,0,0}));
  connect(convection3.port_b, End_Insulation_2.port_b)
    annotation (Line(points={{-42,-109},{-42,-94}}, color={191,0,0}));
  connect(Radial_Insulation.port_b, convection2.port_b)
    annotation (Line(points={{160,2},{175,2}}, color={191,0,0}));
  connect(PCM_Outer.port_b, Heat_Trace.port_a)
    annotation (Line(points={{98,2},{112,2}}, color={191,0,0}));
  connect(Heat_Trace.port_b, Radial_Insulation.port_a)
    annotation (Line(points={{132,2},{140,2}}, color={191,0,0}));
  connect(conduction.port_external, simpleWall.port_a) annotation (Line(points=
          {{-9.8,-31.6},{-42,-31.6},{-42,-44}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(PreserveAspectRatio=false), graphics={
        Bitmap(extent={{-70,76},{62,-74}}, fileName=
              "modelica://NHES/Image_PCM.png"),
        Line(
          points={{-2,70},{-2,-66}},
          color={255,0,0},
          thickness=2),
        Line(
          points={{-2,66},{18,62},{40,50},{52,36},{62,10},{62,-14},{50,-38},{26,
              -60},{-4,-66}},
          color={255,0,0},
          thickness=2)}),                                        Diagram(
        coordinateSystem(PreserveAspectRatio=false)));
end PCM_Chamber_vertsym_2DRTheta;
