within NHES.Desalination.Media.BrineProp.Viscosities;
function dynamicViscosity_Zhang_pTXd
  "Multisalt-Version of viscosity calculation according to Zhang et al 1997: Considers NaCl and CaCl, with geometric mixture rule"
  //doi:10.1007/s10765-009-0646-7
  input Modelica.Units.SI.Pressure p_Pa;
  input Modelica.Units.SI.Temperature T_K;
  input Modelica.Units.SI.MassFraction X[:] "mass fraction m_NaCl/m_Sol";
  input Modelica.Units.SI.Density d;
  input Modelica.Units.SI.MolarMass MM[:];
  output Modelica.Units.SI.DynamicViscosity eta;
protected
  Modelica.Units.NonSI.Temperature_degC T_C=Modelica.Units.Conversions.to_degC(
      T_K);
  Pressure_bar p_bar = Modelica.Units.Conversions.to_bar(
                                             p_Pa);
  Real A = 0.0157;
  Real B = 0.271;
  Real D = 0.04712;
  Real E = 94;
  Real F = 3;
  Real eta_relative;
  Modelica.Units.SI.DynamicViscosity eta_H2O;
  Modelica.Media.Water.WaterIF97_pT.ThermodynamicState state_H2O;
  constant Molality[:] molalities = Utilities.massToMoleFractions(X, MM);
  // constant Partial_Units.Molality[:] molalities=X[1:nX_salt] ./ MM[1:nX_salt]/      X[end];
  Molarity_molperliter c = X[3] / MM[3] * d / 1000;
algorithm
  //   print("X[3]="+String(X[3])+" (Brine.Viscosities.dynamicViscosity_Duan_pTX)");
  if debugmode then
    print("p=" + String(p_Pa) + " Pa, T_K" + String(T_K) + " K (Brine.Viscosities.dynamicViscosity_Duan_pTX)");
  end if;
  assert(T_C >= 0 and T_C <= 400, "Temperature must be between 10 and 350degC");
  assert(p_bar >= 1 and p_bar <= 1000, "Pressure must be between 1 and 500 bar");
  //viscosity calculation
  state_H2O := Modelica.Media.Water.WaterIF97_pT.setState_pTX(p_Pa, T_K, X);
  eta_H2O := Modelica.Media.Water.WaterIF97_pT.dynamicViscosity(state_H2O);
  //  print("eta_H2O= "+String(eta_H2O)+" Pa.s");
  //for pure water skip the whole calculation and return water viscosity
  if X[3] < 1e-8 then
    eta := eta_H2O;
    return;
  end if;
  assert(molalities[3] > 0 and molalities[3] < 3, "Molality b=" + String(molalities[3]) + " too high. (BrineProp.Viscosities.dynamicViscosity_Zhang_pTX)");
  eta_relative := 1 + A * c ^ 0.5 + B * c + D * c ^ 2 + E * c ^ 3.5 + F * c ^ 7;
  eta := eta_relative * eta_H2O;
  print("Molarity c= " + String(c) + " mol/l (BrineProp.Viscosities.dynamicViscosity_Zhang_pTX)");
  print("Molality b= " + String(molalities[3]) + " mol/kg (BrineProp.Viscosities.dynamicViscosity_Zhang_pTX)");
  print("eta_relative CaCl2: " + String(eta_relative) + " Pa.s (BrineProp.Viscosities.dynamicViscosity_Zhang_pTX)");
  //  print("Viscosity CaCl2: "+String(eta)+" Pa.s (BrineProp.Viscosities.dynamicViscosity_Zhang_pTX)");
end dynamicViscosity_Zhang_pTXd;
