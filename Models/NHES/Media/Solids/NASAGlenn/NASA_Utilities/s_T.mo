within NHES.Media.Solids.NASAGlenn.NASA_Utilities;
function s_T
  extends Modelica.Icons.Function;
  input Temperature T;
  input Interfaces.Types.SolidConstants ssd;
  output SpecificEntropy s;
protected
  Integer n_i=get_n_i(T, ssd);
algorithm
    s := ({-(T^(-2))/2,-T^(-1),Modelica.Math.log(T),T,(T^2)/2,(T^3)/3,(T^4)/4,1}*
    cat(  1,
          ssd.a[n_i, :],
          {ssd.b[n_i, 2]}))*ssd.R_m;
  annotation (Inline=true, smoothOrder=2);
end s_T;
