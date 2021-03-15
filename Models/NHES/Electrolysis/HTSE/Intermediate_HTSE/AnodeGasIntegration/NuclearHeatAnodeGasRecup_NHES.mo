within NHES.Electrolysis.HTSE.Intermediate_HTSE.AnodeGasIntegration;
model NuclearHeatAnodeGasRecup_NHES
  import NHES.Electrolysis;

  extends Modelica.Icons.Example;
  //import SI = Modelica.SIunits;

  Electrolysis.HeatExchangers.HEX_nuclearHeatAnodeGasRecup_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    AhShell=hEX_nuclearHeatAnodeGasRecup_ROM.AhTube*1.35)
    annotation (Placement(transformation(extent={{-68,-8},{-52,8}})));

  Modelica.Fluid.Sources.MassFlowSource_T steamNukeFeed_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=3.09452,
    nPorts=1,
    T=574.698)
              annotation (Placement(transformation(extent={{-118,30},{
            -98,50}})));
  Modelica.Fluid.Sources.MassFlowSource_T feedAnodeGas(
    use_m_flow_in=true,
    m_flow=4.484668581,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    T=298.15,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*
        1000})) annotation (Placement(transformation(extent={{-102,-10},
            {-82,10}})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSink_recupOnly(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=2045000,
    T=532.15)
    annotation (Placement(transformation(extent={{162,-10},{142,10}})));
  Modelica.Blocks.Sources.Ramp feedAnodeGas_signal(
    duration=0,
    startTime=100,
    height=4.9795,
    offset=23.2794)  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,8})));
  Electrolysis.Sensors.TempSensorWithThermowell TNOut_anodeGasSensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    y_start=259 + 273.15)
    annotation (Placement(transformation(extent={{-42,14},{-22,34}})));
  Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    offset=259 + 273.15)
                  annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-4,92})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    k=1,
    T=4,
    y_start=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start)
         annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-92,92})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_anodeGas1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=4317930,
    T=465.838)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-30})));
  Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_anodeGas(
    yMin=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start*0.1,
    y_start=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    y(start=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start),
    xi_start=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start/
        FBctrl_TNOut_anodeGas.k,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=0.004,
    Ti=10,
    gainPID(y(start=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start)),
    yMax=hEX_nuclearHeatAnodeGasRecup_ROM.wShell_start*3) annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-32,92})));
equation
  connect(feedAnodeGas.ports[1], hEX_nuclearHeatAnodeGasRecup_ROM.tube_in)
    annotation (Line(points={{-82,0},{-75,0},{-68,0}}, color={0,127,255}));
  connect(feedAnodeGas_signal.y, feedAnodeGas.m_flow_in)
    annotation (Line(points={{-119,8},{-102,8}}, color={0,0,127}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_in,
    steamNukeFeed_anodeGas.ports[1]) annotation (Line(points={{-60,8},{
          -60,40},{-98,40}},  color={0,127,255}));
  connect(anodeGasSink_recupOnly.ports[1],
    hEX_nuclearHeatAnodeGasRecup_ROM.tube_out) annotation (Line(points=
          {{142,0},{45,0},{-52,0}}, color={0,127,255}));
  connect(TNOut_anodeGasSensor.port, hEX_nuclearHeatAnodeGasRecup_ROM.tube_out)
    annotation (Line(points={{-32,14},{-32,0},{-52,0}}, color={0,127,
          255}));
  connect(actuator_TNOut_anodeGas.y, steamNukeFeed_anodeGas.m_flow_in)
    annotation (Line(points={{-100.8,92},{-130,92},{-130,48},{-118,48}},
        color={0,0,127}));
  connect(hEX_nuclearHeatAnodeGasRecup_ROM.shell_out,
    steamNukeSink_anodeGas1.ports[1])
    annotation (Line(points={{-60,-8},{-60,-20}}, color={0,127,255}));
  connect(FBctrl_TNOut_anodeGas.u_s, TNOut_anodeGas_set.y)
    annotation (Line(points={{-22.4,92},{-12.8,92}}, color={0,0,127}));
  connect(TNOut_anodeGasSensor.y, FBctrl_TNOut_anodeGas.u_m)
    annotation (Line(points={{-32,33},{-32,82.4}}, color={0,0,127}));
  connect(FBctrl_TNOut_anodeGas.y, actuator_TNOut_anodeGas.u)
    annotation (Line(points={{-40.8,92},{-82.4,92}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {140,140}})),                           Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {140,140}})));
end NuclearHeatAnodeGasRecup_NHES;
