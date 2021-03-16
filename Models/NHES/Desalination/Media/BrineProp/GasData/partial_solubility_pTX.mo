within NHES.Desalination.Media.BrineProp.GasData;
partial function partial_solubility_pTX
  input Modelica.Units.SI.Pressure p;
  input Modelica.Units.SI.Temperature T;
  input Modelica.Units.SI.MassFraction X[:] "mass fractions m_x/m_Sol";
  input Modelica.Units.SI.MolarMass MM_vec[:] "molar masses of components";
  input Modelica.Units.SI.Pressure p_gas;
  //  output SI.MassFraction c_gas "gas concentration in kg_gas/kg_H2O";
  output Modelica.Units.SI.MassFraction X_gas
    "gas concentration in kg_gas/kg_fluid";
protected
  Types.Molality solu "gas solubility";
  //algorithm
  //    print("mola("+String(X_gas)+","+String(T-273.16)+")=->k="+String(X_gas/max(1,p_gas))+" (partial_solubility_pTX)");
end partial_solubility_pTX;
