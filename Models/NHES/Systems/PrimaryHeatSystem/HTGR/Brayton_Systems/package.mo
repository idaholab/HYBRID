within NHES.Systems.PrimaryHeatSystem.HTGR;
package Brayton_Systems

annotation (Documentation(info="<html>
<p>The Brayton cycle HTGR is constructed a little bit differently than the typical Hybrid power generation system. The entire HTGR power production system is built as a single drag-and-drop module as opposed to a split between the primary and secondary sides. This is due to the fact that a Brayton system is a direct power generation system: the core coolant is the same fluid that is producing the electricity. While it is possible to split the model (see the BalanceOfPlant.Brayton_Cycle module as the secondary side of this particular model without the core), the primary side becomes a single component, which is simplistic. </p>
<p>The Brayton cycle system is based on the HTGR-GT from &quot;Gas turbine power conversion systems for modular HTGRs&quot;, IAEA-TECDOC-1238, on pp 42-43. Standard TRISO fuel (UO2-loaded) is used rather than the document&apos;s Pu-based system. The table on page 43 indicates that the Helium core exit temperature is 850C. </p>
<p><img src=\"modelica://NHES/Systems/PrimaryHeatSystem/HTGR/Brayton_HTGR_Cycle_Example.png\"/></p>
<p><br>There are multiple models held within this package in the Components folder. The &quot;Complete&quot; model effectively the system described by the image above. Two other models are included in the Components folder. </p>
<p>The first other model is Pebble_Bed_CC, which uses the heat of the intercooler and precooler to produce steam that is then used by a steam turbine to produce additional electricity. </p>
<p>The second model Pebble_Bed_Brayton includes a heat exchanger upstream of the turbine for heat applications. Note that this is a similar structure to a TBV in a PWR system for integration. </p>
</html>"));
end Brayton_Systems;
