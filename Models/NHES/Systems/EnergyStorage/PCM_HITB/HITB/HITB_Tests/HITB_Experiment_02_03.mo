within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HITB_Tests;
model HITB_Experiment_02_03
  "Attempt 01 at HITB experiment. Initially, the heat pipe will be assumed to be isothermal."
  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";
  Modelica.Units.SI.Area SA_DHX_Side;
  Modelica.Units.SI.Area SA_CHX_Side;
  Modelica.Units.SI.Area[nV_Zh, nV_Z] SA_PCM_HITB;
  Modelica.Units.SI.Area A_Cyl[nV_R];
  Modelica.Units.SI.Area A_Cyl_HITB[nV_Rh];
  parameter Integer nV_Z = 10;
  parameter Integer nV_Zh = 10;
  parameter Integer nV_R = 10;
  parameter Integer nV_Rh = 5;
  Modelica.Units.SI.SpecificHeatCapacity cp_out;

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

  Modelica.Units.SI.Power Q_CHX;
  Modelica.Units.SI.Power Q_DHX;
  Modelica.Units.SI.Power Q_CHX_theory;
  Modelica.Units.SI.Power Q_DHX_theory;

  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Pipe_Wall[nV_Z](
    T_start=723.15,
    length=l_HITB,
    r_inner=R_PCM_inner,
    r_outer=R_PCM_inner + t_PCM_pipe,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{86,-18},{106,2}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Outer[nV_Z](
    T_start=723.15,                                                         length=
        l_PCM,
    r_inner=R_PCM,
    r_outer=R_PCM + t_PCM_wall)
    annotation (Placement(transformation(extent={{138,-18},{158,2}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D PCM_Discretized(
    redeclare package Material = HITB.PCM_Materials.PCM_HITB_2_Sin,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=698.15,
    T_b1_start=698.15,
    T_a2_start=698.15,
    T_b2_start=698.15,
    exposeState_a1=false,
    exposeState_b1=true,
    exposeState_b2=true,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        nR=nV_R,
        nZ=nV_Z,
        r_inner=R_PCM_inner + t_PCM_pipe,
        r_outer=R_PCM,
        length_z=l_PCM),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.VolumetricHeatGeneration
        (q_ppp=0.0))
    annotation (Placement(transformation(extent={{110,-18},{130,2}})));

  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wick[nV_Zh](
    length=l_HITB,
    r_inner=R_Na,
    r_outer=R_Wick,
    redeclare package Material = HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-74,-18},{-54,2}})));

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D HITB_Main(
    redeclare package Material = HITB.PCM_Materials.Sodium_New,
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
    annotation (Placement(transformation(extent={{44,-84},{24,-64}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_CHX_Side[nV_Zh]
    annotation (Placement(transformation(extent={{76,26},{56,46}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_DHX_Side[nV_Zh](T=
        293.15)
    annotation (Placement(transformation(extent={{78,-62},{58,-42}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection[nV_Zh](
      surfaceArea=SA_DHX_Side, alpha=25e-4)
    annotation (Placement(transformation(extent={{42,-62},{22,-42}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection1[nV_Zh](
      surfaceArea=SA_CHX_Side, alpha=25e-4)
    annotation (Placement(transformation(extent={{36,26},{16,46}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wall[nV_Zh](
    length=l_HITB,
    r_inner=R_Wick,
    r_outer=R_HITB,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-46,-18},{-26,2}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_PCM_Gap[nV_Zh,
    nV_Z](
    T_start=723.15,
    length=l_HITB,
    r_inner=R_HITB,
    r_outer=R_PCM_inner,
    exposeState_a=true)
    annotation (Placement(transformation(extent={{40,-18},{60,2}})));
  Modelica.Blocks.Sources.RealExpression Q_CHX_Input[nV_Zh](y=Q_CHX/nV_Zh)
    annotation (Placement(transformation(extent={{66,44},{46,64}})));
  Modelica.Blocks.Sources.RealExpression Q_DHX_Input[nV_Zh](y=Q_DHX/nV_Zh)
    annotation (Placement(transformation(extent={{74,-84},{54,-64}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial[nV_Z](T=293.15)
    annotation (Placement(transformation(extent={{214,-18},{194,2}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection2[nV_Z](
      surfaceArea=l_PCM/nV_Z*Modelica.Constants.pi*2*(R_PCM + t_PCM_wall), alpha=
        25e-4)
    annotation (Placement(transformation(extent={{188,-18},{168,2}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall[nV_R](
    T_start=723.15,                                                 th=
        t_PCM_pipe, surfaceArea=A_Cyl)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={120,-36})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall1[nV_R](th=
        t_PCM_wall, surfaceArea=A_Cyl,
    T_start=723.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={120,20})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection3[nV_R](
      surfaceArea=A_Cyl, alpha=25e-4)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={120,-62})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial2[nV_R](T=293.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={120,-90})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial1[nV_R](T=293.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={120,82})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection4[nV_R](
      surfaceArea=A_Cyl, alpha=25e-4)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={120,50})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector[nV_Zh](n=
        nV_Z + 4)
    annotation (Placement(transformation(extent={{2,-18},{-18,2}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_CHX(
    amplitude=5e3,
    rising=100,
    width=9000,
    falling=100,
    period=42000)
    annotation (Placement(transformation(extent={{228,102},{248,122}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX(
    amplitude=-5e3,
    rising=100,
    width=9000,
    falling=100,
    period=42000,
    startTime=21000)
    annotation (Placement(transformation(extent={{226,66},{246,86}})));
  Modelica.Blocks.Math.Add     signal_Position
    annotation (Placement(transformation(extent={{226,34},{246,54}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX1(
    amplitude=1,
    rising=100,
    width=9000,
    falling=100,
    period=42000,
    startTime=21000)
    annotation (Placement(transformation(extent={{194,28},{214,48}})));
  Modelica.Blocks.Sources.Constant const(k=0.0)
    annotation (Placement(transformation(extent={{182,58},{202,78}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection Area_correction_convection[nV_Zh,
    nV_Z](surfaceArea=SA_PCM_HITB, alpha=1e10)
    annotation (Placement(transformation(extent={{34,-18},{14,2}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector1
                                                                           [nV_Zh](n=nV_Z)
    annotation (Placement(transformation(extent={{64,-18},{84,2}})));
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
      surfaceArea=A_Cyl_HITB, alpha=25e-4) annotation (Placement(transformation(
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
      surfaceArea=A_Cyl_HITB, alpha=25e-4) annotation (Placement(transformation(
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
protected
  Real Q_CHX_linear(unit = "W/m") = Q_CHX_theory/l_CHX;
  Real Q_DHX_linear(unit = "W/m") = Q_DHX_theory/l_DHX;
equation
  cp_out = PCM_Discretized.Material.specificHeatCapacityCp(PCM_Discretized.materials[1, 1].state);
  Position = signal_Position.y;
  A_Cyl = PCM_Discretized.geometry.crossAreas_2[:,1];
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
      if z_position_PCM[j] >= z_position_HITB[i] and z_position_PCM[j+1] <= z_position_HITB[i+1] then
       z_overlap[i,j] = z_position_PCM[j+1]-z_position_PCM[j];
    elseif z_position_PCM[j] <= z_position_HITB[i+1] and z_position_PCM[j+1] >= z_position_HITB[i+1] then
      z_overlap[i,j] = z_position_HITB[i+1]-z_position_PCM[j];
    elseif z_position_PCM[j] <= z_position_HITB[i] and z_position_PCM[j+1] >= z_position_HITB[i] then
      z_overlap[i,j] = z_position_PCM[j+1]-z_position_HITB[i];
    else
      z_overlap[i,j] = 0;
      end if;
      SA_PCM_HITB[i, j] = z_overlap[i, j] * Modelica.Constants.pi*2*R_HITB;
        connect(Area_correction_convection[i, j].port_b, collector[i].port_a[j+2])
    annotation (Line(points={{17,-8},{2,-8}}, color={191,0,0}));
    end for;
  end for;
  connect(PCM_Discretized.port_b1, PCM_Outer.port_a)
    annotation (Line(points={{130,-8},{138,-8}},
                                               color={191,0,0}));

  connect(HITB_Wall.port_a, HITB_Wick.port_b)
    annotation (Line(points={{-46,-8},{-54,-8}}, color={191,0,0}));

  connect(convection2.port_a, Air_PCM_Axial.port)
    annotation (Line(points={{185,-8},{194,-8}}, color={191,0,0}));
  connect(PCM_Outer.port_b, convection2.port_b)
    annotation (Line(points={{158,-8},{171,-8}}, color={191,0,0}));

  connect(HITB_Wall.port_b, collector.port_b)
    annotation (Line(points={{-26,-8},{-18,-8}}, color={191,0,0}));
  connect(PCM_Pipe_Wall.port_b, PCM_Discretized.port_a1)
    annotation (Line(points={{106,-8},{110,-8}},
                                               color={191,0,0}));
  connect(convection3.port_a, Air_PCM_Axial2.port)
    annotation (Line(points={{120,-69},{120,-80}}, color={191,0,0}));
  connect(convection3.port_b, simpleWall.port_b)
    annotation (Line(points={{120,-55},{120,-46}}, color={191,0,0}));
  connect(Air_PCM_Axial1.port, convection4.port_a)
    annotation (Line(points={{120,72},{120,57}}, color={191,0,0}));
  connect(convection4.port_b, simpleWall1.port_b) annotation (Line(points={{120,43},
          {120,30}},                       color={191,0,0}));
  connect(simpleWall1.port_a, PCM_Discretized.port_b2)
    annotation (Line(points={{120,10},{120,2}},
                                              color={191,0,0}));
  connect(simpleWall.port_a, PCM_Discretized.port_a2)
    annotation (Line(points={{120,-26},{120,-18}},
                                                 color={191,0,0}));

  connect(signal_Position.u2, signal_Q_DHX1.y)
    annotation (Line(points={{224,38},{215,38}}, color={0,0,127}));
  connect(signal_Position.u1, const.y) annotation (Line(points={{224,50},{218,50},
          {218,68},{203,68}},  color={0,0,127}));

  connect(HITB_PCM_Gap.port_a, Area_correction_convection.port_a)
    annotation (Line(points={{40,-8},{31,-8}}, color={191,0,0}));
  connect(collector.port_a[1], CHX.port)
    annotation (Line(points={{2,-8},{6,-8},{6,54},{18,54}}, color={191,0,0}));
  connect(Q_CHX_Input.y, CHX.Q_flow_ext)
    annotation (Line(points={{45,54},{32,54}}, color={0,0,127}));
  connect(convection1.port_b, collector.port_a[2])
    annotation (Line(points={{19,36},{2,36},{2,-8}}, color={191,0,0}));
  connect(Air_CHX_Side.port, convection1.port_a)
    annotation (Line(points={{56,36},{33,36}}, color={191,0,0}));
  connect(convection.port_b, collector.port_a[nV_Z + 3])
    annotation (Line(points={{25,-52},{2,-52},{2,-8}}, color={191,0,0}));
  connect(DHX.port, collector.port_a[nV_Z + 4]) annotation (Line(points={{24,-74},
          {12,-74},{12,-76},{2,-76},{2,-8}}, color={191,0,0}));
  connect(Air_DHX_Side.port, convection.port_a)
    annotation (Line(points={{58,-52},{39,-52}}, color={191,0,0}));
  connect(Q_DHX_Input.y, DHX.Q_flow_ext)
    annotation (Line(points={{53,-74},{38,-74}}, color={0,0,127}));
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
          fillColor={244,125,35},fillPattern=FillPattern.CrossDiag)}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{200,120}}),
                                                     graphics={Text(
          extent={{-34,9},{34,-9}},
          textColor={28,108,200},
          origin={10,73},
          rotation=360,
          textString="R direction -->"),                       Text(
          extent={{34,9},{-34,-9}},
          textColor={28,108,200},
          origin={144,47},
          rotation=90,
          textString="<--- Z direction")}),
    experiment(
      StopTime=43200,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end HITB_Experiment_02_03;
