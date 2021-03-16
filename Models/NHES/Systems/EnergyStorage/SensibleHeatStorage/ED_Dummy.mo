within NHES.Systems.EnergyStorage.SensibleHeatStorage;
model ED_Dummy

  extends EnergyStorage.SensibleHeatStorage.BaseClasses.Partial_EventDriver;

  extends NHES.Icons.DummyIcon;

equation

annotation(defaultComponentName="PHS_CS");
end ED_Dummy;
