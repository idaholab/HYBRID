within NHES.Electrolysis.HeatExchangers.Examples;
model HEX_nuclearHeatCathodeGasRecupVessel_ROM_NHES_test
  import NHES.Electrolysis;
  import NHES;

  extends Modelica.Icons.Example;

  NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatCathodeGasRecupVessel_ROM_NHES
    hEX_nuclearHeatCathodeGasRecup_ROM(
    redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
  Modelica.Fluid.Sources.MassFlowSource_T steamNukeFeed_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=6.47921,
    use_m_flow_in=true,
    T=584.779)
    annotation (Placement(transformation(extent={{-40,32},{-20,52}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedCathodeGas(
    use_m_flow_in=true,
    m_flow=4.484668581,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    T=298.3471)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=5130420,
    T=497.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasSink_recuponly(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=2272220,
    T=556.55,
    nPorts=1)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Sources.Ramp feedCathodeGas_signal(
    duration=0,
    height=-0.2,
    startTime=100,
    offset=4.4846564335925)
                   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,8})));
  Electrolysis.Sensors.TempSensorWithThermowell TNOut_CathodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    y_start=283.4 + 273.15)
    annotation (Placement(transformation(extent={{10,14},{30,34}})));
  Modelica.Blocks.Sources.Ramp steamNukeFeed_signal(
    duration=0,
    startTime=200,
    offset=6.46077,
    height=-0.5)    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,50})));
equation
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.shell_in,
    steamNukeFeed_cathodeGas.ports[1]) annotation (Line(points={{0,8},{0,
          42},{-20,42}},      color={0,127,255}));
  connect(feedCathodeGas_signal.y, feedCathodeGas.m_flow_in)
    annotation (Line(points={{-59,8},{-40,8}},     color={0,0,127}));
  connect(feedCathodeGas.ports[1], hEX_nuclearHeatCathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-20,0},{-8,0}},    color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.shell_out,
    steamNukeSink_cathodeGas.ports[1]) annotation (Line(points={{0,-8},{0,
          -14},{0,-20}}, color={0,127,255}));
  connect(steamNukeFeed_cathodeGas.m_flow_in, steamNukeFeed_signal.y)
    annotation (Line(points={{-40,50},{-59,50}},   color={0,0,127}));
  connect(TNOut_CathodeGasSensor.port, hEX_nuclearHeatCathodeGasRecup_ROM.tube_out)
    annotation (Line(points={{20,14},{20,14},{20,10},{20,0},{8,0}},
        color={0,127,255}));
  connect(cathodeGasSink_recuponly.ports[1],
    hEX_nuclearHeatCathodeGasRecup_ROM.tube_out)
    annotation (Line(points={{60,0},{34,0},{8,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=1200, Interval=1),
    __Dymola_experimentSetupOutput);
end HEX_nuclearHeatCathodeGasRecupVessel_ROM_NHES_test;
