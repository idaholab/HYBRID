within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.Examples;
model ReactorBOPIntegrated_Rankine_Simple
  extends Modelica.Icons.Example;
  Models.PebbleBed_Simple pebble_Bed_Rankine_Standalone
    annotation (Placement(transformation(extent={{-62,-48},{50,44}})));
equation

  annotation (experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p><b><span style=\"font-size: 18pt;\">Example Name</span></b></p>
<p><span style=\"font-size: 12pt;\">Simple example of HTGR integrated with Balance of Plant </span></p>
<p><br><b><span style=\"font-size: 18pt;\">Design Purpose of Exampe</span></b></p>
<p><span style=\"font-size: 12pt;\">The simulation should be moving towards steady state operation using the control system to meet exit core temperature of 850 C. The simple Rankine integration is meant as a demonstrative starting point for integrating the HTGR primary loop (running on gas) to a simple steam system. This simple system contains only two control element: maintaining reactor outlet temperature and the reference mass flow rate through the reactor core. </span></p>
<p><span style=\"font-size: 12pt;\">This is a basis model that can be used to add more detail to the secondary side and introduce new control methods. </span></p>
<p><br><b><span style=\"font-size: 18pt;\">What Users Can Do </span></b></p>
<p><i><span style=\"font-size: 12pt;\">&lt; Please fill this section, if needed &gt;</span></i></p>
<p><br><b><span style=\"font-size: 18pt;\">Reference </span></b></p>
<p><i><span style=\"font-size: 12pt;\">&lt; Please fill this section, if needed &gt;</span></i></p>
<p><br><b><span style=\"font-size: 18pt;\">Contact Deatils </span></b></p>
<p><span style=\"font-size: 12pt;\">This model was designed by Daniel Mikkelson.</span></p>
<p><span style=\"font-size: 12pt;\">All initial questions should be directed to Daniel Mikkelson (Daniel.Mikkelson@inl.gov). </span></p>
</html>"));
end ReactorBOPIntegrated_Rankine_Simple;
