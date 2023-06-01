within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model PropsCalc
  //This is a fluid property calculator. Currently, it is only set up for the cathode (H2, H2O) and anode (N2, O2) gases. The reference state is 0 enthalpy at 0K.

  extends Modelica.Icons.Example;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package MediumCathode =
  NHES.Electrolysis.Media.Electrolysis.CathodeGas_RefStateZeroAt0K constrainedby Modelica.Media.Interfaces.PartialMedium
                                            "Medium model for cathode gas" annotation (Dialog(group="Working fluids (Medium)"));

  replaceable package MediumAnode =
  NHES.Electrolysis.Media.Electrolysis.AnodeGas_air_RefStateZeroAt0K constrainedby Modelica.Media.Interfaces.PartialMedium
                                            "Medium model for anode gas" annotation (Dialog(group="Working fluids (Medium)"));

  constant SI.MolarMass mwH2O = gasProperties.H2O.MM "Molecular weight of water or steam [kg/mol]";
  constant SI.MolarMass mwH2 = gasProperties.H2.MM   "Molecular weight of hydrogen [kg/mol]";
  constant SI.MolarMass mwO2 = gasProperties.O2.MM   "Molecular weight of oxygen [kg/mol]";
  constant SI.MolarMass mwN2 = gasProperties.N2.MM   "Molecular weight of nitrogen [kg/mol]";

  SI.Temperature T_cathode = 790 + 273.15;
  SI.Pressure P_cathode = 103800;
  SI.Temperature T_anode = 780 + 273.15;
  SI.Pressure P_anode = 103300;

  // ----- Fluid conditions -----
  parameter SI.MoleFraction yH2startCathodeIn_1=0.1  "Start value of H2 inlet mole fraction of the cathode stream"  annotation (Dialog(tab="Initialisation"));
  final parameter SI.MoleFraction ystartCathodeIn_1[:]={yH2startCathodeIn_1,1 - yH2startCathodeIn_1} "Start value of inlet gas mole Fraction at cathode {H2, H2O}";
  final parameter SI.MassFraction XCathodeIn[:]=Electrolysis.Utilities.moleToMassFractions(ystartCathodeIn_1, {mwH2*1000, mwH2O*1000}) "Start value of inlet mass Fraction at cathode {H2, H2O}";

  parameter SI.MoleFraction yN2startAnodeIn_1=0.79  "Start value of N2 inlet mole fraction of the cathode stream";
  final parameter SI.MoleFraction ystartAnodeIn_1[:]={yN2startAnodeIn_1,1 - yN2startAnodeIn_1} "Start value of inlet gas mole Fraction at cathode {H2, H2O}";
  final parameter SI.MassFraction XAnodeIn[:]=Electrolysis.Utilities.moleToMassFractions(ystartAnodeIn_1, {mwN2*1000, mwO2*1000}) "Start value of inlet mass Fraction at cathode {H2, H2O}";

  SI.SpecificEnthalpy CathodeIn = XCathodeIn[1]*MediumCathode.specificEnthalpy_pTX(P_cathode, T_cathode, {1,0}) + XCathodeIn[2]*MediumCathode.specificEnthalpy_pTX(P_cathode, T_cathode, {0,1});
  SI.SpecificEnthalpy AnodeIn = XAnodeIn[1]*MediumAnode.specificEnthalpy_pTX(P_anode, T_anode, {1,0}) + XAnodeIn[2]*MediumAnode.specificEnthalpy_pTX(P_anode, T_anode, {0,1});

  SI.SpecificEnthalpy H2 = MediumCathode.specificEnthalpy_pTX(P_cathode, T_cathode, {1,0});
  SI.SpecificEnthalpy H2O = MediumCathode.specificEnthalpy_pTX(P_cathode, T_cathode, {0,1});
  SI.SpecificEnthalpy N2 = MediumAnode.specificEnthalpy_pTX(P_anode, T_anode, {1,0});
  SI.SpecificEnthalpy O2 = MediumAnode.specificEnthalpy_pTX(P_anode, T_anode, {0,1});

equation

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}})),
            experiment(StopTime=100),
  Documentation(info="<html>
  <p>Model of a solid oxide electrolysis cell based on OxEon design. The design has a total of 780 cells based on 65 cells in 12 stacks (65 x 12 = 780). 
  Some of the cell design parameters are chosen from publicly available information for the OxEon Energy SOEC. These details can be found at https://doi.org/10.1016/j.ijhydene.2020.04.074 </p>
    <p>The model's steady state conditions are acquired from an Aspen HYSYS model, which are then used as initial conditions for this model</p>
    <p>The SOEC has a constant area specific resistance (ASR) and operating voltage. These numbers will be modified in the future to account for cell degradation using empirical data.
    The Gibbs Free Energy term is calculated using NASA's 7-term polynomial.
    For any questions regarding the model, please contact Amey Shigrekar (amey.shigreka@inl.gov)</p>        
 </html>"));
end PropsCalc;
