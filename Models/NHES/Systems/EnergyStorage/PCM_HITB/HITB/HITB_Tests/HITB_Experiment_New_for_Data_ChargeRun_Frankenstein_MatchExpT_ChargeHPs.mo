within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HITB_Tests;
model HITB_Experiment_New_for_Data_ChargeRun_Frankenstein_MatchExpT_ChargeHPs
  "Attempt 04 at HITB experiment. The full system needs to include a better representation of the piping losses. We shall restart the non-HITB portion."

  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";

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

  parameter Modelica.Units.SI.Length t_GT = 0.005 "Thickness of the guide tube wall";
  parameter Modelica.Units.SI.Length t_insulation_GT = 0.00001 "Thickness of insulation on the exterior of the guide tubes";

  Modelica.Units.SI.Power Q_CHX;
  Modelica.Units.SI.Power Q_DHX;
  Modelica.Units.SI.Power Q_CHX_theory;
  Modelica.Units.SI.Power Q_DHX_theory;
  parameter Modelica.Units.SI.Power Q_Max = 3000;
  parameter Modelica.Units.SI.Time T_integrator = 3;
  parameter Modelica.Units.SI.Time T_antiwindup = 10;
  parameter Modelica.Units.SI.Time timer_HPs = 91810;
  parameter Modelica.Units.SI.Temperature T_Setpoint_Vessel = 400+273.15;
  parameter Modelica.Units.SI.Temperature T_Setpoint_HP = 460+273.15;
  parameter Real w_prop= 1.0;
//  Modelica.Units.SI.Power Q_loss;
  parameter Modelica.Units.SI.Temperature T_melt = 443+273.15 "Used for graphics only";
  Modelica.Units.SI.Time time_plot;
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 35;
  parameter Modelica.Units.SI.Temperature T_air = 273.15+250 "Air inside the shipping container estimate";

  Components.PCM_Volume.PCM_Chamber_vertsym_03_doubleinsulated PCM_Core(
    nZ=nV_Z,
    t_insulation_inner=0.021,
    t_insulation_outer=0.021,
    hc_air=hc_air,
    T_Init=363.15,
    T_Init_Wall=358.15,
    T_Init_Insulation_Inner=356.15,
    T_Init_Insulation_Outer=303.15,
    T_Init_HT=356.15,
    Q_heat_trace=Q_Vessel_HT.y*ones(11, nV_Z)/(11*nV_Z),
    redeclare package Insulation_Material_Inner = HITB.PCM_Materials.Insulator,
    redeclare package Insulation_Material_Outer =
        HITB.PCM_Materials.Insulator_aerogel,
    redeclare package PCM_Material =
        HITB.PCM_Materials.PCM_HITB_2_Sin_reduced_density_fix)
    annotation (Placement(transformation(extent={{206,-38},{108,64}})));

  Modelica.Blocks.Sources.CombiTimeTable signal_position_upper(table=[0,0; 120000,
        0; 121000,0; 125000,0; 432000,0])
    annotation (Placement(transformation(extent={{-4,90},{16,110}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Upper_Table(table=[0,0; 105500,0;
        105600,0; 125000,0; 125500,0; 432000,0])
    annotation (Placement(transformation(extent={{-44,78},{-24,98}})));
  Components.Guide_Tube Lower_Guide_Tube(
    nV_Z=nV_Z,
    nV_ZGTe=8,
    nV_ZHT=5,
    l_CHX=l_CHX,
    l_CHX_gap=l_gap_CHX,
    l_DHX=l_DHX,
    l_DHX_gap=l_gap_DHX,
    l_Battery=l_PCM,
    T_init_tube=373.15,
    T_init_insulation=373.15,
    r_outer=R_HITB,
    t_insulation_CHX_Inner=0.021,
    t_insulation_CHX_Outer=0.021,
    t_insulation_DHX=0.021,
    redeclare package Insulation_Material_CHX_Outer =
        HITB.PCM_Materials.Insulator,
    redeclare package Insulation_Material_CHX_Inner =
        HITB.PCM_Materials.Insulator_aerogel,
    redeclare package Insulation_Material_DHX =
        HITB.PCM_Materials.Insulator_aerogel,
    thickness=t_GT,
    hc_air=hc_air,
    z_min_heatpipe=signal_position_lower.y[1]*(l_experiment - l_HITB),
    z_max_heatpipe=l_HITB + signal_position_lower.y[1]*(l_experiment - l_HITB),
    nV_Zh=nV_Zh,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS304,
    Q_HP_Tape_Input=HT_Lower.y)
    annotation (Placement(transformation(extent={{78,-36},{148,2}})));

  Components.Guide_Tube Upper_Guide_Tube(
    nV_Z=nV_Z,
    nV_ZGTe=8,
    nV_ZHT=5,
    l_CHX=l_CHX,
    l_CHX_gap=l_gap_CHX,
    l_DHX=l_DHX,
    l_DHX_gap=l_gap_DHX,
    l_Battery=l_PCM,
    T_init_tube=373.15,
    T_init_insulation=373.15,
    r_outer=R_HITB,
    t_insulation_CHX_Inner=0.021,
    t_insulation_CHX_Outer=0.021,
    t_insulation_DHX=0.021,
    redeclare package Insulation_Material_CHX_Outer =
        HITB.PCM_Materials.Insulator,
    redeclare package Insulation_Material_CHX_Inner =
        HITB.PCM_Materials.Insulator_aerogel,
    redeclare package Insulation_Material_DHX =
        HITB.PCM_Materials.Insulator_aerogel,
    thickness=t_GT,
    hc_air=hc_air,
    z_min_heatpipe=signal_position_upper.y[1]*(l_experiment - l_HITB),
    z_max_heatpipe=l_HITB + signal_position_upper.y[1]*(l_experiment - l_HITB),
    nV_Zh=nV_Zh,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS304,
    Q_HP_Tape_Input=0*HT_Lower.y)
    annotation (Placement(transformation(extent={{78,62},{146,22}})));

  Components.Heat_Pipe_New heat_Pipe_New(
    nV_Z=nV_Zh,
    T_init=373.15,
    redeclare package Wick_Material =
        HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    redeclare package Tube_Material = HITB.PCM_Materials.Sodium_New (k_eff_mult
          =50),
    T_air_evaporator=Lower_Guide_Tube.Guide_Tube.materials[1, 1].T,
    T_air_condenser=Lower_Guide_Tube.Guide_Tube.materials[Lower_Guide_Tube.nR,
        Lower_Guide_Tube.nV_ZGT_Total].T)
    annotation (Placement(transformation(extent={{80,-28},{106,-4}})));
  Components.Heat_Pipe_New heat_Pipe_New1(
    nV_Z=nV_Zh,
    T_init=373.15,
    redeclare package Wick_Material =
        HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    redeclare package Tube_Material = HITB.PCM_Materials.Sodium_New (k_eff_mult
          =50),
    T_air_evaporator=Upper_Guide_Tube.Guide_Tube.materials[1, 1].T,
    T_air_condenser=Upper_Guide_Tube.Guide_Tube.materials[Upper_Guide_Tube.nR,
        Upper_Guide_Tube.nV_ZGT_Total].T)
    annotation (Placement(transformation(extent={{80,28},{106,54}})));
  Modelica.Blocks.Sources.CombiTimeTable signal_position_lower(table=[0,0; 120000,
        0; 121000,0; 125000,0; 432000,0])
    annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Lower_Table(table=[0,0; 105500,0;
        105600,0; 125000,0; 125500,0; 432000,0])
    annotation (Placement(transformation(extent={{-10,-32},{10,-12}})));
  Modelica.Blocks.Logical.Timer             timer
    annotation (Placement(transformation(extent={{-146,-6},{-126,14}})));
  TRANSFORM.Controls.LimPID HT_Lower(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    with_FF=false,
    k=25,
    Ti=600,
    yMax=1000,
    yMin=0.0,
    wd=0.1)   annotation (Placement(transformation(extent={{-46,46},{-26,66}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Control_Set_Upper(table=[0,673.15;
        105500,673.15; 105600,673.15; 125000,673.15; 125500,673.15; 432000,
        673.15])
    annotation (Placement(transformation(extent={{-110,78},{-90,98}})));
  Modelica.Blocks.Logical.Switch HT_Lower_Signal
    annotation (Placement(transformation(extent={{30,-56},{50,-36}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-24,-56},{-4,-36}})));
  TRANSFORM.Controls.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1e3,
    yMin=0.0)
    annotation (Placement(transformation(extent={{-26,-72},{-6,-52}})));
  Modelica.Blocks.Sources.RealExpression T_HT_HP_L(y=Upper_Guide_Tube.Guide_Tube.materials[
        Lower_Guide_Tube.Guide_Tube.geometry.nR, 3].T)
    annotation (Placement(transformation(extent={{-52,-92},{-32,-72}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Control_Set_Lower(table=[0,673.15;
        105500,673.15; 105600,673.15; 125000,673.15; 125500,673.15; 432000,
        673.15])
    annotation (Placement(transformation(extent={{-66,-68},{-46,-48}})));
  Modelica.Blocks.Sources.TimeTable Experiment_Measure_TC11(table=[0,87.5; 300,
        87.5; 600,87.9; 900,89.4; 1200,94.1; 1500,97.9; 1800,105; 2100,114;
        2400,121; 2700,125; 3000,133; 3300,138; 3600,143; 3900,149; 4200,157;
        4500,160; 4800,167; 5100,169; 5400,169; 5700,178; 6000,186; 6110,189;
        7022,200.2; 7934,211.4; 8846,222.6; 9758,233.8; 10670,245; 11582,256.2;
        12494,267.4; 13406,278.6; 14318,289.8; 15230,301; 15320,301; 15620,304;
        15920,307; 16220,309; 16520,313; 16820,314; 17120,316; 17420,321; 17720,
        322; 18020,324; 18320,329; 18620,331; 18920,333; 19220,335; 19520,337;
        19820,338; 20120,342; 20420,344; 20720,345; 21020,349; 21320,352; 21620,
        354; 21920,355; 22220,359; 22520,359; 22820,363; 23120,365; 23420,368;
        23720,368; 24020,373; 24320,374; 24620,377; 24920,378; 25220,380; 25520,
        382; 25820,383; 26120,385; 26420,386; 26720,387; 27020,388; 27320,388;
        27620,389; 27920,391; 28220,392; 28520,392; 28820,393; 29120,394; 29420,
        394; 29720,395; 30020,396; 30320,396; 30620,397; 30920,397; 31220,398;
        31520,398; 31820,399; 32120,399; 32420,399; 32720,400; 33020,400; 33320,
        400; 33620,401; 33920,401; 34220,401; 34520,401; 34820,402; 35120,402;
        35420,402; 35720,402; 36020,403; 36320,403; 36620,403; 36920,403; 37220,
        403; 37520,404; 37820,404; 38120,404; 38420,404; 38720,404; 39020,404;
        39320,405; 39620,405; 39920,405; 40220,405; 40520,405; 40820,405; 41120,
        405; 41420,405; 41720,405; 42020,405; 42320,405; 42620,405; 42920,405;
        43220,405; 43520,405; 43820,405; 44120,405; 44420,405; 44720,405; 45020,
        405; 45320,405; 45620,405; 45920,405; 46220,405; 46520,405; 46820,405;
        47120,405; 47420,405; 47720,405; 48020,405; 48320,405; 48620,405; 48920,
        405; 49220,405; 49520,406; 49820,406; 50120,406; 50420,405; 50720,406;
        51020,406; 51320,406; 51620,406; 51920,405; 52220,406; 52520,406; 52820,
        406; 53120,406; 53420,406; 53720,406; 54020,406; 54320,406; 54620,406;
        54920,406; 55220,406; 55520,406; 55820,406; 56120,406; 56420,406; 56720,
        406; 57020,406; 57320,406; 57620,406; 57920,406; 58220,406; 58520,406;
        58820,406; 59120,406; 59420,406; 59720,406; 60020,406; 60320,406; 60620,
        406; 60920,406; 61220,406; 61520,406; 61820,406; 62120,406; 62420,406;
        62720,406; 63020,406; 63320,406; 63620,406; 63920,406; 64220,406; 64520,
        406; 64820,406; 65120,406; 65420,406; 65720,406; 66020,406; 66320,406;
        66620,406; 66920,406; 67220,406; 67520,406; 67820,406; 68120,406; 68420,
        406; 68720,406; 69020,405; 69320,405; 69620,405; 69920,405; 70220,405;
        70520,405; 70820,405; 71120,405; 71420,405; 71720,405; 72020,405; 72320,
        405; 72620,405; 72920,405; 73220,405; 73520,405; 73820,405; 74120,405;
        74420,405; 74720,405; 75020,405; 75320,405; 75620,405; 75920,405; 76220,
        405; 76520,405; 76820,405; 77120,405; 77420,405; 77720,405; 78020,405;
        78320,405; 78620,405; 78920,405; 79220,405; 79520,405; 79820,405; 80120,
        405; 80420,405; 80720,405; 81020,405; 81320,405; 81620,405; 81920,405;
        82220,405; 82520,405; 82820,405; 83120,405; 83420,405; 83720,405; 84020,
        405; 84320,405; 84620,405; 84920,405; 85220,405; 85520,405; 85820,405;
        86120,405; 86420,405; 86720,405; 87020,405; 87320,405; 87620,405; 87920,
        405; 88220,405; 88520,405; 88820,405; 89120,405; 89420,405; 89720,405;
        90020,405; 90320,405; 90620,405; 90920,405; 91220,405; 91520,405; 91820,
        406; 92120,407; 92420,409; 92720,410; 93020,411; 93320,412; 93620,413;
        93920,414; 94220,415; 94520,416; 94820,416; 95120,417; 95420,417; 95720,
        417; 96020,418; 96320,418; 96620,419; 96920,419; 97220,419; 97520,419;
        97820,419; 98120,420; 98420,420; 98720,421; 99020,422; 99320,423; 99620,
        424; 99920,424; 100220,425; 100520,426; 100820,427; 101120,427; 101420,
        428; 101720,429; 102020,430; 102320,430; 102620,431; 102920,431; 103220,
        432; 103520,432; 103820,433; 104120,433; 104420,434; 104720,434; 105020,
        435; 105320,435; 105620,436; 105920,436; 106220,437; 106520,437; 106820,
        437; 107120,438; 107420,438; 107720,439; 108020,439; 108320,439; 108620,
        440; 108920,440; 109220,441; 109520,441; 109820,441; 110120,442; 110420,
        442; 110720,443; 111020,443; 111320,443; 111620,444; 111920,444; 112220,
        444; 112520,445; 112820,445; 113120,445; 113420,446; 113720,446; 114020,
        446; 114320,446; 114620,447; 114920,447; 115220,447; 115520,447; 115820,
        447; 116120,447; 116420,448; 116720,448; 117020,448; 117320,448; 117620,
        448; 117920,448; 118220,448; 118520,449; 118820,449; 119120,449; 119420,
        449; 119720,449; 120020,449; 120320,449; 120620,449; 120920,449; 121220,
        449; 121520,449; 121820,449; 122120,449; 122420,449; 122720,449; 123020,
        450; 123320,450; 123620,450; 123920,450; 124220,450; 124520,450; 124820,
        450; 125120,450; 125420,450; 125720,450; 126020,450; 126320,450; 126620,
        450; 126920,450; 127220,451; 127520,451; 127820,451; 128120,451; 128420,
        451; 128720,451; 129020,451; 129320,451; 129620,451; 129920,451; 130220,
        451; 130520,451; 130820,452; 131120,452; 131420,452; 131720,452; 132020,
        452; 132320,452; 132620,452; 132920,452; 133220,452; 133520,452; 133820,
        452; 134120,452; 134420,452; 134720,452; 135020,453; 135320,453; 135620,
        453; 135920,453; 136220,453; 136520,453; 136820,453; 137120,453; 137420,
        453; 137720,453; 138020,453; 138320,453; 138620,453; 138920,453; 139220,
        453; 139520,453; 139820,453; 140120,453; 140420,453; 140720,453; 141020,
        453; 141320,453; 141620,453; 141920,453; 142220,454; 142520,454; 142820,
        454; 143120,454; 143420,454; 143720,454; 144020,454; 144320,454; 144620,
        454; 144920,454; 145220,454; 145520,454; 145820,454; 146120,454; 146420,
        454; 146720,454; 147020,454; 147320,454; 147620,454; 147920,454; 148220,
        454; 148520,454; 148820,454; 149120,454; 149420,454; 149720,454; 150020,
        454; 150320,454; 150620,454; 150920,454; 151220,454; 151520,455; 151820,
        455; 152120,455; 152420,455; 152720,455; 153020,455; 153320,455; 153620,
        455; 153920,455; 154220,455; 154520,455; 154820,455; 155120,455; 155420,
        455; 155720,455; 156020,455; 156320,455; 156620,455; 156920,455; 157220,
        455; 157520,455; 157820,455; 158120,455; 158420,455; 158720,455; 159020,
        455; 159320,455; 159620,455; 159920,455; 160220,455; 160520,455; 160820,
        455; 161120,455; 161420,455; 161720,455; 162020,455; 162320,455; 162620,
        455; 162920,455; 163220,455; 163520,455; 163820,455; 164120,455; 164420,
        455; 164720,455; 165020,455; 165320,455; 165620,455; 165920,455; 166220,
        455; 166520,455; 166820,455; 167120,455; 167420,456; 167720,456; 168020,
        456; 168320,457; 168620,457; 168920,457; 169220,457; 169520,457; 169820,
        457; 170120,457; 170420,457; 170720,457; 171020,457; 171320,457; 171620,
        457; 171920,457; 172220,457; 172520,457; 172820,457; 173120,457; 173420,
        457; 173720,457; 174020,457; 174320,457; 174620,458; 174920,458; 175220,
        458; 175520,458; 175820,458; 176120,458; 176420,458; 176720,458; 177020,
        458; 177320,458; 177620,458; 177920,455; 178220,453; 178520,451; 178820,
        449; 179120,449; 179420,448; 179720,448; 180020,448; 180320,448; 180620,
        448; 180920,448; 181220,447; 181520,447; 181820,447; 182120,447; 182420,
        447; 182720,447; 183020,447; 183320,447; 183620,446; 183920,446; 184220,
        446; 184520,446; 184820,446; 185120,446; 185420,445; 185720,445; 186020,
        445; 186320,445; 186620,445; 186920,445; 187220,445; 187520,444; 187820,
        444; 188120,444; 188420,444; 188720,443; 189020,443; 189320,443; 189620,
        442; 189920,442; 190220,442; 190520,442; 190820,441; 191120,441; 191420,
        441; 191720,440; 192020,440; 192320,439; 192620,438; 192920,438; 193220,
        437; 193520,436; 193820,434; 194120,432; 194420,430; 194720,427; 195020,
        425; 195320,423; 195620,420; 195920,417; 196220,415; 196520,414; 196820,
        412; 197120,412; 197420,409; 197720,408; 198020,407; 198320,406; 198620,
        404; 198920,403; 199220,401; 199520,400; 199820,399; 200120,398; 200420,
        397; 200720,395; 201020,395; 201320,394; 201620,392; 201920,391; 202220,
        390; 202520,389; 202820,388; 203120,386; 203420,386; 203720,385; 204020,
        383; 204320,382; 204620,382; 204920,380; 205220,380; 205520,379; 205820,
        377; 206120,376; 206420,375; 206720,375; 207020,374; 207320,372; 207620,
        371; 207920,370; 208220,369; 208520,368; 208820,367; 209120,366; 209420,
        365; 209720,365; 210020,364; 210320,363; 210620,362; 210920,361; 211220,
        360; 211520,359; 211820,358; 212120,357; 212420,356; 212720,356; 213020,
        355; 213320,354; 213620,353; 213920,352; 214220,351; 214520,350; 214820,
        349; 215120,348; 215420,348; 215720,347; 216020,346; 216320,345; 216620,
        344; 216920,343; 217220,342; 217520,342; 217820,341; 218120,340; 218420,
        339; 218720,338; 219020,337; 219320,336; 219620,336; 219920,335; 220220,
        334; 220520,333; 220820,332; 221120,332; 221420,331; 221720,330; 222020,
        329; 222320,328; 222620,328; 222920,327; 223220,326; 223520,325; 223820,
        324; 224120,324; 224420,323; 224720,322; 225020,322; 225320,321; 225620,
        320; 225920,319; 226220,318; 226520,318; 226820,317; 227120,316; 227420,
        315; 227720,314; 228020,314; 228320,313; 228620,312; 228920,312; 229220,
        311; 229520,310; 229820,309; 230120,309; 230420,308; 230720,307; 231020,
        306; 231320,306; 231620,305; 231920,304; 232220,303; 232520,303; 232820,
        302; 233120,301; 233420,301; 233720,300; 234020,299; 234320,298; 234620,
        298; 234920,297; 235220,297; 235520,296; 235820,295; 236120,294; 236420,
        294; 236720,293; 237020,292; 237320,292; 237620,292; 237920,290; 238220,
        290; 238520,289; 238820,288; 239120,288; 239420,287; 239720,286; 240020,
        286; 240320,285; 240620,284; 240920,284; 241220,284; 241520,283; 241820,
        283; 242120,281; 242420,280; 242720,280; 243020,279; 243320,279; 243620,
        278; 243920,277; 244220,277; 244520,277; 244820,275; 245120,275; 245420,
        274; 245720,273; 246020,273; 246320,272; 246620,272; 246920,271; 247220,
        270; 247520,270; 247820,269; 248120,269; 248420,268; 248720,267; 249020,
        267; 249320,266; 249620,266; 249920,265; 250220,264; 250520,264; 250820,
        263; 251120,262; 251420,262; 251720,262; 252020,261; 252320,260; 252620,
        260; 252920,259; 253220,258; 253520,258; 253820,257; 254120,257; 254420,
        256],                    offset=273.15)
    annotation (Placement(transformation(extent={{-174,-48},{-154,-28}})));
  TRANSFORM.Controls.LimPID Q_Vessel_HT(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=T_integrator,
    Td=300,
    yMax=Q_Max/2,
    yMin=0,
    wp=w_prop,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    xd_start=0,
    y_start=0)
    annotation (Placement(transformation(extent={{-66,-6},{-46,14}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure(y=PCM_Core.T_TCs[4])
    annotation (Placement(transformation(extent={{-100,-42},{-80,-22}})));
  Modelica.Blocks.Sources.TimeTable Experiment_Measure_TC28(table=[0,82.2; 100,82.3;
        200,82.2; 300,82.2; 400,82.6; 500,83.6; 600,87; 700,89.8; 800,94.6; 900,
        100; 1000,105; 1100,111; 1200,115; 1300,121; 1400,125; 1500,128; 1600,136;
        1700,140; 1800,145; 1900,150; 2000,155; 2100,160; 2200,164; 2300,169; 2400,
        172; 2500,176; 2600,182; 2700,186; 2800,189; 2900,194; 3000,197; 3100,202;
        3200,205; 3300,209; 3400,213; 3500,216; 3600,219; 3700,223; 3800,225; 3900,
        229; 4000,232; 4100,235; 4200,236; 4300,239; 4400,242; 4500,246; 4600,247;
        4700,250; 4800,253; 4900,255; 5000,257; 5100,260; 5200,262; 5300,264; 5400,
        264; 5500,267; 5600,270; 5700,271; 5800,274; 5900,275; 6000,277; 6100,278;
        6110,278; 7022,286.4; 7934,294.8; 8846,303.2; 9758,311.6; 10670,320; 11582,
        328.4; 12494,336.8; 13406,345.2; 14318,353.6; 15230,362; 15420,363; 15520,
        363; 15620,364; 15720,365; 15820,365; 15920,366; 16020,367; 16120,367; 16220,
        368; 16320,369; 16420,369; 16520,370; 16620,371; 16720,371; 16820,372; 16920,
        372; 17020,373; 17120,374; 17220,374; 17320,375; 17420,376; 17520,376; 17620,
        377; 17720,377; 17820,378; 17920,378; 18020,379; 18120,379; 18220,379; 18320,
        380; 18420,380; 18520,381; 18620,381; 18720,381; 18820,382; 18920,382; 19020,
        382; 19120,382; 19220,383; 19320,384; 19420,384; 19520,385; 19620,385; 19720,
        386; 19820,387; 19920,387; 20020,388; 20120,389; 20220,390; 20320,391; 20420,
        391; 20520,392; 20620,393; 20720,393; 20820,394; 20920,395; 21020,395; 21120,
        396; 21220,397; 21320,397; 21420,398; 21520,399; 21620,399; 21720,400; 21820,
        400; 21920,401; 22020,402; 22120,402; 22220,403; 22320,404; 22420,404; 22520,
        405; 22620,405; 22720,406; 22820,407; 22920,407; 23020,408; 23120,408; 23220,
        409; 23320,409; 23420,410; 23520,411; 23620,411; 23720,412; 23820,412; 23920,
        413; 24020,413; 24120,414; 24220,414; 24320,414; 24420,415; 24520,415; 24620,
        415; 24720,415; 24820,415; 24920,415; 25020,415; 25120,415; 25220,415; 25320,
        415; 25420,415; 25520,415; 25620,414; 25720,414; 25820,414; 25920,414; 26020,
        414; 26120,413; 26220,413; 26320,413; 26420,413; 26520,413; 26620,412; 26720,
        412; 26820,412; 26920,412; 27020,412; 27120,412; 27220,411; 27320,411; 27420,
        411; 27520,411; 27620,411; 27720,411; 27820,410; 27920,410; 28020,410; 28120,
        410; 28220,410; 28320,410; 28420,410; 28520,409; 28620,409; 28720,409; 28820,
        409; 28920,409; 29020,409; 29120,409; 29220,409; 29320,409; 29420,408; 29520,
        408; 29620,408; 29720,408; 29820,408; 29920,408; 30020,408; 30120,408; 30220,
        407; 30320,407; 30420,407; 30520,407; 30620,407; 30720,407; 30820,407; 30920,
        407; 31020,406; 31120,406; 31220,406; 31320,406; 31420,406; 31520,406; 31620,
        406; 31720,406; 31820,406; 31920,405; 32020,405; 32120,405; 32220,405; 32320,
        405; 32420,405; 32520,405; 32620,404; 32720,404; 32820,404; 32920,404; 33020,
        404; 33120,404; 33220,404; 33320,404; 33420,404; 33520,404; 33620,404; 33720,
        404; 33820,404; 33920,404; 34020,403; 34120,403; 34220,403; 34320,403; 34420,
        403; 34520,403; 34620,403; 34720,403; 34820,403; 34920,403; 35020,403; 35120,
        403; 35220,403; 35320,402; 35420,402; 35520,402; 35620,402; 35720,402; 35820,
        402; 35920,402; 36020,402; 36120,402; 36220,402; 36320,402; 36420,402; 36520,
        402; 36620,402; 36720,402; 36820,401; 36920,401; 37020,401; 37120,401; 37220,
        401; 37320,401; 37420,401; 37520,401; 37620,401; 37720,401; 37820,401; 37920,
        401; 38020,401; 38120,401; 38220,401; 38320,401; 38420,401; 38520,401; 38620,
        401; 38720,401; 38820,401; 38920,400; 39020,400; 39120,400; 39220,400; 39320,
        400; 39420,400; 39520,400; 39620,400; 39720,400; 39820,400; 39920,400; 40020,
        400; 40120,400; 40220,400; 40320,400; 40420,400; 40520,400; 40620,400; 40720,
        400; 40820,400; 40920,400; 41020,400; 41120,400; 41220,400; 41320,400; 41420,
        400; 41520,400; 41620,400; 41720,400; 41820,400; 41920,400; 42020,400; 42120,
        400; 42220,400; 42320,400; 42420,400; 42520,400; 42620,400; 42720,400; 42820,
        400; 42920,399; 43020,399; 43120,399; 43220,399; 43320,399; 43420,399; 43520,
        399; 43620,399; 43720,399; 43820,399; 43920,399; 44020,399; 44120,399; 44220,
        399; 44320,399; 44420,399; 44520,399; 44620,399; 44720,399; 44820,399; 44920,
        399; 45020,399; 45120,399; 45220,399; 45320,399; 45420,399; 45520,399; 45620,
        399; 45720,399; 45820,399; 45920,399; 46020,399; 46120,399; 46220,399; 46320,
        399; 46420,399; 46520,399; 46620,399; 46720,399; 46820,399; 46920,399; 47020,
        399; 47120,399; 47220,399; 47320,399; 47420,399; 47520,399; 47620,399; 47720,
        399; 47820,399; 47920,399; 48020,399; 48120,399; 48220,399; 48320,399; 48420,
        399; 48520,399; 48620,399; 48720,399; 48820,399; 48920,399; 49020,399; 49120,
        399; 49220,399; 49320,399; 49420,399; 49520,399; 49620,399; 49720,399; 49820,
        399; 49920,399; 50020,399; 50120,399; 50220,399; 50320,399; 50420,399; 50520,
        399; 50620,399; 50720,399; 50820,399; 50920,399; 51020,399; 51120,398; 51220,
        398; 51320,399; 51420,399; 51520,398; 51620,398; 51720,399; 51820,399; 51920,
        399; 52020,399; 52120,399; 52220,399; 52320,399; 52420,399; 52520,399; 52620,
        399; 52720,399; 52820,399; 52920,399; 53020,399; 53120,399; 53220,399; 53320,
        399; 53420,398; 53520,399; 53620,399; 53720,398; 53820,398; 53920,398; 54020,
        398; 54120,398; 54220,398; 54320,398; 54420,398; 54520,398; 54620,398; 54720,
        398; 54820,398; 54920,398; 55020,398; 55120,398; 55220,398; 55320,398; 55420,
        398; 55520,398; 55620,398; 55720,398; 55820,398; 55920,398; 56020,398; 56120,
        398; 56220,398; 56320,398; 56420,398; 56520,398; 56620,398; 56720,398; 56820,
        398; 56920,398; 57020,398; 57120,398; 57220,398; 57320,398; 57420,398; 57520,
        398; 57620,398; 57720,398; 57820,398; 57920,398; 58020,398; 58120,398; 58220,
        398; 58320,398; 58420,398; 58520,398; 58620,398; 58720,398; 58820,398; 58920,
        398; 59020,398; 59120,398; 59220,398; 59320,398; 59420,398; 59520,398; 59620,
        398; 59720,398; 59820,398; 59920,398; 60020,398; 60120,398; 60220,398; 60320,
        398; 60420,398; 60520,398; 60620,398; 60720,398; 60820,398; 60920,398; 61020,
        398; 61120,398; 61220,398; 61320,398; 61420,398; 61520,398; 61620,398; 61720,
        398; 61820,398; 61920,398; 62020,398; 62120,398; 62220,398; 62320,398; 62420,
        398; 62520,398; 62620,398; 62720,398; 62820,398; 62920,398; 63020,398; 63120,
        398; 63220,398; 63320,398; 63420,398; 63520,398; 63620,398; 63720,398; 63820,
        398; 63920,398; 64020,398; 64120,398; 64220,398; 64320,398; 64420,398; 64520,
        398; 64620,398; 64720,398; 64820,398; 64920,398; 65020,398; 65120,398; 65220,
        398; 65320,398; 65420,398; 65520,398; 65620,398; 65720,398; 65820,398; 65920,
        398; 66020,398; 66120,398; 66220,398; 66320,398; 66420,398; 66520,398; 66620,
        398; 66720,398; 66820,398; 66920,398; 67020,398; 67120,398; 67220,398; 67320,
        398; 67420,398; 67520,398; 67620,398; 67720,398; 67820,398; 67920,398; 68020,
        398; 68120,398; 68220,398; 68320,398; 68420,398; 68520,398; 68620,398; 68720,
        398; 68820,398; 68920,398; 69020,398; 69120,398; 69220,398; 69320,398; 69420,
        398; 69520,398; 69620,398; 69720,398; 69820,398; 69920,398; 70020,398; 70120,
        398; 70220,398; 70320,398; 70420,398; 70520,398; 70620,398; 70720,398; 70820,
        398; 70920,398; 71020,398; 71120,398; 71220,398; 71320,398; 71420,398; 71520,
        398; 71620,398; 71720,398; 71820,398; 71920,398; 72020,398; 72120,398; 72220,
        398; 72320,398; 72420,398; 72520,398; 72620,398; 72720,398; 72820,398; 72920,
        398; 73020,398; 73120,398; 73220,398; 73320,398; 73420,398; 73520,398; 73620,
        398; 73720,398; 73820,398; 73920,398; 74020,399; 74120,399; 74220,399; 74320,
        399; 74420,398; 74520,398; 74620,398; 74720,398; 74820,398; 74920,398; 75020,
        398; 75120,398; 75220,398; 75320,398; 75420,398; 75520,398; 75620,398; 75720,
        398; 75820,398; 75920,398; 76020,398; 76120,398; 76220,398; 76320,398; 76420,
        398; 76520,398; 76620,398; 76720,398; 76820,398; 76920,398; 77020,398; 77120,
        398; 77220,398; 77320,398; 77420,398; 77520,398; 77620,398; 77720,398; 77820,
        398; 77920,398; 78020,398; 78120,398; 78220,398; 78320,398; 78420,398; 78520,
        398; 78620,398; 78720,398; 78820,398; 78920,398; 79020,398; 79120,398; 79220,
        398; 79320,398; 79420,398; 79520,398; 79620,398; 79720,398; 79820,398; 79920,
        398; 80020,398])
    annotation (Placement(transformation(extent={{-158,70},{-138,90}})));
  Modelica.Blocks.Logical.Switch HP_Initiator
    annotation (Placement(transformation(extent={{-92,44},{-72,64}})));
  Modelica.Blocks.Logical.Switch HP_Initiator1
    annotation (Placement(transformation(extent={{-132,-40},{-112,-20}})));
  Modelica.Blocks.Sources.BooleanExpression
                                         T_HT_HP_U1(y=true)
    annotation (Placement(transformation(extent={{-178,-6},{-158,14}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       timer_HPs)
    annotation (Placement(transformation(extent={{-112,-6},{-92,14}})));
  Modelica.Blocks.Sources.RealExpression T_HT_HP_L1(y=T_Setpoint_Vessel)
    annotation (Placement(transformation(extent={{-174,-26},{-154,-6}})));
  Modelica.Blocks.Sources.RealExpression T_HT_HP_L2(y=T_Setpoint_HP)
    annotation (Placement(transformation(extent={{-138,52},{-118,72}})));
protected
  Real Q_CHX_linear(unit = "W/m") = Q_CHX_theory/l_CHX;
  Real Q_DHX_linear(unit = "W/m") = Q_DHX_theory/l_DHX;
equation
  time_plot = time;
  cp_out = PCM_Core.conduction.Material.specificHeatCapacityCp(PCM_Core.conduction.materials[1,1, 1].state);
  Position =signal_position_upper.y[1];
  der(E_store) = sum(PCM_Core.port_b.Q_flow);
//  A_Cyl_HITB = HITB_Main.geometry.crossAreas_2[:,1];

  Q_CHX = Q_CHX_theory*(0.5-min(Position,0.5))/0.5;
  Q_DHX = Q_DHX_theory*(max(0.5,Position)-0.5)/0.5;
  Q_CHX_theory =max(0, HT_Lower_Table.y[1]);
  Q_DHX_theory =min(0, HT_Upper_Table.y[1]);

  //  SA_PCM_HITB = z_overlap.*Modelica.Constants.pi*2*R_HITB;

  /* NOTES 
  The heat rate by node for the charging and discharging heat exchangers both need to be adjusted to account for the fact
  that the rod is moving. At the moment, the entire rod is being heated & cooled evenly. The overall heat rate is still being 
  adjusted and is accounted for, but this i snot accurate. The heat needs to be inserted to the correct nodes only.
  
  
  
  */

  connect(Upper_Guide_Tube.port_battery, PCM_Core.port_b[:, 1]) annotation (
      Line(points={{114.72,34.4},{135.44,34.4},{135.44,14.8},{171.088,14.8}},
        color={191,0,0}));
  connect(Lower_Guide_Tube.port_battery, PCM_Core.port_b[:, 2]) annotation (
      Line(points={{115.8,-9.78},{136,-9.78},{136,14.8},{171.088,14.8}},
        color={191,0,0}));
  connect(heat_Pipe_New1.heat_pipe_port, Upper_Guide_Tube.port_HP) annotation (
      Line(points={{97.68,46.72},{79.64,46.72},{79.64,37.6},{85.48,37.6}},
                                                          color={191,0,0}));
  connect(heat_Pipe_New.heat_pipe_port, Lower_Guide_Tube.port_HP) annotation (
      Line(points={{97.68,-10.72},{76,-10.72},{76,-12.82},{85.7,-12.82}},
                                                         color={191,0,0}));
  connect(PID1.y, HT_Lower_Signal.u3) annotation (Line(points={{-5,-62},{22,-62},
          {22,-54},{28,-54}}, color={0,0,127}));
  connect(PID1.u_s, HT_Control_Set_Lower.y[1]) annotation (Line(points={{-28,-62},
          {-38,-62},{-38,-58},{-45,-58}},       color={0,0,127}));
  connect(T_HT_HP_L.y, PID1.u_m) annotation (Line(points={{-31,-82},{-16,-82},{-16,
          -74}},                         color={0,0,127}));
  connect(HT_Lower_Table.y[1], HT_Lower_Signal.u1) annotation (Line(points={{11,
          -22},{20,-22},{20,-38},{28,-38}}, color={0,0,127}));
  connect(booleanExpression1.y, HT_Lower_Signal.u2)
    annotation (Line(points={{-3,-46},{28,-46}}, color={255,0,255}));
  connect(T_Vessel_Measure.y, Q_Vessel_HT.u_m) annotation (Line(points={{-79,-32},
          {-56,-32},{-56,-8}},                     color={0,0,127}));
  connect(HT_Lower.u_s, HP_Initiator.y)
    annotation (Line(points={{-48,56},{-50,56},{-50,54},{-71,54}},
                                                 color={0,0,127}));
  connect(Experiment_Measure_TC11.y, HP_Initiator1.u3)
    annotation (Line(points={{-153,-38},{-134,-38}}, color={0,0,127}));
  connect(T_HT_HP_U1.y, timer.u)
    annotation (Line(points={{-157,4},{-148,4}}, color={255,0,255}));
  connect(timer.y, greaterEqualThreshold.u)
    annotation (Line(points={{-125,4},{-114,4}}, color={0,0,127}));
  connect(greaterEqualThreshold.y, HP_Initiator.u2) annotation (Line(points={{-91,
          4},{-86,4},{-86,14},{-88,14},{-88,22},{-104,22},{-104,54},{-94,54}},
        color={255,0,255}));
  connect(greaterEqualThreshold.y, HP_Initiator1.u2) annotation (Line(points={{-91,
          4},{-86,4},{-86,-14},{-140,-14},{-140,-30},{-134,-30}}, color={255,0,255}));
  connect(T_HT_HP_L1.y, HP_Initiator1.u1) annotation (Line(points={{-153,-16},{-144,
          -16},{-144,-22},{-134,-22}}, color={0,0,127}));
  connect(HP_Initiator1.y, Q_Vessel_HT.u_s) annotation (Line(points={{-111,-30},
          {-102,-30},{-102,-18},{-68,-18},{-68,4}}, color={0,0,127}));
  connect(T_Vessel_Measure.y, HT_Lower.u_m) annotation (Line(points={{-79,-32},
          {-30,-32},{-30,24},{-36,24},{-36,44}}, color={0,0,127}));
  connect(T_Vessel_Measure.y, HP_Initiator.u3) annotation (Line(points={{-79,
          -32},{-30,-32},{-30,24},{-82,24},{-82,34},{-98,34},{-98,46},{-94,46}},
        color={0,0,127}));
  connect(Experiment_Measure_TC11.y, HP_Initiator.u1) annotation (Line(points={
          {-153,-38},{-144,-38},{-144,-24},{-142,-24},{-142,-10},{-120,-10},{
          -120,48},{-106,48},{-106,62},{-94,62}}, color={0,0,127}));
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
      StartTime=88000,
      StopTime=140000,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Dassl"));
end HITB_Experiment_New_for_Data_ChargeRun_Frankenstein_MatchExpT_ChargeHPs;
