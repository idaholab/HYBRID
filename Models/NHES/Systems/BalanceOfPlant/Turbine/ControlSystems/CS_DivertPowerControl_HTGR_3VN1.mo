within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_DivertPowerControl_HTGR_3VN1
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand
  annotation(Dialog(tab="General"));
  input Real Overall_Power
  annotation(Dialog(tab="General"));

  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-5,
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
    k=-5e-6,
    Ti=10,
    k_s=1,
    k_m=1,
    yMax=0,
    yMin=-1 + 0.01,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-58,-28},{-38,-48}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=electric_demand)
    annotation (Placement(transformation(extent={{96,-32},{110,-20}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
  Modelica.Blocks.Sources.Constant const8(k=0.015)
    annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Timer             timer(
      Start_Time=1e-2)
    annotation (Placement(transformation(extent={{-32,-128},{-24,-120}})));
  replaceable Data.TES_Setpoints data(
    p_steam=3398000,
    p_steam_vent=15000000,
    T_Steam_Ref=579.75,
    Q_Nom=48.57e6,
    T_Feedwater=421.15,
    T_SHS_Return=491.15,
    m_flow_reactor=67.3)
    annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{10,204},{30,224}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-58,180},{-38,200}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-98,180},{-78,200}})));
  Modelica.Blocks.Math.Add         add5
    annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
  TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-3e-7,
    Ti=25,
    Td=0.01,
    k_s=1,
    k_m=1,
    yMax=1 - 0.015,
    yMin=0,
    wp=1,
    wd=0.1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{152,-76},{132,-96}})));
  Modelica.Blocks.Sources.Constant const10(k=0.015)
    annotation (Placement(transformation(extent={{152,-122},{144,-114}})));
  Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
    annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
  Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
  Modelica.Blocks.Sources.Constant const12(k=data.Q_Nom + 0.001e6)
    annotation (Placement(transformation(extent={{116,-58},{140,-34}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression1(y=Overall_Power)
    annotation (Placement(transformation(extent={{80,24},{94,36}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-300,
    duration=5000,
    offset=1220,
    startTime=100000)
    annotation (Placement(transformation(extent={{-92,146},{-72,166}})));
  Modelica.Blocks.Math.Add         add3
    annotation (Placement(transformation(extent={{6,130},{26,150}})));
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
      points={{30.1,-99.9},{30.1,164},{31,164},{31,214}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{-77,190},{-60,190}},
                                                 color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-106,-100},{-106,54},{-108,54},{-108,164},{-48,164},{
          -48,178}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{30,174},{-30,174},{-30,190},{-37,190}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add5.u1, Charge_OnOff_Throttle.y)
    annotation (Line(points={{114,-90},{114,-86},{131,-86}},
                                                 color={0,0,127}));
  connect(add5.u2, const10.y) annotation (Line(points={{114,-102},{118,-102},{
          118,-118},{143.6,-118}},
                            color={0,0,127}));
  connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
      points={{30,-100},{30,-96},{91,-96}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, TCV_Power.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-12},{-48,-12},{-48,-26}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(TCV_Power.u_s, const1.y)
    annotation (Line(points={{-60,-38},{-71,-38}}, color={0,0,127}));
  connect(min1.u1, const6.y)
    annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
  connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
          -26},{160,-64},{172,-64}}, color={0,0,127}));
  connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
          {238,-70},{238,-86},{154,-86}}, color={0,0,127}));
  connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
          -46},{141.2,-46}}, color={0,0,127}));
  connect(min1.u2, const6.y) annotation (Line(points={{90,-76},{80,-76},{80,-64},
          {75.2,-64}}, color={0,0,127}));
  connect(sensorBus.Power, Charge_OnOff_Throttle.u_m) annotation (Line(
      points={{-30,-100},{-28,-100},{-28,-70},{142,-70},{142,-74}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ramp1.y, add3.u1) annotation (Line(points={{-71,156},{-71,158},{-46,
          158},{-46,146},{4,146}}, color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add3.y) annotation (Line(
      points={{30,-100},{27,-100},{27,140}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const2.y, add3.u2) annotation (Line(points={{31,214},{40,214},{40,200},
          {46,200},{46,162},{4,162},{4,134}}, color={0,0,127}));
  annotation (Diagram(graphics={Text(
          extent={{-70,-142},{-20,-160}},
          textColor={28,108,200},
          textString="Feedwater")}));
end CS_DivertPowerControl_HTGR_3VN1;
