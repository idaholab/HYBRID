within NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems;
model CS_InputSetpoint
  extends
    NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Math.Gain Q_normal_gain(k=0.25e-8)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Math.Gain Q_normal_gain1(k=0.25e-8) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,-10})));
  TRANSFORM.Controls.LimPID
                       PID_TCV_opening(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=-1,
    k=0.1,
    Ti=95) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Logical.Switch switch_Q_setpoint
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Sources.Constant TCV_opening_nominal(k=0.5)
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Blocks.Math.Add TCV_opening
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Sources.ContinuousClock clock
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Modelica.Blocks.Sources.Constant TCVDelay(k=delayStartTCV)
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  parameter SI.Time delayStartTCV=100 "Delay TCV control";
  Modelica.Blocks.Logical.Switch switch_Q_setpoint1
    annotation (Placement(transformation(extent={{64,20},{84,40}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Blocks.Sources.Constant BV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-14,-312},{6,-292}})));
  Modelica.Blocks.Sources.Constant TDV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{-14,-282},{6,-262}})));
  Modelica.Blocks.Sources.Constant BV_TCV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-14,-342},{6,-322}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Mass_Flow(k=85.0)
    annotation (Placement(transformation(extent={{-12,-132},{8,-112}})));
  Modelica.Blocks.Sources.Constant Diverter_Valve_Position(k=0.5)
    annotation (Placement(transformation(extent={{-12,-192},{8,-172}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Speed(k=3000)
    annotation (Placement(transformation(extent={{-12,-162},{8,-142}})));
  Modelica.Blocks.Sources.Constant Discharge_Throttle_On_Off(k=0.5)
    annotation (Placement(transformation(extent={{-14,-222},{6,-202}})));
  Modelica.Blocks.Sources.Constant LPT_Valve_Opening(k=0.1)
    annotation (Placement(transformation(extent={{92,-190},{72,-170}})));
  Modelica.Blocks.Sources.Constant TBV_Opening(k=0.1)
    annotation (Placement(transformation(extent={{92,-250},{72,-230}})));
  Modelica.Blocks.Sources.Constant TCV_SHS_Opening(k=0.1)
    annotation (Placement(transformation(extent={{92,-220},{72,-200}})));
  Modelica.Blocks.Sources.Constant SHS_Throttle(k=0.1)
    annotation (Placement(transformation(extent={{92,-280},{72,-260}})));
  Modelica.Blocks.Sources.Constant LPT2_BV(k=0.1)
    annotation (Placement(transformation(extent={{92,-310},{72,-290}})));
  Modelica.Blocks.Sources.Constant LPT1_BV(k=0.1)
    annotation (Placement(transformation(extent={{92,-340},{72,-320}})));
  TRANSFORM.Blocks.RealExpression Condensor_Outflow
    annotation (Placement(transformation(extent={{-70,-340},{-50,-320}})));
  TRANSFORM.Blocks.RealExpression Extraction_Flow
    annotation (Placement(transformation(extent={{-70,-326},{-50,-306}})));
  TRANSFORM.Blocks.RealExpression Feedwater_Temperature
    annotation (Placement(transformation(extent={{-70,-312},{-50,-292}})));
  TRANSFORM.Blocks.RealExpression SHS_Return_T
    annotation (Placement(transformation(extent={{-70,-280},{-50,-260}})));
  TRANSFORM.Blocks.RealExpression Steam_Pressure
    annotation (Placement(transformation(extent={{-70,-264},{-50,-244}})));
  TRANSFORM.Blocks.RealExpression Steam_Temperature
    annotation (Placement(transformation(extent={{-70,-246},{-50,-226}})));
  TRANSFORM.Blocks.RealExpression Steam_turbine_inlet_pressure
    annotation (Placement(transformation(extent={{-70,-194},{-50,-174}})));
  TRANSFORM.Blocks.RealExpression massflow_LPTv
    annotation (Placement(transformation(extent={{-70,-212},{-50,-192}})));
equation
  connect(switch_Q_setpoint.y, Q_normal_gain1.u)
    annotation (Line(points={{-39,-10},{-2,-10}}, color={0,0,127}));
  connect(Q_normal_gain1.y, PID_TCV_opening.u_m)
    annotation (Line(points={{21,-10},{30,-10},{30,18}}, color={0,0,127}));
  connect(TCV_opening_nominal.y, TCV_opening.u1) annotation (Line(points={{41,90},
          {50,90},{50,76},{98,76}}, color={0,0,127}));
  connect(Q_normal_gain.y, PID_TCV_opening.u_s)
    annotation (Line(points={{1,30},{18,30}}, color={0,0,127}));
  connect(clock.y, less.u1) annotation (Line(points={{-119,10},{-110,10},{-110,
          -10},{-102,-10}}, color={0,0,127}));
  connect(TCVDelay.y, less.u2) annotation (Line(points={{-119,-30},{-110,-30},{-110,
          -18},{-102,-18}}, color={0,0,127}));
  connect(less.y, switch_Q_setpoint.u2) annotation (Line(points={{-79,-10},{-70,
          -10},{-62,-10}}, color={255,0,255}));
  connect(PID_TCV_opening.y, switch_Q_setpoint1.u3) annotation (Line(points={{
          41,30},{50,30},{50,22},{62,22}}, color={0,0,127}));
  connect(switch_Q_setpoint1.u2, switch_Q_setpoint.u2) annotation (Line(points=
          {{62,30},{52,30},{52,10},{-68,10},{-68,-10},{-62,-10}}, color={255,0,
          255}));
  connect(switch_Q_setpoint1.y, TCV_opening.u2) annotation (Line(points={{85,30},
          {90,30},{90,64},{98,64}}, color={0,0,127}));
  connect(const.y, switch_Q_setpoint1.u1) annotation (Line(points={{41,60},{50,
          60},{50,38},{62,38}}, color={0,0,127}));
  connect(sensorBus.W_totalSetpoint, Q_normal_gain.u) annotation (
      Line(
      points={{-30,-100},{-52,-100},{-72,-100},{-72,30},{-22,30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, switch_Q_setpoint.u3) annotation (Line(
      points={{-30,-100},{-72,-100},{-72,-18},{-62,-18}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint, switch_Q_setpoint.u1)
    annotation (Line(
      points={{-30,-100},{-52,-100},{-72,-100},{-72,-2},{-62,-2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TCV, TCV_opening.y) annotation (Line(
      points={{30.1,-99.9},{116,-99.9},{200,-99.9},{200,70},{121,70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV,BV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-302},{7,-302}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TDV,TDV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-272},{7,-272}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV_TCV,BV_TCV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-332},{7,-332}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_OnOff_Throttle,Discharge_Throttle_On_Off. y)
    annotation (Line(
      points={{30,-100},{30,-212},{7,-212}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position,Diverter_Valve_Position. y)
    annotation (Line(
      points={{30,-100},{30,-182},{9,-182}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed,Feed_Pump_Speed. y) annotation (Line(
      points={{30,-100},{30,-152},{9,-152}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_mFlow,Feed_Pump_Mass_Flow. y) annotation (
      Line(
      points={{30,-100},{30,-122},{9,-122}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT1_BV,LPT1_BV. y) annotation (Line(
      points={{30,-100},{30,-330},{71,-330}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT2_BV,LPT2_BV. y) annotation (Line(
      points={{30,-100},{30,-300},{71,-300}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.SHS_throttle,SHS_Throttle. y) annotation (Line(
      points={{30,-100},{30,-270},{71,-270}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV,TBV_Opening. y) annotation (Line(
      points={{30,-100},{30,-240},{71,-240}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_SHS,TCV_SHS_Opening. y) annotation (Line(
      points={{30,-100},{30,-210},{71,-210}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.openingLPTv,LPT_Valve_Opening. y) annotation (Line(
      points={{30,-100},{30,-180},{71,-180}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensor_Output_mflow,Condensor_Outflow. u) annotation (
      Line(
      points={{-30,-100},{-106,-100},{-106,-330},{-72,-330}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Extract_flow,Extraction_Flow. u) annotation (Line(
      points={{-30,-100},{-106,-100},{-106,-316},{-72,-316}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp,Feedwater_Temperature. u) annotation (Line(
      points={{-30,-100},{-106,-100},{-106,-302},{-72,-302}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SHS_Return_T,SHS_Return_T. u) annotation (Line(
      points={{-30,-100},{-106,-100},{-106,-270},{-72,-270}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure,Steam_Pressure. u) annotation (Line(
      points={{-30,-100},{-106,-100},{-106,-254},{-72,-254}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature,Steam_Temperature. u) annotation (Line(
      points={{-30,-100},{-106,-100},{-106,-236},{-72,-236}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.massflow_LPTv, massflow_LPTv.u) annotation (Line(
      points={{-30,-100},{-106,-100},{-106,-202},{-72,-202}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_inlet_steamTurbine, Steam_turbine_inlet_pressure.u)
    annotation (Line(
      points={{-30,-100},{-106,-100},{-106,-184},{-72,-184}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,
            140}})));
end CS_InputSetpoint;
