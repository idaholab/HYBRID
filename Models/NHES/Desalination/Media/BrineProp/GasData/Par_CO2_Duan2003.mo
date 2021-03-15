within NHES.Desalination.Media.BrineProp.GasData;
function Par_CO2_Duan2003 "Duan,Sun(2003)"
  input Modelica.Units.SI.Pressure p;
  input Modelica.Units.SI.Temperature T;
  input Real[:] c;
  output Real Par;
protected
  Types.Pressure_bar p_bar = Modelica.Units.Conversions.to_bar(
                                                   p);
algorithm
  //eq. 7
  Par := c[1] + c[2] * T + c[3] / T + c[4] * T ^ 2 + c[5] / (630 - T) + c[6] * p_bar + c[7] * p_bar * log(T) + c[8] * p_bar / T + c[9] * p_bar / (630 - T) + c[10] * p_bar ^ 2 / (630 - T) ^ 2 + c[11] * T * log(p_bar);
  //  Modelica.Utilities.Streams.print("Par_CO2_Duan2003, log="+String(Modelica.Math.log(T)));
end Par_CO2_Duan2003;
