within NHES.Electrolysis.Electrolyzers.BaseClasses;
model OxEon_v1 "Solid Oxide Electrolysis Cell (SOEC) stack model"

  extends Electrolysis.Icons.Electrolyzer;
  import SIunits =  Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package MediumCathode =
  Electrolysis.Media.Electrolysis.CathodeGas constrainedby Modelica.Media.Interfaces.PartialMedium
                                            "Medium model for cathode gas" annotation (Dialog(group="Working fluids (Medium)"));

  replaceable package MediumAnode =
  Electrolysis.Media.Electrolysis.AnodeGas_air constrainedby Modelica.Media.Interfaces.PartialMedium
                                            "Medium model for anode gas" annotation (Dialog(group="Working fluids (Medium)"));

  // ---------- Define constants -----------------------------------------------

  constant SI.MolarMass mwH2O = gasProperties.H2O.MM "Molecular weight of water or steam [kg/mol]";
  constant SI.MolarMass mwH2 = gasProperties.H2.MM   "Molecular weight of hydrogen [kg/mol]";
  constant SI.MolarMass mwO2 = gasProperties.O2.MM   "Molecular weight of oxygen [kg/mol]";
  constant SI.MolarMass mwN2 = gasProperties.N2.MM   "Molecular weight of nitrogen [kg/mol]";

  constant Real Fa = Modelica.Constants.F            "Faraday constant [C/mol] or [J/(V.mol)]";
  constant Real Rg(final unit="J/(mol.K)") = Modelica.Constants.R  "Molar gas constant";
  Real numElecTransferred_per_H2prod = 2;

  constant Modelica.Media.IdealGases.Common.DataRecord  dataH2=gasProperties.H2;
  constant Modelica.Media.IdealGases.Common.DataRecord  dataH2O=gasProperties.H2O;
  constant Modelica.Media.IdealGases.Common.DataRecord  dataO2=gasProperties.O2;
  constant Modelica.Media.IdealGases.Common.DataRecord  dataN2=gasProperties.N2;
// constant Real Rg(final unit="J/(mol.K)") = Modelica.Constants.R  "Molar gas constant";

//   constant SI.SpecificEnthalpy Hf_H2O_gas = Modelica.Media.IdealGases.Common.SingleGasesData.H2O.Hf  "Heat of formation for H2O (steam) [J/kg]";
//   constant SI.SpecificEnthalpy Hrxn_electrolysis_per_H2Oconsumed = -Hf_H2O_gas   "Heat of reaction of electrolysis per H2O (kg) consumed [J/kg]";
//   constant Integer numElecTransferred_per_H2prod = 2   "Number of electrons transferred per molecule of H2 produced";


  // ----- Cell stack specifications -----
  parameter SI.Length Wcell = 0.10526  "Stack cell width [m]" annotation (Dialog(group="SOEC stack"));
  parameter SI.Length Lcell = 0.10526  "Stack cell length [m]" annotation (Dialog(group="SOEC stack"));
  final parameter SI.Area Acell_active_m2 = Wcell*Lcell  "Active cell area [m2]";
  final parameter Electrolysis.Types.Area_cm2 Acell_active= Acell_active_m2*10000 "Active cell area [cm2]";
  parameter Integer numCells_perStack = 65  "Number of cells per stack" annotation (Dialog(group="SOEC stack"));
  parameter Integer numStacks = 12  "Number of stacks" annotation (Dialog(group="SOEC stack"));
  parameter Integer TotNumCells = numCells_perStack * numStacks "Total number of cells" annotation (Dialog(group="SOEC stack"));

  //----- Cell Operating Conditions -----
  parameter SI.Voltage TNV = 1.283  "Thermo-Neutral Voltage [V]";
  SI.Voltage OCV "Open Circuit Voltage";
  Electrolysis.Types.AreaSpecificResistance_cm2 ASR = 1.3  "Area specific resistance";
  Electrolysis.Types.CurrentDensity_cm2 current_density "Current density";
  SI.Current calculated_current "Calculated current";
  SI.Current Total_current;
  parameter SI.Pressure P_operating=1.032998      "Start value of inlet pressure at cathode [Pa]" annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.NonSI.Temperature_degC T_stack_C=790   "Stack temperature in Celsius"    annotation (Dialog(tab="Initialisation"));

  SIunits.Pressure pH2, pO2, pH2O "Partial pressures of hydrogen, oxygen and water";
  Real H2_conc = 0.37;
  Real O2_conc = 0.305;
  Real H2O_conc = 0.63;
  //Real test;


  // ----- Operating conditions -----
  //final parameter SI.Frequency f0 = 60 "Nominal frequency";


  parameter SI.MoleFraction yH2startCathodeIn=0.1  "Start value of H2 inlet mole fraction of the cathode stream"  annotation (Dialog(tab="Initialisation"));
  parameter SI.MoleFraction yO2startAnodeIn=0.21   "Start value of O2 inlet mole fraction of the anode stream"    annotation (Dialog(tab="Initialisation"));
  parameter SI.MoleFraction yH2startCathodeOut=0.64  "Start value of H2 inlet mole fraction of the cathode stream"
                                                                                                                  annotation (Dialog(tab="Initialisation"));
  parameter SI.MoleFraction yO2startAnodeOut=0.40 "Start value of O2 outlet mole fraction of the anode gas"
                                                                                                           annotation (Dialog(tab="Initialisation"));

  final parameter SI.MoleFraction ystartCathodeIn[:]={yH2startCathodeIn,1 - yH2startCathodeIn} "Start value of inlet gas mole Fraction at cathode {H2, H2O}";
  final parameter SI.MoleFraction ystartCathodeOut[:]={yH2startCathodeOut,1 -  yH2startCathodeOut} "Start value of outlet gas mole Fraction at cathode {H2, H2O}";
  final parameter SI.MoleFraction ystartAnodeIn[:]={1 - yO2startAnodeIn, yO2startAnodeIn} "Start value of inlet gas mole Fraction at anode {N2, O2}";
  final parameter SI.MoleFraction ystartAnodeOut[:]={1 - yO2startAnodeOut, yO2startAnodeOut} "Start value of outlet gas mole Fraction at anode {N2, O2}";

  final parameter SI.MassFraction XCathodeIn[:]=Electrolysis.Utilities.moleToMassFractions(ystartCathodeIn, {mwH2*1000, mwH2O*1000}) "Start value of inlet mass Fraction at cathode {H2, H2O}";
  final parameter SI.MassFraction XAnodeIn[:]=Electrolysis.Utilities.moleToMassFractions(ystartAnodeIn, {mwN2*1000,mwO2*1000}) "Start value of inlet mass Fraction at anode {N2, O2}";

  parameter SI.MassFlowRate wstartCathodeIn = 0.003741667    "Start value of H2/H2O inlet mass flow rate at cathode [kg/s]"    annotation (Dialog(tab="Initialisation"));
  parameter SI.MassFlowRate wstartCathodeOut = 0.0017861    "Start value of H2/H2O outlet mass flow rate at cathode [kg/s]"    annotation (Dialog(tab="Initialisation"));
  parameter SI.MassFlowRate wstartAnodeIn = 0.005556    "Start value of N2/O2 inlet mass flow rate at anode [kg/s]"    annotation (Dialog(tab="Initialisation"));
  final parameter SI.MassFlowRate wstartAnodeOut = wstartCathodeIn + wstartAnodeIn -  wstartCathodeOut    "Start value of N2/O2 outlet mass flow rate at anode [kg/s]";

  SI.MolarFlowRate molflow_H2O_in, molflow_H2_in, molflow_O2_in, molflow_N2_in, molflow_H2O_out, molflow_H2_out, molflow_O2_out, molflow_N2_out "Molar Flows";
  SI.MolarFlowRate molTransfer_H2, molTransfer_O2 "Molar conversions";
  //SI.MassFlowRate Test123;

  Electrolysis.Types.SteamUtilization SteamUtilization;

  // ---------- Connectors -----------------------------------------------------
  Modelica.Fluid.Interfaces.FluidPort_a
                          cathodeFlangeIn(redeclare package Medium = MediumCathode) annotation (Placement(
        transformation(extent={{-84,20},{-64,40}}),  iconTransformation(extent={{-84,20},
            {-64,40}})));

  Modelica.Fluid.Interfaces.FluidPort_b
                          cathodeFlangeOut(redeclare package Medium = MediumCathode) annotation (Placement(
        transformation(extent={{64,40},{82,58}}),  iconTransformation(extent={{64,40},
            {84,60}})));

  Modelica.Fluid.Interfaces.FluidPort_a
                          anodeFlangeIn(redeclare package Medium = MediumAnode) annotation (Placement(
        transformation(extent={{-84,-64},{-64,-44}}),  iconTransformation(
          extent={{-84,-64},{-64,-44}})));
  Modelica.Fluid.Interfaces.FluidPort_b
                          anodeFlangeOut(redeclare package Medium = MediumAnode) annotation (Placement(
        transformation(extent={{64,-42},{82,-22}}),  iconTransformation(extent={{64,-44},
            {84,-24}})));

  Interfaces.ElectricalPowerPort_a electricalLoad annotation (Placement(
        transformation(extent={{-86,-20},{-66,0}}), iconTransformation(extent={
            {-86,-20},{-66,0}})));

  SI.MolarEnergy deltaGibbsE "GibbsFreeEnergy";
  SI.Voltage Cell_Potential "Standard Cell Potential";
  SI.Voltage Nernst_Potential "Nernst Contribution";

  // ======== Electrochemical model ========
equation

  pH2 = H2_conc*P_operating;
  pO2 = O2_conc*P_operating;
  pH2O = H2O_conc*P_operating;


  deltaGibbsE = Electrolysis.Utilities.GibbsEnergy_NASA_7Term(T_stack_C + 273.15); //Gibbs Energy Calculated on NASA 7 Term Equation
  Cell_Potential = -deltaGibbsE/(2*Fa);
  Nernst_Potential = Rg*(T_stack_C + 273.15)/(2*Fa)*log(max(0.001,pH2O/(pH2*pO2^0.5)));
  OCV = abs(Cell_Potential + Nernst_Potential);

  current_density = abs((TNV - OCV)/ASR);
  calculated_current = current_density*Acell_active;
  Total_current = calculated_current*TotNumCells;


  //Molar Conversion due to splitting
  molTransfer_H2 = Total_current/(numElecTransferred_per_H2prod*Fa);
  molTransfer_O2 = molTransfer_H2/2;

  //Molar Flows at the inlet
  molflow_H2_in = wstartCathodeIn*XCathodeIn[1]/mwH2;
  molflow_H2O_in = wstartCathodeIn*XCathodeIn[2]/mwH2O;
  molflow_O2_in = wstartAnodeIn*XAnodeIn[2]/mwO2;
  molflow_N2_in = wstartAnodeIn*XAnodeIn[1]/mwN2;

  SteamUtilization = molTransfer_H2/(molflow_H2O_in);

  molflow_H2O_out = molflow_H2O_in*(1-SteamUtilization);
  molflow_H2_out = molTransfer_H2 + molflow_H2_in;
  molflow_O2_out = molTransfer_O2 + molflow_O2_in;
  molflow_N2_out = molflow_N2_in;


  //Test123 = wstartCathodeIn;
  //test = pH2O/(pH2*pO2^0.5);

 annotation (Dialog(tab="Initialisation"),
              experiment(StopTime=10, Interval=1),
      __Dymola_experimentSetupOutput,
    Documentation(info="<html>
    <p>Model of a solid oxide electrolysis cell (SOEC) based on the OxEon Energy design</p>
    <p>This SOEC model is developed from a steady-state excel-based model, which can be found in the FORCE repository. The model is design agnostic and therefore can be modified for any SOEC design</p>
    <p>Note: O2 molar mass is slightly lower based on the fluid used herein, so that leads to a small discrepancy</p>        
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
end OxEon_v1;
