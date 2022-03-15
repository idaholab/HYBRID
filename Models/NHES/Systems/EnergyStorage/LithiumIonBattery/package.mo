within NHES.Systems.EnergyStorage;
package LithiumIonBattery "Single cell of Lithium-Ion battery, with independent charging and discharging curve"

annotation (Documentation(info="<html>
<p><b>Author</b>: Haoyu Wang, Roberto Ponciroli, Argonne National Laboratory</p>
<p><b>Date:</b> July 2021</p>
<p><b>email</b>: haoyuwang@anl.gov</p>
<p><b>Description</b>: The Lithium Ion Battery models contains three levels: Level_0 simply echoes the input demand without any integration; Level_1 contains some input/output power regulation features; Level_2 contains the functional dependence of EMF to the charging level, as well as the over-charge, over-current, over-voltage and over-power protection features. </p>
<p><br><b>Full systems details are available</b> <b>in the document:</b> &quot;<i>Development of Electro-chemical Battery Model for Plug-and-Play Eco-system Library</i>&quot; ANL/NSE-21/26</p>

</html>"));
end LithiumIonBattery;
