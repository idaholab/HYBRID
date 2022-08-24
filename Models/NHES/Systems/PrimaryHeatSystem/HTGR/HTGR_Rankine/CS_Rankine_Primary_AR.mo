within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine;
model CS_Rankine_Primary_AR

  extends HTGR_Rankine.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-6,
    Ti=15,
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
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=30,
    yMax=75,
    yMin=45,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-36,14},{-16,-6}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{-80,-6},{-60,14}})));
  Modelica.Blocks.Sources.Constant valvedelay1(k=1e6)
    annotation (Placement(transformation(extent={{-44,74},{-24,94}})));
  Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-48,38},{-28,58}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{-4,74},{16,54}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV1
    annotation (Placement(transformation(extent={{74,54},{94,74}})));
  Modelica.Blocks.Sources.Constant const3(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{-80,112},{-60,132}})));
  TRANSFORM.Controls.LimPID Blower_Speed1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-6,
    Ti=5,
    yMax=75,
    yMin=10,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-36,132},{-16,112}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-59,-40},{-38,-40}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-96},{-96,-96},{-96,-72},{-26,-72},{-26,-52}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{-59,4},{-38,4}}, color={0,0,127}));
  connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,-96},{-96,-96},{-96,22},{-26,22},{-26,16}},
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
  connect(clock1.y, greater1.u1) annotation (Line(points={{-27,48},{-16,48},{
          -16,64},{-6,64}}, color={0,0,127}));
  connect(greater1.y, switch_P_setpoint_TCV1.u2)
    annotation (Line(points={{17,64},{72,64}}, color={255,0,255}));
  connect(actuatorBus.PR_Compressor, switch_P_setpoint_TCV1.y) annotation (Line(
      points={{30,-100},{32,-100},{32,-34},{116,-34},{116,64},{95,64}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Steam_Pressure, Blower_Speed1.u_m) annotation (Line(
      points={{-30,-100},{-30,-96},{-96,-96},{-96,140},{-26,140},{-26,134}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const3.y, Blower_Speed1.u_s)
    annotation (Line(points={{-59,122},{-38,122}}, color={0,0,127}));
  connect(Blower_Speed.y, switch_P_setpoint_TCV1.u3) annotation (Line(points={{
          -15,4},{18,4},{18,2},{62,2},{62,56},{72,56}}, color={0,0,127}));
  connect(Blower_Speed1.y, switch_P_setpoint_TCV1.u1) annotation (Line(points={
          {-15,122},{10,122},{10,120},{56,120},{56,72},{72,72}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Primary_AR;
