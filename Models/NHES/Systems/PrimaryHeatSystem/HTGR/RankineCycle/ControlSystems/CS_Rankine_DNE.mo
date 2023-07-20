within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Rankine_DNE

  extends RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-6,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{72,-66},{80,-58}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{52,-66},{60,-58}})));
  Data.CS_HTGR_Pebble_RankineCycle data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=43.75e6)
    annotation (Placement(transformation(extent={{-100,82},{-82,100}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=30,
    yMax=250,
    yMin=25,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{92,-14},{100,-22}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{62,-22},{70,-14}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-2,
    Ti=30,
    yMax=750,
    yMin=-1000,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{62,2},{70,10}})));
  Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
    annotation (Placement(transformation(extent={{36,2},{44,10}})));
  Modelica.Blocks.Sources.Constant const4(k=1500)
    annotation (Placement(transformation(extent={{76,10},{82,16}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{92,6},{100,14}})));
  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-6,
    Ti=15,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{60,90},{68,82}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{44,82},{52,90}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{72,48},{80,56}})));
  Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{58,48},{66,56}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{72,60},{80,68}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{92,62},{100,54}})));
  Modelica.Blocks.Sources.Constant const8(k=1e-6)
    annotation (Placement(transformation(extent={{72,72},{80,80}})));
  BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
    timer(Start_Time=1e-2)
    annotation (Placement(transformation(extent={{72,82},{80,90}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{92,76},{100,84}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{92,30},{100,38}})));
  Modelica.Blocks.Sources.Constant const9(k=150e5)
    annotation (Placement(transformation(extent={{74,28},{86,40}})));
  TRANSFORM.Controls.LimPID     CR1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{72,-44},{80,-52}})));
  Modelica.Blocks.Sources.Constant const10(k=125e6)
    annotation (Placement(transformation(extent={{52,-52},{60,-44}})));
  Modelica.Blocks.Math.Add         add3
    annotation (Placement(transformation(extent={{92,-60},{100,-52}})));
  Modelica.Blocks.Sources.Constant const11(k=-0.01)
    annotation (Placement(transformation(extent={{80,-40},{88,-32}})));
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
  Modelica.Blocks.Sources.RealExpression feedWaterPump_mass(y=0)
    annotation (Placement(transformation(extent={{76,-86},{100,-74}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{60.4,-62},{71.2,-62}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-74},{76,-74},{76,-66.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{70.4,-18},{91.2,-18}},
                                               color={0,0,127}));
  connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{44.4,6},{61.2,
          6}},                color={0,0,127}));
  connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-4},{66,-4},{66,1.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const4.y, add.u1) annotation (Line(points={{82.3,13},{82.3,12.4},
          {91.2,12.4}},            color={0,0,127}));
  connect(FWCP_Speed.y, add.u2) annotation (Line(points={{70.4,6},{80,6},{
          80,7.6},{91.2,7.6}},
                    color={0,0,127}));
  connect(const5.y, Turb_Divert_Valve.u_s)
    annotation (Line(points={{52.4,86},{59.2,86}},   color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
      points={{-30,-100},{-30,100},{64,100},{64,90.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const6.y, TCV_Position.u_s)
    annotation (Line(points={{66.4,52},{71.2,52}},   color={0,0,127}));
  connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
      points={{-30,-100},{-30,47.2},{76,47.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_Position, add1.y) annotation (Line(
      points={{30,-100},{120,-100},{120,58},{100.4,58}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{120,-100},{120,80},{100.4,80}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{68.4,86},
          {71.2,86}},                                                color={0,0,
          127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{86.6,34},{91.2,34}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-30,22},{96,22},{96,29.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{120,-100},{120,34},{100.4,34}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-4},{96,-4},{96,-13.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-18},{100.4,-18}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.thermal_power, CR1.u_m) annotation (Line(
      points={{-30,-100},{-30,-38},{76,-38},{76,-43.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const10.y, CR1.u_s)
    annotation (Line(points={{60.4,-48},{71.2,-48}},
                                                   color={0,0,127}));
  connect(actuatorBus.CR_Reactivity, add3.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-56},{100.4,-56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add3.u2, CR.y) annotation (Line(points={{91.2,-58.4},{82,-58.4},{
          82,-62},{80.4,-62}},
                     color={0,0,127}));
  connect(sensorBus.Core_Outlet_T,coreOutlet_temp. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,60},{-102.4,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure,steam_pressure. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,50},{-102.4,50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Bypass_flow,bypass_massflow. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensate_Pump_Pressure,condensatePump_pressure. u)
    annotation (Line(
      points={{-30,-100},{-120,-100},{-120,30},{-102.4,30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow,core_massflow. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,20},{-102.4,20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp,feedwater_temperature. u) annotation (
      Line(
      points={{-30,-100},{-120,-100},{-120,10},{-102.4,10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.HPT_Outlet_Pressure,hptOutlet_pressure. u) annotation (
      Line(
      points={{-30,-100},{-120,-100},{-120,0},{-102.4,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power,reactor_power. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-10},{-102.4,-10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature,steam_temperature. u) annotation (
      Line(
      points={{-30,-100},{-120,-100},{-120,-20},{-102.4,-20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.feedpressure,feedwater_pressure. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-30},{-102.4,-30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_steam,steam_massflow. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-40},{-102.4,-40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.thermal_power,thermal_power. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-50},{-102.4,-50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TCV_Position.y, add1.u1) annotation (Line(points={{80.4,52},{86,
          52},{86,55.6},{91.2,55.6}}, color={0,0,127}));
  connect(const7.y, add1.u2) annotation (Line(points={{80.4,64},{86,64},{86,
          60.4},{91.2,60.4}}, color={0,0,127}));
  connect(const8.y, add2.u2) annotation (Line(points={{80.4,76},{86,76},{86,
          77.6},{91.2,77.6}}, color={0,0,127}));
  connect(timer.y, add2.u1) annotation (Line(points={{80.56,86},{86,86},{86,
          82.4},{91.2,82.4}}, color={0,0,127}));
  connect(const11.y, add3.u1) annotation (Line(points={{88.4,-36},{90,-36},
          {90,-53.6},{91.2,-53.6}}, color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{120,-100},{120,10},{100.4,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_DNE;
