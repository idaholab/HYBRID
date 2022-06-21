within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_IntermediateControl_PID
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-2,
    Ti=30,
    yMax=750,
    yMin=-1000,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-38,32},{-18,52}})));
  Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
    annotation (Placement(transformation(extent={{-70,32},{-50,52}})));
  Modelica.Blocks.Sources.Constant const4(k=1500)
    annotation (Placement(transformation(extent={{-14,50},{-6,58}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{2,38},{22,58}})));
  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=15,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-62,-56},{-42,-36}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-54,-2},{-34,-22}})));
  Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{-84,-22},{-64,-2}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
  Modelica.Blocks.Sources.Constant const8(k=1e-6)
    annotation (Placement(transformation(extent={{-32,-62},{-24,-54}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-8,-62},{12,-42}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Timer             timer(
      Start_Time=1e-2)
    annotation (Placement(transformation(extent={{-32,-50},{-24,-42}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-38,68},{-18,88}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-78,68},{-58,88}})));
  Data.Intermediate_Rankine
                  data
    annotation (Placement(transformation(extent={{-96,12},{-76,32}})));
  Modelica.Blocks.Sources.Constant ExternalDivertValve(k=1e-6)
    annotation (Placement(transformation(extent={{80,-28},{60,-8}})));
  Modelica.Blocks.Sources.Constant Volume_pump(k=200)
    annotation (Placement(transformation(extent={{80,14},{60,34}})));
equation
  connect(const3.y,FWCP_Speed. u_s) annotation (Line(points={{-49,42},{-40,42}},
                              color={0,0,127}));
  connect(sensorBus.Steam_Temperature,FWCP_Speed. u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,8},{-28,8},{-28,30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const4.y,add. u1) annotation (Line(points={{-5.6,54},{0,54}},
                                   color={0,0,127}));
  connect(FWCP_Speed.y,add. u2) annotation (Line(points={{-17,42},{0,42}},
                    color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
      points={{30,-100},{30,48},{23,48}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const5.y,Turb_Divert_Valve. u_s)
    annotation (Line(points={{-71,-46},{-64,-46}},   color={0,0,127}));
  connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
      points={{-30,-100},{-52,-100},{-52,-58}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const6.y,TCV_Position. u_s)
    annotation (Line(points={{-63,-12},{-56,-12}},   color={0,0,127}));
  connect(sensorBus.Power,TCV_Position. u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,8},{-44,8},{-44,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                      color={0,0,127}));
  connect(TCV_Position.y,add1. u1) annotation (Line(points={{-33,-12},{-10,-12}},
                                                  color={0,0,127}));
  connect(actuatorBus.Divert_Valve_Position,add2. y) annotation (Line(
      points={{30,-100},{30,-52},{13,-52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add2.u2,const8. y) annotation (Line(points={{-10,-58},{-23.6,-58}},
                                                                         color=
          {0,0,127}));
  connect(add2.u1,timer. y) annotation (Line(points={{-10,-46},{-23.44,-46}},
                                                                color={0,0,127}));
  connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-46},{-32.8,
          -46}},                                                     color={0,0,
          127}));
  connect(const9.y,PI_TBV. u_s)
    annotation (Line(points={{-57,78},{-40,78}},   color={0,0,127}));
  connect(sensorBus.Steam_Pressure,PI_TBV. u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,60},{-28,60},{-28,66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV,PI_TBV. y) annotation (Line(
      points={{30,-100},{30,78},{-17,78}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TCV,add1. y) annotation (Line(
      points={{30.1,-99.9},{30.1,-16},{30,-16},{30,-18},{13,-18}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(ExternalDivertValve.y, actuatorBus.opening_BV) annotation (Line(
        points={{59,-18},{30.1,-18},{30.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Volume_pump.y, actuatorBus.Volume_Pump) annotation (Line(points={{59,24},
          {30,24},{30,-100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
end CS_IntermediateControl_PID;
