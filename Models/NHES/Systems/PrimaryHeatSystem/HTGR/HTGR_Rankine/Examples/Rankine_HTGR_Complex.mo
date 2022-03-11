within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model Rankine_HTGR_Complex
  extends Modelica.Icons.Example;
  Components.Pebble_Bed_Rankine_Complex pebble_Bed_Rankine_Standalone_STHX_DNE
    annotation (Placement(transformation(extent={{-40,-32},{50,46}})));
equation

  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=30,
      __Dymola_Algorithm="Esdirk45a"));
end Rankine_HTGR_Complex;
