within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Basic;
function T_psX
  input AbsolutePressure p;
  input SpecificEntropy s;
  input MassFraction X[:];
  output Temperature T;
protected
  constant Math.Interpolation.PropTable_3 T_data(
    table=T_psX_PropTable.T_table,
    pr_1=T_psX_PropTable.p_range,
    pr_2=T_psX_PropTable.s_range,
    pr_3=T_psX_PropTable.X_range);
  SpecificEntropy s_os=-1163.2672155;
algorithm
  if X[1] > 0 then
    T :=Math.Interpolation.TrilinearInterp(
      p,
      s,
      X[1],
      T_data);
  elseif (p < IFU.BaseIF97.triple.ptriple) then
    T := Modelica.Media.Water.IdealSteam.T_ps(p, s - s_os);
  else
    T := Modelica.Media.Water.WaterIF97_base.temperature_ps(p, s);
  end if;
end T_psX;
