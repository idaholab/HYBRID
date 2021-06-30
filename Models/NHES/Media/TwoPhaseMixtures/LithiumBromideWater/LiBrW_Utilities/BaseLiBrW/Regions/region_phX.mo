within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function region_phX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEnthalpy h;
  input MassFraction X[:];
  input Integer phase=0;
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
    region := IFU.BaseIF97.Regions.region_ph(p, h);
  end if;
end region_phX;
