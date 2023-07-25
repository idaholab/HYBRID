within NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems;
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
"), Line(points={{-70,-42},{-64,-46}}, color={28,108,200})}));
end CS_TES_HT_Power_ANL;
