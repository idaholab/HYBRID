within NHES.Electrolysis.ElectricHeaters.BaseClasses;
model HeatedPipe_fixedTamb
  "Pipe with heat exchange at fixed Tamb without a heat port "

  import      Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package Medium =
      Electrolysis.Media.Electrolysis.CathodeGas constrainedby
    Modelica.Media.Interfaces.PartialMedium "Working fluid model"
                          annotation (choicesAllMatching = true,Dialog(group="Working fluids (Medium)"));

  // ---------- Define constants -----------------------------------------------
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataH2=gasProperties.H2;
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataH2O=gasProperties.H2O;
  constant SI.MolarMass mwH2O = gasProperties.H2O.MM
    "Molecular weight of water/steam [kg/mol]";
  constant SI.MolarMass mwH2 = gasProperties.H2.MM
    "Molecular weight of hydrogen [kg/mol]";

  // ---------- Define parameters ----------------------------------------------
  final parameter SI.Volume Vf = 0.01 "Fluid internal volume [m3]";
  parameter SI.ThermalConductance Ah = 20470 "Thermal conductance [W/K]";

  parameter Electrolysis.Types.HydraulicConductanceSquared coeff_dp=
      1940.29149
    "Coefficient for the pressure drop across a pipe [Pa.s2/(kg2)]";

  parameter SI.Pressure p_in_start = 2.004*1e6
    "Start value of inlet pressure [Pa]" annotation (Dialog(tab="Initialisation"));
  final parameter SI.Pressure p_out_start = p_in_start - coeff_dp*w_start^2
    "Start value of outlet pressure [Pa]";

  parameter SI.Temperature T_in_start = 626.583 + 273.15
    "Start value of inlet temperature [K]" annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature T_out_start = 850 + 273.15
    "Start value of outlet temperature [K]" annotation (Dialog(tab="Initialisation"));

  final parameter SI.Temperature T_mean_start = (T_in_start + T_out_start)/2
    "Start value of average temperature in a pipe [K]";

  final parameter SI.Temperature Tamb_start = T_out_start + 10
    "Start value of temperature relevant for heat exchnage with ambient [K]";

  parameter SI.MoleFraction yH2_start = 0.1
    "Start value of H2 mole fraction in a pipe"
    annotation (Dialog(tab="Initialisation"));
  final parameter SI.MoleFraction y_start[:]={yH2_start,1 -
      yH2_start} "Start value of mole fractions {H2, H2O}";
  final parameter SI.MassFraction X_start[:]=
      Electrolysis.Utilities.moleToMassFractions(y_start, {mwH2*1000,
      mwH2O*1000}) "Start value of mass fractions {H2, H2O}";

  final parameter SI.SpecificEnthalpy h_in_start = Medium.specificEnthalpy(state_in_start)
    "Start value of inlet specific enthalpy [J/kg]";
  final parameter SI.SpecificEnthalpy h_out_start = Medium.specificEnthalpy(state_out_start)
    "Start value of outlet specific enthalpy [J/kg]";

  parameter SI.MassFlowRate w_start= 0.908085*5
    "Start value of mass flow rate [kg/s]"
    annotation (Dialog(tab="Initialisation"));

  // ---------- Connectors -----------------------------------------------------
  Modelica.Fluid.Interfaces.FluidPort_a port_a(h_outflow(start=h_in_start),
  redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}),  iconTransformation(
          extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(h_outflow(start=h_out_start),
  redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{90,-10},{110,10}}),  iconTransformation(extent={{90,-10},
            {110,10}})));

  // ---------- Declare variables ----------------------------------------------
  SI.HeatFlowRate Q_flow "Heat gained/lost by the hot/cold medium [W]";

  SI.Pressure p_in( min=0) "Inlet pressure [Pa]";
  SI.Pressure p_out( min=0) "Outlet pressure of [Pa]";
  SI.Pressure dp "Pressure drop across a pipe [Pa]";

  SI.Temperature Tamb(min = 273.15,start=Tamb_start)
    "Temperature relevant for heat exchange with ambient [K]";
  SI.Temperature T_in(min=273.15,start=T_in_start) "Inlet temperature [K]";
  SI.Temperature T_out(min=273.15,start=T_out_start) "Outlet temperature [K]";
  SI.Temperature T_mean(min=273.15,start = T_mean_start)
    "Average temperature [K]";

  SI.MassFraction X_in[Medium.nX](min={0,0}, max={1,1}, start=X_start);
  SI.MassFraction X_out[Medium.nX](min={0,0}, max={1,1}, start=X_start);

  SI.SpecificEnthalpy h_in(min = 0, start=h_in_start)
    "Inlet specific enthalpy of [J/kg]";
  SI.SpecificEnthalpy h_out(min = 0, start=h_out_start)
    "Outlet specific enthalpy [J/kg]";

  SI.MassFlowRate w_in(min=0) "Inlet mass flow rate [kg/s]";
  SI.MassFlowRate w_out(min=0) "Outlet mass flow rate [kg/s]";

  // ----- Initial states -----
  final parameter Medium.ThermodynamicState state_in_start = Medium.setState_pTX(p_in_start, T_in_start, X_start);
  final parameter Medium.ThermodynamicState state_out_start = Medium.setState_pTX(p_out_start, T_out_start, X_start);

  // ----- Current states -----
  Medium.ThermodynamicState state_in;
  Medium.ThermodynamicState state_out;

equation
  // ----------- Fluid properties ----------------------------------------------
  state_in = Medium.setState_phX(p_in, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
  state_out = Medium.setState_phX(p_out, port_b.h_outflow, port_b.Xi_outflow);

  T_in = Medium.temperature(state_in);
  T_out = Medium.temperature(state_out);

  // ---------- Boundary conditions --------------------------------------------
  port_a.m_flow = w_in "[kg/s]";
  assert(w_in >= 0, "Flow reversal is not supported");
  -port_b.m_flow = w_out "[kg/s]";
  assert(w_out >= 0, "Flow reversal is not supported");

  p_in = port_a.p;
  p_out = port_b.p;

  X_in = inStream(port_a.Xi_outflow);
  X_out = port_b.Xi_outflow;

  h_in = inStream(port_a.h_outflow);
  h_out = port_b.h_outflow;

  // Equations for reverse flow (not used)
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);

  // Intermediate variables
  //Q_flow = heatPort.Q_flow;
  //Tamb = heatPort.T;
  Q_flow = Ah*(Tamb - T_mean);
  Tamb = 850 + 273.15 + 10;

  T_mean = (T_in + T_out)/2;

  // Pressure drop across the heat exchanger
  dp = coeff_dp*w_in^2;
  p_out = p_in - dp;

  // ----- Mass balances ------
  0 = w_in - w_out;

  // ----- Independent component mass balances -----
  X_in = X_out;

  // ----- Energy balances ------
  0 = (w_in*h_in - w_out*h_out) + Q_flow;

    annotation (
     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={
        Ellipse(
          extent={{90,24},{110,-26}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          visible=port_a_exposesState),
        Ellipse(
          extent={{-110,26},{-90,-24}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          visible=port_a_exposesState),
        Polygon(
          points={{20,-66},{60,-81},{20,-96},{20,-66}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=showDesignFlowDirection),
        Text(
          extent={{-98,-103},{102,-133}},
          lineColor={0,0,255},
          textString="%name"),
          Rectangle(
          extent={{-100,44},{100,-44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Polygon(
          points={{20,-71},{50,-81},{20,-91},{20,-71}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{55,-81},{-60,-81}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=showDesignFlowDirection),
        Line(points={{0,70},{0,44}},    color={191,0,0})}));
end HeatedPipe_fixedTamb;
