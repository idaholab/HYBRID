within NHES.Systems.BalanceOfPlant.Turbine;
model SFR_Power_Conversion

  extends BaseClasses.Partial_SubSystem(
    redeclare replaceable Examples.CS_SFR_01 CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare Data.IdealTurbine data);


  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{70,22},{90,42}})));
  Fluid.Vessels.IdealCondenser Condenser(
    p=10000,
    V_total=5000,
    V_liquid_start=1.2)
    annotation (Placement(transformation(extent={{64,-30},{44,-10}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    N_nominal=1500,
    dp_nominal=12000000,
    m_flow_nominal=215,
    d_nominal=1100,
    N_input=1800)
    annotation (Placement(transformation(extent={{32,-32},{12,-52}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12500000,
    T_start=481.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5.0),
    use_HeatPort=true,
    use_TraceMassPort=false) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-28,-42})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary1(
      use_port=true, Q_flow=75000000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-28,-72})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-64,-42})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=50) annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={4,38})));
  TRANSFORM.Fluid.Machines.SteamTurbine HPT(
    nUnits=1,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=12500000,
    p_b_start=8000,
    T_a_start=623.15,
    T_b_start=363.15,
    m_flow_nominal=230,
    p_inlet_nominal=12000000,
    p_outlet_nominal=10000,
    use_T_nominal=false,
    T_nominal=683.15,
    d_nominal=70)
    annotation (Placement(transformation(extent={{32,26},{52,46}})));
  Modelica.Blocks.Sources.Constant const(k=1.0)
    annotation (Placement(transformation(extent={{-30,54},{-10,74}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(rotation=0, extent={{-110,50},{-90,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(
                                                   redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(rotation=0, extent={{-110,-52},{-90,-32}})));
  Modelica.Blocks.Sources.RealExpression Q_balance1
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-96,102},{-84,114}})));
  TRANSFORM.Fluid.Sensors.Pressure           sensor_p(redeclare package Medium
      = Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-48,76})));
equation
  connect(Condenser.port_a,HPT. portLP) annotation (Line(points={{61,-10},{88,
          -10},{88,20},{94,20},{94,42},{52,42}},            color={0,127,255}));
  connect(pump.port_a,Condenser. port_b) annotation (Line(points={{32,-42},{54,
          -42},{54,-30}},              color={0,127,255}));
  connect(pump.port_b,volume1. port_a)
    annotation (Line(points={{12,-42},{-22,-42}},  color={0,127,255}));
  connect(boundary1.port,volume1. heatPort) annotation (Line(points={{-28,-62},
          {-28,-48}},                                        color={191,0,0}));
  connect(sensor_T2.port_a,volume1. port_b)
    annotation (Line(points={{-54,-42},{-34,-42}}, color={0,127,255}));
  connect(TCV.port_b, HPT.portHP) annotation (Line(points={{12,38},{22,38},{22,
          42},{32,42}},  color={0,127,255}));
  connect(generator.shaft, HPT.shaft_b) annotation (Line(points={{69.9,31.9},{
          60,31.9},{60,36},{52,36}},color={0,0,0}));
  connect(port_a, TCV.port_a) annotation (Line(points={{-100,60},{-54,60},{-54,
          38},{-4,38}},
                     color={0,127,255}));
  connect(port_b, sensor_T2.port_b) annotation (Line(points={{-100,-42},{-74,
          -42}},     color={0,127,255}));
  connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
      points={{-30,100},{-110,100},{-110,-66},{-64,-66},{-64,-45.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Q_FWH, boundary1.Q_flow_ext) annotation (Line(
      points={{30,100},{100,100},{100,-88},{-28,-88},{-28,-76}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, Q_balance1.y) annotation (Line(
      points={{-30,100},{-80,100},{-80,108},{-83.4,108}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{36,100.1},{36,52},{38,52},{38,50},{4,50},{4,44.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(port_a, sensor_p.port)
    annotation (Line(points={{-100,60},{-48,60},{-48,66}}, color={0,127,255}));
  connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
      points={{-30,100},{-32,100},{-32,88},{-60,88},{-60,78},{-54,78},{-54,76}},

      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
end SFR_Power_Conversion;
