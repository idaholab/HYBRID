within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function T_phX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEnthalpy h;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output Temperature T;
algorithm
  if (X[1] > 0) or (p < IFU.BaseIF97.triple.ptriple) then
    T := T_props_phX(
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
    IFU.T_props_ph(
            p,
            h,
            IFU.waterBaseProp_ph(
              p,
              h,
              phase,
              region));
  end if;
  annotation (Inline=true, smoothOrder=2);
end T_phX;
