within NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine;
model CS_GTPP_stepInput
  extends
    NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.BaseClasses.Partial_ControlSystem;

  parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
  parameter SI.Power W_SES_nom(displayUnit="MW") = 35e6
    "Nominal electrical power generation in the SES";
  Modelica.Blocks.Math.Feedback feedback_W_gen annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,0})));
  Modelica.Blocks.Sources.Ramp loadSignal1(
      duration=0,
      startTime=10,
    height=-3.5*1e6*5*capacityScaler,
    offset=35*1e6*capacityScaler)
                         annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-70,84})));
  Modelica.Blocks.Math.Add sumLoads annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-48,28})));
  Modelica.Blocks.Sources.Ramp loadSignal2(
    duration=0,
    offset=0,
    startTime=40,
    height=3.5*1e6*3.1*capacityScaler)
                               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,50})));
  Modelica.Blocks.Continuous.PI FBctrl_powerGeneration(
    y_start=1,
    x_start=1/FBctrl_powerGeneration.k,
    T=1.5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=30/(W_SES_nom))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Gain scaler(k=1/capacityScaler)
    annotation (Placement(transformation(extent={{-72,-6},{-60,6}})));
equation
  connect(loadSignal1.y, sumLoads.u1) annotation (Line(points={{-59,84},{
          -43.2,84},{-43.2,37.6}}, color={0,0,127}));
  connect(loadSignal2.y, sumLoads.u2) annotation (Line(points={{-59,50},{
          -52.8,50},{-52.8,37.6}}, color={0,0,127}));
  connect(feedback_W_gen.y, FBctrl_powerGeneration.u)
    annotation (Line(points={{-31,0},{-18,0},{-12,0}}, color={0,0,127}));
  connect(sensorBus.W_gen, feedback_W_gen.u2) annotation (Line(
      points={{-30,-100},{-40,-100},{-40,-100},{-40,-8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.GTPP.m_flow_fuel_pu, FBctrl_powerGeneration.y)
    annotation (Line(
      points={{30,-100},{30,-100},{30,-60},{30,0},{11,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(scaler.y, feedback_W_gen.u1)
    annotation (Line(points={{-59.4,0},{-48,0}}, color={0,0,127}));
  connect(sumLoads.y, scaler.u) annotation (Line(points={{-48,19.2},{-48,10},{-80,
          10},{-80,0},{-73.2,0}}, color={0,0,127}));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_GTPP_stepInput;
