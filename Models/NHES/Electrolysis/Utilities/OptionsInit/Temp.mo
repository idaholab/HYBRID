within NHES.Electrolysis.Utilities.OptionsInit;
type Temp
  "Temporary type with choices for menus (until enumerations are available)"
  extends Integer(min = 0, max = 5);
  annotation(Evaluate = true, choices(choice = Electrolysis.Utilities.OptionsInit.noInit
        "No initial equations",                                                                              choice = Electrolysis.Utilities.OptionsInit.userSpecified
        "User-specified initialisation",                                                                                                    choice = Electrolysis.Utilities.OptionsInit.steadyState
        "Steady-state initialisation",                                                                                                    choice = Electrolysis.Utilities.OptionsInit.steadyStateNoP
        "Steady-state initialisation except pressures",                                                                                                    choice = Electrolysis.Utilities.OptionsInit.steadyStateNoT
        "Steady-state initialisation except temperatures",                                                                                                    choice = Electrolysis.Utilities.OptionsInit.steadyStateNoPT
        "Steady-state initialisation except pressures and temperatures"));
end Temp;
