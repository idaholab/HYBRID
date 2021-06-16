within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function s_phX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEnthalpy h;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output SpecificEntropy s;
algorithm
  if (X[1] > 0) or (p < IFU.BaseIF97.triple.ptriple) then
    s := s_props_phX(
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
    s := IFU.s_props_ph(
            p,
            h,
            IFU.waterBaseProp_ph(
              p,
              h,
              phase,
              region));
  end if;
  annotation (Inline=true, smoothOrder=2);
end s_phX;
