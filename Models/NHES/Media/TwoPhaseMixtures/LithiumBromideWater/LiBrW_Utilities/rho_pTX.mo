within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function rho_pTX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input Temperature T;
  input MassFraction X[:];
  input Integer region=0;
  output Density rho;
algorithm
  if (X[1] > 0) or (p < IFU.BaseIF97.triple.ptriple) or (T < IFU.BaseIF97.triple.Ttriple) then
    rho := rho_props_pTX(
            p,
            T,
            X,
            lithiumBromideWaterBaseProp_pTX(
              p,
              T,
              X,
              region));
  else
    rho := IFU.rho_props_pT(
            max(p, 612),
            min(T, 573),
            IFU.waterBaseProp_pT(
              max(p, 612),
              min(T, 573),
              region));
  end if;
  annotation (Inline=true, smoothOrder=2);
end rho_pTX;
