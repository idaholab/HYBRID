within NHES.Systems.SwitchYard.SimpleYard.BaseClasses;
partial model Partial_SubSystem_A

  extends Partial_SubSystem;
  extends Record_SubSystem_A;

  Electrical.Interfaces.ElectricalPowerPort_a portElec_a1
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Electrical.Interfaces.ElectricalPowerPort_a portElec_a2
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Electrical.Interfaces.ElectricalPowerPort_a portElec_a3
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Electrical.Interfaces.ElectricalPowerPort_b portElec_b1
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  Electrical.Interfaces.ElectricalPowerPort_b portElec_Grid
    annotation (Placement(transformation(extent={{88,-12},{112,12}}),
        iconTransformation(extent={{90,-10},{110,10}})));

  annotation (defaultComponentName="SY");
end Partial_SubSystem_A;
