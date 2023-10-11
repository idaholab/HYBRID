within NHES.Systems.ExperimentalSystems.MAGNET.ControlSystems;
model MAGNET_ControlSystem_GT_newHX
  "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

  replaceable package Medium =
      TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
    TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
      choicesAllMatching=true);

package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
  TEDS.BaseClasses_1.SignalSubBus_SensorOutput actuatorSubBus
    annotation (Placement(transformation(extent={{-48,-242},{0,-196}})));
  TEDS.BaseClasses_1.SignalSubBus_ActuatorInput sensorSubBus
    annotation (Placement(transformation(extent={{16,-242},{64,-196}})));

Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
SI.Power Heat_needed_GT; // Heat needed to produce electricity
SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity

parameter SI.Power Q_TES_max = 175e3;
parameter SI.Power Heater_max = 175e3;
parameter SI.Temperature T_hot_design = 325;
parameter SI.Temperature T_cold_design = 225;

parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

//SI.MassFlowRate m_MAGNET_needed; // mass flow needed from MAGNET as calculated based on Tin on TEDS side
SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed

parameter SI.Pressure p_atm = 1e5;
parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(430);

Medium.BaseProperties mediums;

  Modelica.Blocks.Sources.Constant delayStart(k=20)
    annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
  Modelica.Blocks.Sources.ContinuousClock clock
    annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

  Modelica.Blocks.Math.Gain Tin_MT_HX(k=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-145,45})));
  Modelica.Blocks.Math.Gain Tout_MT_HX(k=1) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-145,29})));
  Modelica.Blocks.Math.Gain mf_MT_HX(k=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-145,13})));
  Modelica.Blocks.Math.Gain HX_heat(k=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-145,-3})));
  Modelica.Blocks.Math.Gain Tin_TEDside(k=1) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-145,-19})));
  Modelica.Blocks.Math.Gain Heater_flowrate_sensor(k=1) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-139,-181})));
  Modelica.Blocks.Math.Gain mflow_inside_MAGNET(k=1) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-139,-133})));
  Modelica.Blocks.Continuous.LimPID PIDV7(
    yMax=1,
    k=-0.007*36,
    Ti=3.5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0)
    annotation (Placement(transformation(extent={{32,84},{46,98}})));
  Modelica.Blocks.Sources.Constant const7(k=0)
    annotation (Placement(transformation(extent={{-12,96},{-2,106}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder6(
    T=2,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{148,68},{160,80}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder8(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{148,4},{160,16}})));
  Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
    annotation (Placement(transformation(extent={{-4,66},{16,86}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{120,8},{136,24}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual2
    annotation (Placement(transformation(extent={{82,12},{94,24}})));
  Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=
        Heater_flowrate_sensor.y)
    annotation (Placement(transformation(extent={{46,4},{68,26}})));
  Modelica.Blocks.Sources.Constant const11(k=0.01)
    annotation (Placement(transformation(extent={{64,-8},{74,2}})));
  Modelica.Blocks.Sources.Constant const12(k=0)
    annotation (Placement(transformation(extent={{96,-8},{106,2}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{118,54},{134,70}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual3
    annotation (Placement(transformation(extent={{84,56},{96,68}})));
  Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=
        Heater_flowrate_sensor.y)
    annotation (Placement(transformation(extent={{44,58},{66,80}})));
  Modelica.Blocks.Sources.Constant const13(k=0.01)
    annotation (Placement(transformation(extent={{54,52},{64,62}})));
  Modelica.Blocks.Sources.Constant const14(k=0)
    annotation (Placement(transformation(extent={{80,36},{90,46}})));
public
  TRANSFORM.Controls.LimPID cw_mf_control(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    with_FF=false,
    k=-0.001,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=10,
    yMin=0.001,
    Nd=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.689,
    reset=TRANSFORM.Types.Reset.Disabled)
    annotation (Placement(transformation(extent={{-34,-100},{-14,-80}})));
public
  TRANSFORM.Controls.LimPID N2_mf_control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    with_FF=false,
    k=-0.00025,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=10,
    yMin=0.001,
    Nd=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.689)
    annotation (Placement(transformation(extent={{-8,-146},{12,-126}})));
  Systems.ExperimentalSystems.MAGNET.Data.Data_base_An data
    annotation (Placement(transformation(extent={{-112,122},{-92,142}})));
  Modelica.Blocks.Continuous.LimPID PIDV1(
    yMax=1,
    k=0.00007*1,
    Ti=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0)
    annotation (Placement(transformation(extent={{40,-48},{54,-34}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{76,-46},{88,-34}})));
  Modelica.Blocks.Sources.Constant const2(k=data.T_hot_side)
    annotation (Placement(transformation(extent={{82,-100},{92,-90}})));
  Modelica.Blocks.Continuous.LimPID PIDV2(
    yMax=1,
    k=-0.0007*1,
    Ti=3.5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0)
    annotation (Placement(transformation(extent={{102,-102},{116,-88}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{130,-102},{142,-90}})));
  Modelica.Blocks.Sources.Constant const3(k=1)
    annotation (Placement(transformation(extent={{-14,34},{-4,44}})));
  Modelica.Blocks.Math.Gain mf_vc_GT(k=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-143,-51})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-(1 - 0.4)*data.GT_demand,
    duration=3000,
    offset=data.GT_demand,
    startTime=15000)
    annotation (Placement(transformation(extent={{-72,-52},{-54,-34}})));
  Modelica.Blocks.Sources.CombiTimeTable P_GT_demand(table=[0.0,1; 1800,1;
        3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
        18000,1], startTime=0)
    annotation (Placement(transformation(extent={{-32,-48},{-18,-34}})));
  Modelica.Blocks.Math.Gain GT_demand(k=data.GT_demand)
    annotation (Placement(transformation(extent={{0,-46},{10,-36}})));
protected
  Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
    annotation (Placement(transformation(extent={{-72,-96},{-60,-84}})));
  Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
    annotation (Placement(transformation(extent={{-78,-142},{-66,-130}})));
equation
  //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
  mediums.p = 1e5;
  mediums.T = 275+273;
  Heat_needed_GT = GT_demand.y/data.eta_mech;

algorithm
  m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

  m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

  Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

equation
  connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
      points={{-24,-219},{-180,-219},{-180,45},{-151,45}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
      points={{-24,-219},{-180,-219},{-180,30},{-152,30},{-152,29},{-151,29}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
      points={{-24,-219},{-180,-219},{-180,13},{-151,13}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
      points={{-24,-219},{-180,-219},{-180,-3},{-151,-3}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
      points={{-24,-219},{-180,-219},{-180,-19},{-151,-19}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
     Line(
      points={{-24,-219},{-180,-219},{-180,-181},{-145,-181}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
    annotation (Line(
      points={{-24,-219},{-180,-219},{-180,-133},{-145,-133}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(MAGNET_valve.y,PIDV7. u_m)
    annotation (Line(points={{17,76},{39,76},{39,82.6}}, color={0,0,127}));
  connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{94.6,18},{94.6,
          16},{118.4,16}},         color={255,0,255}));
  connect(mflow_TEDS1.y, greaterEqual2.u1) annotation (Line(points={{69.1,15},{69.1,
          18},{80.8,18}},              color={0,0,127}));
  connect(const12.y, switch2.u3) annotation (Line(points={{106.5,-3},{112,-3},{112,
          9.6},{118.4,9.6}},               color={0,0,127}));
  connect(switch2.y, firstOrder8.u) annotation (Line(points={{136.8,16},{140,16},
          {140,10},{146.8,10}},            color={0,0,127}));
  connect(const11.y, greaterEqual2.u2) annotation (Line(points={{74.5,-3},{78,-3},
          {78,8},{74,8},{74,13.2},{80.8,13.2}},                color={0,0,
          127}));
  connect(greaterEqual3.y, switch3.u2)
    annotation (Line(points={{96.6,62},{116.4,62}}, color={255,0,255}));
  connect(mflow_TEDS2.y, greaterEqual3.u1) annotation (Line(points={{67.1,
          69},{76,69},{76,62},{82.8,62}}, color={0,0,127}));
  connect(const13.y, greaterEqual3.u2) annotation (Line(points={{64.5,57},{
          73.65,57},{73.65,57.2},{82.8,57.2}}, color={0,0,127}));
  connect(const14.y, switch3.u3) annotation (Line(points={{90.5,41},{110,41},
          {110,55.6},{116.4,55.6}}, color={0,0,127}));
  connect(PIDV7.y, switch3.u1) annotation (Line(points={{46.7,91},{88,91},{
          88,76},{116.4,76},{116.4,68.4}}, color={0,0,127}));
  connect(switch3.y, firstOrder6.u) annotation (Line(points={{134.8,62},{
          140,62},{140,74},{146.8,74}}, color={0,0,127}));
  connect(sensorSubBus.MAGNET_valve_opening, firstOrder6.y) annotation (
      Line(
      points={{40,-219},{40,-220},{178,-220},{178,74},{160.6,74}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_valve3_opening, firstOrder8.y) annotation (
      Line(
      points={{40,-219},{40,-220},{178,-220},{178,10},{160.6,10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y, PIDV7.u_s) annotation (Line(points={{-1.5,101},{22,101},
          {22,91},{30.6,91}}, color={0,0,127}));
  connect(Tin_vc_design.y,cw_mf_control. u_s)
    annotation (Line(points={{-59.4,-90},{-36,-90}},     color={0,0,127}));
  connect(actuatorSubBus.Tin_vc, cw_mf_control.u_m) annotation (Line(
      points={{-24,-219},{-24,-102}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
      points={{40,-219},{40,-90},{-13,-90}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Tout_vc_design.y,N2_mf_control. u_s)
    annotation (Line(points={{-65.4,-136},{-10,-136}},color={0,0,127}));
  connect(actuatorSubBus.Tout_vc, N2_mf_control.u_m) annotation (Line(
      points={{-24,-219},{-24,-156},{2,-156},{2,-148}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (
      Line(
      points={{40,-219},{40,-136},{13,-136}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.GT_Power, PIDV1.u_m) annotation (Line(
      points={{-24,-219},{-24,-172},{47,-172},{47,-49.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(firstOrder1.u, PIDV1.y) annotation (Line(points={{74.8,-40},{64.75,-40},
          {64.75,-41},{54.7,-41}}, color={0,0,127}));
  connect(sensorSubBus.MAGNET_valve2_opening, firstOrder1.y) annotation (Line(
      points={{40,-219},{44,-219},{44,-220},{178,-220},{178,-40},{88.6,-40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PIDV2.u_s, const2.y)
    annotation (Line(points={{100.6,-95},{92.5,-95}}, color={0,0,127}));
  connect(actuatorSubBus.Tout_TEDSide, PIDV2.u_m) annotation (Line(
      points={{-24,-219},{42,-219},{42,-220},{108,-220},{108,-103.4},{109,-103.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(firstOrder2.u, PIDV2.y) annotation (Line(points={{128.8,-96},{128.8,-95},
          {116.7,-95}}, color={0,0,127}));
  connect(sensorSubBus.Pump_Flow, firstOrder2.y) annotation (Line(
      points={{40,-219},{40,-220},{178,-220},{178,-96},{142.6,-96}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const3.y, switch2.u1) annotation (Line(points={{-3.5,39},{74,39},{74,28},
          {110,28},{110,22.4},{118.4,22.4}}, color={0,0,127}));
  connect(actuatorSubBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
      points={{-24,-219},{-180,-219},{-180,-51},{-149,-51}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(P_GT_demand.y[1], GT_demand.u)
    annotation (Line(points={{-17.3,-41},{-1,-41}}, color={0,0,127}));
  connect(GT_demand.y, PIDV1.u_s)
    annotation (Line(points={{10.5,-41},{38.6,-41}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-220},
            {180,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-220},{180,140}})));
end MAGNET_ControlSystem_GT_newHX;
