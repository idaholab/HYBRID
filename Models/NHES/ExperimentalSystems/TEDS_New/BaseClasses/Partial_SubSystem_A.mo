within NHES.ExperimentalSystems.TEDS_New.BaseClasses;
partial model Partial_SubSystem_A

  extends Partial_SubSystem;

  extends Record_SubSystem_A;

  Data.Initial_Data_Dummy data_initial
    annotation (Placement(transformation(extent={{72,122},{92,142}})));
  annotation (
    defaultComponentName="changeMe",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})));
end Partial_SubSystem_A;
