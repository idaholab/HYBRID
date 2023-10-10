within NHES.Systems.ExperimentalSystems_dummy.TEDS;
model ED_Dummy

  extends NHES.Systems.EnergyStorage.Battery.BaseClasses.Partial_EventDriver;

  extends NHES.Icons.DummyIcon;

equation

annotation(defaultComponentName="PHS_CS");
end ED_Dummy;
