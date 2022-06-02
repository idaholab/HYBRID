within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model CS_SFR_01

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{-38,-60},{-30,-52}})));
  Data.HTGR_Rankine
                  data
    annotation (Placement(transformation(extent={{-98,-4},{-78,16}})));
  TRANSFORM.Controls.LimPID PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1000) annotation (Placement(transformation(extent={{-40,64},{-20,44}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-14,22},{6,42}})));
  Modelica.Blocks.Sources.Constant const2(k=175e6)
    annotation (Placement(transformation(extent={{-64,16},{-44,36}})));
  Modelica.Blocks.Sources.Constant const3(k=483.15)
    annotation (Placement(transformation(extent={{-88,42},{-68,62}})));
  TRANSFORM.Controls.LimPID PI_TBV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-7,
    Ti=15,
    yMax=0.99,
    yMin=-0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-96,100},{-76,120}})));
  Modelica.Blocks.Sources.Constant const1(k=150e5)
    annotation (Placement(transformation(extent={{-142,100},{-122,120}})));
  TRANSFORM.Controls.LimPID PI_BV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-78,-80},{-58,-60}})));
  Modelica.Blocks.Sources.Constant const4(k=483.15)
    annotation (Placement(transformation(extent={{-112,-80},{-92,-60}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-6,94},{14,114}})));
  Modelica.Blocks.Sources.Constant const5(k=0.01)
    annotation (Placement(transformation(extent={{-48,86},{-28,106}})));
equation

  connect(actuatorBus.opening_TCV, const7.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-56},{-29.6,-56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add.u2, const2.y)
    annotation (Line(points={{-16,26},{-43,26}}, color={0,0,127}));
  connect(PID.u_s, const3.y) annotation (Line(points={{-42,54},{-42,52},{-67,52}},
                                       color={0,0,127}));
  connect(add.u1, PID.y) annotation (Line(points={{-16,38},{-22,38},{-22,42},{
          -18,42},{-18,46},{-12,46},{-12,54},{-19,54}}, color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, PID.u_m) annotation (Line(
      points={{-30,-100},{-102,-100},{-102,82},{-30,82},{-30,66},{-30,66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Q_FWH, add.y) annotation (Line(
      points={{30,-100},{34,-100},{34,32},{7,32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure,PI_TBV. u_m) annotation (Line(
      points={{-30,-100},{-160,-100},{-160,92},{-86,92},{-86,98}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PI_TBV.u_s, const1.y)
    annotation (Line(points={{-98,110},{-121,110}}, color={0,0,127}));
  connect(actuatorBus.opening_BV, PI_BV.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-70},{-57,-70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, PI_BV.u_m) annotation (Line(
      points={{-30,-100},{-68,-100},{-68,-82}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PI_BV.u_s, const4.y)
    annotation (Line(points={{-80,-70},{-91,-70}}, color={0,0,127}));
  connect(add1.u2, const5.y)
    annotation (Line(points={{-8,98},{-8,96},{-27,96}}, color={0,0,127}));
  connect(add1.u1, PI_TBV.y)
    annotation (Line(points={{-8,110},{-75,110}}, color={0,0,127}));
  connect(actuatorBus.TBV, add1.y) annotation (Line(
      points={{30,-100},{34,-100},{34,104},{15,104}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_SFR_01;
