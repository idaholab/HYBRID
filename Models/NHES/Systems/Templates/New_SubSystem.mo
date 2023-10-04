within NHES.Systems.Templates;
package New_SubSystem

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model Test
      extends Modelica.Icons.Example;

      Models.SubSystem_Dummy changeMe
        annotation (Placement(transformation(extent={{-40,-42},{40,38}})));

      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})),
        experiment(
          StopTime=100,
          __Dymola_NumberOfIntervals=100,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput);
    end Test;
    annotation (Documentation(info="<html>
<p>Examples should show the primary functionality of the components, meaning that generally a transient example should be included. </p>
</html>"));
  end Examples;

  package Models
    model SubSystem_Dummy

      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable NHES.Systems.Templates.New_SubSystem.CS.CS_Dummy CS,
        redeclare Data.Data_Dummy data);

    equation

      annotation (
        defaultComponentName="changeMe",
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                140}})),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end SubSystem_Dummy;
    annotation (Documentation(info="<html>
<p>The Models folder should contain the drag-and-drop components that are ready to use when pushed into the primary repository. </p>
</html>"));
  end Models;

  package CS "Control systems package"
    model CS_Dummy

      extends BaseClasses.Partial_ControlSystem;

    equation

    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Dummy;
    annotation (Documentation(info="<html>
<p>This package is for control systems. CS folders should always maintain the base model &quot;CS_Dummy&quot;. </p>
<p>The proper method for using CS_Dummy is to have ALL connections into the sensor bus connect into TRANSFORM.Blcoks.RealExpression blocks and have sample nominal control valves connected into ALL actuator bus connections using Modelica.Blocks.Sources.RealExpression blocks. </p>
<p>Attaching all connections to the expandable connectors within the package will allow for new control systems to be created out of CS_Dummy and immediately have all connections available to the developer. </p>
</html>"));
  end CS;

  package Data

    model Data_Dummy

      extends BaseClasses.Record_Data;

      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_Dummy;
    annotation (Documentation(info="<html>
<p>The data packages throughout NHES may require some updating to the new format, in which there should be 3 data packages at minimum: </p>
<p>Data_Component (or something that means this): This data component may contain as many tabs or groups as the developer sees appropriate. All geometric and reference component parameters should be placed in the data file so that users can open this interface and have all of their values accessible. For developers: Please <b>include nominal values in your data components</b>. This will help users make sure that checking works for the models. Initial conditions data should be included in a secondary tab within the data component - use annotation(Dialog(tab = &quot;Initial Conditions&quot;, [optional: group = &quot;group _&quot;])); </p>
<p>Data_CS is allowed to be a separate data component. This should include potential reference values for the control system. </p>
<p>There is an assumption of user expertise to not switch in data sets into the wrong areas, but that is a possibility users should be aware of. Bringing in a data set without all the same parameters will fail the simulation.</p>
</html>"));
  end Data;

  package SupportComponent

    annotation (Documentation(info="<html>
<p>This package is reserved for custom components that are placed within the Models. Some examples of this could be a coolant-specific component within a different advanced reactor technology (such as the custom gas compressor acting as a mass flow pump within the HTGR package) or a custom valve used specific to a balance of plant model. </p>
<p>There should be a compelling reason that the component is not placed elsewhere in NHES. One good example of this is if a TRANSFORM component is enhanced or specialized (such as adding a new port into a SimpleVolume or something) in a way that it would fit within the TRANSFORM filetree but has been developed by HYBRID users. </p>
</html>"));
  end SupportComponent;

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
    annotation (Documentation(info="<html>
<p>Base classes should generally not be adjusted by the users or developers. Functionally, most of these base class items add the functionality and standardized appearances used throughout the package. </p>
</html>"));
  end BaseClasses;
  annotation (Documentation(info="<html>
<p>This package should be copied when a user wants to create a new subsystem (consider a reactor type, industrial process, energy storage, etc.). The folder contains the structure desired throughout HYBRID&apos;s Modelica modeling. </p>
</html>"));
end New_SubSystem;
