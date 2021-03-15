within NHES.Electrical.Sources;
model PowerSource

  parameter Boolean use_W_in=false
    "Get the power from the input connector"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  parameter SI.Power W=0 "Active power" annotation(Dialog(enable= not use_W_in));

  Interfaces.ElectricalPowerPort_a portElec_a
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Interfaces.RealInput W_in if use_W_in
    "Prescribed mass flow rate"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),iconTransformation(extent={{-140,
            -20},{-100,20}})));
protected
  Modelica.Blocks.Interfaces.RealInput W_in_internal
    "Needed to connect to conditional connector";
equation

  connect(W_in, W_in_internal);
  if not use_W_in then
    W_in_internal = W;
  end if;

  portElec_a.W + W_in_internal = 0;

  annotation (
    defaultComponentName="boundary",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-150,106},{150,146}},
          lineColor={0,140,72},
          textString="%name"),
          Ellipse(
          extent={{100,100},{-100,-100}},
          lineColor={0,0,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-40,44},{38,-42}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="Power")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end PowerSource;
