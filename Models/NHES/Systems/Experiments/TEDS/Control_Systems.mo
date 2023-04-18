within NHES.Systems.Experiments.TEDS;
package Control_Systems "Range of all control Systems for TEDS"
  model Control_System_B
    BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-62,-122},{-14,-76}})));
    BaseClasses.SignalSubBus_SensorOutput sensorSubBus
      annotation (Placement(transformation(extent={{16,-122},{64,-76}})));
    Modelica.Blocks.Math.Gain gain(k=1)
      annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  equation
    connect(actuatorSubBus.Valve1, gain.u) annotation (Line(
        points={{-38,-99},{-100,-99},{-100,-20},{8,-20}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorSubBus.Valve_1_Opening, gain.y) annotation (Line(
        points={{40,-99},{100,-99},{100,-20},{31,-20}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{160,160}})), Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{160,160}})));
  end Control_System_B;

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

  model Control_System_Therminol

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

  parameter SI.Power Q_TES_max = 200e3;
  parameter SI.Temperature T_hot_design = 325;
  parameter SI.Temperature T_cold_design = 225;

  SI.MassFlowRate m_tes_max;
  SI.MassFlowRate m_tes_demand;
  SI.Power Q_TES_demanded;
  SI.Power Q_TES_discharge;
  SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

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
      annotation (Placement(transformation(extent={{-142,66},{-126,82}})));
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

  initial equation
    Q_TES_discharge = 0.0;

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
    connect(LoadTES.y[1], switch1.u1) annotation (Line(points={{-161.3,87},{-153.65,
            87},{-153.65,80.4},{-143.6,80.4}}, color={0,0,127}));
    connect(Null.y, greaterEqual.u2) annotation (Line(points={{-165.4,34},{-164,34},
            {-164,50},{-178,50},{-178,55.4},{-171.4,55.4}}, color={0,0,127}));
    connect(greaterEqual.y, switch1.u2) annotation (Line(points={{-155.3,61},{-148,
            61},{-148,74},{-143.6,74}}, color={255,0,255}));
    connect(Null.y, switch1.u3) annotation (Line(points={{-165.4,34},{-154,34},{-154,
            46},{-144,46},{-144,56},{-143.6,56},{-143.6,67.6}}, color={0,0,127}));
    connect(LoadTES.y[1], greaterEqual.u1) annotation (Line(points={{-161.3,87},{-158,
            87},{-158,76},{-178,76},{-178,61},{-171.4,61}}, color={0,0,127}));
    connect(switch1.y, add.u1) annotation (Line(points={{-125.2,74},{-94,74},{-94,
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
    connect(Chromolox_Heater_Control1.y, switch3.u1) annotation (Line(points={{-17.4,
            54},{10.4,54},{10.4,-34.4}},
                                       color={0,0,127}));
    connect(Timer.y, greaterEqual2.u2) annotation (Line(points={{-40.9,-19},{-34,-19},
            {-34,-16.6},{-27.4,-16.6}}, color={0,0,127}));
    connect(greaterEqual2.y, switch3.u2) annotation (Line(points={{-11.3,-11},{4,
            -11},{4,-34.4}},  color={255,0,255}));
    connect(Timer1.y, greaterEqual2.u1) annotation (Line(points={{-40.9,-1},{-34.45,
            -1},{-34.45,-11},{-27.4,-11}}, color={0,0,127}));
    connect(Null2.y, switch3.u3) annotation (Line(points={{-33.4,-40},{-24,-40},{
            -24,-30},{-2.4,-30},{-2.4,-34.4}},
                                             color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol;

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

  parameter SI.Power Q_TES_max = 200e3;
  parameter SI.Temperature T_hot_design = 325;
  parameter SI.Temperature T_cold_design = 225;

  SI.MassFlowRate m_tes_max;
  SI.MassFlowRate m_tes_demand;
  SI.Power Q_TES_demanded;
  SI.Power Q_TES_discharge;
  SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

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

  model Control_System_Therminol_3_element

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
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,122},{84,136}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{66,108},{74,116}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,124},{110,136}})));
    Modelica.Blocks.Continuous.LimPID PIDV2(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,86},{84,100}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{60,74},{68,82}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,52},{110,64}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,10},{108,22}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
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

  parameter SI.Power Q_TES_max = 200e3;
  parameter SI.Temperature T_hot_design = 325;
  parameter SI.Temperature T_cold_design = 225;

  parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
  SI.MassFlowRate m_tes_demand;
  SI.Power Q_TES_demanded;
  SI.Power Q_TES_discharge;
  SI.SpecificHeatCapacity Cp = Medium.specificHeatCapacityCp(mediums.state);

  Medium.BaseProperties mediums;

    Modelica.Blocks.Sources.Constant const6(k=200e3)          annotation (
        Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=0,
          origin={-86,92})));
    TRANSFORM.Controls.LimPID Chromolox_Heater_Control1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=3.5,
      k_s=1,
      k_m=1,
      yMax=3,
      yMin=0.2,
      y_start=0.84)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={8,10})));
    Modelica.Blocks.Sources.Constant delayStart(k=20)
      annotation (Placement(transformation(extent={{-100,120},{-80,140}})));
    Modelica.Blocks.Sources.CombiTimeTable LoadTES(table=[0.0,0; 900,0; 2700,-20;
          4800,20; 14400,0.0; 18000,0.0; 21600,0.0], startTime=delayStart.k)
      annotation (Placement(transformation(extent={{-176,80},{-162,94}})));
    TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
      "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,-14},{-146,8}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-32},{-146,-12}})));
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
    Modelica.Blocks.Math.Gain gain(k=Q_TES_max/100.)
      annotation (Placement(transformation(extent={{-146,82},{-136,92}})));
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
  initial equation
    Q_TES_discharge = 0.0;
    //storage_button=0;
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
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,-21},
            {90.35,-20},{94.8,-20}},      color={0,0,127}));
    connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
            -65.4}},      color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,-57},
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
      annotation (Line(points={{49.1,129},{68.6,129}}, color={0,0,127}));
    connect(Valve4.y, PIDV4.u_s) annotation (Line(points={{49,16},{51.5,16},{51.5,
            15},{60.6,15}}, color={0,0,127}));
    connect(Valve5.y, PIDV5.u_s) annotation (Line(points={{49,-22},{52,-22},{52,-21},
            {60.6,-21}}, color={0,0,127}));
    connect(Valve6.y, PIDV6.u_s) annotation (Line(points={{49,-56},{50,-56},{50,-57},
            {60.6,-57}}, color={0,0,127}));
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
    connect(greaterEqual.y, switch1.u2) annotation (Line(points={{-155.3,61},{-148,
            61},{-148,74},{-127.6,74}}, color={255,0,255}));
    connect(Null.y, switch1.u3) annotation (Line(points={{-165.4,34},{-140,34},{-140,
            67.6},{-127.6,67.6}},                               color={0,0,127}));
    connect(LoadTES.y[1], greaterEqual.u1) annotation (Line(points={{-161.3,87},{-158,
            87},{-158,76},{-178,76},{-178,61},{-171.4,61}}, color={0,0,127}));
    connect(switch1.y, add.u1) annotation (Line(points={{-109.2,74},{-94,74},{-94,
            62.8},{-65.4,62.8}}, color={0,0,127}));
    connect(const6.y, add.u2) annotation (Line(points={{-79.4,92},{-76,92},{-76,71.2},
            {-65.4,71.2}}, color={0,0,127}));
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
    connect(LoadTES.y[1], gain.u)
      annotation (Line(points={{-161.3,87},{-147,87}}, color={0,0,127}));
    connect(gain.y, switch1.u1) annotation (Line(points={{-135.5,87},{-132,87},{-132,
            80.4},{-127.6,80.4}}, color={0,0,127}));
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
    connect(Mass_Pass_through2.y, Chromolox_Heater_Control1.u_m)
      annotation (Line(points={{-7,31.5},{-7,10},{0.8,10}}, color={0,0,127}));
    connect(Mass_Pass_through1.y, Chromolox_Heater_Control1.u_s) annotation (Line(
          points={{15,35.5},{15,26.75},{8,26.75},{8,17.2}}, color={0,0,127}));
    connect(Chromolox_Heater_Control1.y, switch3.u1) annotation (Line(points={{8,3.4},
            {8,-24},{10.4,-24},{10.4,-34.4}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol_3_element;

  model Control_System_Therminol_3_element_all_modes

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
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,122},{84,136}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{66,108},{74,116}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,124},{110,136}})));
    Modelica.Blocks.Continuous.LimPID PIDV2(
      yMax=1,
      k=0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,86},{84,100}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{60,74},{68,82}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,52},{110,64}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,10},{108,22}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,-26},{108,-14}})));
    Modelica.Blocks.Continuous.LimPID PIDV6(
      yMax=1,
      k=0.03*0.007*3600,
      Ti=3.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.0)
      annotation (Placement(transformation(extent={{62,-64},{76,-50}})));
    Modelica.Blocks.Sources.Constant const5(k=0)
      annotation (Placement(transformation(extent={{58,-76},{66,-68}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
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
  Real Error2=1 "Valve 2";
  Real Error3 "Valve 3";
  Real Error4 "Valve 4";
  Real Error5 "Valve 5";
  Real Error6 "Valve 6";
  Integer storage_button "0 equals discharge or stationary, 1 is charging";

  parameter SI.Power Q_TES_max = 200e3;
  parameter SI.Temperature T_hot_design = 325;
  parameter SI.Temperature T_cold_design = 225;

  parameter SI.MassFlowRate m_tes_max = 2;//=Q_TES_max/(Cp*(T_hot_design - T_cold_design));
  parameter SI.MassFlowRate m_heater_max= 2; //Just a large number. Not ideal for control, but should work to start off the system.
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
    Modelica.Blocks.Sources.CombiTimeTable LoadTES(table=[0.0,0; 900,0; 2700,-20;
          4800,20; 14400,0.0; 18000,0.0; 21600,0.0], startTime=delayStart.k)
      annotation (Placement(transformation(extent={{-176,80},{-162,94}})));
    TRANSFORM.Blocks.RealExpression Discharge_mass_flow_sensor
      "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,-14},{-146,8}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-32},{-146,-12}})));
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
    Modelica.Blocks.Math.Gain gain(k=Q_TES_max/100.)
      annotation (Placement(transformation(extent={{-146,82},{-136,92}})));
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
      annotation (Placement(transformation(extent={{-170,-54},{-146,-34}})));
    Modelica.Blocks.Sources.Pulse Heater_Load(
      amplitude=100e3,
      width=50,
      period(displayUnit="h") = 7200,
      offset=100e3)
                annotation (Placement(transformation(extent={{-94,84},{-80,98}})));
    Modelica.Blocks.Sources.Constant const6(k=0)
      annotation (Placement(transformation(extent={{-14,2},{-6,10}})));
    Modelica.Blocks.Math.Add add2(k1=0.0001, k2=1)
      annotation (Placement(transformation(extent={{-7,7},{7,-7}},
          rotation=-90,
          origin={9,15})));
  initial equation
    Q_TES_discharge = 0.0;
    //storage_button=0;
  equation
    //Values do not matter here because the fluid is constant cp by definition according to the linear fluid model. But this lets us change the fluid easier.
    mediums.p = 1e5;
    mediums.T = 275+273;

  //Error1 = pulse.y;
  algorithm

  Q_TES_demanded :=(LoadTES.y[1]/100)*Q_TES_max;

  m_tes_demand :=Q_TES_demanded/(Cp*(T_hot_design - T_cold_design));

  m_heater_demand :=Heater_Load.y/(Cp*(T_hot_design - T_cold_design));

  Q_TES_discharge :=Discharge_mass_flow_sensor.y*Cp*(T_hot_design - T_cold_design);
                                                                               // Will need to change this to take into account T_hot_sensor and T_Cold_Sensor.
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

  // Main Heater Mass Flow Control
    if m_heater_demand > 0.001 then
      Error6 :=(abs(m_heater_demand) - Heater_flowrate_sensor.y)/m_heater_max;
    else
      Error6 :=-1;
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
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,-21},
            {90.35,-20},{94.8,-20}},      color={0,0,127}));
    connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
            -65.4}},      color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,-57},
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
    connect(greaterEqual.y, switch1.u2) annotation (Line(points={{-155.3,61},{-148,
            61},{-148,74},{-127.6,74}}, color={255,0,255}));
    connect(Null.y, switch1.u3) annotation (Line(points={{-165.4,34},{-140,34},{-140,
            67.6},{-127.6,67.6}},                               color={0,0,127}));
    connect(LoadTES.y[1], greaterEqual.u1) annotation (Line(points={{-161.3,87},{-158,
            87},{-158,76},{-178,76},{-178,61},{-171.4,61}}, color={0,0,127}));
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
    connect(LoadTES.y[1], gain.u)
      annotation (Line(points={{-161.3,87},{-147,87}}, color={0,0,127}));
    connect(gain.y, switch1.u1) annotation (Line(points={{-135.5,87},{-132,87},{-132,
            80.4},{-127.6,80.4}}, color={0,0,127}));
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
        points={{-34,-99},{-180,-99},{-180,-44},{-172.4,-44}},
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
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol_3_element_all_modes;

  model Control_System_Therminol_4_element_all_modes
    "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

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
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,122},{84,136}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{66,108},{74,116}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,52},{110,64}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,10},{108,22}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
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
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,100,1;
          1800,100,1; 3600,0,4; 4800,0,2; 7200,0,4; 9600,100,5; 10800,140,5;
          12000,140,0.0; 14400,100,0.0; 18000,100,0],
                               startTime=0)
      annotation (Placement(transformation(extent={{-168,-70},{-154,-56}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-176,76},{-154,98}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-144,-68},{-134,-58}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-44},{-146,-24}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
          18000,1],                                             startTime=0)
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
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,-21},
            {90.35,-20},{94.8,-20}},      color={0,0,127}));
    connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
            -65.4}},      color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,-57},
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
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-99},{120,-99},{120,58},{110.6,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

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
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol_4_element_all_modes;

  model Control_System_Therminol_4_element_summer_day
    "TEDS loop controller consistent with M3 milestone controllers. (Values sized for typical summer day demand with 12.5% peaking)"

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
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,122},{84,136}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{66,108},{74,116}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,52},{110,64}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,10},{108,22}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
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
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,100;
          3600,96.16; 7200,93.5; 10800,90.25; 14400,88.91; 18000,90.2; 21600,97.4;
          25200,102; 28800,103; 32400,104; 36000,106.5; 39600,107.2; 43200,109.1;
          46800,109.8; 50400,110.5; 54000,111.16; 57600,112.5; 61200,111.8; 64800,
          110.5; 68400,109.8; 72000,107.9; 75600,107.5; 79200,102; 82800,99.4;
          86400,99.2; 90000,96.1; 93600,96.1],
                               startTime=0)
      annotation (Placement(transformation(extent={{-168,-70},{-154,-56}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-176,76},{-154,98}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-144,-68},{-134,-58}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-44},{-146,-24}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,1; 12000,1; 14400,1;
          18000,1],                                             startTime=0)
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
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,-21},
            {90.35,-20},{94.8,-20}},      color={0,0,127}));
    connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
            -65.4}},      color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,-57},
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
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-99},{120,-99},{120,58},{110.6,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

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
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol_4_element_summer_day;

  model Control_System_Therminol_4_element_summer_day_real
    "Summer Day controller for TEDS loop with M3 milestone (Unused 3-element controls removed.)"

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
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,122},{84,136}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{66,108},{74,116}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,52},{110,64}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,10},{108,22}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
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
    Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
          BOP_total_demand.y, Heater_Total_Demand.y))
      annotation (Placement(transformation(extent={{-122,-96},{-100,-74}})));
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,0;
          3600,0; 7200,0; 10800,0; 14400,0; 18000,90.2; 21600,97.4; 25200,102;
          28800,103; 32400,104; 36000,106.5; 39600,107.2; 43200,109.1; 46800,
          109.8; 50400,110.5; 54000,111.16; 57600,112.5; 61200,111.8; 64800,
          110.5; 68400,109.8; 72000,107.9; 75600,107.5; 79200,102; 82800,99.4;
          86400,99.2; 90000,96.1; 93600,96.1],
                               startTime=0)
      annotation (Placement(transformation(extent={{-168,-70},{-154,-56}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-176,76},{-154,98}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-144,-68},{-134,-58}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-44},{-146,-24}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,1; 12000,1; 14400,1;
          18000,1],                                             startTime=0)
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
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,-21},
            {90.35,-20},{94.8,-20}},      color={0,0,127}));
    connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
            -65.4}},      color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,-57},
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
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-99},{120,-99},{120,58},{110.6,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

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
    connect(Mass_Pass_through1.y, Chromolox_Heater_Control1.u_s) annotation (Line(
          points={{15,35.5},{15,18.75},{10,18.75},{10,3.2}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol_4_element_summer_day_real;

  model Control_System_Therminol_4_element_summer_day_real_100F
    "Summer Day controller for TEDS loop with M3 milestone (Unused 3-element controls removed.)"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);
    BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-54,-118},{-6,-72}})));
    BaseClasses.SignalSubBus_SensorOutput sensorSubBus
      annotation (Placement(transformation(extent={{16,-122},{64,-76}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,52},{110,64}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,10},{108,22}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
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
  SI.VolumeFlowRate v_TES_demand = 0.0008832623;
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
      annotation (Placement(transformation(extent={{-170,-10},{-146,12}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-22},{-146,-2}})));
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
    TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-36},{-146,-16}})));
    Modelica.Blocks.Sources.Pulse Heater_Load(
      amplitude=0,
      width=50,
      period(displayUnit="h") = 7200,
      offset=200e3)
                annotation (Placement(transformation(extent={{-94,84},{-80,98}})));
    Modelica.Blocks.Sources.Constant const6(k=0)
      annotation (Placement(transformation(extent={{-14,2},{-6,10}})));
    Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
          BOP_total_demand.y, Heater_Total_Demand.y))
      annotation (Placement(transformation(extent={{-122,-96},{-100,-74}})));
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,0;
          3600,0; 7200,0; 10800,0; 14400,0; 18000,100; 21600,100; 25200,100;
          28800,100; 32400,100; 36000,100; 39600,100; 43200,100; 46800,100;
          50400,100; 54000,100; 57600,100; 61200,100; 64800,110.5; 68400,109.8;
          72000,107.9; 75600,107.5; 79200,102; 82800,99.4; 86400,99.2; 90000,
          96.1; 93600,96.1],   startTime=0)
      annotation (Placement(transformation(extent={{-168,-70},{-154,-56}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-176,74},{-154,96}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-144,-68},{-134,-58}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-52},{-146,-32}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,1; 12000,1; 14400,1;
          18000,0; 21600,0; 25200,0; 28800,0; 32400,0; 36000,0; 39600,0; 43200,
          0; 46800,0; 50400,0; 54000,0; 57600,0; 61200,0],      startTime=0)
      annotation (Placement(transformation(extent={{-168,-88},{-154,-74}})));
    Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
      annotation (Placement(transformation(extent={{-144,-88},{-134,-78}})));
    TRANSFORM.Blocks.RealExpression Volume_flow_rate "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,4},{-146,26}})));
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

  m_tes_demand :=Q_TES_demanded/(Cp*(100));

  m_heater_demand :=Heater_Load.y/(Cp*(100));

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
    Error1 :=(abs(v_TES_demand)- Volume_flow_rate.y)/v_TES_demand;
    //Error1 :=(abs(m_tes_demand) - Charge_mass_flow_sensor.y)/m_tes_max;
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
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,-21},
            {90.35,-20},{94.8,-20}},      color={0,0,127}));
    connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
            -65.4}},      color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,-57},
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
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-99},{120,-99},{120,58},{110.6,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,1},{-172.4,1}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
      annotation (Line(
        points={{-30,-95},{-148,-95},{-148,-100},{-180,-100},{-180,-12},{-172.4,-12}},
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
    connect(actuatorSubBus.Total_Mass_Flow_System, Mass_Pass_through.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,106},{-15,106},{-15,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Reference_total_mass_flow.y, Subtract1.u1) annotation (Line(points={{9,
            82.9},{9,78.45},{11.2,78.45},{11.2,73.4}}, color={0,0,127}));
    connect(Mass_Pass_through.y, Subtract1.u2) annotation (Line(points={{-15,87.5},
            {-4.5,87.5},{-4.5,73.4},{2.8,73.4}}, color={0,0,127}));
    connect(Subtract1.y, Mass_Pass_through1.u) annotation (Line(points={{7,57.3},{
            7,52.65},{15,52.65},{15,47}}, color={0,0,127}));
    connect(Chromolox_Heater_Control1.y, switch3.u1) annotation (Line(points={{10,
            -10.6},{10,-24},{10.4,-24},{10.4,-34.4}},
                                              color={0,0,127}));
    connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
       Line(
        points={{-30,-95},{-180,-95},{-180,-26},{-172.4,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Heater_Load.y, add.u2) annotation (Line(points={{-79.3,91},{-70,91},{-70,
            71.2},{-65.4,71.2}}, color={0,0,127}));
    connect(const6.y, Chromolox_Heater_Control1.u_m) annotation (Line(points={{
            -5.6,6},{-4,6},{-4,-4},{2.8,-4}}, color={0,0,127}));
    connect(BOP_relative_demand.y[1], BOP_total_demand.u) annotation (Line(points={{-153.3,
            -63},{-145,-63}},                                     color={0,0,127}));
    connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,-42},{-172.4,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Load_TES.y, switch1.u1) annotation (Line(points={{-152.9,85},{-138,
            85},{-138,80.4},{-127.6,80.4}},
                                        color={0,0,127}));
    connect(Load_TES.y, greaterEqual.u1) annotation (Line(points={{-152.9,85},{
            -150,85},{-150,74},{-176,74},{-176,61},{-171.4,61}},
                                                            color={0,0,127}));
    connect(Heater_Demand.y[1], Heater_Total_Demand.u) annotation (Line(points={{-153.3,
            -81},{-145,-81},{-145,-83}}, color={0,0,127}));
    connect(Mass_Pass_through1.y, Chromolox_Heater_Control1.u_s) annotation (Line(
          points={{15,35.5},{15,18.75},{10,18.75},{10,3.2}}, color={0,0,127}));
    connect(actuatorSubBus.Volume_flow_rate, Volume_flow_rate.u) annotation (Line(
        points={{-30,-95},{-180,-95},{-180,15},{-172.4,15}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol_4_element_summer_day_real_100F;

  model Control_System_Therminol_4_element_summer_day_real_70F
    "Summer Day controller for TEDS loop with M3 milestone (Unused 3-element controls removed.)"

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
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1,
      yMin=0.0)
      annotation (Placement(transformation(extent={{70,122},{84,136}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{66,108},{74,116}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,52},{110,64}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,10},{108,22}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
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
    Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
          BOP_total_demand.y, Heater_Total_Demand.y))
      annotation (Placement(transformation(extent={{-122,-96},{-100,-74}})));
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,110;
          3600,110; 7200,110; 10800,110; 14400,110; 18000,110; 21600,110],
                               startTime=0)
      annotation (Placement(transformation(extent={{-168,-70},{-154,-56}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-176,76},{-154,98}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-144,-68},{-134,-58}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-44},{-146,-24}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,0; 1800,0;
          3600,0; 4800,0; 7200,0; 9000,0; 9600,0; 10800,0; 12000,0; 14400,00;
          18000,0; 21600,0],                                    startTime=0)
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
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,-21},
            {90.35,-20},{94.8,-20}},      color={0,0,127}));
    connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
            -65.4}},      color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,-57},
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
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-99},{120,-99},{120,58},{110.6,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

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
    connect(Mass_Pass_through1.y, Chromolox_Heater_Control1.u_s) annotation (Line(
          points={{15,35.5},{15,18.75},{10,18.75},{10,3.2}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol_4_element_summer_day_real_70F;

  model Control_System_Therminol_4_element_initial_exp
    "Initial experiment matching, charge to 200F then cooldown"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);
    BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-54,-118},{-6,-72}})));
    BaseClasses.SignalSubBus_SensorOutput sensorSubBus
      annotation (Placement(transformation(extent={{16,-122},{64,-76}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,52},{110,64}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,10},{108,22}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
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
  SI.VolumeFlowRate v_TES_demand = 0.0008832623;
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
      annotation (Placement(transformation(extent={{-170,-10},{-146,12}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-22},{-146,-2}})));
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
    TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-36},{-146,-16}})));
    Modelica.Blocks.Sources.Pulse Heater_Load(
      amplitude=0,
      width=50,
      period(displayUnit="h") = 7200,
      offset=200e3)
                annotation (Placement(transformation(extent={{-94,84},{-80,98}})));
    Modelica.Blocks.Sources.Constant const6(k=0)
      annotation (Placement(transformation(extent={{-14,2},{-6,10}})));
    Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
          BOP_total_demand.y, Heater_Total_Demand.y))
      annotation (Placement(transformation(extent={{-122,-96},{-100,-74}})));
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,0; 3600,
          0; 7200,0; 9000,100; 9600,100; 10800,100; 12000,100; 14400,100; 18000,100;
          32400,100; 36000,100; 39600,100; 43200,100; 46800,100; 50400,100; 54000,
          100; 57600,100; 61200,100; 64800,110.5; 68400,109.8; 72000,107.9; 75600,
          107.5; 79200,102; 82800,99.4; 86400,99.2; 90000,96.1; 93600,96.1],
                               startTime=0)
      annotation (Placement(transformation(extent={{-166,-68},{-152,-54}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-176,74},{-154,96}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-144,-68},{-134,-58}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-52},{-146,-32}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,1; 12000,1; 14400,1;
          18000,1; 61200,1],                                    startTime=0)
      annotation (Placement(transformation(extent={{-168,-88},{-154,-74}})));
    Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
      annotation (Placement(transformation(extent={{-144,-88},{-134,-78}})));
    TRANSFORM.Blocks.RealExpression Volume_flow_rate "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,4},{-146,26}})));
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

  m_tes_demand :=Q_TES_demanded/(Cp*(100));

  m_heater_demand :=Heater_Load.y/(Cp*(100));

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
    Error1 :=(abs(v_TES_demand)- Volume_flow_rate.y)/v_TES_demand;
    //Error1 :=(abs(m_tes_demand) - Charge_mass_flow_sensor.y)/m_tes_max;
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
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,-21},
            {90.35,-20},{94.8,-20}},      color={0,0,127}));
    connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
            -65.4}},      color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,-57},
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
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-99},{120,-99},{120,58},{110.6,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,1},{-172.4,1}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
      annotation (Line(
        points={{-30,-95},{-148,-95},{-148,-100},{-180,-100},{-180,-12},{-172.4,-12}},
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
    connect(actuatorSubBus.Total_Mass_Flow_System, Mass_Pass_through.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,106},{-15,106},{-15,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Reference_total_mass_flow.y, Subtract1.u1) annotation (Line(points={{9,
            82.9},{9,78.45},{11.2,78.45},{11.2,73.4}}, color={0,0,127}));
    connect(Mass_Pass_through.y, Subtract1.u2) annotation (Line(points={{-15,87.5},
            {-4.5,87.5},{-4.5,73.4},{2.8,73.4}}, color={0,0,127}));
    connect(Subtract1.y, Mass_Pass_through1.u) annotation (Line(points={{7,57.3},{
            7,52.65},{15,52.65},{15,47}}, color={0,0,127}));
    connect(Chromolox_Heater_Control1.y, switch3.u1) annotation (Line(points={{10,
            -10.6},{10,-24},{10.4,-24},{10.4,-34.4}},
                                              color={0,0,127}));
    connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
       Line(
        points={{-30,-95},{-180,-95},{-180,-26},{-172.4,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Heater_Load.y, add.u2) annotation (Line(points={{-79.3,91},{-70,91},{-70,
            71.2},{-65.4,71.2}}, color={0,0,127}));
    connect(const6.y, Chromolox_Heater_Control1.u_m) annotation (Line(points={{
            -5.6,6},{-4,6},{-4,-4},{2.8,-4}}, color={0,0,127}));
    connect(BOP_relative_demand.y[1], BOP_total_demand.u) annotation (Line(points={{-151.3,
            -61},{-150,-61},{-150,-63},{-145,-63}},               color={0,0,127}));
    connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,-42},{-172.4,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Load_TES.y, switch1.u1) annotation (Line(points={{-152.9,85},{-138,
            85},{-138,80.4},{-127.6,80.4}},
                                        color={0,0,127}));
    connect(Load_TES.y, greaterEqual.u1) annotation (Line(points={{-152.9,85},{
            -150,85},{-150,74},{-176,74},{-176,61},{-171.4,61}},
                                                            color={0,0,127}));
    connect(Heater_Demand.y[1], Heater_Total_Demand.u) annotation (Line(points={{-153.3,
            -81},{-145,-81},{-145,-83}}, color={0,0,127}));
    connect(Mass_Pass_through1.y, Chromolox_Heater_Control1.u_s) annotation (Line(
          points={{15,35.5},{15,18.75},{10,18.75},{10,3.2}}, color={0,0,127}));
    connect(actuatorSubBus.Volume_flow_rate, Volume_flow_rate.u) annotation (Line(
        points={{-30,-95},{-180,-95},{-180,15},{-172.4,15}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol_4_element_initial_exp;

  model Control_System_Therminol_4_element_initial_exp_discharge
    "Initial experiment matching, charge to 200F then cooldown"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);
    BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-54,-118},{-6,-72}})));
    BaseClasses.SignalSubBus_SensorOutput sensorSubBus
      annotation (Placement(transformation(extent={{16,-122},{64,-76}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,52},{110,64}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,10},{108,22}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
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
  SI.VolumeFlowRate v_TES_demand = 0.0008832623;
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
      annotation (Placement(transformation(extent={{-170,-10},{-146,12}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-22},{-146,-2}})));
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
    TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-36},{-146,-16}})));
    Modelica.Blocks.Sources.Pulse Heater_Load(
      amplitude=0,
      width=50,
      period(displayUnit="h") = 7200,
      offset=200e3)
                annotation (Placement(transformation(extent={{-94,84},{-80,98}})));
    Modelica.Blocks.Sources.Constant const6(k=0)
      annotation (Placement(transformation(extent={{-14,2},{-6,10}})));
    Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
          BOP_total_demand.y, Heater_Total_Demand.y))
      annotation (Placement(transformation(extent={{-122,-96},{-100,-74}})));
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,0;
          3600,0; 7200,0; 9000,150; 9600,150; 10800,150; 12000,150; 14400,150;
          18000,150; 32400,150; 36000,150; 39600,150; 43200,110; 46800,110;
          50400,110; 54000,110; 57600,110; 61200,110; 64800,110; 68400,110;
          72000,110; 75600,110; 79200,110; 82800,110; 86400,110; 90000,110;
          93600,110],          startTime=0)
      annotation (Placement(transformation(extent={{-168,-68},{-154,-54}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-176,74},{-154,96}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-144,-68},{-134,-58}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-52},{-146,-32}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
          3600,1; 4800,1; 7200,1; 9000,0; 9600,0; 10800,0; 12000,0; 14400,0;
          18000,0; 61200,0],                                    startTime=0)
      annotation (Placement(transformation(extent={{-168,-88},{-154,-74}})));
    Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
      annotation (Placement(transformation(extent={{-144,-88},{-134,-78}})));
    TRANSFORM.Blocks.RealExpression Volume_flow_rate "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,4},{-146,26}})));
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

  m_tes_demand :=Q_TES_demanded/(Cp*(100));

  m_heater_demand :=Heater_Load.y/(Cp*(100));

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
    Error1 :=(abs(v_TES_demand)- Volume_flow_rate.y)/v_TES_demand;
    //Error1 :=(abs(m_tes_demand) - Charge_mass_flow_sensor.y)/m_tes_max;
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
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,-21},
            {90.35,-20},{94.8,-20}},      color={0,0,127}));
    connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
            -65.4}},      color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,-57},
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
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-99},{120,-99},{120,58},{110.6,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,1},{-172.4,1}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
      annotation (Line(
        points={{-30,-95},{-148,-95},{-148,-100},{-180,-100},{-180,-12},{-172.4,-12}},
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
    connect(actuatorSubBus.Total_Mass_Flow_System, Mass_Pass_through.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,106},{-15,106},{-15,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Reference_total_mass_flow.y, Subtract1.u1) annotation (Line(points={{9,
            82.9},{9,78.45},{11.2,78.45},{11.2,73.4}}, color={0,0,127}));
    connect(Mass_Pass_through.y, Subtract1.u2) annotation (Line(points={{-15,87.5},
            {-4.5,87.5},{-4.5,73.4},{2.8,73.4}}, color={0,0,127}));
    connect(Subtract1.y, Mass_Pass_through1.u) annotation (Line(points={{7,57.3},{
            7,52.65},{15,52.65},{15,47}}, color={0,0,127}));
    connect(Chromolox_Heater_Control1.y, switch3.u1) annotation (Line(points={{10,
            -10.6},{10,-24},{10.4,-24},{10.4,-34.4}},
                                              color={0,0,127}));
    connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
       Line(
        points={{-30,-95},{-180,-95},{-180,-26},{-172.4,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Heater_Load.y, add.u2) annotation (Line(points={{-79.3,91},{-70,91},{-70,
            71.2},{-65.4,71.2}}, color={0,0,127}));
    connect(const6.y, Chromolox_Heater_Control1.u_m) annotation (Line(points={{
            -5.6,6},{-4,6},{-4,-4},{2.8,-4}}, color={0,0,127}));
    connect(BOP_relative_demand.y[1], BOP_total_demand.u) annotation (Line(points={{-153.3,
            -61},{-150,-61},{-150,-63},{-145,-63}},               color={0,0,127}));
    connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,-42},{-172.4,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Load_TES.y, switch1.u1) annotation (Line(points={{-152.9,85},{-138,
            85},{-138,80.4},{-127.6,80.4}},
                                        color={0,0,127}));
    connect(Load_TES.y, greaterEqual.u1) annotation (Line(points={{-152.9,85},{
            -150,85},{-150,74},{-176,74},{-176,61},{-171.4,61}},
                                                            color={0,0,127}));
    connect(Heater_Demand.y[1], Heater_Total_Demand.u) annotation (Line(points={{-153.3,
            -81},{-145,-81},{-145,-83}}, color={0,0,127}));
    connect(Mass_Pass_through1.y, Chromolox_Heater_Control1.u_s) annotation (Line(
          points={{15,35.5},{15,18.75},{10,18.75},{10,3.2}}, color={0,0,127}));
    connect(actuatorSubBus.Volume_flow_rate, Volume_flow_rate.u) annotation (Line(
        points={{-30,-95},{-180,-95},{-180,15},{-172.4,15}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol_4_element_initial_exp_discharge;

  model Control_System_Therminol_4_TEDS_com_charge
    "Initial experiment matching, charge to 200F then cooldown"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);
    BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-54,-118},{-6,-72}})));
    BaseClasses.SignalSubBus_SensorOutput sensorSubBus
      annotation (Placement(transformation(extent={{16,-122},{64,-76}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,52},{110,64}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,10},{108,22}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
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
  SI.VolumeFlowRate v_TES_demand = 0.0008832623;
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
      annotation (Placement(transformation(extent={{-170,-10},{-146,12}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-22},{-146,-2}})));
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
    TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-36},{-146,-16}})));
    Modelica.Blocks.Sources.Pulse Heater_Load(
      amplitude=0,
      width=50,
      period(displayUnit="h") = 7200,
      offset=200e3)
                annotation (Placement(transformation(extent={{-94,84},{-80,98}})));
    Modelica.Blocks.Sources.Constant const6(k=0)
      annotation (Placement(transformation(extent={{-14,2},{-6,10}})));
    Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
          BOP_total_demand.y, Heater_Total_Demand.y))
      annotation (Placement(transformation(extent={{-122,-96},{-100,-74}})));
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,0;
          3600,0; 7200,0; 10800,0; 11100,110; 14400,110; 18000,110],
                               startTime=0)
      annotation (Placement(transformation(extent={{-166,-68},{-152,-54}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-176,74},{-154,96}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-144,-68},{-134,-58}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-52},{-146,-32}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 3600,1;
          7200,1; 10800,1; 11100,0; 14400,0; 18000,0; 21600,0], startTime=0)
      annotation (Placement(transformation(extent={{-168,-88},{-154,-74}})));
    Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
      annotation (Placement(transformation(extent={{-144,-88},{-134,-78}})));
    TRANSFORM.Blocks.RealExpression Volume_flow_rate "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,4},{-146,26}})));
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

  m_tes_demand :=Q_TES_demanded/(Cp*(100));

  m_heater_demand :=Heater_Load.y/(Cp*(100));

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
    Error1 :=(abs(v_TES_demand)- Volume_flow_rate.y)/v_TES_demand;
    //Error1 :=(abs(m_tes_demand) - Charge_mass_flow_sensor.y)/m_tes_max;
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
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,-21},
            {90.35,-20},{94.8,-20}},      color={0,0,127}));
    connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
            -65.4}},      color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,-57},
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
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-99},{120,-99},{120,58},{110.6,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,1},{-172.4,1}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
      annotation (Line(
        points={{-30,-95},{-148,-95},{-148,-100},{-180,-100},{-180,-12},{-172.4,-12}},
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
    connect(actuatorSubBus.Total_Mass_Flow_System, Mass_Pass_through.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,106},{-15,106},{-15,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Reference_total_mass_flow.y, Subtract1.u1) annotation (Line(points={{9,
            82.9},{9,78.45},{11.2,78.45},{11.2,73.4}}, color={0,0,127}));
    connect(Mass_Pass_through.y, Subtract1.u2) annotation (Line(points={{-15,87.5},
            {-4.5,87.5},{-4.5,73.4},{2.8,73.4}}, color={0,0,127}));
    connect(Subtract1.y, Mass_Pass_through1.u) annotation (Line(points={{7,57.3},{
            7,52.65},{15,52.65},{15,47}}, color={0,0,127}));
    connect(Chromolox_Heater_Control1.y, switch3.u1) annotation (Line(points={{10,
            -10.6},{10,-24},{10.4,-24},{10.4,-34.4}},
                                              color={0,0,127}));
    connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
       Line(
        points={{-30,-95},{-180,-95},{-180,-26},{-172.4,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Heater_Load.y, add.u2) annotation (Line(points={{-79.3,91},{-70,91},{-70,
            71.2},{-65.4,71.2}}, color={0,0,127}));
    connect(const6.y, Chromolox_Heater_Control1.u_m) annotation (Line(points={{
            -5.6,6},{-4,6},{-4,-4},{2.8,-4}}, color={0,0,127}));
    connect(BOP_relative_demand.y[1], BOP_total_demand.u) annotation (Line(points={{-151.3,
            -61},{-150,-61},{-150,-63},{-145,-63}},               color={0,0,127}));
    connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,-42},{-172.4,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Load_TES.y, switch1.u1) annotation (Line(points={{-152.9,85},{-138,
            85},{-138,80.4},{-127.6,80.4}},
                                        color={0,0,127}));
    connect(Load_TES.y, greaterEqual.u1) annotation (Line(points={{-152.9,85},{
            -150,85},{-150,74},{-176,74},{-176,61},{-171.4,61}},
                                                            color={0,0,127}));
    connect(Heater_Demand.y[1], Heater_Total_Demand.u) annotation (Line(points={{-153.3,
            -81},{-145,-81},{-145,-83}}, color={0,0,127}));
    connect(Mass_Pass_through1.y, Chromolox_Heater_Control1.u_s) annotation (Line(
          points={{15,35.5},{15,18.75},{10,18.75},{10,3.2}}, color={0,0,127}));
    connect(actuatorSubBus.Volume_flow_rate, Volume_flow_rate.u) annotation (Line(
        points={{-30,-95},{-180,-95},{-180,15},{-172.4,15}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol_4_TEDS_com_charge;

  model Control_System_Therminol_4_TEDS_com_charge_300
    "Initial experiment matching, charge to 200F then cooldown"

    replaceable package Medium =
        TRANSFORM.Media.Fluids.DOWTHERM.LinearDOWTHERM_A_95C constrainedby
      TRANSFORM.Media.Interfaces.Fluids.PartialMedium "Fluid Medium" annotation (
        choicesAllMatching=true);
    BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
      annotation (Placement(transformation(extent={{-54,-118},{-6,-72}})));
    BaseClasses.SignalSubBus_SensorOutput sensorSubBus
      annotation (Placement(transformation(extent={{16,-122},{64,-76}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=5,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{98,52},{110,64}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=2,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0)
      annotation (Placement(transformation(extent={{96,10},{108,22}})));
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=2,
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
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=5,
      initType=Modelica.Blocks.Types.Init.NoInit,          y_start=1)
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
  SI.VolumeFlowRate v_TES_demand = 0.000788623;
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
      annotation (Placement(transformation(extent={{-170,-10},{-146,12}})));
    TRANSFORM.Blocks.RealExpression Charge_mass_flow_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-22},{-146,-2}})));
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
    TRANSFORM.Blocks.RealExpression Heater_flowrate_sensor
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-36},{-146,-16}})));
    Modelica.Blocks.Sources.Pulse Heater_Load(
      amplitude=0,
      width=50,
      period(displayUnit="h") = 7200,
      offset=200e3)
                annotation (Placement(transformation(extent={{-94,84},{-80,98}})));
    Modelica.Blocks.Sources.Constant const6(k=0)
      annotation (Placement(transformation(extent={{-14,2},{-6,10}})));
    Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=min(
          BOP_total_demand.y, Heater_Total_Demand.y))
      annotation (Placement(transformation(extent={{-122,-96},{-100,-74}})));
    Modelica.Blocks.Sources.CombiTimeTable BOP_relative_demand(table=[0.0,0;
          3600,0; 7200,0; 10800,0; 11100,0; 14400,0; 18000,110],
                               startTime=0)
      annotation (Placement(transformation(extent={{-166,-68},{-152,-54}})));
    Modelica.Blocks.Sources.RealExpression Load_TES(y=if BOP_total_demand.y <
          Heater_Total_Demand.y then -1*(Heater_Total_Demand.y - BOP_total_demand.y)
           else BOP_total_demand.y - Heater_Total_Demand.y)
      annotation (Placement(transformation(extent={{-176,74},{-154,96}})));
    Modelica.Blocks.Math.Gain BOP_total_demand(k=Heater_max/100.)
      annotation (Placement(transformation(extent={{-144,-68},{-134,-58}})));
    TRANSFORM.Blocks.RealExpression Heater_BOP_mass_flow
      "Used in the Code section. "
      annotation (Placement(transformation(extent={{-170,-52},{-146,-32}})));
    Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 3600,1;
          7200,1; 10800,1; 11100,1; 14400,1; 18000,0; 21600,0], startTime=0)
      annotation (Placement(transformation(extent={{-168,-88},{-154,-74}})));
    Modelica.Blocks.Math.Gain Heater_Total_Demand(k=Heater_max)
      annotation (Placement(transformation(extent={{-144,-88},{-134,-78}})));
    TRANSFORM.Blocks.RealExpression Volume_flow_rate "Used in the Coded Section"
      annotation (Placement(transformation(extent={{-170,4},{-146,26}})));
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

  m_tes_demand :=Q_TES_demanded/(Cp*(100));

  m_heater_demand :=Heater_Load.y/(Cp*(100));

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
    Error1 :=(abs(v_TES_demand)- Volume_flow_rate.y)/v_TES_demand;
    //Error1 :=(abs(m_tes_demand) - Charge_mass_flow_sensor.y)/m_tes_max;
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
    connect(PIDV5.y,firstOrder4. u) annotation (Line(points={{76.7,-21},{90.35,-21},
            {90.35,-20},{94.8,-20}},      color={0,0,127}));
    connect(const5.y,PIDV6. u_m) annotation (Line(points={{66.4,-72},{69,-72},{69,
            -65.4}},      color={0,0,127}));
    connect(PIDV6.y,firstOrder5. u) annotation (Line(points={{76.7,-57},{90.35,-57},
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
    connect(sensorSubBus.Valve_3_Opening, firstOrder2.y) annotation (Line(
        points={{40,-99},{120,-99},{120,58},{110.6,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorSubBus.Discharge_FlowRate, Discharge_mass_flow_sensor.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,1},{-172.4,1}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorSubBus.Charging_flowrate, Charge_mass_flow_sensor.u)
      annotation (Line(
        points={{-30,-95},{-148,-95},{-148,-100},{-180,-100},{-180,-12},{-172.4,-12}},
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
    connect(actuatorSubBus.Total_Mass_Flow_System, Mass_Pass_through.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,106},{-15,106},{-15,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Reference_total_mass_flow.y, Subtract1.u1) annotation (Line(points={{9,
            82.9},{9,78.45},{11.2,78.45},{11.2,73.4}}, color={0,0,127}));
    connect(Mass_Pass_through.y, Subtract1.u2) annotation (Line(points={{-15,87.5},
            {-4.5,87.5},{-4.5,73.4},{2.8,73.4}}, color={0,0,127}));
    connect(Subtract1.y, Mass_Pass_through1.u) annotation (Line(points={{7,57.3},{
            7,52.65},{15,52.65},{15,47}}, color={0,0,127}));
    connect(Chromolox_Heater_Control1.y, switch3.u1) annotation (Line(points={{10,
            -10.6},{10,-24},{10.4,-24},{10.4,-34.4}},
                                              color={0,0,127}));
    connect(actuatorSubBus.Heater_flowrate, Heater_flowrate_sensor.u) annotation (
       Line(
        points={{-30,-95},{-180,-95},{-180,-26},{-172.4,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Heater_Load.y, add.u2) annotation (Line(points={{-79.3,91},{-70,91},{-70,
            71.2},{-65.4,71.2}}, color={0,0,127}));
    connect(const6.y, Chromolox_Heater_Control1.u_m) annotation (Line(points={{
            -5.6,6},{-4,6},{-4,-4},{2.8,-4}}, color={0,0,127}));
    connect(BOP_relative_demand.y[1], BOP_total_demand.u) annotation (Line(points={{-151.3,
            -61},{-150,-61},{-150,-63},{-145,-63}},               color={0,0,127}));
    connect(actuatorSubBus.heater_BOP_massflow, Heater_BOP_mass_flow.u)
      annotation (Line(
        points={{-30,-95},{-180,-95},{-180,-42},{-172.4,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Load_TES.y, switch1.u1) annotation (Line(points={{-152.9,85},{-138,
            85},{-138,80.4},{-127.6,80.4}},
                                        color={0,0,127}));
    connect(Load_TES.y, greaterEqual.u1) annotation (Line(points={{-152.9,85},{
            -150,85},{-150,74},{-176,74},{-176,61},{-171.4,61}},
                                                            color={0,0,127}));
    connect(Heater_Demand.y[1], Heater_Total_Demand.u) annotation (Line(points={{-153.3,
            -81},{-145,-81},{-145,-83}}, color={0,0,127}));
    connect(Mass_Pass_through1.y, Chromolox_Heater_Control1.u_s) annotation (Line(
          points={{15,35.5},{15,18.75},{10,18.75},{10,3.2}}, color={0,0,127}));
    connect(actuatorSubBus.Volume_flow_rate, Volume_flow_rate.u) annotation (Line(
        points={{-30,-95},{-180,-95},{-180,15},{-172.4,15}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
              {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-180,-100},{120,140}})));
  end Control_System_Therminol_4_TEDS_com_charge_300;
end Control_Systems;
