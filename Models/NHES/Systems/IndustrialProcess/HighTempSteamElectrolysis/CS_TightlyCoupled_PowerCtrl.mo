within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis;
model CS_TightlyCoupled_PowerCtrl
  extends
    NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

  parameter SI.Power W_IP_nom(displayUnit="MW") = 51.1454e6
    "Nominal electrical power consumption in the IP";
  final parameter SI.Power W_IP_max(displayUnit="MW") = W_IP_nom*1.05
    "Maximum electrical power consumption in the IP";
  parameter SI.Power W_IP_min(displayUnit="MW") = 20.9561e6
    "Minimum electrical power consumption in the IP";
Modelica.Blocks.Math.Feedback feedback_TNOut_cathodeGas annotation (Placement(
        transformation(
        extent={{12,-12},{-12,12}},
        rotation=180,
        origin={-40,0})));
  Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
    startTime=100,
    height=0,
    duration=0,
    offset=283.4 + 273.15,
    y(displayUnit="degC", unit="K")) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,30})));
  Modelica.Blocks.Continuous.PI FBctrl_TNOut_cathodeGas(
    k=8000,
    T=8,
    y(start=51.1454e6),
    initType=Modelica.Blocks.Types.Init.InitialState,
    x_start=FBctrl_TNOut_cathodeGas.y_start/FBctrl_TNOut_cathodeGas.k,
    y_start=51.1454e6)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={50,0})));
equation
  connect(feedback_TNOut_cathodeGas.y, FBctrl_TNOut_cathodeGas.u) annotation (
      Line(points={{-29.2,-1.33227e-015},{-29.2,0},{-2,0}}, color={0,0,127}));
  connect(FBctrl_TNOut_cathodeGas.y, limiter_W_IP.u) annotation (Line(points={{21,
          0},{21,1.55431e-015},{38,1.55431e-015}}, color={0,0,127}));

  connect(TNOut_cathodeGas_set.y, feedback_TNOut_cathodeGas.u2)
    annotation (Line(points={{-59,30},{-40,30},{-40,9.6}}, color={0,0,127}));
  connect(sensorBus.TNOut_cathodeGas, feedback_TNOut_cathodeGas.u1)
    annotation (Line(
      points={{-30,-100},{-100,-100},{-100,0},{-49.6,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.subBus_IP.HTSE.W_IP, limiter_W_IP.y) annotation (Line(
      points={{30,-100},{100,-100},{100,0},{61,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="CS");
end CS_TightlyCoupled_PowerCtrl;
