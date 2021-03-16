within NHES.Electrolysis.ElectricHeaters.Examples.AnodeGasCarried;
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
    height=-140 + 140,
    offset=426.806)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));

  HeatedPipe_anodeGas
    hEX_anodeGasRecup_ROM(
    isCircular=true,
    diameter=0.3,
    length=2,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-12,-58},{12,-34}})));
  Modelica.Fluid.Sources.MassFlowSource_T wAnodeFeed(
    use_m_flow_in=true,
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow=23.27935,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
        1000}),
    T=1007.642)
    annotation (Placement(transformation(extent={{-62,-56},{-42,-36}})));
  Modelica.Fluid.Sources.Boundary_pT wAnodeSink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=1964000,
    T=1123.15)
    annotation (Placement(transformation(extent={{100,-56},{80,-36}})));
  Modelica.Blocks.Sources.Ramp wAnode_signal(
    startTime=100,
    duration=10,
    offset=23.27935,
    height=4.4514 - 4.4514) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,-38})));
  Electrolysis.Sensors.TempSensorWithThermowell
                                   TAtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=850 + 273.15,
    tau=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{30,-36},{50,-16}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-16})));
  Modelica.Blocks.Sources.Constant thermalConductance(k=46088)
    annotation (Placement(transformation(extent={{-40,-26},{-20,-6}},
          rotation=0)));
  ResistiveHeatingCoil                                resistiveHeatingCoil(C=450*
        371.23)
               annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,12})));
  Electrolysis.Sensors.TempSensorWithThermowell
                                   TAtopping_in(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=734.492 + 273.15)
           annotation (Placement(transformation(extent={{-38,-56},{-18,
            -76}})));
equation
  connect(heatingResistor.p, signalCurrent.n) annotation (Line(points={{10,42},{
          20,42},{20,72},{10,72}}, color={0,0,255}));
  connect(heatingResistor.n, ground.p)
    annotation (Line(points={{-10,42},{-20,42},{-20,44}}, color={0,0,255}));
  connect(ground.p, signalCurrent.p)
    annotation (Line(points={{-20,44},{-20,72},{-10,72}}, color={0,0,255}));
  connect(c_current.y, signalCurrent.i)
    annotation (Line(points={{-19,90},{0,90},{0,84}}, color={0,0,127}));
  connect(wAnode_signal.y,wAnodeFeed. m_flow_in)
    annotation (Line(points={{-79,-38},{-62,-38}},
                                               color={0,0,127}));
  connect(hEX_anodeGasRecup_ROM.port_b,TAtopping_out. port) annotation (
     Line(points={{12,-46},{40,-46},{40,-36}},
                                          color={0,127,255}));
  connect(wAnodeSink.ports[1],hEX_anodeGasRecup_ROM. port_b)
    annotation (Line(points={{80,-46},{80,-46},{12,-46}},
                                                    color={0,127,255}));
  connect(convection.fluid,hEX_anodeGasRecup_ROM. heatPort) annotation (
     Line(points={{0,-26},{0,-28},{0,-36.4}},
        color={191,0,0}));
  connect(thermalConductance.y,convection. Gc)
    annotation (Line(points={{-19,-16},{-10,-16}},
                                                 color={0,0,127}));
  connect(convection.solid,resistiveHeatingCoil. port_b)
    annotation (Line(points={{0,-6},{0,-6},{0,2}},  color={191,0,0}));
  connect(wAnodeFeed.ports[1],hEX_anodeGasRecup_ROM. port_a)
    annotation (Line(points={{-42,-46},{-12,-46}},
                                               color={0,127,255}));
  connect(TAtopping_in.port,hEX_anodeGasRecup_ROM. port_a) annotation (
      Line(points={{-28,-56},{-28,-46},{-12,-46}},
                                               color={0,127,255}));
  connect(heatingResistor.heatPort, resistiveHeatingCoil.port_a)
    annotation (Line(points={{0,32},{0,22}}, color={191,0,0}));
  annotation (Documentation(info="<HTML>
<P>

</P>
</html>"),    experiment(StopTime=1200, Interval=1),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    __Dymola_experimentSetupOutput);
end ElectricHeater_usingResHeatCoil_test;
