within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_SFR_02

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID TCV_Position(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=5,
    yMax=0,
    yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-56,-18},{-36,-38}})));
  Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
    annotation (Placement(transformation(extent={{-86,-38},{-66,-18}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{-38,-60},{-30,-52}})));
  Data.HTGR_Rankine
                  data
    annotation (Placement(transformation(extent={{-98,-4},{-78,16}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    yMax=0.1,
    yMin=-0.9)
    annotation (Placement(transformation(extent={{-40,64},{-20,44}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-16,22},{4,42}})));
  Modelica.Blocks.Sources.Constant const2(k=0.9)
    annotation (Placement(transformation(extent={{-64,16},{-44,36}})));
  Modelica.Blocks.Sources.Constant const3(k=433)
    annotation (Placement(transformation(extent={{-84,46},{-64,66}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-30,-142},{-10,-162}})));
  Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
    annotation (Placement(transformation(extent={{-70,-162},{-50,-142}})));
equation

  connect(const6.y, TCV_Position.u_s)
    annotation (Line(points={{-65,-28},{-58,-28}},   color={0,0,127}));
  connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-8},{-46,-8},{-46,-16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TCV, const7.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-56},{-29.6,-56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add.u2, const2.y)
    annotation (Line(points={{-18,26},{-43,26}}, color={0,0,127}));
  connect(PID.u_s, const3.y) annotation (Line(points={{-42,54},{-42,56},{-63,56}},
                                       color={0,0,127}));
  connect(add.u1, PID.y) annotation (Line(points={{-18,38},{-22,38},{-22,42},{
          -18,42},{-18,46},{-12,46},{-12,54},{-19,54}}, color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, PID.u_m) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,82},{-30,82},{-30,66},{-30,66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Q_FWH, add.y) annotation (Line(
      points={{30,-100},{34,-100},{34,32},{5,32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const9.y,PI_TBV. u_s)
    annotation (Line(points={{-49,-152},{-32,-152}},
                                                   color={0,0,127}));
  connect(sensorBus.p_inlet_steamTurbine, PI_TBV.u_m) annotation (Line(
      points={{-29.9,-99.9},{-48,-99.9},{-48,-114},{-22,-114},{-22,-140},{-20,
          -140}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BV, PI_TBV.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-152},{-9,-152}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_SFR_02;
