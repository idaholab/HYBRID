within NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems;
model CS_UserDefined
  extends
    NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real opening_TCV=0.5
    "Valve opening" annotation(Dialog(group="Inputs"));
  input Real opening_TDV=0.5
    "Valve opening" annotation(Dialog(group="Inputs"));
  input Real opening_BV=0.001
    "Valve opening" annotation(Dialog(group="Inputs"));
  input Real opening_BV_TCV=0.001
    "Valve opening" annotation(Dialog(group="Inputs"));

      input Modelica.Units.SI.MassFlowRate m_flow_FWCP=65
    "Feed flow rate" annotation(Dialog(group="Inputs"));
  input Real FWCP_speed=3000
    "Feedwater control pump speed" annotation(Dialog(group="Inputs"));
  input Real Divert_Valve_Position =0.001
    "Steam diverter valve position" annotation(Dialog(group="Inputs"));
  input Real LPT_Valve_Position=0.001
    "Low Pressure Turbine valve position" annotation(Dialog(group="Inputs"));

      input Real TCV_Augment_Position=0.5
    "Augment steam control valve" annotation(Dialog(group="Inputs"));
  input Real Discharge_Throttle_Position=1.0
    "Discharge throttle valve" annotation(Dialog(group="Inputs"));
  input Real TBV_position=0.001
    "Turbine Bypass Valve position" annotation(Dialog(group="Inputs"));
  input Real Augment_Throttle_Position=0.001
    "Augment steam throttle position" annotation(Dialog(group="Inputs"));

      input Real LPT_s1_Bypass=0.5
    "LPT Stage 1 bypass" annotation(Dialog(group="Inputs"));
  input Real LPT_s2_Bypass=0.5
    "LPT Stage 2 bypass" annotation(Dialog(group="Inputs"));


  Modelica.Blocks.Sources.RealExpression TCV_opening(y=opening_TCV)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Sources.RealExpression BV_opening(y=opening_BV)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Sources.RealExpression TDV_opening(y=opening_TDV)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Blocks.Sources.RealExpression BV_TCV_opening(y=opening_BV_TCV)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));

  TRANSFORM.Blocks.RealExpression Condensor_Outflow
    annotation (Placement(transformation(extent={{-66,-88},{-46,-68}})));
  TRANSFORM.Blocks.RealExpression Extraction_Flow
    annotation (Placement(transformation(extent={{-66,-74},{-46,-54}})));
  TRANSFORM.Blocks.RealExpression Feedwater_Temperature
    annotation (Placement(transformation(extent={{-66,-60},{-46,-40}})));
  TRANSFORM.Blocks.RealExpression Power
    annotation (Placement(transformation(extent={{-66,-44},{-46,-24}})));
  TRANSFORM.Blocks.RealExpression SHS_Return_T
    annotation (Placement(transformation(extent={{-66,-28},{-46,-8}})));
  TRANSFORM.Blocks.RealExpression Steam_Pressure
    annotation (Placement(transformation(extent={{-66,-12},{-46,8}})));
  TRANSFORM.Blocks.RealExpression Steam_Temperature
    annotation (Placement(transformation(extent={{-66,6},{-46,26}})));
  TRANSFORM.Blocks.RealExpression W_total_setpoint
    annotation (Placement(transformation(extent={{-66,24},{-46,44}})));
  TRANSFORM.Blocks.RealExpression Steam_turbine_inlet_pressure
    annotation (Placement(transformation(extent={{-66,58},{-46,78}})));
  TRANSFORM.Blocks.RealExpression massflow_LPTv
    annotation (Placement(transformation(extent={{-66,40},{-46,60}})));
  Modelica.Blocks.Sources.RealExpression
                                   Feed_Pump_Mass_Flow(y=m_flow_FWCP)
    annotation (Placement(transformation(extent={{-10,124},{10,144}})));
  Modelica.Blocks.Sources.RealExpression
                                   Feed_Pump_Speed(y=FWCP_speed)
    annotation (Placement(transformation(extent={{-10,94},{10,114}})));
  Modelica.Blocks.Sources.RealExpression
                                   Diverter_Valve_Position(y = Divert_Valve_Position)
    annotation (Placement(transformation(extent={{-10,64},{10,84}})));
  Modelica.Blocks.Sources.RealExpression
                                   LPT_Valve_Opening(y = LPT_Valve_Position)
    annotation (Placement(transformation(extent={{94,66},{74,86}})));
  Modelica.Blocks.Sources.RealExpression
                                   TCV_SHS_Opening(y = TCV_Augment_Position)
    annotation (Placement(transformation(extent={{94,36},{74,56}})));
  Modelica.Blocks.Sources.RealExpression
                                   Discharge_Throttle_On_Off(y = Discharge_Throttle_Position)
    annotation (Placement(transformation(extent={{-12,34},{8,54}})));
  Modelica.Blocks.Sources.RealExpression
                                   TBV_Opening(y = TBV_position)
    annotation (Placement(transformation(extent={{94,6},{74,26}})));
  Modelica.Blocks.Sources.RealExpression
                                   SHS_Throttle(y = Augment_Throttle_Position)
    annotation (Placement(transformation(extent={{94,-24},{74,-4}})));
  Modelica.Blocks.Sources.RealExpression
                                   LPT2_BV(y = LPT_s2_Bypass)
    annotation (Placement(transformation(extent={{94,-54},{74,-34}})));
  Modelica.Blocks.Sources.RealExpression
                                   LPT1_BV(y = LPT_s1_Bypass)
    annotation (Placement(transformation(extent={{94,-84},{74,-64}})));
equation
  connect(actuatorBus.opening_TCV, TCV_opening.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,20},{11,20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV, BV_opening.y) annotation (
      Line(
      points={{30.1,-99.9},{30.1,-40},{11,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TDV, TDV_opening.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-10},{11,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV_TCV, BV_TCV_opening.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-70},{11,-70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensor_Output_mflow,Condensor_Outflow. u) annotation (
      Line(
      points={{-30,-100},{-102,-100},{-102,-78},{-68,-78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Extract_flow,Extraction_Flow. u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-64},{-68,-64}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp,Feedwater_Temperature. u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-50},{-68,-50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power,Power. u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-34},{-68,-34}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SHS_Return_T,SHS_Return_T. u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-18},{-68,-18}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure,Steam_Pressure. u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,-2},{-68,-2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature,Steam_Temperature. u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,16},{-68,16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint, W_total_setpoint.u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,34},{-68,34}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.massflow_LPTv, massflow_LPTv.u) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,50},{-68,50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_inlet_steamTurbine, Steam_turbine_inlet_pressure.u)
    annotation (Line(
      points={{-30,-100},{-102,-100},{-102,68},{-68,68}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_mFlow,Feed_Pump_Mass_Flow. y) annotation (
      Line(
      points={{30,-100},{30,134},{11,134}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed,Feed_Pump_Speed. y) annotation (Line(
      points={{30,-100},{30,104},{11,104}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position,Diverter_Valve_Position. y)
    annotation (Line(
      points={{30,-100},{30,74},{11,74}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.openingLPTv,LPT_Valve_Opening. y) annotation (Line(
      points={{30,-100},{30,76},{73,76}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_SHS,TCV_SHS_Opening. y) annotation (Line(
      points={{30,-100},{30,46},{73,46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_OnOff_Throttle,Discharge_Throttle_On_Off. y)
    annotation (Line(
      points={{30,-100},{30,44},{9,44}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV,TBV_Opening. y) annotation (Line(
      points={{30,-100},{30,16},{73,16}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.SHS_throttle,SHS_Throttle. y) annotation (Line(
      points={{30,-100},{30,-14},{73,-14}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT2_BV,LPT2_BV. y) annotation (Line(
      points={{30,-100},{30,-44},{73,-44}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT1_BV,LPT1_BV. y) annotation (Line(
      points={{30,-100},{30,-74},{73,-74}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_UserDefined;
