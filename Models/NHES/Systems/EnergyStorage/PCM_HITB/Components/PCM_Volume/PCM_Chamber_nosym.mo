within NHES.Systems.EnergyStorage.PCM_HITB.Components.PCM_Volume;
model PCM_Chamber_nosym "Contained PCM chamber generalizable to interact with a heat pipe 
  at location specified by user as node Nr and Ntheta. 
  It is on implementation that any Z-dependencies should be enforced. 
  Convection BCs on the outside surfaces are allowed, adiabatic internal conditions imposed."
  parameter Integer nR = 10;
  parameter Integer nTheta = 21;
  parameter Integer nZ = 6;
  parameter Integer n_HPs=3;
  parameter Modelica.Units.SI.Length R_HP = 1.325*25.4/1000;
  parameter Modelica.Units.SI.Length R_PCM = 0.295275;
  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26-73.66,27.76,25,25,25,25,35.287};
  parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = {0.3472,0.2,0.2,0.6,0.2,0.2,2*pi/3-1.7472,0.3472,0.2,0.2,0.6,0.2,0.2,2*pi/3-1.7472,0.3472,0.2,0.2,0.6,0.2,0.2,2*pi/3-1.7472};
  parameter Modelica.Units.SI.Length dzs_one[nZ] = 0.595/nZ*ones(nZ);
  parameter Modelica.Units.SI.Length t_PCM_wall = 0.0025;
  parameter Modelica.Units.SI.Length l_PCM = 0.595;
    parameter Integer nR_HP = 4;
  parameter Integer nTheta_HP[n_HPs] = {4,11,18};
  parameter Integer HPs[nTheta] = {0,0,0,1,0,0,0,0,0,0,2,0,0,0,0,0,0,3,0,0,0};

  Modelica.Units.SI.Length drs[nR, nTheta, nZ];
  Modelica.Units.SI.Angle dthetas[nR, nTheta, nZ];
  Modelica.Units.SI.Length dzs[nR, nTheta, nZ];
  Modelica.Units.SI.Volume dVs_HP[nR, nTheta, nZ];
  Modelica.Units.SI.Power Q_heat[nZ,n_HPs];
  Modelica.Units.SI.Power Q_gens[nR, nTheta, nZ];
  Modelica.Units.SI.Length l_shell[nTheta, nZ];
  Modelica.Units.SI.Area SA_End[nR, nTheta];
  Modelica.Units.SI.Area SA_shell[nTheta, nZ];
  Modelica.Units.SI.Temperature T_ave_r[nR];
  Modelica.Units.SI.Temperature T_ave_theta[nTheta];
  Modelica.Units.SI.Temperature T_ave_z[nZ];
  parameter Modelica.Units.SI.DynamicViscosity mu =  5e-4;

  Modelica.Units.SI.Power Q_conv_r[nR,nTheta,nZ];
  Modelica.Units.SI.Power Q_conv_t[nR,nTheta,nZ];
  Modelica.Units.SI.Power Q_conv_net[nR, nTheta, nZ];
  Real Nu_r[nR,nTheta,nZ];
  Real Nu_t[nR,nTheta,nZ];
  Real Gr_r[nR,nTheta,nZ];
  Real Gr_t[nR,nTheta,nZ];
  Real Pr[nR,nTheta,nZ];
  Real beta[nR,nTheta,nZ](unit = "1/K");
  Modelica.Units.SI.Temperature Temp_Profile[nR,nTheta,nZ];

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_3D conduction(
    redeclare package Material = PCM_Materials.PCM_HITB_2_Sin,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=698.15,
    T_b1_start=698.15,
    T_a2_start=698.15,
    T_b2_start=698.15,
    T_a3_start=698.15,
    T_b3_start=698.15,
    exposeState_b1=true,
    exposeState_b2=true,
    exposeState_b3=true,
    redeclare model Geometry = HITB.Cylinder_3D_InteriorPipe (
        nR=nR,
        nTheta=nTheta,
        nZ=nZ,
        drs=drs,
        dthetas=dthetas,
        dzs=dzs,
        dVs_int=dVs_HP),
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_3.GenericHeatGeneration
        (Q_gens=Q_gens))
    annotation (Placement(transformation(extent={{-18,-40},{64,44}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_r[
    nTheta,nZ]
    annotation (Placement(transformation(extent={{-70,-8},{-50,12}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic
    adiabatic_theta[nR,nZ]
    annotation (Placement(transformation(extent={{-14,-88},{6,-68}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic
    adiabatic_theta1[nR,nZ]
    annotation (Placement(transformation(extent={{-14,48},{6,68}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Outer[nTheta,nZ](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    length=l_shell,
    r_inner=R_PCM,
    r_outer=R_PCM + t_PCM_wall)
    annotation (Placement(transformation(extent={{78,-8},{98,12}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial[nTheta,nZ](T=293.15)
               annotation (Placement(transformation(extent={{156,-8},{136,12}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection2[nTheta,nZ](
      surfaceArea=SA_shell,                        alpha=25e-4)
    annotation (Placement(transformation(extent={{128,-8},{108,12}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall[nR,nTheta](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    th=t_PCM_wall,
    surfaceArea=SA_End) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-42,-54})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall1[nR,nTheta](
    th=t_PCM_wall,
    surfaceArea=SA_End,
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,66})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection3[nR,nTheta](
     surfaceArea=SA_End, alpha=25e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-42,-80})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial2[nR,nTheta](T=293.15)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-42,-108})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial1[nR,nTheta](T=293.15)
               annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={70,128})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection4[nR,nTheta](
     surfaceArea=SA_End, alpha=25e-4) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={70,96})));

  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_State port_b[nZ,n_HPs]
    annotation (Placement(transformation(extent={{4,6},{24,26}}),
        iconTransformation(extent={{4,6},{24,26}})));
initial equation

equation
  for i in 1:nR loop
    for j in 1:nTheta loop
      for k in 1:nZ loop
        if i == 1 and j==1 then
          Q_conv_net[i,j,k] = 0-Q_conv_r[i,j,k]+Q_conv_t[i,nTheta,k]-Q_conv_t[i,j,k];
        elseif i == 1 and j == nTheta then
          Q_conv_net[i,j,k] = 0-Q_conv_r[i,j,k]+Q_conv_t[i,j-1,k]-Q_conv_t[i,j,k];
        elseif i == nR and j == 1 then
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-0 + Q_conv_t[i,nTheta,k]-Q_conv_t[i,j,k];
        elseif i == nR and j == nTheta then
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-0 + Q_conv_t[i,j-1,k]-Q_conv_t[i,j,k];
        elseif i == 1 and j>1 and j<nTheta then
          Q_conv_net[i,j,k] = 0-Q_conv_r[i,j,k] + Q_conv_t[i,j-1,k]-Q_conv_t[i,j,k];
        elseif i == nR and j>1 and j<nTheta then
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-0 + Q_conv_t[i,j-1,k]-Q_conv_t[i,j,k];
        elseif j== 1 and i>1 and i<nR then
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-Q_conv_r[i,j,k] + Q_conv_t[i,nTheta,k]-Q_conv_t[i,j,k];
        elseif j == nTheta and i>1 and i<nR then
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-Q_conv_r[i,j,k] + Q_conv_t[i,j-1,k] - Q_conv_t[i,j,k];
        else
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-Q_conv_r[i,j,k]+Q_conv_t[i,j-1,k]-Q_conv_t[i,j,k];
        end if;
      end for;
    end for;
  end for;

  for i in 1:nR loop
    T_ave_r[i] = sum(conduction.materials[i,:,:].T)/(nTheta*nZ);
    for j in 1:nTheta loop
      SA_End[i,j] = ((conduction.geometry.rs[i,j,1]+0.5*drs_one[i])*(conduction.geometry.rs[i,j,1]+0.5*drs_one[i])-(conduction.geometry.rs[i,j,1]-0.5*drs_one[i])*(conduction.geometry.rs[i,j,1]-0.5*drs_one[i]))*dthetas_one[j]/2;
      for k in 1:nZ loop
        Temp_Profile[i,j,k] = conduction.materials[i,j,k].T;
        drs[i,j,k] = drs_one[i];
        dthetas[i,j,k] = dthetas_one[j];
        dzs[i,j,k] = dzs_one[k];
        beta[i,j,k] = conduction.Material.linearExpansionCoefficient(conduction.materials[i,j,k].state);
        Pr[i,j,k] = conduction.Material.specificHeatCapacityCp(conduction.materials[i,j,k].state)*mu/conduction.Material.thermalConductivity(conduction.materials[i,j,k].state);

          if i == nR_HP and HPs[j]>0 then
          dVs_HP[i,j,k] = -Modelica.Constants.pi*R_HP*R_HP*dzs_one[k];
          Q_gens[i,j,k] = Q_heat[k,HPs[j]]+Q_conv_net[i,j,k];
          else
          dVs_HP[i,j,k] = 0;
          Q_gens[i,j,k] = Q_conv_net[i,j,k];
          end if;

      end for;
    end for;
  end for;

  for k in 1:nZ loop
    T_ave_z[k] = sum(conduction.materials[:,:,k].T)/(nR*nTheta);
    for l in 1:n_HPs loop
    Q_heat[k,l] = port_b[k,l].Q_flow;
    port_b[k,l].T = conduction.materials[nR_HP,nTheta_HP[l],k].T;
    end for;
  end for;

  for j in 1:nTheta loop
    T_ave_theta[j] = sum(conduction.materials[:,j,:].T)/(nR*nZ);
    for k in 1:nZ loop
      SA_shell[j,k] = dthetas_one[j]/(2*Modelica.Constants.pi)*(R_PCM+t_PCM_wall)*dzs_one[k];
      l_shell[j,k] = dthetas_one[j]/(2*Modelica.Constants.pi)*dzs_one[k];
    end for;
  end for;

  for i in 1:nR loop
    for j in 1:nTheta loop
      for k in 1:nZ loop
        if i < nR then
      Gr_r[i,j,k] = (Modelica.Constants.g_n*cos(conduction.geometry.thetas[i,j,k])*beta[i,j,k]*(conduction.materials[i+1,j,k].T-conduction.materials[i,j,k].T)*(conduction.geometry.rs[i+1,j,k]-conduction.geometry.rs[i,j,k])^3)/(0.5*(mu/conduction.materials[i+1,j,k].d+mu/conduction.materials[i,j,k].d)^2);
      Nu_r[i,j,k] = 0.75*(2*Pr[i,j,k]/(5*(1+2*Pr[i,j,k]^0.5+2*Pr[i,j,k])))^0.25*(abs(Gr_r[i,j,k]*Pr[i,j,k]))^0.25;

     // Q_conv_r[i,j,k] = Nu_r[i,j,k]*conduction.Material.thermalConductivity(conduction.materials[i,j,k].state)/(conduction.geometry.rs[i+1,j,k]-conduction.geometry.rs[i,j,k])*conduction.geometry.crossAreas_1[i,j,k]*(conduction.materials[i+1,j,k].T-conduction.materials[i,j,k].T);
        Q_conv_r[i,j,k] = Nu_r[i,j,k]*conduction.conductionModel.Q_flows_1[i,j,k];
        else
          Gr_r[i,j,k] = 0;
          Nu_r[i,j,k] = 0;
          Q_conv_r[i,j,k] = 0;
        end if;
        if j<nTheta then
                Nu_t[i,j,k] = 0.75*(2*Pr[i,j,k]/(5*(1+2*Pr[i,j,k]^0.5+2*Pr[i,j,k])))^0.25*(abs(Gr_t[i,j,k]*Pr[i,j,k]))^0.25;
                Gr_t[i,j,k] = (Modelica.Constants.g_n*sin(conduction.geometry.thetas[i,j,k]+dthetas[i,j,k]/2)*beta[i,j,k]*(conduction.materials[i,j+1,k].T-conduction.materials[i,j,k].T)*(conduction.geometry.rs[i,j,k]*dthetas[i,j,k])^3)/(0.5*(mu/conduction.materials[i,j+1,k].d+mu/conduction.materials[i,j,k].d)^2);
          //      Q_conv_t[i,j,k] = Nu_t[i,j,k]*conduction.Material.thermalConductivity(conduction.materials[i,j,k].state)/(conduction.geometry.rs[i,j,k])*conduction.geometry.crossAreas_2[i,j,k]*(conduction.materials[i,j+1,k].T-conduction.materials[i,j,k].T);
                Q_conv_t[i,j,k] = Nu_t[i,j,k]*conduction.conductionModel.Q_flows_2[i,j,k];
        else    Nu_t[i,j,k] = 0.75*(2*Pr[i,j,k]/(5*(1+2*Pr[i,j,k]^0.5+2*Pr[i,j,k])))^0.25*(abs(Gr_t[i,j,k]*Pr[i,j,k]))^0.25;
                Gr_t[i,j,k] = (Modelica.Constants.g_n*sin(conduction.geometry.thetas[i,j,k]+dthetas[i,j,k]/2)*beta[i,j,k]*(conduction.materials[i,1,k].T-conduction.materials[i,j,k].T)*(conduction.geometry.rs[i,j,k]*dthetas[i,j,k])^3)/(0.5*(mu/conduction.materials[i,1,k].d+mu/conduction.materials[i,j,k].d)^2);
       //         Q_conv_t[i,j,k] =Nu_t[i,j,k]*conduction.Material.thermalConductivity(conduction.materials[i,j,k].state)/(conduction.geometry.rs[i,j,k])*conduction.geometry.crossAreas_2[i,j,k]*(conduction.materials[i,1,k].T-conduction.materials[i,j,k].T);
              //  Q_conv_t[i,j,k]= Nu_t[i,j,k]*(-1)*conduction.conductionModel.Q_flows_2[i,1,k];
                Q_conv_t[i,j,k] = Nu_t[i,j,k]*(-0.5)*(conduction.conductionModel.lambdas_2[i, j, k] + conduction.conductionModel.lambdas_2[i,1, k])
            * conduction.conductionModel.crossAreas_2[i, 1, k]*(conduction.conductionModel.Ts_2[i,1, k] - conduction.conductionModel.Ts_2[i, j, k])/
            conduction.conductionModel.lengths_2[i, 1, k];
        end if;
      end for;
    end for;
  end for;

  connect(conduction.port_a1, adiabatic_r.port) annotation (Line(points={{-18,2},
          {-50,2}},                       color={191,0,0}));
  connect(adiabatic_theta.port, conduction.port_a2) annotation (Line(points={{6,-78},
          {22,-78},{22,-44},{23,-44},{23,-40}},          color={191,0,0}));
  connect(adiabatic_theta1.port, conduction.port_b2) annotation (Line(points={{6,58},{
          22,58},{22,48},{23,48},{23,44}},
                                       color={191,0,0}));
  connect(convection2.port_a,Air_PCM_Axial. port)
    annotation (Line(points={{125,2},{136,2}},   color={191,0,0}));
  connect(PCM_Outer.port_b,convection2. port_b)
    annotation (Line(points={{98,2},{111,2}},    color={191,0,0}));
  connect(convection3.port_a,Air_PCM_Axial2. port)
    annotation (Line(points={{-42,-87},{-42,-98}}, color={191,0,0}));
  connect(convection3.port_b,simpleWall. port_b)
    annotation (Line(points={{-42,-73},{-42,-64}}, color={191,0,0}));
  connect(Air_PCM_Axial1.port,convection4. port_a)
    annotation (Line(points={{70,118},{70,103}}, color={191,0,0}));
  connect(convection4.port_b,simpleWall1. port_b) annotation (Line(points={{70,89},
          {70,76}},                        color={191,0,0}));
  connect(PCM_Outer.port_a, conduction.port_b1) annotation (Line(points={{78,2},{
          64,2}},                   color={191,0,0}));
  connect(simpleWall1.port_a, conduction.port_b3) annotation (Line(points={{70,56},
          {70,35.6},{55.8,35.6}},             color={191,0,0}));
  connect(simpleWall.port_a, conduction.port_a3) annotation (Line(points={{-42,-44},
          {-42,-31.6},{-9.8,-31.6}},color={191,0,0}));
  annotation (Icon(coordinateSystem(PreserveAspectRatio=false), graphics={
        Bitmap(extent={{-70,-74},{62,76}}, fileName=
              "modelica://NHES/Image_PCM.png"),
        Line(
          points={{-4,4},{-4,66}},
          color={255,0,0},
          thickness=2),
        Line(
          points={{-4,4},{54,-30}},
          color={255,0,0},
          thickness=2),
        Line(
          points={{-4,68},{20,64},{36,56},{48,44},{58,28},{62,12},{62,-4},{60,-18},
              {54,-30}},
          color={255,0,0},
          thickness=2)}),                                        Diagram(
        coordinateSystem(PreserveAspectRatio=false), graphics={Text(
          extent={{34,9},{-34,-9}},
          textColor={28,108,200},
          origin={94,93},
          rotation=90,
          textString="<--- Z direction")}));
end PCM_Chamber_nosym;
