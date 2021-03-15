within NHES.Systems.ElectricalGrid.InfiniteGrid;
model CS_Dummy
  extends
    NHES.Systems.ElectricalGrid.InfiniteGrid.BaseClasses.Partial_ControlSystem;
  extends Icons.DummyIcon;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_Dummy;
