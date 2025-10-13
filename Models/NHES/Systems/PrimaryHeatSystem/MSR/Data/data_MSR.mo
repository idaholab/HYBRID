within NHES.Systems.PrimaryHeatSystem.MSR.Data;
model data_MSR

  extends
    NHES.Systems.PrimaryHeatSystem.MSR.BaseClasses.Record_Data;
  //Piping
  import TRANSFORM.Units.Conversions.Functions.VolumeFlowRate_m3_s.from_gpm;
  import from_feet =
         TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft;
  import from_inch =
         TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;
  //Pump
//  import TRANSFORM.Units.Conversions.Functions.VolumeFlowRate_m3_s.from_gpm;
//  import from_feet =TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft;
//  import from_inch =TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;
  //PHX
  import TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degF;
  import TRANSFORM.Units.Conversions.Functions.MassFlowRate_kg_s.from_lbm_hr;
  import TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_psi;
  //RCTR
  import from_inch2 = TRANSFORM.Units.Conversions.Functions.Area_m2.from_in2;
  import Modelica.Constants.pi;

  //Piping
  // Assume distance for all looops is the same. Assume out of allignmnent is negligble and ignore elbows
  // Pump is at same elevation as PHX
  parameter Modelica.Units.SI.Length length_pumpToPHX=from_inch(240) "Distance from pump outlet to PHX inlet" annotation(dialog(tab = "Piping", group = "Piping"));
   parameter Modelica.Units.SI.Length length_PHXToRCTR=from_inch(684) "Distance from PHX outlet to inlet reactor tee" annotation(dialog(tab = "Piping", group = "Piping"));
  parameter Modelica.Units.SI.Length height_pumpToPHX=0 "Elevation difference (pump - PHX)" annotation(dialog(tab = "Piping", group = "Piping"));
  parameter Modelica.Units.SI.Length height_PHXToRCTR=from_inch(324) "Elevation difference (PHX - RCTR)" annotation(dialog(tab = "Piping", group = "Piping"));
  parameter Modelica.Units.SI.Length D_PFL=from_inch(12) "Diameter of PFL piping" annotation(dialog(tab = "Piping", group = "Piping"));
  // Distances in primary coolant loop are taken as rough guesses based on the assumption
  // that the steam generator/SHX are in the same building as the PHX as in the MSBR. Very rough guesses.
  parameter Modelica.Units.SI.Length length_pumpToSHX=from_inch(96) "Distance from pump outlet to SHX inlet" annotation(dialog(tab = "Piping", group = "Piping"));
  parameter Modelica.Units.SI.Length length_SHXToPHX=from_inch(252) "Distance from SHX outlet to PHX inlet" annotation(dialog(tab = "Piping", group = "Piping"));
  parameter Modelica.Units.SI.Length length_PHXsToPump=from_inch(180) "Distance from PHX shell outlet to PCL pump" annotation(dialog(tab = "Piping", group = "Piping"));
  parameter Modelica.Units.SI.Length height_pumpToSHX=-from_inch(45) "Elevation difference (SHX - pump)" annotation(dialog(tab = "Piping", group = "Piping"));
  parameter Modelica.Units.SI.Length height_SHXToPHX=-from_inch(83) "Elevation difference (PHX - SHX)" annotation(dialog(tab = "Piping", group = "Piping"));
  parameter Modelica.Units.SI.Length height_PHXsToPump=from_inch(42) "Elevation difference (SHX - PHX)" annotation(dialog(tab = "Piping", group = "Piping"));
  parameter Modelica.Units.SI.Length D_PCL=from_inch(12) "Diameter of PCL piping" annotation(dialog(tab = "Piping", group = "Piping"));
  //Pump
  parameter Modelica.Units.SI.VolumeFlowRate capacity_P=from_gpm(8100) "Capacity of primary pump" annotation(dialog(tab = "Pump"));
  parameter Modelica.Units.SI.Height head_P=from_feet(150) "Head at capacity of primary pump" annotation(dialog(tab = "Pump"));
  parameter Real bypass_P = 0.1 "%Fraction of nominal flow bypassed from pump outlet to inlet to purge offgas" annotation(dialog(tab = "Pump"));
  // Assume secondary pumps are the same as primary pumps.
  //PHX
  parameter Real nHX_total = 6 "Total # of HXs" annotation(dialog(tab = "PHX"));
parameter Real nParallel = 3 "# of parallel HX loops" annotation(dialog(tab = "PHX"));
parameter Real nHX_loop = nHX_total/nParallel "# of HXs per loop" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Power Qt_capacity=125e6 "Nominal capacity per HX" annotation(dialog(tab = "PHX"));
  parameter String Material = "Alloy-N" "HX material" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Temperature T_inlet_tube=from_degF(1250) "Inlet temperature" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Temperature T_outlet_tube=from_degF(1050) "Outlet temperature" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Temperature T_inlet_shell=from_degF(900) "Inlet temperature" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Temperature T_outlet_shell=from_degF(1100) "Outlet temperature" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.PressureDifference dp_tube=from_psi(127) "Pressure drop" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Pressure p_inlet_tube=from_psi(180) "Inlet pressure" annotation(dialog(tab = "PHX"));
                                                                     //taken from MSBR
  parameter Modelica.Units.SI.Pressure p_outlet_tube=p_inlet_tube - dp_tube "Outlet pressure" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.PressureDifference dp_shell=from_psi(115) "Pressure drop" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Pressure p_inlet_shell=from_psi(149) "Inlet pressure" annotation(dialog(tab = "PHX"));                                                 //taken from MSBR
  parameter Modelica.Units.SI.Pressure p_outlet_shell=p_inlet_shell - dp_shell "Outlet pressure" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_tube=from_lbm_hr(6.6e6) "Mass flow rate per HX" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_shell=from_lbm_hr(3.7e6) "Mass flow rate per HX" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Length th_tube=from_inch(0.035) "Tube thickness" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Length D_tube_outer=from_inch(0.375)  "Tube outer diameter" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Length D_tube_inner=D_tube_outer - 2*th_tube "Tube inner diameter" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Length th_shell=from_inch(0.5) "Shell thickness" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Length D_shell_inner=from_inch(26.32) "Shell inner diameter" annotation(dialog(tab = "PHX"));
  parameter Real nTubes = 1368 "# of tubes" annotation(dialog(tab = "PHX"));
  parameter String pitchType = "Triangular" "Tube pitch type" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Length pitch_tube=from_inch(0.672) "Tube pitch" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Length length_tube=from_inch(30*12) "Tubesheet to tubesheet distance" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Area surfaceArea_tubeouter=D_tube_outer*Modelica.Constants.pi*length_tube*nTubes "Surface area outer tube basis" annotation(dialog(tab = "PHX"));                                                   //TRANSFORM.Units.Conversions.Functions.Area_m2.from_feet2(4024);
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U=TRANSFORM.Units.Conversions.Functions.CoefficientOfHeatTransfer_W_m2K.from_btu_hrft2degF(700) annotation(dialog(tab = "PHX"));
      parameter Real nBaffles = 47 "# of baffles" annotation(dialog(tab = "PHX"));
parameter String baffleType="Disk and Dougnut" "Baffle type" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Length spacing_baffle=from_inch(7.7) "Distance between baffles" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Length D_diskBaffle=from_inch(19) "Outer diameter of disk type baffle" annotation(dialog(tab = "PHX"));
  parameter Modelica.Units.SI.Length D_doughnutBaffle=from_inch(18.6) "Inner diameter of doughnut type baffle" annotation(dialog(tab = "PHX"));
  //SHX
  parameter Real nHX_total_SHX = 6 "Total # of HXs" annotation(dialog(tab = "SHX"));
  parameter Real nParallel_SHX = 3 "# of parallel HX loops" annotation(dialog(tab = "SHX"));
parameter Real nHX_loop_SHX = nHX_total/nParallel "# of HXs per loop" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Power Qt_capacity_SHX=125e6 "Nominal capacity per HX" annotation(dialog(tab = "SHX"));
  parameter String Material_SHX = "Alloy-N" "HX material" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Temperature T_inlet_tube_SHX=from_degF(800) "Inlet temperature" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Temperature T_outlet_tube_SHX=from_degF(1050) "Outlet temperature" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Temperature T_inlet_shell_SHX=from_degF(1100) "Inlet temperature" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Temperature T_outlet_shell_SHX=from_degF(900) "Outlet temperature" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.PressureDifference dp_tube_SHX=from_psi(152) "Pressure drop" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Pressure p_inlet_tube_SHX=from_psi(3752) "Inlet pressure" annotation(dialog(tab = "SHX"));                                                 //from MSBR
  parameter Modelica.Units.SI.Pressure p_outlet_tube_SHX=p_inlet_tube - dp_tube "Outlet pressure" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.PressureDifference dp_shell_SHX=from_psi(115) "Pressure drop" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Pressure p_inlet_shell_SHX=from_psi(264) "Inlet pressure" annotation(dialog(tab = "SHX"));                                                 //slightly higher than MSBR (233)
  parameter Modelica.Units.SI.Pressure p_outlet_shell_SHX=p_inlet_shell - dp_shell "Outlet pressure" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_tube_SHX=from_lbm_hr(1.79e6) "Mass flow rate per HX" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_shell_SHX=from_lbm_hr(3.7e6) "Mass flow rate per HX" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Length th_tube_SHX=from_inch(0.035) "Tube thickness" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Length D_tube_outer_SHX=from_inch(0.375) "Tube outer diameter" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Length D_tube_inner_SHX=D_tube_outer - 2*th_tube "Tube inner diameter" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Length th_shell_SHX=from_inch(0.5) "Shell thickness" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Length D_shell_inner_SHX=from_inch(30.5) "Shell inner diameter" annotation(dialog(tab = "SHX"));
  parameter Real nTubes_SHX = 1604 "# of tubes" annotation(dialog(tab = "SHX"));
parameter String pitchType_SHX = "Triangular" "Tube pitch type" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Length pitch_tube_SHX=from_inch(0.7188) "Tube pitch" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Length length_tube_SHX=from_inch(37.5*12) "Tubesheet to tubesheet distance" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Area surfaceArea_tubeouter_SHX=D_tube_outer*Modelica.Constants.pi*length_tube*nTubes "Surface area outer tube basis" annotation(dialog(tab = "SHX"));                                                   //TRANSFORM.Units.Conversions.Functions.Area_m2.from_feet2(5904);
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_SHX=TRANSFORM.Units.Conversions.Functions.CoefficientOfHeatTransfer_W_m2K.from_btu_hrft2degF(500) annotation(dialog(tab = "SHX"));
  parameter Real nBaffles_SHX = 52 "# of baffles" annotation(dialog(tab = "SHX"));
parameter String baffleType_SHX="Disk and Dougnut" "Baffle type" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Length spacing_baffle_SHX=from_inch(8.6) "Distance between baffles" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Length D_diskBaffle_SHX=from_inch(22) "Outer diameter of disk type baffle" annotation(dialog(tab = "SHX"));
  parameter Modelica.Units.SI.Length D_doughnutBaffle_SHX=from_inch(21.6) "Inner diameter of doughnut type baffle" annotation(dialog(tab = "SHX"));
  //RCTR
   parameter Modelica.Units.SI.Power Q_nominal=750e6 "Nominal power of reactor" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Power Q_nominal_fuelcell=Q_nominal/nFcells "Approximate nominal power output per fuel cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Temperature T_inlet_core=from_degF(1050) "Inlet core temperature" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Temperature T_outlet_core=from_degF(1250) "Outlet core temperature" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cp=TRANSFORM.Media.Fluids.FLiBe.Utilities_12Th_05U.cp_T(0.5*(T_inlet_core +T_outlet_core)) "Heat capacity of PFL fluid" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.TemperatureDifference dT_core=Q_nominal/(m_flow*cp) "Expected temperature difference across core" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Velocity vs_reflA_core=TRANSFORM.Units.Conversions.Functions.Velocity_m_s.from_ft_s(7) "Velocity of fueled and control rod cells region in top axial reflector" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Velocity vs_reflA_reflR=TRANSFORM.Units.Conversions.Functions.Velocity_m_s.from_ft_s(1) "Velocity of radial reflector region in top axial reflector" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.MassFlowRate m_flow=from_lbm_hr(6*6.6e6) "Total mass flow rate through reactor" annotation(dialog(tab = "Reactor"));
  parameter Real nFcells = 357 "# of normal fueled cells" annotation(dialog(tab = "Reactor"));
  parameter Real nCRcells = 6 "# of control rod cells" annotation(dialog(tab = "Reactor"));
  parameter Real nCells = nFcells + nCRcells "# of core cells total" annotation(dialog(tab = "Reactor"));
  parameter Integer nIntG_A = 2 "# of internal graphite-A per cell" annotation(dialog(tab = "Reactor"));
  parameter Integer nIntG_B = 3 "# of internal graphite-B per cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length perimeter_intG_A=from_inch(21.7354) "Internal graphite-A perimeter" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length perimeter_intG_B=from_inch(21.8234) "Internal graphite-A perimeter" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_intG_A=from_inch2(16.4265) "Internal graphite-A cross-sectional area" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_intG_B=from_inch2(16.4622) "Internal graphite-A cross-sectional area" annotation(dialog(tab = "Reactor"));
  parameter Integer nSpacer = 28 "# of spacers per cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length diameter_spacer=from_inch(0.142) "Spacer diameter" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_spacer=0.25*pi*diameter_spacer^2 "Spacer cross-sectional area" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length perimeter_inner_empty=from_inch(36.0108 + 8*pi*1.5*(18.02/360)) "perimeter of empty inner cell region" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_inner_empty=from_inch2(93.2048) "crossArea of empty inner cell region" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_extG=from_inch2(11.43^2) - crossArea_inner_empty "Cross area of external graphite box per cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_outer_empty=from_inch2(7.952) "Cross-sectional flow area of outer region of a non-repeated graphite box (approximated from CAD)" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_extG_whole=from_inch2(14.343^2) - crossArea_outer_empty - crossArea_inner_empty "Cross area of external graphite box whole box (calculated from CAD) - i.e., little extra bit between fuel cells and inner radial reflector" annotation(dialog(tab = "Reactor"));
  parameter Integer nfG = 5+2 "# of characteristic graphite slabs in fueled cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length length_fG=crossArea_fG/(nfG*width_fG) "Characteric length of graphite slabs in fueled cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length width_fG=from_inch(1.763) "Characteric width of graphite slabs in fueled cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_fG=crossArea_extG + nIntG_A*crossArea_intG_A + nIntG_B*crossArea_intG_B "Cross-sectional area of graphite per fueled cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length perimeter_f=perimeter_inner_empty + nIntG_A*perimeter_intG_A + nIntG_B*perimeter_intG_B + nSpacer*pi*diameter_spacer "Wetted perimeter of fueled cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_f=crossArea_inner_empty - nIntG_A*crossArea_intG_A - nIntG_B*crossArea_intG_B - nSpacer*crossArea_spacer "Cross-sectional flow area of fueled cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length perimeter_crG_inner=from_inch(36.8873 + pi*7.0) "Wetted perimeter of control rod cell inner graphite" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_crG_inner=from_inch2(87.8893) - 0.25*pi*from_inch(7.0)^2 "Cross-sectional area of control rod cell inner graphite" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_crG=crossArea_extG + crossArea_crG_inner "Cross-sectional area of control rod cell graphite" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length perimeter_cr=perimeter_inner_empty + perimeter_crG_inner "Wetted perimeter of control rod cell (no control rod)" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_cr=crossArea_inner_empty - crossArea_crG_inner "Cross-sectional flow area of control rod cell (no control rod)" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length perimeter_crRod=from_inch(4*(2*2.375 + pi*0.375 + 0.5*pi*0.125)) "Wetted perimeter of control rod" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_crRod=from_inch2(4*(0.5*pi*0.375^2 + 2.375*0.75 + 0.25*(1.0 - pi*0.125^2))) "Cross-sectional area of control rod" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length perimeter_crRod_inner=from_inch(4*(2*2.375 + pi*0.25 + 0.5*pi*0.25)) "Alloy-N - Boron carbide interface perimeter of control rod" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_crRod_BC=from_inch2(4*(0.5*pi*0.25^2 + 2.375*0.5 + 0.25*(1.0 - pi*0.25^2))) "Cross-sectional area of Boron carbide in control rod" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Area crossArea_crRod_alloyN=crossArea_crRod - crossArea_crRod_BC "Cross-sectional area of alloy-N in control rod" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length length_cells=from_feet(21) "Length of cells (fueled and control rod)" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length length_crRod=length_cells - from_feet(3) "Length of control rods" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Volume volume_fG=crossArea_fG*length_cells "Volume of graphite per fueled cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Volume volume_f=crossArea_f*length_cells "Volume of fluid per fueled cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Volume volume_crG=crossArea_crG*length_cells "Volume of graphite per control rod cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Volume volume_cr=crossArea_cr*length_cells "Volume of fluid per control rod cell" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Volume volume_crRod=crossArea_crRod*length_crRod "Volume of each control rod" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Volume volume_crRod_BC=crossArea_crRod_BC*length_crRod "Volume of boron carbide per control rod" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Volume volume_crRod_alloyN=crossArea_crRod_alloyN*length_crRod "Volume of alloy-N per control rod" annotation(dialog(tab = "Reactor"));

  // Axial graphite reflector
  parameter Integer nRegions = 8 "Number of identiical radial reflector regions" annotation(dialog(tab = "Reactor"));
  parameter Modelica.Units.SI.Length perimeter_reflR_inner=from_inch(8*(2*12 + 2*24) + 2*(1.33 + 25.977 + 11.271 + 24)) "Wetted perimeter of inner radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Area crossArea_reflR_innerG=from_inch2(8*(12*24) + 2*(151.208)) "Cross-sectional area of the inner graphite radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  // This is normal gaps + the outer layer of fuel cells box fluid gap of which there are 5.25 cells per graphite region with 1/4 of the flow area present
  parameter Modelica.Units.SI.Area crossArea_reflR_inner=from_inch2(2641.35) - crossArea_reflR_innerG + 5.25*0.25*crossArea_outer_empty "Cross-sectional flow area around the inner graphite radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length perimeter_reflR_outer=from_inch(2*59.9877 + 156.727*45*pi/180) "Wetted perimeter of outer radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Area crossArea_reflR_outerG=from_inch2(0.5*156.727^2*45*pi/180 - 0.5*119.843*156.727*cos(45*pi/180/2)) + from_inch2(11.1156) "Cross-sectional area of the outer graphite radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Area crossArea_reflR_outer=from_inch2(0.5*156.789^2*45*pi/180 - 0.5*120.001*156.789*cos(45*pi/180/2)) + from_inch2(25.2654) - crossArea_reflR_outerG "Cross-sectional flow area around the outer graphite radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Area crossArea_reflR=crossArea_reflR_inner + crossArea_reflR_outer "Total cross-sectional flow area of axial graphite reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length perimeter_reflR=perimeter_reflR_inner + perimeter_reflR_outer "Total wetted perimeter of axial graphite reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length length_reflR_inner=from_feet(21) "Length of inner reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length length_reflR_outer=from_feet(21) "Length of outer reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length length_reflR=0.5*(length_reflR_inner + length_reflR_outer) "Characteristic length of radial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volume_reflR_innerG=crossArea_reflR_innerG*length_reflR_inner "Volume of graphite in inner radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volume_reflR_inner=crossArea_reflR_inner*length_reflR_inner "Volume of fluid in inner radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volume_reflR_outerG=crossArea_reflR_outerG*length_reflR_outer "Volume of graphite in outer radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volume_reflR_outer=crossArea_reflR_outer*length_reflR_outer "Volume of fluid in outer radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volume_reflR_G=volume_reflR_innerG + volume_reflR_outerG "Total volume of graphite in radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volume_reflR=volume_reflR_inner + volume_reflR_outer "Total volume of fluid in radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length length_reflR_blockG=from_inch(24) "length of reflR block" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length width_reflR_blockG=from_inch(12) "width of reflR block" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volume_reflR_blockG=length_reflR_blockG*width_reflR_blockG*length_reflR "Volume of characteristic radial reflector block" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Real n_reflR_blockG = volume_reflR_G/volume_reflR_blockG "# of characteristic blocks of graphite in radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));

  // Now calculate the axial reflectors
  parameter Integer nAs = 2 "# of axial reflectors" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Integer nARs = 13 "# of axial reflector rings" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length length_reflA=from_inch(48) "Vertical length of each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length length_reflA_edge=from_inch(42) "Vertical length to start edge of each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length radius_reflA=from_inch(311/2) "Radius of each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length radius_reflA_edge=from_inch(156/2) "Radius to start edge of each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length length_reflA_ring_cell=radius_reflA/nARs "Length of ring unit cell" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length width_reflA_channel[nARs + 1]=from_inch({0.14,0.14,0.22,0.25,0.24,0.24,0.22,0.20,0.16,0.16,0.11,0.07,0.03,0.02}) "Width of channels between axial reflector blocks" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));                                                                                                                                    //[1] is the diameter assumed of the center whole
  parameter Modelica.Units.SI.Length length_reflA_ring[nARs]=from_inch({48,48,48,48,48,48,48,42,36,30,24,18,12}) "Vertical length of each axial reflector ring"
                                                                                                                                                               annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Integer nGaps[nARs] = {0,3,4,8,8,12,12,12,12,12,12,12,12} "# of gaps in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volume_reflA_reg=pi*radius_reflA_edge^2*(length_reflA_edge) + 0.5*pi*length_reflA_edge*(radius_reflA^2 - radius_reflA_edge^2) + pi*radius_reflA^2*(length_reflA - length_reflA_edge) "Volume of each axial reflector region (no fuel channels) - approximate for checking" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));

  //parameter SI.Area crossArea_reflA_reg_avg = volume_reflA_reg/length_reflA "Cross-sectional area (avg) of each axial reflector region (no fuel channels)";
  parameter Modelica.Units.SI.Length rs_ring_cell[nARs + 1]=cat(
      1,
      {0},
      {rs_ring_cell[i - 1] + length_reflA_ring_cell for i in 2:nARs + 1}) "Radial position of axial reflector ring unit cells" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length rs_ring_edge_inner[nARs]={rs_ring_cell[i] + 0.5*width_reflA_channel[i] for i in 1:nARs} "Radial position of the inner edge of each axial reflector graphite ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length rs_ring_edge_outer[nARs]={rs_ring_cell[i + 1] - 0.5*width_reflA_channel[i + 1] for i in 1:nARs} "Radial position of the outer edge of each axial reflector graphite ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length rs_ring_edge[2*nARs]={if rem(i, 2) == 0 then rs_ring_edge_outer[integer(i/2)] else rs_ring_edge_inner[integer((i + 1)/2)] for i in 1:2*nARs} "Radial position of each graphite ring edge" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length width_reflA_blocks[nARs]={rs_ring_edge_outer[i] - rs_ring_edge_inner[i] for i in 1:nARs} "Width of graphite blocks in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length perimeters_reflA_ring[nARs]={2*pi*rs_ring_edge_inner[i] - nGaps[i]*width_reflA_channel[i + 1] + 2*nGaps[i]*width_reflA_blocks[i] + 2*pi*rs_ring_edge_outer[i] - nGaps[i]*width_reflA_channel[i + 1] for i in 1:nARs} "Wetted perimeter of graphite for each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Area crossAreas_reflA_ring_radial[nARs]={if i == 1 then rs_ring_edge[i]^2*pi else pi*(rs_ring_edge[integer(2*i - 1)]^2 - rs_ring_edge[integer(2*(i - 1))]^2) for i in 1:nARs} " Cross-sectional flow area(excluding gaps in ring) of each ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Area crossAreas_reflA_ring_gaps[nARs]={nGaps[i]*width_reflA_blocks[i]*width_reflA_channel[i + 1] for i in 1:nARs} "Cross-sectional flow area of gaps within each ring each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Area crossAreas_reflA_ring[nARs]=crossAreas_reflA_ring_gaps + crossAreas_reflA_ring_radial "Cross-sectional flow area in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Area crossAreas_reflA_ringG[nARs]={(rs_ring_edge_outer[i]^2 - rs_ring_edge_inner[i]^2)*pi - crossAreas_reflA_ring_gaps[i] for i in 1:nARs} "Cross-sectional area of graphite in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Area crossArea_reflA_ring=sum(crossAreas_reflA_ring) "Total cross-sectional flow area in each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Area crossArea_reflA_ringG=sum(crossAreas_reflA_ringG) "Total cross-sectional area of graphite in each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Length perimeter_reflA_ring=sum(perimeters_reflA_ring) "Total wetted perimeter of graphite in each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Real n_reflA_ringG = volume_reflA_ringG/(length_reflA*crossAreas_reflA_ringG[6]/nGaps[6]) "# of characteristic graphite pieces in ring - assumed based on ring 6" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Angle angle_reflA_ring_blockG=Modelica.Units.Conversions.from_deg(29.8085) "Angle to conserve volume of graphite (removes small spacing between graphite blocks within ring)" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volumes_reflA_ring[nARs]=crossAreas_reflA_ring .* length_reflA_ring "Volume of fluid in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volumes_reflA_ringG[nARs]=crossAreas_reflA_ringG .* length_reflA_ring "Volume of graphite in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volume_reflA_ring=sum(volumes_reflA_ring) "Total volume of fluid in each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
  parameter Modelica.Units.SI.Volume volume_reflA_ringG=sum(volumes_reflA_ringG) "Total volume of graphite in each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));

  // Plenum
  parameter Modelica.Units.SI.Area crossArea_plenum=from_inch2(0.25*pi*156^2) "Cross-sectional area of each plenum" annotation(dialog(tab = "Reactor", group = "Plenum"));
  parameter Modelica.Units.SI.Length length_plenum=from_inch(18) "Vertical length of each plenum, assume whole cylinder" annotation(dialog(tab = "Reactor", group = "Plenum"));
  parameter Modelica.Units.SI.Volume volume_plenum=crossArea_plenum*length_plenum "Approximate volume of each plenum" annotation(dialog(tab = "Reactor", group = "Plenum"));

  // Reactor Inlet Tee
  parameter Modelica.Units.SI.Area crossArea_tee_inlet=from_inch2(0.25*pi*28^2) "Cross-sectional area of the inlet tee" annotation(dialog(tab = "Reactor", group = "Reactor Inlet Tee"));
  parameter Modelica.Units.SI.Length length_tee_inlet=from_inch(42) "Vertical length of the inlet tee" annotation(dialog(tab = "Reactor", group = "Reactor Inlet Tee"));
  parameter Modelica.Units.SI.Volume volume_tee_inlet=crossArea_tee_inlet*length_tee_inlet "Volume of the inlet tee" annotation(dialog(tab = "Reactor", group = "Reactor Inlet Tee"));
  parameter Modelica.Units.SI.Length diameter_tee_pipe=from_inch(12) "Diameter of pipe into the inlet tee" annotation(dialog(tab = "Reactor", group = "Reactor Inlet Tee"));
  parameter Modelica.Units.SI.Length diameter_pipe_draintank=from_inch(6) "Diameter of pipe between the inlet tee and drain tank" annotation(dialog(tab = "Reactor", group = "Reactor Inlet Tee"));

  // Reactor/Pump Overflow line
  parameter Modelica.Units.SI.Area crossArea_tee_overflow=from_inch2(0.25*pi*18^2) "Cross-sectional area of the pump overflow that enters the top of the reactor" annotation(dialog(tab = "Reactor", group = "Reactor/Pump Overflow Line"));
  parameter Modelica.Units.SI.Length length_tee_overflow=from_inch(24) "Vertical length of the pump overflow" annotation(dialog(tab = "Reactor", group = "Reactor/Pump Overflow Line"));
  parameter Modelica.Units.SI.Volume volume_tee_overflow=crossArea_tee_overflow*length_tee_overflow "Volume of the pump overflow" annotation(dialog(tab = "Reactor", group = "Reactor/Pump Overflow Line"));
  parameter Modelica.Units.SI.Length diameter_pipe_overflow=from_inch(6) "Diameter of pump overflow pipe" annotation(dialog(tab = "Reactor", group = "Reactor/Pump Overflow Line"));

  // Pipe to drain tank
  parameter Modelica.Units.SI.Length diameter_pumpPipe_inlet=from_inch(17) "Diameter of pipe leaving reactor and entering pump" annotation(dialog(tab = "Reactor", group = "Pipe to Drain Tank"));

  // Reactor Vessel
  parameter String Material_rtr_wall = "Alloy-N" "Material of reactor vessel" annotation(dialog(tab = "Reactor", group = "Reactor Vessel"));
  parameter Modelica.Units.SI.Length th_rtr_wall=from_inch(2) "Thickness of reactor vessel wall" annotation(dialog(tab = "Reactor", group = "Reactor Vessel"));
  parameter Modelica.Units.SI.Length radius_rtr_outer=from_inch(318/2) "Outer radius of reactor vessel" annotation(dialog(tab = "Reactor", group = "Reactor Vessel"));

  // Pump
  parameter Modelica.Units.SI.Length D_pumpbowl=from_inch(48) "Diameter of pump bowl - guess" annotation(dialog(tab = "Reactor", group = "Pump"));
  parameter Modelica.Units.SI.Length length_pumpbowl=from_inch(48) "Vertical height of pumpbowl" annotation(dialog(tab = "Reactor", group = "Pump"));
  parameter Modelica.Units.SI.Area crossArea_pumpbowl=0.25*pi*D_pumpbowl^2 "Cross-sectional area of pumpbowl" annotation(dialog(tab = "Reactor", group = "Pump"));
  parameter Modelica.Units.SI.Volume volume_pumpbowl=crossArea_pumpbowl*length_pumpbowl "Total pumpbowl volume" annotation(dialog(tab = "Reactor", group = "Pump"));
  parameter Modelica.Units.SI.Length level_pumpbowlnominal=from_inch(24) "Nominal level of fluid in pumpbowl" annotation(dialog(tab = "Reactor", group = "Pump"));
  parameter Modelica.Units.SI.Volume volume_pumpbowlnominal=crossArea_pumpbowl*level_pumpbowlnominal "Nominal fluid volume of pumpbowl" annotation(dialog(tab = "Reactor", group = "Pump"));
  // what is the length to use to for axial reflector?

  annotation (Documentation(info="<html>
<p>Data package for the PrimaryFuelLoop and PrimaryCoolantLoop models</p>
<p>Contact: Sarah Creasman sarah.creasman@inl.gov</p>
<p>Documentation updated September 2023</p>
</html>"));
end data_MSR;
