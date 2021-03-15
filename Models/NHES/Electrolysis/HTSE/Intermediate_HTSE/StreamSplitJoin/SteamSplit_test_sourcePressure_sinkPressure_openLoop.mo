within NHES.Electrolysis.HTSE.Intermediate_HTSE.StreamSplitJoin;
model SteamSplit_test_sourcePressure_sinkPressure_openLoop
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T feedCathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=4.48466,
    use_m_flow_in=true,
    T=298.15)
    annotation (Placement(transformation(extent={{-42,38},{-22,58}})));
  HeatExchangers.HEX_nuclearHeatCathodeGasRecup_ROM_NHES hEX_nuclearHeatCathodeGasRecup_ROM(
    redeclare package Medium_tube =
        Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-8,40},{8,56}})));
  Modelica.Blocks.Sources.Ramp feedCathodeGas_signal(
    startTime=100,
    offset=4.48466,
    height=-1.7456,
    duration=0)     annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,56})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasSink_recupOnly(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=2045000,
    T=556.55)
    annotation (Placement(transformation(extent={{118,38},{98,58}})));
  HeatExchangers.HEX_nuclearHeatAnodeGasRecup_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    AhShell=hEX_nuclearHeatAnodeGasRecup_ROM.AhTube*1.35)
    annotation (Placement(transformation(extent={{-8,-52},{8,-68}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
        1000}),
    m_flow=23.27935,
    T=298.15,
    nPorts=1)   annotation (Placement(transformation(extent={{-42,-70},{
            -22,-50}})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSink_recupOnly(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=2045000,
    T=556.55)
    annotation (Placement(transformation(extent={{118,-70},{98,-50}})));
  Modelica.Blocks.Sources.Ramp steamNukeAnodeFeed_signal(
    duration=0,
    startTime=200,
    offset=23.2794,
    height=4.9792*0)
                    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,-52})));
  Modelica.Fluid.Valves.ValveLinear TCV_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    m_flow_small=0.001,
    show_T=true,
    m_flow_start=6.47973,
    m_flow_nominal=6.47973,
    dp_nominal=0.85*((58 - 44.0804)*1e5),
    dp_start=(58 - 44.0804)*1e5)
                 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-20,80})));
  Modelica.Blocks.Sources.Ramp valveOpening_cathodeGas(
    startTime=100,
    duration=0,
    offset=0.85,
    height=-0.6925)
                   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,100})));
  Modelica.Fluid.Sensors.Temperature tempSteamCatOut(redeclare package Medium =
               Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{30,32},{50,52}})));
  Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    m_flow_small=0.001,
    m_flow_nominal=2.61448,
    show_T=true,
    m_flow_start=2.61448,
    dp_nominal=0.5*((58 - 43.5)*1e5),
    dp_start=(58 - 43.5)*1e5)
                          annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-40,-88})));
  Modelica.Blocks.Sources.Ramp valveOpening_anodeGas(
    duration=0,
    startTime=200,
    offset=0.5,
    height=-0.25)  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-80})));
  Modelica.Fluid.Sensors.Temperature tempSteamAnodeOut(redeclare package Medium =
               Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{28,-40},{48,-20}})));
  Modelica.Fluid.Sources.Boundary_pT steamPressureIn(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    use_p_in=false,
    p=5800000,
    T=591.15)
    annotation (Placement(transformation(extent={{-120,0},{-100,20}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal flowSplit(redeclare package Medium =
               Modelica.Media.Water.StandardWater, port_2(m_flow(start=
            9.09421)))                             annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-70,10})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal flowJoin(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,8})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=4317930,
    T=497.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={76,8})));
equation
  connect(feedCathodeGas_signal.y, feedCathodeGas.m_flow_in) annotation (
      Line(points={{-59,56},{-59,56},{-42,56}}, color={0,0,127}));
  connect(feedCathodeGas.ports[1], hEX_nuclearHeatCathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-22,48},{-15,48},{-8,48}}, color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.tube_out,
    cathodeGasSink_recupOnly.ports[1])
    annotation (Line(points={{8,48},{54,48},{98,48}},
                                              color={0,127,255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out,
    anodeGasSink_recupOnly.ports[1]) annotation (Line(points={{8,-60},{53,
          -60},{98,-60}}, color={0,127,255}));
  connect(steamNukeAnodeFeed_signal.y, feedAnodeGas.m_flow_in)
    annotation (Line(points={{-59,-52},{-42,-52}},           color={0,0,
          127}));
  connect(TCV_cathodeGas.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-10,80},{0,80},{0,56}}, color={0,127,255}));
  connect(valveOpening_cathodeGas.y, TCV_cathodeGas.opening) annotation (
      Line(points={{19,100},{-20,100},{-20,88}}, color={0,0,127}));
  connect(tempSteamCatOut.port, hEX_nuclearHeatCathodeGasRecup_ROM.shell_out)
    annotation (Line(points={{40,32},{40,26},{0,26},{0,40}}, color={0,127,
          255}));
  connect(feedAnodeGas.ports[1], hEX_nuclearHeatAnodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-22,-60},{-22,-60},{-8,-60}}, color={0,127,
          255}));
  connect(TCV_anodeGas.port_b, hEX_nuclearHeatAnodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-30,-88},{0,-88},{0,-68}}, color={0,127,255}));
  connect(valveOpening_anodeGas.y, TCV_anodeGas.opening) annotation (Line(
        points={{19,-80},{-26,-80},{-26,-72},{-40,-72},{-40,-80}}, color=
          {0,0,127}));
  connect(flowSplit.port_2, steamPressureIn.ports[1]) annotation (Line(
        points={{-80,10},{-80,10},{-100,10}}, color={0,127,255}));
  connect(flowSplit.port_3, TCV_cathodeGas.port_a) annotation (Line(
        points={{-70,20},{-70,34},{-78,34},{-100,34},{-100,80},{-30,80}},
        color={0,127,255}));
  connect(flowSplit.port_1, TCV_anodeGas.port_a) annotation (Line(points=
          {{-60,10},{-50,10},{-50,-26},{-100,-26},{-100,-88},{-50,-88}},
        color={0,127,255}));
  connect(tempSteamAnodeOut.port, hEX_nuclearHeatAnodeGasRecup_ROM.shell_out)
    annotation (Line(points={{38,-40},{0,-40},{0,-52}}, color={0,127,255}));
  connect(flowJoin.port_3, hEX_nuclearHeatCathodeGasRecup_ROM.shell_out)
    annotation (Line(points={{30,18},{30,22},{0,22},{0,40}}, color={0,127,255}));
  connect(flowJoin.port_1, hEX_nuclearHeatAnodeGasRecup_ROM.shell_out)
    annotation (Line(points={{20,8},{0,8},{0,-52}}, color={0,127,255}));
  connect(steamNukeSink.ports[1], flowJoin.port_2)
    annotation (Line(points={{66,8},{40,8}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -120},{120,120}})), Icon(coordinateSystem(extent={{-120,-120},
            {120,120}})));
end SteamSplit_test_sourcePressure_sinkPressure_openLoop;
