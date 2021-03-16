within NHES.Electrolysis.Fittings.BaseClasses;
model TeeJunction
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
  constant SI.MolarMass mwH2O = gasProperties.H2O.MM
    "Molecular weight of steam [kg/mol]";
  constant SI.MolarMass mwH2 = gasProperties.H2.MM
    "Molecular weight of hydrogen [kg/mol]";

  // ---------- Define parameters ----------------------------------------------
  parameter SI.Pressure p_start = 2.045*1e6
    "Start value of pressure [Pa]"                                         annotation(Dialog(tab = "Initialisation"));
  parameter SI.Temperature T_start=Modelica.Units.Conversions.from_degC(283.4)
    annotation (Dialog(tab="Initialisation"));
  parameter SI.MoleFraction yH2_start = 0.1
    "Start value of H2 mole fraction in a pipe" annotation (Dialog(tab="Initialisation"));
  final parameter SI.MoleFraction y_start[:]={yH2_start,1 -
      yH2_start} "Start value of mole fractions {H2, H2O}";
  final parameter SI.MassFraction X_start[:]=
      Electrolysis.Utilities.moleToMassFractions(y_start, {mwH2*1000,
      mwH2O*1000}) "Start value of mass fractions {H2, H2O}";
  parameter SI.MassFraction X_1a_start[:] = {1,0}
    "Start value of mass fractions at port_1a {H2, H2O}";
  parameter SI.MassFraction X_2a_start[:] = {0,1}
    "Start value of mass fractions at port_2a {H2, H2O}";

  final parameter SI.SpecificEnthalpy h_start=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2,
      T_start,
      excludeEnthalpyOfFormation)*X_start[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2O,
      T_start,
      excludeEnthalpyOfFormation)*X_start[2]
    "Start value of specific enthalpy [J/kg]";
  final parameter SI.SpecificEnthalpy h_1a_start=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2,
      T_start,
      excludeEnthalpyOfFormation)*X_1a_start[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2O,
      T_start,
      excludeEnthalpyOfFormation)*X_1a_start[2]
    "Start value of specific enthalpy at port_1a [J/kg]";
  final parameter SI.SpecificEnthalpy h_2a_start=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2,
      T_start,
      excludeEnthalpyOfFormation)*X_2a_start[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2O,
      T_start,
      excludeEnthalpyOfFormation)*X_2a_start[2]
    "Start value of specific enthalpy at port_2a [J/kg]";

  parameter Modelica.Units.SI.Volume V=0.001 "Internal volume";
  parameter Modelica.Units.SI.HeatCapacity C=0
    "Additional heat capacity (e.g., of vessel)";

  SI.MassFlowRate w_1a(min=0) "Mass flow rate at port_1a [kg/s]";
  SI.MassFlowRate w_2a(min=0) "Mass flow rate at port_2a [kg/s]";
  SI.MassFlowRate w_3b(min=0) "Mass flow rate at port_3b [kg/s]";

  Medium.SpecificEnthalpy h_1a(start = h_1a_start)
    "Specific enthalpy of fluid at port_1a";
  Medium.SpecificEnthalpy h_2a(start = h_2a_start)
    "Specific enthalpy of fluid at port_2a";
  Medium.SpecificEnthalpy h_3b(start = h_start)
    "Specific enthalpy of fluid at port_3b";

  Medium.MassFraction X_1a[Medium.nX](min = {0,0}, max = {1,1}, start = X_1a_start)
    "Mass fractions at port_1a";
  Medium.MassFraction X_2a[Medium.nX](min = {0,0}, max = {1,1}, start = X_2a_start)
    "Mass fractions at port_2a";
  Medium.MassFraction X_3b[Medium.nX](min = {0,0}, max = {1,1}, start = X_start)
    "Mass fractions at port_3b";

  Medium.BaseProperties fluid(p(start = p_start), X(start = X_start), h(start = h_start))
    "Fluid properties";
  Medium.AbsolutePressure p( start=p_start) "Fluid pressure";
  Medium.SpecificEnthalpy h( start=h_start) "Fluid specific enthalpy";
  Modelica.Units.SI.Mass M "Fluid mass";
  Modelica.Units.SI.Temperature T(start=T_start) "Temperature";
  Modelica.Units.SI.Energy U "Internal energy";
  Modelica.Units.SI.MassFraction X[Medium.nX](
    min={0,0},
    max={1,1},
    start=X_start) "Internal mass fraction";

  Modelica.Fluid.Interfaces.FluidPort_a port_1a(  m_flow(min=0),h_outflow(start=h_1a_start),
      redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{
            -10,90},{10,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_2a(  m_flow(min=0),h_outflow(start=h_2a_start),
      redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent=
           {{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_3b(  m_flow(max=0),h_outflow(start=h_start),
      redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{
            90,-10},{110,10}})));

protected
  final parameter Boolean excludeEnthalpyOfFormation = true;

equation
  // ----------- Fluid properties ----------------------------------------------
  fluid.p = p;
  T = fluid.T;
  fluid.h = h;
  X = fluid.X;

  M = fluid.d*V;
  U = M*fluid.u;

  // Boundary conditions
  w_1a = port_1a.m_flow;
  assert(w_1a >= 0, "Flow reversal is not supported");
  w_2a = port_2a.m_flow;
  assert(w_2a >= 0, "Flow reversal is not supported");
  -w_3b = port_3b.m_flow;
  assert(w_3b >= 0, "Flow reversal is not supported");

  X_1a = inStream(port_1a.Xi_outflow);
  X_2a = inStream(port_2a.Xi_outflow);
  X_3b = port_3b.Xi_outflow;

  h_1a = inStream(port_1a.h_outflow);
  h_2a = inStream(port_2a.h_outflow);
  h_3b = port_3b.h_outflow;

  h = port_3b.h_outflow;
  X = port_3b.Xi_outflow;

  // Equations for reverse flow (not used)
  port_1a.h_outflow = h;
  port_2a.h_outflow = h;
  port_1a.Xi_outflow = X;
  port_2a.Xi_outflow = X;

  // Momentum balances
  port_1a.p = p;
  port_2a.p = p;
  port_3b.p = p;

  // Mass balances
  //der(M) = w_1a + w_2a - w_3b;
  //der(M * X_1a[1]) = w_1a*X_1a[1] + w_2a*X_2a[1] - w_3b*X_3b[1];
  //der(M * X_1a[2]) = w_1a*X_1a[2] + w_2a*X_2a[2] - w_3b*X_3b[2];

  0 = w_1a + w_2a - w_3b;
  0 = w_1a*X_1a[1] + w_2a*X_2a[1] - w_3b*X_3b[1];
  0 = w_1a*X_1a[2] + w_2a*X_2a[2] - w_3b*X_3b[2];

  // Energy balance
  //der(U) = h_1a*w_1a + h_2a*w_2a - h_3b*w_3b;
  0 = h_1a*w_1a + h_2a*w_2a - h_3b*w_3b;

initial equation
  //der(M) = 0;
  //der(M * X[1]) = 0;
  //der(M * X[2]) = 0;
  //der(U) = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,44},{100,-44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-44,100},{44,44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-20,80},{20,-6}},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255},
          pattern=LinePattern.None,
          lineColor={0,0,0}),                      Ellipse(
          extent={{-9,8},{11,-12}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-67},{150,-107}},
          lineColor={0,0,255},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end TeeJunction;
