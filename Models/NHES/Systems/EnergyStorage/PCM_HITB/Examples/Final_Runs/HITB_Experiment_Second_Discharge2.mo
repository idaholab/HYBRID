within NHES.Systems.EnergyStorage.PCM_HITB.Examples.Final_Runs;
model HITB_Experiment_Second_Discharge2
  "First discharge run with data read in the system."
extends Modelica.Icons.Example;
  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable NHES.Systems.EnergyStorage.PCM_HITB.CS.CS_Discharge2
      CS,
    redeclare Data.Data_System data,
    data_Initialization(
      T_PCM=785.15,
      T_Wall=783.15,
      T_HT=630.15,
      T_Insulation_Inner=663.15,
      T_Insulation_Outer=463.15,
      T_Tube_UGT=698.15,
      T_Insulation_UGT=463.15,
      T_UHP=573.15,
      T_Tube_LGT=698.15,
      T_Insulation_LGT=463.15,
      T_LHP=573.15));
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

  PCM_Chamber_Connected PCM_Core(
    nZ=nV_Z,
    t_insulation_inner=t_insulation,
    t_insulation_outer=t_insulation,
    hc_air=hc_air,
    T_Init=data_Initialization.T_PCM,
    T_Init_Wall=data_Initialization.T_Wall,
    T_Init_Insulation_Inner=data_Initialization.T_Insulation_Inner,
    T_Init_Insulation_Outer=data_Initialization.T_Insulation_Outer,
    T_Init_HT=data_Initialization.T_HT,
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
  Modelica.Blocks.Sources.TimeTable Experiment_Measure_TC13(
    table=[0.0,504; 0.083333333,504; 0.166666667,504; 0.25,504; 0.333333333,504;
        0.416666667,504; 0.5,504; 0.583333333,504; 0.666666667,504; 0.75,504; 0.833333333,
        504; 0.916666667,504; 1,503; 1.083333333,502; 1.166666667,501; 1.25,500;
        1.333333333,499; 1.416666667,498; 1.5,496; 1.583333333,494; 1.666666667,
        493; 1.75,492; 1.833333333,490; 1.916666667,489; 2,488; 2.083333333,486;
        2.166666667,484; 2.25,483; 2.333333333,481; 2.416666667,481; 2.5,479; 2.583333333,
        477; 2.666666667,477; 2.75,474; 2.833333333,473; 2.916666667,472; 3,471;
        3.083333333,469; 3.166666667,469; 3.25,469; 3.333333333,465; 3.416666667,
        465; 3.5,462; 3.583333333,462; 3.666666667,460; 3.75,459; 3.833333333,458;
        3.916666667,456; 4,455; 4.083333333,455; 4.166666667,453; 4.25,451; 4.333333333,
        451; 4.416666667,449; 4.5,449; 4.583333333,449; 4.666666667,450; 4.75,450;
        4.833333333,450; 4.916666667,450; 5,450; 5.083333333,450; 5.166666667,450;
        5.25,450; 5.333333333,450; 5.416666667,450; 5.5,450; 5.583333333,450; 5.666666667,
        450; 5.75,450; 5.833333333,450; 5.916666667,450; 6,450; 6.083333333,450;
        6.166666667,450; 6.25,450; 6.333333333,450; 6.416666667,450; 6.5,450; 6.583333333,
        450; 6.666666667,450; 6.75,450; 6.833333333,451; 6.916666667,450; 7,450;
        7.083333333,450; 7.166666667,450; 7.25,451; 7.333333333,450; 7.416666667,
        450; 7.5,450; 7.583333333,450; 7.666666667,450; 7.75,450; 7.833333333,450;
        7.916666667,450; 8,450; 8.083333333,450; 8.166666667,451; 8.25,450; 8.333333333,
        450; 8.416666667,450; 8.5,450; 8.583333333,450; 8.666666667,450; 8.75,450;
        8.833333333,450; 8.916666667,450; 9,450; 9.083333333,450; 9.166666667,450;
        9.25,450; 9.333333333,450; 9.416666667,450; 9.5,450; 9.583333333,450; 9.666666667,
        450; 9.75,450; 9.833333333,450; 9.916666667,450; 10,450; 10.08333333,450;
        10.16666667,450; 10.25,450; 10.33333333,450; 10.41666667,450; 10.5,450;
        10.58333333,450; 10.66666667,450; 10.75,450; 10.83333333,450; 10.91666667,
        450; 11,450; 11.08333333,450; 11.16666667,450; 11.25,450; 11.33333333,450;
        11.41666667,450; 11.5,450; 11.58333333,450; 11.66666667,450; 11.75,450;
        11.83333333,450; 11.91666667,450; 12,450; 12.08333333,450; 12.16666667,450;
        12.25,450; 12.33333333,450; 12.41666667,450; 12.5,450; 12.58333333,450;
        12.66666667,450; 12.75,450; 12.83333333,450; 12.91666667,450; 13,450; 13.08333333,
        450; 13.16666667,450; 13.25,450; 13.33333333,450; 13.41666667,450; 13.5,
        449; 13.58333333,449; 13.66666667,449; 13.75,449; 13.83333333,449; 13.91666667,
        448; 14,448; 14.08333333,448; 14.16666667,447; 14.25,447; 14.33333333,446;
        14.41666667,446; 14.5,446; 14.58333333,444; 14.66666667,443; 14.75,442;
        14.83333333,441; 14.91666667,440; 15,439; 15.08333333,438; 15.16666667,437;
        15.25,435; 15.33333333,433; 15.41666667,432; 15.5,429; 15.58333333,428;
        15.66666667,426; 15.75,425; 15.83333333,423; 15.91666667,422; 16,420; 16.08333333,
        419; 16.16666667,418; 16.25,416; 16.33333333,415; 16.41666667,414; 16.5,
        413; 16.58333333,412; 16.66666667,410; 16.75,410; 16.83333333,409; 16.91666667,
        406; 17,406; 17.08333333,405; 17.16666667,405; 17.25,402; 17.33333333,402;
        17.41666667,400; 17.5,399; 17.58333333,397; 17.66666667,397; 17.75,395;
        17.83333333,394; 17.91666667,394; 18,392; 18.08333333,392; 18.16666667,389;
        18.25,389; 18.33333333,387; 18.41666667,387; 18.5,387; 18.58333333,384;
        18.66666667,383; 18.75,382; 18.83333333,382; 18.91666667,380; 19,379; 19.08333333,
        379; 19.16666667,377; 19.25,376; 19.33333333,375; 19.41666667,373; 19.5,
        373; 19.58333333,373; 19.66666667,371; 19.75,370; 19.83333333,369; 19.91666667,
        369; 20,366; 20.08333333,366; 20.16666667,365; 20.25,364; 20.33333333,363;
        20.41666667,362; 20.5,361; 20.58333333,360; 20.66666667,360; 20.75,360;
        20.83333333,360; 20.91666667,360; 21,355; 21.08333333,355; 21.16666667,353;
        21.25,353; 21.33333333,351; 21.41666667,351; 21.5,350; 21.58333333,349;
        21.66666667,349; 21.75,347; 21.83333333,347; 21.91666667,345; 22,344; 22.08333333,
        343; 22.16666667,343; 22.25,342; 22.33333333,342; 22.41666667,340; 22.5,
        340; 22.58333333,339; 22.66666667,338; 22.75,337; 22.83333333,336; 22.91666667,
        335; 23,334; 23.08333333,334; 23.16666667,332; 23.25,332; 23.33333333,331;
        23.41666667,330; 23.5,330; 23.58333333,328; 23.66666667,328; 23.75,327;
        23.83333333,326; 23.91666667,325; 24,325; 24.08333333,324; 24.16666667,323;
        24.25,322; 24.33333333,321; 24.41666667,321; 24.5,320; 24.58333333,319;
        24.66666667,319; 24.75,318; 24.83333333,317; 24.91666667,316; 25,315; 25.08333333,
        314; 25.16666667,314; 25.25,313; 25.33333333,312; 25.41666667,312; 25.5,
        311; 25.58333333,310; 25.66666667,309; 25.75,309; 25.83333333,308; 25.91666667,
        307; 26,306; 26.08333333,305; 26.16666667,305; 26.25,304; 26.33333333,304;
        26.41666667,303; 26.5,302; 26.58333333,301; 26.66666667,301; 26.75,300;
        26.83333333,299; 26.91666667,299; 27,298; 27.08333333,297; 27.16666667,297;
        27.25,296; 27.33333333,295; 27.41666667,294; 27.5,294; 27.58333333,293;
        27.66666667,293; 27.75,292; 27.83333333,291; 27.91666667,290; 28,290; 28.08333333,
        289; 28.16666667,288; 28.25,288; 28.33333333,287; 28.41666667,286; 28.5,
        286; 28.58333333,285; 28.66666667,285; 28.75,284; 28.83333333,283; 28.91666667,
        282; 29,282; 29.08333333,281; 29.16666667,281; 29.25,280; 29.33333333,279;
        29.41666667,279; 29.5,278; 29.58333333,277; 29.66666667,277; 29.75,276;
        29.83333333,275; 29.91666667,275; 30,275; 30.08333333,273; 30.16666667,273;
        30.25,272; 30.33333333,272; 30.41666667,271; 30.5,270; 30.58333333,270;
        30.66666667,269; 30.75,269; 30.83333333,269; 30.91666667,267; 31,267; 31.08333333,
        266; 31.16666667,266; 31.25,265; 31.33333333,264; 31.41666667,264; 31.5,
        263; 31.58333333,263; 31.66666667,262; 31.75,261; 31.83333333,261; 31.91666667,
        261; 32,261; 32.08333333,259; 32.16666667,259; 32.25,258; 32.33333333,257;
        32.41666667,257; 32.5,257; 32.58333333,256; 32.66666667,255; 32.75,255;
        32.83333333,255; 32.91666667,253; 33,253; 33.08333333,252; 33.16666667,252;
        33.25,251; 33.33333333,251; 33.41666667,251; 33.5,250; 33.58333333,249;
        33.66666667,249; 33.75,248; 33.83333333,247; 33.91666667,247; 34,246; 34.08333333,
        246; 34.16666667,245; 34.25,244; 34.33333333,244; 34.41666667,243; 34.5,
        243; 34.58333333,243; 34.66666667,242; 34.75,241; 34.83333333,241; 34.91666667,
        240; 35,240; 35.08333333,239; 35.16666667,239; 35.25,238; 35.33333333,237;
        35.41666667,237; 35.5,236; 35.58333333,236; 35.66666667,235; 35.75,235;
        35.83333333,234; 35.91666667,234; 36,233; 36.08333333,233; 36.16666667,232;
        36.25,232; 36.33333333,231; 36.41666667,231; 36.5,230; 36.58333333,230;
        36.66666667,229; 36.75,229; 36.83333333,228; 36.91666667,228; 37,227; 37.08333333,
        227; 37.16666667,226; 37.25,226; 37.33333333,225; 37.41666667,225; 37.5,
        225; 37.58333333,224; 37.66666667,223; 37.75,223; 37.83333333,222; 37.91666667,
        222; 38,221; 38.08333333,221; 38.16666667,221; 38.25,220; 38.33333333,220;
        38.41666667,219; 38.5,219; 38.58333333,218; 38.66666667,218; 38.75,217;
        38.83333333,217; 38.91666667,216; 39,216; 39.08333333,215; 39.16666667,215;
        39.25,214; 39.33333333,214; 39.41666667,214; 39.5,213; 39.58333333,213;
        39.66666667,212; 39.75,212; 39.83333333,211; 39.91666667,211; 40,211; 40.08333333,
        210; 40.16666667,210; 40.25,209; 40.33333333,209; 40.41666667,208; 40.5,
        208; 40.58333333,207; 40.66666667,207; 40.75,207; 40.83333333,206; 40.91666667,
        206; 41,205; 41.08333333,205; 41.16666667,204; 41.25,204; 41.33333333,203;
        41.41666667,203; 41.5,202; 41.58333333,202; 41.66666667,202; 41.75,201;
        41.83333333,201; 41.91666667,200; 42,200; 42.08333333,200; 42.16666667,199;
        42.25,199; 42.33333333,198; 42.41666667,198; 42.5,197; 42.58333333,197;
        42.66666667,196; 42.75,196; 42.83333333,196; 42.91666667,195; 43,195; 43.08333333,
        195; 43.16666667,194; 43.25,193; 43.33333333,193; 43.41666667,193; 43.5,
        193; 43.58333333,192; 43.66666667,191; 43.75,191; 43.83333333,191; 43.91666667,
        190; 44,190; 44.08333333,189; 44.16666667,189; 44.25,189; 44.33333333,188;
        44.41666667,188; 44.5,187; 44.58333333,187; 44.66666667,187; 44.75,186;
        44.83333333,186; 44.91666667,185; 45,185; 45.08333333,184; 45.16666667,184;
        45.25,184; 45.33333333,183; 45.41666667,183; 45.5,183; 45.58333333,183;
        45.66666667,182; 45.75,181; 45.83333333,181; 45.91666667,181; 46,180; 46.08333333,
        180; 46.16666667,179; 46.25,179; 46.33333333,179; 46.41666667,178; 46.5,
        178; 46.58333333,178; 46.66666667,177; 46.75,177; 46.83333333,177; 46.91666667,
        176; 47,176; 47.08333333,176; 47.16666667,175; 47.25,175; 47.33333333,174;
        47.41666667,174; 47.5,174; 47.58333333,174; 47.66666667,173; 47.75,173;
        47.83333333,173; 47.91666667,172; 48,172; 48.08333333,171; 48.16666667,171;
        48.25,171; 48.33333333,170; 48.41666667,170; 48.5,169; 48.58333333,169;
        48.66666667,169; 48.75,168; 48.83333333,168; 48.91666667,168; 49,167; 49.08333333,
        167; 49.16666667,167; 49.25,166; 49.33333333,166; 49.41666667,166; 49.5,
        165; 49.58333333,165; 49.66666667,165; 49.75,165; 49.83333333,165; 49.91666667,
        165; 50,165; 50.08333333,163; 50.16666667,163; 50.25,163; 50.33333333,163;
        50.41666667,162; 50.5,161; 50.58333333,161; 50.66666667,161; 50.75,161;
        50.83333333,160; 50.91666667,160; 51,160; 51.08333333,159; 51.16666667,159;
        51.25,159; 51.33333333,159; 51.41666667,158; 51.5,158; 51.58333333,158;
        54.37777778,148; 54.46111111,147; 54.54444444,147; 54.62777778,147; 54.71111111,
        147; 54.79444444,146; 54.87777778,146; 54.96111111,146; 55.04444444,145;
        55.12777778,145; 55.21111111,145; 55.29444444,145; 55.37777778,144; 55.46111111,
        144; 55.54444444,144; 55.62777778,144; 55.71111111,143; 55.79444444,143;
        55.87777778,143; 55.96111111,143; 56.04444444,142; 56.12777778,142; 56.21111111,
        142; 56.29444444,141; 56.37777778,141; 56.46111111,141; 56.54444444,141;
        56.62777778,140; 56.71111111,140; 56.79444444,140; 56.87777778,140; 56.96111111,
        139; 57.04444444,139; 57.12777778,139; 57.21111111,139; 57.29444444,138;
        57.37777778,138; 57.46111111,138; 57.54444444,137; 57.62777778,137; 57.71111111,
        137; 57.79444444,137; 57.87777778,136; 57.96111111,136; 58.04444444,136;
        58.12777778,136; 58.21111111,135; 58.29444444,135; 58.37777778,135; 58.46111111,
        134; 58.54444444,134; 58.62777778,134; 58.71111111,134; 58.79444444,133;
        58.87777778,133; 58.96111111,133; 59.04444444,133; 59.12777778,132; 59.21111111,
        132; 59.29444444,132; 59.37777778,132; 59.46111111,131; 59.54444444,131;
        59.62777778,131; 59.71111111,131; 59.79444444,130; 59.87777778,130; 59.96111111,
        130; 60.04444444,130; 60.12777778,129; 60.21111111,129; 60.29444444,129;
        60.37777778,129; 60.46111111,128; 60.54444444,128; 60.62777778,128; 60.71111111,
        128; 60.79444444,128; 60.87777778,127; 60.96111111,127; 61.84166667,124;
        61.925,124; 62.00833333,124; 62.09166667,124; 62.175,123; 62.25833333,123;
        62.34166667,123; 62.425,123; 62.50833333,123; 62.59166667,122; 62.675,122;
        62.75833333,122; 62.84166667,122; 62.925,121; 63.00833333,121; 63.09166667,
        121; 63.175,121; 63.25833333,120; 63.34166667,120; 63.425,120; 63.50833333,
        120; 63.59166667,120; 64.93333333,116; 65.01666667,116; 65.1,115; 65.18333333,
        115; 65.26666667,115; 65.35,115; 65.43333333,114; 65.51666667,114; 65.6,
        114; 65.68333333,114; 65.76666667,114; 65.85,113; 65.93333333,113; 66.01666667,
        113; 66.1,113; 66.18333333,113; 66.26666667,112; 67.49166667,109; 67.575,
        109; 67.65833333,109; 67.74166667,109; 67.825,108; 67.90833333,108; 67.99166667,
        108; 68.075,108; 68.15833333,108; 68.24166667,107; 68.325,107; 68.40833333,
        107; 68.68333333,106; 68.76666667,106; 68.85,106; 68.93333333,106; 69.01666667,
        106; 69.1,105; 69.18333333,105; 69.26666667,105; 69.35,105; 69.43333333,
        105; 70.50277778,102; 70.58611111,102; 70.66944444,102; 70.75277778,102;
        71.53333333,99.7; 71.61666667,99.5; 71.7,99.3; 71.78333333,99.1; 72.21111111,
        98.3; 72.45555556,98.1],
    timeScale=3600,
    offset=0,
    shiftTime=-8700)
    annotation (Placement(transformation(extent={{-116,10},{-96,30}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure(y=PCM_Core.T_TCs[4])
    annotation (Placement(transformation(extent={{-86,90},{-66,110}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure1(y=PCM_Core.T_TCs[9])
    annotation (Placement(transformation(extent={{-106,-54},{-86,-34}})));
  Components.RMSE_Calculator rMSE_Calculator
    annotation (Placement(transformation(extent={{-68,-36},{-48,-16}})));
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
  connect(Experiment_Measure_TC13.y, rMSE_Calculator.u1) annotation (Line(
        points={{-95,20},{-78,20},{-78,-20},{-70,-20}}, color={0,0,127}));
  connect(T_Vessel_Measure1.y, rMSE_Calculator.u2) annotation (Line(points={{
          -85,-44},{-78,-44},{-78,-32},{-70,-32}}, color={0,0,127}));
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
end HITB_Experiment_Second_Discharge2;
