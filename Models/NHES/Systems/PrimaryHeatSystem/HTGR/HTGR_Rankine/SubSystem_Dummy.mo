within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine;
model SubSystem_Dummy

  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable CS_Dummy CS,
    redeclare replaceable ED_Dummy ED,
    redeclare Data.Data_Dummy data);

equation

  annotation (
    defaultComponentName="changeMe",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics));
end SubSystem_Dummy;
