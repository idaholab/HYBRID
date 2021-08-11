within NHES.Systems.PrimaryHeatSystem.HTGR;
model CS_Dummy

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.RealExpression CR_Reactivity
    annotation (Placement(transformation(extent={{-14,-58},{6,-38}})));
equation

  connect(actuatorBus.CR_Reactivity, CR_Reactivity.y) annotation (Line(
      points={{30,-100},{30,-48},{7,-48}},
      color={111,216,99},
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
