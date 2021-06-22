within NHES.Media.TwoPhaseMixtures.LithiumBromideWater;
partial package LithiumBromideWater_base "Lithium Bromide-Water Mixture properties defined by Zhe Yuan and Keith E. Herold combined with IAPWS/IF97 standard water"
    extends Interfaces.PartialTwoPhaseMixtureMedium(
      mediumName="LithiumBromide - Water",
      substanceNames={"Lithium Bromide","Water"},
      singleState=false,
      SpecificEnthalpy(
        start=1e3,
        nominal=1e3,
        min=-10000,
        max=1e6),
      Density(
        start=1500,
        nominal=1500,
        min=0.001,
        max=2000),
      AbsolutePressure(
        start=10e5,
        nominal=1e5,
        min=1,
        max=100e6),
      Temperature(
        start=300,
        nominal=350,
        min=273.15,
        max=633.15),
      MassFraction(
        start=0.5,
        nominal=0.5,
        min=0,
        max=1),
      reference_X=fill(1/nX, nX),
      X_default=reference_X,
      reducedX=false,
      smoothModel=false,
      onePhase=false,
      fluidConstants={lithiumBromideConstants,waterConstants});

    redeclare record extends ThermodynamicState
      "Thermodynamic state"
      SpecificEnthalpy h "Specific enthalpy";
      Density d "Density";
      Temperature T "Temperature";
      AbsolutePressure p "Pressure";
      MassFraction[nX] X(start=reference_X) "Mass Fraction";
    end ThermodynamicState;
    constant MolarMass[nX] MMX={fluidConstants[1].molarMass,fluidConstants[2].molarMass};
    constant Integer Region=0
      "Region of solution or water if known, zero otherwise";
    constant Boolean phX_explicit
      "True if explicit in pressure, specific enthalpy, and mass fraction";
    constant Boolean dTX_explicit
      "True if explicit in density, temperature, and mass fraction";
    constant Boolean pTX_explicit
      "True if explicit in pressure, temperature, and mass fraction";

    redeclare replaceable model extends BaseProperties(
      h(stateSelect=if phX_explicit and preferredMediumStates then
            StateSelect.prefer else StateSelect.default),
      d(stateSelect=if dTX_explicit and preferredMediumStates then
            StateSelect.prefer else StateSelect.default),
      T(stateSelect=if (pTX_explicit or dTX_explicit) and
            preferredMediumStates then StateSelect.prefer else StateSelect.default),
      p(stateSelect=if (pTX_explicit or phX_explicit) and
            preferredMediumStates then StateSelect.prefer else StateSelect.default),
      Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer
             else StateSelect.default)) "Base properties of water"

      Integer phase(
        min=0,
        max=2,
        start=1,
        fixed=false) "2 for two-phase, 1 for one-phase, 0 if not known";
    equation
      MM = 1/sum(X ./ MMX);
      if Region > 0 then
        // Fixed region
        phase = (if Region == 4 then 2 else 1);
      elseif smoothModel then
        if onePhase then
          phase = 1;
          if phX_explicit then
            assert(((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
              fluidConstants[1].criticalPressure or X[1] > 0), "With onePhase=true this model may only be called with one-phase states h < hl or h > hv!"
               + "(p = " + String(p) + ", h = " + String(h) + ")");
          else
            if dTX_explicit then
              assert(not ((d < bubbleDensity(sat) and d > dewDensity(sat))
                 and T < fluidConstants[1].criticalTemperature or X[1] > 0), "With onePhase=true this model may only be called with one-phase states d > dl or d < dv!"
                 + "(d = " + String(d) + ", T = " + String(T) + ")");
            end if;
          end if;
        else
          phase = 0;
        end if;
      else
        if phX_explicit then
          phase = if ((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
            fluidConstants[1].criticalPressure or X[1] > 0) then 1 else 2;
        elseif dTX_explicit then
          phase = if not ((d < bubbleDensity(sat) and d > dewDensity(sat))
             and T < fluidConstants[1].criticalTemperature or X[1] > 0) then 1
             else 2;
        else
          phase = 1;
          //this is for the one-phase only case pT
        end if;
      end if;
      if dTX_explicit then
        //assume LiBr-H2O is saturated
        p = pressure_dTX(
                d,
                T,
                X,
                phase,
                Region);
        h = specificEnthalpy_dTX(
                d,
                T,
                X,
                phase,
                Region);
        sat.Tsat = T;
        sat.psat = saturationPressure(T, X);
        sat.Xsat = saturationMassFraction(p, T);
      elseif phX_explicit then
        d = density_phX(
                p,
                h,
                X,
                phase,
                Region);
        T = temperature_phX(
                p,
                h,
                X,
                phase,
                Region);
        sat.Tsat = saturationTemperature(p, X);
        sat.psat = p;
        // Why not use psat function here?
        sat.Xsat = saturationMassFraction(p, T);
      else
        h = specificEnthalpy_pTX(
                p,
                T,
                X,
                Region);
        d = density_pTX(
                p,
                T,
                X,
                Region);
        sat.psat = p;
        // Why not use psat function here?
        sat.Tsat = saturationTemperature(p, X);
        sat.Xsat = saturationMassFraction(p, T);
      end if;
      u = h - p/d;
      R_s = gasConstant(state);
      h = state.h;
      p = state.p;
      T = state.T;
      d = state.d;
      phase = state.phase;
      X = state.X;
    end BaseProperties;

     redeclare function extends gasConstant
     algorithm
       R_s :=(Modelica.Constants.R/MMX[1])*state.X[1] +
           (Modelica.Constants.R/MMX[2])*state.X[2];
     end gasConstant;

    redeclare function density_phX
      "Computes density as a function of pressure, specific enthalpy, and mass fraction"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] "Mass fractions of mixture";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
      output Density d "Density";
    algorithm
      // d :=1600;
      d := LiBrW_Utilities.rho_phX(
              p,
              h,
              X,
              phase,
              region);
      annotation (Inline=true);
    end density_phX;

    redeclare function temperature_phX
      "Computes temperature as a function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "Specific enthalpy";
      input MassFraction X[:] "Mass fractions of mixture";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
      output Temperature T "Temperature";
    algorithm
      T := LiBrW_Utilities.T_phX(
              p,
              h,
              X,
              phase,
              region);
      annotation (Inline=true);
    end temperature_phX;

    redeclare function temperature_psX
      "Compute temperature from pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions of mixture";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
      output Temperature T "Temperature";
    algorithm
      T := LiBrW_Utilities.T_psX(
              p,
              s,
              X,
              phase,
              region);
      annotation (Inline=true);
    end temperature_psX;

    redeclare function density_psX
      "Computes density as a function of pressure and specific enthalpy"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions of mixture";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
      output Density d "Density";
    algorithm
      d := LiBrW_Utilities.rho_psX(
              p,
              s,
              X,
              phase,
              region);
      annotation (Inline=true);
    end density_psX;

    redeclare function pressure_dTX
      "Computes pressure as a function of density and temperature"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions of mixture";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
      output AbsolutePressure p "Pressure";
    algorithm
      p := LiBrW_Utilities.p_dTX(
              d,
              T,
              X,
              phase,
              region);
      annotation (Inline=true);
    end pressure_dTX;

    redeclare function specificEnthalpy_dTX
      "Computes specific enthalpy as a function of density and temperature"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions of mixture";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := LiBrW_Utilities.h_dTX(
              d,
              T,
              X,
              phase,
              region);
      annotation (Inline=true);
    end specificEnthalpy_dTX;

    redeclare function specificEnthalpy_pTX
      "Computes specific enthalpy as a function of pressure and temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions of mixture";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := LiBrW_Utilities.h_pTX(
              p,
              T,
              X,
              region);
      annotation (Inline=true);
    end specificEnthalpy_pTX;

    redeclare function specificEnthalpy_psX
      "Computes specific enthalpy as a function of pressure and temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEntropy s "Specific entropy";
      input MassFraction X[:] "Mass fractions of mixture";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
      output SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := LiBrW_Utilities.h_psX(
              p,
              s,
              X,
              phase,
              region);
      annotation (Inline=true);
    end specificEnthalpy_psX;

    redeclare function density_pTX
      "Computes density as a function of pressure and temperature"
      extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input Temperature T "Temperature";
      input MassFraction X[:] "Mass fractions of mixture";
      input FixedPhase phase=0
        "2 for two-phase, 1 for one-phase, 0 if not known";
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
      output Density d "Density";
    algorithm
      d := LiBrW_Utilities.rho_pTX(
              p,
              T,
              X,
              region);
      annotation (Inline=true);
    end density_pTX;

    redeclare function extends setDewState
      "Set the thermodynamic state on the dew line"
    algorithm
      state := ThermodynamicState(
              phase=phase,
              p=sat.psat,
              T=sat.Tsat,
              X=sat.Xsat,
              h=dewEnthalpy(sat),
              d=dewDensity(sat));
      annotation (Inline=true);
    end setDewState;

    redeclare function extends setBubbleState
      "Set the thermodynamic state on the bubble line"
    algorithm
      state := ThermodynamicState(
              phase=phase,
              p=sat.psat,
              T=sat.Tsat,
              X=sat.Xsat,
              h=bubbleEnthalpy(sat),
              d=bubbleDensity(sat));
      annotation (Inline=true);
    end setBubbleState;

    redeclare function extends dynamicViscosity
      "Dynamic viscosity of water"
    algorithm
      eta := LiBrW_Utilities.dynamicViscosity(
              state.d,
              state.T,
              state.p,
              state.X,
              state.phase);
      annotation (Inline=true);
    end dynamicViscosity;

    redeclare function extends thermalConductivity
      "Thermal conductivity of water"
    algorithm
      lambda := LiBrW_Utilities.thermalConductivity(
              state.d,
              state.T,
              state.p,
              state.X,
              state.phase);
      annotation (Inline=true);
    end thermalConductivity;

    redeclare function extends surfaceTension
      "Surface tension in two phase region of water"
    algorithm
      sigma := LiBrW_Utilities.surfaceTension(sat.Tsat);
      annotation (Inline=true);
    end surfaceTension;

    redeclare function extends pressure
      "Return pressure of ideal gas"
    algorithm
      p := state.p;
      //  annotation (Inline=true);
    end pressure;

    redeclare function extends temperature
      "Return temperature of ideal gas"
    algorithm
      T := state.T;
      annotation (Inline=true);
    end temperature;

    redeclare function extends massfraction
    algorithm
      X := state.X;
      annotation (Inline=true);
    end massfraction;

    redeclare function extends density
      "Return density of ideal gas"
    algorithm
      d := max(state.d, 1e-6);
      annotation (Inline=true);
    end density;

    redeclare function extends specificEnthalpy
      "Return specific enthalpy"
    algorithm
      h := state.h;
      annotation (Inline=true);
    end specificEnthalpy;

    redeclare function extends specificInternalEnergy
    algorithm
      u := state.h - state.p/state.d;
      annotation (Inline=true);
    end specificInternalEnergy;

    redeclare function extends specificGibbsEnergy
      "Return specific Gibbs energy"
    algorithm
      g := state.h - state.T*specificEntropy(state);
      annotation (Inline=true);
    end specificGibbsEnergy;

    redeclare function extends specificHelmholtzEnergy
      "Return specific Helmholtz energy"
    algorithm
      f := state.h - state.p/state.d - state.T*specificEntropy(state);
      annotation (Inline=true);
    end specificHelmholtzEnergy;

    redeclare function extends specificEntropy
      "Specific entropy of water"
    algorithm
      s := if dTX_explicit then LiBrW_Utilities.s_dTX(
              state.d,
              state.T,
              state.X,
              state.phase,
              Region) else if pTX_explicit then LiBrW_Utilities.s_pTX(
              state.p,
              state.T,
              state.X,
              Region) else LiBrW_Utilities.s_phX(
              state.p,
              state.h,
              state.X,
              state.phase,
              Region);
      annotation (Inline=true);
    end specificEntropy;

    redeclare function extends specificHeatCapacityCp
      "Specific heat capacity at constant pressure of water"
    algorithm
      cp := if dTX_explicit then LiBrW_Utilities.cp_dTX(
              state.d,
              state.T,
              state.X,
              Region) else if pTX_explicit then LiBrW_Utilities.cp_pTX(
              state.p,
              state.T,
              state.X,
              Region) else LiBrW_Utilities.cp_phX(
              state.p,
              state.h,
              state.X,
              Region);
      annotation (Inline=true);
    end specificHeatCapacityCp;

    redeclare function extends specificHeatCapacityCv
      "Specific heat capacity at constant volume of water"
    algorithm
      cv := if dTX_explicit then LiBrW_Utilities.cv_dTX(
              state.d,
              state.T,
              state.X,
              state.phase,
              Region) else if pTX_explicit then LiBrW_Utilities.cv_pTX(
              state.p,
              state.T,
              state.X,
              Region) else LiBrW_Utilities.cv_phX(
              state.p,
              state.h,
              state.X,
              state.phase,
              Region);
      annotation (Inline=true);
    end specificHeatCapacityCv;

    redeclare function extends isentropicExponent
      "Return isentropic exponent"
    algorithm
      gamma := if dTX_explicit then LiBrW_Utilities.isentropicExponent_dTX(
              state.d,
              state.T,
              state.X,
              state.phase,
              Region) else if pTX_explicit then
        LiBrW_Utilities.isentropicExponent_pTX(
              state.p,
              state.T,
              state.X,
              Region) else LiBrW_Utilities.isentropicExponent_phX(
              state.p,
              state.h,
              state.X,
              state.phase,
              Region);
      annotation (Inline=true);
    end isentropicExponent;

    redeclare function extends isothermalCompressibility
      "Isothermal compressibility of water"
    algorithm
      //    assert(state.phase <> 2, "Isothermal compressibility can not be computed with 2-phase inputs!");
      kappa := if dTX_explicit then LiBrW_Utilities.kappa_dTX(
              state.d,
              state.T,
              state.X,
              state.phase,
              Region) else if pTX_explicit then LiBrW_Utilities.kappa_pTX(
              state.p,
              state.T,
              state.X,
              Region) else LiBrW_Utilities.kappa_phX(
              state.p,
              state.h,
              state.X,
              state.phase,
              Region);
      annotation (Inline=true);
    end isothermalCompressibility;

    redeclare function extends isobaricExpansionCoefficient
      "Isobaric expansion coefficient of water"
    algorithm
      //    assert(state.phase <> 2, "The isobaric expansion coefficient can not be computed with 2-phase inputs!");
      beta := if dTX_explicit then LiBrW_Utilities.beta_dTX(
              state.d,
              state.T,
              state.X,
              state.phase,
              Region) else if pTX_explicit then LiBrW_Utilities.beta_pTX(
              state.p,
              state.T,
              state.X,
              Region) else LiBrW_Utilities.beta_phX(
              state.p,
              state.h,
              state.X,
              state.phase,
              Region);
      annotation (Inline=true);
    end isobaricExpansionCoefficient;

    redeclare function extends velocityOfSound
      "Return velocity of sound as a function of the thermodynamic state record"
    algorithm
      a := if dTX_explicit then LiBrW_Utilities.velocityOfSound_dTX(
              state.d,
              state.T,
              state.X,
              state.phase,
              Region) else if pTX_explicit then
        LiBrW_Utilities.velocityOfSound_pTX(
              state.p,
              state.T,
              state.X,
              Region) else LiBrW_Utilities.velocityOfSound_phX(
              state.p,
              state.h,
              state.X,
              state.phase,
              Region);
      annotation (Inline=true);
    end velocityOfSound;

    redeclare function extends isentropicEnthalpy
      "Compute h(s,p,X)"
      input MassFraction X[:];
    algorithm
      h_is := LiBrW_Utilities.isentropicEnthalpy(
              p_downstream,
              specificEntropy(refState),
              X);
      annotation (Inline=true);
    end isentropicEnthalpy;

    redeclare function extends density_derh_p
      "Density derivative by specific enthalpy"
    algorithm
      ddhp := LiBrW_Utilities.ddhpX(
              state.p,
              state.h,
              state.X,
              state.phase,
              Region);
      annotation (Inline=true);
    end density_derh_p;

    redeclare function extends density_derp_h
      "Density derivative by pressure"
    algorithm
      ddph := LiBrW_Utilities.ddphX(
              state.p,
              state.h,
              state.X,
              state.phase,
              Region);
      annotation (Inline=true);
    end density_derp_h;
    //   redeclare function extends density_derT_p
    //     "Density derivative by temperature"
    //   algorithm
    //     ddTp := IF97_Utilities.ddTp(state.p, state.h, state.phase);
    //   end density_derT_p;
    //
    //   redeclare function extends density_derp_T
    //     "Density derivative by pressure"
    //   algorithm
    //     ddpT := IF97_Utilities.ddpT(state.p, state.h, state.phase);
    //   end density_derp_T;

    redeclare function extends bubbleEnthalpy
      "Boiling curve specific enthalpy of water"
    algorithm
      hl := LiBrW_Utilities.BaseLiBrW.Regions.hl_p(sat.psat);
      annotation (Inline=true);
    end bubbleEnthalpy;

    redeclare function extends dewEnthalpy
      "Dew curve specific enthalpy of water"
    algorithm
      hv := LiBrW_Utilities.BaseLiBrW.Regions.hv_p(sat.psat);
      annotation (Inline=true);
    end dewEnthalpy;

    redeclare function extends bubbleEntropy
      "Boiling curve specific entropy of water"
    algorithm
      sl := LiBrW_Utilities.BaseLiBrW.Regions.sl_p(sat.psat);
      annotation (Inline=true);
    end bubbleEntropy;

    redeclare function extends dewEntropy
      "Dew curve specific entropy of water"
    algorithm
      sv := LiBrW_Utilities.BaseLiBrW.Regions.sv_p(sat.psat);
      annotation (Inline=true);
    end dewEntropy;

    redeclare function extends bubbleDensity
      "Boiling curve specific density of water"
    algorithm
      dl := if phX_explicit or pTX_explicit then
        LiBrW_Utilities.BaseLiBrW.Regions.rhol_p(sat.psat) else
        LiBrW_Utilities.BaseLiBrW.Regions.rhol_T(sat.Tsat);
      annotation (Inline=true);
    end bubbleDensity;

    redeclare function extends dewDensity
      "Dew curve specific density of water"
    algorithm
      dv := if phX_explicit or pTX_explicit then
        LiBrW_Utilities.BaseLiBrW.Regions.rhov_p(sat.psat) else
        LiBrW_Utilities.BaseLiBrW.Regions.rhov_T(sat.Tsat);
      annotation (Inline=true);
    end dewDensity;

    redeclare function extends saturationTemperature
      "Saturation temperature of water"
    algorithm
      T := LiBrW_Utilities.BaseLiBrW.Basic.tsat(p, X);
      annotation (Inline=true);
    end saturationTemperature;

    redeclare function extends saturationTemperature_derp
      "Derivative of saturation temperature w.r.t. pressure"
      input MassFraction X[:];
    algorithm
      dTp := LiBrW_Utilities.BaseLiBrW.Basic.dtsatofp(p, X);
      annotation (Inline=true);
    end saturationTemperature_derp;

    redeclare function extends saturationPressure
      "Saturation pressure of water or solution"
    algorithm
      p := LiBrW_Utilities.BaseLiBrW.Basic.psat(T, X);
      annotation (Inline=true);
    end saturationPressure;

    redeclare function extends saturationMassFraction
    algorithm
      X := LiBrW_Utilities.BaseLiBrW.Basic.Xsat(p, T)
        annotation (Inline=true);
    end saturationMassFraction;

    redeclare function extends dBubbleDensity_dPressure
      "Bubble point density derivative"
    algorithm
      ddldp := LiBrW_Utilities.BaseLiBrW.Regions.drhol_dp(sat.psat);
      annotation (Inline=true);
    end dBubbleDensity_dPressure;

    redeclare function extends dDewDensity_dPressure
      "Dew point density derivative"
    algorithm
      ddvdp := LiBrW_Utilities.BaseLiBrW.Regions.drhov_dp(sat.psat);
      annotation (Inline=true);
    end dDewDensity_dPressure;

    redeclare function extends dBubbleEnthalpy_dPressure
      "Bubble point specific enthalpy derivative"
    algorithm
      dhldp := LiBrW_Utilities.BaseLiBrW.Regions.dhl_dp(sat.psat);
      annotation (Inline=true);
    end dBubbleEnthalpy_dPressure;

    redeclare function extends dDewEnthalpy_dPressure
      "Dew point specific enthalpy derivative"
    algorithm
      dhvdp := LiBrW_Utilities.BaseLiBrW.Regions.dhv_dp(sat.psat);
      annotation (Inline=true);
    end dDewEnthalpy_dPressure;

    redeclare function extends setState_dTX
      "Return thermodynamic state of water as function of d, T, and optional region"
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
    algorithm
      state := ThermodynamicState(
              d=d,
              T=T,
              X=X,
              phase=if region == 0 then 0 else if region == 4 then 2 else 1,
              h=specificEnthalpy_dTX(
                d,
                T,
                X,
                region=region),
              p=pressure_dTX(
                d,
                T,
                X,
                region=region));
      annotation (Inline=true);
    end setState_dTX;

    redeclare function extends setState_phX
      "Return thermodynamic state of water as function of p, h, and optional region"
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
    algorithm
      state := ThermodynamicState(
              d=density_phX(
                p,
                h,
                X,
                region=region),
              T=temperature_phX(
                p,
                h,
                X,
                region=region),
              phase=if region == 0 then 0 else if region == 4 then 2 else 1,
              h=h,
              p=p,
              X=X);
      annotation (Inline=true);
    end setState_phX;

    redeclare function extends setState_psX
      "Return thermodynamic state of water as function of p, s, and optional region"
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
    algorithm
      state := ThermodynamicState(
              d=density_psX(
                p,
                s,
                X,
                region=region),
              T=temperature_psX(
                p,
                s,
                X,
                region=region),
              phase=if region == 0 then 0 else if region == 4 then 2 else 1,
              h=specificEnthalpy_psX(
                p,
                s,
                X,
                region=region),
              p=p,
              X=X);
      annotation (Inline=true);
    end setState_psX;

    redeclare function extends setState_pTX
      "Return thermodynamic state of water as function of p, T, and optional region"
      input Integer region=Region
        "If 0, region is unknown, otherwise known and this input";
    algorithm
      state := ThermodynamicState(
              d=density_pTX(
                p,
                T,
                X,
                region=region),
              T=T,
              phase=1,
              h=specificEnthalpy_pTX(
                p,
                T,
                X,
                region=region),
              p=p,
              X=X);
      annotation (Inline=true);
    end setState_pTX;

    redeclare function extends setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
      import Modelica.Media.Common.smoothStep;
    algorithm
      state := ThermodynamicState(
              p=smoothStep(
                x,
                state_a.p,
                state_b.p,
                x_small),
              h=smoothStep(
                x,
                state_a.h,
                state_b.h,
                x_small),
              d=density_phX(
                smoothStep(
                  x,
                  state_a.p,
                  state_b.p,
                  x_small),
                smoothStep(
                  x,
                  state_a.h,
                  state_b.h,
                  x_small),
                smoothStep(
                  x,
                  state_a.X,
                  state_b.X,
                  x_small)),
              T=temperature_phX(
                smoothStep(
                  x,
                  state_a.p,
                  state_b.p,
                  x_small),
                smoothStep(
                  x,
                  state_a.h,
                  state_b.h,
                  x_small),
                smoothStep(
                  x,
                  state_a.X,
                  state_b.X,
                  x_small)),
              X=smoothStep(
                x,
                state_a.X,
                state_b.X,
                x_small),
              phase=0);
      annotation (Inline=true);
    end setSmoothState;
end LithiumBromideWater_base;
