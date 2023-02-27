within NHES.Systems.PrimaryHeatSystem.SFR.Examples;
model SFR_Example_02
  package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT;
  package IL_Medium = NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt;

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = IL_Medium,
    use_T_in=true,
    m_flow=1500,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{82,-8},{62,12}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = IL_Medium,
    p=100000,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{86,24},{66,44}})));
  Modelica.Blocks.Sources.Constant const(k=245 + 273.15)
    annotation (Placement(transformation(extent={{126,-4},{106,16}})));
  Components.SFR_02_NTUHX sFR_02_NTUHX(redeclare
      NHES.Systems.PrimaryHeatSystem.SFR.CS_01 CS(rho_CR_Init=-1),
                                       redeclare package Medium_IHX_Loop =
        IL_Medium)
    annotation (Placement(transformation(extent={{-108,-22},{-30,56}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium = IL_Medium)
    annotation (Placement(transformation(extent={{18,-10},{-4,14}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package Medium = IL_Medium)
    annotation (Placement(transformation(extent={{-2,22},{24,46}})));
equation
  connect(boundary.T_in, const.y) annotation (Line(points={{84,6},{105,6}},
                               color={0,0,127}));
  connect(boundary.ports[1], sensor_T.port_a) annotation (Line(points={{62,2},{
          18,2}},                                    color={0,127,255}));
  connect(sensor_T.port_b, sFR_02_NTUHX.port_a) annotation (Line(points={{-4,2},{
          -31.17,2.57}},           color={0,127,255}));
  connect(boundary1.ports[1], sensor_T1.port_b)
    annotation (Line(points={{66,34},{24,34}},  color={0,127,255}));
  connect(sensor_T1.port_a, sFR_02_NTUHX.port_b) annotation (Line(points={{-2,34},
          {-20,34},{-20,34.55},{-31.17,34.55}},
                                             color={0,127,255}));
  annotation (experiment(StopTime=100000, __Dymola_Algorithm="Esdirk45a"));
end SFR_Example_02;
