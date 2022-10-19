within NHES.Electrolysis.Separator;
model Temp_Combiner
  extends Electrolysis.Icons.FlashDrum;
  import      Modelica.Units.SI;
  //SI.MassFlowRate m_total;

  // ---------- Fluid package -------------------------------------------------
  replaceable package MediumVapor = Modelica.Media.IdealGases.SingleGases.H2
    constrainedby Modelica.Media.Interfaces.PartialMedium "Working fluid model" annotation (choicesAllMatching = true,Dialog(group="Working fluid (Medium)"));

  replaceable package MediumLiquid = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium "Working fluid model" annotation (choicesAllMatching = true,Dialog(group="Working fluid (Medium)"));

  Modelica.Fluid.Interfaces.FluidPort_a vaporInlet(redeclare package Medium = MediumVapor)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}}), iconTransformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a liquidInlet(redeclare package Medium = MediumLiquid)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
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
  Modelica.Fluid.Interfaces.FluidPort_b Outlet(redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{-10,-100},{10,-80}})));
  Modelica.Fluid.Sources.MassFlowSource_T OutletFlowControl(
    use_m_flow_in=true,
    m_flow=1.35415,
    use_T_in=true,
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    X={0.1,0.9},
    nPorts=1,
    use_X_in=false,
    T=618.329) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={68,0})));
  Modelica.Fluid.Sensors.Temperature LiquidTemp(redeclare package Medium = MediumLiquid)
    annotation (Placement(transformation(extent={{-42,-60},{-22,-40}})));


  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-54,16},{-34,36}})));
  Utilities.Average average annotation (Placement(transformation(extent={{-10,-6},{10,14}})));
  Modelica.Fluid.Sensors.Temperature VaporTemp(redeclare package Medium = MediumVapor)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
equation
//   m_total = VaporFlowRate.m_flow + LiquidFlowRate.m_flow;
//   massFractionVapor = VaporFlowRate.m_flow/m_total;
//   massFractionLiquid = LiquidFlowRate.m_flow/m_total;

  connect(vaporInlet, vaporInlet) annotation (Line(points={{-100,60},{-100,60}}, color={0,127,255}));
  connect(vaporInlet, VaporFlowRate.port_a) annotation (Line(points={{-100,60},{-82,60}}, color={0,127,255}));
  connect(VaporFlowRate.port_b, vaporSink.ports[1]) annotation (Line(points={{-62,60},{40,60}},  color={0,127,255}));
  connect(liquidInlet, LiquidFlowRate.port_a) annotation (Line(points={{-100,-60},{-82,-60}}, color={0,127,255}));
  connect(LiquidFlowRate.port_b, liquidSink.ports[1]) annotation (Line(points={{-62,-60},{40,-60}},  color={0,127,255}));
  connect(OutletFlowControl.ports[1], Outlet) annotation (Line(points={{78,0},{100,0}}, color={0,127,255}));
  connect(LiquidFlowRate.m_flow, add.u2) annotation (Line(points={{-72,-49},{-72,20},{-56,20}}, color={0,0,127}));
  connect(VaporFlowRate.m_flow, add.u1) annotation (Line(points={{-72,49},{-72,32},{-56,32}},
                                                                                            color={0,0,127}));
  connect(add.y, OutletFlowControl.m_flow_in) annotation (Line(points={{-33,26},{58,26},{58,8}},                 color={0,0,127}));
  connect(LiquidFlowRate.port_b, LiquidTemp.port) annotation (Line(points={{-62,-60},{-32,-60}}, color={0,127,255}));
  connect(VaporFlowRate.port_b, VaporTemp.port) annotation (Line(points={{-62,60},{-30,60}}, color={0,127,255}));
  connect(VaporTemp.T, average.u1) annotation (Line(points={{-23,70},{-18,70},{-18,10},{-12,10}}, color={0,0,127}));
  connect(LiquidTemp.T, average.u2) annotation (Line(points={{-25,-50},{-18,-50},{-18,-2},{-12,-2}}, color={0,0,127}));
  connect(average.y, OutletFlowControl.T_in) annotation (Line(points={{11,4},{56,4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
                Text(
          extent={{-150,20},{150,-20}},
          lineColor={0,0,255},
          textString="%name",
          origin={-92,113},
          rotation=0)}),              Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end Temp_Combiner;
