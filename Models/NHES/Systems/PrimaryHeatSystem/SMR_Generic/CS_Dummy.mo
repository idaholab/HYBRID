within NHES.Systems.PrimaryHeatSystem.SMR_Generic;
model CS_Dummy

  extends BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  Modelica.Blocks.Sources.Constant ControlRod_Reactivity(k=0)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.Constant Other_Reactivity(k=0)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Sources.Constant S_external(k=0)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Blocks.Sources.Constant speedPump(k=1500)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Sources.Constant Q_flow_liquidHeater(k=0)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
equation

  connect(actuatorBus.speedPump, speedPump.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,-52},{30.1,-40},{11,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Q_flow_liquidHeater, Q_flow_liquidHeater.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,-70},{11,-70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.reactivity_ControlRod, ControlRod_Reactivity.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,50},{11,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.reactivity_Other, Other_Reactivity.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,8},{30.1,20},{11,20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Q_S_External, S_external.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,-10},{11,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="PHS_CS");
end CS_Dummy;
