within NHES.Media.Common.NASAGlenn.NASA_Utilities;
function h_T
  extends Modelica.Icons.Function;
  input Temperature T_0;
  input Common.SingleSpeciesData ssd;
  output SpecificEnthalpy h;

protected
  Integer n_i=get_n_i(T, ssd);
  Temperature T = if T_0 < 200 then 300 elseif T_0 > 1000 then 500 else T_0;
algorithm
//    if T < 250 or T > 1000 then
//      Modelica.Utilities.Streams.print(String(T));
//    end if;
  h := ({-T^(-2),Modelica.Math.log(T)/T,1,T/2,(T^2)/3,(T^3)/4,(T^4)/5,1/T}*cat(
            1,
            ssd.a[n_i, :],
            {ssd.b[n_i, 1]}))*ssd.R_m*T;
  annotation (Inline=true, smoothOrder=2);
end h_T;
