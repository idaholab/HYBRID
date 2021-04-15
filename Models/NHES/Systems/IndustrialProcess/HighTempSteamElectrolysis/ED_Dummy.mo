within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis;
model ED_Dummy

  extends
    IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_EventDriver;

  extends NHES.Icons.DummyIcon;

equation

annotation(defaultComponentName="PHS_CS");
end ED_Dummy;
