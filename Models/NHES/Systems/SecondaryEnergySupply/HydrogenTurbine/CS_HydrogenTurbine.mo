within NHES.Systems.SecondaryEnergySupply.HydrogenTurbine;
model CS_HydrogenTurbine
  extends
    NHES.Systems.SecondaryEnergySupply.HydrogenTurbine.BaseClasses.Partial_ControlSystem;

  parameter Real delayStart=5000 "Time to start tracking power profiles";
  parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
  parameter SI.Power W_SES_nom(displayUnit="MW") = 35e6
    "Nominal electrical power generation in the SES";

  input SI.Power W_totalSetpoint "Total setpoint power" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Math.Feedback feedback_W_gen annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={40,0})));
  Modelica.Blocks.Continuous.PI FBctrl_powerGeneration(
    y_start=1,
    x_start=1/FBctrl_powerGeneration.k,
    T=1.5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=30/(W_SES_nom))
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=delayStart)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Constant W_SES_nominal(k=W_SES_nom)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Math.Gain scaler(k=1/capacityScaler)
    annotation (Placement(transformation(extent={{-32,-36},{-20,-24}})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_SES(y=W_totalSetpoint)
    annotation (Placement(transformation(extent={{-74,-40},{-54,-20}})));
equation
  connect(feedback_W_gen.y, FBctrl_powerGeneration.u)
    annotation (Line(points={{49,0},{49,0},{58,0}},    color={0,0,127}));
  connect(clock.y, lessThreshold.u)
    annotation (Line(points={{-69,0},{-62,0},{-62,0}}, color={0,0,127}));
  connect(lessThreshold.y, switch.u2)
    annotation (Line(points={{-39,0},{-2,0},{-2,0}}, color={255,0,255}));
  connect(switch.y, feedback_W_gen.u1)
    annotation (Line(points={{21,0},{32,0},{32,0}}, color={0,0,127}));
  connect(scaler.y, switch.u3) annotation (Line(points={{-19.4,-30},{-12,-30},{-12,
          -8},{-2,-8}}, color={0,0,127}));
  connect(W_SES_nominal.y, switch.u1) annotation (Line(points={{-19,30},{-12,30},
          {-12,8},{-2,8}}, color={0,0,127}));
  connect(sensorBus.W_gen, feedback_W_gen.u2) annotation (
      Line(
      points={{-29.9,-99.9},{0,-99.9},{0,-100},{40,-100},{40,-8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.GTPP.m_flow_fuel_pu, FBctrl_powerGeneration.y)
    annotation (Line(
      points={{30,-100},{100,-100},{100,0},{81,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(W_totalSetpoint_SES.y, scaler.u)
    annotation (Line(points={{-53,-30},{-33.2,-30}}, color={0,0,127}));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_HydrogenTurbine;
