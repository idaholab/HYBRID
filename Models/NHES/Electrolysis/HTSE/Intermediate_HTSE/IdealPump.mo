within NHES.Electrolysis.HTSE.Intermediate_HTSE;
model IdealPump "Ideal pump with a fixed pressure increase"

  import      Modelica.Units.SI;
  outer Modelica.Fluid.System system "System wide properties";
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance "Medium model"
    annotation(choicesAllMatching = true);
  parameter Boolean allowFlowReversal=system.allowFlowReversal
   "= true to allow flow reversal, false restricts to design direction";

  parameter Real eta = 0.8
     "Pump efficiency";
  parameter Real PR0 = 60.9167e5/43.1793e5 "Nominal pressure (compression) ratio";
  parameter SI.Pressure pstart_in = pstart_out/PR0 "Inlet start pressure"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.Pressure pstart_out = 60.9167e5 "Outlet start pressure"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature Tstart = 215.143 + 273.15
    "Start temperature [K]" annotation (Dialog(tab="Initialisation"));
  parameter SI.MassFlowRate wstart = 9.0942
    "Start value of mass flow rate of the medium[kg/s]" annotation (Dialog(tab="Initialisation"));

  final parameter SI.SpecificEnthalpy hstart_in = Modelica.Media.Water.IF97_Utilities.h_pT(pstart_in, Tstart)
    "Start value of inlet specific enthalpy [J/kg]";
  final parameter SI.SpecificEnthalpy hstart_out = Modelica.Media.Water.IF97_Utilities.h_pT(pstart_out, Tstart)
    "Start value of outlet specific enthalpy [J/kg]";
  final parameter Medium.ThermodynamicState stateStart_in = Medium.setState_ph(pstart_in, hstart_in);
  final parameter SI.Density rho_start = Medium.density(stateStart_in) "Start value of the medium density";

  Medium.ThermodynamicState state_in(p(start=pstart_in),T(start=Tstart)) "State of the medium at the inlet";
  Medium.ThermodynamicState state_out(p(start=pstart_out),T(start=Tstart)) "State of the medium at the outlet";
  Medium.AbsolutePressure pout(min = 0, start=pstart_out) "Pump outlet pressure";
  Medium.AbsolutePressure pin(min = 0, start=pstart_in) "Pump inlet pressure";
  Medium.SpecificEnthalpy hin(min = 0, start=hstart_in) "Inlet specific enthaply";
  Medium.SpecificEnthalpy hout(min = 0, start=hstart_out) "Outlet specific enthaply";

  SI.Density rho( min = 0, start = Medium.density(stateStart_in))
    "Density of the medium [kg/m3]";
  SI.VolumeFlowRate q(start=wstart/rho_start)
    "Volumetric flow rate [m3/s]";
  SI.MassFlowRate w(min=0) "Mass flow rate [kg/s]";

  Real PR "Pressure (compression) ratio";
  SI.Power W(min=0, displayUnit="MW")
   "Power requirement to drive a pump";

  Modelica.Fluid.Interfaces.FluidPort_b
                            outlet(redeclare package Medium = Medium, m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a inlet(redeclare package Medium = Medium,
      m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0), iconTransformation(extent={{-110,-10},{-90,10}})));
equation
  // ----------- Fluid properties ----------------------------------------------
  state_in  = Medium.setState_ph(pin, inStream(inlet.h_outflow));
  state_out = Medium.setState_ph(pout, outlet.h_outflow);

  rho = Medium.density(state_in);

  // ---------- Boundary conditions --------------------------------------------
  w = inlet.m_flow;
  assert(w >= 0, "The ideal pump model does not support flow reversal");
  pin = inlet.p;
  pout = outlet.p;
  hin = inStream(inlet.h_outflow);
  hout = outlet.h_outflow;

  // Equation for reverse flow (not used)
  inlet.h_outflow = inStream(outlet.h_outflow);

  // Flow equation
  q = w/rho;

  // Power consumption
  W = (pout - pin)*q/eta;

  // Pressure increase across the pump
  PR = PR0;
  PR = pout/inlet.p;

  // ----- Mass balances ------
  inlet.m_flow + outlet.m_flow = 0;

  // Energy balance
  W = w*(hout - hin);

  annotation (defaultComponentName="idealPump",
    Icon(graphics={
        Ellipse(
          extent={{90,25},{110,-25}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          visible=port_b_exposesState),
          Text(extent={{-100,-116},{100,-148}},
            lineColor={0,0,255},
            textString="%name"),
          Rectangle(
            extent={{-100,46},{100,-46}},
            lineColor={0,0,0},
            fillColor={0,127,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Polygon(
            points={{-48,-60},{-72,-100},{72,-100},{48,-60},{-48,-60}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder),
          Ellipse(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,100,199}),
          Polygon(
            points={{-28,30},{-28,-30},{50,-2},{-28,30}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={255,255,255})}),
    Documentation(info="<HTML>
<p></p>
</HTML>",
        revisions="<html>
</html>
"));
end IdealPump;
