within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Basic;
function T_phX
  input AbsolutePressure p;
  input SpecificEnthalpy h;
  input MassFraction X[:];
  output Temperature T;
protected
  constant Common.PropTable_3 T_data(
    table=T_phX_PropTable.T_table,
    pr_1=T_phX_PropTable.p_range,
    pr_2=T_phX_PropTable.h_range,
    pr_3=T_phX_PropTable.X_range);
  // SI.MassFraction X0;
algorithm
  //   X0 :=if (X[1] < 0.35) then 0 else X[1];
  //   X0 :=if (X[1] > 0.75) then 0.65 else X0;
  if X[1] > 0 then
    T := Common.TrilinearInterp(
                max(p, 200),
                min(h, 1e6),
                X[1],
                T_data);
  elseif (p < IFU.BaseIF97.triple.ptriple) then
    T := 275;
    //Modelica.Media.Water.IdealSteam.T_h(h);
  else
    T := Modelica.Media.Water.WaterIF97_base.temperature_ph(p, min(h,
      1e6));
  end if;
  annotation (Inline=true, smoothOrder=2);
end T_phX;
