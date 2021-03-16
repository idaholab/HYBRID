within NHES.Electrolysis.HeatExchangers.Examples;
model HEX_nuclearHeatAnodeGasRecupVessel_ROM_NHES_test
  import NHES.Electrolysis;
  import NHES;

  extends Modelica.Icons.Example;

  NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatAnodeGasRecupVessel_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
  Modelica.Fluid.Sources.MassFlowSource_T steamNukeFeed_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=6.47921,
    use_m_flow_in=true,
    T=583.94)
    annotation (Placement(transformation(extent={{-40,32},{-20,52}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    m_flow=4.484668581,
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    T=461.928,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}))
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=5130420,
    T=497.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSink_recuponly(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=2272220,
    T=532.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Sources.Ramp feedAnodeGas_signal(
    duration=0,
    startTime=100,
    height=-0.2*0,
    offset=23.2785) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,8})));
  Electrolysis.Sensors.TempSensorWithThermowell TNOut_AnodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=259 + 273.15)
    annotation (Placement(transformation(extent={{10,14},{30,34}})));
  Modelica.Blocks.Sources.Ramp steamNukeFeed_signal(
    duration=0,
    startTime=200,
    height=0,
    offset=0.850426)
                    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,50})));
equation
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_in,
    steamNukeFeed_anodeGas.ports[1])
    annotation (Line(points={{0,8},{0,42},{-20,42}}, color={0,127,255}));
  connect(feedAnodeGas_signal.y, feedAnodeGas.m_flow_in)
    annotation (Line(points={{-59,8},{-40,8}}, color={0,0,127}));
  connect(feedAnodeGas.ports[1], hEX_nuclearHeatAnodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-20,0},{-8,0}}, color={0,127,255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_out,
    steamNukeSink_anodeGas.ports[1]) annotation (Line(points={{0,-8},{0,-14},
          {0,-20}}, color={0,127,255}));
  connect(steamNukeFeed_anodeGas.m_flow_in, steamNukeFeed_signal.y)
    annotation (Line(points={{-40,50},{-59,50}}, color={0,0,127}));
  connect(TNOut_AnodeGasSensor.port, hEX_nuclearHeatAnodeGasRecup_ROM.tube_out)
    annotation (Line(points={{20,14},{20,14},{20,10},{20,0},{8,0}}, color=
         {0,127,255}));
  connect(anodeGasSink_recuponly.ports[1],
    hEX_nuclearHeatAnodeGasRecup_ROM.tube_out)
    annotation (Line(points={{60,0},{8,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=3600, Interval=1),
    __Dymola_experimentSetupOutput);
end HEX_nuclearHeatAnodeGasRecupVessel_ROM_NHES_test;
