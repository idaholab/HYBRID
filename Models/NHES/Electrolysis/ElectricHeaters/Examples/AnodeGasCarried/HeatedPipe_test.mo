within NHES.Electrolysis.ElectricHeaters.Examples.AnodeGasCarried;
model HeatedPipe_test
  import NHES.Electrolysis;

  extends Modelica.Icons.Example;

  //import SI = Modelica.SIunits;

  Electrolysis.ElectricHeaters.HeatedPipe_anodeGas
    hEX_anodeGasRecup_ROM(
    isCircular=true,
    diameter=0.3,
    length=2,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-12,-12},{12,12}})));
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
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  Modelica.Fluid.Sources.Boundary_pT wAnodeSink(
    nPorts=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    p=1964000,
    T=1123.15)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Modelica.Blocks.Sources.Ramp wAnode_signal(
    startTime=100,
    duration=10,
    offset=23.27935,
    height=4.4514 - 4.4514) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,8})));
  Electrolysis.Sensors.TempSensorWithThermowell
                                   TAtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=850 + 273.15,
    tau=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(alpha=0, Q_flow=
        3.12265*1e6)       annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={0,86})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,30})));
  Modelica.Blocks.Sources.Constant thermalConductance(k=46088)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}},
          rotation=0)));
  Electrolysis.ElectricHeaters.ResistiveHeatingCoil
    resistiveHeatingCoil(C=450*371.23) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,58})));
  Electrolysis.Sensors.TempSensorWithThermowell
                                   TAtopping_in(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=1,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=734.492 + 273.15)
           annotation (Placement(transformation(extent={{-38,-10},{-18,
            -30}})));
equation
  connect(wAnode_signal.y, wAnodeFeed.m_flow_in)
    annotation (Line(points={{-79,8},{-62,8}}, color={0,0,127}));
  connect(hEX_anodeGasRecup_ROM.port_b, TAtopping_out.port) annotation (
     Line(points={{12,0},{40,0},{40,10}}, color={0,127,255}));
  connect(wAnodeSink.ports[1], hEX_anodeGasRecup_ROM.port_b)
    annotation (Line(points={{80,0},{80,0},{12,0}}, color={0,127,255}));
  connect(convection.fluid, hEX_anodeGasRecup_ROM.heatPort) annotation (
     Line(points={{-6.66134e-016,20},{-6.66134e-016,18},{0,18},{0,9.6}},
        color={191,0,0}));
  connect(thermalConductance.y, convection.Gc)
    annotation (Line(points={{-19,30},{-10,30}}, color={0,0,127}));
  connect(convection.solid, resistiveHeatingCoil.port_b)
    annotation (Line(points={{4.44089e-016,40},{0,40},{0,48}},
                                                    color={191,0,0}));
  connect(resistiveHeatingCoil.port_a, fixedHeatFlow.port) annotation (Line(
        points={{0,68},{0,76},{-6.66134e-016,76}}, color={191,0,0}));
  connect(wAnodeFeed.ports[1], hEX_anodeGasRecup_ROM.port_a)
    annotation (Line(points={{-42,0},{-12,0}}, color={0,127,255}));
  connect(TAtopping_in.port, hEX_anodeGasRecup_ROM.port_a) annotation (
      Line(points={{-28,-10},{-28,0},{-12,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    experiment(StopTime=500, Interval=1),
    __Dymola_experimentSetupOutput);
end HeatedPipe_test;
