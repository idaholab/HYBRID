within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine;
model CS_Rankine_DNE

  extends HTGR_Rankine.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-6,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-24,-76},{-14,-66}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-42,-74},{-36,-68}})));
  HTGR_Rankine.Data.Data_CS data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=30,
    yMax=250,
    yMin=25,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-2,-22},{6,-30}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{-22,-30},{-14,-22}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-2,
    Ti=30,
    yMax=750,
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
    k=1e-5,
    Ti=15,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-42,82},{-34,74}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-62,72},{-50,84}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-34,44},{-26,52}})));
  Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
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
  Modelica.Blocks.Sources.Constant const9(k=150e5)
    annotation (Placement(transformation(extent={{-20,20},{-8,32}})));
  TRANSFORM.Controls.LimPID     CR1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-22,-52},{-14,-60}})));
  Modelica.Blocks.Sources.Constant const10(k=125e6)
    annotation (Placement(transformation(extent={{-42,-60},{-34,-52}})));
  Modelica.Blocks.Math.Add         add3
    annotation (Placement(transformation(extent={{-2,-68},{6,-60}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-35.7,-71},{-25,-71}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-82},{-14,-82},{-14,-77},{-19,-77}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{-13.6,-26},{-2.8,-26}},
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
  connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,38},{-30,38},{-30,43.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y, add1.u2) annotation (Line(points={{-13.7,55},{-12,55},{-12,
          54.4},{-2.8,54.4}},         color={0,0,127}));
  connect(TCV_Position.y, add1.u1) annotation (Line(points={{-25.6,48},{-14,48},
          {-14,49.6},{-2.8,49.6}},                color={0,0,127}));
  connect(actuatorBus.TCV_Position, add1.y) annotation (Line(
      points={{30,-100},{30,52},{6.4,52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{30,72},{6.4,72}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add2.u2, const8.y) annotation (Line(points={{-2.8,69.6},{-10,69.6},{
          -10,68},{-13.6,68}},                                           color=
          {0,0,127}));
  connect(add2.u1, timer.y) annotation (Line(points={{-2.8,74.4},{-6,74.4},{-6,
          78},{-13.44,78}},                                     color={0,0,127}));
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
  connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-12},{2,-12},{2,-21.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
      points={{30,-100},{30,-26},{6.4,-26}},
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
  connect(add3.u1, CR1.y) annotation (Line(points={{-2.8,-61.6},{-6,-61.6},{-6,
          -56},{-13.6,-56}},
                      color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_DNE;
