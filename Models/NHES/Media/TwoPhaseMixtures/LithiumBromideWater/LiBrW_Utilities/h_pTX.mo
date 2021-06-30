within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function h_pTX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input Temperature T;
  input MassFraction X[:];
  input Integer region=0;
  output SpecificEnthalpy h;
algorithm
  if (X[1] > 0) or (p < IFU.BaseIF97.triple.ptriple) or (T < IFU.BaseIF97.triple.Ttriple) then
    h := h_props_pTX(
            p,
            T,
            X,
            lithiumBromideWaterBaseProp_pTX(
              p,
              T,
              X,
              region));
  else
    h := IFU.h_props_pT(
            p,
            T,
            IFU.waterBaseProp_pT(
              p,
              T,
              region));
  end if;
  annotation (Inline=true, smoothOrder=2);
end h_pTX;
