within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model IdealTurbine_Test
  extends Modelica.Icons.Example;
  IdealTurbine BOP
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
  Electrical.Sources.FrequencySource sinkElec(f=60)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T source(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=BOP.port_a_nominal.m_flow,
    T(displayUnit="K") = BOP.port_a_nominal.T)
    annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
  Modelica.Fluid.Sources.Boundary_pT sink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p(displayUnit="MPa") = BOP.port_b_nominal.p,
    T(displayUnit="K") = BOP.port_b_nominal.T)
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
  inner Fluid.System_TP system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation

  connect(BOP.portElec_b, sinkElec.portElec_b)
    annotation (Line(points={{30,0},{70,0}}, color={255,0,0}));
  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-50,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
        points={{-50,-48.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
  connect(stateSensor1.port_a, source.ports[1])
    annotation (Line(points={{-60,12},{-68,12}}, color={0,127,255}));
  connect(sink.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-12},
          {-64,-12},{-60,-12}}, color={0,127,255}));
  connect(stateSensor.port_a, BOP.port_b)
    annotation (Line(points={{-40,-12},{-30,-12}}, color={0,127,255}));
  connect(stateSensor1.port_b, BOP.port_a)
    annotation (Line(points={{-40,12},{-30,12}}, color={0,127,255}));
  annotation (experiment(StopTime=100, __Dymola_NumberOfIntervals=100));
end IdealTurbine_Test;
