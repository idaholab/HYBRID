within NHES.Systems.BalanceOfPlant.Turbine;
model CS_UserDefined
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real opening_TCV=0.5
    "Valve opening" annotation(Dialog(group="Inputs"));
  input Real opening_TDV=0.5
    "Valve opening" annotation(Dialog(group="Inputs"));
  input Real opening_BV=0.001
    "Valve opening" annotation(Dialog(group="Inputs"));
  input Real opening_BV_TCV=0.001
    "Valve opening" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Sources.RealExpression TCV_opening(y=opening_TCV)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Sources.RealExpression BV_opening(y=opening_BV)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Sources.RealExpression TDV_opening(y=opening_TDV)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Blocks.Sources.RealExpression BV_TCV_opening(y=opening_BV_TCV)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));

equation
  connect(actuatorBus.opening_TCV, TCV_opening.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,20},{11,20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV, BV_opening.y) annotation (
      Line(
      points={{30.1,-99.9},{30.1,-40},{11,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TDV, TDV_opening.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-10},{11,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV_TCV, BV_TCV_opening.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-70},{11,-70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_UserDefined;
