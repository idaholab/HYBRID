within NHES.Systems.ExperimentalSystems.MAGNET_TEDS.Models.Magnet_TEDS;
package MAGNET_TEDS_ControlSystem
  "Control System for the integration of MAGNET and TEDS"
  extends Systems.SupervisoryControl;
  model MAGNET_ControlSystem_1
    "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);

  package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-48,-242},{0,-196}})));
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
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

  model MAGNET_ControlSystem_GT
    "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);

  package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-48,-242},{0,-196}})));
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
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
      k=-0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
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
  end MAGNET_ControlSystem_GT;

  model MAGNET_ControlSystem_GT_newHX
    "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);

  package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-48,-242},{0,-196}})));
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
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

  model Control_System_Therminol_4_element_all_modes_MAGNET_GT
    "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);

  package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-46,-418},{2,-372}})));
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
      annotation (Placement(transformation(extent={{16,-418},{64,-372}})));
    Modelica.Blocks.Continuous.LimPID PIDV1(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.03*0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,122},{84,136}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{50,108},{60,118}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,122},{110,136}})));
    Modelica.Blocks.Continuous.LimPID PIDV2(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,90},{84,104}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{50,74},{60,84}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{98,90},{112,104}})));
    Modelica.Blocks.Continuous.LimPID PIDV3(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.03*0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0) annotation (Placement(transformation(extent={{64,56},{78,70}})));
    Modelica.Blocks.Sources.Constant const2(k=0)
      annotation (Placement(transformation(extent={{50,40},{60,50}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,58},{110,70}})));
    Modelica.Blocks.Continuous.LimPID PIDV4(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0) annotation (Placement(transformation(extent={{66,24},{80,38}})));
    Modelica.Blocks.Sources.Constant const3(k=0)
      annotation (Placement(transformation(extent={{50,8},{60,18}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{100,26},{112,38}})));
    Modelica.Blocks.Continuous.LimPID PIDV5(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      yMin=0.0)
      annotation (Placement(transformation(extent={{68,-6},{82,8}})));
    Modelica.Blocks.Sources.Constant const4(k=0)
      annotation (Placement(transformation(extent={{44,-18},{54,-8}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{102,-4},{114,8}})));
    Modelica.Blocks.Continuous.LimPID PIDV6(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.0)
      annotation (Placement(transformation(extent={{62,-36},{76,-22}})));
    Modelica.Blocks.Sources.Constant const5(k=0)
      annotation (Placement(transformation(extent={{36,-48},{46,-38}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
      annotation (Placement(transformation(extent={{96,-34},{108,-22}})));
    Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
      annotation (Placement(transformation(extent={{26,118},{48,140}})));
    Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
      annotation (Placement(transformation(extent={{22,86},{44,108}})));
    Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
      annotation (Placement(transformation(extent={{18,52},{40,74}})));
    Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
      annotation (Placement(transformation(extent={{10,20},{32,42}})));
    Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
      annotation (Placement(transformation(extent={{8,-40},{30,-18}})));
    Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
      annotation (Placement(transformation(extent={{12,-10},{34,12}})));

  Real Error1 "Valve 1";
  Real Error2 "Valve 2";
  Real Error3 "Valve 3";
  Real Error4 "Valve 4";
  Real Error5 "Valve 5";
  Real Error6 "Valve 6";
  Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";

  Integer storage_button "0 equals discharge or stationary, 1 is charging";

  parameter SI.Power Q_TES_max = 175e3;
  parameter SI.Power Heater_max = 175e3;
  parameter SI.Temperature T_hot_design = 325;
  parameter SI.Temperature T_cold_design = 225;

  parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
  parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

  SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
  SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
  SI.MassFlowRate m_tes_demand;
  SI.MassFlowRate m_heater_demand;
  SI.Power Q_TES_demanded;
  SI.Power Q_TES_discharge;
  SI.Power Heat_needed_GT;
  SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity
  SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

  parameter SI.Pressure p_atm = 1e5;
  parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
  parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
  parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(450);

  Medium.BaseProperties mediums;

    Modelica.Blocks.Sources.Constant delayStart(k=20)
      annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
    TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
      "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,-2},{-146,20}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-14},{-146,6}})));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

    TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-28},{-146,-8}})));
    Modelica.Blocks.Sources.Pulse Heater_Load(
      amplitude=0,
      width=50,
      period(displayUnit="h") = 7200,
      offset=200e3)
                annotation (Placement(transformation(extent={{-34,96},{-20,110}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-70,90},{-48,112}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-44},{-146,-24}})));
    Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
          BOP_total_demand.y, Heater_Total_Demand.y))
      annotation (Placement(transformation(extent={{-40,114},{-18,136}})));
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,100,1;
          1800,100,1; 3600,0,4; 4800,0,2; 7200,0,4; 9600,100,5; 10800,140,5;
          12000,140,0.0; 14400,100,0.0; 18000,100,0], startTime=0)
      annotation (Placement(transformation(extent={{-120,120},{-106,134}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-96,122},{-86,132}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
          18000,1], startTime=0)
      annotation (Placement(transformation(extent={{-80,120},{-66,134}})));
    Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
      annotation (Placement(transformation(extent={{-56,122},{-46,132}})));
    Modelica.Blocks.Math.Gain Tin_MT_HX(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-57})));
    Modelica.Blocks.Math.Gain Tout_MT_HX(k=1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-73})));
    Modelica.Blocks.Math.Gain mf_MT_HX(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-89})));
    Modelica.Blocks.Math.Gain HX_heat(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-105})));
    Modelica.Blocks.Math.Gain Tin_TEDside(k=1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-121})));
    Modelica.Blocks.Math.Gain mf_vc_GT(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-137})));
    Modelica.Blocks.Math.Gain mflow_inside_MAGNET(k=1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-155})));
    Modelica.Blocks.Continuous.LimPID PIDV7(
      yMax=1,
      k=-0.007*36,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0)
      annotation (Placement(transformation(extent={{-24,-56},{-10,-42}})));
    Modelica.Blocks.Sources.Constant const7(k=0)
      annotation (Placement(transformation(extent={{-58,-54},{-48,-44}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder6(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{92,-72},{104,-60}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder8(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{92,-148},{104,-136}})));
    Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
      annotation (Placement(transformation(extent={{-60,-74},{-40,-54}})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{64,-144},{80,-128}})));
    Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=Heater_flowrate_sensor.y)
      annotation (Placement(transformation(extent={{-10,-148},{12,-126}})));
    Modelica.Blocks.Sources.Constant const11(k=0.01)
      annotation (Placement(transformation(extent={{8,-160},{18,-150}})));
    Modelica.Blocks.Sources.Constant const12(k=0)
      annotation (Placement(transformation(extent={{40,-160},{50,-150}})));
    Modelica.Blocks.Logical.Switch switch3
      annotation (Placement(transformation(extent={{62,-86},{78,-70}})));
    Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=Heater_flowrate_sensor.y)
      annotation (Placement(transformation(extent={{-12,-82},{10,-60}})));
    Modelica.Blocks.Sources.Constant const13(k=0.01)
      annotation (Placement(transformation(extent={{-2,-88},{8,-78}})));
    Modelica.Blocks.Sources.Constant const14(k=0)
      annotation (Placement(transformation(extent={{24,-104},{34,-94}})));
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
      annotation (Placement(transformation(extent={{-32,-312},{-12,-292}})));
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
      annotation (Placement(transformation(extent={{-6,-266},{14,-246}})));
    Systems.ExperimentalSystems.MAGNET.Data.Data_base_An data
      annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
    Modelica.Blocks.Sources.Constant const15(k=1)
      annotation (Placement(transformation(extent={{36,-122},{46,-112}})));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual1
      annotation (Placement(transformation(extent={{32,-86},{42,-76}})));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual2
      annotation (Placement(transformation(extent={{32,-146},{42,-136}})));
    Modelica.Blocks.Continuous.LimPID PIDV8(
      yMax=1,
      k=0.00007*1,
      Ti=1,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0)
      annotation (Placement(transformation(extent={{34,-198},{48,-184}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder7(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{70,-196},{82,-184}})));
    Modelica.Blocks.Sources.CombiTimeTable P_GT_demand(table=[0.0,1; 1800,1; 3600,
          1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1; 18000,1],
        startTime=0)
      annotation (Placement(transformation(extent={{-38,-198},{-24,-184}})));
    Modelica.Blocks.Math.Gain GT_demand(k=data.GT_demand)
      annotation (Placement(transformation(extent={{-6,-196},{4,-186}})));
    Modelica.Blocks.Sources.Constant const6(k=data.T_hot_side)
      annotation (Placement(transformation(extent={{82,-272},{92,-262}})));
    Modelica.Blocks.Continuous.LimPID PIDV9(
      yMax=1,
      k=-0.0007*1,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0)
      annotation (Placement(transformation(extent={{102,-274},{116,-260}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder9(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{130,-274},{142,-262}})));
    Modelica.Blocks.Sources.RealExpression Load_TES1(y=if BOP_total_demand.y <
          GT_demand.y then -1*(GT_demand.y - BOP_total_demand.y) else
          BOP_total_demand.y - GT_demand.y)
      annotation (Placement(transformation(extent={{-110,90},{-88,112}})));
  protected
    Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
      annotation (Placement(transformation(extent={{-70,-308},{-58,-296}})));
    Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
      annotation (Placement(transformation(extent={{-76,-262},{-64,-250}})));
  initial equation
    Q_TES_discharge = 0.0;
    //storage_button=0;
  equation
    //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
    mediums.p = 1e5;
    mediums.T = 275+273;

  //Error1 = pulse.y;
  algorithm

  Q_TES_demanded := m_MAGNET_left*(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));
  //Load_TES1.y;//BOP_total_demand.y - Heat_needed_GT;//Load_TES.y;

  m_tes_demand :=Q_TES_demanded/(Cp*(T_hot_design - T_cold_design));

  m_heater_demand :=GT_demand.y/(Cp*(T_hot_design - T_cold_design));

  Q_TES_discharge :=Discharge_mass_flow_sensor.y*Cp*(T_hot_design - T_cold_design);

  m_bop_heater_demand :=Heater_BOP_Demand.y/(Cp*(T_hot_design - T_cold_design));

    Heat_needed_GT :=GT_demand.y/data.eta_mech;

    m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

    m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

    Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

  //Valve 2 Used for HeaterBOPDemand

  Error2 :=(m_bop_heater_demand - Heater_BOP_mass_flow.y)/m_tes_max;

                                                                           // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
  //Valve 3 used for TES discharge

  if Q_TES_demanded > 0 and delay(storage_button,15) == 0 then
    Error3 :=(m_tes_demand - Discharge_mass_flow_sensor.y)/m_tes_max;
    else
    Error3 :=-1;
  end if;

  //Valve 1 used for TES Charge
  if Q_TES_demanded < 0 then // charging
    Error1 :=(abs(m_tes_demand) - Charge_mass_flow_sensor.y)/m_tes_max;
    //storage_button :=1;
  else
    Error1 :=-1;
    //storage_button :=0;
  end if;

    //Designation of the TEDS valve control algorithms.

   //Interlock System for the valves.
    if m_tes_demand < -0.001 then
      Error4 :=1;
      storage_button :=1;
    else
      Error4 :=-1;
      storage_button :=0;
    end if;

    if m_tes_demand > 0.001 then
      Error5 :=1;
    else
      Error5 :=-1;
    end if;

  // Main Heater Mass Flow Control
    if m_heater_demand > 0.001 then
      Error6 :=1; //(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
    else
      Error6 :=-1;
    end if;

  //Mode Determination System

  equation
    connect(PIDV1.y,firstOrder. u) annotation (Line(points={{84.7,129},{94.6,129}},
                                   color={0,0,127}));
    connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{84.7,97},{96.6,97}},
                                       color={0,0,127}));
    connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{78.7,63},{92.35,
            63},{92.35,64},{96.8,64}}, color={0,0,127}));
    connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{80.7,31},{94.35,
            31},{94.35,32},{98.8,32}},    color={0,0,127}));
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{82.7,1},{96.35,1},
            {96.35,2},{100.8,2}},         color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-29},{90.35,
            -29},{90.35,-28},{94.8,-28}}, color={0,0,127}));
    connect(sensorSubBus.Valve_1_Opening, firstOrder.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,129},{110.7,129}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_2_Opening, firstOrder1.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,97},{112.7,97}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_4_Opening, firstOrder3.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,32},{112.6,32}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_5_Opening, firstOrder4.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,2},{114.6,2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_6_Opening, firstOrder5.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,-28},{108.6,-28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,64},{110.6,64}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,9},{-172.4,9}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-4},{-172.4,-4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
       Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-18},{-172.4,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-34},{-172.4,-34}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(BOP_relative_demand.y[1],BOP_total_demand. u) annotation (Line(points={{-105.3,
            127},{-97,127}},                                      color={0,0,127}));
    connect(Heater_Demand.y[1],Heater_Total_Demand. u) annotation (Line(points={{-65.3,
            127},{-57,127}},             color={0,0,127}));
    connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-57},{-151,-57}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-73},{-151,-73}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-89},{-151,-89}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-105},{-151,-105}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-121},{-151,-121}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-155},{-151,-155}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.MAGNET_valve3_opening,firstOrder8. y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,-142},{104.6,-142}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.MAGNET_valve_opening,firstOrder6. y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,-66},{104.6,-66}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,PIDV7. u_s)
      annotation (Line(points={{-47.5,-49},{-25.4,-49}},
                                                     color={0,0,127}));
    connect(MAGNET_valve.y,PIDV7. u_m)
      annotation (Line(points={{-39,-64},{-17,-64},{-17,-57.4}},
                                                           color={0,0,127}));
    connect(Valve1.y, PIDV1.u_s)
      annotation (Line(points={{49.1,129},{68.6,129}}, color={0,0,127}));
    connect(const.y, PIDV1.u_m) annotation (Line(points={{60.5,113},{77,113},{
            77,120.6}},
          color={0,0,127}));
    connect(Valve2.y, PIDV2.u_s)
      annotation (Line(points={{45.1,97},{68.6,97}}, color={0,0,127}));
    connect(const1.y, PIDV2.u_m) annotation (Line(points={{60.5,79},{60.5,78},{
            77,78},{77,88.6}},
                            color={0,0,127}));
    connect(Valve3.y, PIDV3.u_s)
      annotation (Line(points={{41.1,63},{62.6,63}}, color={0,0,127}));
    connect(const2.y, PIDV3.u_m) annotation (Line(points={{60.5,45},{60.5,44},{
            71,44},{71,54.6}},
                            color={0,0,127}));
    connect(Valve4.y, PIDV4.u_s)
      annotation (Line(points={{33.1,31},{64.6,31}}, color={0,0,127}));
    connect(const3.y, PIDV4.u_m) annotation (Line(points={{60.5,13},{60.5,16},{
            73,16},{73,22.6}},
                       color={0,0,127}));
    connect(Valve5.y, PIDV5.u_s)
      annotation (Line(points={{35.1,1},{66.6,1}},     color={0,0,127}));
    connect(const4.y, PIDV5.u_m) annotation (Line(points={{54.5,-13},{68,-13},{
            68,-7.4},{75,-7.4}},color={0,0,127}));
    connect(const5.y, PIDV6.u_m) annotation (Line(points={{46.5,-43},{46.5,
            -37.4},{69,-37.4}},
                         color={0,0,127}));
    connect(Valve6.y, PIDV6.u_s)
      annotation (Line(points={{31.1,-29},{60.6,-29}}, color={0,0,127}));
    connect(const12.y, switch2.u3) annotation (Line(points={{50.5,-155},{56,-155},
            {56,-142.4},{62.4,-142.4}},       color={0,0,127}));
    connect(switch2.y, firstOrder8.u) annotation (Line(points={{80.8,-136},{84,-136},
            {84,-142},{90.8,-142}},       color={0,0,127}));
    connect(const14.y, switch3.u3) annotation (Line(points={{34.5,-99},{54,-99},
            {54,-84.4},{60.4,-84.4}}, color={0,0,127}));
    connect(PIDV7.y, switch3.u1) annotation (Line(points={{-9.3,-49},{32,-49},{
            32,-64},{60.4,-64},{60.4,-71.6}}, color={0,0,127}));
    connect(switch3.y, firstOrder6.u) annotation (Line(points={{78.8,-78},{84,
            -78},{84,-66},{90.8,-66}}, color={0,0,127}));
    connect(actuatorSubBus.Tin_vc, cw_mf_control.u_m) annotation (Line(
        points={{-22,-395},{-22,-314}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
        points={{40,-395},{40,-302},{-11,-302}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Tout_vc_design.y,N2_mf_control. u_s)
      annotation (Line(points={{-63.4,-256},{-8,-256}}, color={0,0,127}));
    connect(actuatorSubBus.Tout_vc, N2_mf_control.u_m) annotation (Line(
        points={{-22,-395},{-22,-396},{4,-396},{4,-268}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (Line(
        points={{40,-395},{40,-256},{15,-256}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const15.y, switch2.u1) annotation (Line(points={{46.5,-117},{62.4,-117},
            {62.4,-129.6}},       color={0,0,127}));
    connect(greaterEqual1.u1, mflow_TEDS2.y) annotation (Line(points={{31,-81},
            {16,-81},{16,-71},{11.1,-71}}, color={0,0,127}));
    connect(greaterEqual1.u2, const13.y) annotation (Line(points={{31,-85},{16,
            -85},{16,-83},{8.5,-83}}, color={0,0,127}));
    connect(greaterEqual1.y, switch3.u2) annotation (Line(points={{42.5,-81},{
            42.5,-78},{60.4,-78}}, color={255,0,255}));
    connect(greaterEqual2.u1, mflow_TEDS1.y) annotation (Line(points={{31,-141},{18,
            -141},{18,-137},{13.1,-137}},     color={0,0,127}));
    connect(greaterEqual2.u2, const11.y) annotation (Line(points={{31,-145},{22,-145},
            {22,-155},{18.5,-155}},       color={0,0,127}));
    connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{42.5,-141},{54,
            -141},{54,-136},{62.4,-136}},    color={255,0,255}));
    connect(cw_mf_control.u_s, Tin_vc_design.y)
      annotation (Line(points={{-34,-302},{-57.4,-302}}, color={0,0,127}));
    connect(actuatorSubBus.GT_Power,PIDV8. u_m) annotation (Line(
        points={{-22,-395},{-22,-322},{41,-322},{41,-199.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(firstOrder7.u,PIDV8. y) annotation (Line(points={{68.8,-190},{58.75,-190},
            {58.75,-191},{48.7,-191}},
                                     color={0,0,127}));
    connect(sensorSubBus.MAGNET_valve2_opening,firstOrder7. y) annotation (Line(
        points={{40,-395},{44,-395},{44,-398},{178,-398},{178,-190},{82.6,-190}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(P_GT_demand.y[1], GT_demand.u)
      annotation (Line(points={{-23.3,-191},{-7,-191}}, color={0,0,127}));
    connect(GT_demand.y, PIDV8.u_s)
      annotation (Line(points={{4.5,-191},{32.6,-191}}, color={0,0,127}));
    connect(actuatorSubBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
        points={{-22,-395},{-100,-395},{-100,-394},{-178,-394},{-178,-137},{-151,-137}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(PIDV9.u_s,const6. y)
      annotation (Line(points={{100.6,-267},{92.5,-267}},
                                                        color={0,0,127}));
    connect(actuatorSubBus.Tout_TEDSide,PIDV9. u_m) annotation (Line(
        points={{-22,-395},{42,-395},{42,-392},{108,-392},{108,-275.4},{109,-275.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(firstOrder9.u,PIDV9. y) annotation (Line(points={{128.8,-268},{128.8,-267},
            {116.7,-267}},color={0,0,127}));
    connect(sensorSubBus.Pump_Flow,firstOrder9. y) annotation (Line(
        points={{40,-395},{40,-392},{178,-392},{178,-268},{142.6,-268}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
              -400},{180,140}})),
                            Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-400},{180,140}})));
  end Control_System_Therminol_4_element_all_modes_MAGNET_GT;

  model Control_System_Therminol_4_element_all_modes_MAGNET_GT_SS
    "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);

  package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-46,-418},{2,-372}})));
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
      annotation (Placement(transformation(extent={{16,-418},{64,-372}})));
    Modelica.Blocks.Continuous.LimPID PIDV1(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.003*0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,122},{84,136}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{50,108},{60,118}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,122},{110,136}})));
    Modelica.Blocks.Continuous.LimPID PIDV2(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,90},{84,104}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{50,74},{60,84}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{98,90},{112,104}})));
    Modelica.Blocks.Continuous.LimPID PIDV3(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.0005*0.007*3600,
      Ti=4.25,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0) annotation (Placement(transformation(extent={{64,56},{78,70}})));
    Modelica.Blocks.Sources.Constant const2(k=0)
      annotation (Placement(transformation(extent={{50,40},{60,50}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,58},{110,70}})));
    Modelica.Blocks.Continuous.LimPID PIDV4(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0) annotation (Placement(transformation(extent={{66,24},{80,38}})));
    Modelica.Blocks.Sources.Constant const3(k=0)
      annotation (Placement(transformation(extent={{50,8},{60,18}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{100,26},{112,38}})));
    Modelica.Blocks.Continuous.LimPID PIDV5(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      yMin=0.0)
      annotation (Placement(transformation(extent={{68,-6},{82,8}})));
    Modelica.Blocks.Sources.Constant const4(k=0)
      annotation (Placement(transformation(extent={{44,-18},{54,-8}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{102,-4},{114,8}})));
    Modelica.Blocks.Continuous.LimPID PIDV6(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.0)
      annotation (Placement(transformation(extent={{62,-36},{76,-22}})));
    Modelica.Blocks.Sources.Constant const5(k=0)
      annotation (Placement(transformation(extent={{36,-48},{46,-38}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
      annotation (Placement(transformation(extent={{96,-34},{108,-22}})));
    Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
      annotation (Placement(transformation(extent={{26,118},{48,140}})));
    Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
      annotation (Placement(transformation(extent={{22,86},{44,108}})));
    Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
      annotation (Placement(transformation(extent={{18,52},{40,74}})));
    Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
      annotation (Placement(transformation(extent={{10,20},{32,42}})));
    Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
      annotation (Placement(transformation(extent={{8,-40},{30,-18}})));
    Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
      annotation (Placement(transformation(extent={{12,-10},{34,12}})));

  Real Error1 "Valve 1";
  Real Error2 "Valve 2";
  Real Error3 "Valve 3";
  Real Error4 "Valve 4";
  Real Error5 "Valve 5";
  Real Error6 "Valve 6";
  Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
  //Real Error_TSP "Error between Tout TEDS side and T_hot design";

  Integer storage_button "0 equals discharge or stationary, 1 is charging";

  parameter SI.Power Q_TES_max = 175e3;
  parameter SI.Power Heater_max = 175e3;
  parameter SI.Temperature T_hot_design = 325;
  parameter SI.Temperature T_cold_design = 225;

  parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
  parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

  SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
  SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
  SI.MassFlowRate m_tes_discharged;
  SI.MassFlowRate m_tes_charged;
  SI.Power Q_TES_discharge;
  SI.Power Heat_needed_GT;
  SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity
  SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

  parameter SI.Pressure p_atm = 1e5;
  parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
  parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
  parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(450);

  Medium.BaseProperties mediums;

    Modelica.Blocks.Sources.Constant delayStart(k=20)
      annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
    TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
      "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,-2},{-146,20}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-14},{-146,6}})));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

    TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-28},{-146,-8}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-66,38},{-44,60}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-148,-254},{-124,-234}})));
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,100,1; 1800,
          100,1; 3600,100,4; 4800,100,2; 7200,100,4; 9600,100,5; 10800,100,5; 12000,
          100,0.0; 14400,100,0.0; 18000,100,0],       startTime=0)
      annotation (Placement(transformation(extent={{-120,120},{-106,134}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-96,122},{-86,132}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
          18000,1], startTime=0)
      annotation (Placement(transformation(extent={{-80,120},{-66,134}})));
    Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
      annotation (Placement(transformation(extent={{-56,122},{-46,132}})));
    Modelica.Blocks.Math.Gain Tin_MT_HX(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-57})));
    Modelica.Blocks.Math.Gain Tout_MT_HX(k=1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-73})));
    Modelica.Blocks.Math.Gain mf_MT_HX(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-89})));
    Modelica.Blocks.Math.Gain HX_heat(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-105})));
    Modelica.Blocks.Math.Gain Tin_TEDside(k=1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-121})));
    Modelica.Blocks.Math.Gain mf_vc_GT(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-137})));
    Modelica.Blocks.Math.Gain mflow_inside_MAGNET(k=1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-155})));
    Modelica.Blocks.Continuous.LimPID PIDV7(
      yMax=1,
      k=-0.007*36,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0)
      annotation (Placement(transformation(extent={{-24,-56},{-10,-42}})));
    Modelica.Blocks.Sources.Constant const7(k=0)
      annotation (Placement(transformation(extent={{-58,-54},{-48,-44}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder6(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{92,-72},{104,-60}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder8(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{92,-148},{104,-136}})));
    Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
      annotation (Placement(transformation(extent={{-60,-74},{-40,-54}})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{64,-144},{80,-128}})));
    Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=Heater_flowrate_sensor.y)
      annotation (Placement(transformation(extent={{-10,-148},{12,-126}})));
    Modelica.Blocks.Sources.Constant const11(k=0.01)
      annotation (Placement(transformation(extent={{8,-160},{18,-150}})));
    Modelica.Blocks.Sources.Constant const12(k=0)
      annotation (Placement(transformation(extent={{40,-160},{50,-150}})));
    Modelica.Blocks.Logical.Switch switch3
      annotation (Placement(transformation(extent={{62,-86},{78,-70}})));
    Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=Heater_flowrate_sensor.y)
      annotation (Placement(transformation(extent={{-12,-82},{10,-60}})));
    Modelica.Blocks.Sources.Constant const13(k=0.01)
      annotation (Placement(transformation(extent={{-2,-88},{8,-78}})));
    Modelica.Blocks.Sources.Constant const14(k=0)
      annotation (Placement(transformation(extent={{24,-104},{34,-94}})));
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
      annotation (Placement(transformation(extent={{-32,-312},{-12,-292}})));
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
      annotation (Placement(transformation(extent={{-6,-266},{14,-246}})));
    Systems.ExperimentalSystems.MAGNET.Data.Data_base_An data
      annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
    Modelica.Blocks.Sources.Constant const15(k=1)
      annotation (Placement(transformation(extent={{36,-122},{46,-112}})));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual1
      annotation (Placement(transformation(extent={{32,-86},{42,-76}})));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual2
      annotation (Placement(transformation(extent={{32,-146},{42,-136}})));
    Modelica.Blocks.Continuous.LimPID PIDV8(
      yMax=1,
      k=0.00007*1,
      Ti=1,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0)
      annotation (Placement(transformation(extent={{34,-198},{48,-184}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder7(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{70,-196},{82,-184}})));
    Modelica.Blocks.Sources.CombiTimeTable P_GT_demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0.4; 12000,0.4; 14400,
          1; 18000,1],
        startTime=0)
      annotation (Placement(transformation(extent={{-38,-198},{-24,-184}})));
    Modelica.Blocks.Math.Gain GT_demand(k=data.GT_demand)
      annotation (Placement(transformation(extent={{-6,-196},{4,-186}})));
    Modelica.Blocks.Sources.Constant const6(k=data.T_hot_side)
      annotation (Placement(transformation(extent={{82,-272},{92,-262}})));
    Modelica.Blocks.Sources.Constant SS_BOP_demand(k=100)
      annotation (Placement(transformation(extent={{-138,82},{-118,102}})));
    Modelica.Blocks.Sources.Constant SS_heater_demand(k=1)
      annotation (Placement(transformation(extent={{-90,82},{-70,102}})));
    Modelica.Blocks.Sources.Constant SS_GT_demand(k=1)
      annotation (Placement(transformation(extent={{-54,-230},{-34,-210}})));
    TRANSFORM.Controls.LimPID Chromolox_Heater_Control1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.125,
      Ti=1,
      k_s=1,
      k_m=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=19376)
      annotation (Placement(transformation(extent={{104,-274},{116,-262}})));
    Modelica.Blocks.Math.Gain Tout_TEDS_side(k=1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-139,-195})));
    Modelica.Blocks.Sources.Constant TES_Discharge_load(k=0)
      annotation (Placement(transformation(extent={{-116,46},{-96,66}})));
    Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
          BOP_total_demand.y, Heater_Total_Demand.y))
      annotation (Placement(transformation(extent={{-36,116},{-14,138}})));
  protected
    Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
      annotation (Placement(transformation(extent={{-70,-308},{-58,-296}})));
    Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
      annotation (Placement(transformation(extent={{-76,-262},{-64,-250}})));
  initial equation
    Q_TES_discharge = 0.0;
    //storage_button=0;
  equation
    //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
    mediums.p = 1e5;
    mediums.T = 275+273;

  //Error1 = pulse.y;
  algorithm

  m_tes_discharged := TES_Discharge_load.y/(Cp*(T_hot_design - T_cold_design)) "amount of TES flow rate needed for discharge";

  if HX_heat.y > Heater_BOP_Demand.y then
    m_tes_charged:= (HX_heat.y-Heater_BOP_Demand.y)/(Cp*(T_hot_design - T_cold_design));
  else
    m_tes_charged:= 0;
  end if;

  //m_tes_charged := HX_heat.y/(Cp*(T_hot_design - T_cold_design));

  Q_TES_discharge :=Discharge_mass_flow_sensor.y*Cp*(T_hot_design - Tout_TEDS_side.y);

  m_bop_heater_demand :=Heater_BOP_Demand.y/(Cp*(T_hot_design - T_cold_design));

  Heat_needed_GT :=GT_demand.y/data.eta_mech;

  m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

  m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

  Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

  //Valve 2 Used for HeaterBOPDemand

  Error2 :=(m_bop_heater_demand - Heater_BOP_mass_flow.y)/m_tes_max;

                                                                           // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
  //Valve 3 used for TES discharge

  if TES_Discharge_load.y > 0 and delay(storage_button,15) == 0 then
    Error3 :=(m_tes_discharged - Discharge_mass_flow_sensor.y)/m_tes_max;
    else
    Error3 :=-1;
  end if;

  //Valve 1 used for TES Charge
  if m_tes_charged > 0.001 then // charging
    Error1 :=(m_tes_charged - Charge_mass_flow_sensor.y)/m_tes_max;
    //storage_button :=1;
  else
    Error1 :=-1;
    //storage_button :=0;
  end if;

    //Designation of the TEDS valve control algorithms.

   //Interlock System for the valves.
    if m_tes_charged > 0.001 then
      Error4 :=1;
      storage_button :=1;
    else
      Error4 :=-1;
      storage_button :=0;
    end if;

    if m_tes_discharged > 0.001 then
      Error5 :=1;
    else
      Error5 :=-1;
    end if;

  // Main Heater Mass Flow Control
    if m_tes_charged > 0.001 or m_bop_heater_demand > 0.001 then // makes sure that valve 6 is open when there is extra heat from MAGNET
      Error6 :=1; //(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
    else
      Error6 :=-1;
    end if;

  //Mode Determination System

  equation
    connect(PIDV1.y,firstOrder. u) annotation (Line(points={{84.7,129},{94.6,129}},
                                   color={0,0,127}));
    connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{84.7,97},{96.6,97}},
                                       color={0,0,127}));
    connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{78.7,63},{92.35,
            63},{92.35,64},{96.8,64}}, color={0,0,127}));
    connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{80.7,31},{94.35,
            31},{94.35,32},{98.8,32}},    color={0,0,127}));
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{82.7,1},{96.35,1},
            {96.35,2},{100.8,2}},         color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-29},{90.35,
            -29},{90.35,-28},{94.8,-28}}, color={0,0,127}));
    connect(sensorSubBus.Valve_1_Opening, firstOrder.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,129},{110.7,129}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_2_Opening, firstOrder1.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,97},{112.7,97}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_4_Opening, firstOrder3.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,32},{112.6,32}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_5_Opening, firstOrder4.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,2},{114.6,2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_6_Opening, firstOrder5.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,-28},{108.6,-28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,64},{110.6,64}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,9},{-172.4,9}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-4},{-172.4,-4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
       Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-18},{-172.4,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-244},{-150.4,-244}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-57},{-151,-57}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-73},{-151,-73}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-89},{-151,-89}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-105},{-151,-105}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-121},{-151,-121}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-155},{-151,-155}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.MAGNET_valve3_opening,firstOrder8. y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,-142},{104.6,-142}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.MAGNET_valve_opening,firstOrder6. y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,-66},{104.6,-66}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,PIDV7. u_s)
      annotation (Line(points={{-47.5,-49},{-25.4,-49}},
                                                     color={0,0,127}));
    connect(MAGNET_valve.y,PIDV7. u_m)
      annotation (Line(points={{-39,-64},{-17,-64},{-17,-57.4}},
                                                           color={0,0,127}));
    connect(Valve1.y, PIDV1.u_s)
      annotation (Line(points={{49.1,129},{68.6,129}}, color={0,0,127}));
    connect(const.y, PIDV1.u_m) annotation (Line(points={{60.5,113},{77,113},{
            77,120.6}},
          color={0,0,127}));
    connect(Valve2.y, PIDV2.u_s)
      annotation (Line(points={{45.1,97},{68.6,97}}, color={0,0,127}));
    connect(const1.y, PIDV2.u_m) annotation (Line(points={{60.5,79},{60.5,78},{
            77,78},{77,88.6}},
                            color={0,0,127}));
    connect(Valve3.y, PIDV3.u_s)
      annotation (Line(points={{41.1,63},{62.6,63}}, color={0,0,127}));
    connect(const2.y, PIDV3.u_m) annotation (Line(points={{60.5,45},{60.5,44},{
            71,44},{71,54.6}},
                            color={0,0,127}));
    connect(Valve4.y, PIDV4.u_s)
      annotation (Line(points={{33.1,31},{64.6,31}}, color={0,0,127}));
    connect(const3.y, PIDV4.u_m) annotation (Line(points={{60.5,13},{60.5,16},{
            73,16},{73,22.6}},
                       color={0,0,127}));
    connect(Valve5.y, PIDV5.u_s)
      annotation (Line(points={{35.1,1},{66.6,1}},     color={0,0,127}));
    connect(const4.y, PIDV5.u_m) annotation (Line(points={{54.5,-13},{68,-13},{
            68,-7.4},{75,-7.4}},color={0,0,127}));
    connect(const5.y, PIDV6.u_m) annotation (Line(points={{46.5,-43},{46.5,
            -37.4},{69,-37.4}},
                         color={0,0,127}));
    connect(Valve6.y, PIDV6.u_s)
      annotation (Line(points={{31.1,-29},{60.6,-29}}, color={0,0,127}));
    connect(const12.y, switch2.u3) annotation (Line(points={{50.5,-155},{56,-155},
            {56,-142.4},{62.4,-142.4}},       color={0,0,127}));
    connect(switch2.y, firstOrder8.u) annotation (Line(points={{80.8,-136},{84,-136},
            {84,-142},{90.8,-142}},       color={0,0,127}));
    connect(const14.y, switch3.u3) annotation (Line(points={{34.5,-99},{54,-99},
            {54,-84.4},{60.4,-84.4}}, color={0,0,127}));
    connect(PIDV7.y, switch3.u1) annotation (Line(points={{-9.3,-49},{32,-49},{
            32,-64},{60.4,-64},{60.4,-71.6}}, color={0,0,127}));
    connect(switch3.y, firstOrder6.u) annotation (Line(points={{78.8,-78},{84,
            -78},{84,-66},{90.8,-66}}, color={0,0,127}));
    connect(actuatorSubBus.Tin_vc, cw_mf_control.u_m) annotation (Line(
        points={{-22,-395},{-22,-314}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
        points={{40,-395},{40,-302},{-11,-302}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Tout_vc_design.y,N2_mf_control. u_s)
      annotation (Line(points={{-63.4,-256},{-8,-256}}, color={0,0,127}));
    connect(actuatorSubBus.Tout_vc, N2_mf_control.u_m) annotation (Line(
        points={{-22,-395},{-22,-396},{4,-396},{4,-268}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (Line(
        points={{40,-395},{40,-256},{15,-256}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const15.y, switch2.u1) annotation (Line(points={{46.5,-117},{62.4,-117},
            {62.4,-129.6}},       color={0,0,127}));
    connect(greaterEqual1.u1, mflow_TEDS2.y) annotation (Line(points={{31,-81},
            {16,-81},{16,-71},{11.1,-71}}, color={0,0,127}));
    connect(greaterEqual1.u2, const13.y) annotation (Line(points={{31,-85},{16,
            -85},{16,-83},{8.5,-83}}, color={0,0,127}));
    connect(greaterEqual1.y, switch3.u2) annotation (Line(points={{42.5,-81},{
            42.5,-78},{60.4,-78}}, color={255,0,255}));
    connect(greaterEqual2.u1, mflow_TEDS1.y) annotation (Line(points={{31,-141},{18,
            -141},{18,-137},{13.1,-137}},     color={0,0,127}));
    connect(greaterEqual2.u2, const11.y) annotation (Line(points={{31,-145},{22,-145},
            {22,-155},{18.5,-155}},       color={0,0,127}));
    connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{42.5,-141},{54,
            -141},{54,-136},{62.4,-136}},    color={255,0,255}));
    connect(cw_mf_control.u_s, Tin_vc_design.y)
      annotation (Line(points={{-34,-302},{-57.4,-302}}, color={0,0,127}));
    connect(actuatorSubBus.GT_Power,PIDV8. u_m) annotation (Line(
        points={{-22,-395},{-22,-322},{41,-322},{41,-199.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(firstOrder7.u,PIDV8. y) annotation (Line(points={{68.8,-190},{58.75,-190},
            {58.75,-191},{48.7,-191}},
                                     color={0,0,127}));
    connect(sensorSubBus.MAGNET_valve2_opening,firstOrder7. y) annotation (Line(
        points={{40,-395},{44,-395},{44,-398},{178,-398},{178,-190},{82.6,-190}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(GT_demand.y, PIDV8.u_s)
      annotation (Line(points={{4.5,-191},{32.6,-191}}, color={0,0,127}));
    connect(actuatorSubBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-137},{-151,-137}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(SS_BOP_demand.y, BOP_total_demand.u)
      annotation (Line(points={{-117,92},{-97,92},{-97,127}}, color={0,0,127}));
    connect(SS_heater_demand.y, Heater_Total_Demand.u)
      annotation (Line(points={{-69,92},{-57,92},{-57,127}}, color={0,0,127}));
    connect(SS_GT_demand.y, GT_demand.u) annotation (Line(points={{-33,-220},{-12,
            -220},{-12,-191},{-7,-191}}, color={0,0,127}));
    connect(const6.y, Chromolox_Heater_Control1.u_s) annotation (Line(points={{92.5,
            -267},{92.5,-268},{102.8,-268}}, color={0,0,127}));
    connect(sensorSubBus.Pump_Flow, Chromolox_Heater_Control1.y) annotation (Line(
        points={{40,-395},{178,-395},{178,-268},{116.6,-268}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Tout_TEDSide, Tout_TEDS_side.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-195},{-145,-195}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Tout_TEDSide, Chromolox_Heater_Control1.u_m)
      annotation (Line(
        points={{-22,-395},{40,-395},{40,-314},{110,-314},{110,-275.2}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
              -400},{180,140}})),
                            Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-400},{180,140}})));
  end Control_System_Therminol_4_element_all_modes_MAGNET_GT_SS;

  model Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0
    "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);

  package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-46,-418},{2,-372}})));
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
      annotation (Placement(transformation(extent={{16,-418},{64,-372}})));
    Modelica.Blocks.Continuous.LimPID PIDV1(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.03*0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,122},{84,136}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{50,108},{60,118}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,122},{110,136}})));
    Modelica.Blocks.Continuous.LimPID PIDV2(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,90},{84,104}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{50,74},{60,84}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{98,90},{112,104}})));
    Modelica.Blocks.Continuous.LimPID PIDV3(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.0005*0.007*3600,
      Ti=4.25,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0) annotation (Placement(transformation(extent={{64,56},{78,70}})));
    Modelica.Blocks.Sources.Constant const2(k=0)
      annotation (Placement(transformation(extent={{50,40},{60,50}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,58},{110,70}})));
    Modelica.Blocks.Continuous.LimPID PIDV4(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0) annotation (Placement(transformation(extent={{66,24},{80,38}})));
    Modelica.Blocks.Sources.Constant const3(k=0)
      annotation (Placement(transformation(extent={{50,8},{60,18}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{100,26},{112,38}})));
    Modelica.Blocks.Continuous.LimPID PIDV5(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      yMin=0.0)
      annotation (Placement(transformation(extent={{68,-6},{82,8}})));
    Modelica.Blocks.Sources.Constant const4(k=0)
      annotation (Placement(transformation(extent={{44,-18},{54,-8}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{102,-4},{114,8}})));
    Modelica.Blocks.Continuous.LimPID PIDV6(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.0)
      annotation (Placement(transformation(extent={{62,-36},{76,-22}})));
    Modelica.Blocks.Sources.Constant const5(k=0)
      annotation (Placement(transformation(extent={{36,-48},{46,-38}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
      annotation (Placement(transformation(extent={{96,-34},{108,-22}})));
    Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
      annotation (Placement(transformation(extent={{26,118},{48,140}})));
    Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
      annotation (Placement(transformation(extent={{22,86},{44,108}})));
    Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
      annotation (Placement(transformation(extent={{18,52},{40,74}})));
    Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
      annotation (Placement(transformation(extent={{10,20},{32,42}})));
    Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
      annotation (Placement(transformation(extent={{8,-40},{30,-18}})));
    Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
      annotation (Placement(transformation(extent={{12,-10},{34,12}})));

  Real Error1 "Valve 1";
  Real Error2 "Valve 2";
  Real Error3 "Valve 3";
  Real Error4 "Valve 4";
  Real Error5 "Valve 5";
  Real Error6 "Valve 6";
  Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
  //Real Error_TSP "Error between Tout TEDS side and T_hot design";

  Integer storage_button "0 equals discharge or stationary, 1 is charging";

  parameter SI.Power Q_TES_max = 175e3;
  parameter SI.Power Heater_max = 175e3;
  parameter SI.Temperature T_hot_design = 325;
  parameter SI.Temperature T_cold_design = 225;

  parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
  parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

  SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
  SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
  SI.MassFlowRate m_tes_demand;
  SI.MassFlowRate m_tes_charged;
  SI.MassFlowRate m_heater_demand;
  SI.Power Q_TES_charge;
  SI.Power Q_TES_discharge;
  SI.Power Heat_needed_GT;
  SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity
  SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

  parameter SI.Pressure p_atm = 1e5;
  parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
  parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
  parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(450);

  Medium.BaseProperties mediums;

    Modelica.Blocks.Sources.Constant delayStart(k=20)
      annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
    TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
      "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,-2},{-146,20}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-14},{-146,6}})));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

    TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-28},{-146,-8}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-66,38},{-44,60}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-148,-254},{-124,-234}})));
    Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
          BOP_total_demand.y, TES_Discharge_load.y))
      annotation (Placement(transformation(extent={{-40,114},{-18,136}})));
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,100,1; 1800,
          100,1; 3600,100,4; 4800,100,2; 7200,100,4; 9600,100,5; 10800,100,5; 12000,
          100,0.0; 14400,100,0.0; 18000,100,0],       startTime=0)
      annotation (Placement(transformation(extent={{-120,120},{-106,134}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-96,122},{-86,132}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
          18000,1], startTime=0)
      annotation (Placement(transformation(extent={{-80,120},{-66,134}})));
    Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
      annotation (Placement(transformation(extent={{-56,122},{-46,132}})));
    Modelica.Blocks.Math.Gain Tin_MT_HX(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-57})));
    Modelica.Blocks.Math.Gain Tout_MT_HX(k=1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-73})));
    Modelica.Blocks.Math.Gain mf_MT_HX(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-89})));
    Modelica.Blocks.Math.Gain HX_heat(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-105})));
    Modelica.Blocks.Math.Gain Tin_TEDside(k=1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-121})));
    Modelica.Blocks.Math.Gain mf_vc_GT(k=1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-137})));
    Modelica.Blocks.Math.Gain mflow_inside_MAGNET(k=1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-145,-155})));
    Modelica.Blocks.Continuous.LimPID PIDV7(
      yMax=1,
      k=-0.007*36,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0)
      annotation (Placement(transformation(extent={{-24,-56},{-10,-42}})));
    Modelica.Blocks.Sources.Constant const7(k=0)
      annotation (Placement(transformation(extent={{-58,-54},{-48,-44}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder6(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{92,-72},{104,-60}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder8(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{92,-148},{104,-136}})));
    Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
      annotation (Placement(transformation(extent={{-60,-74},{-40,-54}})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{64,-144},{80,-128}})));
    Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=Heater_flowrate_sensor.y)
      annotation (Placement(transformation(extent={{-10,-148},{12,-126}})));
    Modelica.Blocks.Sources.Constant const11(k=0.01)
      annotation (Placement(transformation(extent={{8,-160},{18,-150}})));
    Modelica.Blocks.Sources.Constant const12(k=0)
      annotation (Placement(transformation(extent={{40,-160},{50,-150}})));
    Modelica.Blocks.Logical.Switch switch3
      annotation (Placement(transformation(extent={{62,-86},{78,-70}})));
    Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=Heater_flowrate_sensor.y)
      annotation (Placement(transformation(extent={{-12,-82},{10,-60}})));
    Modelica.Blocks.Sources.Constant const13(k=0.01)
      annotation (Placement(transformation(extent={{-2,-88},{8,-78}})));
    Modelica.Blocks.Sources.Constant const14(k=0)
      annotation (Placement(transformation(extent={{24,-104},{34,-94}})));
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
      annotation (Placement(transformation(extent={{-32,-312},{-12,-292}})));
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
      annotation (Placement(transformation(extent={{-6,-266},{14,-246}})));
    Systems.ExperimentalSystems.MAGNET.Data.Data_base_An data
      annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
    Modelica.Blocks.Sources.Constant const15(k=1)
      annotation (Placement(transformation(extent={{36,-122},{46,-112}})));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual1
      annotation (Placement(transformation(extent={{32,-86},{42,-76}})));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual2
      annotation (Placement(transformation(extent={{32,-146},{42,-136}})));
    Modelica.Blocks.Continuous.LimPID PIDV8(
      yMax=1,
      k=0.00007*1,
      Ti=1,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0)
      annotation (Placement(transformation(extent={{34,-198},{48,-184}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder7(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{70,-196},{82,-184}})));
    Modelica.Blocks.Sources.CombiTimeTable P_GT_demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,1; 12000,1; 14400,1;
          18000,1; 20000,0.4; 30000,0.4; 36000,1; 40000,1],
        startTime=0)
      annotation (Placement(transformation(extent={{-38,-198},{-24,-184}})));
    Modelica.Blocks.Math.Gain GT_demand(k=data.GT_demand)
      annotation (Placement(transformation(extent={{-6,-196},{4,-186}})));
    Modelica.Blocks.Sources.Constant const6(k=data.T_hot_side)
      annotation (Placement(transformation(extent={{82,-272},{92,-262}})));
    Modelica.Blocks.Sources.Constant SS_BOP_demand(k=100)
      annotation (Placement(transformation(extent={{-138,82},{-118,102}})));
    Modelica.Blocks.Sources.Constant SS_heater_demand(k=1)
      annotation (Placement(transformation(extent={{-90,82},{-70,102}})));
    Modelica.Blocks.Sources.Constant SS_GT_demand(k=1)
      annotation (Placement(transformation(extent={{-54,-230},{-34,-210}})));
    TRANSFORM.Controls.LimPID Chromolox_Heater_Control1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.125,
      Ti=1,
      k_s=1,
      k_m=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=19376)
      annotation (Placement(transformation(extent={{104,-274},{116,-262}})));
    Modelica.Blocks.Math.Gain Tout_TEDS_side(k=1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-139,-195})));
    Modelica.Blocks.Sources.Constant TES_Discharge_load(k=0)
      annotation (Placement(transformation(extent={{-116,46},{-96,66}})));
  protected
    Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
      annotation (Placement(transformation(extent={{-70,-308},{-58,-296}})));
    Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
      annotation (Placement(transformation(extent={{-76,-262},{-64,-250}})));
  initial equation
    Q_TES_discharge = 0.0;
    //storage_button=0;
  equation
    //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
    mediums.p = 1e5;
    mediums.T = 275+273;

  //Error1 = pulse.y;
  algorithm

  //  Error_TSP := (Tout_TEDS_side.y - T_hot_design)/T_hot_design;

  Q_TES_charge := m_MAGNET_left*(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

  m_tes_demand := TES_Discharge_load.y/(Cp*(T_hot_design - T_cold_design)) "amount of TES flow rate needed for discharge";

  m_tes_charged := HX_heat.y/(Cp*(T_hot_design - T_cold_design));

  m_heater_demand :=GT_demand.y/(Cp*(T_hot_design - T_cold_design));

  Q_TES_discharge :=Discharge_mass_flow_sensor.y*Cp*(T_hot_design - T_cold_design);

  m_bop_heater_demand :=Heater_BOP_Demand.y/(Cp*(T_hot_design - T_cold_design));

  Heat_needed_GT :=GT_demand.y/data.eta_mech;

  m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

  m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

  Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

  //Valve 2 Used for HeaterBOPDemand

  Error2 :=(m_bop_heater_demand - Heater_BOP_mass_flow.y)/m_tes_max;

                                                                           // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
  //Valve 3 used for TES discharge

  if TES_Discharge_load.y > 0 and delay(storage_button,15) == 0 then
    Error3 :=(m_tes_demand - Discharge_mass_flow_sensor.y)/m_tes_max;
    else
    Error3 :=-1;
  end if;

  //Valve 1 used for TES Charge
  if Q_TES_charge > 0 then // charging
    Error1 :=(abs(m_tes_charged) - Charge_mass_flow_sensor.y)/m_tes_max;
    //storage_button :=1;
  else
    Error1 :=-1;
    //storage_button :=0;
  end if;

    //Designation of the TEDS valve control algorithms.

   //Interlock System for the valves.
    if m_tes_charged > 0.001 then
      Error4 :=1;
      storage_button :=1;
    else
      Error4 :=-1;
      storage_button :=0;
    end if;

    if m_tes_demand > 0.001 then
      Error5 :=1;
    else
      Error5 :=-1;
    end if;

  // Main Heater Mass Flow Control
    if m_tes_charged > 0.001 then // makes sure that valve 6 is open when there is extra heat from MAGNET
      Error6 :=1; //(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
    else
      Error6 :=-1;
    end if;

  //Mode Determination System

  equation
    connect(PIDV1.y,firstOrder. u) annotation (Line(points={{84.7,129},{94.6,129}},
                                   color={0,0,127}));
    connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{84.7,97},{96.6,97}},
                                       color={0,0,127}));
    connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{78.7,63},{92.35,
            63},{92.35,64},{96.8,64}}, color={0,0,127}));
    connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{80.7,31},{94.35,
            31},{94.35,32},{98.8,32}},    color={0,0,127}));
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{82.7,1},{96.35,1},
            {96.35,2},{100.8,2}},         color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-29},{90.35,
            -29},{90.35,-28},{94.8,-28}}, color={0,0,127}));
    connect(sensorSubBus.Valve_1_Opening, firstOrder.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,129},{110.7,129}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_2_Opening, firstOrder1.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,97},{112.7,97}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_4_Opening, firstOrder3.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,32},{112.6,32}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_5_Opening, firstOrder4.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,2},{114.6,2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_6_Opening, firstOrder5.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,-28},{108.6,-28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,64},{110.6,64}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,9},{-172.4,9}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-4},{-172.4,-4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
       Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-18},{-172.4,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-244},{-150.4,-244}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-57},{-151,-57}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-73},{-151,-73}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-89},{-151,-89}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-105},{-151,-105}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-121},{-151,-121}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
      annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-155},{-151,-155}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.MAGNET_valve3_opening,firstOrder8. y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,-142},{104.6,-142}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.MAGNET_valve_opening,firstOrder6. y) annotation (Line(
        points={{40,-395},{40,-398},{178,-398},{178,-66},{104.6,-66}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,PIDV7. u_s)
      annotation (Line(points={{-47.5,-49},{-25.4,-49}},
                                                     color={0,0,127}));
    connect(MAGNET_valve.y,PIDV7. u_m)
      annotation (Line(points={{-39,-64},{-17,-64},{-17,-57.4}},
                                                           color={0,0,127}));
    connect(Valve1.y, PIDV1.u_s)
      annotation (Line(points={{49.1,129},{68.6,129}}, color={0,0,127}));
    connect(const.y, PIDV1.u_m) annotation (Line(points={{60.5,113},{77,113},{
            77,120.6}},
          color={0,0,127}));
    connect(Valve2.y, PIDV2.u_s)
      annotation (Line(points={{45.1,97},{68.6,97}}, color={0,0,127}));
    connect(const1.y, PIDV2.u_m) annotation (Line(points={{60.5,79},{60.5,78},{
            77,78},{77,88.6}},
                            color={0,0,127}));
    connect(Valve3.y, PIDV3.u_s)
      annotation (Line(points={{41.1,63},{62.6,63}}, color={0,0,127}));
    connect(const2.y, PIDV3.u_m) annotation (Line(points={{60.5,45},{60.5,44},{
            71,44},{71,54.6}},
                            color={0,0,127}));
    connect(Valve4.y, PIDV4.u_s)
      annotation (Line(points={{33.1,31},{64.6,31}}, color={0,0,127}));
    connect(const3.y, PIDV4.u_m) annotation (Line(points={{60.5,13},{60.5,16},{
            73,16},{73,22.6}},
                       color={0,0,127}));
    connect(Valve5.y, PIDV5.u_s)
      annotation (Line(points={{35.1,1},{66.6,1}},     color={0,0,127}));
    connect(const4.y, PIDV5.u_m) annotation (Line(points={{54.5,-13},{68,-13},{
            68,-7.4},{75,-7.4}},color={0,0,127}));
    connect(const5.y, PIDV6.u_m) annotation (Line(points={{46.5,-43},{46.5,
            -37.4},{69,-37.4}},
                         color={0,0,127}));
    connect(Valve6.y, PIDV6.u_s)
      annotation (Line(points={{31.1,-29},{60.6,-29}}, color={0,0,127}));
    connect(const12.y, switch2.u3) annotation (Line(points={{50.5,-155},{56,-155},
            {56,-142.4},{62.4,-142.4}},       color={0,0,127}));
    connect(switch2.y, firstOrder8.u) annotation (Line(points={{80.8,-136},{84,-136},
            {84,-142},{90.8,-142}},       color={0,0,127}));
    connect(const14.y, switch3.u3) annotation (Line(points={{34.5,-99},{54,-99},
            {54,-84.4},{60.4,-84.4}}, color={0,0,127}));
    connect(PIDV7.y, switch3.u1) annotation (Line(points={{-9.3,-49},{32,-49},{
            32,-64},{60.4,-64},{60.4,-71.6}}, color={0,0,127}));
    connect(switch3.y, firstOrder6.u) annotation (Line(points={{78.8,-78},{84,
            -78},{84,-66},{90.8,-66}}, color={0,0,127}));
    connect(actuatorSubBus.Tin_vc, cw_mf_control.u_m) annotation (Line(
        points={{-22,-395},{-22,-314}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
        points={{40,-395},{40,-302},{-11,-302}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Tout_vc_design.y,N2_mf_control. u_s)
      annotation (Line(points={{-63.4,-256},{-8,-256}}, color={0,0,127}));
    connect(actuatorSubBus.Tout_vc, N2_mf_control.u_m) annotation (Line(
        points={{-22,-395},{-22,-396},{4,-396},{4,-268}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (Line(
        points={{40,-395},{40,-256},{15,-256}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const15.y, switch2.u1) annotation (Line(points={{46.5,-117},{62.4,-117},
            {62.4,-129.6}},       color={0,0,127}));
    connect(greaterEqual1.u1, mflow_TEDS2.y) annotation (Line(points={{31,-81},
            {16,-81},{16,-71},{11.1,-71}}, color={0,0,127}));
    connect(greaterEqual1.u2, const13.y) annotation (Line(points={{31,-85},{16,
            -85},{16,-83},{8.5,-83}}, color={0,0,127}));
    connect(greaterEqual1.y, switch3.u2) annotation (Line(points={{42.5,-81},{
            42.5,-78},{60.4,-78}}, color={255,0,255}));
    connect(greaterEqual2.u1, mflow_TEDS1.y) annotation (Line(points={{31,-141},{18,
            -141},{18,-137},{13.1,-137}},     color={0,0,127}));
    connect(greaterEqual2.u2, const11.y) annotation (Line(points={{31,-145},{22,-145},
            {22,-155},{18.5,-155}},       color={0,0,127}));
    connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{42.5,-141},{54,
            -141},{54,-136},{62.4,-136}},    color={255,0,255}));
    connect(cw_mf_control.u_s, Tin_vc_design.y)
      annotation (Line(points={{-34,-302},{-57.4,-302}}, color={0,0,127}));
    connect(actuatorSubBus.GT_Power,PIDV8. u_m) annotation (Line(
        points={{-22,-395},{-22,-322},{41,-322},{41,-199.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(firstOrder7.u,PIDV8. y) annotation (Line(points={{68.8,-190},{58.75,-190},
            {58.75,-191},{48.7,-191}},
                                     color={0,0,127}));
    connect(sensorSubBus.MAGNET_valve2_opening,firstOrder7. y) annotation (Line(
        points={{40,-395},{44,-395},{44,-398},{178,-398},{178,-190},{82.6,-190}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(GT_demand.y, PIDV8.u_s)
      annotation (Line(points={{4.5,-191},{32.6,-191}}, color={0,0,127}));
    connect(actuatorSubBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-137},{-151,-137}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(SS_BOP_demand.y, BOP_total_demand.u)
      annotation (Line(points={{-117,92},{-97,92},{-97,127}}, color={0,0,127}));
    connect(SS_heater_demand.y, Heater_Total_Demand.u)
      annotation (Line(points={{-69,92},{-57,92},{-57,127}}, color={0,0,127}));
    connect(const6.y, Chromolox_Heater_Control1.u_s) annotation (Line(points={{92.5,
            -267},{92.5,-268},{102.8,-268}}, color={0,0,127}));
    connect(sensorSubBus.Pump_Flow, Chromolox_Heater_Control1.y) annotation (Line(
        points={{40,-395},{178,-395},{178,-268},{116.6,-268}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Tout_TEDSide, Tout_TEDS_side.u) annotation (Line(
        points={{-22,-395},{-22,-398},{-178,-398},{-178,-195},{-145,-195}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Tout_TEDSide, Chromolox_Heater_Control1.u_m)
      annotation (Line(
        points={{-22,-395},{40,-395},{40,-314},{110,-314},{110,-275.2}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(P_GT_demand.y[1], GT_demand.u)
      annotation (Line(points={{-23.3,-191},{-7,-191}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
              -400},{180,140}})),
                            Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-400},{180,140}})));
  end Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0;

  model Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1
    "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);

  package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-88,-238},{-40,-192}})));
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
      annotation (Placement(transformation(extent={{46,-238},{94,-192}})));
    Modelica.Blocks.Continuous.LimPID PIDV1(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.005*0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0)
      annotation (Placement(transformation(extent={{134,122},{148,136}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{118,114},{128,124}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{160,122},{174,136}})));
    Modelica.Blocks.Continuous.LimPID PIDV2(
      yMax=1,
      k=0.0007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.0)
      annotation (Placement(transformation(extent={{52,98},{66,112}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{32,90},{42,100}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{80,98},{94,112}})));
    Modelica.Blocks.Continuous.LimPID PIDV3(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.03*0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0) annotation (Placement(transformation(extent={{136,74},{150,88}})));
    Modelica.Blocks.Sources.Constant const2(k=0)
      annotation (Placement(transformation(extent={{118,66},{128,76}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{158,74},{172,88}})));
    Modelica.Blocks.Continuous.LimPID PIDV4(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0) annotation (Placement(transformation(extent={{46,52},{60,66}})));
    Modelica.Blocks.Sources.Constant const3(k=0)
      annotation (Placement(transformation(extent={{30,42},{40,52}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{80,52},{94,66}})));
    Modelica.Blocks.Continuous.LimPID PIDV5(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      yMin=0.0)
      annotation (Placement(transformation(extent={{136,30},{150,44}})));
    Modelica.Blocks.Sources.Constant const4(k=0)
      annotation (Placement(transformation(extent={{120,22},{130,32}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{158,30},{172,44}})));
    Modelica.Blocks.Continuous.LimPID PIDV6(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.0)
      annotation (Placement(transformation(extent={{46,8},{60,22}})));
    Modelica.Blocks.Sources.Constant const5(k=0)
      annotation (Placement(transformation(extent={{30,0},{40,10}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
      annotation (Placement(transformation(extent={{80,10},{92,22}})));
    Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
      annotation (Placement(transformation(extent={{90,118},{112,140}})));
    Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
      annotation (Placement(transformation(extent={{4,94},{26,116}})));
    Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
      annotation (Placement(transformation(extent={{90,70},{112,92}})));
    Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
      annotation (Placement(transformation(extent={{4,48},{26,70}})));
    Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
      annotation (Placement(transformation(extent={{4,4},{26,26}})));
    Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
      annotation (Placement(transformation(extent={{90,26},{112,48}})));

  Real Error1 "Valve 1";
  Real Error2 "Valve 2";
  Real Error3 "Valve 3";
  Real Error4 "Valve 4";
  Real Error5 "Valve 5";
  Real Error6 "Valve 6";
  Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
  //Real Error_TSP "Error between Tout TEDS side and T_hot design";

  Integer storage_button "0 equals discharge or stationary, 1 is charging";

  parameter SI.Power Q_TES_max = 175e3;
  parameter SI.Power Heater_max = 175e3;
  parameter SI.Temperature T_hot_design = 325;
  parameter SI.Temperature T_cold_design = 225;

  parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
  parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

  SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
  SI.MassFlowRate m_bop_heater_demand_graph;
  SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
  SI.MassFlowRate m_tes_discharged;
  SI.MassFlowRate m_tes_charged;
  //SI.Power Q_TES_discharge;
  SI.Power Heat_needed_GT;
  SI.Power Heat_demand;
  SI.Power TES_Load;
  SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity
  SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

  parameter SI.Pressure p_atm = 1e5;
  parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
  parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
  parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(450);

  Medium.BaseProperties mediums;

    Modelica.Blocks.Sources.Constant delayStart(k=20)
      annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
    TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
      "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,54},{-146,76}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,38},{-146,58}})));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

    TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,22},{-146,42}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,6},{-146,26}})));
    Modelica.Blocks.Continuous.LimPID PIDV7(
      yMax=1,
      k=-0.007*36,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0)
      annotation (Placement(transformation(extent={{102,-12},{116,2}})));
    Modelica.Blocks.Sources.Constant const7(k=0)
      annotation (Placement(transformation(extent={{68,-10},{78,0}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder6(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{158,-28},{170,-16}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder8(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{38,-74},{50,-62}})));
    Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
      annotation (Placement(transformation(extent={{66,-30},{86,-10}})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{10,-70},{26,-54}})));
    Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=Heater_flowrate_sensor.y)
      annotation (Placement(transformation(extent={{-64,-74},{-42,-52}})));
    Modelica.Blocks.Sources.Constant const11(k=0.01)
      annotation (Placement(transformation(extent={{-46,-86},{-36,-76}})));
    Modelica.Blocks.Sources.Constant const12(k=0)
      annotation (Placement(transformation(extent={{-14,-86},{-4,-76}})));
    Modelica.Blocks.Logical.Switch switch3
      annotation (Placement(transformation(extent={{128,-42},{144,-26}})));
    Modelica.Blocks.Sources.RealExpression mflow_TEDS2(y=Heater_flowrate_sensor.y)
      annotation (Placement(transformation(extent={{54,-44},{76,-22}})));
    Modelica.Blocks.Sources.Constant const13(k=0.01)
      annotation (Placement(transformation(extent={{60,-52},{70,-42}})));
    Modelica.Blocks.Sources.Constant const14(k=0)
      annotation (Placement(transformation(extent={{100,-62},{110,-52}})));
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
      annotation (Placement(transformation(extent={{46,-180},{62,-164}})));
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
      annotation (Placement(transformation(extent={{152,-152},{168,-136}})));
    Systems.ExperimentalSystems.MAGNET.Data.Data_base_An data
      annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
    Modelica.Blocks.Sources.Constant const15(k=1)
      annotation (Placement(transformation(extent={{-18,-48},{-8,-38}})));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual1
      annotation (Placement(transformation(extent={{98,-42},{108,-32}})));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual2
      annotation (Placement(transformation(extent={{-22,-72},{-12,-62}})));
    Modelica.Blocks.Continuous.LimPID PIDV8(
      yMax=1,
      k=0.00007*1,
      Ti=1,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0)
      annotation (Placement(transformation(extent={{120,-100},{134,-86}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder7(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{156,-98},{168,-86}})));
    Modelica.Blocks.Sources.CombiTimeTable P_GT_demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0.4; 12000,0.4; 14400,
          1; 18000,1],
        startTime=0)
      annotation (Placement(transformation(extent={{-76,50},{-62,64}})));
    Modelica.Blocks.Math.Gain GT_demand(k=data.GT_demand)
      annotation (Placement(transformation(extent={{94,-98},{104,-88}})));
    Modelica.Blocks.Sources.Constant const6(k=data.T_hot_side)
      annotation (Placement(transformation(extent={{-12,-130},{-2,-120}})));
    Modelica.Blocks.Sources.Constant SS_GT_demand(k=1)
      annotation (Placement(transformation(extent={{66,-100},{80,-86}})));
    TRANSFORM.Controls.LimPID TEDS_pump_Control(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.125,
      Ti=1,
      k_s=1,
      k_m=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=19376)
      annotation (Placement(transformation(extent={{10,-132},{22,-120}})));
    Modelica.Blocks.Sources.Constant TES_Discharge_load(k=0)
      annotation (Placement(transformation(extent={{-116,46},{-96,66}})));
    Modelica.Blocks.Sources.CombiTimeTable BOP_heater_demand(table=[0.0,1;
          1800,1; 3600,1; 4800,1; 7200,1; 9000,1; 9999.9,1; 10000,0.1; 12200,
          0.1; 14400,0.1; 18000,0.3; 22000,0.3; 24500,0.5; 30000,0.5; 33000,0;
          40000,0],          startTime=0)
      annotation (Placement(transformation(extent={{-36,120},{-22,134}})));
    Modelica.Blocks.Math.Gain Heater_BOP_Demand(k=100000)
      annotation (Placement(transformation(extent={{-12,122},{-2,132}})));
    TRANSFORM.Blocks.RealExpression mflow_inside_MAGNET
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-10},{-146,10}})));
    TRANSFORM.Blocks.RealExpression Tout_TEDS_side "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-26},{-146,-6}})));
    TRANSFORM.Blocks.RealExpression Tin_MT_HX "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-42},{-146,-22}})));
    TRANSFORM.Blocks.RealExpression Tout_MT_HX "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-58},{-146,-38}})));
    TRANSFORM.Blocks.RealExpression mf_MT_HX "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-74},{-146,-54}})));
    TRANSFORM.Blocks.RealExpression HX_heat "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-90},{-146,-70}})));
    TRANSFORM.Blocks.RealExpression Tin_TEDside "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-106},{-146,-86}})));
    TRANSFORM.Blocks.RealExpression mf_vc_GT "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-122},{-146,-102}})));
    TRANSFORM.Blocks.RealExpression GT_Power_sensor "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-138},{-146,-118}})));
    TRANSFORM.Blocks.RealExpression Tout_vc "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-154},{-146,-134}})));
    Modelica.Blocks.Sources.RealExpression GT_Power_generated(y=GT_Power_sensor.y)
      annotation (Placement(transformation(extent={{88,-124},{110,-102}})));
    Modelica.Blocks.Sources.RealExpression T_TEDSide_out(y=Tout_TEDS_side.y)
      annotation (Placement(transformation(extent={{-24,-154},{-2,-132}})));
    Modelica.Blocks.Sources.RealExpression T_vc_out(y=Tout_vc.y)
      annotation (Placement(transformation(extent={{84,-168},{106,-146}})));
    TRANSFORM.Blocks.RealExpression Tin_vc "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-170},{-146,-150}})));
    Modelica.Blocks.Sources.RealExpression T_vc_in(y=Tin_vc.y)
      annotation (Placement(transformation(extent={{-16,-196},{6,-174}})));
    Modelica.Blocks.Sources.CombiTimeTable P_GT_demand1(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0.4; 12000,0.4; 14400,
          1; 18000,1], startTime=0)
      annotation (Placement(transformation(extent={{32,-110},{46,-96}})));
  protected
    Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
      annotation (Placement(transformation(extent={{10,-178},{22,-166}})));
    Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
      annotation (Placement(transformation(extent={{126,-150},{138,-138}})));
  initial equation
  //  Q_TES_discharge = 0.0;
    //storage_button=0;
  equation
    //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
    mediums.p = 1e5;
    mediums.T = 275+273;

    if clock.y <1e4 then
      Heat_demand = HX_heat.y;
    else
      Heat_demand = Heater_BOP_Demand.y;
    end if;

    TES_Load = -(Heat_demand - HX_heat.y);

     if clock.y <1e4 then
      m_bop_heater_demand_graph = Heat_demand/(Cp*(T_hot_design - T_cold_design));
    else
      m_bop_heater_demand_graph = Heater_BOP_Demand.y/(Cp*(T_hot_design - T_cold_design));
    end if;

  //Error1 = pulse.y;
  algorithm

  if clock.y >1e4 then
    m_tes_discharged:= (Heater_BOP_Demand.y - HX_heat.y)/(Cp*(T_hot_design - T_cold_design))
                                                                                            "amount of TES flow rate needed for discharge";
  else
    m_tes_discharged := 0;
  end if;

  if HX_heat.y > Heater_BOP_Demand.y then
    m_tes_charged:= (HX_heat.y-Heater_BOP_Demand.y)/(Cp*(T_hot_design - T_cold_design));
  else
    m_tes_charged:= 0;
  end if;

  m_bop_heater_demand :=Heater_BOP_Demand.y/(Cp*(T_hot_design - T_cold_design));

  Heat_needed_GT :=GT_demand.y/data.eta_mech;

  m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

  m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

  Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

  //Valve 2 Used for HeaterBOPDemand

  Error2 :=(m_bop_heater_demand - Heater_BOP_mass_flow.y)/m_tes_max;

                                                                           // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
  //Valve 3 used for TES discharge

  if m_tes_discharged > 0 and delay(storage_button,15) == 0 then
    Error3 :=(m_tes_discharged - Discharge_mass_flow_sensor.y)/m_tes_max;
    else
    Error3 :=-1;
  end if;

  //Valve 1 used for TES Charge
  if m_tes_charged > 0.001 then // charging
    Error1 :=(m_tes_charged - Charge_mass_flow_sensor.y)/m_tes_max;
  else
    Error1 :=-1;
    //storage_button :=0;
  end if;

    //Designation of the TEDS valve control algorithms.

   //Interlock System for the valves.
    if m_tes_charged > 0.001 then
      Error4 :=1;
      storage_button :=1;
    else
      Error4 :=-1;
      storage_button :=0;
    end if;

    if m_tes_discharged > 0.001 then
      Error5 :=1;
    else
      Error5 :=-1;
    end if;

  // Main Heater Mass Flow Control
    if m_tes_charged > 0.001 or m_bop_heater_demand > 0.001 then // makes sure that valve 6 is open when there is extra heat from MAGNET
      Error6 :=1; //(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
    else
      Error6 :=-1;
    end if;

  //Mode Determination System

  equation
    connect(PIDV1.y,firstOrder. u) annotation (Line(points={{148.7,129},{158.6,129}},
                                   color={0,0,127}));
    connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{66.7,105},{78.6,105}},
                                       color={0,0,127}));
    connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{150.7,81},{156.6,81}},
                                       color={0,0,127}));
    connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{60.7,59},{78.6,59}},
                                          color={0,0,127}));
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{150.7,37},{156.6,37}},
                                          color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{60.7,15},{74.35,15},
            {74.35,16},{78.8,16}},        color={0,0,127}));
    connect(sensorSubBus.Valve_1_Opening, firstOrder.y) annotation (Line(
        points={{70,-215},{180,-215},{180,129},{174.7,129}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_2_Opening, firstOrder1.y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,105},{94.7,105}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_4_Opening, firstOrder3.y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,59},{94.7,59}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_5_Opening, firstOrder4.y) annotation (Line(
        points={{70,-215},{180,-215},{180,37},{172.7,37}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_6_Opening, firstOrder5.y) annotation (Line(
        points={{70,-215},{180,-215},{180,16},{92.6,16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{70,-215},{180,-215},{180,81},{172.7,81}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
      annotation (Line(
        points={{-64,-215},{-180,-215},{-180,65},{-172.4,65}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
      annotation (Line(
        points={{-64,-215},{-180,-215},{-180,48},{-172.4,48}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(sensorSubBus.MAGNET_valve3_opening,firstOrder8. y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,-68},{50.6,-68}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.MAGNET_valve_opening,firstOrder6. y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,-22},{170.6,-22}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(MAGNET_valve.y,PIDV7. u_m)
      annotation (Line(points={{87,-20},{109,-20},{109,-13.4}},
                                                           color={0,0,127}));
    connect(Valve1.y, PIDV1.u_s)
      annotation (Line(points={{113.1,129},{132.6,129}},
                                                       color={0,0,127}));
    connect(const.y, PIDV1.u_m) annotation (Line(points={{128.5,119},{141,119},{141,
            120.6}},
          color={0,0,127}));
    connect(Valve2.y, PIDV2.u_s)
      annotation (Line(points={{27.1,105},{50.6,105}},
                                                     color={0,0,127}));
    connect(const1.y, PIDV2.u_m) annotation (Line(points={{42.5,95},{42.5,94},{59,
            94},{59,96.6}}, color={0,0,127}));
    connect(Valve3.y, PIDV3.u_s)
      annotation (Line(points={{113.1,81},{134.6,81}},
                                                     color={0,0,127}));
    connect(const2.y, PIDV3.u_m) annotation (Line(points={{128.5,71},{128.5,70},{143,
            70},{143,72.6}},color={0,0,127}));
    connect(Valve4.y, PIDV4.u_s)
      annotation (Line(points={{27.1,59},{44.6,59}}, color={0,0,127}));
    connect(const3.y, PIDV4.u_m) annotation (Line(points={{40.5,47},{40.5,48},{53,
            48},{53,50.6}},
                       color={0,0,127}));
    connect(Valve5.y, PIDV5.u_s)
      annotation (Line(points={{113.1,37},{134.6,37}}, color={0,0,127}));
    connect(const4.y, PIDV5.u_m) annotation (Line(points={{130.5,27},{142.75,27},{
            142.75,28.6},{143,28.6}},
                                color={0,0,127}));
    connect(const5.y, PIDV6.u_m) annotation (Line(points={{40.5,5},{46.75,5},{46.75,
            6.6},{53,6.6}},
                         color={0,0,127}));
    connect(Valve6.y, PIDV6.u_s)
      annotation (Line(points={{27.1,15},{44.6,15}},   color={0,0,127}));
    connect(const12.y, switch2.u3) annotation (Line(points={{-3.5,-81},{2,-81},{2,
            -68.4},{8.4,-68.4}},              color={0,0,127}));
    connect(switch2.y, firstOrder8.u) annotation (Line(points={{26.8,-62},{30,-62},
            {30,-68},{36.8,-68}},         color={0,0,127}));
    connect(const14.y, switch3.u3) annotation (Line(points={{110.5,-57},{120,-57},
            {120,-40.4},{126.4,-40.4}},
                                      color={0,0,127}));
    connect(switch3.y, firstOrder6.u) annotation (Line(points={{144.8,-34},{150,-34},
            {150,-22},{156.8,-22}},    color={0,0,127}));
    connect(Tout_vc_design.y,N2_mf_control. u_s)
      annotation (Line(points={{138.6,-144},{150.4,-144}},
                                                        color={0,0,127}));
    connect(sensorSubBus.MAGNET_flow_control, N2_mf_control.y) annotation (Line(
        points={{70,-215},{180,-215},{180,-144},{168.8,-144}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const15.y, switch2.u1) annotation (Line(points={{-7.5,-43},{8.4,-43},{
            8.4,-55.6}},          color={0,0,127}));
    connect(greaterEqual1.u1, mflow_TEDS2.y) annotation (Line(points={{97,-37},{82,
            -37},{82,-33},{77.1,-33}},     color={0,0,127}));
    connect(greaterEqual1.u2, const13.y) annotation (Line(points={{97,-41},{86,-41},
            {86,-47},{70.5,-47}},     color={0,0,127}));
    connect(greaterEqual1.y, switch3.u2) annotation (Line(points={{108.5,-37},{108.5,
            -34},{126.4,-34}},     color={255,0,255}));
    connect(greaterEqual2.u1, mflow_TEDS1.y) annotation (Line(points={{-23,-67},{-36,
            -67},{-36,-63},{-40.9,-63}},      color={0,0,127}));
    connect(greaterEqual2.u2, const11.y) annotation (Line(points={{-23,-71},{-32,-71},
            {-32,-81},{-35.5,-81}},       color={0,0,127}));
    connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{-11.5,-67},{0,-67},
            {0,-62},{8.4,-62}},              color={255,0,255}));
    connect(cw_mf_control.u_s, Tin_vc_design.y)
      annotation (Line(points={{44.4,-172},{22.6,-172}}, color={0,0,127}));
    connect(firstOrder7.u,PIDV8. y) annotation (Line(points={{154.8,-92},{144.75,-92},
            {144.75,-93},{134.7,-93}},
                                     color={0,0,127}));
    connect(sensorSubBus.MAGNET_valve2_opening,firstOrder7. y) annotation (Line(
        points={{70,-215},{180,-215},{180,-92},{168.6,-92}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(GT_demand.y, PIDV8.u_s)
      annotation (Line(points={{104.5,-93},{118.6,-93}},color={0,0,127}));

    connect(const6.y, TEDS_pump_Control.u_s) annotation (Line(points={{-1.5,-125},
            {-1.5,-126},{8.8,-126}}, color={0,0,127}));
    connect(BOP_heater_demand.y[1], Heater_BOP_Demand.u)
      annotation (Line(points={{-21.3,127},{-13,127}},
                                                     color={0,0,127}));
    connect(const7.y, PIDV7.u_s) annotation (Line(points={{78.5,-5},{89.55,-5},{89.55,
            -5},{100.6,-5}}, color={0,0,127}));
    connect(PIDV7.y, switch3.u1) annotation (Line(points={{116.7,-5},{126.4,-5},{126.4,
            -27.6}}, color={0,0,127}));
    connect(GT_Power_generated.y, PIDV8.u_m) annotation (Line(points={{111.1,-113},
            {127,-113},{127,-101.4}}, color={0,0,127}));
    connect(T_TEDSide_out.y, TEDS_pump_Control.u_m) annotation (Line(points={{-0.9,
            -143},{16,-143},{16,-133.2}}, color={0,0,127}));
    connect(T_vc_out.y, N2_mf_control.u_m) annotation (Line(points={{107.1,-157},{
            160,-157},{160,-153.6}}, color={0,0,127}));
    connect(T_vc_in.y, cw_mf_control.u_m) annotation (Line(points={{7.1,-185},{54,
            -185},{54,-181.6}}, color={0,0,127}));
    connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
      annotation (Line(
        points={{-64,-215},{-180,-215},{-180,16},{-172.4,16}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
       Line(
        points={{-64,-215},{-180,-215},{-180,32},{-172.4,32}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
      annotation (Line(
        points={{-64,-215},{-180,-215},{-180,0},{-172.4,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Tout_TEDSide, Tout_TEDS_side.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-16},{-172.4,-16}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-32},{-172.4,-32}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-48},{-172.4,-48}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-64},{-172.4,-64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Heater_Input, HX_heat.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-80},{-172.4,-80}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-96},{-172.4,-96}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-112},{-172.4,-112}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.GT_Power, GT_Power_sensor.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-128},{-172.4,-128}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Tout_vc, Tout_vc.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-144},{-172.4,-144}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Tin_vc, Tin_vc.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-160},{-172.4,-160}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.Pump_Flow, TEDS_pump_Control.y) annotation (Line(
        points={{70,-215},{180,-215},{180,-126},{22.6,-126}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorSubBus.CW_control, cw_mf_control.y) annotation (Line(
        points={{70,-215},{180,-215},{180,-172},{62.8,-172}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(SS_GT_demand.y, GT_demand.u)
      annotation (Line(points={{80.7,-93},{93,-93}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-220},
              {180,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-220},{180,140}})));
  end Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1;

  model Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1_bypass
    "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);

    package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;

     input Real TEDS_Heat_Load_Demand
     annotation(Dialog(tab="General"));
     input Real Gas_Turbine_Elec_Demand
     annotation(Dialog(tab="General"));
     input Real Delay_Start = 1e4
     annotation(Dialog(tab="General"));
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput sensorBus
      annotation (Placement(transformation(extent={{-88,-238},{-40,-192}})));
    Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput actuatorBus
      annotation (Placement(transformation(extent={{46,-238},{94,-192}})));
    Modelica.Blocks.Continuous.LimPID PIDV1(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.005*0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0)
      annotation (Placement(transformation(extent={{134,182},{148,196}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{118,174},{128,184}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{160,182},{174,196}})));
    Modelica.Blocks.Continuous.LimPID PIDV2(
      yMax=1,
      k=0.0007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.0)
      annotation (Placement(transformation(extent={{52,158},{66,172}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{32,150},{42,160}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{80,158},{94,172}})));
    Modelica.Blocks.Continuous.LimPID PIDV3(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.03*0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0) annotation (Placement(transformation(extent={{136,134},{150,148}})));
    Modelica.Blocks.Sources.Constant const2(k=0)
      annotation (Placement(transformation(extent={{118,126},{128,136}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{158,134},{172,148}})));
    Modelica.Blocks.Continuous.LimPID PIDV4(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0) annotation (Placement(transformation(extent={{46,112},{60,126}})));
    Modelica.Blocks.Sources.Constant const3(k=0)
      annotation (Placement(transformation(extent={{30,102},{40,112}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{80,112},{94,126}})));
    Modelica.Blocks.Continuous.LimPID PIDV5(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      yMin=0.0)
      annotation (Placement(transformation(extent={{136,90},{150,104}})));
    Modelica.Blocks.Sources.Constant const4(k=0)
      annotation (Placement(transformation(extent={{120,82},{130,92}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{158,90},{172,104}})));
    Modelica.Blocks.Continuous.LimPID PIDV6(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.0)
      annotation (Placement(transformation(extent={{46,68},{60,82}})));
    Modelica.Blocks.Sources.Constant const5(k=0)
      annotation (Placement(transformation(extent={{30,60},{40,70}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
      annotation (Placement(transformation(extent={{80,70},{92,82}})));
    Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
      annotation (Placement(transformation(extent={{90,178},{112,200}})));
    Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
      annotation (Placement(transformation(extent={{4,154},{26,176}})));
    Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
      annotation (Placement(transformation(extent={{90,130},{112,152}})));
    Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
      annotation (Placement(transformation(extent={{4,108},{26,130}})));
    Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
      annotation (Placement(transformation(extent={{4,64},{26,86}})));
    Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
      annotation (Placement(transformation(extent={{90,86},{112,108}})));

  Real Error1 "Valve 1";
  Real Error2 "Valve 2";
  Real Error3 "Valve 3";
  Real Error4 "Valve 4";
  Real Error5 "Valve 5";
  Real Error6 "Valve 6";
  Real Error1_MAGNET "Valve 1, MAGNET to TEDS ";
  //Real Error_TSP "Error between Tout TEDS side and T_hot design";

  Integer storage_button "0 equals discharge or stationary, 1 is charging";

  parameter SI.Power Q_TES_max = 175e3;
  parameter SI.Power Heater_max = 175e3;
  parameter SI.Temperature T_hot_design = 325;
  parameter SI.Temperature T_cold_design = 225;

  parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
  parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

  SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
  SI.MassFlowRate m_bop_heater_demand_graph;
  SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
  SI.MassFlowRate m_tes_discharged;
  SI.MassFlowRate m_tes_charged;
  //SI.Power Q_TES_discharge;
  SI.Power Heat_needed_GT;
  SI.Power Heat_demand;
  SI.Power TES_Load;
  SI.MassFlowRate m_MAGNET_GT; // mass flow needed from MAGNET to produce electricity
  SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

  parameter SI.Pressure p_atm = 1e5;
  parameter SI.Pressure p_MAGNET = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
  parameter SI.Temperature Tin_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
  parameter SI.Temperature Tout_MAGNET = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(450);

  Medium.BaseProperties mediums;

    TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
      "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,54},{-146,76}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,38},{-146,58}})));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-180,120},{-160,140}})));

    TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,22},{-146,42}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,6},{-146,26}})));
    Modelica.Blocks.Continuous.LimPID PIDV7(
      yMax=1,
      k=-0.007*36,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0)
      annotation (Placement(transformation(extent={{102,-12},{116,2}})));
    Modelica.Blocks.Sources.Constant const7(k=0)
      annotation (Placement(transformation(extent={{68,-10},{78,0}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder6(
      T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{158,-28},{170,-16}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder8(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{38,-74},{50,-62}})));
    Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
      annotation (Placement(transformation(extent={{66,-30},{86,-10}})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{10,-70},{26,-54}})));
    Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=Heater_flowrate_sensor.y)
      annotation (Placement(transformation(extent={{-78,-46},{-56,-24}})));
    Modelica.Blocks.Sources.Constant const11(k=0.01)
      annotation (Placement(transformation(extent={{-60,-58},{-50,-48}})));
    Modelica.Blocks.Sources.Constant const12(k=0)
      annotation (Placement(transformation(extent={{-18,-80},{-8,-70}})));
    Modelica.Blocks.Logical.Switch switch3
      annotation (Placement(transformation(extent={{128,-42},{144,-26}})));
    Modelica.Blocks.Sources.Constant const14(k=0)
      annotation (Placement(transformation(extent={{100,-62},{110,-52}})));
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
      annotation (Placement(transformation(extent={{46,-180},{62,-164}})));
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
      annotation (Placement(transformation(extent={{152,-152},{168,-136}})));
    Systems.ExperimentalSystems.MAGNET.Data.Data_base_An data
      annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
    Modelica.Blocks.Sources.Constant const15(k=1)
      annotation (Placement(transformation(extent={{-18,-60},{-8,-50}})));
    Modelica.Blocks.Logical.GreaterEqual greaterEqual2
      annotation (Placement(transformation(extent={{-36,-44},{-26,-34}})));
    Modelica.Blocks.Continuous.LimPID PIDV8(
      yMax=1,
      k=0.00007*1,
      Ti=1,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0)
      annotation (Placement(transformation(extent={{120,-100},{134,-86}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder7(
      T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1)
      annotation (Placement(transformation(extent={{156,-98},{168,-86}})));
    Modelica.Blocks.Sources.Constant const6(k=data.T_hot_side)
      annotation (Placement(transformation(extent={{-12,-130},{-2,-120}})));
    TRANSFORM.Controls.LimPID TEDS_pump_Control(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.125,
      Ti=1,
      k_s=1,
      k_m=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=19376)
      annotation (Placement(transformation(extent={{10,-132},{22,-120}})));
    TRANSFORM.Blocks.RealExpression mflow_inside_MAGNET
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-10},{-146,10}})));
    TRANSFORM.Blocks.RealExpression Tout_TEDS_side "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-26},{-146,-6}})));
    TRANSFORM.Blocks.RealExpression Tin_MT_HX "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-42},{-146,-22}})));
    TRANSFORM.Blocks.RealExpression Tout_MT_HX "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-58},{-146,-38}})));
    TRANSFORM.Blocks.RealExpression mf_MT_HX "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-74},{-146,-54}})));
    TRANSFORM.Blocks.RealExpression HX_heat "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-90},{-146,-70}})));
    TRANSFORM.Blocks.RealExpression Tin_TEDside "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-106},{-146,-86}})));
    TRANSFORM.Blocks.RealExpression mf_vc_GT "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-122},{-146,-102}})));
    TRANSFORM.Blocks.RealExpression GT_Power_sensor "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-138},{-146,-118}})));
    TRANSFORM.Blocks.RealExpression Tout_vc "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-154},{-146,-134}})));
    Modelica.Blocks.Sources.RealExpression GT_Power_generated(y=GT_Power_sensor.y)
      annotation (Placement(transformation(extent={{88,-124},{110,-102}})));
    Modelica.Blocks.Sources.RealExpression T_TEDSide_out(y=Tout_TEDS_side.y)
      annotation (Placement(transformation(extent={{-24,-154},{-2,-132}})));
    Modelica.Blocks.Sources.RealExpression T_vc_out(y=Tout_vc.y)
      annotation (Placement(transformation(extent={{84,-168},{106,-146}})));
    TRANSFORM.Blocks.RealExpression Tin_vc "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-170},{-146,-150}})));
    Modelica.Blocks.Sources.RealExpression T_vc_in(y=Tin_vc.y)
      annotation (Placement(transformation(extent={{-16,-196},{6,-174}})));
    Modelica.Blocks.Sources.RealExpression GT_Power_Setpoint(y=
          Gas_Turbine_Elec_Demand)
      annotation (Placement(transformation(extent={{66,-104},{88,-82}})));
    TRANSFORM.Controls.LimPID PV012(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.0004,
      Ti=5,
      yMax=0.999,
      yMin=0.001,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.5)
      annotation (Placement(transformation(extent={{46,32},{60,46}})));
    Modelica.Blocks.Sources.RealExpression Valve7(y=T_cold_design)
      annotation (Placement(transformation(extent={{2,28},{24,50}})));
    Modelica.Blocks.Sources.RealExpression PV008(y=1)
      annotation (Placement(transformation(extent={{138,14},{158,34}})));
    Modelica.Blocks.Sources.RealExpression PV_009(y=1 - PV012.y)
      annotation (Placement(transformation(extent={{138,-4},{160,18}})));
  protected
    Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
      annotation (Placement(transformation(extent={{10,-178},{22,-166}})));
    Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
      annotation (Placement(transformation(extent={{126,-150},{138,-138}})));
  initial equation
    // Q_TES_discharge = 0.0;
    // storage_button=0;
  equation
    // Values do not matter here because the fluid is constant cp by definition
    // according to the linear fluid model. But this lets us change the fluid
    // easier.
    mediums.p = 1e5;
    mediums.T = 275+273;

    if clock.y < Delay_Start then // during the stablization period, Heat Load Demand is bypassed
      Heat_demand = HX_heat.y;
    else
      Heat_demand = TEDS_Heat_Load_Demand;
    end if;

    // TES charging/discharging power demand. Negative value means discharging
    TES_Load = -(Heat_demand - HX_heat.y);

    // variables that were never used again
    m_bop_heater_demand_graph = Heat_demand/(Cp*(T_hot_design - T_cold_design));

  algorithm

  //   if clock.y < Delay_Start then
  //     m_tes_discharged := 0;
  //   else
  //     m_tes_discharged:= (TEDS_Heat_Load_Demand - HX_heat.y)/(Cp*(T_hot_design - T_cold_design))
  //     "amount of TES flow rate needed for discharge";
  //   end if;

    // Theoretical value for discharge flowrate: m=Q/(c*deltaT). Value can be +/-
    m_tes_discharged := -1*TES_Load/(Cp*(T_hot_design - T_cold_design));

    // Theoretical value for charging flowrate: m=Q/(c*deltaT). Value can be + or 0
    // ??? QUESTION MARK ??? : Why the definition is different from m_tes_discharged
    if HX_heat.y > TEDS_Heat_Load_Demand then
      m_tes_charged:= (HX_heat.y-TEDS_Heat_Load_Demand)/(Cp*(T_hot_design - T_cold_design));
    else
      m_tes_charged:= 0;
    end if;

    // Theoretical value for Glycol_HX hot side flowrate: m=Q/(c*deltaT)
    m_bop_heater_demand :=TEDS_Heat_Load_Demand/(Cp*(T_hot_design - T_cold_design));

    // ?? QUESTION MARK ??? : data.eta_mech = 0.98? Such a high heat to mechanical efficiency?!
    Heat_needed_GT :=Gas_Turbine_Elec_Demand/data.eta_mech;

    // "m_MAGNET_GT" is never used again.
    // Plus, the Tin_MT_HX.y and Tout_MT_HX.y are the inlet/outlet temperature of "MAGNET_TEDS_simpleHX1".
    // The temperature should be measured from the inlet/outlet of turbine-compressor combination.
    m_MAGNET_GT := Heat_needed_GT/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));

    // the nitrogen flow rate in "MAGNET_TEDS_simpleHX1"
    m_MAGNET_left := mflow_inside_MAGNET.y-mf_vc_GT.y;//(m_MAGNET_needed);

  Error1_MAGNET := ((m_MAGNET_left) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

  //Valve 2 Used for HeaterBOPDemand

  Error2 :=(m_bop_heater_demand - Heater_BOP_mass_flow.y)/m_tes_max;

  // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
  // Valve 3 used for TES discharge

  if m_tes_discharged > 0 and delay(storage_button,15) == 0 then
    Error3 :=(m_tes_discharged - Discharge_mass_flow_sensor.y)/m_tes_max;
    else
    Error3 :=-1;
  end if;

  //Valve 1 used for TES Charge
  if m_tes_charged > 0.001 then // charging
    Error1 :=(m_tes_charged - Charge_mass_flow_sensor.y)/m_tes_max;
  else
    Error1 :=-1;
    //storage_button :=0;
  end if;

    //Designation of the TEDS valve control algorithms.

   //Interlock System for the valves.
    if m_tes_charged > 0.001 then
      Error4 :=1;
      storage_button :=1;
    else
      Error4 :=-1;
      storage_button :=0;
    end if;

    if m_tes_discharged > 0.001 then
      Error5 :=1;
    else
      Error5 :=-1;
    end if;

  // Main Heater Mass Flow Control
    if m_tes_charged > 0.001 or m_bop_heater_demand > 0.001 then // makes sure that valve 6 is open when there is extra heat from MAGNET
      Error6 :=1; //(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
    else
      Error6 :=-1;
    end if;

  //Mode Determination System

  equation
    connect(PIDV1.y,firstOrder. u) annotation (Line(points={{148.7,189},{158.6,189}},
                                   color={0,0,127}));
    connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{66.7,165},{78.6,165}},
                                       color={0,0,127}));
    connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{150.7,141},{156.6,141}},
                                       color={0,0,127}));
    connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{60.7,119},{78.6,119}},
                                          color={0,0,127}));
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{150.7,97},{156.6,97}},
                                          color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{60.7,75},{74.35,75},
            {74.35,76},{78.8,76}},        color={0,0,127}));
    connect(actuatorBus.Valve_1_Opening, firstOrder.y) annotation (Line(
        points={{70,-215},{180,-215},{180,189},{174.7,189}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Valve_2_Opening, firstOrder1.y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,165},{94.7,165}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Valve_4_Opening, firstOrder3.y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,119},{94.7,119}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Valve_5_Opening, firstOrder4.y) annotation (Line(
        points={{70,-215},{180,-215},{180,97},{172.7,97}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Valve_6_Opening, firstOrder5.y) annotation (Line(
        points={{70,-215},{180,-215},{180,76},{92.6,76}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{70,-215},{180,-215},{180,141},{172.7,141}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(sensorBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
      annotation (Line(
        points={{-64,-215},{-180,-215},{-180,65},{-172.4,65}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_flowrate, Charge_mass_flow_sensor.u) annotation (
        Line(
        points={{-64,-215},{-180,-215},{-180,48},{-172.4,48}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorBus.MAGNET_valve3_opening, firstOrder8.y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,-68},{50.6,-68}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.MAGNET_valve_opening, firstOrder6.y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,-22},{170.6,-22}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(MAGNET_valve.y,PIDV7. u_m)
      annotation (Line(points={{87,-20},{109,-20},{109,-13.4}},
                                                           color={0,0,127}));
    connect(Valve1.y, PIDV1.u_s)
      annotation (Line(points={{113.1,189},{132.6,189}},
                                                       color={0,0,127}));
    connect(const.y, PIDV1.u_m) annotation (Line(points={{128.5,179},{141,179},{141,
            180.6}},
          color={0,0,127}));
    connect(Valve2.y, PIDV2.u_s)
      annotation (Line(points={{27.1,165},{50.6,165}},
                                                     color={0,0,127}));
    connect(const1.y, PIDV2.u_m) annotation (Line(points={{42.5,155},{42.5,154},{59,
            154},{59,156.6}},
                            color={0,0,127}));
    connect(Valve3.y, PIDV3.u_s)
      annotation (Line(points={{113.1,141},{134.6,141}},
                                                     color={0,0,127}));
    connect(const2.y, PIDV3.u_m) annotation (Line(points={{128.5,131},{128.5,130},
            {143,130},{143,132.6}},
                            color={0,0,127}));
    connect(Valve4.y, PIDV4.u_s)
      annotation (Line(points={{27.1,119},{44.6,119}},
                                                     color={0,0,127}));
    connect(const3.y, PIDV4.u_m) annotation (Line(points={{40.5,107},{40.5,108},{53,
            108},{53,110.6}},
                       color={0,0,127}));
    connect(Valve5.y, PIDV5.u_s)
      annotation (Line(points={{113.1,97},{134.6,97}}, color={0,0,127}));
    connect(const4.y, PIDV5.u_m) annotation (Line(points={{130.5,87},{142.75,87},{
            142.75,88.6},{143,88.6}},
                                color={0,0,127}));
    connect(const5.y, PIDV6.u_m) annotation (Line(points={{40.5,65},{46.75,65},{46.75,
            66.6},{53,66.6}},
                         color={0,0,127}));
    connect(Valve6.y, PIDV6.u_s)
      annotation (Line(points={{27.1,75},{44.6,75}},   color={0,0,127}));
    connect(const12.y, switch2.u3) annotation (Line(points={{-7.5,-75},{2,-75},
            {2,-68.4},{8.4,-68.4}},           color={0,0,127}));
    connect(switch2.y, firstOrder8.u) annotation (Line(points={{26.8,-62},{30,-62},
            {30,-68},{36.8,-68}},         color={0,0,127}));
    connect(const14.y, switch3.u3) annotation (Line(points={{110.5,-57},{120,-57},
            {120,-40.4},{126.4,-40.4}},
                                      color={0,0,127}));
    connect(switch3.y, firstOrder6.u) annotation (Line(points={{144.8,-34},{150,-34},
            {150,-22},{156.8,-22}},    color={0,0,127}));
    connect(Tout_vc_design.y,N2_mf_control. u_s)
      annotation (Line(points={{138.6,-144},{150.4,-144}},
                                                        color={0,0,127}));
    connect(actuatorBus.MAGNET_flow_control, N2_mf_control.y) annotation (Line(
        points={{70,-215},{126,-215},{126,-214},{180,-214},{180,-144},{168.8,
            -144}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const15.y, switch2.u1) annotation (Line(points={{-7.5,-55},{4,-55},
            {4,-52},{8.4,-52},{8.4,-55.6}},
                                  color={0,0,127}));
    connect(greaterEqual2.u1, mflow_TEDS1.y) annotation (Line(points={{-37,-39},
            {-50,-39},{-50,-35},{-54.9,-35}}, color={0,0,127}));
    connect(greaterEqual2.u2, const11.y) annotation (Line(points={{-37,-43},{
            -46,-43},{-46,-53},{-49.5,-53}},
                                          color={0,0,127}));
    connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{-25.5,-39},
            {6,-39},{6,-48},{0,-48},{0,-62},{8.4,-62}},
                                             color={255,0,255}));
    connect(cw_mf_control.u_s, Tin_vc_design.y)
      annotation (Line(points={{44.4,-172},{22.6,-172}}, color={0,0,127}));
    connect(firstOrder7.u,PIDV8. y) annotation (Line(points={{154.8,-92},{144.75,-92},
            {144.75,-93},{134.7,-93}},
                                     color={0,0,127}));
    connect(actuatorBus.MAGNET_valve2_opening, firstOrder7.y) annotation (Line(
        points={{70,-215},{74,-215},{74,-216},{76,-216},{76,-214},{180,-214},
            {180,-92},{168.6,-92}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(const6.y, TEDS_pump_Control.u_s) annotation (Line(points={{-1.5,-125},
            {-1.5,-126},{8.8,-126}}, color={0,0,127}));
    connect(const7.y, PIDV7.u_s) annotation (Line(points={{78.5,-5},{89.55,-5},{89.55,
            -5},{100.6,-5}}, color={0,0,127}));
    connect(PIDV7.y, switch3.u1) annotation (Line(points={{116.7,-5},{126.4,-5},{126.4,
            -27.6}}, color={0,0,127}));
    connect(GT_Power_generated.y, PIDV8.u_m) annotation (Line(points={{111.1,-113},
            {127,-113},{127,-101.4}}, color={0,0,127}));
    connect(T_TEDSide_out.y, TEDS_pump_Control.u_m) annotation (Line(points={{-0.9,
            -143},{16,-143},{16,-133.2}}, color={0,0,127}));
    connect(T_vc_out.y, N2_mf_control.u_m) annotation (Line(points={{107.1,-157},{
            160,-157},{160,-153.6}}, color={0,0,127}));
    connect(T_vc_in.y, cw_mf_control.u_m) annotation (Line(points={{7.1,-185},{54,
            -185},{54,-181.6}}, color={0,0,127}));
    connect(sensorBus.heater_BOP_massflow, Heater_BOP_mass_flow.u) annotation (
        Line(
        points={{-64,-215},{-180,-215},{-180,16},{-172.4,16}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,32},{-172.4,32}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u) annotation (
        Line(
        points={{-64,-215},{-180,-215},{-180,0},{-172.4,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Tout_TEDSide, Tout_TEDS_side.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-16},{-172.4,-16}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.MAGNET_TEDS_HX_Tin, Tin_MT_HX.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-32},{-172.4,-32}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.MAGNET_TEDS_HX_Tout, Tout_MT_HX.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-48},{-172.4,-48}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.MAGNET_flow, mf_MT_HX.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-64},{-172.4,-64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Heater_Input, HX_heat.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-80},{-172.4,-80}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Tin_TEDSide, Tin_TEDside.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-96},{-172.4,-96}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.mf_vc_GT, mf_vc_GT.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-112},{-172.4,-112}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.GT_Power, GT_Power_sensor.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-128},{-172.4,-128}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Tout_vc, Tout_vc.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-144},{-172.4,-144}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Tin_vc, Tin_vc.u) annotation (Line(
        points={{-64,-215},{-180,-215},{-180,-160},{-172.4,-160}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Pump_Flow, TEDS_pump_Control.y) annotation (Line(
        points={{70,-215},{72,-215},{72,-214},{180,-214},{180,-126},{22.6,
            -126}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.CW_control, cw_mf_control.y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,-172},{62.8,-172}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(GT_Power_Setpoint.y, PIDV8.u_s) annotation (Line(points={{89.1,-93},{104.55,
            -93},{104.55,-93},{118.6,-93}}, color={0,0,127}));
    connect(switch3.u2, greaterEqual2.y) annotation (Line(points={{126.4,-34},
            {6,-34},{6,-39},{-25.5,-39}}, color={255,0,255}));
    connect(sensorBus.TC006, PV012.u_m) annotation (Line(
        points={{-64,-215},{-64,-52},{-84,-52},{-84,24},{53,24},{53,30.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Valve7.y, PV012.u_s)
      annotation (Line(points={{25.1,39},{44.6,39}}, color={0,0,127}));
    connect(actuatorBus.PV012, PV012.y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,39},{60.7,39}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PV008, PV008.y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,24},{159,24}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PV009, PV_009.y) annotation (Line(
        points={{70,-215},{70,-214},{180,-214},{180,7},{161.1,7}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-220},
              {180,200}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-220},{180,200}})));
  end Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1_bypass;

end MAGNET_TEDS_ControlSystem;
