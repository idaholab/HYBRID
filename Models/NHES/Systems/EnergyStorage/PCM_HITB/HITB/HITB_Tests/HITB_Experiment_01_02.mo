within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HITB_Tests;
model HITB_Experiment_01_02
  "Attempt 01 at HITB experiment. Initially, the heat pipe will be assumed to be isothermal."
  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";
  Modelica.Units.SI.Area SA_DHX_Side;
  Modelica.Units.SI.Area SA_CHX_Side;
  Modelica.Units.SI.Area[nV_Z] SA_PCM_HITB;
  Modelica.Units.SI.Area A_Cyl[nV_R];
  parameter Integer nV_Z = 10;
  parameter Integer nV_R = 10;
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
  Modelica.Units.SI.Length z_overlap[nV_Z];

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
    annotation (Placement(transformation(extent={{68,-18},{88,2}})));
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

  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wick(
    length=l_HITB,
    r_inner=R_Na,
    r_outer=R_Wick,
    redeclare package Material = HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-74,-18},{-54,2}})));

  TRANSFORM.HeatAndMassTransfer.Volumes.UnitVolume          HITB_Main(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=673.15,
    V=l_HITB*Modelica.Constants.pi*R_Na*R_Na,
    d=TRANSFORM.Media.Fluids.Sodium.ConstantPropertyLiquidSodium.d_const,
    cp=TRANSFORM.Media.Fluids.Sodium.ConstantPropertyLiquidSodium.cp_const)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
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
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wall(length=
        l_HITB,
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
    annotation (Placement(transformation(extent={{40,-18},{60,2}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Q_CHX)
    annotation (Placement(transformation(extent={{68,44},{48,64}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=Q_DHX)
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
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector(n=
        nV_Z + 4)
    annotation (Placement(transformation(extent={{2,-18},{-18,2}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_CHX(
    amplitude=5e3,
    rising=100,
    width=18000,
    falling=100,
    period=42000)
    annotation (Placement(transformation(extent={{-88,84},{-68,104}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX(
    amplitude=-5e3,
    rising=100,
    width=18000,
    falling=100,
    period=42000,
    startTime=21000)
    annotation (Placement(transformation(extent={{-88,52},{-68,72}})));
  Modelica.Blocks.Math.Add     signal_Position
    annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX1(
    amplitude=1,
    rising=100,
    width=18000,
    falling=100,
    period=42000,
    startTime=21000)
    annotation (Placement(transformation(extent={{-120,14},{-100,34}})));
  Modelica.Blocks.Sources.Constant const(k=0.0)
    annotation (Placement(transformation(extent={{-132,44},{-112,64}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection Area_correction_convection[nV_Z](
      surfaceArea=SA_PCM_HITB, alpha=1e10)
    annotation (Placement(transformation(extent={{30,-18},{10,2}})));
equation
  cp_out = PCM_Discretized.Material.specificHeatCapacityCp(PCM_Discretized.materials[1, 1].state);
  Position = signal_Position.y;
  A_Cyl = PCM_Discretized.geometry.crossAreas_2[:,1];
  SA_CHX_Side = l_gap_CHX*Modelica.Constants.pi*R_HITB*(1.0-max(0.5,Position))/0.5;
  SA_DHX_Side = l_gap_DHX*Modelica.Constants.pi*R_HITB*min(Position,0.5)/0.5;
  Q_CHX = Q_CHX_theory*(0.5-min(Position,0.5))/0.5;
  Q_DHX = Q_DHX_theory*(max(0.5,Position)-0.5)/0.5;
  Q_CHX_theory = signal_Q_CHX.y;
  Q_DHX_theory = signal_Q_DHX.y;

  z_position_min = Position*(l_experiment-l_HITB);
  z_position_HITB = linspace(z_position_min,z_position_max,nV_Z+1);

  for i in 1:nV_Z loop
    connect(Area_correction_convection[i].port_b, collector.port_a[i+2])
    annotation (Line(points={{13,-8},{2,-8}}, color={191,0,0}));
    SA_PCM_HITB[i] = z_overlap[i]*Modelica.Constants.pi*2*R_HITB;
    if z_position_PCM[i] >= z_position_min and z_position_PCM[i+1] <= z_position_max then
       z_overlap[i] = z_position_PCM[i+1]-z_position_PCM[i];
    elseif z_position_PCM[i] <= z_position_max and z_position_PCM[i+1] >= z_position_max then
      z_overlap[i] = z_position_max-z_position_PCM[i];
    elseif z_position_PCM[i] <= z_position_min and z_position_PCM[i+1] >= z_position_min then
      z_overlap[i] = z_position_PCM[i+1]-z_position_min;
    else
      z_overlap[i] = 0;
    end if;

  end for;
  connect(PCM_Discretized.port_b1, PCM_Outer.port_a)
    annotation (Line(points={{130,-8},{138,-8}},
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
    annotation (Line(points={{185,-8},{194,-8}}, color={191,0,0}));
  connect(PCM_Outer.port_b, convection2.port_b)
    annotation (Line(points={{158,-8},{171,-8}}, color={191,0,0}));
  connect(collector.port_a[1], CHX.port) annotation (Line(points={{2,-8},{6,-8},
          {6,54},{18,54}},   color={191,0,0}));
  connect(collector.port_a[2], convection1.port_b) annotation (Line(points={{2,-8},{
          6,-8},{6,36},{19,36}},        color={191,0,0}));
  connect(collector.port_a[nV_Z], DHX.port) annotation (Line(points={{2,-8},{6,-8},
          {6,-74},{24,-74}},      color={191,0,0}));
  connect(collector.port_a[nV_Z - 1], convection.port_b) annotation (Line(
        points={{2,-8},{6,-8},{6,-52},{25,-52}},    color={191,0,0}));

  connect(HITB_Wall.port_b, collector.port_b)
    annotation (Line(points={{-26,-8},{-18,-8}}, color={191,0,0}));
  connect(HITB_PCM_Gap.port_b, PCM_Pipe_Wall.port_a)
    annotation (Line(points={{60,-8},{68,-8}}, color={191,0,0}));
  connect(PCM_Pipe_Wall.port_b, PCM_Discretized.port_a1)
    annotation (Line(points={{88,-8},{110,-8}},color={191,0,0}));
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
  connect(HITB_Main.port, HITB_Wick.port_a) annotation (Line(points={{-88,-8},{-74,
          -8}},                          color={191,0,0}));

  connect(signal_Position.u2, signal_Q_DHX1.y)
    annotation (Line(points={{-90,24},{-99,24}}, color={0,0,127}));
  connect(signal_Position.u1, const.y) annotation (Line(points={{-90,36},{-96,36},
          {-96,54},{-111,54}}, color={0,0,127}));

  connect(Area_correction_convection.port_a, HITB_PCM_Gap.port_a)
    annotation (Line(points={{27,-8},{40,-8}}, color={191,0,0}));
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
          thickness=DynamicSelect(0,8*(max(Position,0.5)-0.5))),
        Line(
          points={{76,36},{76,24},{70,18},{80,12},{70,4},{80,-4},{70,-12},{76,-18},
              {76,-32}},
          color={28,108,200},
          thickness=DynamicSelect(0,8*(max(Position,0.5)-0.5))),
        Line(
          points={{66,36},{66,24},{60,18},{70,12},{60,4},{70,-4},{60,-12},{66,-18},
              {66,-32}},
          color={28,108,200},
          thickness=DynamicSelect(0,8*(max(Position,0.5)-0.5))),
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
end HITB_Experiment_01_02;
