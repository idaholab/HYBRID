within NHES.Media.TwoPhaseMixtures.LithiumBromideWater;
package LiBrW_Utilities
    extends Modelica.Icons.UtilitiesPackage;
    import IFU = Modelica.Media.Water.IF97_Utilities;
    import IGW = Modelica.Media.IdealGases.Common;








    //   function T_phX_der "Derivative function of T_phX"
    //     extends Modelica.Icons.Function;
    //     input SI.AbsolutePressure p "Pressure";
    //     input SI.SpecificEnthalpy h "Specific enthalpy";
    //     input SI.MassFraction X[:];
    //     input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
    //     input Real p_der "Derivative of pressure";
    //     input Real h_der "Derivative of specific enthalpy";
    //     input Real X_der[:];
    //     output Real T_der "Derivative of temperature";
    //   algorithm
    //     if (aux.region == 7) then
    //       T_der := 0;
    //     elseif (aux.region == 6) then
    //       T_der := 0;
    //     else
    //       IFU.T_ph_der(
    //           p,
    //           h,
    //           aux,
    //           p_der,
    //           h_der);
    //     end if;
    //   end T_phX_der;







    //   function p_dTX_der "Derivative function of p_dTX"
    //     extends Modelica.Icons.Function;
    //     input SI.Density d "Density";
    //     input SI.Temperature T "Temperature";
    //     input SI.MassFraction X[:] "Mass fraction";
    //     input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
    //     input Real d_der "Derivative of density";
    //     input Real T_der "Derivative of temperature";
    //     input Real X_der[:] "Derivative of mass fraction";
    //     output Real p_der "Derivative of pressure";
    //   algorithm
    //     if (aux.region == 7) then
    //       p_der := 0;
    //     elseif (aux.region == 6) then
    //       p_der := 0;
    //     else
    //       p_der := IFU.p_dT_der(
    //           d,
    //           T,
    //           aux,
    //           d_der,
    //           T_der);
    //     end if;
    //   end p_dTX_der;



    //   function h_dTX_der
    //     extends Modelica.Icons.Function;
    //     input SI.Density d "Density";
    //     input SI.Temperature T "Temperature";
    //     input SI.MassFraction X[:] "Mass fraction";
    //     input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
    //     input Real d_der "Derivative of density";
    //     input Real T_der "Derivative of temperature";
    //     input Real X_der[:] "Derivative of mass fraction";
    //     output Real h_der "Derivative of specific enthalpy";
    //   algorithm
    //     if (aux.region == 7) then
    //       h_der := 0;
    //     elseif (aux.region == 6) then
    //       h_der := 0;
    //     else
    //       h_der := IFU.h_dT_der(
    //           d,
    //           T,
    //           aux,
    //           d_der,
    //           T_der);
    //     end if;
    //   end h_dTX_der;




    //   function h_pTX_der "Derivative function of h_pTX"
    //     extends Modelica.Icons.Function;
    //     input SI.AbsolutePressure p "Pressure";
    //     input SI.Temperature T "Temperature";
    //     input SI.MassFraction X[:] "Mass fraction";
    //     input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
    //     input Real p_der "Derivative of pressure";
    //     input Real T_der "Derivative of temperature";
    //     input Real X_der[:] "Derivative of mass fraction";
    //     output Real h_der "Derivative of specific enthalpy";
    //   algorithm
    //     if (aux.region == 7) then
    //       h_der := 0;
    //     elseif (aux.region == 6) then
    //       h_der := 0;
    //     else
    //       h_der := IFU.h_pT_der(
    //           p,
    //           T,
    //           aux,
    //           p_der,
    //           T_der);
    //     end if;
    //   end h_pTX_der;















    //   function s_phX_der
    //     extends Modelica.Icons.Function;
    //     input SI.AbsolutePressure p "Pressure";
    //     input SI.SpecificEnthalpy h "Specific enthalpy";
    //     input SI.MassFraction X[:] "Mass fraction";
    //     input Common.LiBrWBaseTwoPhase aux "Auxiliary record";
    //     input Real p_der "Derivative of pressure";
    //     input Real h_der "Derivative of specific enthalpy";
    //     input Real X_der[:] "Derivative of mass fraction";
    //     output Real s_der "Derivative of entropy";
    //   algorithm
    //     if (aux.region == 7) then
    //       s_der := 0;
    //     elseif (aux.region == 6) then
    //       s_der := 0;
    //     else
    //       s_der := IFU.s_ph_der(
    //           p,
    //           h,
    //           aux,
    //           p_der,
    //           h_der);
    //     end if;
    //     annotation (Inline=true);
    //   end s_phX_der;
















































end LiBrW_Utilities;
