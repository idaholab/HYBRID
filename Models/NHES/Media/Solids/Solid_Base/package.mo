within NHES.Media.Solids;
partial package Solid_Base
  extends Interfaces.PartialSolidMedium(
  mediumName="none",
  Temperature(min=200, max=1000, start=400, nominal=400),
  SpecificEnthalpy(start=0, min=0));

  redeclare record extends ThermodynamicState
    "Thermodynamic state"
    Temperature T "Temperature";
  end ThermodynamicState;
  constant Common.SingleSpeciesData ssd;

  redeclare replaceable model extends BaseProperties(T)
  equation
        assert(T >= 200 and T <= 6000, "
Temperature T (= " + String(T) + " K) is not in the allowed range
200 K <= T <= 6000 K required from medium model \"" + mediumName + "\".
");
    MM = ssd.MW;
    R = ssd.R_m;
    T = state.T;
    h = Common.NASAGlenn.NASA_Utilities.h_T(T, ssd);
    d = ssd.rho;
  end BaseProperties;

  redeclare function extends molarMass
  algorithm
    MM := ssd.MW;
  end molarMass;

  redeclare function extends specificEnthalpyOfFormation_298_15
  algorithm
    h_f :=ssd.h_f_298_15/ssd.MW;
  end specificEnthalpyOfFormation_298_15;

  redeclare function extends thermalConductivity
  algorithm
    lambda := ssd.k;
  end thermalConductivity;

  redeclare function extends temperature
  algorithm
    T := state.T;
    annotation (Inline=true, smoothOrder=2);
  end temperature;

  redeclare function extends density
  algorithm
    d := ssd.rho;
  end density;

  redeclare function extends specificEnthalpy
  algorithm
    h := Common.NASAGlenn.NASA_Utilities.h_T(state.T, ssd);
    annotation (Inline=true, smoothOrder=2);
  end specificEnthalpy;

  redeclare function extends specificGibbsEnergy
  algorithm
    g := specificEnthalpy(state) - state.T*specificEntropy(state);
    annotation (Inline=true);
  end specificGibbsEnergy;

  redeclare function extends specificEntropy
  algorithm
    s := Common.NASAGlenn.NASA_Utilities.s_T(state.T, ssd);
    annotation (Inline=true);
  end specificEntropy;

  redeclare function extends specificHeatCapacityCp
  algorithm
    cp := Common.NASAGlenn.NASA_Utilities.cp_T(state.T, ssd);
    annotation (Inline=true);
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
  algorithm
    cv := Common.NASAGlenn.NASA_Utilities.cp_T(state.T, ssd);
    annotation (Inline=true);
  end specificHeatCapacityCv;

  redeclare function extends setState_T
  algorithm
    state := ThermodynamicState(T);
    annotation (Inline=true, smoothOrder=2);
  end setState_T;

  redeclare function extends setState_h
  algorithm
    state :=ThermodynamicState(T=Common.NASAGlenn.NASA_Utilities.T_h(h, ssd));
    annotation (Inline=true, smoothOrder=2);
  end setState_h;
end Solid_Base;
