within NHES.Electrolysis.HTSE;
model HTSEplant_FY17
  import NHES;
  extends NHES.Electrolysis.HTSE.BaseClasses.Partial_IP_vessel;

  parameter Integer numCells_perVessel=68320 "Total number of cells per vessel";
  parameter Integer numVessels=5 "Number of online vessels per system";
  final parameter Real eta_powerCycle(min=0, max=1, unit="1") = 0.318 "Power cycle efficiency";

  SI.MassFlowRate mH2_sec "H2 produced during electrolysis per second";
  NHES.Electrolysis.Types.AnnualMassFlowRate mH2_yr
    "H2 produced during electrolysis per year";
  SI.MassFlowRate mO2_sec "O2 produced during electrolysis per second";
  NHES.Electrolysis.Types.AnnualMassFlowRate mO2_yr
    "O2 produced during electrolysis per year";

  SI.Power Q_nuclearHeatCathodeRecup "Nuclear heat transferred from the hot utility to cathode stream";
  SI.Power Q_nuclearHeatAnodeRecup "Nuclear heat transferred from the hot utility to anode stream";
  SI.Power Q_nuclearHeatRecup "Total nuclear heat transferred from the hot utility to the cathode and anode streams";
  SI.Power Wq_nuclearHeatRecup "Electrical power equivalent to 'Q_nuclearHeatRecup' with 'eta_powerCycle'";
  SI.Power W_total "Total energy consumption in the HTSE plant";

  Real We_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of electrical energy consumption in the HTSE plant";
  Real Wq_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of thermal energy consumption in the HTSE plant";

  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=
        298.15)
    annotation (Placement(transformation(extent={{180,160},{200,180}})));

  Modelica.Blocks.Continuous.FirstOrder actuator_wAnode_in(
    k=1,
    T=4,
    y_start=HTSEvessel.controlledSOEC.anodeFCV_valveOpening_start,
    initType=Modelica.Blocks.Types.Init.SteadyState)
          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={86,-96})));
  Modelica.Fluid.Sources.Boundary_pT source_cathodeStream(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="bar") = system.p_ambient,
    T=system.T_ambient,
    nPorts=1)
    annotation (Placement(transformation(extent={{-132,76},{-112,96}})));

  Modelica.Fluid.Valves.ValveLinear FCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=HTSEvessel.controlledSOEC.wCathode_in_start,
    dp_nominal=HTSEvessel.controlledSOEC.cathodeFCV_valveOpening_start*((
        22.72222 - 20.45)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wCathode_in_start,
    m_flow(start=HTSEvessel.controlledSOEC.wCathode_in_start, fixed=true),
    dp_start=((22.72222 - 20.45)*1e5))
                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={60,80})));

  Modelica.Blocks.Continuous.FirstOrder actuator_wCathode_in(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.cathodeFCV_valveOpening_start)
                                                       annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={86,104})));
  Modelica.Fluid.Sources.Boundary_pT source_anodeStream(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=NHES.Electrolysis.Utilities.moleToMassFractions(
                                                 {0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    p(displayUnit="bar") = 101325,
    nPorts=1,
    T=288.15) annotation (Placement(transformation(extent={{-132,-82},{
            -112,-62}})));

  Modelica.Fluid.Valves.ValveLinear FCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=HTSEvessel.controlledSOEC.wAnode_in_start,
    dp_nominal=HTSEvessel.controlledSOEC.anodeFCV_valveOpening_start*((
        22.72222 - 20.45)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wAnode_in_start,
    m_flow(start=HTSEvessel.controlledSOEC.wAnode_in_start),
    dp_start=((22.72222 - 20.45)*1e5))    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={60,-72})));

  Modelica.Blocks.Continuous.FirstOrder actuator_pAnSOEC(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.anodePCV_valveOpening_start)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,-42})));
  Modelica.Blocks.Continuous.FirstOrder actuator_pCatSOEC(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.cathodePCV_valveOpening_start)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,42})));
  Modelica.Fluid.Valves.ValveLinear PCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=HTSEvessel.controlledSOEC.wAnode_out_start,
    m_flow(start=HTSEvessel.controlledSOEC.wAnode_out_start),
    dp_nominal=HTSEvessel.controlledSOEC.anodePCV_valveOpening_start*((
        19.23 - 17.307)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wAnode_out_start,
    dp_start=((19.23 - 17.307)*1e5))       annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={60,-18})));
  Modelica.Fluid.Valves.ValveLinear PCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=HTSEvessel.controlledSOEC.wCathode_out_start,
    m_flow(start=HTSEvessel.controlledSOEC.wCathode_out_start),
    dp_nominal=HTSEvessel.controlledSOEC.cathodePCV_valveOpening_start*((
        19.6035 - 17.64315)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wCathode_out_start,
    dp_start=((19.6035 - 17.64315)*1e5))
                           annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={60,20})));

  NHES.Electrolysis.HTSE.HTSEvessel HTSEvessel(numCells_perVessel=
        numCells_perVessel, numVessels=numVessels)
    annotation (Placement(transformation(extent={{102,-12},{122,8}})));
  NHES.Electrolysis.Fittings.CascadeCtrlIdealVessel_yH2 cascadeCtrl_yH2(
    redeclare package MixtureGas =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    redeclare package Steam = Modelica.Media.Water.StandardWater,
    yH2_setPoint=0.1,
    V=0.125,
    initType_FBctrl_yH2=Modelica.Blocks.Types.Init.SteadyState,
    wH2_start=0.0557585664075,
    pSteam_start=2272222,
    TSteam_start=556.55)
    annotation (Placement(transformation(extent={{-2,92},{22,68}})));
  NHES.Electrolysis.Separator.Temp_flashDrumVessel flashDrum(redeclare package
      Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,20})));
  Modelica.Fluid.Sources.Boundary_pT H2O_sink(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1764315,
    T=618.329) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,4})));
  Modelica.Fluid.Sources.Boundary_pT H2_sink(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1764315,
    T=618.329) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-20,44})));
  NHES.Electrolysis.Fittings.IdealRecycleVessel_H2 idealRecycle_H2(
      redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-2,38},{22,62}})));
  NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatCathodeGasRecupVessel_ROM_NHES
    hEX_nuclearHeatCathodeGasRecup_ROM(
    redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell = Medium,
    initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit,
    hTube_out(start=2.98385e6))
    annotation (Placement(transformation(extent={{-60,76},{-40,96}})));

  NHES.Electrolysis.Sensors.TempSensorWithThermowell TNOut_cathodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    y_start=TNOut_cathodeGas_set.offset)
    annotation (Placement(transformation(extent={{-30,100},{-10,120}})));
  Modelica.Fluid.Valves.ValveLinear TCV_cathodeGas(
    m_flow_small=0.001,
    show_T=true,
    m_flow_nominal=6.46077,
    redeclare package Medium = Medium,
    dp_nominal=actuator_TNOut_cathodeGas.y_start*((58 - 52.2)*1e5),
    m_flow_start=TCV_cathodeGas.m_flow_nominal,
    dp_start=(58 - 52.2)*1e5,
    m_flow(start=TCV_cathodeGas.m_flow_nominal, fixed=true))
                 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,120})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_cathodeGas(
    k=1,
    T=4,
    y_start=0.9,
    initType=Modelica.Blocks.Types.Init.SteadyState)         annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-60,144})));
  Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_cathodeGas(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    Ti=159.966330063206,
    gainPID(y(start=actuator_TNOut_cathodeGas.y_start)),
    y(start=actuator_TNOut_cathodeGas.y_start),
    xi_start=actuator_TNOut_cathodeGas.y_start/FBctrl_TNOut_cathodeGas.k,
    y_start=actuator_TNOut_cathodeGas.y_start,
    k=1/252.35*1.5,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-20,144})));

  Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    offset=283.4 + 273.15,
    y(displayUnit="degC", unit="K"))
                  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={20,144})));
  NHES.Electrolysis.Machines.PumpControlledPressureVessel_elecPort
    feedPump(V=1, redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-100,76},{-80,96}})));
  NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatAnodeGasRecupVessel_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_shell = Medium,
    redeclare package Medium_tube =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    initOpt=NHES.Electrolysis.Utilities.OptionsInit.noInit,
    TTube_out(start=532.15)) annotation (Placement(transformation(
          extent={{-30,-62},{-10,-82}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=0.4) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-30,-140})));
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
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={10,-140})));
  Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    y(displayUnit="degC", unit="K"),
    offset=259 + 273.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,-140})));
  Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
    m_flow_small=0.001,
    show_T=true,
    m_flow_start=TCV_anodeGas.m_flow_nominal,
    redeclare package Medium = Medium,
    dp_nominal=actuator_TNOut_anodeGas.y_start*((58 - 51.4542)*1e5),
    m_flow_nominal=0.850426,
    dp_start=(58 - 51.4542)*1e5,
    m_flow(start=TCV_anodeGas.m_flow_nominal, fixed=true))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,-120})));
  NHES.Electrolysis.Sensors.TempSensorWithThermowell TNOut_anodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=TNOut_anodeGas_set.offset)
    annotation (Placement(transformation(extent={{0,-88},{20,-108}})));
  NHES.Electrolysis.Compressor.CompressionSystem_elecPorts
    compressionSystem(
    redeclare package Medium_working =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    redeclare package Medium_utility =
        Modelica.Media.Water.StandardWater,
    comp_1st(Wc(start=3006830)),
    comp_2nd(Wc(start=3426440)),
    comp_3rd(Wc(start=3602150))) annotation (Placement(transformation(
          extent={{-106,-104},{-42,-64}})));
  NHES.Electrolysis.Turbine.TurbineShaft_PowerOut_NPT_HTSE turbine(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    Xstart={0.674729,0.325271},
    phi_start(displayUnit="rad"),
    pstart_out=system.p_ambient,
    phi(
      displayUnit="rad",
      fixed=true,
      start=turbine.phi_start),
    PR0=17.307e5/system.p_ambient,
    w0=PCV_anSOEC.m_flow_nominal,
    Tin0=turbine.Tstart_in,
    pin0=turbine.pstart_in,
    Tstart_in=605.841,
    Tstart_out=308.2712)
    annotation (Placement(transformation(extent={{42,-46},{10,-14}})));
  Modelica.Fluid.Sources.Boundary_pT sink_anodeStream(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=system.p_ambient,
    nPorts=1) annotation (Placement(transformation(extent={{-38,-26},{-18,
            -6}}, rotation=0)));
  NHES.Electrolysis.Electrical.ElectricGenerator_constSpeed generator(
      w_fixed=turbine.N0)
    annotation (Placement(transformation(extent={{12,-40},{-8,-20}})));
  NHES.Electrolysis.Electrical.SwitchYard_HTSE SY_HTSE
    annotation (Placement(transformation(extent={{140,-2},{160,18}})));
  NHES.Electrolysis.Electrical.SwitchYard_auxiliary SY_aux
    annotation (Placement(transformation(extent={{-92,-2},{-72,18}})));
  NHES.Electrolysis.Sensors.PowerSensor W_vessel(W(unit="W",
        displayUnit="MW")) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={132,0})));
  NHES.Electrolysis.Sensors.PowerSensor W_aux(W(unit="W", displayUnit=
          "MW")) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={134,160})));
  NHES.Electrolysis.Sensors.PowerSensor W_GT(W(unit="W", displayUnit=
          "MW")) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={158,-36})));
  NHES.Electrolysis.Sensors.PowerSensor W_HTSE(W(unit="W", displayUnit=
          "MW")) annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={172,16})));
  Modelica.Fluid.Fittings.TeeJunctionVolume flowJoin(
    V=1,
    use_T_start=true,
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    p_start=5130420,
    T_start=497.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-50,-40})));
  Modelica.Fluid.Sensors.MassFlowRate mH2O_out(redeclare package Medium =
        Medium)                             annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={-160,-80})));
  Modelica.Fluid.Sensors.Pressure pH2O_out(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-152,-20},{-168,-4}})));
  Modelica.Fluid.Sensors.Temperature TH2O_out(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-172,-40},{-188,-24}})));
  Modelica.Fluid.Fittings.TeeJunctionVolume flowSplit(
    V=1,
    use_T_start=true,
    redeclare package Medium = Medium,
    port_2(m_flow(start=7.311637), p(start=5800000, fixed=true)),
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    p_start=5800000,
    T_start=591.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-160,20})));
  Modelica.Fluid.Sensors.Temperature TH2O_in(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-180,100},{-196,116}})));
  Modelica.Fluid.Sensors.Pressure pH2O_in(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-172,132},{-188,148}})));
  Modelica.Fluid.Sensors.MassFlowRate mH2O_in(redeclare package Medium = Medium)
                                            annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={-180,60})));
  Modelica.Blocks.Sources.RealExpression mH2(y=mH2_sec)
    annotation (Placement(transformation(extent={{-180,160},{-160,180}})));
  Modelica.Blocks.Sources.RealExpression mO2(y=mO2_sec)
    annotation (Placement(transformation(extent={{-180,146},{-160,166}})));
equation
  mH2_sec = idealRecycle_H2.H2Produced.m_flow_in;
  mH2_yr =  mH2_sec*60*60*24*365;
  mO2_sec = HTSEvessel.controlledSOEC.SOECstack.deltaM_O2*HTSEvessel.controlledSOEC.numVessels;
  mO2_yr = mO2_sec*60*60*24*365;

  Q_nuclearHeatCathodeRecup = hEX_nuclearHeatCathodeGasRecup_ROM.QTube_gained;
  Q_nuclearHeatAnodeRecup = hEX_nuclearHeatAnodeGasRecup_ROM.QTube_gained;
  Q_nuclearHeatRecup = Q_nuclearHeatCathodeRecup + Q_nuclearHeatAnodeRecup;
  Wq_nuclearHeatRecup = Q_nuclearHeatRecup*eta_powerCycle;
  W_total = W_HTSE.W + Wq_nuclearHeatRecup;

  We_HTSE_percent = (W_HTSE.W/W_total)*100;
  Wq_HTSE_percent = (Wq_nuclearHeatRecup/W_total)*100;

  connect(actuator_wCathode_in.y, FCV_catSOEC.opening) annotation (Line(
        points={{75,104},{60,104},{60,88}},      color={0,0,127}));
  connect(FCV_anSOEC.opening, actuator_wAnode_in.y) annotation (Line(
        points={{60,-80},{60,-96},{75,-96}},    color={0,0,127}));
  connect(actuator_pAnSOEC.y, PCV_anSOEC.opening) annotation (Line(points={{69,-42},
          {60,-42},{60,-26}},             color={0,0,127}));
  connect(PCV_catSOEC.opening, actuator_pCatSOEC.y) annotation (Line(
        points={{60,28},{60,42},{69,42}},    color={0,0,127}));
  connect(FCV_catSOEC.port_b, HTSEvessel.cathodeIn) annotation (Line(
        points={{70,80},{112,80},{112,8}}, color={0,127,255}));
  connect(FCV_anSOEC.port_b, HTSEvessel.anodeIn) annotation (Line(points={{70,-72},
          {112,-72},{112,-12}},          color={0,127,255}));
  connect(HTSEvessel.anodeOut, PCV_anSOEC.port_a) annotation (Line(points={{104,-4},
          {90,-4},{90,-18},{70,-18}},          color={0,127,255}));
  connect(HTSEvessel.c_wCathode, actuator_wCathode_in.u) annotation (Line(
        points={{115,8.4},{115,8.4},{115,104},{98,104}},
                                                      color={0,0,127}));
  connect(HTSEvessel.c_wAnode, actuator_wAnode_in.u) annotation (Line(
        points={{115,-12.4},{115,-96},{98,-96}},
                                               color={0,0,127}));
  connect(HTSEvessel.c_pAnode, actuator_pAnSOEC.u) annotation (Line(
        points={{103.6,-6.4},{100,-6.4},{100,-42},{92,-42}},
                                                          color={0,0,127}));
  connect(PCV_catSOEC.port_a, HTSEvessel.cathodeOut) annotation (Line(
        points={{70,20},{90,20},{90,0},{104,0}}, color={0,127,255}));
  connect(FCV_catSOEC.port_a, cascadeCtrl_yH2.mixtureGas_port_3)
    annotation (Line(points={{50,80},{50,80},{19.6,80}}, color={0,127,255}));
  connect(HTSEvessel.c_pCathode, actuator_pCatSOEC.u) annotation (Line(
        points={{103.6,2.4},{100,2.4},{100,42},{92,42}},
                                                      color={0,0,127}));
  connect(PCV_catSOEC.port_b, flashDrum.feedInlet) annotation (Line(
        points={{50,20},{50,20},{38,20}}, color={0,127,255}));
  connect(flashDrum.vaporOutlet, idealRecycle_H2.H2_feed) annotation (
      Line(points={{30,29},{30,50},{19.6,50}},
                                             color={0,127,255}));
  connect(idealRecycle_H2.H2_recycle, cascadeCtrl_yH2.mixtureGas_port_1)
    annotation (Line(points={{0.4,56},{-6,56},{-6,74},{0.4,74}},
        color={0,127,255}));
  connect(cascadeCtrl_yH2.c_yH2, idealRecycle_H2.c_yH2) annotation (Line(
        points={{14.8,76.64},{14.8,52.64}},              color={0,0,127}));
  connect(H2O_sink.ports[1], flashDrum.liquidOutlet) annotation (Line(
        points={{10,4},{30,4},{30,11}},                        color={0,
          127,255}));
  connect(H2_sink.ports[1], idealRecycle_H2.H2_prod)
    annotation (Line(points={{-10,44},{-10,44},{0.4,44}},
                                                   color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.tube_out, cascadeCtrl_yH2.steam_port_2)
    annotation (Line(points={{-40,86},{0.4,86}},   color={0,127,255}));
  connect(TNOut_cathodeGasSensor.port, hEX_nuclearHeatCathodeGasRecup_ROM.tube_out)
    annotation (Line(points={{-20,100},{-20,86},{-40,86}},color={0,127,
          255}));
  connect(TCV_cathodeGas.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-80,120},{-50,120},{-50,96}}, color={0,127,
          255}));
  connect(actuator_TNOut_cathodeGas.y, TCV_cathodeGas.opening)
    annotation (Line(points={{-71,144},{-90,144},{-90,128}},   color={0,0,
          127}));
  connect(TNOut_cathodeGasSensor.y, FBctrl_TNOut_cathodeGas.u_m)
    annotation (Line(points={{-20,119},{-20,132}}, color={0,0,127}));
  connect(actuator_TNOut_cathodeGas.u, FBctrl_TNOut_cathodeGas.y)
    annotation (Line(points={{-48,144},{-31,144}}, color={0,0,127}));
  connect(FBctrl_TNOut_cathodeGas.u_s, TNOut_cathodeGas_set.y)
    annotation (Line(points={{-8,144},{9,144}},    color={0,0,127}));
  connect(feedPump.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-80,86},{-60,86}}, color={0,127,255}));
  connect(source_cathodeStream.ports[1], feedPump.port_a) annotation (
      Line(points={{-112,86},{-100,86}},           color={0,127,255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out, FCV_anSOEC.port_a)
    annotation (Line(points={{-10,-72},{-10,-72},{50,-72}}, color={0,127,
          255}));
  connect(TCV_anodeGas.port_b, hEX_nuclearHeatAnodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-50,-120},{-20,-120},{-20,-82}}, color={0,
          127,255}));
  connect(actuator_TNOut_anodeGas.y, TCV_anodeGas.opening) annotation (
      Line(points={{-41,-140},{-60,-140},{-60,-128}}, color={0,0,127}));
  connect(actuator_TNOut_anodeGas.u, FBctrl_TNOut_anodeGas.y)
    annotation (Line(points={{-18,-140},{-1,-140}},  color={0,0,127}));
  connect(FBctrl_TNOut_anodeGas.u_s, TNOut_anodeGas_set.y)
    annotation (Line(points={{22,-140},{39,-140}},color={0,0,127}));
  connect(TNOut_anodeGasSensor.port, hEX_nuclearHeatAnodeGasRecup_ROM.tube_out)
    annotation (Line(points={{10,-88},{10,-72},{-10,-72}},   color={0,127,
          255}));
  connect(FBctrl_TNOut_anodeGas.u_m, TNOut_anodeGasSensor.y)
    annotation (Line(points={{10,-128},{10,-107}},   color={0,0,127}));
  connect(source_anodeStream.ports[1], compressionSystem.anodeIn)
    annotation (Line(points={{-112,-72},{-112,-72},{-103.6,-72}}, color={
          0,127,255}));
  connect(compressionSystem.anodeOut, hEX_nuclearHeatAnodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-43.6,-72},{-43.6,-72},{-30,-72}}, color={0,
          127,255}));
  connect(turbine.inlet, PCV_anSOEC.port_b) annotation (Line(points={{35.6,
          -17.2},{50,-17.2},{50,-18}},      color={0,127,255}));
  connect(sink_anodeStream.ports[1], turbine.outlet) annotation (Line(
        points={{-18,-16},{16.4,-16},{16.4,-17.2}},   color={0,127,255}));
  connect(generator.shaft, turbine.shaft_b) annotation (Line(points={{10,-30},
          {16.4,-30}},                color={0,0,0}));
  connect(turbine.W_GT, generator.W_GT) annotation (Line(points={{20.24,
          -22.32},{20.24,-22.32},{2,-22.32},{2,-23.8}},     color={0,0,
          127}));
  connect(feedPump.loadElecPump, SY_aux.load_GT) annotation (Line(
      points={{-90,76},{-90,16}},
      color={255,0,0},
      thickness=0.5));
  connect(HTSEvessel.elecLoad, W_vessel.port_b) annotation (Line(
      points={{120,0},{120,0},{126,0}},
      color={255,0,0},
      thickness=0.5));
  connect(W_vessel.port_a, SY_HTSE.load_SOEC) annotation (Line(
      points={{138,0},{138,0},{142,0}},
      color={255,0,0},
      thickness=0.5));
  connect(SY_aux.load_auxiliary, W_aux.port_b) annotation (Line(
      points={{-90,0},{-140,0},{-140,160},{126,160}},
      color={255,0,0},
      thickness=0.5));
  connect(W_aux.port_a, SY_HTSE.load_auxiliary) annotation (Line(
      points={{142,160},{142,160},{142,16}},
      color={255,0,0},
      thickness=0.5));
  connect(SY_HTSE.generation_GT, W_GT.port_b) annotation (Line(
      points={{158,0},{158,-28}},
      color={255,0,0},
      thickness=0.5));
  connect(generator.powerGeneration, W_GT.port_a) annotation (Line(
      points={{-6,-30},{-10,-30},{-10,-54},{158,-54},{158,-44}},
      color={255,0,0},
      thickness=0.5));
  connect(W_HTSE.port_b, SY_HTSE.totalElecPower) annotation (Line(
      points={{164,16},{158,16}},
      color={255,0,0},
      thickness=0.5));
  connect(flowJoin.port_3, hEX_nuclearHeatCathodeGasRecup_ROM.shell_out)
    annotation (Line(points={{-50,-30},{-50,23},{-50,76}}, color={0,127,
          255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_out, flowJoin.port_1)
    annotation (Line(points={{-20,-62},{-20,-40},{-40,-40}}, color={0,127,
          255}));
  connect(pH2O_out.port, mH2O_out.port_a) annotation (Line(points={{-160,-20},{-160,
          -20},{-160,-72}},            color={0,0,127}));
  connect(TH2O_out.port, mH2O_out.port_a) annotation (Line(points={{-180,
          -40},{-160,-40},{-160,-72}}, color={0,0,127}));
  connect(flowJoin.port_2, mH2O_out.port_a) annotation (Line(points={{-60,
          -40},{-160,-40},{-160,-72}}, color={0,127,255}));
  connect(flowSplit.port_3, TCV_cathodeGas.port_a) annotation (Line(
        points={{-160,30},{-160,120},{-100,120}}, color={0,127,255}));
  connect(TCV_anodeGas.port_a, flowSplit.port_1) annotation (Line(points=
          {{-70,-120},{-144,-120},{-144,20},{-150,20}}, color={0,127,255}));
  connect(port_b, mH2O_out.port_b) annotation (Line(points={{-200,-100},{
          -180,-100},{-160,-100},{-160,-88}}, color={0,127,255}));
  connect(portElec_a, W_HTSE.port_a) annotation (Line(
      points={{200,0},{192,0},{180,0},{180,16}},
      color={255,0,0},
      thickness=0.5));
  connect(port_a, TH2O_in.port) annotation (Line(points={{-200,80},{-180,80},
          {-180,100},{-188,100}}, color={0,0,127}));
  connect(pH2O_in.port, TH2O_in.port) annotation (Line(points={{-180,132},{-180,
          100},{-188,100}},      color={0,0,127}));
  connect(signalBus.Signals_IP_vessel.W_HTSE, W_HTSE.W) annotation (Line(
      points={{0.08,180.08},{90,180.08},{200,180.08},{200,40},{172,40},{172,
          23.52}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_IP_vessel.W_GT, W_GT.W) annotation (Line(
      points={{0.08,180.08},{200,180.08},{200,-36},{165.52,-36}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_IP_vessel.W_Vessel, W_vessel.W) annotation (
      Line(
      points={{0.08,180.08},{100,180.08},{200,180.08},{200,-16},{132,-16},{
          132,-5.64}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_IP_vessel.W_Aux, W_aux.W) annotation (Line(
      points={{0.08,180.08},{134,180.08},{134,167.52}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_IP_vessel.W_SOEC, HTSEvessel.s_W_SOEC)
    annotation (Line(
      points={{0.08,180.08},{200,180.08},{200,40},{124,40},{124,-4},{120.4,
          -4}},
      color={255,204,51},
      thickness=0.5));
  connect(port_a, mH2O_in.port_a) annotation (Line(points={{-200,80},{-180,80},{
          -180,68}}, color={0,127,255}));
  connect(mH2O_in.port_b, flowSplit.port_2) annotation (Line(points={{-180,52},{
          -180,20},{-170,20}}, color={0,127,255}));
  connect(signalBus.Signals_IP_vessel.p_in, pH2O_in.p) annotation (Line(
      points={{0.08,180.08},{-34,180.08},{-200,180.08},{-200,140},{-188.8,140}},
      color={255,204,51},
      thickness=0.5));

  connect(signalBus.Signals_IP_vessel.T_in, TH2O_in.T) annotation (Line(
      points={{0.08,180.08},{-56,180.08},{-200,180.08},{-200,108},{-193.6,108}},
      color={255,204,51},
      thickness=0.5));

  connect(signalBus.Signals_IP_vessel.m_flow_in, mH2O_in.m_flow) annotation (
      Line(
      points={{0.08,180.08},{-200,180.08},{-200,60},{-188.8,60}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_IP_vessel.p_out, pH2O_out.p) annotation (Line(
      points={{0.08,180.08},{0,180.08},{0,180},{-200,180},{-200,-12},{-168.8,-12}},
      color={255,204,51},
      thickness=0.5));

  connect(signalBus.Signals_IP_vessel.T_out, TH2O_out.T) annotation (Line(
      points={{0.08,180.08},{-200,180.08},{-200,-32},{-185.6,-32}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_IP_vessel.m_flow_out, mH2O_out.m_flow) annotation (
      Line(
      points={{0.08,180.08},{-200,180.08},{-200,-80},{-168.8,-80}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_IP_vessel.m_flow_O2_prod, mO2.y)
    annotation (Line(
      points={{0.08,180.08},{-78,180.08},{-150,180.08},{-150,156},{-159,
          156}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signals_IP_vessel.m_flow_H2_prod, mH2.y)
    annotation (Line(
      points={{0.08,180.08},{-150,180.08},{-150,170},{-159,170}},
      color={255,204,51},
      thickness=0.5));
  connect(compressionSystem.loadElec_comp, SY_aux.load_MSCS)
    annotation (Line(
      points={{-74,-64},{-74,-32},{-74,0}},
      color={255,0,0},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -180},{200,180}})),
    experiment(
      StopTime=4200,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
                  Text(
          extent={{-108,70},{108,52}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="High-Temperature
Steam Electrolysis"),                                         Bitmap(extent={{
              -72,-56},{74,26}}, fileName=
              "modelica://NHES/../../Models/NHES/Resources/Images/Systems/IP/Electrolysis/HTSE.png")}));
end HTSEplant_FY17;
