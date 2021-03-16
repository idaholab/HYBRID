within NHES.Systems.SwitchYard.SimpleYard.BaseClasses;
partial record Record_SubSystem_B

  extends Record_SubSystem;

  parameter Integer nPorts_a=0 "Number of port_a connections"
    annotation (Dialog(connectorSizing=true));

  annotation (defaultComponentName="subsystem",
  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Record_SubSystem_B;
