within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HITB_Tests;
model HITB_Experiment_03_10 "Add in HITB control"

  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";
  Modelica.Units.SI.Area SA_DHX_Side;
  Modelica.Units.SI.Area SA_CHX_Side;

  Modelica.Units.SI.Area A_Cyl_HITB[nV_Rh];
  parameter Integer nV_Z = 8 "Nodes in the thermal batter";
  parameter Integer nV_Zh = 6 "Nodes in the heat pipe length";
  parameter Integer nV_R = 10 "Radial nodes in the thermal battery";
  parameter Integer nV_Rh = 5 "Radial nodes in the heat pipe";

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
    annotation (Placement(transformation(extent={{114,-10},{134,10}})));

  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wick[nV_Zh](
    length=l_HITB,
    r_inner=R_Na,
    r_outer=R_Wick,
    redeclare package Material = HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

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
        origin={-104,0})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow CHX(use_port=true)
    annotation (Placement(transformation(extent={{104,-58},{84,-38}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow DHX(use_port=true)
    annotation (Placement(transformation(extent={{110,36},{90,56}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_CHX_Side(T=T_air)
    annotation (Placement(transformation(extent={{120,-36},{100,-16}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_DHX_Side(T=T_air)
    annotation (Placement(transformation(extent={{128,12},{108,32}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(
      surfaceArea=SA_DHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{92,12},{72,32}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection1(
      surfaceArea=SA_CHX_Side, alpha=hc_air)
    annotation (Placement(transformation(extent={{80,-36},{60,-16}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_Wall[nV_Zh](
    length=l_HITB,
    r_inner=R_Wick,
    r_outer=R_HITB,
    exposeState_a=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));

  Modelica.Blocks.Sources.RealExpression Q_CHX_Input(y=1000/(l_CHX*Modelica.Constants.pi
        *R_HITB))
    annotation (Placement(transformation(extent={{134,-58},{114,-38}})));
  Modelica.Blocks.Sources.RealExpression Q_DHX_Input(y=-500/(l_CHX*Modelica.Constants.pi
        *R_HITB))
    annotation (Placement(transformation(extent={{140,36},{120,56}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall2[nV_Rh](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-104,28})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial3[nV_Rh](T=T_air)
                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-104,78})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection5[nV_Rh](
      surfaceArea=A_Cyl_HITB, alpha=hc_air)
                                           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-104,52})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall3[nV_Rh](
    th=t_PCM_wall,
    surfaceArea=A_Cyl_HITB,
    T_start=723.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-104,-32})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial4[nV_Rh](T=T_air)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-104,-88})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection6[nV_Rh](
      surfaceArea=A_Cyl_HITB, alpha=hc_air)
                                           annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-104,-60})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic Air_CHX_Side1[nV_Zh]
    annotation (Placement(transformation(extent={{-140,-10},{-120,10}})));

  Modelica.Blocks.Sources.CombiTimeTable charge_demand_table1(table=[0,3000;
        3599,3000; 3600,3000; 10799,3000; 10800,0; 21599,0; 21600,2000; 43199,
        2000; 43200,1000; 57599,1000; 57600,0],
                                    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{144,88},{164,108}})));
  Modelica.Blocks.Sources.CombiTimeTable discharge_demand_table1(table=[0,0.0; 3599,
        0; 3600,0; 10799,0; 10800,3000; 21599,3000; 21600,500; 43199,500; 43200,
        1500; 57599,1500; 57600,0], extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{144,130},{164,150}})));
  Controls_Construction controls_Construction
    annotation (Placement(transformation(extent={{200,108},{220,128}})));
  Collector_Variable_Convection collector_1HP_HITB(n_a=nV_Zh, n_b=nV_Z,
    A_vec=SA_1HP_HP_TB)
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector1[
    nV_Zh](n=5)
    annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
  Collector_Variable_Convection collector_1HP_DHX(n_a=nV_Zh,
    n_b=1,
    A_vec=SA_1HP_HP_DHX)
    annotation (Placement(transformation(extent={{22,10},{42,30}})));
  Collector_Variable_Convection collector_1HP_Air_DHX(n_a=nV_Zh, n_b=1,
    A_vec=SA_1HP_HP_DGap)
    annotation (Placement(transformation(extent={{24,32},{44,52}})));
  Collector_Variable_Convection collector_1HP_Air_CHX(n_a=nV_Zh,
    n_b=1,
    A_vec=SA_1HP_HP_CGap)
    annotation (Placement(transformation(extent={{22,-36},{42,-16}})));
  Collector_Variable_Convection collector__1HP_CHX(n_a=nV_Zh,
    n_b=1,
    A_vec=SA_1HP_HP_CHX)
    annotation (Placement(transformation(extent={{26,-58},{46,-38}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder HITB_PCM_Gap2[nV_Z](
    redeclare package Material = PCM_Materials.Lambda_00_24_d_1200_cp_500,
    T_start=723.15,
    length=l_HITB,
    r_inner=R_HITB,
    r_outer=R_PCM_inner,
    exposeState_a=true)
    annotation (Placement(transformation(extent={{64,-10},{84,10}})));
  Modelica.Blocks.Math.Add     signal_Position
    annotation (Placement(transformation(extent={{248,46},{268,66}})));
  Modelica.Blocks.Sources.Trapezoid signal_Q_DHX1(
    amplitude=1,
    rising=100,
    width=42000,
    falling=100,
    period=86400,
    startTime=43000)
    annotation (Placement(transformation(extent={{198,98},{218,118}})));
  Modelica.Blocks.Sources.Constant const(k=0.0)
    annotation (Placement(transformation(extent={{204,70},{224,90}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance
                                                            generic(R_val=100)
    annotation (Placement(transformation(extent={{80,36},{60,56}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance
                                                            generic1(R_val=100)
    annotation (Placement(transformation(extent={{78,-58},{58,-38}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature T_dummy_HITB[nV_Z](T=(443
         + 273.15) + 273.15)
    annotation (Placement(transformation(extent={{188,-10},{168,10}})));

  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Radiation radiation(epsilon=
        0.3)
    annotation (Placement(transformation(extent={{-64,-72},{-44,-52}})));
equation
  time_plot = time;

  Position = signal_Position.y;

  A_Cyl_HITB = HITB_Main.geometry.crossAreas_2[:,1];
  SA_CHX_Side = l_gap_CHX*Modelica.Constants.pi*R_HITB;
  SA_DHX_Side = l_gap_DHX*Modelica.Constants.pi*R_HITB;

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

  connect(HITB_Wall.port_a, HITB_Wick.port_b)
    annotation (Line(points={{-52,0},{-60,0}},   color={191,0,0}));

  connect(Q_CHX_Input.y, CHX.Q_flow_ext)
    annotation (Line(points={{113,-48},{98,-48}},
                                               color={0,0,127}));
  connect(Air_CHX_Side.port, convection1.port_a)
    annotation (Line(points={{100,-26},{77,-26}},
                                               color={191,0,0}));
  connect(Air_DHX_Side.port, convection.port_a)
    annotation (Line(points={{108,22},{89,22}},  color={191,0,0}));
  connect(Q_DHX_Input.y, DHX.Q_flow_ext)
    annotation (Line(points={{119,46},{104,46}}, color={0,0,127}));
  connect(Air_PCM_Axial3.port, convection5.port_a)
    annotation (Line(points={{-104,68},{-104,59}}, color={191,0,0}));
  connect(convection5.port_b, simpleWall2.port_b)
    annotation (Line(points={{-104,45},{-104,38}}, color={191,0,0}));
  connect(convection6.port_b, simpleWall3.port_b)
    annotation (Line(points={{-104,-53},{-104,-42}},
                                                   color={191,0,0}));
  connect(convection6.port_a, Air_PCM_Axial4.port)
    annotation (Line(points={{-104,-67},{-104,-78}},
                                                   color={191,0,0}));
  connect(HITB_Main.port_b1, HITB_Wick.port_a)
    annotation (Line(points={{-94,0},{-80,0}},   color={191,0,0}));
  connect(HITB_Main.port_b2, simpleWall2.port_a) annotation (Line(points={{-104,10},
          {-104,18}},                    color={191,0,0}));
  connect(HITB_Main.port_a1, Air_CHX_Side1.port)
    annotation (Line(points={{-114,0},{-120,0}},   color={191,0,0}));
  connect(HITB_Main.port_a2, simpleWall3.port_a)
    annotation (Line(points={{-104,-10},{-104,-22}},
                                                   color={191,0,0}));

  connect(charge_demand_table1.y[1], controls_Construction.charge_demand)
    annotation (Line(points={{165,98},{188,98},{188,112},{198,112}}, color={0,0,
          127}));
  connect(controls_Construction.discharge_demand, discharge_demand_table1.y[1])
    annotation (Line(points={{198,122},{170,122},{170,140},{165,140}}, color={0,
          0,127}));
  connect(collector1.port_b, HITB_Wall.port_b)
    annotation (Line(points={{-20,0},{-32,0}},     color={191,0,0}));
  connect(collector1.port_a[1], collector_1HP_HITB.port_a) annotation (Line(
        points={{0,-0.4},{12,-0.4},{12,0},{22,0}},       color={191,0,0}));
  connect(collector__1HP_CHX.port_a, collector1.port_a[2]) annotation (Line(
        points={{26,-48},{12,-48},{12,-0.2},{0,-0.2}},     color={191,0,0}));
  connect(collector_1HP_DHX.port_a, collector1.port_a[3])
    annotation (Line(points={{22,20},{12,20},{12,0},{0,0}},
                                                        color={191,0,0}));
  connect(collector_1HP_Air_DHX.port_a, collector1.port_a[4]) annotation (Line(
        points={{24,42},{12,42},{12,0},{0,0},{0,0.2}},       color={191,0,0}));
  connect(collector_1HP_Air_CHX.port_a, collector1.port_a[5]) annotation (Line(
        points={{22,-26},{12,-26},{12,0.4},{0,0.4}},       color={191,0,0}));
  connect(HITB_PCM_Gap2.port_b, PCM_Pipe_Wall.port_a)
    annotation (Line(points={{84,0},{114,0}},     color={191,0,0}));
  connect(collector_1HP_HITB.port_b, HITB_PCM_Gap2.port_a)
    annotation (Line(points={{42,0},{64,0}},     color={191,0,0}));
  connect(convection1.port_b, collector_1HP_Air_CHX.port_b[1])
    annotation (Line(points={{63,-26},{42,-26}},   color={191,0,0}));
  connect(convection.port_b, collector_1HP_DHX.port_b[1])
    annotation (Line(points={{75,22},{75,20},{42,20}},    color={191,0,0}));
  connect(signal_Position.u2,signal_Q_DHX1. y)
    annotation (Line(points={{246,50},{236,50},{236,108},{219,108}},
                                                 color={0,0,127}));
  connect(signal_Position.u1,const. y) annotation (Line(points={{246,62},{230,62},
          {230,80},{225,80}},  color={0,0,127}));
  connect(DHX.port, generic.port_a)
    annotation (Line(points={{90,46},{77,46}},   color={191,0,0}));
  connect(collector_1HP_Air_DHX.port_b[1], generic.port_b) annotation (Line(
        points={{44,42},{52,42},{52,46},{63,46}},     color={191,0,0}));
  connect(CHX.port, generic1.port_a)
    annotation (Line(points={{84,-48},{75,-48}},   color={191,0,0}));
  connect(collector__1HP_CHX.port_b[1], generic1.port_b) annotation (Line(
        points={{46,-48},{61,-48}},                       color={191,0,0}));
  connect(T_dummy_HITB.port, PCM_Pipe_Wall.port_b)
    annotation (Line(points={{168,0},{134,0}},     color={191,0,0}));
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
          origin={4,81},
          rotation=360,
          textString="R direction -->"),                       Text(
          extent={{-34,9},{34,-9}},
          textColor={28,108,200},
          origin={-32,21},
          rotation=360,
          textString="Single HP")}),
    experiment(
      StopTime=0.1,
      __Dymola_NumberOfIntervals=750,
      __Dymola_Algorithm="Dassl"));
end HITB_Experiment_03_10;
