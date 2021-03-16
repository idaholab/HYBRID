within NHES.Thermal.Conduction.FiniteDifference.Interfaces;
model Adapter_FDtoTP "Interface between FD model and thermopower pipe"

  parameter Integer nNodes(min=1);
  Modelica.Fluid.Interfaces.HeatPorts_a[nNodes] heatPorts_a annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={100,0}), iconTransformation(
        extent={{-40,-10},{40,10}},
        rotation=90,
        origin={100,0})));
  ThermoPower.Thermal.DHTVolumes dHTVolumes(final N=nNodes) annotation (Placement(
        transformation(extent={{-106,-20},{-94,20}}),iconTransformation(extent={
            {-109,-40},{-91,40}})));

equation
  for i in 1:nNodes loop
  dHTVolumes.Q[i] = -heatPorts_a[i].Q_flow;
  dHTVolumes.T[i] = heatPorts_a[i].T;
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={162,29,33}), Text(
          extent={{-62,126},{64,94}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={162,29,33},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end Adapter_FDtoTP;
