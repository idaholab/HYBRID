within NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine;
model CS_Dummy
  extends
    NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.BaseClasses.Partial_ControlSystem;

    extends Icons.DummyIcon;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_Dummy;
