within NHES.Desalination.Media.BrineProp.GasData;
partial function partial_fugacity_pTX
  input Modelica.Units.SI.Pressure p "in Pa";
  input Modelica.Units.SI.Temperature T "in K";
  output Real phi "fugacity coefficient";
protected
  Types.Pressure_bar p_bar = Modelica.Units.Conversions.to_bar(
                                                   p);
end partial_fugacity_pTX;
