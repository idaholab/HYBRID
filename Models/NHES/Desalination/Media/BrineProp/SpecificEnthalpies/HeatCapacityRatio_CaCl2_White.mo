within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
function HeatCapacityRatio_CaCl2_White
  //2D-fit Reproduction of measurements of heat capacity of KCl solution
  //  input SI.Pressure p;
  extends BrineProp.SpecificEnthalpies.PartialCpRatio_CaCl2_White;
  output Real cp_by_cpWater;
  //  SI.SpecificHeatCapacity cp_Water =  Modelica.Media.Water.IF97_Utilities.cp_pT(p, T);
algorithm
  cp_by_cpWater := a + b * bn + c * Tn + d * bn ^ 2 + e * bn * Tn + f * Tn ^ 2 + g * bn ^ 2 * Tn + h * bn * Tn ^ 2 + i * Tn ^ 3;
  //cp = cp_by_cpWater*cp_Water;
  //print("Brine.specificEnthalpy_pTX_Francke: "+String(p*1e-5)+"bar."+String(T)+"degC->"+String(h)+" J/kg");
end HeatCapacityRatio_CaCl2_White;
