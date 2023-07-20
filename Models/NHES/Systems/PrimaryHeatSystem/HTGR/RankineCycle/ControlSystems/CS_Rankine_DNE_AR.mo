within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Rankine_DNE_AR

  extends RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{62,-78},{72,-68}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{46,-78},{56,-68}})));
  Data.CS_HTGR_Pebble_RankineCycle data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=50,
    T_Steam_Ref=838.15,
    Q_Nom=43750000,
    Q_RX_Therm_Nom=200e6,
    T_Feedwater=466.45)
    annotation (Placement(transformation(extent={{-100,84},{-82,100}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=30,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{38,-22},{46,-30}})));
  Modelica.Blocks.Sources.Constant const2(k=78)
    annotation (Placement(transformation(extent={{24,-22},{32,-30}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-3,
    Ti=60,
    yMax=1500,
    yMin=-1000,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{78,-10},{86,-2}})));
  Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
    annotation (Placement(transformation(extent={{62,-10},{70,-2}})));
  Modelica.Blocks.Sources.Constant const4(k=1500)
    annotation (Placement(transformation(extent={{78,4},{86,12}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{92,-4},{100,4}})));
  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-4,
    Ti=1,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{48,82},{56,74}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{34,74},{42,82}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    Ti=5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{68,38},{76,46}})));
  Modelica.Blocks.Sources.Constant const6(k=87.01e6)
    annotation (Placement(transformation(extent={{48,38},{56,46}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{68,52},{76,60}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{92,52},{100,44}})));
  Modelica.Blocks.Sources.Constant const8(k=1e-6)
    annotation (Placement(transformation(extent={{68,64},{76,72}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{92,68},{100,76}})));
  BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
    timer(Start_Time=1e-2)
    annotation (Placement(transformation(extent={{68,74},{76,82}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{92,22},{100,30}})));
  Modelica.Blocks.Sources.Constant const9(k=200e5)
    annotation (Placement(transformation(extent={{78,22},{86,30}})));
  TRANSFORM.Controls.LimPID     CR1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-10,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{22,-52},{30,-60}})));
  Modelica.Blocks.Sources.Constant const10(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{2,-60},{10,-52}})));
  Modelica.Blocks.Math.Add         add3
    annotation (Placement(transformation(extent={{92,-68},{100,-60}})));
  Modelica.Blocks.Sources.Constant const11(k=-0.01)
    annotation (Placement(transformation(extent={{62,-60},{72,-50}})));
  Modelica.Blocks.Math.Add3        add3_1
    annotation (Placement(transformation(extent={{56,-36},{64,-28}})));
  Modelica.Blocks.Sources.Constant const12(k=80)
    annotation (Placement(transformation(extent={{6,-36},{14,-28}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{10,96},{30,116}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{54,116},{74,96}})));
  Modelica.Blocks.Sources.Constant const13(k=0.0)
    annotation (Placement(transformation(extent={{34,124},{42,132}})));
  TRANSFORM.Controls.LimPID Blower_Speed1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=10,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{40,-44},{48,-36}})));
  Modelica.Blocks.Sources.Constant const14(k=165e5)
    annotation (Placement(transformation(extent={{20,-42},{28,-34}})));
  BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter(min=10, max=100)
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
    annotation (Placement(transformation(extent={{76,-98},{100,-86}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{56.5,-73},{61,-73}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-82},{67,-82},{67,-79}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{32.4,-26},{37.2,-26}},
                                               color={0,0,127}));
  connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{70.4,-6},{
          77.2,-6}},          color={0,0,127}));
  connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-14},{82,-14},{82,-10.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const4.y, add.u1) annotation (Line(points={{86.4,8},{86,8},{86,
          2.4},{91.2,2.4}},        color={0,0,127}));
  connect(FWCP_Speed.y, add.u2) annotation (Line(points={{86.4,-6},{91.2,-6},
          {91.2,-2.4}},
                    color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{120,-100},{120,0},{100.4,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const5.y, Turb_Divert_Valve.u_s)
    annotation (Line(points={{42.4,78},{47.2,78}},   color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
      points={{-30,-100},{-30,92},{52,92},{52,82.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const6.y, TCV_Position.u_s)
    annotation (Line(points={{56.4,42},{67.2,42}},   color={0,0,127}));
  connect(actuatorBus.TCV_Position, add1.y) annotation (Line(
      points={{30,-100},{120,-100},{120,48},{100.4,48}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add2.u2, const8.y) annotation (Line(points={{91.2,69.6},{80,69.6},
          {80,68},{76.4,68}},                                            color=
          {0,0,127}));
  connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{56.4,78},
          {67.2,78}},                                                color={0,0,
          127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{86.4,26},{91.2,26}}, color={0,0,127}));
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
      points={{-30,-100},{-30,-46},{26,-46},{26,-51.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const10.y, CR1.u_s)
    annotation (Line(points={{10.4,-56},{21.2,-56}},
                                                   color={0,0,127}));
  connect(actuatorBus.CR_Reactivity, add3.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-64},{100.4,-64}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add3.u2, CR.y) annotation (Line(points={{91.2,-66.4},{78,-66.4},{
          78,-73},{72.5,-73}},
                     color={0,0,127}));
  connect(add3_1.u2, const12.y)
    annotation (Line(points={{55.2,-32},{14.4,-32}},  color={0,0,127}));
  connect(add3_1.u1, Blower_Speed.y) annotation (Line(points={{55.2,-28.8},
          {54,-28.8},{54,-30},{46.4,-30},{46.4,-26}},
                                                color={0,0,127}));
  connect(sensorBus.Core_Mass_Flow, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-18},{42,-18},{42,-21.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
      points={{-30,-100},{-30,32},{72,32},{72,37.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Bypass_flow, greaterThreshold.u) annotation (Line(
      points={{-30,-100},{-30,106},{8,106}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(greaterThreshold.y, switch1.u2)
    annotation (Line(points={{31,106},{52,106}}, color={255,0,255}));
  connect(timer.y, switch1.u1) annotation (Line(points={{76.56,78},{52,78},
          {52,98}},                        color={0,0,127}));
  connect(switch1.y, add2.u1) annotation (Line(points={{75,106},{84,106},{
          84,74.4},{91.2,74.4}},                          color={0,0,127}));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{120,-100},{120,72},{100.4,72}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const14.y, Blower_Speed1.u_s)
    annotation (Line(points={{28.4,-38},{28,-38},{28,-40},{39.2,-40}},
                                                      color={0,0,127}));
  connect(sensorBus.Steam_Pressure, Blower_Speed1.u_m) annotation (Line(
      points={{-30,-100},{-30,-64},{44,-64},{44,-44.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Blower_Speed1.y, add3_1.u3) annotation (Line(points={{48.4,-40},{
          48.4,-35.2},{55.2,-35.2}},
                                color={0,0,127}));
  connect(add3_1.y, minMaxFilter.u) annotation (Line(points={{64.4,-32},{78,
          -32}},              color={0,0,127}));
  connect(actuatorBus.PR_Compressor, minMaxFilter.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-32},{101.4,-32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TCV_Position.y, add1.u1) annotation (Line(points={{76.4,42},{84,
          42},{84,45.6},{91.2,45.6}}, color={0,0,127}));
  connect(const7.y, add1.u2) annotation (Line(points={{76.4,56},{84,56},{84,
          50.4},{91.2,50.4}}, color={0,0,127}));
  connect(const11.y, add3.u1) annotation (Line(points={{72.5,-55},{84,-55},
          {84,-61.6},{91.2,-61.6}}, color={0,0,127}));
  connect(switch1.u3, const13.y) annotation (Line(points={{52,114},{42.4,
          114},{42.4,128}}, color={0,0,127}));
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
end CS_Rankine_DNE_AR;
