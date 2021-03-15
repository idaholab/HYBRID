within NHES.Desalination.Media.BrineProp.GasData;
function polyval "Calculates polynomial value for given coefficients"
  input Real c[:];
  input Real x;
  output Real y;
algorithm
  y := 0;
  for j in 0:size(c, 1) - 1 loop
    y := y + c[end - j] * x ^ j;
  end for;
end polyval;
