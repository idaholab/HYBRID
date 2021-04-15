within NHES.HydrogenTurbine.PowerPlant.Blocks;
block LowValueSelector_twoInputs "Low value selector with two inputs"

  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Logical.LessEqual lessEqual
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Interfaces.RealInput Fd(unit="1") annotation (Placement(
        transformation(extent={{-110,40},{-90,60}}), iconTransformation(extent={
            {-100,40},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput Tctrl(unit="1") annotation (
      Placement(transformation(extent={{-110,-40},{-90,-20}}),
        iconTransformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealOutput y(unit="1") annotation (Placement(
        transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={
            {80,-10},{100,10}})));
equation
  connect(switch.u2, lessEqual.y)
    annotation (Line(points={{18,0},{18,0},{-19,0}}, color={255,0,255}));
  connect(Fd, lessEqual.u1) annotation (Line(points={{-100,50},{-60,50},{-60,0},
          {-42,0}}, color={0,0,127}));
  connect(Tctrl, lessEqual.u2) annotation (Line(points={{-100,-30},{-60,-30},
          {-60,-8},{-42,-8}}, color={0,0,127}));
  connect(switch.u1, Fd) annotation (Line(points={{18,8},{12,8},{0,8},{0,50},{-100,
          50}}, color={0,0,127}));
  connect(switch.u3, Tctrl) annotation (Line(points={{18,-8},{0,-8},{0,-30},
          {-100,-30}}, color={0,0,127}));
  connect(switch.y, y)
    annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                                                        graphics={
          Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),                           Text(
            extent={{-74,-26},{74,26}},
            textString="%name",
            lineColor={0,0,255},
          origin={0,2},
          rotation=0)}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end LowValueSelector_twoInputs;
