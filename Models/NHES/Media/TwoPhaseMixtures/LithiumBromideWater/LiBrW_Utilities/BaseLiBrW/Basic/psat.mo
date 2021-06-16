within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Basic;
function psat "Saturation pressure as function of T and X"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input MassFraction X[:] "Mass Fraction";
  output AbsolutePressure psat
    "Saturation Pressure";
protected
  constant Common.PropTable_2 p_data(
    table=psat_TX_PropTable.p_table,
    pr_1=psat_TX_PropTable.T_range,
    pr_2=psat_TX_PropTable.X_range);
  Temperature T0;
algorithm

  T0 := if (T < 273) then 274 else T;
  T0 := if (T > 573) then 573 else T;

  if X[1] > 0 then
    psat := Common.BilinearInterp(
                T0,
                X[1],
                p_data);
  elseif T0 < IFU.BaseIF97.triple.Ttriple then
    psat := IFU.BaseIF97.triple.ptriple;
  else
    psat := IFU.BaseIF97.Basic.psat(T0);
  end if;

  annotation (derivative=psat_der);
end psat;
