within NHES.Systems.BalanceOfPlant.Turbine;
model SFR_Power_Conversion_02

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
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                       nTU_HX_SinglePhase(
    shell_av_b=false,
    use_derQ=false,
    NTU=3.0,
    K_tube=100,
    K_shell=1000,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    p_start_tube=12500000,
    h_start_tube_inlet=300e3,
    h_start_tube_outlet=750e3,
    p_start_shell=5000000,
    h_start_shell_inlet=2500e3,
    h_start_shell_outlet=600e3)
                             annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-24,-40})));
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
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12500000,
    T_start=623.15)
    annotation (Placement(transformation(extent={{-48,28},{-28,48}})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=7500000,
    m_flow_nominal=50) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=270,
        origin={-40,-2})));
  TRANSFORM.Fluid.Valves.ValveLinear TBV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=50) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-46,78})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=12000000,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-88,68},{-68,88}})));
  Modelica.Blocks.Sources.RealExpression SteamPressure(y=volume.port_a.p)
    annotation (Placement(transformation(extent={{-94,140},{-82,152}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=
        100000)
    annotation (Placement(transformation(extent={{-4,-30},{16,-10}})));
equation
  connect(Condenser.port_a,HPT. portLP) annotation (Line(points={{61,-10},{88,
          -10},{88,20},{94,20},{94,42},{52,42}},            color={0,127,255}));
  connect(pump.port_a,Condenser. port_b) annotation (Line(points={{32,-42},{54,
          -42},{54,-30}},              color={0,127,255}));
  connect(TCV.port_b, HPT.portHP) annotation (Line(points={{12,38},{22,38},{22,
          42},{32,42}},  color={0,127,255}));
  connect(generator.shaft, HPT.shaft_b) annotation (Line(points={{69.9,31.9},{
          60,31.9},{60,36},{52,36}},color={0,0,0}));
  connect(port_b, sensor_T2.port_b) annotation (Line(points={{-100,-42},{-74,
          -42}},     color={0,127,255}));
  connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
      points={{-30,100},{-110,100},{-110,-66},{-64,-66},{-64,-45.6}},
      color={239,82,82},
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

  connect(pump.port_b, nTU_HX_SinglePhase.Tube_in) annotation (Line(points={{12,
          -42},{-8,-42},{-8,-44},{-14,-44}}, color={0,127,255}));
  connect(nTU_HX_SinglePhase.Tube_out, sensor_T2.port_a) annotation (Line(
        points={{-34,-44},{-48,-44},{-48,-42},{-54,-42}}, color={0,127,255}));
  connect(port_a, volume.port_a) annotation (Line(points={{-100,60},{-54,60},{
          -54,38},{-44,38}}, color={0,127,255}));
  connect(volume.port_b, TCV.port_a)
    annotation (Line(points={{-32,38},{-4,38}}, color={0,127,255}));
  connect(volume.port_b, TCV1.port_a) annotation (Line(points={{-32,38},{-24,38},
          {-24,18},{-22,18},{-22,16},{-40,16},{-40,6}}, color={0,127,255}));
  connect(TCV1.port_b, nTU_HX_SinglePhase.Shell_in) annotation (Line(points={{
          -40,-10},{-42,-10},{-42,-38},{-34,-38}}, color={0,127,255}));
  connect(volume.port_b,TBV. port_a) annotation (Line(points={{-32,38},{-18,38},
          {-18,78},{-38,78}}, color={0,127,255}));
  connect(TBV.port_b, boundary.ports[1])
    annotation (Line(points={{-54,78},{-68,78}}, color={0,127,255}));
  connect(actuatorBus.TBV, TBV.opening) annotation (Line(
      points={{30,100},{30,94},{-36,94},{-36,86},{-46,86},{-46,84.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, SteamPressure.y) annotation (Line(
      points={{-30,100},{-30,146},{-81.4,146}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV, TCV1.opening) annotation (Line(
      points={{30.1,100.1},{86,100.1},{86,96},{-66,96},{-66,-4},{-64,-4},{-64,
          -2},{-46.4,-2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(resistance.port_b, Condenser.port_a) annotation (Line(points={{13,-20},
          {18,-20},{18,-22},{32,-22},{32,10},{61,10},{61,-10}}, color={0,127,
          255}));
  connect(resistance.port_a, nTU_HX_SinglePhase.Shell_out) annotation (Line(
        points={{-1,-20},{-10,-20},{-10,-38},{-14,-38}}, color={0,127,255}));
end SFR_Power_Conversion_02;
