within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Rankine_Primary_SS

  extends RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-5,
    Ti=90,
    Td=100,
    wp=0.9,
    wd=0.1,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{80,26},{100,6}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{44,6},{64,26}})));
  replaceable Data.CS_HTGR_Pebble_RankineCycle data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    P_Steam_Ref=14000000)
    annotation (Placement(transformation(extent={{-98,84},{-84,98}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{6,6},{-6,-6}},
        rotation=180,
        origin={8,70})));
  Modelica.Blocks.Sources.Constant valvedelay1(k=7e5)
    annotation (Placement(transformation(extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-16,172})));
  Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-22,146},{-10,158}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{2,166},{16,152}})));
  Modelica.Blocks.Logical.Switch MinPumpSpeed
    annotation (Placement(transformation(extent={{44,152},{58,166}})));
  Modelica.Blocks.Sources.Constant const3(k=45)
    annotation (Placement(transformation(extent={{24,164},{34,174}})));
  Modelica.Blocks.Sources.Constant const4(k=45)
    annotation (Placement(transformation(extent={{24,144},{34,154}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=-40,
    rising=780,
    width=1020,
    falling=780,
    period=3600,
    nperiod=1,
    offset=0,
    startTime=1e6 + 900)
    annotation (Placement(transformation(extent={{-40,166},{-28,178}})));
  SupportComponent.VarLimVarK_PID PID(
    use_k_in=true,
    use_lowlim_in=true,
    use_uplim_in=true,
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    with_FF=true,
    k=1e-6,
    Ti=55,
    Td=1,
    yMax=50,
    yMin=0)
    annotation (Placement(transformation(extent={{44,64},{64,84}})));
  Modelica.Blocks.Sources.Constant const5(k=50)
    annotation (Placement(transformation(extent={{2,90},{14,102}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{6,6},{-6,-6}},
        rotation=180,
        origin={22,112})));
  Modelica.Blocks.Sources.Constant const11(k=2e-6)
    annotation (Placement(transformation(extent={{6,6},{-6,-6}},
        rotation=180,
        origin={38,126})));
  Modelica.Blocks.Sources.Constant const7(k=0)
    annotation (Placement(transformation(extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-12,82})));
  TRANSFORM.Blocks.RealExpression coreOutlet_temp
    annotation (Placement(transformation(extent={{-100,54},{-76,66}})));
  TRANSFORM.Blocks.RealExpression steam_pressure
    annotation (Placement(transformation(extent={{-100,44},{-76,56}})));
  TRANSFORM.Blocks.RealExpression reactor_power
    annotation (Placement(transformation(extent={{-100,-16},{-76,-4}})));
  Modelica.Blocks.Sources.RealExpression divertValve_position(y=0)
    annotation (Placement(transformation(extent={{76,-36},{100,-24}})));
  Modelica.Blocks.Sources.RealExpression feedPump_speed(y=0)
    annotation (Placement(transformation(extent={{76,-46},{100,-34}})));
  Modelica.Blocks.Sources.RealExpression TBV_position(y=0)
    annotation (Placement(transformation(extent={{76,-56},{100,-44}})));
  Modelica.Blocks.Sources.RealExpression TCV_position(y=0)
    annotation (Placement(transformation(extent={{76,-66},{100,-54}})));
  Modelica.Blocks.Sources.RealExpression feedWaterPump_mass(y=0)
    annotation (Placement(transformation(extent={{76,-76},{100,-64}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{65,16},{78,16}},
                            color={0,0,127}));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{120,-100},{120,16},{101,16}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(clock1.y, greater1.u1) annotation (Line(points={{-9.4,152},{-4,
          152},{-4,159},{0.6,159}},
                        color={0,0,127}));
  connect(greater1.y, MinPumpSpeed.u2)
    annotation (Line(points={{16.7,159},{42.6,159}},
                                               color={255,0,255}));
  connect(const3.y, MinPumpSpeed.u1) annotation (Line(points={{34.5,169},{
          34.5,164.6},{42.6,164.6}},
                            color={0,0,127}));
  connect(const4.y, MinPumpSpeed.u3) annotation (Line(points={{34.5,149},{
          42.6,149},{42.6,153.4}},
                        color={0,0,127}));
  connect(PID.y, add.u2)
    annotation (Line(points={{65,74},{78,74}},              color={0,0,127}));
  connect(const2.y, PID.u_s) annotation (Line(points={{14.6,70},{30,70},{30,
          74},{42,74}},
                   color={0,0,127}));
  connect(const6.y, PID.lowerlim) annotation (Line(points={{28.6,112},{54,
          112},{54,85}},          color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, coreOutlet_temp.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,60},{-102.4,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, steam_pressure.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,50},{-102.4,50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, reactor_power.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-10},{-102.4,-10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y, PID.u_ff)
    annotation (Line(points={{-5.4,82},{42,82}}, color={0,0,127}));
  connect(MinPumpSpeed.y, add.u1) annotation (Line(points={{58.7,159},{72,
          159},{72,86},{78,86}},
                            color={0,0,127}));
  connect(const5.y, PID.upperlim)
    annotation (Line(points={{14.6,96},{48,96},{48,85}},
                                                       color={0,0,127}));
  connect(PID.prop_k, const11.y) annotation (Line(points={{61.4,85.4},{62,
          85.4},{62,126},{44.6,126}},
                                    color={0,0,127}));
  connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-9.4,172},{
          -4,172},{-4,164.6},{0.6,164.6}},
                                        color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,56},{54,56},{54,62}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,46},{90,46},{90,28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, add.y) annotation (Line(
      points={{30,-100},{120,-100},{120,80},{101,80}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Primary_SS;
