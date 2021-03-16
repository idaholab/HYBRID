within NHES.Electrolysis.HTSE.Examples;
model HTSEplant_NHES_pressureSources
  extends Modelica.Icons.Example;
  import      Modelica.Units.SI;

  SI.MassFlowRate mH2_sec "H2 produced during electrolysis per second";
  Electrolysis.Types.AnnualMassFlowRate mH2_yr
    "H2 produced during electrolysis per year";
  SI.MassFlowRate mO2_sec "O2 produced during electrolysis per second";
  Electrolysis.Types.AnnualMassFlowRate mO2_yr
    "O2 produced during electrolysis per year";

  HeatExchangers.HEX_nuclearHeatCathodeGasRecup_ROM_NHES
    hEX_nuclearHeatCathodeGasRecup_ROM(
    redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-78,46},{-62,62}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedCathodeGas(
    use_m_flow_in=true,
    m_flow=4.484668581,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    T=298.15)
    annotation (Placement(transformation(extent={{-112,44},{-92,64}})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=4317930,
    T=497.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,22})));
  Sensors.TempSensorWithThermowell TNOut_cathodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    y_start=283.4 + 273.15)
    annotation (Placement(transformation(extent={{-54,72},{-34,92}})));
  Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    offset=283.4 + 273.15)
                  annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-20,120})));
  Fittings.CascadeCtrlIdeal_yH2 cascadeCtrl_yH2(
    redeclare package MixtureGas =
        Electrolysis.Media.Electrolysis.CathodeGas,
    redeclare package Steam = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    yH2_setPoint=0.1,
    V=0.125,
    initType_FBctrl_yH2=Modelica.Blocks.Types.Init.SteadyState,
    TSteam_start=556.55)
    annotation (Placement(transformation(extent={{-36,60},{-12,36}})));
  Modelica.Fluid.Sources.MassFlowSource_T H2Recycled(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    X={1,0},
    m_flow=0.055756419,
    use_m_flow_in=true,
    T=556.55,
    nPorts=1) annotation (Placement(transformation(extent={{-24,2},{-44,
            22}})));

  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_cathodeGas(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=0.85)                                            annotation (
      Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-122,120})));
  HeatExchangers.HEX_cathodeGasRecup_ROM hEX_cathodeGasRecup_ROM(
      redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.CathodeGas, redeclare package
      Medium_shell = Electrolysis.Media.Electrolysis.CathodeGas,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    shell_in(p(start=controlledSOEC.SOECstack.pstartCathodeAvg)))
    annotation (Placement(transformation(extent={{18,40},{34,56}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasShellSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    p=1960350,
    T=618.331,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={26,18})));

  Modelica.Blocks.Sources.Ramp power_set(
    offset=9.10627*1e6*5,
    duration=0,
    startTime=100,
    height=-1.929*1e6*5*2)
    annotation (Placement(transformation(extent={{24,102},{40,118}})));
  Electrolyzers.ControlledSOEC_integratedWithHTSEplant controlledSOEC(
    numVessels=5,
    numCells_perVessel=68320,
    initOpt=Electrolysis.Utilities.OptionsInit.userSpecified,
    initType_wAnode_in=Modelica.Blocks.Types.Init.InitialOutput,
    FBctrl_SUfactor_k=0.03,
    FBctrl_SUfactor_T=18,
    FBctrl_TC_out_k=0.012,
    FBctrl_TC_out_T=16,
    FBctrl_SUfactor(x(start=controlledSOEC.wCathode_in_start/
            controlledSOEC.FBctrl_SUfactor.k, fixed=true)),
    FBctrl_TC_out(y(start=controlledSOEC.wAnode_in_start)),
    initType_wCathode_in=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{116,-16},{150,18}})));
  ElectricHeaters.ToppingHeater_cathodeGas toppingHeater_cathodeGas(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    isCircular=true,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    TC_set(displayUnit="degC") = 1123.15)
    annotation (Placement(transformation(extent={{60,40},{76,56}})));

  Sensors.TempSensorWithThermowell TCtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    y_start=850 + 273.15,
    tau=13) annotation (Placement(transformation(extent={{82,56},{102,76}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_wH2_in(
    k=1,
    y_start=0.055756419,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=8)                                             annotation (
      Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-8,20})));
  HeatExchangers.HEX_nuclearHeatAnodeGasRecup_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    AhShell=hEX_nuclearHeatAnodeGasRecup_ROM.AhTube*1.35)
    annotation (Placement(transformation(extent={{-78,-44},{-62,-60}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
        1000}),
    m_flow=23.27935,
    T=298.15)   annotation (Placement(transformation(extent={{-112,-62},{-92,-42}})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=4317930,
    T=497.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-70,-20})));
  Sensors.TempSensorWithThermowell TNOut_anodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=259 + 273.15)
    annotation (Placement(transformation(extent={{-58,-66},{-38,-86}})));
  Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
    offset=259 + 273.15,
    startTime=100,
    height=0,
    duration=0)   annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-12,-110})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    k=1,
    T=4,
    y_start=0.5)
         annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-82,-110})));
  HeatExchangers.HEX_anodeGasRecup_ROM_NHES
    hEX_anodeGasRecup_ROM(
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    redeclare package Medium_shell =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{18,-44},{34,-60}})));
  Modelica.Fluid.Sources.Boundary_pT wAnodeShellSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=1923000,
    T=605.838) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={26,-20})));
  ElectricHeaters.ToppingHeater_anodeGas toppingHeater_anodeGas(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    isCircular=true,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    TA_set=1123.15)
    annotation (Placement(transformation(extent={{60,-44},{76,-60}})));
  Sensors.TempSensorWithThermowell TAtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=850 + 273.15,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    tau=13) annotation (Placement(transformation(extent={{82,-60},{102,-80}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_wAnode_in(
    k=1,
    y_start=controlledSOEC.FBctrl_TC_out.y_start,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=8)  annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={12,-130})));
  Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_anodeGas(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0.05,
    gainPID(y(start=0.5)),
    y(start=0.5),
    xi_start=0.5/FBctrl_TNOut_anodeGas.k,
    y_start=0.5,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    k=0.0008*0 + (1/223.36)*5,
    Ti=10*0 + 47.1571789477849) annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={-48,-110})));
  Sources.PrescribedPowerFlow prescribedPowerFlow
    annotation (Placement(transformation(extent={{60,100},{80,120}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_wCathode_in(
    k=1,
    y_start=controlledSOEC.FBctrl_SUfactor.y_start,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=36)                                              annotation (
      Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={12,140})));
  Modelica.Blocks.Nonlinear.Limiter limiter_wSteamCat_in(uMax=1, uMin=
        0.05)                                                annotation (
      Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-94,120})));
  Modelica.Blocks.Continuous.PI FBctrl_TNOut_cathodeGas(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start=0.85/FBctrl_TNOut_cathodeGas.k,
    y_start=0.85,
    y(start=0.85),
    k=0.0004*0 + 1/252.35*1.5,
    T=18*0 + 159.966330063206)
    annotation (Placement(transformation(extent={{-60,112},{-76,128}})));
  Modelica.Blocks.Math.Feedback feedback_TNOut_cathodeGas annotation (
      Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-44,120})));
  Modelica.Fluid.Valves.ValveLinear TCV_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    m_flow_small=0.001,
    show_T=true,
    m_flow_start=6.47973,
    m_flow_nominal=6.47973,
    dp_nominal=0.85*((58 - 44.0804)*1e5),
    m_flow(start=6.47973),
    dp_start=(58 - 44.0804)*1e5)
                 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-102,86})));
  Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    allowFlowReversal=false,
    m_flow_small=0.001,
    m_flow_nominal=2.61448,
    show_T=true,
    m_flow_start=2.61448,
    dp_nominal=0.5*((58 - 43.5)*1e5),
    m_flow(start=2.61448),
    dp_start=(58 - 43.5)*1e5)
                          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-102,-78})));
  Modelica.Fluid.Sources.Boundary_pT steamPressureIn_cathodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    use_p_in=false,
    p=5800000,
    T=591.15)
    annotation (Placement(transformation(extent={{-182,76},{-162,96}})));
  Modelica.Fluid.Sources.Boundary_pT steamPressureIn_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    use_p_in=false,
    p=5800000,
    T=591.15) annotation (Placement(transformation(extent={{-182,-88},{
            -162,-68}})));
equation

  mH2_sec = hEX_cathodeGasRecup_ROM.wShell_out*hEX_cathodeGasRecup_ROM.XShell_out[1] - cascadeCtrl_yH2.mixtureGas_port_1.m_flow;
  mH2_yr =  mH2_sec*60*60*24*365;
  mO2_sec = controlledSOEC.SOECstack.deltaM_O2*controlledSOEC.numVessels;
  mO2_yr = mO2_sec*60*60*24*365;

  connect(toppingHeater_cathodeGas.port_a, hEX_cathodeGasRecup_ROM.tube_out)
    annotation (Line(points={{60,48},{60,48},{34,48}}, color={0,127,255}));
  connect(cascadeCtrl_yH2.mixtureGas_port_1, H2Recycled.ports[1])
    annotation (Line(points={{-33.6,42},{-50,42},{-50,12},{-44,12}},
        color={0,127,255}));
  connect(controlledSOEC.ctrlCathodeOut, hEX_cathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{145.58,9.5},{152,9.5},{152,90},{26,90},{26,
          56}}, color={0,127,255}));
  connect(cascadeCtrl_yH2.c_yH2, actuator_wH2_in.u) annotation (Line(
        points={{-19.2,44.64},{-19.2,38},{6,38},{6,20},{1.6,20}}, color={
          0,0,127}));
  connect(toppingHeater_cathodeGas.s_TC_in, TCtopping_out.y) annotation (Line(
        points={{68,56.8},{68,82},{92,82},{92,75}}, color={0,0,127}));
  connect(toppingHeater_cathodeGas.port_b, controlledSOEC.ctrlCathodeIn)
    annotation (Line(points={{76,48},{112,48},{112,6.1},{120.42,6.1}}, color={0,
          127,255}));
  connect(TCtopping_out.port, controlledSOEC.ctrlCathodeIn) annotation (Line(
        points={{92,56},{92,48},{112,48},{112,6.1},{120.42,6.1}}, color={0,127,
          255}));
  connect(hEX_cathodeGasRecup_ROM.shell_out, cathodeGasShellSink.ports[1])
    annotation (Line(points={{26,40},{26,28}},         color={0,127,255}));
  connect(cascadeCtrl_yH2.mixtureGas_port_3, hEX_cathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-14.4,48},{18,48}}, color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.tube_out, cascadeCtrl_yH2.steam_port_2)
    annotation (Line(points={{-62,54},{-33.6,54}}, color={0,127,255}));
  connect(TNOut_cathodeGasSensor.port, cascadeCtrl_yH2.steam_port_2)
    annotation (Line(points={{-44,72},{-44,54},{-33.6,54}}, color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.shell_out,
    steamNukeSink_cathodeGas.ports[1]) annotation (Line(points={{-70,46},{-70,32}},
                         color={0,127,255}));
  connect(feedCathodeGas.ports[1], hEX_nuclearHeatCathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-92,54},{-92,54},{-78,54}},
                                                 color={0,127,255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_out,steamNukeSink_anodeGas.
                           ports[1]) annotation (Line(points={{-70,-44},{
          -70,-30}},            color={0,127,255}));
  connect(feedAnodeGas.ports[1],hEX_nuclearHeatAnodeGasRecup_ROM. tube_in)
    annotation (Line(points={{-92,-52},{-85,-52},{-78,-52}},
                                                       color={0,127,255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out,hEX_anodeGasRecup_ROM.
                          tube_in) annotation (Line(points={{-62,-52},{-28,-52},
          {18,-52}},      color={0,127,255}));
  connect(hEX_anodeGasRecup_ROM.tube_out, toppingHeater_anodeGas.port_a)
    annotation (Line(points={{34,-52},{34,-52},{60,-52}}, color={0,127,255}));
  connect(TAtopping_out.y, toppingHeater_anodeGas.s_TA_in) annotation (Line(
        points={{92,-79},{92,-84},{68,-84},{68,-60.8}}, color={0,0,127}));
  connect(wAnodeShellSink.ports[1], hEX_anodeGasRecup_ROM.shell_out)
    annotation (Line(points={{26,-30},{26,-44}}, color={0,127,255}));
  connect(TNOut_anodeGasSensor.port, hEX_anodeGasRecup_ROM.tube_in) annotation (
     Line(points={{-48,-66},{-48,-52},{18,-52}}, color={0,127,255}));
  connect(toppingHeater_anodeGas.port_b, controlledSOEC.ctrlAnodeIn)
    annotation (Line(points={{76,-52},{76,-52},{112,-52},{112,-8.18},{120.42,-8.18}},
        color={0,127,255}));
  connect(TAtopping_out.port, controlledSOEC.ctrlAnodeIn) annotation (Line(
        points={{92,-60},{92,-52},{112,-52},{112,-8.18},{120.42,-8.18}}, color={
          0,127,255}));
  connect(controlledSOEC.ctrlAnodeOut, hEX_anodeGasRecup_ROM.shell_in)
    annotation (Line(points={{145.58,-4.78},{152,-4.78},{152,-90},{26,-90},
          {26,-60}}, color={0,127,255}));
  connect(actuator_wH2_in.y, H2Recycled.m_flow_in)
    annotation (Line(points={{-16.8,20},{-24,20}}, color={0,0,127}));
  connect(controlledSOEC.c_wAnodeIn, actuator_wAnode_in.u) annotation (
      Line(points={{131.64,-11.58},{131.64,-130},{21.6,-130}}, color={0,0,
          127}));
  connect(actuator_wAnode_in.y, feedAnodeGas.m_flow_in) annotation (Line(
        points={{3.2,-130},{-150,-130},{-150,-44},{-112,-44}},  color={0,
          0,127}));
  connect(actuator_TNOut_anodeGas.u, FBctrl_TNOut_anodeGas.y) annotation (
     Line(points={{-72.4,-110},{-56.8,-110}}, color={0,0,127}));
  connect(power_set.y, prescribedPowerFlow.P_flow) annotation (Line(
        points={{40.8,110},{52,110},{62,110}},
                                             color={0,0,127}));
  connect(prescribedPowerFlow.port_b, controlledSOEC.ctrlElectricalLoad)
    annotation (Line(points={{80,110},{106,110},{106,-0.7},{120.08,-0.7}},
        color={255,0,0}));
  connect(controlledSOEC.c_wCathode, actuator_wCathode_in.u) annotation (
      Line(points={{133,11.2},{133,140},{21.6,140}}, color={0,0,127}));
  connect(actuator_wCathode_in.y, feedCathodeGas.m_flow_in) annotation (
      Line(points={{3.2,140},{-150,140},{-150,62},{-112,62}}, color={0,0,
          127}));
  connect(actuator_TNOut_cathodeGas.u, limiter_wSteamCat_in.y)
    annotation (Line(points={{-112.4,120},{-102.8,120}}, color={0,0,127}));
  connect(FBctrl_TNOut_cathodeGas.y, limiter_wSteamCat_in.u)
    annotation (Line(points={{-76.8,120},{-84.4,120}}, color={0,0,127}));
  connect(FBctrl_TNOut_cathodeGas.u, feedback_TNOut_cathodeGas.y)
    annotation (Line(points={{-58.4,120},{-51.2,120}}, color={0,0,127}));
  connect(TNOut_cathodeGas_set.y, feedback_TNOut_cathodeGas.u1)
    annotation (Line(points={{-28.8,120},{-37.6,120}}, color={0,0,127}));
  connect(feedback_TNOut_cathodeGas.u2, TNOut_cathodeGasSensor.y)
    annotation (Line(points={{-44,113.6},{-44,91}}, color={0,0,127}));
  connect(FBctrl_TNOut_anodeGas.u_m, TNOut_anodeGasSensor.y)
    annotation (Line(points={{-48,-100.4},{-48,-85}}, color={0,0,127}));
  connect(FBctrl_TNOut_anodeGas.u_s, TNOut_anodeGas_set.y) annotation (
      Line(points={{-38.4,-110},{-20.8,-110}}, color={0,0,127}));
  connect(TCV_cathodeGas.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-92,86},{-70,86},{-70,62}}, color={0,127,
          255}));
  connect(actuator_TNOut_cathodeGas.y, TCV_cathodeGas.opening)
    annotation (Line(points={{-130.8,120},{-138,120},{-138,100},{-102,100},
          {-102,94}}, color={0,0,127}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_in, TCV_anodeGas.port_b)
    annotation (Line(points={{-70,-60},{-70,-78},{-92,-78}}, color={0,127,
          255}));
  connect(actuator_TNOut_anodeGas.y, TCV_anodeGas.opening) annotation (
      Line(points={{-90.8,-110},{-102,-110},{-102,-86}}, color={0,0,127}));
  connect(TCV_cathodeGas.port_a, steamPressureIn_cathodeGas.ports[1])
    annotation (Line(points={{-112,86},{-137,86},{-162,86}}, color={0,127,
          255}));
  connect(TCV_anodeGas.port_a, steamPressureIn_anodeGas.ports[1])
    annotation (Line(points={{-112,-78},{-162,-78}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-160},{160,160}},
          preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-160,-160},{160,160}})),
    experiment(StopTime=8100, Interval=1),
    __Dymola_experimentSetupOutput);
end HTSEplant_NHES_pressureSources;
