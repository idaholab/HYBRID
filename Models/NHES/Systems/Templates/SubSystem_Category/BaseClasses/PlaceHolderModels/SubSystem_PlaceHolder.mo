within NHES.Systems.Templates.SubSystem_Category.BaseClasses.PlaceHolderModels;
model SubSystem_PlaceHolder

  extends BaseClasses.Partial_SubSystem(redeclare
      CS_PlaceHolder CS, redeclare ED_PlaceHolder ED);
  extends NHES.Icons.PlaceHolder;

  annotation (defaultComponentName="SES",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SubSystem_PlaceHolder;
