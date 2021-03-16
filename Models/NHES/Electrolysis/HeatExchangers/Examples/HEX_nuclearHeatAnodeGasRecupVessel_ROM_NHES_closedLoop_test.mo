within NHES.Electrolysis.HeatExchangers.Examples;
model HEX_nuclearHeatAnodeGasRecupVessel_ROM_NHES_closedLoop_test
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
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    m_flow=4.484668581,
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    T=461.928)
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
    offset=23.2785,
    height=2) annotation (Placement(transformation(
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
  Modelica.Fluid.Sources.Boundary_pT steamNukeSource_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p=5800000,
    T=591.15)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
    allowFlowReversal=false,
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=TCV_anodeGas.m_flow_nominal,
    m_flow(start=TCV_anodeGas.m_flow_nominal),
    m_flow_nominal=0.850426,
    dp_nominal=0.4*((58 - 51.4542)*1e5),
    dp_start=(58 - 51.4542)*1e5)         annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,50})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=0.4) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-10,70})));
  Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_anodeGas(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y(start=actuator_TNOut_anodeGas.y_start),
    xi_start=actuator_TNOut_anodeGas.y_start/FBctrl_TNOut_anodeGas.k,
    y_start=actuator_TNOut_anodeGas.y_start,
    gainPID(y(start=actuator_TNOut_anodeGas.y_start)),
    k=(1/120.25)*1.5,
    Ti=75.9592150676623) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={20,70})));
  Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    y(displayUnit="degC", unit="K"),
    offset=259 + 273.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,70})));
equation
  connect(feedAnodeGas_signal.y, feedAnodeGas.m_flow_in)
    annotation (Line(points={{-59,8},{-40,8}}, color={0,0,127}));
  connect(feedAnodeGas.ports[1], hEX_nuclearHeatAnodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-20,0},{-8,0}}, color={0,127,255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_out,
    steamNukeSink_anodeGas.ports[1]) annotation (Line(points={{0,-8},{0,-14},
          {0,-20}}, color={0,127,255}));
  connect(TNOut_AnodeGasSensor.port, hEX_nuclearHeatAnodeGasRecup_ROM.tube_out)
    annotation (Line(points={{20,14},{20,14},{20,10},{20,0},{8,0}}, color=
         {0,127,255}));
  connect(TCV_anodeGas.port_a, steamNukeSource_anodeGas.ports[1])
    annotation (Line(points={{-40,50},{-50,50},{-60,50}}, color={0,127,
          255}));
  connect(TCV_anodeGas.opening, actuator_TNOut_anodeGas.y) annotation (
      Line(points={{-30,58},{-30,70},{-21,70}}, color={0,0,127}));
  connect(TCV_anodeGas.port_b, hEX_nuclearHeatAnodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-20,50},{0,50},{0,8}}, color={0,127,255}));
  connect(anodeGasSink_recuponly.ports[1],
    hEX_nuclearHeatAnodeGasRecup_ROM.tube_out)
    annotation (Line(points={{60,0},{34,0},{8,0}}, color={0,127,255}));
  connect(FBctrl_TNOut_anodeGas.y, actuator_TNOut_anodeGas.u)
    annotation (Line(points={{9,70},{5.5,70},{2,70}}, color={0,0,127}));
  connect(TNOut_anodeGas_set.y, FBctrl_TNOut_anodeGas.u_s) annotation (
      Line(points={{39,70},{35.5,70},{32,70}}, color={0,0,127}));
  connect(TNOut_AnodeGasSensor.y, FBctrl_TNOut_anodeGas.u_m)
    annotation (Line(points={{20,33},{20,58}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=1000, Interval=1),
    __Dymola_experimentSetupOutput);
end HEX_nuclearHeatAnodeGasRecupVessel_ROM_NHES_closedLoop_test;
