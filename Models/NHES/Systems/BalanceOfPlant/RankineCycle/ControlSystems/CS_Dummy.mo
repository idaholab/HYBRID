within NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems;
model CS_Dummy
  extends
    NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  Modelica.Blocks.Sources.Constant TCV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Sources.Constant BV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Sources.Constant TDV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Blocks.Sources.Constant BV_TCV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Mass_Flow(k=85.0)
    annotation (Placement(transformation(extent={{-8,130},{12,150}})));
  Modelica.Blocks.Sources.Constant Diverter_Valve_Position(k=0.5)
    annotation (Placement(transformation(extent={{-8,70},{12,90}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Speed(k=3000)
    annotation (Placement(transformation(extent={{-8,100},{12,120}})));
  Modelica.Blocks.Sources.Constant Discharge_Throttle_On_Off(k=0.5)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.Constant LPT_Valve_Opening(k=0.1)
    annotation (Placement(transformation(extent={{96,72},{76,92}})));
  Modelica.Blocks.Sources.Constant TBV_Opening(k=0.1)
    annotation (Placement(transformation(extent={{96,12},{76,32}})));
  Modelica.Blocks.Sources.Constant TCV_SHS_Opening(k=0.1)
    annotation (Placement(transformation(extent={{96,42},{76,62}})));
  Modelica.Blocks.Sources.Constant SHS_Throttle(k=0.1)
    annotation (Placement(transformation(extent={{96,-18},{76,2}})));
  Modelica.Blocks.Sources.Constant LPT2_BV(k=0.1)
    annotation (Placement(transformation(extent={{96,-48},{76,-28}})));
  Modelica.Blocks.Sources.Constant LPT1_BV(k=0.1)
    annotation (Placement(transformation(extent={{96,-78},{76,-58}})));
  TRANSFORM.Blocks.RealExpression Condensor_Outflow
    annotation (Placement(transformation(extent={{-66,-78},{-46,-58}})));
  TRANSFORM.Blocks.RealExpression Extraction_Flow
    annotation (Placement(transformation(extent={{-66,-64},{-46,-44}})));
  TRANSFORM.Blocks.RealExpression Feedwater_Temperature
    annotation (Placement(transformation(extent={{-66,-50},{-46,-30}})));
  TRANSFORM.Blocks.RealExpression Power
    annotation (Placement(transformation(extent={{-66,-34},{-46,-14}})));
  TRANSFORM.Blocks.RealExpression SHS_Return_T
    annotation (Placement(transformation(extent={{-66,-18},{-46,2}})));
  TRANSFORM.Blocks.RealExpression Steam_Pressure
    annotation (Placement(transformation(extent={{-66,-2},{-46,18}})));
  TRANSFORM.Blocks.RealExpression Steam_Temperature
    annotation (Placement(transformation(extent={{-66,16},{-46,36}})));
  TRANSFORM.Blocks.RealExpression W_total_setpoint
    annotation (Placement(transformation(extent={{-66,34},{-46,54}})));
  TRANSFORM.Blocks.RealExpression Steam_turbine_inlet_pressure
    annotation (Placement(transformation(extent={{-66,68},{-46,88}})));
  TRANSFORM.Blocks.RealExpression massflow_LPTv
    annotation (Placement(transformation(extent={{-66,50},{-46,70}})));
equation
  connect(actuatorBus.opening_TCV, TCV_openingNominal.y) annotation (
     Line(
      points={{30.1,-99.9},{30.1,20},{11,20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV, BV_openingNominal.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-40},{11,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TDV, TDV_openingNominal.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-10},{11,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV_TCV, BV_TCV_openingNominal.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-70},{11,-70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_OnOff_Throttle, Discharge_Throttle_On_Off.y)
    annotation (Line(
      points={{30,-100},{30,50},{11,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, Diverter_Valve_Position.y)
    annotation (Line(
      points={{30,-100},{30,80},{13,80}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed, Feed_Pump_Speed.y) annotation (Line(
      points={{30,-100},{30,110},{13,110}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_mFlow, Feed_Pump_Mass_Flow.y) annotation (
      Line(
      points={{30,-100},{30,140},{13,140}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT1_BV, LPT1_BV.y) annotation (Line(
      points={{30,-100},{30,-68},{75,-68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT2_BV, LPT2_BV.y) annotation (Line(
      points={{30,-100},{30,-38},{75,-38}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.SHS_throttle, SHS_Throttle.y) annotation (Line(
      points={{30,-100},{30,-8},{75,-8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV, TBV_Opening.y) annotation (Line(
      points={{30,-100},{30,22},{75,22}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_SHS, TCV_SHS_Opening.y) annotation (Line(
      points={{30,-100},{30,52},{75,52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.openingLPTv, LPT_Valve_Opening.y) annotation (Line(
      points={{30,-100},{30,82},{75,82}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensor_Output_mflow, Condensor_Outflow.u) annotation (
      Line(
      points={{-30,-100},{-102,-100},{-102,-68},{-68,-68}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Extract_flow, Extraction_Flow.u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-54},{-68,-54}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, Feedwater_Temperature.u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-40},{-68,-40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, Power.u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-24},{-68,-24}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SHS_Return_T, SHS_Return_T.u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-8},{-68,-8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, Steam_Pressure.u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,8},{-68,8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature, Steam_Temperature.u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,26},{-68,26}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint, W_total_setpoint.u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,44},{-68,44}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.massflow_LPTv, massflow_LPTv.u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,60},{-68,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_inlet_steamTurbine, Steam_turbine_inlet_pressure.u)
    annotation (Line(
      points={{-30,-100},{-102,-100},{-102,78},{-68,78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_Dummy;
