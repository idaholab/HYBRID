within NHES.Desalination.MEE.BaseClasses;
expandable connector SignalSubBus_SensorOutput

  extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;
  Modelica.Units.SI.Temperature T1set;
  Modelica.Units.SI.Temperature T2set;
  Modelica.Units.SI.Temperature T3set;
  Modelica.Units.SI.Temperature T4set;
  Modelica.Units.SI.Temperature T5set;
  Modelica.Units.SI.Temperature T6set;
  Modelica.Units.SI.Temperature T7set;
  Modelica.Units.SI.Temperature T8set;

  Modelica.Units.SI.Temperature T1;
  Modelica.Units.SI.Temperature T2;
  Modelica.Units.SI.Temperature T3;
  Modelica.Units.SI.Temperature T4;
  Modelica.Units.SI.Temperature T5;
  Modelica.Units.SI.Temperature T6;
  Modelica.Units.SI.Temperature T7;
  Modelica.Units.SI.Temperature T8;

  Modelica.Units.SI.Pressure p1set;
  Modelica.Units.SI.Pressure p2set;
  Modelica.Units.SI.Pressure p3set;
  Modelica.Units.SI.Pressure p4set;
  Modelica.Units.SI.Pressure p5set;
  Modelica.Units.SI.Pressure p6set;
  Modelica.Units.SI.Pressure p7set;
  Modelica.Units.SI.Pressure p8set;

  Modelica.Units.SI.Pressure p1;
  Modelica.Units.SI.Pressure p2;
  Modelica.Units.SI.Pressure p3;
  Modelica.Units.SI.Pressure p4;
  Modelica.Units.SI.Pressure p5;
  Modelica.Units.SI.Pressure p6;
  Modelica.Units.SI.Pressure p7;
  Modelica.Units.SI.Pressure p8;

  annotation (defaultComponentName="sensorSubBus",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalSubBus_SensorOutput;
