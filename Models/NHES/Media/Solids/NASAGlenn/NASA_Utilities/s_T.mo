within NHES.Media.Solids.NASAGlenn.NASA_Utilities;
function s_T
  extends Modelica.Icons.Function;
  input Temperature T;
  input Interfaces.Types.SolidConstants sc;
  output SpecificEntropy s;
protected
  Integer n_i=get_n_i(T, sc);
algorithm
    s := ({-(T^(-2))/2,-T^(-1),Modelica.Math.log(T),T,(T^2)/2,(T^3)/3,(T^4)/4,1}*
    cat(  1,
          sc.a[n_i, :],
          {sc.b[n_i, 2]}))*sc.R_m;
  annotation (Inline=true, smoothOrder=2);
end s_T;
