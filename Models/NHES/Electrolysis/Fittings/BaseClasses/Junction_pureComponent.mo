within NHES.Electrolysis.Fittings.BaseClasses;
model Junction_pureComponent "Junction: one input to one output"
  import      Modelica.Units.SI;

  // ---------- Fluid package -------------------------------------------------_
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance
    "Working fluid model in shell side of a heat exchanger" annotation (choicesAllMatching = true);

  // ---------- Define parameters ----------------------------------------------
  parameter SI.Pressure p_start = 2.045*1e6
    "Start value of pressure [Pa]"                                         annotation(Dialog(tab = "Initialisation"));
  parameter SI.Temperature T_start=Modelica.Units.Conversions.from_degC(283.4)
    annotation (Dialog(tab="Initialisation"));

  final parameter SI.SpecificEnthalpy h_start=
      Modelica.Media.Water.IF97_Utilities.h_pT(p_start,T_start)
    "Start value of specific enthalpy [J/kg]";

  parameter Modelica.Units.SI.Volume V=0.001 "Internal volume";
  parameter Modelica.Units.SI.HeatCapacity C=0
    "Additional heat capacity (e.g., of vessel)";

  SI.MassFlowRate w_in(min=0) "Inlet mass flow rate [kg/s]";
  SI.MassFlowRate w_out(min=0) "Outlet mass flow rate [kg/s]";

  Medium.SpecificEnthalpy h_in(start = h_start)
    "Specific enthalpy of entering fluid";
  Medium.SpecificEnthalpy h_out(start = h_start)
    "Specific enthalpy of outgoing fluid";

  Medium.BaseProperties fluid(p(start = p_start), h(start = h_start))
    "Fluid properties";
  Medium.AbsolutePressure p "Fluid pressure";
  Medium.SpecificEnthalpy h(start = h_start) "Fluid specific enthalpy";
  Modelica.Units.SI.Mass M "Fluid mass";
  Modelica.Units.SI.Temperature T(start=T_start) "Temperature";
  Modelica.Units.SI.Energy U "Internal energy";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(h_outflow(start=h_start),
      redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{-90,-10},{-70,10}}),  iconTransformation(extent={{-90,-10},{-70,
            10}})));
  Modelica.Fluid.Interfaces.FluidPort_b
                     port_b(h_outflow(start=h_start),
                     redeclare package Medium = Medium) annotation(Placement(transformation(extent={{70,-10},
            {90,10}}),                                                                                                    iconTransformation(extent={{70,-10},
            {90,10}})));

protected
  final parameter Boolean excludeEnthalpyOfFormation = true;

equation
  // ----------- Fluid properties ----------------------------------------------
  fluid.p = p;
  T = fluid.T;
  fluid.h = h;

  M = fluid.d*V;
  U = M*fluid.u;

  // Boundary conditions
  w_in = port_a.m_flow;
  assert(w_in >= 0, "Flow reversal is not supported");
  -w_out = port_b.m_flow;
  assert(w_out >= 0, "Flow reversal is not supported");

  h_in = inStream(port_a.h_outflow);
  h_out = port_b.h_outflow;

  h = port_b.h_outflow;

  // Equations for reverse flow (not used)
  port_a.h_outflow = inStream(port_b.h_outflow);

  // Pressure drops
  port_a.p = p;
  port_b.p = p;

  // Mass balances
  der(M) = w_in - w_out;

  // Energy balance (steady state)
  der(U) = h_in*w_in - h_out*w_out;

initial equation
  //der(M) = 0;
  der(U) = 0;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,   extent={{-100,-100},
            {100,100}}),                                                                              graphics={  Ellipse(extent={{
              -80,80},{80,-80}},                                                                                                    lineColor = {0, 0, 255}, startAngle = 0, endAngle = 360, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}})),                                                                                                    Documentation(info = "<HTML>

</HTML>"),
       Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-60, 20}, {60, -60}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 255}, fillPattern = FillPattern.VerticalCylinder)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end Junction_pureComponent;
