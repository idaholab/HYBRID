within NHES.Desalination.Types;
type ThermoInitMeth = enumeration(
    None "Do not explicitly initialize.",
    Pressure "Initialize the pressure.",
    Temperature
              "Initialize the temperature.",
    SpecificEnthalpy
                   "Initialize the specific enthalpy.",
    MassFraction
               "Initialize the mass fraction.",
    PressureSS
             "Initialize w/ steady-state pressure.",
    TemperatureSS
                "Initialize w/ steady-state temperature.",
    SpecificEnthalpySS
                     "Initialize w/ steady-state specific enthalpy.",
    MassFractionSS
                 "Initialize w/ steady-state mass fraction.")
    "Methods of initializing the thermodynamic state";
