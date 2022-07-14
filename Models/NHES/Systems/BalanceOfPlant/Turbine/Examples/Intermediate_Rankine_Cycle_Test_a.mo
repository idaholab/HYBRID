within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model Intermediate_Rankine_Cycle_Test_a
  import NHES;

  parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
  parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));

  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.Intermediate_Rankine_Cycle BOP(
  port_a_nominal(
      m_flow=493.7058,
      p=14000000,
      h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
    port_b_nominal(p=14000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
          318.95)))
    annotation (Placement(transformation(extent={{0,-30},{60,30}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-18,-22},{-38,-2}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-38,2},{-18,22}})));
  Fluid.Sensors.stateDisplay stateDisplay
    annotation (Placement(transformation(extent={{-52,-60},{-8,-30}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-52,30},{-6,60}})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/200,
    offset=4e8,
    startTime=350,
    amplitude=2e8)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX nTU_HX(
    NTU=30,
    K_tube=17000,
    K_shell=500,
    V_Tube=10,
    V_Shell=10,
    p_start_tube=5000000,
    h_start_tube_inlet=1e6,
    h_start_tube_outlet=3e6,
    p_start_shell=5000000,
    h_start_shell_inlet=3.1e6,
    h_start_shell_outlet=1e6,
    Q_init=10e7,
    tau=1,
    m_start_tube=200,
    m_start_shell=200) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-58,0})));
  Modelica.Fluid.Sources.MassFlowSource_h source(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=300,
    nPorts=1,
    h=5.3e6)
    annotation (Placement(transformation(extent={{-88,0},{-68,20}})));
  Modelica.Fluid.Sources.Boundary_ph sink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    h=1e6,
    nPorts=1,
    p(displayUnit="bar") = 4500000)
    annotation (Placement(transformation(extent={{-88,-2},{-68,-22}})));
equation

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-29,41.1},{-29,30},{-28,30},{-28,14},{-27.95,14},{-27.95,12.05}},
                                                                   color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
        points={{-30,-48.9},{-30,-32},{-28,-32},{-28,-11.95},{-28.05,-11.95}},
                                                           color={0,0,0}));
  connect(stateSensor.port_a, BOP.port_b)
    annotation (Line(points={{-18,-12},{0,-12}},   color={0,127,255}));
  connect(stateSensor1.port_b, BOP.port_a)
    annotation (Line(points={{-18,12},{0,12}},   color={0,127,255}));
  connect(BOP.portElec_b, sinkElec.port)
    annotation (Line(points={{60,0},{70,0}}, color={255,0,0}));
  connect(nTU_HX.Tube_in, stateSensor.port_b) annotation (Line(points={{-54,-10},
          {-54,-12},{-38,-12}}, color={0,127,255}));
  connect(nTU_HX.Tube_out, stateSensor1.port_a)
    annotation (Line(points={{-54,10},{-54,12},{-38,12}}, color={0,127,255}));
  connect(source.ports[1], nTU_HX.Shell_in)
    annotation (Line(points={{-68,10},{-60,10}}, color={0,127,255}));
  connect(sink.ports[1], nTU_HX.Shell_out) annotation (Line(points={{-68,-12},{
          -60,-12},{-60,-10}}, color={0,127,255}));
  annotation (experiment(StopTime=500));
end Intermediate_Rankine_Cycle_Test_a;
