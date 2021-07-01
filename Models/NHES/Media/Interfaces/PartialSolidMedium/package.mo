within NHES.Media.Interfaces;
partial package PartialSolidMedium "Partial solid medium properties based on temperature"
  extends Modelica.Media.Interfaces.Types;

  extends Modelica.Icons.MaterialPropertiesPackage;

  // Constants to be set in Medium
  constant Modelica.Media.Interfaces.Choices.IndependentVariables
    ThermoStates "Enumeration type for independent variables";
  constant String mediumName="unusablePartialMedium" "Name of the medium";
  constant String substanceName=mediumName
    "Names of the mixture substances. Set substanceNames={mediumName} if only one substance.";
  constant Boolean singleState
    "= true, if u and d are not a function of pressure";
  constant Temperature reference_T=298.15
    "Reference temperature of Medium: default 25 deg Celsius";
  constant Temperature T_default=Modelica.Units.Conversions.from_degC(20)
    "Default value for temperature of medium (for initialization)";
  constant SpecificEnthalpy h_default=specificEnthalpy_T(T_default)
    "Default value for specific enthalpy of medium (for initialization)";

  replaceable record ThermodynamicState
    "Minimal variable set that is available as input argument to every medium function"
    extends Modelica.Icons.Record;
  end ThermodynamicState;

  replaceable partial model BaseProperties
    "Base properties (d, T, h, R, and MM) of a medium"
    InputTemperature T "Temperature of medium";
    SpecificEnthalpy h "Specific enthalpy of medium";
    Density d "Density of medium";
    SpecificHeatCapacity R "Gas constant";
    MolarMass MM "Molar mass";
    ThermodynamicState state
      "Thermodynamic state record for optional functions";
    parameter Boolean preferredMediumStates=false
      "= true if StateSelect.prefer shall be used for the independent property variables of the medium"
      annotation (Evaluate=true, Dialog(tab="Advanced"));
    parameter Boolean standardOrderComponents=true
      "If true, and reducedX = true, the last element of X will be computed from the other ones";
    Modelica.Units.NonSI.Temperature_degC T_degC=
        Modelica.Units.Conversions.to_degC(T)
      "Temperature of medium in [degC]";
    // Local connector definition, used for equation balancing check
    connector InputTemperature = input Modelica.Units.SI.Temperature
      "Temperature as input signal connector";

  equation

  end BaseProperties;

  replaceable partial function setState_T
    "Return thermodynamic state as function of T"
    extends Modelica.Icons.Function;
    input Temperature T "Temperature";
    output ThermodynamicState state "Thermodynamic state record";
  end setState_T;

  replaceable partial function setState_h
   "Return thermodynamic state as function of p, h and composition X or Xi"
   extends Modelica.Icons.Function;
   input SpecificEnthalpy h "Specific enthalpy";
   output ThermodynamicState state "Thermodynamic state record";
  end setState_h;

  // replaceable partial function setState_s
  //   "Return thermodynamic state as function of p, s and composition X or Xi"
  //   extends Modelica.Icons.Function;
  //   input SpecificEntropy s "Specific entropy";
  //   output ThermodynamicState state "Thermodynamic state record";
  // end setState_s;

  replaceable partial function setSmoothState
    "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
    extends Modelica.Icons.Function;
    input Real x "m_flow or dp";
    input ThermodynamicState state_a "Thermodynamic state if x > 0";
    input ThermodynamicState state_b "Thermodynamic state if x < 0";
    input Real x_small(min=0)
      "Smooth transition in the region -x_small < x < x_small";
    output ThermodynamicState state
      "Smooth thermodynamic state for all x (continuous and differentiable)";
  end setSmoothState;

  replaceable partial function thermalConductivity
    "Return thermal conductivity"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output ThermalConductivity lambda "Thermal conductivity";
  end thermalConductivity;

  replaceable partial function temperature "Return temperature"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output Temperature T "Temperature";
  end temperature;

  replaceable partial function density "Return density"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output Density d "Density";
  end density;

  replaceable partial function specificEnthalpy
    "Return specific enthalpy"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output SpecificEnthalpy h "Specific enthalpy";
  end specificEnthalpy;
  // replaceable partial function specificInternalEnergy
  //   "Return specific internal energy"
  //   extends Modelica.Icons.Function;
  //   input ThermodynamicState state "Thermodynamic state record";
  //   output SpecificEnergy u "Specific internal energy";
  // end specificInternalEnergy;

  replaceable partial function specificEntropy
    "Return specific entropy"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output SpecificEntropy s "Specific entropy";
  end specificEntropy;

  replaceable partial function specificGibbsEnergy
    "Return specific Gibbs energy"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output SpecificEnergy g "Specific Gibbs energy";
  end specificGibbsEnergy;

  replaceable partial function specificHeatCapacityCp
    "Return specific heat capacity at constant pressure"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output SpecificHeatCapacity cp
      "Specific heat capacity at constant pressure";
  end specificHeatCapacityCp;

  replaceable partial function specificHeatCapacityCv
    "Return specific heat capacity at constant volume"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output SpecificHeatCapacity cv
      "Specific heat capacity at constant volume";
  end specificHeatCapacityCv;
  //   // explicit derivative functions for finite element models
  //   replaceable partial function density_derh_p
  //     "Return density derivative w.r.t. specific enthalpy at constant pressure"
  //     extends Modelica.Icons.Function;
  //     input ThermodynamicState state "Thermodynamic state record";
  //     output DerDensityByEnthalpy ddhp
  //       "Density derivative w.r.t. specific enthalpy";
  //   end density_derh_p;
  //
  //   replaceable partial function density_derT_p
  //     "Return density derivative w.r.t. temperature at constant pressure"
  //     extends Modelica.Icons.Function;
  //     input ThermodynamicState state "Thermodynamic state record";
  //     output DerDensityByTemperature ddTp
  //       "Density derivative w.r.t. temperature";
  //   end density_derT_p;

  replaceable partial function molarMass
    "Return the molar mass of the medium"
    extends Modelica.Icons.Function;
    input ThermodynamicState state "Thermodynamic state record";
    output MolarMass MM "Mixture molar mass";
  end molarMass;

  replaceable function specificEnthalpy_T
    "Return specific enthalpy from T"
    extends Modelica.Icons.Function;
    input Temperature T "Temperature";
    output SpecificEnthalpy h "Specific enthalpy";
  algorithm
    h := specificEnthalpy(setState_T(T));
  end specificEnthalpy_T;

  replaceable function specificEntropy_T
    "Return specific enthalpy from p, T, and X or Xi"
    extends Modelica.Icons.Function;
    input Temperature T "Temperature";
    output SpecificEntropy s "Specific entropy";
  algorithm
    s := specificEntropy(setState_T(T));
  end specificEntropy_T;

  replaceable partial function specificEnthalpyOfFormation_298_15
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    output SpecificEnthalpy h_f;
  end specificEnthalpyOfFormation_298_15;
  //   replaceable function temperature_h
  //     "Return temperature from p, h, and X or Xi"
  //     extends Modelica.Icons.Function;
  //     input SpecificEnthalpy h "Specific enthalpy";
  //     output Temperature T "Temperature";
  //   algorithm
  //     T := temperature(setState_h(h));
  //   end temperature_h;
  //
  //   replaceable function temperature_s
  //     "Return temperature from s"
  //     extends Modelica.Icons.Function;
  //     input SpecificEntropy s "Specific entropy";
  //     output Temperature T "Temperature";
  //   algorithm
  //     T := temperature(setState_s(s));
  //     annotation (inverse(s=specificEntropy_T(T)));
  //   end temperature_s;

  // replaceable function specificEnthalpy_s
  //   "Return specific enthalpy from p, s, and X or Xi"
  //   extends Modelica.Icons.Function;
  //   input SpecificEntropy s "Specific entropy";
  //   output SpecificEnthalpy h "Specific enthalpy";
  // algorithm
  //   h := specificEnthalpy(setState_s(s));
  // end specificEnthalpy_s;

end PartialSolidMedium;
