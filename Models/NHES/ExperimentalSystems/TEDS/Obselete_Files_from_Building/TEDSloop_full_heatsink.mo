within NHES.ExperimentalSystems.TEDS.Obselete_Files_from_Building;
model TEDSloop_full_heatsink
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p_a_start=system.p_ambient,
    T_a_start=system.T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
        (nV=10, dimensions=fill(0.076, pipe1.nV)),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal)
    annotation (Placement(transformation(extent={{-46,40},{-30,56}})));

  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{104,40},{120,56}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe4(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
                    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-80,-2})));
  Modelica.Fluid.Pipes.DynamicPipe pipe5(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{-54,-66},{-66,-54}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe7(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
                    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={128,-8})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_input=false,
    m_flow_nominal=0.8814)
    annotation (Placement(transformation(extent={{-26,-54},{-38,-66}})));
  TRANSFORM.Fluid.Volumes.ExpansionTank tank1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    A=1,
    V0=1,
    p_surface=system.p_ambient,
    p_start=system.p_start,
    level_start=0,
    h_start=pipe1.h_b_start)
    annotation (Placement(transformation(extent={{10,46},{26,62}})));
  inner TRANSFORM.Fluid.System
                        system(
    p_ambient=18000,
    T_ambient=498.15,
    m_flow_start=MassFlow_Control.y_start)
    annotation (Placement(transformation(extent={{140,120},{160,140}})));
  Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{42,-50},{32,-62}})));
  Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{110,-60},{120,-48}})));
  TRANSFORM.Controls.LimPID Chromolox_Heater_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k_s=1,
    k_m=1,
    yMax=205e3,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=200e3)
    annotation (Placement(transformation(extent={{-100,102},{-88,90}})));
  Data.Data_TEDS data(T_hot_side=598.15, T_cold_side=498.15)
    annotation (Placement(transformation(extent={{-100,122},{-80,142}})));
  Modelica.Blocks.Sources.Constant const(k=data.T_hot_side) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-124,96})));
  TRANSFORM.Controls.LimPID MassFlow_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1,
    Ti=5,
    k_s=5e-1,
    k_m=5e-1,
    yMax=15,
    yMin=3,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=4)
    annotation (Placement(transformation(extent={{-14,-84},{-26,-72}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_cold_side) annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={6,-78})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Ethylene_Glycol_50_Water.Linear_Ethylene_Glycol,
    use_m_flow_in=false,
    m_flow=12.6,
    T=280.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{26,-108},{46,-88}})));

  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Ethylene_Glycol_50_Water.Linear_Ethylene_Glycol,
    p=300000,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{174,-98},{154,-78}})));

  Modelica.Fluid.Sensors.Temperature temperature4(redeclare package Medium =
        TRANSFORM.Media.Fluids.Ethylene_Glycol_50_Water.Linear_Ethylene_Glycol)
    annotation (Placement(transformation(extent={{50,-108},{60,-120}})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
    p_b_start_shell=system.p_ambient,
    T_a_start_shell=data.T_hot_side,
    T_b_start_shell=data.T_cold_side,
    p_b_start_tube=boundary1.p,
    counterCurrent=true,
    m_flow_a_start_tube=boundary.m_flow,
    m_flow_a_start_shell=MassFlow_Control.y_start,
    redeclare package Medium_tube =
        TRANSFORM.Media.Fluids.Ethylene_Glycol_50_Water.Linear_Ethylene_Glycol,
    redeclare package Medium_shell =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS316,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
        (
        D_o_shell=0.192,
        nV=10,
        nTubes=113,
        nR=3,
        length_shell=1.0,
        dimension_tube=0.013,
        length_tube=1.0,
        th_wall=0.0001),
    p_a_start_tube=boundary1.p + 100,
    T_a_start_tube=boundary.T,
    T_b_start_tube=boundary1.T,
    p_a_start_shell=system.p_ambient + 100,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region
        (CF=5),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region
        (CF=5))
    annotation (Placement(transformation(extent={{57,-72},{88,-42}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3)
    annotation (Placement(transformation(extent={{-78,36},{-54,58}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3)
    annotation (Placement(transformation(extent={{-20,38},{4,62}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-54,86},{-74,106}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package Medium
      = TRANSFORM.Media.Fluids.Ethylene_Glycol_50_Water.Linear_Ethylene_Glycol,
      precision=3)
    annotation (Placement(transformation(extent={{102,-92},{126,-72}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow_multi
    boundary3(nPorts=10, Q_flow=fill(200e2, 10))
    annotation (Placement(transformation(extent={{-66,60},{-46,80}})));
equation
  connect(pipe2.port_b, pipe7.port_a) annotation (Line(points={{120,48},{128,48},
          {128,-2}},               color={0,127,255}));
  connect(pump1.port_b, pipe5.port_a)
    annotation (Line(points={{-38,-60},{-54,-60}}, color={0,127,255}));
  connect(tank1.port_b, pipe2.port_a) annotation (Line(points={{23.6,49.2},{
          23.6,48},{104,48}}, color={0,127,255}));
  connect(pipe7.port_b, temperature3.port) annotation (Line(points={{128,-14},{
          128,-60},{115,-60}}, color={0,127,255}));
  connect(pipe5.port_b, pipe4.port_a) annotation (Line(points={{-66,-60},{-80,
          -60},{-80,-8}}, color={0,127,255}));
  connect(const.y, Chromolox_Heater_Control.u_s)
    annotation (Line(points={{-117.4,96},{-101.2,96}}, color={0,0,127}));
  connect(const1.y, MassFlow_Control.u_s)
    annotation (Line(points={{1.6,-78},{-12.8,-78}}, color={0,0,127}));
  connect(boundary.ports[1], temperature4.port) annotation (Line(points={{46,
          -97.5},{55,-97.5},{55,-108}}, color={0,127,255}));
  connect(pipe7.port_b, STHX.port_a_shell) annotation (Line(points={{128,-14},{
          128,-60},{108,-60},{108,-50.1},{88,-50.1}}, color={0,127,255}));
  connect(STHX.port_b_shell, pump1.port_a) annotation (Line(points={{57,-50.1},
          {40,-50.1},{40,-50},{22,-50},{22,-56},{-26,-56},{-26,-60}}, color={0,
          127,255}));
  connect(STHX.port_b_shell, temperature2.port) annotation (Line(points={{57,
          -50.1},{40,-50.1},{40,-50},{37,-50}}, color={0,127,255}));
  connect(boundary.ports[2], STHX.port_a_tube) annotation (Line(points={{46,
          -98.5},{66,-98.5},{66,-86},{48,-86},{48,-57},{57,-57}}, color={0,127,
          255}));
  connect(pipe4.port_b, sensor_T.port_a)
    annotation (Line(points={{-80,4},{-80,47},{-78,47}}, color={0,127,255}));
  connect(sensor_T.port_b, pipe1.port_a)
    annotation (Line(points={{-54,47},{-54,48},{-46,48}},
                                                 color={0,127,255}));
  connect(pipe1.port_b, sensor_T1.port_a)
    annotation (Line(points={{-30,48},{-26,48},{-26,50},{-20,50}},
                                                 color={0,127,255}));
  connect(sensor_T1.port_b, tank1.port_a) annotation (Line(points={{4,50},{12.4,
          50},{12.4,49.2}}, color={0,127,255}));
  connect(const.y, Chromolox_Heater_Control.u_m) annotation (Line(points={{
          -117.4,96},{-104,96},{-104,108},{-94,108},{-94,103.2}}, color={0,0,
          127}));
  connect(sensor_T.T, feedback.u2)
    annotation (Line(points={{-66,50.96},{-66,70},{-64,70},{-64,88}},
                                                   color={0,0,127}));
  connect(sensor_T1.T, feedback.u1)
    annotation (Line(points={{-8,54.32},{-8,96},{-56,96}},  color={0,0,127}));
  connect(const1.y, MassFlow_Control.u_m) annotation (Line(points={{1.6,-78},{
          -4,-78},{-4,-85.2},{-20,-85.2}}, color={0,0,127}));
  connect(STHX.port_b_tube, sensor_T2.port_a) annotation (Line(points={{88,-57},
          {100,-57},{100,-82},{102,-82}}, color={0,127,255}));
  connect(sensor_T2.port_b, boundary1.ports[1]) annotation (Line(points={{126,
          -82},{134,-82},{134,-86},{144,-86},{144,-88},{154,-88}}, color={0,127,
          255}));
  connect(boundary3.port, pipe1.heatPorts[:, 1])
    annotation (Line(points={{-46,70},{-38,70},{-38,52}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
            140}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            160,140}})),
    experiment(
      StopTime=40000,
      Interval=1,
      __Dymola_Algorithm="Esdirk45a"));
end TEDSloop_full_heatsink;
