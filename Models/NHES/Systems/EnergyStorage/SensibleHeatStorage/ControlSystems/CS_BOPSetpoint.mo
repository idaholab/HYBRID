within NHES.Systems.EnergyStorage.SensibleHeatStorage.ControlSystems;
model CS_BOPSetpoint

  extends BaseClasses.Partial_ControlSystem;

  parameter SI.Power Q_nominal "Nominal power for BOP for zero flow to energy storage";
  input SI.Power W_totalSetpoint "Total setpoint power from BOP from SC" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Math.Gain gain(k=100)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.Constant const(k=Q_nominal)
    annotation (Placement(transformation(extent={{6,-16},{26,4}})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_BOP(y=W_totalSetpoint)
    annotation (Placement(transformation(extent={{4,10},{24,30}})));
  TRANSFORM.Blocks.RealExpression Q_balance
    annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
  TRANSFORM.Blocks.RealExpression W_balance
    annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
equation

  connect(division.y, gain.u)
    annotation (Line(points={{61,0},{78,0}},    color={0,0,127}));
  connect(actuatorBus.Demand, gain.y) annotation (
     Line(
      points={{30.1,-99.9},{120,-99.9},{120,0},{101,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const.y, division.u2) annotation (Line(points={{27,-6},{38,-6}},
                           color={0,0,127}));
  connect(W_totalSetpoint_BOP.y, division.u1)
    annotation (Line(points={{25,20},{32,20},{32,6},{38,6}},
                                                   color={0,0,127}));
  connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_balance, W_balance.u) annotation (Line(
      points={{-30,-100},{-36,-100},{-36,-98},{-120,-98},{-120,28},{-102.4,28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

annotation(defaultComponentName="ES_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_BOPSetpoint;
