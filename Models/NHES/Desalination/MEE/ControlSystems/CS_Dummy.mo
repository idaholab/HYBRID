within NHES.Desalination.MEE.ControlSystems;
model CS_Dummy
  extends BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  Modelica.Blocks.Sources.Constant const(k=0.55)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Blocks.Sources.Constant const1(k=0.6)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Sources.Constant const2(k=0.65)
    annotation (Placement(transformation(extent={{-18,-40},{2,-20}})));
  Modelica.Blocks.Sources.Constant const3(k=0.7)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Sources.Constant const4(k=0.75)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Blocks.Sources.Constant const5(k=0.8)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Blocks.Sources.Constant const6(k=0.85)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.Constant const7(k=0.9)
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
equation
  connect(actuatorBus.CV2_opening, const1.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-50},{21,-50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.CV3_opening, const2.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-30},{3,-30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.CV4_opening, const3.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-10},{21,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.CV5_opening, const4.y) annotation (Line(
      points={{30.1,-99.9},{30.1,10},{1,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.CV6_opening, const5.y) annotation (Line(
      points={{30.1,-99.9},{30.1,30},{21,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.CV7_opening, const6.y) annotation (Line(
      points={{30.1,-99.9},{30.1,50},{1,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.CV8_opening, const7.y) annotation (Line(
      points={{30.1,-99.9},{30.1,70},{21,70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.CV1_opening, const.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-70},{1,-70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_Dummy;
