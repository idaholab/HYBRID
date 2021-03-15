within NHES.Electrolysis.HeatExchangers.BaseClasses;
model HEX_nuclearHeatCathodeGasRecupVessel_ROM_nom_NHES
  "Nominal condition for nuclear heat recuperation with cathode gas"

  import      Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package Medium_tube = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance
    "Working fluid model in tube side of a heat exchanger";
  replaceable package Medium_shell = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance
    "Working fluid model in shell side of a heat exchanger";

  // ---------- Define parameters ----------------------------------------------
  parameter Electrolysis.Types.HydraulicConductanceSquared coeff_dpTube=
      4872.23324354983
    "Coefficient for the pressure drop in tube side [Pa.s2/(kg2)]";
  parameter Electrolysis.Types.HydraulicConductanceSquared coeff_dpShell=
      2146.02917037094
    "Coefficient for the pressure drop in shell side [Pa.s2/(kg2)]";

  SI.Temperature Tm "Metal temperature [K]";
  SI.Power QTube_gained "Energy gained by the cold fluid [W]";
  SI.Power QShell_lost "Energy lost by the hot fluid [W]";

  SI.Pressure pTube_in( min=0)
    "Inlet pressure of the medium in tube side [Pa]";
  SI.Pressure pShell_in( min=0)
    "Inlet pressure of the medium in shell side [Pa]";
  SI.Pressure pTube_out( min=0)
    "Outlet pressure of the medium in tube side [Pa]";
  SI.Pressure pShell_out( min=0)
    "Outlet pressure of the medium in shell side [Pa]";

  SI.SpecificEnthalpy hTube_in(min = 0)
    "Inlet specific enthalpy of the medium in tube side [J/kg]";
  SI.SpecificEnthalpy hShell_in(min = 0)
    "Inlet specific enthalpy of the medium in shell side [J/kg]";
  SI.SpecificEnthalpy hTube_out(min = 0)
    "Outlet specific enthalpy of the medium in tube side [J/kg]";
  SI.SpecificEnthalpy hShell_out(min = 0)
    "Outlet specific enthalpy of the medium in shell side [J/kg]";

  SI.Temperature TTube_in(min=273.15,nominal=298.15);
  SI.Temperature TTube_out(min=273.15);
  SI.Temperature TShell_in(min=273.15+283.4,nominal=574.698);
  SI.Temperature TShell_out(min=273.15);
  SI.Temperature TTube_mean(min=273.15);
  SI.Temperature TShell_mean(min=273.15);

  SI.MassFlowRate wTube_in(min=0)
    "Inlet mass flow rate of the medium in tube side [kg/s]";
  SI.MassFlowRate wTube_out(min=0)
    "Outlet mass flow rate of the medium in tube side [kg/s]";
  SI.MassFlowRate wShell_in(min=0)
    "Inlet mass flow rate of the medium in shell side [kg/s]";
  SI.MassFlowRate wShell_out(min=0)
    "Outlet mass flow rate of the medium in shell side [kg/s]";

   SI.ThermalConductance AhTube "Thermal conductance in tube side [W/K]";
   SI.ThermalConductance AhShell
    "Thermal conductance in shell side [W/K]";

   SI.Pressure dpTube "Pressure drop in tube side [Pa]";
   SI.Pressure dpShell "Pressure drop in shell side [Pa]";

  Medium_tube.ThermodynamicState tubeState_in;
  Medium_shell.ThermodynamicState shellState_in;
  Medium_tube.ThermodynamicState tubeState_out;
  Medium_shell.ThermodynamicState shellState_out;

equation
  // ----------- Fluid properties ----------------------------------------------
  tubeState_in = Medium_tube.setState_pT(pTube_in, TTube_in);
  shellState_in = Medium_shell.setState_pT(pShell_in, TShell_in);
  tubeState_out = Medium_tube.setState_pT(pTube_out, TTube_out);
  shellState_out = Medium_shell.setState_pT(pShell_out, TShell_out);

  // ---------- Boundary conditions --------------------------------------------
  wTube_in = 4.4846564335925;

  pTube_in = 2.37021305331862*1e6 "[Pa]";
  pShell_in = 5.22*1e6 "[Pa]";
  //pShell_out = 4.31793*1e6 "[Pa]";

  QTube_gained = -(wTube_in*hTube_in - wTube_out*hTube_out);
  QShell_lost = (wShell_in*hShell_in - wShell_out*hShell_out);

  Tm = (TTube_mean + TShell_mean)/2;
  TTube_mean = (TTube_in + TTube_out)/2;
  TShell_mean = (TShell_in + TShell_out)/2;

  dpTube = coeff_dpTube*wTube_in^2;
  dpShell = coeff_dpShell*wShell_in^2;

  // Pressure drop across the heat exchanger
  pTube_out = pTube_in - dpTube;
  pShell_out = pShell_in - dpShell;

  // ----- Mass balances ------
  0 = wTube_in - wTube_out;
  0 = wShell_in - wShell_out;

  // ----- Energy balances ------
  hTube_in = Medium_tube.specificEnthalpy(tubeState_in);
  hShell_in = Medium_shell.specificEnthalpy(shellState_in);
  hTube_out = Medium_tube.specificEnthalpy(tubeState_out);
  hShell_out = Medium_shell.specificEnthalpy(shellState_out);

  TTube_in = 273.15 + 25.1971;
  TShell_in = 273.15 + 311.629;

  TTube_out = 273.15 + 283.4;
  TShell_out = 273.15 + 224;

  AhTube*(Tm - TTube_mean) = QTube_gained;
  AhShell*(Tm - TShell_mean) = -QShell_lost;

  0 = (wTube_in*hTube_in - wTube_out*hTube_out) + (wShell_in*hShell_in - wShell_out*hShell_out);

    annotation (
     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={238,46,47}),
        Text(
          extent={{-100,-115},{100,-145}},
          lineColor={85,170,255},
          textString="%name"),
        Line(
          points={{-6.12323e-015,100},{0,40},{40,20},{-40,-20},{0,-40},{6.12323e-015,
              -100}},
          color={0,0,255},
          thickness=0.5,
          origin={0,0},
          rotation=90)}));
end HEX_nuclearHeatCathodeGasRecupVessel_ROM_nom_NHES;
