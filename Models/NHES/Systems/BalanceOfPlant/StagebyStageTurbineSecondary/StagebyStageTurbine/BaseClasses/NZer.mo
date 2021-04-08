within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses;
function NZer
  "Function returns a value that will switch between positive 1 and negative 1 without a divide by 0 error when the argument is 0."
  input Real m;
  constant Real k = 0.0001;
  output Real l;
algorithm
  l := m/sqrt(m*m+k);
end NZer;
