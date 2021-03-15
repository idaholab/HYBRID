within NHES.Electrolysis.Controllers;
block LimI_antiWindup
  "Anti-windup integral controller with limited value of the output (and with limited ramp rates)"
  extends Modelica.Blocks.Interfaces.SISO;
  import InitPID =
         Modelica.Blocks.Types.Init;
  import Modelica.Blocks.Types.Init;
  //import Modelica.Blocks.Types.SimpleController;

  parameter .Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Evaluate=true, Dialog(group="Initialization"));

  parameter SI.Time Ti( min=Modelica.Constants.small)=0.5 "Integral time constant";
  parameter Real Ni(unit="1",min=100*Modelica.Constants.eps) = 0.9
    "Ni*Ti is time constant of anti-windup compensation";

  parameter Real uRamp_max = Modelica.Constants.inf
    "Upper limit for the ramp rate of an input signal";
  parameter Real uRamp_min = -uRamp_max
    "Lower limit for the ramp rate of an input signal";

  parameter Real xi_start=0
    "Initial or guess value for integrator output (= integrator state)" annotation (Dialog(group="Initialization"));
  parameter Real y_start=0
    "Initial value of output"  annotation(Dialog(enable=initType == .Modelica.Blocks.Types.Init.InitialOutput,    group=
          "Initialization"));
  parameter Real y_max(start=1) "Upper limit of an output signal";
  parameter Real y_min = -y_max "Lower limit of an output signal";

  constant SI.Time unitTime=1  annotation(HideResult=true);

  Modelica.Blocks.Math.Add addI(k1=+1, k2=+1)
    annotation (Placement(transformation(extent={{-20,-16},{0,4}})));

  Modelica.Blocks.Continuous.Integrator I(
    y_start=xi_start,
    initType=if initType == InitPID.SteadyState then Init.SteadyState else if
        initType == InitPID.InitialState or initType == InitPID.InitialState
         then Init.InitialState else Init.NoInit,
    k=1) annotation (Placement(transformation(extent={{20,-16},{40,4}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_rampRate(uMax=uRamp_max, uMin=
        uRamp_min)
    annotation (Placement(transformation(extent={{-56,-10},{-36,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=y_max, uMin=y_min)
    annotation (Placement(transformation(extent={{60,-16},{80,4}})));
  Modelica.Blocks.Math.Add addSat(k2=-1, k1=+1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,-50})));
  Modelica.Blocks.Math.Gain gainTrack(k=1/(Ni*Ti))
    annotation (Placement(transformation(extent={{20,-80},{0,-60}})));

  Modelica.Blocks.Math.Gain Ti_reciprocal(k=unitTime/Ti)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
initial equation
    if initType==InitPID.InitialOutput then
       I.y = y_start;
    end if;
equation
    if initType ==InitPID.InitialOutput  and (y_start < y_min or y_start > y_max) then
        Modelica.Utilities.Streams.error("LimPID: Start value y_start (=" + String(y_start) +
           ") is outside of the limits of yMin (=" + String(y_min) +") and yMax (=" + String(y_max) + ")");
    end if;

  connect(limiter.y, y) annotation (Line(points={{81,-6},{81,-6},{90,-6},{90,0},
          {110,0}},
        color={0,0,127}));
  connect(addSat.u1, limiter.y) annotation (Line(points={{76,-38},{76,-28},{90,-28},
          {90,-6},{81,-6}},
                          color={0,0,127}));
  connect(limiter.u, addSat.u2) annotation (Line(points={{58,-6},{50,-6},{50,-28},
          {64,-28},{64,-38}}, color={0,0,127}));
  connect(addSat.y, gainTrack.u)
    annotation (Line(points={{70,-61},{70,-70},{22,-70}}, color={0,0,127}));
  connect(Ti_reciprocal.y, limiter_rampRate.u)
    annotation (Line(points={{-67,0},{-67,0},{-58,0}}, color={0,0,127}));
  connect(u, Ti_reciprocal.u)
    annotation (Line(points={{-120,0},{-102,0},{-90,0}}, color={0,0,127}));
  connect(limiter_rampRate.y, addI.u1)
    annotation (Line(points={{-35,0},{-22,0}},         color={0,0,127}));
  connect(addI.y, I.u)
    annotation (Line(points={{1,-6},{18,-6}}, color={0,0,127}));
  connect(I.y, limiter.u)
    annotation (Line(points={{41,-6},{58,-6}}, color={0,0,127}));
  connect(gainTrack.y, addI.u2) annotation (Line(points={{-1,-70},{-30,-70},{-30,
          -12},{-22,-12}}, color={0,0,127}));
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
