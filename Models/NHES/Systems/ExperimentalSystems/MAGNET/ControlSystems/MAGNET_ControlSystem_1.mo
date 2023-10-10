within NHES.Systems.ExperimentalSystems.MAGNET.ControlSystems;
model MAGNET_ControlSystem_1
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
Real Error2_MAGNET "Valve 2, vaccuum chamber to recuperator in MAGNET";
Real Error3_MAGNET "Valve 3, TEDS to MAGNET";

parameter SI.Power Q_TES_max = 175e3;
parameter SI.Power Heater_max = 175e3;
parameter SI.Temperature T_hot_design = 325;
parameter SI.Temperature T_cold_design = 225;

parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

SI.MassFlowRate m_MAGNET_needed; // mass flow needed from MAGNET as calculated based on Tin on TEDS side
SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
SI.Power Heat_needed;
SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

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
  Modelica.Blocks.Math.Gain mf_vc_rp(k=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-145,-35})));
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
  Modelica.Blocks.Sources.RealExpression MAGNET_valve2(y=Error2_MAGNET)
    annotation (Placement(transformation(extent={{-42,-4},{-22,16}})));
  Modelica.Blocks.Continuous.LimPID PIDV8(
    yMax=1,
    k=0.007*10,
    Ti=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.0)
    annotation (Placement(transformation(extent={{26,16},{40,30}})));
  Modelica.Blocks.Sources.Constant const8(k=0)
    annotation (Placement(transformation(extent={{-6,18},{4,28}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder7(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{148,-2},{160,10}})));
  Modelica.Blocks.Sources.RealExpression MAGNET_valve3(y=Error3_MAGNET)
    annotation (Placement(transformation(extent={{-40,-52},{-20,-32}})));
  Modelica.Blocks.Continuous.LimPID PIDV9(
    yMax=1,
    k=-0.007*3600,
    Ti=3.5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMin=0)
    annotation (Placement(transformation(extent={{32,-28},{46,-14}})));
  Modelica.Blocks.Sources.Constant const9(k=0)
    annotation (Placement(transformation(extent={{-4,-26},{6,-16}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder8(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{148,-44},{160,-32}})));
  Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
    annotation (Placement(transformation(extent={{-4,66},{16,86}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{122,-8},{138,8}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual1
    annotation (Placement(transformation(extent={{88,-6},{100,6}})));
  Modelica.Blocks.Sources.RealExpression mflow_TEDS(y=
        Heater_flowrate_sensor.y)
    annotation (Placement(transformation(extent={{48,-4},{70,18}})));
  Modelica.Blocks.Sources.Constant const6(k=0.01)
    annotation (Placement(transformation(extent={{58,-10},{68,0}})));
  Modelica.Blocks.Sources.Constant const10(k=1)
    annotation (Placement(transformation(extent={{76,-18},{86,-8}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{120,-40},{136,-24}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual2
    annotation (Placement(transformation(extent={{82,-36},{94,-24}})));
  Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=
        Heater_flowrate_sensor.y)
    annotation (Placement(transformation(extent={{46,-44},{68,-22}})));
  Modelica.Blocks.Sources.Constant const11(k=0.01)
    annotation (Placement(transformation(extent={{64,-56},{74,-46}})));
  Modelica.Blocks.Sources.Constant const12(k=0)
    annotation (Placement(transformation(extent={{96,-56},{106,-46}})));
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
protected
  Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
    annotation (Placement(transformation(extent={{-72,-96},{-60,-84}})));
  Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
    annotation (Placement(transformation(extent={{-78,-142},{-66,-130}})));
equation
  //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
  mediums.p = 1e5;
  mediums.T = 275+273;

algorithm

//Heat_needed := (Heater_flowrate_sensor.y)*Cp*(T_hot_design-Tin_TEDside.y+273.15);
Heat_needed := (Medium.specificEnthalpy_pT(1e5,T_hot_design) - Medium.specificEnthalpy_pT(1e5,Tin_TEDside.y))*(Heater_flowrate_sensor.y);

if Heat_needed >250e3 then
  m_MAGNET_needed := 0.938;
else
  //m_MAGNET_needed := Heat_needed/abs(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MAGNET) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));
  m_MAGNET_needed := Heat_needed/abs(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));
  //m_MAGNET_needed := Heat_needed/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MAGNET) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MAGNET));
end if;

if Heater_flowrate_sensor.y>0.001 then
  m_MAGNET_needed := m_MAGNET_needed;
else
  m_MAGNET_needed:= 1e-8;
end if;

Error1_MAGNET := ((m_MAGNET_needed) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

m_MAGNET_left := mflow_inside_MAGNET.y-(m_MAGNET_needed);

if Heater_flowrate_sensor.y>0.001 then
  Error2_MAGNET := ((mf_vc_rp.y) - m_MAGNET_left)/mflow_inside_MAGNET.y;
else
  Error2_MAGNET:= 1;
end if;

//if m_MAGNET_needed >0.001 then
if Heater_flowrate_sensor.y >0.001 then
  Error3_MAGNET :=1;
else
  Error3_MAGNET:=-1;
end if;

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
  connect(actuatorSubBus.mf_vc_rp, mf_vc_rp.u) annotation (Line(
      points={{-24,-219},{-180,-219},{-180,-35},{-151,-35}},
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
  connect(const8.y,PIDV8. u_s)
    annotation (Line(points={{4.5,23},{10,23},{10,24},{14,24},{14,23},{24.6,
          23}},                                        color={0,0,127}));
  connect(MAGNET_valve2.y,PIDV8. u_m) annotation (Line(points={{-21,6},{-21,
          8},{33,8},{33,14.6}},   color={0,0,127}));
  connect(const9.y,PIDV9. u_s)
    annotation (Line(points={{6.5,-21},{30.6,-21}},    color={0,0,127}));
  connect(MAGNET_valve3.y,PIDV9. u_m) annotation (Line(points={{-19,-42},{
          39,-42},{39,-29.4}},
                        color={0,0,127}));
  connect(greaterEqual1.y, switch1.u2)
    annotation (Line(points={{100.6,0},{120.4,0}}, color={255,0,255}));
  connect(mflow_TEDS.y, greaterEqual1.u1) annotation (Line(points={{71.1,7},
          {80,7},{80,0},{86.8,0}}, color={0,0,127}));
  connect(switch1.u1, PIDV8.y) annotation (Line(points={{120.4,6.4},{120.4,
          6},{106,6},{106,23},{40.7,23}}, color={0,0,127}));
  connect(switch1.y, firstOrder7.u) annotation (Line(points={{138.8,0},{142,
          0},{142,4},{146.8,4}}, color={0,0,127}));
  connect(const6.y, greaterEqual1.u2) annotation (Line(points={{68.5,-5},{
          77.65,-5},{77.65,-4.8},{86.8,-4.8}}, color={0,0,127}));
  connect(const10.y, switch1.u3) annotation (Line(points={{86.5,-13},{112,
          -13},{112,-6.4},{120.4,-6.4}}, color={0,0,127}));
  connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{94.6,-30},
          {94.6,-32},{118.4,-32}}, color={255,0,255}));
  connect(mflow_TEDS1.y, greaterEqual2.u1) annotation (Line(points={{69.1,
          -33},{69.1,-30},{80.8,-30}}, color={0,0,127}));
  connect(const12.y, switch2.u3) annotation (Line(points={{106.5,-51},{112,
          -51},{112,-38.4},{118.4,-38.4}}, color={0,0,127}));
  connect(switch2.y, firstOrder8.u) annotation (Line(points={{136.8,-32},{
          140,-32},{140,-38},{146.8,-38}}, color={0,0,127}));
  connect(PIDV9.y, switch2.u1) annotation (Line(points={{46.7,-21},{112,-21},
          {112,-25.6},{118.4,-25.6}}, color={0,0,127}));
  connect(const11.y, greaterEqual2.u2) annotation (Line(points={{74.5,-51},
          {78,-51},{78,-40},{74,-40},{74,-34.8},{80.8,-34.8}}, color={0,0,
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
  connect(sensorSubBus.MAGNET_valve2_opening, firstOrder7.y) annotation (
      Line(
      points={{40,-219},{40,-220},{178,-220},{178,4},{160.6,4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_valve3_opening, firstOrder8.y) annotation (
      Line(
      points={{40,-219},{40,-220},{178,-220},{178,-38},{160.6,-38}},
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
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-220},
            {180,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-220},{180,140}})));
end MAGNET_ControlSystem_1;
