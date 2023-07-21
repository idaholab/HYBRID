within NHES.Desalination.MEE.BaseClasses;
expandable connector SignalSubBus_SensorOutput3

  extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;
  SI.Temperature T1set;
  SI.Temperature T2set;
  SI.Temperature T3set;

  SI.Temperature T1;
  SI.Temperature T2;
  SI.Temperature T3;

  annotation (defaultComponentName="sensorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_SensorOutput3;
