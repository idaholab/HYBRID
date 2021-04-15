within NHES.HydrogenTurbine.PowerPlant.Blocks;
block LowValueSelector_threeInputs "Low value selector with three inputs"

  Modelica.Blocks.Interfaces.RealInput Fd(unit="1") annotation (Placement(
        transformation(extent={{-110,40},{-90,60}}), iconTransformation(extent={
            {-100,40},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput Tctrl(unit="1") annotation (Placement(
        transformation(extent={{-110,-40},{-90,-20}}), iconTransformation(
          extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealInput rotorAccelCtrl(unit="1") annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-90})));
  Modelica.Blocks.Interfaces.RealOutput y(unit="1") annotation (Placement(
        transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={
            {80,-10},{100,10}})));
  Blocks.LowValueSelector_twoInputs LVS1
    annotation (Placement(transformation(extent={{-42,-6},{-18,18}})));
  Blocks.LowValueSelector_twoInputs LVS2
    annotation (Placement(transformation(extent={{18,-12},{42,12}})));

equation
  connect(Fd, LVS1.Fd) annotation (Line(points={{-100,50},{-80,50},{-80,12},{-40.8,
          12}}, color={0,0,127}));
  connect(LVS1.y, LVS2.Fd)
    annotation (Line(points={{-19.2,6},{19.2,6}}, color={0,0,127}));
  connect(LVS2.y, y)
    annotation (Line(points={{40.8,0},{110,0}}, color={0,0,127}));
  connect(rotorAccelCtrl, LVS2.Tctrl)
    annotation (Line(points={{0,-100},{0,-6},{19.2,-6}}, color={0,0,127}));
  connect(Tctrl, LVS1.Tctrl) annotation (Line(points={{-100,-30},{-80,-30},{-80,
          0},{-40.8,0}}, color={0,0,127}));
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
end LowValueSelector_threeInputs;
