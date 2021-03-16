within NHES.Electrolysis.Turbine.BaseClasses;
partial model TurbineBase_HTSE "Turbine"
  extends Electrolysis.Icons.Turbine;

  outer Modelica.Fluid.System system "System wide properties";
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation(choicesAllMatching = true,Dialog(tab="General", group="Working fluid"));

  parameter Boolean allowFlowReversal=system.allowFlowReversal
   "= true to allow flow reversal, false restricts to design direction" annotation(Dialog(tab="General", group="Turbine"));
  parameter Boolean explicitIsentropicEnthalpy=true
   "IsentropicEnthalpy function used" annotation(Dialog(tab="General", group="Turbine"));

  parameter SI.Pressure pstart_in "Inlet start pressure"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.Pressure pstart_out = 1.01325*1e5 "Outlet start pressure"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature Tstart_in "Inlet start temperature"
                              annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature Tstart_out "Outlet start temperature"
                               annotation (Dialog(tab="Initialisation"));
  parameter SI.MassFraction Xstart[Medium.nX]=Medium.reference_X
   "Start gas composition"  annotation (Dialog(tab="Initialisation"));

  Medium.BaseProperties gas_in(
    p(start=pstart_in),
    T(start=Tstart_in),
    Xi(start=Xstart[1:Medium.nXi]));
  Medium.BaseProperties gas_iso(
    p(start=pstart_out),
    T(start=Tstart_out),
    Xi(start=Xstart[1:Medium.nXi]));

  Medium.ThermodynamicState state_gas_out "State of the output gas";
  Medium.SpecificEntropy s_in "Inlet specific entropy";
  Medium.SpecificEnthalpy hout_iso "Outlet isentropic enthalpy";
  Medium.SpecificEnthalpy hout "Outlet enthalpy";
  Medium.AbsolutePressure pin(start=pstart_in) "Turbine inlet pressure";
  Medium.AbsolutePressure pout(start=pstart_out)
   "Turbine outlet pressure";
  SI.Temperature Tf "Turbine firing temperature";
  SI.Temperature Te "Turbine exhaust gas temperature";

  Modelica.Units.SI.MassFlowRate w "Gas flow rate";
  SI.Power Wt(min=0,displayUnit="MW")
   "Produced (mechanical) power from a turbine";
  Real eta_mech(min=0,max=1) "Mechanical efficiency";
  Real eta "Isentropic efficiency";
  Real PR "Pressure ratio";

  Modelica.Fluid.Interfaces.FluidPort_a
          inlet(redeclare package Medium = Medium, m_flow(min=if
          allowFlowReversal then -Modelica.Constants.inf else 0)) annotation (
     Placement(transformation(extent={{-70,70},{-50,90}},   rotation=0),
        iconTransformation(extent={{-70,70},{-50,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b
          outlet(redeclare package Medium = Medium, m_flow(max=if
          allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (
     Placement(transformation(extent={{50,70},{70,90}},   rotation=0),
        iconTransformation(extent={{50,70},{70,90}})));

equation
  w = inlet.m_flow;
  assert(w >= 0, "The turbine model does not support flow reversal");
  inlet.m_flow + outlet.m_flow = 0 "Mass balance";

  // Set inlet gas properties
  gas_in.p = inlet.p;
  gas_in.h = inStream(inlet.h_outflow);
  gas_in.Xi = inStream(inlet.Xi_outflow);

  // Set outlet gas properties
  outlet.p = pout;
  outlet.h_outflow = hout;
  outlet.Xi_outflow = gas_in.Xi;
  state_gas_out = Medium.setState_phX(pout, outlet.h_outflow, outlet.Xi_outflow);

  // Equations for reverse flow (not used)
  inlet.h_outflow = inStream(outlet.h_outflow);
  inlet.Xi_outflow = inStream(outlet.Xi_outflow);

  // Component mass balances
  gas_iso.Xi = gas_in.Xi;

  if explicitIsentropicEnthalpy then
    hout_iso = Medium.isentropicEnthalpy(outlet.p, gas_in.state)
     "Approximated isentropic enthalpy";
    hout - gas_in.h = eta*(hout_iso - gas_in.h) "Enthalpy change";
    //Dummy assignments
    s_in = 0;
    gas_iso.p = 1e5;
    gas_iso.T = 300;
  else
    // Properties of the gas after isentropic transformation
    gas_iso.p = pout;
    s_in = Medium.specificEntropy(gas_in.state);
    s_in = Medium.specificEntropy(gas_iso.state);
    hout - gas_in.h = eta*(gas_iso.h - gas_in.h) "Enthalpy change";
    //Dummy assignment
    hout_iso = 0;
  end if;

  pin = inlet.p;
  Tf = gas_in.T;
  Te = Medium.temperature(state_gas_out);

  Wt = eta_mech*w*(gas_in.h - hout);
  PR = gas_in.p/pout "Pressure ratio";

  annotation (
    Documentation(info="<html>
<p>This is the base model for a turbine, including the interface and all equations. Reverse flow conditions are not supported.</p>
<p>This model does not include any shaft inertia by itself; if that is needed, connect a Modelica.Mechanics.Rotational.Inertia model to one of the shaft connectors.</p>
<p>As a base-model, it can be used both for axial and radial turbines.
<p><b>Modelling options</b></p>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package. In the case of multiple component, variable composition gases, the start composition is given by <tt>Xstart</tt>, whose default value is <tt>Medium.reference_X</tt>.
<p>The following options are available to calculate the enthalpy of the outgoing gas:
<ul><li><tt>explicitIsentropicEnthalpy = true</tt>: the isentropic enthalpy <tt>hout_iso</tt> is calculated by the <tt>Medium.isentropicEnthalpy</tt> function. <li><tt>explicitIsentropicEnthalpy = false</tt>: the isentropic enthalpy is determined by equating the specific entropy of the inlet gas <tt>gas_in</tt> and of a fictious gas state <tt>gas_iso</tt>, with the same pressure of the outgoing gas; both are computed with the function <tt>Medium.specificEntropy</tt>.</pp></ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={Text(
          extent={{-128,-60},{128,-100}},
          lineColor={0,0,255},
          textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end TurbineBase_HTSE;
