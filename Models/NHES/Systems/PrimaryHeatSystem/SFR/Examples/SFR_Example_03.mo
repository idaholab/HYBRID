within NHES.Systems.PrimaryHeatSystem.SFR.Examples;
model SFR_Example_03
  package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT;
  package IL_Medium =
      NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt;

  Components.SFR_Intermediate_Loop sFR_Intermediate_Loop(redeclare package
      Medium_IHX_Loop = IL_Medium)
    annotation (Placement(transformation(extent={{-18,-24},{66,42}})));
  Components.SFR_02_NTUHX sFR_02_NTUHX(redeclare replaceable CS_01 CS(
        rho_CR_Init=-1.0),             redeclare package Medium_IHX_Loop =
        IL_Medium)
    annotation (Placement(transformation(extent={{-140,-24},{-60,42}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=215,
    T=483.15,
    nPorts=1) annotation (Placement(transformation(extent={{156,-14},{136,6}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=12500000,
    nPorts=1) annotation (Placement(transformation(extent={{152,12},{132,32}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{88,14},{108,34}})));
equation
  connect(sFR_02_NTUHX.port_a, sFR_Intermediate_Loop.port_IHX_b) annotation (
      Line(points={{-61.2,-3.21},{-38,-3.21},{-38,-2},{-28,-2},{-28,-2.55},{
          -16.74,-2.55}},                                          color={0,127,
          255}));
  connect(sFR_02_NTUHX.port_b, sFR_Intermediate_Loop.port_IHX_a) annotation (
      Line(points={{-61.2,23.85},{-42,23.85},{-42,24},{-30,24},{-30,23.85},{
          -16.74,23.85}},                                          color={0,127,
          255}));
  connect(sFR_Intermediate_Loop.port_SG_a, boundary.ports[1]) annotation (Line(
        points={{64.74,-3.21},{100,-3.21},{100,-4},{136,-4}}, color={0,127,255}));
  connect(sFR_Intermediate_Loop.port_SG_b, sensor_T.port_a) annotation (Line(
        points={{64.74,23.85},{64.74,24},{88,24}}, color={0,127,255}));
  connect(sensor_T.port_b, boundary1.ports[1]) annotation (Line(points={{108,24},
          {120,24},{120,22},{132,22}}, color={0,127,255}));
  annotation (experiment(StopTime=100000, __Dymola_Algorithm="Esdirk45a"));
end SFR_Example_03;
