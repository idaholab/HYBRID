within NHES.HydrogenTurbine.PowerPlant.Blocks;
block LimPI_antiWindup
  "Anti-windup proportional-integral (PI) controller with limited value of the output"
  extends Modelica.Blocks.Interfaces.SISO;

  parameter SI.Time T "Time constant";
  parameter SI.Time TI "Integration rate";

  parameter Real Ni(unit="1") = 0.95
    "T*Ni is time constant of anti-windup compensation";

  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3,4: initial output)" annotation (Dialog(tab="Initialization"));
  parameter Real y_start "Initial or guess value of output for y (= state)"
                                                       annotation (Dialog(tab="Initialization"));
  parameter Real y_max "Upper limit of an output signal";
  parameter Real y_min = -y_max "Lower limit of an output signal";

  Modelica.Blocks.Math.Add add1(k1=1, k2=1)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Math.Gain TeCtrlPara1(k=T/TI)
    annotation (Placement(transformation(extent={{-80,14},{-68,26}})));

  Modelica.Blocks.Continuous.Integrator integrator(y_start=y_start, initType=
        initType)
    annotation (Placement(transformation(extent={{-22,-36},{-2,-16}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=y_max, uMin=y_min)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Math.Add add2(k1=1, k2=-1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,-50})));
  Modelica.Blocks.Math.Gain AntiWindupConstant(k=1/(T*Ni))
    annotation (Placement(transformation(extent={{40,-76},{28,-64}})));

  Modelica.Blocks.Math.Gain TeCtrlPara2(k=(T/TI)/T)
    annotation (Placement(transformation(extent={{-80,-26},{-68,-14}})));
  Modelica.Blocks.Math.Add add(k1=1, k2=1)
    annotation (Placement(transformation(extent={{-56,-36},{-36,-16}})));
equation
  connect(limiter.y, y) annotation (Line(points={{81,0},{90,0},{110,0}},
        color={0,0,127}));
  connect(add2.u1, limiter.y) annotation (Line(points={{76,-38},{76,-28},{90,-28},
          {90,0},{81,0}},   color={0,0,127}));
  connect(limiter.u,add2. u2) annotation (Line(points={{58,0},{50,0},{50,-28},{64,
          -28},{64,-38}},     color={0,0,127}));
  connect(add2.y, AntiWindupConstant.u) annotation (Line(points={{70,-61},{70,-70},
          {46,-70},{41.2,-70}},          color={0,0,127}));
  connect(TeCtrlPara1.u, u) annotation (Line(points={{-81.2,20},{-88,20},{-88,0},
          {-120,0}}, color={0,0,127}));
  connect(TeCtrlPara2.u, u) annotation (Line(points={{-81.2,-20},{-88,-20},{-88,
          0},{-120,0}}, color={0,0,127}));
  connect(TeCtrlPara2.y, add.u1)
    annotation (Line(points={{-67.4,-20},{-58,-20}}, color={0,0,127}));
  connect(TeCtrlPara1.y, add1.u1) annotation (Line(points={{-67.4,20},{8,20},{8,
          6},{18,6}}, color={0,0,127}));
  connect(integrator.y, add1.u2) annotation (Line(points={{-1,-26},{8,-26},{8,-6},
          {18,-6}}, color={0,0,127}));
  connect(add.y, integrator.u)
    annotation (Line(points={{-35,-26},{-24,-26}},           color={0,0,127}));
  connect(limiter.u, add1.y)
    annotation (Line(points={{58,0},{41,0}}, color={0,0,127}));
  connect(AntiWindupConstant.y, add.u2) annotation (Line(points={{27.4,-70},{-66,
          -70},{-66,-32},{-58,-32}}, color={0,0,127}));
annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-32},{20,68},{80,68}}, color={0,0,127}),
        Line(
          visible=strict,
          points={{-30,0},{20,-6.12325e-016}},
          color={0,0,127},
          smooth=Smooth.None,
          origin={-80,-52},
          rotation=90),
        Text(
          extent={{10,0},{70,-60}},
          lineColor={192,192,192},
          textString="PI")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}})));
end LimPI_antiWindup;
