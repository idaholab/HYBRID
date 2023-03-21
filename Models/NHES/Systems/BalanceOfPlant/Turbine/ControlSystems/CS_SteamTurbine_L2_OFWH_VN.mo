within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_SteamTurbine_L2_OFWH_VN
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand_int = data.Q_Nom;

  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-3,
    Ti=5,
    Td=0.1,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-58,-58},{-38,-38}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
  TRANSFORM.Controls.LimPID TCV_Power(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-7,
    Ti=30,
    k_s=1,
    k_m=1,
    yMax=0,
    yMin=-1 + 0.05,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=electric_demand_int)
    annotation (Placement(transformation(extent={{-94,-6},{-80,6}})));
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
  replaceable Data.Turbine_2_Setpoints data(
    p_steam=3500000,
    p_steam_vent=15000000,
    T_Steam_Ref=579.75,
    Q_Nom=40e6,
    T_Feedwater=421.15)
    annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
  Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{-78,-22},{-64,-8}})));
  Modelica.Blocks.Sources.Constant const3(k=400 + 273.15)
    annotation (Placement(transformation(extent={{-66,28},{-46,48}})));
  Modelica.Blocks.Sources.Constant const4(k=72)
    annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{2,36},{22,56}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{2,74},{22,94}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
  Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
    annotation (Placement(transformation(extent={{-192,48},{-172,68}})));
  TRANSFORM.Controls.LimPID FWCP_Speed1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2.5e-7,
    Ti=10,
    yMax=250,
    yMin=-72,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-160,48},{-140,68}})));
  TRANSFORM.Controls.LimPID Pump_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.009,
    Ti=10,
    yb=0.01,
    yMax=250,
    yMin=-72,
    wp=0.8,
    Ni=0.1,
    y_start=30)
    annotation (Placement(transformation(extent={{-34,30},{-20,44}})));
  Modelica.Blocks.Sources.Constant const6(k=72)
    annotation (Placement(transformation(extent={{-148,76},{-140,84}})));
  Modelica.Blocks.Math.Add         add3
    annotation (Placement(transformation(extent={{-126,50},{-106,70}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Timer             timer1(
      Start_Time=2000, init_mult=25)
    annotation (Placement(transformation(extent={{-14,24},{-6,32}})));
equation
  connect(const5.y,Turb_Divert_Valve. u_s)
    annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-60,-48}},
                                                     color={0,0,127}));
  connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
      points={{-30,-100},{-48,-100},{-48,-60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                      color={0,0,127}));
  connect(TCV_Power.y, add1.u1)
    annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
  connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                         color=
          {0,0,127}));
  connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                color={0,0,127}));
  connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-37,-48},{-36,
          -48},{-36,-40},{-32.8,-40}},                               color={0,0,
          127}));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{30,-46},{13,-46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.opening_BV, const2.y) annotation (Line(
      points={{30.1,-99.9},{30.1,84},{23,84}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const4.y, add.u1)
    annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,70},{-28,70}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, TCV_Power.u_s) annotation (Line(points={{-63.3,-15},{-56,-15},
          {-56,-12},{-52,-12}}, color={0,0,127}));
  connect(const1.y, FWCP_Speed1.u_s)
    annotation (Line(points={{-171,58},{-162,58}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, FWCP_Speed1.u_m) annotation (Line(
      points={{-30,-100},{-30,-98},{-100,-98},{-100,36},{-150,36},{-150,46}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const3.y, Pump_Speed.u_s) annotation (Line(points={{-45,38},{-40.2,38},
          {-40.2,37},{-35.4,37}}, color={0,0,127}));
  connect(sensorBus.Steam_Temperature, Pump_Speed.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,8},{-27,8},{-27,28.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const6.y, add3.u1) annotation (Line(points={{-139.6,80},{-136,80},{
          -136,66},{-128,66}}, color={0,0,127}));
  connect(FWCP_Speed1.y, add3.u2) annotation (Line(points={{-139,58},{-134,58},
          {-134,54},{-128,54}}, color={0,0,127}));
  connect(actuatorBus.opening_TCV, const7.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-30},{-17.6,-30},{-17.6,-24}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Pump_Speed.y, timer1.u) annotation (Line(points={{-19.3,37},{-19.3,34},
          {-14.8,34},{-14.8,28}}, color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{30,46},{23,46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add.u2, Pump_Speed.y) annotation (Line(points={{0,40},{-4,40},{-4,37},
          {-19.3,37}}, color={0,0,127}));
end CS_SteamTurbine_L2_OFWH_VN;
