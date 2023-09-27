within NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.CS;
model CS_Dummy

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.RealExpression Reactivity_CR
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Sources.RealExpression M_flow_steam(y=dataCS.m_flow_steam)
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Data.DataCS             dataCS
    annotation (Placement(transformation(extent={{-10,-88},{10,-68}})));
  TRANSFORM.Blocks.RealExpression dT_Across_Core
    annotation (Placement(transformation(extent={{-68,-24},{-48,-4}})));
  TRANSFORM.Blocks.RealExpression Reactor_Heat
    annotation (Placement(transformation(extent={{-68,-48},{-48,-28}})));
equation

  connect(actuatorBus.reactivity_CR, Reactivity_CR.y) annotation (Line(
      points={{30.1,-99.9},{50,-99.9},{50,-40},{11,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.m_flow_steam, M_flow_steam.y) annotation (Line(
      points={{30.1,-99.9},{50,-99.9},{50,-60},{11,-60}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Q_total, Reactor_Heat.u) annotation (Line(
      points={{-29.9,-99.9},{-29.9,-100},{-100,-100},{-100,-38},{-70,-38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.dT_core, dT_Across_Core.u) annotation (Line(
      points={{-29.9,-99.9},{-100,-99.9},{-100,-14},{-70,-14}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="PHS_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_Dummy;
