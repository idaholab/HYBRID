within NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems;
model CS_NoFeedHeat_mFlow_Control

  // Modified from CS_SmallCycle_NoFeedHeat_Argonne

  extends
    NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand_large
  annotation(Dialog(tab="General"));

  replaceable NHES.Systems.BalanceOfPlant.RankineCycle.Data.TES_Setpoints data(
    p_steam=1200000,
    p_steam_vent=15000000,
    T_Steam_Ref=579.75,
    Q_Nom=48.57e6,
    T_Feedwater=421.15,
    T_SHS_Return=491.15)
    annotation (Placement(transformation(extent={{64,42},{78,56}})));
  Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  TRANSFORM.Controls.LimPID FWP_mFlow(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=5,
    Td=0.1,
    yMax=50,
    yMin=0.9,
    wd=1,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-28,14},{-8,34}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{-14,44},{-6,52}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Sources.Constant const11(k=1e-4)
    annotation (Placement(transformation(extent={{-4,-56},{4,-48}})));
  Modelica.Blocks.Math.Add         add4
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter(min=0, max=1)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=electric_demand_large)
    annotation (Placement(transformation(extent={{-74,18},{-60,30}})));
  TRANSFORM.Controls.LimPID TCV_SHS(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=-1e-9,
    Ti=1,
    Td=0.1,
    yMax=1 - const11.k,
    yMin=0,
    wd=1,
    Ni=0.9,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Modelica.Blocks.Sources.Constant TCV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{-18,-234},{2,-214}})));
  Modelica.Blocks.Sources.Constant BV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-18,-294},{2,-274}})));
  Modelica.Blocks.Sources.Constant TDV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{-18,-264},{2,-244}})));
  Modelica.Blocks.Sources.Constant BV_TCV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-18,-324},{2,-304}})));
  Modelica.Blocks.Sources.Constant Diverter_Valve_Position(k=0.5)
    annotation (Placement(transformation(extent={{-16,-174},{4,-154}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Speed(k=3000)
    annotation (Placement(transformation(extent={{-16,-144},{4,-124}})));
  Modelica.Blocks.Sources.Constant Discharge_Throttle_On_Off(k=0.5)
    annotation (Placement(transformation(extent={{-18,-204},{2,-184}})));
  Modelica.Blocks.Sources.Constant LPT_Valve_Opening(k=0.1)
    annotation (Placement(transformation(extent={{88,-172},{68,-152}})));
  Modelica.Blocks.Sources.Constant TBV_Opening(k=0.1)
    annotation (Placement(transformation(extent={{88,-232},{68,-212}})));
  Modelica.Blocks.Sources.Constant SHS_Throttle(k=0.1)
    annotation (Placement(transformation(extent={{88,-262},{68,-242}})));
  Modelica.Blocks.Sources.Constant LPT2_BV(k=0.1)
    annotation (Placement(transformation(extent={{88,-292},{68,-272}})));
  Modelica.Blocks.Sources.Constant LPT1_BV(k=0.1)
    annotation (Placement(transformation(extent={{88,-322},{68,-302}})));
  TRANSFORM.Blocks.RealExpression Condensor_Outflow
    annotation (Placement(transformation(extent={{-74,-252},{-54,-232}})));
  TRANSFORM.Blocks.RealExpression Extraction_Flow
    annotation (Placement(transformation(extent={{-74,-238},{-54,-218}})));
  TRANSFORM.Blocks.RealExpression Feedwater_Temperature
    annotation (Placement(transformation(extent={{-74,-224},{-54,-204}})));
  TRANSFORM.Blocks.RealExpression SHS_Return_T
    annotation (Placement(transformation(extent={{-74,-208},{-54,-188}})));
  TRANSFORM.Blocks.RealExpression Steam_Temperature
    annotation (Placement(transformation(extent={{-74,-192},{-54,-172}})));
  TRANSFORM.Blocks.RealExpression W_total_setpoint
    annotation (Placement(transformation(extent={{-74,-174},{-54,-154}})));
  TRANSFORM.Blocks.RealExpression Steam_turbine_inlet_pressure
    annotation (Placement(transformation(extent={{-74,-140},{-54,-120}})));
  TRANSFORM.Blocks.RealExpression massflow_LPTv
    annotation (Placement(transformation(extent={{-74,-158},{-54,-138}})));
equation
  connect(FWP_mFlow.y, add.u2)
    annotation (Line(points={{-7,24},{18,24}}, color={0,0,127}));
  connect(const4.y,add. u1)
    annotation (Line(points={{-5.6,48},{12,48},{12,36},{18,36}},
                                                color={0,0,127}));
  connect(const11.y,add4. u2) annotation (Line(points={{4.4,-52},{12,-52},{
          12,-36},{18,-36}},
                   color={0,0,127}));
  connect(add4.u1,minMaxFilter. y)
    annotation (Line(points={{18,-24},{8,-24},{8,-30},{1.4,-30}},
                                                   color={0,0,127}));
  connect(minMaxFilter.u, TCV_SHS.y)
    annotation (Line(points={{-22,-30},{-29,-30}},
                                                 color={0,0,127}));
  connect(realExpression.y, FWP_mFlow.u_s)
    annotation (Line(points={{-59.3,24},{-30,24}}, color={0,0,127}));
  connect(sensorBus.Power, FWP_mFlow.u_m) annotation (Line(
      points={{-30,-100},{-30,-70},{-86,-70},{-86,12},{-18,12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const3.y, TCV_SHS.u_s)
    annotation (Line(points={{-59,-30},{-52,-30}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, TCV_SHS.u_m) annotation (Line(
      points={{-30,-100},{-30,-50},{-40,-50},{-40,-42}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
      points={{30,-100},{30,-70},{48,-70},{48,-30},{41,-30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Feed_Pump_mFlow, add.y) annotation (Line(
      points={{30,-100},{30,-72},{50,-72},{50,30},{41,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.opening_TCV,TCV_openingNominal. y) annotation (
     Line(
      points={{30.1,-99.9},{30.1,-224},{3,-224}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV,BV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-284},{3,-284}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TDV,TDV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-254},{3,-254}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_OnOff_Throttle,Discharge_Throttle_On_Off. y)
    annotation (Line(
      points={{30,-100},{30,-194},{3,-194}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position,Diverter_Valve_Position. y)
    annotation (Line(
      points={{30,-100},{30,-164},{5,-164}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed,Feed_Pump_Speed. y) annotation (Line(
      points={{30,-100},{30,-134},{5,-134}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT1_BV,LPT1_BV. y) annotation (Line(
      points={{30,-100},{30,-312},{67,-312}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT2_BV,LPT2_BV. y) annotation (Line(
      points={{30,-100},{30,-282},{67,-282}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.SHS_throttle,SHS_Throttle. y) annotation (Line(
      points={{30,-100},{30,-252},{67,-252}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV,TBV_Opening. y) annotation (Line(
      points={{30,-100},{30,-222},{67,-222}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.openingLPTv,LPT_Valve_Opening. y) annotation (Line(
      points={{30,-100},{30,-162},{67,-162}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensor_Output_mflow,Condensor_Outflow. u) annotation (
      Line(
      points={{-30,-100},{-110,-100},{-110,-242},{-76,-242}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Extract_flow,Extraction_Flow. u) annotation (Line(
      points={{-30,-100},{-110,-100},{-110,-228},{-76,-228}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp,Feedwater_Temperature. u) annotation (Line(
      points={{-30,-100},{-110,-100},{-110,-214},{-76,-214}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SHS_Return_T,SHS_Return_T. u) annotation (Line(
      points={{-30,-100},{-110,-100},{-110,-198},{-76,-198}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature,Steam_Temperature. u) annotation (Line(
      points={{-30,-100},{-110,-100},{-110,-182},{-76,-182}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint,W_total_setpoint. u) annotation (Line(
      points={{-30,-100},{-110,-100},{-110,-164},{-76,-164}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.massflow_LPTv,massflow_LPTv. u) annotation (Line(
      points={{-30,-100},{-110,-100},{-110,-148},{-76,-148}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_inlet_steamTurbine,Steam_turbine_inlet_pressure. u)
    annotation (Line(
      points={{-30,-100},{-110,-100},{-110,-130},{-76,-130}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV_TCV, BV_TCV_openingNominal.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-314},{3,-314}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,60}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,60}})),
    experiment(
      StopTime=200,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end CS_NoFeedHeat_mFlow_Control;
