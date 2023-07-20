within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Rankine_DNE_04

  extends RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{72,-74},{80,-66}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{58,-74},{66,-66}})));
  Data.CS_HTGR_Pebble_RankineCycle data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=50,
    Q_Nom=43750000)
    annotation (Placement(transformation(extent={{-100,84},{-82,100}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=30,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{44,-24},{52,-16}})));
  Modelica.Blocks.Sources.Constant const2(k=48)
    annotation (Placement(transformation(extent={{30,-16},{38,-24}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-3,
    Ti=30,
    yMax=750,
    yMin=-1000,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{72,-10},{80,-2}})));
  Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
    annotation (Placement(transformation(extent={{56,-10},{64,-2}})));
  Modelica.Blocks.Sources.Constant const4(k=1500)
    annotation (Placement(transformation(extent={{72,4},{80,12}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{92,-2},{100,6}})));
  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-4,
    Ti=1,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{8,82},{16,74}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-12,72},{0,84}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    Ti=5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{76,42},{84,50}})));
  Modelica.Blocks.Sources.Constant const6(k=43.75e6)
    annotation (Placement(transformation(extent={{62,42},{70,50}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{76,56},{84,64}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{92,56},{100,48}})));
  Modelica.Blocks.Sources.Constant const8(k=1e-6)
    annotation (Placement(transformation(extent={{30,64},{38,72}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{92,68},{100,76}})));
  BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
    timer(Start_Time=1e-2)
    annotation (Placement(transformation(extent={{30,74},{38,82}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{92,22},{100,30}})));
  Modelica.Blocks.Sources.Constant const9(k=150e5)
    annotation (Placement(transformation(extent={{30,20},{42,32}})));
  TRANSFORM.Controls.LimPID     CR1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-10,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{26,-56},{34,-48}})));
  Modelica.Blocks.Sources.Constant const10(k=125e6)
    annotation (Placement(transformation(extent={{12,-56},{20,-48}})));
  Modelica.Blocks.Math.Add         add3
    annotation (Placement(transformation(extent={{92,-70},{100,-62}})));
  Modelica.Blocks.Sources.Constant const11(k=-0.01)
    annotation (Placement(transformation(extent={{72,-60},{80,-52}})));
  Modelica.Blocks.Math.Add3        add3_1
    annotation (Placement(transformation(extent={{62,-36},{70,-28}})));
  Modelica.Blocks.Sources.Constant const12(k=50)
    annotation (Placement(transformation(extent={{12,-36},{20,-28}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{16,96},{36,116}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{60,116},{80,96}})));
  Modelica.Blocks.Sources.Constant const13(k=0.0)
    annotation (Placement(transformation(extent={{30,124},{38,132}})));
  TRANSFORM.Controls.LimPID Blower_Speed1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=10,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{46,-42},{54,-34}})));
  Modelica.Blocks.Sources.Constant const14(k=140e5)
    annotation (Placement(transformation(extent={{26,-42},{34,-34}})));
  BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter(min=10, max=80)
    annotation (Placement(transformation(extent={{80,-42},{100,-22}})));
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
    annotation (Placement(transformation(extent={{76,-94},{100,-82}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{66.4,-70},{71.2,-70}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-82},{76,-82},{76,-74.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{38.4,-20},{40,-20},{40,-20},{43.2,-20}},
                                               color={0,0,127}));
  connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{64.4,-6},{
          71.2,-6}},          color={0,0,127}));
  connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-14},{76,-14},{76,-10.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const4.y, add.u1) annotation (Line(points={{80.4,8},{86,8},{86,
          4.4},{91.2,4.4}},        color={0,0,127}));
  connect(FWCP_Speed.y, add.u2) annotation (Line(points={{80.4,-6},{86,-6},
          {86,-0.4},{91.2,-0.4}},
                    color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{120,-100},{120,2},{100.4,2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const5.y, Turb_Divert_Valve.u_s)
    annotation (Line(points={{0.6,78},{7.2,78}},     color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
      points={{-30,-100},{-30,92},{12,92},{12,82.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const6.y, TCV_Position.u_s)
    annotation (Line(points={{70.4,46},{75.2,46}},   color={0,0,127}));
  connect(actuatorBus.TCV_Position, add1.y) annotation (Line(
      points={{30,-100},{120,-100},{120,52},{100.4,52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add2.u2, const8.y) annotation (Line(points={{91.2,69.6},{40,69.6},
          {40,68},{38.4,68}},                                            color=
          {0,0,127}));
  connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{16.4,78},
          {29.2,78}},                                                color={0,0,
          127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{42.6,26},{91.2,26}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-30,14},{96,14},{96,21.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{120,-100},{120,26},{100.4,26}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.thermal_power, CR1.u_m) annotation (Line(
      points={{-30,-100},{-30,-62},{30,-62},{30,-56.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, add3.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-66},{100.4,-66}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add3_1.u2, const12.y)
    annotation (Line(points={{61.2,-32},{20.4,-32}},  color={0,0,127}));
  connect(add3_1.u1, Blower_Speed.y) annotation (Line(points={{61.2,-28.8},
          {60,-28.8},{60,-30},{52.4,-30},{52.4,-20}},
                                                color={0,0,127}));
  connect(sensorBus.Core_Mass_Flow, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-26},{48,-26},{48,-24.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
      points={{-30,-100},{-30,36},{80,36},{80,41.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Bypass_flow, greaterThreshold.u) annotation (Line(
      points={{-30,-100},{-30,106},{14,106}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(greaterThreshold.y, switch1.u2)
    annotation (Line(points={{37,106},{58,106}}, color={255,0,255}));
  connect(timer.y, switch1.u1) annotation (Line(points={{38.56,78},{40,78},
          {40,80},{42,80},{42,98},{58,98}},color={0,0,127}));
  connect(switch1.y, add2.u1) annotation (Line(points={{81,106},{86,106},{
          86,74.4},{91.2,74.4}},                          color={0,0,127}));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{120,-100},{120,72},{100.4,72}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const14.y, Blower_Speed1.u_s)
    annotation (Line(points={{34.4,-38},{45.2,-38}},  color={0,0,127}));
  connect(sensorBus.Steam_Pressure, Blower_Speed1.u_m) annotation (Line(
      points={{-30,-100},{-30,-62},{50,-62},{50,-42.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Blower_Speed1.y, add3_1.u3) annotation (Line(points={{54.4,-38},{
          54.4,-35.2},{61.2,-35.2}},
                                color={0,0,127}));
  connect(add3_1.y, minMaxFilter.u) annotation (Line(points={{70.4,-32},{78,
          -32}},              color={0,0,127}));
  connect(actuatorBus.PR_Compressor, minMaxFilter.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-32},{101.4,-32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(CR.y, add3.u2) annotation (Line(points={{80.4,-70},{86,-70},{86,
          -68.4},{91.2,-68.4}}, color={0,0,127}));
  connect(add3.u1, const11.y) annotation (Line(points={{91.2,-63.6},{83.6,
          -63.6},{83.6,-56},{80.4,-56}}, color={0,0,127}));
  connect(CR1.u_s, const10.y)
    annotation (Line(points={{25.2,-52},{20.4,-52}}, color={0,0,127}));
  connect(TCV_Position.y, add1.u1) annotation (Line(points={{84.4,46},{88,
          46},{88,49.6},{91.2,49.6}}, color={0,0,127}));
  connect(add1.u2, const7.y) annotation (Line(points={{91.2,54.4},{90,54.4},
          {90,60},{84.4,60}}, color={0,0,127}));
  connect(switch1.u3, const13.y) annotation (Line(points={{58,114},{42,114},
          {42,128},{38.4,128}}, color={0,0,127}));
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
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_DNE_04;
