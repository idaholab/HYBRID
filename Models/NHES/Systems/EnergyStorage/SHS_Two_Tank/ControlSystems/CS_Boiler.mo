within NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems;
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
