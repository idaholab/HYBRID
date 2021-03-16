within NHES.Electrolysis.HeatExchangers.Examples.TCS_FY16;
model HES_nuclearHeatCathodeGasRecup_ROM_NHES_test
  import NHES.Electrolysis;

  extends Modelica.Icons.Example;

  Electrolysis.HeatExchangers.HEX_nuclearHeatCathodeGasRecup_ROM_NHES
    hEX_nuclearHeatCathodeGasRecup_ROM(
    redeclare package Medium_tube =
        Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-68,12},{-52,28}})));
  Modelica.Fluid.Sources.MassFlowSource_T steamNukeFeed_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=6.47921,
    use_m_flow_in=true,
    T=574.698)
    annotation (Placement(transformation(extent={{-100,52},{-80,72}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedCathodeGas(
    use_m_flow_in=true,
    m_flow=4.484668581,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    T=298.15)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=4259910,
    T=497.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-10})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasSink_recuponly(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=2,
    p=2045000,
    T=556.55)
    annotation (Placement(transformation(extent={{162,10},{142,30}})));
  Modelica.Blocks.Sources.Ramp feedCathodeGas_signal(
    duration=0,
    offset=4.48467,
    height=-0.2,
    startTime=100) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,28})));
  Electrolysis.Sensors.TempSensorWithThermowell TNOut_CathodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    y_start=283.4 + 273.15)
    annotation (Placement(transformation(extent={{-50,34},{-30,54}})));
  Modelica.Blocks.Sources.Ramp steamNukeFeed_signal(
    duration=0,
    height=0,
    startTime=200,
    offset=6.47921) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,70})));
equation
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.shell_in,
    steamNukeFeed_cathodeGas.ports[1]) annotation (Line(points={{-60,28},{
          -60,62},{-80,62}},  color={0,127,255}));
  connect(feedCathodeGas_signal.y, feedCathodeGas.m_flow_in)
    annotation (Line(points={{-119,28},{-100,28}}, color={0,0,127}));
  connect(feedCathodeGas.ports[1], hEX_nuclearHeatCathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-80,20},{-68,20}}, color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.shell_out,
    steamNukeSink_anodeGas.ports[1]) annotation (Line(points={{-60,12},{-60,
          6},{-60,0}}, color={0,127,255}));
  connect(steamNukeFeed_cathodeGas.m_flow_in, steamNukeFeed_signal.y)
    annotation (Line(points={{-100,70},{-119,70}}, color={0,0,127}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.tube_out,
    cathodeGasSink_recuponly.ports[1]) annotation (Line(points={{-52,20},{
          142,20},{142,22}}, color={0,127,255}));
  connect(TNOut_CathodeGasSensor.port, hEX_nuclearHeatCathodeGasRecup_ROM.tube_out)
    annotation (Line(points={{-40,34},{-40,34},{-40,30},{-40,20},{-52,20}},
        color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {140,140}})),                           Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{
            140,140}})),
    experiment(StopTime=1200, Interval=1),
    __Dymola_experimentSetupOutput);
end HES_nuclearHeatCathodeGasRecup_ROM_NHES_test;
