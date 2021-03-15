within NHES.Electrolysis.HTSE.Intermediate_HTSE.CathodeGasIntegration;
model NuclearHeatCathodeGasRecup_NHES
  import NHES.Electrolysis;

  extends Modelica.Icons.Example;
  //import SI = Modelica.SIunits;

  Electrolysis.HeatExchangers.HEX_nuclearHeatCathodeGasRecup_ROM_NHES
    hEX_nuclearHeatCathodeGasRecup_ROM(
    redeclare package Medium_tube =
        Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-68,-8},{-52,8}})));

  Modelica.Fluid.Sources.MassFlowSource_T steamNukeFeed_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=6.47022,
    nPorts=1,
    T=575.391)
              annotation (Placement(transformation(extent={{-128,34},{
            -108,54}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedCathodeGas(
    use_m_flow_in=true,
    m_flow=4.484668581,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    T=298.15)
    annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
  Modelica.Blocks.Sources.Ramp feedCathodeGas_signal(
    duration=0,
    offset=4.48467,
    startTime=100,
    height=-1.7456)
                   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,8})));
  Electrolysis.Sensors.TempSensorWithThermowell TNOut_cathodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    y_start=283.4 + 273.15)
    annotation (Placement(transformation(extent={{-50,22},{-30,42}})));
  Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    offset=283.4 + 273.15)
                  annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-12,80})));
  Modelica.Blocks.Math.Feedback feedback_TNout_cathodeGas annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-40,80})));
  Modelica.Blocks.Continuous.PI FBctrl_TNOut_cathodeGas(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    k=0.003,
    T=18)    annotation (Placement(transformation(extent={{-56,72},{-72,
            88}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_cathodeGas(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-116,80})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasSink_recupOnly(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=2045000,
    T=556.55)
    annotation (Placement(transformation(extent={{150,-10},{130,10}})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=4317930,
    T=497.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-30})));
  Modelica.Blocks.Nonlinear.Limiter limiter_wSteamCat_in(uMin=
        hEX_nuclearHeatCathodeGasRecup_ROM.wShell_start*0.05, uMax=
        hEX_nuclearHeatCathodeGasRecup_ROM.wShell_start*1.5) annotation (
      Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-90,80})));
equation
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.shell_in,
    steamNukeFeed_cathodeGas.ports[1]) annotation (Line(points={{-60,8},
          {-60,44},{-108,44}}, color={0,127,255}));
  connect(actuator_TNOut_cathodeGas.y, steamNukeFeed_cathodeGas.m_flow_in)
    annotation (Line(points={{-124.8,80},{-140,80},{-140,52},{-128,52}},
        color={0,0,127}));
  connect(feedback_TNout_cathodeGas.y, FBctrl_TNOut_cathodeGas.u)
    annotation (Line(points={{-49,80},{-56,80},{-54.4,80}},
                                                     color={0,0,127}));
  connect(TNOut_cathodeGas_set.y, feedback_TNout_cathodeGas.u1)
    annotation (Line(points={{-20.8,80},{-26.4,80},{-32,80}},    color=
          {0,0,127}));
  connect(feedCathodeGas_signal.y, feedCathodeGas.m_flow_in)
    annotation (Line(points={{-119,8},{-102,8}},   color={0,0,127}));
  connect(feedCathodeGas.ports[1], hEX_nuclearHeatCathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-82,0},{-68,0}},   color={0,127,255}));
  connect(TNOut_cathodeGasSensor.port,
    hEX_nuclearHeatCathodeGasRecup_ROM.tube_out) annotation (Line(
        points={{-40,22},{-40,0},{-52,0}},   color={0,127,255}));
  connect(feedback_TNout_cathodeGas.u2,TNOut_cathodeGasSensor. y)
    annotation (Line(points={{-40,72},{-40,41}}, color={0,0,127}));
  connect(cathodeGasSink_recupOnly.ports[1],
    hEX_nuclearHeatCathodeGasRecup_ROM.tube_out) annotation (Line(
        points={{130,0},{39,0},{-52,0}},    color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.shell_out,
    steamNukeSink_cathodeGas.ports[1]) annotation (Line(points={{-60,-8},
          {-60,-14},{-60,-20}},
                            color={0,127,255}));
  connect(actuator_TNOut_cathodeGas.u, limiter_wSteamCat_in.y)
    annotation (Line(points={{-106.4,80},{-102,80},{-98.8,80}},
        color={0,0,127}));
  connect(limiter_wSteamCat_in.u, FBctrl_TNOut_cathodeGas.y)
    annotation (Line(points={{-80.4,80},{-76,80},{-72.8,80}},    color=
          {0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {140,140}})),                           Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {140,140}})),
    experiment(StopTime=6100, Interval=1),
    __Dymola_experimentSetupOutput);
end NuclearHeatCathodeGasRecup_NHES;
