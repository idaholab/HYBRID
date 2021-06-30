within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Regions;
function region_psX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEntropy s;
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
    region := IFU.BaseIF97.Regions.region_ps(p, s);
  end if;
end region_psX;
