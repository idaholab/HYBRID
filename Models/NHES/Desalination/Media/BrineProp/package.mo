within NHES.Desalination.Media;
package BrineProp "Media models for p-h-T-rho-eta properties of aqueous solutions of multiple salts and gases"
  extends Modelica.Icons.VariantsPackage;
  import Modelica.Utilities.Streams.print;
  constant Boolean debugmode = false "print messages in functions";
  constant Integer outOfRangeMode = 2
    "when out of validity range: 0-do nothing, 1-show warnings, 2-throw error";
  constant Boolean ignoreLimitN2_T = true;
  constant Boolean ignoreLimitN2_p = true;
  constant Boolean ignoreLimitInh_KCl_Tmin = true
    "ignore Tmin in appMolarEnthalpy_KCl_White and appMolarHeatCapacity_KCl_White";
  constant Boolean ignoreLimitInh_CaCl2_Tmin = true
    "ignore Tmin in appMolarEnthalpy_CaCl2_White and appMolarHeatCapacity_CaCl2_White";
  constant Boolean[5] ignoreLimitSalt_p = {false, false, false, false, false}
    "ignore pressure limits";
  constant Boolean[5] ignoreLimitSalt_T = {false, false, false, false, false}
    "ignore temperature limits";
  constant Boolean[5] ignoreLimitSalt_b = {false, false, false, false, false}
    "ignore salinity limits";
  // constant Boolean[5] ignoreLimitSalt_visc={false,false,false,false,false};
constant Modelica.Units.SI.MolarMass M_H2O=Modelica.Media.Water.waterConstants[
    1].molarMass "0.018015 [kg/mol]";
  /* Set the path to the data directory */
  constant String DataDir = Modelica.Utilities.Files.loadResource("modelica://BrineProp/Resources/Data/");
  /* Set the path of the output directory */
  constant String OutputDir = Modelica.Utilities.Files.loadResource("modelica://BrineProp/Resources/output/");






















  annotation(Documentation(info = "<html>
<p><b>BrineProp</b> is a modelica package that calculates the thermodynamic properties of a specified brine, i.e. an aqueous solution of salts and gases, with a potential gas phase, including degassing/evaporation and solution/condensation.</p>
<p>It was developed as a part of a PhD projected, documented in the thesis &QUOT;<a href=\"http://nbn-resolving.de/urn:nbn:de:kobv:83-opus4-47126\">Thermo-hydraulic model of the two-phase flow in the brine circuit of a geothermal power plant</a>&QUOT;. </p>
<p>This package contains an extension of the Modelica.Media interfaces for two-phase mixtures (<a href=\"BrineProp.PartialMixtureTwoPhaseMedium\">PartialMixtureTwoPhaseMedium</a>), the generic brine template with the vapour-liquid-equilibrium calculation (<a href=\"BrineProp.PartialBrine_ngas_Newton\">PartialBrine_ngas_Newton</a>), as well specific brine models for NaCl, KCl, CaCl2, [MgCl2, SrCl2 partially supported] (1-phase: <a href=\"BrineProp.Brine_5salts\">Brine_5salts</a>) and CO2, N2 and CH4 (2-phase: <a href=\"BrineProp.Brine_5salts_TwoPhase_3gas\">Brine_5salts_TwoPhase_3gas</a>).</p>
<p>This package has been developed and tested in Dymola up to 2015 MSL 3.2.1 (See &QUOT;Known issues&QUOT;).</p>
<p><b>Licensed by the </b>Helmholtz Centre Potsdam, GFZ German Research Centre for Geosciences<b> under the Modelica License 2</b></p>
<p>Copyright &copy; 2009-2014 Henning Francke.</p>
<p><br><i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\">http://www.modelica.org/licenses/ModelicaLicense2</a>.</i> </p>
<h4>Usage</h4>
<p>Check the (non-partial) Brine packages (<a href=\"BrineProp.Brine_5salts\">Brine_5salts</a>, <a href=\"BrineProp.BrineGas_3Gas\">BrineGas_3Gas</a> or <a href=\"BrineProp.Brine_5salts_TwoPhase_3gas\">Brine_5salts_TwoPhase_3gas</a>) for instructions or run models from <code>BrineProp/Examples</code>. </p>
<p>All calculated values are returned in SI-Units and are mass based. </p>
<h4>Known issues:</h4>
<ul>
<li>no differentials implemented</li>
<li>1phase-transient calculation does not compile, supposedly due to missing derivatives</li>
<li>To switch from MSL 3.2 to MSL 3.2.1 (un)comment code in <code>PartialMixtureTwoPhaseMedium </code>to avoid warnings</li>
<li>To switch from MSL 3.2.1 to MSL 3.2 (un)comment code in <code>PartialMixtureTwoPhaseMedium </code>to avoid errors</li>
<li>not fully compatible to OpenModelica(check OK, errors at compiling or simulation)</li>
<li>not fully compatible to JModelica (String arguments not fully supported)</li>
</ul>
<h4>Compatibilty:</h4>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td></td>
<td><p align=\"center\"><h4>OpenModelica 1.9.1 beta2</h4></p></td>
<td><p align=\"center\"><h4>JModelica 1.14</h4></p></td>
</tr>
<tr>
<td><p>SingleSaltBrine</p></td>
<td><p>check</p></td>
<td><p>?</p></td>
</tr>
<tr>
<td><p>BrineProps1PhaseMinimal</p></td>
<td><p>check</p></td>
<td><p>?</p></td>
</tr>
<tr>
<td><p>BrineProps1PhaseFull</p></td>
<td><p>check</p></td>
<td><p>?</p></td>
</tr>
<tr>
<td><p>BrineGas</p></td>
<td><p>check, compile w/ warning</p></td>
<td><p>?</p></td>
</tr>
<tr>
<td><p>PureWaterMinimal</p></td>
<td><p>check, compile, simulate</p></td>
<td><p>error</p></td>
</tr>
<tr>
<td><p>PureWaterFlashing</p></td>
<td><p>check</p></td>
<td><p>?</p></td>
</tr>
<tr>
<td><p>BrineProps2PhaseMinimal</p></td>
<td><p>check</p></td>
<td><p>?</p></td>
</tr>
<tr>
<td><p>BrineProps2phaseFull</p></td>
<td><p>check</p></td>
<td><p>?</p></td>
</tr>
<tr>
<td><p>BrineProps2PhaseMinimal_state</p></td>
<td><p>check</p></td>
<td><p>?</p></td>
</tr>
<tr>
<td><p>ConvertBrineComposition</p></td>
<td><p>check</p></td>
<td><p>?</p></td>
</tr>
</table>
<h4>TODO:</h4>
<ul>
<li>implement differentials</li>
<li>remove <font style=\"color: #006400; \">argument <code>MM_vec</font></code> in property functions</li>
<li>implement limit ignore switches consistently (preferrably as parameter in the Medium package to be changed on declaration)</li>
<li>Add apparent molar heat capacity/enthalpy for (NaCl,) MgCl2 and SrCl2</li>
</ul>
<h5>Created by</h5>
<p>Henning Francke</p>
<p>Helmholtz Centre Potsdam GFZ German Research Centre for Geosciences</p>
<p>Telegrafenberg, D-14473 Potsdam</p>
<p>Germany</p>
<p><a href=\"mailto:info@xrg-simulation.de\">francke@gfz-potsdam.de</a></p>
</html>",
      revisions = "<html>

</html>"),
       versionDate = "2014-04-02");
end BrineProp;
