within NHES.Electrolysis.HTSE.Intermediate_HTSE.StreamSplitJoin;
model SteamSplit_test_sourceMassFlows
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T feedCathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=4.48466,
    use_m_flow_in=true,
    T=298.15)
    annotation (Placement(transformation(extent={{-42,40},{-22,60}})));
  HeatExchangers.HEX_nuclearHeatCathodeGasRecup_ROM_NHES hEX_nuclearHeatCathodeGasRecup_ROM(
    redeclare package Medium_tube =
        Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-8,42},{8,58}})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=4317930,
    T=497.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,10})));
  Modelica.Fluid.Sources.MassFlowSource_T steamNukeFeed_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    use_C_in=false,
    use_m_flow_in=true,
    m_flow=6.47968,
    T=591.15)
    annotation (Placement(transformation(extent={{-84,72},{-64,92}})));
  Modelica.Blocks.Sources.Ramp feedCathodeGas_signal(
    startTime=100,
    duration=5,
    height=-0.85232 + 0.85232,
    offset=4.48466) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,58})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasSink_recuponly(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=2045000,
    T=556.55)
    annotation (Placement(transformation(extent={{118,40},{98,60}})));
  Modelica.Blocks.Sources.Ramp steamNukeCathodeFeed_signal(
    duration=0,
    startTime=100,
    height=-2,
    offset=6.47968) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,90})));
  HeatExchangers.HEX_nuclearHeatAnodeGasRecup_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    AhShell=hEX_nuclearHeatAnodeGasRecup_ROM.AhTube*1.35)
    annotation (Placement(transformation(extent={{-8,-54},{8,-70}})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=2,
    p=4317930,
    T=497.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-26})));
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
        1000}),
    m_flow=23.27935,
    T=298.15,
    nPorts=1)   annotation (Placement(transformation(extent={{-42,-72},{
            -22,-52}})));
  Modelica.Fluid.Sources.MassFlowSource_T steamNukeFeed_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=2.61448,
    use_m_flow_in=true,
    T=591.15) annotation (Placement(transformation(extent={{-84,-104},{
            -64,-84}})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSink_recupOnly(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=2045000,
    T=556.55)
    annotation (Placement(transformation(extent={{118,-72},{98,-52}})));
  Modelica.Blocks.Sources.Ramp feedAnodeGas_signal(
    duration=0,
    startTime=100,
    height=0,
    offset=2.61448)  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,-86})));
  Modelica.Blocks.Sources.Ramp steamNukeAnodeFeed_signal(
    duration=0,
    height=0,
    startTime=200,
    offset=23.2794) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,-54})));
  Modelica.Fluid.Valves.ValveLinear TCV_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    m_flow_small=0.001,
    dp_nominal=0.85*((58 - 44.0804)*1e5),
    m_flow_start=6.47973,
    m_flow_nominal=6.47973,
    dp_start=(58 - 44.0804)*1e5)
                            annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-20,82})));
  Modelica.Blocks.Sources.Ramp valveOpening_cathodeGas(
    duration=0,
    height=0,
    startTime=0,
    offset=0.85)
                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={10,100})));
  Modelica.Fluid.Sensors.Temperature tempSteamCatthodeIn(redeclare package
      Medium =         Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{30,82},{50,102}})));
  Modelica.Fluid.Sensors.Temperature tempSteamCatOut(redeclare package Medium =
               Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{30,28},{50,48}})));
  Modelica.Fluid.Sensors.Pressure valve_pCathodeIn(redeclare package Medium =
               Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-58,90},{-38,110}})));
  Modelica.Fluid.Sensors.Pressure valve_pAnodeIn(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-66,-36},{-46,-16}})));
  Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    m_flow_small=0.001,
    m_flow_nominal=2.61448,
    dp_nominal=0.5*((58 - 43.5)*1e5),
    m_flow_start=2.61448,
    dp_start=(58 - 43.5)*1e5)
                          annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-40,-94})));
  Modelica.Blocks.Sources.Ramp valveOpening_anodeGas(
    duration=0,
    height=0,
    startTime=0,
    offset=0.5) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-6,-110})));
  Modelica.Fluid.Sensors.Temperature tempSteamAnodeIn(redeclare package Medium =
               Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{28,-88},{48,-68}})));
  Modelica.Fluid.Sensors.Temperature tempSteamAnodeOut(redeclare package Medium =
               Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{30,-44},{50,-24}})));
equation
  connect(feedCathodeGas_signal.y, feedCathodeGas.m_flow_in) annotation (
      Line(points={{-99,58},{-84,58},{-42,58}}, color={0,0,127}));
  connect(feedCathodeGas.ports[1], hEX_nuclearHeatCathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-22,50},{-15,50},{-8,50}}, color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.tube_out,
    cathodeGasSink_recuponly.ports[1])
    annotation (Line(points={{8,50},{98,50}}, color={0,127,255}));
  connect(steamNukeCathodeFeed_signal.y, steamNukeFeed_cathodeGas.m_flow_in)
    annotation (Line(points={{-99,90},{-99,90},{-84,90}}, color={0,0,127}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_out,
    steamNukeSink_anodeGas.ports[1]) annotation (Line(points={{0,-54},{0,
          -36},{-2,-36}},color={0,127,255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out,
    anodeGasSink_recupOnly.ports[1]) annotation (Line(points={{8,-62},{53,
          -62},{98,-62}}, color={0,127,255}));
  connect(steamNukeFeed_anodeGas.m_flow_in, feedAnodeGas_signal.y)
    annotation (Line(points={{-84,-86},{-99,-86}}, color={0,0,127}));
  connect(steamNukeAnodeFeed_signal.y, feedAnodeGas.m_flow_in)
    annotation (Line(points={{-99,-54},{-42,-54}},           color={0,0,
          127}));
  connect(steamNukeFeed_cathodeGas.ports[1], TCV_cathodeGas.port_a)
    annotation (Line(points={{-64,82},{-64,82},{-30,82}}, color={0,127,
          255}));
  connect(TCV_cathodeGas.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-10,82},{0,82},{0,58}}, color={0,127,255}));
  connect(valveOpening_cathodeGas.y, TCV_cathodeGas.opening) annotation (
      Line(points={{-1,100},{-20,100},{-20,90}}, color={0,0,127}));
  connect(tempSteamCatthodeIn.port, TCV_cathodeGas.port_b) annotation (
      Line(points={{40,82},{40,82},{-10,82}}, color={0,127,255}));
  connect(tempSteamCatOut.port, hEX_nuclearHeatCathodeGasRecup_ROM.shell_out)
    annotation (Line(points={{40,28},{40,28},{0,28},{0,42}}, color={0,127,
          255}));
  connect(valve_pCathodeIn.port, TCV_cathodeGas.port_a) annotation (Line(
        points={{-48,90},{-48,82},{-30,82}}, color={0,127,255}));
  connect(steamNukeSink_cathodeGas.ports[1],
    hEX_nuclearHeatCathodeGasRecup_ROM.shell_out)
    annotation (Line(points={{0,20},{0,20},{0,42}}, color={0,127,255}));
  connect(feedAnodeGas.ports[1], hEX_nuclearHeatAnodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-22,-62},{-22,-62},{-8,-62}}, color={0,127,
          255}));
  connect(steamNukeFeed_anodeGas.ports[1], TCV_anodeGas.port_a)
    annotation (Line(points={{-64,-94},{-50,-94}}, color={0,127,255}));
  connect(TCV_anodeGas.port_b, hEX_nuclearHeatAnodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-30,-94},{0,-94},{0,-70}}, color={0,127,255}));
  connect(valveOpening_anodeGas.y, TCV_anodeGas.opening) annotation (Line(
        points={{-17,-110},{-26,-110},{-26,-78},{-40,-78},{-40,-86}},
        color={0,0,127}));
  connect(valve_pAnodeIn.port, TCV_anodeGas.port_a) annotation (Line(
        points={{-56,-36},{-56,-36},{-56,-56},{-56,-94},{-50,-94}}, color=
         {0,127,255}));
  connect(tempSteamAnodeIn.port, hEX_nuclearHeatAnodeGasRecup_ROM.shell_in)
    annotation (Line(points={{38,-88},{0,-88},{0,-70}}, color={0,127,255}));
  connect(tempSteamAnodeOut.port, hEX_nuclearHeatAnodeGasRecup_ROM.shell_out)
    annotation (Line(points={{40,-44},{0,-44},{0,-54}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -140},{140,140}})), Icon(coordinateSystem(extent={{-140,-140},{140,
            140}})));
end SteamSplit_test_sourceMassFlows;
