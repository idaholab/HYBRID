within NHES.Systems.PrimaryHeatSystem.SMR_Generic.Components;
package Data

  model IRIS

    extends BaseClasses.Record_Data;

    /* ---- Primary Heat System ---- */

    parameter SI.Power Q_totalTh=1000e6 "core thermal output";
    parameter SI.MassFlowRate core_m_flow=4712 "nominal core mass flow rate";
    parameter SI.Temperature core_T_inlet=556 "core inlet temperature";
    parameter SI.Temperature core_T_outlet=594 "core outlet temperature";
    parameter SI.Temperature core_T_avg=0.5*(core_T_inlet + core_T_outlet)
      "core average temperature";
    parameter SI.TemperatureDifference core_dT=core_T_outlet - core_T_inlet
      "core temperature rise";

    parameter SI.Pressure pressurizer_p=1.55e7 "nominal operating pressure";
    parameter SI.Height pressurizer_level=1.68 "nominal pressurizer level";
    parameter NHES.SIunits.nonDim pressurizer_Vfrac_liquid=0.34
      "nominal fraction of liquid in pressurizer";

    annotation (
      defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="IRIS")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<pre><span style=\"color: #006400;\">&nbsp;&nbsp;Sources:</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;1.&nbsp;International&nbsp;Atomic&nbsp;Energy&nbsp;Agency&nbsp;(IAEA),&nbsp;&ldquo;IRIS&nbsp;Plant&nbsp;Overview,&rdquo;&nbsp;October,&nbsp;2002.</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;2.&nbsp;M.&nbsp;D.&nbsp;Carelli,&nbsp;B.&nbsp;Petrović,&nbsp;N.&nbsp;Čavlina,&nbsp;and&nbsp;D.&nbsp;Grgić,&nbsp;</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;&ldquo;IRIS&nbsp;(International&nbsp;Reactor&nbsp;Innovative&nbsp;and&nbsp;Secure)&nbsp;&ndash;&nbsp;Design&nbsp;Overview&nbsp;and</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Deployment&nbsp;Prospects,&rdquo;&nbsp;Nuclear&nbsp;Energy&nbsp;for&nbsp;New&nbsp;Europe&nbsp;International</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Conference,&nbsp;Bled,&nbsp;Slovenia,&nbsp;Sep.&nbsp;5-8,&nbsp;2005.</span>

<span style=\"color: #006400;\">&nbsp;&nbsp;3.&nbsp;A.&nbsp;C.&nbsp;O.&nbsp;Barroso,&nbsp;B.&nbsp;D.&nbsp;Baptista&nbsp;F.,&nbsp;I.&nbsp;D.&nbsp;Arone,&nbsp;L.&nbsp;A.&nbsp;Macedo,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;P.&nbsp;A.&nbsp;B.&nbsp;Sampaio,&nbsp;and&nbsp;M.&nbsp;Moraes,&nbsp;&ldquo;IRIS&nbsp;Pressurizer&nbsp;Design,&rdquo;&nbsp;International</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Congress&nbsp;on&nbsp;Advances&nbsp;in&nbsp;Nuclear&nbsp;Power&nbsp;Plants&nbsp;(ICAPP),&nbsp;paper&nbsp;3227,&nbsp;C&oacute;rdoba,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Spain,&nbsp;May&nbsp;4-7,&nbsp;2003.</span>

<span style=\"color: #006400;\">&nbsp;&nbsp;4.&nbsp;A.&nbsp;C.&nbsp;O.&nbsp;Barroso&nbsp;and&nbsp;B.&nbsp;D.&nbsp;Baptista&nbsp;F.,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;&ldquo;Refining&nbsp;the&nbsp;Design&nbsp;and&nbsp;Analysis&nbsp;of&nbsp;the&nbsp;IRIS&nbsp;Pressurizer,&rdquo;</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;5th&nbsp;International&nbsp;Conference&nbsp;on&nbsp;Nuclear&nbsp;Option&nbsp;in&nbsp;Countries&nbsp;with&nbsp;Small</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;and&nbsp;Medium&nbsp;Electricity&nbsp;Grids,&nbsp;Dubrovnik,&nbsp;Croatia,&nbsp;May&nbsp;16-20,&nbsp;2004.</span>

<span style=\"color: #006400;\">&nbsp;&nbsp;5.&nbsp;A.&nbsp;C.&nbsp;O.&nbsp;Barroso,&nbsp;D.&nbsp;A.&nbsp;Botelho,&nbsp;P.&nbsp;A.&nbsp;B.&nbsp;De&nbsp;Sampaio,&nbsp;and&nbsp;M.&nbsp;Moreira,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;&ldquo;Simulation&nbsp;of&nbsp;IRIS&nbsp;Pressurizer&nbsp;Out-Surge&nbsp;Transient&nbsp;Using&nbsp;Two&nbsp;and&nbsp;Three</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Volumes&nbsp;Simulation&nbsp;Models,&rdquo;&nbsp;International&nbsp;Nuclear&nbsp;Atlantic</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Conference&nbsp;(INAC),&nbsp;Santos,&nbsp;Brazil,&nbsp;Aug.&nbsp;28-Sep.&nbsp;2,&nbsp;2005.</span>

<span style=\"color: #006400;\">&nbsp;&nbsp;6.&nbsp;A.&nbsp;Cioncolini,&nbsp;A.&nbsp;Caami,&nbsp;L.Cinotti,&nbsp;G.&nbsp;Castelli,&nbsp;C.&nbsp;Lombardi,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;L.&nbsp;Luzzi,&nbsp;and&nbsp;M.&nbsp;Ricotti,&nbsp;&ldquo;Thermal&nbsp;Hydraulic&nbsp;Analysis&nbsp;of&nbsp;IRIS&nbsp;Reactor</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Coiled&nbsp;Tube&nbsp;Steam&nbsp;Generator,&rdquo;&nbsp;Proc.&nbsp;Of&nbsp;Nuclear&nbsp;Mathematical&nbsp;and</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Computational&nbsp;Sciences:&nbsp;A&nbsp;Century&nbsp;in&nbsp;Review,&nbsp;A&nbsp;Century&nbsp;Anew,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;LaGrange&nbsp;Park,&nbsp;Ill,&nbsp;April&nbsp;6-11,&nbsp;2003.</span>

<span style=\"color: #006400;\">&nbsp;&nbsp;7.&nbsp;Westinghouse,&nbsp;&ldquo;Computer&nbsp;Models&nbsp;for&nbsp;IRIS&nbsp;Control</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;System&nbsp;Transient&nbsp;Analysis,&rdquo;&nbsp;STD-AR-06-04,&nbsp;2007.</span></pre>
</html>"));
  end IRIS;

  model Data_GenericModule

    extends GenericModular_PWR.BaseClasses.Record_Data;

    import TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;

    // Source 1 (s1):
    // Systems Summary of a Westinghouse Pressurized Water Reactor Nuclear Power Plant
    // 1984, Westinghouse Electric Corporation
    // http://www4.ncsu.edu/~doster/NE405/Manuals/PWR_Manual.pdf

    // Data from Source 1 (d*s1): 4-Loop basis
    // (d1s1) = Table 1-1 (pg. 3): Principal data for current Westinghouse NSSS Models
    // (d2s1) = Table 2-1 (pg. 14): Typical reactor core parameters (4-Loop Plant)
    // (d3s1) = Table 2-2 (pg. 19): Fuel rod parameters
    // (d4s1) = Table 3.1-1 (pg. --): Fuel rod parameters

    //Source 2: https://aris.iaea.org/PDF/NuScale.pdf

    //Source 3: https://doi.org/10.1016/j.desal.2014.02.023

    package Medium = Modelica.Media.Water.StandardWater;
    parameter Real nModules=12;

    //per module
    parameter SI.Power Q_total=160e6 "Total thermal output";
    parameter SI.Power Q_total_el=45e6 "Total electrical output";
    parameter Real eta=Q_total_el/Q_total "Net efficiency";

    parameter SI.Pressure p=12.76e6;
    parameter SI.Temperature T_hot=325 + 273.15 "estimate";
    parameter SI.Temperature T_cold=Medium.temperature_ph(p, h_cold);
    parameter SI.Temperature T_avg=0.5*(T_hot+T_cold);
    parameter SI.TemperatureDifference dT_core=T_hot - T_cold;
    parameter SI.SpecificEnthalpy h_hot=Medium.specificEnthalpy_pT(p, T_hot);
    parameter SI.SpecificEnthalpy h_cold=h_hot - Q_total/m_flow;
    parameter SI.MassFlowRate m_flow=700 "rough estimate from normalizing IRIS and rounded down";

    parameter SI.Length d_reactorVessel_outer=2.75;
    parameter SI.Length length_reactorVessel=20;

    parameter SI.Length length_inletPlenum=2;
    parameter SI.Length d_inletPlenum=d_reactorVessel_outer;

    parameter SI.Length length_core=2.408;
    parameter SI.Length d_core=1.5;
    parameter String Material_fuel="Uranium Oxide" "Fuel pellet material";
    parameter String Material_cladding="Zircaloy-4" "Cladding material";
    parameter SI.Length r_outer_fuelRod=0.5*from_in(0.360) "Outside diameter of fuel rod (d3s1)";
    parameter SI.Length th_clad_fuelRod=from_in(0.0225) "Cladding thickness of fuel rod (d3s1)";
    parameter SI.Length th_gap_fuelRod=0.5*from_in(0.0062) "Gap thickness between pellet and cladding (d3s1)";
    parameter SI.Length r_pellet_fuelRod=0.5*from_in(0.3088) "Pellet radius (d3s1)";
    parameter SI.Length pitch_fuelRod=from_in(0.496) "Fuel rod pitch (d3s1)";
    parameter TRANSFORM.Units.NonDim sizeAssembly=17 "square size of assembly (e.g., 17 = 17x17)";
    parameter TRANSFORM.Units.NonDim nRodFuel_assembly=264 "# of fuel rods per assembly (d3s1)";
    parameter TRANSFORM.Units.NonDim nRodNonFuel_assembly=sizeAssembly^2 - 264 "# of non-fuel rods per assembly (d3s1)";
    parameter TRANSFORM.Units.NonDim nAssembly=floor(Modelica.Constants.pi*d_core^2/4/(pitch_fuelRod*sizeAssembly)^2);

    parameter SI.Length length_outletPlenum=3;
    parameter SI.Length d_outletPlenum=2;

    parameter SI.Length length_hotLeg=10.092;
    parameter SI.Length d_hotLeg=1.4;

    parameter SI.Length length_pressurizer=2.5;
    parameter SI.Length d_pressurizer=d_reactorVessel_outer;

    parameter SI.Length length_steamGenerator=5.5;
    parameter SI.Length d_steamGenerator_tube_outer=from_in(0.5);
    parameter SI.Length th_steamGenerator_tube=from_in(0.083) "Sch 10/20";
    parameter SI.Length d_steamGenerator_tube_inner=d_steamGenerator_tube_outer - 2*th_steamGenerator_tube;
    parameter SI.Length d_steamGenerator_shell_inner=d_hotLeg;
    parameter SI.Length d_steamGenerator_shell_outer=d_reactorVessel_outer;
    // nTubes and length calculation should have reductions based on spacing of tubes
    parameter Real ratioPD_steamGenerator_tube=1.5 "pitch to diameter ratio";
    // nTubes and length are intertwined. This calculation assumes some number of entry tubes that then coil around the entire cavity between the reactor vessel and outlet plenum/hot leg space
    parameter Real nPasses = 2;
    parameter Real nEntryPoint_steamGenerator=128;
    parameter Real nTubes_steamGenerator_perEntryPoint=floor(0.5*(d_steamGenerator_shell_outer - d_steamGenerator_shell_inner)/(d_steamGenerator_tube_outer*ratioPD_steamGenerator_tube));
    parameter Real nTubes_steamGenerator=nEntryPoint_steamGenerator*nTubes_steamGenerator_perEntryPoint/nPasses;
    // For nEntryPoint approach, length is taken as circumference of the average diameter between vessel and plenum. The length is then a calculation of the number of times the tubes can go around with each entry point reducing the length"
    parameter SI.Length length_steamGenerator_tube=Modelica.Constants.pi*0.5*(d_steamGenerator_shell_outer + d_steamGenerator_shell_inner)*floor(
        length_steamGenerator*nPasses/(nEntryPoint_steamGenerator*d_steamGenerator_tube_outer*ratioPD_steamGenerator_tube));
    //Solution for max tubes, min length
    //parameter Real nTubes_steamGenerator= floor(Modelica.Constants.pi*(d_steamGenerator_shell_outer^2/4 - d_steamGenerator_shell_inner^2/4)/(Modelica.Constants.pi*d_steamGenerator_tube_outer^2/4)/nPasses) "for single pass (maximum nTubes)";
    //parameter Real length_steamGenerator_tube = length_steamGenerator*nPasses "for max nTubes";

    parameter SI.Length length_coldLeg=12;
    parameter SI.Length d_coldLeg_inner=d_outletPlenum;
    parameter SI.Length d_coldLeg_outer=d_reactorVessel_outer;
    parameter SI.Length d_coldLeg=4*Modelica.Constants.pi*(d_coldLeg_outer^2/4 - d_coldLeg_inner^2/4)/Modelica.Constants.pi/(d_coldLeg_outer + d_coldLeg_inner);

    final parameter SI.Length lengths[2]={length_inletPlenum + length_core + length_outletPlenum + length_hotLeg,length_steamGenerator + length_coldLeg};

    parameter SI.Pressure p_steam = 3.5e6;
    parameter SI.Temperature T_steam_hot = 300+273.15;
    parameter SI.Temperature T_steam_cold=200+273.15;
    parameter SI.SpecificEnthalpy h_steam_hot=Medium.specificEnthalpy_pT(p_steam, T_steam_hot);
    parameter SI.SpecificEnthalpy h_steam_cold=Medium.specificEnthalpy_pT(p_steam, T_steam_cold);
    parameter SI.MassFlowRate m_flow_steam = Q_total/(h_steam_hot-h_steam_cold);

  equation
    assert(abs(lengths[1] - lengths[2]) <= Modelica.Constants.eps, "Hot/cold leg lengths must be equal");
    assert(abs(length_reactorVessel - lengths[1] - length_pressurizer) <= Modelica.Constants.eps, "Hot leg and pressurizer must be equal to reactor vessel length");

    annotation (
      defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="GenericModule")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
</html>"));
  end Data_GenericModule;

  record DataInitial

    extends TRANSFORM.Icons.Record;

  //core.coolantSubchannel
  parameter SI.Density d_start_core_coolantSubchannel[:] = {729.99456787,707.68652344,683.89465332,658.36236572};
  parameter SI.Pressure p_start_core_coolantSubchannel[:] = {12911367.,12907437.,12903607.,12899882.};
  parameter SI.Temperature T_start_core_coolantSubchannel[:] = {569.07678223,579.30987549,588.94995117,597.87921143};
  parameter SI.SpecificEnthalpy h_start_core_coolantSubchannel[:] = {1317572.25,1374710.125,1431848.125,1488985.875};
  //hotLeg
  parameter SI.Density d_start_hotLeg[:] = {658.2980957,658.20166016};
  parameter SI.Pressure p_start_hotLeg[:] = {12861758.,12810911.};
  parameter SI.Temperature T_start_hotLeg[:] = {597.85516357,597.82647705};
  parameter SI.SpecificEnthalpy h_start_hotLeg[:] = {1488930.125,1488878.625};
  //coldLeg
  parameter SI.Density d_start_coldLeg[:] = {751.05932617};
  parameter SI.Pressure p_start_coldLeg[:] = {12936737.};
  parameter SI.Temperature T_start_coldLeg[:] = {558.34472656};
  parameter SI.SpecificEnthalpy h_start_coldLeg[:] = {1260434.125};
  //STHX.tube
  parameter SI.Density d_start_STHX_tube[:] = {801.91125488,117.77983093,67.53452301,46.95209503,35.55274582,28.22073174,23.06417084,19.21644974,16.3672657,14.60087109};
  parameter SI.Pressure p_start_STHX_tube[:] = {3928153.5,3925242.75,3913008.75,3891694.,3861035.5,3820542.75,3769524.25,3707093.75,3632158.5,3500001.};
  parameter SI.Temperature T_start_STHX_tube[:] = {521.17053223,522.37127686,522.19030762,521.87188721,521.41033936,520.79528809,520.01159668,519.03967285,547.73358154,573.36859131};
  parameter SI.SpecificEnthalpy h_start_STHX_tube[:] = {1076191.5,1333470.,1550688.375,1770644.875,1997392.25,2233793.25,2481958.25,2743505.5,2901873.5,2978967.5};
  //STHX.shell
  parameter SI.Density d_start_STHX_shell[:] = {662.02679443,669.76708984,682.17218018,693.54766846,704.05200195,713.84399414,723.09503174,732.00646973,742.28991699,750.97668457};
  parameter SI.Pressure p_start_STHX_shell[:] = {12810909.,12816239.,12819835.,12823497.,12827221.,12831002.,12834836.,12838720.,12842652.,12848634.};
  parameter SI.Temperature T_start_STHX_shell[:] = {596.58215332,593.97235107,589.5078125,585.11022949,580.78710938,576.52716064,572.29638672,568.02947998,562.8692627,558.31341553};
  parameter SI.SpecificEnthalpy h_start_STHX_shell[:] = {1480592.25,1463564.625,1435439.875,1408754.25,1383334.,1358952.,1335300.375,1311943.25,1284277.5,1260316.375};
  //inletPlenum
  parameter SI.Density d_start_inletPlenum = 751.037;
  parameter SI.Pressure p_start_inletPlenum = 1.29207e+07;
  parameter SI.Temperature T_start_inletPlenum = 558.343;
  parameter SI.SpecificEnthalpy h_start_inletPlenum = 1.26043e+06;
  //outletPlenum
  parameter SI.Density d_start_outletPlenum = 658.335;
  parameter SI.Pressure p_start_outletPlenum = 1.28884e+07;
  parameter SI.Temperature T_start_outletPlenum = 597.874;
  parameter SI.SpecificEnthalpy h_start_outletPlenum = 1.48899e+06;
  //core.fuelModel.region_1
  parameter Real Ts_start_core_fuelModel_region_1[:,:] = {{833.46563721,844.07550049,853.94927979,862.88238525},{794.86474609,805.08477783,814.59460449,823.19750977},{687.40283203,696.56268311,705.08319092,712.78900146}};
  //core.fuelModel.region_2
  parameter Real Ts_start_core_fuelModel_region_2[:,:] = {{687.40283203,696.56268311,705.08319092,712.78900146},{647.13977051,656.53381348,665.26824951,673.16430664},{606.20654297,615.85943604,624.82983398,632.93554688}};
  //core.fuelModel.region_3
  parameter Real Ts_start_core_fuelModel_region_3[:,:] = {{606.20654297,615.85943604,624.82983398,632.93554688},{602.0279541,611.70294189,620.69366455,628.81744385},{598.11029053,607.80609131,616.81585693,624.95678711}};
  //STHX.tubeWall
  parameter SI.Temperature T_start_STHX_tubeWall[:,:] = {{526.4765625,526.28808594,537.38659668,541.44897461,544.92095947,548.05151367,550.99615479,553.85308838,572.65716553,586.29663086},{536.44354248,537.79101562,547.02868652,551.18432617,554.93139648,558.46380615,561.90209961,565.32196045,579.52258301,589.61157227}};
  //pressurizer
  parameter SI.Pressure p_start_pressurizer = 1.28109e+07;
  parameter SI.Length level_start_pressurizer = 1.18567;
  parameter SI.SpecificEnthalpy h_start_pressurizer = 1.47822e+06;
  //pressurizer_tee
  parameter SI.Density d_start_pressurizer_tee = 658.202;
  parameter SI.Pressure p_start_pressurizer_tee = 1.28109e+07;
  parameter SI.Temperature T_start_pressurizer_tee = 597.826;
  parameter SI.SpecificEnthalpy h_start_pressurizer_tee = 1.48888e+06;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                  Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="GenericModule")}),                         Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DataInitial;

  model Data_GenericModule_SMR

    extends GenericModular_PWR.BaseClasses.Record_Data;

    import TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;

    // Source 1 (s1):
    // Systems Summary of a Westinghouse Pressurized Water Reactor Nuclear Power Plant
    // 1984, Westinghouse Electric Corporation
    // http://www4.ncsu.edu/~doster/NE405/Manuals/PWR_Manual.pdf

    // Data from Source 1 (d*s1): 4-Loop basis
    // (d1s1) = Table 1-1 (pg. 3): Principal data for current Westinghouse NSSS Models
    // (d2s1) = Table 2-1 (pg. 14): Typical reactor core parameters (4-Loop Plant)
    // (d3s1) = Table 2-2 (pg. 19): Fuel rod parameters
    // (d4s1) = Table 3.1-1 (pg. --): Fuel rod parameters

    //Source 2: https://aris.iaea.org/PDF/NuScale.pdf

    //Source 3: https://doi.org/10.1016/j.desal.2014.02.023

    package Medium = Modelica.Media.Water.StandardWater;
    parameter Real nModules=12;

    //per module
    parameter SI.Power Q_total=160e6 "Total thermal output";
    parameter SI.Power Q_total_el=45e6 "Total electrical output";
    parameter Real eta=Q_total_el/Q_total "Net efficiency";

    parameter SI.Pressure p=12.76e6;
    parameter SI.Temperature T_hot=325 + 273.15 "estimate";
    parameter SI.Temperature T_cold=Medium.temperature_ph(p, h_cold);
    parameter SI.Temperature T_avg=0.5*(T_hot+T_cold);
    parameter SI.TemperatureDifference dT_core=T_hot - T_cold;
    parameter SI.SpecificEnthalpy h_hot=Medium.specificEnthalpy_pT(p, T_hot);
    parameter SI.SpecificEnthalpy h_cold=h_hot - Q_total/m_flow;
    parameter SI.MassFlowRate m_flow=700 "rough estimate from normalizing IRIS and rounded down";

    parameter SI.Length d_reactorVessel_outer=2.75;
    parameter SI.Length length_reactorVessel=20;

    parameter SI.Length length_inletPlenum=2;
    parameter SI.Length d_inletPlenum=d_reactorVessel_outer;

    parameter SI.Length length_core=2.408 "meters (based on 1.33 H/D ratio)";
    parameter SI.Length d_core=1.5;
    parameter String Material_fuel="Uranium Oxide" "Fuel pellet material";
    parameter String Material_cladding="Zircaloy-4" "Cladding material";
    parameter SI.Length r_outer_fuelRod=0.5*from_in(0.360) "Outside diameter of fuel rod (d3s1)";
    parameter SI.Length th_clad_fuelRod=from_in(0.0225) "Cladding thickness of fuel rod (d3s1)";
    parameter SI.Length th_gap_fuelRod=0.5*from_in(0.0062) "Gap thickness between pellet and cladding (d3s1)";
    parameter SI.Length r_pellet_fuelRod=0.5*from_in(0.3088) "Pellet radius (d3s1)";
    parameter SI.Length pitch_fuelRod=from_in(0.496) "Fuel rod pitch (d3s1)";
    parameter TRANSFORM.Units.NonDim sizeAssembly=17 "square size of assembly (e.g., 17 = 17x17)";
    parameter TRANSFORM.Units.NonDim nRodFuel_assembly=264 "# of fuel rods per assembly (d3s1)";
    parameter TRANSFORM.Units.NonDim nRodNonFuel_assembly=sizeAssembly^2 - 264 "# of non-fuel rods per assembly (d3s1)";
    parameter TRANSFORM.Units.NonDim nAssembly=floor(Modelica.Constants.pi*d_core^2/4/(pitch_fuelRod*sizeAssembly)^2);

    parameter SI.Length length_outletPlenum=3;
    parameter SI.Length d_outletPlenum=2;

    parameter SI.Length length_hotLeg=10.092;
    parameter SI.Length d_hotLeg=1.4;

    parameter SI.Length length_pressurizer=2.5;
    parameter SI.Length d_pressurizer=d_reactorVessel_outer;

    //Steam Generator Data
    //From Design Certification....

    parameter SI.Length length_steamGenerator=5.5;
    parameter SI.Length d_steamGenerator_tube_outer=from_in(0.625);
    parameter SI.Length th_steamGenerator_tube=from_in(0.05) "Sch 10/20";
    parameter SI.Length d_steamGenerator_tube_inner=d_steamGenerator_tube_outer - 2*th_steamGenerator_tube;
    parameter SI.Length d_steamGenerator_shell_inner=d_hotLeg;
    parameter SI.Length d_steamGenerator_shell_outer=d_reactorVessel_outer;
    // nTubes and length calculation should have reductions based on spacing of tubes
    parameter Real ratioPD_steamGenerator_tube=1.5 "pitch to diameter ratio";
    // nTubes and length are intertwined. This calculation assumes some number of entry tubes that then coil around the entire cavity between the reactor vessel and outlet plenum/hot leg space
    //parameter Real nPasses = 2;
    //parameter Real nEntryPoint_steamGenerator=128;
    //parameter Real nTubes_steamGenerator_perEntryPoint=floor(0.5*(d_steamGenerator_shell_outer - d_steamGenerator_shell_inner)/(d_steamGenerator_tube_outer*ratioPD_steamGenerator_tube));
    //parameter Real nTubes_steamGenerator=nEntryPoint_steamGenerator*nTubes_steamGenerator_perEntryPoint/nPasses;

    parameter Real nTubes_steamGenerator=1380;
    parameter SI.Area Area_heat_transfer = 2*1665.56 "meters squared, according to table 5.4-2 in design cert its 17928ft^2 ;2 since there are 2 steam generators.";
    // For nEntryPoint approach, length is taken as circumference of the average diameter between vessel and plenum. The length is then a calculation of the number of times the tubes can go around with each entry point reducing the length"
    //parameter SI.Length length_steamGenerator_tube=Modelica.Constants.pi*0.5*(d_steamGenerator_shell_outer + d_steamGenerator_shell_inner)*floor(
    //     length_steamGenerator*nPasses/(nEntryPoint_steamGenerator*d_steamGenerator_tube_outer*ratioPD_steamGenerator_tube));

    parameter SI.Length length_steamGenerator_tube=Area_heat_transfer/(Modelica.Constants.pi*(d_steamGenerator_tube_outer-2*th_steamGenerator_tube)*nTubes_steamGenerator);

    //Modelica.Constants.pi*0.5*(d_steamGenerator_shell_outer + d_steamGenerator_shell_inner)*floor(
      //  length_steamGenerator*nPasses/(nEntryPoint_steamGenerator*d_steamGenerator_tube_outer*ratioPD_steamGenerator_tube));
    //Solution for max tubes, min length
    //parameter Real nTubes_steamGenerator= floor(Modelica.Constants.pi*(d_steamGenerator_shell_outer^2/4 - d_steamGenerator_shell_inner^2/4)/(Modelica.Constants.pi*d_steamGenerator_tube_outer^2/4)/nPasses) "for single pass (maximum nTubes)";
    //parameter Real length_steamGenerator_tube = length_steamGenerator*nPasses "for max nTubes";

    //End Steam Generator Area

    parameter SI.Length length_coldLeg=12;
    parameter SI.Length d_coldLeg_inner=d_outletPlenum;
    parameter SI.Length d_coldLeg_outer=d_reactorVessel_outer;
    parameter SI.Length d_coldLeg=4*Modelica.Constants.pi*(d_coldLeg_outer^2/4 - d_coldLeg_inner^2/4)/Modelica.Constants.pi/(d_coldLeg_outer + d_coldLeg_inner);

    final parameter SI.Length lengths[2]={length_inletPlenum + length_core + length_outletPlenum + length_hotLeg,length_steamGenerator + length_coldLeg};

    parameter SI.Pressure p_steam = 3.5e6;
    parameter SI.Temperature T_steam_hot = 300+273.15;
    parameter SI.Temperature T_steam_cold=200+273.15;
    parameter SI.SpecificEnthalpy h_steam_hot=Medium.specificEnthalpy_pT(p_steam, T_steam_hot);
    parameter SI.SpecificEnthalpy h_steam_cold=Medium.specificEnthalpy_pT(p_steam, T_steam_cold);
    parameter SI.MassFlowRate m_flow_steam = Q_total/(h_steam_hot-h_steam_cold);

  equation
    assert(abs(lengths[1] - lengths[2]) <= Modelica.Constants.eps, "Hot/cold leg lengths must be equal");
    assert(abs(length_reactorVessel - lengths[1] - length_pressurizer) <= Modelica.Constants.eps, "Hot leg and pressurizer must be equal to reactor vessel length");

    annotation (
      defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="GenericModule")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
</html>"));
  end Data_GenericModule_SMR;
end Data;
