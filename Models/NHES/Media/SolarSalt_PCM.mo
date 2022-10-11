within NHES.Media;
package SolarSalt_PCM "Industry standard solar salt package"
extends Modelica.Icons.VariantsPackage;
  package ConstantPropertyLiquidSolarSalt
    "Solar Salt PCM Package"
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
      T_min=473,
      T_max=835,
      T0=298.15,
      MM_const=0.072948,
      fluidConstants=SolarSaltConstants);

    annotation (Documentation(info="<html>

</html>"));
  end ConstantPropertyLiquidSolarSalt;

  package SolarSalt
    "Attempt 01 at a phase change material all packaged as a single liquid package."
    // Energies 2021 14, pp 1195-1209
  // beta_const adjusted till density matched. kappa left alone
  // references are based on 800K
  // assumed specific enthalpy at 273.15 is zero
    extends TRANSFORM.Media.Interfaces.Fluids.PartialLinearFluid(
      mediumName="PCM_Solar_Salt",
      constantJacobian=false,
      reference_p=1e5,
      reference_T=800,
      reference_d=Utilities_SolarSalt.d_T(reference_T),
      reference_h=Utilities_SolarSalt.cp_T(reference_T)*(reference_T - 273.15),
      reference_s=0,
      beta_const=2.4151e-4,
      kappa_const=2.89e-10,
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
  /*
redeclare function extends specificHeatCapacityCp "Heat Capacity"
algorithm 
  cp := Utilities_SolarSalt.cp_T(state.T);
  annotation(Inline=true);
end specificHeatCapacityCp;

redeclare function extends density "Density"
algorithm 
  d := Utilities_SolarSalt.d_T(state.T);
  annotation(Inline=true);
end density;*/
  end SolarSalt;

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
      parameter Modelica.Units.SI.Temperature T_melt = 340+273.15;
      parameter Modelica.Units.SI.Temperature T_meltmin = T_melt - 10;
      parameter Modelica.Units.SI.Temperature T_meltplus = T_melt + 10;
      parameter Real m1(unit = "J/(kg.K.K)") = 0.172;
      parameter Real b1(unit = "J/(kg.K)") = 1443.0;
      parameter Real m3(unit = "J/(kg.K.K)") = 0.183;
      parameter Real b3(unit = "J/(kg.K)") = 1504.1;
      parameter Real h_melt(unit = "J/kg") = 100000;
    protected
      Real a(unit = "J/(kg.K.K.K.K.K)");
      Real b(unit = "J/(kg.K.K.K.K)");
      Real c(unit = "J/(kg.K.K.K)");
      Real d(unit = "J/(kg.K.K)");
      Real e(unit = "J/(kg.K)");
      parameter Real A_mat[5,5] = {{T_meltmin^4,T_meltmin^3,T_meltmin^2, T_meltmin,1},
                              {T_meltplus^4, T_meltplus^3, T_meltplus^2, T_meltplus,1},
                              {4*T_meltmin^3,3*T_meltmin^2,2*T_meltmin,1,0},
                              {4*T_meltplus^3,3*T_meltplus^2,2*T_meltplus,1,0},
                              {(T_meltplus^5-T_meltmin^5)/5,(T_meltplus^4-T_meltmin^4)/4,(T_meltplus^3-T_meltmin^3)/3,(T_meltplus^2-T_meltmin^2)/2,T_meltplus-T_meltmin}};
      parameter Real b_mat[5] = {m1*T_meltmin+b1,m3*T_meltplus+b3, m1, m3, m1*(T_melt*T_melt-T_meltmin*T_meltmin)/2+b1*(T_melt-T_meltmin)+m3*(T_meltplus*T_meltplus-T_melt*T_melt)/2+b3*(T_melt-T_meltplus)+h_melt};
      Real x_mat[5];

      Modelica.Units.SI.Temperature dTmelt = T_meltplus-T_meltmin;

    algorithm
      x_mat := Modelica.Math.Matrices.solve(A_mat,b_mat);
      a := x_mat[1];
      b := x_mat[2];
      c := x_mat[3];
      d := x_mat[4];
      e := x_mat[5];
      if T<T_meltmin then
        cp := m1*T+b1;
      elseif T>T_meltplus then
        cp := m3*T+b3;
      else
        cp := a*T^4+b*T^3+c*T^2+d*T+e;
      end if;



      //
      //cp:=1443+0.172*T;
      //




    end cp_T;
  end Utilities_SolarSalt;
end SolarSalt_PCM;
