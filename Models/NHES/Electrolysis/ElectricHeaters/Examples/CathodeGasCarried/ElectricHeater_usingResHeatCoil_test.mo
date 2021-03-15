within NHES.Electrolysis.ElectricHeaters.Examples.CathodeGasCarried;
model ElectricHeater_usingResHeatCoil_test

  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground ground
                              annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},               rotation=0,
        origin={-20,34})));
  Modelica.Electrical.Analog.Basic.Resistor heatingResistor(
    R=15,
    useHeatPort=true,
    alpha=0.00017,
    T_ref=293.15) annotation (Placement(transformation(
        origin={0,42},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
    annotation (Placement(transformation(extent={{-10,62},{10,82}})));
  Modelica.Blocks.Sources.Ramp c_current(
    duration=5,
    startTime=500,
    height=-140,
    offset=381.231)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));

  HeatedPipe_cathodeGas hEX_cathodeGasRecup_ROM(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    isCircular=true,
    diameter=0.3,
    length=2)
    annotation (Placement(transformation(extent={{-12,-68},{12,-44}})));
  Modelica.Fluid.Sources.MassFlowSource_T wCathodeFeed(
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow=4.540425,
    X=Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*1000}),
    nPorts=1,
    T=899.733)
    annotation (Placement(transformation(extent={{-62,-66},{-42,-46}})));
  Modelica.Fluid.Sources.Boundary_pT wCathodeTubeSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1964000,
    T=1123.15)
    annotation (Placement(transformation(extent={{100,-66},{80,-46}})));
  Modelica.Blocks.Sources.Ramp wCathodeTubeSignal(
    startTime=100,
    offset=4.540425,
    duration=10,
    height=-2.7236) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,-48})));
  Electrolysis.Sensors.TempSensorWithThermowell
                                   TCtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    y_start=850 + 273.15,
    tau=1)
    annotation (Placement(transformation(extent={{30,-46},{50,-26}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-18})));
  Modelica.Blocks.Sources.Constant thermalConductance(k=20470)
    annotation (Placement(transformation(extent={{-40,-28},{-20,-8}},
          rotation=0)));
  Electrolysis.Sensors.TempSensorWithThermowell
                                   TCtopping_in(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    y_start=663.061 + 273.15,
    tau=1) annotation (Placement(transformation(extent={{-38,-68},{-18,-88}})));
  ResistiveHeatingCoil resistiveHeatingCoil(C=450*131.25)
                                                        annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,12})));
equation
  connect(heatingResistor.p, signalCurrent.n) annotation (Line(points={{10,42},{
          20,42},{20,72},{10,72}}, color={0,0,255}));
  connect(heatingResistor.n, ground.p)
    annotation (Line(points={{-10,42},{-20,42},{-20,44}}, color={0,0,255}));
  connect(ground.p, signalCurrent.p)
    annotation (Line(points={{-20,44},{-20,72},{-10,72}}, color={0,0,255}));
  connect(c_current.y, signalCurrent.i)
    annotation (Line(points={{-19,90},{0,90},{0,84}}, color={0,0,127}));
  connect(wCathodeTubeSignal.y,wCathodeFeed. m_flow_in)
    annotation (Line(points={{-79,-48},{-62,-48}}, color={0,0,127}));
  connect(hEX_cathodeGasRecup_ROM.port_b,TCtopping_out. port)
    annotation (Line(points={{12,-56},{40,-56},{40,-46}},
                                                       color={0,127,255}));
  connect(wCathodeTubeSink.ports[1],hEX_cathodeGasRecup_ROM. port_b)
    annotation (Line(points={{80,-56},{80,-56},{12,-56}},
                                                       color={0,127,255}));
  connect(convection.fluid,hEX_cathodeGasRecup_ROM. heatPort)
    annotation (Line(points={{0,-28},{0,-46.4}},      color={191,0,0}));
  connect(heatingResistor.heatPort, resistiveHeatingCoil.port_a)
    annotation (Line(points={{0,32},{0,27},{0,22}}, color={191,0,0}));
  connect(thermalConductance.y, convection.Gc)
    annotation (Line(points={{-19,-18},{-10,-18}}, color={0,0,127}));
  connect(resistiveHeatingCoil.port_b, convection.solid)
    annotation (Line(points={{0,2},{0,-3},{0,-8}}, color={191,0,0}));
  connect(wCathodeFeed.ports[1], hEX_cathodeGasRecup_ROM.port_a)
    annotation (Line(points={{-42,-56},{-12,-56}}, color={0,127,255}));
  connect(TCtopping_in.port, hEX_cathodeGasRecup_ROM.port_a) annotation (
      Line(points={{-28,-68},{-28,-56},{-12,-56}}, color={0,127,255}));
  annotation (Documentation(info="<HTML>
<P>

</P>
</html>"),    experiment(StopTime=1200, Interval=1),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    __Dymola_experimentSetupOutput);
end ElectricHeater_usingResHeatCoil_test;
