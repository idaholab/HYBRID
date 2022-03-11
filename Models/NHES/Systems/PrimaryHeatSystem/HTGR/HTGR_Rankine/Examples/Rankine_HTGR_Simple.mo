within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model Rankine_HTGR_Simple
  extends Modelica.Icons.Example;
  Components.Pebble_Bed_Simple_Rankine pebble_Bed_Rankine_Standalone
    annotation (Placement(transformation(extent={{-62,-48},{50,44}})));
equation

  annotation (experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"));
end Rankine_HTGR_Simple;
