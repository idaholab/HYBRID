within NHES.Systems.EnergyStorage.SensibleHeatStorage;
model CS_Default

  extends BaseClasses.Partial_ControlSystem;

  input Real u = 100 annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Sources.RealExpression Demand(y=u)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
equation

  connect(actuatorBus.Demand, Demand.y)
    annotation (Line(
      points={{30.1,-99.9},{48,-99.9},{48,-20},{11,-20}},
      color={111,216,99},
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
end CS_Default;
