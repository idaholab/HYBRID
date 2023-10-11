within NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems;
model CS_SmallCycle_NoFeedHeat
  extends
    NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand
  annotation(Dialog(tab="General"));

  replaceable Data.TES_Setpoints data(
    p_steam=1200000,
    p_steam_vent=15000000,
    T_Steam_Ref=579.75,
    Q_Nom=48.57e6,
    T_Feedwater=421.15,
    T_SHS_Return=491.15)
    annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
  Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
    annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2.5e-4,
    Ti=5,
    Td=0.1,
    yMax=2500,
    yMin=0,
    wd=1,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-58,62},{-38,82}})));
  Modelica.Blocks.Sources.Constant const4(k=100)
    annotation (Placement(transformation(extent={{-32,80},{-24,88}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{-16,68},{4,88}})));
  Modelica.Blocks.Sources.Constant const11(k=0.001)
    annotation (Placement(transformation(extent={{134,-10},{126,-2}})));
  Modelica.Blocks.Math.Add         add4
    annotation (Placement(transformation(extent={{106,0},{86,20}})));
  Modelica.Blocks.Math.Add         add7
    annotation (Placement(transformation(extent={{94,48},{74,68}})));
  Modelica.Blocks.Sources.Constant const15(k=0.01)
    annotation (Placement(transformation(extent={{118,38},{110,46}})));
  Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter(max=1 - 0.001)
    annotation (Placement(transformation(extent={{134,6},{114,26}})));
  Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter1(max=1 - 0.01)
    annotation (Placement(transformation(extent={{138,54},{118,74}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=electric_demand - data.Q_Nom)
    annotation (Placement(transformation(extent={{66,-26},{80,-14}})));
  TRANSFORM.Controls.LimPID TCV_SHS(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2.5e-9,
    Ti=5,
    Td=0.1,
    yMax=1,
    yMin=0,
    wd=1,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{164,6},{144,26}})));
  TRANSFORM.Controls.LimPID Discharge_OnOFF(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2.5e-9,
    Ti=5,
    Td=0.1,
    yMax=1,
    yMin=0,
    wd=1,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{184,54},{164,74}})));
  Modelica.Blocks.Sources.Constant BV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-28,-224},{-8,-204}})));
  Modelica.Blocks.Sources.Constant TDV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{-28,-194},{-8,-174}})));
  Modelica.Blocks.Sources.Constant BV_TCV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-28,-254},{-8,-234}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Mass_Flow(k=85.0)
    annotation (Placement(transformation(extent={{-26,-132},{-6,-112}})));
  Modelica.Blocks.Sources.Constant Diverter_Valve_Position(k=0.5)
    annotation (Placement(transformation(extent={{-26,-162},{-6,-142}})));
  Modelica.Blocks.Sources.Constant LPT_Valve_Opening(k=0.1)
    annotation (Placement(transformation(extent={{78,-122},{58,-102}})));
  Modelica.Blocks.Sources.Constant TBV_Opening(k=0.1)
    annotation (Placement(transformation(extent={{78,-182},{58,-162}})));
  Modelica.Blocks.Sources.Constant TCV_SHS_Opening(k=0.1)
    annotation (Placement(transformation(extent={{78,-152},{58,-132}})));
  Modelica.Blocks.Sources.Constant SHS_Throttle(k=0.1)
    annotation (Placement(transformation(extent={{78,-212},{58,-192}})));
  Modelica.Blocks.Sources.Constant LPT2_BV(k=0.1)
    annotation (Placement(transformation(extent={{78,-242},{58,-222}})));
  Modelica.Blocks.Sources.Constant LPT1_BV(k=0.1)
    annotation (Placement(transformation(extent={{78,-272},{58,-252}})));
  TRANSFORM.Blocks.RealExpression Condensor_Outflow
    annotation (Placement(transformation(extent={{-84,-234},{-64,-214}})));
  TRANSFORM.Blocks.RealExpression Extraction_Flow
    annotation (Placement(transformation(extent={{-84,-220},{-64,-200}})));
  TRANSFORM.Blocks.RealExpression Feedwater_Temperature
    annotation (Placement(transformation(extent={{-84,-206},{-64,-186}})));
  TRANSFORM.Blocks.RealExpression SHS_Return_T
    annotation (Placement(transformation(extent={{-84,-192},{-64,-172}})));
  TRANSFORM.Blocks.RealExpression Steam_Temperature
    annotation (Placement(transformation(extent={{-84,-178},{-64,-158}})));
  TRANSFORM.Blocks.RealExpression W_total_setpoint
    annotation (Placement(transformation(extent={{-84,-160},{-64,-140}})));
  TRANSFORM.Blocks.RealExpression Steam_turbine_inlet_pressure
    annotation (Placement(transformation(extent={{-84,-126},{-64,-106}})));
  TRANSFORM.Blocks.RealExpression massflow_LPTv
    annotation (Placement(transformation(extent={{-84,-144},{-64,-124}})));
equation
  connect(sensorBus.Steam_Pressure,FWCP_Speed. u_m) annotation (Line(
      points={{-30,-100},{-118,-100},{-118,40},{-48,40},{-48,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const3.y,FWCP_Speed. u_s)
    annotation (Line(points={{-69,72},{-60,72}}, color={0,0,127}));
  connect(FWCP_Speed.y,add. u2)
    annotation (Line(points={{-37,72},{-18,72}},
                                               color={0,0,127}));
  connect(const4.y,add. u1)
    annotation (Line(points={{-23.6,84},{-18,84}},
                                                color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
      points={{30,-100},{30,78},{5,78}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const11.y,add4. u2) annotation (Line(points={{125.6,-6},{118,-6},{118,
          4},{108,4}},
                   color={0,0,127}));
  connect(actuatorBus.TCV_SHS,add4. y) annotation (Line(
      points={{30,-100},{30,10},{85,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add7.u2,const15. y) annotation (Line(points={{96,52},{100,52},{100,46},
          {109.6,46},{109.6,42}},     color={0,0,127}));
  connect(actuatorBus.Discharge_OnOff_Throttle,add7. y) annotation (Line(
      points={{30,-100},{30,58},{73,58}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(minMaxFilter1.y,add7. u1)
    annotation (Line(points={{116.6,64},{96,64}},  color={0,0,127}));
  connect(add4.u1,minMaxFilter. y)
    annotation (Line(points={{108,16},{112.6,16}}, color={0,0,127}));
  connect(minMaxFilter.u, TCV_SHS.y)
    annotation (Line(points={{136,16},{143,16}}, color={0,0,127}));
  connect(sensorBus.Power, TCV_SHS.u_m) annotation (Line(
      points={{-30,-100},{-30,-52},{154,-52},{154,4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(realExpression.y, TCV_SHS.u_s) annotation (Line(points={{80.7,-20},{
          170,-20},{170,16},{166,16}}, color={0,0,127}));
  connect(minMaxFilter1.u, Discharge_OnOFF.y)
    annotation (Line(points={{140,64},{163,64}}, color={0,0,127}));
  connect(sensorBus.Power, Discharge_OnOFF.u_m) annotation (Line(
      points={{-30,-100},{-30,-52},{184,-52},{184,38},{174,38},{174,52}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(realExpression.y, Discharge_OnOFF.u_s) annotation (Line(points={{80.7,
          -20},{204,-20},{204,64},{186,64}}, color={0,0,127}));
  connect(actuatorBus.opening_BV,BV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-214},{-7,-214}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TDV,TDV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-184},{-7,-184}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV_TCV,BV_TCV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-244},{-7,-244}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position,Diverter_Valve_Position. y)
    annotation (Line(
      points={{30,-100},{30,-152},{-5,-152}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_mFlow,Feed_Pump_Mass_Flow. y) annotation (
      Line(
      points={{30,-100},{30,-122},{-5,-122}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT1_BV,LPT1_BV. y) annotation (Line(
      points={{30,-100},{30,-262},{57,-262}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT2_BV,LPT2_BV. y) annotation (Line(
      points={{30,-100},{30,-232},{57,-232}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.SHS_throttle,SHS_Throttle. y) annotation (Line(
      points={{30,-100},{30,-202},{57,-202}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV,TBV_Opening. y) annotation (Line(
      points={{30,-100},{30,-172},{57,-172}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_SHS,TCV_SHS_Opening. y) annotation (Line(
      points={{30,-100},{30,-142},{57,-142}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.openingLPTv,LPT_Valve_Opening. y) annotation (Line(
      points={{30,-100},{30,-112},{57,-112}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensor_Output_mflow,Condensor_Outflow. u) annotation (
      Line(
      points={{-30,-100},{-120,-100},{-120,-224},{-86,-224}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Extract_flow,Extraction_Flow. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-210},{-86,-210}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp,Feedwater_Temperature. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-196},{-86,-196}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SHS_Return_T,SHS_Return_T. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-182},{-86,-182}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature,Steam_Temperature. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-168},{-86,-168}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint,W_total_setpoint. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-150},{-86,-150}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.massflow_LPTv,massflow_LPTv. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-134},{-86,-134}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_inlet_steamTurbine,Steam_turbine_inlet_pressure. u)
    annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-116},{-86,-116}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
end CS_SmallCycle_NoFeedHeat;
