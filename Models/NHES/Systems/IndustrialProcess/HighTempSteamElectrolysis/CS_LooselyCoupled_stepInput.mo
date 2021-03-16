within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis;
model CS_LooselyCoupled_stepInput
  extends
    NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

  parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
  parameter SI.Power W_IP_nom(displayUnit="MW") = 69.62449e6
    "Nominal electrical power consumption in the IP";
  final parameter SI.Power W_IP_max(displayUnit="MW") = W_IP_nom*1.05
    "Maximum electrical power consumption in the IP";
  parameter SI.Power W_IP_min(displayUnit="MW") = 31.777966e6
    "Minimum electrical power consumption in the IP";

  Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
                   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={30,0})));
  Modelica.Blocks.Math.Gain scaler(k=1/capacityScaler)
    annotation (Placement(transformation(extent={{-12,-6},{0,6}})));
  Modelica.Blocks.Sources.Ramp W_IP_setPoint(
    duration=0,
    startTime=100,
    offset=(9.10627*1e6*5 + 24093140)*capacityScaler,
    height=(-1.929*1e6*5*1 - 291560*1 - 3037180*0 - 8911524*0)*capacityScaler)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation

  connect(actuatorBus.subBus_IP.HTSE.W_IP, limiter_W_IP.y) annotation (Line(
      points={{30,-100},{64,-100},{100,-100},{100,-1.33227e-15},{41,
          -1.33227e-15}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(scaler.y, limiter_W_IP.u)
    annotation (Line(points={{0.6,0},{0.6,0},{18,0}},       color={0,0,127}));
  connect(W_IP_setPoint.y, scaler.u)
    annotation (Line(points={{-39,0},{-13.2,0}},     color={0,0,127}));
annotation(defaultComponentName="CS");
end CS_LooselyCoupled_stepInput;
