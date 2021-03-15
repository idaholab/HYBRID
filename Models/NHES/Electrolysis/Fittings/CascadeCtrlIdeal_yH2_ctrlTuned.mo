within NHES.Electrolysis.Fittings;
model CascadeCtrlIdeal_yH2_ctrlTuned "Joins two gas flows"
  import      Modelica.Units.SI;
  //import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package MixtureGas =
      Electrolysis.Media.Electrolysis.CathodeGas constrainedby
    Modelica.Media.Interfaces.PartialMedium
    "Medium model for mixture gas in the mixer" annotation (choicesAllMatching = true, Dialog(group="Working fluids (Medium)"));
  replaceable package Steam = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance
    "Medium model for pure steam in the mixer" annotation (choicesAllMatching = true, Dialog(group="Working fluids (Medium)"));

  parameter Boolean allowFlowReversal = system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  parameter Modelica.Blocks.Types.Init initType_FBctrl_yH2 = Modelica.Blocks.Types.Init.NoInit
    "Type of initialization for yH2 feedback control (1: no init, 2: steady state, 3/4: initial output)"
                                                                                                        annotation (Dialog(tab="Initialization"));
  parameter SI.AbsolutePressure pSteam_start = 2.045*1e6
    "Start value of steam pressure [Pa]"
    annotation(Dialog(tab = "Initialization"));
  parameter SI.Temperature TSteam_start = 283.4 + 273.15
    "Start value of steam temperature"
    annotation(Dialog(tab = "Initialization"));
//  parameter SI.MassFlowRate wSteam_start = 4.48467
//    "Start value of steam mass flow rate [kg/s]"
//    annotation (Dialog(tab="Initialization"));
  parameter SI.MassFlowRate wH2_start=0.055756419
    "Start value of hydrogen mass flow rate" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Volume V "Mixing volume inside junction";
  parameter Real yH2_setPoint = 0.1
    "Desired mole fraction of hydrogen in cathode gas entering SOEC units";

  Modelica.Fluid.Interfaces.FluidPort_a mixtureGas_port_1( redeclare package
      Medium = MixtureGas,m_flow(min=0)) annotation (Placement(
        transformation(extent={{-90,40},{-70,60}}), iconTransformation(extent={{-90,40},
            {-70,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a steam_port_2(redeclare package Medium =
        Steam, m_flow(min=0)) annotation (Placement(transformation(extent={{-90,
            -60},{-70,-40}}), iconTransformation(extent={{-90,-60},{-70,-40}})));
  Modelica.Fluid.Interfaces.FluidPort_b mixtureGas_port_3( redeclare package
      Medium = MixtureGas, m_flow(max=0)) annotation (Placement(
        transformation(extent={{70,-10},{90,10}}), iconTransformation(extent={{70,-10},
            {90,10}})));

  Modelica.Fluid.Sensors.MassFlowRate wSteam(
      redeclare package Medium = MixtureGas, allowFlowReversal=
        allowFlowReversal)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Electrolysis.Fittings.BaseClasses.MediumConverter mediumConverter(
    redeclare package Medium_port_a = Steam,
    redeclare package Medium_port_b = MixtureGas,
    p_start=pSteam_start,
    T_start=TSteam_start)
    annotation (Placement(transformation(extent={{-52,-60},{-32,-40}})));
  Electrolysis.Fittings.BaseClasses.TeeJunction mixer_H2Recycled(
    redeclare package Medium = MixtureGas,
    V=V,
    yH2_start=yH2_set.k,
    p_start=2045000,
    T_start=556.55)
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));

  Electrolysis.Controllers.FFcontroller_XH2 FFctrl_yH2(initialOutput=
        wH2_start)
    annotation (Placement(transformation(extent={{-12,-28},{12,-4}})));
  Modelica.Blocks.Sources.Constant yH2_set(k=yH2_setPoint)
    annotation (Placement(transformation(extent={{-50,-26},{-30,-6}})));
  Modelica.Blocks.Math.Feedback feedback_wSteam annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={0,28})));
  Modelica.Fluid.Sensors.MassFlowRate wH2_recycled(
      redeclare package Medium = MixtureGas, allowFlowReversal=
        allowFlowReversal)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={52,28})));

  Modelica.Blocks.Interfaces.RealOutput c_yH2(final quantity="MassFlowRate", final unit="kg/s", min = 0, displayUnit="kg/s") annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={0,110}),iconTransformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={40,28})));

  Modelica.Blocks.Continuous.PI FBctrl_yH2(
    initType=initType_FBctrl_yH2,
    y_start=wH2_start,
    y(start=wH2_start),
    x_start=wH2_start/FBctrl_yH2.k,
    k=0.1*0 + 3,
    T=2*0 + 8)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=-90,
        origin={0,64})));

  Modelica.Blocks.Nonlinear.Limiter limiter_wH2_in(uMax=wH2_start*1.2, uMin=
       wH2_start*0.1) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=90,
        origin={0,88})));
equation
  connect(wH2_recycled.m_flow, feedback_wSteam.u2)
    annotation (Line(points={{41,28},{41,28},{8,28}},
                                              color={0,0,127}));
  connect(feedback_wSteam.u1, FFctrl_yH2.y) annotation (Line(points={{-1.33227e-015,
          20},{-1.33227e-015,-5.2},{0,-5.2}}, color={0,0,127}));
  connect(FFctrl_yH2.u_m, wSteam.m_flow)
    annotation (Line(points={{0,-26.8},{0,-26.8},{0,-39}},
                                                         color={0,0,127}));
  connect(mediumConverter.port_b, wSteam.port_a) annotation (Line(points={{-32,-50},
          {-32,-50},{-10,-50}}, color={0,127,255}));
  connect(yH2_set.y, FFctrl_yH2.u_s_yH2in) annotation (Line(points={{-29,-16},{-29,
          -16},{-10.8,-16}},                color={0,0,127}));
  connect(mixtureGas_port_1, mixtureGas_port_1)
    annotation (Line(points={{-80,50},{-80,50}},          color={0,127,255}));
  connect(mixtureGas_port_1, wH2_recycled.port_a)
    annotation (Line(points={{-80,50},{52,50},{52,38}}, color={0,127,255}));
  connect(c_yH2, c_yH2)
    annotation (Line(points={{0,110},{0,110}},         color={0,0,127}));
  connect(mediumConverter.port_a, steam_port_2)
    annotation (Line(points={{-52.2,-50},{-80,-50}}, color={0,127,255}));
  connect(wH2_recycled.port_b, mixer_H2Recycled.port_1a)
    annotation (Line(points={{52,18},{52,14},{52,10}}, color={0,127,255}));
  connect(mixer_H2Recycled.port_3b, mixtureGas_port_3)
    annotation (Line(points={{62,0},{71,0},{80,0}}, color={0,127,255}));
  connect(wSteam.port_b, mixer_H2Recycled.port_2a) annotation (Line(points=
          {{10,-50},{20,-50},{20,0},{42,0}}, color={0,127,255}));
  connect(feedback_wSteam.y, FBctrl_yH2.u)
    annotation (Line(points={{0,37},{0,46},{0,54.4},{-1.77636e-015,54.4}},
                                                        color={0,0,127}));
  connect(FBctrl_yH2.y, limiter_wH2_in.u) annotation (Line(points={{
          1.55431e-015,72.8},{1.55431e-015,77.6},{-5.55112e-016,77.6},{
          -5.55112e-016,78.4}}, color={0,0,127}));
  connect(limiter_wH2_in.y, c_yH2)
    annotation (Line(points={{0,96.8},{0,110}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                      graphics={Polygon(
          points={{-70,70},{0,18},{70,18},{70,-18},{0,-18},{-70,-70},{-70,-30},{
              -30,0},{-70,30},{-70,70}},
          lineColor={128,128,128},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
                   Text(extent={{-92,-56},{112,-98}},  textString="%name",lineColor={0,0,255})}));
end CascadeCtrlIdeal_yH2_ctrlTuned;
