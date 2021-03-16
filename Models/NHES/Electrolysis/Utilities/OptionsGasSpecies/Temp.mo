within NHES.Electrolysis.Utilities.OptionsGasSpecies;
type Temp
  "Temporary type with choices for menus (until enumerations are available)"
  extends Integer(min = 1, max = 4);
  annotation(Evaluate = true, choices(
                              choice=Electrolysis.Utilities.OptionsGasSpecies.H2
        "hydrogen",           choice=Electrolysis.Utilities.OptionsGasSpecies.H2O "steam",
                              choice=Electrolysis.Utilities.OptionsGasSpecies.N2
        "nitrogen",           choice=Electrolysis.Utilities.OptionsGasSpecies.O2 "oxygen"));

end Temp;
