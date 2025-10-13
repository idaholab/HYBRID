within NHES.Media.HITEC;
package Utilities_HITEC
  import TRANSFORM;
 // Document from Rami, got it from a vendor data sheet
  extends TRANSFORM.Icons.UtilitiesPackage;
  function d_T
    input SI.Temperature T;
    output SI.Density d;
  algorithm
    d:=-0.72222*T+1950;
  end d_T;

  function eta_T
    input SI.Temperature T;
    output SI.DynamicViscosity eta;
  algorithm
    eta:=2.652e-1*exp(-0.007614*T);
  end eta_T;

  function lambda_T
    input SI.Temperature T;
    output SI.ThermalConductivity lambda;
  algorithm
    lambda:=0.6;
  end lambda_T;

  function cp_T
    input SI.Temperature T;
    output SI.SpecificHeatCapacity cp;
  algorithm
    cp:=1495.3;
  end cp_T;
end Utilities_HITEC;
