within NHES.Electrolysis.ElectricHeaters.Examples.AnodeGasCarried;
model ElectricHeaterModuleLoadVessel_test

  extends Modelica.Icons.Example;

  Electrolysis.ElectricHeaters.ToppingHeater_anodeGasVessel_elecPort
    toppingHeater_anodeGas(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    isCircular=true,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    TA_set=1123.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp wAnode_signal(
    startTime=100,
    height=4.4514,
    duration=1,
    offset=23.27855)        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-88,8})));
  Modelica.Fluid.Sources.MassFlowSource_T wAnodeFeed(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
        1000}),
    nPorts=1,
    m_flow=23.27855,
    use_m_flow_in=true,
    T=1007.642)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Sources.Boundary_pT wAnodeSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=1964000,
    T=1123.15)
    annotation (Placement(transformation(extent={{84,-10},{64,10}})));
  Electrolysis.Sensors.TempSensorWithThermowell TAtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=850 + 273.15,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    tau=13) annotation (Placement(transformation(extent={{20,8},{40,28}})));
  Electrolysis.Sensors.TempSensorWithThermowell TAtopping_in(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=734.492 + 273.15,
    tau=13) annotation (Placement(transformation(extent={{-34,-10},{-14,-30}})));
  Electrolysis.Sources.LoadSink elec_sink annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-30})));
equation
  connect(TAtopping_out.y, toppingHeater_anodeGas.s_TA_in) annotation (
      Line(points={{30,27},{30,27},{30,34},{0,34},{0,11}}, color={0,0,
          127}));
  connect(wAnodeFeed.ports[1], toppingHeater_anodeGas.port_a)
    annotation (Line(points={{-40,0},{-26,0},{-10,0}}, color={0,127,255}));
  connect(wAnode_signal.y, wAnodeFeed.m_flow_in) annotation (Line(
        points={{-77,8},{-68.5,8},{-60,8}}, color={0,0,127}));
  connect(toppingHeater_anodeGas.port_b, TAtopping_out.port)
    annotation (Line(points={{10,0},{30,0},{30,8}}, color={0,127,255}));
  connect(TAtopping_in.port, toppingHeater_anodeGas.port_a) annotation (
     Line(points={{-24,-10},{-24,0},{-10,0}}, color={0,127,255}));
  connect(wAnodeSink.ports[1], toppingHeater_anodeGas.port_b)
    annotation (Line(points={{64,0},{37,0},{10,0}}, color={0,127,255}));
  connect(toppingHeater_anodeGas.loadElecHeater, elec_sink.port_a)
    annotation (Line(points={{0,-10},{0,-15},{0,-20}}, color={255,0,0}));
  annotation (Documentation(info="<HTML>
<P>

</P>
</html>"),    experiment(StopTime=1200, Interval=1),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    __Dymola_experimentSetupOutput);
end ElectricHeaterModuleLoadVessel_test;
