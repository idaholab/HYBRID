within NHES.Systems.SecondaryEnergySupply.HydrogenTurbine;
model CS_Dummy
  extends
    NHES.Systems.SecondaryEnergySupply.HydrogenTurbine.BaseClasses.Partial_ControlSystem;

    extends Icons.DummyIcon;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_Dummy;
