within NHES.Electrolysis.ElectricHeaters.BaseClasses;
model HeatedPipe_anodeGas_nom
  "Nominal condition for a pipe with heat exchange carrying anode gas"

  import      Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package Medium =
      Electrolysis.Media.Electrolysis.AnodeGas_air constrainedby
    Modelica.Media.Interfaces.PartialMedium "Working fluid model";

  // ---------- Define constants -----------------------------------------------
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataO2=gasProperties.O2;
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataN2=gasProperties.N2;
  constant SI.MolarMass mwO2 = gasProperties.O2.MM
    "Molecular weight of oxygen [kg/mol]";
  constant SI.MolarMass mwN2 = gasProperties.N2.MM
    "Molecular weight of nitrogen [kg/mol]";

  // ---------- Define parameters ----------------------------------------------
  parameter SI.Volume V = 0.01 "Fluid internal volume [m3]";
  parameter Electrolysis.Types.HydraulicConductanceSquared coeff_dp=
      73.8105245172487
    "Coefficient for the pressure drop across a pipe [Pa.s2/(kg2)]";
  parameter SI.MoleFraction yO2_start = 0.21 "Start value of O2 mole fraction"
    annotation (Dialog(tab="Initialisation"));

  final parameter SI.MoleFraction y_start[:]={1-yO2_start, yO2_start}
    "Start value of mole fractions {N2, O2}";
  final parameter SI.MassFraction X_start[:]=
      Electrolysis.Utilities.moleToMassFractions(y_start, {mwN2*1000,
      mwO2*1000}) "Start value of mass fractions {N2, O2}";

  SI.Temperature Tamb "Temperature relevant for heat exchange with ambient";
  SI.HeatFlowRate Q_flow "Heat gained/lost by the hot/cold medium";

  SI.Pressure p_in( min=0) "Inlet pressure of the medium in a pipe [Pa]";
  SI.Pressure p_out( min=0) "Outlet pressure of the medium in a pipe [Pa]";

  SI.SpecificEnthalpy h_in(min = 0)
    "Inlet specific enthalpy of the medium [J/kg]";
  SI.SpecificEnthalpy h_out(min = 0)
    "Outlet specific enthalpy of the medium [J/kg]";

  SI.Temperature T_in(min=273.15) "Inlet temperature [K]";
  SI.Temperature T_out(min=273.15) "Outlet temperature [K]";
  SI.Temperature T_mean(min=273.15) "Average temperature [K]";

  SI.MassFraction X_in[Medium.nX](min={0,0}, max={1,1}, start=X_start);
  SI.MassFraction X_out[Medium.nX](min={0,0}, max={1,1}, start=X_start);

  SI.MassFlowRate w_in(min=0) "Inlet mass flow rate [kg/s]";
  SI.MassFlowRate w_out(min=0) "Outlet mass flow rate kg/s]";

  SI.ThermalConductance Ah "Thermal conductance [W/K]";

  SI.Pressure dp "Pressure drop across a pipe [Pa]";

  Medium.ThermodynamicState state_in;
  Medium.ThermodynamicState state_out;

equation
  // ----------- Fluid properties ----------------------------------------------
  state_in = Medium.setState_pTX(p_in, T_in, X_in);
  state_out = Medium.setState_pTX(p_out, T_out, X_out);

  w_in = 23.27935;
  p_in = 2.004*1e6;

  Tamb = T_out + 10;
  T_mean = (T_in + T_out)/2;

  dp = coeff_dp*w_in^2;

  // Pressure drop across the heat exchanger
  p_out = p_in - dp;

  // ----- Mass balances ------
  0 = w_in - w_out;

  // ----- Independent component mass balances -----
  X_in = X_start;
  X_out = X_start;

  // ----- Energy balances ------
  h_in = Medium.specificEnthalpy(state_in);
  h_out = Medium.specificEnthalpy(state_out);

  T_in = 273.15 + 734.492;
  T_out = 273.15 + 850;

  Q_flow = Ah*(Tamb - T_mean);

  0 = (w_in*h_in - w_out*h_out) + Q_flow;

    annotation (
     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={
        Text(
          extent={{-147,-98},{153,-138}},
          lineColor={0,0,255},
          textString="%name"),
          Rectangle(
          extent={{-100,44},{100,-44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Polygon(
          points={{20,-66},{60,-81},{20,-96},{20,-66}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=showDesignFlowDirection),
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
          visible=showDesignFlowDirection)}));
end HeatedPipe_anodeGas_nom;
