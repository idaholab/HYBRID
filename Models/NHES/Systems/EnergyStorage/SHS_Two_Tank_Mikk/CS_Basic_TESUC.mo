within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk;
model CS_Basic_TESUC

  extends BaseClasses.Partial_ControlSystem;
  parameter Modelica.Units.SI.Temperature steam_ref;
  input Modelica.Units.SI.MassFlowRate Ref_Charge_Flow "TES should supply expected charging mass flow rate given demand" annotation(Dialog(tab = "General"));
  replaceable Data.Data_CS data
    annotation (Placement(transformation(extent={{-92,18},{-72,38}})), Dialog(tab = "General", choicesAllMatching=true));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
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
<<<<<<< Updated upstream
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=2,
    rising=500,
    width=8500,
    falling=500,
    period=18000,
    offset=0,
    startTime=2000)
    annotation (Placement(transformation(extent={{-56,48},{-44,60}})));
=======
>>>>>>> Stashed changes
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    Discharging_Valve_Position(min=2e-4) annotation (Placement(transformation(
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
  Modelica.Blocks.Sources.Constant one1(k=data.hot_tank_ref_temp)
    annotation (Placement(transformation(extent={{-54,-20},{-48,-14}})));
  Modelica.Blocks.Math.Add add3(k1=0.1)
    annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-48,-6},{-44,-2}})));
  Modelica.Blocks.Sources.Constant one6(k=0.0)
    annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
  TRANSFORM.Controls.LimPID PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2.5e-2,
    Ti=10,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
<<<<<<< Updated upstream
  Modelica.Blocks.Logical.Switch switch_CR1
    annotation (Placement(transformation(extent={{0,32},{20,12}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{-56,14},{-36,34}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=2000)
    annotation (Placement(transformation(extent={{-88,18},{-76,30}})));
  Modelica.Blocks.Sources.Constant delay_Feed(k=1)
    annotation (Placement(transformation(extent={{-88,0},{-76,12}})));
  Modelica.Blocks.Sources.Constant one9(k=0.01)
    annotation (Placement(transformation(extent={{-22,30},{-16,36}})));
=======
  Modelica.Blocks.Sources.Constant one9(k=data.discharge_control_ref_value)
    annotation (Placement(transformation(extent={{-48,54},{-42,60}})));
  Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=Ref_Charge_Flow)
    annotation (Placement(transformation(extent={{-66,-8},{-56,6}})));
>>>>>>> Stashed changes
equation

  connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
          -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
  connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
          -24.8},{-56.6,-24.8}},                                       color={0,
          0,127}));
  connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
          -30.4},{-80.8,-30.4}},   color={0,0,127}));
  connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
          -61.7,-21}},color={0,0,127}));
  connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
      points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
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
  connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,68.4},{-56.8,68.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(one1.y, PID5.u_s) annotation (Line(points={{-47.7,-17},{-44.6,-17}},
                      color={0,0,127}));
  connect(sensorBus.Charge_Temp, PID5.u_m) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-8},{-41,-8},{-41,-13.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
          -12.8},{-30.6,-12.8}},
                               color={0,0,127}));
  connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
          -19.2},{-22,-11},{-23.7,-11}},
                                color={0,0,127}));
  connect(switch1.u3, one6.y) annotation (Line(points={{-48.4,-5.6},{-48.4,-7},{
          -53.9,-7}},  color={0,0,127}));
  connect(switch1.y, PID2.u_s) annotation (Line(points={{-43.8,-4},{-43.8,-3},{-40.6,
          -3}},       color={0,0,127}));
  connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
          -33.7,-3}}, color={0,0,127}));
  connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,6},{-37,6},{-37,0.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-4},{-48.4,-4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points=
         {{-11.7,-21},{-6,-21},{-6,-28},{0,-28},{0,-22}}, color={0,0,127}));
  connect(product1.y, Discharging_Valve_Position.u)
    annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
  connect(sensorBus.Steam_Temp, PID3.u_m) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,44},{-32,44},{-32,53.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
<<<<<<< Updated upstream
  connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points=
         {{-11.7,-21},{-6,-21},{-6,-28},{0,-28},{0,-22}}, color={0,0,127}));
  connect(product1.y, Discharging_Valve_Position.u)
    annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
  connect(delay_Feed.y, greater1.u2) annotation (Line(points={{-75.4,6},{-70,6},
          {-70,8},{-58,8},{-58,16}}, color={0,0,127}));
  connect(clock.y, greater1.u1)
    annotation (Line(points={{-75.4,24},{-58,24}}, color={0,0,127}));
  connect(greater1.y, switch_CR1.u2) annotation (Line(points={{-35,24},{-8,24},
          {-8,22},{-2,22}}, color={255,0,255}));
  connect(one9.y, switch_CR1.u3) annotation (Line(points={{-15.7,33},{-10,33},{
          -10,30},{-2,30}}, color={0,0,127}));
  connect(Charging_Valve_Position_MinMax.y, switch_CR1.u1) annotation (Line(
        points={{23.4,-22},{26,-22},{26,4},{-4,4},{-4,8},{-8,8},{-8,14},{-2,14}},
        color={0,0,127}));
  connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
    annotation (Line(
      points={{30,-100},{30,66},{23.4,66},{23.4,64}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Charge_Valve_Position, switch_CR1.y) annotation (Line(
      points={{30,-100},{30,22},{21,22}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
=======
  connect(PID3.u_s, one9.y) annotation (Line(points={{-36.8,58},{-36.8,57},{-41.7,
          57}}, color={0,0,127}));
  connect(switch1.u1, Level_Hot_Tank2.y) annotation (Line(points={{-48.4,-2.4},{
          -48.4,-2},{-48,-2},{-48,0},{-55.5,0},{-55.5,-1}},
                                          color={0,0,127}));
>>>>>>> Stashed changes
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_Basic_TESUC;
