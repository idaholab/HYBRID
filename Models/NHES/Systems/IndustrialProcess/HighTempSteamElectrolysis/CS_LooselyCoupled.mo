within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis;
model CS_LooselyCoupled
  extends
    NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

  parameter Real delayStart=5000 "Time to start tracking power profiles";
  parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
  parameter SI.Power W_IP_nom(displayUnit="MW") = 69.62449e6
    "Nominal electrical power consumption in the IP";
  final parameter SI.Power W_IP_max(displayUnit="MW") = W_IP_nom*1.05
    "Maximum electrical power consumption in the IP";
  parameter SI.Power W_IP_min(displayUnit="MW") = 31.777966e6
    "Minimum electrical power consumption in the IP";

  input SI.Power W_totalSetpoint "Total setpoint power" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
                   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={70,0})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=delayStart)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant W_IP_nominal(k=W_IP_nom)
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Blocks.Math.Gain scaler(k=1/capacityScaler)
    annotation (Placement(transformation(extent={{-14,-26},{-2,-14}})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_IP(y=W_totalSetpoint)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
equation

  connect(actuatorBus.subBus_IP.HTSE.W_IP, limiter_W_IP.y) annotation (Line(
      points={{30,-100},{64,-100},{100,-100},{100,-1.33227e-15},{81,-1.33227e-15}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(limiter_W_IP.u, switch.y)
    annotation (Line(points={{58,0},{58,0},{41,0}},       color={0,0,127}));
  connect(lessThreshold.y, switch.u2)
    annotation (Line(points={{-29,0},{18,0}},     color={255,0,255}));
  connect(clock.y, lessThreshold.u)
    annotation (Line(points={{-69,0},{-58,0},{-52,0}},       color={0,0,127}));
  connect(W_IP_nominal.y, switch.u1) annotation (Line(points={{1,20},{10,20},{10,
          8},{18,8}},        color={0,0,127}));
  connect(scaler.y, switch.u3) annotation (Line(points={{-1.4,-20},{10,-20},{10,
          -8},{18,-8}},   color={0,0,127}));
  connect(W_totalSetpoint_IP.y, scaler.u) annotation (Line(points={{-39,-40},{
          -28,-40},{-28,-20},{-15.2,-20}}, color={0,0,127}));
annotation(defaultComponentName="CS");
end CS_LooselyCoupled;
