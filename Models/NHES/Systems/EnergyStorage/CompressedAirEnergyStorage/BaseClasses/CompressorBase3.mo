within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.BaseClasses;
partial model CompressorBase3 "Gas compressor"
  extends NHES.GasTurbine.Icons.Compressor;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation(choicesAllMatching = true);
  parameter Boolean explicitIsentropicEnthalpy=true
    "isentropicEnthalpy function used";
  parameter SI.PerUnit eta_mech=0.98 "mechanical efficiency";
  parameter Medium.AbsolutePressure pstart_in "inlet start pressure"
    annotation (Dialog(tab="Initialisation"));
  parameter Medium.AbsolutePressure pstart_out "outlet start pressure"
    annotation (Dialog(tab="Initialisation"));
  parameter Medium.Temperature Tdes_in "inlet design temperature";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction"
  annotation(Evaluate=true);
  outer Modelica.Fluid.System system "System wide properties";
  parameter Medium.Temperature Tstart_in=Tdes_in "inlet start temperature"
                              annotation (Dialog(tab="Initialisation"));
  parameter Medium.Temperature Tstart_out "outlet start temperature"
                               annotation (Dialog(tab="Initialisation"));
  parameter Medium.MassFraction Xstart[Medium.nX]=Medium.reference_X
    "start gas composition" annotation (Dialog(tab="Initialisation"));
  Medium.BaseProperties gas_in(
    p(start=pstart_in),
    T(start=Tstart_in),
    Xi(start=Xstart[1:Medium.nXi]));
  Medium.BaseProperties gas_iso(
    p(start=pstart_out),
    T(start=Tstart_out),
    Xi(start=Xstart[1:Medium.nXi]));
  Medium.SpecificEnthalpy hout_iso "Outlet isentropic enthalpy";
  Medium.SpecificEnthalpy hout "Outlet enthaply";
  Medium.SpecificEntropy s_in "Inlet specific entropy";
  Medium.AbsolutePressure pout(start=pstart_out) "Outlet pressure";

  Medium.MassFlowRate w "Gas flow rate";
  SI.Angle phi "shaft rotation angle";
  SI.AngularVelocity omega "shaft angular velocity";
  SI.Torque tau "net torque acting on the compressor";
  SI.Power CompPower;

  parameter SI.PerUnit eta = 0.9 "isentropic efficiency";
  SI.PerUnit PR "pressure ratio";

  Modelica.Fluid.Interfaces.FluidPort_a
                          inlet(redeclare package Medium = Medium, m_flow(min=if allowFlowReversal
           then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-100,60},{-60,100}}, rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_b
                          outlet(redeclare package Medium = Medium, m_flow(max=if allowFlowReversal
           then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{60,60},{100,100}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (
      Placement(transformation(extent={{-72,-12},{-48,12}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (
      Placement(transformation(extent={{48,-12},{72,12}}, rotation=0)));

equation
  w = inlet.m_flow;
  assert(w >= 0, "The compressor model does not support flow reversal");
  inlet.m_flow + outlet.m_flow = 0 "Mass balance";

  // Set inlet gas properties
  gas_in.p = inlet.p;
  gas_in.h = inStream(inlet.h_outflow);
  gas_in.Xi = inStream(inlet.Xi_outflow);

  // Set outlet gas properties
  outlet.p = pout;
  outlet.h_outflow = hout;
  outlet.Xi_outflow = gas_in.Xi;

  // Equations for reverse flow (not used)
  inlet.h_outflow = inStream(outlet.h_outflow);
  inlet.Xi_outflow = inStream(outlet.Xi_outflow);

  // Component mass balances
  gas_iso.Xi = gas_in.Xi;

  if explicitIsentropicEnthalpy then
    hout_iso = Medium.isentropicEnthalpy(outlet.p, gas_in.state)
      "Approximated isentropic enthalpy";
    hout - gas_in.h = 1/eta*(hout_iso - gas_in.h);
    // dummy assignments
    s_in = 0;
    gas_iso.p = 1e5;
    gas_iso.T = 300;
  else
    // Properties of the gas after isentropic transformation
    gas_iso.p = pout;
    s_in = Medium.specificEntropy(gas_in.state);
    s_in = Medium.specificEntropy(gas_iso.state);
    hout - gas_in.h = 1/eta*(gas_iso.h - gas_in.h);
    // dummy assignment
    hout_iso = 0;
  end if;

  w*(hout - gas_in.h) = tau*omega*eta_mech "Energy balance";
  PR = pout/gas_in.p "Pressure ratio";
  CompPower = w*(hout - gas_in.h);

  // Mechanical boundary conditions
  shaft_a.phi = phi;
  shaft_b.phi = phi;
  shaft_a.tau + shaft_b.tau = tau;
  der(phi) = omega;
  annotation (
    Documentation(info="<html>
<p>This is the base model for a compressor, including the interface and all equations except the actual computation of the performance characteristics. Reverse flow conditions are not supported.</p>
<p>This model does not include any shaft inertia by itself; if that is needed, connect a Modelica.Mechanics.Rotational.Inertia model to one of the shaft connectors.</p>
<p>As a base-model, it can be used both for axial and centrifugal compressors.
<p><b>Modelling options</b></p>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package. In the case of multiple component, variable composition gases, the start composition is given by <tt>Xstart</tt>, whose default value is <tt>Medium.reference_X</tt>.
<p>The following options are available to calculate the enthalpy of the outgoing gas:
<ul><li><tt>explicitIsentropicEnthalpy = true</tt>: the isentropic enthalpy <tt>hout_iso</tt> is calculated by the <tt>Medium.isentropicEnthalpy</tt> function. <li><tt>explicitIsentropicEnthalpy = false</tt>: the isentropic enthalpy is obtained by equating the specific entropy of the inlet gas <tt>gas_in</tt> and of a fictitious gas state <tt>gas_iso</tt>, with the same pressure of the outgoing gas; both are computed with the function <tt>Medium.specificEntropy</tt>.</pp></ul>
</html>",
        revisions="<html>
<ul>
<li><i>13 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Medium.BaseProperties <tt>gas_out</tt>removed.</li>
</li>
<li><i>14 Jan 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<br> Compressor model restructured using inheritance.
</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"), Diagram(graphics),
    Icon(graphics={Text(
          extent={{-128,-60},{128,-100}},
          lineColor={0,0,255},
          textString="%name")}));
end CompressorBase3;
