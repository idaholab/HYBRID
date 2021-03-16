within NHES.Electrolysis.HeatExchangers.Examples.LooselyCoupled;
model HEX_ETH_anodeGasRecup_ROM_LooselyCoupledNHES_test
  import NHES.Electrolysis;

  extends Modelica.Icons.Example;
  //import SI = Modelica.SIunits;

  Electrolysis.HeatExchangers.HEX_anodeGasRecup_ROM_NHES
                                                    hEX_anodeGasRecup_ROM(
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    redeclare package Medium_shell =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    coeff_dpTube=75.6613127794432,
    coeff_dpShell=58.5391785819561,
    yO2Shell_start=0.296783,
    wTube_start=23.2785,
    wShell_start=26.4648,
    AhTube=90898.7,
    AhShell=90898.7,
    TTube_in_start=298.15,
    TTube_out_start=795.404,
    TShell_out_start=605.837)
    annotation (Placement(transformation(extent={{-68,12},{-52,28}})));
  Modelica.Fluid.Sources.MassFlowSource_T wAnodeShellFeed(
    nPorts=1,
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=Electrolysis.Utilities.moleToMassFractions({0.70322,0.29678}, {
        Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,
        Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    m_flow=26.4656,
    T=1022.642)
    annotation (Placement(transformation(extent={{-108,54},{-88,74}})));

  Modelica.Fluid.Sources.Boundary_pT wAnodeShellSink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=1923000,
    T=605.837) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-12})));

  Modelica.Blocks.Sources.Ramp wAnodeShellFeed_signal(
    duration=20,
    startTime=500,
    offset=26.4648,
    height=-1.43*0)
                  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,72})));
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    m_flow=4.484668581,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    T=298.15)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.Ramp feedAnodeGas_signal(
    duration=0,
    startTime=100,
    offset=23.2785,
    height=0)        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,28})));
  Electrolysis.ElectricHeaters.ToppingHeater_anodeGas_elecPort_LC
                         toppingHeater_anodeGas(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    isCircular=true,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-8,12},{8,28}})));
  Electrolysis.Sensors.TempSensorWithThermowell TAtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=850 + 273.15,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    tau=13) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Electrolysis.Sources.LoadSink loadrSink annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-10})));
  Modelica.Fluid.Sources.Boundary_pT wAnodeSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=1964000,
    T=1123.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{102,10},{82,30}})));
equation
  connect(hEX_anodeGasRecup_ROM.shell_out, wAnodeShellSink.ports[1])
    annotation (Line(points={{-60,12},{-60,12},{-60,-2}}, color={0,127,255}));
  connect(wAnodeShellFeed.ports[1], hEX_anodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-88,64},{-60,64},{-60,28}}, color={0,127,255}));
  connect(wAnodeShellFeed.m_flow_in, wAnodeShellFeed_signal.y)
    annotation (Line(points={{-108,72},{-119,72}}, color={0,0,127}));
  connect(feedAnodeGas.ports[1], hEX_anodeGasRecup_ROM.tube_in) annotation (
      Line(points={{-80,20},{-74,20},{-68,20}}, color={0,127,255}));
  connect(feedAnodeGas_signal.y, feedAnodeGas.m_flow_in)
    annotation (Line(points={{-119,28},{-100,28}}, color={0,0,127}));
  connect(hEX_anodeGasRecup_ROM.tube_out, toppingHeater_anodeGas.port_a)
    annotation (Line(points={{-52,20},{-30,20},{-8,20}}, color={0,127,255}));
  connect(wAnodeSink.ports[1], toppingHeater_anodeGas.port_b)
    annotation (Line(points={{82,20},{82,20},{8,20}}, color={0,127,255}));
  connect(toppingHeater_anodeGas.loadElecHeater, loadrSink.port_a)
    annotation (Line(
      points={{0,12},{0,0}},
      color={255,0,0},
      thickness=0.5));
  connect(TAtopping_out.port, toppingHeater_anodeGas.port_b)
    annotation (Line(points={{30,30},{30,20},{8,20}}, color={0,127,255}));
  connect(TAtopping_out.y, toppingHeater_anodeGas.s_TA_in) annotation (Line(
        points={{30,49},{30,60},{0,60},{0,28.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -140},{140,140}})),                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,
            140}})));
end HEX_ETH_anodeGasRecup_ROM_LooselyCoupledNHES_test;
