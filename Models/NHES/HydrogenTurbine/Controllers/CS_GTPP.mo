within NHES.HydrogenTurbine.Controllers;
model CS_GTPP
  extends NHES.HydrogenTurbine.Controllers.BaseClasses.Partial_SES_CS;
  Modelica.Blocks.Sources.Ramp wf_pu_ctrlSignal(
    duration=0,
    height=0.513332 - 1,
    offset=1,
    startTime=15)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Math.Feedback feedback_W_gen annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,0})));
  Modelica.Blocks.Sources.Ramp loadSignal1(
      duration=0,
      offset=35*1e6,
      startTime=10,
      height=-3.5*1e6*5) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-70,84})));
  Modelica.Blocks.Math.Add sumLoads annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-48,28})));
  Modelica.Blocks.Sources.Ramp loadSignal2(
    duration=0,
    offset=0,
    startTime=40,
    height=3.5*1e6*3.1)        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,50})));
  Modelica.Blocks.Continuous.PI FBctrl_powerGeneration(
    y_start=1,
    x_start=1/FBctrl_powerGeneration.k,
    T=1.5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=30/(35e6))
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(signalBus.Signal_SES.c_wf_pu, wf_pu_ctrlSignal.y) annotation (
      Line(
      points={{0.1,-99.9},{80,-99.9},{80,0},{61,0}},
      color={255,204,51},
      thickness=0.5));
  connect(signalBus.Signal_SES.s_W_gen, feedback_W_gen.u2) annotation (Line(
      points={{0.1,-99.9},{-40,-99.9},{-40,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(loadSignal1.y, sumLoads.u1) annotation (Line(points={{-59,84},{
          -43.2,84},{-43.2,37.6}}, color={0,0,127}));
  connect(loadSignal2.y, sumLoads.u2) annotation (Line(points={{-59,50},{
          -52.8,50},{-52.8,37.6}}, color={0,0,127}));
  connect(sumLoads.y, feedback_W_gen.u1) annotation (Line(points={{-48,19.2},
          {-48,12},{-60,12},{-60,0},{-48,0}}, color={0,0,127}));
  connect(feedback_W_gen.y, FBctrl_powerGeneration.u)
    annotation (Line(points={{-31,0},{-2,0}}, color={0,0,127}));
  annotation (defaultComponentName="CS",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_GTPP;
