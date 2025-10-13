within NHES.Systems.PrimaryHeatSystem.MSR.SupportComponents;
function Finder_SIZZZAAA
  input Integer SIZZZAAA "<html>Isotope identification number<br>test new line</html>";
  input Integer filter = 0 annotation(choices(choice=0 "Molar mass [kg/mol]", choice=1 "Abundancy [atom%]", choice=2 "Decay constant [1/s]",choice=2 "Half-life [s]"));
  output Real y "Result based on filter selection";
algorithm

end Finder_SIZZZAAA;
