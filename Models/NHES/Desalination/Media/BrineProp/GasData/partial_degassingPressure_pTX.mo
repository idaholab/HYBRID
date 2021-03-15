within NHES.Desalination.Media.BrineProp.GasData;
partial function partial_degassingPressure_pTX
  input Modelica.Units.SI.Pressure p;
  input Modelica.Units.SI.Temperature T;
  input Modelica.Units.SI.MassFraction X[:] "mass fractions m_x/m_Sol";
  input Modelica.Units.SI.MolarMass MM_vec[:] "molar masses of components";
  output Modelica.Units.SI.Pressure p_gas;
end partial_degassingPressure_pTX;
