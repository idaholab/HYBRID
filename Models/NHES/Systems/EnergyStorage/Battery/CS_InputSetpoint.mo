within NHES.Systems.EnergyStorage.Battery;
model CS_InputSetpoint
  extends BaseClasses.Partial_ControlSystem;

  input SI.Power W_totalSetpoint "Total setpoint power from SC" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Math.Gain gain(k=-1)
    "Reverse control signal to match notation of setpoint signals"
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_SC(y=W_totalSetpoint)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation

  connect(actuatorBus.W_setPoint, gain.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,0},{13,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(W_totalSetpoint_SC.y, gain.u)
    annotation (Line(points={{-39,0},{-10,0}}, color={0,0,127}));
annotation(defaultComponentName="ES_CS", Icon(graphics={Text(
          extent={{-48,16},{50,-12}},
          lineColor={28,108,200},
          lineThickness=1,
          textString="Battery")}));
end CS_InputSetpoint;
