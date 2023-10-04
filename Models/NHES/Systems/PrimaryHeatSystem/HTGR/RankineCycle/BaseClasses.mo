within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle;
package BaseClasses
  extends TRANSFORM.Icons.BasesPackage;

  partial model Partial_SubSystem

    extends NHES.Systems.BaseClasses.Partial_SubSystem;

    extends Record_SubSystem;

    replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
        Placement(transformation(extent={{-8,122},{8,138}})));
    replaceable Record_Data data
      annotation (Placement(transformation(extent={{42,122},{58,138}})));

    SignalSubBus_ActuatorInput actuatorBus
      annotation (Placement(transformation(extent={{10,80},{50,120}}),
          iconTransformation(extent={{10,80},{50,120}})));
    SignalSubBus_SensorOutput sensorBus
      annotation (Placement(transformation(extent={{-50,80},{-10,120}}),
          iconTransformation(extent={{-50,80},{-10,120}})));

  equation
    connect(sensorBus, CS.sensorBus) annotation (Line(
        points={{-30,100},{-2.4,100},{-2.4,122}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus, CS.actuatorBus) annotation (Line(
        points={{30,100},{2.4,100},{2.4,122}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    annotation (
      defaultComponentName="changeMe",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,140}})));
  end Partial_SubSystem;

  partial model Partial_SubSystem_A

    extends Partial_SubSystem;

    extends Record_SubSystem_A;

    annotation (
      defaultComponentName="changeMe",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              140}})));
  end Partial_SubSystem_A;

  partial model Record_Data

    extends Modelica.Icons.Record;

    annotation (defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Record_Data;

  partial record Record_SubSystem

    annotation (defaultComponentName="subsystem",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Record_SubSystem;

  partial record Record_SubSystem_A

    extends Record_SubSystem;

    annotation (defaultComponentName="subsystem",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Record_SubSystem_A;

  partial model Partial_ControlSystem

    extends NHES.Systems.BaseClasses.Partial_ControlSystem;

    SignalSubBus_ActuatorInput actuatorBus
      annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
          iconTransformation(extent={{10,-120},{50,-80}})));
    SignalSubBus_SensorOutput sensorBus
      annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
          iconTransformation(extent={{-50,-120},{-10,-80}})));

    annotation (
      defaultComponentName="CS",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})));

  end Partial_ControlSystem;

  expandable connector SignalSubBus_ActuatorInput

    extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

    annotation (defaultComponentName="actuatorBus",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SignalSubBus_ActuatorInput;

  expandable connector SignalSubBus_SensorOutput

    extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

    annotation (defaultComponentName="sensorBus",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SignalSubBus_SensorOutput;

end BaseClasses;
