within NHES.Electrolysis.HTSE;
model HTSEvessel "HTSE vessel"
  extends NHES.Electrolysis.Icons.HTSEvessel;

  parameter Integer numCells_perVessel = 68320 "Total number of cells per vessel";
  parameter Integer numVessels = 5 "Number of online vessels per system";

  Electrolysis.Interfaces.ElectricalPowerPort_a elecLoad annotation (
      Placement(transformation(extent={{90,10},{110,30}}),
        iconTransformation(extent={{70,10},{90,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b cathodeOut(redeclare package Medium =
               Electrolysis.Media.Electrolysis.CathodeGas) annotation (
      Placement(transformation(extent={{-110,10},{-90,30}}),
        iconTransformation(extent={{-90,10},{-70,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b anodeOut(redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air) annotation (
      Placement(transformation(extent={{-110,-30},{-90,-10}}),
        iconTransformation(extent={{-90,-30},{-70,-10}})));
  Modelica.Blocks.Interfaces.RealOutput c_wCathode annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={20,106}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,104})));
  Modelica.Blocks.Interfaces.RealOutput c_pCathode annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-106,40}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-84,44})));
  Modelica.Blocks.Interfaces.RealOutput c_pAnode annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-106,-40}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-84,-44})));
  Modelica.Blocks.Interfaces.RealOutput c_wAnode annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={20,-106}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,-104})));
  Electrolysis.Electrical.SwitchYard_vessel SY_vessel(powerConsumption_SOEC(
        fixed=false))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Electrolysis.Sensors.PowerSensor W_SOEC(W(unit="W", displayUnit="MW"))
    annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={32,0})));
  Modelica.Blocks.Interfaces.RealOutput s_W_SOEC(final unit="W",
      displayUnit="MW") annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={106,-20}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={84,-20})));

  Electrolysis.Electrolyzers.ControlledSOEC_integratedWithHTSEplant_FY17
    controlledSOEC(
    initOpt=Electrolysis.Utilities.OptionsInit.userSpecified,
    FBctrl_TC_out_T=212.7930347,
    initType_anodePCV=Modelica.Blocks.Types.Init.SteadyState,
    initType_cathodePCV=Modelica.Blocks.Types.Init.SteadyState,
    numVessels=numVessels,
    numCells_perVessel=numCells_perVessel,
    initType_cathodeFCV=Modelica.Blocks.Types.Init.SteadyState,
    initType_anodeFCV=Modelica.Blocks.Types.Init.InitialOutput,
    FBctrl_TC_out_k=0.019944973)
    annotation (Placement(transformation(extent={{54,-14},{86,18}})));
  Electrolysis.HeatExchangers.HEX_cathodeGasRecupVessel_ROM
    hEX_cathodeGasRecup_ROM(
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.CathodeGas,
    redeclare package Medium_shell =
        Electrolysis.Media.Electrolysis.CathodeGas,
    shell_in(p(start=controlledSOEC.SOECstack.pstartCathodeAvg)),
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Electrolysis.ElectricHeaters.ToppingHeater_cathodeGasVessel_elecPort
    toppingHeater_cathodeGas(
    redeclare package Medium = Electrolysis.Media.Electrolysis.CathodeGas,
    isCircular=true,
    TC_set(displayUnit="degC") = 1123.15,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Electrolysis.Sensors.TempSensorWithThermowell TCtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    redeclare package Medium = Electrolysis.Media.Electrolysis.CathodeGas,
    y_start=850 + 273.15,
    tau=13) annotation (Placement(transformation(extent={{42,30},{62,50}})));

  Electrolysis.Sensors.TempSensorWithThermowell TAtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=850 + 273.15,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    tau=13) annotation (Placement(transformation(extent={{42,-30},{62,-50}})));
  Electrolysis.ElectricHeaters.ToppingHeater_anodeGasVessel_elecPort
    toppingHeater_anodeGas(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    isCircular=true,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    TA_set=1123.15)
    annotation (Placement(transformation(extent={{-10,-30},{10,-50}})));
  Electrolysis.HeatExchangers.HEX_anodeGasRecupVessel_ROM_NHES
    hEX_anodeGasRecup_ROM(
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    redeclare package Medium_shell =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
                                               annotation (Placement(
        transformation(extent={{-70,-30},{-50,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a cathodeIn(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas) annotation (Placement(
        transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},
            {10,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a anodeIn(redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air) annotation (Placement(
        transformation(extent={{-10,-90},{10,-110}}), iconTransformation(extent={{-10,
            -110},{10,-90}})));
equation

  connect(toppingHeater_cathodeGas.port_b, controlledSOEC.ctrlCathodeIn)
    annotation (Line(points={{10,40},{40,40},{40,6.8},{58.16,6.8}}, color=
         {0,127,255}));
  connect(TCtopping_out.y, toppingHeater_cathodeGas.s_TC_in) annotation (
      Line(points={{52,49},{52,60},{0,60},{0,51}},     color={0,0,127}));
  connect(hEX_cathodeGasRecup_ROM.tube_out, toppingHeater_cathodeGas.port_a)
    annotation (Line(points={{-50,40},{-50,40},{-10,40}},color={0,127,255}));
  connect(controlledSOEC.ctrlCathodeOut, hEX_cathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{81.84,10},{90,10},{90,70},{-60,70},{-60,50}},
                color={0,127,255}));
  connect(TAtopping_out.y, toppingHeater_anodeGas.s_TA_in) annotation (
      Line(points={{52,-49},{52,-60},{0,-60},{0,-51}},     color={0,0,127}));
  connect(toppingHeater_anodeGas.port_b, controlledSOEC.ctrlAnodeIn)
    annotation (Line(points={{10,-40},{40,-40},{40,-6.64},{58.16,-6.64}},
        color={0,127,255}));
  connect(hEX_anodeGasRecup_ROM.tube_out, toppingHeater_anodeGas.port_a)
    annotation (Line(points={{-50,-40},{-50,-40},{-10,-40}},color={0,127,
          255}));
  connect(controlledSOEC.ctrlAnodeOut, hEX_anodeGasRecup_ROM.shell_in)
    annotation (Line(points={{81.84,-3.44},{90,-3.44},{90,-70},{-60,-70},
          {-60,-50}}, color={0,127,255}));
  connect(anodeIn, anodeIn)
    annotation (Line(points={{0,-100},{0,-100}},       color={0,127,255}));
  connect(hEX_cathodeGasRecup_ROM.shell_out, cathodeOut) annotation (Line(
        points={{-60,30},{-60,20},{-100,20}}, color={0,127,255}));
  connect(hEX_anodeGasRecup_ROM.shell_out, anodeOut) annotation (Line(
        points={{-60,-30},{-60,-20},{-100,-20}}, color={0,127,255}));
  connect(cathodeIn, hEX_cathodeGasRecup_ROM.tube_in) annotation (Line(
        points={{0,100},{0,80},{-80,80},{-80,40},{-70,40}}, color={0,127,
          255}));
  connect(anodeIn, hEX_anodeGasRecup_ROM.tube_in) annotation (Line(points=
         {{0,-100},{0,-80},{-80,-80},{-80,-40},{-70,-40}}, color={0,127,
          255}));
  connect(controlledSOEC.c_pAnode, c_pAnode) annotation (Line(points={{
          71.92,-9.84},{71.92,-52},{72,-52},{72,-90},{-90,-90},{-90,-40},
          {-106,-40}}, color={0,0,127}));
  connect(controlledSOEC.c_wAnodeIn, c_wAnode) annotation (Line(points={{
          65.52,-9.84},{65.52,-9.84},{65.52,-80},{20,-80},{20,-106}},
        color={0,0,127}));
  connect(controlledSOEC.c_wCathode, c_wCathode) annotation (Line(points=
          {{66.8,11.6},{66.8,11.6},{66.8,80},{20,80},{20,106}}, color={0,
          0,127}));
  connect(controlledSOEC.c_pCathode, c_pCathode) annotation (Line(points=
          {{73.2,11.6},{73.2,88},{-90,88},{-90,40},{-106,40}}, color={0,0,
          127}));
  connect(toppingHeater_cathodeGas.port_b, TCtopping_out.port)
    annotation (Line(points={{10,40},{40,40},{40,30},{52,30}}, color={0,
          127,255}));
  connect(toppingHeater_anodeGas.port_b, TAtopping_out.port) annotation (
      Line(points={{10,-40},{40,-40},{40,-30},{52,-30}}, color={0,127,255}));
  connect(elecLoad, SY_vessel.totalElecPower) annotation (Line(
      points={{100,20},{100,20},{20,20},{20,8},{8,8}},
      color={255,0,0},
      thickness=0.5));
  connect(toppingHeater_cathodeGas.loadElecHeater, SY_vessel.load_catElecHeater)
    annotation (Line(
      points={{0,30},{0,20},{-8,20},{-8,8}},
      color={255,0,0},
      thickness=0.5));
  connect(toppingHeater_anodeGas.loadElecHeater, SY_vessel.load_anElecHeater)
    annotation (Line(
      points={{0,-30},{0,-20},{-8,-20},{-8,-8}},
      color={255,0,0},
      thickness=0.5));
  connect(SY_vessel.load_SOEC, W_SOEC.port_a) annotation (Line(
      points={{8,-8},{20,-8},{20,8.88178e-016},{24,8.88178e-016}},
      color={255,0,0},
      thickness=0.5));
  connect(controlledSOEC.ctrlElectricalLoad, W_SOEC.port_b) annotation (
      Line(
      points={{57.84,0.4},{40,0.4},{40,-9.71445e-016}},
      color={255,0,0},
      thickness=0.5));
  connect(W_SOEC.W, s_W_SOEC) annotation (Line(points={{32,-7.52},{32,-20},
          {106,-20}}, color={0,0,127}));
  annotation (defaultComponentName="HTSEvessel",
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=1200,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end HTSEvessel;
