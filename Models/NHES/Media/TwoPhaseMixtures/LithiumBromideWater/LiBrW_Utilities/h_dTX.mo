within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function h_dTX
  extends Modelica.Icons.Function;
  input Density d;
  input Temperature T;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output SpecificEnthalpy h;
algorithm
  if (X[1] > 0) or (d < IFU.BaseIF97.triple.dvtriple) then
    h := h_props_dTX(
            d,
            T,
            X,
            lithiumBromideWaterBaseProp_dTX(
              d,
              T,
              X,
              phase,
              region));
  else
    h := IFU.h_props_dT(
            d,
            T,
            IFU.waterBaseProp_dT(
              d,
              T,
              phase,
              region));
  end if;
  annotation (Inline=true);
end h_dTX;
