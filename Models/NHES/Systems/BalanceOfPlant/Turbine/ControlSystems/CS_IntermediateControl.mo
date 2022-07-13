within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_IntermediateControl
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  Modelica.Blocks.Sources.Constant TCV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Speed(k=2500)
    annotation (Placement(transformation(extent={{72,42},{52,62}})));
  Modelica.Blocks.Sources.Constant Divert_Valve_Position(k=0.1)
    annotation (Placement(transformation(extent={{-10,42},{10,62}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=0,
    period=50,
    offset=0.001,
    startTime=20)
    annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_dp(k=18)
    annotation (Placement(transformation(extent={{72,-6},{52,14}})));
  Modelica.Blocks.Sources.Constant TBV(k=0)
    annotation (Placement(transformation(extent={{72,-46},{52,-26}})));
equation
  connect(actuatorBus.opening_TCV, TCV_openingNominal.y) annotation (
     Line(
      points={{30.1,-99.9},{30.1,20},{11,20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, Divert_Valve_Position.y)
    annotation (Line(
      points={{30,-100},{30,52},{11,52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed, Feed_Pump_Speed.y)
    annotation (Line(
      points={{30,-100},{30,52},{51,52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(pulse.y, actuatorBus.opening_BV) annotation (Line(points={{11,-32},{30.1,
          -32},{30.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Feed_Pump_dp.y, actuatorBus.condensor_pump) annotation (Line(points={
          {51,4},{30,4},{30,-100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TBV.y, actuatorBus.TBV) annotation (Line(points={{51,-36},{30,-36},{
          30,-100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
end CS_IntermediateControl;
