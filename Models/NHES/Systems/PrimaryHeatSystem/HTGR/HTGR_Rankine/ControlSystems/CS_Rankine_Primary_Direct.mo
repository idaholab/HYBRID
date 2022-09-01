within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems;
model CS_Rankine_Primary_Direct

  extends HTGR_Rankine.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  replaceable HTGR_Rankine.Data.Data_CS data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    P_Steam_Ref=15000000)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=30,
    yMax=75,
    yMin=45,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-36,14},{-16,-6}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{-80,-6},{-60,14}})));
  TRANSFORM.Controls.LimPID PID_FeedPump(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    Ti=5,
    Td=0.001,
    yMax=100,
    yMin=5,
    wp=0.5,
    wd=0.5,
    y_start=67,
    k=-8e-6,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1.0,
    k_s=1,
    k_m=1)
    annotation (Placement(transformation(extent={{-20,68},{0,48}})));
  Modelica.Blocks.Sources.Constant const3(k=140e5)
    annotation (Placement(transformation(extent={{-58,48},{-38,68}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-59,-40},{-38,-40}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-96},{-96,-96},{-96,-72},{-26,-72},{-26,-52}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{-59,4},{-38,4}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-96},{-96,-96},{-96,22},{-26,22},{-26,16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{28,-100},{28,-40},{-15,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
      points={{30,-100},{30,4},{-15,4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.mfeedpump,PID_FeedPump. y) annotation (Line(
      points={{30,-100},{54,-100},{54,58},{1,58}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const3.y, PID_FeedPump.u_s)
    annotation (Line(points={{-37,58},{-22,58}}, color={0,0,127}));
  connect(sensorBus.feedpressure, PID_FeedPump.u_m) annotation (Line(
      points={{-30,-100},{-64,-100},{-64,-96},{-96,-96},{-96,34},{-30,34},{-30,
          78},{-10,78},{-10,70}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Primary_Direct;
