within NHES.Electrolysis.Fittings.BaseClasses;
model Junction_anodeStream "Junction: one input to one output"
  import      Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid package -------------------------------------------------_
  replaceable package Medium =
      Electrolysis.Media.Electrolysis.CathodeGas constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model"
                   annotation (choicesAllMatching = true);

  // ---------- Define constants -----------------------------------------------
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataH2=gasProperties.H2;
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataH2O=gasProperties.H2O;
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataO2=gasProperties.O2;
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataN2=gasProperties.N2;
  constant SI.MolarMass mwH2O = gasProperties.H2O.MM
    "Molecular weight of steam [kg/mol]";
  constant SI.MolarMass mwH2 = gasProperties.H2.MM
    "Molecular weight of hydrogen [kg/mol]";
  constant SI.MolarMass mwO2 = gasProperties.O2.MM
    "Molecular weight of oxygen [kg/mol]";
  constant SI.MolarMass mwN2 = gasProperties.N2.MM
    "Molecular weight of nitrogen [kg/mol]";

  // ---------- Define parameters ----------------------------------------------
  parameter SI.Pressure p_start = 2.045*1e6
    "Start value of pressure [Pa]"                                         annotation(Dialog(tab = "Initialisation"));
  parameter SI.Temperature T_start=Modelica.Units.Conversions.from_degC(283.4)
    annotation (Dialog(tab="Initialisation"));
  parameter SI.MoleFraction yO2_start = 0.21
    "Start value of O2 mole fraction in a pipe" annotation (Dialog(tab="Initialisation"));
  final parameter SI.MoleFraction y_start[:]={1 - yO2_start,yO2_start} "Start value of mole fractions {N2, O2}";
  final parameter SI.MassFraction X_start[:]=
      Electrolysis.Utilities.moleToMassFractions(y_start, {mwN2*1000,
      mwO2*1000}) "Start value of mass fractions {H2, H2O}";

  final parameter SI.SpecificEnthalpy h_start=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataN2,
      T_start,
      excludeEnthalpyOfFormation)*X_start[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataO2,
      T_start,
      excludeEnthalpyOfFormation)*X_start[2]
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

  Medium.MassFraction X_in[Medium.nX](min = {0,0}, max = {1,1}, start = X_start)
    "Inlet mass fractions";
  Medium.MassFraction X_out[Medium.nX](min = {0,0}, max = {1,1}, start = X_start)
    "Outlet mass fractions";

  Medium.BaseProperties fluid(p(start = p_start), X(start = X_start), h(start = h_start))
    "Fluid properties";
  Medium.AbsolutePressure p "Fluid pressure";
  Medium.SpecificEnthalpy h(start = h_start) "Fluid specific enthalpy";
  Modelica.Units.SI.Mass M "Fluid mass";
  Modelica.Units.SI.Temperature T(start=T_start) "Temperature";
  Modelica.Units.SI.Energy U "Internal energy";
  Modelica.Units.SI.MassFraction X[Medium.nX](
    min={0,0},
    max={1,1},
    start=X_start) "Internal mass fraction";

 // ----- Initial states -----
  //final parameter Medium.ThermodynamicState state_start = Medium.setState_phX(p_start, h_start, X_start);

  // ----- Current states -----
  //Medium.ThermodynamicState state;

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
  //state = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));

  fluid.p = p;
  T = fluid.T;
  fluid.h = h;
  X = fluid.X;

  M = fluid.d*V;
  U = M*fluid.u;

  // Boundary conditions
  w_in = port_a.m_flow;
  assert(w_in >= 0, "Flow reversal is not supported");
  -w_out = port_b.m_flow;
  assert(w_out >= 0, "Flow reversal is not supported");

  X_in = inStream(port_a.Xi_outflow);
  X_out = port_b.Xi_outflow;

  h_in = inStream(port_a.h_outflow);
  h_out = port_b.h_outflow;

  h = port_b.h_outflow;
  X = port_b.Xi_outflow;

  // Equations for reverse flow (not used)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);

  // Pressure drops
  port_a.p = p;
  port_b.p = p;

  // Mass balances
  der(M) = w_in - w_out;
  der(M * X[1]) = w_in * X_in[1] - w_out * X_out[1];
  der(M * X[2]) = w_in * X_in[2] - w_out * X_out[2];

  // Energy balance
  der(U) = h_in*w_in - h_out*w_out;

initial equation
  der(M) = 0;
  der(M * X[1]) = 0;
  //der(M * X[2]) = 0;
  der(U) = 0;

  annotation(Icon(coordinateSystem(preserveAspectRatio=false,   extent={{-100,-100},
            {100,100}}),                                                                              graphics={  Ellipse(extent={{
              -80,80},{80,-80}},                                                                                                    lineColor = {0, 0, 255}, startAngle = 0, endAngle = 360, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}})),                                                                                                    Documentation(info = "<HTML>

</HTML>"),
       Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-60, 20}, {60, -60}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 255}, fillPattern = FillPattern.VerticalCylinder)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end Junction_anodeStream;
