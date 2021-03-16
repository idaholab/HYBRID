within NHES.Electrolysis.ElectricHeaters.Examples.CathodeGasCarried;
model ElectricHeater_usingGenericCapacitor_test
  extends Modelica.Icons.Example;
     Modelica.Electrical.Analog.Basic.Ground ground
                              annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},               rotation=0,
        origin={-20,24})));
  Modelica.Electrical.Analog.Basic.Resistor heatingResistor(
    R=15,
    alpha=0.00017,
    useHeatPort=true,
    T_ref=293.15) annotation (Placement(transformation(
        origin={0,32},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Modelica.Blocks.Sources.Ramp c_current(
    offset=0,
    startTime=5,
    height=381.231,
    duration=0)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Nichrome_80_20(
    der_T(fixed=true), C=450*131.25)  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={30,14})));

  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-10})));
  Modelica.Blocks.Sources.Constant thermalConductance(k=20470)
    annotation (Placement(transformation(extent={{-48,-20},{-28,0}},
          rotation=0)));
  HeatedPipe_cathodeGas hEX_cathodeGasRecup_ROM(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    isCircular=true,
    diameter=0.3,
    length=2)
    annotation (Placement(transformation(extent={{-12,-74},{12,-50}})));
  Modelica.Fluid.Sources.MassFlowSource_T wCathodeFeed(
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow=4.540425,
    X=Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*1000}),
    T=899.733,
    nPorts=1)
    annotation (Placement(transformation(extent={{-46,-72},{-26,-52}})));
  Modelica.Fluid.Sources.Boundary_pT wCathodeTubeSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1964000,
    T=1123.15)
    annotation (Placement(transformation(extent={{98,-74},{78,-54}})));
  Modelica.Blocks.Sources.Ramp wCathodeTubeSignal(
    startTime=100,
    offset=4.540425,
    duration=10,
    height=-2.7236) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-74,-54})));
  Electrolysis.Sensors.TempSensorWithThermowell
                                   TCtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    y_start=850 + 273.15)
    annotation (Placement(transformation(extent={{20,-56},{40,-36}})));
equation
  connect(heatingResistor.p, signalCurrent.n) annotation (Line(points={{10,32},{
          20,32},{20,62},{10,62}}, color={0,0,255}));
  connect(heatingResistor.n, ground.p)
    annotation (Line(points={{-10,32},{-20,32},{-20,34}}, color={0,0,255}));
  connect(ground.p, signalCurrent.p)
    annotation (Line(points={{-20,34},{-20,62},{-10,62}}, color={0,0,255}));
  connect(c_current.y, signalCurrent.i)
    annotation (Line(points={{-19,80},{0,80},{0,74}}, color={0,0,127}));
  connect(heatingResistor.heatPort, Nichrome_80_20.port)
    annotation (Line(points={{0,22},{0,14},{20,14}},    color={191,0,0}));
  connect(thermalConductance.y, convection.Gc)
    annotation (Line(points={{-27,-10},{-10,-10}}, color={0,0,127}));
  connect(convection.solid, heatingResistor.heatPort)
    annotation (Line(points={{0,0},{0,11},{0,22}}, color={191,0,0}));
  connect(wCathodeTubeSignal.y,wCathodeFeed. m_flow_in)
    annotation (Line(points={{-63,-54},{-46,-54}}, color={0,0,127}));
  connect(wCathodeFeed.ports[1], hEX_cathodeGasRecup_ROM.port_a)
    annotation (Line(points={{-26,-62},{-19,-62},{-12,-62}}, color={0,127,
          255}));
  connect(hEX_cathodeGasRecup_ROM.port_b, TCtopping_out.port) annotation (
      Line(points={{12,-62},{30,-62},{30,-56}}, color={0,127,255}));
  connect(wCathodeTubeSink.ports[1], hEX_cathodeGasRecup_ROM.port_b)
    annotation (Line(points={{78,-64},{78,-62},{12,-62}}, color={0,127,255}));
  connect(convection.fluid, hEX_cathodeGasRecup_ROM.heatPort)
    annotation (Line(points={{0,-20},{0,-52.4}}, color={191,0,0}));
  annotation (Documentation(info="<HTML>
<P>

</P>
</html>"),    experiment(StopTime=30, Interval=0.001),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    __Dymola_experimentSetupOutput);
end ElectricHeater_usingGenericCapacitor_test;
