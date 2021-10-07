within NHES.Systems.EnergyStorage.Concrete_Solid_Media;
model CS_Dummy

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Blocks.RealExpression T_Ave_Conc
    annotation (Placement(transformation(extent={{-6,-8},{6,6}})));
  TRANSFORM.Blocks.RealExpression m_flow_dis
    annotation (Placement(transformation(extent={{-8,-24},{4,-10}})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-10,-46},{10,-26}})));
equation

  connect(sensorBus.T_Ave_Conc, T_Ave_Conc.u) annotation (Line(
      points={{-30,-100},{-30,-1},{-7.2,-1}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.DFV_Opening, realExpression.y) annotation (Line(
      points={{30,-100},{30,-36},{11,-36}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_dis, m_flow_dis.u) annotation (Line(
      points={{-30,-100},{-30,-17},{-9.2,-17}},
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
