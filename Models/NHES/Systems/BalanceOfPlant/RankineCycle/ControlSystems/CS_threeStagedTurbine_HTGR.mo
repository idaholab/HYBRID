within NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems;
model CS_threeStagedTurbine_HTGR

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
    annotation (Placement(transformation(extent={{-22,16},{-2,36}})));
  Modelica.Blocks.Sources.Constant const4(k=1200)
    annotation (Placement(transformation(extent={{54,86},{74,106}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  TRANSFORM.Controls.LimPID LTV2_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=15,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{20,-68},{42,-46}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-14,-68},{8,-46}})));
  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-3e-9,
    Ti=360,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{26,-14},{46,-34}})));
  Modelica.Blocks.Sources.Constant const8(k=1e-6)
    annotation (Placement(transformation(extent={{58,-88},{70,-76}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{80,-74},{100,-54}})));
  Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
      Start_Time=1e-2)
    annotation (Placement(transformation(extent={{58,-64},{70,-50}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=500,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{54,40},{74,60}})));
  Data.HTGR_Rankine
                  data(
    p_steam_vent=14000000,
    T_Steam_Ref=788.15,                       Q_Nom=44e6)
    annotation (Placement(transformation(extent={{-98,82},{-78,102}})));
  Modelica.Blocks.Sources.ContinuousClock clock2(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-318,40},{-298,60}})));
  Modelica.Blocks.Sources.Constant valvedelay2(k=6e5)
    annotation (Placement(transformation(extent={{-318,74},{-298,94}})));
  Modelica.Blocks.Logical.Greater greater2
    annotation (Placement(transformation(extent={{-278,74},{-258,54}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV1
    annotation (Placement(transformation(extent={{-238,54},{-218,74}})));
  Modelica.Blocks.Sources.Constant const1(k=-150)
    annotation (Placement(transformation(extent={{-278,80},{-258,100}})));
  Modelica.Blocks.Sources.Constant const2(k=-150)
    annotation (Placement(transformation(extent={{-278,24},{-258,44}})));
  Modelica.Blocks.Sources.Constant const10(k=5000)
    annotation (Placement(transformation(extent={{-278,-12},{-260,6}})));
  SupportComponent.VarLimVarK_PID PID(
    use_k_in=true,
    use_lowlim_in=true,
    use_uplim_in=true,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    with_FF=true,
    k=-5e-1,
    Ti=30) annotation (Placement(transformation(extent={{18,16},{38,36}})));
  Modelica.Blocks.Sources.Constant const11(k=-1e-1)
    annotation (Placement(transformation(extent={{-278,-114},{-258,-94}})));
  Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-318,-96},{-298,-76}})));
  Modelica.Blocks.Sources.Constant valvedelay1(k=8.5e5)
    annotation (Placement(transformation(extent={{-318,-64},{-298,-44}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{-278,-64},{-258,-84}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV2
    annotation (Placement(transformation(extent={{-238,-84},{-218,-64}})));
  Modelica.Blocks.Sources.Constant
                               const(k=-1e-1)
    annotation (Placement(transformation(extent={{-278,-56},{-258,-36}})));
  TRANSFORM.Controls.LimPID LTV1_Divert_Valve1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-8,
    Ti=300,
    yMax=1 - 1e-6,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=0.2)
    annotation (Placement(transformation(extent={{-40,110},{-20,130}})));
  Modelica.Blocks.Sources.Trapezoid trap_LTV1bypass_power(
    amplitude=-16e6,
    rising=7200,
    width=3600,
    falling=7200,
    period=21600,
    nperiod=-1,
    offset=44e6,
    startTime=1e4)
    annotation (Placement(transformation(extent={{-72,110},{-52,130}})));
  Modelica.Blocks.Sources.Constant const12(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-278,122},{-260,140}})));
  Modelica.Blocks.Sources.Constant valvedelay3(k=1e5)
    annotation (Placement(transformation(extent={{-318,176},{-298,196}})));
  Modelica.Blocks.Sources.ContinuousClock clock3(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-318,136},{-298,156}})));
  Modelica.Blocks.Logical.Greater greater3
    annotation (Placement(transformation(extent={{-278,176},{-258,156}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV3
    annotation (Placement(transformation(extent={{-238,156},{-218,176}})));
  Modelica.Blocks.Sources.Constant valvedelay4(k=14e6)
    annotation (Placement(transformation(extent={{-278,190},{-258,210}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  Modelica.Blocks.Sources.Constant const7(k=1.0)
    annotation (Placement(transformation(extent={{58,-42},{70,-30}})));
  Modelica.Blocks.Sources.Constant constant_0(k=0)
    annotation (Placement(transformation(extent={{-22,46},{-2,66}})));
  TRANSFORM.Blocks.RealExpression Control_1
    annotation (Placement(transformation(extent={{-206,156},{-170,176}})));
  Modelica.Blocks.Sources.RealExpression Control_Input_1_output(y=Control_1.y)
    annotation (Placement(transformation(extent={{-14,-36},{12,-12}})));
  TRANSFORM.Blocks.RealExpression Control_2
    annotation (Placement(transformation(extent={{-206,54},{-170,74}})));
  Modelica.Blocks.Sources.RealExpression Contro2_out(y=Control_2.y)
    annotation (Placement(transformation(extent={{-58,170},{-18,188}})));
  TRANSFORM.Blocks.RealExpression Control_3
    annotation (Placement(transformation(extent={{-206,-14},{-170,6}})));
  Modelica.Blocks.Sources.RealExpression Contro3_out(y=Control_3.y)
    annotation (Placement(transformation(extent={{-58,152},{-18,170}})));
  TRANSFORM.Blocks.RealExpression Control_4
    annotation (Placement(transformation(extent={{-206,-84},{-170,-64}})));
  Modelica.Blocks.Sources.RealExpression Contro4_out(y=Control_4.y)
    annotation (Placement(transformation(extent={{-58,134},{-18,154}})));
  Modelica.Blocks.Sources.Constant BV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-26,-232},{-6,-212}})));
  Modelica.Blocks.Sources.Constant TDV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{-26,-202},{-6,-182}})));
  Modelica.Blocks.Sources.Constant BV_TCV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-26,-140},{-6,-120}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Mass_Flow(k=85.0)
    annotation (Placement(transformation(extent={{78,-132},{58,-112}})));
  Modelica.Blocks.Sources.Constant Discharge_Throttle_On_Off(k=0.5)
    annotation (Placement(transformation(extent={{-26,-172},{-6,-152}})));
  Modelica.Blocks.Sources.Constant TCV_SHS_Opening(k=0.1)
    annotation (Placement(transformation(extent={{78,-160},{58,-140}})));
  Modelica.Blocks.Sources.Constant SHS_Throttle(k=0.1)
    annotation (Placement(transformation(extent={{78,-192},{58,-172}})));
  Modelica.Blocks.Sources.Constant LPT2_BV(k=0.1)
    annotation (Placement(transformation(extent={{78,-222},{58,-202}})));
  Modelica.Blocks.Sources.Constant LPT1_BV(k=0.1)
    annotation (Placement(transformation(extent={{78,-252},{58,-232}})));
  TRANSFORM.Blocks.RealExpression Condensor_Outflow
    annotation (Placement(transformation(extent={{-82,-208},{-62,-188}})));
  TRANSFORM.Blocks.RealExpression Extraction_Flow
    annotation (Placement(transformation(extent={{-82,-194},{-62,-174}})));
  TRANSFORM.Blocks.RealExpression SHS_Return_T
    annotation (Placement(transformation(extent={{-82,-180},{-62,-160}})));
  TRANSFORM.Blocks.RealExpression W_total_setpoint
    annotation (Placement(transformation(extent={{-82,-164},{-62,-144}})));
  TRANSFORM.Blocks.RealExpression Steam_turbine_inlet_pressure
    annotation (Placement(transformation(extent={{-82,-130},{-62,-110}})));
  TRANSFORM.Blocks.RealExpression massflow_LPTv
    annotation (Placement(transformation(extent={{-82,-148},{-62,-128}})));
equation

  connect(const5.y,LTV2_Divert_Valve. u_s)
    annotation (Line(points={{9.1,-57},{17.8,-57}},  color={0,0,127}));
  connect(sensorBus.Feedwater_Temp,LTV2_Divert_Valve. u_m) annotation (Line(
      points={{-30,-100},{-30,-80},{30,-80},{30,-70.2},{31,-70.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{120,-100},{120,-64},{101,-64}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add2.u2, const8.y) annotation (Line(points={{78,-70},{70.6,-70},{
          70.6,-82}},                                                    color=
          {0,0,127}));
  connect(add2.u1, timer.y) annotation (Line(points={{78,-58},{78,-57},{
          70.84,-57}},                                          color={0,0,127}));
  connect(LTV2_Divert_Valve.y, timer.u) annotation (Line(points={{43.1,-57},
          {56.8,-57}},                                               color={0,0,
          127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{75,50},{78,50}},     color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-30,0},{90,0},{90,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{120,-100},{120,50},{101,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(clock2.y, greater2.u1) annotation (Line(points={{-297,50},{-288,
          50},{-288,64},{-280,64}},
                                  color={0,0,127}));
  connect(valvedelay2.y, greater2.u2) annotation (Line(points={{-297,84},{
          -288,84},{-288,72},{-280,72}},
                                       color={0,0,127}));
  connect(greater2.y, switch_P_setpoint_TCV1.u2)
    annotation (Line(points={{-257,64},{-240,64}},  color={255,0,255}));
  connect(const2.y, switch_P_setpoint_TCV1.u3) annotation (Line(points={{-257,34},
          {-248,34},{-248,56},{-240,56}},                  color={0,0,127}));
  connect(const1.y, switch_P_setpoint_TCV1.u1) annotation (Line(points={{-257,90},
          {-248,90},{-248,72},{-240,72}},      color={0,0,127}));
  connect(const3.y, PID.u_s)
    annotation (Line(points={{-1,26},{16,26}},  color={0,0,127}));
  connect(clock1.y, greater1.u1) annotation (Line(points={{-297,-86},{-288,
          -86},{-288,-74},{-280,-74}},
                                  color={0,0,127}));
  connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-297,-54},{
          -288,-54},{-288,-66},{-280,-66}},
                                       color={0,0,127}));
  connect(greater1.y, switch_P_setpoint_TCV2.u2)
    annotation (Line(points={{-257,-74},{-240,-74}},color={255,0,255}));
  connect(const11.y, switch_P_setpoint_TCV2.u3) annotation (Line(points={{-257,
          -104},{-248,-104},{-248,-82},{-240,-82}},
        color={0,0,127}));
  connect(const.y, switch_P_setpoint_TCV2.u1) annotation (Line(points={{-257,
          -46},{-248,-46},{-248,-66},{-240,-66}},
                                               color={0,0,127}));
  connect(sensorBus.Power, LTV1_Divert_Valve1.u_m) annotation (Line(
      points={{-30,-100},{-30,108}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(valvedelay3.y, greater3.u2) annotation (Line(points={{-297,186},{
          -288,186},{-288,174},{-280,174}},
                                      color={0,0,127}));
  connect(clock3.y, greater3.u1) annotation (Line(points={{-297,146},{-290,
          146},{-290,166},{-280,166}},
                                  color={0,0,127}));
  connect(const12.y, switch_P_setpoint_TCV3.u3) annotation (Line(points={{-259.1,
          131},{-248,131},{-248,158},{-240,158}},        color={0,0,127}));
  connect(greater3.y, switch_P_setpoint_TCV3.u2)
    annotation (Line(points={{-257,166},{-240,166}}, color={255,0,255}));
  connect(valvedelay4.y, switch_P_setpoint_TCV3.u1) annotation (Line(points={{-257,
          200},{-248,200},{-248,174},{-240,174}},  color={0,0,127}));
  connect(TCV_Position.y, add1.u1)
    annotation (Line(points={{47,-24},{78,-24}},   color={0,0,127}));
  connect(const7.y, add1.u2)
    annotation (Line(points={{70.6,-36},{78,-36}},   color={0,0,127}));
  connect(const4.y, add.u1)
    annotation (Line(points={{75,96},{75,97.5},{78,97.5},{78,96}},
                                                 color={0,0,127}));
  connect(trap_LTV1bypass_power.y, LTV1_Divert_Valve1.u_s)
    annotation (Line(points={{-51,120},{-42,120}},      color={0,0,127}));
  connect(constant_0.y, PID.u_ff) annotation (Line(points={{-1,56},{8,56},{
          8,34},{16,34}},                      color={0,0,127}));
  connect(PID.y, add.u2) annotation (Line(points={{39,26},{48,26},{48,84},{
          78,84}}, color={0,0,127}));
  connect(switch_P_setpoint_TCV3.y, Control_1.u)
    annotation (Line(points={{-217,166},{-209.6,166}}, color={0,0,127}));
  connect(Control_Input_1_output.y, TCV_Position.u_s)
    annotation (Line(points={{13.3,-24},{24,-24}}, color={0,0,127}));
  connect(switch_P_setpoint_TCV1.y, Control_2.u)
    annotation (Line(points={{-217,64},{-209.6,64}}, color={0,0,127}));
  connect(Contro2_out.y, PID.lowerlim) annotation (Line(points={{-16,179},{
          28,179},{28,37}}, color={0,0,127}));
  connect(const10.y, Control_3.u) annotation (Line(points={{-259.1,-3},{
          -259.1,-4},{-209.6,-4}}, color={0,0,127}));
  connect(Contro3_out.y, PID.upperlim) annotation (Line(points={{-16,161},{
          22,161},{22,37}}, color={0,0,127}));
  connect(switch_P_setpoint_TCV2.y, Control_4.u)
    annotation (Line(points={{-217,-74},{-209.6,-74}}, color={0,0,127}));
  connect(PID.prop_k, Contro4_out.y) annotation (Line(points={{35.4,37.4},{
          35.4,122},{36,122},{36,144},{-16,144}}, color={0,0,127}));
  connect(sensorBus.Steam_Temperature, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,6},{28,6},{28,14}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, TCV_Position.u_m) annotation (Line(
      points={{-30,-100},{-30,0},{36,0},{36,-12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
      points={{30.1,-99.9},{120,-99.9},{120,-30},{101,-30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{120,-100},{120,90},{101,90}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.openingLPTv, LTV1_Divert_Valve1.y) annotation (Line(
      points={{30,-100},{120,-100},{120,120},{-19,120}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV,BV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-222},{-5,-222}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TDV,TDV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-192},{-5,-192}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_OnOff_Throttle,Discharge_Throttle_On_Off. y)
    annotation (Line(
      points={{30,-100},{30,-162},{-5,-162}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_mFlow,Feed_Pump_Mass_Flow. y) annotation (
      Line(
      points={{30,-100},{30,-122},{57,-122}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT1_BV,LPT1_BV. y) annotation (Line(
      points={{30,-100},{30,-242},{57,-242}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT2_BV,LPT2_BV. y) annotation (Line(
      points={{30,-100},{30,-212},{57,-212}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.SHS_throttle,SHS_Throttle. y) annotation (Line(
      points={{30,-100},{30,-182},{57,-182}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_SHS,TCV_SHS_Opening. y) annotation (Line(
      points={{30,-100},{30,-150},{57,-150}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensor_Output_mflow,Condensor_Outflow. u) annotation (
      Line(
      points={{-30,-100},{-118,-100},{-118,-198},{-84,-198}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Extract_flow,Extraction_Flow. u) annotation (Line(
      points={{-30,-100},{-118,-100},{-118,-184},{-84,-184}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SHS_Return_T,SHS_Return_T. u) annotation (Line(
      points={{-30,-100},{-118,-100},{-118,-170},{-84,-170}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint,W_total_setpoint. u) annotation (Line(
      points={{-30,-100},{-118,-100},{-118,-154},{-84,-154}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.massflow_LPTv,massflow_LPTv. u) annotation (Line(
      points={{-30,-100},{-118,-100},{-118,-138},{-84,-138}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_inlet_steamTurbine,Steam_turbine_inlet_pressure. u)
    annotation (Line(
      points={{-30,-100},{-118,-100},{-118,-120},{-84,-120}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV_TCV, BV_TCV_openingNominal.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-130},{-5,-130}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_threeStagedTurbine_HTGR;
