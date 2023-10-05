within NHES.ExperimentalSystems.TEDS.Control_Systems;
model Control_System_Therminol_4_element_all_modes_ExpTest2
  "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

 // replaceable package Medium =
 //     TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
 //   TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
 //     choicesAllMatching=true);

  replaceable package Medium =
      TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C constrainedby
    TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
      choicesAllMatching=true);

  BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
    annotation (Placement(transformation(extent={{-58,-122},{-10,-76}})));
  BaseClasses.SignalSubBus_SensorOutput sensorSubBus
    annotation (Placement(transformation(extent={{16,-122},{64,-76}})));
  Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
    annotation (Placement(transformation(extent={{26,118},{48,140}})));
  Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
    annotation (Placement(transformation(extent={{26,84},{46,104}})));
  Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
    annotation (Placement(transformation(extent={{28,48},{48,68}})));
  Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
    annotation (Placement(transformation(extent={{28,6},{48,26}})));
  Modelica.Blocks.Sources.RealExpression Valve6(y=1)
    annotation (Placement(transformation(extent={{28,-66},{48,-46}})));
  Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
    annotation (Placement(transformation(extent={{28,-32},{48,-12}})));

Real Error1 "Valve 1";
Real Error2 "Valve 2";
Real Error3 "Valve 3";
// Real Error4 "Valve 4";
// Real Error5 "Valve 5";
//Real Error6 "Valve 6";
Integer storage_button "0 equals discharge or stationary, 1 is charging";

parameter SI.Power Q_TES_max =200e3;
parameter SI.Power Heater_max = 200e3;
parameter SI.Temperature T_hot_design = 300;
parameter SI.Temperature T_cold_design = 50;

parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.

SI.MassFlowRate m_bop_heater_demand; //Demand through Valve 2
SI.MassFlowRate m_tes_demand;
SI.MassFlowRate m_heater_demand;
SI.Power Q_TES_demanded;
SI.Power Q_TES_discharge;
SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

Medium.BaseProperties mediums;

  TRANSFORM.Controls.LimPID Chromolox_Heater_Control1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.8,
    Ti=3.5,
    k_s=1,
    k_m=1,
    yMax=3,
    yMin=0.2,
    y_start=0.84)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={10,-4})));
  Modelica.Blocks.Sources.Constant delayStart(k=20)
    annotation (Placement(transformation(extent={{-100,120},{-80,140}})));
  TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
    "Used in the Coded Section"
    annotation (Placement(transformation(extent={{-170,-2},{-146,20}})));
  TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
    "Used in the Code section. "
    annotation (Placement(transformation(extent={{-170,-14},{-146,6}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-64,74},{-50,60}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual
    annotation (Placement(transformation(extent={{-170,54},{-156,68}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-126,66},{-110,82}})));
  Modelica.Blocks.Sources.Constant Null(k=0) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-172,34})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual1
    annotation (Placement(transformation(extent={{-108,8},{-94,22}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-78,24},{-62,40}})));
  Modelica.Blocks.Sources.RealExpression Q_discharge(y=Q_TES_discharge)
    annotation (Placement(transformation(extent={{-112,26},{-90,48}})));
  Modelica.Blocks.Sources.Constant Null1(k=0)
                                             annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-124,8})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-52,16},{-38,30}})));
  Modelica.Blocks.Sources.ContinuousClock clock
    annotation (Placement(transformation(extent={{-180,120},{-160,140}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=90,
        origin={4,-44})));
  Modelica.Blocks.Sources.RealExpression Timer(y=delayStart.k)
    annotation (Placement(transformation(extent={{-64,-30},{-42,-8}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual2
    annotation (Placement(transformation(extent={{-26,-18},{-12,-4}})));
  Modelica.Blocks.Sources.RealExpression Timer1(y=clock.y)
    annotation (Placement(transformation(extent={{-64,-12},{-42,10}})));
  Modelica.Blocks.Sources.Constant Null2(k=0.84)
                                             annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-40,-40})));

  Modelica.Blocks.Sources.RealExpression Reference_total_mass_flow(y=add.y/(Cp*(
        T_hot_design - T_cold_design))) annotation (Placement(transformation(
        extent={{11,-11},{-11,11}},
        rotation=90,
        origin={9,95})));
  Modelica.Blocks.Math.Add Subtract(k2=-1)
    annotation (Placement(transformation(extent={{-32,44},{-18,58}})));
  Modelica.Blocks.Math.Gain Mass_Pass_through(k=1) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-15,93})));
  Modelica.Blocks.Math.Add Subtract1(k2=-1) annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={7,65})));
  Modelica.Blocks.Math.Gain Mass_Pass_through1(k=1/m_tes_max) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={15,41})));
  Modelica.Blocks.Math.Gain Mass_Pass_through2(k=1/Q_TES_max) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-7,37})));
  TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
    "Used in the Code section. "
    annotation (Placement(transformation(extent={{-170,-28},{-146,-8}})));
  Modelica.Blocks.Sources.Pulse Heater_Load(
    amplitude=0,
    width=50,
    period(displayUnit="h") = 7200,
    offset=200e3)
              annotation (Placement(transformation(extent={{-94,84},{-80,98}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{-14,2},{-6,10}})));
  Modelica.Blocks.Math.Add add2(k1=0.0001, k2=1)
    annotation (Placement(transformation(extent={{-7,7},{7,-7}},
        rotation=-90,
        origin={9,15})));
  Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
        BOP_total_demand.y, Heater_Total_Demand.y))
    annotation (Placement(transformation(extent={{-122,-96},{-100,-74}})));
  Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,10,1;
        3500,10,1; 3600,0,4; 4800,0,2; 7200,0,4; 9600,0,5; 10800,0,5; 14300,0,
        0.0; 14400,0,0.0; 17900,0,0; 18000,150,0.0; 23300,150,0.0; 23400,0,0.0;
        25000,0,0.0],        startTime=0)
    annotation (Placement(transformation(extent={{-168,-70},{-154,-56}})));
  Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
        Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
         else BOP_total_demand.y - Heater_Total_Demand.y)
    annotation (Placement(transformation(extent={{-176,76},{-154,98}})));
  Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/200.)
    annotation (Placement(transformation(extent={{-144,-68},{-134,-58}})));
  TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
    "Used in the Code section. "
    annotation (Placement(transformation(extent={{-170,-44},{-146,-24}})));
  Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,0.01; 3500,
        0.01; 3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,1; 14300,1; 14400,0;
        18000,0],                                             startTime=0)
    annotation (Placement(transformation(extent={{-168,-90},{-154,-76}})));
  Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
    annotation (Placement(transformation(extent={{-144,-88},{-134,-78}})));
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

//  //Interlock System for the valves.
//   if m_tes_demand < -0.001 then
//     Error4 :=1;
//     storage_button :=1;
//   else
//     Error4 :=-1;
//     storage_button :=0;
//   end if;
//
//   if m_tes_demand > 0.001 then
//     Error5 :=1;
//   else
//     Error5 :=-1;
//   end if;

// Main Heater Mass Flow Control
//   if m_heater_demand > 0.001 then
//     Error6 :=1; //(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
//   else
//     Error6 :=-1;
//   end if;

//Mode Determination System

equation

  connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
    annotation (Line(
      points={{-34,-99},{-180,-99},{-180,9},{-172.4,9}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
    annotation (Line(
      points={{-34,-99},{-148,-99},{-148,-100},{-180,-100},{-180,-4},{-172.4,-4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Null.y, greaterEqual.u2) annotation (Line(points={{-165.4,34},{-164,34},
          {-164,50},{-178,50},{-178,55.4},{-171.4,55.4}}, color={0,0,127}));
  connect(greaterEqual.y, switch1.u2) annotation (Line(points={{-155.3,61},{-148,
          61},{-148,74},{-127.6,74}}, color={255,0,255}));
  connect(Null.y, switch1.u3) annotation (Line(points={{-165.4,34},{-140,34},{-140,
          67.6},{-127.6,67.6}},                               color={0,0,127}));
  connect(switch1.y, add.u1) annotation (Line(points={{-109.2,74},{-94,74},{-94,
          62.8},{-65.4,62.8}}, color={0,0,127}));
  connect(greaterEqual1.y, switch2.u2) annotation (Line(points={{-93.3,15},{-82,
          15},{-82,32},{-79.6,32}}, color={255,0,255}));
  connect(Q_discharge.y, switch2.u1) annotation (Line(points={{-88.9,37},{-83.45,
          37},{-83.45,38.4},{-79.6,38.4}}, color={0,0,127}));
  connect(Q_discharge.y, greaterEqual1.u1) annotation (Line(points={{-88.9,37},{
          -86,37},{-86,26},{-116,26},{-116,15},{-109.4,15}}, color={0,0,127}));
  connect(Null1.y, greaterEqual1.u2) annotation (Line(points={{-117.4,8},{-114,8},
          {-114,9.4},{-109.4,9.4}}, color={0,0,127}));
  connect(Null1.y, switch2.u3) annotation (Line(points={{-117.4,8},{-114,8},{-114,
          4},{-80,4},{-80,25.6},{-79.6,25.6}}, color={0,0,127}));
  connect(switch2.y, add1.u1) annotation (Line(points={{-61.2,32},{-56,32},{-56,
          27.2},{-53.4,27.2}}, color={0,0,127}));
  connect(actuatorSubBus.Heater_Input, add1.u2) annotation (Line(
      points={{-34,-99},{-74,-99},{-74,18.8},{-53.4,18.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Pump_Flow, switch3.y) annotation (Line(
      points={{40,-99},{4,-99},{4,-52.8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Timer.y, greaterEqual2.u2) annotation (Line(points={{-40.9,-19},{-34,-19},
          {-34,-16.6},{-27.4,-16.6}}, color={0,0,127}));
  connect(greaterEqual2.y, switch3.u2) annotation (Line(points={{-11.3,-11},{4,-11},
          {4,-34.4}},       color={255,0,255}));
  connect(Timer1.y, greaterEqual2.u1) annotation (Line(points={{-40.9,-1},{-34.45,
          -1},{-34.45,-11},{-27.4,-11}}, color={0,0,127}));
  connect(Null2.y, switch3.u3) annotation (Line(points={{-33.4,-40},{-24,-40},{-24,
          -30},{-2.4,-30},{-2.4,-34.4}},   color={0,0,127}));
  connect(add.y, Subtract.u1) annotation (Line(points={{-49.3,67},{-40.65,67},{-40.65,
          55.2},{-33.4,55.2}}, color={0,0,127}));
  connect(add1.y, Subtract.u2) annotation (Line(points={{-37.3,23},{-37.3,46},{-33.4,
          46},{-33.4,46.8}}, color={0,0,127}));
  connect(actuatorSubBus.Total_Mass_Flow_System, Mass_Pass_through.u)
    annotation (Line(
      points={{-34,-99},{-180,-99},{-180,108},{-15,108},{-15,99}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Reference_total_mass_flow.y, Subtract1.u1) annotation (Line(points={{9,
          82.9},{9,78.45},{11.2,78.45},{11.2,73.4}}, color={0,0,127}));
  connect(Mass_Pass_through.y, Subtract1.u2) annotation (Line(points={{-15,87.5},
          {-4.5,87.5},{-4.5,73.4},{2.8,73.4}}, color={0,0,127}));
  connect(Subtract1.y, Mass_Pass_through1.u) annotation (Line(points={{7,57.3},{
          7,52.65},{15,52.65},{15,47}}, color={0,0,127}));
  connect(Subtract.y, Mass_Pass_through2.u) annotation (Line(points={{-17.3,51},
          {-11.65,51},{-11.65,43},{-7,43}}, color={0,0,127}));
  connect(Chromolox_Heater_Control1.y, switch3.u1) annotation (Line(points={{10,
          -10.6},{10,-24},{10.4,-24},{10.4,-34.4}},
                                            color={0,0,127}));
  connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
     Line(
      points={{-34,-99},{-180,-99},{-180,-18},{-172.4,-18}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Heater_Load.y, add.u2) annotation (Line(points={{-79.3,91},{-70,91},{-70,
          71.2},{-65.4,71.2}}, color={0,0,127}));
  connect(const6.y, Chromolox_Heater_Control1.u_m) annotation (Line(points={{
          -5.6,6},{-4,6},{-4,-4},{2.8,-4}}, color={0,0,127}));
  connect(Chromolox_Heater_Control1.u_s, add2.y)
    annotation (Line(points={{10,3.2},{10,7.3},{9,7.3}}, color={0,0,127}));
  connect(Mass_Pass_through2.y, add2.u1) annotation (Line(points={{-7,31.5},{4,
          31.5},{4,23.4},{4.8,23.4}}, color={0,0,127}));
  connect(Mass_Pass_through1.y, add2.u2) annotation (Line(points={{15,35.5},{15,
          28.75},{13.2,28.75},{13.2,23.4}}, color={0,0,127}));
  connect(BOP_relative_demand.y[1], BOP_total_demand.u) annotation (Line(points={{-153.3,
          -63},{-145,-63}},                                     color={0,0,127}));
  connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
    annotation (Line(
      points={{-34,-99},{-180,-99},{-180,-34},{-172.4,-34}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Load_TES.y, switch1.u1) annotation (Line(points={{-152.9,87},{-138,87},
          {-138,80.4},{-127.6,80.4}}, color={0,0,127}));
  connect(Load_TES.y, greaterEqual.u1) annotation (Line(points={{-152.9,87},{-150,
          87},{-150,74},{-176,74},{-176,61},{-171.4,61}}, color={0,0,127}));
  connect(Heater_Demand.y[1], Heater_Total_Demand.u) annotation (Line(points={{-153.3,
          -83},{-145,-83},{-145,-83}}, color={0,0,127}));
  connect(sensorSubBus.Valve_6_Opening, Valve6.y) annotation (Line(
      points={{40,-99},{40,-70},{56,-70},{56,-56},{49,-56}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
            {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-100},{120,140}})));
end Control_System_Therminol_4_element_all_modes_ExpTest2;
