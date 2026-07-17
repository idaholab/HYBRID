within NHES.Systems.EnergyStorage.PCM_HITB.Examples.Final_Runs_Model_Update;
model HITB_Experiment_01_Calibrate
  "First discharge run with data read in the system."
extends Modelica.Icons.Example;
  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable NHES.Systems.EnergyStorage.PCM_HITB.CS.CS_Calibrate1
      CS,
    redeclare Data.Data_System data,
    data_Initialization(
      T_PCM=361.65,
      T_Wall=358.15,
      T_HT=358.15,
      T_Insulation_Inner=353.15,
      T_Insulation_Outer=303.15,
      T_Tube_UGT=373.15,
      T_Insulation_UGT=373.15,
      T_UHP=373.15,
      T_Tube_LGT=373.15,
      T_Insulation_LGT=373.15,
      T_LHP=373.15));
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
  Modelica.Blocks.Sources.TimeTable Temperature_Reference_TC11(table=[0,89.7;
        300,89.6; 600,89.5; 900,90.3; 1200,90.3; 1500,93; 1800,97.1; 2100,98.9;
        2400,103; 2700,105; 3000,110; 3300,114; 3600,118; 3900,120; 4200,126;
        4500,130; 4800,133; 5100,140; 5400,144; 5700,147; 6000,151; 6110,155;
        7022,167.9; 7934,180.8; 8846,193.7; 9758,206.6; 10670,219.5; 11582,
        232.4; 12494,245.3; 13406,258.2; 14318,271.1; 15230,284; 15320,284;
        15620,285; 15920,285; 16220,290; 16520,290; 16820,290; 17120,290; 17420,
        304; 17720,307; 18020,310; 18320,312; 18620,316; 18920,319; 19220,319;
        19520,323; 19820,325; 20120,329; 20420,332; 20720,335; 21020,335; 21320,
        339; 21620,342; 21920,346; 22220,349; 22520,351; 22820,354; 23120,357;
        23420,357; 23720,360; 24020,360; 24320,360; 24620,368; 24920,370; 25220,
        371; 25520,371; 25820,376; 26120,377; 26420,379; 26720,380; 27020,381;
        27320,383; 27620,384; 27920,385; 28220,386; 28520,387; 28820,389; 29120,
        389; 29420,391; 29720,391; 30020,392; 30320,393; 30620,393; 30920,394;
        31220,395; 31520,396; 31820,396; 32120,397; 32420,397; 32720,398; 33020,
        398; 33320,399; 33620,399; 33920,400; 34220,400; 34520,400; 34820,401;
        35120,401; 35420,401; 35720,402; 36020,402; 36320,402; 36620,402; 36920,
        403; 37220,403; 37520,403; 37820,403; 38120,403; 38420,404; 38720,404;
        39020,404; 39320,404; 39620,404; 39920,405; 40220,405; 40520,405; 40820,
        405; 41120,405; 41420,405; 41720,405; 42020,405; 42320,405; 42620,405;
        42920,405; 43220,405; 43520,405; 43820,405; 44120,406; 44420,406; 44720,
        406; 45020,406; 45320,406; 45620,406; 45920,406; 46220,406; 46520,406;
        46820,406; 47120,406; 47420,406; 47720,406; 48020,406; 48320,406; 48620,
        406; 48920,406; 49220,406; 49520,406; 49820,406; 50120,406; 50420,406;
        50720,406; 51020,406; 51320,406; 51620,406; 51920,406; 52220,406; 52520,
        406; 52820,406; 53120,406; 53420,406; 53720,406; 54020,406; 54320,406;
        54620,406; 54920,406; 55220,406; 55520,406; 55820,406; 56120,406; 56420,
        406; 56720,406; 57020,406; 57320,406; 57620,406; 57920,406; 58220,406;
        58520,406; 58820,406; 59120,406; 59420,406; 59720,406; 60020,406; 60320,
        406; 60620,406; 60920,406; 61220,406; 61520,406; 61820,406; 62120,406;
        62420,406; 62720,406; 63020,406; 63320,406; 63620,406; 63920,406; 64220,
        406; 64520,406; 64820,406; 65120,406; 65420,406; 65720,406; 66020,406;
        66320,406; 66620,406; 66920,406; 67220,406; 67520,406; 67820,406; 68120,
        406; 68420,406; 68720,406; 69020,405; 69320,405; 69620,405; 69920,405;
        70220,405; 70520,405; 70820,405; 71120,405; 71420,405; 71720,405; 72020,
        405; 72320,405; 72620,405; 72920,405; 73220,405; 73520,405; 73820,406;
        74120,405; 74420,405; 74720,405; 75020,405; 75320,405; 75620,405; 75920,
        405; 76220,405; 76520,405; 76820,405; 77120,405; 77420,405; 77720,405;
        78020,405; 78320,405; 78620,405; 78920,405; 79220,405; 79520,405; 79820,
        405; 80120,405; 80420,405; 80720,405; 81020,405; 81320,405; 81620,405;
        81920,405; 82220,405; 82520,405; 82820,405; 83120,405; 83420,405; 83720,
        405; 84020,405; 84320,405; 84620,405; 84920,405; 85220,405; 85520,405;
        85820,405; 86120,405; 86420,405; 86720,405; 87020,405; 87320,405; 87620,
        405; 87920,405; 88220,405; 88520,405; 88820,405; 89120,405; 89420,405;
        89720,405; 90020,405; 90320,405; 90620,405; 90920,405; 91220,405; 91520,
        405; 91820,405; 92120,405; 92420,406; 92720,406; 93020,407; 93320,407;
        93620,407; 93920,409; 94220,409; 94520,409; 94820,409; 95120,409; 95420,
        410; 95720,411; 96020,411; 96320,411; 96620,412; 96920,412; 97220,412;
        97520,412; 97820,413; 98120,413; 98420,413; 98720,414; 99020,414; 99320,
        414; 99620,415; 99920,415; 100220,416; 100520,416; 100820,417; 101120,
        417; 101420,418; 101720,419; 102020,419; 102320,420; 102620,420; 102920,
        421; 103220,421; 103520,422; 103820,422; 104120,423; 104420,423; 104720,
        424; 105020,425; 105320,425; 105620,425; 105920,426; 106220,426; 106520,
        427; 106820,427; 107120,428; 107420,429; 107720,429; 108020,429; 108320,
        430; 108620,430; 108920,431; 109220,431; 109520,432; 109820,432; 110120,
        432; 110420,433; 110720,433; 111020,434; 111320,434; 111620,434; 111920,
        435; 112220,435; 112520,435; 112820,436; 113120,436; 113420,437; 113720,
        437; 114020,437; 114320,437; 114620,438; 114920,438; 115220,439; 115520,
        439; 115820,439; 116120,440; 116420,440; 116720,440; 117020,440; 117320,
        440; 117620,441; 117920,441; 118220,441; 118520,442; 118820,442; 119120,
        442; 119420,442; 119720,443; 120020,443; 120320,443; 120620,443; 120920,
        444; 121220,444; 121520,444; 121820,444; 122120,444; 122420,444; 122720,
        444; 123020,445; 123320,445; 123620,445; 123920,445; 124220,445; 124520,
        445; 124820,445; 125120,445; 125420,446; 125720,446; 126020,446; 126320,
        446; 126620,446; 126920,446; 127220,446; 127520,446; 127820,446; 128120,
        446; 128420,446; 128720,446; 129020,446; 129320,447; 129620,447; 129920,
        447; 130220,447; 130520,447; 130820,447; 131120,447; 131420,447; 131720,
        447; 132020,447; 132320,447; 132620,447; 132920,447; 133220,447; 133520,
        447; 133820,447; 134120,447; 134420,447; 134720,447; 135020,447; 135320,
        447; 135620,447; 135920,447; 136220,447; 136520,447; 136820,447; 137120,
        447; 137420,447; 137720,447; 138020,448; 138320,448; 138620,448; 138920,
        448; 139220,448; 139520,448; 139820,448; 140120,448; 140420,448; 140720,
        448; 141020,448; 141320,448; 141620,448; 141920,448; 142220,448; 142520,
        448; 142820,448; 143120,448; 143420,448; 143720,448; 144020,448; 144320,
        448; 144620,448; 144920,448; 145220,448; 145520,448; 145820,448; 146120,
        448; 146420,448; 146720,448; 147020,448; 147320,448; 147620,448; 147920,
        448; 148220,448; 148520,448; 148820,448; 149120,448; 149420,448; 149720,
        448; 150020,448; 150320,448; 150620,448; 150920,448; 151220,448; 151520,
        448; 151820,448; 152120,448; 152420,448; 152720,448; 153020,448; 153320,
        448; 153620,448; 153920,448; 154220,448; 154520,448; 154820,448; 155120,
        448; 155420,448; 155720,448; 156020,448; 156320,448; 156620,448; 156920,
        448; 157220,448; 157520,448; 157820,448; 158120,448; 158420,448; 158720,
        448; 159020,448; 159320,448; 159620,448; 159920,448; 160220,448; 160520,
        448; 160820,449; 161120,449; 161420,449; 161720,449; 162020,448; 162320,
        449; 162620,449; 162920,449; 163220,449; 163520,449; 163820,449; 164120,
        449; 164420,449; 164720,449; 165020,449; 165320,449; 165620,449; 165920,
        449; 166220,449; 166520,449; 166820,449; 167120,449; 167420,449; 167720,
        449; 168020,449; 168320,449; 168620,449; 168920,449; 169220,449; 169520,
        449; 169820,449; 170120,449; 170420,449; 170720,449; 171020,449; 171320,
        449; 171620,449; 171920,449; 172220,449; 172520,449; 172820,449; 173120,
        449; 173420,449; 173720,449; 174020,449; 174320,449; 174620,449; 174920,
        449; 175220,449; 175520,449; 175820,449; 176120,449; 176420,449; 176720,
        449; 177020,449; 177320,449; 177620,449; 177920,449; 178220,449; 178520,
        449; 178820,449; 179120,449; 179420,449; 179720,449; 180020,449; 180320,
        449; 180620,449; 180920,449; 181220,449; 181520,449; 181820,449; 182120,
        449; 182420,448; 182720,448; 183020,448; 183320,448; 183620,448; 183920,
        448; 184220,448; 184520,448; 184820,448; 185120,448; 185420,448; 185720,
        448; 186020,448; 186320,448; 186620,448; 186920,447; 187220,447; 187520,
        447; 187820,447; 188120,447; 188420,446; 188720,446; 189020,446; 189320,
        446; 189620,445; 189920,445; 190220,445; 190520,444; 190820,444; 191120,
        444; 191420,443; 191720,442; 192020,442; 192320,441; 192620,440; 192920,
        440; 193220,439; 193520,438; 193820,437; 194120,435; 194420,434; 194720,
        433; 195020,431; 195320,428; 195620,427; 195920,427; 196220,427; 196520,
        422; 196820,420; 197120,419; 197420,419; 197720,416; 198020,414; 198320,
        413; 198620,413; 198920,411; 199220,409; 199520,408; 199820,407; 200120,
        407; 200420,407; 200720,403; 201020,403; 201320,403; 201620,400; 201920,
        399; 202220,398; 202520,397; 202820,396; 203120,394; 203420,393; 203720,
        392; 204020,392; 204320,390; 204620,390; 204920,388; 205220,388; 205520,
        386; 205820,385; 206120,384; 206420,383; 206720,383; 207020,383; 207320,
        380; 207620,379; 207920,378; 208220,377; 208520,376; 208820,375; 209120,
        374; 209420,373; 209720,372; 210020,371; 210320,370; 210620,369; 210920,
        369; 211220,367; 211520,366; 211820,365; 212120,364; 212420,363; 212720,
        363; 213020,362; 213320,361; 213620,360; 213920,359; 214220,358; 214520,
        357; 214820,356; 215120,355; 215420,355; 215720,355; 216020,353; 216320,
        353; 216620,351; 216920,351; 217220,349; 217520,349; 217820,348; 218120,
        347; 218420,346; 218720,345; 219020,345; 219320,343; 219620,343; 219920,
        342; 220220,341; 220520,340; 220820,339; 221120,338; 221420,338; 221720,
        337; 222020,336; 222320,335; 222620,335; 222920,335; 223220,333; 223520,
        333; 223820,332; 224120,331; 224420,330; 224720,329; 225020,328; 225320,
        327; 225620,327; 225920,326; 226220,325; 226520,325; 226820,324; 227120,
        323; 227420,323; 227720,321; 228020,321; 228320,320; 228620,319; 228920,
        318; 229220,318; 229520,317; 229820,316; 230120,316; 230420,315; 230720,
        314; 231020,313; 231320,312; 231620,312; 231920,311; 232220,310; 232520,
        310; 232820,309; 233120,308; 233420,307; 233720,307; 234020,306; 234320,
        306; 234620,305; 234920,304; 235220,303; 235520,303; 235820,302; 236120,
        301; 236420,300; 236720,300; 237020,299; 237320,298; 237620,298; 237920,
        297; 238220,297; 238520,296; 238820,295; 239120,294; 239420,294; 239720,
        293; 240020,293; 240320,292; 240620,291; 240920,290; 241220,290; 241520,
        289; 241820,289; 242120,288; 242420,287; 242720,286; 243020,286; 243320,
        286; 243620,285; 243920,284; 244220,283; 244520,283; 244820,283; 245120,
        283; 245420,283; 245720,283; 246020,283; 246320,279; 246620,278; 246920,
        277; 247220,277; 247520,276; 247820,276; 248120,275; 248420,275; 248720,
        274; 249020,274; 249320,273; 249620,272; 249920,271; 250220,271; 250520,
        270; 250820,270; 251120,269; 251420,268; 251720,268; 252020,267; 252320,
        267; 252620,266; 252920,265; 253220,265; 253520,264; 253820,263; 254120,
        263; 254420,262],
    offset=273.15,        shiftTime=-1200)
    annotation (Placement(transformation(extent={{-116,0},{-96,20}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure1(y=PCM_Core.T_TCs[9])
    annotation (Placement(transformation(extent={{-102,-30},{-82,-10}})));
  Components.RMSE_Calculator rMSE_Calculator
    annotation (Placement(transformation(extent={{-64,-12},{-44,8}})));
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
  connect(T_Vessel_Measure1.y, rMSE_Calculator.u2) annotation (Line(points={{
          -81,-20},{-74,-20},{-74,-8},{-66,-8}}, color={0,0,127}));
  connect(Temperature_Reference_TC11.y, rMSE_Calculator.u1) annotation (Line(
        points={{-95,10},{-76,10},{-76,4},{-66,4}}, color={0,0,127}));
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
end HITB_Experiment_01_Calibrate;
