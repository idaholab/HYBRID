within NHES.Desalination.MEE.ControlSystems;
model ED_Dummy

  extends Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_EventDriver;

  extends NHES.Icons.DummyIcon;

equation

annotation(defaultComponentName="PHS_CS");
end ED_Dummy;
