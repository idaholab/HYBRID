within NHES.Electrolysis.HTSE.Intermediate_HTSE.HTSEvessel;
model HTSEvessel_test "HTSE vessel"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp power_set(
    offset=9.10627*1e6*5,
    duration=0,
    startTime=100,
    height=-1.929*1e6*5*1)
    annotation (Placement(transformation(extent={{146,20},{126,40}})));

  Electrolysis.Sources.PrescribedPowerFlow prescribedPowerFlow
    annotation (Placement(transformation(extent={{120,18},{96,42}})));

  Modelica.Blocks.Continuous.FirstOrder actuator_wAnode_in(
    k=1,
    T=4,
    y_start=controlledSOEC.anodeFCV_valveOpening_start,
    initType=Modelica.Blocks.Types.Init.SteadyState)
          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-70})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasSource(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    X=Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*
        1000}),
    p(displayUnit="bar") = 2272222,
    T=556.55)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));

  inner Modelica.Fluid.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Valves.ValveLinear FCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=controlledSOEC.wCathode_in_start,
    m_flow(start=controlledSOEC.wCathode_in_start),
    m_flow_nominal=controlledSOEC.wCathode_in_start,
    dp_nominal=controlledSOEC.cathodeFCV_valveOpening_start*((22.72222 - 20.45)*
        1e5),
    dp_start=((22.72222 - 20.45)*1e5))
                           annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-60,40})));

  Modelica.Blocks.Continuous.FirstOrder actuator_wCathode_in(
    k=1,
    T=4,
    y_start=controlledSOEC.cathodeFCV_valveOpening_start,
    initType=Modelica.Blocks.Types.Init.SteadyState)   annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-60,70})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSource(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    nPorts=1,
    p(displayUnit="bar") = 2272222,
    T=532.15)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));

  Modelica.Fluid.Valves.ValveLinear FCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=controlledSOEC.wAnode_in_start,
    m_flow(start=controlledSOEC.wAnode_in_start),
    m_flow_nominal=controlledSOEC.wAnode_in_start,
    dp_nominal=controlledSOEC.anodeFCV_valveOpening_start*((22.72222 - 20.45)*1e5),
    dp_start=((22.72222 - 20.45)*1e5))    annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-60,-40})));

  Electrolysis.Electrolyzers.ControlledSOEC_integratedWithHTSEplant_FY17
    controlledSOEC(
    numCells_perVessel=68320,
    numVessels=5,
    initOpt=Electrolysis.Utilities.OptionsInit.userSpecified,
    FBctrl_TC_out_T=212.7930347,
    FBctrl_TC_out_k=0.019944973,
    initType_anodeFCV=Modelica.Blocks.Types.Init.InitialOutput,
    initType_anodePCV=Modelica.Blocks.Types.Init.SteadyState,
    initType_cathodePCV=Modelica.Blocks.Types.Init.SteadyState,
    initType_cathodeFCV=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{54,-14},{86,18}})));
  Electrolysis.HeatExchangers.HEX_cathodeGasRecupVessel_ROM
    hEX_cathodeGasRecup_ROM(
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.CathodeGas,
    redeclare package Medium_shell =
        Electrolysis.Media.Electrolysis.CathodeGas,
    shell_in(p(start=controlledSOEC.SOECstack.pstartCathodeAvg)),
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
                                               annotation (
      Placement(transformation(extent={{-30,30},{-10,50}})));

  Electrolysis.ElectricHeaters.ToppingHeater_cathodeGasVessel_elecPort
    toppingHeater_cathodeGas(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    isCircular=true,
    TC_set(displayUnit="degC") = 1123.15,
    initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (
      Placement(transformation(extent={{10,30},{30,50}})));
  Electrolysis.Sensors.TempSensorWithThermowell TCtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    y_start=850 + 273.15,
    tau=13) annotation (Placement(transformation(extent={{30,46},{50,66}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1764315,
    T=618.331) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,16})));

  Modelica.Blocks.Continuous.FirstOrder actuator_pAnSOEC(
    k=1,
    T=4,
    y_start=controlledSOEC.anodePCV_valveOpening_start,
    initType=Modelica.Blocks.Types.Init.SteadyState)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={10,-86})));
  Modelica.Blocks.Continuous.FirstOrder actuator_pCatSOEC(
    k=1,
    T=4,
    y_start=controlledSOEC.cathodePCV_valveOpening_start,
    initType=Modelica.Blocks.Types.Init.SteadyState)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={10,86})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=1730700,
    T=605.838)
    annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
  Modelica.Fluid.Valves.ValveLinear PCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=controlledSOEC.wAnode_out_start,
    m_flow_nominal=controlledSOEC.wAnode_out_start,
    m_flow(start=controlledSOEC.wAnode_out_start),
    dp_nominal=controlledSOEC.anodePCV_valveOpening_start*((19.23 - 17.307)*1e5),
    dp_start=((19.23 - 17.307)*1e5))       annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-40,-16})));

  Modelica.Fluid.Valves.ValveLinear PCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=controlledSOEC.wCathode_out_start,
    m_flow_nominal=controlledSOEC.wCathode_out_start,
    m_flow(start=controlledSOEC.wCathode_out_start),
    dp_nominal=controlledSOEC.cathodePCV_valveOpening_start*((19.6035 - 17.64315)
        *1e5),
    dp_start=((19.6035 - 17.64315)*1e5))
                           annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-40,16})));

  Electrolysis.Sensors.TempSensorWithThermowell TAtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=850 + 273.15,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    tau=13) annotation (Placement(transformation(extent={{30,-46},{50,-66}})));
  Electrolysis.ElectricHeaters.ToppingHeater_anodeGasVessel_elecPort
    toppingHeater_anodeGas(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    isCircular=true,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    TA_set=1123.15) annotation (Placement(transformation(extent={{
            10,-30},{30,-50}})));
  Electrolysis.HeatExchangers.HEX_anodeGasRecupVessel_ROM_NHES
    hEX_anodeGasRecup_ROM(
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    redeclare package Medium_shell =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
                                         annotation (Placement(
        transformation(extent={{-30,-30},{-10,-50}})));

  Electrolysis.Sources.LoadSink catElec_sink annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={20,8})));
  Electrolysis.Sources.LoadSink anElec_sink annotation (Placement(
        transformation(
        extent={{12,12},{-12,-12}},
        rotation=-90,
        origin={20,-8})));
equation
  connect(FCV_catSOEC.port_a, cathodeGasSource.ports[1]) annotation (Line(
        points={{-68,40},{-68,40},{-80,40}},
                                          color={0,127,255}));
  connect(actuator_wCathode_in.y, FCV_catSOEC.opening) annotation (Line(
        points={{-60,59},{-60,59},{-60,46.4}},   color={0,0,127}));
  connect(anodeGasSource.ports[1], FCV_anSOEC.port_a) annotation (Line(
        points={{-80,-40},{-80,-40},{-68,-40}}, color={0,127,255}));
  connect(actuator_wAnode_in.y, FCV_anSOEC.opening) annotation (Line(
        points={{-60,-59},{-60,-59},{-60,-46.4}},   color={0,0,127}));
  connect(power_set.y, prescribedPowerFlow.P_flow)
    annotation (Line(points={{125,30},{125,30},{117.6,30}},
                                                   color={0,0,127}));
  connect(prescribedPowerFlow.port_b, controlledSOEC.ctrlElectricalLoad)
    annotation (Line(points={{96,30},{40,30},{40,0.4},{57.84,0.4}},  color={255,
          0,0}));
  connect(toppingHeater_cathodeGas.port_b, controlledSOEC.ctrlCathodeIn)
    annotation (Line(points={{30,40},{50,40},{50,6.8},{58.16,6.8}}, color=
         {0,127,255}));
  connect(toppingHeater_cathodeGas.port_b, TCtopping_out.port)
    annotation (Line(points={{30,40},{40,40},{40,46}}, color={0,127,255}));
  connect(TCtopping_out.y, toppingHeater_cathodeGas.s_TC_in) annotation (
      Line(points={{40,65},{40,70},{20,70},{20,51}},   color={0,0,127}));
  connect(hEX_cathodeGasRecup_ROM.tube_out, toppingHeater_cathodeGas.port_a)
    annotation (Line(points={{-10,40},{-10,40},{10,40}}, color={0,127,255}));
  connect(controlledSOEC.ctrlCathodeOut, hEX_cathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{81.84,10},{90,10},{90,72},{-20,72},{-20,50}},
                color={0,127,255}));
  connect(TAtopping_out.y, toppingHeater_anodeGas.s_TA_in) annotation (
      Line(points={{40,-65},{40,-70},{20,-70},{20,-51}},   color={0,0,127}));
  connect(toppingHeater_anodeGas.port_b, controlledSOEC.ctrlAnodeIn)
    annotation (Line(points={{30,-40},{50,-40},{50,-6.64},{58.16,-6.64}},
        color={0,127,255}));
  connect(toppingHeater_anodeGas.port_b, TAtopping_out.port) annotation (
      Line(points={{30,-40},{40,-40},{40,-46}}, color={0,127,255}));
  connect(hEX_anodeGasRecup_ROM.tube_out, toppingHeater_anodeGas.port_a)
    annotation (Line(points={{-10,-40},{-10,-40},{10,-40}}, color={0,127,
          255}));
  connect(hEX_anodeGasRecup_ROM.tube_in, FCV_anSOEC.port_b) annotation (
      Line(points={{-30,-40},{-52,-40}},           color={0,127,255}));
  connect(controlledSOEC.ctrlAnodeOut, hEX_anodeGasRecup_ROM.shell_in)
    annotation (Line(points={{81.84,-3.44},{90,-3.44},{90,-72},{-20,-72},{-20,-50}},
                      color={0,127,255}));
  connect(controlledSOEC.c_wAnodeIn, actuator_wAnode_in.u) annotation (
      Line(points={{65.52,-9.84},{65.52,-100},{64,-100},{-60,-100},{-60,
          -82}},                                           color={0,0,127}));
  connect(actuator_pAnSOEC.u, controlledSOEC.c_pAnode) annotation (Line(
        points={{22,-86},{71.92,-86},{71.92,-9.84}},   color={0,0,127}));
  connect(FCV_catSOEC.port_b, hEX_cathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-52,40},{-30,40}}, color={0,127,255}));
  connect(hEX_cathodeGasRecup_ROM.shell_out, PCV_catSOEC.port_a)
    annotation (Line(points={{-20,30},{-20,16},{-32,16}}, color={0,127,255}));
  connect(cathodeGasSink.ports[1], PCV_catSOEC.port_b)
    annotation (Line(points={{-80,16},{-48,16}}, color={0,127,255}));
  connect(toppingHeater_cathodeGas.loadElecHeater, catElec_sink.port_a)
    annotation (Line(points={{20,30},{20,24},{20,20}}, color={255,0,0}));
  connect(toppingHeater_anodeGas.loadElecHeater, anElec_sink.port_a)
    annotation (Line(points={{20,-30},{20,-24},{20,-20}}, color={255,0,0}));
  connect(controlledSOEC.c_pCathode, actuator_pCatSOEC.u) annotation (Line(
        points={{73.2,11.6},{73.2,38},{73.2,86},{22,86}}, color={0,0,127}));
  connect(actuator_pCatSOEC.y, PCV_catSOEC.opening)
    annotation (Line(points={{-1,86},{-40,86},{-40,22.4}}, color={0,0,127}));
  connect(actuator_pAnSOEC.y, PCV_anSOEC.opening) annotation (Line(points={{-1,-86},
          {-40,-86},{-40,-22.4}}, color={0,0,127}));
  connect(anodeGasSink.ports[1], PCV_anSOEC.port_b) annotation (Line(points={{-80,-16},
          {-48,-16}},                color={0,127,255}));
  connect(controlledSOEC.c_wCathode, actuator_wCathode_in.u) annotation (Line(
        points={{66.8,11.6},{66.8,26},{66.8,100},{-60,100},{-60,82}}, color={0,0,
          127}));
  connect(hEX_anodeGasRecup_ROM.shell_out, PCV_anSOEC.port_a) annotation (
     Line(points={{-20,-30},{-20,-16},{-32,-16}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=1200,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end HTSEvessel_test;
