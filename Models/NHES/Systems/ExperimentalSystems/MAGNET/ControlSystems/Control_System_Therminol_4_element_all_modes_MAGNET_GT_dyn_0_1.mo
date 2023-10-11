within NHES.Systems.ExperimentalSystems.MAGNET.ControlSystems;
model Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1
  "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

  replaceable package Medium =
      TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
    TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
      choicesAllMatching=true);

package Medium_MAGNET = Modelica.Media.IdealGases.SingleGases.N2;
  TEDS.BaseClasses_1.SignalSubBus_SensorOutput actuatorSubBus
    annotation (Placement(transformation(extent={{-88,-238},{-40,-192}})));
  TEDS.BaseClasses_1.SignalSubBus_ActuatorInput sensorSubBus
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
