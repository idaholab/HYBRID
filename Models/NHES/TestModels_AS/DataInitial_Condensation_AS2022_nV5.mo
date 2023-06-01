within NHES.TestModels_AS;
record DataInitial_Condensation_AS2022_nV5

  extends TRANSFORM.Icons.Record;

  //*********************************************************************
  // Commented things are not really needed
  //*********************************************************************

//STHX.tube
parameter SI.Density d_start_STHX_tube[:] = {0.55296,0.60576,0.67087,954.86,971.80};
parameter SI.Pressure p_start_STHX_tube[:] = {120000,120000,120000,120000,120000};
parameter SI.Temperature T_start_STHX_tube[:] = {473.15,433.15,393.15,377.93,353.15};
parameter SI.SpecificEnthalpy h_start_STHX_tube[:] = {2874500,2795100,2714600,1561230,419180};

//STHX.shell
parameter SI.Density d_start_STHX_shell[:] = {662.02679443,669.76708984,682.17218018,693.54766846,704.05200195};
parameter SI.Pressure p_start_STHX_shell[:] = {12810909,12816239,12819835,12823497,12827221};
parameter SI.Temperature T_start_STHX_shell[:] = {596.58215332,593.97235107,589.5078125,585.11022949,580.78710938};
parameter SI.SpecificEnthalpy h_start_STHX_shell[:] = {1480592.25,1463564.625,1435439.875,1408754.25,1383334};

//STHX.tubeWall
parameter SI.Temperature T_start_STHX_tubeWall[:,:] = {{526.4765625,526.28808594,537.38659668,541.44897461,544.92095947},{536.44354248,537.79101562,547.02868652,551.18432617,554.93139648}};

//core.coolantSubchannel
// parameter SI.Density d_start_core_coolantSubchannel[:] = {729.99456787,707.68652344,683.89465332,658.36236572};
// parameter SI.Pressure p_start_core_coolantSubchannel[:] = {12911367.,12907437.,12903607.,12899882.};
// parameter SI.Temperature T_start_core_coolantSubchannel[:] = {569.07678223,579.30987549,588.94995117,597.87921143};
// parameter SI.SpecificEnthalpy h_start_core_coolantSubchannel[:] = {1317572.25,1374710.125,1431848.125,1488985.875};
//
//hotLeg
// parameter SI.Density d_start_hotLeg[:] = {658.2980957,658.20166016};
// parameter SI.Pressure p_start_hotLeg[:] = {12861758.,12810911.};
// parameter SI.Temperature T_start_hotLeg[:] = {597.85516357,597.82647705};
// parameter SI.SpecificEnthalpy h_start_hotLeg[:] = {1488930.125,1488878.625};
//
//coldLeg
// parameter SI.Density d_start_coldLeg[:] = {751.05932617};
// parameter SI.Pressure p_start_coldLeg[:] = {12936737.};
// parameter SI.Temperature T_start_coldLeg[:] = {558.34472656};
// parameter SI.SpecificEnthalpy h_start_coldLeg[:] = {1260434.125};

//inletPlenum
// parameter SI.Density d_start_inletPlenum = 751.037;
// parameter SI.Pressure p_start_inletPlenum = 1.29207e+07;
// parameter SI.Temperature T_start_inletPlenum = 558.343;
// parameter SI.SpecificEnthalpy h_start_inletPlenum = 1.26043e+06;
//
//outletPlenum
// parameter SI.Density d_start_outletPlenum = 658.335;
// parameter SI.Pressure p_start_outletPlenum = 1.28884e+07;
// parameter SI.Temperature T_start_outletPlenum = 597.874;
// parameter SI.SpecificEnthalpy h_start_outletPlenum = 1.48899e+06;

//core.fuelModel.region_1
// parameter Real Ts_start_core_fuelModel_region_1[:,:] = {{833.46563721,844.07550049,853.94927979,862.88238525},{794.86474609,805.08477783,814.59460449,823.19750977},{687.40283203,696.56268311,705.08319092,712.78900146}};
//
//core.fuelModel.region_2
// parameter Real Ts_start_core_fuelModel_region_2[:,:] = {{687.40283203,696.56268311,705.08319092,712.78900146},{647.13977051,656.53381348,665.26824951,673.16430664},{606.20654297,615.85943604,624.82983398,632.93554688}};
//
//core.fuelModel.region_3
// parameter Real Ts_start_core_fuelModel_region_3[:,:] = {{606.20654297,615.85943604,624.82983398,632.93554688},{602.0279541,611.70294189,620.69366455,628.81744385},{598.11029053,607.80609131,616.81585693,624.95678711}};

//pressurizer
// parameter SI.Pressure p_start_pressurizer = 1.28109e+07;
// parameter SI.Length level_start_pressurizer = 1.18567;
// parameter SI.SpecificEnthalpy h_start_pressurizer = 1.47822e+06;
//
//pressurizer_tee
// parameter SI.Density d_start_pressurizer_tee = 658.202;
// parameter SI.Pressure p_start_pressurizer_tee = 1.28109e+07;
// parameter SI.Temperature T_start_pressurizer_tee = 597.826;
// parameter SI.SpecificEnthalpy h_start_pressurizer_tee = 1.48888e+06;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="GenericModule")}),                         Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DataInitial_Condensation_AS2022_nV5;
