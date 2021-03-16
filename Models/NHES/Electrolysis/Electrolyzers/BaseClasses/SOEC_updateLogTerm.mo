within NHES.Electrolysis.Electrolyzers.BaseClasses;
model SOEC_updateLogTerm
  "Solid Oxide Electrolysis Cell (SOEC) stack model"

  extends Electrolysis.Icons.Electrolyzer;
  import      Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package MediumCathode =
  Electrolysis.Media.Electrolysis.CathodeGas constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model for cathode gas" annotation (Dialog(group="Working fluids (Medium)"));
  replaceable package MediumAnode =
  Electrolysis.Media.Electrolysis.AnodeGas_air constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model for anode gas" annotation (Dialog(group="Working fluids (Medium)"));

  // ---------- Define constants -----------------------------------------------
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataH2=gasProperties.H2;
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataH2O=gasProperties.H2O;
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataO2=gasProperties.O2;
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataN2=gasProperties.N2;
  constant Real Rg(final unit="J/(mol.K)") = Modelica.Constants.R
    "Molar gas constant";
  constant Real Fa = Modelica.Constants.F
    "Faraday constant [C/mol] or [J/(V.mol)]";
  constant SI.SpecificEnthalpy Hf_H2O_gas = Modelica.Media.IdealGases.Common.SingleGasesData.H2O.Hf
    "Heat of formation for H2O (steam) [J/kg]";
  constant SI.SpecificEnthalpy Hrxn_electrolysis_per_H2Oconsumed = -Hf_H2O_gas
    "Heat of reaction of electrolysis per H2O (kg) consumed [J/kg]";
  constant Integer numElecTransferred_per_H2prod = 2
    "Number of electrons transferred per molecule of H2 produced";
  constant SI.MolarMass mwH2O = gasProperties.H2O.MM
    "Molecular weight of water or steam [kg/mol]";
  constant SI.MolarMass mwH2 = gasProperties.H2.MM
    "Molecular weight of hydrogen [kg/mol]";
  constant SI.MolarMass mwO2 = gasProperties.O2.MM
    "Molecular weight of oxygen [kg/mol]";
  constant SI.MolarMass mwN2 = gasProperties.N2.MM
    "Molecular weight of nitrogen [kg/mol]";
  constant Real sigma(final unit="W/(m2.K4)") = Modelica.Constants.sigma
    "Stefan-Boltzmann constant [W/(m2.K4)]";

  // ---------- Define parameters ----------------------------------------------
  parameter Electrolysis.Utilities.OptionsInit.Temp initOpt=
      Electrolysis.Utilities.OptionsInit.noInit "Type of initialization"
                             annotation (Dialog(tab="Initialisation"));

  // ----- Cell stack specifications -----
  parameter SI.Length Wcell = 0.15 "Stack cell width [m]" annotation (Dialog(group="SOEC stack"));
  parameter SI.Length Lcell = 0.15 "Stack cell length [m]" annotation (Dialog(group="SOEC stack"));
  final parameter SI.Area Acell_active_m2 = Wcell*Lcell "Active cell area [m2]";
  final parameter Electrolysis.Types.Area_cm2 Acell_active=
      Acell_active_m2*10000 "Active cell area [cm2]";
  parameter SI.Thickness thicknessCathode = 500*1e-6 "Cathode thickness [m]" annotation (Dialog(group="SOEC stack"));
  parameter SI.Thickness thicknessElectrolyte = 20*1e-6
    "Electrolyte thickness [m]" annotation (Dialog(group="SOEC stack"));
  parameter SI.Thickness thicknessAnode = 50*1e-6 "Anode thickness [m]" annotation (Dialog(group="SOEC stack"));
  parameter SI.Thickness lC = 0.001 "Cathode channel height [m]" annotation (Dialog(group="SOEC stack"));
  parameter SI.Thickness lA = 0.001 "Anode channel height [m]" annotation (Dialog(group="SOEC stack"));
  parameter SI.Thickness lI = 500*1e-6 "Interconnect thickness [m]" annotation (Dialog(group="SOEC stack"));
  final parameter SI.Thickness lS = thicknessCathode + thicknessElectrolyte + thicknessAnode
    "Solid structure thickness [m]";
  final parameter SI.Volume VC = Acell_active_m2*lC
    "Aathode channel volume [m3]";
  final parameter SI.Volume VA = Acell_active_m2*lA "Anode channel volume [m3]";
  final parameter SI.Volume VS = Acell_active_m2*lS
    "Solid structure volume [m3]";
  final parameter SI.Volume VI = Acell_active_m2*lI "Interconnect volume [m3]";
  final parameter SI.Diameter dhC = 2*Wcell*lC/(Wcell+lC)
    "Hydraulic diameter of the cathode gas channel [m]";
  final parameter SI.Diameter dhA = 2*Wcell*lA/(Wcell+lA)
    "Hydraulic diameter of the anode gas channel [m]";
  parameter Electrolysis.Types.ElecConductivity conductivityC=80000
    "Cathode electric conductivity [ohm-1.m-1]"
    annotation (Dialog(group="SOEC stack"));
  parameter Electrolysis.Types.ElecConductivity conductivityA=8400
    "Anode electric conductivity [ohm-1.m-1]"
    annotation (Dialog(group="SOEC stack"));
  parameter SI.NusseltNumber NuC = 3.09 "Cathode stream Nusselt number []" annotation (Dialog(group="Working fluids (Medium)"));
  parameter SI.NusseltNumber NuA = 3.09 "Anode stream Nusselt number []" annotation (Dialog(group="Working fluids (Medium)"));
  parameter SI.ThermalConductivity kC = 0.1936
    "Cathode stream thermal conductivity [W/(m.K)]" annotation (Dialog(group="Working fluids (Medium)"));
  parameter SI.ThermalConductivity kA = 0.06866
    "Anode stream thermal conductivity [W/(m.K)]" annotation (Dialog(group="Working fluids (Medium)"));
  parameter SI.ThermalConductivity kS = 2
    "Solid structure thermal conductivity [W/(m.K)]" annotation (Dialog(group="SOEC stack"));
  parameter SI.ThermalConductivity kI = 25
    "Interconnect thermal conductivity [W/(m.K)]" annotation (Dialog(group="SOEC stack"));
  final parameter SI.CoefficientOfHeatTransfer hC = NuC*kC/dhC
    "Convective heat transfer coefficient betweeen the solid parts of the cell and the cathode stream[W/(m2.K)]";
  final parameter SI.CoefficientOfHeatTransfer hA = NuA*kA/dhA
    "Convective heat transfer coefficient betweeen the solid parts of the cell and the anode stream[W/(m2.K)]";
  parameter SI.Emissivity emissivityS = 0.8 "Solid structure emissivity []" annotation (Dialog(group="SOEC stack"));
  parameter SI.Emissivity emissivityI = 0.1 "Interconnect emissivity []" annotation (Dialog(group="SOEC stack"));
  parameter SI.Density rhoS = 5900 "Solid structure density [kg/m3]" annotation (Dialog(group="SOEC stack"));
  parameter SI.Density rhoI = 8000 "Interconnect density [kg/m3]" annotation (Dialog(group="SOEC stack"));
  parameter SI.SpecificHeatCapacity cpS = 500
    "Solid structure specific heat capacity [J/(kg.K)]" annotation (Dialog(group="SOEC stack"));
  parameter SI.SpecificHeatCapacity cpI = 500
    "Interconnect specific heat capacity [J/(kg.K)]" annotation (Dialog(group="SOEC stack"));
  parameter Integer numCells_perVessel "Total number of cells per vessel []" annotation (Dialog(group="SOEC stack"));
  parameter Integer numVessels "Number of online vessels per system []" annotation (Dialog(group="SOEC stack"));

  // ----- Operating conditions -----
  final parameter SI.Frequency f0 = 60 "Nominal frequency";
  parameter SI.Pressure pstartCathodeIn=1.964e6
    "Start value of inlet pressure at cathode [Pa]"
    annotation (Dialog(tab="Initialisation"));
  final parameter SI.Pressure pstartCathodeOut = pstartCathodeIn
    "Start value of outlet pressure at cathode [Pa]"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.Pressure pstartAnodeIn = 1.964e6
    "Start value of inlet pressure at anode [Pa]"
    annotation (Dialog(tab="Initialisation"));
  final parameter SI.Pressure pstartAnodeOut = pstartAnodeIn
    "Start value of outlet pressure at anode [Pa]"
    annotation (Dialog(tab="Initialisation"));
  final parameter SI.Pressure pstartCathodeAvg = (pstartCathodeIn + pstartCathodeOut)/2
    "Start value of average pressure at cathode [Pa]";
  final parameter SI.Pressure pstartAnodeAvg = (pstartAnodeIn + pstartAnodeOut)/2
    "Start value of average pressure at anode [Pa]";

  parameter Modelica.Units.NonSI.Temperature_degC TCstartIn_C=850
    "Start value of temperature in Celsius at cathode - in"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.NonSI.Temperature_degC TCstartOut_C=750
    "Start value of temperature in Celsius at cathode - out"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.NonSI.Temperature_degC TAstartIn_C=850
    "Start value of temperature in Celsius at anode - in"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.NonSI.Temperature_degC TAstartOut_C=749.492
    "Start value of temperature in Celsius at anode - out"
    annotation (Dialog(tab="Initialisation"));
  final parameter Modelica.Units.NonSI.Temperature_degC TSstartIn_C=(
      TCstartIn_C + TAstartIn_C)/2
    "Start value of temperature in Celsius at solid structure - in"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.NonSI.Temperature_degC TSstartOut_C=748.368
    "Start value of temperature in Celsius at solid structure - out"
    annotation (Dialog(tab="Initialisation"));
  final parameter Modelica.Units.NonSI.Temperature_degC TIstartIn_C=(
      TCstartIn_C + TAstartIn_C)/2
    "Start value of temperature in Celsius at interconnect - in"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.NonSI.Temperature_degC TIstartOut_C=749.69
    "Start value of temperature in Celsius at interconnect - out"
    annotation (Dialog(tab="Initialisation"));
  final parameter SI.Temperature TCstartIn_K=
      Modelica.Units.Conversions.from_degC(TCstartIn_C)
    "Start value of temperature in Kelvin at cathode - in";
  final parameter SI.Temperature TCstartOut_K=
      Modelica.Units.Conversions.from_degC(TCstartOut_C)
    "Start value of temperature in Kelvin at cathode - out";
  final parameter SI.Temperature TCstartAvg_K = (TCstartIn_K + TCstartOut_K)/2
    "Start value of average temperature in Kelvin at cathode";
  final parameter SI.Temperature TAstartIn_K=
      Modelica.Units.Conversions.from_degC(TAstartIn_C)
    "Start value of temperature in Kelvin at anode - in";
  final parameter SI.Temperature TAstartOut_K=
      Modelica.Units.Conversions.from_degC(TAstartOut_C)
    "Start value of temperature in Kelvin at anode - out";
  final parameter SI.Temperature TAstartAvg_K = (TAstartIn_K + TAstartOut_K)/2
    "Start value of average temperature in Kelvin at anode";
  final parameter SI.Temperature TSstartIn_K=
      Modelica.Units.Conversions.from_degC(TSstartIn_C)
    "Start value of temperature in Kelvin at solid structure - in";
  final parameter SI.Temperature TSstartOut_K=
      Modelica.Units.Conversions.from_degC(TSstartOut_C)
    "Start value of temperature in Kelvin at solid structure - out";
  final parameter SI.Temperature TSstartAvg_K= (TSstartIn_K + TSstartOut_K)/2
    "Start value of average temperature in Kelvin at solid structure";
  final parameter SI.Temperature TIstartIn_K=
      Modelica.Units.Conversions.from_degC(TIstartIn_C)
    "Start value of temperature in Kelvin at interconnect - in";
  final parameter SI.Temperature TIstartOut_K=
      Modelica.Units.Conversions.from_degC(TIstartOut_C)
    "Start value of temperature in Kelvin at interconnect - out";
  final parameter SI.Temperature TIstartAvg_K= (TIstartIn_K + TIstartOut_K)/2
    "Start value of average temperature in Kelvin at interconnect";

  parameter SI.MoleFraction yH2startCathodeIn=0.1
    "Start value of H2 inlet mole fraction of the cathode stream"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.MoleFraction yO2startAnodeIn=0.21
    "Start value of O2 inlet mole fraction of the anode stream"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.MoleFraction yH2startCathodeOut=0.82
    "Start value of H2 inlet mole fraction of the cathode stream"
                                                                 annotation (Dialog(tab="Initialisation"));
  parameter SI.MoleFraction yO2startAnodeOut=0.29678
    "Start value of O2 outlet mole fraction of the anode gas"
                                                             annotation (Dialog(tab="Initialisation"));

  final parameter SI.MoleFraction ystartCathodeIn[:]={yH2startCathodeIn,1 -
      yH2startCathodeIn}
    "Start value of inlet gas mole Fraction at cathode {H2, H2O}";
  final parameter SI.MoleFraction ystartCathodeOut[:]={yH2startCathodeOut,1 -
      yH2startCathodeOut}
    "Start value of outlet gas mole Fraction at cathode {H2, H2O}";
  final parameter SI.MoleFraction ystartAnodeIn[:]={1 - yO2startAnodeIn,
      yO2startAnodeIn}
    "Start value of inlet gas mole Fraction at anode {N2, O2}";
  final parameter SI.MoleFraction ystartAnodeOut[:]={1 - yO2startAnodeOut,
      yO2startAnodeOut}
    "Start value of outlet gas mole Fraction at anode {N2, O2}";
  final parameter SI.MassFraction XstartCathodeIn[:]=
      Electrolysis.Utilities.moleToMassFractions(ystartCathodeIn, {mwH2*1000,
      mwH2O*1000}) "Start value of inlet mass Fraction at cathode {H2, H2O}";
  final parameter SI.MassFraction XstartCathodeOut[:]=
      Electrolysis.Utilities.moleToMassFractions(ystartCathodeOut, {mwH2*1000,
      mwH2O*1000}) "Start value of outlet mass Fraction at cathode {H2, H2O}";
  final parameter SI.MassFraction XstartCathodeAvg[:] = (XstartCathodeIn + XstartCathodeOut)/2
    "Start value of average mass Fraction at cathode {H2, H2O}";
  final parameter SI.MassFraction XstartAnodeIn[:]=
      Electrolysis.Utilities.moleToMassFractions(ystartAnodeIn, {mwN2*1000,mwO2*
      1000}) "Start value of inlet mass Fraction at anode {N2, O2}";
  final parameter SI.MassFraction XstartAnodeOut[:]=
      Electrolysis.Utilities.moleToMassFractions(ystartAnodeOut, {mwN2*1000,
      mwO2*1000}) "Start value of outlet mass Fraction at anode {N2, O2}";
  final parameter SI.MassFraction XstartAnodeAvg[:]= (XstartAnodeIn + XstartAnodeOut)/2
    "Start value of average mass Fraction at anode {N2, O2}";

  parameter SI.MassFlowRate wstartCathodeIn = 0.908085
    "Start value of H2/H2O inlet mass flow rate at cathode [kg/s]"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.MassFlowRate wstartCathodeOut = 0.270831
    "Start value of H2/H2O outlet mass flow rate at cathode [kg/s]"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.MassFlowRate wstartAnodeIn = 4.65587
    "Start value of N2/O2 inlet mass flow rate at anode [kg/s]"
    annotation (Dialog(tab="Initialisation"));
  final parameter SI.MassFlowRate wstartAnodeOut = wstartCathodeIn + wstartAnodeIn -
      wstartCathodeOut
    "Start value of N2/O2 outlet mass flow rate at anode [kg/s]";

  final parameter SI.SpecificEnthalpy hstartCathodeIn=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2,
      TCstartIn_K,
      excludeEnthalpyOfFormation)*XstartCathodeIn[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2O,
      TCstartIn_K,
      excludeEnthalpyOfFormation)*XstartCathodeIn[2]
    "Start value of specific enthalpy for inlet cathode gas [J/kg]";
  final parameter SI.SpecificEnthalpy hstartCathodeOut=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2,
      TCstartOut_K,
      excludeEnthalpyOfFormation)*XstartCathodeOut[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2O,
      TCstartOut_K,
      excludeEnthalpyOfFormation)*XstartCathodeOut[2]
    "Start value of specific enthalpy for outlet cathode gas [J/kg]";
  final parameter SI.SpecificEnthalpy hstartCathodeAvg=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2,
      TCstartAvg_K,
      excludeEnthalpyOfFormation)*XstartCathodeAvg[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataH2O,
      TCstartAvg_K,
      excludeEnthalpyOfFormation)*XstartCathodeAvg[2]
    "Start value of average specific enthalpy for cathode gas [J/kg]";
  final parameter SI.SpecificEnthalpy hstartAnodeIn=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataN2,
      TAstartIn_K,
      excludeEnthalpyOfFormation)*XstartAnodeIn[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataO2,
      TAstartIn_K,
      excludeEnthalpyOfFormation)*XstartAnodeIn[2]
    "Start value of specific enthalpy for inlet anode gas [J/kg]";
  final parameter SI.SpecificEnthalpy hstartAnodeOut=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataN2,
      TAstartOut_K,
      excludeEnthalpyOfFormation)*XstartAnodeOut[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataO2,
      TAstartOut_K,
      excludeEnthalpyOfFormation)*XstartAnodeOut[2]
    "Start value of specific enthalpy for outlet anode gas [J/kg]";
  final parameter SI.SpecificEnthalpy hstartAnodeAvg=
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataN2,
      TAstartAvg_K,
      excludeEnthalpyOfFormation)*XstartAnodeAvg[1] +
      Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
      dataO2,
      TAstartAvg_K,
      excludeEnthalpyOfFormation)*XstartAnodeAvg[2]
    "Start value of average specific enthalpy for anode gas [J/kg]";

  // ---------- Connectors -----------------------------------------------------
  Modelica.Fluid.Interfaces.FluidPort_a
                          cathodeFlangeIn(p(start = pstartCathodeIn),
   h_outflow(start = hstartCathodeIn),
   Xi_outflow(start = XstartCathodeIn),
    redeclare package Medium = MediumCathode) annotation (Placement(
        transformation(extent={{-84,20},{-64,40}}),  iconTransformation(extent={{-84,20},
            {-64,40}})));

  Modelica.Fluid.Interfaces.FluidPort_b
                          cathodeFlangeOut(p(start = pstartCathodeOut),
   h_outflow(start = hstartCathodeOut),
   Xi_outflow(start = XstartCathodeOut),
    redeclare package Medium = MediumCathode) annotation (Placement(
        transformation(extent={{64,40},{82,58}}),  iconTransformation(extent={{64,40},
            {84,60}})));

  Modelica.Fluid.Interfaces.FluidPort_a
                          anodeFlangeIn(p(start=pstartAnodeIn),
    h_outflow(start=hstartAnodeIn),
    Xi_outflow(start=XstartAnodeIn),
    redeclare package Medium = MediumAnode) annotation (Placement(
        transformation(extent={{-84,-64},{-64,-44}}),  iconTransformation(
          extent={{-84,-64},{-64,-44}})));
  Modelica.Fluid.Interfaces.FluidPort_b
                          anodeFlangeOut(p(start=pstartAnodeOut),
    h_outflow(start=hstartAnodeOut),
    Xi_outflow(start=XstartAnodeOut),
    redeclare package Medium = MediumAnode) annotation (Placement(
        transformation(extent={{64,-42},{82,-22}}),  iconTransformation(extent={{64,-44},
            {84,-24}})));

  Interfaces.ElectricalPowerPort_a electricalLoad annotation (Placement(
        transformation(extent={{-86,-20},{-66,0}}), iconTransformation(extent={
            {-86,-20},{-66,0}})));

  /*
  Modelica.Blocks.Interfaces.RealInput power_set(
    final quantity="Power",
    final unit="W",
    min=0,
    displayUnit="MW") "electrical power set point [MWe]" annotation (Placement(
        transformation(extent={{-122,-40},{-82,0}}), iconTransformation(extent={
            {-102,-20},{-82,0}})));
  */

  // ---------- Declare variables ----------------------------------------------
  // ------ Electrochemical model -----
  Electrolysis.Types.CurrentDensity_cm2 j_stack_cm2(
    min=0.1,
    max=1.6,
    start=0.5) "Average current density of the stack [A/cm2]";
  Electrolysis.Types.CurrentDensity_cm2 j0_cathode_cm2(min=0, start=
        0.45796) "Exchange current density of the cathode [A/cm2]";
  Electrolysis.Types.CurrentDensity_cm2 j0_anode_cm2(min=0, start=
        0.230382) "Exchange current density of the anode [A/cm2]";
  SI.ElectricPotential lossActOPcathode( min = 0, start = 0.0482256)
    "Activation overpotential(OP) loss at the cathode [V]";
  SI.ElectricPotential lossActOPanode( min = 0, start = 0.0868923)
    "Activation overpotential(OP) loss at the anode [V]";
  Electrolysis.Types.ElecConductivity conductivityElectrolyte(min=0,
      start=2.25037) "Electrolyte ionic conductivity [ohm-1.m-1]";
  Electrolysis.Types.AreaSpecificResistance_cm2 Rohm_cm2(min=0, start=
        0.0889964)
    "Total resistance of the cell including electric and ionic resistances [Ohm.cm2]";
  Electrolysis.Types.AreaSpecificResistance_cm2 ASR(min=0, start=
        0.359232) "Area specific resistance [Ohm.cm2]";

  SI.ElectricPotential Vn_isothermal(min=0.7,max=1.6)
    "Nernst potential at isothermal condition [V]";
  SI.ElectricPotential Vn(min=0.7,max=1.6)
    "Single-cell open-cell (Nernst) potential [V]";
  SI.ElectricPotential Vop_single(min=0.5) "Single-cell operating voltage [V]";
  SI.ElectricPotential Vop_overall "Overall stack operating voltage [V]";
  SI.ElectricCurrent I(min=0, start=112.5) "current [A]";
  SI.Power W_elec(min=0, start=9.10627*1e6)
    "Electrical power provided to the SOEC stacks per vessel [W]";
  SI.Power W_elec_total(min=0, start=9.10627*1e6*5)
    "Total electrical load in the SOEC stacks [W]";
  SI.Frequency f "Frequency [Hz]";

  SI.Pressure pCathodeIn( min=101325, start=pstartCathodeIn)
    "Inlet pressure of the cathode stream [Pa]";
  SI.Pressure pCathodeOut(min=101325, start=pstartCathodeOut)
    "Outlet pressure of the cathode stream [Pa]";
  SI.Pressure pCathodeAvg(min=101325, start=pstartCathodeAvg)
    "Average pressure of the cathode stream [Pa]";
  SI.Pressure pAnodeIn(min=101325, start=pstartAnodeIn)
    "Inlet pressure of the anode stream [Pa]";
  SI.Pressure pAnodeOut(min=101325, start=pstartAnodeOut)
    "Outlet pressure of the anode stream [Pa]";
  SI.Pressure pAnodeAvg(min=101325, start=pstartAnodeAvg)
    "Outlet pressure of the anode stream [Pa]";

  SI.Temperature TCin(min=273.15+25,nominal=1000,start=TCstartIn_K);
  SI.Temperature TCout(min=273.15+25,nominal=1000,start=TCstartOut_K);
  SI.Temperature TAin(min=273.15+25,nominal=1000,start=TAstartIn_K);
  SI.Temperature TAout(min=273.15+25,nominal=1000,start=TAstartOut_K);
  SI.Temperature TSin(  min=650+273.15,max=1050+273.15,nominal=1000,start=TSstartIn_K)
    "Inlet temperature of soild structure [K]";
  SI.Temperature TSout( min=550+273.15,max=950+273.15,nominal=1000,start=TSstartOut_K)
    "Outlet temperature of soild structure [K]";
  SI.Temperature TIin(  min=650+273.15,max=1050+273.15,nominal=1000,start=TIstartIn_K)
    "Inlet temperature of interconnect [K]";
  SI.Temperature TIout( min=550+273.15,max=950+273.15,nominal=1000,start=TIstartOut_K)
    "Outlet temperature of interconnect [K]";
  SI.Temperature TCavg( start=TCstartAvg_K, nominal = 1000)
    "Mean temperature of the cathode gas [K]";
  SI.Temperature TAavg( start=TAstartAvg_K, nominal = 1000)
    "Mean temperature of the anode gas [K]";
  SI.Temperature TSavg( start=TSstartAvg_K, nominal = 1000)
    "Mean temperature of the solid structure [K]";
  SI.Temperature TIavg( start=TIstartAvg_K, nominal = 1000)
    "Mean temperature of the interconnect [K]";

  SI.MassFraction XcathodeIn[MediumCathode.nX](min={0,0},max={1,1}, start=XstartCathodeIn, nominal={0.012,0.988});
  SI.MassFraction XcathodeOut[MediumCathode.nX](min={0,0},max={1,1}, start=XstartCathodeOut, nominal={0.337,0.663});
  SI.MassFraction XcathodeAvg[MediumCathode.nX](min={0,0},max={1,1}, start=XstartCathodeAvg, nominal={0.175,0.825});
  SI.MassFraction XanodeIn[MediumAnode.nX](min={0,0},max={1,1}, start=XstartAnodeIn, nominal={0.767,0.233});
  SI.MassFraction XanodeOut[MediumAnode.nX](min={0,0},max={1,1}, start=XstartAnodeOut, nominal={0.704,0.296});
  SI.MassFraction XanodeAvg[MediumAnode.nX](min={0,0},max={1,1}, start=XstartAnodeAvg, nominal={0.735,0.265});
  SI.MoleFraction ycathodeIn[MediumCathode.nX](min={0,0},max={1,1}, start=ystartCathodeIn, nominal={0.1,0.9})
    "Inlet mole fraction of cathode stream";
  SI.MoleFraction ycathodeOut[MediumCathode.nX](min={0,0},max={1,1}, start=ystartCathodeOut, nominal={0.82,0.18})
    "Outlet mole fraction of cathode stream";
  SI.MoleFraction yanodeIn[MediumAnode.nX](min={0,0},max={1,1}, start=ystartAnodeIn, nominal={0.79,0.21})
    "Inlet mole fraction of anode gas";
  SI.MoleFraction yanodeOut[MediumAnode.nX](min={0,0},max={1,1}, start=ystartAnodeOut, nominal={0.703,0.297})
    "Outlet mole fraction of anode gas";
  SI.MoleFraction yH2_cathodeIn(min = 0, start=0.1)
    "Inlet mole fraction of hydrogen - cathode []";
  SI.MoleFraction yH2_cathodeOut(min = 0, start=0.82)
    "Outlet mole fraction of hydrogen - cathode []";
  SI.MoleFraction yH2O_cathodeIn(min = 0, start=0.9)
    "Inlet mole fraction of steam - cathode []";
  SI.MoleFraction yH2O_cathodeOut(min = 0, start=0.18)
    "Outlet mole fraction of steam - cathode []";
  SI.MoleFraction yO2_anodeIn(min = 0, start=0.21)
    "Inlet mole fraction of oxygen - anode []";
  SI.MoleFraction yO2_anodeOut(min = 0, start=0.297)
    "Outlet mole fraction of oxygen - anode []";
  SI.MoleFraction yN2_anodeIn(min = 0, start=0.79)
    "Inlet mole fraction of nitrogen - anode []";
  SI.MoleFraction yN2_anodeOut(min = 0, start=0.703)
    "Outlet mole fraction of nitrogen - anode []";
  Real yaIn(start=4.07, unit="1") "Lumped inlet mole fraction of oxygen []";
  Real yaOut( start=5.75, unit="1") "Lumped outlet mole fraction of oxygen []";

  SI.MolarMass mw_cathodeIn "Inlet molecular weight of cathode stream [kg/mol]";
  SI.MolarMass mw_cathodeOut
    "Outlet molecular weight of cathode stream [kg/mol]";
  SI.MolarMass mw_anodeIn "Inlet molecular weight of anode gas [kg/mol]";
  SI.MolarMass mw_anodeOut "Outlet molecular weight of anode gas [kg/mol]";

  SI.SpecificEnthalpy hCathodeIn(start=hstartCathodeIn)
    "Inlet enthalpy of cathode stream [J/kg]";
  SI.SpecificEnthalpy hCathodeOut(start=hstartCathodeOut)
    "Outlet enthalpy of cathode stream [J/kg]";
  SI.SpecificEnthalpy hCathodeAvg(start=hstartCathodeAvg)
    "Average enthalpy of cathode stream [J/kg]";
  SI.SpecificEnthalpy hAnodeIn(start=hstartAnodeIn)
    "Inlet enthalpy of anode stream [J/kg]";
  SI.SpecificEnthalpy hAnodeOut(start=hstartAnodeOut)
    "Outlet enthalpy of anode stream [J/kg]";
  SI.SpecificEnthalpy hAnodeAvg(start=hstartAnodeAvg)
    "Average enthalpy of anode stream [J/kg]";

  SI.MassFlowRate wCathodeIn(min=0, start=wstartCathodeIn)
    "H2/H2O inlet mass flow rate of cathode stream [kg/s]";
  SI.MassFlowRate wCathodeOut(min=0,start=wstartCathodeOut)
    "H2/H2O outlet mass flow rate of cathode stream [kg/s]";
  SI.MassFlowRate wAnodeIn(min=0, start=wstartAnodeIn)
    "H2O/O2 inlet mass flow rate of anode gas [kg/s]";
  SI.MassFlowRate wAnodeOut(min=0,start=wstartAnodeOut)
    "H2O/O2 outlet mass flow rate of anode gas [kg/s]";
  SI.MolarFlowRate N_cathodeIn(min=0,start=55.3193)
    "H2/H2O inlet molar flow rate of cathode stream [mol/s]";
  SI.MolarFlowRate N_cathodeOut(min=0,start=55.393)
    "H2/H2O outlet molar flow rate of cathode stream [mol/s]";
  SI.MolarFlowRate N_anodeIn(min=0,start=161.38)
    "H2O/O2 inlet molar flow rate of anode gas [mol/s]";
  SI.MolarFlowRate N_anodeOut(min=0,start=181.295)
    "H2O/O2 inlet molar flow rate of anode gas [mol/s]";

  SI.Density rho_CathodeIn(min = 0,start = MediumCathode.density(stateCathodeInStart))
    "Inlet density of cathode stream [kg/m3]";
  SI.Density rho_CathodeOut(min = 0,start= MediumCathode.density(stateCathodeOutStart))
    "Outlet density of cathode stream [kg/m3]";
  SI.Density rho_CathodeAvg( min = 0, start= MediumCathode.density(stateCathodeAvgStart))
    "average density of cathode stream [kg/m3]";
  SI.Density rho_AnodeIn(min = 0, start = MediumAnode.density(stateAnodeInStart))
    "Inlet density of anode stream [kg/m3]";
  SI.Density rho_AnodeOut( min = 0, start = MediumAnode.density(stateAnodeOutStart))
    "Outlet density of anode stream [kg/m3]";
  SI.Density rho_AnodeAvg( min = 0, start = MediumAnode.density(stateAnodeAvgStart))
    "Average density of anode stream [kg/m3]";

  SI.SpecificHeatCapacity cpC( min = 0, start=4577.89)
    "Cathode stream specific heat capacity - average [J/(kg.K)]";
  SI.SpecificHeatCapacity cpA( min = 0, start=1159.02)
    "Anode stream specific heat capacity - average [J/(kg.K)]";

  SI.MolarFlowRate deltaN_O2
    "O2  produced(positive)/consumed(negative) during electrolysis [mol/s]";
  SI.MolarFlowRate deltaN_H2
    "H2  produced(positive)/consumed(negative) during electrolysis [mol/s]";
  SI.MolarFlowRate deltaN_H2O
    "H2O produced(positive)/consumed(negative) during electrolysis [mol/s]";
  SI.MolarFlowRate N_H2_cathodeIn(min=0)
    "Inlet molar flow of hydrogen -cathode [mol/s]";
  SI.MolarFlowRate N_H2O_cathodeIn(min=0)
    "Inlet molar flow of steam - cathode [mol/s]";
  SI.MolarFlowRate N_H2_cathodeOut(min=0)
    "Outlet molar flow of hydrogen - cathode [mol/s]";
  SI.MolarFlowRate N_H2O_cathodeOut(min=0)
    "Outlet molar flow of steam - cathode [mol/s]";
  SI.MolarFlowRate N_O2_anodeIn(min=0)
    "Inlet molar flow of oxygen - anode [mol/s]";
  SI.MolarFlowRate N_N2_anodeIn(min=0)
    "Inlet molar flow of nitrogen - anode [mol/s]";
  SI.MolarFlowRate N_O2_anodeOut(min=0)
    "Outlet molar flow of oxygen - anode [mol/s]";
  SI.MolarFlowRate N_N2_anodeOut(min=0)
    "Outlet molar flow of nitrogen - anode [mol/s]";
  SI.AmountOfSubstance N_H2_cathode(min=0)
    "Total number of substance in cathode channel - H2 [mol]";
  SI.AmountOfSubstance N_H2O_cathode(min=0)
    "Total number of substance in cathode channel - H2O [mol]";
  SI.AmountOfSubstance N_N2_anode(min=0)
    "Total number of substance in anode channel - N2 [mol]";
  SI.AmountOfSubstance N_O2_anode(min=0)
    "Total number of substance in anode channel - O2 [mol]";

  SI.MassFlowRate deltaM_O2
    "O2  produced(positive)/consumed(negative) during electrolysis [kg/s]";
  SI.MassFlowRate deltaM_H2
    "H2  produced(positive)/consumed(negative) during electrolysis [kg/s]";
  SI.MassFlowRate deltaM_H2O
    "H2O produced(positive)/consumed(negative) during electrolysis [kg/s]";

  SI.EnthalpyFlowRate deltaH_cathode
    "Change in enthalpy of cathode stream [J/s] or [W]";
  SI.EnthalpyFlowRate deltaH_anode
    "Change in enthalpy of anode stream [J/s] or [W]";
  SI.EnthalpyFlowRate deltaH_system
    "Change in enthalpy of the system, excluding the heat of rxn. [J/s] or [W]";
  SI.EnthalpyFlowRate Hrxn_electrolysis
    "Heat of reaction during eletrolysis [J/s] or [W]";
  SI.EnthalpyFlowRate deltaH_electrolysis
    "Change in enthalpy of the electrolyzer, including the heat of rxn. [J/s] or [W]";

  Electrolysis.Types.ElectrolysisEfficiency etaElectrolysis(min=0)
    "Electrolysis efficiency [%]";

  Real airRatio(min=0.4,max=14,unit="1")
    "Ratio between the moles of O2 contained in the inlet air flow to that produced in the unit cell, per unit time []";
  Electrolysis.Types.SteamUtilization SUfactor(start=80)
    "Steam utilization factor, i.e. the fraction of total inlet steam consumed during electrolysis [%]";
  Electrolysis.Types.SteamUtilization SUfactor_est(start=80)
    "Estimated steam utilization factor based on the steady-state conditions [%]";

  // ----- Initial states for gas streams -----
protected
  final parameter MediumCathode.ThermodynamicState stateCathodeInStart = MediumCathode.setState_phX(pstartCathodeIn, hstartCathodeIn, XstartCathodeIn);
  final parameter MediumCathode.ThermodynamicState stateCathodeOutStart = MediumCathode.setState_phX(pstartCathodeOut, hstartCathodeOut, XstartCathodeOut);
  final parameter MediumCathode.ThermodynamicState stateCathodeAvgStart = MediumCathode.setState_pTX(pstartCathodeAvg, TCstartAvg_K, XstartCathodeAvg);
  final parameter MediumAnode.ThermodynamicState stateAnodeInStart = MediumAnode.setState_phX(pstartAnodeIn, hstartAnodeIn, XstartAnodeIn);
  final parameter MediumAnode.ThermodynamicState stateAnodeOutStart = MediumAnode.setState_phX(pstartAnodeOut, hstartAnodeOut, XstartAnodeOut);
  final parameter MediumAnode.ThermodynamicState stateAnodeAvgStart = MediumAnode.setState_pTX(pstartAnodeAvg, TAstartAvg_K, XstartAnodeAvg);

  final parameter Boolean excludeEnthalpyOfFormation = true;
  final parameter SI.Pressure p_std = 1.01325*1e5 "Standard pressure [Pa]";

  parameter SI.TemperatureDifference TStol_Vn = 0.1
    "Tolerance to avoid the division by zero in Vn calculation [K]";

  // ----- States for gas streams -----
  MediumCathode.ThermodynamicState stateCathodeIn(p(start=pstartCathodeIn),T(start=TCstartIn_K),X(start=XstartCathodeIn))
    "State for cathode medium inflowing through port_a";
  MediumCathode.ThermodynamicState stateCathodeOut(p(start=pstartCathodeOut),T(start=TCstartOut_K),X(start=XstartCathodeOut))
    "State for cathode medium outflowing through port_b";
  MediumCathode.ThermodynamicState stateCathodeAvg( p(start=pstartCathodeAvg),T(start=TCstartAvg_K),X(start=XstartCathodeAvg))
    "State for cathode medium between port_a and port_b";
  MediumAnode.ThermodynamicState stateAnodeIn(p(start=pstartAnodeIn),T(start=TAstartIn_K),X(start=XstartAnodeIn))
    "State for anode medium inflowing through port_a";
  MediumAnode.ThermodynamicState stateAnodeOut(p(start=pstartAnodeOut),T(start=TAstartOut_K),X(start=XstartAnodeOut))
    "State for anode medium outflowing through port_b";
  MediumAnode.ThermodynamicState stateAnodeAvg( p(start=pstartAnodeAvg),T(start=TAstartAvg_K),X(start=XstartAnodeAvg))
    "State for anode medium between port_a and port_b";

  SI.MolarEnergy deltaGibbsE( start=188710)
    "Gibbs free energy change of the reaction (free enthalpy) [J/mol]";
  Electrolysis.Types.GibbsIntegral IntegraldeltaGibbsE(start=-1.54047*
        1e7)
    "Gibbs free energy change of the reaction (free enthalpy) - integral form [J.K/mol]";
  Real coef_isothermal( start=4.27863*1e-6)
    "Coefficient for Nernst potential (Vn) at isothermal condition";
  Real Integral_y_H2_1( unit="1") "Nernst potential term regarding H2";
  Real Integral_y_H2_2( unit="1") "Nernst potential term regarding H2";
  Real Integral_ya( unit="1") "Nernst potential term regarding O2";
  SI.MoleFraction delta_yH2 "change in yH2 during electrolysis []";
  SI.MoleFraction delta_yH2O "change in yH2O during electrolysis []";
  Real delta_ya( unit = "1") "change in ya during electrolysis []";

  SI.MolarFlowRate consN_H2O_SS
    "H2O consumed during electrolysis if steady state has been reached [mol/s]";

equation
  // ----------- Fluid properties ----------------------------------------------
  // ----- Cathode stream -----
  stateCathodeIn = MediumCathode.setState_phX(cathodeFlangeIn.p, inStream(cathodeFlangeIn.h_outflow), inStream(cathodeFlangeIn.Xi_outflow));
  TCin = MediumCathode.temperature(stateCathodeIn);
  rho_CathodeIn = MediumCathode.density(stateCathodeIn);

  stateCathodeOut = MediumCathode.setState_phX(cathodeFlangeOut.p, cathodeFlangeOut.h_outflow, cathodeFlangeOut.Xi_outflow);
  TCout = MediumCathode.temperature(stateCathodeOut);
  rho_CathodeOut = MediumCathode.density(stateCathodeOut);

  stateCathodeAvg = MediumCathode.setState_pTX(pCathodeAvg, TCavg, XcathodeAvg);
  hCathodeAvg = MediumCathode.specificEnthalpy(stateCathodeAvg);
  rho_CathodeAvg = MediumCathode.density(stateCathodeAvg);

  // ----- Anode stream -----
  stateAnodeIn = MediumAnode.setState_phX(anodeFlangeIn.p, inStream(anodeFlangeIn.h_outflow), inStream(anodeFlangeIn.Xi_outflow));
  TAin = MediumAnode.temperature(stateAnodeIn);
  rho_AnodeIn = MediumAnode.density(stateAnodeIn);

  stateAnodeOut = MediumAnode.setState_phX(anodeFlangeOut.p, anodeFlangeOut.h_outflow, anodeFlangeOut.Xi_outflow);
  TAout = MediumAnode.temperature(stateAnodeOut);
  rho_AnodeOut = MediumAnode.density(stateAnodeOut);

  stateAnodeAvg = MediumAnode.setState_pTX(pAnodeAvg, TAavg, XanodeAvg);
  hAnodeAvg = MediumAnode.specificEnthalpy(stateAnodeAvg);
  rho_AnodeAvg = MediumAnode.density(stateAnodeAvg);

  // ---------- Boundary conditions --------------------------------------------
  cathodeFlangeIn.m_flow = wCathodeIn*numVessels "[kg/s]";
  assert(wCathodeIn >= 0, "The electrolyzer model does not support flow reversal");
  anodeFlangeIn.m_flow = wAnodeIn*numVessels "[kg/s]";
  assert(wAnodeIn >= 0, "The electrolyzer model does not support flow reversal");
  -cathodeFlangeOut.m_flow = wCathodeOut*numVessels "[kg/s]";
  assert(wCathodeOut >= 0, "The electrolyzer model does not support flow reversal");
  -anodeFlangeOut.m_flow = wAnodeOut*numVessels "[kg/s]";
  assert(wAnodeOut >= 0, "The electrolyzer model does not support flow reversal");

  pCathodeIn  = cathodeFlangeIn.p "[Pa]";
  pCathodeOut = cathodeFlangeOut.p "[Pa]";
  pAnodeIn = anodeFlangeIn.p "[Pa]";
  pAnodeOut = anodeFlangeOut.p "[Pa]";

  hCathodeIn = inStream(cathodeFlangeIn.h_outflow);
  hCathodeOut = cathodeFlangeOut.h_outflow;
  hAnodeIn = inStream(anodeFlangeIn.h_outflow);
  hAnodeOut = anodeFlangeOut.h_outflow;

  XcathodeIn = inStream(cathodeFlangeIn.Xi_outflow);
  XcathodeOut = cathodeFlangeOut.Xi_outflow;
  XanodeIn = inStream(anodeFlangeIn.Xi_outflow);
  XanodeOut = anodeFlangeOut.Xi_outflow;

  W_elec_total = electricalLoad.W;
  f = electricalLoad.f;

  // Equations for reverse flow (not used)
  cathodeFlangeIn.h_outflow = inStream(cathodeFlangeOut.h_outflow);
  anodeFlangeIn.h_outflow = inStream(anodeFlangeOut.h_outflow);
  cathodeFlangeIn.Xi_outflow = inStream(cathodeFlangeOut.Xi_outflow);
  anodeFlangeIn.Xi_outflow = inStream(anodeFlangeOut.Xi_outflow);

  // ----- Intermediate variables -----
  TCavg = (TCin + TCout)/2;
  TAavg = (TAin + TAout)/2;
  TSavg = (TSin + TSout)/2;
  TIavg = (TIin + TIout)/2;
  TIin = (TAin + TCin)/2;
  TSin = (TCin + TAin)/2;

  pCathodeAvg = (pCathodeIn + pCathodeOut)/2;
  pAnodeAvg = (pAnodeIn + pAnodeOut)/2;

  XcathodeAvg = (XcathodeIn + XcathodeOut)/2;
  XanodeAvg = (XanodeIn + XanodeOut)/2;

  ycathodeIn[:] = Electrolysis.Utilities.massToMoleFractions(XcathodeIn,
    {mwH2*1000,mwH2O*1000}) "inlet mole fraction at cathode {H2, H2O}";
  yanodeIn[:] = Electrolysis.Utilities.massToMoleFractions(XanodeIn, {
    mwN2*1000,mwO2*1000}) "inlet mole fraction at anode {N2, O2}";
  XcathodeOut[:] = Electrolysis.Utilities.moleToMassFractions(
    ycathodeOut, {mwH2*1000,mwH2O*1000})
    "outlet mass Fraction at cathode {H2, H2O}";
  XanodeOut[:] = Electrolysis.Utilities.moleToMassFractions(yanodeOut,
    {mwN2*1000,mwO2*1000}) "outlet mass Fraction at anode {N2, O2}";

  yH2_cathodeIn  = ycathodeIn[1];
  yH2O_cathodeIn = ycathodeIn[2];
  yH2_cathodeOut  = ycathodeOut[1];
  yH2O_cathodeOut = ycathodeOut[2];

  yN2_anodeIn = yanodeIn[1];
  yO2_anodeIn = yanodeIn[2];
  yN2_anodeOut  = yanodeOut[1];
  yO2_anodeOut  = yanodeOut[2];

  mw_cathodeIn  = mwH2*yH2_cathodeIn + mwH2O*yH2O_cathodeIn;
  mw_cathodeOut = mwH2*yH2_cathodeOut + mwH2O*yH2O_cathodeOut;
  mw_anodeIn  = mwN2*yN2_anodeIn + mwO2*yO2_anodeIn;
  mw_anodeOut = mwN2*yN2_anodeOut + mwO2*yO2_anodeOut;

  // ----- Known inlet conditions -----
  // Cathode stream
  N_cathodeIn = wCathodeIn/mw_cathodeIn;
  N_H2_cathodeIn = N_cathodeIn*yH2_cathodeIn;
  N_H2O_cathodeIn = N_cathodeIn*yH2O_cathodeIn;

  // Anode gas
  N_anodeIn = wAnodeIn/mw_anodeIn;
  N_N2_anodeIn = N_anodeIn*yN2_anodeIn;
  N_O2_anodeIn = N_anodeIn*yO2_anodeIn;

  // Calculate the amount (mol/s) of generated/consumed species
  deltaN_O2 = numCells_perVessel*I/(2*2*Fa) "Faraday's law [mol/s]";
  deltaN_H2 = 2*deltaN_O2 "[mol/s]";
  deltaN_H2O = -2*deltaN_O2 "[mol/s]";

  deltaM_O2 = deltaN_O2*mwO2 "[kg/s]";
  deltaM_H2 = deltaN_H2*mwH2 "[kg/s]";
  deltaM_H2O = deltaN_H2O*mwH2O "[kg/s]";

  N_H2_cathode = numCells_perVessel*VC*(rho_CathodeAvg*XcathodeAvg[1]/mwH2);
  N_H2O_cathode = numCells_perVessel*VC*(rho_CathodeAvg*XcathodeAvg[2]/mwH2O);
  N_N2_anode = numCells_perVessel*VA*(rho_AnodeAvg*XanodeAvg[1]/mwN2);
  N_O2_anode = numCells_perVessel*VA*(rho_AnodeAvg*XanodeAvg[2]/mwO2);

  // ----- Calculate the outlet conditions -----
  // Cathode stream (H2/H2O mixture)
  //0 = N_H2_cathodeIn - N_H2_cathodeOut + deltaN_H2;
  //0 = N_H2O_cathodeIn - N_H2O_cathodeOut + deltaN_H2O;
  der(N_H2_cathode) = N_H2_cathodeIn - N_H2_cathodeOut + deltaN_H2;
  der(N_H2O_cathode) = N_H2O_cathodeIn - N_H2O_cathodeOut + deltaN_H2O;

  N_cathodeOut = N_H2_cathodeOut + N_H2O_cathodeOut;
  wCathodeOut = N_cathodeOut*mw_cathodeOut;
  yH2_cathodeOut = N_H2_cathodeOut/N_cathodeOut;
  yH2O_cathodeOut = 1 - yH2_cathodeOut;

  // Anode stream(air, N2/O2 mixture)
  //0 = N_N2_anodeIn - N_N2_anodeOut;
  //0 = N_O2_anodeIn - N_O2_anodeOut + deltaN_O2;
  der(N_N2_anode) = N_N2_anodeIn - N_N2_anodeOut;
  der(N_O2_anode) = N_O2_anodeIn - N_O2_anodeOut + deltaN_O2;

  N_anodeOut = N_O2_anodeOut + N_N2_anodeOut;
  wAnodeOut = N_anodeOut*mw_anodeOut;
  yO2_anodeOut = N_O2_anodeOut/N_anodeOut;
  yN2_anodeOut = 1 - yO2_anodeOut;

  // ----- Nernst potential calculation -----
  yaIn = yO2_anodeIn*(pCathodeIn/p_std);
  yaOut = yO2_anodeOut*(pCathodeOut/p_std);
  delta_ya = yaOut - yaIn;
  delta_yH2 = yH2_cathodeOut - yH2_cathodeIn;
  delta_yH2O = yH2O_cathodeOut - yH2O_cathodeIn;

  deltaGibbsE = Electrolysis.Utilities.GibbsEnergy(TSavg);
  IntegraldeltaGibbsE = Electrolysis.Utilities.integralGibbsEnergy(
    TSout) - Electrolysis.Utilities.integralGibbsEnergy(TSin);
  coef_isothermal = 1/(2*Fa*delta_yH2*delta_ya);
  Integral_y_H2_1 = (-(1 - yH2_cathodeOut)*log(max(0.001,1 - yH2_cathodeOut)) -
    yH2_cathodeOut) - (-(1 - yH2_cathodeIn)*log(max(0.001,1 - yH2_cathodeIn)) -
    yH2_cathodeIn);
  Integral_y_H2_2 = (yH2_cathodeOut*log(max(0.001,yH2_cathodeOut)) - yH2_cathodeOut) - (
    yH2_cathodeIn*log(max(0.001,yH2_cathodeIn)) - yH2_cathodeIn);
  Integral_ya = (yaOut*log(max(0.001,yaOut)) - yaOut) - (yaIn*log(max(0.001,yaIn)) - yaIn);
  Vn_isothermal = coef_isothermal*(deltaGibbsE*delta_yH2*delta_ya - Rg*TSavg*(
    delta_ya*(Integral_y_H2_1 - Integral_y_H2_2) - delta_yH2/2*Integral_ya));

  Vn = if noEvent(TSout > TSin-TStol_Vn and TSout < TSin+TStol_Vn) then Vn_isothermal else coef_isothermal/(TSout - TSin)*(
    IntegraldeltaGibbsE*delta_yH2*delta_ya - Rg/2*(TSout^2 - TSin^2)*(delta_ya*(
    Integral_y_H2_1 - Integral_y_H2_2) - delta_yH2/2*Integral_ya));

  j0_cathode_cm2 = Electrolysis.Utilities.cathodeExCurrentDensity(TSavg);
  j0_anode_cm2 = Electrolysis.Utilities.anodeExCurrentDensity(TSavg);
  j_stack_cm2 = j0_cathode_cm2*(exp(2*(1-0.5)*Fa*lossActOPcathode/(Rg*TSavg)) - exp(-2*0.5*Fa*lossActOPcathode/(Rg*TSavg)))
    "Solve for cathode activation overpotential";
  j_stack_cm2 = j0_anode_cm2*(exp(2*(1-0.5)*Fa*lossActOPanode/(Rg*TSavg)) - exp(-2*0.5*Fa*lossActOPanode/(Rg*TSavg)))
    " Solve for anode activation overpotential";
  conductivityElectrolyte = 33.4*1000*exp(-10.3*1000/TSavg);

  Rohm_cm2 = (thicknessCathode/conductivityC + thicknessAnode/conductivityA + thicknessElectrolyte/conductivityElectrolyte)*10000;
  ASR = Rohm_cm2 + (lossActOPcathode + lossActOPanode)/j_stack_cm2;
  Vop_single = Vn + (ASR)*j_stack_cm2;
  Vop_overall = Vop_single*numCells_perVessel;
  I = Acell_active*j_stack_cm2;
  W_elec = Vop_overall*I;
  W_elec = W_elec_total/numVessels;
  f = f0 "Frequency set by parameter";

  etaElectrolysis = (Hrxn_electrolysis_per_H2Oconsumed*mwH2O + 0.5*
    Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
            dataO2,
            TSavg,
            excludeEnthalpyOfFormation)*mwO2 +
    Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
            dataH2,
            TSavg,
            excludeEnthalpyOfFormation)*mwH2 -
    Electrolysis.Utilities.h_T_NASA_ZeroAt25C(
            dataH2O,
            TSavg,
            excludeEnthalpyOfFormation)*mwH2O)*(-deltaN_H2O)/W_elec*100;

  airRatio = N_O2_anodeIn/deltaN_O2;
  SUfactor = -deltaN_H2O/N_H2O_cathodeIn*100;
  consN_H2O_SS = N_H2O_cathodeIn - N_H2O_cathodeOut;
  SUfactor_est = consN_H2O_SS/N_H2O_cathodeIn*100;

  // ---------------------------------------------------------------------------
  deltaH_cathode = hCathodeOut*wCathodeOut - hCathodeIn*wCathodeIn;
  deltaH_anode = hAnodeOut*wAnodeOut - hAnodeIn*wAnodeIn;
  deltaH_system  = deltaH_cathode + deltaH_anode;

  // ---------------------------------------------------------------------------
  // No pressure drop across the cell stack
  pCathodeIn = pCathodeOut;
  pAnodeIn = pAnodeOut;

  // ----- Energy balances ------
  cpC = Electrolysis.Utilities.cp_T(dataH2, TCavg)*XcathodeAvg[1] +
    Electrolysis.Utilities.cp_T(dataH2O, TCavg)*XcathodeAvg[2];
  cpA = Electrolysis.Utilities.cp_T(dataN2, TAavg)*XanodeAvg[1] +
    Electrolysis.Utilities.cp_T(dataO2, TAavg)*XanodeAvg[2];

  Hrxn_electrolysis = -deltaM_H2O*Hrxn_electrolysis_per_H2Oconsumed;
  deltaH_electrolysis = deltaH_system + Hrxn_electrolysis;

  // Cathode stream
  VC*der(rho_CathodeAvg*cpC*TCavg) = (wCathodeIn*hCathodeIn - wCathodeOut*hCathodeOut)/numCells_perVessel + Acell_active_m2*hC*(TSavg - TCavg) + Acell_active_m2*hC*(TIavg - TCavg);
  //0 = (wCathodeIn*hCathodeIn - wCathodeOut*hCathodeOut)/numCells_perVessel + Acell_active_m2*hC*(TSavg - TCavg) + Acell_active_m2*hC*(TIavg - TCavg);

  // Anode stream
  VA*der(rho_AnodeAvg*cpA*TAavg) = (wAnodeIn*hAnodeIn - wAnodeOut*hAnodeOut)/numCells_perVessel + Acell_active_m2*hA*(TSavg - TAavg) + Acell_active_m2*hA*(TIavg - TAavg);
  //0 = (wAnodeIn*hAnodeIn - wAnodeOut*hAnodeOut)/numCells_perVessel + Acell_active_m2*hA*(TSavg - TAavg) + Acell_active_m2*hA*(TIavg - TAavg);

  // Solid structure
  VS*rhoS*cpS*der(TSavg) = -Acell_active_m2*hC*(TSavg - TCavg) - Acell_active_m2*hA*(TSavg - TAavg) - 2*Acell_active_m2*(sigma*(TSavg^4 - TIavg^4)/(1/emissivityS+1/emissivityI-1)) + (-Hrxn_electrolysis + W_elec)/numCells_perVessel;
  //0 = -Acell_active_m2*hC*(TSavg - TCavg) - Acell_active_m2*hA*(TSavg - TAavg) - 2*Acell_active_m2*(sigma*(TSavg^4 - TIavg^4)/(1/emissivityS+1/emissivityI-1)) + (-Hrxn_electrolysis + W_elec)/numCells_perVessel;

  // Interconnect
  VI*rhoI*cpI*der(TIavg) = -Acell_active_m2*hC*(TIavg - TCavg) - Acell_active_m2*hA*(TIavg - TAavg) + 2*Acell_active_m2*(sigma*(TSavg^4 - TIavg^4)/(1/emissivityS+1/emissivityI-1));
  //0 = -Acell_active_m2*hC*(TIavg - TCavg) - Acell_active_m2*hA*(TIavg - TAavg) + 2*Acell_active_m2*(sigma*(TSavg^4 - TIavg^4)/(1/emissivityS+1/emissivityI-1));

initial equation

  if initOpt == Electrolysis.Utilities.OptionsInit.noInit then
    // do nothing
  elseif initOpt == Electrolysis.Utilities.OptionsInit.userSpecified then

    der(TSavg) = 0;
    der(TIavg) = 0;
    //der(TCavg) = 0;
    //der(TAavg) = 0;
    TCavg = TCstartAvg_K;
    TAavg = TAstartAvg_K;

    //TCin = TCstartIn_K;
    //TAout = TAstartOut_K;

    der(N_H2_cathode) = 0;
    der(N_H2O_cathode) = 0;
    der(N_N2_anode) = 0;
    der(N_O2_anode) = 0;

  elseif initOpt == Electrolysis.Utilities.OptionsInit.steadyState then

    der(TSavg) = 0;
    der(TIavg) = 0;
    //der(TCavg) = 0;
    //der(TAavg) = 0;

    der(N_H2_cathode) = 0;
    der(N_H2O_cathode) = 0;
    der(N_N2_anode) = 0;
    der(N_O2_anode) = 0;

  else

    assert(false, "Unsupported initialisation option");

  end if;

  annotation (experiment(StopTime=10, Interval=1),
      __Dymola_experimentSetupOutput,
    Documentation(info="<html>
    <p>Model of a solid oxide electrolysis cell</p>    
 </html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={
        Line(points={{-56,20},{-56,14},{-56,10},{-76,10},{-76,-4}}, color={0,0,0}),
        Line(points={{-80,-4},{-72,-4}}, color={0,0,0}),
        Line(points={{-80,-12},{-72,-12}}, color={0,0,0}),
        Line(points={{-84,-8},{-68,-8}}, color={0,0,0}),
        Line(points={{-84,-16},{-68,-16}}, color={0,0,0}),
        Line(points={{-76,-16},{-76,-20},{-76,-30},{-56,-30},{-56,-40}}, color={
              0,0,0})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})));
end SOEC_updateLogTerm;
