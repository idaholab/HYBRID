within NHES.Systems.EnergyStorage;
package Latent_Heat_TES

annotation (Documentation(info="<html>
<p>Package developed to model solid media thermal energy storage systems. There are 3 models developed and presented in this package. </p>
<p>The first is the &quot;single pipe&quot; model. This model evaluates a single fluid pipe (hence the name) during all operations. The concrete has a radial (perpendicular to the pipe) adiabatic boundary condition imposing radial symmetry on the system. By multiplying this tube by variable nTubes, the system can be expanded to its necessary size. For more realistic expected solutions, the system should have a large axial length in order to avoid end behaviors. </p>
<p>The second is the &quot;dual pipe&quot; model. In this case, the charging ports communicate with one set of fluid nodes, which interact with radial node 1 of the concrete, while the discharging ports interact with a second pipe (in HTF_State[:,2] slot) which interact with radial node nY of the concrete. Again, a full physical system is built by using parameter nTubes. </p>
<p>The final is the &quot;two HTFs&quot; model. This model is similar to the &quot;dual pipe&quot; model in structure, but allows the user to dictate different heat transfer fluids within the two pipes. They are then labeled HTFC (for HTF Charging) and HTFD for Discharging. </p>
<p>Default media for the concrete is held in this package&apos;s SubClasses package and is called HeatCrete. Technically, any TRANSFORM solid could work there. The HeatCrete data is held within this package so that it is not TRANSFORM dependent. </p>
<p>The default media for the HTF is water, as this was developed in nuclear SMR research, where the charging fluid was steam and the application was energy arbitrage. </p>
<p>The active &quot;controlled&quot; versions of these concrete systems have no actuators. Controls on the system should be imposed from the outside. A user should consider these models to evaluate the physical block that starts and ends at the edges of the concrete. Current concrete designs do not allow for moving parts within that structure, and thus nothing to inherently control. </p>
<p>For questions, contact: </p>
<p>Daniel Mikkelson, Ph.D. </p>
<p>Idaho National Laboratory</p>
<p>daniel.mikkelson@inl.gov</p>
</html>"));
end Latent_Heat_TES;
