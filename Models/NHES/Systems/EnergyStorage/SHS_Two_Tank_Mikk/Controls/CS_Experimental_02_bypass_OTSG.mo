within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Controls;
model CS_Experimental_02_bypass_OTSG

  extends BaseClasses.Partial_ControlSystem;
  parameter Real m_flow_rate_steam_trigger = 3.0;

  Data.Data_Default data
    annotation (Placement(transformation(extent={{70,76},{90,96}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
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
    k=1,
    Ti=10,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=0.0,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-34,50},{-26,42}})));
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
  Modelica.Blocks.Sources.Constant one12(k=2.0)
    annotation (Placement(transformation(extent={{-142,8},{-136,14}})));
  Modelica.Blocks.Sources.Constant one10(k=185 + 273.15)
    annotation (Placement(transformation(extent={{-64,40},{-58,46}})));
  Modelica.Blocks.Logical.Switch
                               switch2
    annotation (Placement(transformation(extent={{-46,26},{-38,34}})));
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
  connect(PID3.y,product1. u2) annotation (Line(points={{-25.6,46},{-20.8,46},{
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
  connect(PID5.y, add3.u2) annotation (Line(points={{-41.7,-11},{-34,-11},{-34,
          -12.8},{-30.6,-12.8}},
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
  connect(sensorBus.Discharge_Temp, PID3.u_m) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,58},{-42,58},{-42,62},{-30,62},{-30,
          50.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Discharge_Temp, switch2.u3) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,26.8},{-46.8,26.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(one10.y, switch2.u1) annotation (Line(points={{-57.7,43},{-54,43},{
          -54,33.2},{-46.8,33.2}}, color={0,0,127}));
  connect(switch2.y, PID3.u_s) annotation (Line(points={{-37.6,30},{-32,30},{
          -32,28},{-28,28},{-28,38},{-40,38},{-40,46},{-34.8,46}}, color={0,0,
          127}));
  connect(sensorBus.discharging_logical, switch2.u2) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,30},{-46.8,30}},
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
end CS_Experimental_02_bypass_OTSG;
