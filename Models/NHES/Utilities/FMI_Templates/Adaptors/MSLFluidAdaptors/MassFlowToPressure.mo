within NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors;
model MassFlowToPressure "Massflow to pressure adaptor"
  extends Utilities.Icons.Adaptor2;

  // Medium
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Fluid model" annotation (choicesAllMatching);
  parameter Modelica.Units.SI.AbsolutePressure p_atm=100000
    "Atmospheric pressure";
  // Port
  Modelica.Fluid.Interfaces.FluidPort fluidPort(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  // Real inputs
  Modelica.Blocks.Interfaces.RealInput m_flow_in(quantity="MassFlowRate")
    "Prescribed mass flow rate [kg/s]" annotation (Placement(transformation(
        origin={120,240},
        extent={{-20,-20},{20,20}},
        rotation=180)));
  Modelica.Blocks.Interfaces.RealInput h_in(quantity="SpecificEnthalpy") "Prescribed specific enthalpy"
    annotation (Placement(transformation(
        origin={120,180},
        extent={{-20,-20},{20,20}},
        rotation=180)));
  Modelica.Blocks.Interfaces.RealInput[Medium.nXi] X_in(quantity="MassFraction")
    "Prescribed composition" annotation (Placement(transformation(
        origin={120,120},
        extent={{-20,-20},{20,20}},
        rotation=180)));
  Modelica.Blocks.Interfaces.RealInput[Medium.nC] C_in "Prescribed trace composition" annotation (
      Placement(transformation(
        origin={120,60},
        extent={{-20,-20},{20,20}},
        rotation=180)));

  // Real outputs
  Modelica.Blocks.Interfaces.RealOutput h_out(quantity="SpecificEnthalpy") annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-120})));
  Modelica.Blocks.Interfaces.RealOutput p_out(quantity="Pressure") annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-60})));
  Modelica.Blocks.Interfaces.RealOutput[Medium.nXi] X_out(quantity="MassFraction") annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-180})));
  Modelica.Blocks.Interfaces.RealOutput[Medium.nC] C_out annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-240})));

  /* Enabling unit conversion */
  // Conversion for input mass flow rate
//   replaceable function massFlowRateUnit =
//       Adaptors.UnitConversion.Inputs.MassFlowRate.Kilogram_per_second constrainedby
//     Adaptors.UnitConversion.Subsets.MassFlowRateInput "Define unit of input mass flow rate"
   // annotation (choicesAllMatching=true, Dialog(group="Define unit of inputs"));

  // Conversion for output pressure
 // replaceable function pressureUnit = Adaptors.UnitConversion.Outputs.Pressure.Pa_absolute
   // constrainedby Adaptors.UnitConversion.Subsets.PressureOutput(final p_atm=p_atm)
  //  "Define unit of output pressure" annotation (choicesAllMatching=true, Dialog(group="Define unit of outputs"));

  /* Defining enthalpy offset parameter */
  parameter Modelica.Units.SI.SpecificEnthalpy h0_causal=0
    "Specific Enthalpy offset from causal side"
    annotation (Dialog(group="Enthalpy Offset"));
  parameter Modelica.Units.SI.SpecificEnthalpy h0_acausal=0
    "Specific Enthalpy offset on acausal side"
    annotation (Dialog(group="Enthalpy Offset"));

  /* Defining additional variables - protected */
protected
  Modelica.Units.SI.AbsolutePressure p_abs
    "Absolute pressure, used for all property calculations";
  Medium.ThermodynamicState state_acausalPort "State from acausal inputs";
  Medium.ThermodynamicState state_causalPort "State from causal inputs";

  // Enthalpy offset
  final parameter Modelica.Units.SI.SpecificEnthalpy h0=(h0_acausal - h0_causal);

equation

  /* Absolute pressure equated to port pressure*/
  p_abs = fluidPort.p;

  /* Setting the flow at the port to the one specified on the mass flow input */
  fluidPort.m_flow = -(m_flow_in);//massFlowRateUnit(m_flow_in);

  /* Parametrizing the thermodynamic state record with pressure, specific enthalpy and mass fraction*/
  state_causalPort = Medium.setState_phX(
    (p_abs),
    h_in + h0,
    X_in);  //pressureUnit(p_abs),

  /* Setting the outflow specific enthalpy based on the thermodynamic state record - state_causalPort*/
  fluidPort.h_outflow = Medium.specificEnthalpy(state_causalPort);

  /* Setting the mass fraction at the port to the one specified on the mass fraction input */
  fluidPort.Xi_outflow = X_in;

  /* Setting the extra property at the port to the one specified on the extra property input */
  fluidPort.C_outflow = C_in;

  /* Output pressure is the absolute pressure */
  p_out = (p_abs);//pressureUnit(p_abs);

  /* Parametrizing the thermodynamic state record with pressure, specific enthalpy and mass fraction*/
  state_acausalPort = Medium.setState_phX(
    (p_abs),
    inStream(fluidPort.h_outflow) - h0,
    inStream(fluidPort.Xi_outflow));
            //pressureUnit(p_abs),

  /* Setting the output fluid specific enthalpy based on thermodynamic state record - state_acausalPort*/
  h_out = Medium.specificEnthalpy(state_acausalPort);

  /* Output mass fraction is the instream mass fraction*/
  X_out = inStream(fluidPort.Xi_outflow);

  /* Output extra property is the instream extra property*/
  C_out = inStream(fluidPort.C_outflow);

  annotation (
    preferredView="info",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-260},{100,260}}), graphics={
        Text(
          extent={{-90,-266},{70,-294}},
          lineColor={0,0,127},
          textString="%name"),
        Text(
          extent={{-83,253},{63,227}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="m_flow_in"),
        Text(
          extent={{-83,193},{63,167}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="h_in"),
        Text(
          extent={{-83,133},{63,107}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="X_in"),
        Text(
          extent={{-83,73},{63,47}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="C_in"),
        Text(
          extent={{-83,-227},{63,-253}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="C_out"),
        Text(
          extent={{-83,-47},{63,-73}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="p_out"),
        Text(
          extent={{-83,-107},{63,-133}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="h_out"),
        Text(
          extent={{-83,-167},{63,-193}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="X_out"),
        Line(
          points={{58,-60},{140,-60}},
          color={2,0,127},
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{58,-120},{140,-120}},
          color={2,0,127},
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{58,-180},{138,-180}},
          color={2,0,127},
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{58,-240},{138,-240}},
          color={2,0,127},
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{60,240},{142,240}},
          color={2,0,127},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{60,180},{142,180}},
          color={2,0,127},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{60,120},{140,120}},
          color={2,0,127},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{60,60},{140,60}},
          color={2,0,127},
          arrow={Arrow.Filled,Arrow.None})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-260},{100,260}})),
    Documentation(info="<html>
<p>This component models acausal to causal adaptor. This component preferably has to be connected to a volume port.</p>
<h4>Inputs:</h4>
<ul>
<li>Causal Mass flow rate</li>
<li>Upstream specific enthalpy from the causal side</li>
<li>Upstream MassFraction from the causal side</li>
<li>Upstream Trace composition from the causal side</li>
</ul>
<h4>Outputs:</h4>
<ul>
<li>Pressure at the interface</li>
<li>Upstream specific enthalpy from the acausal side</li>
<li>Upstream MassFraction from the acausal side</li>
<li>Upstream Trace composition from the acausal side</li>
</ul>
<h4>Unit Conversion</h4>
<p>It is possible to select the units of causal inputs and outputs, in the parameter dialog. This is performed through the parameters <span style=\"font-family: Courier New;\">pressureUnit</span> and <span style=\"font-family: Courier New;\">massFlowRateUnit</span>. Default selection is SI units at the causal interfaces.</p>
<p><i>Note: acausal connectors in Modelon libraries are always using SI units.</i></p>
<h5>Example</h5>
<p>For converting input mass flow rate unit from lbm/s to kg/s, choose <span style=\"font-family: Courier New;\">&quot;Mass flow rate in lbm/s&quot;</span> parameter, from the drop-down list.</p>
<p><img src=\"modelica://Adaptors/Resources/Images/MassflowToPressure_enthalpy.png\"/></p>
</html>", revisions="<html>
<!--COPYRIGHT-->
</html>"));
end MassFlowToPressure;
