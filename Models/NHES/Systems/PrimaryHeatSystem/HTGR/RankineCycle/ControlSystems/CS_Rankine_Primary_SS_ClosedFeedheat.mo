within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Rankine_Primary_SS_ClosedFeedheat

  extends RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-5,
    Ti=90,
    Td=100,
    wp=0.9,
    wd=0.1,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{80,16},{100,-4}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{36,-4},{56,16}})));
  replaceable Data.CS_HTGR_Pebble_RankineCycle data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    P_Steam_Ref=14000000)
    annotation (Placement(transformation(extent={{-98,84},{-84,98}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{-22,52},{-8,66}})));
  Modelica.Blocks.Sources.Constant valvedelay1(k=7e5)
    annotation (Placement(transformation(extent={{-54,156},{-34,176}})));
  Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-54,124},{-34,144}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{-14,158},{6,138}})));
  Modelica.Blocks.Logical.Switch MinPumpSpeed
    annotation (Placement(transformation(extent={{48,138},{68,158}})));
  Modelica.Blocks.Sources.Constant const3(k=20)
    annotation (Placement(transformation(extent={{14,156},{34,176}})));
  Modelica.Blocks.Sources.Constant const4(k=35)
    annotation (Placement(transformation(extent={{14,124},{34,144}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{80,68},{100,88}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=-40,
    rising=780,
    width=1020,
    falling=780,
    period=3600,
    nperiod=1,
    offset=0,
    startTime=1e6 + 900)
    annotation (Placement(transformation(extent={{-22,74},{-8,88}})));
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
    annotation (Placement(transformation(extent={{42,62},{62,82}})));
  Modelica.Blocks.Sources.Constant const5(k=50)
    annotation (Placement(transformation(extent={{26,100},{36,110}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{40,100},{50,110}})));
  Modelica.Blocks.Sources.Constant const11(k=2e-5)
    annotation (Placement(transformation(extent={{72,100},{62,110}})));
  TRANSFORM.Blocks.RealExpression coreOutlet_temp
    annotation (Placement(transformation(extent={{-100,54},{-76,66}})));
  TRANSFORM.Blocks.RealExpression steam_pressure
    annotation (Placement(transformation(extent={{-100,44},{-76,56}})));
  TRANSFORM.Blocks.RealExpression bypass_massflow
    annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
  TRANSFORM.Blocks.RealExpression condensatePump_pressure
    annotation (Placement(transformation(extent={{-100,24},{-76,36}})));
  TRANSFORM.Blocks.RealExpression core_massflow
    annotation (Placement(transformation(extent={{-100,14},{-76,26}})));
  TRANSFORM.Blocks.RealExpression feedwater_temperature
    annotation (Placement(transformation(extent={{-100,4},{-76,16}})));
  TRANSFORM.Blocks.RealExpression hptOutlet_pressure
    annotation (Placement(transformation(extent={{-100,-6},{-76,6}})));
  TRANSFORM.Blocks.RealExpression reactor_power
    annotation (Placement(transformation(extent={{-100,-16},{-76,-4}})));
  TRANSFORM.Blocks.RealExpression steam_temperature
    annotation (Placement(transformation(extent={{-100,-26},{-76,-14}})));
  TRANSFORM.Blocks.RealExpression feedwater_pressure
    annotation (Placement(transformation(extent={{-100,-36},{-76,-24}})));
  TRANSFORM.Blocks.RealExpression steam_massflow
    annotation (Placement(transformation(extent={{-100,-46},{-76,-34}})));
  TRANSFORM.Blocks.RealExpression thermal_power
    annotation (Placement(transformation(extent={{-100,-56},{-76,-44}})));
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

  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,24},{90,24},{90,18}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{120,-100},{120,6},{101,6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(clock1.y, greater1.u1) annotation (Line(points={{-33,134},{-26,
          134},{-26,148},{-16,148}},
                        color={0,0,127}));
  connect(const3.y, MinPumpSpeed.u1) annotation (Line(points={{35,166},{40,
          166},{40,156},{46,156}},
                            color={0,0,127}));
  connect(const4.y, MinPumpSpeed.u3) annotation (Line(points={{35,134},{40,
          134},{40,140},{46,140}},
                        color={0,0,127}));
  connect(PID.y, add.u2)
    annotation (Line(points={{63,72},{78,72}},              color={0,0,127}));
  connect(const5.y, PID.upperlim) annotation (Line(points={{36.5,105},{36.5,
          90},{46,90},{46,83}},   color={0,0,127}));
  connect(trapezoid1.y, PID.u_ff) annotation (Line(points={{-7.3,81},{-7.3,
          80},{40,80}},     color={0,0,127}));
  connect(const2.y, PID.u_s) annotation (Line(points={{-7.3,59},{34,59},{34,
          72},{40,72}},
                   color={0,0,127}));
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
  connect(sensorBus.Bypass_flow, bypass_massflow.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensate_Pump_Pressure, condensatePump_pressure.u)
    annotation (Line(
      points={{-30,-100},{-120,-100},{-120,30},{-102.4,30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, core_massflow.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,20},{-102.4,20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, feedwater_temperature.u) annotation (
      Line(
      points={{-30,-100},{-120,-100},{-120,10},{-102.4,10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.HPT_Outlet_Pressure, hptOutlet_pressure.u) annotation (
      Line(
      points={{-30,-100},{-120,-100},{-120,0},{-102.4,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, reactor_power.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-10},{-102.4,-10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature, steam_temperature.u) annotation (
      Line(
      points={{-30,-100},{-120,-100},{-120,-20},{-102.4,-20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.feedpressure, feedwater_pressure.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-30},{-102.4,-30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_steam, steam_massflow.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-40},{-102.4,-40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.thermal_power, thermal_power.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-50},{-102.4,-50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const1.y, CR.u_s)
    annotation (Line(points={{57,6},{78,6}}, color={0,0,127}));
  connect(actuatorBus.PR_Compressor, add.y) annotation (Line(
      points={{30,-100},{120,-100},{120,78},{101,78}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-33,166},{
          -26,166},{-26,156},{-16,156}}, color={0,0,127}));
  connect(const11.y, PID.prop_k) annotation (Line(points={{61.5,105},{60,
          105},{60,83.4},{59.4,83.4}}, color={0,0,127}));
  connect(PID.lowerlim, const6.y) annotation (Line(points={{52,83},{52,105},
          {50.5,105}}, color={0,0,127}));
  connect(add.u1, MinPumpSpeed.y) annotation (Line(points={{78,84},{76,84},
          {76,148},{69,148}}, color={0,0,127}));
  connect(MinPumpSpeed.u2, greater1.y)
    annotation (Line(points={{46,148},{7,148}}, color={255,0,255}));
  connect(sensorBus.Steam_Pressure, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,46},{52,46},{52,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Primary_SS_ClosedFeedheat;
