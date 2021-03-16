within NHES.Electrolysis.HeatExchangers.Examples;
model HEX_nuclearHeatCathodeGasRecupVessel_withValve_ROM_NHES_closedLoop_test

  import NHES;

  import NHES.Electrolysis;

  extends Modelica.Icons.Example;

  NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatCathodeGasRecupVessel_ROM_NHES
    hEX_nuclearHeatCathodeGasRecup_ROM(
    redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
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
    startTime=100,
    offset=4.4846564335925,
    height=-0.89387)
                   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,8})));
  Electrolysis.Sensors.TempSensorWithThermowell TNOut_CathodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    y_start=TNOut_cathodeGas_set.offset)
    annotation (Placement(transformation(extent={{10,14},{30,34}})));
  Modelica.Fluid.Valves.ValveLinear TCV_cathodeGas(
    allowFlowReversal=false,
    m_flow_small=0.001,
    show_T=true,
    m_flow_start=6.46077,
    m_flow_nominal=6.46077,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow(start=6.46077),
    dp_nominal=actuator_TNOut_cathodeGas.y_start*((58 - 52.2)*1e5),
    dp_start=(58 - 52.2)*1e5)
                 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,50})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_cathodeGas(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=0.9)                                             annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-10,70})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSource_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p=5800000,
    T=591.15)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    offset=283.4 + 273.15,
    y(displayUnit="degC", unit="K"))
                  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,70})));
  Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_cathodeGas(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    Ti=159.966330063206,
    y(start=actuator_TNOut_cathodeGas.y_start),
    xi_start=actuator_TNOut_cathodeGas.y_start/FBctrl_TNOut_cathodeGas.k,
    y_start=actuator_TNOut_cathodeGas.y_start,
    gainPID(y(start=actuator_TNOut_cathodeGas.y_start)),
    k=1/252.35*1.5) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={20,70})));

equation
  connect(feedCathodeGas_signal.y, feedCathodeGas.m_flow_in)
    annotation (Line(points={{-59,8},{-40,8}},     color={0,0,127}));
  connect(feedCathodeGas.ports[1], hEX_nuclearHeatCathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-20,0},{-8,0}},    color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.shell_out,
    steamNukeSink_cathodeGas.ports[1]) annotation (Line(points={{0,-8},{0,
          -14},{0,-20}}, color={0,127,255}));
  connect(TNOut_CathodeGasSensor.port, hEX_nuclearHeatCathodeGasRecup_ROM.tube_out)
    annotation (Line(points={{20,14},{20,14},{20,10},{20,0},{8,0}},
        color={0,127,255}));
  connect(actuator_TNOut_cathodeGas.y, TCV_cathodeGas.opening)
    annotation (Line(points={{-21,70},{-30,70},{-30,58}}, color={0,0,127}));
  connect(steamNukeSource_cathodeGas.ports[1], TCV_cathodeGas.port_a)
    annotation (Line(points={{-60,50},{-60,50},{-40,50}}, color={0,127,
          255}));
  connect(TCV_cathodeGas.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-20,50},{0,50},{0,8}}, color={0,127,255}));
  connect(actuator_TNOut_cathodeGas.u, FBctrl_TNOut_cathodeGas.y)
    annotation (Line(points={{2,70},{9,70}}, color={0,0,127}));
  connect(FBctrl_TNOut_cathodeGas.u_s, TNOut_cathodeGas_set.y)
    annotation (Line(points={{32,70},{39,70}}, color={0,0,127}));
  connect(TNOut_CathodeGasSensor.y, FBctrl_TNOut_cathodeGas.u_m)
    annotation (Line(points={{20,33},{20,33},{20,58}},   color={0,0,127}));
  connect(cathodeGasSink_recuponly.ports[1],
    hEX_nuclearHeatCathodeGasRecup_ROM.tube_out)
    annotation (Line(points={{60,0},{34,0},{8,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=3600, Interval=1),
    __Dymola_experimentSetupOutput);
end HEX_nuclearHeatCathodeGasRecupVessel_withValve_ROM_NHES_closedLoop_test;
