within NHES.Systems.EnergyStorage.PCM_HITB.Examples.Final_Runs_Model_Update;
model HITB_Experiment_02_RunCharge "First charge run after calibration."
extends Modelica.Icons.Example;
  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable NHES.Systems.EnergyStorage.PCM_HITB.CS.CS_Charge
      CS,
    redeclare Data.Data_System data,
    data_Initialization(
      T_PCM=325.15,
      T_Wall=325.15,
      T_HT=325.15,
      T_Insulation_Inner=321.15,
      T_Insulation_Outer=305.15,
      T_Tube_UGT=323.15,
      T_Insulation_UGT=298.15,
      T_UHP=303.15,
      T_Tube_LGT=323.15,
      T_Insulation_LGT=298.15,
      T_LHP=303.15));
 // Modelica.Units.SI.Area A_Cyl_HITB[nV_Rh];
  parameter Integer nV_Z = 6;
  parameter Integer nV_Zh = 6;
  parameter Integer nV_R = 10;
  parameter Integer nV_Rh = 5;
  Modelica.Units.SI.SpecificHeatCapacity cp_out;
  Modelica.Units.SI.Energy E_store;
  parameter Modelica.Units.SI.Length R_Na = R_Wick - 0.0011 "Main sodium radius within heat pipe, value is inner wick radius";
  parameter Modelica.Units.SI.Length R_Wick = R_HITB-0.0032 "Radius of where outer wick is.";
  parameter Modelica.Units.SI.Length R_HITB = 0.0254*1.0 "Radius of entire heat pipe apparatus that moves";
  parameter Modelica.Units.SI.Length t_PCM_pipe = 0.002 "Thickness of inner pipe of PCM container";
  parameter Modelica.Units.SI.Length R_PCM_inner = R_HITB+t_PCM_pipe+0.002 "Inner radius of PCM container";
  parameter Modelica.Units.SI.Length R_PCM = 0.295 "Outer radius of PCM container";
  parameter Modelica.Units.SI.Length t_PCM_wall = 0.002 "Outer PCM container wall thickness";

  parameter Modelica.Units.SI.Length l_HITB = 0.5+0.3+0.2;
  parameter Modelica.Units.SI.Length l_CHX = 0.3 "Length of section where heat pipe can be heated by CHX";
  parameter Modelica.Units.SI.Length l_DHX = l_CHX "Length of section where heat pipe can be cooled by DHX";
  parameter Modelica.Units.SI.Length l_gap_CHX = 0.2 "Length of section between the CHX and the PCM";
  parameter Modelica.Units.SI.Length l_gap_DHX = 0.2 "Length of section between the DHX and the PCM";
  parameter Modelica.Units.SI.Length l_PCM =  0.6 "Length of PCM heat exchange potential";
  parameter Modelica.Units.SI.Length l_experiment = l_CHX+l_DHX+l_gap_CHX+l_gap_DHX+l_PCM;
  parameter Real Q_HP_HT_Max = 920;

  parameter Modelica.Units.SI.Length t_GT = 0.005 "Thickness of the guide tube wall";
  parameter Modelica.Units.SI.Length t_insulation_GT = 0.00001 "Thickness of insulation on the exterior of the guide tubes";

  parameter Modelica.Units.SI.Time T_integrator = 3;
  parameter Modelica.Units.SI.Time T_antiwindup = 10;
  parameter Modelica.Units.SI.Time timer_HPs = 91810;
  parameter Modelica.Units.SI.Temperature T_Setpoint_Vessel = 400+273.15;
  parameter Modelica.Units.SI.Temperature T_Setpoint_HP = 460+273.15;
//  Modelica.Units.SI.Power Q_loss;
  parameter Modelica.Units.SI.Temperature T_melt = 443+273.15 "Used for graphics only";
  Modelica.Units.SI.Time time_plot;
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 35;
  parameter Modelica.Units.SI.Temperature T_air = 273.15+250 "Air inside the shipping container estimate";
  parameter Modelica.Units.SI.Length t_insulation = 0.022 "Insulation thickness value";

  Components.PCM_Volume.PCM_Chamber_vertsym_03_FullDynamicHPLocs_doubleinsulated
                        PCM_Core(
    nZ=nV_Z,
    t_insulation_inner=t_insulation,
    t_insulation_outer=t_insulation,
    hc_air=hc_air,
    T_Init=data_Initialization.T_PCM,
    T_Init_Insulation_Inner=data_Initialization.T_Insulation_Inner,
    T_Init_Insulation_Outer=data_Initialization.T_Insulation_Outer,
    redeclare package Insulation_Material_Inner = PCM_Materials.Insulator,
    redeclare package Insulation_Material_Outer =
        PCM_Materials.Insulator_aerogel,
    redeclare package PCM_Material = PCM_Materials.PCM_HITB_DensityFactor)
    annotation (Placement(transformation(extent={{142,-60},{44,42}})));

  Guide_Tube_New_Air_Inputs Lower_Guide_Tube(
    nV_Z=nV_Z,
    nV_ZGTe=8,
    nV_ZHT=5,
    l_CHX=l_CHX,
    l_CHX_gap=l_gap_CHX,
    l_DHX=l_DHX,
    l_DHX_gap=l_gap_DHX,
    l_Battery=l_PCM,
    T_init_tube=data_Initialization.T_Tube_LGT,
    T_init_insulation=data_Initialization.T_Insulation_LGT,
    r_outer=R_HITB,
    t_insulation_CHX_Inner=t_insulation,
    t_insulation_CHX_Outer=t_insulation,
    t_insulation_DHX=t_insulation,
    redeclare package Insulation_Material_CHX_Outer =
        PCM_Materials.Insulator_aerogel,
    redeclare package Insulation_Material_CHX_Inner = PCM_Materials.Insulator,
    redeclare package Insulation_Material_DHX = PCM_Materials.Insulator_aerogel,
    thickness=t_GT,
    hc_air=hc_air,
    nV_Zh=nV_Zh,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS316)
    annotation (Placement(transformation(extent={{8,-22},{78,-60}})));

  Guide_Tube_New_Air_Inputs Upper_Guide_Tube(
    nV_Z=nV_Z,
    nV_ZGTe=8,
    nV_ZHT=5,
    l_CHX=l_CHX,
    l_CHX_gap=l_gap_CHX,
    l_DHX=l_DHX,
    l_DHX_gap=l_gap_DHX,
    l_Battery=l_PCM,
    T_init_tube=data_Initialization.T_Tube_UGT,
    T_init_insulation=data_Initialization.T_Insulation_UGT,
    r_outer=R_HITB,
    t_insulation_CHX_Inner=t_insulation,
    t_insulation_CHX_Outer=t_insulation,
    t_insulation_DHX=t_insulation,
    redeclare package Insulation_Material_CHX_Outer =
        PCM_Materials.Insulator_aerogel,
    redeclare package Insulation_Material_CHX_Inner = PCM_Materials.Insulator,
    redeclare package Insulation_Material_DHX = PCM_Materials.Insulator_aerogel,
    thickness=t_GT,
    hc_air=hc_air,
    nV_Zh=nV_Zh,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS316)
    annotation (Placement(transformation(extent={{12,-2},{80,38}})));

  Heat_Pipe_New heat_Pipe_New(
    nV_Z=nV_Zh,
    T_init=data_Initialization.T_UHP,
    redeclare package Core_Material = PCM_Materials.Sodium_New (k_eff_mult=50),
    redeclare package Wick_Material = PCM_Materials.Lambda_wick_d_5000_cp_1000,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS316,
    T_air_evaporator=Lower_Guide_Tube.Guide_Tube.materials[1, 1].T,
    T_air_condenser=Lower_Guide_Tube.Guide_Tube.materials[Lower_Guide_Tube.nR,
        Lower_Guide_Tube.nV_ZGT_Total].T)
    annotation (Placement(transformation(extent={{16,-28},{42,-52}})));
  Heat_Pipe_New heat_Pipe_New1(
    nV_Z=nV_Zh,
    T_init=data_Initialization.T_UHP,
    redeclare package Core_Material = PCM_Materials.Sodium_New (k_eff_mult=50),
    redeclare package Wick_Material = PCM_Materials.Lambda_wick_d_5000_cp_1000,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS316,
    T_air_evaporator=Upper_Guide_Tube.Guide_Tube.materials[1, 1].T,
    T_air_condenser=Upper_Guide_Tube.Guide_Tube.materials[Upper_Guide_Tube.nR,
        Upper_Guide_Tube.nV_ZGT_Total].T)
    annotation (Placement(transformation(extent={{16,4},{42,30}})));

  Components.Position_Calculator  Signal_Position_Lower(l_experiment=
        l_experiment, l_HITB=l_HITB)
    annotation (Placement(transformation(extent={{86,88},{100,74}})));
  Components.Position_Calculator Signal_Position_Upper(l_experiment=
        l_experiment, l_HITB=l_HITB)
    annotation (Placement(transformation(extent={{86,92},{100,106}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure(y=PCM_Core.T_TCs[4])
    annotation (Placement(transformation(extent={{-86,90},{-66,110}})));
  Modelica.Blocks.Sources.TimeTable Temperature_Reference_TC18(
    table=[0,57.5; 0.083333333,57.5; 0.166666667,57.4; 0.25,57.3; 0.333333333,
        57.2; 0.416666667,57.1; 0.5,57; 0.583333333,57; 0.666666667,56.9; 0.75,
        56.7; 0.833333333,56.7; 0.916666667,56.6; 1,56.5; 1.083333333,56.9;
        1.166666667,58.3; 1.25,59.1; 1.333333333,62.3; 1.416666667,64.4; 1.5,
        66.8; 1.583333333,71; 1.666666667,74.3; 1.75,77.5; 1.833333333,80.3;
        1.916666667,84.6; 2,88.5; 2.083333333,92.2; 2.166666667,96; 2.25,99.8;
        2.333333333,104; 2.416666667,108; 2.5,112; 2.583333333,114; 2.666666667,
        120; 2.75,124; 2.833333333,128; 2.916666667,131; 3,136; 3.083333333,141;
        3.166666667,145; 3.25,149; 3.333333333,153; 3.416666667,157; 3.5,160;
        3.583333333,165; 3.666666667,168; 3.75,173; 3.833333333,177;
        3.916666667,181; 4,184; 4.083333333,188; 4.166666667,192; 4.25,196;
        4.333333333,200; 4.416666667,203; 4.5,207; 4.583333333,210; 4.666666667,
        215; 4.75,218; 4.833333333,222; 4.916666667,224; 5,229; 5.083333333,232;
        5.166666667,235; 5.25,238; 5.333333333,241; 5.416666667,245; 5.5,248;
        5.583333333,252; 5.666666667,255; 5.75,258; 5.833333333,261;
        5.916666667,265; 6,267; 6.083333333,271; 6.166666667,273; 6.25,277;
        6.333333333,280; 6.416666667,283; 6.5,285; 6.583333333,289; 6.666666667,
        291; 6.75,295; 6.833333333,298; 6.916666667,298; 7,303; 7.083333333,306;
        7.166666667,309; 7.25,312; 7.333333333,314; 7.416666667,317; 7.5,320;
        7.583333333,322; 7.666666667,325; 7.75,327; 7.833333333,330;
        7.916666667,333; 8,335; 8.083333333,338; 8.166666667,339; 8.25,343;
        8.333333333,345; 8.416666667,348; 8.5,350; 8.583333333,352; 8.666666667,
        355; 8.75,357; 8.833333333,359; 8.916666667,362; 9,364; 9.083333333,366;
        9.166666667,368; 9.25,371; 9.333333333,373; 9.416666667,375; 9.5,376;
        9.583333333,378; 9.666666667,379; 9.75,380; 9.833333333,382;
        9.916666667,383; 10,384; 10.08333333,386; 10.16666667,387; 10.25,388;
        10.33333333,389; 10.41666667,389; 10.5,390; 10.58333333,391;
        10.66666667,392; 10.75,393; 10.83333333,393; 10.91666667,394; 11,394;
        11.08333333,395; 11.16666667,395; 11.25,396; 11.33333333,396;
        11.41666667,397; 11.5,397; 11.58333333,398; 11.66666667,398; 11.75,399;
        11.83333333,399; 11.91666667,399; 12,400; 12.08333333,400; 12.16666667,
        400; 12.25,400; 12.33333333,401; 12.41666667,401; 12.5,401; 12.58333333,
        401; 12.66666667,401; 12.75,402; 12.83333333,402; 12.91666667,402; 13,
        402; 13.08333333,402; 13.16666667,403; 13.25,403; 13.33333333,403;
        13.41666667,403; 13.5,403; 13.58333333,403; 13.66666667,403; 13.75,403;
        13.83333333,403; 13.91666667,404; 14,404; 14.08333333,404; 14.16666667,
        404; 14.25,404; 14.33333333,404; 14.41666667,404; 14.5,404; 14.58333333,
        404; 14.66666667,404; 14.75,404; 14.83333333,404; 14.91666667,404; 15,
        404; 15.08333333,404; 15.16666667,404; 15.25,404; 15.33333333,404;
        15.41666667,405; 15.5,405; 15.58333333,405; 15.66666667,405; 15.75,405;
        15.83333333,405; 15.91666667,405; 16,405; 16.08333333,405; 16.16666667,
        405; 16.25,405; 16.33333333,405; 16.41666667,405; 16.5,405; 16.58333333,
        405; 16.66666667,405; 16.75,405; 16.83333333,405; 16.91666667,405; 17,
        405; 17.08333333,405; 17.16666667,405; 17.25,405; 17.33333333,405;
        17.41666667,405; 17.5,405; 17.58333333,405; 17.66666667,405; 17.75,405;
        17.83333333,405; 17.91666667,405; 18,405; 18.08333333,405; 18.16666667,
        405; 18.25,405; 18.33333333,405; 18.41666667,405; 18.5,405; 18.58333333,
        405; 18.66666667,405; 18.75,405; 18.83333333,405; 18.91666667,405; 19,
        405; 19.08333333,405; 19.16666667,405; 19.25,405; 19.33333333,405;
        19.41666667,405; 19.5,405; 19.58333333,405; 19.66666667,405; 19.75,405;
        19.83333333,405; 19.91666667,405; 20,405; 20.08333333,405; 20.16666667,
        405; 20.25,405; 20.33333333,405; 20.41666667,405; 20.5,405; 20.58333333,
        404; 20.66666667,405; 20.75,405; 20.83333333,405; 20.91666667,405; 21,
        405; 21.08333333,405; 21.16666667,404; 21.25,404; 21.33333333,404;
        21.41666667,405; 21.5,405; 21.58333333,404; 21.66666667,405; 21.75,404;
        21.83333333,404; 21.91666667,404; 22,404; 22.08333333,404; 22.16666667,
        404; 22.25,404; 22.33333333,404; 22.41666667,404; 22.5,404; 22.58333333,
        404; 22.66666667,404; 22.75,404; 22.83333333,404; 22.91666667,404; 23,
        404; 23.08333333,404; 23.16666667,404; 23.25,404; 23.33333333,404;
        23.41666667,404; 23.5,404; 23.58333333,404; 23.66666667,404; 23.75,404;
        23.83333333,404; 23.91666667,404; 24,404; 24.08333333,404; 24.16666667,
        404; 24.25,404; 24.33333333,404; 24.41666667,404; 24.5,404; 24.58333333,
        405; 24.66666667,406; 24.75,407; 24.83333333,409; 24.91666667,411; 25,
        413; 25.08333333,414; 25.16666667,415; 25.25,417; 25.33333333,418;
        25.41666667,419; 25.5,420; 25.58333333,421; 25.66666667,422; 25.75,423;
        25.83333333,424; 25.91666667,425; 26,426; 26.08333333,427; 26.16666667,
        427; 26.25,429; 26.33333333,429; 26.41666667,430; 26.5,431; 26.58333333,
        431; 26.66666667,432; 26.75,433; 26.83333333,434; 26.91666667,434; 27,
        435; 27.08333333,436; 27.16666667,437; 27.25,437; 27.33333333,438;
        27.41666667,439; 27.5,439; 27.58333333,440; 27.66666667,440; 27.75,441;
        27.83333333,442; 27.91666667,442; 28,443; 28.08333333,443; 28.16666667,
        444; 28.25,444; 28.33333333,445; 28.41666667,445; 28.5,445; 28.58333333,
        446; 28.66666667,446; 28.75,446; 28.83333333,447; 28.91666667,447; 29,
        447; 29.08333333,447; 29.16666667,448; 29.25,448; 29.33333333,448;
        29.41666667,448; 29.5,448; 29.58333333,449; 29.66666667,449; 29.75,449;
        29.83333333,449; 29.91666667,449; 30,449; 30.08333333,450; 30.16666667,
        450; 30.25,450; 30.33333333,450; 30.41666667,450; 30.5,450; 30.58333333,
        450; 30.66666667,450; 30.75,450; 30.83333333,450; 30.91666667,450; 31,
        450; 31.08333333,450; 31.16666667,450; 31.25,450; 31.33333333,450;
        31.41666667,450; 31.5,450; 31.58333333,450; 31.66666667,450; 31.75,450;
        31.83333333,450; 31.91666667,450; 32,450; 32.08333333,450; 32.16666667,
        450; 32.25,450; 32.33333333,450; 32.41666667,450; 32.5,450; 32.58333333,
        450; 32.66666667,450; 32.75,450; 32.83333333,450; 32.91666667,450; 33,
        450; 33.08333333,450; 33.16666667,450; 33.25,450; 33.33333333,449;
        33.41666667,449; 33.5,448; 33.58333333,448; 33.66666667,448; 33.75,447;
        33.83333333,447; 33.91666667,446; 34,445; 34.08333333,444; 34.16666667,
        443; 34.25,442; 34.33333333,441; 34.41666667,439; 34.5,437; 34.58333333,
        433; 34.66666667,431; 34.75,429; 34.83333333,428; 34.91666667,425; 35,
        424; 35.08333333,422; 35.16666667,421; 35.25,420; 35.33333333,418;
        35.41666667,417; 35.5,415; 35.58333333,414; 35.66666667,413; 35.75,411;
        35.83333333,410; 35.91666667,409; 36,408; 36.08333333,406; 36.16666667,
        406; 36.25,404; 36.33333333,403; 36.41666667,402; 36.5,401; 36.58333333,
        399; 36.66666667,398; 36.75,397; 36.83333333,396; 36.91666667,395; 37,
        394; 37.08333333,393; 37.16666667,392; 37.25,391; 37.33333333,390;
        37.41666667,389; 37.5,387; 37.58333333,387; 37.66666667,385; 37.75,384;
        37.83333333,383; 37.91666667,382; 38,382; 38.08333333,381; 38.16666667,
        379; 38.25,378; 38.33333333,377; 38.41666667,376; 38.5,375; 38.58333333,
        374; 38.66666667,373; 38.75,372; 38.83333333,372; 38.91666667,370; 39,
        369; 39.08333333,368; 39.16666667,368; 39.25,367; 39.33333333,366;
        39.41666667,365; 39.5,364; 39.58333333,363; 39.66666667,362; 39.75,361;
        39.83333333,360; 39.91666667,359; 40,358; 40.08333333,358; 40.16666667,
        357; 40.25,356; 40.33333333,355; 40.41666667,354; 40.5,353; 40.58333333,
        352; 40.66666667,351; 40.75,350; 40.83333333,349; 40.91666667,349; 41,
        348; 41.08333333,347; 41.16666667,346; 41.25,346; 41.33333333,345;
        41.41666667,344; 41.5,343; 41.58333333,342; 41.66666667,341; 41.75,340;
        41.83333333,339; 41.91666667,339; 42,339; 42.08333333,337; 42.16666667,
        336; 42.25,336; 42.33333333,335; 42.41666667,334; 42.5,333; 42.58333333,
        332; 42.66666667,331; 42.75,331; 42.83333333,330; 42.91666667,329; 43,
        328; 43.08333333,328; 43.16666667,327; 43.25,326; 43.33333333,325;
        43.41666667,324; 43.5,324; 43.58333333,323; 43.66666667,322; 43.75,322;
        43.83333333,321; 43.91666667,320; 44,319; 44.08333333,318; 44.16666667,
        318; 44.25,317; 44.33333333,316; 44.41666667,316; 44.5,315; 44.58333333,
        314; 44.66666667,313; 44.75,312; 44.83333333,312; 44.91666667,311; 45,
        310; 45.08333333,310; 45.16666667,309; 45.25,308; 45.33333333,307;
        45.41666667,307; 45.5,306; 45.58333333,305; 45.66666667,305; 45.75,304;
        45.83333333,303; 45.91666667,302; 46,302; 46.08333333,302; 46.16666667,
        300; 46.25,300; 46.33333333,299; 46.41666667,298; 46.5,298; 46.58333333,
        297; 46.66666667,297; 46.75,296; 46.83333333,295; 46.91666667,294; 47,
        294; 47.08333333,293; 47.16666667,293; 47.25,291; 47.33333333,291;
        47.41666667,290; 47.5,290; 47.58333333,289; 47.66666667,288; 47.75,287;
        47.83333333,287; 47.91666667,287; 48,285; 48.08333333,285; 48.16666667,
        284; 48.25,284; 48.33333333,283; 48.41666667,282; 48.5,282; 48.58333333,
        281; 48.66666667,281; 48.75,280; 48.83333333,279; 48.91666667,279; 49,
        278; 49.08333333,277; 49.16666667,277; 49.25,276; 49.33333333,275;
        49.41666667,275; 49.5,274; 49.58333333,274; 49.66666667,273; 49.75,273;
        49.83333333,272; 49.91666667,271; 50,271; 50.08333333,270; 50.16666667,
        270; 50.25,269; 50.33333333,268; 50.41666667,268; 50.5,267; 50.58333333,
        266; 50.66666667,266; 50.75,266; 50.83333333,265; 50.91666667,264; 51,
        264; 51.08333333,263; 51.16666667,262; 51.25,262; 51.33333333,261;
        51.41666667,261; 51.5,260; 51.58333333,259; 51.66666667,259; 51.75,258;
        51.83333333,258; 51.91666667,257; 52,257; 52.08333333,256; 52.16666667,
        256; 52.25,255; 52.33333333,255; 52.41666667,254; 52.5,253; 52.58333333,
        253; 52.66666667,252; 52.75,252; 52.83333333,251; 52.91666667,251; 53,
        250; 53.08333333,249; 53.16666667,249; 53.25,248; 53.33333333,248;
        53.41666667,247; 53.5,247; 53.58333333,247; 53.66666667,246; 53.75,245;
        53.83333333,245; 53.91666667,244; 54,244; 54.08333333,243; 54.16666667,
        243; 54.25,242; 54.33333333,241; 54.41666667,241; 54.5,240; 54.58333333,
        240; 54.66666667,239; 54.75,239; 54.83333333,238; 54.91666667,238; 55,
        237; 55.08333333,237; 55.16666667,237; 55.25,236; 55.33333333,236;
        55.41666667,235; 55.5,234; 55.58333333,234; 55.66666667,233; 55.75,233;
        55.83333333,232; 55.91666667,232; 56,231; 56.08333333,231; 56.16666667,
        231; 56.25,230; 56.33333333,230; 56.41666667,229; 56.5,228; 56.58333333,
        228; 56.66666667,228; 56.75,227; 56.83333333,227; 56.91666667,226; 57,
        226; 57.08333333,225; 57.16666667,225; 57.25,225; 57.33333333,224;
        57.41666667,224; 57.5,223; 57.58333333,223; 57.66666667,222; 57.75,222;
        57.83333333,221; 57.91666667,221; 58,220; 58.08333333,220; 58.16666667,
        220; 58.25,219; 58.33333333,219; 58.41666667,218; 58.5,218; 58.58333333,
        217; 58.66666667,217; 58.75,216; 58.83333333,216; 58.91666667,216; 59,
        215; 59.08333333,215; 59.16666667,214; 59.25,214; 59.33333333,213;
        59.41666667,213; 59.5,212; 59.58333333,212],
    timeScale=3600,
    offset=273.15,
    shiftTime=-3300)
    annotation (Placement(transformation(extent={{-114,2},{-94,22}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure1(y=PCM_Core.T_TCs[4])
    annotation (Placement(transformation(extent={{-76,-52},{-56,-32}})));
  Components.RMSE_Calculator rMSE_Calculator
    annotation (Placement(transformation(extent={{-38,-34},{-18,-14}})));
protected

equation
  time_plot = time+91000;
  cp_out = PCM_Core.conduction.Material.specificHeatCapacityCp(PCM_Core.conduction.materials[1,1, 1].state);
  Position = Signal_Position_Lower.Position;
//  Position =Signal_Position_Upper.y;
  der(E_store) = sum(PCM_Core.port_b.Q_flow);
//  A_Cyl_HITB = HITB_Main.geometry.crossAreas_2[:,1];

  //  SA_PCM_HITB = z_overlap.*Modelica.Constants.pi*2*R_HITB;

  /* NOTES 
  The heat rate by node for the charging and discharging heat exchangers both need to be adjusted to account for the fact
  that the rod is moving. At the moment, the entire rod is being heated & cooled evenly. The overall heat rate is still being 
  adjusted and is accounted for, but this i snot accurate. The heat needs to be inserted to the correct nodes only.
  
  
  
  */

  connect(Upper_Guide_Tube.port_battery, PCM_Core.port_b[:, 1]) annotation (
      Line(points={{47.9429,25.6},{71.44,25.6},{71.44,-7.2},{97.1263,-7.2}},
        color={191,0,0}));
  connect(Lower_Guide_Tube.port_battery, PCM_Core.port_b[:, 2]) annotation (
      Line(points={{45,-48.22},{72,-48.22},{72,-7.2},{97.1263,-7.2}},
        color={191,0,0}));
  connect(heat_Pipe_New1.heat_pipe_port, Upper_Guide_Tube.port_HP) annotation (
      Line(points={{34.98,21.42},{27.0571,21.42},{27.0571,22.4}},
                                                          color={191,0,0}));
  connect(heat_Pipe_New.heat_pipe_port, Lower_Guide_Tube.port_HP) annotation (
      Line(points={{34.98,-44.08},{34,-44.08},{34,-46},{28,-46},{28,-45.18},{23.5,
          -45.18}},                                      color={191,0,0}));
  connect(actuatorBus.Lower_Heat_Tape_Power, Lower_Guide_Tube.Heat_Tape_Input)
    annotation (Line(
      points={{30,100},{66,100},{66,110},{152,110},{152,-70},{62,-70},{62,-60},{
          62.5,-60},{62.5,-50.12}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Tape_Power, Upper_Guide_Tube.Heat_Tape_Input)
    annotation (Line(
      points={{30,100},{64.9429,100},{64.9429,27.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Pipe_Position, Signal_Position_Upper.Position)
    annotation (Line(
      points={{30,100},{74,100},{74,99},{84.6,99}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Pipe_Position, Signal_Position_Lower.Position)
    annotation (Line(
      points={{30,100},{74,100},{74,81},{84.6,81}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Vessel_Heat_Tape_Power, PCM_Core.Heat_Tape_Input)
    annotation (Line(
      points={{30,100},{66,100},{66,110},{152,110},{152,4},{60,4},{60,-12},{
          80.1053,-12}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Signal_Position_Lower.z_min, Lower_Guide_Tube.z_min_heatpipe)
    annotation (Line(points={{100.7,77.5},{160,77.5},{160,-66},{-8,-66},{-8,-46},
          {9.25,-46},{9.25,-44.61}}, color={0,0,127}));
  connect(Lower_Guide_Tube.z_max_heatpipe, Signal_Position_Lower.z_max)
    annotation (Line(points={{9.25,-38.53},{-8,-38.53},{-8,-66},{160,-66},{160,84},
          {130,84},{130,84.5},{100.7,84.5}}, color={0,0,127}));
  connect(Signal_Position_Upper.z_max, Upper_Guide_Tube.z_max_heatpipe)
    annotation (Line(points={{100.7,95.5},{130,95.5},{130,96},{160,96},{160,-66},
          {-8,-66},{-8,16},{2,16},{2,15.4},{13.2143,15.4}}, color={0,0,127}));
  connect(Upper_Guide_Tube.z_min_heatpipe, Signal_Position_Upper.z_min)
    annotation (Line(points={{13.2143,21.8},{2,21.8},{2,22},{-8,22},{-8,-66},{
          160,-66},{160,102},{100.7,102},{100.7,102.5}},
                                                     color={0,0,127}));
  connect(sensorBus.T_PCM, T_Vessel_Measure.y) annotation (Line(
      points={{-30,100},{-65,100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(rMSE_Calculator.u1, Temperature_Reference_TC18.y) annotation (Line(
        points={{-40,-18},{-88,-18},{-88,12},{-93,12}}, color={0,0,127}));
  connect(T_Vessel_Measure1.y, rMSE_Calculator.u2) annotation (Line(points={{
          -55,-42},{-48,-42},{-48,-30},{-40,-30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},
            {200,120}}),                                        graphics={
        Rectangle(
          extent={{56,36},{94,-32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-98,36},{-60,-32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95}),
        Ellipse(
          extent={{-34,34},{-26,-30}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,34},{26,-30}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{22,34},{30,-30}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(points={{-78,28}}, color={0,0,0}),
        Line(
          points={{-88,36},{-88,24},{-94,18},{-84,12},{-94,4},{-84,-4},{-94,-12},
              {-88,-18},{-88,-32}},
          color={255,0,0},
          thickness=DynamicSelect(0,2-4*min(0.5,Position))),
        Line(
          points={{-78,36},{-78,24},{-84,18},{-74,12},{-84,4},{-74,-4},{-84,-12},
              {-78,-18},{-78,-32}},
          color={255,0,0},
          thickness=DynamicSelect(0,2-4*min(0.5,Position))),
        Line(
          points={{-68,36},{-68,24},{-74,18},{-64,12},{-74,4},{-64,-4},{-74,-12},
              {-68,-18},{-68,-32}},
          color={255,0,0},
          thickness=DynamicSelect(0,2-4*min(0.5,Position))),
        Line(
          points={{86,36},{86,24},{80,18},{90,12},{80,4},{90,-4},{80,-12},{86,-18},
              {86,-32}},
          color={28,108,200},
          thickness=DynamicSelect(0,4*(max(Position,0.5)-0.5))),
        Line(
          points={{76,36},{76,24},{70,18},{80,12},{70,4},{80,-4},{70,-12},{76,-18},
              {76,-32}},
          color={28,108,200},
          thickness=DynamicSelect(0,4*(max(Position,0.5)-0.5))),
        Line(
          points={{66,36},{66,24},{60,18},{70,12},{60,4},{70,-4},{60,-12},{66,-18},
              {66,-32}},
          color={28,108,200},
          thickness=DynamicSelect(0,4*(max(Position,0.5)-0.5))),
        Ellipse(
          extent=DynamicSelect({{-94,4},{-98,-2}},{{-94+76*Position,4},{-98+76*Position,-2}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent=DynamicSelect({{20,4},{16,-2}},{{20+76*Position,4},{16+76*Position,-2}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent=DynamicSelect({{-96,4},{18,-2}},{{-96+76*Position,4},{18+76*Position,-2}}),
          lineColor={28,108,200},
          fillColor={244,125,35},fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent=DynamicSelect({{-96,-8},{18,-14}},{{-96+76*Position,-8},{18+76*Position,-14}}),
          lineColor={28,108,200},
          fillColor={244,125,35},fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent=DynamicSelect({{20,-8},{16,-14}},{{20+76*Position,-8},{16+76*Position,-14}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent=DynamicSelect({{-94,-8},{-98,-14}},{{-94+76*Position,-8},{-98+76*Position,-14}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent=DynamicSelect({{-96,16},{18,10}},{{-96+76*Position,16},{18+76*Position,10}}),
          lineColor={28,108,200},
          fillColor={244,125,35},fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent=DynamicSelect({{20,16},{16,10}},{{20+76*Position,10}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent=DynamicSelect({{-94,16},{-98,10}},{{-94+76*Position,16},{-98+76*Position,10}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent={{-36,106},{26,46}},
          lineColor={28,108,200},
          startAngle=0,
          endAngle=360,
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-18,84},{-12,78}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{2,84},{8,78}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{-8,68},{-2,62}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360)}),                                       Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{200,120}})),
    experiment(
      StopTime=90000,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Dassl"));
end HITB_Experiment_02_RunCharge;
