within NHES.Systems.SupervisoryControl.Examples;
model InputSetpointData_Test

  extends Modelica.Icons.Example;

  InputSetpointData SC
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10000, __Dymola_NumberOfIntervals=1000));
end InputSetpointData_Test;
