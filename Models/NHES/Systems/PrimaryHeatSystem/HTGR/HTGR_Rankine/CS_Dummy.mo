within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine;
model CS_Dummy

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.RealExpression CR_Reactivity
    annotation (Placement(transformation(extent={{-14,-58},{6,-38}})));
  TRANSFORM.Blocks.RealExpression T_RX
    annotation (Placement(transformation(extent={{-44,-24},{-32,-10}})));
  Modelica.Blocks.Sources.RealExpression PR_Compressor
    annotation (Placement(transformation(extent={{22,-24},{42,-4}})));
  TRANSFORM.Blocks.RealExpression Core_mass_flow_rate
    annotation (Placement(transformation(extent={{-8,10},{4,24}})));
equation

  connect(actuatorBus.CR_Reactivity, CR_Reactivity.y) annotation (Line(
      points={{30,-100},{30,-48},{7,-48}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_T, T_RX.u) annotation (Line(
      points={{-30,-100},{-32,-100},{-32,-58},{-56,-58},{-56,-32},{-58,-32},{
          -58,-17},{-45.2,-17}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, Core_mass_flow_rate.u) annotation (Line(
      points={{-30,-100},{-32,-100},{-32,-50},{-68,-50},{-68,14},{-9.2,14},{
          -9.2,17}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, PR_Compressor.y) annotation (Line(
      points={{30,-100},{30,-40},{28,-40},{28,-24},{64,-24},{64,-14},{43,-14}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Dummy;
