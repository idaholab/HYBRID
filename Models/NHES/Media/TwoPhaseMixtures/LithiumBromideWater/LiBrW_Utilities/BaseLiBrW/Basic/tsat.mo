within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Basic;
function tsat
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input MassFraction X[:] "Mass Fraction";
  output Temperature tsat "Saturation Pressure";
protected
  constant Math.Interpolation.PropTable_2 T_data(
    table=Tsat_pX_PropTable.T_table,
    pr_1=Tsat_pX_PropTable.p_range,
    pr_2=Tsat_pX_PropTable.X_range);
algorithm
  if X[1] > 0 then
    tsat :=Math.Interpolation.BilinearInterp(
      max(p, 200),
      X[1],
      T_data);

  elseif p < IFU.BaseIF97.triple.ptriple then
    tsat := IFU.BaseIF97.triple.Ttriple;

  else
    IFU.BaseIF97.Basic.tsat(max(p, 612));
    //Modelica.Utilities.Streams.print(String(tsat));
  end if;

  //annotation (derivative=tsat_der);
  annotation (Inline=true, smoothOrder=2);
end tsat;
