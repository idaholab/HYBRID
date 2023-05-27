within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems;
model CS_Rankine_PrimaryVN

  extends HTGR_Rankine.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  replaceable HTGR_Rankine.Data.Data_CS data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    P_Steam_Ref=15000000)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=30,
    yMax=75,
    yMin=45,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-36,14},{-16,-6}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{-80,-6},{-60,14}})));
  VarLimVarK_PID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.000001,
    Ti=10,
    k_s=-1,
    k_m=-1,
    Ni=0.0001,
    xi_start=40,
    use_k_in=false,
    use_lowlim_in=false,
    use_uplim_in=false,
    Td=1,
    yMax=80,
    yMin=0) annotation (Placement(transformation(extent={{38,50},{58,70}})));
  Modelica.Blocks.Sources.Constant const6(k=12.5e7)
    annotation (Placement(transformation(extent={{10,58},{20,68}})));
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
  connect(const6.y, PID.u_s) annotation (Line(points={{20.5,63},{26,63},{26,60},
          {36,60}}, color={0,0,127}));
  connect(sensorBus.thermal_power, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-74},{48,-74},{48,48}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
      points={{30,-100},{30,4},{-15,4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    experiment(Tolerance=0.001, __Dymola_Algorithm="Esdirk45a"));
end CS_Rankine_PrimaryVN;
