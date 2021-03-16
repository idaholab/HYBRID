within NHES.Electrolysis.HeatExchangers.Examples;
model ISC1_openLoop_test2
  import NHES.Electrolysis;
  import NHES;

  extends Modelica.Icons.Example;

  NHES.Electrolysis.HeatExchangers.ISC_anodeGas1 hEX_interStageCooler1_ROM(
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    AhTube=10000) annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow=23.2785,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    T=412.821)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

  Modelica.Fluid.Sources.Boundary_pT sink_chilledWater1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=121325,
    T=298.1637)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=268620.40206962,
    T=313.15)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Sources.Ramp feedAnodeGas_signal(
    duration=0,
    startTime=100,
    offset=23.2785,
    height=(27.7282 - 23.2785))
                    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,8})));
  Electrolysis.Sensors.TempSensorWithThermowell Tout_interStageCooler1(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=40 + 273.15)
    annotation (Placement(transformation(extent={{10,14},{30,34}})));
  Modelica.Blocks.Continuous.FirstOrder feed_chilledWater_1st_1st(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=31.3051,
    T=8) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,70})));
  Modelica.Blocks.Sources.Ramp feed_chilledWater_1st_signal(
    duration=0,
    startTime=300,
    offset=31.3051,
    height=20) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,70})));
  Modelica.Fluid.Sources.MassFlowSource_T feed_chilledWater_1st(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=31.3051,
    T=280.1183295) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,50})));
equation
  connect(feedAnodeGas_signal.y, feedAnodeGas.m_flow_in)
    annotation (Line(points={{-59,8},{-40,8}}, color={0,0,127}));
  connect(feedAnodeGas.ports[1], hEX_interStageCooler1_ROM.tube_in)
    annotation (Line(points={{-20,0},{-8,0}}, color={0,127,255}));
  connect(hEX_interStageCooler1_ROM.shell_out, sink_chilledWater1.ports[1])
    annotation (Line(points={{0,-8},{0,-14},{0,-20}}, color={0,127,255}));
  connect(Tout_interStageCooler1.port, hEX_interStageCooler1_ROM.tube_out)
    annotation (Line(points={{20,14},{20,14},{20,10},{20,0},{8,0}}, color=
         {0,127,255}));
  connect(anodeGasSink.ports[1], hEX_interStageCooler1_ROM.tube_out)
    annotation (Line(points={{60,0},{34,0},{8,0}}, color={0,127,255}));
  connect(feed_chilledWater_1st.ports[1], hEX_interStageCooler1_ROM.shell_in)
    annotation (Line(points={{0,40},{0,24},{0,8}}, color={0,127,255}));
  connect(feed_chilledWater_1st_1st.y, feed_chilledWater_1st.m_flow_in)
    annotation (Line(points={{-19,70},{8,70},{8,60}}, color={0,0,127}));
  connect(feed_chilledWater_1st_signal.y, feed_chilledWater_1st_1st.u)
    annotation (Line(points={{-59,70},{-42,70}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=3600, Interval=1),
    __Dymola_experimentSetupOutput);
end ISC1_openLoop_test2;
