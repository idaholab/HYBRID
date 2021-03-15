within NHES.Electrolysis.HTSE.Intermediate_HTSE.AnodeGasIntegration;
model NuclearHeatAnodeGasRecup_anodeGasRecup_NHES
  import NHES.Electrolysis;

  extends Modelica.Icons.Example;
  //import SI = Modelica.SIunits;

  Electrolysis.HeatExchangers.HEX_nuclearHeatAnodeGasRecup_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-68,-8},{-52,8}})));

  Modelica.Fluid.Sources.MassFlowSource_T steamNukeFeed_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=2.80069,
    use_m_flow_in=true,
    T=574.698)
              annotation (Placement(transformation(extent={{-118,30},{
            -98,50}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
        1000}),
    m_flow=23.27935,
    T=298.15)   annotation (Placement(transformation(extent={{-102,-10},
            {-82,10}})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=4313200,
    T=497.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-30})));
  Modelica.Blocks.Sources.Ramp feedAnodeGas_signal(
    duration=0,
    startTime=100,
    offset=23.27935,
    height=4.4514 - 4.4514)
                     annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,8})));
  Electrolysis.Sensors.TempSensorWithThermowell TNOut_anodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=259 + 273.15)
    annotation (Placement(transformation(extent={{-42,14},{-22,34}})));
  Electrolysis.HeatExchangers.HEX_anodeGasRecup_ROM_NHES
    hEX_anodeGasRecup_ROM(
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    redeclare package Medium_shell =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
  Modelica.Fluid.Sources.Boundary_pT wAnodeTubeSink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=2004000,
    T=1007.642)
    annotation (Placement(transformation(extent={{140,-10},{120,10}})));
  Modelica.Fluid.Sources.Boundary_pT wAnodeShellSink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=1923000,
    T=605.838) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Fluid.Sources.MassFlowSource_T wAnodeShellFeed(
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=Electrolysis.Utilities.moleToMassFractions({0.70322,0.29678}, {
        Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,
        Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    nPorts=1,
    m_flow=26.4656,
    T=1022.642)
    annotation (Placement(transformation(extent={{30,30},{10,50}})));
  Modelica.Blocks.Sources.Ramp wAnodeShellFeed_signal(
    duration=20,
    startTime=500,
    offset=26.4656,
    height=3.84585 - 3.84585)
                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={60,48})));
  Electrolysis.Sensors.TempSensorWithThermowell TAtopping_in(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=734.492 + 273.15)
    annotation (Placement(transformation(extent={{28,14},{48,34}})));
  Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    offset=259 + 273.15)
                  annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-4,92})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    k=1,
    T=4) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-110,92})));
  Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_anodeGas(
    yMax=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start*3,
    yMin=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start*0.1,
    y_start=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.004,
    Ti=10,
    y(start=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start),
    xi_start=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start/
        FBctrl_TNOut_anodeGas.k,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    gainPID(y(start=2.80069))) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-32,92})));
equation
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_out,
    steamNukeSink_anodeGas.ports[1]) annotation (Line(points={{-60,-8},
          {-60,-14},{-60,-20}}, color={0,127,255}));
  connect(feedAnodeGas.ports[1], hEX_nuclearHeatAnodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-82,0},{-75,0},{-68,0}}, color={0,127,255}));
  connect(feedAnodeGas_signal.y, feedAnodeGas.m_flow_in)
    annotation (Line(points={{-119,8},{-102,8}}, color={0,0,127}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_in,
    steamNukeFeed_anodeGas.ports[1]) annotation (Line(points={{-60,8},{
          -60,40},{-98,40}},  color={0,127,255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out,
    hEX_anodeGasRecup_ROM.tube_in) annotation (Line(points={{-52,0},{
          -24,0},{-8,0}}, color={0,127,255}));
  connect(TNOut_anodeGasSensor.port, hEX_nuclearHeatAnodeGasRecup_ROM.tube_out)
    annotation (Line(points={{-32,14},{-32,0},{-52,0}}, color={0,127,
          255}));
  connect(hEX_anodeGasRecup_ROM.tube_out, wAnodeTubeSink.ports[1])
    annotation (Line(points={{8,0},{120,0}}, color={0,127,255}));
  connect(hEX_anodeGasRecup_ROM.shell_out, wAnodeShellSink.ports[1])
    annotation (Line(points={{0,-8},{0,-14},{0,-20}}, color={0,127,255}));
  connect(wAnodeShellFeed.m_flow_in, wAnodeShellFeed_signal.y)
    annotation (Line(points={{30,48},{49,48}}, color={0,0,127}));
  connect(hEX_anodeGasRecup_ROM.shell_in, wAnodeShellFeed.ports[1])
    annotation (Line(points={{0,8},{0,40},{10,40}}, color={0,127,255}));
  connect(hEX_anodeGasRecup_ROM.tube_out, TAtopping_in.port)
    annotation (Line(points={{8,0},{38,0},{38,14}}, color={0,127,255}));
  connect(TNOut_anodeGas_set.y, FBctrl_TNOut_anodeGas.u_s)
    annotation (Line(points={{-12.8,92},{-22.4,92}}, color={0,0,127}));
  connect(actuator_TNOut_anodeGas.u, FBctrl_TNOut_anodeGas.y)
    annotation (Line(points={{-100.4,92},{-40.8,92}}, color={0,0,127}));
  connect(TNOut_anodeGasSensor.y, FBctrl_TNOut_anodeGas.u_m)
    annotation (Line(points={{-32,33},{-32,82.4}}, color={0,0,127}));
  connect(actuator_TNOut_anodeGas.y, steamNukeFeed_anodeGas.m_flow_in)
    annotation (Line(points={{-118.8,92},{-132,92},{-132,48},{-118,48}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {140,140}})),                           Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {140,140}})));
end NuclearHeatAnodeGasRecup_anodeGasRecup_NHES;
