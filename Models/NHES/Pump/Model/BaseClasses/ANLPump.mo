within NHES.Pump.Model.BaseClasses;
model ANLPump "Centrifugal pump with ideally controlled speed"
  extends ANLPumpBase;
  import Modelica.Units.NonSI.*;
  parameter AngularVelocity_rpm n_const=n0 "Constant rotational speed";
  parameter Real ND_const=ND0 "nominal ND^3";
  parameter Real NDg_const=NDg0 "nominal N^2D2/q";
  Modelica.Blocks.Interfaces.RealInput in_n "RPM" annotation (Placement(
        transformation(
        origin={-26,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  n = in_n "Rotational speed";
  if cardinality(in_n) == 0 then
    in_n = n_const "Rotational speed provided by parameter";
  end if;
  annotation (
    Icon(graphics={Text(extent={{-58,94},{-30,74}}, textString="n"), Text(
            extent={{-10,102},{18,82}}, textString="Np")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Documentation(info="<HTML>
<p>This model describes a centrifugal pump (or a group of <tt>Np</tt> pumps in parallel) with controlled speed, either fixed or provided by an external signal.
<p>The model extends <tt>PumpBase</tt>
<p>If the <tt>in_n</tt> input connector is wired, it provides rotational speed of the pumps (rpm); otherwise, a constant rotational speed equal to <tt>n_const</tt> (which can be different from <tt>n0</tt>) is assumed.</p>
</HTML>",
        revisions="<html>
<ul>
<li><i>5 Jul 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Model restructured by using inheritance. Adapted to Modelica.Media.</li>
<li><i>15 Jan 2004</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       <tt>ThermalCapacity</tt> and <tt>CheckValve</tt> added.</li>
<li><i>15 Dec 2003</i>
    by <a href=\"mailto:francesco.schiavo@polimi.it\">Francesco Schiavo</a>:<br>
       First release.</li>
</ul>
</html>"));
end ANLPump;
