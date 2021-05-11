within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution;
block PI_Control_Reset_Input
  "Proportional-Integral controller: y = yb + Kc*e + Kc/Ti*integral(e), with a logical input for integral reset"
  import Modelica.Blocks.Types.Init;
  extends Modelica.Blocks.Interfaces.SVcontrol;
  parameter Real k(unit="1") = 1 "Error Gain";
  parameter Modelica.Units.SI.Time Ti(
    start=1,
    min=Modelica.Constants.small) = 1 "Time Constant (Ti>0 required)";
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Evaluate=true, Dialog(group="Initialization"));

  parameter Real yb=0 "Output bias";
  parameter Real k_s=1 "Scaling factor for setpoint: k_s*u_s";
  parameter Real k_m=1 "Scaling factor for measurement: k_m*u_m";
  parameter Boolean directActing=true "=false reverse acting"
    annotation (Evaluate=true);
  parameter Real x_start=0 "Initial or guess value of error integral (state)"
    annotation (Dialog(group="Initialization"));
  parameter Real y_start=0 "Initial value of output" annotation (Dialog(enable=
          initType == Init.SteadyState or initType == Init.InitialOutput, group=
         "Initialization"));
  Real x(start=x_start) "Error integral (state)";
  Real Kc=k*(if directActing then +1 else -1);
  Real e=k_s*u_s - k_m*u_m;

  Modelica.Blocks.Interfaces.BooleanInput
            k_in
                "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-140,60},{-100,100}})));
initial equation
  if initType == Init.SteadyState then
    der(x) = 0;
  elseif initType == Init.InitialState then
    x = x_start;
  elseif initType == Init.InitialOutput then
    y = y_start;
  end if;
equation

if k_in then
  Ti*der(x) = e;
else
  der(x) = -10*x;
end if;
  y = yb + Kc*e + Kc*x;
  //y = yb + Kc*e;
  annotation (
    defaultComponentName="PI",
    Documentation(info="<html>
<p>This is a custom PI controller based on the PI TRANSFORM controller but also uses a logical input to dictate a form of anti-windup. The purpose is to force a PI controller to effectively be forced to turn off when the logical input is false and operate normally when the logical is true. During long periods of controller integral calculation when the controller is not in use, the controller will produce a large integral term which could cause controller lag when the operational mode changes. </p>
<p>This blocks defines the transfer function between the input u and the output y (element-wise) as <i>PI</i> system: </p>
<p><span style=\"font-family: Courier New;\">                 1</span></p>
<p><span style=\"font-family: Courier New;\">   y = k * (1 + ---) * u</span></p>
<p><span style=\"font-family: Courier New;\">                T*s</span></p>
<p><span style=\"font-family: Courier New;\">           T*s + 1</span></p>
<p><span style=\"font-family: Courier New;\">     = k * ------- * u</span></p>
<p><span style=\"font-family: Courier New;\">             T*s</span></p>
<p>If you would like to be able to change easily between different transfer functions (FirstOrder, SecondOrder, ... ) by changing parameters, use the general model class <b>TransferFunction</b> instead and model a PI SISO system with parameters</p><p>b = {k*T, k}, a = {T, 0}. </p>
<p><span style=\"font-family: Courier New;\">Example:</span></p>
<p><br><span style=\"font-family: Courier New;\">   parameter: k = 0.3,  T = 0.4</span></p>
<p><br><span style=\"font-family: Courier New;\">   results in:</span></p>
<p><span style=\"font-family: Courier New;\">               0.4 s + 1</span></p>
<p><span style=\"font-family: Courier New;\">      y = 0.3 ----------- * u</span></p>
<p><span style=\"font-family: Courier New;\">                 0.4 s</span> </p>
<p>It might be difficult to initialize the PI component in steady state due to the integrator part. This is discussed in the description of package <a href=\"modelica://Modelica.Blocks.Continuous#info\">Continuous</a>. </p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
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
        Line(points={{-80.0,-80.0},{-80.0,-20.0},{60.0,80.0}}, color={0,0,127}),
        Text(
          extent={{0,6},{60,-56}},
          lineColor={192,192,192},
          textString="PI"),
        Text(
          extent={{-150,-150},{150,-110}},
          lineColor={0,0,0},
          textString="T=%T")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})));
end PI_Control_Reset_Input;
