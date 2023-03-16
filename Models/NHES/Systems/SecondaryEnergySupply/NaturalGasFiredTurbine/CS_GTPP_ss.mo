within NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine;
model CS_GTPP_ss
  extends
    NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.BaseClasses.Partial_ControlSystem;

  parameter SI.Power Power_nom(displayUnit="MW") = 30e6
    "Nominal electrical power generation in the SES";


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
    k=30/(Power_nom))
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_SES(y=Power_nom)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(feedback_W_gen.y, FBctrl_powerGeneration.u)
    annotation (Line(points={{49,0},{49,0},{58,0}},    color={0,0,127}));
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
  connect(W_totalSetpoint_SES.y, feedback_W_gen.u1)
    annotation (Line(points={{-19,0},{32,0}}, color={0,0,127}));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=2000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end CS_GTPP_ss;
