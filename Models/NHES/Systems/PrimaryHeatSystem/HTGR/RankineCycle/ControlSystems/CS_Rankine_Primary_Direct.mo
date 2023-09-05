within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Rankine_Primary_Direct

  extends RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=4.5e-9,
    Ti=15,
    yb=-8e-3,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{80,2},{100,-18}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{42,-18},{62,2}})));
  replaceable Data.CS_HTGR_Pebble_RankineCycle data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    P_Steam_Ref=15000000)
    annotation (Placement(transformation(extent={{-98,84},{-84,98}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=30,
    yMax=75,
    yMin=45,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{80,46},{100,26}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{42,26},{62,46}})));
  TRANSFORM.Controls.LimPID PID_FeedPump(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    Ti=5,
    Td=0.001,
    yMax=100,
    yMin=5,
    wp=0.5,
    wd=0.5,
    y_start=67,
    k=-8e-6,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1.0,
    k_s=1,
    k_m=1)
    annotation (Placement(transformation(extent={{80,90},{100,70}})));
  Modelica.Blocks.Sources.Constant const3(k=140e5)
    annotation (Placement(transformation(extent={{42,70},{62,90}})));
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
    annotation (Placement(transformation(extent={{76,-48},{100,-36}})));
  Modelica.Blocks.Sources.RealExpression feedPump_speed(y=0)
    annotation (Placement(transformation(extent={{76,-58},{100,-46}})));
  Modelica.Blocks.Sources.RealExpression TBV_position(y=0)
    annotation (Placement(transformation(extent={{76,-68},{100,-56}})));
  Modelica.Blocks.Sources.RealExpression TCV_position(y=0)
    annotation (Placement(transformation(extent={{76,-78},{100,-66}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{63,-8},{78,-8}},
                            color={0,0,127}));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{63,36},{78,36}}, color={0,0,127}));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{112,-100},{112,-8},{101,-8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
      points={{30,-100},{112,-100},{112,36},{101,36}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.mfeedpump,PID_FeedPump. y) annotation (Line(
      points={{30,-100},{112,-100},{112,80},{101,80}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const3.y, PID_FeedPump.u_s)
    annotation (Line(points={{63,80},{78,80}},   color={0,0,127}));
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
  connect(sensorBus.feedpressure, PID_FeedPump.u_m) annotation (Line(
      points={{-30,-100},{-30,100},{90,100},{90,92}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,56},{90,56},{90,48}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,10},{90,10},{90,4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Primary_Direct;
