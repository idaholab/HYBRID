within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Rankine_Primary_TransientControl

  extends RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-5,
    Ti=90,
    Td=100,
    wp=0.9,
    wd=0.1,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{80,2},{100,22}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{50,2},{70,22}})));
  replaceable Data.CS_HTGR_Pebble_RankineCycle data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    P_Steam_Ref=14000000)
    annotation (Placement(transformation(extent={{-98,84},{-84,98}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{-10,42},{10,62}})));
  Modelica.Blocks.Sources.Constant valvedelay1(k=7e5)
    annotation (Placement(transformation(extent={{-54,138},{-34,158}})));
  Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-54,102},{-34,122}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{-14,138},{6,118}})));
  Modelica.Blocks.Logical.Switch MinPumpSpeed
    annotation (Placement(transformation(extent={{50,118},{70,138}})));
  Modelica.Blocks.Sources.Constant const3(k=20)
    annotation (Placement(transformation(extent={{16,138},{36,158}})));
  Modelica.Blocks.Sources.Constant const4(k=45)
    annotation (Placement(transformation(extent={{16,102},{36,122}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{80,44},{100,64}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=-40,
    rising=780,
    width=1020,
    falling=780,
    period=3600,
    nperiod=1,
    offset=0,
    startTime=1e6 + 900)
    annotation (Placement(transformation(extent={{-10,12},{10,32}})));
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
    annotation (Placement(transformation(extent={{34,42},{54,62}})));
  Modelica.Blocks.Sources.Constant const5(k=50)
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=180,
        origin={26,82})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=90,
        origin={44,90})));
  Modelica.Blocks.Sources.Constant const11(k=2e-6)
    annotation (Placement(transformation(extent={{68,76},{56,88}})));
  TRANSFORM.Blocks.RealExpression coreOutlet_temp
    annotation (Placement(transformation(extent={{-100,54},{-76,66}})));
  TRANSFORM.Blocks.RealExpression steam_pressure
    annotation (Placement(transformation(extent={{-100,44},{-76,56}})));
  TRANSFORM.Blocks.RealExpression reactor_power
    annotation (Placement(transformation(extent={{-100,-16},{-76,-4}})));
  Modelica.Blocks.Sources.RealExpression divertValve_position(y=0)
    annotation (Placement(transformation(extent={{76,-46},{100,-34}})));
  Modelica.Blocks.Sources.RealExpression feedPump_speed(y=0)
    annotation (Placement(transformation(extent={{76,-56},{100,-44}})));
  Modelica.Blocks.Sources.RealExpression TBV_position(y=0)
    annotation (Placement(transformation(extent={{76,-76},{100,-64}})));
  Modelica.Blocks.Sources.RealExpression TCV_position(y=0)
    annotation (Placement(transformation(extent={{76,-86},{100,-74}})));
  Modelica.Blocks.Sources.RealExpression feedWaterPump_mass(y=0)
    annotation (Placement(transformation(extent={{76,-96},{100,-84}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{71,12},{78,12}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-20},{90,-20},{90,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{120,-100},{120,12},{101,12}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-33,148},{
          -16,148},{-16,136}},
                             color={0,0,127}));
  connect(clock1.y, greater1.u1) annotation (Line(points={{-33,112},{-16,
          112},{-16,128}},
                        color={0,0,127}));
  connect(greater1.y, MinPumpSpeed.u2)
    annotation (Line(points={{7,128},{48,128}},color={255,0,255}));
  connect(const3.y, MinPumpSpeed.u1) annotation (Line(points={{37,148},{48,
          148},{48,136}},   color={0,0,127}));
  connect(const4.y, MinPumpSpeed.u3) annotation (Line(points={{37,112},{48,
          112},{48,120}},
                        color={0,0,127}));
  connect(MinPumpSpeed.y, add.u1) annotation (Line(points={{71,128},{72,128},
          {72,60},{78,60}},                         color={0,0,127}));
  connect(PID.y, add.u2)
    annotation (Line(points={{55,52},{70,52},{70,48},{78,48}},
                                                            color={0,0,127}));
  connect(trapezoid1.y, PID.u_ff) annotation (Line(points={{11,22},{22,22},
          {22,60},{32,60}}, color={0,0,127}));
  connect(const2.y, PID.u_s) annotation (Line(points={{11,52},{32,52}},
                   color={0,0,127}));
  connect(sensorBus.Core_Outlet_T,coreOutlet_temp. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,60},{-102.4,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure,steam_pressure. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,50},{-102.4,50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power,reactor_power. u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-10},{-102.4,-10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PID.prop_k, const11.y) annotation (Line(points={{51.4,63.4},{50,
          63.4},{50,82},{55.4,82}}, color={0,0,127}));
  connect(const5.y, PID.upperlim)
    annotation (Line(points={{32.6,82},{38,82},{38,63}}, color={0,0,127}));
  connect(PID.lowerlim, const6.y)
    annotation (Line(points={{44,63},{44,83.4}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,0},{44,0},{44,40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, add.y) annotation (Line(
      points={{30,-100},{120,-100},{120,54},{101,54}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Primary_TransientControl;
