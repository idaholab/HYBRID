within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS;
model CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle_AR
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

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
  StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
                                                                    PI_DFV(
    k=5,
    Ti=30,
    k_s=5e-9,
    k_m=5e-9)
    annotation (Placement(transformation(extent={{178,54},{158,74}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
                                                                    PI_DCV1(
    k=5,
    Ti=30,
    k_s=5e-9,
    k_m=5e-9)
    annotation (Placement(transformation(extent={{164,6},{144,26}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter(max=1 - 0.001)
    annotation (Placement(transformation(extent={{134,6},{114,26}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
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
