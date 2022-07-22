within NHES.Media;
package Hitec "Industry standard Hitec package (molten)"
extends Modelica.Icons.VariantsPackage;
  package ConstantPropertyLiquidHitec
    "Hitec Package"
    /*
Properties have been calculated based on a weighted average basis between T_min and T_max
*/
    constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[1]
      HitecConstants(
      each chemicalFormula="NaNO3KNO3NaNO2",
      each structureFormula="NaNO3NaNO2KNO3",
      each casRegistryNumber="",
      each iupacName="Hitec",
      each molarMass=0.072948);

    extends Modelica.Media.Interfaces.PartialSimpleMedium(
      mediumName="Hitec",
      cp_const=1200,
      cv_const=1200,
      d_const=1816.12,
      eta_const=0.003121,
      lambda_const=0.6502,
      a_const=3300,
      T_min=443,
      T_max=820,
      T0=298.15,
      MM_const=0.072948,
      fluidConstants=HitecConstants);

    annotation (Documentation(info="<html>

</html>"));
  end ConstantPropertyLiquidHitec;

  package Hitec
    "Hitec solar salt, a eutectic salt composed of sodium nitrate, sodium nitrite, and postassium nitrate"
    //
  // references are based on average values from 170-550C
  // assumed specific enthalpy at 273.15 is zero
    extends TRANSFORM.Media.Interfaces.Fluids.PartialLinearFluid(
      mediumName="Linear Hitec",
      constantJacobian=false,
      reference_p=1e5,
      reference_T=800,
      reference_d=Utilities_Hitec.d_T(reference_T),
      reference_h=Utilities_Hitec.cp_T(reference_T)*(reference_T - 273.15),
      reference_s=0,
      beta_const=2.4151e-4,
      kappa_const=2.89e-10,
      cp_const=Utilities_Hitec.cp_T(reference_T),
      MM_const=0.033,
      T_default=800);

  redeclare function extends dynamicViscosity "Dynamic viscosity"
  algorithm
    eta :=Utilities_Hitec.eta_T(state.T);
    annotation(Inline=true);
  end dynamicViscosity;

  redeclare function extends thermalConductivity
      "Thermal conductivity"
  algorithm
    lambda :=Utilities_Hitec.lambda_T(state.T);
    annotation(Inline=true);
  end thermalConductivity;
  end Hitec;

  package Utilities_Hitec
    import TRANSFORM;
   // ORNL/TM-2006/12
    extends TRANSFORM.Icons.UtilitiesPackage;
    function d_T
      input SI.Temperature T;
      output SI.Density d;
    algorithm
      d:=-0.733*(T)+2280.2;
    end d_T;

    function eta_T
      input SI.Temperature T;
      output SI.DynamicViscosity eta;
    protected
      Real b;
    algorithm
      b := 5.9*(T-9.638)/990.362;
      eta:=(exp(b)+exp(-b))/(exp(b)-exp(-b))-0.999;
    end eta_T;

    function lambda_T
      input SI.Temperature T;
      output SI.ThermalConductivity lambda;
    algorithm
      lambda:=0.78-0.00125*T+1.6*(10^(-6))*T*T;
    end lambda_T;

    function cp_T
      input SI.Temperature T;
      output SI.SpecificHeatCapacity cp;
    algorithm
      cp:=1833.15-T;
    end cp_T;
  end Utilities_Hitec;
end Hitec;
