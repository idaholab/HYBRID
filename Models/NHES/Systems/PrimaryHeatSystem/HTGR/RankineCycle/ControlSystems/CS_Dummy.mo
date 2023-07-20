within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Dummy

  extends RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Blocks.RealExpression coreOutlet_temp
    annotation (Placement(transformation(extent={{-100,54},{-76,66}})));
  TRANSFORM.Blocks.RealExpression steam_pressure
    annotation (Placement(transformation(extent={{-100,44},{-76,56}})));
  TRANSFORM.Blocks.RealExpression bypass_massflow
    annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
  TRANSFORM.Blocks.RealExpression condensatePump_pressure
    annotation (Placement(transformation(extent={{-100,24},{-76,36}})));
  TRANSFORM.Blocks.RealExpression core_massflow
    annotation (Placement(transformation(extent={{-100,14},{-76,26}})));
  TRANSFORM.Blocks.RealExpression feedwater_temperature
    annotation (Placement(transformation(extent={{-100,4},{-76,16}})));
  TRANSFORM.Blocks.RealExpression hptOutlet_pressure
    annotation (Placement(transformation(extent={{-100,-6},{-76,6}})));
  TRANSFORM.Blocks.RealExpression reactor_power
    annotation (Placement(transformation(extent={{-100,-16},{-76,-4}})));
  TRANSFORM.Blocks.RealExpression steam_temperature
    annotation (Placement(transformation(extent={{-100,-26},{-76,-14}})));
  TRANSFORM.Blocks.RealExpression feedwater_pressure
    annotation (Placement(transformation(extent={{-100,-36},{-76,-24}})));
  TRANSFORM.Blocks.RealExpression steam_massflow
    annotation (Placement(transformation(extent={{-100,-46},{-76,-34}})));
  TRANSFORM.Blocks.RealExpression thermal_power
    annotation (Placement(transformation(extent={{-100,-56},{-76,-44}})));
  Modelica.Blocks.Sources.RealExpression divertValve_position(y=0)
    annotation (Placement(transformation(extent={{76,44},{100,56}})));
  Modelica.Blocks.Sources.RealExpression reactorCore_reactivity(y=0)
    annotation (Placement(transformation(extent={{76,54},{100,66}})));
  Modelica.Blocks.Sources.RealExpression feedPump_speed(y=0)
    annotation (Placement(transformation(extent={{76,34},{100,46}})));
  Modelica.Blocks.Sources.RealExpression compressor_PR(y=0)
    annotation (Placement(transformation(extent={{76,24},{100,36}})));
  Modelica.Blocks.Sources.RealExpression TBV_position(y=0)
    annotation (Placement(transformation(extent={{76,14},{100,26}})));
  Modelica.Blocks.Sources.RealExpression TCV_position(y=0)
    annotation (Placement(transformation(extent={{76,4},{100,16}})));
  Modelica.Blocks.Sources.RealExpression feedWaterPump_mass(y=0)
    annotation (Placement(transformation(extent={{76,-6},{100,6}})));
  Data.CS_Dummy data
    annotation (Placement(transformation(extent={{-98,84},{-82,98}})));
equation

  connect(sensorBus.Core_Outlet_T, coreOutlet_temp.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,60},{-102.4,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, steam_pressure.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,50},{-102.4,50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Bypass_flow, bypass_massflow.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensate_Pump_Pressure, condensatePump_pressure.u)
    annotation (Line(
      points={{-30,-100},{-120,-100},{-120,30},{-102.4,30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, core_massflow.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,20},{-102.4,20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, feedwater_temperature.u) annotation (
      Line(
      points={{-30,-100},{-120,-100},{-120,10},{-102.4,10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.HPT_Outlet_Pressure, hptOutlet_pressure.u) annotation (
      Line(
      points={{-30,-100},{-120,-100},{-120,0},{-102.4,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, reactor_power.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-10},{-102.4,-10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature, steam_temperature.u) annotation (
      Line(
      points={{-30,-100},{-120,-100},{-120,-20},{-102.4,-20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.feedpressure, feedwater_pressure.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-30},{-102.4,-30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_steam, steam_massflow.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-40},{-102.4,-40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.thermal_power, thermal_power.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-50},{-102.4,-50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, divertValve_position.y)
    annotation (Line(
      points={{30,-100},{120,-100},{120,50},{101.2,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, reactorCore_reactivity.y) annotation (
      Line(
      points={{30,-100},{120,-100},{120,60},{101.2,60}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed, feedPump_speed.y) annotation (Line(
      points={{30,-100},{120,-100},{120,40},{101.2,40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, compressor_PR.y) annotation (Line(
      points={{30,-100},{120,-100},{120,30},{101.2,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV, TBV_position.y) annotation (Line(
      points={{30,-100},{120,-100},{120,20},{101.2,20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_Position, TCV_position.y) annotation (Line(
      points={{30,-100},{120,-100},{120,10},{101.2,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.mfeedpump, feedWaterPump_mass.y) annotation (Line(
      points={{30,-100},{120,-100},{120,0},{101.2,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Dummy;
