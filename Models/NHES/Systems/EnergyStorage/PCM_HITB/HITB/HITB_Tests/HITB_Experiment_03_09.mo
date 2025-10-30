within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HITB_Tests;
model HITB_Experiment_03_09 "Add in HITB control"

  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";
  Modelica.Units.SI.Area SA_DHX_Side;
  Modelica.Units.SI.Area SA_CHX_Side;

  Modelica.Units.SI.Area A_Cyl_HITB[nV_Rh];
  parameter Integer nV_Z = 8 "Nodes in the thermal batter";
  parameter Integer nV_Zh = 6 "Nodes in the heat pipe length";
  parameter Integer nV_R = 10 "Radial nodes in the thermal battery";
  parameter Integer nV_Rh = 5 "Radial nodes in the heat pipe";
  Modelica.Units.SI.SpecificHeatCapacity cp_out;
  Modelica.Units.SI.Energy E_store;
  parameter Modelica.Units.SI.Length R_Na = 0.0254*1.98 "Main sodium radius within heat pipe, value is inner wick radius";
  parameter Modelica.Units.SI.Length R_Wick = 0.0254*2.0 "Radius of where outer wick is.";
  parameter Modelica.Units.SI.Length R_HITB = 0.0254*2.1 "Radius of entire heat pipe apparatus that moves";
  parameter Modelica.Units.SI.Length t_PCM_pipe = 0.002 "Thickness of inner pipe of PCM container";
  parameter Modelica.Units.SI.Length R_PCM_inner = 0.0254*2.1+t_PCM_pipe+0.002 "Inner radius of PCM container";
  parameter Modelica.Units.SI.Length R_PCM = 0.295 "Outer radius of PCM container";
  parameter Modelica.Units.SI.Length t_PCM_wall = 0.002 "Outer PCM container wall thickness";

  parameter Modelica.Units.SI.Length l_HITB = 0.5+0.3+0.2;
  parameter Modelica.Units.SI.Length l_CHX = 0.3 "Length of section where heat pipe can be heated by CHX";
  Modelica.Units.SI.Length z_CHX[2] = linspace(0,l_CHX,2);
  parameter Modelica.Units.SI.Length l_DHX = l_CHX "Length of section where heat pipe can be cooled by DHX";
  Modelica.Units.SI.Length z_DHX[2] = linspace(l_experiment-l_DHX, l_DHX,2);
  parameter Modelica.Units.SI.Length l_gap_CHX = 0.2 "Length of section between the CHX and the PCM";
  Modelica.Units.SI.Length z_gap_CHX[2] = linspace(l_CHX, l_CHX+l_gap_CHX,2);
  parameter Modelica.Units.SI.Length l_gap_DHX = 0.2 "Length of section between the DHX and the PCM";
  Modelica.Units.SI.Length z_gap_DHX[2] = linspace(l_CHX+l_gap_CHX+l_PCM, l_CHX+l_gap_CHX+l_PCM+l_gap_DHX,2);
  parameter Modelica.Units.SI.Length l_PCM =  0.6 "Length of PCM heat exchange potential";
  Modelica.Units.SI.Length z_position_PCM[nV_Z+1] = linspace(l_CHX+l_gap_CHX,l_CHX+l_gap_CHX+l_PCM,nV_Z+1);
  parameter Modelica.Units.SI.Length l_experiment = l_CHX+l_DHX+l_gap_CHX+l_gap_DHX+l_PCM;
  Modelica.Units.SI.Length z_1HP[nV_Zh+1] = linspace(controls_Construction.one_HP_Position*(l_experiment-l_HITB),l_HITB+controls_Construction.one_HP_Position*(l_experiment-l_HITB),nV_Zh+1);
  Modelica.Units.SI.Length z_2HP[nV_Zh+1] = linspace(controls_Construction.two_HPs_position*(l_experiment-l_HITB),l_HITB+controls_Construction.two_HPs_position*(l_experiment-l_HITB),nV_Zh+1);
 // Modelica.Units.SI.Length z_position_HITB[nV_Z+1];

  //Modelica.Units.SI.Length z_overlap[nV_Zh, nV_Z];
  Modelica.Units.SI.Area SA_1HP_HP_TB[nV_Zh, nV_Z];
  Modelica.Units.SI.Area SA_1HP_HP_CHX[nV_Zh, 1];
  Modelica.Units.SI.Area SA_1HP_HP_CGap[nV_Zh, 1];
  Modelica.Units.SI.Area SA_1HP_HP_DGap[nV_Zh, 1];
  Modelica.Units.SI.Area SA_1HP_HP_DHX[nV_Zh, 1];
  Modelica.Units.SI.Area SA_2HP_HP_TB[nV_Zh, nV_Z];
  Modelica.Units.SI.Area SA_2HP_HP_CHX[nV_Zh, 1];
  Modelica.Units.SI.Area SA_2HP_HP_CGap[nV_Zh, 1];
  Modelica.Units.SI.Area SA_2HP_HP_DGap[nV_Zh, 1];
  Modelica.Units.SI.Area SA_2HP_HP_DHX[nV_Zh, 1];

  Modelica.Units.SI.Power Q_CHX;
  Modelica.Units.SI.Power Q_DHX;
  Modelica.Units.SI.Power Q_CHX_theory;
  Modelica.Units.SI.Power Q_DHX_theory;
  Modelica.Units.SI.Power Q_loss;
  parameter Modelica.Units.SI.Temperature T_melt = 443+273.15 "Used for graphics only";
  Modelica.Units.SI.Time time_plot;
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 2.5;
  parameter Modelica.Units.SI.Temperature T_air = 273.15+250 "Air inside the shipping container estimate";

  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Pipe_Wall[nV_Z](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    length=l_HITB,
    r_inner=R_PCM_inner,
    r_outer=R_PCM_inner + t_PCM_pipe,
    exposeState_a=false,
    exposeState_b=false)
    annotation (Placement(transformation(extent={{120,-86},{140,-66}})));

  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wick[nV_Zh](
    length=l_HITB,
    r_inner=R_Na,
    r_outer=R_Wick,
    redeclare package Material = HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-74,-86},{-54,-66}})));

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D HITB_Main(
    redeclare package Material = HITB.PCM_Materials.Sodium_New (k_eff_mult=2),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=723.15,
    T_b1_start=723.15,
    T_a2_start=723.15,
    T_b2_start=723.15,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        nR=nV_Rh,
        nZ=nV_Zh,
        r_outer=R_Na,
        length_z=l_HITB),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-98,-76})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow CHX(use_port=true)
    annotation (Placement(transformation(extent={{110,-136},{90,-116}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow DHX(use_port=true)
    annotation (Placement(transformation(extent={{116,-40},{96,-20}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_CHX_Side(T=T_air)
    annotation (Placement(transformation(extent={{126,-112},{106,-92}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_DHX_Side(T=T_air)
    annotation (Placement(transformation(extent={{134,-64},{114,-44}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(
      surfaceArea=SA_DHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{98,-64},{78,-44}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection1(
      surfaceArea=SA_CHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{86,-112},{66,-92}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wall[nV_Zh](
    length=l_HITB,
    r_inner=R_Wick,
    r_outer=R_HITB,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-46,-86},{-26,-66}})));

  Modelica.Blocks.Sources.RealExpression Q_CHX_Input(y=1000/(l_CHX*Modelica.Constants.pi
        *R_HITB))
    annotation (Placement(transformation(extent={{140,-136},{120,-116}})));
  Modelica.Blocks.Sources.RealExpression Q_DHX_Input(y=-1000/(l_CHX*Modelica.Constants.pi
        *R_HITB))
    annotation (Placement(transformation(extent={{146,-40},{126,-20}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall2[nV_Rh](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-98,-48})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial3[nV_Rh](T=T_air)
                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-98,2})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection5[nV_Rh](
      surfaceArea=A_Cyl_HITB, alpha=hc_air)
                                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-98,-24})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall3[nV_Rh](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-98,-108})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial4[nV_Rh](T=T_air)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-98,-164})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection6[nV_Rh](
      surfaceArea=A_Cyl_HITB, alpha=hc_air)
                                           annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-98,-136})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic Air_CHX_Side1[nV_Zh]
    annotation (Placement(transformation(extent={{-134,-86},{-114,-66}})));

  Components.PCM_Volume.PCM_Chamber_vertsym_03 PCM_Core(
    nZ=nV_Z,
    t_insulation=0.3,
    hc_air=hc_air,
    Q_heat_trace=50*ones(11, nV_Z))
    annotation (Placement(transformation(extent={{226,-66},{128,36}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Pipe_Wall1
                                                                         [nV_Z](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    length=l_HITB,
    r_inner=R_PCM_inner,
    r_outer=R_PCM_inner + t_PCM_pipe,
    exposeState_a=false,
    exposeState_b=false)
    annotation (Placement(transformation(extent={{58,90},{78,110}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wick1[nV_Zh](
    length=l_HITB,
    r_inner=R_Na,
    r_outer=R_Wick,
    redeclare package Material = HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-102,90},{-82,110}})));

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D HITB_Main1(
    redeclare package Material = HITB.PCM_Materials.Sodium_New (k_eff_mult=2),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=723.15,
    T_b1_start=723.15,
    T_a2_start=723.15,
    T_b2_start=723.15,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        nR=nV_Rh,
        nZ=nV_Zh,
        r_outer=R_Na,
        length_z=l_HITB),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-126,100})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow CHX1(use_port=true)
    annotation (Placement(transformation(extent={{56,28},{36,48}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow DHX1(use_port=true)
    annotation (Placement(transformation(extent={{66,140},{46,160}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_CHX_Side2(T=T_air)
    annotation (Placement(transformation(extent={{64,60},{44,80}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_DHX_Side1(T=T_air)
    annotation (Placement(transformation(extent={{74,112},{54,132}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection2(
      surfaceArea=SA_DHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{38,112},{18,132}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection3(
      surfaceArea=SA_CHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{24,60},{4,80}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wall1
                                                                     [nV_Zh](
    length=l_HITB,
    r_inner=R_Wick,
    r_outer=R_HITB,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-74,90},{-54,110}})));

  Modelica.Blocks.Sources.RealExpression Q_CHX_Input1(y=1000/(l_CHX*Modelica.Constants.pi
        *R_HITB))
    annotation (Placement(transformation(extent={{82,28},{62,48}})));
  Modelica.Blocks.Sources.RealExpression Q_DHX_Input_2HP(y=-1000/(l_CHX*
        Modelica.Constants.pi*R_HITB))
    annotation (Placement(transformation(extent={{96,140},{76,160}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector2
                                                                           [nV_Zh](n=5)
    annotation (Placement(transformation(extent={{-26,90},{-46,110}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall1[nV_Rh](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-128,148})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial1[nV_Rh](T=T_air)
                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-128,210})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection4[nV_Rh](
      surfaceArea=A_Cyl_HITB, alpha=hc_air)
                                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-128,178})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall4[nV_Rh](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-126,68})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial2[nV_Rh](T=T_air)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-126,12})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection7[nV_Rh](
      surfaceArea=A_Cyl_HITB, alpha=hc_air)
                                           annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-126,40})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic Air_CHX_Side3[nV_Zh]
    annotation (Placement(transformation(extent={{-162,90},{-142,110}})));

  Modelica.Blocks.Sources.CombiTimeTable charge_demand_table1(table=[0,0.0; 3599,
        0; 3600,3000; 10799,3000; 10800,0; 21599,0; 21600,2000; 43199,2000; 43200,
        1000; 57599,1000; 57600,0], extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{144,88},{164,108}})));
  Modelica.Blocks.Sources.CombiTimeTable discharge_demand_table1(table=[0,0.0; 3599,
        0; 3600,0; 10799,0; 10800,3000; 21599,3000; 21600,500; 43199,500; 43200,
        1500; 57599,1500; 57600,0], extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{144,130},{164,150}})));
  Controls_Construction controls_Construction
    annotation (Placement(transformation(extent={{202,106},{222,126}})));
  Collector_Variable_Convection collector_1HP_HITB(n_a=nV_Zh, n_b=nV_Z,
    A_vec=SA_1HP_HP_TB)
    annotation (Placement(transformation(extent={{28,-86},{48,-66}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector1[
    nV_Zh](n=5)
    annotation (Placement(transformation(extent={{6,-86},{-14,-66}})));
  Collector_Variable_Convection collector_1HP_DHX(n_a=nV_Zh,
    n_b=1,
    A_vec=SA_1HP_HP_DHX)
    annotation (Placement(transformation(extent={{28,-66},{48,-46}})));
  Collector_Variable_Convection collector_1HP_Air_DHX(n_a=nV_Zh, n_b=1,
    A_vec=SA_1HP_HP_DGap)
    annotation (Placement(transformation(extent={{30,-44},{50,-24}})));
  Collector_Variable_Convection collector_1HP_Air_CHX(n_a=nV_Zh,
    n_b=1,
    A_vec=SA_1HP_HP_CGap)
    annotation (Placement(transformation(extent={{28,-112},{48,-92}})));
  Collector_Variable_Convection collector__1HP_CHX(n_a=nV_Zh,
    n_b=1,
    A_vec=SA_1HP_HP_CHX)
    annotation (Placement(transformation(extent={{32,-134},{52,-114}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_PCM_Gap2[nV_Z](
    redeclare package Material = PCM_Materials.Lambda_00_24_d_1200_cp_500,
    T_start=723.15,
    length=l_HITB,
    r_inner=R_HITB,
    r_outer=R_PCM_inner,
    exposeState_a=true)
    annotation (Placement(transformation(extent={{70,-86},{90,-66}})));
  Modelica.Blocks.Math.Add     signal_Position
    annotation (Placement(transformation(extent={{248,46},{268,66}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX1(
    amplitude=1,
    rising=100,
    width=42000,
    falling=100,
    period=86400,
    startTime=43000)
    annotation (Placement(transformation(extent={{204,22},{224,42}})));
  Modelica.Blocks.Sources.Constant const(k=0.0)
    annotation (Placement(transformation(extent={{204,70},{224,90}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_CHX(
    amplitude=1e3,
    rising=100,
    width=3600*4,
    falling=100,
    period=3600*6)
    annotation (Placement(transformation(extent={{142,240},{162,260}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX(
    amplitude=-1e3,
    rising=100,
    width=3600*2,
    falling=100,
    period=3600*6,
    startTime=3600*3)
    annotation (Placement(transformation(extent={{142,206},{162,226}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       443 + 273.15 + 25)
    annotation (Placement(transformation(extent={{142,270},{162,290}})));
  Modelica.Blocks.Sources.RealExpression Q_CHX_Input2(y=PCM_Core.T_ave_r[
        PCM_Core.nR])
    annotation (Placement(transformation(extent={{94,270},{114,290}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
    amplitude=-1e3,
    rising=100,
    falling=600,
    offset=0)
    annotation (Placement(transformation(extent={{190,270},{210,290}})));
  Modelica.Blocks.Math.Add add_Q_CHX
    annotation (Placement(transformation(extent={{222,250},{242,270}})));
  Modelica.Blocks.Logical.LessEqualThreshold    lessEqualThreshold(threshold=443
         + 273.15 - 5)
    annotation (Placement(transformation(extent={{126,178},{146,198}})));
  Modelica.Blocks.Sources.RealExpression Q_CHX_Input3(y=PCM_Core.T_ave_r[
        PCM_Core.nR])
    annotation (Placement(transformation(extent={{78,178},{98,198}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid1(
    amplitude=1e3,
    rising=100,
    falling=600,
    offset=0)
    annotation (Placement(transformation(extent={{174,178},{194,198}})));
  Modelica.Blocks.Math.Add add_Q_DHX
    annotation (Placement(transformation(extent={{212,226},{232,206}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_PCM_Gap2HP[nV_Z](
    redeclare package Material = PCM_Materials.Lambda_00_24_d_1200_cp_500,
    T_start=723.15,
    length=l_HITB,
    r_inner=R_HITB,
    r_outer=R_PCM_inner,
    exposeState_a=true)
    annotation (Placement(transformation(extent={{28,90},{48,110}})));
  Collector_Variable_Convection collector_1HP_HITB1(
    n_a=nV_Zh,
    n_b=nV_Z,
    A_vec=SA_2HP_HP_TB)
    annotation (Placement(transformation(extent={{-4,90},{16,110}})));
  Collector_Variable_Convection collector_2HP_Air_DHX(
    n_a=nV_Zh,
    n_b=1,
    A_vec=SA_2HP_HP_DHX)
    annotation (Placement(transformation(extent={{-12,140},{8,160}})));
  Collector_Variable_Convection collector_2HP_DGap(
    n_a=nV_Zh,
    n_b=1,
    A_vec=SA_2HP_HP_DGap)
    annotation (Placement(transformation(extent={{-12,112},{8,132}})));
  Collector_Variable_Convection collector_2HP_Air_CHX(
    n_a=nV_Zh,
    n_b=1,
    A_vec=SA_2HP_HP_CGap)
    annotation (Placement(transformation(extent={{-18,60},{2,80}})));
  Collector_Variable_Convection collector__2HP_CHX(
    n_a=nV_Zh,
    n_b=1,
    A_vec=SA_2HP_HP_CHX)
    annotation (Placement(transformation(extent={{-18,30},{2,50}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance
                                                            generic(R_val=100)
    annotation (Placement(transformation(extent={{86,-40},{66,-20}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance
                                                            generic1(R_val=100)
    annotation (Placement(transformation(extent={{82,-136},{62,-116}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance generic2(
      R_val=100)
    annotation (Placement(transformation(extent={{10,28},{30,48}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance generic3(
      R_val=100)
    annotation (Placement(transformation(extent={{16,140},{36,160}})));
protected
  Real Q_CHX_linear(unit = "W/m") = Q_CHX_theory/l_CHX;
  Real Q_DHX_linear(unit = "W/m") = Q_DHX_theory/l_DHX;
equation
  time_plot = time;
  cp_out = PCM_Core.conduction.Material.specificHeatCapacityCp(PCM_Core.conduction.materials[1,1, 1].state);
  Position = signal_Position.y;
  der(E_store) = sum(PCM_Core.port_b.Q_flow);
  A_Cyl_HITB = HITB_Main.geometry.crossAreas_2[:,1];
  SA_CHX_Side = l_gap_CHX*Modelica.Constants.pi*R_HITB;
  SA_DHX_Side = l_gap_DHX*Modelica.Constants.pi*R_HITB;
  Q_CHX = Q_CHX_theory*(0.5-min(Position,0.5))/0.5;
  Q_DHX = Q_DHX_theory*(max(0.5,Position)-0.5)/0.5;
  Q_CHX_theory = max(0,add_Q_CHX.y);
  Q_DHX_theory = min(0,add_Q_DHX.y);

  //  SA_PCM_HITB = z_overlap.*Modelica.Constants.pi*2*R_HITB;

  /* NOTES 
  The heat rate by node for the charging and discharging heat exchangers both need to be adjusted to account for the fact
  that the rod is moving. At the moment, the entire rod is being heated & cooled evenly. The overall heat rate is still being 
  adjusted and is accounted for, but this i snot accurate. The heat needs to be inserted to the correct nodes only.
  
  
  
  */

 /* for i in 1:nV_Zh loop //i will indicate PCM location
    for j in 1:nV_Z loop //j will indicate HITB location


      if z_position_PCM[j] >= z_position_HITB[i] and z_position_PCM[j+1] <= z_position_HITB[i+1] then
       z_overlap[i,j] = z_position_PCM[j+1]-z_position_PCM[j];
    elseif z_position_PCM[j] <= z_position_HITB[i+1] and z_position_PCM[j+1] >= z_position_HITB[i+1] then
      z_overlap[i,j] = z_position_HITB[i+1]-z_position_PCM[j];
    elseif z_position_PCM[j] <= z_position_HITB[i] and z_position_PCM[j+1] >= z_position_HITB[i] then
      z_overlap[i,j] = z_position_PCM[j+1]-z_position_HITB[i];
    else
      z_overlap[i,j] = 0;
      end if;
      SA_PCM_HITB[j,i] = z_overlap[i, j] * Modelica.Constants.pi*2*R_HITB;
    end for;
    end for; */
   SA_1HP_HP_TB =Data.overlap_vec(z_1HP, z_position_PCM, 1);
  SA_1HP_HP_CHX =Data.overlap_vec(z_1HP, z_CHX, 1);
  SA_1HP_HP_CGap =Data.overlap_vec(z_1HP, z_gap_CHX, 1);
  SA_1HP_HP_DGap =Data.overlap_vec(z_1HP, z_gap_DHX, 1);
  SA_1HP_HP_DHX =Data.overlap_vec(z_1HP, z_DHX, 1);

     SA_2HP_HP_TB =Data.overlap_vec(z_2HP, z_position_PCM, 1);
  SA_2HP_HP_CHX =Data.overlap_vec(z_2HP, z_CHX, 1);
  SA_2HP_HP_CGap =Data.overlap_vec(z_2HP, z_gap_CHX, 1);
  SA_2HP_HP_DGap =Data.overlap_vec(z_2HP, z_gap_DHX, 1);
  SA_2HP_HP_DHX =Data.overlap_vec(z_2HP, z_DHX, 1);
  for i in 1:nV_Zh loop
    for j in 1:nV_Z loop
    end for;
  end for;

  Q_loss = sum(Air_CHX_Side.port.Q_flow)+sum(Air_CHX_Side1.port.Q_flow)+sum(Air_CHX_Side2.port.Q_flow)+sum(Air_CHX_Side3.port.Q_flow)+sum(Air_DHX_Side.port.Q_flow)+sum(Air_DHX_Side1.port.Q_flow)+sum(Air_PCM_Axial1.port.Q_flow)+sum(Air_PCM_Axial2.port.Q_flow)+sum(Air_PCM_Axial3.port.Q_flow)+sum(Air_PCM_Axial4.port.Q_flow) + PCM_Core.Q_loss;

  connect(HITB_Wall.port_a, HITB_Wick.port_b)
    annotation (Line(points={{-46,-76},{-54,-76}},
                                                 color={191,0,0}));

  connect(Q_CHX_Input.y, CHX.Q_flow_ext)
    annotation (Line(points={{119,-126},{104,-126}},
                                               color={0,0,127}));
  connect(Air_CHX_Side.port, convection1.port_a)
    annotation (Line(points={{106,-102},{83,-102}},
                                               color={191,0,0}));
  connect(Air_DHX_Side.port, convection.port_a)
    annotation (Line(points={{114,-54},{95,-54}},color={191,0,0}));
  connect(Q_DHX_Input.y, DHX.Q_flow_ext)
    annotation (Line(points={{125,-30},{110,-30}},
                                                 color={0,0,127}));
  connect(Air_PCM_Axial3.port, convection5.port_a)
    annotation (Line(points={{-98,-8},{-98,-17}},  color={191,0,0}));
  connect(convection5.port_b, simpleWall2.port_b)
    annotation (Line(points={{-98,-31},{-98,-38}}, color={191,0,0}));
  connect(convection6.port_b, simpleWall3.port_b)
    annotation (Line(points={{-98,-129},{-98,-118}},
                                                   color={191,0,0}));
  connect(convection6.port_a, Air_PCM_Axial4.port)
    annotation (Line(points={{-98,-143},{-98,-154}},
                                                   color={191,0,0}));
  connect(HITB_Main.port_b1, HITB_Wick.port_a)
    annotation (Line(points={{-88,-76},{-74,-76}},
                                                 color={191,0,0}));
  connect(HITB_Main.port_b2, simpleWall2.port_a) annotation (Line(points={{-98,-66},
          {-98,-58}},                    color={191,0,0}));
  connect(HITB_Main.port_a1, Air_CHX_Side1.port)
    annotation (Line(points={{-108,-76},{-114,-76}},
                                                   color={191,0,0}));
  connect(HITB_Main.port_a2, simpleWall3.port_a)
    annotation (Line(points={{-98,-86},{-98,-98}}, color={191,0,0}));
  connect(HITB_Wall1.port_a, HITB_Wick1.port_b)
    annotation (Line(points={{-74,100},{-82,100}}, color={191,0,0}));
  connect(HITB_Wall1.port_b, collector2.port_b)
    annotation (Line(points={{-54,100},{-46,100}}, color={191,0,0}));
  connect(Q_CHX_Input1.y, CHX1.Q_flow_ext)
    annotation (Line(points={{61,38},{50,38}},   color={0,0,127}));
  connect(Air_CHX_Side2.port, convection3.port_a)
    annotation (Line(points={{44,70},{21,70}},   color={191,0,0}));
  connect(Air_DHX_Side1.port, convection2.port_a)
    annotation (Line(points={{54,122},{35,122}}, color={191,0,0}));
  connect(Q_DHX_Input_2HP.y, DHX1.Q_flow_ext)
    annotation (Line(points={{75,150},{60,150}}, color={0,0,127}));
  connect(Air_PCM_Axial1.port,convection4. port_a)
    annotation (Line(points={{-128,200},{-128,185}},
                                                   color={191,0,0}));
  connect(convection4.port_b,simpleWall1. port_b)
    annotation (Line(points={{-128,171},{-128,158}},
                                                   color={191,0,0}));
  connect(convection7.port_b,simpleWall4. port_b)
    annotation (Line(points={{-126,47},{-126,58}}, color={191,0,0}));
  connect(convection7.port_a,Air_PCM_Axial2. port)
    annotation (Line(points={{-126,33},{-126,22}}, color={191,0,0}));
  connect(HITB_Main1.port_b1, HITB_Wick1.port_a)
    annotation (Line(points={{-116,100},{-102,100}},
                                                   color={191,0,0}));
  connect(HITB_Main1.port_b2, simpleWall1.port_a) annotation (Line(points={{-126,
          110},{-126,132},{-128,132},{-128,138}}, color={191,0,0}));
  connect(HITB_Main1.port_a1, Air_CHX_Side3.port)
    annotation (Line(points={{-136,100},{-142,100}}, color={191,0,0}));
  connect(HITB_Main1.port_a2, simpleWall4.port_a)
    annotation (Line(points={{-126,90},{-126,78}},   color={191,0,0}));

  connect(PCM_Core.port_b[:, 1], PCM_Pipe_Wall.port_b) annotation (Line(points={{170.14,
          -6.84},{170.14,46},{146,46},{146,-76},{140,-76}},        color={191,0,
          0}));
  connect(PCM_Core.port_b[:, 2], PCM_Pipe_Wall1.port_b) annotation (Line(points=
         {{170.14,-6.84},{170.14,46.58},{78,46.58},{78,100}}, color={191,0,0}));
  connect(charge_demand_table1.y[1], controls_Construction.charge_demand)
    annotation (Line(points={{165,98},{188,98},{188,110},{200,110}}, color={0,0,
          127}));
  connect(controls_Construction.discharge_demand, discharge_demand_table1.y[1])
    annotation (Line(points={{200,120},{170,120},{170,140},{165,140}}, color={0,
          0,127}));
  connect(collector1.port_b, HITB_Wall.port_b)
    annotation (Line(points={{-14,-76},{-26,-76}}, color={191,0,0}));
  connect(collector1.port_a[1], collector_1HP_HITB.port_a) annotation (Line(
        points={{6,-76.4},{18,-76.4},{18,-76},{28,-76}}, color={191,0,0}));
  connect(collector__1HP_CHX.port_a, collector1.port_a[2]) annotation (Line(
        points={{32,-124},{18,-124},{18,-76.2},{6,-76.2}}, color={191,0,0}));
  connect(collector_1HP_DHX.port_a, collector1.port_a[3])
    annotation (Line(points={{28,-56},{18,-56},{18,-76},{6,-76}},
                                                        color={191,0,0}));
  connect(collector_1HP_Air_DHX.port_a, collector1.port_a[4]) annotation (Line(
        points={{30,-34},{18,-34},{18,-76},{6,-76},{6,-75.8}},
                                                             color={191,0,0}));
  connect(collector_1HP_Air_CHX.port_a, collector1.port_a[5]) annotation (Line(
        points={{28,-102},{18,-102},{18,-75.6},{6,-75.6}}, color={191,0,0}));
  connect(HITB_PCM_Gap2.port_b, PCM_Pipe_Wall.port_a)
    annotation (Line(points={{90,-76},{120,-76}}, color={191,0,0}));
  connect(collector_1HP_HITB.port_b, HITB_PCM_Gap2.port_a)
    annotation (Line(points={{48,-76},{70,-76}}, color={191,0,0}));
  connect(convection1.port_b, collector_1HP_Air_CHX.port_b[1])
    annotation (Line(points={{69,-102},{48,-102}}, color={191,0,0}));
  connect(convection.port_b, collector_1HP_DHX.port_b[1])
    annotation (Line(points={{81,-54},{81,-56},{48,-56}}, color={191,0,0}));
  connect(signal_Position.u2,signal_Q_DHX1. y)
    annotation (Line(points={{246,50},{234,50},{234,32},{225,32}},
                                                 color={0,0,127}));
  connect(signal_Position.u1,const. y) annotation (Line(points={{246,62},{230,62},
          {230,80},{225,80}},  color={0,0,127}));
  connect(greaterEqualThreshold.y,triggeredTrapezoid. u)
    annotation (Line(points={{163,280},{188,280}}, color={255,0,255}));
  connect(Q_CHX_Input2.y,greaterEqualThreshold. u)
    annotation (Line(points={{115,280},{140,280}}, color={0,0,127}));
  connect(triggeredTrapezoid.y,add_Q_CHX. u1)
    annotation (Line(points={{211,280},{220,280},{220,266}}, color={0,0,127}));
  connect(signal_Q_CHX.y,add_Q_CHX. u2) annotation (Line(points={{163,250},{210,
          250},{210,254},{220,254}}, color={0,0,127}));
  connect(lessEqualThreshold.y,triggeredTrapezoid1. u)
    annotation (Line(points={{147,188},{172,188}},
                                                 color={255,0,255}));
  connect(Q_CHX_Input3.y,lessEqualThreshold. u)
    annotation (Line(points={{99,188},{124,188}},color={0,0,127}));
  connect(triggeredTrapezoid1.y,add_Q_DHX. u1) annotation (Line(points={{195,188},
          {200,188},{200,210},{210,210}},
                                       color={0,0,127}));
  connect(add_Q_DHX.u2,signal_Q_DHX. y) annotation (Line(points={{210,222},{168,
          222},{168,216},{163,216}},
                              color={0,0,127}));
  connect(PCM_Pipe_Wall1.port_a, HITB_PCM_Gap2HP.port_b)
    annotation (Line(points={{58,100},{48,100}}, color={191,0,0}));
  connect(HITB_PCM_Gap2HP.port_a, collector_1HP_HITB1.port_b)
    annotation (Line(points={{28,100},{16,100}}, color={191,0,0}));
  connect(collector2.port_a[1], collector_2HP_Air_DHX.port_a) annotation (Line(
        points={{-26,99.6},{-22,99.6},{-22,150},{-12,150}},
        color={191,0,0}));
  connect(collector_2HP_DGap.port_b[1], convection2.port_b)
    annotation (Line(points={{8,122},{21,122}}, color={191,0,0}));
  connect(collector_2HP_DGap.port_a, collector2.port_a[2]) annotation (Line(
        points={{-12,122},{-22,122},{-22,99.8},{-26,99.8}}, color={191,0,0}));
  connect(collector_1HP_HITB1.port_a, collector2.port_a[3])
    annotation (Line(points={{-4,100},{-26,100}}, color={191,0,0}));
  connect(collector_2HP_Air_CHX.port_a, collector2.port_a[4]) annotation (Line(
        points={{-18,70},{-22,70},{-22,100.2},{-26,100.2}},
        color={191,0,0}));
  connect(collector__2HP_CHX.port_a, collector2.port_a[5]) annotation (Line(
        points={{-18,40},{-22,40},{-22,100.4},{-26,100.4}},
                        color={191,0,0}));
  connect(convection3.port_b, collector_2HP_Air_CHX.port_b[1])
    annotation (Line(points={{7,70},{2,70}}, color={191,0,0}));
  connect(DHX.port, generic.port_a)
    annotation (Line(points={{96,-30},{83,-30}}, color={191,0,0}));
  connect(collector_1HP_Air_DHX.port_b[1], generic.port_b) annotation (Line(
        points={{50,-34},{58,-34},{58,-30},{69,-30}}, color={191,0,0}));
  connect(CHX.port, generic1.port_a)
    annotation (Line(points={{90,-126},{79,-126}}, color={191,0,0}));
  connect(collector__1HP_CHX.port_b[1], generic1.port_b) annotation (Line(
        points={{52,-124},{58,-124},{58,-126},{65,-126}}, color={191,0,0}));
  connect(generic2.port_a, collector__2HP_CHX.port_b[1])
    annotation (Line(points={{13,38},{2,38},{2,40}}, color={191,0,0}));
  connect(generic2.port_b, CHX1.port)
    annotation (Line(points={{27,38},{36,38}}, color={191,0,0}));
  connect(DHX1.port, generic3.port_b)
    annotation (Line(points={{46,150},{33,150}}, color={191,0,0}));
  connect(collector_2HP_Air_DHX.port_b[1], generic3.port_a)
    annotation (Line(points={{8,150},{19,150}}, color={191,0,0}));
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
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{200,120}}),
                                                     graphics={Text(
          extent={{-34,9},{34,-9}},
          textColor={28,108,200},
          origin={10,5},
          rotation=360,
          textString="R direction -->"),                       Text(
          extent={{-34,9},{34,-9}},
          textColor={28,108,200},
          origin={-18,181},
          rotation=360,
          textString="R direction -->"),                       Text(
          extent={{-34,9},{34,-9}},
          textColor={28,108,200},
          origin={-26,-55},
          rotation=360,
          textString="Single HP"),                             Text(
          extent={{-34,9},{34,-9}},
          textColor={28,108,200},
          origin={-74,127},
          rotation=360,
          textString="Dual HP")}),
    experiment(
      StopTime=1e-06,
      __Dymola_NumberOfIntervals=750,
      __Dymola_Algorithm="Dassl"));
end HITB_Experiment_03_09;
