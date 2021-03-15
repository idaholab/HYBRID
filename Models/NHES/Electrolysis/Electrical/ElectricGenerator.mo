within NHES.Electrolysis.Electrical;
model ElectricGenerator "Active power generator"

  parameter Real eta(unit = "1", min = 0, max=1)=1 "Generator efficiency";
  parameter SI.MomentOfInertia J=0 "Moment of inertia";
  parameter Integer Np = 2 "Number of electrical poles";
  parameter SI.Frequency fstart = 60
    "Start value of the electrical frequency"
    annotation (Dialog(tab="Initialization"));
  final parameter SI.AngularVelocity omega_m_start = Modelica.Units.Conversions.from_rpm(  fstart*120/Np)
    "Start value of the angular velocity at shaft";
  parameter Electrolysis.Utilities.OptionsInit.Temp initOpt=
      Electrolysis.Utilities.OptionsInit.noInit "Initialization option"
    annotation (Dialog(tab="Initialization"));

  SI.Power Pm "Mechanical power";
  SI.Power Pe "Electrical Power";
  SI.Power Ploss "Inertial power loss";
  SI.Torque tau "Torque at shaft";
  SI.AngularVelocity omega_m(start=omega_m_start)
    "Angular velocity of the shaft";
  Modelica.Units.NonSI.AngularVelocity_rpm Nrpm
    "Rotational speed of the shaft in rpm";
  SI.Frequency f "Electrical frequency";

  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (Placement(
        transformation(extent={{-94,-14},{-66,14}}, rotation=0),
        iconTransformation(extent={{-90,-10},{-70,10}})));
  Electrolysis.Interfaces.ElectricalPowerPort_b powerGeneration annotation (
     Placement(transformation(extent={{66,-14},{94,14}}, rotation=0),
        iconTransformation(extent={{70,-10},{90,10}})));

equation
  Nrpm =Modelica.Units.Conversions.to_rpm(omega_m);
  f = Np*Nrpm/120;
  Pm = omega_m*tau;

  if J > 0 then
    Ploss = J*der(omega_m)*omega_m;
  else
    Ploss = 0;
  end if annotation (Diagram);
  Pm = Pe/eta + Ploss "Energy balance";

  // ----- Boundary conditions -----
  omega_m = der(shaft.phi);
  f = powerGeneration.f;
  Pe = -powerGeneration.W;
  tau = shaft.tau;

initial equation
  if initOpt == Electrolysis.Utilities.OptionsInit.noInit then
    // Do nothing
  elseif initOpt == Electrolysis.Utilities.OptionsInit.steadyState then
    der(omega_m) = 0;
  else
    assert(false, "Unsupported initialization option");
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={Rectangle(
              extent={{-80,8},{-48,-8}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),Ellipse(
              extent={{50,-50},{-50,50}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(points={{50,0},{70,0}},
            color={255,0,0},
          thickness=0.5),Text(
              extent={{-26,26},{28,-26}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="G"),
                   Text(
          extent={{-128,102},{128,62}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>This model describes the conversion between mechanical power and electrical power in an ideal synchronous generator.
<p>It is possible to consider the generator inertia in the model, by setting the parameter <tt>J > 0</tt>. 
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end ElectricGenerator;
