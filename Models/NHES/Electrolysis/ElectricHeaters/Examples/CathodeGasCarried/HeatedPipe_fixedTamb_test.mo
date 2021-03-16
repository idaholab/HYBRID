within NHES.Electrolysis.ElectricHeaters.Examples.CathodeGasCarried;
model HeatedPipe_fixedTamb_test
  import NHES.Electrolysis;

  extends Modelica.Icons.Example;
  //import SI = Modelica.SIunits;

  Electrolysis.ElectricHeaters.BaseClasses.HeatedPipe_fixedTamb
    hEX_cathodeGasRecup_ROM(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-12,6},{12,30}})));
  Modelica.Fluid.Sources.MassFlowSource_T wCathodeFeed(
    nPorts=1,
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow=4.540425,
    X=Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*
        1000}),
    T=899.733)
    annotation (Placement(transformation(extent={{-46,8},{-26,28}})));

  Modelica.Fluid.Sources.Boundary_pT wCathodeTubeSink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    p=1964000,
    T=1123.15)
    annotation (Placement(transformation(extent={{80,8},{60,28}})));

  Modelica.Blocks.Sources.Ramp wCathodeTubeSignal(
    startTime=100,
    offset=4.540425,
    duration=10,
    height=-2.7236) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-74,26})));
  Electrolysis.Sensors.TempSensorWithThermowell
                                   TCtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    y_start=850 + 273.15)
    annotation (Placement(transformation(extent={{20,24},{40,44}})));

equation
  connect(wCathodeTubeSignal.y, wCathodeFeed.m_flow_in)
    annotation (Line(points={{-63,26},{-46,26}},   color={0,0,127}));
  connect(wCathodeFeed.ports[1], hEX_cathodeGasRecup_ROM.port_a)
    annotation (Line(points={{-26,18},{-12,18}}, color={0,127,255}));
  connect(hEX_cathodeGasRecup_ROM.port_b, wCathodeTubeSink.ports[1])
    annotation (Line(points={{12,18},{60,18}},   color={0,127,255}));
  connect(hEX_cathodeGasRecup_ROM.port_b, TCtopping_out.port) annotation (
     Line(points={{12,18},{30,18},{30,24}},    color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}})),                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,120}})),
    experiment(StopTime=1000, Interval=0.1),
    __Dymola_experimentSetupOutput);
end HeatedPipe_fixedTamb_test;
