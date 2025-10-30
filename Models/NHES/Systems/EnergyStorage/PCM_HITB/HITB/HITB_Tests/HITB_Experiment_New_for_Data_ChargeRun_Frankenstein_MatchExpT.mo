within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HITB_Tests;
model HITB_Experiment_New_for_Data_ChargeRun_Frankenstein_MatchExpT
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
  parameter Modelica.Units.SI.Time timer_high_setpoint = 10800;
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
    Q_HP_Tape_Input=HT_Upper.y)
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
  Modelica.Blocks.Logical.Switch HT_Upper
    annotation (Placement(transformation(extent={{-4,60},{16,80}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-58,60},{-38,80}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1e3,
    yMin=0.0) annotation (Placement(transformation(extent={{-60,44},{-40,64}})));
  Modelica.Blocks.Sources.RealExpression T_HT_HP_U(y=Upper_Guide_Tube.Guide_Tube.materials[
        Upper_Guide_Tube.Guide_Tube.geometry.nR, 3].T)
    annotation (Placement(transformation(extent={{-96,26},{-76,46}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Control_Set_Upper(table=[0,673.15;
        105500,673.15; 105600,673.15; 125000,673.15; 125500,673.15; 432000,
        673.15])
    annotation (Placement(transformation(extent={{-96,54},{-76,74}})));
  Modelica.Blocks.Logical.Switch HT_Lower
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
  Modelica.Blocks.Sources.TimeTable Experiment_Measure_TC12(table=[0,89.5; 300,
        89.4; 600,89.3; 900,90.2; 1200,91.1; 1500,93.7; 1800,95.4; 2100,97.5;
        2400,102; 2700,105; 3000,106; 3300,112; 3600,115; 3900,119; 4200,124;
        4500,129; 4800,133; 5100,136; 5400,143; 5700,144; 6000,152; 6110,152;
        7022,164.8; 7934,177.6; 8846,190.4; 9758,203.2; 10670,216; 11582,228.8;
        12494,241.6; 13406,254.4; 14318,267.2; 15230,280; 15320,280; 15620,282;
        15920,284; 16220,290; 16520,292; 16820,294; 17120,297; 17420,302; 17720,
        306; 18020,309; 18320,309; 18620,314; 18920,317; 19220,318; 19520,323;
        19820,325; 20120,328; 20420,331; 20720,334; 21020,336; 21320,339; 21620,
        342; 21920,344; 22220,347; 22520,350; 22820,351; 23120,355; 23420,357;
        23720,359; 24020,363; 24320,365; 24620,367; 24920,370; 25220,371; 25520,
        373; 25820,374; 26120,376; 26420,378; 26720,379; 27020,381; 27320,382;
        27620,383; 27920,384; 28220,386; 28520,386; 28820,388; 29120,389; 29420,
        390; 29720,391; 30020,391; 30320,392; 30620,393; 30920,394; 31220,394;
        31520,395; 31820,395; 32120,396; 32420,397; 32720,397; 33020,398; 33320,
        398; 33620,399; 33920,399; 34220,399; 34520,400; 34820,400; 35120,400;
        35420,401; 35720,401; 36020,401; 36320,402; 36620,402; 36920,402; 37220,
        402; 37520,403; 37820,403; 38120,403; 38420,403; 38720,403; 39020,404;
        39320,404; 39620,404; 39920,404; 40220,404; 40520,404; 40820,404; 41120,
        405; 41420,405; 41720,405; 42020,405; 42320,405; 42620,405; 42920,405;
        43220,405; 43520,405; 43820,405; 44120,405; 44420,405; 44720,405; 45020,
        405; 45320,405; 45620,405; 45920,405; 46220,405; 46520,405; 46820,405;
        47120,405; 47420,405; 47720,405; 48020,405; 48320,405; 48620,405; 48920,
        405; 49220,405; 49520,406; 49820,406; 50120,406; 50420,405; 50720,406;
        51020,406; 51320,406; 51620,406; 51920,406; 52220,406; 52520,406; 52820,
        406; 53120,406; 53420,406; 53720,406; 54020,406; 54320,406; 54620,406;
        54920,406; 55220,406; 55520,406; 55820,406; 56120,406; 56420,406; 56720,
        406; 57020,406; 57320,406; 57620,406; 57920,406; 58220,406; 58520,406;
        58820,406; 59120,406; 59420,406; 59720,406; 60020,406; 60320,406; 60620,
        406; 60920,405; 61220,406; 61520,406; 61820,406; 62120,405; 62420,405;
        62720,406; 63020,406; 63320,406; 63620,405; 63920,406; 64220,406; 64520,
        406; 64820,406; 65120,406; 65420,406; 65720,406; 66020,406; 66320,405;
        66620,406; 66920,406; 67220,406; 67520,406; 67820,406; 68120,406; 68420,
        406; 68720,406; 69020,405; 69320,405; 69620,405; 69920,405; 70220,405;
        70520,405; 70820,405; 71120,405; 71420,405; 71720,405; 72020,405; 72320,
        405; 72620,405; 72920,405; 73220,405; 73520,405; 73820,405],
                                 offset=273.15)
    annotation (Placement(transformation(extent={{-130,-6},{-110,14}})));
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
    annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
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
      Line(points={{114.72,34.4},{135.44,34.4},{135.44,21.16},{150.14,21.16}},
        color={191,0,0}));
  connect(Lower_Guide_Tube.port_battery, PCM_Core.port_b[:, 2]) annotation (
      Line(points={{115.8,-9.78},{136,-9.78},{136,21.16},{150.14,21.16}},
        color={191,0,0}));
  connect(heat_Pipe_New1.heat_pipe_port, Upper_Guide_Tube.port_HP) annotation (
      Line(points={{97.68,46.72},{79.64,46.72},{79.64,37.6},{85.48,37.6}},
                                                          color={191,0,0}));
  connect(heat_Pipe_New.heat_pipe_port, Lower_Guide_Tube.port_HP) annotation (
      Line(points={{97.68,-10.72},{76,-10.72},{76,-12.82},{85.7,-12.82}},
                                                         color={191,0,0}));
  connect(booleanExpression.y, HT_Upper.u2)
    annotation (Line(points={{-37,70},{-6,70}},
                                              color={255,0,255}));
  connect(HT_Upper_Table.y[1], HT_Upper.u1) annotation (Line(points={{-23,88},{-14,
          88},{-14,78},{-6,78}},   color={0,0,127}));
  connect(PID.y, HT_Upper.u3) annotation (Line(points={{-39,54},{-12,54},{-12,62},
          {-6,62}},color={0,0,127}));
  connect(PID.u_s, HT_Control_Set_Upper.y[1]) annotation (Line(points={{-62,54},
          {-72,54},{-72,64},{-75,64}}, color={0,0,127}));
  connect(T_HT_HP_U.y, PID.u_m) annotation (Line(points={{-75,36},{-62,36},{-62,
          34},{-50,34},{-50,42}},
                                color={0,0,127}));
  connect(PID1.y, HT_Lower.u3) annotation (Line(points={{-5,-62},{22,-62},{22,-54},
          {28,-54}},             color={0,0,127}));
  connect(PID1.u_s, HT_Control_Set_Lower.y[1]) annotation (Line(points={{-28,-62},
          {-38,-62},{-38,-58},{-45,-58}},       color={0,0,127}));
  connect(T_HT_HP_L.y, PID1.u_m) annotation (Line(points={{-31,-82},{-16,-82},{-16,
          -74}},                         color={0,0,127}));
  connect(HT_Lower_Table.y[1], HT_Lower.u1) annotation (Line(points={{11,-22},{20,
          -22},{20,-38},{28,-38}},        color={0,0,127}));
  connect(booleanExpression1.y, HT_Lower.u2)
    annotation (Line(points={{-3,-46},{28,-46}},  color={255,0,255}));
  connect(Experiment_Measure_TC12.y, Q_Vessel_HT.u_s) annotation (Line(points={{-109,4},
          {-68,4}},                             color={0,0,127}));
  connect(T_Vessel_Measure.y, Q_Vessel_HT.u_m) annotation (Line(points={{-79,-32},
          {-56,-32},{-56,-8}},                     color={0,0,127}));
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
      StopTime=172800,
      __Dymola_NumberOfIntervals=750,
      __Dymola_Algorithm="Dassl"));
end HITB_Experiment_New_for_Data_ChargeRun_Frankenstein_MatchExpT;
