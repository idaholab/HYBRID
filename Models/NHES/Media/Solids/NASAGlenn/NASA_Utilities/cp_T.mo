within NHES.Media.Solids.NASAGlenn.NASA_Utilities;
function cp_T
  extends Modelica.Icons.Function;
  input Temperature T;
  input Interfaces.Types.SolidConstants sc;
  output SpecificHeatCapacity cp;
protected
  Integer n_i=get_n_i(T, sc);
algorithm
    cp := ({T^(-2),T^(-1),1,T,T^2,T^3,T^4}*sc.a[n_i, :])*sc.R_m;
  annotation (Inline=true, smoothOrder=2);
end cp_T;
