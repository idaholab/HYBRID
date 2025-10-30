within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HITB_Tests;
model HITB_Experiment_03_07 "Attempt 03 at HITB experiment."

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
    annotation (Placement(transformation(extent={{86,-86},{106,-66}})));

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

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow CHX[nV_Zh](
      use_port=true)
    annotation (Placement(transformation(extent={{38,-24},{18,-4}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow DHX[nV_Zh](
      use_port=true)
    annotation (Placement(transformation(extent={{42,-152},{22,-132}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_CHX_Side[nV_Zh](T=T_air)
    annotation (Placement(transformation(extent={{76,-42},{56,-22}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_DHX_Side[nV_Zh](T=T_air)
    annotation (Placement(transformation(extent={{76,-130},{56,-110}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection[nV_Zh](
      surfaceArea=SA_DHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{40,-130},{20,-110}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection1[nV_Zh](
      surfaceArea=SA_CHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{36,-42},{16,-22}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wall[nV_Zh](
    length=l_HITB,
    r_inner=R_Wick,
    r_outer=R_HITB,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-46,-86},{-26,-66}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_PCM_Gap[nV_Z,
    nV_Zh](
    redeclare package Material = HITB.PCM_Materials.Lambda_00_24_d_1200_cp_500,
    T_start=723.15,
    length=l_HITB,
    r_inner=R_HITB,
    r_outer=R_PCM_inner,
    exposeState_a=true)
    annotation (Placement(transformation(extent={{40,-86},{60,-66}})));

  Modelica.Blocks.Sources.RealExpression Q_CHX_Input[nV_Zh](y=Q_CHX/nV_Zh)
    annotation (Placement(transformation(extent={{66,-24},{46,-4}})));
  Modelica.Blocks.Sources.RealExpression Q_DHX_Input[nV_Zh](y=Q_DHX/nV_Zh)
    annotation (Placement(transformation(extent={{72,-152},{52,-132}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector[nV_Zh](n=
        nV_Z + 4)
    annotation (Placement(transformation(extent={{2,-86},{-18,-66}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_CHX(
    amplitude=1e3,
    rising=100,
    width=3600*4,
    falling=100,
    period=3600*6)
    annotation (Placement(transformation(extent={{246,146},{266,166}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX(
    amplitude=-1e3,
    rising=100,
    width=3600*2,
    falling=100,
    period=3600*6,
    startTime=3600*3)
    annotation (Placement(transformation(extent={{246,112},{266,132}})));
  Modelica.Blocks.Math.Add     signal_Position
    annotation (Placement(transformation(extent={{278,-8},{298,12}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX1(
    amplitude=1,
    rising=100,
    width=42000,
    falling=100,
    period=86400,
    startTime=43000)
    annotation (Placement(transformation(extent={{234,-32},{254,-12}})));
  Modelica.Blocks.Sources.Constant const(k=0.0)
    annotation (Placement(transformation(extent={{234,16},{254,36}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection Area_correction_convection[nV_Z,
    nV_Zh](
          surfaceArea=SA_PCM_HITB, alpha=1e10)
    annotation (Placement(transformation(extent={{34,-86},{14,-66}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector1[nV_Z](n=
        nV_Zh) annotation (Placement(transformation(extent={{64,-86},{84,-66}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall2[nV_Rh](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-28})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial3[nV_Rh](T=T_air)
                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-100,34})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection5[nV_Rh](
      surfaceArea=A_Cyl_HITB, alpha=hc_air)
                                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-100,2})));
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
    annotation (Placement(transformation(extent={{-156,-84},{-136,-64}})));

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

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow CHX1
                                                                    [nV_Zh](use_port=
       true)
    annotation (Placement(transformation(extent={{10,152},{-10,172}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow DHX1
                                                                    [nV_Zh](use_port=
       true)
    annotation (Placement(transformation(extent={{16,24},{-4,44}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_CHX_Side2
                                                                                [nV_Zh](T=T_air)
    annotation (Placement(transformation(extent={{48,134},{28,154}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_DHX_Side1
                                                                                [nV_Zh](T=T_air)
    annotation (Placement(transformation(extent={{50,46},{30,66}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection2
                                                                      [nV_Zh](
      surfaceArea=SA_DHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{14,46},{-6,66}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection3[nV_Zh](
      surfaceArea=SA_CHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{8,134},{-12,154}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wall1
                                                                     [nV_Zh](
    length=l_HITB,
    r_inner=R_Wick,
    r_outer=R_HITB,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-74,90},{-54,110}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_PCM_Gap1
                                                                        [nV_Z,
    nV_Zh](
    redeclare package Material = HITB.PCM_Materials.Lambda_00_24_d_1200_cp_500,
    T_start=723.15,
    length=l_HITB,
    r_inner=R_HITB,
    r_outer=R_PCM_inner,
    exposeState_a=true)
    annotation (Placement(transformation(extent={{12,90},{32,110}})));

  Modelica.Blocks.Sources.RealExpression Q_CHX_Input1
                                                    [nV_Zh](y=Q_CHX/nV_Zh)
    annotation (Placement(transformation(extent={{38,152},{18,172}})));
  Modelica.Blocks.Sources.RealExpression Q_DHX_Input1
                                                    [nV_Zh](y=Q_DHX/nV_Zh)
    annotation (Placement(transformation(extent={{46,24},{26,44}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector2
                                                                           [nV_Zh](n=nV_Z
         + 4)
    annotation (Placement(transformation(extent={{-26,90},{-46,110}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection Area_correction_convection1
                                                                                      [nV_Z,
    nV_Zh](surfaceArea=SA_PCM_HITB, alpha=1e10)
    annotation (Placement(transformation(extent={{6,90},{-14,110}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector3[nV_Z](n=nV_Zh)
               annotation (Placement(transformation(extent={{36,90},{56,110}})));
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
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       443 + 273.15 + 25)
    annotation (Placement(transformation(extent={{246,176},{266,196}})));
  Modelica.Blocks.Sources.RealExpression Q_CHX_Input2(y=PCM_Core.T_ave_r[
        PCM_Core.nR])
    annotation (Placement(transformation(extent={{198,176},{218,196}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
    amplitude=-1e3,
    rising=100,
    falling=600,
    offset=0)
    annotation (Placement(transformation(extent={{294,176},{314,196}})));
  Modelica.Blocks.Math.Add add_Q_CHX
    annotation (Placement(transformation(extent={{326,156},{346,176}})));
  Modelica.Blocks.Logical.LessEqualThreshold    lessEqualThreshold(threshold=443
         + 273.15 - 5)
    annotation (Placement(transformation(extent={{230,84},{250,104}})));
  Modelica.Blocks.Sources.RealExpression Q_CHX_Input3(y=PCM_Core.T_ave_r[
        PCM_Core.nR])
    annotation (Placement(transformation(extent={{182,84},{202,104}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid1(
    amplitude=1e3,
    rising=100,
    falling=600,
    offset=0)
    annotation (Placement(transformation(extent={{278,84},{298,104}})));
  Modelica.Blocks.Math.Add add_Q_DHX
    annotation (Placement(transformation(extent={{316,132},{336,112}})));

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
  Q_CHX_theory = max(0,add_Q_CHX.y);
  Q_DHX_theory = min(0,add_Q_DHX.y);

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
    annotation (Line(points={{-11,100},{-26,100}},
                                                color={191,0,0}));
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
    annotation (Line(points={{17,-76},{2,-76}},
                                              color={191,0,0}));
    end for;
  end for;
  for j in 1:nV_Z loop
    SA_PCM_Heated[j] = sum(SA_PCM_HITB[j,:]);
  end for;
  Q_loss = sum(Air_CHX_Side.port.Q_flow)+sum(Air_CHX_Side1.port.Q_flow)+sum(Air_CHX_Side2.port.Q_flow)+sum(Air_CHX_Side3.port.Q_flow)+sum(Air_DHX_Side.port.Q_flow)+sum(Air_DHX_Side1.port.Q_flow)+sum(Air_PCM_Axial1.port.Q_flow)+sum(Air_PCM_Axial2.port.Q_flow)+sum(Air_PCM_Axial3.port.Q_flow)+sum(Air_PCM_Axial4.port.Q_flow) + PCM_Core.Q_loss;

  connect(HITB_Wall.port_a, HITB_Wick.port_b)
    annotation (Line(points={{-46,-76},{-54,-76}},
                                                 color={191,0,0}));

  connect(HITB_Wall.port_b, collector.port_b)
    annotation (Line(points={{-26,-76},{-18,-76}},
                                                 color={191,0,0}));

  connect(signal_Position.u2, signal_Q_DHX1.y)
    annotation (Line(points={{276,-4},{260,-4},{260,-22},{255,-22}},
                                                 color={0,0,127}));
  connect(signal_Position.u1, const.y) annotation (Line(points={{276,8},{276,26},
          {255,26}},           color={0,0,127}));

  connect(HITB_PCM_Gap.port_a, Area_correction_convection.port_a)
    annotation (Line(points={{40,-76},{31,-76}},
                                               color={191,0,0}));
  connect(collector.port_a[1], CHX.port)
    annotation (Line(points={{2,-76},{6,-76},{6,-14},{18,-14}},
                                                            color={191,0,0}));
  connect(Q_CHX_Input.y, CHX.Q_flow_ext)
    annotation (Line(points={{45,-14},{32,-14}},
                                               color={0,0,127}));
  connect(convection1.port_b, collector.port_a[2])
    annotation (Line(points={{19,-32},{6,-32},{6,-76},{2,-76}},
                                                     color={191,0,0}));
  connect(Air_CHX_Side.port, convection1.port_a)
    annotation (Line(points={{56,-32},{33,-32}},
                                               color={191,0,0}));
  connect(convection.port_b, collector.port_a[nV_Z + 3])
    annotation (Line(points={{23,-120},{4,-120},{4,-78},{2,-78},{2,-76}},
                                                       color={191,0,0}));
  connect(DHX.port, collector.port_a[nV_Z + 4]) annotation (Line(points={{22,-142},
          {4,-142},{4,-76},{2,-76}},         color={191,0,0}));
  connect(Air_DHX_Side.port, convection.port_a)
    annotation (Line(points={{56,-120},{37,-120}},
                                                 color={191,0,0}));
  connect(Q_DHX_Input.y, DHX.Q_flow_ext)
    annotation (Line(points={{51,-142},{36,-142}},
                                                 color={0,0,127}));
  connect(HITB_PCM_Gap.port_b, collector1.port_a)
    annotation (Line(points={{60,-76},{64,-76}},
                                               color={191,0,0}));
  connect(collector1.port_b, PCM_Pipe_Wall.port_a)
    annotation (Line(points={{84,-76},{86,-76}},
                                               color={191,0,0}));
  connect(Air_PCM_Axial3.port, convection5.port_a)
    annotation (Line(points={{-100,24},{-100,9}},  color={191,0,0}));
  connect(convection5.port_b, simpleWall2.port_b)
    annotation (Line(points={{-100,-5},{-100,-18}},color={191,0,0}));
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
          {-98,-44},{-100,-44},{-100,-38}},
                                         color={191,0,0}));
  connect(HITB_Main.port_a1, Air_CHX_Side1.port)
    annotation (Line(points={{-108,-76},{-110,-76},{-110,-74},{-136,-74}},
                                                   color={191,0,0}));
  connect(HITB_Main.port_a2, simpleWall3.port_a)
    annotation (Line(points={{-98,-86},{-98,-98}}, color={191,0,0}));
  connect(HITB_Wall1.port_a, HITB_Wick1.port_b)
    annotation (Line(points={{-74,100},{-82,100}}, color={191,0,0}));
  connect(HITB_Wall1.port_b, collector2.port_b)
    annotation (Line(points={{-54,100},{-46,100}}, color={191,0,0}));
  connect(HITB_PCM_Gap1.port_a, Area_correction_convection1.port_a)
    annotation (Line(points={{12,100},{3,100}},  color={191,0,0}));
  connect(collector2.port_a[1], CHX1.port) annotation (Line(points={{-26,100},{
          -22,100},{-22,162},{-10,162}},
                                  color={191,0,0}));
  connect(Q_CHX_Input1.y, CHX1.Q_flow_ext)
    annotation (Line(points={{17,162},{4,162}},  color={0,0,127}));
  connect(convection3.port_b, collector2.port_a[2])
    annotation (Line(points={{-9,144},{-26,144},{-26,100}},
                                                         color={191,0,0}));
  connect(Air_CHX_Side2.port, convection3.port_a)
    annotation (Line(points={{28,144},{5,144}},  color={191,0,0}));
  connect(convection2.port_b, collector2.port_a[nV_Z + 3])
    annotation (Line(points={{-3,56},{-26,56},{-26,100}}, color={191,0,0}));
  connect(DHX1.port, collector2.port_a[nV_Z + 4]) annotation (Line(points={{-4,34},
          {-16,34},{-16,32},{-26,32},{-26,100}},
                                              color={191,0,0}));
  connect(Air_DHX_Side1.port, convection2.port_a)
    annotation (Line(points={{30,56},{11,56}},   color={191,0,0}));
  connect(Q_DHX_Input1.y, DHX1.Q_flow_ext)
    annotation (Line(points={{25,34},{10,34}},   color={0,0,127}));
  connect(HITB_PCM_Gap1.port_b, collector3.port_a)
    annotation (Line(points={{32,100},{36,100}}, color={191,0,0}));
  connect(collector3.port_b, PCM_Pipe_Wall1.port_a)
    annotation (Line(points={{56,100},{58,100}}, color={191,0,0}));
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

  connect(PCM_Core.port_b[:, 1], PCM_Pipe_Wall.port_b) annotation (Line(points=
          {{170.14,-6.84},{170.14,-41.42},{106,-41.42},{106,-76}}, color={191,0,
          0}));
  connect(PCM_Core.port_b[:, 2], PCM_Pipe_Wall1.port_b) annotation (Line(points=
         {{170.14,-6.84},{170.14,46.58},{78,46.58},{78,100}}, color={191,0,0}));
  connect(greaterEqualThreshold.y, triggeredTrapezoid.u)
    annotation (Line(points={{267,186},{292,186}}, color={255,0,255}));
  connect(Q_CHX_Input2.y, greaterEqualThreshold.u)
    annotation (Line(points={{219,186},{244,186}}, color={0,0,127}));
  connect(triggeredTrapezoid.y, add_Q_CHX.u1)
    annotation (Line(points={{315,186},{324,186},{324,172}}, color={0,0,127}));
  connect(signal_Q_CHX.y, add_Q_CHX.u2) annotation (Line(points={{267,156},{314,
          156},{314,160},{324,160}}, color={0,0,127}));
  connect(lessEqualThreshold.y, triggeredTrapezoid1.u)
    annotation (Line(points={{251,94},{276,94}}, color={255,0,255}));
  connect(Q_CHX_Input3.y, lessEqualThreshold.u)
    annotation (Line(points={{203,94},{228,94}}, color={0,0,127}));
  connect(triggeredTrapezoid1.y, add_Q_DHX.u1) annotation (Line(points={{299,94},
          {304,94},{304,116},{314,116}},
                                       color={0,0,127}));
  connect(add_Q_DHX.u2, signal_Q_DHX.y) annotation (Line(points={{314,128},{272,
          128},{272,122},{267,122}},
                              color={0,0,127}));
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
          textString="R direction -->")}),
    experiment(
      StopTime=432000,
      __Dymola_NumberOfIntervals=750,
      __Dymola_Algorithm="Dassl"));
end HITB_Experiment_03_07;
