within NHES.Systems.SwitchYard.SimpleYard;
model CS_SimpleBreakers
  extends NHES.Systems.SwitchYard.SimpleYard.BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.BooleanStep BOP_BKR_REF(
              startValue=true, startTime=1e10)
              annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Blocks.Sources.BooleanStep ES_BKR_REF(startValue=true, startTime=
        1e10)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Blocks.Sources.BooleanStep SES_BKR_REF(startValue=true, startTime=
        1e10)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Blocks.Sources.BooleanStep EG_BKR_REF(startValue=true, startTime=
        1e10)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
equation
  connect(actuatorBus.closed_BOP, BOP_BKR_REF.y) annotation (Line(
      points={{30.1,-99.9},{30.1,70},{11,70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.closed_ES, ES_BKR_REF.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,28},{30.1,30},{11,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.closed_SES, SES_BKR_REF.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-10},{11,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.closed_EG, EG_BKR_REF.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-50},{11,-50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (defaultComponentName="SY_CS",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_SimpleBreakers;
