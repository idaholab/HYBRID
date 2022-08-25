within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine;
model CS_Rankine_Primary_AR

  extends HTGR_Rankine.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=120,
    Td=100,
    wp=0.9,
    wd=0.1,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  replaceable HTGR_Rankine.Data.Data_CS data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    P_Steam_Ref=14000000)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=2e-6,
    Ti=30,
    Td=1,
    yMax=75,
    yMin=0,
    wp=0.5,
    wd=0.5,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-36,12},{-16,-8}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{-80,-6},{-60,14}})));
  Modelica.Blocks.Sources.Constant valvedelay1(k=7e5)
    annotation (Placement(transformation(extent={{-44,74},{-24,94}})));
  Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-48,38},{-28,58}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{-4,74},{16,54}})));
  Modelica.Blocks.Logical.Switch MinPumpSpeed
    annotation (Placement(transformation(extent={{60,54},{80,74}})));
  Modelica.Blocks.Sources.Constant const3(k=10)
    annotation (Placement(transformation(extent={{26,96},{46,116}})));
  Modelica.Blocks.Sources.Constant const4(k=45)
    annotation (Placement(transformation(extent={{28,28},{48,48}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{14,-8},{34,12}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-59,-40},{-38,-40}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-96},{-96,-96},{-96,-72},{-26,-72},{-26,-52}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{-59,4},{-48,4},{-48,2},{-38,2}},
                                               color={0,0,127}));
  connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-96},{-96,-96},{-96,22},{-26,22},{-26,14}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{28,-100},{28,-40},{-15,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-23,84},{-14,84},
          {-14,72},{-6,72}}, color={0,0,127}));
  connect(clock1.y, greater1.u1) annotation (Line(points={{-27,48},{-16,48},{-16,
          64},{-6,64}}, color={0,0,127}));
  connect(greater1.y, MinPumpSpeed.u2)
    annotation (Line(points={{17,64},{58,64}}, color={255,0,255}));
  connect(const3.y, MinPumpSpeed.u1) annotation (Line(points={{47,106},{50,106},
          {50,72},{58,72}}, color={0,0,127}));
  connect(const4.y, MinPumpSpeed.u3) annotation (Line(points={{49,38},{52,38},{52,
          56},{58,56}}, color={0,0,127}));
  connect(Blower_Speed.y, add.u2)
    annotation (Line(points={{-15,2},{2,2},{2,-4},{12,-4}}, color={0,0,127}));
  connect(actuatorBus.PR_Compressor, add.y) annotation (Line(
      points={{30,-100},{30,-18},{42,-18},{42,2},{35,2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(MinPumpSpeed.y, add.u1) annotation (Line(points={{81,64},{86,64},{86,
          66},{88,66},{88,20},{6,20},{6,8},{12,8}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Primary_AR;
