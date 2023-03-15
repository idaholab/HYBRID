within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_SteamTSlidingP
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  //input Real electric_demand_int = data.Q_Nom;

  Modelica.Blocks.Sources.Constant const1(k=500 + 273)
    annotation (Placement(transformation(extent={{-90,-4},{-76,10}})));
  TRANSFORM.Controls.LimPID Pump_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.005,
    Ti=100,
    yb=0.01,
    yMax=1,
    yMin=0.01,
    wp=0.8,
    Ni=0.1,
    xi_start=0,
    y_start=0.01)
    annotation (Placement(transformation(extent={{-56,-16},{-42,-2}})));
  Modelica.Blocks.Sources.Constant valvedelay3(k=3500)
    annotation (Placement(transformation(extent={{-84,78},{-64,98}})));
  Modelica.Blocks.Sources.ContinuousClock clock3(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-84,38},{-64,58}})));
  Modelica.Blocks.Logical.Greater greater3
    annotation (Placement(transformation(extent={{-44,78},{-24,58}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV3
    annotation (Placement(transformation(extent={{6,78},{26,58}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=0.4,
    duration=2000,
    offset=0.0005,
    startTime=4000)
    annotation (Placement(transformation(extent={{-32,100},{-18,114}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay2(Ti=20)
    annotation (Placement(transformation(extent={{42,62},{56,74}})));
  TRANSFORM.Controls.LimPID FWH_ctr(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=50,
    yb=0.001,
    yMax=1,
    yMin=0.001,
    wp=0.8,
    y_start=0.01)
    annotation (Placement(transformation(extent={{-22,34},{-8,48}})));
  Modelica.Blocks.Sources.Constant const3(k=100 + 273)
    annotation (Placement(transformation(extent={{-50,34},{-36,48}})));
equation
  connect(sensorBus.Steam_Temperature, Pump_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-22},{-49,-22},{-49,-17.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Feed_Pump_mFlow, Pump_Speed.y) annotation (Line(
      points={{30,-100},{30,-9},{-41.3,-9}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const1.y, Pump_Speed.u_s) annotation (Line(points={{-75.3,3},{-64,3},
          {-64,-9},{-57.4,-9}},color={0,0,127}));
  connect(valvedelay3.y,greater3. u2) annotation (Line(points={{-63,88},{-54,88},
          {-54,76},{-46,76}},         color={0,0,127}));
  connect(clock3.y,greater3. u1) annotation (Line(points={{-63,48},{-56,48},{
          -56,68},{-46,68}},      color={0,0,127}));
  connect(greater3.y,switch_P_setpoint_TCV3. u2)
    annotation (Line(points={{-23,68},{4,68}},       color={255,0,255}));
  connect(ramp2.y,switch_P_setpoint_TCV3. u3) annotation (Line(points={{-17.3,
          107},{-4,107},{-4,76},{4,76}},                 color={0,0,127}));
  connect(delay2.u,switch_P_setpoint_TCV3. y)
    annotation (Line(points={{40.6,68},{27,68}},   color={0,0,127}));
  connect(actuatorBus.FW_valve_opening, delay2.y) annotation (Line(
      points={{30,-100},{30,-8},{72,-8},{72,68},{56.98,68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const3.y,FWH_ctr. u_s) annotation (Line(points={{-35.3,41},{-23.4,41}},
                                                 color={0,0,127}));
  connect(FWH_ctr.y, switch_P_setpoint_TCV3.u1) annotation (Line(points={{-7.3,
          41},{-4,41},{-4,60},{4,60}}, color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, FWH_ctr.u_m) annotation (Line(
      points={{-30,-100},{-30,-22},{-15,-22},{-15,32.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
end CS_SteamTSlidingP;
