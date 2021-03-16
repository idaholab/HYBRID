within NHES.Systems.BalanceOfPlant.Turbine;
model ED_Dummy

  extends BalanceOfPlant.Turbine.BaseClasses.Partial_EventDriver;

  extends NHES.Icons.DummyIcon;

equation

annotation(defaultComponentName="PHS_CS");
end ED_Dummy;
