within NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors;
model PressureToMassFlow "Pressure to massflow adaptor"
  extends Utilities.Icons.Adaptor2;

  // Parameter for the size of the vectorized port
  //parameter Integer N=0 "number of vector elements in connector"
  // Medium
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Fluid model" annotation (choicesAllMatching);
  parameter Modelica.Units.SI.AbsolutePressure p_atm=100000
    "Atmospheric pressure";

  // Port
  Modelica.Fluid.Interfaces.FluidPort fluidPort(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
        iconTransformation(extent={{92,-8},{112,12}})));

  // Real inputs
  Modelica.Blocks.Interfaces.RealInput[Medium.nXi] X_in(quantity="MassFraction")
    "Prescribed mass fractions" annotation (Placement(transformation(
        origin={-120,-180},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput[Medium.nC] C_in "Prescribed mass fractions" annotation (
      Placement(transformation(
        origin={-120,-240},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput p_in(quantity="Pressure") "Prescribed pressure" annotation (
      Placement(transformation(
        origin={-120,-60},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput h_in(quantity="SpecificEnthalpy") "Prescribed specific enthalpy"
    annotation (Placement(transformation(
        origin={-120,-120},
        extent={{-20,-20},{20,20}},
        rotation=0)));

  // Real outputs
  Modelica.Blocks.Interfaces.RealOutput m_flow_out(quantity="MassFlowRate") annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={-120,240})));
  Modelica.Blocks.Interfaces.RealOutput h_out(quantity="SpecificEnthalpy") annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={-120,180})));
  Modelica.Blocks.Interfaces.RealOutput[Medium.nXi] X_out(quantity="MassFraction") annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={-120,120})));
  Modelica.Blocks.Interfaces.RealOutput[Medium.nC] C_out annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={-120,60})));

  /* Enabling unit conversion */
  // Conversion for input pressure
  //replaceable function pressureUnit = Adaptors.UnitConversion.Inputs.Pressure.Pa_absolute
    //constrainedby Adaptors.UnitConversion.Subsets.PressureInput(final p_atm=p_atm)
   // "Define unit of input pressure" annotation (choicesAllMatching=true, Dialog(group="Define unit of inputs"));

  // Conversion for output mass flow rate
 // replaceable function massFlowRateUnit =
     // Adaptors.UnitConversion.Outputs.MassFlowRate.Kilogram_per_second constrainedby
   // Adaptors.UnitConversion.Subsets.MassFlowRateOutput "Define unit of output mass flow rate"
   // annotation (choicesAllMatching=true, Dialog(group="Define unit of outputs"));

  /* Defining enthalpy offset parameter */
  parameter Modelica.Units.SI.SpecificEnthalpy h0_causal=0
    "Specific Enthalpy offset from causal side"
    annotation (Dialog(group="Enthalpy Offset"));
  parameter Modelica.Units.SI.SpecificEnthalpy h0_acausal=0
    "Specific Enthalpy offset on acausal side"
    annotation (Dialog(group="Enthalpy Offset"));

  /* Defining additional variables - protected */
protected
  Modelica.Units.SI.AbsolutePressure p_in_SI=(p_in);
                                                   //pressureUnit(p_in);
  Modelica.Units.SI.AbsolutePressure p_abs(start=p_init);

  // Pressure initialization
  //  final parameter Modelica.SIunits.Pressure p_init(fixed=false);
  parameter Modelica.Units.SI.Pressure p_init=1e5;
  Medium.ThermodynamicState state_acausalPorts;
  Medium.ThermodynamicState state_causalPort "Prescribed state";

  // Enthalpy offset
  final parameter Modelica.Units.SI.SpecificEnthalpy h0=(h0_acausal - h0_causal);

// initial equation
//   p_init = p_in_SI;

equation
  /* Absolute pressure computed from specified pressure converted in absolute, SI unit */
  p_abs = p_in_SI;

  /* Parametrizing the thermodynamic state record with pressure, specific enthalpy and mass fraction*/
  state_causalPort = Medium.setState_phX(
    p_abs,
    h_in + h0,
    X_in);

  //for i in 1:N loop
    /* Setting absolute pressure to all ports */
    fluidPort.p = p_abs;

    /* Parametrizing the thermodynamic state record with pressure, specific enthalpy and mass fraction*/
    state_acausalPorts = Medium.setState_phX(
      fluidPort.p,
      inStream(fluidPort.h_outflow) - h0,
      inStream(fluidPort.Xi_outflow));

    /* Setting the outflow specific enthalpy based on thermodynamic state record - state_causalPorts*/
    fluidPort.h_outflow = Medium.specificEnthalpy(state_causalPort);

    /* Setting the outflow specific enthalpy based on thermodynamic state record - state_causalPorts*/
    h_out = Medium.specificEnthalpy(state_acausalPorts);

    /* Setting the mass fraction at the port to the one specified on the mass fraction input */
    fluidPort.Xi_outflow = X_in;

    /* Setting the extra property at the port to the one specified on the extra property input */
    fluidPort.C_outflow = C_in;

    /* Output temperatures are the one from the port */
    m_flow_out = (fluidPort.m_flow);//massFlowRateUnit(fluidPort[i].m_flow);
  //end for;
  /* Output mass fraction is the instream mass fraction*/
  X_out = inStream(fluidPort.Xi_outflow);
  /* Output extra property is the instream extra property*/
  C_out = inStream(fluidPort.C_outflow);

    annotation (Dialog(connectorSizing=true),
    preferredView="info",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-260},{100,260}}), graphics={
        Text(
          extent={{-90,-266},{70,-294}},
          lineColor={0,0,127},
          textString="%name"),
        Text(
          extent={{-73,-47},{73,-73}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="p_in"),
        Text(
          extent={{-73,-107},{73,-133}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="h_in"),
        Text(
          extent={{-73,-167},{73,-193}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="X_in"),
        Text(
          extent={{-73,-227},{73,-253}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="C_in"),
        Line(
          points={{-138,240},{-56,240}},
          color={2,0,127},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-138,180},{-56,180}},
          color={2,0,127},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-138,120},{-58,120}},
          color={2,0,127},
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-138,60},{-58,60}},
          color={2,0,127},
          arrow={Arrow.Filled,Arrow.None}),
        Text(
          extent={{-63,253},{83,227}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="m_flow_out"),
        Text(
          extent={{-73,193},{73,167}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="h_out"),
        Text(
          extent={{-73,133},{73,107}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="X_out"),
        Text(
          extent={{-73,73},{73,47}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,240,240},
          textString="C_out"),
        Line(
          points={{-140,-240},{-60,-240}},
          color={2,0,127},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-140,-180},{-60,-180}},
          color={2,0,127},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-140,-120},{-58,-120}},
          color={2,0,127},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-140,-60},{-58,-60}},
          color={2,0,127},
          arrow={Arrow.None,Arrow.Filled})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-260},{100,260}})),
    Documentation(info="<html>
<p>This component models acausal to causal adaptor. This component preferably has to be connected to a flow port.</p>
<h4>Inputs:</h4>
<ul>
<li>Pressure at the interface</li>
<li>Upstream Temperature from the causal side</li>
<li>Upstream MassFraction from the causal side</li>
<li>Upstream Trace composition from the causal side</li>
</ul>
<h4>Outputs:</h4>
<ul>
<li>Acausal Mass flow rate</li>
<li>Upstream Temperature from the acausal side</li>
<li>Upstream MassFraction from the acausal side</li>
<li>Upstream Trace composition from the acausal side</li>
</ul>
<h4>Unit Conversion</h4>
<p>It is possible to select the units of causal inputs and outputs, in the parameter dialog. This is performed through the parameters <span style=\"font-family: Courier New;\">pressureUnit</span> and <span style=\"font-family: Courier New;\">massFlowRateUnit</span>. Default selection is SI units at the causal interfaces.</p>
<p><i>Note: acausal connectors in Modelon libraries are always using SI units.</i></p>
<h5>Example</h5>
<p>For converting input pressure unit from absolute PSI to Pa, choose &quot;<span style=\"font-family: Courier New;\">Absolute Pressure in Bar&quot;</span> option for <span style=\"font-family: Courier New;\">pressureUnit</span> parameter, from the drop-down list.</p>
<p><img src=\"modelica://Adaptors/Resources/Images/PressureToMassflow_enthalpy.png\"/></p>
</html>", revisions="<html>
<!--COPYRIGHT-->
</html>"));
end PressureToMassFlow;
