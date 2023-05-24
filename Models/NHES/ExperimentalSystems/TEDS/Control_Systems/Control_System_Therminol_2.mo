within NHES.ExperimentalSystems.TEDS.Control_Systems;
model Control_System_Therminol_2

  replaceable package Medium =
      TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
    TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
      choicesAllMatching=true);
  BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
    annotation (Placement(transformation(extent={{-58,-122},{-10,-76}})));
  BaseClasses.SignalSubBus_SensorOutput sensorSubBus
    annotation (Placement(transformation(extent={{16,-122},{64,-76}})));
  Modelica.Blocks.Continuous.LimPID PIDV1(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03*0.007*3600,
    Ti=3.5,
    y_start=1,
    yMin=0.0)
    annotation (Placement(transformation(extent={{70,122},{84,136}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{66,108},{74,116}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)
    annotation (Placement(transformation(extent={{98,124},{110,136}})));
  Modelica.Blocks.Continuous.LimPID PIDV2(
    yMax=1,
    k=0.007*3600,
    Ti=3.5,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMin=0.0)
    annotation (Placement(transformation(extent={{70,86},{84,100}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{60,74},{68,82}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5, y_start=0)
    annotation (Placement(transformation(extent={{98,88},{110,100}})));
  Modelica.Blocks.Continuous.LimPID PIDV3(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.03*0.007*3600,
    Ti=3.5,
    y_start=1,
    yMin=0.0)
    annotation (Placement(transformation(extent={{64,50},{78,64}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{58,34},{66,42}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)
    annotation (Placement(transformation(extent={{98,52},{110,64}})));
  Modelica.Blocks.Continuous.LimPID PIDV4(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=0.007*3600,
    Ti=3.5,
    y_start=1,
    yMin=0.0)
    annotation (Placement(transformation(extent={{62,8},{76,22}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
    annotation (Placement(transformation(extent={{58,-4},{66,4}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)
    annotation (Placement(transformation(extent={{96,10},{108,22}})));
  Modelica.Blocks.Continuous.LimPID PIDV5(
    yMax=1,
    k=0.007*3600,
    Ti=3.5,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMin=0.0)
    annotation (Placement(transformation(extent={{62,-28},{76,-14}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{58,-40},{66,-32}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)
    annotation (Placement(transformation(extent={{96,-26},{108,-14}})));
  Modelica.Blocks.Continuous.LimPID PIDV6(
    yMax=1,
    k=0.007*3600,
    Ti=3.5,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.0)
    annotation (Placement(transformation(extent={{62,-64},{76,-50}})));
  Modelica.Blocks.Sources.Constant const5(k=0)
    annotation (Placement(transformation(extent={{58,-76},{66,-68}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5, y_start=1)
    annotation (Placement(transformation(extent={{96,-62},{108,-50}})));
  Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
    annotation (Placement(transformation(extent={{26,118},{48,140}})));
  Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
    annotation (Placement(transformation(extent={{28,84},{48,104}})));
  Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
    annotation (Placement(transformation(extent={{28,48},{48,68}})));
  Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
    annotation (Placement(transformation(extent={{28,6},{48,26}})));
  Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
    annotation (Placement(transformation(extent={{28,-66},{48,-46}})));
  Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
    annotation (Placement(transformation(extent={{28,-32},{48,-12}})));

Real Error1 "Valve 1";
Real Error2=1 "Valve 2";
Real Error3 "Valve 3";
Real Error4 "Valve 4";
Real Error5 "Valve 5";
Real Error6=1 "Valve 6";
Integer storage_button "0 equals discharge or stationary, 1 is charging";

parameter Modelica.Units.SI.Power Q_TES_max=200e3;
parameter Modelica.Units.SI.Temperature T_hot_design=325;
parameter Modelica.Units.SI.Temperature T_cold_design=225;

Modelica.Units.SI.MassFlowRate m_tes_max;
Modelica.Units.SI.MassFlowRate m_tes_demand;
Modelica.Units.SI.Power Q_TES_demanded;
Modelica.Units.SI.Power Q_TES_discharge;
Modelica.Units.SI.SpecificHeatCapacity Cp=Medium.specificHeatCapacityCp(mediums.state);

Medium.BaseProperties mediums;

  Modelica.Blocks.Sources.Constant const6(k=200e3)          annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-86,92})));
  TRANSFORM.Controls.LimPID Chromolox_Heater_Control1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    Ti=3.5,
    k_s=1,
    k_m=1,
    yMax=3,
    yMin=0.2,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.84)
    annotation (Placement(transformation(extent={{-30,48},{-18,60}})));
  Modelica.Blocks.Sources.Constant delayStart(k=1)
    annotation (Placement(transformation(extent={{-100,120},{-80,140}})));
  Modelica.Blocks.Sources.CombiTimeTable LoadTES(table=[0.0,0; 900,0; 2700,-20;
        4800,20; 14400,0.0; 18000,0.0; 21600,0.0])
    annotation (Placement(transformation(extent={{-176,80},{-162,94}})));
  TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
    "Used in the Coded Section"
    annotation (Placement(transformation(extent={{-170,-14},{-146,8}})));
  TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
    "Used in the Code section. "
    annotation (Placement(transformation(extent={{-170,-32},{-146,-12}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-60,74},{-46,60}})));
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
    annotation (Placement(transformation(extent={{-74,24},{-58,40}})));
  Modelica.Blocks.Sources.RealExpression Q_discharge(y=Q_TES_discharge)
    annotation (Placement(transformation(extent={{-112,26},{-90,48}})));
  Modelica.Blocks.Sources.Constant Null1(k=0)
                                             annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-124,8})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-46,16},{-32,30}})));
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

  Modelica.Blocks.Sources.RealExpression Reference_total_mass_flow(y=add.y/(Cp*
        (T_hot_design - T_cold_design))) annotation (Placement(transformation(
        extent={{11,-11},{-11,11}},
        rotation=90,
        origin={11,33})));
  Modelica.Blocks.Math.Gain gain(k=Q_TES_max/100.)
    annotation (Placement(transformation(extent={{-146,82},{-136,92}})));
initial equation
 // Q_TES_discharge = 0.0;

equation
  //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
  mediums.p = 1e5;
  mediums.T = 275+273;

//Error1 = pulse.y;
algorithm

Q_TES_demanded :=(LoadTES.y[1]/100)*Q_TES_max;

m_tes_demand :=Q_TES_demanded/(Cp*(T_hot_design - T_cold_design));

Q_TES_discharge :=Discharge_mass_flow_sensor.y*Cp*(T_hot_design - T_cold_design);
                                                                             // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
m_tes_max :=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
//Valve 3 used for TES discharge

if LoadTES.y[1] > 0 and delay(storage_button,15) == 0 then
  Error3 :=(m_tes_demand - Discharge_mass_flow_sensor.y)/m_tes_max;
  else
  Error3 :=-1;
end if;

//Valve 1 used for TES Charge
if LoadTES.y[1] < 0 then // charging
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

equation
  connect(const.y,PIDV1. u_m)
    annotation (Line(points={{74.4,112},{77,112},{77,120.6}},
                                                           color={0,0,127}));
  connect(PIDV1.y,firstOrder. u) annotation (Line(points={{84.7,129},{92.35,129},
          {92.35,130},{96.8,130}},
                                 color={0,0,127}));
  connect(const1.y,PIDV2. u_m)
    annotation (Line(points={{68.4,78},{77,78},{77,84.6}}, color={0,0,127}));
  connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{84.7,93},{92.35,93},
          {92.35,94},{96.8,94}},     color={0,0,127}));
  connect(const2.y,PIDV3. u_m)
    annotation (Line(points={{66.4,38},{71,38},{71,48.6}},color={0,0,127}));
  connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{78.7,57},{92.35,57},
          {92.35,58},{96.8,58}},     color={0,0,127}));
  connect(const3.y,PIDV4. u_m) annotation (Line(points={{66.4,0},{69,0},{69,6.6}},
                      color={0,0,127}));
  connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{76.7,15},{90.35,15},
          {90.35,16},{94.8,16}},        color={0,0,127}));
  connect(const4.y,PIDV5. u_m) annotation (Line(points={{66.4,-36},{69,-36},{69,
          -29.4}},    color={0,0,127}));
  connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,
          -21},{90.35,-20},{94.8,-20}}, color={0,0,127}));
  connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
          -65.4}},      color={0,0,127}));
  connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,
          -57},{90.35,-56},{94.8,-56}}, color={0,0,127}));
  connect(sensorSubBus.Valve_1_Opening, firstOrder.y) annotation (Line(
      points={{40,-99},{120,-99},{120,130},{110.6,130}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Valve_2_Opening, firstOrder1.y) annotation (Line(
      points={{40,-99},{120,-99},{120,94},{110.6,94}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Valve_4_Opening, firstOrder3.y) annotation (Line(
      points={{40,-99},{120,-99},{120,16},{108.6,16}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Valve_5_Opening, firstOrder4.y) annotation (Line(
      points={{40,-99},{120,-99},{120,-20},{108.6,-20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Valve_6_Opening, firstOrder5.y) annotation (Line(
      points={{40,-99},{120,-99},{120,-56},{108.6,-56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Valve1.y, PIDV1.u_s)
    annotation (Line(points={{49.1,129},{68.6,129}}, color={0,0,127}));
  connect(Valve4.y, PIDV4.u_s) annotation (Line(points={{49,16},{51.5,16},{51.5,
          15},{60.6,15}}, color={0,0,127}));
  connect(Valve5.y, PIDV5.u_s) annotation (Line(points={{49,-22},{52,-22},{52,
          -21},{60.6,-21}},
                       color={0,0,127}));
  connect(Valve6.y, PIDV6.u_s) annotation (Line(points={{49,-56},{50,-56},{50,
          -57},{60.6,-57}},
                       color={0,0,127}));
  connect(Valve3.y, PIDV3.u_s) annotation (Line(points={{49,58},{52,58},{52,57},
          {62.6,57}}, color={0,0,127}));
  connect(Valve2.y, PIDV2.u_s) annotation (Line(points={{49,94},{58,94},{58,93},
          {68.6,93}}, color={0,0,127}));
  connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
      points={{40,-99},{120,-99},{120,58},{110.6,58}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
    annotation (Line(
      points={{-34,-99},{-180,-99},{-180,-3},{-172.4,-3}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
    annotation (Line(
      points={{-34,-99},{-148,-99},{-148,-100},{-180,-100},{-180,-22},{-172.4,-22}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Null.y, greaterEqual.u2) annotation (Line(points={{-165.4,34},{-164,34},
          {-164,50},{-178,50},{-178,55.4},{-171.4,55.4}}, color={0,0,127}));
  connect(greaterEqual.y, switch1.u2) annotation (Line(points={{-155.3,61},{
          -148,61},{-148,74},{-127.6,74}},
                                      color={255,0,255}));
  connect(Null.y, switch1.u3) annotation (Line(points={{-165.4,34},{-140,34},{
          -140,67.6},{-127.6,67.6}},                          color={0,0,127}));
  connect(LoadTES.y[1], greaterEqual.u1) annotation (Line(points={{-161.3,87},{-158,
          87},{-158,76},{-178,76},{-178,61},{-171.4,61}}, color={0,0,127}));
  connect(switch1.y, add.u1) annotation (Line(points={{-109.2,74},{-94,74},{-94,
          62.8},{-61.4,62.8}}, color={0,0,127}));
  connect(const6.y, add.u2) annotation (Line(points={{-79.4,92},{-76,92},{-76,71.2},
          {-61.4,71.2}}, color={0,0,127}));
  connect(add.y, Chromolox_Heater_Control1.u_s) annotation (Line(points={{-45.3,
          67},{-44,67},{-44,54},{-31.2,54}}, color={0,0,127}));
  connect(greaterEqual1.y, switch2.u2) annotation (Line(points={{-93.3,15},{-82,
          15},{-82,32},{-75.6,32}}, color={255,0,255}));
  connect(Q_discharge.y, switch2.u1) annotation (Line(points={{-88.9,37},{-83.45,
          37},{-83.45,38.4},{-75.6,38.4}}, color={0,0,127}));
  connect(Q_discharge.y, greaterEqual1.u1) annotation (Line(points={{-88.9,37},{
          -86,37},{-86,26},{-116,26},{-116,15},{-109.4,15}}, color={0,0,127}));
  connect(Null1.y, greaterEqual1.u2) annotation (Line(points={{-117.4,8},{-114,8},
          {-114,9.4},{-109.4,9.4}}, color={0,0,127}));
  connect(Null1.y, switch2.u3) annotation (Line(points={{-117.4,8},{-114,8},{-114,
          4},{-80,4},{-80,25.6},{-75.6,25.6}}, color={0,0,127}));
  connect(switch2.y, add1.u1) annotation (Line(points={{-57.2,32},{-52,32},{-52,
          27.2},{-47.4,27.2}}, color={0,0,127}));
  connect(add1.y, Chromolox_Heater_Control1.u_m) annotation (Line(points={{-31.3,
          23},{-24,23},{-24,46.8}}, color={0,0,127}));
  connect(actuatorSubBus.Heater_Input, add1.u2) annotation (Line(
      points={{-34,-99},{-70,-99},{-70,18.8},{-47.4,18.8}},
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
  connect(greaterEqual2.y, switch3.u2) annotation (Line(points={{-11.3,-11},{4,
          -11},{4,-34.4}},  color={255,0,255}));
  connect(Timer1.y, greaterEqual2.u1) annotation (Line(points={{-40.9,-1},{-34.45,
          -1},{-34.45,-11},{-27.4,-11}}, color={0,0,127}));
  connect(Null2.y, switch3.u3) annotation (Line(points={{-33.4,-40},{-24,-40},{
          -24,-30},{-2.4,-30},{-2.4,-34.4}},
                                           color={0,0,127}));
  connect(Reference_total_mass_flow.y, switch3.u1) annotation (Line(points={{11,
          20.9},{11,-14.55},{10.4,-14.55},{10.4,-34.4}}, color={0,0,127}));
  connect(LoadTES.y[1], gain.u)
    annotation (Line(points={{-161.3,87},{-147,87}}, color={0,0,127}));
  connect(gain.y, switch1.u1) annotation (Line(points={{-135.5,87},{-132,87},{
          -132,80.4},{-127.6,80.4}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
            {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-100},{120,140}})));
end Control_System_Therminol_2;
