within NHES.Electrolysis.Controllers;
model CS_HTSE
  extends Electrolysis.Controllers.BaseClasses.Partial_IP_CS;
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
    y_start=45.53135e6,
    x_start=45.53135e6/FBctrl_TNOut_cathodeGas.k,
    k=8000,
    T=8,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y(start=45.53135e6))
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_We_SOEC(uMin=16.596350*1e6, uMax=(
        45.531350*1e6)*1.05) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={50,0})));
equation
  connect(feedback_TNOut_cathodeGas.y, FBctrl_TNOut_cathodeGas.u) annotation (
      Line(points={{-29.2,-1.33227e-015},{-29.2,0},{-2,0}}, color={0,0,127}));
  connect(FBctrl_TNOut_cathodeGas.y, limiter_We_SOEC.u) annotation (Line(points=
         {{21,0},{21,1.55431e-015},{38,1.55431e-015}}, color={0,0,127}));
  connect(signalBus.Signals_IP.c_We_SOEC, limiter_We_SOEC.y) annotation (Line(
      points={{0,-100},{80,-100},{80,-1.33227e-015},{61,-1.33227e-015}},
      color={255,204,51},
      thickness=0.5));

  connect(signalBus.Signals_IP.s_TNOut_cathodeGas, feedback_TNOut_cathodeGas.u1)
    annotation (Line(
      points={{0,-100},{0,-98},{-80,-98},{-80,1.33227e-015},{-49.6,1.33227e-015}},
      color={255,204,51},
      thickness=0.5));
  connect(TNOut_cathodeGas_set.y, feedback_TNOut_cathodeGas.u2)
    annotation (Line(points={{-59,30},{-40,30},{-40,9.6}}, color={0,0,127}));
annotation(defaultComponentName="CS");
end CS_HTSE;
