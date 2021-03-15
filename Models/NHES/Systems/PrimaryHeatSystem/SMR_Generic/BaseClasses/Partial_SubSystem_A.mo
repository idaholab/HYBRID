within NHES.Systems.PrimaryHeatSystem.SMR_Generic.BaseClasses;
partial model Partial_SubSystem_A

  import Modelica.Constants;

  extends Partial_SubSystem;
  extends Record_SubSystem_A;

  Modelica.Fluid.Interfaces.FluidPort_a port_a
    annotation (Placement(transformation(extent={{94,-16},{114,4}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b
    annotation (Placement(transformation(extent={{94,50},{114,70}})));
  annotation (
    defaultComponentName="PHS",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})));

end Partial_SubSystem_A;
