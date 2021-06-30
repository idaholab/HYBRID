within NHES.Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities;
function rho_phX_der
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction X[:] "Mass fraction";
  input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
  input Real p_der "Derivative of pressure";
  input Real h_der "Derivative of specific enthalpy";
  input Real X_der[:] "Derivative of mass fraction";
  output Real rho_der "Derivative of density";
protected
  constant AbsolutePressure dp=Common.TabDerAssums.dp;
  constant SpecificEnthalpy dh=Common.TabDerAssums.dh;
  constant MassFraction dX=Common.TabDerAssums.dX;
  Temperature T;
  Real T_der(unit="K/s");
  Real dTdp(unit="K/Pa");
  Real dTdh(unit="kg.K/J");
  Temperature dTdX;
algorithm
  T := T_phX(
          p,
          h,
          X);

  dTdp := (T_phX(
          p + 0.5*dp,
          h,
          X) - T_phX(
          p - 0.5*dp,
          h,
          X))/dp;
  dTdh := (T_phX(
          p,
          h + 0.5*dh,
          X) - T_phX(
          p,
          h - 0.5*dh,
          X))/dh;
  dTdX := (T_phX(
          p,
          h,
          {X[1] + 0.5*dX,X[2] - 0.5*dX}) - T_phX(
          p,
          h,
          {X[1] - 0.5*dX,X[2] + 0.5*dX}))/dX;
  T_der := dTdp*p_der + dTdh*h_der + dTdX*X_der[1];
  rho_der := rho_pTX_der(
          p,
          T,
          X,
          lithiumBromideWaterBaseProp_pTX(
            p,
            T,
            X),
          p_der,
          T_der,
          X_der)*dTdh;
end rho_phX_der;
