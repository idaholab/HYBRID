within NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems;
model CS_L3_HTGR_extraction_logan

  extends
    NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

  replaceable NHES.Systems.BalanceOfPlant.RankineCycle.Data.Data_L3 data
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.RealExpression T_in_set(y=data.Tin)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression T_feed_set(y=data.Tfeed)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.RealExpression P_in_set(y=data.HPT_p_in)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  replaceable Modelica.Blocks.Sources.RealExpression Steam_Extraction
    annotation (choices(
      choice(redeclare Modelica.Blocks.Sources.Ramp Steam_Extraction),
      choice(redeclare Modelica.Blocks.Sources.Step Steam_Extraction),
      choice(redeclare Modelica.Blocks.Sources.Sine Steam_Extraction),
      choice(redeclare Modelica.Blocks.Sources.Trapezoid Steam_Extraction)), Placement(
        transformation(extent={{-100,-40},{-80,-20}})));
  TRANSFORM.Controls.LimPID FeedPump_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-4,
    Ti=10,
    yMax=2*data.mdot_total,
    yMin=data.mdot_total*0.5)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  TRANSFORM.Controls.LimPID TCV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-10,
    Ti=360,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-12,0},{8,20}})));
  TRANSFORM.Controls.LimPID LPT1_BV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    Ti=300,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  TRANSFORM.Controls.LimPID LPT2_BV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=20,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=data.HPT_p_in, uHigh=
        data.p_dump)
    annotation (Placement(transformation(extent={{-74,-130},{-54,-150}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-34,-150},{-14,-130}})));
  Modelica.Blocks.Sources.RealExpression P_dump_open0(y=0)
    annotation (Placement(transformation(extent={{-74,-174},{-54,-154}})));
  Modelica.Blocks.Sources.RealExpression P_dump_open1(y=1)
    annotation (Placement(transformation(extent={{-76,-128},{-56,-108}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-1,
    duration=4000,
    offset=1,
    startTime=8000)
    annotation (Placement(transformation(extent={{-36,-174},{-16,-154}})));
  Modelica.Blocks.Math.Product
                           product1
    annotation (Placement(transformation(extent={{4,-156},{24,-136}})));
  Modelica.Blocks.Sources.RealExpression T_in_set1(y=data.mdot_total)
    annotation (Placement(transformation(extent={{2,64},{22,84}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{38,72},{58,92}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=4000)
    annotation (Placement(transformation(extent={{-10,114},{10,134}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-54,60},{-34,80}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{42,20},{62,40}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep1(startTime=1200000)
    annotation (Placement(transformation(extent={{86,74},{106,94}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{134,32},{154,52}})));
  Modelica.Blocks.Sources.RealExpression T_in_set2(y=0.03)
    annotation (Placement(transformation(extent={{100,24},{120,44}})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{-14,-76},{6,-56}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep2(startTime=1.2e6)
    annotation (Placement(transformation(extent={{30,-22},{50,-2}})));
  Modelica.Blocks.Logical.Switch switch7
    annotation (Placement(transformation(extent={{78,-64},{98,-44}})));
  Modelica.Blocks.Sources.Ramp           ext_pos_start(
    height=0,
    duration=1000,
    startTime=2000)
    annotation (Placement(transformation(extent={{-152,-68},{-132,-48}})));
  Modelica.Blocks.Sources.Constant BV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{0,-274},{20,-254}})));
  Modelica.Blocks.Sources.Constant TDV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{0,-244},{20,-224}})));
  Modelica.Blocks.Sources.Constant BV_TCV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{82,-246},{62,-226}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Mass_Flow(k=85.0)
    annotation (Placement(transformation(extent={{80,-128},{60,-108}})));
  Modelica.Blocks.Sources.Constant Diverter_Valve_Position(k=0.5)
    annotation (Placement(transformation(extent={{2,-184},{22,-164}})));
  Modelica.Blocks.Sources.Constant Discharge_Throttle_On_Off(k=0.5)
    annotation (Placement(transformation(extent={{0,-214},{20,-194}})));
  Modelica.Blocks.Sources.Constant LPT_Valve_Opening(k=0.1)
    annotation (Placement(transformation(extent={{82,-156},{62,-136}})));
  Modelica.Blocks.Sources.Constant TCV_SHS_Opening(k=0.1)
    annotation (Placement(transformation(extent={{82,-186},{62,-166}})));
  Modelica.Blocks.Sources.Constant SHS_Throttle(k=0.1)
    annotation (Placement(transformation(extent={{82,-216},{62,-196}})));
  TRANSFORM.Blocks.RealExpression Condensor_Outflow
    annotation (Placement(transformation(extent={{-98,-214},{-78,-194}})));
  TRANSFORM.Blocks.RealExpression Power
    annotation (Placement(transformation(extent={{-98,-198},{-78,-178}})));
  TRANSFORM.Blocks.RealExpression SHS_Return_T
    annotation (Placement(transformation(extent={{-98,-182},{-78,-162}})));
  TRANSFORM.Blocks.RealExpression W_total_setpoint
    annotation (Placement(transformation(extent={{-98,-166},{-78,-146}})));
  TRANSFORM.Blocks.RealExpression Steam_turbine_inlet_pressure
    annotation (Placement(transformation(extent={{-98,-132},{-78,-112}})));
  TRANSFORM.Blocks.RealExpression massflow_LPTv
    annotation (Placement(transformation(extent={{-98,-228},{-78,-208}})));
equation

  connect(T_feed_set.y, LPT2_BV_PID.u_s)
    annotation (Line(points={{-79,50},{-12,50}}, color={0,0,127}));
  connect(P_in_set.y, TCV_PID.u_s)
    annotation (Line(points={{-79,10},{-14,10}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, TCV_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-10},{-2,-10},{-2,-2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.opening_TCV, TCV_PID.y) annotation (Line(
      points={{30.1,-99.9},{30,-99.9},{30,10},{9,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_in_set.y, FeedPump_PID.u_s)
    annotation (Line(points={{-79,90},{-12,90}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2)
    annotation (Line(points={{-53,-140},{-36,-140}},
                                                  color={255,0,255}));
  connect(sensorBus.Steam_Pressure, hysteresis.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-140},{-76,-140}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(P_dump_open0.y, switch1.u3) annotation (Line(points={{-53,-164},{-44,
          -164},{-44,-148},{-36,-148}},
                                      color={0,0,127}));
  connect(switch1.u1, P_dump_open1.y) annotation (Line(points={{-36,-132},{-48,
          -132},{-48,-118},{-55,-118}},
                                    color={0,0,127}));
  connect(ramp.y, product1.u2) annotation (Line(points={{-15,-164},{-6,-164},{
          -6,-152},{2,-152}},  color={0,0,127}));
  connect(actuatorBus.TBV, product1.y) annotation (Line(
      points={{30,-100},{30,-146},{25,-146}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch1.y, product1.u1) annotation (Line(points={{-13,-140},{2,-140}},
                                color={0,0,127}));
  connect(FeedPump_PID.y, switch2.u1)
    annotation (Line(points={{11,90},{36,90}}, color={0,0,127}));
  connect(switch2.u3, T_in_set1.y)
    annotation (Line(points={{36,74},{23,74}}, color={0,0,127}));
  connect(booleanStep.y, switch2.u2) annotation (Line(points={{11,124},{36,
          124},{36,82}}, color={255,0,255}));
  connect(actuatorBus.Feed_Pump_Speed, switch2.y) annotation (Line(
      points={{30,-100},{30,44},{74,44},{74,82},{59,82}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanStep.y, switch3.u2) annotation (Line(points={{11,124},{16,
          124},{16,106},{-28,106},{-28,82},{-62,82},{-62,70},{-56,70}},
        color={255,0,255}));
  connect(switch3.y, FeedPump_PID.u_m) annotation (Line(points={{-33,70},{
          -18,70},{-18,78},{0,78}}, color={0,0,127}));
  connect(sensorBus.Steam_Temperature, switch3.u1) annotation (Line(
      points={{-30,-100},{-30,44},{-72,44},{-72,80},{-56,80},{-56,78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_in_set.y, switch3.u3) annotation (Line(points={{-79,90},{-64,90},
          {-64,62},{-56,62}}, color={0,0,127}));
  connect(booleanStep1.y,switch5. u2)
    annotation (Line(points={{107,84},{132,84},{132,42}}, color={255,0,255}));
  connect(booleanStep1.y,switch4. u2) annotation (Line(points={{107,84},{112,84},
          {112,50},{76,50},{76,14},{32,14},{32,30},{40,30}},
                                                color={255,0,255}));
  connect(T_feed_set.y,switch4. u3) annotation (Line(points={{-79,50},{-20,50},
          {-20,26},{32,26},{32,22},{40,22}},
                              color={0,0,127}));
  connect(sensorBus.Feedwater_Temp,switch4. u1) annotation (Line(
      points={{-30,-100},{-30,28},{26,28},{26,46},{40,46},{40,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch4.y, LPT2_BV_PID.u_m) annotation (Line(points={{63,30},{63,46},
          {16,46},{16,30},{0,30},{0,38}},   color={0,0,127}));
  connect(LPT2_BV_PID.y,switch5. u1) annotation (Line(points={{11,50},{124,50},
          {124,58},{132,58},{132,50}},
                              color={0,0,127}));
  connect(T_in_set2.y,switch5. u3)
    annotation (Line(points={{121,34},{132,34}}, color={0,0,127}));
  connect(actuatorBus.LPT2_BV, switch5.y) annotation (Line(
      points={{30,-100},{30,12},{162,12},{162,42},{155,42}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Steam_Extraction.y, LPT1_BV_PID.u_s)
    annotation (Line(points={{-79,-30},{-12,-30}}, color={0,0,127}));
  connect(booleanStep2.y, switch7.u2)
    annotation (Line(points={{51,-12},{76,-12},{76,-54}}, color={255,0,255}));
  connect(booleanStep2.y, switch6.u2) annotation (Line(points={{51,-12},{56,-12},
          {56,-34},{16,-34},{16,-50},{-24,-50},{-24,-66},{-16,-66}}, color={255,
          0,255}));
  connect(Steam_Extraction.y, switch6.u3) annotation (Line(points={{-79,-30},{
          -28,-30},{-28,-74},{-16,-74}}, color={0,0,127}));
  connect(switch6.y, LPT1_BV_PID.u_m) annotation (Line(points={{7,-66},{7,-48},
          {-16,-48},{-16,-42},{0,-42}}, color={0,0,127}));
  connect(actuatorBus.LPT1_BV, switch7.y) annotation (Line(
      points={{30,-100},{68,-100},{68,-80},{118,-80},{118,-54},{99,-54}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Extract_flow, switch6.u1) annotation (Line(
      points={{-30,-100},{-30,-58},{-16,-58}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(LPT1_BV_PID.y, switch7.u1) annotation (Line(points={{11,-30},{66,-30},
          {66,-46},{76,-46}}, color={0,0,127}));
  connect(ext_pos_start.y, switch7.u3) annotation (Line(points={{-131,-58},{-22,
          -58},{-22,-52},{66,-52},{66,-62},{76,-62}}, color={0,0,127}));
  connect(actuatorBus.opening_BV,BV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-264},{21,-264}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TDV,TDV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-234},{21,-234}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_OnOff_Throttle,Discharge_Throttle_On_Off. y)
    annotation (Line(
      points={{30,-100},{30,-204},{21,-204}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position,Diverter_Valve_Position. y)
    annotation (Line(
      points={{30,-100},{30,-174},{23,-174}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_mFlow,Feed_Pump_Mass_Flow. y) annotation (
      Line(
      points={{30,-100},{30,-118},{59,-118}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.SHS_throttle,SHS_Throttle. y) annotation (Line(
      points={{30,-100},{30,-206},{61,-206}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_SHS,TCV_SHS_Opening. y) annotation (Line(
      points={{30,-100},{30,-176},{61,-176}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.openingLPTv,LPT_Valve_Opening. y) annotation (Line(
      points={{30,-100},{30,-146},{61,-146}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensor_Output_mflow,Condensor_Outflow. u) annotation (
      Line(
      points={{-30,-100},{-120,-100},{-120,-204},{-100,-204}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power,Power. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-188},{-100,-188}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SHS_Return_T,SHS_Return_T. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-172},{-100,-172}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint,W_total_setpoint. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-156},{-100,-156}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.massflow_LPTv,massflow_LPTv. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-218},{-100,-218}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_inlet_steamTurbine,Steam_turbine_inlet_pressure. u)
    annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-122},{-100,-122}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV_TCV, BV_TCV_openingNominal.y) annotation (Line(
      points={{30,-100},{30,-236},{61,-236}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    experiment(
      StopTime=1000,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"));
end CS_L3_HTGR_extraction_logan;
