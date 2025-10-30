within NHES.Systems.EnergyStorage.PCM_HITB.Components.PCM_Volume;
model PCM_Chamber_onethirdsym "Contained PCM chamber generalizable to interact with a heat pipe 
  at location specified by user as node Nr and Ntheta. 
  It is on implementation that any Z-dependencies should be enforced. 
  Convection BCs on the outside surfaces are allowed, adiabatic internal conditions imposed."
  parameter Integer nR = 10;
  parameter Integer nTheta = 7;
  parameter Integer nZ = 6;
  parameter Modelica.Units.SI.Length R_HP = 1.325*25.4/1000;
  parameter Modelica.Units.SI.Length R_PCM = 0.295275;
  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26-73.66,27.76,25,25,25,25,35.287};
  parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = {0.3472,0.2,0.2,0.6,0.2,0.2,2.0944-1.7472};
  parameter Modelica.Units.SI.Length dzs_one[nZ] = 0.595/nZ*ones(nZ);
  parameter Modelica.Units.SI.Length t_PCM_wall = 0.0025;
  parameter Modelica.Units.SI.Length l_PCM = 0.595;
    parameter Integer nR_HP = 4;
  parameter Integer nTheta_HP = 4;

  Modelica.Units.SI.Length drs[nR, nTheta, nZ];
  Modelica.Units.SI.Angle dthetas[nR, nTheta, nZ];
  Modelica.Units.SI.Length dzs[nR, nTheta, nZ];
  Modelica.Units.SI.Volume dVs_HP[nR, nTheta, nZ];
  Modelica.Units.SI.Power Q_heat[nZ];
  Modelica.Units.SI.Power Q_gens[nR, nTheta, nZ];
  Modelica.Units.SI.Length l_shell[nTheta, nZ];
  Modelica.Units.SI.Area SA_End[nR, nTheta];
  Modelica.Units.SI.Area SA_shell[nTheta, nZ];
  Modelica.Units.SI.Temperature T_ave_r[nR];
  Modelica.Units.SI.Temperature T_ave_theta[nTheta];
  Modelica.Units.SI.Temperature T_ave_z[nZ];

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

  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_State port_b[nZ]
    annotation (Placement(transformation(extent={{4,6},{24,26}}),
        iconTransformation(extent={{4,6},{24,26}})));
initial equation

equation

  for i in 1:nR loop
    T_ave_r[i] = sum(conduction.materials[i,:,:].T)/(nTheta*nZ);
    for j in 1:nTheta loop
      SA_End[i,j] = ((conduction.geometry.rs[i,j,1]+0.5*drs_one[i])*(conduction.geometry.rs[i,j,1]+0.5*drs_one[i])-(conduction.geometry.rs[i,j,1]-0.5*drs_one[i])*(conduction.geometry.rs[i,j,1]-0.5*drs_one[i]))*dthetas_one[j]/2;
      for k in 1:nZ loop
        drs[i,j,k] = drs_one[i];
        dthetas[i,j,k] = dthetas_one[j];
        dzs[i,j,k] = dzs_one[k];
        if i==nR_HP and j==nTheta_HP then
          dVs_HP[i,j,k] = -Modelica.Constants.pi*R_HP*R_HP*dzs_one[k];
          Q_gens[i,j,k] = Q_heat[k];
        else
          dVs_HP[i,j,k] = 0;
          Q_gens[i,j,k] = 0;
        end if;
      end for;
    end for;
  end for;

  for k in 1:nZ loop
    Q_heat[k] = port_b[k].Q_flow;
    port_b[k].T = conduction.materials[nR_HP,nTheta_HP,k].T;
    T_ave_z[k] = sum(conduction.materials[:,:,k].T)/(nR*nTheta);
  end for;

  for j in 1:nTheta loop
    T_ave_theta[j] = sum(conduction.materials[:,j,:].T)/(nR*nZ);
    for k in 1:nZ loop
      SA_shell[j,k] = dthetas_one[j]/(2*Modelica.Constants.pi)*(R_PCM+t_PCM_wall)*dzs_one[k];
      l_shell[j,k] = dthetas_one[j]/(2*Modelica.Constants.pi)*dzs_one[k];
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{34,9},{-34,-9}},
          textColor={28,108,200},
          origin={94,93},
          rotation=90,
          textString="<--- Z direction")}));
end PCM_Chamber_onethirdsym;
