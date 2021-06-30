within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function ddhpX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEnthalpy h;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output DerDensityByEnthalpy ddhpX;
algorithm
  if (X[1] > 0) or (p < IFU.BaseIF97.triple.ptriple) then
    ddhpX := ddhpX_props(
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
    ddhpX := IFU.ddhp_props(
            p,
            h,
            IFU.waterBaseProp_ph(
              p,
              h,
              phase,
              region));
  end if;
  annotation (Inline=true);
end ddhpX;
