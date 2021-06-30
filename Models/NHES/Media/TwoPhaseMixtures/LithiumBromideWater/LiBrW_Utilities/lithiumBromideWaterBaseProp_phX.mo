within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function lithiumBromideWaterBaseProp_phX
  extends Modelica.Icons.Function;
  input AbsolutePressure p;
  input SpecificEnthalpy h;
  input MassFraction X[:];
  input Integer phase=0;
  input Integer region=0;
  output Common.LiBrWBaseTwoPhase aux;
protected
  Common.GibbsDerivs g;
  Modelica.Media.Common.IF97BaseTwoPhase aux_w;
  Integer error;
  SpecificEntropy s_os=-1163.2672155;
  SpecificEnthalpy h_os=1997638.12889;
algorithm
  aux.p := p;
  aux.h := h;
  aux.X := X;
  aux.region := if region == 0 then BaseLiBrW.Regions.region_phX(
          aux.p,
          aux.h,
          aux.X) else region;
  if (aux.region == 7) then
    aux.T := BaseLiBrW.Basic.T_phX(
            aux.p,
            aux.h,
            aux.X);
    g := BaseLiBrW.Basic.g(
            aux.p,
            aux.T,
            aux.X);
    aux.R_s := g.R_s;
    aux.s := -g.dgdT;
    aux.rho := 1/max(g.dgdp, 1e-4);
    //aux.rho := if g.dgdp > 0 then 1/g.dgdp else 1000;
    aux.vp := 0;
    aux.vx := g.dgdpdX;
    aux.cp := -aux.T*g.d2gdT2;
    aux.hp := g.dhdp;
    aux.hx := g.dhdX;
    aux.sx := -g.dgdTdX;
  elseif (aux.region == 6) then
    aux.T := 275;
    aux.s := IGW.Functions.s0_T(T=aux.T, data=IGW.SingleGasesData.H2O) +
      s_os;
    g.g := aux.h - aux.T*aux.s;
    aux.R_s := IGW.SingleGasesData.H2O.R_s;
    aux.rho := aux.p/(aux.R_s*aux.T);
    aux.vt := aux.R_s/max(aux.p, Modelica.Constants.small);
    aux.vx := 0;
    aux.cp := IGW.Functions.cp_T(T=aux.T, data=IGW.SingleGasesData.H2O);
    aux.hp := g.dhdp;
  else
    aux_w := IFU.waterBaseProp_ph(
            aux.p,
            aux.h,
            phase,
            aux.region);
    aux.R_s := aux_w.R_s;
    aux.s := aux_w.s;
    aux.phase := aux_w.phase;
    aux.region := aux_w.region;
    aux.h := aux_w.h;
    aux.cp := aux_w.cp;
    aux.cv := aux_w.cv;
    aux.rho := aux_w.rho;
    aux.pt := aux_w.pt;
    aux.pd := aux_w.pd;
    aux.vt := aux_w.vt;
    aux.vp := aux_w.vp;
    aux.x := aux_w.x;
    aux.dpT := aux_w.dpT;
  end if;
end lithiumBromideWaterBaseProp_phX;
