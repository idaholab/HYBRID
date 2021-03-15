within NHES.Electrolysis.HeatExchangers.Examples;
model ISC2_openLoop_test
  import NHES.Electrolysis;
  import NHES;

  extends Modelica.Icons.Example;

  NHES.Electrolysis.HeatExchangers.ISC_anodeGas2 hEX_interStageCooler2_ROM(
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow=23.2785,
    T=454.737,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}))
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Fluid.Sources.Boundary_pT sink_chilledWater2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=121325,
    T=298.164)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=778176.52593961,
    T=313.15)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Sources.Ramp feedAnodeGas_signal(
    duration=0,
    startTime=100,
    height=2*0,
    offset=23.2785) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,8})));
  Electrolysis.Sensors.TempSensorWithThermowell Tout_interStageCooler2(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=40 + 273.15)
    annotation (Placement(transformation(extent={{10,14},{30,34}})));
  Modelica.Fluid.Valves.ValveLinear TCV_ISC_2nd(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    m_flow_nominal=44.581,
    m_flow_start=TCV_ISC_2nd.m_flow_nominal,
    m_flow(start=TCV_ISC_2nd.m_flow_nominal),
    dp_nominal=actuator_Tout_ISC_2nd.y_start*((3.01325 - 2.01325)*1e5),
    dp_start=(3.01325 - 2.01325)*1e5)    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,40})));
  Modelica.Fluid.Sources.Boundary_pT source_chilledWater_2nd(
    use_p_in=false,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=301325,
    T=280.1183295)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_Tout_ISC_2nd(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=0.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-10,70})));
  Modelica.Blocks.Sources.Ramp TCV_ISC_2nd_signal(
    duration=0,
    offset=0.3,
    startTime=10,
    height=0.3*0.05*0)  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,70})));
equation
  connect(feedAnodeGas_signal.y, feedAnodeGas.m_flow_in)
    annotation (Line(points={{-59,8},{-40,8}}, color={0,0,127}));
  connect(feedAnodeGas.ports[1],hEX_interStageCooler2_ROM. tube_in)
    annotation (Line(points={{-20,0},{-8,0}}, color={0,127,255}));
  connect(hEX_interStageCooler2_ROM.shell_out,sink_chilledWater2. ports[1])
    annotation (Line(points={{0,-8},{0,-14},{0,-20}}, color={0,127,255}));
  connect(Tout_interStageCooler2.port,hEX_interStageCooler2_ROM. tube_out)
    annotation (Line(points={{20,14},{20,14},{20,10},{20,0},{8,0}}, color=
         {0,127,255}));
  connect(anodeGasSink.ports[1],hEX_interStageCooler2_ROM. tube_out)
    annotation (Line(points={{60,0},{34,0},{8,0}}, color={0,127,255}));
  connect(source_chilledWater_2nd.ports[1], TCV_ISC_2nd.port_a)
    annotation (Line(points={{-50,40},{-45,40},{-40,40}}, color={0,127,
          255}));
  connect(actuator_Tout_ISC_2nd.y, TCV_ISC_2nd.opening) annotation (Line(
        points={{-21,70},{-30,70},{-30,48}}, color={0,0,127}));
  connect(actuator_Tout_ISC_2nd.u, TCV_ISC_2nd_signal.y)
    annotation (Line(points={{2,70},{19,70}}, color={0,0,127}));
  connect(hEX_interStageCooler2_ROM.shell_in, TCV_ISC_2nd.port_b)
    annotation (Line(points={{0,8},{0,40},{-20,40}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=1200, Interval=1),
    __Dymola_experimentSetupOutput);
end ISC2_openLoop_test;
