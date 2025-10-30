within NHES.Systems.EnergyStorage.PCM_HITB.BaseClasses;
partial model Partial_SubSystem_A

  extends Partial_SubSystem(redeclare Data.Data_System data);

  extends Record_SubSystem_A;

  Data.Data_InitialConditions data_Initialization
    annotation (Placement(transformation(extent={{66,122},{86,142}})));
  annotation (
    defaultComponentName="changeMe",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})));
end Partial_SubSystem_A;
