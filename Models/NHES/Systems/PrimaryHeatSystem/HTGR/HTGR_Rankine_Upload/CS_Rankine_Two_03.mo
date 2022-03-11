within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload;
model CS_Rankine_Two_03

  extends HTGR_Rankine_Upload.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=3e-6,
    Ti=2.5,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-40,-56},{-20,-36}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-80,-56},{-60,-36}})));
  HTGR_Rankine_Upload.Data.Data_CS data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=30,
    yMax=250,
    yMin=25,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-38,14},{-18,-6}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{-78,-6},{-58,14}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-2,
    Ti=30,
    yMax=750,
    yMin=-1000,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-36,60},{-16,40}})));
  Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
    annotation (Placement(transformation(extent={{-64,38},{-44,58}})));
  Modelica.Blocks.Sources.Constant const4(k=1500)
    annotation (Placement(transformation(extent={{-10,66},{10,86}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{18,36},{38,56}})));
  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=15,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-52,-122},{-32,-142}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-124,-138},{-104,-118}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-20,-156},{0,-176}})));
  Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{-58,-176},{-38,-156}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{-20,-210},{0,-190}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{28,-196},{48,-176}})));
  Modelica.Blocks.Sources.Constant const8(k=1e-6)
    annotation (Placement(transformation(extent={{-114,-174},{-94,-154}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-2,-138},{18,-118}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
    timer(Start_Time=1e-2, mult_time_constant=1)
    annotation (Placement(transformation(extent={{-18,-130},{-12,-122}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-42,100},{-22,120}})));
  Modelica.Blocks.Sources.Constant const9(k=150e5)
    annotation (Placement(transformation(extent={{-82,100},{-62,120}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-59,-46},{-42,-46}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-58}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{-57,4},{-40,4}}, color={0,0,127}));
  connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{-43,48},{-43,56},
          {-38,56},{-38,50}}, color={0,0,127}));
  connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-74},{-104,-74},{-104,74},{-26,74},{-26,62}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const4.y, add.u1) annotation (Line(points={{11,76},{16,76},{16,58},{
          10,58},{10,52},{16,52}}, color={0,0,127}));
  connect(FWCP_Speed.y, add.u2) annotation (Line(points={{-15,50},{8,50},{8,40},
          {16,40}}, color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{30,16},{56,16},{56,46},{39,46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const5.y, Turb_Divert_Valve.u_s)
    annotation (Line(points={{-103,-128},{-78,-128},{-78,-132},{-54,-132}},
                                                     color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
      points={{-30,-100},{-36,-100},{-36,-120},{-42,-120}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
      points={{-30,-100},{-30,-114},{-10,-114},{-10,-154}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y, add1.u2) annotation (Line(points={{1,-200},{12,-200},{12,
          -198},{26,-198},{26,-192}}, color={0,0,127}));
  connect(TCV_Position.y, add1.u1) annotation (Line(points={{1,-166},{6,-166},{
          6,-164},{10,-164},{10,-180},{26,-180}}, color={0,0,127}));
  connect(actuatorBus.TCV_Position, add1.y) annotation (Line(
      points={{30,-100},{34,-100},{34,-150},{38,-150},{38,-154},{70,-154},{70,
          -186},{49,-186}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{30,-126},{19,-126},{19,-128}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add2.u2, const8.y) annotation (Line(points={{-4,-134},{-20,-134},{-20,
          -148},{-38,-148},{-38,-150},{-72,-150},{-72,-164},{-93,-164}}, color=
          {0,0,127}));
  connect(add2.u1, timer.y) annotation (Line(points={{-4,-122},{-8,-122},{-8,
          -126},{-11.58,-126}},                                 color={0,0,127}));
  connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-31,-132},{
          -20,-132},{-20,-126},{-18.6,-126}},                        color={0,0,
          127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{-61,110},{-44,110}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-30,-72},{-104,-72},{-104,88},{-32,88},{-32,98}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{30,26},{82,26},{82,98},{-21,98},{-21,110}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-72},{-104,-72},{-104,24},{-28,24},{-28,16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
      points={{30,-100},{30,6},{28,6},{28,4},{-17,4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{30,-46},{-19,-46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const6.y, TCV_Position.u_s) annotation (Line(points={{-37,-166},{-38,
          -166},{-38,-166},{-22,-166}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Two_03;
