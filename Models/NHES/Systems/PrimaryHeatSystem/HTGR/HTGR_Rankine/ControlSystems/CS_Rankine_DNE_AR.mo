within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems;
model CS_Rankine_DNE_AR

  extends HTGR_Rankine.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-24,-76},{-14,-66}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-42,-74},{-36,-68}})));
  HTGR_Rankine.Data.Data_CS data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=50,
    T_Steam_Ref=838.15,
    Q_Nom=43750000,
    Q_RX_Therm_Nom=200e6,
    T_Feedwater=466.45)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=30,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-6,-22},{2,-30}})));
  Modelica.Blocks.Sources.Constant const2(k=78)
    annotation (Placement(transformation(extent={{-20,-22},{-12,-30}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-3,
    Ti=60,
    yMax=1500,
    yMin=-1000,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-32,-6},{-24,2}})));
  Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
    annotation (Placement(transformation(extent={{-58,-6},{-50,2}})));
  Modelica.Blocks.Sources.Constant const4(k=1500)
    annotation (Placement(transformation(extent={{-18,2},{-12,8}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{-4,-4},{6,6}})));
  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-4,
    Ti=1,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-42,82},{-34,74}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-62,72},{-50,84}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    Ti=5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-34,44},{-26,52}})));
  Modelica.Blocks.Sources.Constant const6(k=87.01e6)
    annotation (Placement(transformation(extent={{-50,44},{-42,52}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{-20,52},{-14,58}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-2,56},{6,48}})));
  Modelica.Blocks.Sources.Constant const8(k=1e-6)
    annotation (Placement(transformation(extent={{-22,64},{-14,72}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-2,68},{6,76}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
    timer(Start_Time=1e-2)
    annotation (Placement(transformation(extent={{-22,74},{-14,82}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-2,22},{6,30}})));
  Modelica.Blocks.Sources.Constant const9(k=200e5)
    annotation (Placement(transformation(extent={{-20,20},{-8,32}})));
  TRANSFORM.Controls.LimPID     CR1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-10,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-22,-52},{-14,-60}})));
  Modelica.Blocks.Sources.Constant const10(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{-42,-60},{-34,-52}})));
  Modelica.Blocks.Math.Add         add3
    annotation (Placement(transformation(extent={{-2,-68},{6,-60}})));
  Modelica.Blocks.Sources.Constant const11(k=-0.01)
    annotation (Placement(transformation(extent={{-14,-52},{-6,-44}})));
  Modelica.Blocks.Math.Add3        add3_1
    annotation (Placement(transformation(extent={{12,-36},{20,-28}})));
  Modelica.Blocks.Sources.Constant const12(k=80)
    annotation (Placement(transformation(extent={{-38,-36},{-30,-28}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-34,96},{-14,116}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{10,116},{30,96}})));
  Modelica.Blocks.Sources.Constant const13(k=0.0)
    annotation (Placement(transformation(extent={{-34,124},{-26,132}})));
  TRANSFORM.Controls.LimPID Blower_Speed1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=10,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-4,-44},{4,-36}})));
  Modelica.Blocks.Sources.Constant const14(k=165e5)
    annotation (Placement(transformation(extent={{-24,-42},{-16,-34}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter(min=10, max=100)
    annotation (Placement(transformation(extent={{66,-60},{86,-40}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-35.7,-71},{-25,-71}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-82},{-14,-82},{-14,-77},{-19,-77}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{-11.6,-26},{-6.8,-26}},
                                               color={0,0,127}));
  connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{-49.6,-2},{-32.8,
          -2}},               color={0,0,127}));
  connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-12},{-28,-12},{-28,-6.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const4.y, add.u1) annotation (Line(points={{-11.7,5},{-11.7,4},{-5,4}},
                                   color={0,0,127}));
  connect(FWCP_Speed.y, add.u2) annotation (Line(points={{-23.6,-2},{-5,-2}},
                    color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{30,1},{6.5,1}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const5.y, Turb_Divert_Valve.u_s)
    annotation (Line(points={{-49.4,78},{-42.8,78}}, color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,92},{-38,92},{-38,82.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const6.y, TCV_Position.u_s)
    annotation (Line(points={{-41.6,48},{-34.8,48}}, color={0,0,127}));
  connect(const7.y, add1.u2) annotation (Line(points={{-13.7,55},{-12,55},{-12,
          54.4},{-2.8,54.4}},         color={0,0,127}));
  connect(TCV_Position.y, add1.u1) annotation (Line(points={{-25.6,48},{-14,48},
          {-14,49.6},{-2.8,49.6}},                color={0,0,127}));
  connect(actuatorBus.TCV_Position, add1.y) annotation (Line(
      points={{30,-100},{30,52},{6.4,52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add2.u2, const8.y) annotation (Line(points={{-2.8,69.6},{-10,69.6},{
          -10,68},{-13.6,68}},                                           color=
          {0,0,127}));
  connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-33.6,78},{
          -22.8,78}},                                                color={0,0,
          127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{-7.4,26},{-2.8,26}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-12},{-72,-12},{-72,14},{2,14},{2,
          21.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{30,26},{6.4,26}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.thermal_power, CR1.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-46},{-18,-46},{-18,-51.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const10.y, CR1.u_s)
    annotation (Line(points={{-33.6,-56},{-22.8,-56}},
                                                   color={0,0,127}));
  connect(actuatorBus.CR_Reactivity, add3.y) annotation (Line(
      points={{30,-100},{30,-64},{6.4,-64}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add3.u2, CR.y) annotation (Line(points={{-2.8,-66.4},{-12,-66.4},{-12,
          -71},{-13.5,-71}},
                     color={0,0,127}));
  connect(add3_1.u2, const12.y)
    annotation (Line(points={{11.2,-32},{-29.6,-32}}, color={0,0,127}));
  connect(add3_1.u1, Blower_Speed.y) annotation (Line(points={{11.2,-28.8},{10,
          -28.8},{10,-30},{2.4,-30},{2.4,-26}}, color={0,0,127}));
  connect(sensorBus.Core_Mass_Flow, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-18},{-2,-18},{-2,-21.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add3.u1, const11.y) annotation (Line(points={{-2.8,-61.6},{-4,-61.6},
          {-4,-48},{-5.6,-48}}, color={0,0,127}));
  connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,38},{-30,38},{-30,43.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Bypass_flow, greaterThreshold.u) annotation (Line(
      points={{-30,-100},{-30,-64},{-102,-64},{-102,106},{-36,106}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(greaterThreshold.y, switch1.u2)
    annotation (Line(points={{-13,106},{8,106}}, color={255,0,255}));
  connect(const13.y, switch1.u3) annotation (Line(points={{-25.6,128},{-6,128},
          {-6,114},{8,114}}, color={0,0,127}));
  connect(timer.y, switch1.u1) annotation (Line(points={{-13.44,78},{-10,78},{
          -10,80},{-8,80},{-8,98},{8,98}}, color={0,0,127}));
  connect(switch1.y, add2.u1) annotation (Line(points={{31,106},{40,106},{40,86},
          {38,86},{38,82},{-6,82},{-6,74.4},{-2.8,74.4}}, color={0,0,127}));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{32,-100},{32,72},{6.4,72}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const14.y, Blower_Speed1.u_s)
    annotation (Line(points={{-15.6,-38},{-16,-38},{-16,-40},{-4.8,-40}},
                                                      color={0,0,127}));
  connect(sensorBus.Steam_Pressure, Blower_Speed1.u_m) annotation (Line(
      points={{-30,-100},{-30,-62},{-8,-62},{-8,-44.8},{0,-44.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Blower_Speed1.y, add3_1.u3) annotation (Line(points={{4.4,-40},{4.4,
          -35.2},{11.2,-35.2}}, color={0,0,127}));
  connect(add3_1.y, minMaxFilter.u) annotation (Line(points={{20.4,-32},{58,-32},
          {58,-50},{64,-50}}, color={0,0,127}));
  connect(actuatorBus.PR_Compressor, minMaxFilter.y) annotation (Line(
      points={{30,-100},{96,-100},{96,-46},{87.4,-46},{87.4,-50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_DNE_AR;
