within NHES.ExperimentalSystems.TEDS_New.BaseClasses;
partial model Partial_ControlSystem

  extends NHES.Systems.BaseClasses.Partial_ControlSystem;

  SignalSubBus_ActuatorInput actuatorBus
    annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
        iconTransformation(extent={{10,-120},{50,-80}})));
  SignalSubBus_SensorOutput sensorBus
    annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
        iconTransformation(extent={{-50,-120},{-10,-80}})));

  replaceable Data.Data_Dummy data
    annotation (Placement(transformation(extent={{-100,84},{-80,104}})), choicesAllMatching = true);
  annotation (
    defaultComponentName="CS",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));

end Partial_ControlSystem;
