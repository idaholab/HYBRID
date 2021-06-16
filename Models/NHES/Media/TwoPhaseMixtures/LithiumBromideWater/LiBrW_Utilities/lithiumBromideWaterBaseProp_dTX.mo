within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function lithiumBromideWaterBaseProp_dTX
  extends Modelica.Icons.Function;
  input Density d;
  input Temperature T;
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
  aux.rho := d;
  aux.T := T;
  aux.X := X;
  aux.region := if region == 0 then BaseLiBrW.Regions.region_dTX(
          aux.rho,
          aux.T,
          aux.X) else region;

  if (aux.region == 7) then
    aux.p := BaseLiBrW.Basic.psat(aux.T, aux.X);
    g := BaseLiBrW.Basic.g(
            aux.p,
            aux.T,
            aux.X);
    aux.R_s := g.R_s;
    //aux.s :=-g.dgdT;
    aux.h := g.g - (aux.T*g.dgdT);
    //aux.rho := abs(1/g.dgdp);
    aux.rho := if g.dgdp > 0 then 1/g.dgdp else 1000;
    aux.vp := 0;
    aux.vx := g.dgdpdX;
    aux.cp := -aux.T*g.d2gdT2;
    aux.hp := g.dhdp;
    aux.hx := g.dhdX;
    aux.sx := -g.dgdTdX;
    // elseif (aux.region == 7) then
    //   aux.T :=BaseLiBrW.Basic.T_psX(
    //         aux.p,
    //         aux.s,
    //         aux.X);
    //   g :=BaseLiBrW.Basic.g(
    //         aux.p,
    //         aux.T,
    //         aux.X);
    //   aux.R :=g.R;
    //   //aux.s :=-g.dgdT;
    //   aux.h :=g.g - (aux.T*g.dgdT);
    //   aux.rho :=abs(1/g.dgdp);
    //   aux.vp :=0;
    //   aux.vx :=g.dgdpdX;
    //   aux.cp :=-aux.T*g.d2gdT2;
    //   aux.hp :=g.dhdp;
    //   aux.hx :=g.dhdX;
    //   aux.sx :=-g.dgdTdX;
  elseif (aux.region == 6) then
    aux.T := Modelica.Media.Water.IdealSteam.T_ps(aux.p, aux.s - s_os);
    g.g := aux.h - aux.T*aux.s;
    aux.h := IGW.Functions.h_T(IGW.SingleGasesData.H2O, aux.T);
    aux.R_s := IGW.SingleGasesData.H2O.R_s;
    aux.rho := aux.p/(aux.R_s*aux.T);
    aux.vt := aux.R_s/aux.p;
    aux.vx := 0;
    aux.cp := IGW.Functions.cp_T(T=aux.T, data=IGW.SingleGasesData.H2O);
    aux.hp := g.dhdp;
  else
    aux_w := IFU.waterBaseProp_ps(
            aux.p,
            aux.s,
            phase,
            aux.region);
    aux.R_s := aux_w.R_s;
    //aux.s :=aux_w.s;
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
end lithiumBromideWaterBaseProp_dTX;
