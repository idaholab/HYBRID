within NHES.Electrolysis.Sensors;
model TempSensorWithThermowell
  "Ideal one port temperature sensor with thermowell"
  extends Modelica.Fluid.Sensors.BaseClasses.PartialAbsoluteSensor;
  import Modelica.Blocks.Types.Init;

  parameter Modelica.Units.SI.Time tau(start=13) "Time constant [s]";
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3/4: initial output)"     annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real y_start "Initial or guess value of output (= state)"
    annotation (Dialog(group="Initialization"));
  Real u(final quantity="ThermodynamicTemperature",
                                           final unit="K",
                                           min = 0,
                                           displayUnit="degC")
    "Actual temperature of the passing fluid";
  Modelica.Blocks.Interfaces.RealOutput y( final quantity="ThermodynamicTemperature",
                                           final unit="K",
                                           min = 0,
                                           displayUnit="degC",
                                           start=y_start)
    "Measured temperature of the passing fluid" annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=-90,
        origin={0,120}), iconTransformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={0,90})));
initial equation
  if initType == Init.SteadyState then
    der(y) = 0;
  elseif initType == Init.InitialState or initType == Init.InitialOutput then
    y = y_start;
  end if;
equation
  u =  Medium.temperature(Medium.setState_phX(port.p, inStream(port.h_outflow), inStream(port.Xi_outflow)));
  der(y) = (1*u - y)/tau;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,-100},{100,100}})),                Icon(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                                                    graphics={                                                                                                                                                         Text(extent={{
              -134,-128},{134,-168}},                                                                                                                                                                                                        lineColor=
              {0,0,255},
          textString="%name"),                                                                                                                                                                                                        Line(points={{0,
              80},{0,30}},                                                                                                                                                                                                        color = {0, 0, 127}),
                                                                                                                                                         Ellipse(extent={{
              -20,-88},{20,-50}},                                                                                                                                                                  lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5, fillColor = {191, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              -12,30},{12,-54}},                                                                                                                                                           lineColor = {191, 0, 0}, fillColor = {191, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points={{
              -12,30},{-12,50},{-10,56},{-6,58},{0,60},{6,58},{10,56},{12,
              50},{12,30},{-12,30}},                                                                                                                                                                                                        lineColor = {0, 0, 0},
            lineThickness =                                                                                                   0.5), Line(points={{
              -12,30},{-12,-55}},                                                                                                                                          color = {0, 0, 0}, thickness = 0.5), Line(points={{
              12,30},{12,-54}},                                                                                                                                                                                                        color = {0, 0, 0}, thickness = 0.5), Line(points={{
              -40,-30},{-12,-30}},                                                                                                                                                                                                        color = {0, 0, 0}), Line(points={{
              -40,0},{-12,0}},                                                                                                                                                                                                        color = {0, 0, 0}), Line(points={{
              -40,30},{-12,30}},                                                                                                                                                                                                        color = {0, 0, 0}), Text(extent={{
              74,102},{-20,72}},                                                                                                    lineColor = {0, 0, 0}, textString = "T")}),
            Documentation(info="<html>
<p>This component monitors the temperature of the passing fluid. The sensor is ideal, i.e., it does not influence the fluid.
<p><b>Modelling options</p></b>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package.
</html>",
        revisions="<html>
<ul>
<li><i>25 Apr 2016</i>
by <a href=\"mailto:jongsuk.kim@inl.gov\">Jong Suk Kim</a>:<br>
       Adapted to Modelica.Media.</li>
       <li><i> ? ? 2016</i>
    by <a href=\"mailto:jongsuk.kim@inl.gov\">Jong Suk Kim</a>:<br>
       First release.</li>
</ul>
</html>"));
end TempSensorWithThermowell;
