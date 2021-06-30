within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function region_pTX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input Temperature T;
  input MassFraction X[:];
  input Integer mode=0;
  output Integer region;
algorithm
  if (mode <> 0) then
    region := mode;
  elseif (X[1] > 0) then
    region := 7;
  elseif (p < IFU.BaseIF97.triple.ptriple) then
    region := 6;
  else
    region := IFU.BaseIF97.Regions.region_pT(p, T);
  end if;
end region_pTX;
