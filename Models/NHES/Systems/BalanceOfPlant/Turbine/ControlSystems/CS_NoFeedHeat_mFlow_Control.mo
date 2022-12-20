within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_NoFeedHeat_mFlow_Control

  // Modified from CS_SmallCycle_NoFeedHeat_Argonne

  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand_large
  annotation(Dialog(tab="General"));

  replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.TES_Setpoints data(
    p_steam=1200000,
    p_steam_vent=15000000,
    T_Steam_Ref=579.75,
    Q_Nom=48.57e6,
    T_Feedwater=421.15,
    T_SHS_Return=491.15)
    annotation (Placement(transformation(extent={{64,42},{78,56}})));
  Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  TRANSFORM.Controls.LimPID FWP_mFlow(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=5,
    Td=0.1,
    yMax=50,
    yMin=0.9,
    wd=1,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-28,14},{-8,34}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{-14,44},{-6,52}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Sources.Constant const11(k=1e-4)
    annotation (Placement(transformation(extent={{-4,-56},{4,-48}})));
  Modelica.Blocks.Math.Add         add4
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter(min=0, max=1)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=electric_demand_large)
    annotation (Placement(transformation(extent={{-74,18},{-60,30}})));
  TRANSFORM.Controls.LimPID TCV_SHS(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=-1e-9,
    Ti=1,
    Td=0.1,
    yMax=1 - const11.k,
    yMin=0,
    wd=1,
    Ni=0.9,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
equation
  connect(FWP_mFlow.y, add.u2)
    annotation (Line(points={{-7,24},{18,24}}, color={0,0,127}));
  connect(const4.y,add. u1)
    annotation (Line(points={{-5.6,48},{12,48},{12,36},{18,36}},
                                                color={0,0,127}));
  connect(const11.y,add4. u2) annotation (Line(points={{4.4,-52},{12,-52},{
          12,-36},{18,-36}},
                   color={0,0,127}));
  connect(add4.u1,minMaxFilter. y)
    annotation (Line(points={{18,-24},{8,-24},{8,-30},{1.4,-30}},
                                                   color={0,0,127}));
  connect(minMaxFilter.u, TCV_SHS.y)
    annotation (Line(points={{-22,-30},{-29,-30}},
                                                 color={0,0,127}));
  connect(realExpression.y, FWP_mFlow.u_s)
    annotation (Line(points={{-59.3,24},{-30,24}}, color={0,0,127}));
  connect(sensorBus.Power, FWP_mFlow.u_m) annotation (Line(
      points={{-30,-100},{-30,-70},{-86,-70},{-86,12},{-18,12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const3.y, TCV_SHS.u_s)
    annotation (Line(points={{-59,-30},{-52,-30}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, TCV_SHS.u_m) annotation (Line(
      points={{-30,-100},{-30,-50},{-40,-50},{-40,-42}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
      points={{30,-100},{30,-70},{48,-70},{48,-30},{41,-30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Feed_Pump_mFlow, add.y) annotation (Line(
      points={{30,-100},{30,-72},{50,-72},{50,30},{41,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,60}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,60}})),
    experiment(
      StopTime=200,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end CS_NoFeedHeat_mFlow_Control;
