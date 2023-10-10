within NHES.Systems.ExperimentalSystems.MAGNET.ControlSystems;
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
  TEDS.BaseClasses_1.SignalSubBus_SensorOutput sensorBus
    annotation (Placement(transformation(extent={{-88,-238},{-40,-192}})));
  TEDS.BaseClasses_1.SignalSubBus_ActuatorInput actuatorBus
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
