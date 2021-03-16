within NHES.Systems.ElectricalGrid.InfiniteGrid.BaseClasses;
partial model Partial_SubSystem_A

  extends Partial_SubSystem;
  extends Record_SubSystem_A;

  NHES.Electrical.Interfaces.ElectricalPowerPort_a portElec_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  annotation (defaultComponentName="EG",
Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                        Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,140}})));
end Partial_SubSystem_A;
