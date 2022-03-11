within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload;
model CS_Rankine_Power_Change_2

  extends HTGR_Rankine_Upload.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-6,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-40,-54},{-20,-34}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-80,-54},{-60,-34}})));
  HTGR_Rankine_Upload.Data.Data_CS data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    Q_RX_Therm_Nom=175e6)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-6,
    Ti=22.5,
    yMax=225,
    yMin=60,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-38,14},{-18,-6}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{-78,-6},{-58,14}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-2,
    Ti=2.5,
    yMax=750,
    yMin=-1000,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-34,58},{-14,38}})));
  Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
    annotation (Placement(transformation(extent={{-64,38},{-44,58}})));
  Modelica.Blocks.Sources.Constant const4(k=1500)
    annotation (Placement(transformation(extent={{-10,66},{10,86}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{18,36},{38,56}})));
  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2.5e-5,
    Ti=10,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-52,-122},{-32,-142}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-124,-138},{-104,-118}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=3e-9,
    Ti=2.5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-20,-164},{0,-184}})));
  Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{-104,-230},{-84,-210}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{-20,-216},{0,-196}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{28,-196},{48,-176}})));
  Modelica.Blocks.Sources.Constant const8(k=1e-6)
    annotation (Placement(transformation(extent={{-114,-174},{-94,-154}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-2,-138},{18,-118}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
    timer(Start_Time=1e-2, mult_time_constant=1)
    annotation (Placement(transformation(extent={{-88,-106},{-68,-86}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=5e-5,
    Ti=0.5,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-52,140},{-32,160}})));
  Modelica.Blocks.Sources.Ramp     ramp(
    height=-0.4*data.Q_Nom,
    duration=900,
    offset=0,
    startTime=33600)
    annotation (Placement(transformation(extent={{-100,-202},{-80,-182}})));
  Modelica.Blocks.Sources.Ramp     ramp1(
    height=0.4*data.Q_Nom,
    duration=900,
    offset=0,
    startTime=33600 + 2700 + 900)
    annotation (Placement(transformation(extent={{-98,-258},{-78,-238}})));
  Modelica.Blocks.Math.Add3        add3
    annotation (Placement(transformation(extent={{-56,-234},{-36,-214}})));
  Modelica.Blocks.Math.Add3        add4
    annotation (Placement(transformation(extent={{-82,132},{-62,152}})));
  Modelica.Blocks.Sources.Constant const6(k=0.0)
    annotation (Placement(transformation(extent={{-130,136},{-110,156}})));
  Modelica.Blocks.Sources.Ramp     ramp2(
    height=15.0,
    duration=900,
    offset=0,
    startTime=7200)
    annotation (Placement(transformation(extent={{-128,164},{-108,184}})));
  Modelica.Blocks.Sources.Ramp     ramp3(
    height=-15.0,
    duration=900,
    offset=0,
    startTime=7200 + 2700 + 900)
    annotation (Placement(transformation(extent={{-130,108},{-110,128}})));
  Modelica.Blocks.Math.Add         add5
    annotation (Placement(transformation(extent={{2,-26},{22,-46}})));
  Modelica.Blocks.Sources.Constant const9(k=-0.0111)
    annotation (Placement(transformation(extent={{-32,-34},{-12,-14}})));
  TRANSFORM.Controls.LimPID PI_TBV1(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-38,176},{-18,196}})));
  Modelica.Blocks.Sources.Constant const10(k=145e5)
    annotation (Placement(transformation(extent={{-78,176},{-58,196}})));
  Modelica.Blocks.Math.Add3 add3_1
    annotation (Placement(transformation(extent={{18,140},{38,160}})));
  TRANSFORM.Controls.LimPID PI_TBV2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-11,
    Ti=150,
    yMax=1.0,
    yMin=-1.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-10,122},{10,142}})));
  Modelica.Blocks.Sources.Constant const11(k=data.Q_RX_Therm_Nom)
    annotation (Placement(transformation(extent={{-38,114},{-18,134}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter
    annotation (Placement(transformation(extent={{48,140},{68,160}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-59,-44},{-42,-44}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-56}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{-57,4},{-40,4}}, color={0,0,127}));
  connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{-43,48},{-43,56},
          {-36,56},{-36,48}}, color={0,0,127}));
  connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-74},{-104,-74},{-104,74},{-24,74},{-24,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const4.y, add.u1) annotation (Line(points={{11,76},{16,76},{16,58},{
          10,58},{10,52},{16,52}}, color={0,0,127}));
  connect(FWCP_Speed.y, add.u2) annotation (Line(points={{-13,48},{8,48},{8,40},
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
      points={{-30,-100},{-30,-114},{-10,-114},{-10,-162}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y, add1.u2) annotation (Line(points={{1,-206},{12,-206},{12,
          -198},{26,-198},{26,-192}}, color={0,0,127}));
  connect(TCV_Position.y, add1.u1) annotation (Line(points={{1,-174},{6,-174},{
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
  connect(add2.u1, timer.y) annotation (Line(points={{-4,-122},{-4,-120},{-6,
          -120},{-6,-76},{-60,-76},{-60,-96},{-66.6,-96}},      color={0,0,127}));
  connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-31,-132},{
          -20,-132},{-20,-116},{-82,-116},{-82,-96},{-90,-96}},      color={0,0,
          127}));
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
  connect(add3.y, TCV_Position.u_s) annotation (Line(points={{-35,-224},{-42,
          -224},{-42,-174},{-22,-174}}, color={0,0,127}));
  connect(ramp.y, add3.u1) annotation (Line(points={{-79,-192},{-72,-192},{-72,
          -190},{-64,-190},{-64,-212},{-68,-212},{-68,-216},{-58,-216}},
        color={0,0,127}));
  connect(add3.u2, const.y) annotation (Line(points={{-58,-224},{-68,-224},{-68,
          -226},{-78,-226},{-78,-220},{-83,-220}},         color={0,0,127}));
  connect(ramp1.y, add3.u3) annotation (Line(points={{-77,-248},{-70,-248},{-70,
          -234},{-64,-234},{-64,-232},{-58,-232}},        color={0,0,127}));
  connect(add4.u2, const6.y) annotation (Line(points={{-84,142},{-94,142},{-94,
          140},{-104,140},{-104,146},{-109,146}}, color={0,0,127}));
  connect(ramp2.y, add4.u1) annotation (Line(points={{-107,174},{-98,174},{-98,
          176},{-90,176},{-90,154},{-94,154},{-94,150},{-84,150}}, color={0,0,
          127}));
  connect(ramp3.y,add4. u3) annotation (Line(points={{-109,118},{-96,118},{-96,
          132},{-90,132},{-90,134},{-84,134}},            color={0,0,127}));
  connect(PI_TBV.u_s, add4.y)
    annotation (Line(points={{-54,150},{-54,118},{-61,118},{-61,142}},
                                                             color={0,0,127}));
  connect(sensorBus.Bypass_Flow, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-30,34},{-38,34},{-38,42},{-44,42},{-44,116},{-42,116},
          {-42,138}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const9.y,add5. u2) annotation (Line(points={{-11,-24},{-6,-24},{-6,
          -30},{0,-30}},              color={0,0,127}));
  connect(actuatorBus.CR_Reactivity, add5.y) annotation (Line(
      points={{30,-100},{30,-36},{23,-36}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(CR.y, add5.u1) annotation (Line(points={{-19,-44},{-14,-44},{-14,-42},
          {0,-42}}, color={0,0,127}));
  connect(const10.y, PI_TBV1.u_s)
    annotation (Line(points={{-57,186},{-40,186}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV1.u_m) annotation (Line(
      points={{-30,-100},{-30,4},{-100,4},{-100,164},{-28,164},{-28,174}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PI_TBV1.y, add3_1.u1) annotation (Line(points={{-17,186},{-17,172},{
          -18,172},{-18,158},{16,158}}, color={0,0,127}));
  connect(PI_TBV.y, add3_1.u2)
    annotation (Line(points={{-31,150},{16,150}}, color={0,0,127}));
  connect(const11.y, PI_TBV2.u_s) annotation (Line(points={{-17,124},{-17,118},
          {-12,118},{-12,132}}, color={0,0,127}));
  connect(sensorBus.thermal_power, PI_TBV2.u_m) annotation (Line(
      points={{-30,-100},{-30,-72},{-104,-72},{-104,98},{0,98},{0,120}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PI_TBV2.y, add3_1.u3)
    annotation (Line(points={{11,132},{16,132},{16,142}}, color={0,0,127}));
  connect(actuatorBus.TBV, minMaxFilter.y) annotation (Line(
      points={{30,-100},{30,24},{84,24},{84,150},{69.4,150}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(minMaxFilter.u, add3_1.y) annotation (Line(points={{46,150},{46,118},
          {39,118},{39,150}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    experiment(
      StopTime=20000,
      Interval=30,
      __Dymola_Algorithm="Esdirk45a"));
end CS_Rankine_Power_Change_2;
