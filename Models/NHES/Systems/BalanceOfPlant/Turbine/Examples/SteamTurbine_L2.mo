within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model SteamTurbine_L2
  import NHES;
  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_OpenFeedHeat_DivertPowerControl
    intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2_AR(
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_DivertPowerControl
      CS(electric_demand=sine.y, Overall_Power=sensorW.W),
    port_a_nominal(
      p=3400000,
      h=3e6,
      m_flow=67),
    port_b_nominal(p=3400000, h=1e6))
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));

  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Modelica.Fluid.Sources.Boundary_pT sink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p(displayUnit="bar") = 3400000,
    T(displayUnit="degC") = 421.15)
    annotation (Placement(transformation(extent={{-88,-2},{-68,-22}})));
  Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-40,-22},{-60,-2}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
  Fluid.Sensors.stateDisplay stateDisplay
    annotation (Placement(transformation(extent={{-72,-60},{-28,-30}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-72,20},{-28,50}})));
  Modelica.Fluid.Sources.MassFlowSource_h source1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=10,
    h=2e6,
    nPorts=1)
    annotation (Placement(transformation(extent={{-48,-88},{-28,-68}})));
  Modelica.Fluid.Sources.Boundary_ph source(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=3400000,
    h=3e6,
    use_p_in=false)
    annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{46,-6},{60,6}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=10e6,
    f=1/20000,
    offset=38e6,
    startTime=2000)
    annotation (Placement(transformation(extent={{-56,58},{-36,78}})));
equation

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-50,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
        points={{-50,-48.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
  connect(sink.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-12},
          {-64,-12},{-60,-12}}, color={0,127,255}));
  connect(stateSensor.port_a,
    intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2_AR.port_b)
    annotation (Line(points={{-40,-12},{-30,-12}}, color={0,127,255}));
  connect(stateSensor1.port_b,
    intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2_AR.port_a)
    annotation (Line(points={{-40,12},{-30,12}}, color={0,127,255}));
  connect(source.ports[1], stateSensor1.port_a)
    annotation (Line(points={{-68,12},{-60,12}}, color={0,127,255}));
  connect(source1.ports[1], intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2_AR.port_a1)
    annotation (Line(points={{-28,-78},{-22,-78},{-22,-28.8},{-19.2,-28.8}},
        color={0,127,255}));
  connect(intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2_AR.portElec_b,
    sensorW.port_a) annotation (Line(points={{30,0},{46,0}}, color={255,0,0}));
  connect(sensorW.port_b, sinkElec.port)
    annotation (Line(points={{60,0},{70,0}}, color={255,0,0}));
  annotation (experiment(StopTime=500));
end SteamTurbine_L2;
