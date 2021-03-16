within NHES.Desalination.Media.BrineProp.GasData;
function solutionEnthalpy_CO2_Duan2003
  "calculation of solution enthalpy of CO2+H2O according to Duan(2003) equ. 8"
  extends partial_solutionEnthalpy;
  /*  input SI.Temp_K T;
                      output SI.SpecificEnthalpy Delta_h_solution;

                      input SI.Pressure p;
                      input SI.Temp_K T;
                      input MassFraction X[:] "mass fraction m_NaCl/m_Sol";
                      output SI.SpecificEnthalpy h;

                      output SI.SpecificEnthalpy Delta_h_solution 
                        "solution enthalpy per mole";
                      SI.SpecificEnthalpy h_l;
                      SI.SpecificEnthalpy h_g;
                      SI.SpecificEnthalpy h_brine;
                      SI.SpecificEnthalpy h_CO2_dissoluted;
                      SI.SpecificEnthalpy h_H2O_g;
                      SI.SpecificEnthalpy h_CO2_g;
                      SI.SpecificEnthalpy Delta_h_mix "mixing enthalpy in gas phase";*/
protected
  Modelica.Units.SI.Pressure p_H2O;
  Real[:] c = {28.9447706, -0.0354581768, -4770.67077, 1.02782768e-5, 33.8126098, 9.04037140e-3, -1.14934031e-3, -0.307405726, -0.0907301486, 9.32713393e-4, 0};
algorithm
  /*  h_brine := Brine_Driesner.specificEnthalpy_pTX(p,T,X);

                      h_CO2_dissoluted := 0;
                    */
  p_H2O := 0 "Modelica.Media.Water.WaterIF97_pT.saturationPressure(T)";
  Delta_h_solution := Modelica.Constants.R * T ^ 2 * (c[2] - c[3] / T ^ 2 + 2 * c[4] * T + c[5] / (630 - T) ^ 2 + c[7] * p_H2O / T - c[8] * p_H2O / T ^ 2 + c[9] * p_H2O / (630 - T) ^ 2 + 2 * c[10] * p_H2O ^ 2 / (630 - T) ^ 3)
    "eq. 8 Duan 2003";
  /*  h_H2O_g := 0 
                        "Modelica.Media.Water.WaterIF97_pT.dewEnthalpy(Modelica.Media.Water.WaterIF97_pT.setSat_p(p))";

                      h_CO2_g := 0 
                        "Modelica.Media.IdealGases.SingleGases.CO2.specificEnthalpy(Modelica.Media.IdealGases.SingleGases.CO2.specificEnthalpy(p,T))";

                      Delta_h_mix :=0 "ideal mixing";

                      h_l := h_brine + h_CO2_dissoluted + Delta_h_solution 
                        "specific enthalpy of liquid phase";
                      h_g := h_H2O_g + h_CO2_g + Delta_h_mix "specific enthalpy of gas phase";

                      h :=((1 - GVF)*d_l*h_l + GVF*d_g*h_g)/d "summarize according to mass ratio";*/
end solutionEnthalpy_CO2_Duan2003;
