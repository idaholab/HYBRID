within NHES.Electrolysis.HeatExchangers.Examples.TCS_FY16;
model HEX_anodeGasRecup_ROM_NHES_test
  import NHES.Electrolysis;

  extends Modelica.Icons.Example;
  //import SI = Modelica.SIunits;

  Electrolysis.HeatExchangers.HEX_anodeGasRecup_ROM_NHES
                                                    hEX_anodeGasRecup_ROM(
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    redeclare package Medium_shell =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
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

  Modelica.Fluid.Sources.MassFlowSource_T wAnodeTubeFeed(
    nPorts=1,
    use_m_flow_in=true,
    m_flow=4.540425,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    T=532.15)
    annotation (Placement(transformation(extent={{-102,10},{-82,30}})));

  Modelica.Fluid.Sources.Boundary_pT wAnodeShellSink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=1923000,
    T=605.838) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-12})));

  Modelica.Fluid.Sources.Boundary_pT wAnodeTubeSink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=2004000,
    T=1007.642)
    annotation (Placement(transformation(extent={{162,10},{142,30}})));

  Modelica.Blocks.Sources.Ramp wAnodeTubeFeed_signal(
    startTime=100,
    duration=10,
    offset=23.27935,
    height=0.4813 - 0.4813)
                    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,28})));
  Electrolysis.Sensors.TempSensorWithThermowell TAtopping_in(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    y_start=663.061 + 273.15,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-36,26},{-16,46}})));
  Modelica.Blocks.Sources.Ramp wAnodeShellFeed_signal(
    duration=20,
    startTime=500,
    offset=26.4656,
    height=-1.43) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,72})));
equation
  connect(wAnodeTubeFeed_signal.y, wAnodeTubeFeed.m_flow_in)
    annotation (Line(points={{-119,28},{-102,28}}, color={0,0,127}));
  connect(hEX_anodeGasRecup_ROM.tube_out, wAnodeTubeSink.ports[1])
    annotation (Line(points={{-52,20},{-52,20},{142,20}}, color={0,127,255}));
  connect(wAnodeTubeFeed.ports[1], hEX_anodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-82,20},{-68,20}}, color={0,127,255}));
  connect(hEX_anodeGasRecup_ROM.tube_out, TAtopping_in.port) annotation (
      Line(points={{-52,20},{-26,20},{-26,26}}, color={0,127,255}));
  connect(hEX_anodeGasRecup_ROM.shell_out, wAnodeShellSink.ports[1])
    annotation (Line(points={{-60,12},{-60,12},{-60,-2}}, color={0,127,255}));
  connect(wAnodeShellFeed.ports[1], hEX_anodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-88,64},{-60,64},{-60,28}}, color={0,127,255}));
  connect(wAnodeShellFeed.m_flow_in, wAnodeShellFeed_signal.y)
    annotation (Line(points={{-108,72},{-119,72}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {140,140}})),                           Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{
            140,140}})));
end HEX_anodeGasRecup_ROM_NHES_test;
