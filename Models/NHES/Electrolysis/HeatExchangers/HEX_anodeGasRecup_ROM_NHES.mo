within NHES.Electrolysis.HeatExchangers;
model HEX_anodeGasRecup_ROM_NHES
  "Reduced order model (ROM) for heat recuperation via anode gas"

  import      Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package Medium_tube =
      Electrolysis.Media.Electrolysis.AnodeGas_air constrainedby
    Modelica.Media.Interfaces.PartialMedium
    "Working fluid model in tube side of a heat exchanger" annotation (choicesAllMatching = true,Dialog(group="Working fluids (Medium)"));
  replaceable package Medium_shell =
      Electrolysis.Media.Electrolysis.AnodeGas_air constrainedby
    Modelica.Media.Interfaces.PartialMedium
    "Working fluid model in shell side of a heat exchanger" annotation (choicesAllMatching = true,Dialog(group="Working fluids (Medium)"));

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
  parameter Electrolysis.Utilities.OptionsInit.Temp initOpt=Electrolysis.Utilities.OptionsInit.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));

  final parameter SI.Volume Vf = 0.01 "Fluid internal volume [m3]";
  parameter SI.Volume Vm = 0.55*4
    "Volume of the metal parts in a heat exchanger [m3]";
  parameter SI.Density rhom = 7753 "Metal density [kg/m3]";
  parameter SI.SpecificHeatCapacity cpm = 486
    "Specific heat capacity of the metal [J/(kg.K)]";
  parameter SI.ThermalConductance AhTube = 548277
    "Thermal conductance in tube side [W/K]";
  parameter SI.ThermalConductance AhShell = 548277
    "Thermal conductance in shell side [W/K]";

  //SI.ThermalConductance AhTube "Thermal conductance in tube side [W/K]";
  //SI.ThermalConductance AhShell "Thermal conductance in shell side [W/K]";

  parameter Electrolysis.Types.HydraulicConductanceSquared coeff_dpTube=
      75.6557876301802
    "Coefficient for the pressure drop in tube side [Pa.s2/(kg2)]";
  parameter Electrolysis.Types.HydraulicConductanceSquared coeff_dpShell=
      58.5356396004058
    "Coefficient for the pressure drop in shell side [Pa.s2/(kg2)]";

  parameter SI.Pressure pTube_in_start = 2.045*1e6
    "Start value of inlet pressure in tube side [Pa]" annotation (Dialog(tab="Initialisation"));
  parameter SI.Pressure pShell_in_start = 1.964*1e6
    "Start value of inlet pressure in shell side [Pa]" annotation (Dialog(tab="Initialisation"));
  final parameter SI.Pressure pTube_out_start = pTube_in_start - coeff_dpTube*wTube_start^2
    "Start value of outlet pressure in tube side [Pa]";
  final parameter SI.Pressure pShell_out_start = pShell_in_start - coeff_dpShell*wShell_start^2
    "Start value of outlet pressure in shell side [Pa]";

  parameter SI.Temperature TTube_in_start = 259 + 273.15
    "Start value of inlet temperature in tube side [K]" annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature TShell_in_start = 749.492 + 273.15
    "Start value of inlet temperature in shell side [K]" annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature TTube_out_start = 734.492 + 273.15
    "Start value of outlet temperature in tube side [K]" annotation (Dialog(tab="Initialisation"));
//  parameter SI.Temperature TShell_out_start = 332.688 + 273.15
//    "Start value of outlet temperature in shell side [K]" annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature TShell_out_start = 400 + 273.15
    "Start value of outlet temperature in shell side [K]" annotation (Dialog(tab="Initialisation"));
  final parameter SI.Temperature TTube_mean_start = (TTube_in_start + TTube_out_start)/2
    "Start value of average temperature in tube side [K]";
  final parameter SI.Temperature TShell_mean_start = (TShell_in_start + TShell_out_start)/2
    "Start value of average temperature in shell side [K]";
  final parameter SI.Temperature Tm_start = (TTube_mean_start + TShell_mean_start)/2
    "Start value of metal temperature [K]";

  parameter SI.MoleFraction yO2Tube_start = 0.21
    "Start value of O2 mole fraction in tube side"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.MoleFraction yO2Shell_start = 0.29678
    "Start value of O2 mole fraction in shell side" annotation (Dialog(tab="Initialisation"));
  final parameter SI.MoleFraction yTube_start[:]={1-yO2Tube_start, yO2Tube_start}
    "Start value of mole fractions in tube side {N2, O2}";
  final parameter SI.MoleFraction yShell_start[:]={1-yO2Shell_start, yO2Shell_start}
    "Start value of mole fractions in shell side {N2, O2}";
  final parameter SI.MassFraction XTube_start[:]=
      Electrolysis.Utilities.moleToMassFractions(yTube_start, {mwN2*1000,
      mwO2*1000}) "Start value of mass fractions in tube side {N2, O2}";
  final parameter SI.MassFraction XShell_start[:]=
      Electrolysis.Utilities.moleToMassFractions(yShell_start, {mwN2*1000,
      mwO2*1000}) "Start value of mass fractions in shell side {N2, O2}";

  final parameter SI.SpecificEnthalpy hTube_in_start=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataN2,
      TTube_in_start,
      excludeEnthalpyOfFormation)*XTube_start[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataO2,
      TTube_in_start,
      excludeEnthalpyOfFormation)*XTube_start[2]
    "Start value of inlet specific enthalpy in tube side [J/kg]";
  final parameter SI.SpecificEnthalpy hTube_out_start=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataN2,
      TTube_out_start,
      excludeEnthalpyOfFormation)*XTube_start[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataO2,
      TTube_out_start,
      excludeEnthalpyOfFormation)*XTube_start[2]
    "Start value of outlet specific enthalpy in tube side [J/kg]";
  final parameter SI.SpecificEnthalpy hShell_in_start=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataN2,
      TShell_in_start,
      excludeEnthalpyOfFormation)*XShell_start[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataO2,
      TShell_in_start,
      excludeEnthalpyOfFormation)*XShell_start[2]
    "Start value of inlet specific enthalpy in shell side [J/kg]";
  final parameter SI.SpecificEnthalpy hShell_out_start=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataN2,
      TShell_out_start,
      excludeEnthalpyOfFormation)*XShell_start[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataO2,
      TShell_out_start,
      excludeEnthalpyOfFormation)*XShell_start[2]
    "Start value of outlet specific enthalpy in shell side [J/kg]";

  parameter SI.MassFlowRate wTube_start = 23.2794
    "Start value of mass flow rate of the medium in tube side [kg/s]"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.MassFlowRate wShell_start = 26.4656
    "Start value of mass flow rate of the medium in shell side [kg/s]"
    annotation (Dialog(tab="Initialisation"));

  // ---------- Connectors -----------------------------------------------------
  Modelica.Fluid.Interfaces.FluidPort_a tube_in(h_outflow(start=hTube_in_start),
  redeclare package Medium = Medium_tube) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}),  iconTransformation(
          extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b tube_out(h_outflow(start=hTube_out_start),
  redeclare package Medium = Medium_tube) annotation (Placement(
        transformation(extent={{90,-10},{110,10}}),  iconTransformation(extent={{90,-10},
            {110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a shell_in(h_outflow(start=hShell_in_start),
  redeclare package Medium = Medium_shell) annotation (Placement(
        transformation(extent={{-10,90},{10,110}}),  iconTransformation(extent={{-10,90},
            {10,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b shell_out(h_outflow(start=hShell_out_start),
  redeclare package Medium = Medium_shell) annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}}),  iconTransformation(
          extent={{-10,-110},{10,-90}})));

  // ---------- Declare variables ----------------------------------------------
  SI.Mass MTube(min=0) "Fluid mass in tube side [kg]";
  SI.Mass MShell(min=0) "Fluid mass in shell side [kg]";
  SI.Energy UTube(min=0) "Fulid specific internal energy in tube side [J]";
  SI.Energy UShell(min=0) "Fulid specific internal energy in shell side [J]";
  SI.Power QTube_gained "Energy gained by the cold fluid [W]";
  SI.Power QShell_lost "Energy lost by the hot fluid [W]";

  SI.Pressure pTube_in( min=0) "Inlet pressure of the medium in tube side [Pa]";
  SI.Pressure pShell_in( min=0)
    "Inlet pressure of the medium in shell side [Pa]";
  SI.Pressure pTube_out( min=0)
    "Outlet pressure of the medium in tube side [Pa]";
  SI.Pressure pShell_out( min=0)
    "Outlet pressure of the medium in shell side [Pa]";
  SI.Pressure dpTube( min=0) "Pressure drop in tube side [Pa]";
  SI.Pressure dpShell( min=0) "Pressure drop in shell side [Pa]";

  SI.Temperature Tm(min = 273.15, start=Tm_start) "Metal temperature [K]";
  SI.Temperature TTube_in(min=273.15, nominal=532.15, start=TTube_in_start)
    "Inlet temperature in tube side [K]";
  SI.Temperature TTube_out(min=273.15, nominal = 1007.642, start=TTube_out_start)
    "Outlet temperature in tube side [K]";
  SI.Temperature TShell_in(min=273.15, nominal=1022.642,start=TShell_in_start)
    "Inlet temperature in shell side [K]";
  SI.Temperature TShell_out(min=273.15, nominal = 605.838, start=TShell_out_start)
    "Outlet temperature in shell side [K]";
  SI.Temperature TTube_mean(min=273.15, nominal = 769.896, start = TTube_mean_start)
    "Average temperature in tube side [K]";
  SI.Temperature TShell_mean(min=273.15, nominal = 814.24, start = TShell_mean_start)
    "Average temperature in shell side [K]";

  SI.MassFraction XTube_in[Medium_tube.nX](min={0,0}, max={1,1}, start=XTube_start);
  SI.MassFraction XTube_out[Medium_tube.nX](min={0,0}, max={1,1}, start=XTube_start);
  SI.MassFraction XShell_in[Medium_shell.nX](min={0,0}, max={1,1}, start=XShell_start);
  SI.MassFraction XShell_out[Medium_shell.nX](min={0,0},max={1,1}, start=XShell_start);

  SI.SpecificEnthalpy hTube_in(min = 0, start=hTube_in_start)
    "Inlet specific enthalpy of the medium in tube side [J/kg]";
  SI.SpecificEnthalpy hShell_in(min = 0, start=hShell_in_start)
    "Inlet specific enthalpy of the medium in shell side [J/kg]";
  SI.SpecificEnthalpy hTube_out(min = 0, start=hTube_out_start)
    "Outlet specific enthalpy of the medium in tube side [J/kg]";
  SI.SpecificEnthalpy hShell_out(min = 0, start=hShell_out_start)
    "Outlet specific enthalpy of the medium in shell side [J/kg]";

  SI.MassFlowRate wTube_in(min=0)
    "Inlet mass flow rate of the medium in tube side [kg/s]";
  SI.MassFlowRate wTube_out(min=0)
    "Outlet mass flow rate of the medium in tube side [kg/s]";
  SI.MassFlowRate wShell_in(min=0,start=wShell_start)
    "Inlet mass flow rate of the medium in shell side [kg/s]";
  SI.MassFlowRate wShell_out(min=0)
    "Outlet mass flow rate of the medium in shell side [kg/s]";

  // ----- Initial states -----
  final parameter Medium_tube.ThermodynamicState tubeState_in_start = Medium_tube.setState_phX(pTube_in_start, hTube_in_start, XTube_start);
  final parameter Medium_tube.ThermodynamicState tubeState_out_start = Medium_tube.setState_phX(pTube_out_start, hTube_out_start, XTube_start);
  final parameter Medium_shell.ThermodynamicState shellState_in_start = Medium_shell.setState_phX(pShell_in_start, hShell_in_start, XShell_start);
  final parameter Medium_shell.ThermodynamicState shellState_out_start = Medium_shell.setState_phX(pShell_out_start, hShell_out_start, XShell_start);

  // ----- Current states -----
  Medium_tube.ThermodynamicState tubeState_in;
  Medium_tube.ThermodynamicState tubeState_out;
  Medium_shell.ThermodynamicState shellState_in;
  Medium_shell.ThermodynamicState shellState_out;

protected
  final parameter Boolean excludeEnthalpyOfFormation = true;

equation
  // ----------- Fluid properties ----------------------------------------------
  tubeState_in = Medium_tube.setState_phX(pTube_in, inStream(tube_in.h_outflow), inStream(tube_in.Xi_outflow));
  tubeState_out = Medium_tube.setState_phX(pTube_out, tube_out.h_outflow, tube_out.Xi_outflow);
  shellState_in = Medium_shell.setState_phX(pShell_in, inStream(shell_in.h_outflow), inStream(shell_in.Xi_outflow));
  shellState_out = Medium_shell.setState_phX(pShell_out, shell_out.h_outflow, shell_out.Xi_outflow);

  TTube_in = Medium_tube.temperature(tubeState_in);
  TTube_out = Medium_tube.temperature(tubeState_out);
  TShell_in = Medium_shell.temperature(shellState_in);
  TShell_out = Medium_shell.temperature(shellState_out);

  // ---------- Boundary conditions --------------------------------------------
  tube_in.m_flow = wTube_in "[kg/s]";
  assert(wTube_in >= 0, "Flow reversal is not supported");
  shell_in.m_flow = wShell_in "[kg/s]";
  assert(wShell_in >= 0, "Flow reversal is not supported");
  -tube_out.m_flow = wTube_out "[kg/s]";
  assert(wTube_out >= 0, "Flow reversal is not supported");
  -shell_out.m_flow = wShell_out "[kg/s]";
  assert(wShell_out >= 0, "Flow reversal is not supported");

  pTube_in = tube_in.p;
  pTube_out = tube_out.p;
  pShell_in = shell_in.p;
  pShell_out = shell_out.p;

  XTube_in = inStream(tube_in.Xi_outflow);
  XTube_out = tube_out.Xi_outflow;
  XShell_in = inStream(shell_in.Xi_outflow);
  XShell_out = shell_out.Xi_outflow;

  hTube_in = inStream(tube_in.h_outflow);
  hTube_out = tube_out.h_outflow;
  hShell_in = inStream(shell_in.h_outflow);
  hShell_out = shell_out.h_outflow;

  // Equations for reverse flow (not used)
  tube_in.h_outflow = inStream(tube_out.h_outflow);
  shell_in.h_outflow = inStream(shell_out.h_outflow);
  tube_in.Xi_outflow = inStream(tube_out.Xi_outflow);
  shell_in.Xi_outflow = inStream(shell_out.Xi_outflow);

  // Intermediate variables
  MTube = Medium_tube.density(tubeState_in)*Vf;
  MShell = Medium_shell.density(shellState_in)*Vf;
  UTube = Medium_tube.specificInternalEnergy(tubeState_in)*MTube;
  UShell = Medium_shell.specificInternalEnergy(shellState_in)*MShell;

  QTube_gained = -(wTube_in*hTube_in - wTube_out*hTube_out);
  QShell_lost = (wShell_in*hShell_in - wShell_out*hShell_out);

  TTube_mean = (TTube_in + TTube_out)/2;
  TShell_mean = (TShell_in + TShell_out)/2;

  // Pressure drop across the heat exchanger
  dpTube = coeff_dpTube*wTube_in^2;
  dpShell = coeff_dpShell*wShell_in^2;
  pTube_out = pTube_in - dpTube;
  pShell_out = pShell_in - dpShell;

  // ----- Mass balances ------
  //der(MTube) = wTube_in - wTube_out;
  //der(MShell) = wShell_in - wShell_out;
  0 = wTube_in - wTube_out;
  0 = wShell_in - wShell_out;

  // ----- Independent component mass balances -----
  XTube_in = XTube_out;
  XShell_in = XShell_out;

  // ----- Energy balances ------
  //der(UTube) = (wTube_in*hTube_in - wTube_out*hTube_out) + AhTube*(Tm - TTube_mean);
  //der(UShell) = (wShell_in*hShell_in - wShell_out*hShell_out) + AhShell*(Tm - TShell_mean);
  0 = (wTube_in*hTube_in - wTube_out*hTube_out) + AhTube*(Tm - TTube_mean);
  0 = (wShell_in*hShell_in - wShell_out*hShell_out) + AhShell*(Tm - TShell_mean);

  Vm*rhom*cpm*der(Tm) = -AhTube*(Tm - TTube_mean) - AhShell*(Tm - TShell_mean);

  //Vm*rhom*cpm*der(Tm) = (wTube_in*hTube_in - wTube_out*hTube_out) + (wShell_in*hShell_in - wShell_out*hShell_out);

  //AhTube = AhShell;
  //TTube_out = TShell_in - 15;

initial equation
  //der(MTube) = 0;
  //der(MShell) = 0;
  //der(UTube) = 0;
  //der(UShell) = 0;

  if initOpt == Electrolysis.Utilities.OptionsInit.noInit then
    // do nothing
  elseif initOpt == Electrolysis.Utilities.OptionsInit.userSpecified then

  elseif initOpt == Electrolysis.Utilities.OptionsInit.steadyState then

    der(Tm) = 0;

  else

    assert(false, "Unsupported initialisation option");

  end if;

    annotation (
     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
         graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={238,46,47}),
        Text(
          extent={{-100,-123},{100,-153}},
          lineColor={0,0,255},
          textString="%name"),
        Line(
          points={{-6.12323e-015,100},{0,40},{40,20},{-40,-20},{0,-40},{6.12323e-015,
              -100}},
          color={0,0,255},
          thickness=0.5,
          origin={0,0},
          rotation=90)}));
end HEX_anodeGasRecup_ROM_NHES;
