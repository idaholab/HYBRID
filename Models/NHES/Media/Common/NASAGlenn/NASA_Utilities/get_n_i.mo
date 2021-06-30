within NHES.Media.Common.NASAGlenn.NASA_Utilities;
function get_n_i
  extends Modelica.Icons.Function;
  input Temperature T;
  input Common.SingleSpeciesData ssd;
  output Integer n_i;
protected
  Integer i=1;
algorithm
  if ssd.n == 1 or T >= ssd.T_lims[ssd.n, 2] then
    n_i := ssd.n;
  elseif
    T <= ssd.T_lims[1,1] then
    n_i :=1;
  else
    while (T >= ssd.T_lims[i, 2]) loop
      i := i + 1;
    end while;
  end if;
  n_i := i;
end get_n_i;
