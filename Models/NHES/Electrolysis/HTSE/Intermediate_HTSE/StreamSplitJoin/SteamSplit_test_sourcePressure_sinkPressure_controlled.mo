within NHES.Electrolysis.HTSE.Intermediate_HTSE.StreamSplitJoin;
model SteamSplit_test_sourcePressure_sinkPressure_controlled
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T feedCathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=4.48466,
    use_m_flow_in=true,
    T=298.15)
    annotation (Placement(transformation(extent={{-42,38},{-22,58}})));
  HeatExchangers.HEX_nuclearHeatCathodeGasRecup_ROM_NHES hEX_nuclearHeatCathodeGasRecup_ROM(
    redeclare package Medium_tube =
        Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-8,40},{8,56}})));
  Modelica.Blocks.Sources.Ramp feedCathodeGas_signal(
    startTime=100,
    offset=4.48466,
    duration=0,
    height=-1.7456*0)
                    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,56})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasSink_recupOnly(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=2045000,
    T=556.55,
    nPorts=1)
    annotation (Placement(transformation(extent={{120,38},{100,58}})));
  HeatExchangers.HEX_nuclearHeatAnodeGasRecup_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    AhShell=hEX_nuclearHeatAnodeGasRecup_ROM.AhTube*1.35)
    annotation (Placement(transformation(extent={{-8,-46},{8,-62}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
        1000}),
    m_flow=23.27935,
    T=298.15,
    nPorts=1)   annotation (Placement(transformation(extent={{-42,-64},{
            -22,-44}})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSink_recupOnly(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=2045000,
    T=556.55,
    nPorts=1)
    annotation (Placement(transformation(extent={{120,-64},{100,-44}})));
  Modelica.Blocks.Sources.Ramp steamNukeAnodeFeed_signal(
    duration=0,
    offset=23.2794,
    startTime=100,
    height=4.9795*0)
                    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,-46})));
  Modelica.Fluid.Valves.ValveLinear TCV_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    m_flow_small=0.001,
    show_T=true,
    m_flow_start=6.47973,
    m_flow_nominal=6.47973,
    dp_nominal=0.85*((58 - 44.0804)*1e5),
    dp_start=(58 - 44.0804)*1e5)
                 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,80})));
  Modelica.Fluid.Sensors.Temperature tempSteamCatOut(redeclare package Medium =
               Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-38,14},{-18,34}})));
  Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    m_flow_small=0.001,
    m_flow_nominal=2.61448,
    show_T=true,
    m_flow_start=2.61448,
    dp_nominal=0.5*((58 - 43.5)*1e5),
    dp_start=(58 - 43.5)*1e5)
                          annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,-80})));
  Modelica.Fluid.Sensors.Temperature tempSteamAnodeOut(redeclare package Medium =
               Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{20,-34},{40,-14}})));
  Modelica.Fluid.Sources.Boundary_pT steamPressureIn(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    use_p_in=false,
    p=5800000,
    T=591.15)
    annotation (Placement(transformation(extent={{-120,0},{-100,20}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal flowSplit(redeclare package Medium =
               Modelica.Media.Water.StandardWater, port_2(m_flow(start=
            9.09421)))                             annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-70,10})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal flowJoin(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,4})));
  Modelica.Blocks.Continuous.PI FBctrl_TNOut_cathodeGas(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start=0.85/FBctrl_TNOut_cathodeGas.k,
    y_start=0.85,
    y(start=0.85),
    k=0.0004,
    T=18)
    annotation (Placement(transformation(extent={{64,98},{48,114}})));
  Sensors.TempSensorWithThermowell TNOut_cathodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    y_start=283.4 + 273.15)
    annotation (Placement(transformation(extent={{70,64},{90,84}})));
  Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    offset=283.4 + 273.15)
                  annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={108,106})));
  Modelica.Blocks.Math.Feedback feedback_TNOut_cathodeGas annotation (
      Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={80,106})));
  Modelica.Blocks.Nonlinear.Limiter limiter_wSteamCat_in(uMax=1, uMin=
        0.05)                                                annotation (
      Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={28,106})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_cathodeGas(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=0.85)                                            annotation (
      Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={0,106})));
  Sensors.TempSensorWithThermowell TNOut_anodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=259 + 273.15)
    annotation (Placement(transformation(extent={{30,-64},{50,-84}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    k=1,
    T=4,
    y_start=0.5)
         annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={8,-100})));
  Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_anodeGas(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=10,
    yMax=1,
    yMin=0.05,
    gainPID(y(start=0.5)),
    y(start=0.5),
    xi_start=0.5/FBctrl_TNOut_anodeGas.k,
    y_start=0.5,
    k=0.0008,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={40,-100})));
  Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
    offset=259 + 273.15,
    startTime=100,
    height=0,
    duration=0)   annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={72,-100})));
  Machines.PumpControlledPressure pumpControlledPressure(redeclare package
      Medium = Modelica.Media.Water.StandardWater, V=1)
    annotation (Placement(transformation(extent={{60,-6},{80,14}})));
  Modelica.Fluid.Sources.Boundary_pT recyledWaterSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=6270000,
    T=488.293) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={110,4})));
equation
  connect(feedCathodeGas_signal.y, feedCathodeGas.m_flow_in) annotation (
      Line(points={{-59,56},{-59,56},{-42,56}}, color={0,0,127}));
  connect(feedCathodeGas.ports[1], hEX_nuclearHeatCathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-22,48},{-15,48},{-8,48}}, color={0,127,255}));
  connect(steamNukeAnodeFeed_signal.y, feedAnodeGas.m_flow_in)
    annotation (Line(points={{-59,-46},{-42,-46}},           color={0,0,
          127}));
  connect(TCV_cathodeGas.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-20,80},{0,80},{0,56}}, color={0,127,255}));
  connect(feedAnodeGas.ports[1], hEX_nuclearHeatAnodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-22,-54},{-22,-54},{-8,-54}}, color={0,127,
          255}));
  connect(TCV_anodeGas.port_b, hEX_nuclearHeatAnodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-20,-80},{0,-80},{0,-62}}, color={0,127,255}));
  connect(flowSplit.port_2, steamPressureIn.ports[1]) annotation (Line(
        points={{-80,10},{-80,10},{-100,10}}, color={0,127,255}));
  connect(flowSplit.port_3, TCV_cathodeGas.port_a) annotation (Line(
        points={{-70,20},{-70,34},{-78,34},{-100,34},{-100,80},{-40,80}},
        color={0,127,255}));
  connect(flowSplit.port_1, TCV_anodeGas.port_a) annotation (Line(points={{-60,10},
          {-50,10},{-50,-20},{-100,-20},{-100,-80},{-40,-80}},
        color={0,127,255}));
  connect(tempSteamAnodeOut.port, hEX_nuclearHeatAnodeGasRecup_ROM.shell_out)
    annotation (Line(points={{30,-34},{0,-34},{0,-46}}, color={0,127,255}));
  connect(flowJoin.port_3, hEX_nuclearHeatCathodeGasRecup_ROM.shell_out)
    annotation (Line(points={{30,14},{30,22},{0,22},{0,40}}, color={0,127,255}));
  connect(flowJoin.port_1, hEX_nuclearHeatAnodeGasRecup_ROM.shell_out)
    annotation (Line(points={{20,4},{0,4},{0,-46}}, color={0,127,255}));
  connect(TNOut_cathodeGasSensor.port, hEX_nuclearHeatCathodeGasRecup_ROM.tube_out)
    annotation (Line(points={{80,64},{80,64},{80,58},{80,48},{8,48}},
        color={0,127,255}));
  connect(feedback_TNOut_cathodeGas.u2, TNOut_cathodeGasSensor.y)
    annotation (Line(points={{80,99.6},{80,83}},           color={0,0,127}));
  connect(TNOut_cathodeGas_set.y, feedback_TNOut_cathodeGas.u1)
    annotation (Line(points={{99.2,106},{86.4,106}}, color={0,0,127}));
  connect(actuator_TNOut_cathodeGas.y, TCV_cathodeGas.opening)
    annotation (Line(points={{-8.8,106},{-30,106},{-30,88}}, color={0,0,
          127}));
  connect(limiter_wSteamCat_in.y, actuator_TNOut_cathodeGas.u)
    annotation (Line(points={{19.2,106},{9.6,106}}, color={0,0,127}));
  connect(cathodeGasSink_recupOnly.ports[1],
    hEX_nuclearHeatCathodeGasRecup_ROM.tube_out) annotation (Line(points=
          {{100,48},{100,48},{8,48}}, color={0,127,255}));
  connect(limiter_wSteamCat_in.u, FBctrl_TNOut_cathodeGas.y)
    annotation (Line(points={{37.6,106},{47.2,106}}, color={0,0,127}));
  connect(FBctrl_TNOut_cathodeGas.u, feedback_TNOut_cathodeGas.y)
    annotation (Line(points={{65.6,106},{72.8,106}}, color={0,0,127}));
  connect(tempSteamCatOut.port, hEX_nuclearHeatCathodeGasRecup_ROM.shell_out)
    annotation (Line(points={{-28,14},{-28,12},{0,12},{0,40}}, color={0,
          127,255}));
  connect(TNOut_anodeGasSensor.port, hEX_nuclearHeatAnodeGasRecup_ROM.tube_out)
    annotation (Line(points={{40,-64},{40,-54},{8,-54}}, color={0,127,255}));
  connect(anodeGasSink_recupOnly.ports[1],
    hEX_nuclearHeatAnodeGasRecup_ROM.tube_out) annotation (Line(points={{
          100,-54},{54,-54},{8,-54}}, color={0,127,255}));
  connect(TNOut_anodeGasSensor.y, FBctrl_TNOut_anodeGas.u_m) annotation (
      Line(points={{40,-83},{40,-83},{40,-90.4}}, color={0,0,127}));
  connect(TNOut_anodeGas_set.y, FBctrl_TNOut_anodeGas.u_s)
    annotation (Line(points={{63.2,-100},{49.6,-100}}, color={0,0,127}));
  connect(actuator_TNOut_anodeGas.u, FBctrl_TNOut_anodeGas.y)
    annotation (Line(points={{17.6,-100},{31.2,-100}}, color={0,0,127}));
  connect(actuator_TNOut_anodeGas.y, TCV_anodeGas.opening) annotation (
      Line(points={{-0.8,-100},{-10,-100},{-10,-66},{-30,-66},{-30,-72}},
        color={0,0,127}));
  connect(pumpControlledPressure.port_a, flowJoin.port_2)
    annotation (Line(points={{60,4},{60,4},{40,4}}, color={0,127,255}));
  connect(pumpControlledPressure.port_b, recyledWaterSink.ports[1])
    annotation (Line(points={{80,4},{80,4},{100,4}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -120},{120,120}})), Icon(coordinateSystem(extent={{-120,-120},
            {120,120}})));
end SteamSplit_test_sourcePressure_sinkPressure_controlled;
