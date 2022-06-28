within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_IntermediateControl_PID_4
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-6,
    Ti=5,
    Td=0.1,
    yMax=1,
    yMin=1e-3,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
  TRANSFORM.Controls.LimPID TCV_Power(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.5e-9,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=0,
    yMin=-1 + 0.0001,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-54,-2},{-34,-22}})));
  Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{-84,-22},{-64,-2}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
  Modelica.Blocks.Sources.Constant const8(k=0)
    annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Timer             timer(
      Start_Time=1e-2)
    annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
  TRANSFORM.Controls.LimPID BV_Pressure(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-3e-9,
    Ti=10,
    yMax=1.0,
    yMin=1e-2,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-38,68},{-18,88}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-78,68},{-58,88}})));
  Fluid.Intermediate_Rankine data(
    p_steam_vent=8000000,
    T_Steam_Ref=579.75,
    Q_Nom=60e6,
    T_Feedwater=421.15)
    annotation (Placement(transformation(extent={{-96,12},{-76,32}})));
  TRANSFORM.Controls.LimPID CondensorBalance(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-2,
    Ti=15,
    yMax=2000,
    yMin=-2000,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500,
    y_start=0)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-26,-82},{-18,-74}})));
  Modelica.Blocks.Math.Add         add3
    annotation (Placement(transformation(extent={{-2,-82},{18,-62}})));
equation
  connect(const5.y,Turb_Divert_Valve. u_s)
    annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                     color={0,0,127}));
  connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
      points={{-30,-100},{-50,-100},{-50,-60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const6.y, TCV_Power.u_s)
    annotation (Line(points={{-63,-12},{-56,-12}}, color={0,0,127}));
  connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,8},{-44,8},{-44,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                      color={0,0,127}));
  connect(TCV_Power.y, add1.u1)
    annotation (Line(points={{-33,-12},{-10,-12}}, color={0,0,127}));
  connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                         color=
          {0,0,127}));
  connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                color={0,0,127}));
  connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
          -48},{-36,-40},{-32.8,-40}},                               color={0,0,
          127}));
  connect(const9.y, BV_Pressure.u_s)
    annotation (Line(points={{-57,78},{-40,78}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, BV_Pressure.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,60},{-28,60},{-28,66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{30,-46},{13,-46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-18},{13,-18}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.opening_BV, BV_Pressure.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-10},{30,-10},{30,78},{-17,78}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(CondensorBalance.y,add3. u1) annotation (Line(points={{-59,-80},{-48,
          -80},{-48,-66},{-4,-66}},  color={0,0,127}));
  connect(const1.y,add3. u2)
    annotation (Line(points={{-17.6,-78},{-4,-78}},  color={0,0,127}));
  connect(actuatorBus.CondensorFlow, add3.y) annotation (Line(
      points={{30,-100},{30,-72},{19,-72}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Condensor_Output_mflow, CondensorBalance.u_m) annotation (
      Line(
      points={{-30,-100},{-70,-100},{-70,-92}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Condensor_Input_mflow, CondensorBalance.u_s) annotation (
      Line(
      points={{-30,-100},{-100,-100},{-100,-80},{-82,-80}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
end CS_IntermediateControl_PID_4;
