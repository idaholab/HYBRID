within NHES.Electrolysis.HeatExchangers.Examples.TCS_FY16;
model HEX_nuclearHeatAnodeGasRecup_ROM_NHES_test
  import NHES.Electrolysis;

  extends Modelica.Icons.Example;

  Electrolysis.HeatExchangers.HEX_nuclearHeatAnodeGasRecup_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-68,12},{-52,28}})));
  Modelica.Fluid.Sources.MassFlowSource_T steamNukeFeed_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=2.80062,
    use_m_flow_in=true,
    T=574.698)
    annotation (Placement(transformation(extent={{-100,52},{-80,72}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    m_flow=4.484668581,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    T=298.15)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));

  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=4313200,
    T=497.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-10})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSink_recupOnly(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=2045000,
    T=532.15)
    annotation (Placement(transformation(extent={{162,10},{142,30}})));

  Modelica.Blocks.Sources.Ramp feedAnodeGas_signal(
    duration=0,
    startTime=100,
    height=-2,
    offset=23.27935) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,28})));
  Electrolysis.Sensors.TempSensorWithThermowell TNOut_anodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    y_start=283.4 + 273.15,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-50,34},{-30,54}})));
  Modelica.Blocks.Sources.Ramp steamNukeFeed_signal(
    duration=0,
    height=0,
    startTime=200,
    offset=2.80062)
                   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,70})));
equation
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_out,
    steamNukeSink_anodeGas.ports[1]) annotation (Line(points={{-60,12},{-60,
          6},{-60,0}}, color={0,127,255}));
  connect(feedAnodeGas.ports[1], hEX_nuclearHeatAnodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-80,20},{-80,20},{-68,20}}, color={0,127,255}));
  connect(feedAnodeGas_signal.y, feedAnodeGas.m_flow_in)
    annotation (Line(points={{-119,28},{-100,28}}, color={0,0,127}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_in, steamNukeFeed_anodeGas.ports[
    1]) annotation (Line(points={{-60,28},{-60,62},{-80,62}},  color={0,127,
          255}));
  connect(steamNukeFeed_signal.y, steamNukeFeed_anodeGas.m_flow_in)
    annotation (Line(points={{-119,70},{-100,70}}, color={0,0,127}));
  connect(anodeGasSink_recupOnly.ports[1], hEX_nuclearHeatAnodeGasRecup_ROM.tube_out)
    annotation (Line(points={{142,20},{45,20},{-52,20}}, color={0,127,255}));
  connect(TNOut_anodeGasSensor.port, hEX_nuclearHeatAnodeGasRecup_ROM.tube_out)
    annotation (Line(points={{-40,34},{-40,20},{-52,20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {140,140}})),                           Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{
            140,140}})),
    experiment(StopTime=1200, Interval=1),
    __Dymola_experimentSetupOutput);
end HEX_nuclearHeatAnodeGasRecup_ROM_NHES_test;
