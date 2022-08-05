within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_IntermediateControl_PID_TESUC_ImpControl_2_Mikk
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand
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
    k=-5e-8,
    Ti=1,
    k_s=1,
    k_m=1,
    yMax=0,
    yMin=-1 + 0.0001,
    initType=Modelica.Blocks.Types.Init.InitialState,
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
  Data.Intermediate_Rankine_Setpoints data(
    p_steam=3398000,
    p_steam_vent=15000000,
    T_Steam_Ref=579.75,
    Q_Nom=46.5e6,
    T_Feedwater=421.15,
    T_SHS_Return=491.15)
    annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
  Modelica.Blocks.Sources.Constant const3(k=67.3)
    annotation (Placement(transformation(extent={{-96,62},{-76,82}})));
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
  Modelica.Blocks.Sources.Constant const11(k=0.001)
    annotation (Placement(transformation(extent={{156,-10},{148,-2}})));
  Modelica.Blocks.Math.Add         add4
    annotation (Placement(transformation(extent={{128,0},{108,20}})));
  Modelica.Blocks.Math.Add         add5
    annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
  TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-4e-9,
    Ti=1,
    k_s=1,
    k_m=1,
    yMax=1 - 0.015,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{152,-78},{132,-98}})));
  Modelica.Blocks.Sources.Constant const10(k=0.015)
    annotation (Placement(transformation(extent={{152,-122},{144,-114}})));
  Modelica.Blocks.Math.Add         add7
    annotation (Placement(transformation(extent={{116,48},{96,68}})));
  Modelica.Blocks.Sources.Constant const15(k=0.01)
    annotation (Placement(transformation(extent={{140,38},{132,46}})));
  Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
    annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=42e6)
    annotation (Placement(transformation(extent={{240,8},{260,28}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
                                                                    PI_DFV(
    k=10,
    Ti=25,
    k_s=5e-9,
    k_m=5e-9)
    annotation (Placement(transformation(extent={{200,54},{180,74}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
                                                                    PI_DCV1(
    k=10,
    Ti=25,
    k_s=5e-9,
    k_m=5e-9)
    annotation (Placement(transformation(extent={{186,6},{166,26}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter(max=1 - 0.001)
    annotation (Placement(transformation(extent={{156,6},{136,26}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter1(max=1 - 0.01)
    annotation (Placement(transformation(extent={{160,54},{140,74}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
  Modelica.Blocks.Sources.Constant const6(k=40e6)
    annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
  Modelica.Blocks.Sources.Constant const12(k=40.001e6)
    annotation (Placement(transformation(extent={{140,-84},{164,-60}})));
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
  connect(const3.y,FWCP_mflow. u_s)
    annotation (Line(points={{-75,72},{-68,72}}, color={0,0,127}));
  connect(FWCP_mflow.y, add.u2)
    annotation (Line(points={{-45,72},{-26,72}},
                                               color={0,0,127}));
  connect(const4.y, add.u1)
    annotation (Line(points={{-31.6,84},{-26,84}},
                                                color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{30,78},{-3,78}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
  connect(const11.y, add4.u2) annotation (Line(points={{147.6,-6},{140,-6},{140,
          4},{130,4}},
                   color={0,0,127}));
  connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
      points={{30,-100},{30,10},{107,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
  connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
          46},{131.6,46},{131.6,42}}, color={0,0,127}));
  connect(actuatorBus.Discharge_OnOff_Throttle, add7.y) annotation (Line(
      points={{30,-100},{30,58},{95,58}},
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
  connect(realExpression.y, greaterThreshold.u) annotation (Line(points={{110.7,
          -26},{224,-26},{224,18},{238,18}}, color={0,0,127}));
  connect(greaterThreshold.y, PI_DFV.k_in) annotation (Line(points={{261,18},{
          294,18},{294,14},{320,14},{320,72},{202,72}}, color={255,0,255}));
  connect(PI_DFV.u_s, realExpression.y) annotation (Line(points={{202,64},{210,
          64},{210,-26},{110.7,-26}}, color={0,0,127}));
  connect(sensorBus.Power, PI_DFV.u_m) annotation (Line(
      points={{-30,-100},{-30,-52},{194,-52},{194,52},{190,52}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, PI_DCV1.u_m) annotation (Line(
      points={{-30,-100},{-30,-52},{186,-52},{186,-6},{176,-6},{176,4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(realExpression.y, PI_DCV1.u_s) annotation (Line(points={{110.7,-26},{
          188,-26},{188,16}}, color={0,0,127}));
  connect(greaterThreshold.y, PI_DCV1.k_in) annotation (Line(points={{261,18},{
          304,18},{304,38},{188,38},{188,24}}, color={255,0,255}));
  connect(PI_DFV.y, minMaxFilter1.u)
    annotation (Line(points={{179,64},{162,64}}, color={0,0,127}));
  connect(minMaxFilter1.y, add7.u1)
    annotation (Line(points={{138.6,64},{118,64}}, color={0,0,127}));
  connect(add4.u1, minMaxFilter.y)
    annotation (Line(points={{130,16},{134.6,16}}, color={0,0,127}));
  connect(minMaxFilter.u, PI_DCV1.y)
    annotation (Line(points={{158,16},{165,16}}, color={0,0,127}));
  connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,46},{-56,46},{-56,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, min1.u2) annotation (Line(
      points={{-30,-100},{-30,-74},{90,-74},{90,-76}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(min1.u1, const6.y)
    annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
  connect(Charge_OnOff_Throttle.u_m, min1.y) annotation (Line(points={{142,-76},
          {142,-66},{113,-66},{113,-70}}, color={0,0,127}));
  connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
          -26},{160,-64},{172,-64}}, color={0,0,127}));
  connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
          {238,-70},{238,-88},{154,-88}}, color={0,0,127}));
  connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
          -72},{165.2,-72}}, color={0,0,127}));
  annotation (Diagram(graphics={Text(
          extent={{-70,-142},{-20,-160}},
          textColor={28,108,200},
          textString="Feedwater")}));
end CS_IntermediateControl_PID_TESUC_ImpControl_2_Mikk;
