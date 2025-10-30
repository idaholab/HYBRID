within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HITB_Tests;
model HITB_Experiment_03_03 "Attempt 03 at HITB experiment."
  import Unnamed;
  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";
  Modelica.Units.SI.Area SA_DHX_Side;
  Modelica.Units.SI.Area SA_CHX_Side;
  Modelica.Units.SI.Area[nV_Z,nV_Zh] SA_PCM_HITB;

  Modelica.Units.SI.Area A_Cyl_HITB[nV_Rh];
  parameter Integer nV_Z = 8;
  parameter Integer nV_Zh = 6;
  parameter Integer nV_R = 10;
  parameter Integer nV_Rh = 5;
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
  parameter Modelica.Units.SI.Length l_DHX = l_CHX "Length of section where heat pipe can be cooled by DHX";
  parameter Modelica.Units.SI.Length l_gap_CHX = 0.2 "Length of section between the CHX and the PCM";
  parameter Modelica.Units.SI.Length l_gap_DHX = 0.2 "Length of section between the DHX and the PCM";
  parameter Modelica.Units.SI.Length l_PCM =  0.6 "Length of PCM heat exchange potential";
  parameter Modelica.Units.SI.Length l_experiment = l_CHX+l_DHX+l_gap_CHX+l_gap_DHX+l_PCM;
  Modelica.Units.SI.Length z_position_min;
  Modelica.Units.SI.Length z_position_max = z_position_min+l_HITB;
  Modelica.Units.SI.Length z_position_HITB[nV_Z+1];
  Modelica.Units.SI.Length z_position_PCM[nV_Z+1] = linspace(l_CHX+l_gap_CHX,l_CHX+l_gap_CHX+l_PCM,nV_Z+1);
  Modelica.Units.SI.Length z_overlap[nV_Zh, nV_Z];
  Modelica.Units.SI.Area SA_PCM_Heated[nV_Z];
  Modelica.Units.SI.Power Q_CHX;
  Modelica.Units.SI.Power Q_DHX;
  Modelica.Units.SI.Power Q_CHX_theory;
  Modelica.Units.SI.Power Q_DHX_theory;
  parameter Modelica.Units.SI.Temperature T_melt = 443+273.15 "Used for graphics only";
  Modelica.Units.SI.Time time_plot;
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 2.5;

  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Pipe_Wall[nV_Z](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    length=l_HITB,
    r_inner=R_PCM_inner,
    r_outer=R_PCM_inner + t_PCM_pipe,
    exposeState_a=false,
    exposeState_b=false)
    annotation (Placement(transformation(extent={{86,-18},{106,2}})));

  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wick[nV_Zh](
    length=l_HITB,
    r_inner=R_Na,
    r_outer=R_Wick,
    redeclare package Material = HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-74,-18},{-54,2}})));

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D HITB_Main(
    redeclare package Material = HITB.PCM_Materials.Sodium_New (k_eff_mult=60),
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
        origin={-98,-8})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow CHX[nV_Zh](
      use_port=true)
    annotation (Placement(transformation(extent={{38,44},{18,64}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow DHX[nV_Zh](
      use_port=true)
    annotation (Placement(transformation(extent={{42,-84},{22,-64}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_CHX_Side[nV_Zh]
    annotation (Placement(transformation(extent={{76,26},{56,46}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_DHX_Side[nV_Zh](T=
        293.15)
    annotation (Placement(transformation(extent={{76,-62},{56,-42}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection[nV_Zh](
      surfaceArea=SA_DHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{40,-62},{20,-42}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection1[nV_Zh](
      surfaceArea=SA_CHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{36,26},{16,46}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wall[nV_Zh](
    length=l_HITB,
    r_inner=R_Wick,
    r_outer=R_HITB,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-46,-18},{-26,2}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_PCM_Gap[nV_Z,
    nV_Zh](
    redeclare package Material =
        TRANSFORM.Media.Solids.CustomSolids.Lambda_0_33_d_1200_cp_500,
    T_start=723.15,
    length=l_HITB,
    r_inner=R_HITB,
    r_outer=R_PCM_inner,
    exposeState_a=true)
    annotation (Placement(transformation(extent={{40,-18},{60,2}})));
  Modelica.Blocks.Sources.RealExpression Q_CHX_Input[nV_Zh](y=Q_CHX/nV_Zh)
    annotation (Placement(transformation(extent={{66,44},{46,64}})));
  Modelica.Blocks.Sources.RealExpression Q_DHX_Input[nV_Zh](y=Q_DHX/nV_Zh)
    annotation (Placement(transformation(extent={{72,-84},{52,-64}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector[nV_Zh](n=
        nV_Z + 4)
    annotation (Placement(transformation(extent={{2,-18},{-18,2}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_CHX(
    amplitude=1.5e3,
    rising=100,
    width=26000,
    falling=100,
    period=72200)
    annotation (Placement(transformation(extent={{262,102},{282,122}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX(
    amplitude=-1e3,
    rising=100,
    width=26000,
    falling=100,
    period=72200,
    startTime=36500)
    annotation (Placement(transformation(extent={{260,66},{280,86}})));
  Modelica.Blocks.Math.Add     signal_Position
    annotation (Placement(transformation(extent={{260,34},{280,54}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX1(
    amplitude=1,
    rising=100,
    width=31000,
    falling=100,
    period=72200,
    startTime=36500)
    annotation (Placement(transformation(extent={{228,28},{248,48}})));
  Modelica.Blocks.Sources.Constant const(k=0.0)
    annotation (Placement(transformation(extent={{216,58},{236,78}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection Area_correction_convection[nV_Z,
    nV_Zh](
          surfaceArea=SA_PCM_HITB, alpha=1e10)
    annotation (Placement(transformation(extent={{34,-18},{14,2}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector1[nV_Z](n=
        nV_Zh) annotation (Placement(transformation(extent={{64,-18},{84,2}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall2[nV_Rh](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,40})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial3[nV_Rh](T=
        293.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-100,102})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection5[nV_Rh](
      surfaceArea=A_Cyl_HITB, alpha=hc_air)
                                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-100,70})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall3[nV_Rh](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-98,-40})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial4[nV_Rh](T=
        293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-98,-96})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection6[nV_Rh](
      surfaceArea=A_Cyl_HITB, alpha=hc_air)
                                           annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-98,-68})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic Air_CHX_Side1[nV_Zh]
    annotation (Placement(transformation(extent={{-134,-18},{-114,2}})));

  Modelica.Blocks.Sources.Sine signal_R_Na(
    amplitude=0.1*R_Na,
    f=300,
    offset=R_Na,
    startTime=300)
    annotation (Placement(transformation(extent={{236,158},{256,178}})));
  Components.PCM_Volume.PCM_Chamber_vertsym PCM_Core(
    nZ=nV_Z,
    drs_one=1/1000*{25,25,23.66,142.26 - 73.66,27.76,25,25,25,25,35.287 -
        12.538},
    hc_air=hc_air)
    annotation (Placement(transformation(extent={{128,-66},{226,36}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Pipe_Wall1
                                                                         [nV_Z](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=723.15,
    length=l_HITB,
    r_inner=R_PCM_inner,
    r_outer=R_PCM_inner + t_PCM_pipe,
    exposeState_a=false,
    exposeState_b=false)
    annotation (Placement(transformation(extent={{76,196},{96,216}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wick1[nV_Zh](
    length=l_HITB,
    r_inner=R_Na,
    r_outer=R_Wick,
    redeclare package Material = HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-84,196},{-64,216}})));

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D HITB_Main1(
    redeclare package Material = HITB.PCM_Materials.Sodium_New (k_eff_mult=60),
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
        origin={-108,206})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow CHX1
                                                                    [nV_Zh](use_port=
       true)
    annotation (Placement(transformation(extent={{28,258},{8,278}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow DHX1
                                                                    [nV_Zh](use_port=
       true)
    annotation (Placement(transformation(extent={{34,130},{14,150}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_CHX_Side2
                                                                                [nV_Zh]
    annotation (Placement(transformation(extent={{66,240},{46,260}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_DHX_Side1
                                                                                [nV_Zh](T=293.15)
    annotation (Placement(transformation(extent={{68,152},{48,172}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection2
                                                                      [nV_Zh](
      surfaceArea=SA_DHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{32,152},{12,172}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection3[nV_Zh](
      surfaceArea=SA_CHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{26,240},{6,260}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wall1
                                                                     [nV_Zh](
    length=l_HITB,
    r_inner=R_Wick,
    r_outer=R_HITB,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-56,196},{-36,216}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_PCM_Gap1
                                                                        [nV_Z,
    nV_Zh](
    redeclare package Material =
        TRANSFORM.Media.Solids.CustomSolids.Lambda_0_33_d_1200_cp_500,
    T_start=723.15,
    length=l_HITB,
    r_inner=R_HITB,
    r_outer=R_PCM_inner,
    exposeState_a=true)
    annotation (Placement(transformation(extent={{30,196},{50,216}})));
  Modelica.Blocks.Sources.RealExpression Q_CHX_Input1
                                                    [nV_Zh](y=Q_CHX/nV_Zh)
    annotation (Placement(transformation(extent={{56,258},{36,278}})));
  Modelica.Blocks.Sources.RealExpression Q_DHX_Input1
                                                    [nV_Zh](y=Q_DHX/nV_Zh)
    annotation (Placement(transformation(extent={{64,130},{44,150}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector2
                                                                           [nV_Zh](n=nV_Z
         + 4)
    annotation (Placement(transformation(extent={{-8,196},{-28,216}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection Area_correction_convection1
                                                                                      [nV_Z,
    nV_Zh](surfaceArea=SA_PCM_HITB, alpha=1e10)
    annotation (Placement(transformation(extent={{24,196},{4,216}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector3[nV_Z](n=nV_Zh)
               annotation (Placement(transformation(extent={{54,196},{74,216}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall1[nV_Rh](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-110,254})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial1[nV_Rh](T=293.15)
                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-110,316})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection4[nV_Rh](
      surfaceArea=A_Cyl_HITB, alpha=hc_air)
                                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-110,284})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall4[nV_Rh](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-108,174})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial2[nV_Rh](T=293.15)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-108,118})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection7[nV_Rh](
      surfaceArea=A_Cyl_HITB, alpha=hc_air)
                                           annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-108,146})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic Air_CHX_Side3[nV_Zh]
    annotation (Placement(transformation(extent={{-144,196},{-124,216}})));
protected
  Real Q_CHX_linear(unit = "W/m") = Q_CHX_theory/l_CHX;
  Real Q_DHX_linear(unit = "W/m") = Q_DHX_theory/l_DHX;
equation
  time_plot = time;
  cp_out = PCM_Core.conduction.Material.specificHeatCapacityCp(PCM_Core.conduction.materials[1,1, 1].state);
  Position = signal_Position.y;
  der(E_store) = sum(PCM_Core.port_b.Q_flow);
  A_Cyl_HITB = HITB_Main.geometry.crossAreas_2[:,1];
  SA_CHX_Side = l_gap_CHX*Modelica.Constants.pi*R_HITB*(1.0-max(0.5,Position))/0.5;
  SA_DHX_Side = l_gap_DHX*Modelica.Constants.pi*R_HITB*min(Position,0.5)/0.5;
  Q_CHX = Q_CHX_theory*(0.5-min(Position,0.5))/0.5;
  Q_DHX = Q_DHX_theory*(max(0.5,Position)-0.5)/0.5;
  Q_CHX_theory = signal_Q_CHX.y;
  Q_DHX_theory = signal_Q_DHX.y;

  z_position_min = Position*(l_experiment-l_HITB);
  z_position_HITB = linspace(z_position_min,z_position_max,nV_Z+1);

  //  SA_PCM_HITB = z_overlap.*Modelica.Constants.pi*2*R_HITB;

  /* NOTES 
  The heat rate by node for the charging and discharging heat exchangers both need to be adjusted to account for the fact
  that the rod is moving. At the moment, the entire rod is being heated & cooled evenly. The overall heat rate is still being 
  adjusted and is accounted for, but this i snot accurate. The heat needs to be inserted to the correct nodes only.
  
  
  
  */

  for i in 1:nV_Zh loop //i will indicate PCM location
    for j in 1:nV_Z loop //j will indicate HITB location

  connect(Area_correction_convection1[j, i].port_b, collector2[i].port_a[j + 2])
    annotation (Line(points={{7,206},{-8,206}}, color={191,0,0}));
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
        connect(Area_correction_convection[j,i].port_b, collector[i].port_a[j+2])
    annotation (Line(points={{17,-8},{2,-8}}, color={191,0,0}));
    end for;
  end for;
  for j in 1:nV_Z loop
    SA_PCM_Heated[j] = sum(SA_PCM_HITB[j,:]);
  end for;

  connect(HITB_Wall.port_a, HITB_Wick.port_b)
    annotation (Line(points={{-46,-8},{-54,-8}}, color={191,0,0}));

  connect(HITB_Wall.port_b, collector.port_b)
    annotation (Line(points={{-26,-8},{-18,-8}}, color={191,0,0}));

  connect(signal_Position.u2, signal_Q_DHX1.y)
    annotation (Line(points={{258,38},{249,38}}, color={0,0,127}));
  connect(signal_Position.u1, const.y) annotation (Line(points={{258,50},{252,50},
          {252,68},{237,68}},  color={0,0,127}));

  connect(HITB_PCM_Gap.port_a, Area_correction_convection.port_a)
    annotation (Line(points={{40,-8},{31,-8}}, color={191,0,0}));
  connect(collector.port_a[1], CHX.port)
    annotation (Line(points={{2,-8},{6,-8},{6,54},{18,54}}, color={191,0,0}));
  connect(Q_CHX_Input.y, CHX.Q_flow_ext)
    annotation (Line(points={{45,54},{32,54}}, color={0,0,127}));
  connect(convection1.port_b, collector.port_a[2])
    annotation (Line(points={{19,36},{6,36},{6,-8},{2,-8}},
                                                     color={191,0,0}));
  connect(Air_CHX_Side.port, convection1.port_a)
    annotation (Line(points={{56,36},{33,36}}, color={191,0,0}));
  connect(convection.port_b, collector.port_a[nV_Z + 3])
    annotation (Line(points={{23,-52},{4,-52},{4,-10},{2,-10},{2,-8}},
                                                       color={191,0,0}));
  connect(DHX.port, collector.port_a[nV_Z + 4]) annotation (Line(points={{22,-74},
          {4,-74},{4,-8},{2,-8}},            color={191,0,0}));
  connect(Air_DHX_Side.port, convection.port_a)
    annotation (Line(points={{56,-52},{37,-52}}, color={191,0,0}));
  connect(Q_DHX_Input.y, DHX.Q_flow_ext)
    annotation (Line(points={{51,-74},{36,-74}}, color={0,0,127}));
  connect(HITB_PCM_Gap.port_b, collector1.port_a)
    annotation (Line(points={{60,-8},{64,-8}}, color={191,0,0}));
  connect(collector1.port_b, PCM_Pipe_Wall.port_a)
    annotation (Line(points={{84,-8},{86,-8}}, color={191,0,0}));
  connect(Air_PCM_Axial3.port, convection5.port_a)
    annotation (Line(points={{-100,92},{-100,77}}, color={191,0,0}));
  connect(convection5.port_b, simpleWall2.port_b)
    annotation (Line(points={{-100,63},{-100,50}}, color={191,0,0}));
  connect(convection6.port_b, simpleWall3.port_b)
    annotation (Line(points={{-98,-61},{-98,-50}}, color={191,0,0}));
  connect(convection6.port_a, Air_PCM_Axial4.port)
    annotation (Line(points={{-98,-75},{-98,-86}}, color={191,0,0}));
  connect(HITB_Main.port_b1, HITB_Wick.port_a)
    annotation (Line(points={{-88,-8},{-74,-8}}, color={191,0,0}));
  connect(HITB_Main.port_b2, simpleWall2.port_a) annotation (Line(points={{-98,2},
          {-98,24},{-100,24},{-100,30}}, color={191,0,0}));
  connect(HITB_Main.port_a1, Air_CHX_Side1.port)
    annotation (Line(points={{-108,-8},{-114,-8}}, color={191,0,0}));
  connect(HITB_Main.port_a2, simpleWall3.port_a)
    annotation (Line(points={{-98,-18},{-98,-30}}, color={191,0,0}));
  connect(PCM_Core.port_b[:, 1], PCM_Pipe_Wall.port_b) annotation (Line(points={{183.86,
          -6.84},{183.86,34},{124,34},{124,-8},{106,-8}},         color={191,0,0}));
  connect(HITB_Wall1.port_a, HITB_Wick1.port_b)
    annotation (Line(points={{-56,206},{-64,206}}, color={191,0,0}));
  connect(HITB_Wall1.port_b, collector2.port_b)
    annotation (Line(points={{-36,206},{-28,206}}, color={191,0,0}));
  connect(HITB_PCM_Gap1.port_a, Area_correction_convection1.port_a)
    annotation (Line(points={{30,206},{21,206}}, color={191,0,0}));
  connect(collector2.port_a[1], CHX1.port) annotation (Line(points={{-8,206},{-4,
          206},{-4,268},{8,268}}, color={191,0,0}));
  connect(Q_CHX_Input1.y, CHX1.Q_flow_ext)
    annotation (Line(points={{35,268},{22,268}}, color={0,0,127}));
  connect(convection3.port_b, collector2.port_a[2])
    annotation (Line(points={{9,250},{-8,250},{-8,206}}, color={191,0,0}));
  connect(Air_CHX_Side2.port, convection3.port_a)
    annotation (Line(points={{46,250},{23,250}}, color={191,0,0}));
  connect(convection2.port_b, collector2.port_a[nV_Z + 3])
    annotation (Line(points={{15,162},{-8,162},{-8,206}}, color={191,0,0}));
  connect(DHX1.port, collector2.port_a[nV_Z + 4]) annotation (Line(points={{14,140},
          {2,140},{2,138},{-8,138},{-8,206}}, color={191,0,0}));
  connect(Air_DHX_Side1.port, convection2.port_a)
    annotation (Line(points={{48,162},{29,162}}, color={191,0,0}));
  connect(Q_DHX_Input1.y, DHX1.Q_flow_ext)
    annotation (Line(points={{43,140},{28,140}}, color={0,0,127}));
  connect(HITB_PCM_Gap1.port_b, collector3.port_a)
    annotation (Line(points={{50,206},{54,206}}, color={191,0,0}));
  connect(collector3.port_b, PCM_Pipe_Wall1.port_a)
    annotation (Line(points={{74,206},{76,206}}, color={191,0,0}));
  connect(Air_PCM_Axial1.port,convection4. port_a)
    annotation (Line(points={{-110,306},{-110,291}},
                                                   color={191,0,0}));
  connect(convection4.port_b,simpleWall1. port_b)
    annotation (Line(points={{-110,277},{-110,264}},
                                                   color={191,0,0}));
  connect(convection7.port_b,simpleWall4. port_b)
    annotation (Line(points={{-108,153},{-108,164}},
                                                   color={191,0,0}));
  connect(convection7.port_a,Air_PCM_Axial2. port)
    annotation (Line(points={{-108,139},{-108,128}},
                                                   color={191,0,0}));
  connect(HITB_Main1.port_b1, HITB_Wick1.port_a)
    annotation (Line(points={{-98,206},{-84,206}}, color={191,0,0}));
  connect(HITB_Main1.port_b2, simpleWall1.port_a) annotation (Line(points={{-108,
          216},{-108,238},{-110,238},{-110,244}}, color={191,0,0}));
  connect(HITB_Main1.port_a1, Air_CHX_Side3.port)
    annotation (Line(points={{-118,206},{-124,206}}, color={191,0,0}));
  connect(HITB_Main1.port_a2, simpleWall4.port_a)
    annotation (Line(points={{-108,196},{-108,184}}, color={191,0,0}));
  connect(PCM_Core.port_b[:, 2], PCM_Pipe_Wall1.port_b) annotation (Line(points={{183.86,
          -6.84},{183.86,206},{96,206}},         color={191,0,0}));

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
          origin={10,73},
          rotation=360,
          textString="R direction -->"),                       Text(
          extent={{-34,9},{34,-9}},
          textColor={28,108,200},
          origin={0,287},
          rotation=360,
          textString="R direction -->")}),
    experiment(
      StopTime=432000,
      __Dymola_NumberOfIntervals=750,
      __Dymola_Algorithm="Dassl"));
end HITB_Experiment_03_03;
