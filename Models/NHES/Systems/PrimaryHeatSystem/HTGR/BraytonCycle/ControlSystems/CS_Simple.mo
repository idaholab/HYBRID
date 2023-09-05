within NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems;
model CS_Simple

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.RealExpression CR_Reactivity
    annotation (Placement(transformation(extent={{60,-66},{80,-54}})));
  TRANSFORM.Blocks.RealExpression T_RX
    annotation (Placement(transformation(extent={{-80,-66},{-60,-54}})));
  Modelica.Blocks.Sources.RealExpression PR_Compressor
    annotation (Placement(transformation(extent={{60,-46},{80,-34}})));
  TRANSFORM.Blocks.RealExpression Core_mass_flow_rate
    annotation (Placement(transformation(extent={{-80,-46},{-60,-34}})));
equation

  connect(actuatorBus.CR_Reactivity, CR_Reactivity.y) annotation (Line(
      points={{30,-100},{100,-100},{100,-60},{81,-60}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_T, T_RX.u) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-60},{-82,-60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, Core_mass_flow_rate.u) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-40},{-82,-40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, PR_Compressor.y) annotation (Line(
      points={{30,-100},{100,-100},{100,-40},{81,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Simple;
