within NHES.Systems.ExperimentalSystems.MAGNET.ControlSystems;
model Control_System_Therminol_4_element_all_modes_MAGNET_GT_SS
  "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

  replaceable package Medium =
      TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
    TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
      choicesAllMatching=true);

package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
  TEDS.BaseClasses_1.SignalSubBus_SensorOutput actuatorSubBus
    annotation (Placement(transformation(extent={{-46,-418},{2,-372}})));
  TEDS.BaseClasses_1.SignalSubBus_ActuatorInput sensorSubBus
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
