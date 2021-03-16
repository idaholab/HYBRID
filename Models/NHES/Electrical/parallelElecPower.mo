within NHES.Electrical;
model parallelElecPower
  "Scale electrical power: simulates parallel flow streams"

  parameter Real nParallel = 1 "port_a.W is divided into nParallel flow streams";

  Interfaces.ElectricalPowerPort_a singleFlow annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent=
           {{-110,-10},{-90,10}})));
  Interfaces.ElectricalPowerPort_a parallelFlow annotation (Placement(
        transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={
            {90,-10},{110,10}})));
equation
  // mass balance
  0 =singleFlow.W + parallelFlow.W*nParallel;

  // frequency equation
  singleFlow.f =parallelFlow.f;

  annotation (defaultComponentName="nFlow",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-88,60},{88,-60}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{80,3},{0,3},{0,34},{80,34},{80,40},{-6,40},{-6,-40},{80,-40},
              {80,-34},{0,-34},{0,-3},{80,-3},{80,3}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-6,3},{-80,3},{-80,-3},{-6,-3},{-6,3}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{-145,-68},{155,-108}},
          lineColor={0,0,0},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end parallelElecPower;
