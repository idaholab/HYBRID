within NHES.ExperimentalSystems.TEDS_New.CS;
model Control_System_Therminol_4_element_all_modes_DMM
  "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"
  extends BaseClasses.Partial_ControlSystem;
  replaceable Data.Data_Dummy data annotation(tab="General", choicesAllMatching=true,Placement(transformation(extent={{-54,160},
            {-34,180}})));
  replaceable package Medium =
      TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
    TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
      choicesAllMatching=true);
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
    annotation (Placement(transformation(extent={{66,108},{74,116}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderV1(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=0)
    annotation (Placement(transformation(extent={{98,124},{110,136}})));
  Modelica.Blocks.Continuous.LimPID PIDV2(
    yMax=1,
    k=0.007*3600,
    Ti=3.5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.0)
    annotation (Placement(transformation(extent={{70,86},{84,100}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{60,74},{68,82}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderV2(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{98,88},{110,100}})));
  Modelica.Blocks.Continuous.LimPID PIDV3(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03*0.007*3600,
    Ti=3.5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1,
    yMin=0.0) annotation (Placement(transformation(extent={{64,50},{78,64}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{58,34},{66,42}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderV3(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=0) annotation (Placement(transformation(extent={{98,52},{110,64}})));
  Modelica.Blocks.Continuous.LimPID PIDV4(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=0.007*3600,
    Ti=3.5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1,
    yMin=0.0) annotation (Placement(transformation(extent={{62,8},{76,22}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
    annotation (Placement(transformation(extent={{58,-4},{66,4}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderV4(
    T=2,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=0) annotation (Placement(transformation(extent={{96,10},{108,22}})));
  Modelica.Blocks.Continuous.LimPID PIDV5(
    yMax=1,
    k=0.007*3600,
    Ti=3.5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMin=0.0)
    annotation (Placement(transformation(extent={{62,-28},{76,-14}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{58,-40},{66,-32}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderV5(
    T=2,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=0)
    annotation (Placement(transformation(extent={{96,-26},{108,-14}})));
  Modelica.Blocks.Continuous.LimPID PIDV6(
    yMax=1,
    k=0.007*3600,
    Ti=3.5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.0)
    annotation (Placement(transformation(extent={{62,-64},{76,-50}})));
  Modelica.Blocks.Sources.Constant const5(k=0)
    annotation (Placement(transformation(extent={{58,-76},{66,-68}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderV6(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{96,-62},{108,-50}})));
  Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
    annotation (Placement(transformation(extent={{26,118},{48,140}})));
  Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
    annotation (Placement(transformation(extent={{26,84},{46,104}})));
  Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
    annotation (Placement(transformation(extent={{28,48},{48,68}})));
  Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
    annotation (Placement(transformation(extent={{28,6},{48,26}})));
  Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
    annotation (Placement(transformation(extent={{28,-66},{48,-46}})));
  Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
    annotation (Placement(transformation(extent={{28,-32},{48,-12}})));

Real Error1 "Valve 1";
Real Error2 "Valve 2";
Real Error3 "Valve 3";
Real Error4 "Valve 4";
Real Error5 "Valve 5";
Real Error6 "Valve 6";
Integer storage_button "0 equals discharge or stationary, 1 is charging";

parameter SI.Power Q_TES_max = 175e3;
parameter SI.Power Heater_max = 175e3;
parameter SI.Temperature T_hot_design = 325;
parameter SI.Temperature T_cold_design = 225;

parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
SI.MassFlowRate m_tes_demand;
SI.MassFlowRate m_heater_demand;
SI.Power Q_TES_demanded;
SI.Power Q_TES_discharge;
SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

Medium.BaseProperties mediums;

  Modelica.Blocks.Sources.Constant delayStart(k=20)
    annotation (Placement(transformation(extent={{-102,120},{-82,140}})));
  TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
    "Used in the Coded Section"
    annotation (Placement(transformation(extent={{-146,6},{-122,28}})));
  TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
    "Used in the Code section. "
    annotation (Placement(transformation(extent={{-146,-24},{-122,-4}})));
  Modelica.Blocks.Sources.ContinuousClock clock
    annotation (Placement(transformation(extent={{-178,120},{-158,140}})));

  TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
    "Used in the Code section. "
    annotation (Placement(transformation(extent={{-146,-58},{-122,-38}})));
  Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
        BOP_total_demand.y, Heater_Total_Demand.y))
    annotation (Placement(transformation(extent={{-108,32},{-86,54}})));
  Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,100,1;
        1800,100,1; 3600,0,4; 4800,0,2; 7200,0,4; 9600,100,5; 10800,140,5;
        12000,140,0.0; 14400,100,0.0; 18000,100,0],
                             startTime=0)
    annotation (Placement(transformation(extent={{-154,58},{-140,72}})));
  Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
    annotation (Placement(transformation(extent={{-130,60},{-120,70}})));
  TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
    "Used in the Code section. "
    annotation (Placement(transformation(extent={{-146,-92},{-122,-72}})));
  Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
        3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
        18000,1],                                             startTime=0)
    annotation (Placement(transformation(extent={{-154,38},{-140,52}})));
  Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
    annotation (Placement(transformation(extent={{-130,40},{-120,50}})));
  Modelica.Blocks.Sources.RealExpression Load_TES(y=BOP_total_demand.y -
        Heater_Total_Demand.y)
    annotation (Placement(transformation(extent={{-156,76},{-134,98}})));
  Modelica.Blocks.Sources.Pulse Heater_Load(
    amplitude=0,
    width=50,
    period(displayUnit="h") = 7200,
    offset=200e3)
              annotation (Placement(transformation(extent={{-150,104},{-136,118}})));
  TRANSFORM.Controls.LimPID Chromolox_Heater_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=7,
    Ti=0.05,
    k_s=1,
    k_m=1,
    yMax=200e3,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=200e3)
    annotation (Placement(transformation(extent={{68,160},{80,172}})));
  Modelica.Blocks.Sources.Constant const6(k=data.T_hot_design)     annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={44,166})));

  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-14,-86},{6,-66}})));
  Modelica.Blocks.Sources.Constant pump_dp_setpoint(k=20000)
    annotation (Placement(transformation(extent={{-54,-72},{-34,-52}})));
  Modelica.Blocks.Sources.Constant const7(k=data.T_cold_design)     annotation (
     Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={36,214})));
  TRANSFORM.Controls.LimPID MassFlow_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1,
    Ti=5,
    k_s=2*5e-1,
    k_m=2*5e-1,
    yMax=30,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=data_initial.MassFlow_Controlstart)
    annotation (Placement(transformation(extent={{56,208},{68,220}})));
  Modelica.Blocks.Sources.Constant const8(k=data.m_flow_glycolwater_chiller)
                                                                    annotation (
     Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={62,232})));
  Modelica.Blocks.Math.Add add1(k1=if data.control_chiller_flow then 0 else 1,
      k2=if data.control_chiller_flow then 1 else 0)
    annotation (Placement(transformation(extent={{84,212},{104,232}})));
  Data.Initial_Data_Dummy data_initial
    annotation (Placement(transformation(extent={{-92,160},{-72,180}})));
  Modelica.Blocks.Sources.RealExpression BV1_opening(y=1e-8)
    annotation (Placement(transformation(extent={{18,-136},{42,-114}})));
  Modelica.Blocks.Sources.RealExpression BV_2(y=0.8)
    annotation (Placement(transformation(extent={{18,-152},{42,-130}})));
  Modelica.Blocks.Sources.RealExpression valve_MAGNET(y=1e-8)
    annotation (Placement(transformation(extent={{18,-192},{42,-170}})));
  Modelica.Blocks.Sources.RealExpression valve_MAGNET_bypass(y=0.8)
    annotation (Placement(transformation(extent={{18,-174},{42,-152}})));
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
  connect(const.y,PIDV1. u_m)
    annotation (Line(points={{74.4,112},{77,112},{77,120.6}},
                                                           color={0,0,127}));
  connect(PIDV1.y, firstOrderV1.u) annotation (Line(points={{84.7,129},{92.35,129},
          {92.35,130},{96.8,130}}, color={0,0,127}));
  connect(const1.y,PIDV2. u_m)
    annotation (Line(points={{68.4,78},{77,78},{77,84.6}}, color={0,0,127}));
  connect(PIDV2.y, firstOrderV2.u) annotation (Line(points={{84.7,93},{92.35,93},
          {92.35,94},{96.8,94}}, color={0,0,127}));
  connect(const2.y,PIDV3. u_m)
    annotation (Line(points={{66.4,38},{71,38},{71,48.6}},color={0,0,127}));
  connect(PIDV3.y, firstOrderV3.u) annotation (Line(points={{78.7,57},{92.35,57},
          {92.35,58},{96.8,58}}, color={0,0,127}));
  connect(const3.y,PIDV4. u_m) annotation (Line(points={{66.4,0},{69,0},{69,6.6}},
                      color={0,0,127}));
  connect(PIDV4.y, firstOrderV4.u) annotation (Line(points={{76.7,15},{90.35,15},
          {90.35,16},{94.8,16}}, color={0,0,127}));
  connect(const4.y,PIDV5. u_m) annotation (Line(points={{66.4,-36},{69,-36},{69,
          -29.4}},    color={0,0,127}));
  connect(PIDV5.y, firstOrderV5.u) annotation (Line(points={{76.7,-21},{90.35,-21},
          {90.35,-20},{94.8,-20}}, color={0,0,127}));
  connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
          -65.4}},      color={0,0,127}));
  connect(PIDV6.y, firstOrderV6.u) annotation (Line(points={{76.7,-57},{90.35,-57},
          {90.35,-56},{94.8,-56}}, color={0,0,127}));
  connect(Valve1.y, PIDV1.u_s)
    annotation (Line(points={{49.1,129},{68.6,129}}, color={0,0,127}));
  connect(Valve4.y, PIDV4.u_s) annotation (Line(points={{49,16},{51.5,16},{51.5,
          15},{60.6,15}}, color={0,0,127}));
  connect(Valve5.y, PIDV5.u_s) annotation (Line(points={{49,-22},{52,-22},{52,-21},
          {60.6,-21}}, color={0,0,127}));
  connect(Valve6.y, PIDV6.u_s) annotation (Line(points={{49,-56},{50,-56},{50,-57},
          {60.6,-57}}, color={0,0,127}));
  connect(Valve3.y, PIDV3.u_s) annotation (Line(points={{49,58},{52,58},{52,57},
          {62.6,57}}, color={0,0,127}));
  connect(Valve2.y, PIDV2.u_s) annotation (Line(points={{47,94},{58,94},{58,93},
          {68.6,93}}, color={0,0,127}));

  connect(BOP_relative_demand.y[1], BOP_total_demand.u) annotation (Line(points={{-139.3,
          65},{-131,65}},                                       color={0,0,127}));
  connect(Heater_Demand.y[1], Heater_Total_Demand.u) annotation (Line(points={{-139.3,
          45},{-131,45}},              color={0,0,127}));
  connect(sensorBus.BOP_mass_flow, Heater_BOP_mass_flow.u) annotation (Line(
      points={{-30,-100},{-180,-100},{-180,-82},{-148.4,-82}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.heater_flow_rate, Heater_flowrate_sensor.u) annotation (
      Line(
      points={{-30,-100},{-180,-100},{-180,-48},{-148.4,-48}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.charging_flow_rate, Charge_mass_flow_sensor.u) annotation (
      Line(
      points={{-30,-100},{-180,-100},{-180,-14},{-148.4,-14}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.discharging_flow_rate, Discharge_mass_flow_sensor.u)
    annotation (Line(
      points={{-30,-100},{-180,-100},{-180,18},{-154,18},{-154,17},{-148.4,17}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorBus.valve_1_opening, firstOrderV1.y) annotation (Line(
      points={{30,-100},{120,-100},{120,130},{110.6,130}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_2_opening, firstOrderV2.y) annotation (Line(
      points={{30,-100},{120,-100},{120,94},{110.6,94}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_3_opening, firstOrderV3.y) annotation (Line(
      points={{30,-100},{120,-100},{120,58},{110.6,58}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_4_opening, firstOrderV4.y) annotation (Line(
      points={{30,-100},{120,-100},{120,16},{108.6,16}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_5_opening, firstOrderV5.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-20},{108.6,-20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_6_opening, firstOrderV6.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-56},{108.6,-56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const6.y, Chromolox_Heater_Control.u_s)
    annotation (Line(points={{50.6,166},{66.8,166}}, color={0,0,127}));
  connect(sensorBus.T_Chromolox_Exit, Chromolox_Heater_Control.u_m) annotation (
     Line(
      points={{-30,-100},{-180,-100},{-180,144},{74,144},{74,158.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.heater_power, Chromolox_Heater_Control.y) annotation (
      Line(
      points={{30,-100},{120,-100},{120,166},{80.6,166}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.pump_dp, add.y) annotation (Line(
      points={{30,-100},{30,-76},{7,-76}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.pump_inlet_pressure, add.u2) annotation (Line(
      points={{-30,-100},{-30,-76},{-16,-76},{-16,-82}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add.u1, pump_dp_setpoint.y) annotation (Line(points={{-16,-70},{-26,
          -70},{-26,-62},{-33,-62}}, color={0,0,127}));
  connect(MassFlow_Control.u_s, const7.y)
    annotation (Line(points={{54.8,214},{40.4,214}}, color={0,0,127}));
  connect(sensorBus.T_therminol_glycolHX_exit, MassFlow_Control.u_m)
    annotation (Line(
      points={{-30,-100},{-180,-100},{-180,194},{62,194},{62,206.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add1.u2, MassFlow_Control.y)
    annotation (Line(points={{82,216},{82,214},{68.6,214}}, color={0,0,127}));
  connect(add1.u1, const8.y) annotation (Line(points={{82,228},{72,228},{72,232},
          {66.4,232}}, color={0,0,127}));
  connect(actuatorBus.glycol_water_flow_rate, add1.y) annotation (Line(
      points={{30,-100},{118,-100},{118,222},{105,222}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.BV1_opening, BV1_opening.y) annotation (Line(
      points={{30,-100},{52,-100},{52,-124},{48,-124},{48,-125},{43.2,-125}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.BV2_opening, BV_2.y) annotation (Line(
      points={{30,-100},{52,-100},{52,-142},{43.2,-142},{43.2,-141}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_MAGNET_bypass_opening, valve_MAGNET_bypass.y)
    annotation (Line(
      points={{30,-100},{52,-100},{52,-163},{43.2,-163}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_MAGNET, valve_MAGNET.y) annotation (Line(
      points={{30,-100},{52,-100},{52,-181},{43.2,-181}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
            {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-100},{120,140}})));
end Control_System_Therminol_4_element_all_modes_DMM;
