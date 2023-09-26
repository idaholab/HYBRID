within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR.CS;
model CS_Texit_speedControl

  extends BaseClasses.Partial_ControlSystem;
  parameter Modelica.Units.SI.Power Power_nom= 15e6;
  parameter Real CR_worth=2000e-5;
  parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
  TRANSFORM.Controls.LimPID PID_exit_T(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.0000001,
    Ti=3600,
    yMax=0.0032,
    yMin=-0.0032,
    Ni=3,
    y_start=8.75)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.RealExpression power_ref(y=Power_nom)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  parameter Modelica.Blocks.Interfaces.RealOutput T_in_nom=330
    "Value of Real output";
  NHES.Controls.LimOffsetPID RCP_PID(
    k=1e-8,
    Ti=360,
    yMax=12,
    yMin=2,
    offset=6,
    delayTime=0,
    init_output=6)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
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
  connect(power_ref.y, RCP_PID.u_s)
    annotation (Line(points={{-59,-30},{-22,-30}}, color={0,0,127}));
  connect(actuatorBus.Pump_flow, RCP_PID.y) annotation (Line(
      points={{30,-100},{30,-30},{1,-30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Q_RX, RCP_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-52},{-10,-52},{-10,-42}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.CR_speed, PID_exit_T.y) annotation (Line(
      points={{30,-100},{30,50},{-19,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end CS_Texit_speedControl;
