within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Basic;
function g
  extends Modelica.Icons.Function;
  import MATH = Modelica.Math;
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature (K)";
  input MassFraction X[:]={0.6,0.4} "Mass fraction";
  output Common.GibbsDerivs g "Gibbs function and derivatives";
protected
  constant Common.LiBrWData d(
    T_num=T + d.T_0,
    T_den=if (T - d.T_0 <= 0) then 50 else T - d.T_0,
    x_per=100*X[1],
    p_kpa=(1/d.C_kpa2pa)*p,
    x_po={1,d.x_per,d.x_per^2,d.x_per^3,d.x_per^1.1},
    xT_po={1,d.x_per,d.x_per^2,T,d.x_per*T,(d.x_per^2)*T,T^2,d.x_per*(
        T^2)},
    xT_po_dgdT={1,d.x_per,d.x_per^2,2*T,2*d.x_per*T},
    xT_po_dgdX={1,2*d.x_per,T,2*T*d.x_per,T^2},
    xT_po_dudT={1,d.x_per,d.x_per^2,4*T,4*d.x_per*T},
    V_dgdX={d.V[2],d.V[3],d.V[5],d.V[6],d.V[8]},
    C_F=1 + (d.T_num/d.T_den));
algorithm
  g.p := p;
  g.T := if (T > 0) then T else 300;
  g.X := X;
  //g.MM :=1/sum(X./MW);
  //g.R := 1;
  //Modelica.Constants.R/g.MM;

  g.g := (1/d.C_g2kg)*(d.A*d.x_po + T*(d.B*d.x_po) + (T^2)*(d.C*d.x_po)
     + (T^3)*(d.D*d.x_po) + (T^4)*(d.E*d.x_po[1:2]) + (d.F*d.x_po[1:2])
    /d.T_den + d.p_kpa*(d.V*d.xT_po) + MATH.log(g.T/d.T_norm)*(d.L*d.x_po)
     + T*MATH.log(g.T/d.T_norm)*(d.M*d.x_po));
  g.dgdp := (1/d.C_g2kg)*(1/d.C_kpa2pa)*(d.V*d.xT_po);
  g.dgdpdT := (1/d.C_g2kg)*(1/d.C_kpa2pa)*d.V[4:8]*d.xT_po_dgdT;
  g.dgdpdX := (1/d.C_g2kg)*(1/d.C_kpa2pa)*d.V_dgdX*d.xT_po_dgdX;
  g.dgdT := (1/d.C_g2kg)*((d.B*d.x_po) + 2*T*(d.C*d.x_po) + 3*(T^2)*(
    d.D*d.x_po) + 4*(T^3)*(d.E*d.x_po[1:2]) - (d.F*d.x_po[1:2])/(d.T_den
    ^2) + d.p_kpa*(d.V[4:8]*d.xT_po_dgdT) + (1/g.T)*(d.L*d.x_po) + (
    MATH.log(g.T/d.T_norm) + 1)*(d.M*d.x_po));
  g.d2gdT2 := (1/d.C_g2kg)*(2*(d.C*d.x_po) + 6*g.T*(d.D*d.x_po) + 12*(
    g.T^2)*(d.E*d.x_po[1:2]) + 2*(d.F*d.x_po[1:2])/(d.T_den^3) + 2*d.p_kpa
    *(d.V[7:8]*d.x_po[1:2]) - (1/(g.T^2))*(d.L*d.x_po) + (1/g.T)*(d.M*
    d.x_po));
  g.dgdTdX := (1/d.C_g2kg)*((d.B[2:5]*d.x_po_dgdX) + 2*T*(d.C[2:5]*d.x_po_dgdX)
     + 3*(T^2)*(d.D[2:5]*d.x_po_dgdX) + 4*(T^3)*d.E[2] - (d.F[2]/(d.T_den
    ^2)) + d.p_kpa*(d.V[5] + 2*d.V[6]*d.x_per + 2*T*d.V[8]) + (1/g.T)*
    (d.L[2:5]*d.x_po_dgdX)) + (MATH.log(g.T/d.T_norm) + 1)*(d.M[2:5]*
    d.x_po_dgdX);
  g.dgdX := (1/d.C_g2kg)*((d.A[2:5]*d.x_po_dgdX) + T*(d.B[2:5]*d.x_po_dgdX)
     + (T^2)*(d.C[2:5]*d.x_po_dgdX) + (T^3)*(d.D[2:5]*d.x_po_dgdX) + (
    T^4)*d.E[2] + d.F[2]/d.T_den + d.p_kpa*(d.V_dgdX*d.xT_po_dgdX) +
    MATH.log(g.T/d.T_norm)*(d.L[2:5]*d.x_po_dgdX) + T*MATH.log(g.T/d.T_norm)
    *(d.M[2:5]*d.x_po_dgdX));
  g.dudT := (1/d.C_g2kg)*(-2*T*(d.C*d.x_po) - 6*(T^2)*(d.D*d.x_po) - 12
    *(T^3)*(d.E*d.x_po[1:2]) - d.C_F*((d.F[1]/(d.T_den^2)) + (d.F[2]*
    d.x_per/(d.T_den^2))) - d.p_kpa*(d.V[4:8]*d.xT_po_dudT) + ((1/g.T)
     - 1)*(d.L*d.x_po) - (d.M*d.x_po));
  g.dhdX := (1/d.C_g2kg)*((d.A[2:5]*d.x_po_dgdX) - (g.T^2)*(d.C[2:5]*
    d.x_po_dgdX) - 2*(g.T^3)*(d.D[2:5]*d.x_po_dgdX) - 3*(g.T^4)*d.E[2]
     + (d.F[2]/d.T_den) + (d.F[2]*g.T/(d.T_den^2)) + d.p_kpa*(d.V[2] +
    2*d.x_per*d.V[3] - d.V[8]*(T^2)) + (MATH.log(g.T/d.T_norm) - 1)*(
    d.L[2:5]*d.x_po_dgdX) - T*(d.M[2:5]*d.x_po_dgdX));
  g.dhdp := (1/d.C_g2kg)*(1/d.C_kpa2pa)*(d.V[1] + d.V[2]*d.x_per + d.V[
    3]*(d.x_per^2) - d.V[7]*(g.T^2) - d.V[8]*d.x_per*(g.T^2));
end g;
