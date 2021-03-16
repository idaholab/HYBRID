within NHES.Desalination.Utilities.Options;
type Temp
  "Temporary type with choices for menus (until enumerations are available)"
  extends Integer(min = 0, max = 5);
  annotation(Evaluate = true, choices(choice = Desalination.Utilities.Options.noInit         "No initial equations",                                                                              choice = Desalination.Utilities.Options.userSpecified
        "User-specified initialisation",                                                                                                    choice = Desalination.Utilities.Options.steadyState
        "Steady-state initialisation",                                                                                                    choice = Desalination.Utilities.Options.steadyStateNoP
        "Steady-state initialisation except pressures",                                                                                                    choice = Desalination.Utilities.Options.steadyStateNoT
        "Steady-state initialisation except temperatures",                                                                                                    choice = Desalination.Utilities.Options.steadyStateNoPT
        "Steady-state initialisation except pressures and temperatures"));
end Temp;
