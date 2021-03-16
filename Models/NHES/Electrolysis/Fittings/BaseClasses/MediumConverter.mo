within NHES.Electrolysis.Fittings.BaseClasses;
model MediumConverter "Convert the medium from one type to another"
  import      Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package Medium_port_a =
      Modelica.Media.Water.StandardWater                                 constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance
    "Medium model at port_a in the component" annotation (choicesAllMatching = true, Dialog(group="Working fluids (Medium)"));
  replaceable package Medium_port_b =
      Electrolysis.Media.Electrolysis.CathodeGas constrainedby
    Modelica.Media.Interfaces.PartialMedium
    "Medium model at port b in the component" annotation (choicesAllMatching = true, Dialog(group="Working fluids (Medium)"));

  // ---------- Define constants -----------------------------------------------
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataH2=gasProperties.H2;
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataH2O=gasProperties.H2O;

  // ---------- Define parameters ----------------------------------------------
//  parameter SI.MassFlowRate m_flow_start = 4.48467
//    "Start value of mass flow rate of the medium [kg/s]"
//    annotation (Dialog(tab="Initialisation"));

  //parameter Modelica.SIunits.Volume V = 0.0001 "Internal volume";
  parameter SI.Pressure p_start = 2.045*1e6
    "Start value of pressure [Pa]"
                                  annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature T_start = 283.4 + 273.15
    "Start value of temperature [K]" annotation (Dialog(tab="Initialisation"));

  final parameter SI.SpecificEnthalpy h_port_a_start = Medium_port_a.specificEnthalpy(Medium_port_a.setState_pT(p_start, T_start))
    "Start value of specific enthalpy at port_a [J/kg]";
  final parameter SI.SpecificEnthalpy h_port_b_start=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2,
      T_start,
      excludeEnthalpyOfFormation)*X_start[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2O,
      T_start,
      excludeEnthalpyOfFormation)*X_start[2]
    "Start value of specific enthalpy of the medium at port_b [J/kg]";

  // ---------- Connectors -----------------------------------------------------
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium_port_a,
        m_flow(min=0),
        h_outflow(start=h_port_a_start)) annotation (Placement(transformation(
          extent={{-112,-10},{-92,10}}), iconTransformation(extent={{-112,-10},{
            -92,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium_port_b,
        m_flow(max=0),
        h_outflow(start=h_port_b_start),
        Xi_outflow(start=X_start)) annotation (Placement(transformation(
          extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,
            10}})));

  // ---------- Declare variables ----------------------------------------------
  Medium_port_a.BaseProperties pureSubstance_port_a( p(start=p_start),
    h(start=h_port_a_start)) "Fluid properties of the medium at port_a";
  Medium_port_b.BaseProperties mixtureGas_port_b( p(start=p_start),
    h(start=h_port_b_start),X(start=X_start))
    "Fluid properties of the medium at port_b";

  SI.Temperature T( min=273.15, start=T_start)
    "Temperature of the medium [K]";
  SI.MassFraction X[Medium_port_b.nX]( min={0,0},max={1,1}, start=X_start, nominal={0,1})
    "Mass fraction of the medium at port_b {H2, H2O}";
  SI.SpecificEnthalpy h_port_a(min = 0, start=h_port_a_start)
    "Specific enthalpy of the medium at port_a [J/kg]";
  SI.SpecificEnthalpy h_port_b(min = 0, start=h_port_b_start)
    "Specific enthalpy of the medium at port_b [J/kg]";

protected
  final parameter Boolean excludeEnthalpyOfFormation = true;
  final parameter SI.MassFraction X_start[:] = {0,1}
    "Start value of mass fraction at port_b {H2, H2O}";

equation
  // Fluid properties
  pureSubstance_port_a.p = port_a.p;
  pureSubstance_port_a.h = inStream(port_a.h_outflow);

  mixtureGas_port_b.p = port_b.p;
  mixtureGas_port_b.h = port_b.h_outflow;
  mixtureGas_port_b.X = port_b.Xi_outflow;

  T = pureSubstance_port_a.T;
  mixtureGas_port_b.T = T;

  X = X_start;
  mixtureGas_port_b.X = X;

  h_port_a = inStream(port_a.h_outflow);
  h_port_b = port_b.h_outflow;

  // Equations for reverse flow (not used)
  port_a.h_outflow = inStream(port_b.h_outflow);
  //Medium_port_b.reference_X = inStream(port_b.Xi_outflow);

  // Mass Balance
  0 = port_a.m_flow + port_b.m_flow;
  //der(mixtureGas_port_b.d*V) = port_a.m_flow + port_b.m_flow;
  assert(port_a.m_flow >= 0, "The model does not support flow reversal");

  // Momentum balance
  port_a.p = port_b.p;

  // Transport of substances
  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);

initial equation
  //V*der(mixtureGas_port_b.d) = 0;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}})),  Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
                                      graphics={
                               Rectangle(
          extent={{-92,40},{90,-40}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
                   Text(extent={{-104,-44},{108,-90}}, textString="%name",lineColor={0,0,255})}));
end MediumConverter;
