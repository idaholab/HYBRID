within NHES.Systems.EnergyStorage.Battery;
model Logical
  extends BaseClasses.Partial_SubSystem_A(redeclare replaceable CS_Dummy CS,
      redeclare replaceable ED_Dummy ED,
    redeclare Data.Logical data);

  parameter SIadd.nonDim capacityFrac_start = 1.0
    "Initial capacity as a fraction of usable capacity (capacity_max-capacity_min)"
    annotation (Dialog(tab="Initialization"));

  parameter Modelica.Units.NonSI.Energy_Wh capacity_max=100e6
    "Maximum storage capacity";
  parameter Modelica.Units.NonSI.Energy_Wh capacity_min=0
    "Minimum storage capacity";

  parameter SI.Power chargePower_max=Modelica.Constants.inf
    "Maximum charge power";
  parameter SI.Power chargePower_min=0 "Minimum charge power";
  parameter SI.Power dischargePower_max=Modelica.Constants.inf
    "Maximum discharge power";
  parameter SI.Power dischargePower_min=0 "Minimum discharge power";

  Electrical.Battery battery(
    capacityFrac_start=capacityFrac_start,
    capacity_max=capacity_max,
    capacity_min=capacity_min,
    chargePower_max=chargePower_max,
    chargePower_min=chargePower_min,
    dischargePower_max=dischargePower_max,
    dischargePower_min=dischargePower_min)
    annotation (Placement(transformation(extent={{-30,-32},{30,32}})));
equation
  connect(battery.port, portElec_b)
    annotation (Line(points={{30,0},{100,0}},         color={255,0,0}));
  connect(actuatorBus.W_setPoint, battery.W_setpoint)
    annotation (Line(
      points={{30.1,100.1},{0,100.1},{0,102},{-100,102},{-100,0},{-32.4,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (defaultComponentName="ES",
Icon(graphics={
        Rectangle(
          extent={{-48,37},{-6,19}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-6,37},{6,19}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{6,32},{8,24}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder),
        Line(points={{0,33},{0,23}}, color={0,0,0}),
        Line(points={{-5,28},{5,28}}, color={0,0,0}),
        Rectangle(
          extent={{-36,9},{6,-9}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{6,9},{18,-9}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{18,4},{20,-4}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder),
        Line(points={{12,5},{12,-5}}, color={0,0,0}),
        Line(points={{7,0},{17,0}}, color={0,0,0}),
        Rectangle(
          extent={{-24,-19},{18,-37}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{18,-19},{30,-37}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{30,-24},{32,-32}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder),
        Line(points={{24,-23},{24,-33}}, color={0,0,0}),
        Line(points={{19,-28},{29,-28}}, color={0,0,0}),
        Line(points={{20,0},{80,0}}, color={255,0,0}),
        Line(points={{8,28},{54,28},{54,0}}, color={255,0,0}),
        Line(points={{32,-28},{54,-28},{54,0}}, color={255,0,0}),
                  Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Logical Battery")}));
end Logical;
