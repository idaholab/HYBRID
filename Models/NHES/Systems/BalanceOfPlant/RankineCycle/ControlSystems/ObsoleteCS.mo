within NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems;
package ObsoleteCS
  model CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle_AR
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand
    annotation(Dialog(tab="General"));

    Data.TES_Setpoints data(
      p_steam=1200000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=42e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-4,
      Ti=5,
      Td=0.1,
      yMax=2500,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,62},{-38,82}})));
    Modelica.Blocks.Sources.Constant const4(k=100)
      annotation (Placement(transformation(extent={{-32,80},{-24,88}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-16,68},{4,88}})));
    Modelica.Blocks.Sources.Constant const11(k=0.001)
      annotation (Placement(transformation(extent={{134,-10},{126,-2}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{106,0},{86,20}})));
    Modelica.Blocks.Math.Add         add7
      annotation (Placement(transformation(extent={{94,48},{74,68}})));
    Modelica.Blocks.Sources.Constant const15(k=0.01)
      annotation (Placement(transformation(extent={{118,38},{110,46}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0)
      annotation (Placement(transformation(extent={{218,8},{238,28}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
      PI_DFV(
      k=5,
      Ti=30,
      k_s=5e-9,
      k_m=5e-9)
      annotation (Placement(transformation(extent={{178,54},{158,74}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
      PI_DCV1(
      k=5,
      Ti=30,
      k_s=5e-9,
      k_m=5e-9)
      annotation (Placement(transformation(extent={{164,6},{144,26}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter(max=1 - 0.001)
      annotation (Placement(transformation(extent={{134,6},{114,26}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter1(max=1 - 0.01)
      annotation (Placement(transformation(extent={{138,54},{118,74}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand - data.Q_Nom)
      annotation (Placement(transformation(extent={{66,-24},{80,-12}})));
  equation
    connect(sensorBus.Steam_Pressure,FWCP_Speed. u_m) annotation (Line(
        points={{-30,-100},{-118,-100},{-118,40},{-48,40},{-48,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(const3.y,FWCP_Speed. u_s)
      annotation (Line(points={{-69,72},{-60,72}}, color={0,0,127}));
    connect(FWCP_Speed.y,add. u2)
      annotation (Line(points={{-37,72},{-18,72}},
                                                 color={0,0,127}));
    connect(const4.y,add. u1)
      annotation (Line(points={{-23.6,84},{-18,84}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
        points={{30,-100},{30,78},{5,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const11.y,add4. u2) annotation (Line(points={{125.6,-6},{118,-6},{118,
            4},{108,4}},
                     color={0,0,127}));
    connect(actuatorBus.TCV_SHS,add4. y) annotation (Line(
        points={{30,-100},{30,10},{85,10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add7.u2,const15. y) annotation (Line(points={{96,52},{100,52},{100,46},
            {109.6,46},{109.6,42}},     color={0,0,127}));
    connect(actuatorBus.Discharge_OnOff_Throttle,add7. y) annotation (Line(
        points={{30,-100},{30,58},{73,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(realExpression.y,greaterThreshold. u) annotation (Line(points={{80.7,
            -18},{202,-18},{202,18},{216,18}}, color={0,0,127}));
    connect(greaterThreshold.y,PI_DFV. k_in) annotation (Line(points={{239,18},{
            272,18},{272,14},{298,14},{298,72},{180,72}}, color={255,0,255}));
    connect(PI_DFV.u_s, realExpression.y) annotation (Line(points={{180,64},{188,
            64},{188,-18},{80.7,-18}},  color={0,0,127}));
    connect(sensorBus.Power,PI_DFV. u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{172,-52},{172,52},{168,52}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Power,PI_DCV1. u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{166,-52},{166,-6},{154,-6},{154,4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(realExpression.y,PI_DCV1. u_s) annotation (Line(points={{80.7,-18},{
            166,-18},{166,16}}, color={0,0,127}));
    connect(greaterThreshold.y,PI_DCV1. k_in) annotation (Line(points={{239,18},{
            282,18},{282,38},{166,38},{166,24}}, color={255,0,255}));
    connect(PI_DFV.y,minMaxFilter1. u)
      annotation (Line(points={{157,64},{140,64}}, color={0,0,127}));
    connect(minMaxFilter1.y,add7. u1)
      annotation (Line(points={{116.6,64},{96,64}},  color={0,0,127}));
    connect(add4.u1,minMaxFilter. y)
      annotation (Line(points={{108,16},{112.6,16}}, color={0,0,127}));
    connect(minMaxFilter.u,PI_DCV1. y)
      annotation (Line(points={{136,16},{143,16}}, color={0,0,127}));
  end CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle_AR;

  model CS_IntermediateControl_PID_TESUC_ImpControl_2_Mikk
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

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
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2) annotation (Placement(transformation(extent={{
              -32,-128},{-24,-120}})));
    Data.TES_Setpoints data(
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
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=48e6)
      annotation (Placement(transformation(extent={{240,8},{260,28}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
      PI_DFV(
      k=10,
      Ti=25,
      k_s=5e-9,
      k_m=5e-9)
      annotation (Placement(transformation(extent={{200,54},{180,74}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
      PI_DCV1(
      k=10,
      Ti=25,
      k_s=5e-9,
      k_m=5e-9)
      annotation (Placement(transformation(extent={{186,6},{166,26}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter(max=1 - 0.001)
      annotation (Placement(transformation(extent={{156,6},{136,26}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter1(max=1 - 0.01)
      annotation (Placement(transformation(extent={{160,54},{140,74}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
    Modelica.Blocks.Sources.Constant const6(k=48e6)
      annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
    Modelica.Blocks.Sources.Constant const12(k=48.001e6)
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

  model CS_IntermediateControl_PID_TESUC_ImpControl_3
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

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
      annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand)
      annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
    Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=46.5e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=-10e6,
      rising=720,
      width=7200,
      falling=720,
      period=18000,
      nperiod=-2,
      offset=45e6,
      startTime=20000)
      annotation (Placement(transformation(extent={{68,74},{82,88}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    TRANSFORM.Controls.LimPID FWCP_mflow(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-4,
      Ti=30,
      Td=0.1,
      yMax=8000,
      yMin=-1450,
      wd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    Modelica.Blocks.Sources.Constant const4(k=1500)
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
    TRANSFORM.Controls.LimPID MFlow_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-6,
      Ti=5,
      Td=0.1,
      yMax=0,
      yMin=-1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-46,-80},{-34,-68}})));
    Modelica.Blocks.Sources.Constant const1(k=data.m_flow_reactor)
      annotation (Placement(transformation(extent={{-92,-88},{-72,-68}})));
    Modelica.Blocks.Sources.Constant const6(k=1)
      annotation (Placement(transformation(extent={{-26,-84},{-18,-76}})));
    Modelica.Blocks.Math.Add         add3
      annotation (Placement(transformation(extent={{-2,-84},{18,-64}})));
    TRANSFORM.Controls.LimPID SHS_TCV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{98,28},{78,8}})));
    Modelica.Blocks.Sources.Constant const11(k=1)
      annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{62,0},{42,20}})));
    Modelica.Blocks.Math.Add         add5
      annotation (Placement(transformation(extent={{58,-76},{38,-56}})));
    TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - 0.015,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{90,-50},{70,-70}})));
    Modelica.Blocks.Sources.Constant const10(k=0.015)
      annotation (Placement(transformation(extent={{82,-86},{74,-78}})));
    Modelica.Blocks.Math.Add add6
      annotation (Placement(transformation(extent={{134,-68},{114,-48}})));
    Modelica.Blocks.Sources.Constant const12(k=-data.Q_Nom)
      annotation (Placement(transformation(extent={{178,-74},{158,-54}})));
    Modelica.Blocks.Sources.Constant const13(k=0)
      annotation (Placement(transformation(extent={{98,-32},{90,-24}})));
    Modelica.Blocks.Math.Add         add7
      annotation (Placement(transformation(extent={{116,48},{96,68}})));
    TRANSFORM.Controls.LimPID Discharge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.25e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - 0.01,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{152,74},{132,54}})));
    Modelica.Blocks.Sources.Constant const14(k=0)
      annotation (Placement(transformation(extent={{156,92},{148,100}})));
    Modelica.Blocks.Sources.Constant const15(k=0.01)
      annotation (Placement(transformation(extent={{140,38},{132,46}})));
    Modelica.Blocks.Math.Add add8(k1=-1)
      annotation (Placement(transformation(extent={{192,56},{172,76}})));
    Modelica.Blocks.Sources.Constant const16(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{236,50},{216,70}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                       color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-50,-100},{-50,-60}},
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
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
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
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-18},{13,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.Steam_Pressure,FWCP_mflow. u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,84},{23,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y,FWCP_mflow. u_s)
      annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
    connect(FWCP_mflow.y, add.u2)
      annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,46},{23,46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
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
    connect(const1.y, MFlow_Valve.u_s) annotation (Line(points={{-71,-78},{-64,-78},
            {-64,-70},{-56,-70},{-56,-74},{-47.2,-74}}, color={0,0,127}));
    connect(MFlow_Valve.y, add3.u1) annotation (Line(points={{-33.4,-74},{-32,-74},
            {-32,-72},{-10,-72},{-10,-68},{-4,-68}}, color={0,0,127}));
    connect(const6.y, add3.u2) annotation (Line(points={{-17.6,-80},{-16,-80},{-16,
            -76},{-8,-76},{-8,-86},{-4,-86},{-4,-80}}, color={0,0,127}));
    connect(sensorBus.Power, SHS_TCV.u_m) annotation (Line(
        points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(SHS_TCV.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
            {64,16}}, color={0,0,127}));
    connect(const11.y, add4.u2) annotation (Line(points={{77.6,-6},{70,-6},{70,4},
            {64,4}}, color={0,0,127}));
    connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
        points={{30,-100},{30,10},{41,10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, SHS_TCV.u_s) annotation (Line(points={{128.7,-26},{
            134,-26},{134,16},{100,16},{100,18}}, color={0,0,127}));
    connect(realExpression.y, TCV_Power.u_s) annotation (Line(points={{128.7,-26},
            {132,-26},{132,-38},{54,-38},{54,-2},{20,-2},{20,4},{-60,4},{-60,-12},
            {-52,-12}}, color={0,0,127}));
    connect(add5.u1, Charge_OnOff_Throttle.y)
      annotation (Line(points={{60,-60},{69,-60}}, color={0,0,127}));
    connect(add5.u2, const10.y) annotation (Line(points={{60,-72},{66,-72},{66,
            -82},{73.6,-82}}, color={0,0,127}));
    connect(Charge_OnOff_Throttle.u_s, add6.y) annotation (Line(points={{92,-60},
            {104,-60},{104,-58},{113,-58}}, color={0,0,127}));
    connect(realExpression.y, add6.u1) annotation (Line(points={{128.7,-26},{146,
            -26},{146,-52},{136,-52}}, color={0,0,127}));
    connect(add6.u2, const12.y)
      annotation (Line(points={{136,-64},{157,-64}}, color={0,0,127}));
    connect(const13.y, Charge_OnOff_Throttle.u_m)
      annotation (Line(points={{89.6,-28},{80,-28},{80,-48}}, color={0,0,127}));
    connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
        points={{30,-100},{30,-66},{37,-66}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add7.u1, Discharge_OnOff_Throttle.y)
      annotation (Line(points={{118,64},{131,64}}, color={0,0,127}));
    connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
            46},{131.6,46},{131.6,42}}, color={0,0,127}));
    connect(Discharge_OnOff_Throttle.u_s, add8.y) annotation (Line(points={{154,
            64},{161,64},{161,66},{171,66}}, color={0,0,127}));
    connect(Discharge_OnOff_Throttle.u_m, const14.y)
      annotation (Line(points={{142,76},{142,96},{147.6,96}}, color={0,0,127}));
    connect(add8.u2, const16.y)
      annotation (Line(points={{194,60},{215,60}}, color={0,0,127}));
    connect(realExpression.y, add8.u1) annotation (Line(points={{128.7,-26},{174,
            -26},{174,-18},{206,-18},{206,72},{194,72}}, color={0,0,127}));
    connect(actuatorBus.Discharge_OnOff_Throttle, add7.y) annotation (Line(
        points={{30,-100},{30,58},{95,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Reactor_mflow, MFlow_Valve.u_m) annotation (Line(
        points={{-30,-100},{-30,-86},{-40,-86},{-40,-81.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Reactor_mflow, add3.y) annotation (Line(
        points={{30,-100},{30,-74},{19,-74}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
  end CS_IntermediateControl_PID_TESUC_ImpControl_3;

  model CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand
    annotation(Dialog(tab="General"));

    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand)
      annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
    Data.TES_Setpoints data(
      p_steam=1200000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=46.5e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=-10e6,
      rising=720,
      width=7200,
      falling=720,
      period=18000,
      nperiod=-2,
      offset=45e6,
      startTime=20000)
      annotation (Placement(transformation(extent={{68,74},{82,88}})));
    TRANSFORM.Controls.LimPID SHS_TCV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.005,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{98,28},{78,8}})));
    Modelica.Blocks.Sources.Constant const11(k=1)
      annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{62,0},{42,20}})));
    Modelica.Blocks.Math.Add         add7
      annotation (Placement(transformation(extent={{116,48},{96,68}})));
    TRANSFORM.Controls.LimPID Discharge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.5e-9,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - 0.01,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{152,74},{132,54}})));
    Modelica.Blocks.Sources.Constant const14(k=0)
      annotation (Placement(transformation(extent={{156,92},{148,100}})));
    Modelica.Blocks.Sources.Constant const15(k=0.01)
      annotation (Placement(transformation(extent={{140,38},{132,46}})));
    Modelica.Blocks.Math.Add add8(k1=-1)
      annotation (Placement(transformation(extent={{192,56},{172,76}})));
    Modelica.Blocks.Sources.Constant const16(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{236,50},{216,70}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression1(y=electric_demand - data.Q_Nom)
      annotation (Placement(transformation(extent={{166,12},{152,24}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-4,
      Ti=5,
      Td=0.1,
      yMax=2500,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,62},{-38,82}})));
    Modelica.Blocks.Sources.Constant const4(k=100)
      annotation (Placement(transformation(extent={{-32,80},{-24,88}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-16,68},{4,88}})));
  equation
    connect(sensorBus.Power, SHS_TCV.u_m) annotation (Line(
        points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(SHS_TCV.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
            {64,16}}, color={0,0,127}));
    connect(const11.y, add4.u2) annotation (Line(points={{77.6,-6},{70,-6},{70,4},
            {64,4}}, color={0,0,127}));
    connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
        points={{30,-100},{30,10},{41,10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add7.u1, Discharge_OnOff_Throttle.y)
      annotation (Line(points={{118,64},{131,64}}, color={0,0,127}));
    connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
            46},{131.6,46},{131.6,42}}, color={0,0,127}));
    connect(Discharge_OnOff_Throttle.u_s, add8.y) annotation (Line(points={{154,
            64},{161,64},{161,66},{171,66}}, color={0,0,127}));
    connect(Discharge_OnOff_Throttle.u_m, const14.y)
      annotation (Line(points={{142,76},{142,96},{147.6,96}}, color={0,0,127}));
    connect(add8.u2, const16.y)
      annotation (Line(points={{194,60},{215,60}}, color={0,0,127}));
    connect(realExpression.y, add8.u1) annotation (Line(points={{128.7,-26},{174,
            -26},{174,-18},{206,-18},{206,72},{194,72}}, color={0,0,127}));
    connect(actuatorBus.Discharge_OnOff_Throttle, add7.y) annotation (Line(
        points={{30,-100},{30,58},{95,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(realExpression1.y, SHS_TCV.u_s)
      annotation (Line(points={{151.3,18},{100,18}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure,FWCP_Speed. u_m) annotation (Line(
        points={{-30,-100},{-118,-100},{-118,40},{-48,40},{-48,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(const3.y,FWCP_Speed. u_s)
      annotation (Line(points={{-69,72},{-60,72}}, color={0,0,127}));
    connect(FWCP_Speed.y,add. u2)
      annotation (Line(points={{-37,72},{-18,72}},
                                                 color={0,0,127}));
    connect(const4.y,add. u1)
      annotation (Line(points={{-23.6,84},{-18,84}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
        points={{30,-100},{30,78},{5,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  end CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle;

  model CS_IntermediateControl_PID_TESUC_1_intermediate
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

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
      annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand)
      annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
    Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=46.5e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=-10e6,
      rising=720,
      width=7200,
      falling=720,
      period=18000,
      nperiod=-2,
      offset=45e6,
      startTime=20000)
      annotation (Placement(transformation(extent={{68,74},{82,88}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-72,30},{-52,50}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      k=2.5e-5,
      Ti=20,
      Td=0.1,
      yMax=250,
      yMin=-67,
      wp=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    Modelica.Blocks.Sources.Constant const4(k=67)
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
    TRANSFORM.Controls.LimPID SHS_TCV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{98,28},{78,8}})));
    Modelica.Blocks.Sources.Constant const11(k=1)
      annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{62,0},{42,20}})));
    Modelica.Blocks.Math.Add         add5
      annotation (Placement(transformation(extent={{58,-76},{38,-56}})));
    TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-9,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - 0.015,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{90,-50},{70,-70}})));
    Modelica.Blocks.Sources.Constant const10(k=0.015)
      annotation (Placement(transformation(extent={{82,-86},{74,-78}})));
    Modelica.Blocks.Math.Add add6
      annotation (Placement(transformation(extent={{134,-68},{114,-48}})));
    Modelica.Blocks.Sources.Constant const12(k=-data.Q_Nom)
      annotation (Placement(transformation(extent={{178,-74},{158,-54}})));
    Modelica.Blocks.Sources.Constant const13(k=0)
      annotation (Placement(transformation(extent={{98,-32},{90,-24}})));
    Modelica.Blocks.Math.Add         add7
      annotation (Placement(transformation(extent={{116,48},{96,68}})));
    TRANSFORM.Controls.LimPID Discharge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.5e-9,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - 0.01,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{152,74},{132,54}})));
    Modelica.Blocks.Sources.Constant const14(k=0)
      annotation (Placement(transformation(extent={{156,92},{148,100}})));
    Modelica.Blocks.Sources.Constant const15(k=0.01)
      annotation (Placement(transformation(extent={{140,38},{132,46}})));
    Modelica.Blocks.Math.Add add8(k1=-1)
      annotation (Placement(transformation(extent={{192,56},{172,76}})));
    Modelica.Blocks.Sources.Constant const16(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{236,50},{216,70}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                       color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-50,-100},{-50,-60}},
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
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
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
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-18},{13,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,84},{23,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y, FWCP_Speed.u_s)
      annotation (Line(points={{-51,40},{-42,40}}, color={0,0,127}));
    connect(FWCP_Speed.y, add.u2)
      annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,46},{23,46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
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
    connect(sensorBus.Power, SHS_TCV.u_m) annotation (Line(
        points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(SHS_TCV.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
            {64,16}}, color={0,0,127}));
    connect(const11.y, add4.u2) annotation (Line(points={{77.6,-6},{70,-6},{70,4},
            {64,4}}, color={0,0,127}));
    connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
        points={{30,-100},{30,10},{41,10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, SHS_TCV.u_s) annotation (Line(points={{128.7,-26},{
            134,-26},{134,16},{100,16},{100,18}}, color={0,0,127}));
    connect(realExpression.y, TCV_Power.u_s) annotation (Line(points={{128.7,-26},
            {132,-26},{132,-38},{54,-38},{54,-2},{20,-2},{20,4},{-60,4},{-60,-12},
            {-52,-12}}, color={0,0,127}));
    connect(add5.u1, Charge_OnOff_Throttle.y)
      annotation (Line(points={{60,-60},{69,-60}}, color={0,0,127}));
    connect(add5.u2, const10.y) annotation (Line(points={{60,-72},{66,-72},{66,
            -82},{73.6,-82}}, color={0,0,127}));
    connect(Charge_OnOff_Throttle.u_s, add6.y) annotation (Line(points={{92,-60},
            {104,-60},{104,-58},{113,-58}}, color={0,0,127}));
    connect(realExpression.y, add6.u1) annotation (Line(points={{128.7,-26},{146,
            -26},{146,-52},{136,-52}}, color={0,0,127}));
    connect(add6.u2, const12.y)
      annotation (Line(points={{136,-64},{157,-64}}, color={0,0,127}));
    connect(const13.y, Charge_OnOff_Throttle.u_m)
      annotation (Line(points={{89.6,-28},{80,-28},{80,-48}}, color={0,0,127}));
    connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
        points={{30,-100},{30,-66},{37,-66}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add7.u1, Discharge_OnOff_Throttle.y)
      annotation (Line(points={{118,64},{131,64}}, color={0,0,127}));
    connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
            46},{131.6,46},{131.6,42}}, color={0,0,127}));
    connect(Discharge_OnOff_Throttle.u_s, add8.y) annotation (Line(points={{154,
            64},{161,64},{161,66},{171,66}}, color={0,0,127}));
    connect(Discharge_OnOff_Throttle.u_m, const14.y)
      annotation (Line(points={{142,76},{142,96},{147.6,96}}, color={0,0,127}));
    connect(add8.u2, const16.y)
      annotation (Line(points={{194,60},{215,60}}, color={0,0,127}));
    connect(realExpression.y, add8.u1) annotation (Line(points={{128.7,-26},{174,
            -26},{174,-18},{206,-18},{206,72},{194,72}}, color={0,0,127}));
    connect(actuatorBus.Discharge_OnOff_Throttle, add7.y) annotation (Line(
        points={{30,-100},{30,58},{95,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
  end CS_IntermediateControl_PID_TESUC_1_intermediate;

  model CS_IntermediateControl_PID_TESUC_ImpControl_2
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

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
      annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand)
      annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
    Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=46.5e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=-10e6,
      rising=720,
      width=7200,
      falling=720,
      period=18000,
      nperiod=-2,
      offset=45e6,
      startTime=20000)
      annotation (Placement(transformation(extent={{68,74},{82,88}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    TRANSFORM.Controls.LimPID FWCP_mflow(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      k=2.5e-5,
      Ti=20,
      Td=0.1,
      yMax=250,
      yMin=-67,
      wp=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    Modelica.Blocks.Sources.Constant const4(k=67)
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
    TRANSFORM.Controls.LimPID SHS_Pump_MFR(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-3,
      Ti=5,
      Td=0.1,
      yMax=100,
      yMin=-19.9,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-46,-80},{-34,-68}})));
    Modelica.Blocks.Sources.Constant const1(k=data.T_SHS_Return)
      annotation (Placement(transformation(extent={{-92,-88},{-72,-68}})));
    Modelica.Blocks.Sources.Constant const6(k=20)
      annotation (Placement(transformation(extent={{-26,-84},{-18,-76}})));
    Modelica.Blocks.Math.Add         add3
      annotation (Placement(transformation(extent={{-2,-84},{18,-64}})));
    TRANSFORM.Controls.LimPID SHS_TCV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{98,28},{78,8}})));
    Modelica.Blocks.Sources.Constant const11(k=1)
      annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{62,0},{42,20}})));
    Modelica.Blocks.Math.Add         add5
      annotation (Placement(transformation(extent={{58,-76},{38,-56}})));
    TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-9,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - 0.015,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{90,-50},{70,-70}})));
    Modelica.Blocks.Sources.Constant const10(k=0.015)
      annotation (Placement(transformation(extent={{82,-86},{74,-78}})));
    Modelica.Blocks.Math.Add add6
      annotation (Placement(transformation(extent={{134,-68},{114,-48}})));
    Modelica.Blocks.Sources.Constant const12(k=-data.Q_Nom)
      annotation (Placement(transformation(extent={{178,-74},{158,-54}})));
    Modelica.Blocks.Sources.Constant const13(k=0)
      annotation (Placement(transformation(extent={{98,-32},{90,-24}})));
    Modelica.Blocks.Math.Add         add7
      annotation (Placement(transformation(extent={{116,48},{96,68}})));
    TRANSFORM.Controls.LimPID Discharge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.5e-9,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - 0.01,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{152,74},{132,54}})));
    Modelica.Blocks.Sources.Constant const14(k=0)
      annotation (Placement(transformation(extent={{156,92},{148,100}})));
    Modelica.Blocks.Sources.Constant const15(k=0.01)
      annotation (Placement(transformation(extent={{140,38},{132,46}})));
    Modelica.Blocks.Math.Add add8(k1=-1)
      annotation (Placement(transformation(extent={{192,56},{172,76}})));
    Modelica.Blocks.Sources.Constant const16(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{236,50},{216,70}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                       color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-50,-100},{-50,-60}},
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
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
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
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-18},{13,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.Steam_Pressure,FWCP_mflow. u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,84},{23,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y,FWCP_mflow. u_s)
      annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
    connect(FWCP_mflow.y, add.u2)
      annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,46},{23,46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
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
    connect(sensorBus.SHS_Return_T, SHS_Pump_MFR.u_m) annotation (Line(
        points={{-30,-100},{-40,-100},{-40,-81.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(const1.y, SHS_Pump_MFR.u_s) annotation (Line(points={{-71,-78},{-56,-78},
            {-56,-74},{-47.2,-74}}, color={0,0,127}));
    connect(SHS_Pump_MFR.y, add3.u1) annotation (Line(points={{-33.4,-74},{-32,-74},
            {-32,-72},{-10,-72},{-10,-68},{-4,-68}}, color={0,0,127}));
    connect(const6.y, add3.u2) annotation (Line(points={{-17.6,-80},{-16,-80},{-16,
            -76},{-8,-76},{-8,-86},{-4,-86},{-4,-80}}, color={0,0,127}));
    connect(sensorBus.Power, SHS_TCV.u_m) annotation (Line(
        points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(SHS_TCV.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
            {64,16}}, color={0,0,127}));
    connect(const11.y, add4.u2) annotation (Line(points={{77.6,-6},{70,-6},{70,4},
            {64,4}}, color={0,0,127}));
    connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
        points={{30,-100},{30,10},{41,10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, SHS_TCV.u_s) annotation (Line(points={{128.7,-26},{
            134,-26},{134,16},{100,16},{100,18}}, color={0,0,127}));
    connect(realExpression.y, TCV_Power.u_s) annotation (Line(points={{128.7,-26},
            {132,-26},{132,-38},{54,-38},{54,-2},{20,-2},{20,4},{-60,4},{-60,-12},
            {-52,-12}}, color={0,0,127}));
    connect(add5.u1, Charge_OnOff_Throttle.y)
      annotation (Line(points={{60,-60},{69,-60}}, color={0,0,127}));
    connect(add5.u2, const10.y) annotation (Line(points={{60,-72},{66,-72},{66,
            -82},{73.6,-82}}, color={0,0,127}));
    connect(Charge_OnOff_Throttle.u_s, add6.y) annotation (Line(points={{92,-60},
            {104,-60},{104,-58},{113,-58}}, color={0,0,127}));
    connect(realExpression.y, add6.u1) annotation (Line(points={{128.7,-26},{146,
            -26},{146,-52},{136,-52}}, color={0,0,127}));
    connect(add6.u2, const12.y)
      annotation (Line(points={{136,-64},{157,-64}}, color={0,0,127}));
    connect(const13.y, Charge_OnOff_Throttle.u_m)
      annotation (Line(points={{89.6,-28},{80,-28},{80,-48}}, color={0,0,127}));
    connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
        points={{30,-100},{30,-66},{37,-66}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add7.u1, Discharge_OnOff_Throttle.y)
      annotation (Line(points={{118,64},{131,64}}, color={0,0,127}));
    connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
            46},{131.6,46},{131.6,42}}, color={0,0,127}));
    connect(Discharge_OnOff_Throttle.u_s, add8.y) annotation (Line(points={{154,
            64},{161,64},{161,66},{171,66}}, color={0,0,127}));
    connect(Discharge_OnOff_Throttle.u_m, const14.y)
      annotation (Line(points={{142,76},{142,96},{147.6,96}}, color={0,0,127}));
    connect(add8.u2, const16.y)
      annotation (Line(points={{194,60},{215,60}}, color={0,0,127}));
    connect(realExpression.y, add8.u1) annotation (Line(points={{128.7,-26},{174,
            -26},{174,-18},{206,-18},{206,72},{194,72}}, color={0,0,127}));
    connect(actuatorBus.Discharge_OnOff_Throttle, add7.y) annotation (Line(
        points={{30,-100},{30,58},{95,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
  end CS_IntermediateControl_PID_TESUC_ImpControl_2;

  model CS_IntermediateControl_PID_TESUC_ImpControl
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

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
      annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand)
      annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
    Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=40e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=-10e6,
      rising=720,
      width=7200,
      falling=720,
      period=18000,
      nperiod=-2,
      offset=45e6,
      startTime=20000)
      annotation (Placement(transformation(extent={{68,74},{82,88}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-7,
      Ti=20,
      yMax=250,
      yMin=-72,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    Modelica.Blocks.Sources.Constant const4(k=72.1)
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
    TRANSFORM.Controls.LimPID SHS_Pump_MFR(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-3,
      Ti=5,
      Td=0.1,
      yMax=100,
      yMin=-19.9,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-46,-80},{-34,-68}})));
    Modelica.Blocks.Sources.Constant const1(k=data.T_SHS_Return)
      annotation (Placement(transformation(extent={{-92,-88},{-72,-68}})));
    Modelica.Blocks.Sources.Constant const6(k=20)
      annotation (Placement(transformation(extent={{-26,-84},{-18,-76}})));
    Modelica.Blocks.Math.Add         add3
      annotation (Placement(transformation(extent={{-2,-84},{18,-64}})));
    TRANSFORM.Controls.LimPID SHS_TCV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{98,28},{78,8}})));
    Modelica.Blocks.Sources.Constant const11(k=1)
      annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{62,0},{42,20}})));
    Modelica.Blocks.Math.Add         add5
      annotation (Placement(transformation(extent={{58,-76},{38,-56}})));
    TRANSFORM.Controls.LimPID SHS_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - 0.015,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{90,-50},{70,-70}})));
    Modelica.Blocks.Sources.Constant const10(k=0.015)
      annotation (Placement(transformation(extent={{82,-86},{74,-78}})));
    Modelica.Blocks.Math.Add add6
      annotation (Placement(transformation(extent={{134,-68},{114,-48}})));
    Modelica.Blocks.Sources.Constant const12(k=-data.Q_Nom)
      annotation (Placement(transformation(extent={{178,-74},{158,-54}})));
    Modelica.Blocks.Sources.Constant const13(k=0)
      annotation (Placement(transformation(extent={{98,-32},{90,-24}})));
    Modelica.Blocks.Math.Add         add7
      annotation (Placement(transformation(extent={{116,48},{96,68}})));
    TRANSFORM.Controls.LimPID Discharge_MassFlow(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-2e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-18,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{150,74},{130,54}})));
    Modelica.Blocks.Sources.Constant const14(k=0)
      annotation (Placement(transformation(extent={{156,92},{148,100}})));
    Modelica.Blocks.Sources.Constant const15(k=20)
      annotation (Placement(transformation(extent={{140,38},{132,46}})));
    Modelica.Blocks.Math.Add add8(k1=-1)
      annotation (Placement(transformation(extent={{192,56},{172,76}})));
    Modelica.Blocks.Sources.Constant const16(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{236,50},{216,70}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                       color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-50,-100},{-50,-60}},
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
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
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
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-18},{13,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,84},{23,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y, FWCP_Speed.u_s)
      annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
    connect(FWCP_Speed.y, add.u2)
      annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,46},{23,46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
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
    connect(sensorBus.SHS_Return_T, SHS_Pump_MFR.u_m) annotation (Line(
        points={{-30,-100},{-40,-100},{-40,-81.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(const1.y, SHS_Pump_MFR.u_s) annotation (Line(points={{-71,-78},{-56,-78},
            {-56,-74},{-47.2,-74}}, color={0,0,127}));
    connect(SHS_Pump_MFR.y, add3.u1) annotation (Line(points={{-33.4,-74},{-32,-74},
            {-32,-72},{-10,-72},{-10,-68},{-4,-68}}, color={0,0,127}));
    connect(const6.y, add3.u2) annotation (Line(points={{-17.6,-80},{-16,-80},{-16,
            -76},{-8,-76},{-8,-86},{-4,-86},{-4,-80}}, color={0,0,127}));
    connect(sensorBus.Power, SHS_TCV.u_m) annotation (Line(
        points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(SHS_TCV.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
            {64,16}}, color={0,0,127}));
    connect(const11.y, add4.u2) annotation (Line(points={{77.6,-6},{70,-6},{70,4},
            {64,4}}, color={0,0,127}));
    connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
        points={{30,-100},{30,10},{41,10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, SHS_TCV.u_s) annotation (Line(points={{128.7,-26},{
            134,-26},{134,16},{100,16},{100,18}}, color={0,0,127}));
    connect(realExpression.y, TCV_Power.u_s) annotation (Line(points={{128.7,-26},
            {132,-26},{132,-38},{54,-38},{54,-2},{20,-2},{20,4},{-60,4},{-60,-12},
            {-52,-12}}, color={0,0,127}));
    connect(add5.u1, SHS_Throttle.y)
      annotation (Line(points={{60,-60},{69,-60}}, color={0,0,127}));
    connect(add5.u2, const10.y) annotation (Line(points={{60,-72},{66,-72},{66,
            -82},{73.6,-82}}, color={0,0,127}));
    connect(SHS_Throttle.u_s, add6.y) annotation (Line(points={{92,-60},{104,-60},
            {104,-58},{113,-58}}, color={0,0,127}));
    connect(realExpression.y, add6.u1) annotation (Line(points={{128.7,-26},{146,
            -26},{146,-52},{136,-52}}, color={0,0,127}));
    connect(add6.u2, const12.y)
      annotation (Line(points={{136,-64},{157,-64}}, color={0,0,127}));
    connect(const13.y, SHS_Throttle.u_m)
      annotation (Line(points={{89.6,-28},{80,-28},{80,-48}}, color={0,0,127}));
    connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
        points={{30,-100},{30,-66},{37,-66}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.condensor_pump, add7.y) annotation (Line(
        points={{30,-100},{30,58},{95,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add7.u1, Discharge_MassFlow.y)
      annotation (Line(points={{118,64},{129,64}}, color={0,0,127}));
    connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
            46},{131.6,46},{131.6,42}}, color={0,0,127}));
    connect(Discharge_MassFlow.u_s, add8.y) annotation (Line(points={{152,64},{
            161,64},{161,66},{171,66}}, color={0,0,127}));
    connect(Discharge_MassFlow.u_m, const14.y)
      annotation (Line(points={{140,76},{140,96},{147.6,96}}, color={0,0,127}));
    connect(add8.u2, const16.y)
      annotation (Line(points={{194,60},{215,60}}, color={0,0,127}));
    connect(realExpression.y, add8.u1) annotation (Line(points={{128.7,-26},{174,
            -26},{174,-18},{206,-18},{206,72},{194,72}}, color={0,0,127}));
  end CS_IntermediateControl_PID_TESUC_ImpControl;

  model CS_IntermediateControl_PID_6_Pressure
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand_int = data.Q_Nom;

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-4,
      Ti=60,
      Td=0.1,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
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
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
    Data.TES_Setpoints data(
      p_steam(displayUnit="Pa") = 1197000,
      p_steam_vent(displayUnit="Pa") = 15000000,
      T_Steam_Ref=491.15,
      Q_Nom=18.57e6,
      T_Feedwater=309.9)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{62,-12},{82,8}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=-10e6,
      rising=720,
      width=7200,
      falling=720,
      period=18000,
      nperiod=-2,
      offset=45e6,
      startTime=20000)
      annotation (Placement(transformation(extent={{-92,-22},{-78,-8}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5,
      Ti=5,
      yMax=100,
      yMin=-12,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    Modelica.Blocks.Sources.Constant const4(k=12e5)
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
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                       color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-50,-100},{-50,-60}},
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
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
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
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-18},{13,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,84},{23,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y, FWCP_Speed.u_s)
      annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
    connect(FWCP_Speed.y, add.u2)
      annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,46},{23,46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
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
    connect(TCV_Power.u_s, const.y) annotation (Line(points={{-52,-12},{-58,-12},
            {-58,4},{50,4},{50,18},{88,18},{88,-2},{83,-2}}, color={0,0,127}));
  end CS_IntermediateControl_PID_6_Pressure;

  model CS_IntermediateControl_PID_TESUC
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand_int = data.Q_Nom;

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-4,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand_int)
      annotation (Placement(transformation(extent={{-94,-6},{-80,6}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
    Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=67.38e6,
      T_Feedwater=421.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{62,-12},{82,8}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=-10e6,
      rising=720,
      width=7200,
      falling=720,
      period=18000,
      nperiod=-2,
      offset=45e6,
      startTime=20000)
      annotation (Placement(transformation(extent={{-92,-22},{-78,-8}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-7,
      Ti=20,
      yMax=250,
      yMin=-72,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    Modelica.Blocks.Sources.Constant const4(k=72.1)
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
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                       color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-50,-100},{-50,-60}},
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
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
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
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-18},{13,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,84},{23,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y, FWCP_Speed.u_s)
      annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
    connect(FWCP_Speed.y, add.u2)
      annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,46},{23,46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
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
    connect(const.y, TCV_Power.u_s) annotation (Line(points={{83,-2},{88,-2},{88,
            14},{-14,14},{-14,4},{-60,4},{-60,-12},{-52,-12}}, color={0,0,127}));
  end CS_IntermediateControl_PID_TESUC;

  model CS_IntermediateControl_PID_6
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand_int = data.Q_Nom;

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-4,
      Ti=60,
      Td=0.1,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
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
    Data.TES_Setpoints data(
      p_steam(displayUnit="bar") = 3400000,
      p_steam_vent(displayUnit="Pa") = 15000000,
      T_Steam_Ref=579.15,
      Q_Nom=30e6,
      T_Feedwater=323.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{62,-12},{82,8}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=-10e6,
      rising=720,
      width=7200,
      falling=720,
      period=18000,
      nperiod=-2,
      offset=45e6,
      startTime=20000)
      annotation (Placement(transformation(extent={{-92,-22},{-78,-8}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-5,
      Ti=20,
      yMax=250,
      yMin=-20,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    Modelica.Blocks.Sources.Constant const4(k=200)
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
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                       color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-50,-100},{-50,-60}},
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
    connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,84},{23,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y, FWCP_Speed.u_s)
      annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
    connect(FWCP_Speed.y, add.u2)
      annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,46},{23,46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
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
    connect(TCV_Power.u_s, const.y) annotation (Line(points={{-52,-12},{-58,-12},
            {-58,4},{50,4},{50,18},{88,18},{88,-2},{83,-2}}, color={0,0,127}));
    connect(Turb_Divert_Valve.y, add2.u1)
      annotation (Line(points={{-39,-48},{-39,-40},{-10,-40}}, color={0,0,127}));
  end CS_IntermediateControl_PID_6;

  model CS_IntermediateControl_PID_5
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand_int = data.Q_Nom;

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-4,
      Ti=60,
      Td=0.1,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-8,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
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
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
    Data.TES_Setpoints data(
      p_steam=3500000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=60e6,
      T_Feedwater=421.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{62,-12},{82,8}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=-10e6,
      rising=720,
      width=7200,
      falling=720,
      period=18000,
      nperiod=-2,
      offset=45e6,
      startTime=20000)
      annotation (Placement(transformation(extent={{-92,-22},{-78,-8}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-7,
      Ti=20,
      yMax=250,
      yMin=-72,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    Modelica.Blocks.Sources.Constant const4(k=72.1)
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
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                       color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-50,-100},{-50,-60}},
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
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
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
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-18},{13,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,84},{23,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y, FWCP_Speed.u_s)
      annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
    connect(FWCP_Speed.y, add.u2)
      annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,46},{23,46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
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
    connect(TCV_Power.u_s, const.y) annotation (Line(points={{-52,-12},{-58,-12},
            {-58,4},{50,4},{50,18},{88,18},{88,-2},{83,-2}}, color={0,0,127}));
  end CS_IntermediateControl_PID_5;

  model CS_IntermediateControl_PID_3
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1,
      Ti=15,
      yMax=750,
      yMin=-1500,
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
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=1e-3,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-60,-56},{-40,-36}})));
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
    Modelica.Blocks.Sources.Constant const8(k=0)
      annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-9,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-38,68},{-18,88}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-78,68},{-58,88}})));
    Fluid.Intermediate_Rankine data(
      p_steam_vent=3600000,
      T_Steam_Ref=579.75,
      Q_Nom=60e6,
      T_Feedwater=421.15)
      annotation (Placement(transformation(extent={{-96,12},{-76,32}})));
    Modelica.Blocks.Math.Add         add3
      annotation (Placement(transformation(extent={{-8,-82},{12,-62}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{-32,-82},{-24,-74}})));
    TRANSFORM.Controls.LimPID CondensorBalance(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-2,
      Ti=15,
      yMax=2000,
      yMin=-2000,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500,
      y_start=0)
      annotation (Placement(transformation(extent={{-86,-90},{-66,-70}})));
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
      annotation (Line(points={{-71,-46},{-62,-46}},   color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-50,-100},{-50,-58}},
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
    connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-46},{-36,
            -46},{-36,-40},{-32.8,-40}},                               color={0,0,
            127}));
    connect(const9.y,PI_TBV. u_s)
      annotation (Line(points={{-57,78},{-40,78}},   color={0,0,127}));
    connect(sensorBus.Steam_Pressure,PI_TBV. u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,60},{-28,60},{-28,66}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.opening_TCV,add1. y) annotation (Line(
        points={{30.1,-99.9},{30.1,-16},{30,-16},{30,-18},{13,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(CondensorBalance.u_m, sensorBus.Condensor_Output_mflow) annotation (
        Line(points={{-76,-92},{-76,-100},{-30,-100}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(CondensorBalance.u_s, sensorBus.Condensor_Input_mflow) annotation (
        Line(points={{-88,-80},{-100,-80},{-100,-100},{-30,-100}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(CondensorBalance.y, add3.u1) annotation (Line(points={{-65,-80},{-54,
            -80},{-54,-66},{-10,-66}}, color={0,0,127}));
    connect(const1.y, add3.u2)
      annotation (Line(points={{-23.6,-78},{-10,-78}}, color={0,0,127}));
    connect(add3.y, actuatorBus.CondensorFlow) annotation (Line(points={{13,-72},
            {30,-72},{30,-100}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-46},{13,-46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_BV, PI_TBV.y) annotation (Line(
        points={{30.1,-99.9},{30.1,78},{-17,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  end CS_IntermediateControl_PID_3;

  model CS_IntermediateControl_PID_2
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

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
      annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
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
    Fluid.Intermediate_Rankine data
      annotation (Placement(transformation(extent={{-96,12},{-76,32}})));
    Modelica.Blocks.Sources.Constant ExternalDivertValve(k=1)
      annotation (Placement(transformation(extent={{80,-28},{60,-8}})));
    Modelica.Blocks.Sources.Constant Volume_pump(k=200)
      annotation (Placement(transformation(extent={{80,14},{60,34}})));
    Modelica.Blocks.Math.Add         add3
      annotation (Placement(transformation(extent={{-8,-82},{12,-62}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{-32,-82},{-24,-74}})));
    TRANSFORM.Controls.LimPID Turb_Divert_Valve1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-2,
      Ti=15,
      yMax=200,
      yMin=-200,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-86,-90},{-66,-70}})));
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
        points={{30,-100},{30,-46},{13,-46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-46},{-36,
            -46},{-36,-40},{-32.8,-40}},                               color={0,0,
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
    connect(Turb_Divert_Valve1.u_m, sensorBus.Condensor_Output_mflow) annotation (
       Line(points={{-76,-92},{-76,-100},{-30,-100}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(Turb_Divert_Valve1.u_s, sensorBus.Condensor_Input_mflow) annotation (
        Line(points={{-88,-80},{-100,-80},{-100,-100},{-30,-100}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(Turb_Divert_Valve1.y, add3.u1) annotation (Line(points={{-65,-80},{
            -54,-80},{-54,-66},{-10,-66}}, color={0,0,127}));
    connect(const1.y, add3.u2)
      annotation (Line(points={{-23.6,-78},{-10,-78}}, color={0,0,127}));
    connect(add3.y, actuatorBus.CondensorFlow) annotation (Line(points={{13,-72},
            {30,-72},{30,-100}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  end CS_IntermediateControl_PID_2;

  model CS_IntermediateControl_PID
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

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
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2)
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
    Fluid.Intermediate_Rankine data
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

  model CS_IntermediateControl
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    Modelica.Blocks.Sources.Constant TCV_openingNominal(k=0.5)
      annotation (Placement(transformation(extent={{-10,10},{10,30}})));
    Modelica.Blocks.Sources.Constant Feed_Pump_Speed(k=2500)
      annotation (Placement(transformation(extent={{72,42},{52,62}})));
    Modelica.Blocks.Sources.Constant Divert_Valve_Position(k=0.1)
      annotation (Placement(transformation(extent={{-10,42},{10,62}})));
    Modelica.Blocks.Sources.Pulse pulse(
      amplitude=0,
      period=50,
      offset=0.001,
      startTime=20)
      annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));
    Modelica.Blocks.Sources.Constant Feed_Pump_dp(k=18)
      annotation (Placement(transformation(extent={{72,-6},{52,14}})));
    Modelica.Blocks.Sources.Constant TBV(k=0)
      annotation (Placement(transformation(extent={{72,-46},{52,-26}})));
  equation
    connect(actuatorBus.opening_TCV, TCV_openingNominal.y) annotation (
       Line(
        points={{30.1,-99.9},{30.1,20},{11,20}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Divert_Valve_Position, Divert_Valve_Position.y)
      annotation (Line(
        points={{30,-100},{30,52},{11,52}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Feed_Pump_Speed, Feed_Pump_Speed.y)
      annotation (Line(
        points={{30,-100},{30,52},{51,52}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(pulse.y, actuatorBus.opening_BV) annotation (Line(points={{11,-32},{30.1,
            -32},{30.1,-99.9}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(Feed_Pump_dp.y, actuatorBus.condensor_pump) annotation (Line(points={
            {51,4},{30,4},{30,-100}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(TBV.y, actuatorBus.TBV) annotation (Line(points={{51,-36},{30,-36},{
            30,-100}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
  end CS_IntermediateControl;

  model CS_DirectCoupling
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

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
                                     realExpression(y=electric_demand_large)
      annotation (Placement(transformation(extent={{96,-32},{110,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2) annotation (Placement(transformation(extent={{
              -32,-128},{-24,-120}})));
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
      annotation (Placement(transformation(extent={{152,-78},{132,-98}})));
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
    connect(min1.u1, const6.y)
      annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
    connect(Charge_OnOff_Throttle.u_m, min1.y) annotation (Line(points={{142,-76},
            {142,-66},{113,-66},{113,-70}}, color={0,0,127}));
    connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
            -26},{160,-64},{172,-64}}, color={0,0,127}));
    connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
            {238,-70},{238,-88},{154,-88}}, color={0,0,127}));
    connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
            -46},{141.2,-46}}, color={0,0,127}));
    connect(sensorBus.Power, min1.u2) annotation (Line(
        points={{-30,-100},{-30,-84},{84,-84},{84,-76},{90,-76}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Diagram(graphics={Text(
            extent={{-70,-142},{-20,-160}},
            textColor={28,108,200},
            textString="Feedwater")}));
  end CS_DirectCoupling;
end ObsoleteCS;
