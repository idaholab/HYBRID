within NHES.Media.Solids.NASAGlenn.NASA_Utilities;
function get_n_i
  extends Modelica.Icons.Function;
  input Temperature T;
  input Common.SingleSpeciesData ssd;
  output Integer n_i;
protected
  Integer i=1;
algorithm
  if ssd.n == 1 then
    n_i := ssd.n;
  else
    while (T >= ssd.T_lims[i, 2]) loop
      i := i + 1;
    end while;
  end if;
  n_i := i;
end get_n_i;
