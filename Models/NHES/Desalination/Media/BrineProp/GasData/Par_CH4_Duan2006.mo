within NHES.Desalination.Media.BrineProp.GasData;
function Par_CH4_Duan2006 "Duan,Sun(2003)"
  input Modelica.Units.SI.Pressure p;
  input Modelica.Units.SI.Temperature T;
  input Real[:] c;
  output Real Par;
protected
  Types.Pressure_bar p_bar = Modelica.Units.Conversions.to_bar(
                                                   p);
algorithm
  //eq. 7
  Par := c[1] + c[2] * T + c[3] / T + c[4] * T ^ 2 + c[5] / T ^ 2 + c[6] * p_bar + c[7] * p_bar * T + c[8] * p_bar / T + c[9] * p_bar / T ^ 2 + c[10] * p_bar ^ 2 * T;
end Par_CH4_Duan2006;
