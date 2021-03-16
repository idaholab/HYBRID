within NHES.Electrolysis.Compressor.Examples;
model MultiStageCompressor_withISCs_poutCtrl
  extends Modelica.Icons.Example;

  inner Modelica.Fluid.System
                           system(allowFlowReversal=false, T_ambient=
         298.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.Boundary_pT source_anodeStream(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    use_p_in=false,
     nPorts=1,
     p=101325,
     T=288.15,
     X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
         *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}))
              annotation (Placement(transformation(extent={{-100,-10},{-80,
             10}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT sink_anodeStream(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
     p=1730700,
     T=605.838,
     nPorts=1)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
         rotation=180,
         origin={70,30})));
   CompressionSystem multiStage_Compressor
     annotation (Placement(transformation(extent={{-72,-32},{-8,8}})));
  Modelica.Fluid.Valves.ValveLinear FCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
     m_flow_nominal=23.2785,
     dp_nominal=0.3*((22.72222 - 20.45)*1e5),
     dp_start=((22.72222 - 20.45)*1e5),
     m_flow_start=23.2785,
     m_flow(start=23.2785))               annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={40,0})));
  Modelica.Blocks.Continuous.FirstOrder actuator_wAnode_in(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
     y_start=0.3)
          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,70})));
  Modelica.Blocks.Sources.Ramp actuator_wAnode_in_signal(
     offset=0.3,
     startTime=100,
     height=0.23246,
     duration=0)
     annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  HeatExchangers.HEX_nuclearHeatAnodeGasRecupVessel_ROM_NHES
    hEX_nuclearHeatAnodeGasRecup_ROM(
    redeclare package Medium_tube =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{0,10},{20,-10}})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSink_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=5130420,
    T=497.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,30})));
  Modelica.Fluid.Valves.ValveLinear TCV_anodeGas(
    m_flow_small=0.001,
    show_T=true,
    m_flow_start=TCV_anodeGas.m_flow_nominal,
    m_flow_nominal=0.850426,
    m_flow(start=TCV_anodeGas.m_flow_nominal),
    dp_start=(58 - 51.4542)*1e5,
     redeclare package Medium = Modelica.Media.Water.StandardWater,
     dp_nominal=0.3*((58 - 51.4542)*1e5))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-50,-50})));
  Modelica.Fluid.Sources.Boundary_pT steamNukeSource_anodeGas(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p=5800000,
    T=591.15) annotation (Placement(transformation(extent={{-100,-60},{-80,
             -40}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_TNOut_anodeGas(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
     y_start=0.3)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-30,-80})));
  Modelica.Blocks.Sources.Ramp actuator_TNOut_anodeGas_signal(
     duration=0,
     height=0,
     startTime=0,
     offset=0.3) annotation (Placement(transformation(
         extent={{-10,10},{10,-10}},
         rotation=180,
         origin={10,-80})));
  Modelica.Fluid.Valves.ValveLinear PCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
     m_flow_start=23.2785,
     m_flow(start=23.2785),
     m_flow_nominal=23.2785,
     dp_start=((20.45 - 17.307)*1e5),
     dp_nominal=0.4*((20.45 - 17.307)*1e5))
                                           annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={80,0})));
  Modelica.Blocks.Continuous.FirstOrder actuator_pAnSOEC(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
     y_start=0.4)
                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={62,-40})));
  Modelica.Blocks.Sources.Ramp actuator_pAnSOEC_signal(
     duration=0,
     height=0,
     startTime=0,
     offset=0.4) annotation (Placement(transformation(
         extent={{10,10},{-10,-10}},
         rotation=180,
         origin={30,-40})));
equation
   connect(source_anodeStream.ports[1], multiStage_Compressor.anodeIn)
     annotation (Line(points={{-80,0},{-80,0},{-69.6,0}},
                                                  color={0,127,255}));
   connect(actuator_wAnode_in.y, FCV_anSOEC.opening)
     annotation (Line(points={{21,70},{40,70},{40,8}}, color={0,0,127}));
   connect(actuator_wAnode_in_signal.y, actuator_wAnode_in.u)
     annotation (Line(points={{-19,70},{-2,70}}, color={0,0,127}));
   connect(multiStage_Compressor.anodeOut,
     hEX_nuclearHeatAnodeGasRecup_ROM.tube_in) annotation (Line(points={{
           -9.6,0},{-9.6,0},{0,0}}, color={0,127,255}));
   connect(TCV_anodeGas.port_b, hEX_nuclearHeatAnodeGasRecup_ROM.shell_in)
     annotation (Line(points={{-40,-50},{10,-50},{10,-10}}, color={0,127,
           255}));
   connect(steamNukeSink_anodeGas.ports[1],
     hEX_nuclearHeatAnodeGasRecup_ROM.shell_out) annotation (Line(points={
           {10,20},{10,20},{10,10}}, color={0,127,255}));
   connect(steamNukeSource_anodeGas.ports[1], TCV_anodeGas.port_a)
     annotation (Line(points={{-80,-50},{-80,-50},{-60,-50}}, color={0,127,
           255}));
   connect(actuator_TNOut_anodeGas.y, TCV_anodeGas.opening) annotation (
       Line(points={{-41,-80},{-50,-80},{-50,-58}}, color={0,0,127}));
   connect(FCV_anSOEC.port_b, PCV_anSOEC.port_a)
     annotation (Line(points={{50,0},{70,0}}, color={0,127,255}));
   connect(actuator_pAnSOEC.y, PCV_anSOEC.opening) annotation (Line(points=
          {{73,-40},{80,-40},{80,-8}}, color={0,0,127}));
   connect(sink_anodeStream.ports[1], PCV_anSOEC.port_b) annotation (Line(
         points={{80,30},{96,30},{96,0},{90,0}}, color={0,127,255}));
   connect(actuator_pAnSOEC_signal.y, actuator_pAnSOEC.u) annotation (Line(
         points={{41,-40},{45.5,-40},{50,-40}}, color={0,0,127}));
   connect(actuator_TNOut_anodeGas_signal.y, actuator_TNOut_anodeGas.u)
     annotation (Line(points={{-1,-80},{-18,-80}}, color={0,0,127}));
   connect(hEX_nuclearHeatAnodeGasRecup_ROM.tube_out, FCV_anSOEC.port_a)
     annotation (Line(points={{20,0},{25,0},{30,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
     experiment(StopTime=500, Interval=1));
end MultiStageCompressor_withISCs_poutCtrl;
