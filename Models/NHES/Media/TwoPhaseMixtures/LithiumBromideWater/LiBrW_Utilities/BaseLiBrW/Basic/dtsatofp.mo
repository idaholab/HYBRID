within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Basic;
function dtsatofp
  input AbsolutePressure p;
  input MassFraction X[:];
  output Real dtsat(unit="K/Pa");
protected
  constant AbsolutePressure dp=Common.TabDerAssums.dp;
  Real dtdp(unit="K/Pa");
  Temperature T_pminus;
  Temperature T_pplus;
algorithm
  if (X[1] > 0) then
    T_pminus := tsat(p - 0.5*dp, X);
    T_pplus := tsat(p + 0.5*dp, X);
    dtsat := (T_pplus - T_pminus)/dp;
  else
    dtsat := IFU.BaseIF97.Basic.dtsatofp(p);
  end if;
end dtsatofp;
