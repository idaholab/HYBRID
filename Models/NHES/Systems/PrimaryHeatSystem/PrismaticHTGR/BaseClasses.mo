within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR;
package BaseClasses
  extends TRANSFORM.Icons.BasesPackage;

  partial model Partial_SubSystem

    extends NHES.Systems.BaseClasses.Partial_SubSystem;

    extends Record_SubSystem;

    replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
        Placement(transformation(extent={{-18,122},{-2,138}})));
    replaceable Partial_EventDriver ED annotation (choicesAllMatching=true,
        Placement(transformation(extent={{2,122},{18,138}})));
    replaceable Record_Data data
      annotation (Placement(transformation(extent={{42,122},{58,138}})));

    SignalSubBus_ActuatorInput actuatorBus
      annotation (Placement(transformation(extent={{10,80},{50,120}}),
          iconTransformation(extent={{10,80},{50,120}})));
    SignalSubBus_SensorOutput sensorBus
      annotation (Placement(transformation(extent={{-50,80},{-10,120}}),
          iconTransformation(extent={{-50,80},{-10,120}})));

  equation
    connect(sensorBus, ED.sensorBus) annotation (Line(
        points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus, CS.sensorBus) annotation (Line(
        points={{-30,100},{-12.4,100},{-12.4,122}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus, CS.actuatorBus) annotation (Line(
        points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus, ED.actuatorBus) annotation (Line(
        points={{30,100},{20,100},{12.4,100},{12.4,122}},
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
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Line(points={{-218,-4}}, color={28,108,200}),
          Polygon(points={{-130,-78},{-130,-78}}, lineColor={28,108,200}),
          Polygon(
            points={{20,-10},{10,-4},{10,6},{20,12},{30,6},{30,-4},{20,-10}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(points={{-252,50},{-252,50}}, lineColor={28,108,200}),
          Polygon(
            points={{-10,6},{-20,12},{-20,22},{-10,28},{0,22},{0,12},{-10,6}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{0,-10},{-10,-4},{-10,6},{0,12},{10,6},{10,-4},{0,-10}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{10,6},{0,12},{0,22},{10,28},{20,22},{20,12},{10,6}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(points={{8,16},{8,16}}, lineColor={28,108,200}),
          Polygon(
            points={{10,-26},{0,-20},{0,-10},{10,-4},{20,-10},{20,-20},{10,
                -26}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-12,-16},{-12,-16}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(points={{-190,-174},{-190,-174}}, lineColor={28,108,200}),
          Polygon(
            points={{-10,-26},{-20,-20},{-20,-10},{-10,-4},{0,-10},{0,-20},{
                -10,-26}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-20,-10},{-30,-4},{-30,6},{-20,12},{-10,6},{-10,-4},{-20,
                -10}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{20,-42},{10,-36},{10,-26},{20,-20},{30,-26},{30,-36},{20,
                -42}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{20,22},{10,28},{10,38},{20,44},{30,38},{30,28},{20,22}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-40,-10},{-50,-4},{-50,6},{-40,12},{-30,6},{-30,-4},{-40,
                -10}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-20,22},{-30,28},{-30,38},{-20,44},{-10,38},{-10,28},{
                -20,22}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{40,-10},{30,-4},{30,6},{40,12},{50,6},{50,-4},{40,-10}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-20,-42},{-30,-36},{-30,-26},{-20,-20},{-10,-26},{-10,
                -36},{-20,-42}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{0,-42},{-10,-36},{-10,-26},{0,-20},{10,-26},{10,-36},{0,
                -42}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{30,-26},{20,-20},{20,-10},{30,-4},{40,-10},{40,-20},{30,
                -26}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{30,6},{20,12},{20,22},{30,28},{40,22},{40,12},{30,6}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{0,22},{-10,28},{-10,38},{0,44},{10,38},{10,28},{0,22}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-30,6},{-40,12},{-40,22},{-30,28},{-20,22},{-20,12},{-30,
                6}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-30,-26},{-40,-20},{-40,-10},{-30,-4},{-20,-10},{-20,-20},
                {-30,-26}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-60,-10},{-70,-4},{-70,6},{-60,12},{-50,6},{-50,-4},{-60,
                -10}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-50,6},{-60,12},{-60,22},{-50,28},{-40,22},{-40,12},{-50,
                6}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-40,22},{-50,28},{-50,38},{-40,44},{-30,38},{-30,28},{
                -40,22}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-30,38},{-40,44},{-40,54},{-30,60},{-20,54},{-20,44},{
                -30,38}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{60,-10},{50,-4},{50,6},{60,12},{70,6},{70,-4},{60,-10}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{50,6},{40,12},{40,22},{50,28},{60,22},{60,12},{50,6}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{40,22},{30,28},{30,38},{40,44},{50,38},{50,28},{40,22}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{30,38},{20,44},{20,54},{30,60},{40,54},{40,44},{30,38}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{30,-58},{20,-52},{20,-42},{30,-36},{40,-42},{40,-52},{30,
                -58}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-10,-58},{-20,-52},{-20,-42},{-10,-36},{0,-42},{0,-52},{
                -10,-58}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{10,-58},{0,-52},{0,-42},{10,-36},{20,-42},{20,-52},{10,
                -58}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-30,-58},{-40,-52},{-40,-42},{-30,-36},{-20,-42},{-20,
                -52},{-30,-58}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{40,-42},{30,-36},{30,-26},{40,-20},{50,-26},{50,-36},{40,
                -42}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{50,-26},{40,-20},{40,-10},{50,-4},{60,-10},{60,-20},{50,
                -26}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{10,38},{0,44},{0,54},{10,60},{20,54},{20,44},{10,38}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-10,38},{-20,44},{-20,54},{-10,60},{0,54},{0,44},{-10,38}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-40,-42},{-50,-36},{-50,-26},{-40,-20},{-30,-26},{-30,
                -36},{-40,-42}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Polygon(
            points={{-50,-26},{-60,-20},{-60,-10},{-50,-4},{-40,-10},{-40,-20},
                {-50,-26}},
            lineColor={238,46,47},
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag)}),
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

  partial model Partial_EventDriver

    extends NHES.Systems.BaseClasses.Partial_EventDriver;

    SignalSubBus_ActuatorInput actuatorBus
      annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
          iconTransformation(extent={{10,-120},{50,-80}})));
    SignalSubBus_SensorOutput sensorBus
      annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
          iconTransformation(extent={{-50,-120},{-10,-80}})));

    annotation (
      defaultComponentName="ED",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})));

  end Partial_EventDriver;

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
