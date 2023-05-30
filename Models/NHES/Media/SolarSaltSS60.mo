within NHES.Media;
package SolarSaltSS60
  "Industry standard solar salt package 60% NaKNO3 40% KNO3"
extends Modelica.Icons.VariantsPackage;
  package ConstantPropertyLiquidSolarSalt
    "Solar Salt Package"
    /*
Properties have been calculated based on a weighted average basis between T_min and T_max
*/
    constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[1]
      SolarSaltConstants(
      each chemicalFormula="NaNO3KNO3",
      each structureFormula="NaNO3KNO3",
      each casRegistryNumber="7647-14-5",
      each iupacName="SolarSalt",
      each molarMass=0.072948);

    extends Modelica.Media.Interfaces.PartialSimpleMedium(
      mediumName="SimpleSolarSalt",
      cp_const=1559,
      cv_const=1559,
      d_const=1660,
      eta_const=0.0008,
      lambda_const=0.5,
      a_const=3300,
      T_min=173,
      T_max=1865,
      T0=298.15,
      MM_const=0.072948,
      fluidConstants=SolarSaltConstants);

    annotation (Documentation(info="<html>

</html>"));
  end ConstantPropertyLiquidSolarSalt;

  package SolarSalt
    "Linear Solar Salt"
    // Energies 2021 14, pp 1195-1209
  // beta_const adjusted till density matched. kappa left alone
  // references are based on 800K
  // assumed specific enthalpy at 273.15 is zero
    extends TRANSFORM.Media.Interfaces.Fluids.PartialLinearFluid(
      mediumName="Linear FLiBe",
      constantJacobian=false,
      reference_p=1e5,
      reference_T=800,
      reference_d=Utilities_SolarSalt.d_T(reference_T),
      reference_h=Utilities_SolarSalt.cp_T(reference_T)*(reference_T - 273.15),
      reference_s=0,
      beta_const=2.4151e-4,
      kappa_const=2.89e-10,
      cp_const=Utilities_SolarSalt.cp_T(reference_T),
      MM_const=0.033,
      T_default=800);

  redeclare function extends dynamicViscosity "Dynamic viscosity"
  algorithm
    eta :=Utilities_SolarSalt.eta_T(state.T);
    annotation(Inline=true);
  end dynamicViscosity;

  redeclare function extends thermalConductivity
      "Thermal conductivity"
  algorithm
    lambda :=Utilities_SolarSalt.lambda_T(state.T);
    annotation(Inline=true);
  end thermalConductivity;
  end SolarSalt;

  package Utilities_SolarSalt
    import TRANSFORM;

    extends TRANSFORM.Icons.UtilitiesPackage;
    function d_T
      input Modelica.Units.SI.Temperature T;
      output Modelica.Units.SI.Density d;
    algorithm
      d:=-0.6679*T+2160;
    end d_T;

    function eta_T
      input Modelica.Units.SI.Temperature T;
      output Modelica.Units.SI.DynamicViscosity eta;
    algorithm
      eta:=1.4648e-1*exp(-0.00514633*T);
    end eta_T;

    function lambda_T
      input Modelica.Units.SI.Temperature T;
      output Modelica.Units.SI.ThermalConductivity lambda;
    algorithm
      lambda:=0.55;
    end lambda_T;

    function cp_T
      input Modelica.Units.SI.Temperature T;
      output Modelica.Units.SI.SpecificHeatCapacity cp;
    algorithm
      cp:=1540.4+3.09E-2*T;
    end cp_T;
  end Utilities_SolarSalt;
end SolarSaltSS60;
