within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.Examples;
model ReactorBOPIntegrated_Rankine_Advanced
  extends Modelica.Icons.Example;
  Models.PebbleBed_Complex pebble_Bed_Rankine_Standalone_STHX_DNE
    annotation (Placement(transformation(extent={{-40,-32},{50,46}})));
equation

  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=30,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p><b><span style=\"font-size: 18pt;\">Example Name</span></b></p>
<p><span style=\"font-size: 12pt;\">Advanced example of HTGR integrated with Balance of Plant </span></p>
<p><br><b><span style=\"font-size: 18pt;\">Design Purpose of Exampe</span></b></p>
<p><span style=\"font-size: 12pt;\">This model is mostly based on Xe-100 designs, but is not yet considered to represent the system completely. Few details exist regarding specific internal dimensions of that design. As such, the characteristics and theory of control should be accurate (what elements are controlled based on what variables) but the time constants are not to be considered completely accurate as of yet. Continued work (as of March 2022) will be done to match some literature output data [1] produced by X-Energy. The steady-state results are close to literature values. </span></p>
<p><span style=\"font-size: 12pt;\">This specific model is likely the best starting point for testing integration techniques and new control methods of the Rankine-cycle HTGR. That being said, the Primary_Loop model is taken from this model to build only the primary side of the Rankine system. </span></p>
<p><br><b><span style=\"font-size: 18pt;\">What Users Can Do </span></b></p>
<p><i><span style=\"font-size: 12pt;\">&lt; Please fill this section, if needed &gt;</span></i></p>
<p><br><b><span style=\"font-size: 18pt;\">Reference </span></b></p>
<p><span style=\"font-size: 12pt;\">[1] <span style=\"font-family: Arial; color: #222222; background-color: #ffffff;\">Brits, Yvotte, et al. &quot;A control approach investigation of the Xe-100 plant to perform load following within the operational range of 100&ndash;25&ndash;100&percnt;.&quot;&nbsp;<i>Nuclear Engineering and Design</i>&nbsp;329 (2018): 12-19.</span></p>
<p><br><b><span style=\"font-size: 18pt;\">Contact Deatils </span></b></p>
<p><span style=\"font-size: 12pt;\">This model was designed by Daniel Mikkelson.</span></p>
<p><span style=\"font-size: 12pt;\">All initial questions should be directed to Daniel Mikkelson (Daniel.Mikkelson@inl.gov). </span></p>
</html>"));
end ReactorBOPIntegrated_Rankine_Advanced;
