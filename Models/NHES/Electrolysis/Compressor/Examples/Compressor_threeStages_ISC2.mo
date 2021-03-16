within NHES.Electrolysis.Compressor.Examples;
model Compressor_threeStages_ISC2
  extends Modelica.Icons.Example;

  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=288.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  //outer Modelica.Fluid.System system "System wide properties";
  replaceable package Medium_working =
        Electrolysis.Media.Electrolysis.AnodeGas_air constrainedby
    Modelica.Media.Interfaces.PartialMedium               annotation (
      __Dymola_choicesAllMatching=true, Dialog(tab="General", group="Overall"));
  replaceable package Medium_utility =
      Modelica.Media.Water.StandardWater                                  constrainedby
    Modelica.Media.Interfaces.PartialMedium "Working fluid for the cold utility" annotation (__Dymola_choicesAllMatching=true, Dialog(tab="General", group="Overall"));

  parameter Boolean allowFlowReversal = system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction" annotation(Dialog(tab="Assumptions"));
  parameter Boolean explicitIsentropicEnthalpy=true
    "IsentropicEnthalpy function used" annotation(Dialog(tab="Assumptions"));

  parameter SI.MassFlowRate w0 = 23.2785 "Nominal gas flow rate" annotation(Dialog(tab="General", group="Overall"));

  parameter Real eta_mech0_1st = 0.98 "Mechanical efficiency" annotation(Dialog(tab="General", group="1st compressor"));
  parameter Real eta_mech0_2nd = 0.98 "Mechanical efficiency" annotation(Dialog(tab="General", group="2nd compressor"));
  parameter Real eta_mech0_3rd = 0.98 "Mechanical efficiency" annotation(Dialog(tab="General", group="3rd compressor"));

  parameter Real eta0_1st = 0.86 "Isentropic efficiency" annotation(Dialog(tab="General", group="1st compressor"));
  parameter Real eta0_2nd = 0.82 "Isentropic efficiency" annotation(Dialog(tab="General", group="2nd compressor"));
  parameter Real eta0_3rd = 0.78 "Isentropic efficiency" annotation(Dialog(tab="General", group="3rd compressor"));

  parameter Real PR0_1st = 3.04584655385761 "Nominal compression ratio" annotation(Dialog(tab="General", group="1st compressor"));
  parameter Real PR0_2nd = 3.04584655385761 "Nominal compression ratio" annotation(Dialog(tab="General", group="2nd compressor"));
  parameter Real PR0_3rd = 3.04584655385761 "Nominal compression ratio" annotation(Dialog(tab="General", group="3rd compressor"));

  Modelica.Fluid.Sources.Boundary_pT source_anodeStream(
    redeclare package Medium =
          Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    use_p_in=false,
       X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
           *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
       p=101325,
       T=288.15)
              annotation (Placement(transformation(extent={{-130,-10},{-110,10}},
          rotation=0)));

     CompressorShaft_NPT_HTSE comp_1st(
       phi_start(displayUnit="rad"),
       phi(
         displayUnit="rad",
         start=comp_1st.phi_start,
         fixed=true),
       PR0=PR0_1st,
       w0=w0,
       eta_mech0=eta_mech0_1st,
       eta0=eta0_1st,
       allowFlowReversal=allowFlowReversal,
       explicitIsentropicEnthalpy=explicitIsentropicEnthalpy,
       redeclare package Medium = Medium_working,
       pstart_in=101325,
       Tstart_in=288.15,
       Tstart_out=412.821) annotation (Placement(transformation(extent={{-86,
               -34},{-48,4}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed N_const_1st(w_fixed=
        comp_1st.N0, useSupport=false) annotation (Placement(transformation(
          extent={{-100,-24},{-82,-6}}, rotation=0)));
    HeatExchangers.ISC_anodeGas1 ISC_1st(
      initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
      TTube_in_start=comp_1st.Tstart_out,
      pTube_in_start=comp_1st.pstart_out,
      wTube_start=w0,
      redeclare package Medium_shell = Medium_utility,
      redeclare package Medium_tube = Medium_working,
      TTube_out_start=313.1554,
      TShell_out_start=298.1636)
      annotation (Placement(transformation(extent={{-48,-8},{-32,8}})));
  Modelica.Fluid.Sources.Boundary_pT sink_anodeStream(
    redeclare package Medium =
          Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
       p=101325,
       T=310.8058)
    annotation (Placement(transformation(extent={{152,-10},{132,10}})));
  Modelica.Fluid.Sources.Boundary_pT sink_chilledWater_1st(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
       p=121325,
       T=298.1636)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-70})));
  Electrolysis.Sensors.TempSensorWithThermowell Tout_ISC_1st(
      initType=Modelica.Blocks.Types.Init.SteadyState,
      tau=13,
      y_start=ISC_1st.TTube_out_start,
      redeclare package Medium = Medium_working)
      annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Modelica.Blocks.Sources.Ramp valveOpening(
       startTime=10,
       duration=0,
    offset=0.3,
       height=0.1*0)
       annotation (Placement(transformation(extent={{164,30},{144,50}})));
  Modelica.Blocks.Continuous.FirstOrder actuator_valveLinear(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.3,
    T=4) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={126,40})));
  Modelica.Fluid.Valves.ValveLinear TCV_ISC_1st(
    m_flow_small=0.001,
    show_T=true,
    allowFlowReversal=allowFlowReversal,
    m_flow_start=TCV_ISC_1st.m_flow_nominal,
    m_flow(start=TCV_ISC_1st.m_flow_nominal),
    dp_nominal=actuator_Tout_ISC_1st.y_start*((3.01325 - 2.01325)*1e5),
    m_flow_nominal=ISC_1st.wShell_start,
    redeclare package Medium = Medium_utility,
       dp_start=(3.01325 - 2.01325)*1e5) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-60,40})));
  Modelica.Blocks.Continuous.FirstOrder actuator_Tout_ISC_1st(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=0.3) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-44,68})));
  Modelica.Blocks.Sources.Ramp TCV_ISC_1st_signal(
    duration=0,
    offset=0.3,
       startTime=50,
       height=+0.3*0.5*0)
                        annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-16,68})));
  Modelica.Fluid.Sources.Boundary_pT source_chilledWater_1st(
    use_p_in=false,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
       p=301325,
       T=280.1183295)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Fluid.Valves.ValveLinear valveLinear(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
          Electrolysis.Media.Electrolysis.AnodeGas_air,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=w0,
    m_flow(start=valveLinear.m_flow_nominal),
    m_flow_start=valveLinear.m_flow_nominal,
       dp_nominal=actuator_valveLinear.y_start*(comp_3rd.pstart_in*comp_3rd.PR0
            - 1.01325*1e5),
       dp_start=(comp_3rd.pstart_in*comp_3rd.PR0 - 1.01325*1e5))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed N_const_2nd(
                     useSupport=false, w_fixed=comp_2nd.N0)
                                       annotation (Placement(transformation(
          extent={{-28,-24},{-10,-6}}, rotation=0)));
     CompressorShaft_NPT_HTSE comp_2nd(
       phi_start(displayUnit="rad"),
       phi(
         displayUnit="rad",
         start=comp_2nd.phi_start,
         fixed=true),
       pstart_in=ISC_1st.pTube_out_start,
       Tstart_in=ISC_1st.TTube_out_start,
       PR0=PR0_2nd,
       w0=w0,
       allowFlowReversal=allowFlowReversal,
       explicitIsentropicEnthalpy=explicitIsentropicEnthalpy,
       redeclare package Medium = Medium_working,
       eta_mech0=eta_mech0_2nd,
       eta0=eta0_2nd,
       pin0=comp_2nd.pstart_in,
       Tin0=comp_2nd.Tstart_in,
       Tstart_out=454.737) annotation (Placement(transformation(extent={{-14,
               -34},{24,4}}, rotation=0)));

    HeatExchangers.ISC_anodeGas2 ISC_2nd(
      redeclare package Medium_tube = Medium_working,
      redeclare package Medium_shell = Medium_utility,
      initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
      pTube_in_start=comp_2nd.pstart_out,
      TTube_in_start=comp_2nd.Tstart_out,
      wTube_start=w0,
      TTube_out_start=313.1558,
      TShell_out_start=298.1639)
      annotation (Placement(transformation(extent={{24,-8},{40,8}})));
  Electrolysis.Sensors.TempSensorWithThermowell Tout_ISC_2nd(
      initType=Modelica.Blocks.Types.Init.SteadyState,
      tau=13,
      redeclare package Medium = Medium_working,
      y_start=ISC_2nd.TTube_out_start)
      annotation (Placement(transformation(extent={{42,10},{62,30}})));
  Modelica.Fluid.Valves.ValveLinear TCV_ISC_2nd(
       m_flow_small=0.001,
       show_T=true,
       allowFlowReversal=allowFlowReversal,
       redeclare package Medium = Medium_utility,
       m_flow_nominal=ISC_2nd.wShell_start,
       m_flow_start=TCV_ISC_2nd.m_flow_nominal,
       m_flow(start=TCV_ISC_2nd.m_flow_nominal),
       dp_nominal=actuator_Tout_ISC_2nd.y_start*((3.01325 - 2.01325)*1e5),
       dp_start=(3.01325 - 2.01325)*1e5)
       annotation (Placement(transformation(
           extent={{10,10},{-10,-10}},
           rotation=180,
           origin={10,40})));
  Modelica.Fluid.Sources.Boundary_pT source_chilledWater_2nd(
       use_p_in=false,
       nPorts=1,
       redeclare package Medium = Modelica.Media.Water.StandardWater,
       p=301325,
       T=280.1183295)
       annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Blocks.Sources.Ramp TCV_ISC_2nd_signal(
       duration=0,
       offset=0.3,
       startTime=50,
       height=+0.3*0.5*0) annotation (Placement(transformation(
           extent={{-8,8},{8,-8}},
           rotation=180,
           origin={54,68})));
  Modelica.Blocks.Continuous.FirstOrder actuator_Tout_ISC_2nd(
       k=1,
       initType=Modelica.Blocks.Types.Init.SteadyState,
       T=4,
       y_start=0.3) annotation (Placement(transformation(
           extent={{8,-8},{-8,8}},
           rotation=0,
           origin={26,68})));
  Modelica.Fluid.Sources.Boundary_pT sink_chilledWater_2nd(
       nPorts=1,
       redeclare package Medium = Modelica.Media.Water.StandardWater,
       p=121325,
       T=298.1639) annotation (Placement(transformation(
           extent={{-10,-10},{10,10}},
           rotation=90,
           origin={32,-72})));
     CompressorShaft_NPT_HTSE comp_3rd(
       phi_start(displayUnit="rad"),
       w0=w0,
       allowFlowReversal=allowFlowReversal,
       explicitIsentropicEnthalpy=explicitIsentropicEnthalpy,
       redeclare package Medium = Medium_working,
       eta_mech0=eta_mech0_3rd,
       eta0=eta0_3rd,
       PR0=PR0_3rd,
       phi(
         displayUnit="rad",
         start=comp_3rd.phi_start,
         fixed=true),
       pstart_in=ISC_2nd.pTube_out_start,
       Tstart_in=ISC_2nd.TTube_out_start,
       pin0=comp_3rd.pstart_in,
       Tin0=comp_3rd.Tstart_in,
       Tstart_out=461.928) annotation (Placement(transformation(extent={{58,
               -34},{96,4}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed N_const_3rd(useSupport=
          false, w_fixed=comp_3rd.N0) annotation (Placement(transformation(
             extent={{44,-24},{62,-6}}, rotation=0)));
equation

  connect(source_anodeStream.ports[1], comp_1st.inlet) annotation (Line(points={{-110,0},
             {-78.4,0},{-78.4,0.2}},       color={0,127,255}));
  connect(comp_1st.shaft_a, N_const_1st.flange) annotation (Line(points={{-78.4,
             -15},{-78.4,-15},{-82,-15}},
                                       color={0,0,0}));
  connect(ISC_1st.tube_in, comp_1st.outlet) annotation (Line(points={{-48,0},
             {-48,0.2},{-55.6,0.2}},
                             color={0,127,255}));
  connect(sink_chilledWater_1st.ports[1], ISC_1st.shell_out) annotation (Line(
        points={{-40,-60},{-40,-8}},           color={0,127,255}));
  connect(valveOpening.y, actuator_valveLinear.u)
    annotation (Line(points={{143,40},{143,40},{138,40}},
                                                 color={0,0,127}));
  connect(source_chilledWater_1st.ports[1], TCV_ISC_1st.port_a)
    annotation (Line(points={{-80,40},{-80,40},{-70,40}}, color={0,127,255}));
  connect(TCV_ISC_1st.port_b, ISC_1st.shell_in)
    annotation (Line(points={{-50,40},{-40,40},{-40,8}}, color={0,127,255}));
  connect(actuator_Tout_ISC_1st.u, TCV_ISC_1st_signal.y)
    annotation (Line(points={{-34.4,68},{-24.8,68}}, color={0,0,127}));
  connect(TCV_ISC_1st.opening, actuator_Tout_ISC_1st.y)
    annotation (Line(points={{-60,48},{-60,68},{-52.8,68}}, color={0,0,127}));
  connect(valveLinear.opening, actuator_valveLinear.y)
    annotation (Line(points={{110,8},{110,40},{115,40}},
                                                      color={0,0,127}));
  connect(sink_anodeStream.ports[1], valveLinear.port_b)
    annotation (Line(points={{132,0},{120,0}},         color={0,127,255}));
  connect(ISC_1st.tube_out, comp_2nd.inlet)
    annotation (Line(points={{-32,0},{-6.4,0},{-6.4,0.2}}, color={0,127,255}));
  connect(N_const_2nd.flange, comp_2nd.shaft_a)
    annotation (Line(points={{-10,-15},{-10,-15},{-6.4,-15}}, color={0,0,0}));
  connect(Tout_ISC_1st.port, ISC_1st.tube_out)
    annotation (Line(points={{-20,10},{-20,0},{-32,0}}, color={0,127,255}));
     connect(ISC_2nd.tube_in, comp_2nd.outlet) annotation (Line(points={{24,
             0},{16.4,0},{16.4,0.2}}, color={0,127,255}));
     connect(source_chilledWater_2nd.ports[1], TCV_ISC_2nd.port_a)
       annotation (Line(points={{-10,40},{-10,40},{0,40}}, color={0,127,255}));
     connect(TCV_ISC_2nd_signal.y, actuator_Tout_ISC_2nd.u)
       annotation (Line(points={{45.2,68},{35.6,68}}, color={0,0,127}));
     connect(actuator_Tout_ISC_2nd.y, TCV_ISC_2nd.opening) annotation (Line(
           points={{17.2,68},{10,68},{10,48}}, color={0,0,127}));
     connect(ISC_2nd.shell_in, TCV_ISC_2nd.port_b) annotation (Line(points={
             {32,8},{32,40},{20,40}}, color={0,127,255}));
     connect(sink_chilledWater_2nd.ports[1], ISC_2nd.shell_out)
       annotation (Line(points={{32,-62},{32,-8}}, color={0,127,255}));
     connect(valveLinear.port_a, comp_3rd.outlet) annotation (Line(points={{
             100,0},{100,0.2},{88.4,0.2}}, color={0,127,255}));
     connect(ISC_2nd.tube_out, comp_3rd.inlet) annotation (Line(points={{40,
             0},{65.6,0},{65.6,0.2}}, color={0,127,255}));
     connect(Tout_ISC_2nd.port, ISC_2nd.tube_out)
       annotation (Line(points={{52,10},{52,0},{40,0}}, color={0,127,255}));
     connect(comp_3rd.shaft_a, N_const_3rd.flange)
       annotation (Line(points={{65.6,-15},{62,-15}}, color={0,0,0}));
  annotation (
    experiment(
      StopTime=100,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    experimentSetupOutput,
    Documentation(info="<html>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
               {100,100}})));
end Compressor_threeStages_ISC2;
