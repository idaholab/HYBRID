within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function rho_phX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEnthalpy h;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output Density rho;
algorithm
  if (X[1] > 0) or (p < IFU.BaseIF97.triple.ptriple) or (region > 5) then
    // rho :=1500;
    rho := rho_props_phX(
            p,
            h,
            X,
            lithiumBromideWaterBaseProp_phX(
              p,
              h,
              X,
              phase,
              region));

  else
    rho := IFU.rho_props_ph(
            max(p, 612),
            h,
            IFU.waterBaseProp_ph(
              max(p, 612),
              h,
              phase,
              region));
    //rho :=1;
  end if;
  annotation (Inline=true, smoothOrder=2);
end rho_phX;
