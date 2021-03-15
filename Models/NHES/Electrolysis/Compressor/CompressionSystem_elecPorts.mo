within NHES.Electrolysis.Compressor;
model CompressionSystem_elecPorts

  outer Modelica.Fluid.System system "System wide properties";
  replaceable package Medium_working =
        Electrolysis.Media.Electrolysis.AnodeGas_air constrainedby
    Modelica.Media.Interfaces.PartialMedium               annotation (
      __Dymola_choicesAllMatching=true, Dialog(tab="General", group="Overall"));
  replaceable package Medium_utility = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Working fluid for the cold utility" annotation (__Dymola_choicesAllMatching=true, Dialog(tab="General", group="Overall"));

  parameter Boolean allowFlowReversal = system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction" annotation(Dialog(tab="Assumptions"));
  parameter Boolean explicitIsentropicEnthalpy=true
    "IsentropicEnthalpy function used" annotation(Dialog(tab="Assumptions"));
  parameter SI.MassFlowRate w0 = 23.2785 "Nominal gas flow rate" annotation(Dialog(tab="General", group="Overall"));
  parameter SI.MassFraction X0[ :] = Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
  *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}) "Nominal mass fraction" annotation(Dialog(tab="General", group="Overall"));

  parameter Real eta_mech0_1st = 0.98 "Mechanical efficiency" annotation(Dialog(tab="General", group="1st compressor"));
  parameter Real eta_mech0_2nd = 0.98 "Mechanical efficiency" annotation(Dialog(tab="General", group="2nd compressor"));
  parameter Real eta_mech0_3rd = 0.98 "Mechanical efficiency" annotation(Dialog(tab="General", group="3rd compressor"));

  parameter Real eta0_1st = 0.86 "Isentropic efficiency" annotation(Dialog(tab="General", group="1st compressor"));
  parameter Real eta0_2nd = 0.82 "Isentropic efficiency" annotation(Dialog(tab="General", group="2nd compressor"));
  parameter Real eta0_3rd = 0.78 "Isentropic efficiency" annotation(Dialog(tab="General", group="3rd compressor"));

  parameter Real PR0_1st = 3.04584655385761 "Nominal compression ratio" annotation(Dialog(tab="General", group="1st compressor"));
  parameter Real PR0_2nd = 3.04584655385761 "Nominal compression ratio" annotation(Dialog(tab="General", group="2nd compressor"));
  parameter Real PR0_3rd = 3.04584655385761 "Nominal compression ratio" annotation(Dialog(tab="General", group="3rd compressor"));

  SI.Power Wc_total(min=0,displayUnit="MW")
   "Power requirement to drive a multi-stage compressor";

     CompressorShaft_NPT_HTSE comp_1st(
       phi_start(displayUnit="rad"),
       phi(
         displayUnit="rad",
         start=comp_1st.phi_start,
         fixed=true),
       PR0=PR0_1st,
       eta_mech0=eta_mech0_1st,
       eta0=eta0_1st,
       allowFlowReversal=allowFlowReversal,
       explicitIsentropicEnthalpy=explicitIsentropicEnthalpy,
       redeclare package Medium = Medium_working,
       pin0=comp_1st.pstart_in,
       Tin0=comp_1st.Tstart_in,
       thetaIGV0=thetaIGV0_1st,
       use_in_thetaIGV=true,
       w0=w0/0.65,
       pstart_in=101325,
       Tstart_in=288.15,
       Tstart_out=412.821,
       Xstart=X0) annotation (Placement(transformation(extent={{-106,-34},{-68,
               4}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed N_const_1st(w_fixed=
        comp_1st.N0, useSupport=false) annotation (Placement(transformation(
          extent={{-118,-22},{-104,-8}},rotation=0)));
    HeatExchangers.ISC_anodeGas1 ISC_1st(
      TTube_in_start=comp_1st.Tstart_out,
      pTube_in_start=comp_1st.pstart_out,
      wTube_start=w0,
      redeclare package Medium_shell = Medium_utility,
      redeclare package Medium_tube = Medium_working,
      initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
      TTube_out_start=313.1554,
      TShell_out_start=298.1636)
      annotation (Placement(transformation(extent={{-62,-8},{-46,8}})));
  Modelica.Fluid.Sources.Boundary_pT sink_chilledWater(
       redeclare package Medium = Medium_utility,
       nPorts=1,
       p=121325,
       T=298.1639) annotation (Placement(transformation(
           extent={{10,-10},{-10,10}},
           rotation=0,
           origin={56,-50})));
  Electrolysis.Sensors.TempSensorWithThermowell Tout_ISC_1st(
      initType=Modelica.Blocks.Types.Init.SteadyState,
      tau=13,
      y_start=ISC_1st.TTube_out_start,
      redeclare package Medium = Medium_working)
      annotation (Placement(transformation(extent={{-46,10},{-26,30}})));
     Modelica.Fluid.Valves.ValveLinear TCV_ISC_1st(
       m_flow_small=0.001,
       show_T=true,
       allowFlowReversal=allowFlowReversal,
       m_flow_start=TCV_ISC_1st.m_flow_nominal,
       m_flow_nominal=ISC_1st.wShell_start,
       redeclare package Medium = Medium_utility,
       dp_nominal=TCV_ISC_1st_signal.k*(source_chilledWater.p - 2.01325*1e5),
       dp_start=(source_chilledWater.p - 2.01325*1e5),
       m_flow(start=TCV_ISC_1st.m_flow_nominal)) annotation (Placement(
           transformation(
           extent={{-10,10},{10,-10}},
           rotation=270,
           origin={-54,50})));
  Modelica.Fluid.Sources.Boundary_pT source_chilledWater(
       use_p_in=false,
       redeclare package Medium = Medium_utility,
       p=301325,
       T=280.1183295,
       nPorts=1) annotation (Placement(transformation(
           extent={{10,10},{-10,-10}},
           rotation=180,
           origin={-90,90})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed N_const_2nd(
                     useSupport=false, w_fixed=comp_2nd.N0)
                                       annotation (Placement(transformation(
          extent={{-44,-22},{-30,-8}}, rotation=0)));
     CompressorShaft_NPT_HTSE comp_2nd(
       phi_start(displayUnit="rad"),
       phi(
         displayUnit="rad",
         start=comp_2nd.phi_start,
         fixed=true),
       pstart_in=ISC_1st.pTube_out_start,
       Tstart_in=ISC_1st.TTube_out_start,
       PR0=PR0_2nd,
       allowFlowReversal=allowFlowReversal,
       explicitIsentropicEnthalpy=explicitIsentropicEnthalpy,
       redeclare package Medium = Medium_working,
       eta_mech0=eta_mech0_2nd,
       eta0=eta0_2nd,
       pin0=comp_2nd.pstart_in,
       Tin0=comp_2nd.Tstart_in,
       thetaIGV0=thetaIGV0_2nd,
       w0=w0,
       Tstart_out=454.737,
       Xstart=X0) annotation (Placement(transformation(extent={{-32,-34},{6,4}},
             rotation=0)));

    HeatExchangers.ISC_anodeGas2 ISC_2nd(
      redeclare package Medium_tube = Medium_working,
      redeclare package Medium_shell = Medium_utility,
      pTube_in_start=comp_2nd.pstart_out,
      TTube_in_start=comp_2nd.Tstart_out,
      wTube_start=w0,
      initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
      TTube_out_start=313.1558,
      TShell_out_start=298.1639)
      annotation (Placement(transformation(extent={{12,-8},{28,8}})));
  Electrolysis.Sensors.TempSensorWithThermowell Tout_ISC_2nd(
      initType=Modelica.Blocks.Types.Init.SteadyState,
      tau=13,
      redeclare package Medium = Medium_working,
      y_start=ISC_2nd.TTube_out_start)
      annotation (Placement(transformation(extent={{30,10},{50,30}})));
     Modelica.Fluid.Valves.ValveLinear TCV_ISC_2nd(
       m_flow_small=0.001,
       show_T=true,
       allowFlowReversal=allowFlowReversal,
       redeclare package Medium = Medium_utility,
       m_flow_nominal=ISC_2nd.wShell_start,
       m_flow_start=TCV_ISC_2nd.m_flow_nominal,
       m_flow(start=TCV_ISC_2nd.m_flow_nominal),
       dp_start=(source_chilledWater.p - 2.01325*1e5),
       dp_nominal=TCV_ISC_2nd_signal.k*(source_chilledWater.p - 2.01325*1e5))
       annotation (Placement(transformation(
           extent={{-10,-10},{10,10}},
           rotation=270,
           origin={20,50})));
     CompressorShaft_NPT_HTSE comp_3rd(
       phi_start(displayUnit="rad"),
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
       thetaIGV0=thetaIGV0_3rd,
       use_in_thetaIGV=false,
       w0=w0,
       Tstart_out=461.928,
       Xstart=X0) annotation (Placement(transformation(extent={{46,-34},{84,4}},
             rotation=0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed N_const_3rd(useSupport=false,
      w_fixed=comp_3rd.N0) annotation (Placement(transformation(extent={{34,-22},
               {48,-8}},
                      rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_a anodeIn(redeclare package Medium =
           Medium_working) annotation (Placement(transformation(extent={{-130,
               -10},{-110,10}}),iconTransformation(extent={{-158,50},{-138,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b anodeOut(redeclare package Medium =
           Medium_working) annotation (Placement(transformation(extent={{110,-10},
               {130,10}}),      iconTransformation(extent={{142,50},{162,70}})));
    Fittings.BaseClasses.Junction_anodeStream junction(
      redeclare package Medium = Medium_working,
      T_start=comp_3rd.Tstart_out,
      p_start=comp_3rd.pstart_out)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  parameter Electrolysis.Types.ThetaIGV thetaIGV0_1st=50.1289277721195
      "Nominal IGV angle" annotation (Dialog(group="1st compressor"));
  parameter Electrolysis.Types.ThetaIGV thetaIGV0_2nd=85 "Nominal IGV angle"
                          annotation (Dialog(group="2nd compressor"));
  parameter Electrolysis.Types.ThetaIGV thetaIGV0_3rd=85 "Nominal IGV angle"
                          annotation (Dialog(group="3rd compressor"));
  Modelica.Fluid.Sensors.Pressure pout_mes(redeclare package Medium =
        Medium_working)
    annotation (Placement(transformation(extent={{96,-90},{76,-110}})));
  Modelica.Blocks.Sources.Ramp pout_set(
    duration=0,
    height=0,
    startTime=0,
    y(unit="Pa", displayUnit="bar"),
    offset=23.7020628982604e5) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,-80})));
  Modelica.Blocks.Math.Gain pout_pu(y(unit="1"), k=1/pout_set.offset)
    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-14,-80})));
  Modelica.Blocks.Math.Feedback FB_pout
    annotation (Placement(transformation(extent={{30,-90},{10,-70}})));
  Modelica.Blocks.Math.Gain thetaIGV(y(unit="deg"), k=thetaIGV0_3rd)
       annotation (Placement(transformation(
           extent={{-6,6},{6,-6}},
           rotation=180,
           origin={-86,-80})));
  Controllers.LimI_antiWindup FBctrl_pout(
    y_max=1,
    xi_start=FBctrl_pout.y_start,
    uRamp_min=-FBctrl_pout.uRamp_max,
    uRamp_max=0.016,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=50.1289277721195/thetaIGV0_3rd,
    y_min=46.699179272248/thetaIGV0_3rd,
    Ti=250/822.15)
    annotation (Placement(transformation(extent={{-40,-90},{-60,-70}})));
     Modelica.Blocks.Sources.Constant TCV_ISC_1st_signal(k=0.3)
       annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
     Modelica.Blocks.Sources.Constant TCV_ISC_2nd_signal(k=0.3)
       annotation (Placement(transformation(extent={{66,40},{46,60}})));
     Modelica.Fluid.Fittings.TeeJunctionVolume flowSplit(
       redeclare package Medium = Medium_utility,
       p_start=source_chilledWater.p,
       T_start=source_chilledWater.T,
       use_T_start=true,
       energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
       massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
       V=8,
       port_2(m_flow(start=75.8861)))
       annotation (Placement(transformation(extent={{-44,100},{-64,80}})));
     Modelica.Fluid.Fittings.TeeJunctionVolume flowJoin(
       redeclare package Medium = Medium_utility,
       T_start=source_chilledWater.T,
       use_T_start=true,
       energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
       massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
       V=8,
       p_start=sink_chilledWater.p)
       annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
    Interfaces.ElectricalPowerPort_a loadElec_comp annotation (Placement(
          transformation(extent={{-10,110},{10,130}}), iconTransformation(
            extent={{-6,94},{6,106}})));
  Modelica.Blocks.Sources.RealExpression W_comps(y=Wc_total)
       annotation (Placement(transformation(extent={{40,94},{20,114}})));
    Sources.PrescribedLoad load_comps annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={0,102})));
equation

  Wc_total = comp_1st.Wc + comp_2nd.Wc + comp_3rd.Wc;
  connect(comp_1st.shaft_a, N_const_1st.flange) annotation (Line(points={{-98.4,
             -15},{-98.4,-15},{-104,-15}},
                                       color={0,0,0}));
  connect(ISC_1st.tube_in, comp_1st.outlet) annotation (Line(points={{-62,0},{
             -62,0.2},{-75.6,0.2}},
                             color={0,127,255}));
  connect(TCV_ISC_1st.port_b, ISC_1st.shell_in)
    annotation (Line(points={{-54,40},{-54,40},{-54,8}}, color={0,127,255}));
  connect(N_const_2nd.flange, comp_2nd.shaft_a)
    annotation (Line(points={{-30,-15},{-30,-15},{-24.4,-15}},color={0,0,0}));
  connect(Tout_ISC_1st.port, ISC_1st.tube_out)
    annotation (Line(points={{-36,10},{-36,0},{-46,0}}, color={0,127,255}));
  connect(ISC_2nd.shell_in, TCV_ISC_2nd.port_b)
    annotation (Line(points={{20,8},{20,22},{20,40}}, color={0,127,255}));
  connect(Tout_ISC_2nd.port, ISC_2nd.tube_out)
    annotation (Line(points={{40,10},{40,0},{28,0}}, color={0,127,255}));
  connect(comp_3rd.shaft_a, N_const_3rd.flange)
    annotation (Line(points={{53.6,-15},{53.6,-15},{48,-15}},
                                                   color={0,0,0}));
     connect(anodeIn, comp_1st.inlet) annotation (Line(points={{-120,0},{-98.4,
             0},{-98.4,0.2}}, color={0,127,255}));
     connect(anodeIn, anodeIn)
       annotation (Line(points={{-120,0},{-120,0}}, color={0,127,255}));
     connect(ISC_1st.tube_out, comp_2nd.inlet) annotation (Line(points={{-46,0},
             {-24.4,0},{-24.4,0.2}}, color={0,127,255}));
     connect(ISC_2nd.tube_in, comp_2nd.outlet) annotation (Line(points={{12,0},
             {-1.6,0},{-1.6,0.2}}, color={0,127,255}));
     connect(ISC_2nd.tube_out, comp_3rd.inlet) annotation (Line(points={{28,0},
             {53.6,0},{53.6,0.2}}, color={0,127,255}));
     connect(junction.port_a, comp_3rd.outlet) annotation (Line(points={{92,0},
             {76.4,0},{76.4,0.2}}, color={0,127,255}));
     connect(junction.port_b, anodeOut)
       annotation (Line(points={{108,0},{108,0},{120,0}}, color={0,127,255}));
  connect(junction.port_a, pout_mes.port)
    annotation (Line(points={{92,0},{86,0},{86,-90}}, color={0,127,255}));
  connect(pout_mes.p, FB_pout.u2)
    annotation (Line(points={{75,-100},{20,-100},{20,-88}}, color={0,0,127}));
  connect(pout_pu.u, FB_pout.y)
    annotation (Line(points={{-6.8,-80},{-4,-80},{11,-80}},
                                                  color={0,0,127}));
  connect(FBctrl_pout.u, pout_pu.y)
    annotation (Line(points={{-38,-80},{-38,-80},{-20.6,-80}},
                                                     color={0,0,127}));
     connect(FBctrl_pout.y, thetaIGV.u)
       annotation (Line(points={{-61,-80},{-61,-80},{-78.8,-80}},
                                                        color={0,0,127}));
     connect(thetaIGV.y, comp_1st.in_thetaIGV) annotation (Line(points={{-92.6,
             -80},{-104,-80},{-104,-22.6},{-94.6,-22.6}}, color={0,0,127}));
     connect(FB_pout.u1, pout_set.y)
       annotation (Line(points={{28,-80},{39,-80}}, color={0,0,127}));
     connect(source_chilledWater.ports[1], flowSplit.port_2)
       annotation (Line(points={{-80,90},{-64,90}}, color={0,127,255}));
     connect(flowSplit.port_3, TCV_ISC_1st.port_a) annotation (Line(points={{-54,80},
             {-54,68},{-54,60}},         color={0,127,255}));
     connect(flowSplit.port_1, TCV_ISC_2nd.port_a) annotation (Line(points={{-44,90},
             {20,90},{20,60}},         color={0,127,255}));
     connect(ISC_2nd.shell_out, flowJoin.port_3) annotation (Line(points={{20,
             -8},{20,-8},{20,-40}}, color={0,127,255}));
     connect(ISC_1st.shell_out, flowJoin.port_1) annotation (Line(points={{-54,
             -8},{-54,-50},{10,-50}}, color={0,127,255}));
     connect(sink_chilledWater.ports[1], flowJoin.port_2) annotation (Line(
           points={{46,-50},{38,-50},{30,-50}}, color={0,127,255}));
     connect(load_comps.powerConsumption, W_comps.y)
       annotation (Line(points={{3,104},{3,104},{19,104}}, color={0,0,127}));
     connect(loadElec_comp, load_comps.load) annotation (Line(
         points={{0,120},{4.44089e-016,120},{4.44089e-016,112}},
         color={255,0,0},
         thickness=0.5));
     connect(TCV_ISC_1st_signal.y, TCV_ISC_1st.opening) annotation (Line(
           points={{-79,50},{-70.5,50},{-62,50}}, color={0,0,127}));
     connect(TCV_ISC_2nd.opening, TCV_ISC_2nd_signal.y)
       annotation (Line(points={{28,50},{45,50},{45,50}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=100,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    experimentSetupOutput,
    Documentation(info="<html>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{120,
            120}})),
    Icon(coordinateSystem(extent={{-160,-100},{160,100}}, initialScale=0.2),
                                                           graphics={
        Polygon(
          points={{10,18},{18,18},{18,56},{28,56},{28,64},{10,64},{10,18}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{110,18},{118,18},{118,56},{144,56},{144,64},{110,64},{110,
                 18}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
            points={{78,56},{78,34},{86,34},{86,64},{58,64},{58,56},{78,56}},
            lineColor={128,128,128},
            lineThickness=0.5,
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
        Polygon(
            points={{-22,56},{-22,34},{-14,34},{-14,64},{-42,64},{-42,56},{-22,
                 56}},
            lineColor={128,128,128},
            lineThickness=0.5,
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
        Rectangle(
            extent={{60,6},{140,-6}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={160,160,164}),
        Rectangle(
            extent={{-40,6},{40,-6}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={160,160,164}),
        Rectangle(
            extent={{-140,6},{-60,-6}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={160,160,164}),
        Polygon(
            points={{-120,56},{-120,34},{-112,34},{-112,64},{-140,64},{-140,56},
                 {-120,56}},
            lineColor={128,128,128},
            lineThickness=0.5,
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
        Polygon(
          points={{-88,18},{-80,18},{-80,56},{-70,56},{-70,64},{-88,64},{-88,
                 18}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
                   Text(
          extent={{-130,-56},{126,-94}},
          lineColor={0,0,255},
          textString="%name"),
        Ellipse(
          extent={{-72,80},{-32,40}},
          fillPattern=FillPattern.Sphere,
          fillColor={0,128,255},
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-120,40},{-120,-40},{-80,-20},{-80,20},{-120,40}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{1.08054e-015,44},{2.4493e-016,36},{10,28},{-10,20},{
                 5.9748e-016,12},{6.43249e-016,4}},
          color={238,46,47},
          thickness=0.5,
          origin={-28,60},
          rotation=90),
        Polygon(
          points={{-22,40},{-22,-40},{18,-20},{18,20},{-22,40}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{78,40},{78,-40},{118,-20},{118,20},{78,40}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,80},{68,40}},
          fillPattern=FillPattern.Sphere,
          fillColor={0,128,255},
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{1.08054e-015,44},{2.4493e-016,36},{10,28},{-10,20},{
                 5.9748e-016,12},{6.43249e-016,4}},
          color={238,46,47},
          thickness=0.5,
          origin={72,60},
          rotation=90),
           Ellipse(
             extent={{-146,8},{-130,-8}},
             lineColor={0,0,0},
             fillColor={95,95,95},
             fillPattern=FillPattern.Solid),
           Ellipse(
             extent={{-48,8},{-32,-8}},
             lineColor={0,0,0},
             fillColor={95,95,95},
             fillPattern=FillPattern.Solid),
           Ellipse(
             extent={{52,8},{68,-8}},
             lineColor={0,0,0},
             fillColor={95,95,95},
             fillPattern=FillPattern.Solid),
           Ellipse(
             extent={{-70,8},{-54,-8}},
             lineColor={0,0,0},
             fillColor={255,255,255},
             fillPattern=FillPattern.Solid),
           Ellipse(
             extent={{28,8},{44,-8}},
             lineColor={0,0,0},
             fillColor={255,255,255},
             fillPattern=FillPattern.Solid),
           Ellipse(
             extent={{128,8},{144,-8}},
             lineColor={0,0,0},
             fillColor={255,255,255},
             fillPattern=FillPattern.Solid),
           Ellipse(
             extent={{-106,38},{-94,26}},
             lineColor={0,0,0},
             fillColor={238,46,47},
             fillPattern=FillPattern.Solid),
           Ellipse(
             extent={{94,36},{106,24}},
             lineColor={0,0,0},
             fillColor={238,46,47},
             fillPattern=FillPattern.Solid),
           Line(
             points={{-100,30},{-100,100},{100,100},{100,30}},
             color={238,46,47},
             thickness=0.5),
           Line(
             points={{0,30},{0,100},{0,100}},
             color={238,46,47},
             thickness=0.5),
           Ellipse(
             extent={{-6,36},{6,24}},
             lineColor={0,0,0},
             fillColor={238,46,47},
             fillPattern=FillPattern.Solid)}));
end CompressionSystem_elecPorts;
