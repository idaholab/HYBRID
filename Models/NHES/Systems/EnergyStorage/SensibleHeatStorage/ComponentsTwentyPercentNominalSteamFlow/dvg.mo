within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
function dvg
  "Builds derivative with respect to time to make the system work faster"
  input Real P;
  input Real dP;
  output Real dvg;
algorithm
dvg:=0*dP;
end dvg;
