within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_DivertPowerControl_ANL_v2
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand_large
  annotation(Dialog(tab="General"));

  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-4,
    Ti=5,
    Td=0.1,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-62,-116},{-42,-136}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-104,-136},{-84,-116}})));
  TRANSFORM.Controls.LimPID TCV_Power(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=1 - const7.k,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-58,-28},{-38,-48}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=electric_demand_large)
    annotation (Placement(transformation(extent={{54,-8},{68,4}})));
  Modelica.Blocks.Sources.Constant const7(k=5e-3)
    annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
  Modelica.Blocks.Sources.Constant const8(k=0.015)
    annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
    timer(Start_Time=1e-2)
    annotation (Placement(transformation(extent={{-32,-128},{-24,-120}})));
  replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.TES_Setpoints data(
    p_steam=3398000,
    p_steam_vent=15000000,
    T_Steam_Ref=579.75,
    Q_Nom=48.57e6,
    T_Feedwater=421.15,
    T_SHS_Return=491.15,
    m_flow_reactor=67.3)
    annotation (Placement(transformation(extent={{78,78},{98,98}})));
  Modelica.Blocks.Sources.Constant const3(k=data.m_flow_reactor)
    annotation (Placement(transformation(extent={{-96,34},{-76,54}})));
  TRANSFORM.Controls.LimPID FWCP_mflow(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=20,
    Td=0.1,
    yMax=1250,
    yMin=-750,
    wp=0,
    wd=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-66,34},{-46,54}})));
  Modelica.Blocks.Sources.Constant const4(k=1200)
    annotation (Placement(transformation(extent={{-40,52},{-32,60}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{-24,40},{-4,60}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{10,74},{30,94}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-58,74},{-38,94}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-98,74},{-78,94}})));
  Modelica.Blocks.Math.Add         add5
    annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
  TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-4e-7,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=1 - 0.015,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{146,-78},{126,-98}})));
  Modelica.Blocks.Sources.Constant const10(k=0.015)
    annotation (Placement(transformation(extent={{138,-122},{130,-114}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{90,-18},{110,2}})));
  Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
  Modelica.Blocks.Sources.Constant const12(k=data.Q_Nom + 0.001e6)
    annotation (Placement(transformation(extent={{54,-34},{78,-10}})));
equation
  connect(const5.y,Turb_Divert_Valve. u_s)
    annotation (Line(points={{-83,-126},{-64,-126}}, color={0,0,127}));
  connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
      points={{-30,-100},{-52,-100},{-52,-114}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y,add1. u2) annotation (Line(points={{-25.6,-50},{-18,-50}},
                                      color={0,0,127}));
  connect(TCV_Power.y, add1.u1)
    annotation (Line(points={{-37,-38},{-18,-38}}, color={0,0,127}));
  connect(add2.u2,const8. y) annotation (Line(points={{-10,-136},{-23.6,-136}},
                                                                         color=
          {0,0,127}));
  connect(add2.u1,timer. y) annotation (Line(points={{-10,-124},{-23.44,-124}},
                                                                color={0,0,127}));
  connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-126},{
          -36,-126},{-36,-124},{-32.8,-124}},                        color={0,0,
          127}));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{30,-130},{13,-130}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-44},{5,-44}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.opening_BV, const2.y) annotation (Line(
      points={{30.1,-99.9},{30.1,58},{31,58},{31,84}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const3.y,FWCP_mflow. u_s)
    annotation (Line(points={{-75,44},{-68,44}}, color={0,0,127}));
  connect(FWCP_mflow.y, add.u2)
    annotation (Line(points={{-45,44},{-26,44}},
                                               color={0,0,127}));
  connect(const4.y, add.u1)
    annotation (Line(points={{-31.6,56},{-26,56}},
                                                color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{30,50},{-3,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{-77,84},{-60,84}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,62},{-48,62},{-48,72}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{30,68},{-30,68},{-30,84},{-37,84}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add5.u1, Charge_OnOff_Throttle.y)
    annotation (Line(points={{114,-90},{114,-88},{125,-88}},
                                                 color={0,0,127}));
  connect(add5.u2, const10.y) annotation (Line(points={{114,-102},{118,-102},
          {118,-118},{129.6,-118}},
                            color={0,0,127}));
  connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
      points={{30,-100},{30,-96},{91,-96}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,18},{-56,18},{-56,32}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(min1.u1, const6.y)
    annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
  connect(Charge_OnOff_Throttle.u_m, min1.y) annotation (Line(points={{136,-76},
          {136,-70},{113,-70}},           color={0,0,127}));
  connect(realExpression.y, min2.u1) annotation (Line(points={{68.7,-2},{88,
          -2}},                      color={0,0,127}));
  connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{111,-8},
          {148,-8},{148,-88}},            color={0,0,127}));
  connect(min2.u2, const12.y) annotation (Line(points={{88,-14},{79.2,-14},
          {79.2,-22}},       color={0,0,127}));
  connect(sensorBus.Power, min1.u2) annotation (Line(
      points={{-30,-100},{-30,-84},{84,-84},{84,-76},{90,-76}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(min2.y, TCV_Power.u_s) annotation (Line(points={{111,-8},{114,-8},
          {114,-38},{8,-38},{8,-18},{-66,-18},{-66,-38},{-60,-38}}, color={
          0,0,127}));
  connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
      points={{-30,-100},{-30,-58},{-24,-58},{-24,-52},{-22,-52},{-22,-36},
          {-32,-36},{-32,-20},{-48,-20},{-48,-26}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Diagram(graphics={Text(
          extent={{-70,-142},{-20,-160}},
          textColor={28,108,200},
          textString="Feedwater")}));
end CS_DivertPowerControl_ANL_v2;
