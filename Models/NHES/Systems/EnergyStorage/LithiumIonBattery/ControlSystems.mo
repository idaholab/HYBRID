within NHES.Systems.EnergyStorage.LithiumIonBattery;
package ControlSystems
  model ED_Dummy

    extends EnergyStorage.Battery.BaseClasses.Partial_EventDriver;

    extends NHES.Icons.DummyIcon;

  equation

  annotation(defaultComponentName="PHS_CS");
  end ED_Dummy;
end ControlSystems;
