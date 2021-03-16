within NHES.Desalination.ReverseOsmosis.BaseClasses;
model Junction "Junction: one input to one output"
  import BrineProperties = NHES.Desalination.Media.BrineProp;

  // ---------- Fluid package -------------------------------------------------_
  replaceable package Medium =
    NHES.Desalination.Media.BrineProp.BrineDriesner
    constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model" annotation (choicesAllMatching=true);

  // ---------- Define constants -----------------------------------------------
  constant Real Rg(final unit = "J/(mol.K)") = Modelica.Constants.R
    "Molar gas constant";
  constant Real MW_NaCl(final unit = "g/mol") = 1000*BrineProperties.SaltData.M_NaCl
    "Molecular weight of NaCl";
  constant Integer NumValElectrons_NaCl = BrineProperties.SaltData.nM_NaCl
    "[ion moles/mol]";

  // ---------- Define parameters ----------------------------------------------
  parameter SI.Pressure p_start = 15.5315e5
    "Start value of pressure [Pa]" annotation(Dialog(tab = "Initialisation"));
  parameter SI.Temperature T_start = Modelica.Units.Conversions.from_degC(  25.3936) annotation(Dialog(tab = "Initialisation"));
  parameter SI.MassFraction X_NaCl_start = 0.00671314 "Start value of X_NaCl " annotation(Dialog(tab = "Initialisation"));
  parameter SI.MassFlowRate w_start = 2.26914 "Start value of the mass flow rate" annotation(Dialog(tab = "Initialisation"));

  final parameter SI.MassFraction X_start[:] = NHES.Desalination.Media.BrineProp.Xi2X({X_NaCl_start})
    "Start value of mass fractions";
  final parameter SI.SpecificEnthalpy h_start = NHES.Desalination.Media.BrineProp.SpecificEnthalpies.specificEnthalpy_pTX_Driesner(p_start, T_start, X_start[1])
    "Start value of the specific enthalpy [J/kg]";
  final parameter SI.Density rho_start =  Medium.density(state_start) "Start value of the density [kg/m3]";

  parameter Modelica.Units.SI.Volume V=0.001 "Internal volume";
  parameter Modelica.Units.SI.HeatCapacity C=0 "Additional heat capacity";

  // ----- Declare variables -----
  SI.MassFlowRate w_in(min=0, start= w_start) "Inlet mass flow rate [kg/s]";
  SI.MassFlowRate w_out(min=0, start= w_start) "Outlet mass flow rate [kg/s]";

  Medium.SpecificEnthalpy h_in(start = h_start)
    "Specific enthalpy of entering fluid";
  Medium.SpecificEnthalpy h_out(start = h_start)
    "Specific enthalpy of outgoing fluid";

  Medium.MassFraction X_in[Medium.nX](min = {0,0}, max = {1,1}, start = X_start)
    "Inlet mass fractions";
  Medium.MassFraction X_out[Medium.nX](min = {0,0}, max = {1,1}, start = X_start)
    "Outlet mass fractions";

  Modelica.Units.SI.Density rho(min=0, start=rho_start) "Density [kg/m3]";

  Modelica.Units.SI.Mass M "Fluid mass";
  Modelica.Units.SI.Temperature T(start=T_start) "Temperature";
  Modelica.Units.SI.Energy U "Internal energy";
  Modelica.Units.SI.MassFraction X[Medium.nX](
    min={0,0},
    max={1,1},
    start=X_start) "Internal mass fraction";

  // ----- Initial state -----
  final parameter Medium.ThermodynamicState state_start = Medium.setState_pTX(p_start, T_start, X_start);

  // ----- Thermodynamic state -----
  Medium.ThermodynamicState state(p(start = p_start), T(start = T_start), X(start = X_start))
    "Fluid properties";

  // ---------- Connectors -----------------------------------------------------
  Modelica.Fluid.Interfaces.FluidPort_a port_a(h_outflow(start=h_start),
      redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{-90,-10},{-70,10}}),  iconTransformation(extent={{-90,-10},{-70,
            10}})));
  Modelica.Fluid.Interfaces.FluidPort_b
                     port_b(h_outflow(start=h_start),
                     redeclare package Medium = Medium) annotation(Placement(transformation(extent={{70,-10},
            {90,10}}),                                                                                                    iconTransformation(extent={{70,-10},
            {90,10}})));

equation
  // ----------- Fluid properties ----------------------------------------------
  state = Medium.setState_pTX(port_a.p, T, inStream(port_a.Xi_outflow));
  h_in = Medium.specificEnthalpy(state);
  rho = Medium.density(state);

  // Boundary conditions
  w_in = port_a.m_flow;
  assert(w_in >= 0, "Flow reversal is not supported");
  -w_out = port_b.m_flow;
  assert(w_out >= 0, "Flow reversal is not supported");

  X_in = inStream(port_a.Xi_outflow);
  X_out = port_b.Xi_outflow;

  h_in = inStream(port_a.h_outflow);
  h_out = port_b.h_outflow;

  X = port_b.Xi_outflow;

  // Equations for reverse flow (not used)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);

  // ----- Intermediate variables -----
  M = rho*V;
  U = M*Medium.specificInternalEnergy(state);

  // Pressure drops
  port_a.p = port_b.p;

  // Mass balances
  der(M) = w_in - w_out;
  der(M * X[1]) = w_in * X_in[1] - w_out * X_out[1];
  der(M * X[2]) = w_in * X_in[2] - w_out * X_out[2];

  // Energy balance
  der(U) = h_in*w_in - h_out*w_out;

initial equation
  //der(M) = 0;
  der(M * X[1]) = 0;
  der(M * X[2]) = 0;
  //der(U) = 0;
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,   extent={{-100,-100},
            {100,100}}),                                                                              graphics={  Ellipse(extent={{
              -80,80},{80,-80}},                                                                                                    lineColor = {0, 0, 255}, startAngle = 0, endAngle = 360, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}})),                                                                                                    Documentation(info = "<HTML>

</HTML>"),
       Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-60, 20}, {60, -60}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 255}, fillPattern = FillPattern.VerticalCylinder)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end Junction;
