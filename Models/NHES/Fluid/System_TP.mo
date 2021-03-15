within NHES.Fluid;
model System_TP
  "Modelica.Fluid System properties and default values (ambient, flow direction, initialization) with ThermoPower Addition"

  extends Modelica.Fluid.System;

  // Assumptions
  //parameter ThermoPower.Choices.System.Dynamics Dynamics=ThermoPower.Choices.System.Dynamics.DynamicFreeInitial "Dynamics for ThermoPower components" annotation(Evaluate=true, Dialog(tab = "Assumptions", group="ThermoPower Dynamics"));

  annotation (defaultComponentName="system",
  defaultComponentPrefixes="inner",
              missingInnerMessage="
Your model is using an outer \"system\" component but
an inner \"system\" component is not defined.
For simulation drag Modelica.Fluid.System into your model
to specify system properties.",
              Documentation(info="<html>
<p>Provides the parameter definition for Dynamics used in ThermoPower. It is assumed Dynamics = energyDynamics.</p>
</html>"));
end System_TP;
