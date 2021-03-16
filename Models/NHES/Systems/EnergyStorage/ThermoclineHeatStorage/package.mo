within NHES.Systems.EnergyStorage;
package ThermoclineHeatStorage "Single-Tank Packed Bed Thermocline Tank, More specifically for the TEDS experiment at INL"

annotation (Documentation(info="<html>
<p><b>Author</b>: Konor Frick</p>
<p><b>Date:</b> August 2020</p>
<p><b>email</b>: konor.frick@inl.gov</p>
<p><b>Description</b>: The Thermocline Models are designed for single tank packed bed thermocline systems. The equations are consistent with the Schumann Equations developed in 1927. </p>
<p>System example showcases the ability of cycling the thermocline and the ability of the thermocline to lose heat to the surrounding. System parameters can be changed from the top level screen in the geometry file and the parameters tab</p>
<p><b>Note</b>: From a practical standpoint either the top or bottom of the tank can be the hot side or cold side. It is just a matter of cycling the Thermocline to achieve a semi-steady state of temperature distribution. </p>
<p><br><b>Full systems details are available</b> <b>in the document:</b> &quot;<i>Development of the INL Thermal Energy Distribution System (TEDS) in the Modelica Ecosystem for Validation and Verification</i>&quot; INL/EXT-20-59195</p>
<p>Full TEDS models will be made available from an Experimental Plugin that is currently under development. </p>
</html>"));
end ThermoclineHeatStorage;
