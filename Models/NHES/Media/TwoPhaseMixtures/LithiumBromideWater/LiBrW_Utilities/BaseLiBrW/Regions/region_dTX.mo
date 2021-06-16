within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function region_dTX "Assumes saturated if X[1] > 0"
  extends Modelica.Icons.Function;
  input Density d;
  input Temperature T;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer mode=0;
  output Integer region;
algorithm
  if (mode <> 0) then
    region := mode;
  elseif (X[1] > 0) then
    region := 7;
  elseif d < IFU.BaseIF97.triple.dvtriple then
    region := 6;
  else
    region := IFU.BaseIF97.Regions.region_dT(d, T);
  end if;
end region_dTX;
