within NHES.Systems.EnergyStorage.SensibleHeatStorage;
model CS_TextRead

  extends BaseClasses.Partial_ControlSystem;

  //parameter SI.Power Q_nominal "Nominal power for BOP for zero flow to energy storage";
  input SI.Power W_totalSetpoint "Total setpoint power from SC" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Math.Gain gain(k=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_ES(y=W_totalSetpoint)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation

  connect(actuatorBus.Demand, gain.y) annotation (
     Line(
      points={{30.1,-99.9},{100,-99.9},{100,0},{11,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(W_totalSetpoint_ES.y, gain.u)
    annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
annotation(defaultComponentName="ES_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_TextRead;
