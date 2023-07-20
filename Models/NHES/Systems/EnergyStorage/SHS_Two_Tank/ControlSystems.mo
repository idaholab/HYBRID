within NHES.Systems.EnergyStorage.SHS_Two_Tank;
package ControlSystems
  model CS_Default

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-96,86},{-76,106}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=25,
      rising=500,
      width=2600,
      falling=500,
      period=10800,
      offset=0.0,
      startTime=7200)
      annotation (Placement(transformation(extent={{-54,-56},{-42,-44}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      amplitude=25,
      rising=500,
      width=2600,
      falling=500,
      period=10800,
      offset=0.0,
      startTime=1800)
      annotation (Placement(transformation(extent={{-38,34},{-24,48}})));
    Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
      annotation (Placement(transformation(extent={{-16,-62},{-4,-50}})));
    Modelica.Blocks.Sources.Constant cold_tank_level_max(k=data.cold_tank_level_max)
      annotation (Placement(transformation(extent={{-92,6},{-84,14}})));
    Modelica.Blocks.Sources.Constant hot_tank_max_level(k=data.hot_tank_level_max)
      annotation (Placement(transformation(extent={{-96,-34},{-88,-26}})));
    Modelica.Blocks.Sources.Constant zero(k=0)
      annotation (Placement(transformation(extent={{-54,-26},{-48,-20}})));
    Modelica.Blocks.Sources.Constant one(k=1)
      annotation (Placement(transformation(extent={{-80,-22},{-72,-14}})));
    Modelica.Blocks.Math.MultiProduct multiProduct1(nu=3)
      annotation (Placement(transformation(extent={{-14,2},{-2,14}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-62,-34},{-54,-26}})));
    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{-80,-36},{-72,-28}})));
    Modelica.Blocks.Math.Max max1
      annotation (Placement(transformation(extent={{-36,-28},{-30,-22}})));
    Modelica.Blocks.Math.Max max2
      annotation (Placement(transformation(extent={{-56,24},{-48,32}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-72,22},{-66,28}})));
    Modelica.Blocks.Sources.Constant zero1(k=0)
      annotation (Placement(transformation(extent={{-78,32},{-70,40}})));
    Modelica.Blocks.Sources.Constant one1(k=1)
      annotation (Placement(transformation(extent={{-92,24},{-86,30}})));
    Modelica.Blocks.Math.Max max3
      annotation (Placement(transformation(extent={{-30,4},{-24,10}})));
    Modelica.Blocks.Sources.Constant zero2(k=0)
      annotation (Placement(transformation(extent={{-48,6},{-42,12}})));
    Modelica.Blocks.Math.Min min3
      annotation (Placement(transformation(extent={{-56,-2},{-48,6}})));
    Modelica.Blocks.Math.Add add1(k2=-1)
      annotation (Placement(transformation(extent={{-74,-4},{-66,4}})));
    Modelica.Blocks.Sources.Constant one2(k=1)
      annotation (Placement(transformation(extent={{-74,10},{-66,18}})));
    Modelica.Blocks.Math.Min min4
      annotation (Placement(transformation(extent={{-64,-78},{-58,-72}})));
    Modelica.Blocks.Math.Max max4
      annotation (Placement(transformation(extent={{-48,-72},{-40,-64}})));
    Modelica.Blocks.Sources.Constant zero3(k=0)
      annotation (Placement(transformation(extent={{-70,-68},{-62,-60}})));
    Modelica.Blocks.Sources.Constant one3(k=1)
      annotation (Placement(transformation(extent={{-84,-76},{-78,-70}})));
  equation

    connect(add.u1, hot_tank_max_level.y) annotation (Line(points={{-80.8,-29.6},
            {-80,-29.6},{-80,-30},{-87.6,-30}}, color={0,0,127}));
    connect(sensorBus.hot_tank_level, add.u2) annotation (Line(
        points={{-30,-100},{-86,-100},{-86,-34.4},{-80.8,-34.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(min1.u2, add.y)
      annotation (Line(points={{-62.8,-32.4},{-71.6,-32}}, color={0,0,127}));
    connect(one.y, min1.u1) annotation (Line(points={{-71.6,-18},{-62.8,-18},{
            -62.8,-27.6}}, color={0,0,127}));
    connect(max1.u2, min1.y) annotation (Line(points={{-36.6,-26.8},{-48,-26.8},{
            -48,-30},{-53.6,-30}}, color={0,0,127}));
    connect(zero.y, max1.u1) annotation (Line(points={{-47.7,-23},{-47.7,-23.2},{
            -36.6,-23.2}}, color={0,0,127}));
    connect(zero1.y, max2.u1) annotation (Line(points={{-69.6,36},{-56.8,36},{
            -56.8,30.4}}, color={0,0,127}));
    connect(one1.y, min2.u1) annotation (Line(points={{-85.7,27},{-85.7,26.8},{
            -72.6,26.8}}, color={0,0,127}));
    connect(sensorBus.hot_tank_level, min2.u2) annotation (Line(
        points={{-30,-100},{-86,-100},{-86,-38},{-102,-38},{-102,18},{-78,18},{
            -78,23.2},{-72.6,23.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(trapezoid.y, multiProduct.u[1]) annotation (Line(points={{-41.4,-50},
            {-22,-50},{-22,-53.2},{-16,-53.2}},
                                            color={0,0,127}));
    connect(max1.y, multiProduct.u[2]) annotation (Line(points={{-29.7,-25},{-22,
            -25},{-22,-56},{-16,-56}}, color={0,0,127}));
    connect(actuatorBus.m_flow_charge, multiProduct.y) annotation (Line(
        points={{30,-100},{28,-100},{28,-56},{-2.98,-56}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(min2.y, max2.u2) annotation (Line(points={{-65.7,25},{-62,25},{-62,
            25.6},{-56.8,25.6}}, color={0,0,127}));
    connect(max3.u2, min3.y) annotation (Line(points={{-30.6,5.2},{-42,5.2},{-42,
            2},{-47.6,2}}, color={0,0,127}));
    connect(zero2.y, max3.u1) annotation (Line(points={{-41.7,9},{-41.7,8.8},{
            -30.6,8.8}}, color={0,0,127}));
    connect(min3.u2, add1.y)
      annotation (Line(points={{-56.8,-0.4},{-65.6,0}}, color={0,0,127}));
    connect(one2.y, min3.u1) annotation (Line(points={{-65.6,14},{-60,14},{-60,
            4.4},{-56.8,4.4}}, color={0,0,127}));
    connect(add1.u1, cold_tank_level_max.y) annotation (Line(points={{-74.8,2.4},
            {-80,2.4},{-80,10},{-83.6,10}}, color={0,0,127}));
    connect(sensorBus.cold_tank_level, add1.u2) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,-8},{-74.8,-8},{-74.8,-2.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(trapezoid1.y, multiProduct1.u[1]) annotation (Line(points={{-23.3,41},
            {-16,41},{-16,10.8},{-14,10.8}}, color={0,0,127}));
    connect(min4.y, max4.u2) annotation (Line(points={{-57.7,-75},{-50,-75},{-50,
            -70.4},{-48.8,-70.4}}, color={0,0,127}));
    connect(zero3.y, max4.u1) annotation (Line(points={{-61.6,-64},{-48.8,-64},{
            -48.8,-65.6}}, color={0,0,127}));
    connect(one3.y, min4.u1) annotation (Line(points={{-77.7,-73},{-77.7,-73.2},{
            -64.6,-73.2}}, color={0,0,127}));
    connect(max3.y, multiProduct1.u[2])
      annotation (Line(points={{-23.7,7},{-14,8}}, color={0,0,127}));
    connect(sensorBus.cold_tank_level, min4.u2) annotation (Line(
        points={{-30,-100},{-66,-100},{-66,-76.8},{-64.6,-76.8}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.m_flow_discharge, multiProduct1.y) annotation (Line(
        points={{30,-100},{28,-100},{28,8},{-0.98,8}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(max2.y, multiProduct1.u[3]) annotation (Line(points={{-47.6,28},{-40,
            28},{-40,26},{-34,26},{-34,5.2},{-14,5.2}}, color={0,0,127}));
    connect(max4.y, multiProduct.u[3]) annotation (Line(points={{-39.6,-68},{-22,
            -68},{-22,-58.8},{-16,-58.8}},
                                       color={0,0,127}));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Default;

  model CS_Boiler

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-3,
      Ti=15,
      yMax=1.0,
      yMin=0.0) annotation (Placement(transformation(extent={{-2,-56},{18,-36}})));
    Modelica.Blocks.Sources.Constant const1(k=5e5)
      annotation (Placement(transformation(extent={{-48,-56},{-28,-36}})));
    Modelica.Blocks.Sources.Constant const(k=10)
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-2,
      Ti=10,
      yMin=-0.25)
                annotation (Placement(transformation(extent={{-22,-20},{-2,0}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-4)
      annotation (Placement(transformation(extent={{2,6},{22,26}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,20},{-12,14}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-4,
      Ti=10,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,26},{-38,20}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      amplitude=20,
      rising=500,
      width=8500,
      falling=500,
      period=18000,
      offset=0,
      startTime=9000)
      annotation (Placement(transformation(extent={{-62,20},{-56,26}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,12},{-50,18}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,6},{-72,14}})));
    Modelica.Blocks.Sources.Constant one4(k=1.25)
      annotation (Placement(transformation(extent={{-94,6},{-90,10}})));
    Modelica.Blocks.Sources.Constant one5(k=-0.25)
      annotation (Placement(transformation(extent={{-68,14},{-62,20}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-4,
      Ti=10,
      yMax=1.0,
      yMin=0.0,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=20,
      rising=500,
      width=8500,
      falling=500,
      period=18000,
      offset=0.0,
      startTime=0)
      annotation (Placement(transformation(extent={{-74,42},{-62,54}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=1e-4) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={12,64})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
    Modelica.Blocks.Sources.Constant one2(k=1.25)
      annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
  equation

    connect(PID1.u_s, const1.y)
      annotation (Line(points={{-4,-46},{-27,-46}}, color={0,0,127}));
    connect(sensorBus.Boiler_Drum_Pressure, PID1.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{8,-70},{8,-58}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Boiler_Steam_Valve, PID1.y) annotation (Line(
        points={{30,-100},{30,-46},{19,-46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID.u_s,const. y)
      annotation (Line(points={{-24,-10},{-39,-10}},
                                                  color={0,0,127}));
    connect(sensorBus.Boiler_Level, PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-60},{-52,-60},{-52,-28},{-12,-28},{-12,-22}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Boiler_Feed_Flow, PID.y) annotation (Line(
        points={{30,-100},{30,-10},{-1,-10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points=
           {{-11.7,17},{-8,17},{-8,16},{0,16}}, color={0,0,127}));
    connect(add2.y,product2. u1) annotation (Line(points={{-49.7,15},{-22,15},{
            -22,16},{-18.6,16},{-18.6,15.2}},                 color={0,0,127}));
    connect(PID5.y,product2. u2) annotation (Line(points={{-37.7,23},{-24,23},{
            -24,18.8},{-18.6,18.8}},                          color={0,0,127}));
    connect(trapezoid1.y,PID5. u_s)
      annotation (Line(points={{-55.7,23},{-44.6,23}},     color={0,0,127}));
    connect(min2.y,add2. u2) annotation (Line(points={{-71.6,10},{-60,10},{-60,
            13.2},{-56.6,13.2}},                                         color={0,
            0,127}));
    connect(one4.y,min2. u2) annotation (Line(points={{-89.8,8},{-88,8},{-88,7.6},
            {-80.8,7.6}},            color={0,0,127}));
    connect(add2.u1, one5.y) annotation (Line(points={{-56.6,16.8},{-56.6,17},{
            -61.7,17}}, color={0,0,127}));
    connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
      annotation (Line(
        points={{30,-100},{30,16},{23.4,16}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,30},{-41,30},{-41,26.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,12.4},{-80.8,12.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(trapezoid.y,PID3. u_s)
      annotation (Line(points={{-61.4,48},{-42,48},{-42,58},{-36.8,58}},
                                                       color={0,0,127}));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
            -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
            -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
            74.8},{-36.6,74.8}},                                    color={0,0,
            127}));
    connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
            -36.6,71.2}},                                      color={0,0,127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
            {-56.8,62},{-56.8,63.6}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,64},{23.4,64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.discharge_m_flow, PID3.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,30},{-36,30},{-36,38},{-32,
            38},{-32,53.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Boiler;

  model CS_Boiler_02

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-3,
      Ti=15,
      yMax=1.0,
      yMin=0.0) annotation (Placement(transformation(extent={{-2,-56},{18,-36}})));
    Modelica.Blocks.Sources.Constant const1(k=5e5)
      annotation (Placement(transformation(extent={{-48,-56},{-28,-36}})));
    Modelica.Blocks.Sources.Constant const(k=10)
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-2,
      Ti=10,
      yMin=-0.25)
                annotation (Placement(transformation(extent={{-22,-20},{-2,0}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-4)
      annotation (Placement(transformation(extent={{2,6},{22,26}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,20},{-12,14}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-7.5e-4,
      Ti=30,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,24},{-38,18}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,12},{-50,18}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,6},{-72,14}})));
    Modelica.Blocks.Sources.Constant one4(k=1.25)
      annotation (Placement(transformation(extent={{-94,6},{-90,10}})));
    Modelica.Blocks.Sources.Constant one5(k=-0.25)
      annotation (Placement(transformation(extent={{-68,14},{-62,20}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-2,
      Ti=10,
      yMax=1.0,
      yMin=0.0,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=2.0,
      rising=500,
      width=8500,
      falling=500,
      period=18000,
      offset=0.0,
      startTime=0)
      annotation (Placement(transformation(extent={{-58,48},{-46,60}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=1e-4) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={12,64})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
    Modelica.Blocks.Sources.Constant one2(k=1.25)
      annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
    Modelica.Blocks.Sources.Constant one1(k=273.15 + 245)
      annotation (Placement(transformation(extent={{-58,22},{-52,28}})));
    Modelica.Blocks.Math.Add add3(k1=0.1)
      annotation (Placement(transformation(extent={{-30,24},{-24,30}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-50,32},{-46,36}})));
    Modelica.Blocks.Sources.Constant one6(k=0.0)
      annotation (Placement(transformation(extent={{-56,30},{-54,32}})));
    Modelica.Blocks.Sources.Constant one7(k=22.0)
      annotation (Placement(transformation(extent={{-56,38},{-54,40}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-2,
      Ti=10,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-40,38},{-34,32}})));
  equation

    connect(PID1.u_s, const1.y)
      annotation (Line(points={{-4,-46},{-27,-46}}, color={0,0,127}));
    connect(sensorBus.Boiler_Drum_Pressure, PID1.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{8,-70},{8,-58}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Boiler_Steam_Valve, PID1.y) annotation (Line(
        points={{30,-100},{30,-46},{19,-46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID.u_s,const. y)
      annotation (Line(points={{-24,-10},{-39,-10}},
                                                  color={0,0,127}));
    connect(sensorBus.Boiler_Level, PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-52,-70},{-52,-28},{-12,-28},{-12,-22}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Boiler_Feed_Flow, PID.y) annotation (Line(
        points={{30,-100},{30,-10},{-1,-10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points=
           {{-11.7,17},{-8,17},{-8,16},{0,16}}, color={0,0,127}));
    connect(add2.y,product2. u1) annotation (Line(points={{-49.7,15},{-22,15},{
            -22,16},{-18.6,16},{-18.6,15.2}},                 color={0,0,127}));
    connect(min2.y,add2. u2) annotation (Line(points={{-71.6,10},{-60,10},{-60,
            13.2},{-56.6,13.2}},                                         color={0,
            0,127}));
    connect(one4.y,min2. u2) annotation (Line(points={{-89.8,8},{-88,8},{-88,7.6},
            {-80.8,7.6}},            color={0,0,127}));
    connect(add2.u1, one5.y) annotation (Line(points={{-56.6,16.8},{-56.6,17},{
            -61.7,17}}, color={0,0,127}));
    connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
      annotation (Line(
        points={{30,-100},{30,16},{23.4,16}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,12.4},{-80.8,12.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(trapezoid.y,PID3. u_s)
      annotation (Line(points={{-45.4,54},{-40,54},{-40,58},{-36.8,58}},
                                                       color={0,0,127}));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
            -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
            -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
            74.8},{-36.6,74.8}},                                    color={0,0,
            127}));
    connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
            -36.6,71.2}},                                      color={0,0,127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
            {-56.8,62},{-56.8,63.6}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,64},{23.4,64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,25},{-44.6,25},{
            -44.6,21}}, color={0,0,127}));
    connect(sensorBus.Charge_Temp, PID5.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,30},{-41,30},{-41,24.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,21},{-34,21},{-34,
            25.2},{-30.6,25.2}}, color={0,0,127}));
    connect(product2.u2, add3.y) annotation (Line(points={{-18.6,18.8},{-22,18.8},
            {-22,27},{-23.7,27}}, color={0,0,127}));
    connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,35.6},{-52,35.6},
            {-52,39},{-53.9,39}}, color={0,0,127}));
    connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,32.4},{-50.4,31},
            {-53.9,31}}, color={0,0,127}));
    connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,34},{-45.8,35},{
            -40.6,35}}, color={0,0,127}));
    connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,28.8},{-33.7,28.8},{
            -33.7,35}}, color={0,0,127}));
    connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-37,42},{-37,38.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,34},{-50.4,34}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Discharge_Steam, PID3.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Boiler_02;

  model CS_Boiler_03

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-4)
      annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-7.5e-4,
      Ti=30,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
    Modelica.Blocks.Sources.Constant one4(k=1.25)
      annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
    Modelica.Blocks.Sources.Constant one5(k=-0.25)
      annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-2,
      Ti=10,
      yMax=1.0,
      yMin=0.0,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=2.0,
      rising=500,
      width=8500,
      falling=500,
      period=18000,
      offset=0.0,
      startTime=0)
      annotation (Placement(transformation(extent={{-58,48},{-46,60}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=1e-4) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={12,64})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
    Modelica.Blocks.Sources.Constant one2(k=1.25)
      annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
    Modelica.Blocks.Sources.Constant one1(k=273.15 + 245)
      annotation (Placement(transformation(extent={{-58,-16},{-52,-10}})));
    Modelica.Blocks.Math.Add add3(k1=0.1)
      annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
    Modelica.Blocks.Sources.Constant one6(k=0.0)
      annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
    Modelica.Blocks.Sources.Constant one7(k=22.0)
      annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-2,
      Ti=10,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
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
        points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(trapezoid.y,PID3. u_s)
      annotation (Line(points={{-45.4,54},{-40,54},{-40,58},{-36.8,58}},
                                                       color={0,0,127}));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
            -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
            -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
            74.8},{-36.6,74.8}},                                    color={0,0,
            127}));
    connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
            -36.6,71.2}},                                      color={0,0,127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
            {-56.8,62},{-56.8,63.6}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,64},{23.4,64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,-13},{-44.6,-13},{
            -44.6,-17}},color={0,0,127}));
    connect(sensorBus.Charge_Temp, PID5.u_m) annotation (Line(
        points={{-30,-100},{-30,-64},{-102,-64},{-102,-4},{-41,-4},{-41,-13.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
            -12.8},{-30.6,-12.8}},
                                 color={0,0,127}));
    connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
            -19.2},{-22,-11},{-23.7,-11}},
                                  color={0,0,127}));
    connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
            {-53.9,-1}},          color={0,0,127}));
    connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
            {-53.9,-7}}, color={0,0,127}));
    connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
            -40.6,-3}}, color={0,0,127}));
    connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
            -33.7,-3}}, color={0,0,127}));
    connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
        points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
            -37,0.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Discharge_Steam, PID3.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Boiler_03;

  model CS_Boiler_04

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-4)
      annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-2.5e-3,
      Ti=3,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
    Modelica.Blocks.Sources.Constant one4(k=1.25)
      annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
    Modelica.Blocks.Sources.Constant one5(k=-0.25)
      annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-2,
      Ti=10,
      yMax=1.0,
      yMin=0.0,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=2.0,
      rising=500,
      width=8500,
      falling=500,
      period=18000,
      offset=0.0,
      startTime=0)
      annotation (Placement(transformation(extent={{-58,48},{-46,60}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=1e-4) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={12,64})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
    Modelica.Blocks.Sources.Constant one2(k=1.25)
      annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
    Modelica.Blocks.Sources.Constant one1(k=273.15 + 245)
      annotation (Placement(transformation(extent={{-58,-16},{-52,-10}})));
    Modelica.Blocks.Math.Add add3(k1=0.1)
      annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
    Modelica.Blocks.Sources.Constant one6(k=0.0)
      annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
    Modelica.Blocks.Sources.Constant one7(k=22.0)
      annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-2,
      Ti=10,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
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
        points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(trapezoid.y,PID3. u_s)
      annotation (Line(points={{-45.4,54},{-40,54},{-40,58},{-36.8,58}},
                                                       color={0,0,127}));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
            -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
            -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
            74.8},{-36.6,74.8}},                                    color={0,0,
            127}));
    connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
            -36.6,71.2}},                                      color={0,0,127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
            {-56.8,62},{-56.8,63.6}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,64},{23.4,64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,-13},{-44.6,-13},{
            -44.6,-17}},color={0,0,127}));
    connect(sensorBus.Charge_Temp, PID5.u_m) annotation (Line(
        points={{-30,-100},{-30,-64},{-102,-64},{-102,-4},{-41,-4},{-41,-13.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
            -12.8},{-30.6,-12.8}},
                                 color={0,0,127}));
    connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
            -19.2},{-22,-11},{-23.7,-11}},
                                  color={0,0,127}));
    connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
            {-53.9,-1}},          color={0,0,127}));
    connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
            {-53.9,-7}}, color={0,0,127}));
    connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
            -40.6,-3}}, color={0,0,127}));
    connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
            -33.7,-3}}, color={0,0,127}));
    connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
        points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
            -37,0.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Discharge_Steam, PID3.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Boiler_04;

  model CS_Boiler_03_GMI

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-4)
      annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-7.5e-4,
      Ti=30,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
    Modelica.Blocks.Sources.Constant one4(k=1.25)
      annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
    Modelica.Blocks.Sources.Constant one5(k=-0.25)
      annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-2,
      Ti=1,
      yMax=1.0,
      yMin=0.0,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=10,
      rising=10,
      width=9480,
      falling=10,
      period=18000,
      offset=0.0,
      startTime=0)
      annotation (Placement(transformation(extent={{-58,48},{-46,60}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=0.3) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={12,64})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
    Modelica.Blocks.Sources.Constant one2(k=1.25)
      annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
    Modelica.Blocks.Sources.Constant one1(k=273.15 + 245)
      annotation (Placement(transformation(extent={{-58,-16},{-52,-10}})));
    Modelica.Blocks.Math.Add add3(k1=0.1)
      annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
    Modelica.Blocks.Sources.Constant one6(k=0.0)
      annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
    Modelica.Blocks.Sources.Constant one7(k=22.0)
      annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-2,
      Ti=10,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
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
        points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(trapezoid.y,PID3. u_s)
      annotation (Line(points={{-45.4,54},{-40,54},{-40,58},{-36.8,58}},
                                                       color={0,0,127}));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
            -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
            -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
            74.8},{-36.6,74.8}},                                    color={0,0,
            127}));
    connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
            -36.6,71.2}},                                      color={0,0,127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
            {-56.8,62},{-56.8,63.6}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,64},{23.4,64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,-13},{-44.6,-13},{
            -44.6,-17}},color={0,0,127}));
    connect(sensorBus.Charge_Temp, PID5.u_m) annotation (Line(
        points={{-30,-100},{-30,-64},{-102,-64},{-102,-4},{-41,-4},{-41,-13.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
            -12.8},{-30.6,-12.8}},
                                 color={0,0,127}));
    connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
            -19.2},{-22,-11},{-23.7,-11}},
                                  color={0,0,127}));
    connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
            {-53.9,-1}},          color={0,0,127}));
    connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
            {-53.9,-7}}, color={0,0,127}));
    connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
            -40.6,-3}}, color={0,0,127}));
    connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
            -33.7,-3}}, color={0,0,127}));
    connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
        points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
            -37,0.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Discharge_Steam, PID3.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Boiler_03_GMI;

  model CS_Basic_TESUC

    extends BaseClasses.Partial_ControlSystem;
    parameter Modelica.Units.SI.Temperature steam_ref;
    input Modelica.Units.SI.MassFlowRate Ref_Charge_Flow "TES should supply expected charging mass flow rate given demand" annotation(Dialog(tab = "General"));
    replaceable Data.Data_CS data
      annotation (Placement(transformation(extent={{-92,18},{-72,38}})), Dialog(tab = "General", choicesAllMatching=true));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=2e-4)
      annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-2.5e-3,
      Ti=3,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
    Modelica.Blocks.Sources.Constant one4(k=1.25)
      annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
    Modelica.Blocks.Sources.Constant one5(k=-0.25)
      annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.01*data.discharge_control_ref_value,
      Ti=10,
      yMax=1.0,
      yMin=0.0,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
  end CS_Basic_TESUC;

  model CS_Case_1

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-2, max=1)
      annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=7.5e-5,
      Ti=5,
      yMax=1.0,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
    Modelica.Blocks.Sources.Constant one4(k=5)
      annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
    Modelica.Blocks.Sources.Constant one5(k=-4)
      annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-3,
      Ti=20,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=1e-2) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={12,64})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
    Modelica.Blocks.Sources.Constant one2(k=1.25)
      annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
    Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
      annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
    Modelica.Blocks.Sources.Constant one6(k=0.0)
      annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
    Modelica.Blocks.Sources.Constant one7(k=915.5)
      annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-2,
      Ti=10,
      yMax=1,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
    Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
      annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
    Modelica.Blocks.Math.Product product3
      annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
    Modelica.Blocks.Sources.Constant one1(k=24)
      annotation (Placement(transformation(extent={{-118,4},{-108,14}})));
    Modelica.Blocks.Sources.Constant one9(k=0.015)
      annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
    Modelica.Blocks.Math.Add add4
      annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
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
        points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
            -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
            -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
            74.8},{-36.6,74.8}},                                    color={0,0,
            127}));
    connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
            -36.6,71.2}},                                      color={0,0,127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
            {-56.8,62},{-56.8,63.6}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,64},{23.4,64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
            -12.8},{-30.6,-12.8}},
                                 color={0,0,127}));
    connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
            -19.2},{-22,-11},{-23.7,-11}},
                                  color={0,0,127}));
    connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
            {-53.9,-1}},          color={0,0,127}));
    connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
            {-53.9,-7}}, color={0,0,127}));
    connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
            -40.6,-3}}, color={0,0,127}));
    connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
            -33.7,-3}}, color={0,0,127}));
    connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
        points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
            -37,0.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
            -36.8,54},{-36.8,58}}, color={0,0,127}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one1.y, product3.u1) annotation (Line(points={{-107.5,9},{-107.5,8.4},
            {-86.8,8.4}}, color={0,0,127}));
    connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
            -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
    connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
            14.8},{-70.6,14.8}}, color={0,0,127}));
    connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
            11.2},{-70.6,11.2}}, color={0,0,127}));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Case_1;

  model CS_Case_3

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-2, max=1)
      annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=7.5e-5,
      Ti=5,
      yMax=1.0,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
    Modelica.Blocks.Sources.Constant one4(k=5)
      annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
    Modelica.Blocks.Sources.Constant one5(k=-4)
      annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-3,
      Ti=20,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=1e-2) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={12,64})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
    Modelica.Blocks.Sources.Constant one2(k=1.25)
      annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
    Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
      annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
    Modelica.Blocks.Sources.Constant one6(k=0.0)
      annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
    Modelica.Blocks.Sources.Constant one7(k=915.5)
      annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-2,
      Ti=10,
      yMax=1,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
    Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
      annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
    Modelica.Blocks.Math.Product product3
      annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
    Modelica.Blocks.Sources.Constant one1(k=28)
      annotation (Placement(transformation(extent={{-118,4},{-108,14}})));
    Modelica.Blocks.Sources.Constant one9(k=0.015)
      annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
    Modelica.Blocks.Math.Add add4
      annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
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
        points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
            -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
            -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
            74.8},{-36.6,74.8}},                                    color={0,0,
            127}));
    connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
            -36.6,71.2}},                                      color={0,0,127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
            {-56.8,62},{-56.8,63.6}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,64},{23.4,64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
            -12.8},{-30.6,-12.8}},
                                 color={0,0,127}));
    connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
            -19.2},{-22,-11},{-23.7,-11}},
                                  color={0,0,127}));
    connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
            {-53.9,-1}},          color={0,0,127}));
    connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
            {-53.9,-7}}, color={0,0,127}));
    connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
            -40.6,-3}}, color={0,0,127}));
    connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
            -33.7,-3}}, color={0,0,127}));
    connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
        points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
            -37,0.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
            -36.8,54},{-36.8,58}}, color={0,0,127}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one1.y, product3.u1) annotation (Line(points={{-107.5,9},{-107.5,8.4},
            {-86.8,8.4}}, color={0,0,127}));
    connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
            -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
    connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
            14.8},{-70.6,14.8}}, color={0,0,127}));
    connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
            11.2},{-70.6,11.2}}, color={0,0,127}));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Case_3;

  model CS_BestExample

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-2, max=1)
      annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=7.5e-5,
      Ti=5,
      yMax=1.0,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
    Modelica.Blocks.Sources.Constant one4(k=1.25)
      annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
    Modelica.Blocks.Sources.Constant one5(k=-0.25)
      annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-3,
      Ti=20,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=1e-2) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={12,64})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
    Modelica.Blocks.Sources.Constant one2(k=1.25)
      annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
    Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
      annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
    Modelica.Blocks.Sources.Constant one6(k=0.0)
      annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
    Modelica.Blocks.Sources.Constant one7(k=915.5)
      annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-2,
      Ti=10,
      yMax=1,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
    Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
      annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
    Modelica.Blocks.Math.Product product3
      annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
    Modelica.Blocks.Sources.Constant one1(k=240 + 273.15)
      annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
    Modelica.Blocks.Sources.Constant one9(k=0.015)
      annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
    Modelica.Blocks.Math.Add add4
      annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-2,
      Ti=20,
      yMax=40,
      yMin=-9,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
    Modelica.Blocks.Math.Add add5
      annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
    Modelica.Blocks.Sources.Constant one10(k=30)
      annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
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
        points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
            -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
            -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
            74.8},{-36.6,74.8}},                                    color={0,0,
            127}));
    connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
            -36.6,71.2}},                                      color={0,0,127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
            {-56.8,62},{-56.8,63.6}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,64},{23.4,64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
            -12.8},{-30.6,-12.8}},
                                 color={0,0,127}));
    connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
            -19.2},{-22,-11},{-23.7,-11}},
                                  color={0,0,127}));
    connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
            {-53.9,-1}},          color={0,0,127}));
    connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
            {-53.9,-7}}, color={0,0,127}));
    connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
            -40.6,-3}}, color={0,0,127}));
    connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
            -33.7,-3}}, color={0,0,127}));
    connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
        points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
            -37,0.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
            -36.8,54},{-36.8,58}}, color={0,0,127}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
            -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
    connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
            14.8},{-70.6,14.8}}, color={0,0,127}));
    connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
            11.2},{-70.6,11.2}}, color={0,0,127}));
    connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
            -143.15,8},{-136.8,8}}, color={0,0,127}));
    connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
            -120,20.8},{-116.6,20.8}}, color={0,0,127}));
    connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
            -116.6,17.2}}, color={0,0,127}));
    connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
            -92,8.4},{-86.8,8.4}}, color={0,0,127}));
    connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}),
      Diagram(graphics={Text(
            extent={{-170,20},{-126,14}},
            textColor={28,108,200},
            textString="Don't set lower bound lower than -9
"),   Line(points={{-142,16},{-136,12}}, color={28,108,200})}));
  end CS_BestExample;

  model CS_DirectCoupling

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-2, max=1)
      annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=7.5e-5,
      Ti=5,
      yMax=1.0,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
    Modelica.Blocks.Sources.Constant one4(k=1.25)
      annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
    Modelica.Blocks.Sources.Constant one5(k=-0.25)
      annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-3,
      Ti=20,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=1e-2) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={12,64})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
    Modelica.Blocks.Sources.Constant one2(k=1.25)
      annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
    Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
      annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
    Modelica.Blocks.Sources.Constant one6(k=0.0)
      annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
    Modelica.Blocks.Sources.Constant one7(k=915.5)
      annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-2,
      Ti=10,
      yMax=1,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
    Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
      annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
    Modelica.Blocks.Math.Product product3
      annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
    Modelica.Blocks.Sources.Constant one1(k=240 + 273.15)
      annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
    Modelica.Blocks.Sources.Constant one9(k=0.015)
      annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
    Modelica.Blocks.Math.Add add4
      annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-2,
      Ti=20,
      yMax=40,
      yMin=-10,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
    Modelica.Blocks.Math.Add add5
      annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
    Modelica.Blocks.Sources.Constant one10(k=15)
      annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
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
        points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
            -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
            -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
            74.8},{-36.6,74.8}},                                    color={0,0,
            127}));
    connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
            -36.6,71.2}},                                      color={0,0,127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
            {-56.8,62},{-56.8,63.6}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,64},{23.4,64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
            -12.8},{-30.6,-12.8}},
                                 color={0,0,127}));
    connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
            -19.2},{-22,-11},{-23.7,-11}},
                                  color={0,0,127}));
    connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
            {-53.9,-1}},          color={0,0,127}));
    connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
            {-53.9,-7}}, color={0,0,127}));
    connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
            -40.6,-3}}, color={0,0,127}));
    connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
            -33.7,-3}}, color={0,0,127}));
    connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
        points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
            -37,0.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
            -36.8,54},{-36.8,58}}, color={0,0,127}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
            -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
    connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
            14.8},{-70.6,14.8}}, color={0,0,127}));
    connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
            11.2},{-70.6,11.2}}, color={0,0,127}));
    connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
            -143.15,8},{-136.8,8}}, color={0,0,127}));
    connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
            -120,20.8},{-116.6,20.8}}, color={0,0,127}));
    connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
            -116.6,17.2}}, color={0,0,127}));
    connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
            -92,8.4},{-86.8,8.4}}, color={0,0,127}));
    connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}),
      Diagram(graphics={Text(
            extent={{-170,20},{-126,14}},
            textColor={28,108,200},
            textString="Don't set lower bound lower than -9
"),   Line(points={{-142,16},{-136,12}}, color={28,108,200})}));
  end CS_DirectCoupling;

  model CS_Case_1_HTGR

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-2, max=1)
      annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=7.5e-5,
      Ti=5,
      yMax=1.0,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
    Modelica.Blocks.Sources.Constant one4(k=1.25)
      annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
    Modelica.Blocks.Sources.Constant one5(k=-0.25)
      annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-3,
      Ti=20,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=1e-2) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={12,64})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
    Modelica.Blocks.Sources.Constant one2(k=1.25)
      annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
    Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
      annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
    Modelica.Blocks.Sources.Constant one6(k=0.0)
      annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
    Modelica.Blocks.Sources.Constant one7(k=915.5)
      annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-2,
      Ti=10,
      yMax=1,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
    Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
      annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
    Modelica.Blocks.Math.Product product3
      annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
    Modelica.Blocks.Sources.Constant one1(k=240 + 273.15)
      annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
    Modelica.Blocks.Sources.Constant one9(k=0.015)
      annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
    Modelica.Blocks.Math.Add add4
      annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-2,
      Ti=20,
      yMax=40,
      yMin=-9,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
    Modelica.Blocks.Math.Add add5
      annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
    Modelica.Blocks.Sources.Constant one10(k=30)
      annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
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
        points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
            -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
            -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
            74.8},{-36.6,74.8}},                                    color={0,0,
            127}));
    connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
            -36.6,71.2}},                                      color={0,0,127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
            {-56.8,62},{-56.8,63.6}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,64},{23.4,64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
            -12.8},{-30.6,-12.8}},
                                 color={0,0,127}));
    connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
            -19.2},{-22,-11},{-23.7,-11}},
                                  color={0,0,127}));
    connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
            {-53.9,-1}},          color={0,0,127}));
    connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
            {-53.9,-7}}, color={0,0,127}));
    connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
            -40.6,-3}}, color={0,0,127}));
    connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
            -33.7,-3}}, color={0,0,127}));
    connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
        points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
            -37,0.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
            -36.8,54},{-36.8,58}}, color={0,0,127}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
            -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
    connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
            14.8},{-70.6,14.8}}, color={0,0,127}));
    connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
            11.2},{-70.6,11.2}}, color={0,0,127}));
    connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
            -143.15,8},{-136.8,8}}, color={0,0,127}));
    connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
            -120,20.8},{-116.6,20.8}}, color={0,0,127}));
    connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
            -116.6,17.2}}, color={0,0,127}));
    connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
            -92,8.4},{-86.8,8.4}}, color={0,0,127}));
    connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}),
      Diagram(graphics={Text(
            extent={{-170,20},{-126,14}},
            textColor={28,108,200},
            textString="Don't set lower bound lower than -9
"),   Line(points={{-142,16},{-136,12}}, color={28,108,200})}));
  end CS_Case_1_HTGR;

  model CS_DirectCoupling_HTGR

    extends BaseClasses.Partial_ControlSystem;

    Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-2, max=1)
      annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=7.5e-5,
      Ti=5,
      yMax=1.0,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
    Modelica.Blocks.Sources.Constant one4(k=1.25)
      annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
    Modelica.Blocks.Sources.Constant one5(k=-0.25)
      annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-3,
      Ti=20,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=1e-2) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={12,64})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
    Modelica.Blocks.Sources.Constant one2(k=1.25)
      annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
    Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
      annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
    Modelica.Blocks.Sources.Constant one6(k=0.0)
      annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
    Modelica.Blocks.Sources.Constant one7(k=915.5)
      annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-2,
      Ti=10,
      yMax=1,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
    Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
      annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
    Modelica.Blocks.Math.Product product3
      annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
    Modelica.Blocks.Sources.Constant one1(k=340 + 273.15)
      annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
    Modelica.Blocks.Sources.Constant one9(k=0.015)
      annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
    Modelica.Blocks.Math.Add add4
      annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-2,
      Ti=20,
      yMax=70,
      yMin=-9,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
    Modelica.Blocks.Math.Add add5
      annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
    Modelica.Blocks.Sources.Constant one10(k=30)
      annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{120,-44},{140,-24}})));
    Modelica.Blocks.Sources.Constant const9(k=165e5)
      annotation (Placement(transformation(extent={{80,-44},{100,-24}})));
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
        points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
            -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
            -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
            74.8},{-36.6,74.8}},                                    color={0,0,
            127}));
    connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
            -36.6,71.2}},                                      color={0,0,127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
            {-56.8,62},{-56.8,63.6}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,64},{23.4,64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
            -12.8},{-30.6,-12.8}},
                                 color={0,0,127}));
    connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
            -19.2},{-22,-11},{-23.7,-11}},
                                  color={0,0,127}));
    connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
            {-53.9,-1}},          color={0,0,127}));
    connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
            {-53.9,-7}}, color={0,0,127}));
    connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
            -40.6,-3}}, color={0,0,127}));
    connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
            -33.7,-3}}, color={0,0,127}));
    connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
        points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
            -37,0.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
            -36.8,54},{-36.8,58}}, color={0,0,127}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
        points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
            -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
    connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
            14.8},{-70.6,14.8}}, color={0,0,127}));
    connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
            11.2},{-70.6,11.2}}, color={0,0,127}));
    connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
            -143.15,8},{-136.8,8}}, color={0,0,127}));
    connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
            -120,20.8},{-116.6,20.8}}, color={0,0,127}));
    connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
            -116.6,17.2}}, color={0,0,127}));
    connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
            -92,8.4},{-86.8,8.4}}, color={0,0,127}));
    connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(const9.y,PI_TBV. u_s)
      annotation (Line(points={{101,-34},{118,-34}},
                                                   color={0,0,127}));
    connect(sensorBus.Steam_Pressure,PI_TBV. u_m) annotation (Line(
        points={{-30,-100},{58,-100},{58,-70},{130,-70},{130,-46}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TBV,PI_TBV. y) annotation (Line(
        points={{30,-100},{30,-50},{148,-50},{148,-34},{141,-34}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}),
      Diagram(graphics={Text(
            extent={{-170,20},{-126,14}},
            textColor={28,108,200},
            textString="Don't set lower bound lower than -9
"),   Line(points={{-142,16},{-136,12}}, color={28,108,200})}));
  end CS_DirectCoupling_HTGR;

  package ObseleteControlSystems
    model CS_Boiler_03_GMI_TESUC

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-4)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-7.5e-4,
        Ti=30,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-2,
        Ti=1,
        yMax=1.0,
        yMin=0.0,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=200,
        rising=10,
        width=9480,
        falling=10,
        period=18000,
        offset=0.0,
        startTime=0)
        annotation (Placement(transformation(extent={{-58,48},{-46,60}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-4) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Sources.Constant one1(k=273.15 + 245)
        annotation (Placement(transformation(extent={{-58,-16},{-52,-10}})));
      Modelica.Blocks.Math.Add add3(k1=0.1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=22.0)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
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
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(trapezoid.y,PID3. u_s)
        annotation (Line(points={{-45.4,54},{-40,54},{-40,58},{-36.8,58}},
                                                         color={0,0,127}));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,-13},{-44.6,-13},{
              -44.6,-17}},color={0,0,127}));
      connect(sensorBus.Charge_Temp, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-64},{-102,-64},{-102,-10},{-41,-10},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Boiler_03_GMI_TESUC;

    model CS_Boiler_03_GMI_TempControl

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-2, max=1)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-7.5e-4,
        Ti=1,
        yMax=1.0,
        yMin=0.001,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-4,
        Ti=5,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-3) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Sources.Constant one1(k=273.15 + 140)
        annotation (Placement(transformation(extent={{-58,-16},{-52,-10}})));
      Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=915.5)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
      Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
        annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
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
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,-13},{-44.6,-13},{
              -44.6,-17}},color={0,0,127}));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
              -36.8,54},{-36.8,58}}, color={0,0,127}));
      connect(sensorBus.Coolant_Water_temp, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Boiler_03_GMI_TempControl;

    model CS_Boiler_03_GMI_TempControl_2

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-2, max=1)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=7.5e-5,
        Ti=5,
        yMax=1.0,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=5)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-4)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-3,
        Ti=20,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-2) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=915.5)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
      Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
        annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
      Modelica.Blocks.Math.Product product3
        annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
      Modelica.Blocks.Sources.Constant one1(k=26)
        annotation (Placement(transformation(extent={{-118,4},{-108,14}})));
      Modelica.Blocks.Sources.Constant one9(k=0.015)
        annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
      Modelica.Blocks.Math.Add add4
        annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
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
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
              -36.8,54},{-36.8,58}}, color={0,0,127}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one1.y, product3.u1) annotation (Line(points={{-107.5,9},{-107.5,8.4},
              {-86.8,8.4}}, color={0,0,127}));
      connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
              -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
      connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
              14.8},{-70.6,14.8}}, color={0,0,127}));
      connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
              11.2},{-70.6,11.2}}, color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Boiler_03_GMI_TempControl_2;

    model CS_Boiler_03_GMI_TempControl_4

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-2, max=1)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=7.5e-5,
        Ti=5,
        yMax=1.0,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=5)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-4)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-3,
        Ti=20,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-2) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=915.5)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
      Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
        annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
      Modelica.Blocks.Math.Product product3
        annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
      Modelica.Blocks.Sources.Constant one1(k=240 + 273.15)
        annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
      Modelica.Blocks.Sources.Constant one9(k=0.015)
        annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
      Modelica.Blocks.Math.Add add4
        annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
      TRANSFORM.Controls.LimPID PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-2,
        Ti=20,
        yMax=20,
        yMin=-20,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
      Modelica.Blocks.Math.Add add5
        annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
      Modelica.Blocks.Sources.Constant one10(k=28)
        annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
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
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
              -36.8,54},{-36.8,58}}, color={0,0,127}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
              -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
      connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
              14.8},{-70.6,14.8}}, color={0,0,127}));
      connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
              11.2},{-70.6,11.2}}, color={0,0,127}));
      connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
              -143.15,8},{-136.8,8}}, color={0,0,127}));
      connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
              -120,20.8},{-116.6,20.8}}, color={0,0,127}));
      connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
              -116.6,17.2}}, color={0,0,127}));
      connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
              -92,8.4},{-86.8,8.4}}, color={0,0,127}));
      connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Boiler_03_GMI_TempControl_4;

    model CS_Boiler_03_GMI_TempControl_5

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-2, max=1)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=7.5e-5,
        Ti=5,
        yMax=1.0,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-3,
        Ti=20,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-2) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=915.5)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
      Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
        annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
      Modelica.Blocks.Math.Product product3
        annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
      Modelica.Blocks.Sources.Constant one1(k=240 + 273.15)
        annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
      Modelica.Blocks.Sources.Constant one9(k=0.015)
        annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
      Modelica.Blocks.Math.Add add4
        annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
      TRANSFORM.Controls.LimPID PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-2,
        Ti=20,
        yMax=20,
        yMin=-9,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
      Modelica.Blocks.Math.Add add5
        annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
      Modelica.Blocks.Sources.Constant one10(k=28)
        annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
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
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
              -36.8,54},{-36.8,58}}, color={0,0,127}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
              -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
      connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
              14.8},{-70.6,14.8}}, color={0,0,127}));
      connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
              11.2},{-70.6,11.2}}, color={0,0,127}));
      connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
              -143.15,8},{-136.8,8}}, color={0,0,127}));
      connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
              -120,20.8},{-116.6,20.8}}, color={0,0,127}));
      connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
              -116.6,17.2}}, color={0,0,127}));
      connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
              -92,8.4},{-86.8,8.4}}, color={0,0,127}));
      connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}),
        Diagram(graphics={Text(
              extent={{-170,20},{-126,14}},
              textColor={28,108,200},
              textString="Don't set lower bound lower than -9
"),     Line(points={{-142,16},{-136,12}}, color={28,108,200})}));
    end CS_Boiler_03_GMI_TempControl_5;
  end ObseleteControlSystems;

  model CS_TES_HT_Power_ANL

    extends
      NHES.Systems.EnergyStorage.SHS_Two_Tank.BaseClasses.Partial_ControlSystem;

    input Real electric_demand_TES;
    input Real Round_Trip_Efficiency;

    NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_Default data
      annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax(min=1e-2, max=1)
      annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{40,-56},{48,-64}})));
    TRANSFORM.Controls.LimPID PID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=7.5e-5,
      Ti=5,
      yMax=1.0,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{14,-54},{20,-60}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{2,-72},{8,-66}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{-22,-78},{-14,-70}})));
    Modelica.Blocks.Sources.Constant one4(k=1.25)
      annotation (Placement(transformation(extent={{-36,-78},{-32,-74}})));
    Modelica.Blocks.Sources.Constant one5(k=-0.25)
      annotation (Placement(transformation(extent={{-10,-70},{-4,-64}})));
    TRANSFORM.Controls.LimPID PID3(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-3,
      Ti=200,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.2)
      annotation (Placement(transformation(extent={{22,-26},{30,-18}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Discharging_Valve_Position(min=9e-3) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={70,-20})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{38,-24},{46,-16}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{6,-18},{14,-10}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{-14,-30},{-6,-22}})));
    Modelica.Blocks.Sources.Constant one3(k=-0.25)
      annotation (Placement(transformation(extent={{-12,-16},{-6,-10}})));
    Modelica.Blocks.Sources.Constant one2(k=0.5)
      annotation (Placement(transformation(extent={{-28,-28},{-22,-22}})));
    Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
      annotation (Placement(transformation(extent={{28,-58},{34,-52}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{8,-54},{12,-50}})));
    Modelica.Blocks.Sources.Constant one6(k=0.0)
      annotation (Placement(transformation(extent={{2,-56},{4,-54}})));
    Modelica.Blocks.Sources.Constant one7(k=915.5)
      annotation (Placement(transformation(extent={{2,-50},{4,-48}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-2,
      Ti=10,
      yMax=1,
      yMin=0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.0)
      annotation (Placement(transformation(extent={{18,-44},{24,-50}})));
    Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
      annotation (Placement(transformation(extent={{10,-26},{16,-20}})));
    Modelica.Blocks.Math.Product product3
      annotation (Placement(transformation(extent={{-28,-64},{-20,-56}})));
    Modelica.Blocks.Sources.Constant one1(k=240 + 273.15)
      annotation (Placement(transformation(extent={{-100,-50},{-90,-40}})));
    Modelica.Blocks.Sources.Constant one9(k=0.015)
      annotation (Placement(transformation(extent={{-28,-50},{-22,-44}})));
    Modelica.Blocks.Math.Add add4
      annotation (Placement(transformation(extent={{-12,-60},{-6,-54}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-2,
      Ti=20,
      yMax=40,
      yMin=-9,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-64,-72},{-56,-64}})));
    Modelica.Blocks.Math.Add add5
      annotation (Placement(transformation(extent={{-44,-62},{-38,-56}})));
    Modelica.Blocks.Sources.Constant one10(k=30)
      annotation (Placement(transformation(extent={{-62,-54},{-56,-48}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand_TES)
      annotation (Placement(transformation(extent={{-14,80},{0,92}})));
    Modelica.Blocks.Sources.Constant minimumOpening(k=0)
      annotation (Placement(transformation(extent={{42,70},{50,78}})));
    Modelica.Blocks.Math.Add InletValveOpening
      annotation (Placement(transformation(extent={{60,70},{80,90}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter(max=1 - minimumOpening.k)
      annotation (Placement(transformation(extent={{30,82},{38,90}})));
    TRANSFORM.Controls.LimPID InletValvePID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-8,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{10,82},{18,90}})));
    TRANSFORM.Controls.LimPID PID6(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-2,
      Ti=10,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=0.2,
      reset=TRANSFORM.Types.Reset.Disabled)
      annotation (Placement(transformation(extent={{24,40},{32,48}})));
    Modelica.Blocks.Math.Product product4
      annotation (Placement(transformation(extent={{38,46},{46,54}})));
    Modelica.Blocks.Math.Add add6
      annotation (Placement(transformation(extent={{8,50},{14,56}})));
    Modelica.Blocks.Math.Min min3
      annotation (Placement(transformation(extent={{-18,46},{-10,54}})));
    Modelica.Blocks.Sources.Constant one11(k=-0.25)
      annotation (Placement(transformation(extent={{-2,54},{4,60}})));
    Modelica.Blocks.Sources.Constant one12(k=0.5)
      annotation (Placement(transformation(extent={{-34,46},{-26,54}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      Charging_Valve_Position_MinMax1(min=2.935e-3, max=1)
      annotation (Placement(transformation(extent={{60,40},{80,60}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      HotTank_Power(min=0, max=100e6) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={70,20})));
    TRANSFORM.Controls.LimPID PID4(
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=1e11,
      Ti=1000,
      yMin=0,
      y_start=1)
      annotation (Placement(transformation(extent={{-20,16},{-12,24}})));
    Modelica.Blocks.Math.Gain gain(k=2.5)
      annotation (Placement(transformation(extent={{-2,48},{2,52}})));
    Modelica.Blocks.Math.Gain gain1(k=2.5)
      annotation (Placement(transformation(extent={{-4,-28},{0,-24}})));
    Modelica.Blocks.Sources.RealExpression efficiency(y=Round_Trip_Efficiency)
      annotation (Placement(transformation(extent={{-36,74},{-22,86}})));
    Modelica.Blocks.Math.Product product5
      annotation (Placement(transformation(extent={{-12,70},{-4,78}})));
  equation

    connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{48.4,
            -60},{58,-60}},                     color={0,0,127}));
    connect(add2.y,product2. u1) annotation (Line(points={{8.3,-69},{36,-69},{36,-60},
            {39.2,-60},{39.2,-62.4}},                         color={0,0,127}));
    connect(min2.y,add2. u2) annotation (Line(points={{-13.6,-74},{-2,-74},{-2,-70.8},
            {1.4,-70.8}},                                                color={0,
            0,127}));
    connect(one4.y,min2. u2) annotation (Line(points={{-31.8,-76},{-30,-76},{-30,-76.4},
            {-22.8,-76.4}},          color={0,0,127}));
    connect(add2.u1, one5.y) annotation (Line(points={{1.4,-67.2},{1.4,-67},{-3.7,
            -67}},      color={0,0,127}));
    connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
        points={{-30,-100},{-44,-100},{-44,-71.6},{-22.8,-71.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(product1.y, Discharging_Valve_Position.u)
      annotation (Line(points={{46.4,-20},{58,-20}},
                                                   color={0,0,127}));
    connect(PID3.y,product1. u2) annotation (Line(points={{30.4,-22},{37.2,-22},{37.2,
            -22.4}},                                           color={0,0,127}));
    connect(add1.y,product1. u1) annotation (Line(points={{14.4,-14},{36,-14},{36,
            -17.6},{37.2,-17.6}},                        color={0,0,127}));
    connect(one3.y,add1. u1) annotation (Line(points={{-5.7,-13},{2,-13},{2,-11.6},
            {5.2,-11.6}},                                           color={0,0,
            127}));
    connect(one2.y,min1. u2) annotation (Line(points={{-21.7,-25},{-20.25,-25},
            {-20.25,-28.4},{-14.8,-28.4}},
                                   color={0,0,127}));
    connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,-80},{94,-80},{94,-20},{81.4,-20}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
        points={{-30,-100},{-60,-100},{-60,-23.6},{-14.8,-23.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PID5.y, add3.u2) annotation (Line(points={{20.3,-57},{24,-57},{24,-56.8},
            {27.4,-56.8}},       color={0,0,127}));
    connect(product2.u2, add3.y) annotation (Line(points={{39.2,-57.6},{36,-57.6},
            {36,-55},{34.3,-55}}, color={0,0,127}));
    connect(switch1.u1, one7.y) annotation (Line(points={{7.6,-50.4},{7.6,-49},{4.1,
            -49}},                color={0,0,127}));
    connect(switch1.u3, one6.y) annotation (Line(points={{7.6,-53.6},{7.6,-55},{4.1,
            -55}},       color={0,0,127}));
    connect(switch1.y, PID2.u_s) annotation (Line(points={{12.2,-52},{12.2,-47},{17.4,
            -47}},      color={0,0,127}));
    connect(add3.u1, PID2.y) annotation (Line(points={{27.4,-53.2},{24.3,-53.2},{24.3,
            -47}},      color={0,0,127}));
    connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
        points={{-30,-100},{-44,-100},{-44,-38},{21,-38},{21,-43.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
        points={{-30,-100},{-44,-100},{-44,-52},{7.6,-52}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one8.y, PID3.u_s) annotation (Line(points={{16.3,-23},{16.3,-22},{21.2,
            -22}},                 color={0,0,127}));
    connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
        points={{-30,-100},{-44,-100},{-44,-30},{26,-30},{26,-26.8}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
        points={{-30,-100},{-44,-100},{-44,-42},{17,-42},{17,-53.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
        points={{-30,-100},{-44,-100},{-44,-66},{-28.8,-66},{-28.8,-62.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(one9.y, add4.u1) annotation (Line(points={{-21.7,-47},{-18,-47},{-18,-55.2},
            {-12.6,-55.2}},      color={0,0,127}));
    connect(product3.y, add4.u2) annotation (Line(points={{-19.6,-60},{-16,-60},{-16,
            -58.8},{-12.6,-58.8}},
                                 color={0,0,127}));
    connect(one1.y, PID1.u_s) annotation (Line(points={{-89.5,-45},{-71.15,-45},{-71.15,
            -68},{-64.8,-68}},      color={0,0,127}));
    connect(one10.y, add5.u1) annotation (Line(points={{-55.7,-51},{-48,-51},{-48,
            -57.2},{-44.6,-57.2}},     color={0,0,127}));
    connect(PID1.y, add5.u2) annotation (Line(points={{-55.6,-68},{-44.6,-68},{-44.6,
            -60.8}},       color={0,0,127}));
    connect(add5.y, product3.u1) annotation (Line(points={{-37.7,-59},{-32,-59},{-32,
            -57.6},{-28.8,-57.6}}, color={0,0,127}));
    connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
        points={{-30,-100},{-30,-88},{-60,-88},{-60,-72.8}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(add4.y, PID5.u_s)
      annotation (Line(points={{-5.7,-57},{13.4,-57}}, color={0,0,127}));
    connect(minimumOpening.y,InletValveOpening. u2) annotation (Line(points={{50.4,74},
            {58,74}},                          color={0,0,127}));
    connect(InletValveOpening.u1,minMaxFilter. y) annotation (Line(points={{58,86},
            {38.56,86}},                       color={0,0,127}));
    connect(minMaxFilter.u,InletValvePID. y)
      annotation (Line(points={{29.2,86},{18.4,86}},
                                                   color={0,0,127}));
    connect(realExpression.y,InletValvePID. u_s)
      annotation (Line(points={{0.7,86},{9.2,86}},   color={0,0,127}));
    connect(actuatorBus.InletValveOpening,InletValveOpening. y) annotation (
        Line(
        points={{30,-100},{30,-80},{94,-80},{94,80},{81,80}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(PID6.y,product4. u2) annotation (Line(points={{32.4,44},{37.2,44},{37.2,
            47.6}},                                            color={0,0,127}));
    connect(add6.y,product4. u1) annotation (Line(points={{14.3,53},{14.3,52.4},{37.2,
            52.4}},                                      color={0,0,127}));
    connect(one11.y,add6. u1) annotation (Line(points={{4.3,57},{4.3,54.8},{
            7.4,54.8}},    color={0,0,127}));
    connect(one12.y,min3. u2) annotation (Line(points={{-25.6,50},{-24,50},{-24,47.6},
            {-18.8,47.6}},           color={0,0,127}));
    connect(sensorBus.Hot_Tank_Entrance_Temp,PID6. u_m) annotation (Line(
        points={{-30,-100},{-30,-2},{28,-2},{28,39.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(one1.y,PID6. u_s) annotation (Line(points={{-89.5,-45},{-46,-45},
            {-46,20},{-28,20},{-28,44},{23.2,44}},   color={0,0,127}));
    connect(sensorBus.cold_tank_level,min3. u1) annotation (Line(
        points={{-30,-100},{-30,-92},{-44,-92},{-44,-78},{-46,-78},{-46,-38},{-48,
            -38},{-48,18},{-40,18},{-40,58},{-18.8,58},{-18.8,52.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(product4.y,Charging_Valve_Position_MinMax1. u)
      annotation (Line(points={{46.4,50},{58,50}}, color={0,0,127}));
    connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax1.y)
      annotation (Line(
        points={{30,-100},{30,-80},{94,-80},{94,50},{81.4,50}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(PID4.u_s, PID6.u_s) annotation (Line(points={{-20.8,20},{-28,20},
            {-28,44},{23.2,44}}, color={0,0,127}));
    connect(sensorBus.Hot_Tank_Temp, PID4.u_m) annotation (Line(
        points={{-30,-100},{-30,-88},{-60,-88},{-60,-78},{-68,-78},{-68,-42},
            {-42,-42},{-42,10},{-16,10},{-16,15.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(PID4.y, HotTank_Power.u)
      annotation (Line(points={{-11.6,20},{58,20}}, color={0,0,127}));
    connect(actuatorBus.Hot_Tank_Heating_Power, HotTank_Power.y) annotation (
        Line(
        points={{30,-100},{30,-80},{94,-80},{94,20},{81.4,20}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(min3.y, gain.u)
      annotation (Line(points={{-9.6,50},{-2.4,50}}, color={0,0,127}));
    connect(add6.u2, gain.y) annotation (Line(points={{7.4,51.2},{6,51.2},{6,
            50},{2.2,50}}, color={0,0,127}));
    connect(add1.u2, gain1.y) annotation (Line(points={{5.2,-16.4},{2,-16.4},
            {2,-26},{0.2,-26}}, color={0,0,127}));
    connect(min1.y, gain1.u)
      annotation (Line(points={{-5.6,-26},{-4.4,-26}}, color={0,0,127}));
    connect(sensorBus.Steam_Deposit_Power, product5.u2) annotation (Line(
        points={{-30,-100},{-30,42},{-42,42},{-42,66},{-12.8,66},{-12.8,71.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(efficiency.y, product5.u1)
      annotation (Line(points={{-21.3,80},{-17.05,80},{-17.05,76.4},{-12.8,76.4}},
                                                         color={0,0,127}));
    connect(product5.y, InletValvePID.u_m)
      annotation (Line(points={{-3.6,74},{14,74},{14,81.2}}, color={0,0,127}));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}),
      Diagram(graphics={Text(
            extent={{-98,-38},{-54,-44}},
            textColor={28,108,200},
            textString="Don't set lower bound lower than -9
"),   Line(points={{-70,-42},{-64,-46}}, color={28,108,200})}));
  end CS_TES_HT_Power_ANL;

  model CS_Dummy

    extends BaseClasses.Partial_ControlSystem;

  equation

  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Dummy;

  model ED_Dummy

    extends BaseClasses.Partial_EventDriver;

  equation

  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end ED_Dummy;
end ControlSystems;
