within NHES.Media.Solids.NASAGlenn.NASA_Utilities;
function h_T
  extends Modelica.Icons.Function;
  input Temperature T;
  input Common.SingleSpeciesData ssd;
  output SpecificEnthalpy h;
protected
  Integer n_i=get_n_i(T, ssd);
algorithm
  h := ({-T^(-2),Modelica.Math.log(T)/T,1,T/2,(T^2)/3,(T^3)/4,(T^4)/5,1/T}*cat(
            1,
            ssd.a[n_i, :],
            {ssd.b[n_i, 1]}))*ssd.R_m*T;
  annotation (Inline=true, smoothOrder=2);
end h_T;
