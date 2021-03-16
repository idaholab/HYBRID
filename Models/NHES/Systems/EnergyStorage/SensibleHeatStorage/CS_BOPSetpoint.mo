within NHES.Systems.EnergyStorage.SensibleHeatStorage;
model CS_BOPSetpoint

  extends BaseClasses.Partial_ControlSystem;

  parameter SI.Power Q_nominal "Nominal power for BOP for zero flow to energy storage";
  input SI.Power W_totalSetpoint "Total setpoint power from BOP from SC" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Math.Gain gain(k=100)
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Modelica.Blocks.Sources.Constant const(k=Q_nominal)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_BOP(y=W_totalSetpoint)
    annotation (Placement(transformation(extent={{-80,-24},{-60,-4}})));
equation

  connect(division.y, gain.u)
    annotation (Line(points={{-9,-20},{8,-20}}, color={0,0,127}));
  connect(actuatorBus.Demand, gain.y) annotation (
     Line(
      points={{30.1,-99.9},{50,-99.9},{50,-20},{31,-20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const.y, division.u2) annotation (Line(points={{-59,-40},{-48,-40},{-48,
          -26},{-32,-26}}, color={0,0,127}));
  connect(W_totalSetpoint_BOP.y, division.u1)
    annotation (Line(points={{-59,-14},{-32,-14}}, color={0,0,127}));
annotation(defaultComponentName="ES_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_BOPSetpoint;
