within NHES.Systems.EnergyStorage.PCM_HITB.HITB;
model New_3D_Conduction_Alone
  "This model should represent the tri-pipe system pretty well. Of course, the material properties should be updated eventually. 
   That being said, it uses BCs for the heat pipe, so basically this is just a stepping stone into HITB_Experiment_03s"
  parameter Integer nR = 10;
  parameter Integer nTheta = 7;
  parameter Integer nZ = 6;
  parameter Modelica.Units.SI.Length R_HP = 1.325*25.4/1000;
  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26-73.66,27.76,25,25,25,25,35.287};
  parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = {0.3472,0.2,0.2,0.6,0.2,0.2,2.0944-1.7472};
  parameter Modelica.Units.SI.Length dzs_one[nZ] = 0.595/nZ*ones(nZ);

  Modelica.Units.SI.Length drs[nR, nTheta, nZ];
  Modelica.Units.SI.Angle dthetas[nR, nTheta, nZ];
  Modelica.Units.SI.Length dzs[nR, nTheta, nZ];
  Modelica.Units.SI.Volume dVs_HP[nR, nTheta, nZ];
  Modelica.Units.SI.Power Q_heat[nZ];
  Modelica.Units.SI.Power Q_gens[nR, nTheta, nZ];

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_3D conduction(
    redeclare package Material = PCM_Materials.PCM_HITB_2_Sin,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=698.15,
    T_b1_start=698.15,
    T_a2_start=698.15,
    T_b2_start=698.15,
    T_a3_start=698.15,
    T_b3_start=698.15,
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
    annotation (Placement(transformation(extent={{-52,-10},{30,74}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=-1.5e3,
    rising=3600,
    width=10800,
    falling=3600,
    period=28800,
    offset=0.8e3,
    startTime=10800)
    annotation (Placement(transformation(extent={{-118,-78},{-98,-58}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_z[
    nR,nTheta]
    annotation (Placement(transformation(extent={{-86,-22},{-66,-2}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_z1[
    nR,nTheta] annotation (Placement(transformation(extent={{68,70},{48,90}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_r[
    nTheta,nZ]
    annotation (Placement(transformation(extent={{-148,14},{-128,34}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_r1[
    nTheta,nZ] annotation (Placement(transformation(extent={{94,22},{74,42}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic
    adiabatic_theta[nR,nZ]
    annotation (Placement(transformation(extent={{-66,-58},{-46,-38}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic
    adiabatic_theta1[nR,nZ]
    annotation (Placement(transformation(extent={{-50,84},{-30,104}})));
initial equation

equation

  for i in 1:nR loop
    for j in 1:nTheta loop
      for k in 1:nZ loop
        drs[i,j,k] = drs_one[i];
        dthetas[i,j,k] = dthetas_one[j];
        dzs[i,j,k] = dzs_one[k];
        if i==4 and j==4 then
          dVs_HP[i,j,k] = -Modelica.Constants.pi*R_HP*R_HP*dzs_one[k];
          Q_gens[i,j,k] = Q_heat[k];
        else
          dVs_HP[i,j,k] = 0;
          Q_gens[i,j,k] = 0;
        end if;
      end for;
    end for;
  end for;

  for k in 1:nZ-1 loop
    Q_heat[k] = trapezoid.y/(nZ-1);
  end for;
  Q_heat[nZ] = 0;

  connect(conduction.port_b3, adiabatic_z1.port) annotation (Line(points={{21.8,
          65.6},{20,65.6},{20,80},{48,80}}, color={191,0,0}));
  connect(adiabatic_z.port, conduction.port_a3) annotation (Line(points={{-66,-12},
          {-52,-12},{-52,-2},{-43.8,-2},{-43.8,-1.6}}, color={191,0,0}));
  connect(conduction.port_a1, adiabatic_r.port) annotation (Line(points={{-52,32},
          {-120,32},{-120,24},{-128,24}}, color={191,0,0}));
  connect(conduction.port_b1, adiabatic_r1.port)
    annotation (Line(points={{30,32},{74,32}}, color={191,0,0}));
  connect(adiabatic_theta.port, conduction.port_a2) annotation (Line(points={{-46,
          -48},{-26,-48},{-26,-46},{-11,-46},{-11,-10}}, color={191,0,0}));
  connect(adiabatic_theta1.port, conduction.port_b2) annotation (Line(points={{-30,
          94},{4,94},{4,74},{-11,74}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end New_3D_Conduction_Alone;
