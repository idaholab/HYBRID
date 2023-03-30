within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems;
model CS_VN

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
    annotation (Placement(transformation(extent={{-82,-54},{-62,-34}})));
  replaceable HTGR_Rankine.Data.Data_CS data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    P_Steam_Ref=14000000)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{-104,-10},{-84,10}})));
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
  Modelica.Blocks.Sources.Constant const4(k=25)
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
    use_k_in=false,
    use_lowlim_in=false,
    use_uplim_in=false,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-2e-2,
    Ti=55,
    Td=1,
    yMax=80,
    yMin=0) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Sources.Constant const5(k=50)
    annotation (Placement(transformation(extent={{-96,14},{-86,24}})));
  Modelica.Blocks.Sources.Constant const6(k=1e8)
    annotation (Placement(transformation(extent={{-58,-2},{-48,8}})));
  Modelica.Blocks.Sources.Constant const11(k=2e-6)
    annotation (Placement(transformation(extent={{-128,26},{-120,34}})));
  Modelica.Blocks.Sources.Constant const7(k=45)
    annotation (Placement(transformation(extent={{52,-30},{72,-10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=500,
    offset=0,
    startTime=500)
    annotation (Placement(transformation(extent={{108,30},{122,44}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{152,-4},{172,16}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{192,-26},{212,-6}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-15,
    duration=500,
    offset=15,
    startTime=500)
    annotation (Placement(transformation(extent={{114,-28},{128,-14}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-61,-44},{-48,-44},{-48,
          -40},{-38,-40}},  color={0,0,127}));
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
  connect(MinPumpSpeed.y, add.u1) annotation (Line(points={{81,64},{86,64},{86,
          66},{88,66},{88,20},{6,20},{6,8},{12,8}}, color={0,0,127}));
  connect(PID.y, add.u2)
    annotation (Line(points={{-9,0},{4,0},{4,-4},{12,-4}},  color={0,0,127}));
  connect(sensorBus.thermal_power, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-74},{-12,-74},{-12,-12},{-20,-12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const6.y, PID.u_s) annotation (Line(points={{-47.5,3},{-42,3},{-42,0},
          {-32,0}}, color={0,0,127}));
  connect(ramp.y, product1.u1) annotation (Line(points={{122.7,37},{142,37},{
          142,12},{150,12}}, color={0,0,127}));
  connect(add.y, product1.u2)
    annotation (Line(points={{35,2},{38,2},{38,0},{150,0}}, color={0,0,127}));
  connect(product1.y, add1.u1) annotation (Line(points={{173,6},{180,6},{180,
          -10},{190,-10}}, color={0,0,127}));
  connect(actuatorBus.mfeedpump, add1.y) annotation (Line(
      points={{30,-100},{30,-40},{220,-40},{220,-16},{213,-16}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ramp1.y, add1.u2) annotation (Line(points={{128.7,-21},{128.7,-22},{
          190,-22}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_VN;
