within NHES.HydrogenTurbine.PowerPlant.Blocks;
block LimI_antiWindup
  "Anti-windup integral controller with limited value of the output (and with limited ramp rates)"
  extends Modelica.Blocks.Interfaces.SISO;

  parameter SI.Time T "Integrator time constant";
  parameter Real Ni(unit="1") = 0.95
    "T*Ni is time constant of anti-windup compensation";

  parameter Real uRamp_max = Modelica.Constants.inf
    "Upper limit for the ramp rate of an input signal";
  parameter Real uRamp_min = -uRamp_max
    "Lower limit for the ramp rate of an input signal";
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3,4: initial output)" annotation (Dialog(tab="Initialization"));
  parameter Real y_start "Initial or guess value of output for y (= state)"
                                                       annotation (Dialog(tab="Initialization"));
  parameter Real y_max "Upper limit of an output signal";
  parameter Real y_min = -y_max "Lower limit of an output signal";

  Modelica.Blocks.Math.Add add(k1=1, k2=1)
    annotation (Placement(transformation(extent={{-20,-16},{0,4}})));
  Modelica.Blocks.Math.Gain IntegralTimeConstant(k=1/T)
    annotation (Placement(transformation(extent={{-80,-6},{-68,6}})));

  Modelica.Blocks.Continuous.Integrator integrator(y_start=y_start, initType=
        initType)
    annotation (Placement(transformation(extent={{20,-16},{40,4}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_rampRate(uMax=uRamp_max, uMin=
        uRamp_min)
    annotation (Placement(transformation(extent={{-56,-10},{-36,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=y_max, uMin=y_min)
    annotation (Placement(transformation(extent={{60,-16},{80,4}})));
  Modelica.Blocks.Math.Add add1(k1=1, k2=-1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,-50})));
  Modelica.Blocks.Math.Gain AntiWindupConstant(k=1/(T*Ni))
    annotation (Placement(transformation(extent={{20,-76},{8,-64}})));

equation
  connect(IntegralTimeConstant.u, u)
    annotation (Line(points={{-81.2,0},{-81.2,0},{-120,0}}, color={0,0,127}));
  connect(limiter_rampRate.u, IntegralTimeConstant.y)
    annotation (Line(points={{-58,0},{-67.4,0}}, color={0,0,127}));
  connect(limiter_rampRate.y, add.u1)
    annotation (Line(points={{-35,0},{-22,0}}, color={0,0,127}));
  connect(integrator.u, add.y)
    annotation (Line(points={{18,-6},{1,-6}}, color={0,0,127}));
  connect(limiter.u, integrator.y)
    annotation (Line(points={{58,-6},{41,-6}}, color={0,0,127}));
  connect(limiter.y, y) annotation (Line(points={{81,-6},{90,-6},{90,0},{110,0}},
        color={0,0,127}));
  connect(add1.u1, limiter.y) annotation (Line(points={{76,-38},{76,-28},{90,-28},
          {90,-6},{81,-6}}, color={0,0,127}));
  connect(limiter.u, add1.u2) annotation (Line(points={{58,-6},{50,-6},{50,-28},
          {64,-28},{64,-38}}, color={0,0,127}));
  connect(add1.y, AntiWindupConstant.u) annotation (Line(points={{70,-61},{70,-70},
          {46,-70},{34,-70},{21.2,-70}}, color={0,0,127}));
  connect(AntiWindupConstant.y, add.u2) annotation (Line(points={{7.4,-70},{-30,
          -70},{-30,-12},{-22,-12}}, color={0,0,127}));
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
        Line(points={{-80,-80},{20,20},{80,20}}, color={0,0,127}),
        Text(
          extent={{0,-10},{60,-70}},
          lineColor={192,192,192},
          textString="I"),
        Text(
          extent={{-150,-150},{150,-110}},
          lineColor={0,0,0},
          textString="T=%T")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}})));
end LimI_antiWindup;
