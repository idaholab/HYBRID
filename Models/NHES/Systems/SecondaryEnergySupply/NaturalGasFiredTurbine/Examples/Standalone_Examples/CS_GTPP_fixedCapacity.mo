within NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.Examples.Standalone_Examples;
model CS_GTPP_fixedCapacity
  extends
    NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.BaseClasses.Partial_ControlSystem;

  input SI.Power W_totalSetpoint "Total setpoint power" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Math.Feedback feedback_W_gen annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,0})));
  Modelica.Blocks.Continuous.PI FBctrl_powerGeneration(
    y_start=1,
    x_start=1/FBctrl_powerGeneration.k,
    T=1.5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=30/(35e6))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_SES(y=W_totalSetpoint)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(feedback_W_gen.y, FBctrl_powerGeneration.u)
    annotation (Line(points={{-31,0},{-18,0},{-12,0}}, color={0,0,127}));
  connect(sensorBus.W_gen, feedback_W_gen.u2) annotation (Line(
      points={{-30,-100},{-40,-100},{-40,-8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.GTPP.m_flow_fuel_pu, FBctrl_powerGeneration.y)
    annotation (Line(
      points={{30,-100},{30,0},{11,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(W_totalSetpoint_SES.y, feedback_W_gen.u1)
    annotation (Line(points={{-69,0},{-48,0}}, color={0,0,127}));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_GTPP_fixedCapacity;
