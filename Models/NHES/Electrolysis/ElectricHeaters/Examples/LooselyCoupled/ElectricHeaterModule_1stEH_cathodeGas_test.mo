within NHES.Electrolysis.ElectricHeaters.Examples.LooselyCoupled;
model ElectricHeaterModule_1stEH_cathodeGas_test

  extends Modelica.Icons.Example;

  Heater_cathodeGas_elecPort_LC elecHeater_cathodeGas(
    isCircular=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    initOpt=Electrolysis.Utilities.OptionsInit.userSpecified)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sensors.TempSensorWithThermowell TC_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    y_start=283.4 + 273.15)
    annotation (Placement(transformation(extent={{16,12},{36,32}})));
  Sources.LoadSink loadrSink annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Blocks.Sources.Ramp wCathode_signal(
    startTime=100,
    duration=10,
    offset=4.484656329,
    height=-2) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,8})));
  Modelica.Fluid.Sources.MassFlowSource_T wCathodeFeed(
    use_m_flow_in=true,
    m_flow=4.540425,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T=298.15)
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  Modelica.Fluid.Sources.Boundary_pT wCathodeSink(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=2045000,
    T=556.55)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
equation
  connect(elecHeater_cathodeGas.port_b, TC_out.port)
    annotation (Line(points={{10,0},{26,0},{26,12}}, color={0,127,255}));
  connect(TC_out.y, elecHeater_cathodeGas.s_TC_in) annotation (Line(points={{26,31},
          {26,38},{0,38},{0,11}},        color={0,0,127}));
  connect(elecHeater_cathodeGas.loadElecHeater, loadrSink.port_a) annotation (
     Line(
      points={{0,-10},{0,-15},{0,-20}},
      color={255,0,0},
      thickness=0.5));
  connect(wCathodeFeed.ports[1], elecHeater_cathodeGas.port_a)
    annotation (Line(points={{-42,0},{-26,0},{-10,0}}, color={0,127,255}));
  connect(wCathode_signal.y, wCathodeFeed.m_flow_in)
    annotation (Line(points={{-79,8},{-62,8}}, color={0,0,127}));
  connect(wCathodeSink.ports[1], elecHeater_cathodeGas.port_b)
    annotation (Line(points={{60,0},{35,0},{10,0}}, color={0,127,255}));
  annotation (Documentation(info="<HTML>
<P>

</P>
</html>"),    experiment(StopTime=360, Interval=0.1),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    __Dymola_experimentSetupOutput);
end ElectricHeaterModule_1stEH_cathodeGas_test;
