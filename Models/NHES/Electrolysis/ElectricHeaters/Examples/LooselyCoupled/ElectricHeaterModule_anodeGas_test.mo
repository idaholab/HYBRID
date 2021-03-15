within NHES.Electrolysis.ElectricHeaters.Examples.LooselyCoupled;
model ElectricHeaterModule_anodeGas_test

  extends Modelica.Icons.Example;

  ToppingHeater_anodeGas_elecPort_LC
                         toppingHeater_anodeGas(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    isCircular=true,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp wAnode_signal(
    startTime=100,
    duration=1,
    offset=23.2785,
    height=4.4514)          annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-88,8})));
  Modelica.Fluid.Sources.MassFlowSource_T wAnodeFeed(
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow=23.27935,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
        1000}),
    nPorts=1,
    T=795.404)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Sources.Boundary_pT wAnodeSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=1964000,
    T=1123.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{84,-10},{64,10}})));
  Sensors.TempSensorWithThermowell TAtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=850 + 273.15,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    tau=13) annotation (Placement(transformation(extent={{20,8},{40,28}})));
  Sources.LoadSink loadrSink annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
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
  connect(wAnodeSink.ports[1], toppingHeater_anodeGas.port_b)
    annotation (Line(points={{64,0},{37,0},{10,0}}, color={0,127,255}));
  connect(toppingHeater_anodeGas.loadElecHeater, loadrSink.port_a)
    annotation (Line(
      points={{0,-10},{0,-10},{0,-20}},
      color={255,0,0},
      thickness=0.5));
  annotation (Documentation(info="<HTML>
<P>

</P>
</html>"),    experiment(StopTime=800, Interval=1),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    __Dymola_experimentSetupOutput);
end ElectricHeaterModule_anodeGas_test;
