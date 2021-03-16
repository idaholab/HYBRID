within NHES.Systems.ElectricalGrid.InfiniteGrid;
model ED_Dummy

  extends ElectricalGrid.InfiniteGrid.BaseClasses.Partial_EventDriver;

  extends NHES.Icons.DummyIcon;

equation

annotation(defaultComponentName="PHS_CS");
end ED_Dummy;
