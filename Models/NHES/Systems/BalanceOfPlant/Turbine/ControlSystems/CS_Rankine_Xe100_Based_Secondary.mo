within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_Rankine_Xe100_Based_Secondary

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-2,
    Ti=30,
    yMax=750,
    yMin=-1000,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-40,16},{-20,36}})));
  Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
    annotation (Placement(transformation(extent={{-72,16},{-52,36}})));
  Modelica.Blocks.Sources.Constant const4(k=1500)
    annotation (Placement(transformation(extent={{-16,34},{-8,42}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{0,22},{20,42}})));
  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=15,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-64,-72},{-44,-52}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-94,-72},{-74,-52}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-56,-18},{-36,-38}})));
  Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{-86,-38},{-66,-18}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{-28,-44},{-20,-36}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-10,-44},{10,-24}})));
  Modelica.Blocks.Sources.Constant const8(k=1e-6)
    annotation (Placement(transformation(extent={{-34,-78},{-26,-70}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-10,-78},{10,-58}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Timer             timer(
      Start_Time=1e-2)
    annotation (Placement(transformation(extent={{-34,-66},{-26,-58}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-80,52},{-60,72}})));
  Data.HTGR_Rankine
                  data
    annotation (Placement(transformation(extent={{-98,-4},{-78,16}})));
equation

  connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{-51,26},{-42,26}},
                              color={0,0,127}));
  connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-8},{-30,-8},{-30,14}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const4.y, add.u1) annotation (Line(points={{-7.6,38},{-2,38}},
                                   color={0,0,127}));
  connect(FWCP_Speed.y, add.u2) annotation (Line(points={{-19,26},{-2,26}},
                    color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{30,32},{21,32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const5.y, Turb_Divert_Valve.u_s)
    annotation (Line(points={{-73,-62},{-66,-62}},   color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
      points={{-30,-100},{-54,-100},{-54,-74}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const6.y, TCV_Position.u_s)
    annotation (Line(points={{-65,-28},{-58,-28}},   color={0,0,127}));
  connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-8},{-46,-8},{-46,-16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y, add1.u2) annotation (Line(points={{-19.6,-40},{-12,-40}},
                                      color={0,0,127}));
  connect(TCV_Position.y, add1.u1) annotation (Line(points={{-35,-28},{-12,-28}},
                                                  color={0,0,127}));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{30,-68},{11,-68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add2.u2, const8.y) annotation (Line(points={{-12,-74},{-25.6,-74}},
                                                                         color=
          {0,0,127}));
  connect(add2.u1, timer.y) annotation (Line(points={{-12,-62},{-25.44,-62}},
                                                                color={0,0,127}));
  connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-43,-62},{-34.8,
          -62}},                                                     color={0,0,
          127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{-59,62},{-42,62}},   color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,44},{-30,44},{-30,50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{30,62},{-19,62}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-32},{28,-32},{28,-34},{11,-34}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Xe100_Based_Secondary;
