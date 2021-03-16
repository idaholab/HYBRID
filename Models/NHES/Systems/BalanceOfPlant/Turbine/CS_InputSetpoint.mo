within NHES.Systems.BalanceOfPlant.Turbine;
model CS_InputSetpoint
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Math.Gain Q_normal_gain(k=0.25e-8)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Math.Gain Q_normal_gain1(k=0.25e-8) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,-10})));
  TRANSFORM.Controls.LimPID
                       PID_TCV_opening(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=-1,
    k=0.1,
    Ti=95) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Logical.Switch switch_Q_setpoint
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Sources.Constant TCV_opening_nominal(k=0.5)
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Blocks.Math.Add TCV_opening
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Sources.ContinuousClock clock
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Modelica.Blocks.Sources.Constant TCVDelay(k=delayStartTCV)
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  parameter SI.Time delayStartTCV=100 "Delay TCV control";
  Modelica.Blocks.Logical.Switch switch_Q_setpoint1
    annotation (Placement(transformation(extent={{64,20},{84,40}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
equation
  connect(switch_Q_setpoint.y, Q_normal_gain1.u)
    annotation (Line(points={{-39,-10},{-2,-10}}, color={0,0,127}));
  connect(Q_normal_gain1.y, PID_TCV_opening.u_m)
    annotation (Line(points={{21,-10},{30,-10},{30,18}}, color={0,0,127}));
  connect(TCV_opening_nominal.y, TCV_opening.u1) annotation (Line(points={{41,90},
          {50,90},{50,76},{98,76}}, color={0,0,127}));
  connect(Q_normal_gain.y, PID_TCV_opening.u_s)
    annotation (Line(points={{1,30},{18,30}}, color={0,0,127}));
  connect(clock.y, less.u1) annotation (Line(points={{-119,10},{-110,10},{-110,
          -10},{-102,-10}}, color={0,0,127}));
  connect(TCVDelay.y, less.u2) annotation (Line(points={{-119,-30},{-110,-30},{-110,
          -18},{-102,-18}}, color={0,0,127}));
  connect(less.y, switch_Q_setpoint.u2) annotation (Line(points={{-79,-10},{-70,
          -10},{-62,-10}}, color={255,0,255}));
  connect(PID_TCV_opening.y, switch_Q_setpoint1.u3) annotation (Line(points={{
          41,30},{50,30},{50,22},{62,22}}, color={0,0,127}));
  connect(switch_Q_setpoint1.u2, switch_Q_setpoint.u2) annotation (Line(points=
          {{62,30},{52,30},{52,10},{-68,10},{-68,-10},{-62,-10}}, color={255,0,
          255}));
  connect(switch_Q_setpoint1.y, TCV_opening.u2) annotation (Line(points={{85,30},
          {90,30},{90,64},{98,64}}, color={0,0,127}));
  connect(const.y, switch_Q_setpoint1.u1) annotation (Line(points={{41,60},{50,
          60},{50,38},{62,38}}, color={0,0,127}));
  connect(sensorBus.W_totalSetpoint, Q_normal_gain.u) annotation (
      Line(
      points={{-29.9,-99.9},{-52,-99.9},{-72,-99.9},{-72,30},{-22,30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_total, switch_Q_setpoint.u3) annotation (Line(
      points={{-29.9,-99.9},{-72,-99.9},{-72,-18},{-62,-18}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint, switch_Q_setpoint.u1)
    annotation (Line(
      points={{-29.9,-99.9},{-52,-99.9},{-72,-99.9},{-72,-2},{-62,-2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TCV, TCV_opening.y) annotation (Line(
      points={{30.1,-99.9},{116,-99.9},{200,-99.9},{200,70},{121,70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,
            140}})));
end CS_InputSetpoint;
