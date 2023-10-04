within NHES.Systems.PrimaryHeatSystem.SFR.CS;
model CS_Dummy

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.RealExpression Pump_speed(y=2550)
    annotation (Placement(transformation(extent={{18,10},{38,30}})));
  Modelica.Blocks.Sources.RealExpression CR_Reactivity(y=0.0)
    annotation (Placement(transformation(extent={{20,-62},{40,-42}})));
  TRANSFORM.Blocks.RealExpression IHX_Outlet_Temperature
    annotation (Placement(transformation(extent={{-52,-38},{-32,-18}})));
  TRANSFORM.Blocks.RealExpression Core_Outlet_Temperature
    annotation (Placement(transformation(extent={{-52,-64},{-32,-44}})));
  TRANSFORM.Blocks.RealExpression Primary_Mass_Flow
    annotation (Placement(transformation(extent={{-52,-16},{-32,4}})));
equation

  connect(actuatorBus.CR_Reactivity, CR_Reactivity.y) annotation (Line(
      points={{30,-100},{100,-100},{100,-52},{41,-52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Pump_Speed, Pump_speed.y) annotation (Line(
      points={{30,-100},{100,-100},{100,20},{39,20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_Temp, Core_Outlet_Temperature.u) annotation (
      Line(
      points={{-30,-100},{-98,-100},{-98,-54},{-54,-54}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.IHX_Outlet_Temp, IHX_Outlet_Temperature.u) annotation (Line(
      points={{-30,-100},{-98,-100},{-98,-28},{-54,-28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.PrimaryMassFlow, Primary_Mass_Flow.u) annotation (Line(
      points={{-30,-100},{-98,-100},{-98,-6},{-54,-6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_Dummy;
