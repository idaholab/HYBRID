within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine;
model Turbine_Physical
  Modelica.Mechanics.Rotational.Interfaces.Flange_a Generator_torque
    annotation (Placement(transformation(extent={{90,48},{110,68}}),
        iconTransformation(extent={{90,48},{110,68}})));
  parameter Integer nSt = 10 "Number of ROTOR stages this model will be connected to";
  parameter Modelica.Units.SI.MomentOfInertia I_turb=1000 "Moment of inertia of the entire turbine";
  parameter Modelica.Units.SI.AngularVelocity om_start=3600*60/(2*3.14159) "Initial rotational speed";
  Modelica.Units.SI.AngularVelocity om(start=om_start) "Rotational speed of turbine";
  Modelica.Units.SI.Torque torq_int[nSt] "Internal torque vector";
  Modelica.Units.SI.Torque total_torque_fluid "Sum of internal torque vector";
  Modelica.Units.SI.Angle phi(start=0) "Initial angle, required for Flange_a port to the generator";
  Modelica.Units.SI.Power P_turb "Turbine power";

  BaseClasses.Torque Fluidtorques[nSt]
    annotation (Placement(transformation(extent={{-14,-42},{6,-22}})));

equation
  for i in 1:nSt loop
    Fluidtorques[i].w = om;
    Fluidtorques[i].tau = torq_int[i];
  end for;
  der(om)*I_turb = total_torque_fluid + Generator_torque.tau;
  total_torque_fluid = sum(torq_int);
  phi = Generator_torque.phi;
  der(phi) = om;
  P_turb = total_torque_fluid*om;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(
          points={{-100,38},{-100,-22},{100,-42},{100,78},{-100,38}},
          lineColor={28,108,200},
          fillColor={181,181,181},
          fillPattern=FillPattern.Solid), Text(
          extent={{32,86},{112,34}},
          lineColor={244,125,35},
          fillColor={181,181,181},
          fillPattern=FillPattern.None,
          textString="e-")}),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Polygon(
          points={{-100,40},{-100,-20},{100,-40},{100,80},{-100,40}},
          lineColor={28,108,200},
          fillColor={181,181,181},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>The physical turbine model connects to rotor stage components via the torque port. It also connects to the generator via a torque port. The turbine itself maintains a rotational speed omega, and a torque equation is applied on the turbine to determine that rotational speed. The main turbine parameters are the number of torque ports (should equal the number of rotor stages) and the moment of inertia of the turbine. </p>
</html>"));
end Turbine_Physical;
