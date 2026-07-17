within NHES.Systems.EnergyStorage.PCM_HITB.Examples.Final_Runs_Model_Update;
model HITB_Experiment_02_MaxCharge "First charge run after calibration."
extends Modelica.Icons.Example;
  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable NHES.Systems.EnergyStorage.PCM_HITB.CS.CS_MaxCharge
      CS,
    redeclare Data.Data_System data,
    data_Initialization(
      T_PCM=299.15,
      T_Wall=299.15,
      T_HT=299.15,
      T_Insulation_Inner=299.15,
      T_Insulation_Outer=299.15,
      T_Tube_UGT=299.15,
      T_Insulation_UGT=299.15,
      T_UHP=299.15,
      T_Tube_LGT=299.15,
      T_Insulation_LGT=299.15,
      T_LHP=299.15));
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
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure(y=PCM_Core.T_TCs[4, 3])
    annotation (Placement(transformation(extent={{-86,90},{-66,110}})));
  Modelica.Blocks.Sources.TimeTable Temperature_Reference_TC1(
    table=[0,26.01; 300,27.384; 600,32.145; 900,36.71; 1200,47.943; 1500,56.933;
        1800,59.612; 2100,75.345; 2400,87.854; 2700,98.623; 3000,106.847; 3300,
        118.072; 3600,129.371; 3900,139.075; 4200,144.828; 4500,156.165; 4800,
        163.498; 5100,169.565; 5400,182.868; 5700,190.791; 6000,198.858; 6300,
        201.083; 6600,211.349; 6900,219.924; 7200,226.829; 7500,232.119; 7800,
        238.24; 8100,242.885; 8400,248.988; 8700,256.69; 9000,262.063; 9300,
        266.606; 9600,272.244; 9900,276.816; 10200,282.655; 10500,286.741;
        10800,291.25; 11100,296.257; 11400,299.909; 11700,305.545; 12000,
        310.203; 12300,313.135; 12600,317.758; 12900,321.896; 13200,324.428;
        13500,329.734; 13800,334.082; 14100,337.294; 14400,340.628; 14700,
        343.082; 15000,346.536; 15300,348.774; 15600,351.131; 15900,353.55;
        16200,356.211; 16500,358.018; 16800,362.2; 17100,364.23; 17400,368.298;
        17700,372.735; 18000,375.174; 18300,378.251; 18600,383.028; 18900,
        385.791; 19200,388.761; 19500,391.161; 19800,393.215; 20100,395.167;
        20400,396.96; 20700,398.297; 21000,399.845; 21300,401.224; 21600,
        402.421; 21900,402.826; 22200,404.451; 22500,405.511; 22800,406.665;
        23100,407.314; 23400,408.537; 23700,409.359; 24000,410.115; 24300,
        410.878; 24600,411.477; 24900,411.974; 25200,412.871; 25500,413.523;
        25800,413.927; 26100,415.152; 26400,415.912; 26700,416.744; 27000,
        417.44; 27300,418.086; 27600,418.732; 27900,419.81; 28200,420.572;
        28500,420.966; 28800,422.12; 29100,422.84; 29400,423.456; 29700,423.456;
        30000,425.042; 30300,425.875; 30600,426.149; 30900,427.359; 31200,
        428.121; 31500,428.862; 31800,429.229; 32100,430.055; 32400,430.743;
        32700,431.591; 33000,432.2; 33300,432.707; 33600,433.515; 33900,434.204;
        34200,434.811; 34500,435.433; 34800,436.064; 35100,436.665; 35400,
        437.237; 35700,437.816; 36000,438.233; 36300,438.817; 36600,439.419;
        36900,439.922; 37200,440.332; 37500,440.808; 37800,441.189; 38100,
        441.49; 38400,441.932; 38700,442.281; 39000,442.542; 39300,442.8; 39600,
        443.059; 39900,443.262; 40200,443.546; 40500,443.815; 40800,443.991;
        41100,444.249; 41400,444.41; 41700,444.602; 42000,444.726; 42300,
        444.964; 42600,445.122; 42900,445.277; 43200,445.408; 43500,445.537;
        43800,445.665; 44100,445.766; 44400,445.858; 44700,446.011; 45000,
        446.017; 45300,446.201; 45600,446.302; 45900,446.309; 46200,446.384;
        46500,446.49; 46800,446.568; 47100,446.63; 47400,446.686; 47700,446.727;
        48000,446.806; 48300,446.787; 48600,446.889; 48900,446.972; 49200,
        447.018; 49500,447.111; 49800,447.135; 50100,447.149; 50400,447.23;
        50700,447.253; 51000,447.321; 51300,447.348; 51600,447.41; 51900,
        447.442; 52200,447.503; 52500,447.592; 52800,447.59; 53100,447.699;
        53400,447.732; 53700,447.808; 54000,447.901; 54300,447.942; 54600,
        448.002; 54900,448.084; 55200,448.168; 55500,448.219; 55800,448.293;
        56100,448.378; 56400,448.584; 56700,448.614; 57000,448.65; 57300,
        448.772; 57600,448.85; 57900,448.913; 58200,448.967; 58500,449.045;
        58800,449.16; 59100,449.271; 59400,449.438; 59700,449.586; 60000,
        449.714; 60300,449.832; 60600,450.031; 60900,450.223; 61200,450.436;
        61500,450.625; 61800,450.753; 62100,450.915; 62400,451.065; 62700,
        451.219; 63000,451.458; 63300,451.59; 63600,451.645; 63900,451.768;
        64200,451.916; 64500,452.006; 64800,452.15; 65100,452.218; 65400,
        452.352; 65700,452.392; 66000,452.467; 66300,452.521; 66600,452.621;
        66900,452.614; 67200,452.721; 67500,452.587; 67800,452.502; 68100,
        452.502; 68400,452.458; 68700,452.467; 69000,452.512; 69300,452.525;
        69600,452.552; 69900,452.552; 70200,452.584; 70500,452.602; 70800,
        452.563; 71100,452.575; 71400,452.579; 71700,452.578; 72000,452.593;
        72300,452.664; 72600,452.678; 72900,452.723; 73200,452.745; 73500,
        452.79; 73800,452.897; 74100,452.89; 74400,452.994; 74700,453.073;
        75000,453.021; 75300,453.023; 75600,453.037; 75900,453.04; 76200,
        453.065; 76500,453.055; 76800,453.059; 77100,453.037; 77400,453.032;
        77700,453.028; 78000,452.991; 78300,453.003; 78600,452.988; 78900,
        453.013; 79200,453.058; 79500,452.963; 79800,453.009; 80100,453.041;
        80400,453.065; 80700,453.087; 81000,453.096; 81300,453.09; 81600,
        453.146; 81900,453.144; 82200,453.26; 82500,453.215; 82800,453.213;
        83100,453.202; 83400,453.159; 83700,453.18; 84000,453.188; 84300,
        453.167; 84600,453.195; 84900,453.228; 85200,453.202; 85500,453.246;
        85800,453.223; 86100,453.234; 86400,453.254; 86700,453.279; 87000,
        453.294; 87300,453.341; 87600,453.325; 87900,453.344; 88200,453.351;
        88500,453.323; 88800,453.344; 89100,453.348; 89400,453.416; 89700,
        453.478; 90000,453.485; 90300,453.491; 90600,453.533; 90900,453.521],
    timeScale=1,
    offset=273.15,
    shiftTime=0)
    annotation (Placement(transformation(extent={{-120,42},{-100,62}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure1(y=PCM_Core.T_TCs[4,
        3])
    annotation (Placement(transformation(extent={{-116,4},{-96,24}})));
  Components.RMSE_Calculator rMSE_Calculator
    annotation (Placement(transformation(extent={{-78,22},{-58,42}})));
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
      Line(points={{47.9429,25.6},{71.44,25.6},{71.44,-0.84},{86.14,-0.84}},
        color={191,0,0}));
  connect(Lower_Guide_Tube.port_battery, PCM_Core.port_b[:, 2]) annotation (
      Line(points={{45,-48.22},{72,-48.22},{72,-0.84},{86.14,-0.84}},
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
      points={{30,100},{66,100},{66,110},{152,110},{152,4},{60,4},{60,-9},{53.8,
          -9}},
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
          -95,14},{-88,14},{-88,26},{-80,26}}, color={0,0,127}));
  connect(Temperature_Reference_TC1.y, rMSE_Calculator.u1) annotation (Line(
        points={{-99,52},{-88,52},{-88,38},{-80,38}}, color={0,0,127}));
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
end HITB_Experiment_02_MaxCharge;
