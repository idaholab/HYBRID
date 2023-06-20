within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems;
model CS_Rankine_PrimaryVNa_AR1

  extends HTGR_Rankine.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-6,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-38,-50},{-18,-30}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  replaceable HTGR_Rankine.Data.Data_CS data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    P_Steam_Ref=15000000)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  TRANSFORM.Controls.LimPID Blower_Speed1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=15,
    yMax=400,
    yMin=45,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{46,82},{66,62}})));
  Modelica.Blocks.Sources.Constant const3(k=200e6)
    annotation (Placement(transformation(extent={{4,62},{24,82}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-59,-40},{-40,-40}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-96},{-96,-96},{-96,-72},{-28,-72},{-28,-52}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{28,-100},{28,-40},{-17,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const3.y, Blower_Speed1.u_s)
    annotation (Line(points={{25,72},{44,72}}, color={0,0,127}));
  connect(sensorBus.thermal_power, Blower_Speed1.u_m) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,98},{56,98},{56,84}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.PR_Compressor, Blower_Speed1.y) annotation (Line(
      points={{30,-100},{30,4},{96,4},{96,72},{67,72}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_PrimaryVNa_AR1;
