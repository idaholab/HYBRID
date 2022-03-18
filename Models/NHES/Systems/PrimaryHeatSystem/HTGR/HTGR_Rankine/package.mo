within NHES.Systems.PrimaryHeatSystem.HTGR;
package HTGR_Rankine

annotation (Documentation(info="<html>
<p>The HTGR Rankine system appears to be the leading candidate for early deployment internationally. As such, it is included as an option here. </p>
<p>The specific reference paper most used in this model development was &quot;A control approach investigation fo the Xe-100 plant to perform load following within the operational range of 100 - 25 - 100&percnt;&quot;, 2018 paper from Nuclear Engineering and Design by Brits et al. </p>
<p>The steady-state results are mostly met, and the control system introduced by that paper is introduced in this package. Further investigation is required to replicate the transient results presented in that paper. It is difficult to obtain precise results without some additional information regarding the thermal mass of the system and the overall rate of change of key controlled values. </p>
</html>"));
end HTGR_Rankine;
