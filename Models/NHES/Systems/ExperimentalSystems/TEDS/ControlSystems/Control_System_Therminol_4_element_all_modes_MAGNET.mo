within NHES.Systems.Experiments.TEDS.Control_Systems;
model Control_System_Therminol_4_element_all_modes_MAGNET
  "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

  replaceable package Medium =
      TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
    TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
      choicesAllMatching=true);

package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
  BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
    annotation (Placement(transformation(extent={{-46,-418},{2,-372}})));
  BaseClasses.SignalSubBus_SensorOutput sensorSubBus
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
Real Error2_MAGNET "Valve 2, vaccuum chamber to recuperator in MAGNET";
Real Error3_MAGNET "Valve 3, TEDS to MAGNET";

Integer storage_button "0 equals discharge or stationary, 1 is charging";

parameter SI.Power Q_TES_max = 175e3;
parameter SI.Power Heater_max = 175e3;
parameter SI.Temperature T_hot_design = 325;
parameter SI.Temperature T_cold_design = 225;

parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
SI.MassFlowRate m_MAGNET_needed; // mass flow needed from MAGNET as calculated based on Tin on TEDS side
SI.MassFlowRate m_MAGNET_left; // mass flow left on the MAGNET side not needed
SI.MassFlowRate m_tes_demand;
SI.MassFlowRate m_heater_demand;
SI.Power Q_TES_demanded;
SI.Power Q_TES_discharge;
SI.Power Heat_needed;
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
  Modelica.Blocks.Math.Gain mf_vc_rp(k=1) annotation (Placement(transformation(
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
  Modelica.Blocks.Sources.RealExpression MAGNET_valve2(y=Error2_MAGNET)
    annotation (Placement(transformation(extent={{-98,-144},{-78,-124}})));
  Modelica.Blocks.Continuous.LimPID PIDV8(
    yMax=1,
    k=0.035,
    Ti=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.0)
    annotation (Placement(transformation(extent={{-30,-124},{-16,-110}})));
  Modelica.Blocks.Sources.Constant const8(k=0)
    annotation (Placement(transformation(extent={{-64,-122},{-54,-112}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder7(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{92,-142},{104,-130}})));
  Modelica.Blocks.Sources.RealExpression MAGNET_valve3(y=Error3_MAGNET)
    annotation (Placement(transformation(extent={{-96,-204},{-76,-184}})));
  Modelica.Blocks.Continuous.LimPID PIDV9(
    yMax=1,
    k=-0.007*360,
    Ti=3.5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMin=0)
    annotation (Placement(transformation(extent={{-24,-180},{-10,-166}})));
  Modelica.Blocks.Sources.Constant const9(k=0)
    annotation (Placement(transformation(extent={{-68,-178},{-58,-168}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder8(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{92,-196},{104,-184}})));
  Modelica.Blocks.Sources.RealExpression MAGNET_valve(y=Error1_MAGNET)
    annotation (Placement(transformation(extent={{-60,-74},{-40,-54}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{66,-148},{82,-132}})));
  Modelica.Blocks.Sources.RealExpression mflow_TEDS(y=Heater_flowrate_sensor.y)
    annotation (Placement(transformation(extent={{-8,-144},{14,-122}})));
  Modelica.Blocks.Sources.Constant const6(k=0.01)
    annotation (Placement(transformation(extent={{2,-150},{12,-140}})));
  Modelica.Blocks.Sources.Constant const10(k=1)
    annotation (Placement(transformation(extent={{20,-158},{30,-148}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{64,-192},{80,-176}})));
  Modelica.Blocks.Sources.RealExpression mflow_TEDS1(y=Heater_flowrate_sensor.y)
    annotation (Placement(transformation(extent={{-10,-196},{12,-174}})));
  Modelica.Blocks.Sources.Constant const11(k=0.01)
    annotation (Placement(transformation(extent={{8,-208},{18,-198}})));
  Modelica.Blocks.Sources.Constant const12(k=0)
    annotation (Placement(transformation(extent={{40,-208},{50,-198}})));
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
  ExperimentalSystems.MAGNET.Data.Data_base_An data
    annotation (Placement(transformation(extent={{-180,86},{-160,106}})));
  Modelica.Blocks.Sources.Constant const15(k=1)
    annotation (Placement(transformation(extent={{36,-170},{46,-160}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual
    annotation (Placement(transformation(extent={{30,-142},{40,-132}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual1
    annotation (Placement(transformation(extent={{32,-86},{42,-76}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual2
    annotation (Placement(transformation(extent={{32,-194},{42,-184}})));
  Modelica.Blocks.Sources.Constant const16(k=300 + 273.15)
    annotation (Placement(transformation(extent={{-78,-322},{-68,-312}})));
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

Q_TES_demanded :=Load_TES.y;  //(Load_TES.y/100)*Q_TES_max;

m_tes_demand :=Q_TES_demanded/(Cp*(T_hot_design - T_cold_design));

m_heater_demand :=Heater_Load.y/(Cp*(T_hot_design - T_cold_design));

Q_TES_discharge :=Discharge_mass_flow_sensor.y*Cp*(T_hot_design - T_cold_design);

m_bop_heater_demand :=Heater_BOP_Demand.y/(Cp*(T_hot_design - T_cold_design));

Heat_needed := (Medium.specificEnthalpy_pT(1e5,T_hot_design) - Medium.specificEnthalpy_pT(1e5,Tin_TEDside.y))*(Heater_flowrate_sensor.y);

//if Heat_needed >250e3 then
//  m_MAGNET_needed := 0.938;
//else
  //m_MAGNET_needed := Heat_needed/abs(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MAGNET) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y));
  m_MAGNET_needed := max(Heat_needed/abs(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MT_HX.y) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MT_HX.y)), 1e-8);
  //m_MAGNET_needed := Heat_needed/(Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tin_MAGNET) - Medium_MAGNET.specificEnthalpy_pT(p_MAGNET,Tout_MAGNET));
//end if;

//if Heater_flowrate_sensor.y>0.001 then
//  m_MAGNET_needed := m_MAGNET_needed;
//else
//  m_MAGNET_needed:= 1e-8;
//end if;

Error1_MAGNET := ((m_MAGNET_needed) - mf_MT_HX.y)/mflow_inside_MAGNET.y;

if mflow_inside_MAGNET.y > m_MAGNET_needed then
  m_MAGNET_left := mflow_inside_MAGNET.y-(m_MAGNET_needed);
else
  m_MAGNET_left := 0;
end if;

//if Heater_flowrate_sensor.y>0.001 then
   Error2_MAGNET := ((mf_vc_rp.y) - m_MAGNET_left)/mflow_inside_MAGNET.y;
//else
//  Error2_MAGNET:= 1;
//end if;

if m_MAGNET_needed >0.001 then
  Error3_MAGNET :=1;
else
  Error3_MAGNET:=-1;
end if;

//Valve 2 Used for HeaterBOPDemand

Error2 :=(m_bop_heater_demand - Heater_BOP_mass_flow.y)/m_tes_max;

                                                                         // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
//Valve 3 used for TES discharge

if Load_TES.y > 0 and delay(storage_button,15) == 0 then
  Error3 :=(m_tes_demand - Discharge_mass_flow_sensor.y)/m_tes_max;
  else
  Error3 :=-1;
end if;

//Valve 1 used for TES Charge
if Load_TES.y < 0 then // charging
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
  connect(actuatorSubBus.mf_vc_rp, mf_vc_rp.u) annotation (Line(
      points={{-22,-395},{-22,-398},{-178,-398},{-178,-138},{-164,-138},{-164,
          -137},{-151,-137}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.u)
    annotation (Line(
      points={{-22,-395},{-22,-398},{-178,-398},{-178,-155},{-151,-155}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_valve2_opening,firstOrder7. y) annotation (Line(
      points={{40,-395},{40,-398},{178,-398},{178,-136},{104.6,-136}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_valve3_opening,firstOrder8. y) annotation (Line(
      points={{40,-395},{40,-398},{178,-398},{178,-190},{104.6,-190}},
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
  connect(const8.y, PIDV8.u_s)
    annotation (Line(points={{-53.5,-117},{-31.4,-117}},
                                                       color={0,0,127}));
  connect(MAGNET_valve2.y, PIDV8.u_m) annotation (Line(points={{-77,-134},{
          -77,-132},{-23,-132},{-23,-125.4}},
                                  color={0,0,127}));
  connect(MAGNET_valve3.y, PIDV9.u_m) annotation (Line(points={{-75,-194},{
          -17,-194},{-17,-181.4}},
                        color={0,0,127}));
  connect(switch1.u1, PIDV8.y) annotation (Line(points={{64.4,-133.6},{64.4,
          -134},{50,-134},{50,-117},{-15.3,-117}}, color={0,0,127}));
  connect(switch1.y, firstOrder7.u) annotation (Line(points={{82.8,-140},{86,
          -140},{86,-136},{90.8,-136}}, color={0,0,127}));
  connect(const10.y, switch1.u3) annotation (Line(points={{30.5,-153},{56,
          -153},{56,-146.4},{64.4,-146.4}}, color={0,0,127}));
  connect(const12.y, switch2.u3) annotation (Line(points={{50.5,-203},{56,
          -203},{56,-190.4},{62.4,-190.4}}, color={0,0,127}));
  connect(switch2.y, firstOrder8.u) annotation (Line(points={{80.8,-184},{84,
          -184},{84,-190},{90.8,-190}}, color={0,0,127}));
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
  connect(const9.y, PIDV9.u_s)
    annotation (Line(points={{-57.5,-173},{-25.4,-173}}, color={0,0,127}));
  connect(const15.y, switch2.u1) annotation (Line(points={{46.5,-165},{62.4,
          -165},{62.4,-177.6}}, color={0,0,127}));
  connect(greaterEqual.u2, const6.y) annotation (Line(points={{29,-141},{29,
          -145},{12.5,-145}}, color={0,0,127}));
  connect(greaterEqual.u1, mflow_TEDS.y) annotation (Line(points={{29,-137},{
          20,-137},{20,-133},{15.1,-133}}, color={0,0,127}));
  connect(greaterEqual.y, switch1.u2) annotation (Line(points={{40.5,-137},{
          56,-137},{56,-140},{64.4,-140}}, color={255,0,255}));
  connect(greaterEqual1.u1, mflow_TEDS2.y) annotation (Line(points={{31,-81},
          {16,-81},{16,-71},{11.1,-71}}, color={0,0,127}));
  connect(greaterEqual1.u2, const13.y) annotation (Line(points={{31,-85},{16,
          -85},{16,-83},{8.5,-83}}, color={0,0,127}));
  connect(greaterEqual1.y, switch3.u2) annotation (Line(points={{42.5,-81},{
          42.5,-78},{60.4,-78}}, color={255,0,255}));
  connect(greaterEqual2.u1, mflow_TEDS1.y) annotation (Line(points={{31,-189},
          {18,-189},{18,-185},{13.1,-185}}, color={0,0,127}));
  connect(greaterEqual2.u2, const11.y) annotation (Line(points={{31,-193},{22,
          -193},{22,-203},{18.5,-203}}, color={0,0,127}));
  connect(greaterEqual2.y, switch2.u2) annotation (Line(points={{42.5,-189},{
          54,-189},{54,-184},{62.4,-184}}, color={255,0,255}));
  connect(cw_mf_control.u_s, Tin_vc_design.y)
    annotation (Line(points={{-34,-302},{-57.4,-302}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
            -400},{180,140}})),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-400},{180,140}})));
end Control_System_Therminol_4_element_all_modes_MAGNET;
