within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR.CS;
model CS_Texit_posControl

  extends BaseClasses.Partial_ControlSystem;
  parameter Modelica.Units.SI.Power Power_nom= 15e6;
  parameter Real CR_worth=2000e-5;
  parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
  TRANSFORM.Controls.LimPID PID_exit_T(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.00002,
    Ti=360,
    yMax=1,
    yMin=-1,
    Ni=3)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Math.Gain gain(k=-CR_worth)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Step step(height=300e-5, startTime=3.1E6)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Blocks.Sources.Step step1(height=0, startTime=0)
    annotation (Placement(transformation(extent={{14,70},{34,90}})));
  Modelica.Blocks.Sources.RealExpression power_ref(y=Power_nom)
    annotation (Placement(transformation(extent={{-70,-48},{-50,-28}})));
  Controls.LimOffsetPID      RCP_PID(
    k=1e-8,
    Ti=360,
    yMax=12,
    yMin=2,
    offset=7,
    init_output=7)
    annotation (Placement(transformation(extent={{-10,-48},{10,-28}})));
equation

  connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
      points={{-30,-100},{-30,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
    annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
  connect(gain.u, PID_exit_T.y)
    annotation (Line(points={{-2,50},{-19,50}},          color={0,0,127}));
  connect(step.y, add.u2) annotation (Line(points={{21,10},{32,10},{32,24},
          {38,24}}, color={0,0,127}));
  connect(actuatorBus.CR_pos, add.y) annotation (Line(
      points={{30,-100},{30,8},{66,8},{66,30},{61,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(gain.y, add.u1)
    annotation (Line(points={{21,50},{38,50},{38,36}}, color={0,0,127}));
  connect(power_ref.y,RCP_PID. u_s)
    annotation (Line(points={{-49,-38},{-12,-38}}, color={0,0,127}));
  connect(actuatorBus.Pump_flow,RCP_PID. y) annotation (Line(
      points={{30,-100},{30,-38},{11,-38}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Q_RX,RCP_PID. u_m) annotation (Line(
      points={{-30,-100},{-30,-60},{0,-60},{0,-50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end CS_Texit_posControl;
