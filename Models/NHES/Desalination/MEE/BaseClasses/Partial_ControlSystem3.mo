within NHES.Desalination.MEE.BaseClasses;
partial model Partial_ControlSystem3

  extends NHES.Systems.BaseClasses.Partial_ControlSystem;

  SignalSubBus_ActuatorInput3 actuatorBus
                                         annotation (Placement(
        transformation(extent={{10,-120},{50,-80}}), iconTransformation(
          extent={{10,-120},{50,-80}})));
  SignalSubBus_SensorOutput3 sensorBus
                                      annotation (Placement(
        transformation(extent={{-50,-120},{-10,-80}}), iconTransformation(
          extent={{-50,-120},{-10,-80}})));

  annotation (
    defaultComponentName="CS",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));

end Partial_ControlSystem3;
