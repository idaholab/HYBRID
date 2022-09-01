within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems;
model CS_Rankine_Primary_TransientControl

  extends HTGR_Rankine.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-5,
    Ti=90,
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
  Modelica.Blocks.Sources.Constant const3(k=20)
    annotation (Placement(transformation(extent={{26,96},{46,116}})));
  Modelica.Blocks.Sources.Constant const4(k=45)
    annotation (Placement(transformation(extent={{28,28},{48,48}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{14,-8},{34,12}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=-40,
    rising=780,
    width=1020,
    falling=780,
    period=3600,
    nperiod=1,
    offset=0,
    startTime=1e6 + 900)
    annotation (Placement(transformation(extent={{-138,-26},{-118,-6}})));
  VarLimVarK_PID PID(
    use_k_in=true,
    use_lowlim_in=true,
    use_uplim_in=true,
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    with_FF=true,
    k=1e-6,
    Ti=55,
    Td=1,
    yMax=50,
    yMin=0) annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
  Modelica.Blocks.Sources.Constant const5(k=50)
    annotation (Placement(transformation(extent={{-96,14},{-86,24}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{-96,-30},{-86,-20}})));
  Modelica.Blocks.Sources.Constant const11(k=2e-6)
    annotation (Placement(transformation(extent={{-128,26},{-120,34}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-59,-40},{-38,-40}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-96},{-96,-96},{-96,-72},{-26,-72},{-26,-52}},
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
  connect(sensorBus.Steam_Pressure, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-74},{-10,-74},{-10,-20},{-22,-20},{-22,-12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(PID.y, add.u2)
    annotation (Line(points={{-11,0},{4,0},{4,-4},{12,-4}}, color={0,0,127}));
  connect(const5.y, PID.upperlim) annotation (Line(points={{-85.5,19},{-42,19},
          {-42,11},{-28,11}},     color={0,0,127}));
  connect(trapezoid1.y, PID.u_ff) annotation (Line(points={{-117,-16},{-46,-16},
          {-46,8},{-34,8}}, color={0,0,127}));
  connect(const2.y, PID.u_s) annotation (Line(points={{-59,4},{-40,4},{-40,0},{
          -34,0}}, color={0,0,127}));
  connect(const6.y, PID.lowerlim) annotation (Line(points={{-85.5,-25},{-40,-25},
          {-40,11},{-22,11}},     color={0,0,127}));
  connect(const11.y, PID.prop_k) annotation (Line(points={{-119.6,30},{-38,30},
          {-38,11.4},{-14.6,11.4}},
                                  color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Primary_TransientControl;
