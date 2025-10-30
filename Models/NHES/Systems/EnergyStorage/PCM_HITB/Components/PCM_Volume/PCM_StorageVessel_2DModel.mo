within NHES.Systems.EnergyStorage.PCM_HITB.Components.PCM_Volume;
model PCM_StorageVessel_2DModel "Cylindrical vessel using the construction of the HP system but without volumetric defects. 
  THIS MEANS THAT NO HEAT SHOULD BE APPLIED TO HEAT TRANSFER NODES"
  parameter Integer nR = 10;
  parameter Integer nTheta = 11;
  parameter Integer nZ = 6;
  parameter Integer n_HPs = 1;
  parameter Integer n_Thermocouples = 9;
  parameter Real k_multparam = 1.0;

  parameter Modelica.Units.SI.Length R_HP = 1.325*25.4/1000;
  parameter Modelica.Units.SI.Length R_PCM = 0.295275;
  parameter Modelica.Units.SI.Length D_TC = 0.25*25.4/1000;
  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26-73.66,27.74,25,25,25,25,29.5275};
  //parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = {0.3472,0.2,0.2,0.6,0.20.2,2*pi/3-1.7472,0.3472,0.2,0.2,0.5*0.6};
  //parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = Modelica.Constants.pi/180*{20, 15, 20, 12.5, 12.5, 10, 10, 40, 10, 15, 15};
  parameter Modelica.Units.SI.Length dzs_one[nZ] = l_PCM/nZ*ones(nZ);
  parameter Modelica.Units.SI.Length t_PCM_wall = 0.0025;
  parameter Modelica.Units.SI.Length t_heat_trace = 0.0025;
  parameter Modelica.Units.SI.Length l_PCM = 0.145794985/Modelica.Constants.pi/R_PCM/R_PCM;
  parameter Integer nR_HP = 4;
  parameter Real[n_HPs] HPFrac = {3};
 // parameter Integer nTheta_HP[n_HPs] = {1,8};
  //parameter Integer HPs[nTheta] = {1,0,0,0,0,0,0,2,0,0,0}; //This should be thought of as an index. This is used to point to HPFrac.
  parameter Integer HPs[nR] = {0,0,0,1,0,0,0,0,0,0};
  //parameter Integer TCs[n_Thermocouples, 2] = {{1,1},{4,3},{4,6},{4,11},{7,1},{7,3},{7,6},{7,9},{7,11}};
  parameter Integer TCs[n_Thermocouples] = {1,4,4,4,7,7,7,7,7};
  parameter Modelica.Units.SI.Length t_insulation = 2*0.0254;
  input Modelica.Units.SI.Length t_insulation_end = min(t_insulation,0.15);
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 2.5;
  parameter Modelica.Units.SI.Temperature T_Init = 443+273.15-5;
//  Real dAs_2[nR,nTheta,nZ];

/*  Modelica.Units.SI.Length drs[nR, nTheta, nZ];
  Modelica.Units.SI.Angle dthetas[nR, nTheta, nZ];
  Modelica.Units.SI.Length dzs[nR, nTheta, nZ];
  Modelica.Units.SI.Volume dVs_HP[nR, nTheta, nZ];
  Modelica.Units.SI.Volume dVs_TCs[nR, nTheta, nZ]; */
  Modelica.Units.SI.Length drs[nR, nZ];
//  Modelica.Units.SI.Angle dthetas[nR, nZ];
  Modelica.Units.SI.Length dzs[nR, nZ];
  Modelica.Units.SI.Volume dVs_HP[nR, nZ];
  Modelica.Units.SI.Volume dVs_TCs[nR, nZ];
  Modelica.Units.SI.Power Q_heat[nZ,n_HPs];
  /*
  Modelica.Units.SI.Power Q_gens[nR, nTheta, nZ];
  Modelica.Units.SI.Length l_shell[nTheta, nZ];
  Modelica.Units.SI.Area SA_End[nR, nTheta];
  Modelica.Units.SI.Area SA_shell[nTheta, nZ];
  */
  Modelica.Units.SI.Power Q_gens[nR, nZ];
  Modelica.Units.SI.Length l_shell[nZ];
  Modelica.Units.SI.Area SA_End[nR];
  Modelica.Units.SI.Area SA_shell[nZ];
  Modelica.Units.SI.Temperature T_ave_r[nR];
  //Modelica.Units.SI.Temperature T_ave_theta[nTheta];
  Modelica.Units.SI.Temperature T_ave_z[nZ];
  parameter Modelica.Units.SI.DynamicViscosity mu =  5e-4;

/*  Modelica.Units.SI.Power Q_conv_r[nR,nTheta,nZ];
  Modelica.Units.SI.Power Q_conv_t[nR,nTheta,nZ];
  Modelica.Units.SI.Power Q_conv_net[nR, nTheta, nZ];*/
  Modelica.Units.SI.Power Q_conv_r[nR,nZ];
//  Modelica.Units.SI.Power Q_conv_t[nR,nZ];
  Modelica.Units.SI.Power Q_conv_net[nR,nZ];

  Modelica.Units.SI.Power Q_loss;
  Modelica.Units.SI.Power Q_net_trace_and_loss;
  /*Real Nu_r[nR,nTheta,nZ];
  Real Nu_t[nR,nTheta,nZ];
  Real Gr_r[nR,nTheta,nZ];
  Real Gr_t[nR,nTheta,nZ];
  Real Pr[nR,nTheta,nZ];
  Real beta[nR,nTheta,nZ](unit = "1/K");
  Modelica.Units.SI.Temperature Temp_Profile[nR,nTheta,nZ];*/
  Real Nu_r[nR,nZ];
//  Real Nu_t[nR,nZ];
  Real Gr_r[nR,nZ];
//  Real Gr_t[nR,nZ];
  Real Pr[nR,nZ];
  Real beta[nR,nZ](unit = "1/K");
  Modelica.Units.SI.Temperature Temp_Profile[nR,nZ];
  Modelica.Units.SI.Mass m_total;
  Modelica.Units.SI.Temperature T_TCs[n_Thermocouples];
  /*input Modelica.Units.SI.Power Q_heat_trace[nTheta, nZ] annotation(Dialog(tab = "General"));
  Modelica.Units.SI.Power actual_total_heat_trace;*/
//  input Modelica.Units.SI.Power Q_heat_trace[nZ] annotation(Dialog(tab = "General"));
  Modelica.Units.SI.Power actual_total_heat_trace;
  replaceable package Insulation_Material = NHES.Media.Solids.FoamGlass constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                                                                   annotation(Dialog(tab = "General"), choicesAllMatching = true);
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
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        nR=nR,
        nZ=nZ,
        r_outer=R_PCM,
        angle_theta=Modelica.Constants.pi,
        length_z=l_PCM,
        drs=drs,
        dzs=dzs),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.VolumetricHeatGeneration)
    annotation (Placement(transformation(extent={{-20,-40},{62,44}})));

     //   dAs_2=dAs_2,
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_r[nZ]
    annotation (Placement(transformation(extent={{-70,-8},{-50,12}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Outer[nZ](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    length=l_shell,
    r_inner=R_PCM,
    r_outer=R_PCM + t_PCM_wall)
    annotation (Placement(transformation(extent={{78,-8},{98,12}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial[nZ](T=
        293.15)
    annotation (Placement(transformation(extent={{220,-8},{200,12}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection2[nZ](
      surfaceArea=SA_shell, alpha=hc_air)
    annotation (Placement(transformation(extent={{192,-8},{172,12}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall[nR](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    th=t_PCM_wall,
    surfaceArea=SA_End) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={22,-68})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall1[nR](
    th=t_PCM_wall,
    surfaceArea=SA_End,
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={22,70})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection3[nR](
      surfaceArea=SA_End, alpha=hc_air) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={22,-130})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial2[nR](T=
        293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={22,-158})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial1[nR](T=
        293.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={22,162})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection4[nR](
      surfaceArea=SA_End, alpha=hc_air) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={22,130})));

  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_State port_b[nZ,n_HPs]
    annotation (Placement(transformation(extent={{4,6},{24,26}}),
        iconTransformation(extent={{4,6},{24,26}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall End_Insulation_2[nR](
    redeclare package Material = Insulation_Material,
    T_start=293.15,
    th=t_insulation_end,
    surfaceArea=SA_End) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={22,-98})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder Radial_Insulation[nZ](
    redeclare package Material = Insulation_Material,
    T_start=293.15,
    length=l_shell,
    r_inner=R_PCM + t_PCM_wall,
    r_outer=R_PCM + t_PCM_wall + t_insulation)
    annotation (Placement(transformation(extent={{140,-8},{160,12}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall End_Insulation_1[nR](
    th=t_insulation_end,
    surfaceArea=SA_End,
    redeclare package Material = Insulation_Material,
    T_start=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={22,100})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder Heat_Trace[nZ](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    length=l_shell,
    r_inner=R_PCM + t_PCM_wall,
    r_outer=R_PCM + t_PCM_wall + t_heat_trace,
    Q_gen=Heat_Tape_Input/nZ)
    annotation (Placement(transformation(extent={{112,-8},{132,12}})));
  Modelica.Blocks.Interfaces.RealInput Heat_Tape_Input annotation (Placement(
        transformation(extent={{-58,-44},{-98,-4}}),iconTransformation(extent={{
            100,-20},{60,20}})));
initial equation
  Gr_r = zeros(nR, nZ);

algorithm
  dVs_TCs[:,:] := zeros(nR, nZ);
  for i in 1:n_Thermocouples loop
    dVs_TCs[TCs[i],:]:= dVs_TCs[TCs[i]]-D_TC*D_TC/4*conduction.geometry.angle_theta*dzs_one*0;
  end for;

equation
  m_total = sum(conduction.geometry.Vs.*conduction.materials.d);
  for i in 1:n_Thermocouples loop
    T_TCs[i] = 1/nZ*sum(Temp_Profile[TCs[i],:]);
  end for;
  Q_conv_net = Q_conv_r;

  for i in 1:nR loop
    T_ave_r[i] = sum(conduction.materials[i,:].T)/nZ;
    SA_End[i] = conduction.geometry.angle_theta*((conduction.geometry.rs[i,1]+0.5*drs_one[i])*(conduction.geometry.rs[i,1]+0.5*drs_one[i])-(conduction.geometry.rs[i,1]-0.5*drs_one[i])*(conduction.geometry.rs[i,1]-0.5*drs_one[i]));
      for k in 1:nZ loop
        Temp_Profile[i,k] = conduction.materials[i,k].T;
        drs[i,k] = drs_one[i];
        dzs[i,k] = dzs_one[k];
        beta[i,k] = conduction.Material.linearExpansionCoefficient(conduction.materials[i,k].state);
        Pr[i,k] = conduction.Material.specificHeatCapacityCp(conduction.materials[i,k].state)*mu/conduction.Material.thermalConductivity(conduction.materials[i,k].state);

          if i == nR_HP and HPs[i]>0 then
            dVs_HP[i,k] = -Modelica.Constants.pi*R_HP*R_HP*dzs_one[k];
            Q_gens[i,k] = Q_heat[k,HPs[i]]+Q_conv_net[i,k];
            else
            dVs_HP[i,k] = 0;
            Q_gens[i,k] = Q_conv_net[i,k];
          end if;

      end for;
    end for;

  for k in 1:nZ loop
      T_ave_z[k] = sum(conduction.materials[:,k].T)/(nR);
   // Q_heat[k,1] = port_b[k,1].Q_flow*HPFrac[1];
   // Q_heat[k,2] = port_b[k,2].Q_flow*HPFrac[2];
      for l in 1:n_HPs loop
        Q_heat[k,l] = port_b[k,l].Q_flow*HPFrac[l];
        port_b[k,l].T = conduction.materials[nR_HP,k].T;
      end for;
  end for;

    for k in 1:nZ loop
      SA_shell[k] = (R_PCM+t_PCM_wall+t_insulation+t_heat_trace)*Modelica.Constants.pi*2*dzs_one[k];
      l_shell[k]  = dzs_one[k];
    //l_shell[j,k] = dzs_one[k];
    end for;

  for i in 1:nR loop
      for k in 1:nZ loop
       // Q_conv_r[i,j,k] = Nu_r[i,j,k]*conduction.conductionModel.Q_flows_1[i,j,k];
        if i < nR then
      der(Gr_r[i,k]) = -Gr_r[i,k] + (Modelica.Constants.g_n*2/Modelica.Constants.pi)*(beta[i,k]*(conduction.materials[i+1,k].T-conduction.materials[i,k].T)*(conduction.geometry.rs[i+1,k]-conduction.geometry.rs[i,k])^3)/(0.5*(mu/conduction.materials[i+1,k].d+mu/conduction.materials[i,k].d)^2);
      //der(Gr_r[i,k]) = -Gr_r[i,k];
      Nu_r[i,k] = 0.75*(2*Pr[i,k]/(5*(1+2*Pr[i,k]^0.5+2*Pr[i,k])))^0.25*(abs(Gr_r[i,k]*Pr[i,k]))^0.25;
     // Q_conv_r[i,j,k] = Nu_r[i,j,k]*conduction.Material.thermalConductivity(conduction.materials[i,j,k].state)/(conduction.geometry.rs[i+1,j,k]-conduction.geometry.rs[i,j,k])*conduction.geometry.crossAreas_1[i,j,k]*(conduction.materials[i+1,j,k].T-conduction.materials[i,j,k].T);
        else
          der(Gr_r[i,k]) = 0;
          Nu_r[i,k] = 0;
     //     Q_conv_r[i,j,k] = 0;
        end if;
       // Q_conv_t[i,j,k] = Nu_t[i,j,k]*conduction.conductionModel.Q_flows_2[i,j+1,k];
           //     Nu_t[i,k] = 0.75*(2*Pr[i,k]/(5*(1+2*Pr[i,k]^0.5+2*Pr[i,k])))^0.25*(abs(Gr_t[i,k]*Pr[i,k]))^0.25;
           //     der(Gr_t[i,k]) = -Gr_t[i,k];
                /*Gr_t[i,k] = (Modelica.Constants.g_n*sin(conduction.geometry.thetas[i,k]+dthetas[i,k]/2)*beta[i,k]*
                (conduction.materials[i,k].T-conduction.materials[i,k].T)*
                (conduction.geometry.rs[i,k]*dthetas[i,k])^3)/(0.5*(mu/conduction.materials[i,k].d+mu/conduction.materials[i,k].d)^2);*/
          //      Q_conv_t[i,j,k] = Nu_t[i,j,k]*conduction.Material.thermalConductivity(conduction.materials[i,j,k].state)/(conduction.geometry.rs[i,j,k])*conduction.geometry.crossAreas_2[i,j,k]*(conduction.materials[i,j+1,k].T-conduction.materials[i,j,k].T);
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
      for k in 1:nZ loop
        if i < nR then
           Q_conv_r[i,k] = Nu_r[i,k]*conduction.conductionModel.Q_flows_1[i,k];
        else
          Q_conv_r[i,k] = 0;
        end if;
      end for;
  end for;
  Q_loss = (sum(End_Insulation_1.port_b.Q_flow)+sum(End_Insulation_2.port_b.Q_flow)+sum(Radial_Insulation.port_b.Q_flow));
  Q_net_trace_and_loss = (sum(conduction.port_a1.Q_flow)+sum(conduction.port_a2.Q_flow)+sum(conduction.port_b1.Q_flow)+sum(conduction.port_b2.Q_flow));
  actual_total_heat_trace = Heat_Tape_Input;
  connect(conduction.port_a1, adiabatic_r.port) annotation (Line(points={{-20,2},
          {-50,2}},                       color={191,0,0}));
  connect(convection2.port_a,Air_PCM_Axial. port)
    annotation (Line(points={{189,2},{200,2}},   color={191,0,0}));
  connect(convection3.port_a,Air_PCM_Axial2. port)
    annotation (Line(points={{22,-137},{22,-148}}, color={191,0,0}));
  connect(Air_PCM_Axial1.port,convection4. port_a)
    annotation (Line(points={{22,152},{22,137}}, color={191,0,0}));
  connect(PCM_Outer.port_a, conduction.port_b1) annotation (Line(points={{78,2},{
          62,2}},                   color={191,0,0}));
  connect(simpleWall.port_b, End_Insulation_2.port_a)
    annotation (Line(points={{22,-78},{22,-88}},   color={191,0,0}));
  connect(convection3.port_b, End_Insulation_2.port_b)
    annotation (Line(points={{22,-123},{22,-108}},  color={191,0,0}));
  connect(Radial_Insulation.port_b, convection2.port_b)
    annotation (Line(points={{160,2},{175,2}}, color={191,0,0}));
  connect(End_Insulation_1.port_b, convection4.port_b)
    annotation (Line(points={{22,110},{22,123}}, color={191,0,0}));
  connect(End_Insulation_1.port_a, simpleWall1.port_b)
    annotation (Line(points={{22,90},{22,80}}, color={191,0,0}));
  connect(PCM_Outer.port_b, Heat_Trace.port_a)
    annotation (Line(points={{98,2},{112,2}}, color={191,0,0}));
  connect(Heat_Trace.port_b, Radial_Insulation.port_a)
    annotation (Line(points={{132,2},{140,2}}, color={191,0,0}));
  connect(simpleWall.port_a, conduction.port_a2) annotation (Line(points={{22,-58},
          {22,-48},{21,-48},{21,-40}},                      color={191,0,0}));
  connect(simpleWall1.port_a, conduction.port_b2) annotation (Line(points={{22,60},
          {22,54},{21,54},{21,44}}, color={191,0,0}));
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
        coordinateSystem(PreserveAspectRatio=false), graphics={Text(
          extent={{34,9},{-34,-9}},
          textColor={28,108,200},
          origin={46,127},
          rotation=90,
          textString="<--- Z direction")}));
end PCM_StorageVessel_2DModel;
