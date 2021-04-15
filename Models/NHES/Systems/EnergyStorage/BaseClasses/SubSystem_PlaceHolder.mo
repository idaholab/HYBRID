within NHES.Systems.EnergyStorage.BaseClasses;
model SubSystem_PlaceHolder

  extends BaseClasses.Partial_SubSystem;
  extends NHES.Icons.PlaceHolder;

  annotation (defaultComponentName="ES",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SubSystem_PlaceHolder;
