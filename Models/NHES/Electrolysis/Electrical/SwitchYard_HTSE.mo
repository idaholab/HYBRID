within NHES.Electrolysis.Electrical;
model SwitchYard_HTSE
  import      Modelica.Units.SI;

  SI.Power powerConsumption_auxiliary;
  SI.Power powerConsumption_SOEC(start=51.1451e6);
  SI.Power powerGeneration_GT;

  Electrolysis.Interfaces.ElectricalPowerPort_a totalElecPower annotation (
      Placement(transformation(extent={{70,70},{90,90}}),
        iconTransformation(extent={{70,70},{90,90}})));
  Electrolysis.Interfaces.ElectricalPowerPort_b load_SOEC
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  Electrolysis.Interfaces.ElectricalPowerPort_b load_auxiliary
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Sources.PowerSink totalElecPower_sink
    annotation (Placement(transformation(extent={{60,70},{40,90}})));
  Sources.PrescribedPowerFlow SOECelec_source
    annotation (Placement(transformation(extent={{-40,-90},{-60,-70}})));
  Modelica.Blocks.Sources.RealExpression SOECelec_sourceSingal(y=
        powerConsumption_SOEC)
    annotation (Placement(transformation(extent={{0,-90},{-20,-70}})));
  Sources.LoadSink loadUtility_auxiliary
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Electrolysis.Interfaces.ElectricalPowerPort_a generation_GT annotation (
      Placement(transformation(extent={{70,-90},{90,-70}}),
        iconTransformation(extent={{70,-90},{90,-70}})));
  Sources.PrescribedFrequency generationGT_sink(f=60)
    annotation (Placement(transformation(extent={{60,-90},{40,-70}})));
equation
  powerConsumption_auxiliary =-loadUtility_auxiliary.W;
  powerGeneration_GT = generationGT_sink.portElec_a.W;
  powerConsumption_SOEC = totalElecPower_sink.W - powerConsumption_auxiliary + powerGeneration_GT;

  connect(load_SOEC, SOECelec_source.port_b) annotation (Line(
      points={{-80,-80},{-70,-80},{-60,-80}},
      color={255,0,0},
      thickness=0.5));
  connect(SOECelec_source.P_flow, SOECelec_sourceSingal.y)
    annotation (Line(points={{-42,-80},{-21,-80}}, color={0,0,127}));
  connect(totalElecPower_sink.port_a, totalElecPower) annotation (Line(
      points={{60,80},{80,80}},
      color={255,0,0},
      thickness=0.5));
  connect(loadUtility_auxiliary.port_a, load_auxiliary) annotation (Line(
      points={{-60,80},{-70,80},{-80,80}},
      color={255,0,0},
      thickness=0.5));
  connect(generationGT_sink.portElec_a, generation_GT) annotation (Line(
      points={{60,-80},{70,-80},{80,-80}},
      color={255,0,0},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-100,-60},{-60,-100},{58,-100},{100,-60},{100,60},{60,100},{-60,
              100},{-100,60},{-100,-60}},
          lineColor={175,175,175},
          fillColor={255,213,170},
          fillPattern=FillPattern.CrossDiag),
        Line(
          points={{-80,52},{-40,0},{-2,52},{-40,0},{-40,-52}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{0,40},{0,-40},{80,0},{0,40}},
          color={255,0,0},
          thickness=0.5),
                Text(
          extent={{-150,-109},{150,-149}},
          lineColor={0,0,255},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end SwitchYard_HTSE;
