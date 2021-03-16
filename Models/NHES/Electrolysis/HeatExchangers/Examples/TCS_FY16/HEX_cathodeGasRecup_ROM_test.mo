within NHES.Electrolysis.HeatExchangers.Examples.TCS_FY16;
model HEX_cathodeGasRecup_ROM_test
  import NHES.Electrolysis;

  extends Modelica.Icons.Example;
  //import SI = Modelica.SIunits;

  Electrolysis.HeatExchangers.HEX_cathodeGasRecup_ROM
    hEX_cathodeGasRecup_ROM(
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.CathodeGas,
    redeclare package Medium_shell =
        Electrolysis.Media.Electrolysis.CathodeGas,
    AhTube=75919,
    AhShell=75919,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-68,12},{-52,28}})));
  Modelica.Fluid.Sources.MassFlowSource_T wCathodeShellFeed(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow=1.35415,
    use_m_flow_in=true,
    X=Electrolysis.Utilities.moleToMassFractions({0.82,0.18}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*1000}),
    T=1023.15)
    annotation (Placement(transformation(extent={{-108,54},{-88,74}})));
  Modelica.Fluid.Sources.MassFlowSource_T wCathodeTubeFeed(
    nPorts=1,
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow=4.540425,
    T=556.55,
    X=Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*1000}))
    annotation (Placement(transformation(extent={{-102,10},{-82,30}})));
  Modelica.Fluid.Sources.Boundary_pT wCathodeShellSink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    p=1960350,
    T=618.331)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-12})));
  Modelica.Fluid.Sources.Boundary_pT wCathodeTubeSink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    p=2004000,
    T=899.733)
    annotation (Placement(transformation(extent={{162,10},{142,30}})));
  Modelica.Blocks.Sources.Ramp wCathodeTubeSignal(
    startTime=100,
    offset=4.540425,
    duration=10,
    height=-2.7236) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,28})));
  Electrolysis.Sensors.TempSensorWithThermowell TCtopping_in(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    y_start=663.061 + 273.15)
    annotation (Placement(transformation(extent={{-36,26},{-16,46}})));
  Modelica.Blocks.Sources.Ramp cathodeFlowFeed(
    offset=1.35415,
    duration=20,
    height=-0.81230,
    startTime=500)   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,72})));
equation
  connect(wCathodeTubeSignal.y, wCathodeTubeFeed.m_flow_in)
    annotation (Line(points={{-119,28},{-102,28}}, color={0,0,127}));
  connect(hEX_cathodeGasRecup_ROM.tube_out, wCathodeTubeSink.ports[1])
    annotation (Line(points={{-52,20},{-52,20},{142,20}},     color={0,127,
          255}));
  connect(wCathodeTubeFeed.ports[1], hEX_cathodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-82,20},{-68,20}},   color={0,127,255}));
  connect(hEX_cathodeGasRecup_ROM.tube_out, TCtopping_in.port) annotation (
      Line(points={{-52,20},{-26,20},{-26,26}},   color={0,127,255}));
  connect(hEX_cathodeGasRecup_ROM.shell_out, wCathodeShellSink.ports[1])
    annotation (Line(points={{-60,12},{-60,12},{-60,-2}},  color={0,127,255}));
  connect(wCathodeShellFeed.ports[1], hEX_cathodeGasRecup_ROM.shell_in)
    annotation (Line(points={{-88,64},{-60,64},{-60,28}},   color={0,127,
          255}));
  connect(wCathodeShellFeed.m_flow_in, cathodeFlowFeed.y)
    annotation (Line(points={{-108,72},{-119,72}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {140,140}})),                           Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{
            140,140}})));
end HEX_cathodeGasRecup_ROM_test;
