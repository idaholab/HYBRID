within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Rankine_DNE_PowerManuever

  extends RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-6,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{66,-74},{74,-66}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{46,-74},{54,-66}})));
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
    annotation (Placement(transformation(extent={{92,-24},{100,-32}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{74,-32},{82,-24}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-2,
    Ti=30,
    yMax=750,
    yMin=-1000,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{62,-8},{70,0}})));
  Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
    annotation (Placement(transformation(extent={{36,-8},{44,0}})));
  Modelica.Blocks.Sources.Constant const4(k=1500)
    annotation (Placement(transformation(extent={{76,0},{84,8}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{90,-6},{100,4}})));
  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-6,
    Ti=15,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{36,72},{44,80}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{22,72},{30,80}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{76,38},{84,46}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=0.0*data.Q_Nom,
    rising=600,
    width=1200,
    falling=600,
    period=86400,
    offset=data.Q_Nom,
    startTime=86400 + 900)
    annotation (Placement(transformation(extent={{62,38},{70,46}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{76,50},{84,58}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{92,52},{100,44}})));
  Modelica.Blocks.Sources.Constant const8(k=1e-6)
    annotation (Placement(transformation(extent={{76,62},{84,70}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{92,72},{100,80}})));
  BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
    timer(Start_Time=1e-2)
    annotation (Placement(transformation(extent={{56,72},{64,80}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{92,20},{100,28}})));
  Modelica.Blocks.Sources.Constant const9(k=150e5)
    annotation (Placement(transformation(extent={{76,20},{84,28}})));
  TRANSFORM.Controls.LimPID     CR1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{66,-52},{74,-60}})));
  Modelica.Blocks.Sources.Constant const10(k=125e6)
    annotation (Placement(transformation(extent={{46,-60},{54,-52}})));
  Modelica.Blocks.Math.Add         add3
    annotation (Placement(transformation(extent={{92,-68},{100,-60}})));
  Modelica.Blocks.Sources.Constant const11(k=-0.01)
    annotation (Placement(transformation(extent={{78,-60},{86,-52}})));
  Modelica.Blocks.Math.Add         add4(k2=-1)
    annotation (Placement(transformation(extent={{26,100},{34,108}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold
    annotation (Placement(transformation(extent={{40,100},{48,108}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{52,100},{60,108}})));
  Modelica.Blocks.Sources.Constant const6(k=1.0)
    annotation (Placement(transformation(extent={{40,114},{48,122}})));
  Modelica.Blocks.Sources.Constant const12(k=0.0)
    annotation (Placement(transformation(extent={{40,88},{48,96}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{76,84},{84,92}})));
  BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
    delay1(Ti=0.25)
    annotation (Placement(transformation(extent={{64,100},{72,108}})));
  TRANSFORM.Blocks.RealExpression coreOutlet_temp
    annotation (Placement(transformation(extent={{-100,54},{-76,66}})));
  TRANSFORM.Blocks.RealExpression steam_pressure
    annotation (Placement(transformation(extent={{-100,44},{-76,56}})));
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
  TRANSFORM.Blocks.RealExpression thermal_power
    annotation (Placement(transformation(extent={{-100,-56},{-76,-44}})));
  Modelica.Blocks.Sources.RealExpression feedWaterPump_mass(y=0)
    annotation (Placement(transformation(extent={{76,-96},{100,-84}})));
equation

  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-84},{70,-84},{70,-74.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{82.4,-28},{91.2,-28}},
                                               color={0,0,127}));
  connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{44.4,-4},{
          61.2,-4}},          color={0,0,127}));
  connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-14},{66,-14},{66,-8.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const4.y, add.u1) annotation (Line(points={{84.4,4},{84.4,2},{89,
          2}},                     color={0,0,127}));
  connect(FWCP_Speed.y, add.u2) annotation (Line(points={{70.4,-4},{89,-4}},
                    color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-1},{100.5,-1}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const5.y, Turb_Divert_Valve.u_s)
    annotation (Line(points={{30.4,76},{35.2,76}},   color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
      points={{-30,-100},{-30,62},{40,62},{40,71.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(trapezoid.y, TCV_Position.u_s)
    annotation (Line(points={{70.4,42},{75.2,42}},   color={0,0,127}));
  connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
      points={{-30,-100},{-30,34},{80,34},{80,37.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_Position, add1.y) annotation (Line(
      points={{30,-100},{120,-100},{120,48},{100.4,48}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{120,-100},{120,76},{100.4,76}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{44.4,76},
          {55.2,76}},                                                color={0,0,
          127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{84.4,24},{91.2,24}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-30,12},{96,12},{96,19.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{120,-100},{120,24},{100.4,24}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-14},{96,-14},{96,-23.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-28},{100.4,-28}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.thermal_power, CR1.u_m) annotation (Line(
      points={{-30,-100},{-30,-48},{70,-48},{70,-51.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, add3.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-64},{100.4,-64}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add3.u2, CR.y) annotation (Line(points={{91.2,-66.4},{82,-66.4},{
          82,-70},{74.4,-70}},
                     color={0,0,127}));
  connect(add3.u1, const11.y) annotation (Line(points={{91.2,-61.6},{86.4,
          -61.6},{86.4,-56}},          color={0,0,127}));
  connect(sensorBus.Condensate_Pump_Pressure, add4.u2) annotation (Line(
      points={{-30,-100},{-30,101.6},{25.2,101.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.HPT_Outlet_Pressure, add4.u1) annotation (Line(
      points={{-30,-100},{-30,106.4},{25.2,106.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(timer.y, product1.u2) annotation (Line(points={{64.56,76},{70,76},
          {70,85.6},{75.2,85.6}}, color={0,0,127}));
  connect(switch1.y, delay1.u)
    annotation (Line(points={{60.4,104},{63.2,104}}, color={0,0,127}));
  connect(switch1.u2, greaterEqualThreshold.y) annotation (Line(points={{
          51.2,104},{50,104},{50,104},{48.4,104}}, color={255,0,255}));
  connect(const12.y, switch1.u3) annotation (Line(points={{48.4,92},{51.2,
          92},{51.2,100.8}}, color={0,0,127}));
  connect(const6.y, switch1.u1) annotation (Line(points={{48.4,118},{51.2,
          118},{51.2,107.2}}, color={0,0,127}));
  connect(product1.u1, delay1.y) annotation (Line(points={{75.2,90.4},{74,
          90.4},{74,104},{72.56,104}}, color={0,0,127}));
  connect(add4.y, greaterEqualThreshold.u)
    annotation (Line(points={{34.4,104},{39.2,104}}, color={0,0,127}));
  connect(product1.y, add2.u1) annotation (Line(points={{84.4,88},{88,88},{
          88,78.4},{91.2,78.4}}, color={0,0,127}));
  connect(const8.y, add2.u2) annotation (Line(points={{84.4,66},{88,66},{88,
          73.6},{91.2,73.6}}, color={0,0,127}));
  connect(TCV_Position.y, add1.u1) annotation (Line(points={{84.4,42},{88,
          42},{88,45.6},{91.2,45.6}}, color={0,0,127}));
  connect(const7.y, add1.u2) annotation (Line(points={{84.4,54},{88,54},{88,
          50.4},{91.2,50.4}}, color={0,0,127}));
  connect(const10.y, CR1.u_s)
    annotation (Line(points={{54.4,-56},{65.2,-56}}, color={0,0,127}));
  connect(const1.y, CR.u_s)
    annotation (Line(points={{54.4,-70},{65.2,-70}}, color={0,0,127}));
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
  connect(sensorBus.thermal_power,thermal_power. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-50},{-102.4,-50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_DNE_PowerManuever;
