within NHES.Systems.EnergyStorage;
package SensibleHeatStorage

annotation (Documentation(info="<html>
<p><b>Author</b>: Konor Frick</p>
<p><b>Date</b>: May 2018</p>
<p><b>email</b>: konor.frick@inl.gov</p>
<p><b>Description</b>: The two-tank sensible heat system is<span style=\"font-family: TimesNewRoman;\"> involves the heating of a solid or liquid without phase change and can be</span> <span style=\"font-family: TimesNewRoman;\">deconstructed into two operating modes: charging and discharging. A two-tank TES system is a common</span> <span style=\"font-family: TimesNewRoman;\">configuration for liquid sensible heat systems. In the charging mode cold fluid is pumped from a cold</span> <span style=\"font-family: TimesNewRoman;\">tank through an Intermediate Heat Exchanger (IHX), heated, and stored in a hot tank while the opposite</span> <span style=\"font-family: TimesNewRoman;\">occurs in the discharge mode. Such systems have been successfully demonstrated in the solar energy field</span> <span style=\"font-family: TimesNewRoman;\">as a load management strategy.</span> </p>
<p><span style=\"font-family: TimesNewRoman;\">The configuration of the TES system held within the repository involves an outer loop interfaces with the energy manifold. Bypass steam is directed through an IHX and ultimately discharged to the main condenser of an Integrated system. An inner loop containing a TES fluid consists of two large storage tanks along with several pumps to transport the TES fluid between the tanks, the IHX and a steam generator.</span></p>
<p><br>Full systems details are available in the document:</p>
<p>&quot;<i><span style=\"font-family: Courier New; font-size: 10pt; background-color: #f9f9f9;\">Status Report on the Component Models Developed in the Modelica Framework: Reverse Osmosis Desalination Plant &amp; Thermal Energy Storage</span></i>&quot;. INL/EXT-18-45505</p>
</html>"));
end SensibleHeatStorage;
