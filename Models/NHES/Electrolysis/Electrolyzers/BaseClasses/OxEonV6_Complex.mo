within NHES.Electrolysis.Electrolyzers.BaseClasses;
model OxEonV6_Complex

  extends Electrolysis.Icons.Electrolyzer;
  import SIunits =  Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package MediumCathode =
  NHES.Electrolysis.Media.Electrolysis.CathodeGas constrainedby Modelica.Media.Interfaces.PartialMedium
                                            "Medium model for cathode gas" annotation (Dialog(group="Working fluids (Medium)"));

  replaceable package MediumAnode =
  NHES.Electrolysis.Media.Electrolysis.AnodeGas_air constrainedby Modelica.Media.Interfaces.PartialMedium
                                            "Medium model for anode gas" annotation (Dialog(group="Working fluids (Medium)"));

// ---------- Define constants -----------------------------------------------

  constant SI.MolarMass mwH2O = gasProperties.H2O.MM "Molecular weight of water or steam [kg/mol]";
  constant SI.MolarMass mwH2 = gasProperties.H2.MM   "Molecular weight of hydrogen [kg/mol]";
  constant SI.MolarMass mwO2 = gasProperties.O2.MM   "Molecular weight of oxygen [kg/mol]";
  constant SI.MolarMass mwN2 = gasProperties.N2.MM   "Molecular weight of nitrogen [kg/mol]";

  constant Real Fa = Modelica.Constants.F            "Faraday constant [C/mol] or [J/(V.mol)]";
  constant Real Rg(final unit="J/(mol.K)") = Modelica.Constants.R  "Molar gas constant";
  Real numElecTransferred_per_H2prod = 2 "Number of electrons transferred per mole of H2 produced";

  //Fluid properties
  constant Modelica.Media.IdealGases.Common.DataRecord  dataH2=gasProperties.H2;
  constant Modelica.Media.IdealGases.Common.DataRecord  dataH2O=gasProperties.H2O;
  constant Modelica.Media.IdealGases.Common.DataRecord  dataO2=gasProperties.O2;
  constant Modelica.Media.IdealGases.Common.DataRecord  dataN2=gasProperties.N2;

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
  SI.Voltage Total_Voltage "Total Stack Voltage";
  Electrolysis.Types.AreaSpecificResistance_cm2 ASR = 1.3  "Area specific resistance";
  Electrolysis.Types.CurrentDensity_cm2 current_density "Current density";
  SI.Current calculated_current "Calculated current per cell";
  SI.Current Total_current "Total current";
  SI.Power W_elec_total "Electrical Power";

  parameter SI.Pressure P_operating_cathode=103299.8      "Start value of inlet pressure at cathode [Pa]" annotation (Dialog(tab="Initialisation"));
  parameter SI.Pressure P_operating_anode=103299.8      "Start value of inlet pressure at cathode [Pa]" annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.NonSI.Temperature_degC T_stack_C=790   "Stack temperature in Celsius"    annotation (Dialog(tab="Initialisation"));

  SIunits.Pressure pH2, pO2, pH2O "Partial pressures of hydrogen, oxygen and water";

 //************Need to add to equation later**************
  Real H2_conc = 0.37; //average molar concentration of H2 in the stack
  Real O2_conc = 0.305; //average molar concentration of O2 in the stack
  Real H2O_conc = 0.63; //average molar concentration of H2O in the stack

  // ----- Fluid conditions -----
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
  SI.Frequency f = 60;

  SI.MolarEnergy deltaGibbsE "GibbsFreeEnergy";
  SI.Voltage Cell_Potential "Standard Cell Potential";
  SI.Voltage Nernst_Potential "Nernst Contribution";

  HTSE.SimpleVolume_XChange CathodeVolume(redeclare package Medium = MediumCathode,
    T_start=1063.15,
    Q_gen=Q_gen1 + Q_gen2,                                                          dmX={(molflow_H2_out - molflow_H2_in)*mwH2,(molflow_H2O_out -  molflow_H2O_in)*mwH2O})
   annotation (Placement(transformation(extent={{-10,40},{10,60}})));

  HTSE.SimpleVolume_XChange AnodeVolume(redeclare package Medium = MediumAnode,
    T_start=1063.15,
    Q_gen=Q_transfer,                                                           dmX={(molflow_N2_out - molflow_N2_in)*mwN2,(molflow_O2_out -  molflow_O2_in)*mwO2})
   annotation (Placement(transformation(extent={{-10,-58},
            {10,-38}})));

  //SI.MassFlowRate cathode_massflow[MediumCathode.nXi];
  //SI.MassFlowRate anode_massflow[MediumAnode.nXi];
  //Interfaces.ElectricalPowerPort_a electricalLoad;

  TRANSFORM.Fluid.Interfaces.FluidPort_State CathodeOut(redeclare package Medium = MediumCathode)   annotation (Placement(transformation(extent={{90,40},{110,60}}), iconTransformation(extent={{90,40},{110,60}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow CathodeIn(redeclare package Medium = MediumCathode)  annotation (Placement(transformation(extent={{-110,40},{-90,60}}), iconTransformation(extent={{-110,40},{-90,60}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow AnodeIn(redeclare package Medium = MediumAnode)  annotation (Placement(transformation(extent={{-110,-58},{-90,-38}}),
                                                                       iconTransformation(extent={{-110,-60},{-90,-40}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State AnodeOut(redeclare package Medium = MediumAnode)  annotation (Placement(transformation(extent={{90,-58},{110,-38}}),
                                                                     iconTransformation(extent={{90,-60},{110,-40}})));
  Interfaces.ElectricalPowerPort_a electricalLoad  annotation (Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CathodeTemp(redeclare package Medium = Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-66,40},{-46,60}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeTemp(redeclare package Medium = Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-66,-58},{-46,-38}})));

  SI.Power Q_transfer "Energy transfer from Cathode to Anode due to mass transfer. This term only appears in the Anode volume";
  SI.Power Q_gen1,Q_gen2  "Energy gain from H2 production and H2O splitting, respectively";

equation

  pH2 = H2_conc*P_operating_cathode;
  pO2 = O2_conc*P_operating_anode;
  pH2O = H2O_conc*P_operating_cathode;

  deltaGibbsE = Electrolysis.Utilities.GibbsEnergy_NASA_7Term(T_stack_C + 273.15); //Gibbs Energy Calculated from NASA 7 Term Equation
  Cell_Potential = -deltaGibbsE/(2*Fa);
  Nernst_Potential = Rg*(T_stack_C + 273.15)/(2*Fa)*log(max(0.001,pH2O/(pH2*pO2^0.5)));
  OCV = abs(Cell_Potential + Nernst_Potential);

  //current_density = abs((TNV - OCV)/ASR);
  W_elec_total = electricalLoad.W;
  calculated_current = current_density*Acell_active;
  Total_current = calculated_current*TotNumCells;
  Total_Voltage = TNV*TotNumCells;
  W_elec_total = Total_Voltage*calculated_current;

  //Molar Conversion due to splitting of H2O
  molTransfer_H2 = Total_current/(numElecTransferred_per_H2prod*Fa);
  molTransfer_O2 = molTransfer_H2/2; //For every 2 moles of hydrogen, 1 mole of oxygen is produced

  //Molar Flows at the inlet of Cathode and Anode
  molflow_H2_in = wstartCathodeIn*XCathodeIn[1]/mwH2;
  molflow_H2O_in = wstartCathodeIn*XCathodeIn[2]/mwH2O;
  molflow_O2_in = wstartAnodeIn*XAnodeIn[2]/mwO2;
  molflow_N2_in = wstartAnodeIn*XAnodeIn[1]/mwN2;

  //Steam utilization of SOEC
  SteamUtilization = molTransfer_H2/(molflow_H2O_in);

  molflow_H2O_out = molflow_H2O_in*(1-SteamUtilization);
  molflow_H2_out = molTransfer_H2 + molflow_H2_in;
  molflow_O2_out = molTransfer_O2 + molflow_O2_in;
  molflow_N2_out = molflow_N2_in;
  electricalLoad.f = f;

  Q_transfer = molTransfer_O2*mwO2*MediumAnode.specificEnthalpy_pTX(P_operating_anode,AnodeVolume.medium.T,{0,1}); //energy gain from pure oxygen stream coming into the anode
  Q_gen1 = molTransfer_H2*mwH2*MediumCathode.specificEnthalpy_pTX(P_operating_cathode,CathodeVolume.medium.T,{1,0}); //energy gain from production of hydrogen
  Q_gen2 =(molflow_H2O_out-molflow_H2O_in)*mwH2O*MediumCathode.specificEnthalpy_pTX(P_operating_cathode, CathodeVolume.medium.T, {0,1}); //energy loss from splitting of water

  connect(CathodeVolume.port_b, CathodeOut) annotation (Line(points={{6,50},{100,50}},                  color={0,127,255}));
  connect(AnodeVolume.port_b, AnodeOut) annotation (Line(points={{6,-48},{100,-48}},                            color={0,127,255}));
  connect(CathodeIn, CathodeTemp.port_a) annotation (Line(points={{-100,50},{-66,50}}, color={0,127,255}));
  connect(CathodeTemp.port_b, CathodeVolume.port_a) annotation (Line(points={{-46,50},{-6,50}}, color={0,127,255}));
  connect(AnodeIn, AnodeTemp.port_a) annotation (Line(points={{-100,-48},{-66,-48}}, color={0,127,255}));
  connect(AnodeTemp.port_b, AnodeVolume.port_a) annotation (Line(points={{-46,-48},{-6,-48}}, color={0,127,255}));
end OxEonV6_Complex;
