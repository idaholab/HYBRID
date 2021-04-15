within NHES.Systems.Templates.SubSystem_Category_Simple.BaseClasses;
model SubSystem_PlaceHolder

  extends Partial_SubSystem;
  extends NHES.Icons.PlaceHolder;

  annotation (defaultComponentName="SES",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SubSystem_PlaceHolder;
