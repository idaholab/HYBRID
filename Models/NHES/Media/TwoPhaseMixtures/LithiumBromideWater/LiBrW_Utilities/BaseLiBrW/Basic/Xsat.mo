within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Basic;
function Xsat
  "Saturation mass fraction as a function of p and T"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  output MassFraction[2] Xsat
    "Saturation mass fraction";
protected
  MassFraction X_1;
  constant Common.PropTable_2 X_data(
    table=xsat_pT_PropTable.x_table,
    pr_1=xsat_pT_PropTable.p_range,
    pr_2=xsat_pT_PropTable.T_range);
algorithm
  X_1 := Common.BilinearInterp(
              max(p, 200),
              min(T, 303),
              X_data);
  Xsat := {X_1,1 - X_1};
  annotation (Inline=true, smoothOrder=2);
end Xsat;
