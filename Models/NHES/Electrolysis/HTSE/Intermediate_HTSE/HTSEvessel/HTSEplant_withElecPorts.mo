within NHES.Electrolysis.HTSE.Intermediate_HTSE.HTSEvessel;
model HTSEplant_withElecPorts
  import NHES.Electrolysis;
  import NHES;
  extends Modelica.Icons.Example;

  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium
    annotation (__Dymola_choicesAllMatching=true, Dialog(group="Working fluid for the hot utility"));

  parameter Integer numCells_perVessel=68320 "Total number of cells per vessel";
  parameter Integer numVessels=5 "Number of online vessels per system";
  final parameter Real eta_powerCycle(min=0, max=1, unit="1") = 0.318 "Power cycle efficiency";

  //SI.MassFlowRate mH2_sec "H2 produced during electrolysis per second";
  /*
  Electrolysis.Types.AnnualMassFlowRate mH2_yr
    "H2 produced during electrolysis per year";
  SI.MassFlowRate mO2_sec "O2 produced during electrolysis per second";
  Electrolysis.Types.AnnualMassFlowRate mO2_yr
    "O2 produced during electrolysis per year";

  SI.Power Q_nuclearHeatCathodeRecup "Nuclear heat transferred from the hot utility to cathode stream";
  SI.Power Q_nuclearHeatAnodeRecup "Nuclear heat transferred from the hot utility to anode stream";
  SI.Power Q_nuclearHeatRecup "Total nuclear heat transferred from the hot utility to the cathode and anode streams";
  SI.Power Wq_nuclearHeatRecup "Electrical power equivalent to 'Q_nuclearHeatRecup' with 'eta_powerCycle'";
  SI.Power W_total "Total energy consumption in the HTSE plant";
  Real We_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of electrical energy consumption in the HTSE plant";
  Real Wq_HTSE_percent(min=0,max=100,unit="1",displayUnit="%") "Percentage of thermal energy consumption in the HTSE plant";
  */

  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=
        298.15)
    annotation (Placement(transformation(extent={{160,160},{180,180}})));
  Modelica.Blocks.Sources.Ramp power_set(
    duration=0,
    startTime=100,
    offset=9.10627*1e6*5 + 5613800,
    height=-1.929*1e6*5*1 + 310130*0 + 453400*1 + 106810*0 - 1255195*0)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={170,38})));

  NHES.Electrolysis.Sources.PrescribedPowerFlow prescribedPowerFlow
    annotation (Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=0,
        origin={134,38})));

  Modelica.Blocks.Continuous.FirstOrder actuator_wAnode_in(
    k=1,
    T=4,
    y_start=HTSEvessel.controlledSOEC.anodeFCV_valveOpening_start,
    initType=Modelica.Blocks.Types.Init.SteadyState)
          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={66,-96})));
  Modelica.Fluid.Sources.Boundary_pT source_cathodeStream(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="bar") = system.p_ambient,
    T=system.T_ambient,
    nPorts=1)
    annotation (Placement(transformation(extent={{-154,76},{-134,96}})));

  Modelica.Fluid.Valves.ValveLinear FCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=HTSEvessel.controlledSOEC.wCathode_in_start,
    dp_nominal=HTSEvessel.controlledSOEC.cathodeFCV_valveOpening_start*((
        22.72222 - 20.45)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wCathode_in_start,
    m_flow(start=HTSEvessel.controlledSOEC.wCathode_in_start, fixed=true),
    dp_start=((22.72222 - 20.45)*1e5))
                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={40,80})));

  Modelica.Blocks.Continuous.FirstOrder actuator_wCathode_in(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.cathodeFCV_valveOpening_start)
                                                       annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={66,104})));
  Modelica.Fluid.Sources.Boundary_pT source_anodeStream(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    p(displayUnit="bar") = 101325,
    nPorts=1,
    T=288.15) annotation (Placement(transformation(extent={{-154,-82},{-134,
            -62}})));

  Modelica.Fluid.Valves.ValveLinear FCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=HTSEvessel.controlledSOEC.wAnode_in_start,
    dp_nominal=HTSEvessel.controlledSOEC.anodeFCV_valveOpening_start*((
        22.72222 - 20.45)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wAnode_in_start,
    m_flow(start=HTSEvessel.controlledSOEC.wAnode_in_start),
    dp_start=((22.72222 - 20.45)*1e5))    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={40,-72})));

  Modelica.Blocks.Continuous.FirstOrder actuator_pAnSOEC(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.anodePCV_valveOpening_start)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,-42})));
  Modelica.Blocks.Continuous.FirstOrder actuator_pCatSOEC(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=HTSEvessel.controlledSOEC.cathodePCV_valveOpening_start)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,42})));
  Modelica.Fluid.Valves.ValveLinear PCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=HTSEvessel.controlledSOEC.wAnode_out_start,
    m_flow(start=HTSEvessel.controlledSOEC.wAnode_out_start),
    dp_nominal=HTSEvessel.controlledSOEC.anodePCV_valveOpening_start*((
        19.23 - 17.307)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wAnode_out_start,
    dp_start=((19.23 - 17.307)*1e5))       annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={40,-18})));
  Modelica.Fluid.Valves.ValveLinear PCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=HTSEvessel.controlledSOEC.wCathode_out_start,
    m_flow(start=HTSEvessel.controlledSOEC.wCathode_out_start),
    dp_nominal=HTSEvessel.controlledSOEC.cathodePCV_valveOpening_start*((
        19.6035 - 17.64315)*1e5),
    m_flow_nominal=HTSEvessel.controlledSOEC.wCathode_out_start,
    dp_start=((19.6035 - 17.64315)*1e5))
                           annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={40,20})));

  NHES.Electrolysis.HTSE.HTSEvessel HTSEvessel(numCells_perVessel=
        numCells_perVessel, numVessels=numVessels)
    annotation (Placement(transformation(extent={{82,-12},{102,8}})));
  NHES.Electrolysis.Sensors.PowerSensor W_HTSE(W(unit="W",
        displayUnit="MW")) annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={114,0})));
  NHES.Electrolysis.Fittings.CascadeCtrlIdealVessel_yH2
    cascadeCtrl_yH2(
    redeclare package MixtureGas =
        Electrolysis.Media.Electrolysis.CathodeGas,
    redeclare package Steam = Modelica.Media.Water.StandardWater,
    yH2_setPoint=0.1,
    V=0.125,
    initType_FBctrl_yH2=Modelica.Blocks.Types.Init.SteadyState,
    wH2_start=0.0557585664075,
    pSteam_start=2272222,
    TSteam_start=556.55) annotation (Placement(transformation(
          extent={{-22,92},{2,68}})));
  NHES.Electrolysis.Separator.Temp_flashDrumVessel flashDrum(
      redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={10,20})));
  Modelica.Fluid.Sources.Boundary_pT H2O_sink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1764315,
    T=618.329) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-20,4})));
  Modelica.Fluid.Sources.Boundary_pT H2_sink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1764315,
    T=618.329) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-40,44})));
  NHES.Electrolysis.Fittings.IdealRecycleVessel_H2 idealRecycle_H2(
      redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas) annotation (
      Placement(transformation(extent={{-22,38},{2,62}})));
  NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatCathodeGasRecupVessel_ROM_NHES
    hEX_nuclearHeatCathodeGasRecup_ROM(
    initOpt=Electrolysis.Utilities.OptionsInit.userSpecified,
    redeclare package Medium_tube =
        Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell = Medium) annotation (Placement(
        transformation(extent={{-80,76},{-60,96}})));
  Modelica.Fluid.Sources.Boundary_pT steamSink_cathodeStream(
    nPorts=1,
    redeclare package Medium = Medium,
    p=5130420,
    T=497.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,44})));
  Electrolysis.Sensors.TempSensorWithThermowell TNOut_cathodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    y_start=TNOut_cathodeGas_set.offset)
    annotation (Placement(transformation(extent={{-50,100},{-30,120}})));
  Modelica.Fluid.Valves.ValveLinear TCV_cathodeGas(
    m_flow_small=0.001,
    show_T=true,
    m_flow_nominal=6.46077,
    redeclare package Medium = Medium,
    dp_nominal=actuator_TNOut_cathodeGas.y_start*((58 - 52.2)*1e5),
    m_flow_start=TCV_cathodeGas.m_flow_nominal,
    m_flow(start=TCV_cathodeGas.m_flow_nominal, fixed=true),
    dp_start=(58 - 52.2)*1e5)
                 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-110,120})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_cathodeGas(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.9)                                             annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-80,144})));
  Modelica.Fluid.Sources.Boundary_pT steamSource_cathodeStream(
    use_p_in=false,
    nPorts=1,
    redeclare package Medium = Medium,
    p=5800000,
    T=591.15) annotation (Placement(transformation(extent={{-154,110},{-134,
            130}})));
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
        origin={-40,144})));

  Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    offset=283.4 + 273.15,
    y(displayUnit="degC", unit="K"))
                  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,144})));
  NHES.Electrolysis.Machines.PumpControlledPressureVessel_elecPort
    feedPump(V=1, redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(extent={{-120,76},{-100,96}})));
  NHES.Electrolysis.HeatExchangers.HEX_nuclearHeatAnodeGasRecupVessel_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_shell = Medium,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-50,-62},{-30,-82}})));
  Modelica.Fluid.Sources.Boundary_pT steamSink_anodeStream(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=5130420,
    T=497.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-70,-44})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=0.4) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-50,-140})));
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
        origin={-10,-140})));
  Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    y(displayUnit="degC", unit="K"),
    offset=259 + 273.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,-140})));
  Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
    m_flow_small=0.001,
    show_T=true,
    m_flow_start=TCV_anodeGas.m_flow_nominal,
    redeclare package Medium = Medium,
    dp_nominal=actuator_TNOut_anodeGas.y_start*((58 - 51.4542)*1e5),
    m_flow_nominal=0.850426,
    m_flow(start=TCV_anodeGas.m_flow_nominal),
    dp_start=(58 - 51.4542)*1e5)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-80,-120})));
  Modelica.Fluid.Sources.Boundary_pT steamSource_anodeStream(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p=5800000,
    T=591.15) annotation (Placement(transformation(extent={{-154,-130},{-134,
            -110}})));
  Electrolysis.Sensors.TempSensorWithThermowell
                                   TNOut_anodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=TNOut_anodeGas_set.offset)
    annotation (Placement(transformation(extent={{-20,-88},{0,-108}})));
  NHES.Electrolysis.Compressor.CompressionSystem_elecPorts
    compressionSystem(redeclare package Medium_working =
        Electrolysis.Media.Electrolysis.AnodeGas_air, redeclare package
      Medium_utility =         Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-126,-104},{-62,-64}})));
  NHES.Electrolysis.Turbine.TurbineShaft_PowerOut_NPT_HTSE turbine(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
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
    Tstart_out=308.2712) annotation (Placement(transformation(
          extent={{18,-46},{-14,-14}})));
  Modelica.Fluid.Sources.Boundary_pT sink_anodeStream(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=system.p_ambient,
    nPorts=1) annotation (Placement(transformation(extent={{-80,-28},{-60,
            -8}}, rotation=0)));
  NHES.Electrolysis.Electrical.ElectricGenerator_constSpeed
    generator(w_fixed=turbine.N0) annotation (Placement(
        transformation(extent={{-14,-40},{-34,-20}})));
  NHES.Electrolysis.Sources.PrescribedFrequency prescribedFrequency(
      f=60) annotation (Placement(transformation(extent={{-40,-40},
            {-60,-20}})));
  NHES.Electrolysis.Sources.LoadSink loadSink2 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-94,-48})));
  NHES.Electrolysis.Sources.LoadSink loadSink1 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-110,60})));
equation

  //mH2_sec = hEX_cathodeGasRecup_ROM.wShell_out*hEX_cathodeGasRecup_ROM.XShell_out[1] - cascadeCtrl_yH2.mixtureGas_port_1.m_flow;
  /*
  mH2_yr =  mH2_sec*60*60*24*365;
  mO2_sec = controlledSOEC.SOECstack.deltaM_O2*controlledSOEC.numVessels;
  mO2_yr = mO2_sec*60*60*24*365;

  Q_nuclearHeatCathodeRecup = hEX_nuclearHeatCathodeGasRecup_ROM.QTube_gained;
  Q_nuclearHeatAnodeRecup = hEX_nuclearHeatAnodeGasRecup_ROM.QTube_gained;
  Q_nuclearHeatRecup = Q_nuclearHeatCathodeRecup + Q_nuclearHeatAnodeRecup;
  Wq_nuclearHeatRecup = Q_nuclearHeatRecup*eta_powerCycle;

  W_total = We_HTSE.W + Wq_nuclearHeatRecup;

  We_HTSE_percent = (We_HTSE.W/W_total)*100;
  Wq_HTSE_percent = (Wq_nuclearHeatRecup/W_total)*100;  
  */

  connect(actuator_wCathode_in.y, FCV_catSOEC.opening) annotation (Line(
        points={{55,104},{40,104},{40,88}},      color={0,0,127}));
  connect(FCV_anSOEC.opening, actuator_wAnode_in.y) annotation (Line(
        points={{40,-80},{40,-96},{55,-96}},    color={0,0,127}));
  connect(actuator_pAnSOEC.y, PCV_anSOEC.opening) annotation (Line(points={{49,-42},
          {40,-42},{40,-26}},             color={0,0,127}));
  connect(PCV_catSOEC.opening, actuator_pCatSOEC.y) annotation (Line(
        points={{40,28},{40,42},{49,42}},    color={0,0,127}));
  connect(FCV_catSOEC.port_b, HTSEvessel.cathodeIn) annotation (Line(
        points={{50,80},{92,80},{92,8}},   color={0,127,255}));
  connect(FCV_anSOEC.port_b, HTSEvessel.anodeIn) annotation (Line(points={{50,-72},
          {92,-72},{92,-12}},            color={0,127,255}));
  connect(HTSEvessel.anodeOut, PCV_anSOEC.port_a) annotation (Line(points={{84,-4},
          {70,-4},{70,-18},{50,-18}},          color={0,127,255}));
  connect(HTSEvessel.c_wCathode, actuator_wCathode_in.u) annotation (Line(
        points={{95,8.4},{95,8.4},{95,104},{78,104}}, color={0,0,127}));
  connect(HTSEvessel.c_wAnode, actuator_wAnode_in.u) annotation (Line(
        points={{95,-12.4},{95,-96},{78,-96}}, color={0,0,127}));
  connect(HTSEvessel.c_pAnode, actuator_pAnSOEC.u) annotation (Line(
        points={{83.6,-6.4},{80,-6.4},{80,-42},{72,-42}}, color={0,0,127}));
  connect(PCV_catSOEC.port_a, HTSEvessel.cathodeOut) annotation (Line(
        points={{50,20},{70,20},{70,0},{84,0}},  color={0,127,255}));
  connect(prescribedPowerFlow.P_flow, power_set.y)
    annotation (Line(points={{143.6,38},{159,38}}, color={0,0,127}));
  connect(FCV_catSOEC.port_a, cascadeCtrl_yH2.mixtureGas_port_3)
    annotation (Line(points={{30,80},{30,80},{-0.4,80}}, color={0,127,255}));
  connect(HTSEvessel.c_pCathode, actuator_pCatSOEC.u) annotation (Line(
        points={{83.6,2.4},{80,2.4},{80,42},{72,42}}, color={0,0,127}));
  connect(PCV_catSOEC.port_b, flashDrum.feedInlet) annotation (Line(
        points={{30,20},{30,20},{18,20}}, color={0,127,255}));
  connect(flashDrum.vaporOutlet, idealRecycle_H2.H2_feed) annotation (
      Line(points={{10,29},{10,50},{-0.4,50}},
                                             color={0,127,255}));
  connect(idealRecycle_H2.H2_recycle, cascadeCtrl_yH2.mixtureGas_port_1)
    annotation (Line(points={{-19.6,56},{-26,56},{-26,74},{-19.6,74}},
        color={0,127,255}));
  connect(cascadeCtrl_yH2.c_yH2, idealRecycle_H2.c_yH2) annotation (Line(
        points={{-5.2,76.64},{-5.2,52.64}},              color={0,0,127}));
  connect(H2O_sink.ports[1], flashDrum.liquidOutlet) annotation (Line(
        points={{-10,4},{10,4},{10,11}},                       color={0,
          127,255}));
  connect(H2_sink.ports[1], idealRecycle_H2.H2_prod)
    annotation (Line(points={{-30,44},{-30,44},{-19.6,44}},
                                                   color={0,127,255}));
  connect(hEX_nuclearHeatCathodeGasRecup_ROM.tube_out, cascadeCtrl_yH2.steam_port_2)
    annotation (Line(points={{-60,86},{-19.6,86}}, color={0,127,255}));
  connect(steamSink_cathodeStream.ports[1],
    hEX_nuclearHeatCathodeGasRecup_ROM.shell_out)
    annotation (Line(points={{-70,54},{-70,76}}, color={0,127,255}));
  connect(TNOut_cathodeGasSensor.port, hEX_nuclearHeatCathodeGasRecup_ROM.tube_out)
    annotation (Line(points={{-40,100},{-40,86},{-60,86}},color={0,127,
          255}));
  connect(TCV_cathodeGas.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-100,120},{-70,120},{-70,96}},color={0,127,
          255}));
  connect(actuator_TNOut_cathodeGas.y, TCV_cathodeGas.opening)
    annotation (Line(points={{-91,144},{-110,144},{-110,128}}, color={0,0,
          127}));
  connect(steamSource_cathodeStream.ports[1], TCV_cathodeGas.port_a)
    annotation (Line(points={{-134,120},{-134,120},{-120,120}}, color={0,
          127,255}));
  connect(TNOut_cathodeGasSensor.y, FBctrl_TNOut_cathodeGas.u_m)
    annotation (Line(points={{-40,119},{-40,132}}, color={0,0,127}));
  connect(actuator_TNOut_cathodeGas.u, FBctrl_TNOut_cathodeGas.y)
    annotation (Line(points={{-68,144},{-51,144}}, color={0,0,127}));
  connect(FBctrl_TNOut_cathodeGas.u_s, TNOut_cathodeGas_set.y)
    annotation (Line(points={{-28,144},{-11,144}}, color={0,0,127}));
  connect(feedPump.port_b, hEX_nuclearHeatCathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-100,86},{-80,86}},color={0,127,255}));
  connect(source_cathodeStream.ports[1], feedPump.port_a) annotation (
      Line(points={{-134,86},{-120,86}},           color={0,127,255}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out, FCV_anSOEC.port_a)
    annotation (Line(points={{-30,-72},{-30,-72},{30,-72}}, color={0,127,
          255}));
  connect(steamSink_anodeStream.ports[1],
    hEX_nuclearHeatAnodeGasRecup_ROM.shell_out) annotation (Line(points={{-60,-44},
          {-40,-44},{-40,-62}},           color={0,127,255}));
  connect(TCV_anodeGas.port_b, hEX_nuclearHeatAnodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-70,-120},{-40,-120},{-40,-82}}, color={0,
          127,255}));
  connect(actuator_TNOut_anodeGas.y, TCV_anodeGas.opening) annotation (
      Line(points={{-61,-140},{-80,-140},{-80,-128}}, color={0,0,127}));
  connect(steamSource_anodeStream.ports[1], TCV_anodeGas.port_a)
    annotation (Line(points={{-134,-120},{-134,-120},{-90,-120}}, color={
          0,127,255}));
  connect(actuator_TNOut_anodeGas.u, FBctrl_TNOut_anodeGas.y)
    annotation (Line(points={{-38,-140},{-21,-140}}, color={0,0,127}));
  connect(FBctrl_TNOut_anodeGas.u_s, TNOut_anodeGas_set.y)
    annotation (Line(points={{2,-140},{19,-140}}, color={0,0,127}));
  connect(TNOut_anodeGasSensor.port, hEX_nuclearHeatAnodeGasRecup_ROM.tube_out)
    annotation (Line(points={{-10,-88},{-10,-72},{-30,-72}}, color={0,127,
          255}));
  connect(FBctrl_TNOut_anodeGas.u_m, TNOut_anodeGasSensor.y)
    annotation (Line(points={{-10,-128},{-10,-107}}, color={0,0,127}));
  connect(source_anodeStream.ports[1], compressionSystem.anodeIn)
    annotation (Line(points={{-134,-72},{-134,-72},{-123.6,-72}}, color={
          0,127,255}));
  connect(compressionSystem.anodeOut, hEX_nuclearHeatAnodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-63.6,-72},{-63.6,-72},{-50,-72}}, color={0,
          127,255}));
  connect(turbine.inlet, PCV_anSOEC.port_b) annotation (Line(points={{11.6,
          -17.2},{30,-17.2},{30,-18}},      color={0,127,255}));
  connect(sink_anodeStream.ports[1], turbine.outlet) annotation (Line(
        points={{-60,-18},{-7.6,-18},{-7.6,-17.2}},   color={0,127,255}));
  connect(generator.shaft, turbine.shaft_b) annotation (Line(points={{-16,-30},
          {-7.6,-30}},                color={0,0,0}));
  connect(turbine.W_GT, generator.W_GT) annotation (Line(points={{-3.76,
          -22.32},{-3.76,-22.32},{-24,-22.32},{-24,-23.8}}, color={0,0,
          127}));
  connect(prescribedFrequency.portElec_a, generator.powerGeneration)
    annotation (Line(
      points={{-40,-30},{-36,-30},{-32,-30}},
      color={255,0,0},
      thickness=0.5));
  connect(W_HTSE.port_a, prescribedPowerFlow.port_b) annotation (Line(
      points={{122,0},{122,19},{122,38}},
      color={255,0,0},
      thickness=0.5));
  connect(HTSEvessel.elecLoad, W_HTSE.port_b) annotation (Line(
      points={{100,0},{103,0},{106,0}},
      color={255,0,0},
      thickness=0.5));
  connect(compressionSystem.loadElec_comp, loadSink2.port_a)
    annotation (Line(
      points={{-94,-64},{-94,-62},{-94,-58}},
      color={255,0,0},
      thickness=0.5));
  connect(loadSink1.port_a, feedPump.loadElecPump) annotation (Line(
      points={{-110,70},{-110,70},{-110,76}},
      color={255,0,0},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,
            -180},{180,180}})),
    experiment(
      StopTime=4200,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end HTSEplant_withElecPorts;
