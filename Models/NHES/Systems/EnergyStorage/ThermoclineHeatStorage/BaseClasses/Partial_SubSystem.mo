within NHES.Systems.EnergyStorage.ThermoclineHeatStorage.BaseClasses;
partial model Partial_SubSystem

  replaceable Record_Data data
    annotation (Placement(transformation(extent={{42,122},{58,138}})));

  extends Record_SubSystem;

  annotation (
    defaultComponentName="ES",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,140}})));
end Partial_SubSystem;
