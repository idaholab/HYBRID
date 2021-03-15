within NHES.Utilities.CharacteristicNumbers;
function PecletNumber
  "Returns Peclet number from Reynolds and Prandtl/Schmidt numbers"
  extends Modelica.Icons.Function;

  input SI.ReynoldsNumber Re "Reynolds number";
  input SI.PrandtlNumber Pr "Prandtl or Schmidt number";

  output SI.PecletNumber Pe "Peclet number";
algorithm
  Pe := Re.*Pr;

  annotation (Documentation(info="<html>
<p>The Peclet numver is defined to be the ratio of the rate of&nbsp;advection&nbsp;of a physical quantity by the flow to the rate of&nbsp;diffusion&nbsp;of the same quantity driven by an appropriate gradient.</p>
<p> In the context of species or&nbsp;mass transfer, the P&eacute;clet number is the product of the&nbsp;Reynolds number&nbsp;and the&nbsp;Schmidt number. </p>
<ul>
<li>Pe = Re*Sc</li>
</ul>
<p>In the context of the&nbsp;thermal fluids, the thermal Peclet number is equivalent to the product of the&nbsp;Reynolds number&nbsp;and the&nbsp;Prandtl number.</p>
<ul>
<li>Pe = Re*Pr</li>
</ul>
</html>"));
end PecletNumber;
