within NHES.Media.Common.NASAGlenn.NASA_Utilities;
function cp_T
  extends Modelica.Icons.Function;
  input Temperature T;
  input Interfaces.Types.SolidConstants ssd;
  output SpecificHeatCapacity cp;
protected
  Integer n_i=get_n_i(T, ssd);
algorithm
    cp := ({T^(-2),T^(-1),1,T,T^2,T^3,T^4}*ssd.a[n_i, :])*ssd.R_m;
  annotation (Inline=true, smoothOrder=2);
end cp_T;
