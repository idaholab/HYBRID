within NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems;
model CS_SteamTurbine_L2_PressurePowerFeedtemp_HTGR
  extends
    NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  input Real electric_demand_int = data.Q_Nom;

  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-7,
    Ti=15,
    Td=0.1,
    yMax=0.9,
    yMin=-0.0935,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-54,-60},{-34,-40}})));
  Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
    annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
  TRANSFORM.Controls.LimPID TCV_Power(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-11,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=0.95,
    yMin=-0.04,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=electric_demand_int)
    annotation (Placement(transformation(extent={{-94,-6},{-80,6}})));
  Modelica.Blocks.Sources.Constant const7(k=0.01)
    annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
  Modelica.Blocks.Sources.Constant const8(k=0.1)
    annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
  Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
      Start_Time=1e-2)
    annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
  replaceable Data.Turbine_2_Setpoints data(
    p_steam=3500000,
    p_steam_vent=15000000,
    T_Steam_Ref=579.75,
    Q_Nom=40e6,
    T_Feedwater=421.15)
    annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
  Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{-78,-22},{-64,-8}})));
  Modelica.Blocks.Sources.Constant const3(k=540 + 273.15)
    annotation (Placement(transformation(extent={{-180,44},{-160,64}})));
  TRANSFORM.Controls.LimPID FWCP_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-2,
    Ti=120,
    Td=1,
    yMax=3000,
    yMin=-1500,
    wp=1,
    wd=0.5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Sources.Constant const4(k=2800)
    annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{2,36},{22,56}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{2,74},{22,94}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-222,-2},{-202,18}})));
  Modelica.Blocks.Sources.Constant valvedelay(k=0)
    annotation (Placement(transformation(extent={{-218,34},{-198,54}})));
  Modelica.Blocks.Logical.Greater greater5
    annotation (Placement(transformation(extent={{-178,34},{-158,14}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV
    annotation (Placement(transformation(extent={{-138,14},{-118,34}})));
  Modelica.Blocks.Sources.Constant TDV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{-8,-148},{12,-128}})));
  Modelica.Blocks.Sources.Constant BV_TCV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-8,-208},{12,-188}})));
  Modelica.Blocks.Sources.Constant Feed_Pump_Mass_Flow(k=85.0)
    annotation (Placement(transformation(extent={{96,-132},{76,-112}})));
  Modelica.Blocks.Sources.Constant Discharge_Throttle_On_Off(k=0.5)
    annotation (Placement(transformation(extent={{-8,-180},{12,-160}})));
  Modelica.Blocks.Sources.Constant LPT_Valve_Opening(k=0.1)
    annotation (Placement(transformation(extent={{98,-162},{78,-142}})));
  Modelica.Blocks.Sources.Constant TCV_SHS_Opening(k=0.1)
    annotation (Placement(transformation(extent={{98,-194},{78,-174}})));
  Modelica.Blocks.Sources.Constant SHS_Throttle(k=0.1)
    annotation (Placement(transformation(extent={{98,-224},{78,-204}})));
  Modelica.Blocks.Sources.Constant LPT2_BV(k=0.1)
    annotation (Placement(transformation(extent={{98,-254},{78,-234}})));
  Modelica.Blocks.Sources.Constant LPT1_BV(k=0.1)
    annotation (Placement(transformation(extent={{98,-284},{78,-264}})));
  TRANSFORM.Blocks.RealExpression Condensor_Outflow
    annotation (Placement(transformation(extent={{-64,-214},{-44,-194}})));
  TRANSFORM.Blocks.RealExpression Extraction_Flow
    annotation (Placement(transformation(extent={{-64,-200},{-44,-180}})));
  TRANSFORM.Blocks.RealExpression SHS_Return_T
    annotation (Placement(transformation(extent={{-64,-186},{-44,-166}})));
  TRANSFORM.Blocks.RealExpression W_total_setpoint
    annotation (Placement(transformation(extent={{-64,-172},{-44,-152}})));
  TRANSFORM.Blocks.RealExpression Steam_turbine_inlet_pressure
    annotation (Placement(transformation(extent={{-64,-138},{-44,-118}})));
  TRANSFORM.Blocks.RealExpression massflow_LPTv
    annotation (Placement(transformation(extent={{-64,-156},{-44,-136}})));
equation
  connect(const5.y,Turb_Divert_Valve. u_s)
    annotation (Line(points={{-71,-46},{-66,-46},{-66,-50},{-56,-50}},
                                                     color={0,0,127}));
  connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
      points={{-30,-100},{-44,-100},{-44,-62}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                      color={0,0,127}));
  connect(TCV_Power.y, add1.u1)
    annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
  connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                         color=
          {0,0,127}));
  connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                color={0,0,127}));
  connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-33,-50},{-36,
          -50},{-36,-40},{-32.8,-40}},                               color={0,0,
          127}));
  connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
      points={{30,-100},{30,-46},{13,-46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-18},{13,-18}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.opening_BV, const2.y) annotation (Line(
      points={{30.1,-99.9},{30.1,84},{23,84}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const3.y, FWCP_Speed.u_s)
    annotation (Line(points={{-159,54},{-50,54},{-50,40},{-42,40}},
                                                 color={0,0,127}));
  connect(FWCP_Speed.y, add.u2)
    annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
  connect(const4.y, add.u1)
    annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
  connect(const9.y, PI_TBV.u_s)
    annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
      points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, TCV_Power.u_s) annotation (Line(points={{-63.3,-15},{-56,-15},
          {-56,-12},{-52,-12}}, color={0,0,127}));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{30,46},{23,46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(valvedelay.y,greater5. u2) annotation (Line(points={{-197,44},{-188,
          44},{-188,32},{-180,32}},
                                color={0,0,127}));
  connect(clock.y,greater5. u1) annotation (Line(points={{-201,8},{-188,8},{
          -188,24},{-180,24}},
                          color={0,0,127}));
  connect(greater5.y,switch_P_setpoint_TCV. u2)
    annotation (Line(points={{-157,24},{-140,24}},   color={255,0,255}));
  connect(const3.y, switch_P_setpoint_TCV.u3) annotation (Line(points={{-159,54},
          {-154,54},{-154,16},{-140,16}}, color={0,0,127}));
  connect(switch_P_setpoint_TCV.y, FWCP_Speed.u_m) annotation (Line(points={{
          -117,24},{-110,24},{-110,42},{-62,42},{-62,20},{-30,20},{-30,28}},
        color={0,0,127}));
  connect(sensorBus.Steam_Temperature, switch_P_setpoint_TCV.u1) annotation (
      Line(
      points={{-30,-100},{-150,-100},{-150,32},{-140,32}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.opening_TDV,TDV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-138},{13,-138}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV_TCV,BV_TCV_openingNominal. y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-198},{13,-198}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Discharge_OnOff_Throttle,Discharge_Throttle_On_Off. y)
    annotation (Line(
      points={{30,-100},{30,-170},{13,-170}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_mFlow,Feed_Pump_Mass_Flow. y) annotation (
      Line(
      points={{30,-100},{30,-122},{75,-122}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT1_BV,LPT1_BV. y) annotation (Line(
      points={{30,-100},{30,-274},{77,-274}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT2_BV,LPT2_BV. y) annotation (Line(
      points={{30,-100},{30,-244},{77,-244}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.SHS_throttle,SHS_Throttle. y) annotation (Line(
      points={{30,-100},{30,-214},{77,-214}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_SHS,TCV_SHS_Opening. y) annotation (Line(
      points={{30,-100},{30,-184},{77,-184}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.openingLPTv,LPT_Valve_Opening. y) annotation (Line(
      points={{30,-100},{30,-152},{77,-152}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Condensor_Output_mflow,Condensor_Outflow. u) annotation (
      Line(
      points={{-30,-100},{-100,-100},{-100,-204},{-66,-204}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Extract_flow,Extraction_Flow. u) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-190},{-66,-190}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SHS_Return_T,SHS_Return_T. u) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-176},{-66,-176}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint,W_total_setpoint. u) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-162},{-66,-162}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.massflow_LPTv,massflow_LPTv. u) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-146},{-66,-146}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_inlet_steamTurbine,Steam_turbine_inlet_pressure. u)
    annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-128},{-66,-128}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
end CS_SteamTurbine_L2_PressurePowerFeedtemp_HTGR;
