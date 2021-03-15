within NHES.Electrolysis.HTSE.Intermediate_HTSE.HTSEvessel;
model HTSEvesselModule
  import NHES;
  extends Modelica.Icons.Example;

  inner Modelica.Fluid.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  Modelica.Blocks.Sources.Ramp power_set(
    duration=0,
    startTime=100,
    offset=9.10627*1e6*5 + 5613800,
    height=-1.929*1e6*5*1 + 453400 - 1255195*0)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,70})));

  NHES.Electrolysis.Sources.PrescribedPowerFlow prescribedPowerFlow
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={70,48})));

  Modelica.Blocks.Continuous.FirstOrder actuator_wAnode_in(
    k=1,
    T=4,
    y_start=HTSEvessel.controlledSOEC.anodeFCV_valveOpening_start,
    initType=Modelica.Blocks.Types.Init.SteadyState)
          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,-80})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasSource(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    X=NHES.Electrolysis.Utilities.moleToMassFractions(
                                                 {0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*
        1000}),
    p(displayUnit="bar") = 2272222,
    T=556.55)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));

  Modelica.Fluid.Valves.ValveLinear FCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=HTSEvessel.controlledSOEC.wCathode_in_start,
    dp_nominal=HTSEvessel.controlledSOEC.cathodeFCV_valveOpening_start*((
        22.72222 - 20.45)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wCathode_in_start,
    m_flow(start=HTSEvessel.controlledSOEC.wCathode_in_start, fixed=true),
    dp_start=((22.72222 - 20.45)*1e5))
                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,60})));

  Modelica.Blocks.Continuous.FirstOrder actuator_wCathode_in(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.cathodeFCV_valveOpening_start)
                                                       annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,80})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSource(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=NHES.Electrolysis.Utilities.moleToMassFractions(
                                                 {0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    p(displayUnit="bar") = 2272222,
    nPorts=1,
    T=532.15)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));

  Modelica.Fluid.Valves.ValveLinear FCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=HTSEvessel.controlledSOEC.wAnode_in_start,
    dp_nominal=HTSEvessel.controlledSOEC.anodeFCV_valveOpening_start*((
        22.72222 - 20.45)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wAnode_in_start,
    m_flow(start=HTSEvessel.controlledSOEC.wAnode_in_start),
    dp_start=((22.72222 - 20.45)*1e5))    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,-60})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasSink(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1764315,
    T=618.329)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,20})));

  Modelica.Blocks.Continuous.FirstOrder actuator_pAnSOEC(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.anodePCV_valveOpening_start)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,-40})));
  Modelica.Blocks.Continuous.FirstOrder actuator_pCatSOEC(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.cathodePCV_valveOpening_start)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,40})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSink(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=1730700,
    T=605.838,
    nPorts=1)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Fluid.Valves.ValveLinear PCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=HTSEvessel.controlledSOEC.wAnode_out_start,
    m_flow(start=HTSEvessel.controlledSOEC.wAnode_out_start),
    dp_nominal=HTSEvessel.controlledSOEC.anodePCV_valveOpening_start*((
        19.23 - 17.307)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wAnode_out_start,
    dp_start=((19.23 - 17.307)*1e5))       annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-30,-20})));
  Modelica.Fluid.Valves.ValveLinear PCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=HTSEvessel.controlledSOEC.wCathode_out_start,
    m_flow(start=HTSEvessel.controlledSOEC.wCathode_out_start),
    dp_nominal=HTSEvessel.controlledSOEC.cathodePCV_valveOpening_start*((
        19.6035 - 17.64315)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wCathode_out_start,
    dp_start=((19.6035 - 17.64315)*1e5))
                           annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,20})));

  NHES.Electrolysis.HTSE.HTSEvessel HTSEvessel
    annotation (Placement(transformation(extent={{38,-10},{58,10}})));
  NHES.Electrolysis.Sensors.PowerSensor We_HTSE(W(unit="W",
        displayUnit="MW")) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=-90,
        origin={70,20})));
equation
  connect(FCV_catSOEC.port_a, cathodeGasSource.ports[1]) annotation (Line(
        points={{-40,60},{-40,60},{-60,60}},
                                          color={0,127,255}));
  connect(actuator_wCathode_in.y, FCV_catSOEC.opening) annotation (Line(
        points={{-11,80},{-30,80},{-30,68}},     color={0,0,127}));
  connect(anodeGasSource.ports[1], FCV_anSOEC.port_a) annotation (Line(
        points={{-60,-60},{-60,-60},{-40,-60}}, color={0,127,255}));
  connect(FCV_anSOEC.opening, actuator_wAnode_in.y) annotation (Line(
        points={{-30,-68},{-30,-80},{-11,-80}}, color={0,0,127}));
  connect(anodeGasSink.ports[1], PCV_anSOEC.port_b)
    annotation (Line(points={{-60,-20},{-40,-20}}, color={0,127,255}));
  connect(actuator_pAnSOEC.y, PCV_anSOEC.opening) annotation (Line(points=
         {{-11,-40},{-30,-40},{-30,-28}}, color={0,0,127}));
  connect(PCV_catSOEC.opening, actuator_pCatSOEC.y) annotation (Line(
        points={{-30,28},{-30,40},{-11,40}}, color={0,0,127}));
  connect(FCV_catSOEC.port_b, HTSEvessel.cathodeIn) annotation (Line(
        points={{-20,60},{48,60},{48,10}}, color={0,127,255}));
  connect(FCV_anSOEC.port_b, HTSEvessel.anodeIn) annotation (Line(points={{-20,-60},
          {48,-60},{48,-10}},            color={0,127,255}));
  connect(HTSEvessel.anodeOut, PCV_anSOEC.port_a) annotation (Line(points={{40,-2},
          {10,-2},{10,-20},{-20,-20}},         color={0,127,255}));
  connect(power_set.y, prescribedPowerFlow.P_flow) annotation (Line(
        points={{79,70},{70,70},{70,57.6}}, color={0,0,127}));
  connect(HTSEvessel.c_wCathode, actuator_wCathode_in.u) annotation (Line(
        points={{51,10.4},{51,10.4},{51,80},{12,80}}, color={0,0,127}));
  connect(HTSEvessel.c_pCathode, actuator_pCatSOEC.u) annotation (Line(
        points={{39.6,4.4},{30,4.4},{30,40},{12,40}}, color={0,0,127}));
  connect(HTSEvessel.c_wAnode, actuator_wAnode_in.u) annotation (Line(
        points={{51,-10.4},{51,-80},{12,-80}}, color={0,0,127}));
  connect(HTSEvessel.c_pAnode, actuator_pAnSOEC.u) annotation (Line(
        points={{39.6,-4.4},{28,-4.4},{28,-40},{12,-40}}, color={0,0,127}));
  connect(cathodeGasSink.ports[1], PCV_catSOEC.port_b) annotation (Line(
        points={{-60,20},{-50,20},{-40,20}}, color={0,127,255}));
  connect(PCV_catSOEC.port_a, HTSEvessel.cathodeOut) annotation (Line(
        points={{-20,20},{10,20},{10,2},{40,2}}, color={0,127,255}));
  connect(prescribedPowerFlow.port_b, We_HTSE.port_a)
    annotation (Line(points={{70,36},{70,28}}, color={255,0,0}));
  connect(We_HTSE.port_b, HTSEvessel.elecLoad) annotation (Line(points={{70,12},
          {70,2},{56,2}},              color={255,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=1800,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end HTSEvesselModule;
