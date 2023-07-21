within NHES.Desalination.MEE.BaseClasses.Choices;
type EvaporatorType = enumeration(
    FC                               "Full Condensing",
    UA   "Constant UA",
    HX   "Heat Transfer Correlations") "Enumeration defining Evaporator Types"
                                               annotation (Evaluate=true);
