within NHES.Electrolysis.Separator;
model Temp_Combiner_Test
  extends Electrolysis.Icons.FlashDrum;
  import      Modelica.Units.SI;
  //SI.MassFlowRate m_total;

  // ---------- Fluid package -------------------------------------------------
  replaceable package MediumVapor = Modelica.Media.IdealGases.SingleGases.H2
    constrainedby Modelica.Media.Interfaces.PartialMedium "Working fluid model" annotation (choicesAllMatching = true,Dialog(group="Working fluid (Medium)"));

  replaceable package MediumLiquid = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium "Working fluid model" annotation (choicesAllMatching = true,Dialog(group="Working fluid (Medium)"));

  Modelica.Fluid.Sensors.MassFlowRate VaporFlowRate(redeclare package Medium = MediumVapor)
    annotation (Placement(transformation(extent={{-82,70},{-62,50}})));
  Modelica.Fluid.Sensors.MassFlowRate LiquidFlowRate(redeclare package Medium = MediumLiquid)
    annotation (Placement(transformation(extent={{-82,-70},{-62,-50}})));
  Modelica.Fluid.Sources.Boundary_pT vaporSink(
    redeclare package Medium = MediumVapor,
    p=1764315,
    T=618.329,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,60})));
  Modelica.Fluid.Sources.Boundary_pT liquidSink(
    redeclare package Medium = MediumLiquid,
    p=1764315,
    T=618.329,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,-60})));
  Modelica.Fluid.Sources.MassFlowSource_T OutletFlowControl(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    use_X_in=true,
    nPorts=1)  annotation (Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=0,
        origin={63,1})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                     LiquidTemp(redeclare package Medium = MediumLiquid)
    annotation (Placement(transformation(extent={{-34,-70},{-14,-50}})));

  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-54,16},{-34,36}})));
  Utilities.Average average annotation (Placement(transformation(extent={{-10,-6},{10,14}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                     VaporTemp(redeclare package Medium = MediumVapor)
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(extent={{-56,-22},{-36,-2}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T TubeH2In(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    m_flow=1,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(extent={{-134,50},{-114,70}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T TubeWaterIn(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(extent={{-138,-70},{-118,-50}})));
  Modelica.Fluid.Sources.Boundary_pT TotalSink(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    p=101300,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={106,0})));
  Utilities.RealExpression_Vector realExpression_Vector1(y={division.y,1 - division.y})
    annotation (Placement(transformation(extent={{0,-36},{20,-16}})));
equation
//   m_total = VaporFlowRate.m_flow + LiquidFlowRate.m_flow;
//   massFractionVapor = VaporFlowRate.m_flow/m_total;
//   massFractionLiquid = LiquidFlowRate.m_flow/m_total;

  connect(LiquidFlowRate.m_flow, add.u2) annotation (Line(points={{-72,-49},{-72,20},{-56,20}}, color={0,0,127}));
  connect(VaporFlowRate.m_flow, add.u1) annotation (Line(points={{-72,49},{-72,32},{-56,32}},
                                                                                            color={0,0,127}));
  connect(VaporTemp.T, average.u1) annotation (Line(points={{-20,63.6},{-20,74},{-6,74},{-6,58},{-4,58},{-4,18},{-18,18},{-18,10},{-12,10}},
                                                                                                  color={0,0,127}));
  connect(LiquidTemp.T, average.u2) annotation (Line(points={{-24,-56.4},{-24,-2},{-12,-2}},         color={0,0,127}));
  connect(VaporFlowRate.m_flow, division.u1)
    annotation (Line(points={{-72,49},{-72,32},{-66,32},{-66,22},{-68,22},{-68,-6},{-58,-6}}, color={0,0,127}));
  connect(add.y, division.u2) annotation (Line(points={{-33,26},{-28,26},{-28,-26},{-64,-26},{-64,-18},{-58,-18}}, color={0,0,127}));
  connect(VaporFlowRate.port_a, TubeH2In.ports[1]) annotation (Line(points={{-82,60},{-114,60}}, color={0,127,255}));
  connect(LiquidFlowRate.port_a, TubeWaterIn.ports[1]) annotation (Line(points={{-82,-60},{-118,-60}}, color={0,127,255}));
  connect(OutletFlowControl.ports[1], TotalSink.ports[1]) annotation (Line(points={{74,1},{74,4.44089e-16},{96,4.44089e-16}}, color={0,127,255}));
  connect(VaporFlowRate.port_b, VaporTemp.port_a) annotation (Line(points={{-62,60},{-30,60}}, color={0,127,255}));
  connect(vaporSink.ports[1], VaporTemp.port_b) annotation (Line(points={{40,60},{-10,60}}, color={0,127,255}));
  connect(LiquidFlowRate.port_b, LiquidTemp.port_a) annotation (Line(points={{-62,-60},{-34,-60}}, color={0,127,255}));
  connect(liquidSink.ports[1], LiquidTemp.port_b) annotation (Line(points={{40,-60},{-14,-60}}, color={0,127,255}));
  connect(average.y, OutletFlowControl.T_in) annotation (Line(points={{11,4},{46,4},{46,5.4},{49.8,5.4}}, color={0,0,127}));
  connect(add.y, OutletFlowControl.m_flow_in) annotation (Line(points={{-33,26},{32,26},{32,18},{52,18},{52,9.8}}, color={0,0,127}));
  connect(realExpression_Vector1.y, OutletFlowControl.X_in)
    annotation (Line(points={{21,-26},{48,-26},{48,-8},{49.8,-8},{49.8,-3.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
                Text(
          extent={{-150,20},{150,-20}},
          lineColor={0,0,255},
          textString="%name",
          origin={-92,113},
          rotation=0)}),              Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end Temp_Combiner_Test;
