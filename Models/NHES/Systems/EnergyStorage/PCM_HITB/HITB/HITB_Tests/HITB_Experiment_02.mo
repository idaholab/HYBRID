within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HITB_Tests;
model HITB_Experiment_02
  "Attempt 02 at HITB experiment. Removing iso-thermal nature of the heat pipe. That being said, no axial conduction exists except in the heat pipe and the PCM."
  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";
  Modelica.Units.SI.Area SA_DHX_Side;
  Modelica.Units.SI.Area SA_CHX_Side;
  Modelica.Units.SI.Area A_Cyl[nV_R_PCM];
  Modelica.Units.SI.Area A_Cyl_HITB[nV_R_HITB];
  parameter Integer nV_Z = 10;
  parameter Integer nV_R_PCM = 10;
  parameter Integer nV_R_HITB = 3;
  parameter Modelica.Units.SI.Temperature T_CHX = 873.15;
  parameter Modelica.Units.SI.Temperature T_DHX = 473.15;
  parameter Modelica.Units.SI.Temperature T_ambient = 298.15;
  Modelica.Units.SI.SpecificHeatCapacity cp_out;
  Modelica.Units.SI.Temperature T_CHXEnd_Ambient;
  Modelica.Units.SI.Temperature T_DHXEnd_Ambient;
  parameter Modelica.Units.SI.Length R_Na = 0.0254*1.98 "Main sodium radius within heat pipe, value is inner wick radius";
  parameter Modelica.Units.SI.Length R_Wick = 0.0254*2.0 "Radius of where outer wick is.";
  parameter Modelica.Units.SI.Length R_HITB = 0.0254*2.1 "Radius of entire heat pipe apparatus that moves";
  parameter Modelica.Units.SI.Length t_PCM_pipe = 0.002 "Thickness of inner pipe of PCM container";
  parameter Modelica.Units.SI.Length R_PCM_inner = 0.0254*2.1+t_PCM_pipe+0.002 "Inner radius of PCM container";
  parameter Modelica.Units.SI.Length R_PCM = 0.995 "Outer radius of PCM container";
  parameter Modelica.Units.SI.Length t_PCM_wall = 0.002 "Outer PCM container wall thickness";

  parameter Modelica.Units.SI.Length l_HITB = 2;
  parameter Modelica.Units.SI.Length l_CHX = 0.5 "Length of section where heat pipe can be heated by CHX";
  parameter Modelica.Units.SI.Length l_DHX = l_CHX "Length of section where heat pipe can be cooled by DHX";
  parameter Modelica.Units.SI.Length l_gap_CHX = 0.5 "Length of section between the CHX and the PCM";
  parameter Modelica.Units.SI.Length l_gap_DHX = 0.5 "Length of section between the DHX and the PCM";
  parameter Modelica.Units.SI.Length l_PCM =  1.0 "Length of PCM heat exchange potential";
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
    annotation (Placement(transformation(extent={{56,-18},{76,2}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Outer[nV_Z](
    T_start=723.15,                                                         length=
        l_PCM,
    r_inner=R_PCM,
    r_outer=R_PCM + t_PCM_wall)
    annotation (Placement(transformation(extent={{114,-18},{134,2}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D PCM_Discretized(
    redeclare package Material = HITB.PCM_Materials.PCM_HITB,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=723.15,
    T_b1_start=723.15,
    T_a2_start=723.15,
    T_b2_start=723.15,
    exposeState_a1=false,
    exposeState_b1=true,
    exposeState_b2=true,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        nR=nV_R_PCM,
        nZ=nV_Z,
        r_inner=R_PCM_inner + t_PCM_pipe,
        r_outer=R_PCM,
        length_z=l_PCM),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.VolumetricHeatGeneration
        (q_ppp=0.0))
    annotation (Placement(transformation(extent={{86,-18},{106,2}})));

  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wick[nV_Z + 4](
    length=l_HITB,
    r_inner=R_Na,
    r_outer=R_Wick,
    redeclare package Material = HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-74,-18},{-54,2}})));

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D
                                                            HITB_Main(
    redeclare package Material = TRANSFORM.Media.Solids.Sodium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=723.15,
    T_b1_start=723.15,
    T_a2_start=723.15,
    T_b2_start=723.15,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        nR=nV_R_HITB,
        nZ=nV_Z+4,
        r_outer=R_Na,
        length_z=l_HITB))
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-98,-8})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow CHX(use_port=true)
    annotation (Placement(transformation(extent={{38,44},{18,64}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow DHX(use_port=true)
    annotation (Placement(transformation(extent={{44,-84},{24,-64}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_CHX_Side
    annotation (Placement(transformation(extent={{76,26},{56,46}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_DHX_Side(T=293.15)
    annotation (Placement(transformation(extent={{78,-62},{58,-42}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(
      surfaceArea=SA_DHX_Side, alpha=25e-4)
    annotation (Placement(transformation(extent={{42,-62},{22,-42}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection1(
      surfaceArea=SA_CHX_Side, alpha=25e-4)
    annotation (Placement(transformation(extent={{36,26},{16,46}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wall[nV_Z + 4](
    length=l_HITB,
    r_inner=R_Wick,
    r_outer=R_HITB,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-46,-18},{-26,2}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_PCM_Gap[nV_Z](
    T_start=723.15,
      length=l_HITB,
    r_inner=R_HITB,
    r_outer=R_PCM_inner,
                     exposeState_a=true)
    annotation (Placement(transformation(extent={{4,-18},{24,2}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Q_CHX)
    annotation (Placement(transformation(extent={{68,44},{48,64}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=Q_DHX)
    annotation (Placement(transformation(extent={{74,-84},{54,-64}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial[nV_Z](T=293.15)
    annotation (Placement(transformation(extent={{190,-18},{170,2}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection2[nV_Z](
      surfaceArea=l_PCM/nV_Z*Modelica.Constants.pi*2*(R_PCM + t_PCM_wall), alpha=
        25e-4)
    annotation (Placement(transformation(extent={{164,-18},{144,2}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall[nV_R_PCM](
    T_start=723.15,                                                 th=
        t_PCM_pipe, surfaceArea=A_Cyl)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={96,-36})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall1[nV_R_PCM](th=
        t_PCM_wall, surfaceArea=A_Cyl,
    T_start=723.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={96,20})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection3[nV_R_PCM](
      surfaceArea=A_Cyl, alpha=25e-4)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={96,-62})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial2[nV_R_PCM](T=293.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={96,-90})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial1[nV_R_PCM](T=293.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={96,82})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection4[nV_R_PCM](
      surfaceArea=A_Cyl, alpha=25e-4)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={96,50})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_CHX(
    amplitude=1e3,
    rising=100,
    width=900,
    falling=100,
    period=2200)
    annotation (Placement(transformation(extent={{-66,86},{-46,106}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX(
    amplitude=-1e3,
    rising=100,
    width=900,
    falling=100,
    period=2200)
    annotation (Placement(transformation(extent={{-70,54},{-50,74}})));
  Modelica.Blocks.Sources.Sine signal_Position(
    amplitude=0.5,
    f=1/800,
    offset=0.5)
    annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall2[nV_R_HITB](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,16})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary_HITB_CHX_End[nV_R_HITB](use_port=
        true, T=293.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-90,78})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection5[nV_R_HITB](
      surfaceArea=A_Cyl_HITB, alpha=25e-4)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-90,46})));
  Modelica.Blocks.Sources.RealExpression realExpression2[nV_R_HITB](y=
        T_CHXEnd_Ambient)
    annotation (Placement(transformation(extent={{-134,86},{-114,106}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall3[nV_R_HITB](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-94,-116})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection6[nV_R_HITB](
      surfaceArea=A_Cyl_HITB, alpha=25e-4)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-94,-86})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary_HITB_CHX_End1
                                                                                         [nV_R_HITB](use_port=
       true, T=293.15)  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-94,-54})));
  Modelica.Blocks.Sources.RealExpression realExpression3[nV_R_HITB](y=
        T_DHXEnd_Ambient)
    annotation (Placement(transformation(extent={{-138,-46},{-118,-26}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic(nPorts=nV_Z + 4)
    annotation (Placement(transformation(extent={{-148,-16},{-128,4}})));
equation
  cp_out = PCM_Discretized.Material.specificHeatCapacityCp(PCM_Discretized.materials[1, 1].state);
  Position = signal_Position.y;
  A_Cyl = PCM_Discretized.geometry.crossAreas_2[:,1];
  A_Cyl_HITB = HITB_Main.geometry.crossAreas_2[:,1];
  SA_CHX_Side = l_gap_CHX*Modelica.Constants.pi*R_HITB*(1-max(0.75,Position))/0.25;
  SA_DHX_Side = l_gap_DHX*Modelica.Constants.pi*R_HITB*min(Position,0.25)/0.25;
  Q_CHX = Q_CHX_theory*min(Position,0.25)/0.25;
  Q_DHX = Q_DHX_theory*(1-max(0.75,Position))/0.25;
  Q_CHX_theory = signal_Q_CHX.y;
  Q_DHX_theory = signal_Q_DHX.y;
  T_CHXEnd_Ambient = T_ambient + (T_CHX-T_ambient)*(0.26-min(0.26,max(Position,0.24)))/0.02;
  T_DHXEnd_Ambient = T_ambient + (T_DHX-T_ambient)*(max(0.76,min(0.74,Position))-0.74)/0.02;

  for i in 1:nV_Z loop
     connect(HITB_PCM_Gap[i].port_a, HITB_Wall[i+2].port_b)
    annotation (Line(points={{4,-8},{-26,-8}},  color={191,0,0}));
  end for;
  connect(PCM_Discretized.port_b1, PCM_Outer.port_a)
    annotation (Line(points={{106,-8},{114,-8}},
                                               color={191,0,0}));

  connect(convection.port_a, Air_DHX_Side.port)
    annotation (Line(points={{39,-52},{58,-52}},   color={191,0,0}));
  connect(Air_CHX_Side.port, convection1.port_a)
    annotation (Line(points={{56,36},{33,36}},   color={191,0,0}));

  connect(DHX.Q_flow_ext, realExpression1.y)
    annotation (Line(points={{38,-74},{53,-74}},     color={0,0,127}));
  connect(realExpression.y, CHX.Q_flow_ext)
    annotation (Line(points={{47,54},{32,54}},     color={0,0,127}));
  connect(HITB_Wall.port_a, HITB_Wick.port_b)
    annotation (Line(points={{-46,-8},{-54,-8}}, color={191,0,0}));

  connect(convection2.port_a, Air_PCM_Axial.port)
    annotation (Line(points={{161,-8},{170,-8}}, color={191,0,0}));
  connect(PCM_Outer.port_b, convection2.port_b)
    annotation (Line(points={{134,-8},{147,-8}}, color={191,0,0}));

  connect(HITB_PCM_Gap.port_b, PCM_Pipe_Wall.port_a)
    annotation (Line(points={{24,-8},{56,-8}}, color={191,0,0}));
  connect(PCM_Pipe_Wall.port_b, PCM_Discretized.port_a1)
    annotation (Line(points={{76,-8},{86,-8}}, color={191,0,0}));
  connect(convection3.port_a, Air_PCM_Axial2.port)
    annotation (Line(points={{96,-69},{96,-80}},   color={191,0,0}));
  connect(convection3.port_b, simpleWall.port_b)
    annotation (Line(points={{96,-55},{96,-46}},   color={191,0,0}));
  connect(Air_PCM_Axial1.port, convection4.port_a)
    annotation (Line(points={{96,72},{96,57}},   color={191,0,0}));
  connect(convection4.port_b, simpleWall1.port_b) annotation (Line(points={{96,43},
          {96,30}},                        color={191,0,0}));
  connect(simpleWall1.port_a, PCM_Discretized.port_b2)
    annotation (Line(points={{96,10},{96,2}}, color={191,0,0}));
  connect(simpleWall.port_a, PCM_Discretized.port_a2)
    annotation (Line(points={{96,-26},{96,-18}}, color={191,0,0}));
  connect(CHX.port, HITB_Wall[1].port_b) annotation (Line(points={{18,54},{-14,54},
          {-14,-8},{-26,-8}}, color={191,0,0}));
  connect(convection1.port_b, HITB_Wall[2].port_b) annotation (Line(points={{19,
          36},{-4,36},{-4,-8},{-26,-8}}, color={191,0,0}));

  connect(convection.port_b, HITB_Wall[nV_Z-1].port_b)
    annotation (Line(points={{25,-52},{-26,-52},{-26,-8}}, color={191,0,0}));
  connect(DHX.port, HITB_Wall[nV_Z].port_b) annotation (Line(points={{24,-74},{-2,-74},
          {-2,-76},{-26,-76},{-26,-8}}, color={191,0,0}));
  connect(boundary_HITB_CHX_End.port, convection5.port_a)
    annotation (Line(points={{-90,68},{-90,53}}, color={191,0,0}));
  connect(convection5.port_b,simpleWall2. port_b) annotation (Line(points={{-90,39},
          {-90,26}},                       color={191,0,0}));
  connect(realExpression2.y, boundary_HITB_CHX_End.T_ext)
    annotation (Line(points={{-113,96},{-90,96},{-90,82}}, color={0,0,127}));
  connect(HITB_Main.port_b1, HITB_Wick.port_a)
    annotation (Line(points={{-88,-8},{-74,-8}}, color={191,0,0}));
  connect(HITB_Main.port_b2, simpleWall2.port_a) annotation (Line(points={{-98,2},
          {-112,2},{-112,6},{-90,6}}, color={191,0,0}));
  connect(convection6.port_b,simpleWall3. port_b) annotation (Line(points={{-94,-93},
          {-94,-106}},                     color={191,0,0}));
  connect(boundary_HITB_CHX_End1.port, convection6.port_a)
    annotation (Line(points={{-94,-64},{-94,-79}}, color={191,0,0}));
  connect(realExpression3.y, boundary_HITB_CHX_End1.T_ext) annotation (Line(
        points={{-117,-36},{-94,-36},{-94,-50}}, color={0,0,127}));
  connect(simpleWall3.port_a, HITB_Main.port_a2) annotation (Line(points={{-94,
          -126},{-94,-138},{-58,-138},{-58,-28},{-98,-28},{-98,-18}}, color={
          191,0,0}));
  connect(adiabatic.port, HITB_Main.port_a1)
    annotation (Line(points={{-128,-6},{-120,-8},{-108,-8}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-34,9},{34,-9}},
          textColor={28,108,200},
          origin={10,73},
          rotation=360,
          textString="R direction -->"),                       Text(
          extent={{34,9},{-34,-9}},
          textColor={28,108,200},
          origin={120,47},
          rotation=90,
          textString="<--- Z direction")}),
    experiment(StopTime=200000, __Dymola_Algorithm="Dassl"));
end HITB_Experiment_02;
