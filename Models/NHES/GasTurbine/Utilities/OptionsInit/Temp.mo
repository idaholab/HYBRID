within NHES.GasTurbine.Utilities.OptionsInit;
type Temp
  "Temporary type with choices for menus (until enumerations are available)"
  extends Integer(min = 0, max = 5);
  annotation(Evaluate = true, choices(choice = GasTurbine.Utilities.OptionsInit.noInit
        "No initial equations",                                                                              choice = GasTurbine.Utilities.OptionsInit.userSpecified
        "User-specified initialisation",                                                                                                    choice = GasTurbine.Utilities.OptionsInit.steadyState
        "Steady-state initialisation",                                                                                                    choice = GasTurbine.Utilities.OptionsInit.steadyStateNoP
        "Steady-state initialisation except pressures",                                                                                                    choice = GasTurbine.Utilities.OptionsInit.steadyStateNoT
        "Steady-state initialisation except temperatures",                                                                                                    choice = GasTurbine.Utilities.OptionsInit.steadyStateNoPT
        "Steady-state initialisation except pressures and temperatures"));
end Temp;
