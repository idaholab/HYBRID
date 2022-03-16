within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model Rankine_HTGR_Complex
  extends Modelica.Icons.Example;
  Components.Pebble_Bed_Rankine_Complex pebble_Bed_Rankine_Standalone_STHX_DNE
    annotation (Placement(transformation(extent={{-40,-32},{50,46}})));
equation

  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=30,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>This model is mostly based on Xe-100 designs, but is not yet considered to represent the system completely. Few details exist regarding specific internal dimensions of that design. As such, the characteristics and theory of control should be accurate (what elements are controlled based on what variables) but the time constants are not to be considered completely accurate as of yet. Continued work (as of March 2022) will be done to match some literature output data produced by X-Energy. </p>
<p><br>The steady-state results are close to literature values. </p>
<p><br>This specific model is likely the best starting point for testing integration techniques and new control methods of the Rankine-cycle HTGR. That being said, the Primary_Loop model is taken from this model to build only the primary side of the Rankine system. </p>
<p><br>Reference doc: A control approach investigation of the Xe-100 plant to perform load following within the operational range of 100 &ndash; 25 &ndash; 100&percnt;, Brits et al. Nuclear Engineering and Design 2018. </p>
</html>"));
end Rankine_HTGR_Complex;
