within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_DivertPowerControl_HTGR_3VNa
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand
  annotation(Dialog(tab="General"));
  input Real Overall_Power
  annotation(Dialog(tab="General"));

    input Real m_required;



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
  Modelica.Blocks.Sources.Constant const3(k=data.m_flow_reactor)
    annotation (Placement(transformation(extent={{-186,68},{-166,88}})));
  TRANSFORM.Controls.LimPID FWCP_mflow(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.1,
    Ti=20,
    Td=0.1,
    yMax=3000,
    yMin=-750,
    wd=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-66,62},{-46,82}})));
  Modelica.Blocks.Sources.Constant const4(k=1200)
    annotation (Placement(transformation(extent={{-40,80},{-32,88}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{-24,68},{-4,88}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{10,158},{30,178}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-58,134},{-38,154}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-98,134},{-78,154}})));
  Modelica.Blocks.Math.Add         add5
    annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
  TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=20,
    Td=0.01,
    k_s=1,
    k_m=1,
    yMax=1 - 0.015,
    yMin=0,
    wp=1,
    wd=0.1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{152,-78},{132,-98}})));
  Modelica.Blocks.Sources.Constant const10(k=0.015)
    annotation (Placement(transformation(extent={{152,-122},{144,-114}})));
  Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
    annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
  Modelica.Blocks.Sources.Constant const12(k=data.Q_Nom + 0.001e6)
    annotation (Placement(transformation(extent={{116,-58},{140,-34}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression1(y=Overall_Power)
    annotation (Placement(transformation(extent={{80,24},{94,36}})));
  Modelica.Blocks.Sources.RealExpression m_req(y=m_required)
    annotation (Placement(transformation(extent={{-108,66},{-94,78}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-1000,
    duration=5000,
    offset=1200,
    startTime=100000)
    annotation (Placement(transformation(extent={{-238,108},{-218,128}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=1,
    duration=5000,
    offset=0,
    startTime=100000)
    annotation (Placement(transformation(extent={{-224,24},{-204,44}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{130,96},{150,116}})));
  Modelica.Blocks.Math.Add         add3
    annotation (Placement(transformation(extent={{190,102},{210,122}})));
  Modelica.Blocks.Math.Add         add4
    annotation (Placement(transformation(extent={{-178,118},{-158,138}})));
  Modelica.Blocks.Sources.Ramp ramp3(
    height=-200,
    duration=5000,
    offset=0,
    startTime=50000)
    annotation (Placement(transformation(extent={{-244,152},{-224,172}})));
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
      points={{30.1,-99.9},{30.1,118},{31,118},{31,168}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(FWCP_mflow.y, add.u2)
    annotation (Line(points={{-45,72},{-26,72}},
                                               color={0,0,127}));
  connect(const4.y, add.u1)
    annotation (Line(points={{-31.6,84},{-26,84}},
                                                color={0,0,127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{-77,144},{-60,144}},
                                                 color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,108},{-48,108},{-48,132}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{30,128},{-30,128},{-30,144},{-37,144}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add5.u1, Charge_OnOff_Throttle.y)
    annotation (Line(points={{114,-90},{114,-88},{131,-88}},
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
  connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,46},{-56,46},{-56,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
          -26},{160,-64},{172,-64}}, color={0,0,127}));
  connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
          {238,-70},{238,-88},{154,-88}}, color={0,0,127}));
  connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
          -46},{141.2,-46}}, color={0,0,127}));
  connect(sensorBus.Power, Charge_OnOff_Throttle.u_m) annotation (Line(
      points={{-30,-100},{-28,-100},{-28,-70},{142,-70},{142,-76}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(m_req.y, FWCP_mflow.u_s)
    annotation (Line(points={{-93.3,72},{-68,72}}, color={0,0,127}));
  connect(ramp2.y, product1.u1) annotation (Line(points={{-203,34},{-118,34},{
          -118,102},{118,102},{118,112},{128,112}}, color={0,0,127}));
  connect(add.y, product1.u2) annotation (Line(points={{-3,78},{118,78},{118,
          100},{128,100}}, color={0,0,127}));
  connect(product1.y, add3.u2)
    annotation (Line(points={{151,106},{188,106}}, color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add3.y) annotation (Line(
      points={{30,-100},{40,-100},{40,8},{211,8},{211,112}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ramp1.y, add4.u2) annotation (Line(points={{-217,118},{-217,110},{
          -180,110},{-180,122}}, color={0,0,127}));
  connect(add4.y, add3.u1) annotation (Line(points={{-157,128},{-120,128},{-120,
          118},{188,118}}, color={0,0,127}));
  connect(ramp3.y, add4.u1) annotation (Line(points={{-223,162},{-223,146},{
          -180,146},{-180,134}}, color={0,0,127}));
  annotation (Diagram(graphics={Text(
          extent={{-70,-142},{-20,-160}},
          textColor={28,108,200},
          textString="Feedwater")}));
end CS_DivertPowerControl_HTGR_3VNa;
