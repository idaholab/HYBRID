within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Controls;
model CS_Experimental_03_bypass

  extends BaseClasses.Partial_ControlSystem;
  parameter Real m_flow_rate_steam_trigger = 3.0;
  //This system has the option to run the valve governing the charging heat exchanger flow either by PI or by P-->Limited Derivative. It is recommended for uncertainty added systems to use the PI.

  Data.Data_Default data
    annotation (Placement(transformation(extent={{70,76},{90,96}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    Charging_Valve_Position_MinMax(min=1e-4)
    annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
  TRANSFORM.Controls.LimPID PID5(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=-1.75e-4,
    Ti=9000,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-48,-14},{-42,-8}})));
  Modelica.Blocks.Math.Add add2(k2=4.0)
    annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
  Modelica.Blocks.Sources.Constant one4(k=0.25)
    annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
  Modelica.Blocks.Sources.Constant one5(k=0.0)
    annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
  TRANSFORM.Controls.LimPID PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1.0,
    Ti=10,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=0.0,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-34,58},{-26,50}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid_only(
    amplitude=2*m_flow_rate_steam_trigger,
    rising=50,
    width=0.325*8950,
    falling=50,
    period=12000,
    offset=0.0,
    startTime=34200)
    annotation (Placement(transformation(extent={{-18,34},{-6,46}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    Discharging_Valve_Position(min=1e-4) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={12,64})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
  Modelica.Blocks.Math.Add add1(k2=4.0)
    annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
  Modelica.Blocks.Sources.Constant one3(k=0.0)
    annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
  Modelica.Blocks.Sources.Constant one2(k=0.25)
    annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
  Modelica.Blocks.Sources.Constant one1(k=273.15 + 410)
    annotation (Placement(transformation(extent={{-62,-14},{-56,-8}})));
  Modelica.Blocks.Math.Add add3(k1=0.0)
    annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-50,-4},{-46,0}})));
  Modelica.Blocks.Sources.Constant one6(k=0.0)
    annotation (Placement(transformation(extent={{-56,-6},{-54,-4}})));
  Modelica.Blocks.Sources.Constant one7(k=0.03)
    annotation (Placement(transformation(extent={{-56,0},{-54,2}})));
  TRANSFORM.Controls.LimPID PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2.5e-2,
    Ti=10,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
  TRANSFORM.Controls.LimPID PID_CHX_Byp(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-7.5e-4,
    Ti=60,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-28,-64},{-20,-56}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    CHX_Bypass(min=0.0)
    annotation (Placement(transformation(extent={{-6,-70},{14,-50}})));
  Modelica.Blocks.Sources.Constant one8(k=360 + 273.15)
    annotation (Placement(transformation(extent={{-44,-56},{-36,-64}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    DHX_Bypass1(min=0.0)
    annotation (Placement(transformation(extent={{2,88},{22,108}})));
  TRANSFORM.Controls.LimPID PID4(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=7.5e-4,
    Ti=60,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-16,102},{-10,96}})));
  Modelica.Blocks.Sources.Constant one9(k=180 + 273.15)
    annotation (Placement(transformation(extent={{-30,102},{-24,96}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0.25, uHigh=1.75)
    annotation (Placement(transformation(extent={{-84,14},{-64,34}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-48,14},{-28,34}})));
  Modelica.Blocks.Sources.Constant one10(k=m_flow_rate_steam_trigger)
    annotation (Placement(transformation(extent={{-122,28},{-116,34}})));
  Modelica.Blocks.Sources.Constant one11(k=0.0)
    annotation (Placement(transformation(extent={{-118,10},{-112,16}})));
  Modelica.Blocks.Math.Add add4(k2=-1)
    annotation (Placement(transformation(extent={{-128,4},{-122,10}})));
  Modelica.Blocks.Sources.Constant one12(k=2.0)
    annotation (Placement(transformation(extent={{-142,8},{-136,14}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=m_flow_rate_steam_trigger*0.2,
    f=1/3600,
    offset=m_flow_rate_steam_trigger*0.25,
    startTime=34200)
    annotation (Placement(transformation(extent={{-140,58},{-130,68}})));
  Modelica.Blocks.Math.Add3 add3_1(k1=0.0,
                                   k3=0.0)
    annotation (Placement(transformation(extent={{-180,-44},{-160,-24}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid_with_sine(
    amplitude=0.55*m_flow_rate_steam_trigger,
    rising=50,
    width=5950,
    falling=50,
    period=12000,
    offset=0.0,
    startTime=34200)
    annotation (Placement(transformation(extent={{-218,-44},{-206,-32}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-164,26},{-144,46}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=m_flow_rate_steam_trigger*0.25,
    duration=4000,
    offset=-m_flow_rate_steam_trigger*0.25,
    startTime=29000)
    annotation (Placement(transformation(extent={{-176,70},{-166,80}})));
  Modelica.Blocks.Noise.NormalNoise normalNoise(
    samplePeriod=1800,
    mu=m_flow_rate_steam_trigger*0.49,
    sigma=m_flow_rate_steam_trigger*0.18)
    annotation (Placement(transformation(extent={{-158,104},{-138,124}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-82,114},{-62,134}})));
  Modelica.Blocks.Sources.Constant one13(k=0.001)
    annotation (Placement(transformation(extent={{-124,98},{-118,104}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=32400)
    annotation (Placement(transformation(extent={{-190,96},{-170,116}})));
  Modelica.Blocks.Sources.RealExpression
                                   one14(y=time)
    annotation (Placement(transformation(extent={{-214,68},{-208,74}})));
  TRANSFORM.Controls.LimPID PID5_perfect(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-7.5e-3,
    Ti=30,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-84,-14},{-78,-8}})));
  TRANSFORM.Blocks.IntegratorWithReset
                             I(
    k=1,
    y_start=0.1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    reset=TRANSFORM.Types.Reset.Disabled,
    y_reset=0.0)
    annotation (Placement(transformation(extent={{-34,-24},{-26,-16}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-30,-34},{-24,-28}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-58,-34},{-50,-26}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=1e-3)
    annotation (Placement(transformation(extent={{-44,-34},{-36,-26}})));
  Modelica.Blocks.Sources.Constant one15(k=0.0)
    annotation (Placement(transformation(extent={{-60,-48},{-54,-42}})));
equation

  connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
          -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
  connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
          -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
  connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
          -24.8},{-56.6,-24.8}},                                       color={0,
          0,127}));
  connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
          -30.4},{-80.8,-30.4}},   color={0,0,127}));
  connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
          -61.7,-21}},color={0,0,127}));
  connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
    annotation (Line(
      points={{30,-100},{30,-22},{23.4,-22}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-25.6},{-80.8,-25.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(product1.y, Discharging_Valve_Position.u)
    annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
  connect(PID3.y,product1. u2) annotation (Line(points={{-25.6,54},{-20.8,54},{
          -20.8,61.6}},                                      color={0,0,127}));
  connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
          -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
  connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
          74.8},{-36.6,74.8}},                                    color={0,0,
          127}));
  connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
          -36.6,71.2}},                                      color={0,0,127}));
  connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,64},
          {-56.8,64},{-56.8,63.6}},
                                 color={0,0,127}));
  connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
    annotation (Line(
      points={{30,-100},{30,64},{23.4,64}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,68.4},{-56.8,68.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(one1.y, PID5.u_s) annotation (Line(points={{-55.7,-11},{-48.6,-11}},
                      color={0,0,127}));
  connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
          -19.2},{-22,-11},{-23.7,-11}},
                                color={0,0,127}));
  connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-0.4},{-50.4,1},{
          -53.9,1}},            color={0,0,127}));
  connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-3.6},{-50.4,-5},
          {-53.9,-5}}, color={0,0,127}));
  connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-2},{-45.8,-3},{
          -40.6,-3}}, color={0,0,127}));
  connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
          -33.7,-3}}, color={0,0,127}));
  connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,6},{-37,6},{-37,0.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-2},{-50.4,-2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Discharge_Steam, PID3.u_m) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,48},{-44,48},{-44,62},{-30,62},{-30,
          58.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Charging_HTF_Temp, PID5.u_m) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-18},{-45,-18},{-45,-14.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Charge_Temp, PID_CHX_Byp.u_m) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-72},{-24,-72},{-24,-64.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(CHX_Bypass.u, PID_CHX_Byp.y)
    annotation (Line(points={{-8,-60},{-19.6,-60}}, color={0,0,127}));
  connect(actuatorBus.hot_tank_bypass_position, CHX_Bypass.y) annotation (Line(
      points={{30,-100},{30,-60},{15.4,-60}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(one8.y, PID_CHX_Byp.u_s)
    annotation (Line(points={{-35.6,-60},{-28.8,-60}}, color={0,0,127}));
  connect(DHX_Bypass1.u, PID4.y)
    annotation (Line(points={{0,98},{0,99},{-9.7,99}}, color={0,0,127}));
  connect(one9.y,PID4. u_s)
    annotation (Line(points={{-23.7,99},{-16.6,99}},   color={0,0,127}));
  connect(sensorBus.cold_tank_inlet_temp, PID4.u_m) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,106},{-100,106},{-100,108},{-13,108},
          {-13,102.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.cold_tank_bypass_position, DHX_Bypass1.y) annotation (
      Line(
      points={{30,-100},{30,98},{23.4,98}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(switch2.u2, hysteresis.y)
    annotation (Line(points={{-50,24},{-63,24}}, color={255,0,255}));
  connect(one11.y, switch2.u3) annotation (Line(points={{-111.7,13},{-96,13},{
          -96,10},{-60,10},{-60,16},{-50,16}}, color={0,0,127}));
  connect(one10.y, switch2.u1) annotation (Line(points={{-115.7,31},{-96,31},{
          -96,38},{-60,38},{-60,32},{-50,32}}, color={0,0,127}));
  connect(sensorBus.hot_tank_level, add4.u2) annotation (Line(
      points={{-30,-100},{-136,-100},{-136,5.2},{-128.6,5.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(one12.y, add4.u1) annotation (Line(points={{-135.7,11},{-135.7,8.8},{
          -128.6,8.8}}, color={0,0,127}));
  connect(sensorBus.hot_tank_level, hysteresis.u) annotation (Line(
      points={{-30,-100},{-136,-100},{-136,-4},{-102,-4},{-102,24},{-86,24}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(switch2.y, add3_1.u2) annotation (Line(points={{-27,24},{-10,24},{-10,
          -14},{-8,-14},{-8,-36},{-154,-36},{-154,-48},{-182,-48},{-182,-34}},
        color={0,0,127}));
  connect(trapezoid_with_sine.y, add3_1.u3) annotation (Line(points={{-205.4,-38},
          {-192,-38},{-192,-42},{-182,-42}},                         color={0,0,
          127}));
  connect(sine.y, add.u1) annotation (Line(points={{-129.5,63},{-118,63},{-118,52},
          {-176,52},{-176,42},{-166,42}}, color={0,0,127}));
  connect(ramp.y, add.u2) annotation (Line(points={{-165.5,75},{-158,75},{-158,62},
          {-192,62},{-192,30},{-166,30}}, color={0,0,127}));
  connect(add3_1.u1, add.y) annotation (Line(points={{-182,-26},{-196,-26},{-196,
          24},{-130,24},{-130,36},{-143,36}}, color={0,0,127}));
  connect(normalNoise.y, switch3.u1) annotation (Line(points={{-137,114},{-94,114},
          {-94,132},{-84,132}}, color={0,0,127}));
  connect(one13.y, switch3.u3) annotation (Line(points={{-117.7,101},{-104,101},
          {-104,112},{-92,112},{-92,116},{-84,116}}, color={0,0,127}));
  connect(one14.y, greaterThreshold.u) annotation (Line(points={{-207.7,71},{-202,
          71},{-202,106},{-192,106}}, color={0,0,127}));
  connect(greaterThreshold.y, switch3.u2) annotation (Line(points={{-169,106},{-164,
          106},{-164,128},{-92,128},{-92,124},{-84,124}}, color={255,0,255}));
  connect(one1.y, PID5_perfect.u_s) annotation (Line(points={{-55.7,-11},{-55.7,
          -12},{-54,-12},{-54,-16},{-66,-16},{-66,-4},{-88,-4},{-88,-11},{-84.6,
          -11}}, color={0,0,127}));
  connect(sensorBus.Charging_HTF_Temp, PID5_perfect.u_m) annotation (Line(
      points={{-30,-100},{-66,-100},{-66,-102},{-102,-102},{-102,-20},{-81,-20},
          {-81,-14.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(one15.y, switch4.u3) annotation (Line(points={{-53.7,-45},{-53.7,-46},
          {-30.6,-46},{-30.6,-33.4}},
                                   color={0,0,127}));
  connect(switch4.u2, greaterThreshold1.y)
    annotation (Line(points={{-30.6,-31},{-30.6,-30},{-35.6,-30}},
                                                 color={255,0,255}));
  connect(I.u, switch4.y) annotation (Line(points={{-34.8,-20},{-46,-20},{-46,-38},
          {-20,-38},{-20,-31},{-23.7,-31}},
                                   color={0,0,127}));
  connect(abs1.y, greaterThreshold1.u) annotation (Line(points={{-49.6,-30},{-44.8,
          -30}},                                              color={0,0,127}));
  connect(PID5.y, abs1.u) annotation (Line(points={{-41.7,-11},{-41.7,-12},{-38,
          -12},{-38,-40},{-62,-40},{-62,-30},{-58.8,-30}},
                                      color={0,0,127}));
  connect(PID5.y, switch4.u1) annotation (Line(points={{-41.7,-11},{-41.7,-12},{
          -38,-12},{-38,-40},{-30.6,-40},{-30.6,-28.6}},
                                                     color={0,0,127}));
  connect(add3_1.y, PID3.u_s) annotation (Line(points={{-159,-34},{-146,-34},{-146,
          22},{-100,22},{-100,46},{-38,46},{-38,54},{-34.8,54}}, color={0,0,127}));
  connect(I.y, add3.u2) annotation (Line(points={{-25.6,-20},{-30.6,-20},{-30.6,
          -12.8}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_Experimental_03_bypass;
