within NHES.Media.SolarSalt;
package Utilities_SolarSalt
  import TRANSFORM;
 // ORNL/TM-2006/12
  extends TRANSFORM.Icons.UtilitiesPackage;
  function d_T
    input SI.Temperature T;
    output SI.Density d;
  algorithm
    d:=-0.636*T+2090;
  end d_T;

  function eta_T
    input SI.Temperature T;
    output SI.DynamicViscosity eta;
  algorithm
    eta:=1.4648e-1*exp(-0.00514633*T);
  end eta_T;

  function lambda_T
    input SI.Temperature T;
    output SI.ThermalConductivity lambda;
  algorithm
    lambda:=0.5;
  end lambda_T;

  function cp_T
    input SI.Temperature T;
    output SI.SpecificHeatCapacity cp;
  algorithm
    cp:=1443+0.172*T;
  end cp_T;
end Utilities_SolarSalt;
