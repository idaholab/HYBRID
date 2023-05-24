within NHES.ExperimentalSystems.TEDS.Obselete_Files_from_Building;
model TEDSloop_controls_Thermocline
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p_a_start=system.p_ambient,
    T_a_start=system.T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
        (nV=1, dimensions=fill(0.076, pipe1.nV)),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal)
    annotation (Placement(transformation(extent={{-44,68},{-28,84}})));

  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{40,68},{56,84}})));
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
        origin={-96,18})));
  Modelica.Fluid.Pipes.DynamicPipe pipe5(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{-82,-62},{-94,-50}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe7(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=false,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
                    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={156,-6})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_input=true,
    m_flow_nominal=0.8814)
    annotation (Placement(transformation(extent={{-40,-66},{-52,-54}})));
  TRANSFORM.Fluid.Volumes.ExpansionTank tank1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    A=1,
    V0=1,
    p_surface=system.p_ambient,
    p_start=system.p_start,
    level_start=0,
    h_start=pipe1.h_b_start)
    annotation (Placement(transformation(extent={{12,72},{28,88}})));
  inner TRANSFORM.Fluid.System
                        system(
    p_ambient=18000,
    T_ambient=498.15,
    m_flow_start=MassFlow_Control.y_start)
    annotation (Placement(transformation(extent={{140,120},{160,140}})));
  Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{24,-52},{14,-64}})));
  Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{142,-70},{152,-58}})));
  TRANSFORM.Controls.LimPID Chromolox_Heater_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    k_s=1,
    k_m=1,
    yMax=250e3,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=200e3)
    annotation (Placement(transformation(extent={{-120,78},{-108,66}})));
  Data.Data_TEDS data(T_hot_side=598.15, T_cold_side=498.15)
    annotation (Placement(transformation(extent={{-100,122},{-80,142}})));
  Modelica.Blocks.Sources.Constant const(k=data.T_hot_side) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-144,72})));
  TRANSFORM.Controls.LimPID MassFlow_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1,
    Ti=5,
    k_s=5e-1,
    k_m=5e-1,
    yMax=30,
    yMin=3,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=4)
    annotation (Placement(transformation(extent={{-32,-86},{-44,-74}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_cold_side) annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={-12,-80})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Ethylene_Glycol_50_Water.Linear_Ethylene_Glycol,
    use_m_flow_in=true,
    m_flow=12.6,
    T=280.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{4,-116},{24,-96}})));

  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Ethylene_Glycol_50_Water.Linear_Ethylene_Glycol,
    p=300000,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{158,-76},{138,-96}})));

  TRANSFORM.HeatExchangers.GenericDistributed_HX Glycol_HX(
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
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=1.0),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region
        (CF=5))
    annotation (Placement(transformation(extent={{35,-72},{66,-42}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3)
    annotation (Placement(transformation(extent={{-76,64},{-52,86}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3)
    annotation (Placement(transformation(extent={{-18,64},{6,88}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package Medium
      = TRANSFORM.Media.Fluids.Ethylene_Glycol_50_Water.Linear_Ethylene_Glycol,
      precision=3)
    annotation (Placement(transformation(extent={{102,-92},{126,-72}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow_multi
    boundary3(nPorts=pipe1.geometry.nV, use_port=true)
    annotation (Placement(transformation(extent={{-64,86},{-44,106}})));
  Modelica.Blocks.Sources.RealExpression realExpression[pipe1.geometry.nV](y=
        fill(Chromolox_Heater_Control.y/pipe1.geometry.nV, pipe1.geometry.nV))
    annotation (Placement(transformation(extent={{-90,88},{-70,108}})));
  Modelica.Blocks.Math.Sum sum1
    annotation (Placement(transformation(extent={{-52,-20},{-40,-8}})));
  TRANSFORM.Controls.LimPID Chromolox_Heater_Control1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    k_s=1,
    k_m=1,
    yMax=1,
    yMin=0.2,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=200e3)
    annotation (Placement(transformation(extent={{-36,-22},{-24,-34}})));
  Modelica.Blocks.Sources.Constant const2(k=200e3)          annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-62,-30})));
  Modelica.Fluid.Pipes.DynamicPipe pipe3(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
                    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={124,-50})));
  Modelica.Fluid.Pipes.DynamicPipe pipe6(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=false,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
                    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={104,-28})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={104,36})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={158,50})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{112,-58},{94,-42}})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=false,
    m_flow_start=0.41,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={104,58})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=0.5,
    f=1/(60*60),
    offset=0.5,
    startTime=0)
    annotation (Placement(transformation(extent={{80,92},{100,112}})));
  ThermoclineModels.Thermocline_Insulation thermocline_Insulation(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      geometry(Radius_Tank=0.5, Height_Tank=3.55))
    annotation (Placement(transformation(extent={{86,-10},{120,22}})));
equation
  connect(pump1.port_b, pipe5.port_a)
    annotation (Line(points={{-52,-60},{-72,-60},{-72,-56},{-82,-56}},
                                                   color={0,127,255}));
  connect(tank1.port_b, pipe2.port_a) annotation (Line(points={{25.6,75.2},{
          25.6,76},{40,76}},  color={0,127,255}));
  connect(pipe7.port_b, temperature3.port) annotation (Line(points={{156,-12},{
          156,-70},{147,-70}}, color={0,127,255}));
  connect(pipe5.port_b, pipe4.port_a) annotation (Line(points={{-94,-56},{-96,
          -56},{-96,12}}, color={0,127,255}));
  connect(const.y, Chromolox_Heater_Control.u_s)
    annotation (Line(points={{-137.4,72},{-121.2,72}}, color={0,0,127}));
  connect(const1.y, MassFlow_Control.u_s)
    annotation (Line(points={{-16.4,-80},{-30.8,-80}},
                                                     color={0,0,127}));
  connect(Glycol_HX.port_b_shell, pump1.port_a) annotation (Line(points={{35,
          -50.1},{22,-50.1},{22,-52},{-14,-52},{-14,-60},{-40,-60}}, color={0,
          127,255}));
  connect(Glycol_HX.port_b_shell, temperature2.port) annotation (Line(points={{
          35,-50.1},{22,-50.1},{22,-52},{19,-52}}, color={0,127,255}));
  connect(boundary.ports[1], Glycol_HX.port_a_tube) annotation (Line(points={{
          24,-106},{28,-106},{28,-106},{30,-106},{30,-57},{35,-57}}, color={0,
          127,255}));
  connect(pipe4.port_b, sensor_T.port_a)
    annotation (Line(points={{-96,24},{-96,75},{-76,75}},color={0,127,255}));
  connect(sensor_T.port_b, pipe1.port_a)
    annotation (Line(points={{-52,75},{-52,76},{-44,76}},
                                                 color={0,127,255}));
  connect(pipe1.port_b, sensor_T1.port_a)
    annotation (Line(points={{-28,76},{-18,76}}, color={0,127,255}));
  connect(sensor_T1.port_b, tank1.port_a) annotation (Line(points={{6,76},{14.4,
          76},{14.4,75.2}}, color={0,127,255}));
  connect(Glycol_HX.port_b_tube, sensor_T2.port_a) annotation (Line(points={{66,
          -57},{78,-57},{78,-58},{86,-58},{86,-82},{102,-82}}, color={0,127,255}));
  connect(sensor_T2.port_b, boundary1.ports[1]) annotation (Line(points={{126,-82},
          {134,-82},{134,-86},{138,-86}},                          color={0,127,
          255}));
  connect(sensor_T1.T, Chromolox_Heater_Control.u_m) annotation (Line(points={{
          -6,80.32},{-6,112},{-114,112},{-114,79.2}}, color={0,0,127}));
  connect(boundary3.port, pipe1.heatPorts[:, 1])
    annotation (Line(points={{-44,96},{-36,96},{-36,80}}, color={191,0,0}));
  connect(realExpression.y, boundary3.Q_flow_ext) annotation (Line(points={{-69,
          98},{-64,98},{-64,96},{-58,96}}, color={0,0,127}));
  connect(temperature2.T, MassFlow_Control.u_m) annotation (Line(points={{15.5,
          -58},{6,-58},{6,-66},{-4,-66},{-4,-92},{-38,-92},{-38,-87.2}}, color=
          {0,0,127}));
  connect(MassFlow_Control.y, boundary.m_flow_in) annotation (Line(points={{
          -44.6,-80},{-48,-80},{-48,-98},{4,-98}}, color={0,0,127}));
  connect(realExpression.y, sum1.u) annotation (Line(points={{-69,98},{-66,98},
          {-66,88},{-82,88},{-82,-14},{-53.2,-14}}, color={0,0,127}));
  connect(sum1.y, Chromolox_Heater_Control1.u_m) annotation (Line(points={{
          -39.4,-14},{-30,-14},{-30,-20.8}}, color={0,0,127}));
  connect(const2.y, Chromolox_Heater_Control1.u_s) annotation (Line(points={{
          -55.4,-30},{-46,-30},{-46,-28},{-37.2,-28}}, color={0,0,127}));
  connect(Chromolox_Heater_Control1.y, pump1.in_m_flow) annotation (Line(points=
         {{-23.4,-28},{-18,-28},{-18,-48},{-46,-48},{-46,-55.62}}, color={0,0,
          127}));
  connect(pipe7.port_b, pipe3.port_a) annotation (Line(points={{156,-12},{156,
          -50},{130,-50}}, color={0,127,255}));
  connect(pipe6.port_b, pipe3.port_a) annotation (Line(points={{104,-34},{136,
          -34},{136,-50},{130,-50}}, color={0,127,255}));
  connect(pipe2.port_b, sensor_m_flow2.port_a)
    annotation (Line(points={{56,76},{158,76},{158,60}}, color={0,127,255}));
  connect(sensor_m_flow2.port_b, pipe7.port_a) annotation (Line(points={{158,40},
          {158,8},{156,8},{156,0}}, color={0,127,255}));
  connect(pipe2.port_b, valveLinear.port_a)
    annotation (Line(points={{56,76},{104,76},{104,64}}, color={0,127,255}));
  connect(valveLinear.port_b, sensor_m_flow.port_a)
    annotation (Line(points={{104,52},{104,46}}, color={0,127,255}));
  connect(sine.y, valveLinear.opening) annotation (Line(points={{101,102},{112,
          102},{112,58},{108.8,58}}, color={0,0,127}));
  connect(pipe3.port_b, sensor_m_flow1.port_a)
    annotation (Line(points={{118,-50},{112,-50}}, color={0,127,255}));
  connect(sensor_m_flow1.port_b, Glycol_HX.port_a_shell) annotation (Line(
        points={{94,-50},{90,-50},{90,-50.1},{66,-50.1}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, thermocline_Insulation.port_a)
    annotation (Line(points={{104,26},{104,22},{103,22}}, color={0,127,255}));
  connect(pipe6.port_a, thermocline_Insulation.port_b) annotation (Line(points=
          {{104,-22},{104,-10},{103,-10}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
            140}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            160,140}})),
    experiment(
      StopTime=7200,
      Interval=0.1,
      __Dymola_Algorithm="Esdirk45a"));
end TEDSloop_controls_Thermocline;
