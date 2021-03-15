within NHES.Desalination.Media.BrineProp.SpecificEnthalpies;
function HeatCapacityRatio_KCl_White
  extends BrineProp.SpecificEnthalpies.PartialCpRatio_KCl_White;
  //2D-fit Reproduction of measurements of heat capacity of KCl solution
  output Real cp_by_cpWater;
  //  SI.SpecificHeatCapacity cp_Water =  Modelica.Media.Water.IF97_Utilities.cp_pT(p, T);
algorithm
  //cp_by_cpWater :=p00 + p10*T + p01*b + p20*T^2 + p11*T*b + p02*b^2;
  cp_by_cpWater := a + b * bn + c * Tn + d * bn ^ 2 + e * bn * Tn + f * Tn ^ 2 + g * bn ^ 2 * Tn + h * bn * Tn ^ 2 + i * Tn ^ 3;
  //cp = cp_by_cpWater*cp_Water;
  //print("Brine.specificEnthalpy_pTX_Francke: "+String(p*1e-5)+"bar."+String(T)+"degC->"+String(h)+" J/kg");
end HeatCapacityRatio_KCl_White;
