within NHES.Systems.ExperimentalSystems.TEDS.ControlSystems;
model Control_System_B_1

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
    k=0.007*3600,
    Ti=3.5,
    y_start=1,
    yMin=0.0)
    annotation (Placement(transformation(extent={{74,122},{88,136}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{70,108},{78,116}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1, y_start=1)
    annotation (Placement(transformation(extent={{98,124},{110,136}})));
  Modelica.Blocks.Continuous.LimPID PIDV2(
    yMax=1,
    k=0.007*3600,
    Ti=3.5,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMin=0.0)
    annotation (Placement(transformation(extent={{74,86},{88,100}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{70,74},{78,82}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=1, y_start=0)
    annotation (Placement(transformation(extent={{98,88},{110,100}})));
  Modelica.Blocks.Continuous.LimPID PIDV3(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.007*3600,
    Ti=3.5,
    y_start=1,
    yMin=0.0)
    annotation (Placement(transformation(extent={{74,50},{88,64}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{68,34},{76,42}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=1, y_start=1)
    annotation (Placement(transformation(extent={{98,52},{110,64}})));
  Modelica.Blocks.Continuous.LimPID PIDV4(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=0.007*3600,
    Ti=3.5,
    y_start=1,
    yMin=0.0)
    annotation (Placement(transformation(extent={{72,8},{86,22}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
    annotation (Placement(transformation(extent={{68,-4},{76,4}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=0.1,
                                                         y_start=1)
    annotation (Placement(transformation(extent={{96,10},{108,22}})));
  Modelica.Blocks.Continuous.LimPID PIDV5(
    yMax=1,
    k=0.007*3600,
    Ti=3.5,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMin=0.0)
    annotation (Placement(transformation(extent={{72,-28},{86,-14}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{68,-40},{76,-32}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=0.1,
                                                         y_start=1)
    annotation (Placement(transformation(extent={{96,-26},{108,-14}})));
  Modelica.Blocks.Continuous.LimPID PIDV6(
    yMax=1,
    k=0.007*3600,
    Ti=3.5,
    y_start=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.0)
    annotation (Placement(transformation(extent={{72,-64},{86,-50}})));
  Modelica.Blocks.Sources.Constant const5(k=0)
    annotation (Placement(transformation(extent={{68,-76},{76,-68}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=1, y_start=1)
    annotation (Placement(transformation(extent={{96,-62},{108,-50}})));
  Modelica.Blocks.Sources.RealExpression Valve1(y=Error1)
    annotation (Placement(transformation(extent={{32,118},{54,140}})));
  Modelica.Blocks.Sources.RealExpression Valve2(y=Error2)
    annotation (Placement(transformation(extent={{32,84},{52,104}})));
  Modelica.Blocks.Sources.RealExpression Valve3(y=Error3)
    annotation (Placement(transformation(extent={{32,48},{52,68}})));
  Modelica.Blocks.Sources.RealExpression Valve4(y=Error4)
    annotation (Placement(transformation(extent={{32,6},{52,26}})));
  Modelica.Blocks.Sources.RealExpression Valve6(y=Error6)
    annotation (Placement(transformation(extent={{32,-66},{52,-46}})));
  Modelica.Blocks.Sources.RealExpression Valve5(y=Error5)
    annotation (Placement(transformation(extent={{32,-32},{52,-12}})));

  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=1,
    period=1600,
    startTime=delayStart.k)
    annotation (Placement(transformation(extent={{-60,120},{-40,140}})));

Real Error1 "Valve 1";
Real Error2=1 "Valve 2";
Real Error3=0 "Valve 3";
Real Error4 "Valve 4";
Real Error5 "Valve 5";
Real Error6=1 "Valve 6";

parameter SI.Power Q_TES_max = 200e3;
parameter SI.Temperature T_hot_design = 325;
parameter SI.Temperature T_cold_design = 225;

SI.Power Q_TES_demanded;
SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

Medium.BaseProperties mediums;

  Modelica.Blocks.Sources.Constant const6(k=200e3)          annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-76,80})));
  TRANSFORM.Controls.LimPID Chromolox_Heater_Control1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    k_s=1,
    k_m=1,
    yMax=3,
    yMin=0.2,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=200e3)
    annotation (Placement(transformation(extent={{-50,88},{-38,76}})));
  Modelica.Blocks.Sources.Constant delayStart(k=3600)
    annotation (Placement(transformation(extent={{-100,120},{-80,140}})));
  Modelica.Blocks.Sources.CombiTimeTable LoadTES(table=[0.0,-20; 3600,20; 7200,0.0;
        10800,0.0; 14400,0.0; 18000,0.0; 21600,0.0])
    annotation (Placement(transformation(extent={{-20,120},{0,140}})));
equation
  //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
  mediums.p = 1e5;
  mediums.T = 275+273;

Error1 = pulse.y;
algorithm

Q_TES_demanded :=(LoadTES.y[1]/100)*Q_TES_max;

//m_tes_demand = Q_TES_demanded/(Cp*(T_hot_design-T_cold_design));

//Valve 3 used for TES discharge
//If LoadTES > 0 then discharging

//Q_TES_demanded = Load

//Valve 1 used for TES Charge
//If LoadTES < 0 then charging

  //Designation of the TEDS valve control algorithms.

 //Interlock System for the valves.
  if PIDV1.y > 0.001 then
    Error4 :=1;
  else
    Error4 :=-1;
  end if;

  if PIDV3.y > 0.001 then
    Error5 :=1;
  else
    Error5 :=-1;
  end if;

equation
  connect(const.y,PIDV1. u_m)
    annotation (Line(points={{78.4,112},{81,112},{81,120.6}},
                                                           color={0,0,127}));
  connect(PIDV1.y,firstOrder. u) annotation (Line(points={{88.7,129},{92.35,129},
          {92.35,130},{96.8,130}},
                                 color={0,0,127}));
  connect(const1.y,PIDV2. u_m)
    annotation (Line(points={{78.4,78},{81,78},{81,84.6}}, color={0,0,127}));
  connect(PIDV2.y,firstOrder1. u) annotation (Line(points={{88.7,93},{92.35,93},
          {92.35,94},{96.8,94}},     color={0,0,127}));
  connect(const2.y,PIDV3. u_m)
    annotation (Line(points={{76.4,38},{81,38},{81,48.6}},color={0,0,127}));
  connect(PIDV3.y,firstOrder2. u) annotation (Line(points={{88.7,57},{92.35,57},
          {92.35,58},{96.8,58}},     color={0,0,127}));
  connect(const3.y,PIDV4. u_m) annotation (Line(points={{76.4,0},{79,0},{79,6.6}},
                      color={0,0,127}));
  connect(PIDV4.y,firstOrder3. u) annotation (Line(points={{86.7,15},{90.35,15},
          {90.35,16},{94.8,16}},        color={0,0,127}));
  connect(const4.y,PIDV5. u_m) annotation (Line(points={{76.4,-36},{79,-36},{79,
          -29.4}},    color={0,0,127}));
  connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{86.7,-21},{90.35,-21},
          {90.35,-20},{94.8,-20}},      color={0,0,127}));
  connect(const5.y,PIDV6. u_m) annotation (Line(points={{76.4,-72},{79,-72},{79,
          -65.4}},      color={0,0,127}));
  connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{86.7,-57},{90.35,-57},
          {90.35,-56},{94.8,-56}},      color={0,0,127}));
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
    annotation (Line(points={{55.1,129},{72.6,129}}, color={0,0,127}));
  connect(Valve4.y, PIDV4.u_s) annotation (Line(points={{53,16},{61.5,16},{61.5,
          15},{70.6,15}}, color={0,0,127}));
  connect(Valve5.y, PIDV5.u_s) annotation (Line(points={{53,-22},{62,-22},{62,-21},
          {70.6,-21}}, color={0,0,127}));
  connect(Valve6.y, PIDV6.u_s) annotation (Line(points={{53,-56},{60,-56},{60,-57},
          {70.6,-57}}, color={0,0,127}));
  connect(Valve3.y, PIDV3.u_s) annotation (Line(points={{53,58},{62,58},{62,57},
          {72.6,57}}, color={0,0,127}));
  connect(Valve2.y, PIDV2.u_s) annotation (Line(points={{53,94},{62,94},{62,93},
          {72.6,93}}, color={0,0,127}));
  connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
      points={{40,-99},{120,-99},{120,58},{110.6,58}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const6.y, Chromolox_Heater_Control1.u_s) annotation (Line(points={{
          -69.4,80},{-60,80},{-60,82},{-51.2,82}}, color={0,0,127}));
  connect(sensorSubBus.Pump_Flow, Chromolox_Heater_Control1.y) annotation (Line(
      points={{40,-99},{14,-99},{14,82},{-37.4,82}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Heater_Input, Chromolox_Heater_Control1.u_m)
    annotation (Line(
      points={{-34,-99},{-100,-99},{-100,96},{-44,96},{-44,89.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{120,140}})));
end Control_System_B_1;
