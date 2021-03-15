within NHES.Electrolysis.Electrical;
model SwitchYard_auxiliary
  import      Modelica.Units.SI;

  SI.Power powerConsumption_MSCS;
  SI.Power powerConsumption_GT;
  SI.Power totalLoad_auxiliary;

  Electrolysis.Interfaces.ElectricalPowerPort_a load_auxiliary annotation (
      Placement(transformation(extent={{-70,-90},{-90,-70}}),
        iconTransformation(extent={{-90,-90},{-70,-70}})));
  Electrolysis.Interfaces.ElectricalPowerPort_b load_GT
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Electrolysis.Interfaces.ElectricalPowerPort_b load_MSCS
    annotation (Placement(transformation(extent={{90,-90},{70,-70}})));
  Sources.LoadSink loadGT_sink
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Sources.LoadSink loadMSCS_sink
    annotation (Placement(transformation(extent={{60,-90},{40,-70}})));
  Modelica.Blocks.Sources.RealExpression loadSignal_auxiliary(y=
        totalLoad_auxiliary)
    annotation (Placement(transformation(extent={{-20,-80},{-40,-60}})));
  Sources.PrescribedLoad loadAuxiliary_source annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,-80})));
equation
  powerConsumption_MSCS =-loadGT_sink.W;
  powerConsumption_GT =-loadMSCS_sink.W;
  totalLoad_auxiliary = powerConsumption_MSCS + powerConsumption_GT;

  connect(load_GT, loadGT_sink.port_a) annotation (Line(
      points={{-80,80},{-70,80},{-60,80}},
      color={255,0,0},
      thickness=0.5));
  connect(load_auxiliary, loadAuxiliary_source.load) annotation (Line(
      points={{-80,-80},{-60,-80}},
      color={255,0,0},
      thickness=0.5));
  connect(loadSignal_auxiliary.y, loadAuxiliary_source.powerConsumption)
    annotation (Line(points={{-41,-70},{-52,-70},{-52,-77}}, color={0,0,127}));
  connect(loadMSCS_sink.port_a, load_MSCS) annotation (Line(
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
end SwitchYard_auxiliary;
