within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses;
partial model Partial_SubSystem_A

  extends Partial_SubSystem;
  extends Record_SubSystem_A;

  Electrical.Interfaces.ElectricalPowerPort_a portElec_a annotation (Placement(
        transformation(extent={{150,-70},{170,-50}}),iconTransformation(extent={
            {90,-10},{110,10}})));

  annotation (defaultComponentName="IP",
  Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=false)),
    Diagram(coordinateSystem(extent={{-160,-100},{160,140}},
          preserveAspectRatio=false)));
end Partial_SubSystem_A;
