within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary;
package StagebyStageTurbine









annotation (Documentation(info="<html>
<p>The goal of this package is to allow for the detailed simulation of an energy conversion cycle. That is achieved by building a turbine in a stage-by-stage format, designing with deflection angles and cross sectional areas. By designing the turbine in this manner, the user has ready access to intermediate fluid conditions and can either tap these fluid streams or use moisture separators. Additionally, a user can junction in other fluid streams (so if one wanted a reheat stream or a peaking stream). </p>
<p>This is done by changing the velocity profile from 1-D into 3-D cylindrical. The geometry is still 1-D area averaged, and so the velocities are still defined as existing within a single axial node, but simply having those rotational and radial components. The forces exchanged between the turbine stages and the HTF define the torque applied on the turbine, which then dictates the power via a generator component. </p>
<p>The Eight_Stage_Turbine example shows all of the capabilities of this package in one single location. It demonstrates the use of the stator and rotor stages, along with the conversion components switching between the cylindrical flow and linear flow components. It also shows the application of the new boundary conditions. </p>
<p>This package has allowed for simulation of some of the most complex fluid networks observed to date within Dymola/Modelica. Due to the complexity involved by adding so many junctions, it is highly recommended that users build systems component-by-component. Attempting to combine many components together without a grasp for initial conditions can cause failure in initialization stages in otherwise well-posed systems (true across all of Dymola, but very easy to do here). </p>
<p>The original intent of this package was to enhance our ability to observe system-wide implications of the use of energy storage in integrated energy systems with nuclear reactors. System-wide pressure changes are readily observed when these systems are built up and nuclear reactor feedback is observable. Minimal control optimization has been done so far, but having this level of complexity in our modeling should allow for control mechanism studies moving forward. </p>
<p>A final developer note: when building such complex fluid networks, it is often possible that adding even one more connection can cause the Dymola matrix building routines to fail and have some form of computation error. It is often possible to alleviate this issue by introducing a quick &quot;Delay&quot; component. While admittedly not physical, even introducing a delay component with a 1ms derivative term can help loosen the solution matrix. It is better to have a minimally off solution than no solution at all. </p>
<p>(A delay box sets Time_Constant*der(Output) = Input-Output, so technically Output=/=Input, but it&apos;s always exponentially approaching and should be equal within general orders of magnitude. And hey, it&apos;s probably better than our correlations). </p>
<p>Contact: Daniel Mikkelson, Ph.D.</p>
<p>Idaho National Laboratory</p>
<p>daniel.mikkelson@inl.gov</p>
</html>"));
end StagebyStageTurbine;
