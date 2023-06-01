within NHES.TestModels_AS;
model H2FlowRateAdjust_w_Steam_SOEC

  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=0.908085*5,
    T=414.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-78,-48},{-58,-28}})));
  Modelica.Blocks.Sources.Constant CathodeFlowControl2(k=1)          annotation (Placement(transformation(extent={{-112,-40},{-92,-20}})));
  Modelica.Fluid.Sensors.MassFractions X_H2(redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas, substanceName="H2")
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={32,24})));
  Modelica.Fluid.Sources.MassFlowSource_T H2_feed(
    use_m_flow_in=true,
    m_flow=1.35415,
    use_T_in=false,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    nPorts=1,
    use_X_in=false,
    T=414.15)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-86,14})));
  Electrolysis.Separator.Combiner_H2_Steam combiner_FinalV2_1 annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink1(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{110,-24},{90,-4}})));
  TRANSFORM.Controls.LimPID PID_Fuel(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{-18,54},{-38,74}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0.0123)      annotation (Placement(transformation(extent={{14,54},{-6,74}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTemp(redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{52,-24},{72,-4}})));
  Modelica.Fluid.Sensors.MassFlowRate CatGasMassFlow(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-48,-48},{-28,-28}})));
  Modelica.Fluid.Sensors.MassFlowRate H2MassFlowRate(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2)
    annotation (Placement(transformation(extent={{-58,4},{-38,24}})));
equation
  connect(cathodeFeed2.m_flow_in, CathodeFlowControl2.y) annotation (Line(points={{-78,-30},{-91,-30}}, color={0,0,127}));
  connect(combiner_FinalV2_1.Outlet, X_H2.port) annotation (Line(points={{0,-9},{0,-14},{32,-14},{32,14}}, color={0,127,255}));
  connect(X_H2.Xi, PID_Fuel.u_m) annotation (Line(points={{43,24},{48,24},{48,46},{-28,46},{-28,52}}, color={0,0,127}));
  connect(realExpression1.y, PID_Fuel.u_s) annotation (Line(points={{-7,64},{-16,64}}, color={0,0,127}));
  connect(H2_feed.m_flow_in, PID_Fuel.y) annotation (Line(points={{-96,22},{-96,64},{-39,64}}, color={0,0,127}));
  connect(X_H2.port, SinkTemp.port_a) annotation (Line(points={{32,14},{32,-14},{52,-14}}, color={0,127,255}));
  connect(SinkTemp.port_b, cathodeSink1.ports[1]) annotation (Line(points={{72,-14},{90,-14}}, color={0,127,255}));
  connect(cathodeFeed2.ports[1], CatGasMassFlow.port_a) annotation (Line(points={{-58,-38},{-48,-38}}, color={0,127,255}));
  connect(CatGasMassFlow.port_b, combiner_FinalV2_1.liquidInlet)
    annotation (Line(points={{-28,-38},{-16,-38},{-16,-6},{-10,-6}}, color={0,127,255}));
  connect(H2_feed.ports[1], H2MassFlowRate.port_a) annotation (Line(points={{-76,14},{-58,14}}, color={0,127,255}));
  connect(H2MassFlowRate.port_b, combiner_FinalV2_1.vaporInlet) annotation (Line(points={{-38,14},{-16,14},{-16,6},{-10,6}}, color={0,127,255}));
  annotation ();
end H2FlowRateAdjust_w_Steam_SOEC;
