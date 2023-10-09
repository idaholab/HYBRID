within NHES.ExperimentalSystems.TEDS.Examples;
model TEDSloopTest_Basic
  "This is just a basic test, it does not operate through all modes, but only through TES tank valving."
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p_a_start=system.p_ambient,
    T_a_start=system.T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
        (nV=3, dimensions=fill(0.076, pipe1.nV)),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal)
    annotation (Placement(transformation(extent={{-48,38},{-32,54}})));

  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{46,68},{62,84}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe4(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
                    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={-95,-47})));
  Modelica.Fluid.Pipes.DynamicPipe pipe7(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
                    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={228,-18})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_input=true,
    m_flow_nominal=0.8814)
    annotation (Placement(transformation(extent={{22,-152},{10,-140}})));
  TRANSFORM.Fluid.Volumes.ExpansionTank tank1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    A=1,
    V0=1,
    p_surface=system.p_ambient,
    p_start=system.p_start,
    level_start=0,
    h_start=pipe1.h_b_start)
    annotation (Placement(transformation(extent={{8,72},{24,88}})));
  inner TRANSFORM.Fluid.System
                        system(
    p_ambient=18000,
    T_ambient=498.15,
    m_flow_start=pump1.m_flow_nominal)
    annotation (Placement(transformation(extent={{220,120},{240,140}})));
  Data.Data_TEDS data(T_hot_side=598.15, T_cold_side=498.15)
    annotation (Placement(transformation(extent={{-100,124},{-80,144}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3)
    annotation (Placement(transformation(extent={{-80,34},{-56,56}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3)
    annotation (Placement(transformation(extent={{-22,34},{2,58}})));
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
        origin={156,-142})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={84,38})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={228,40})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{144,-134},{118,-154}})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=1e-2,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={84,56})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve3(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={154,66})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve5(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={80,-116})));
  TRANSFORM.Fluid.Valves.ValveLinear valve4(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={182,-128})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={116,76})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow4(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,-10},{12,10}},
        rotation=-90,
        origin={80,-98})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow6(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=-90,
        origin={154,-101})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve6(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-10,-146})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow5(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{-24,-154},{-42,-138}})));
  Control_Systems.Control_System_Therminol_3_element
    control_System_Therminol_3_element(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_hot_design=598.15,
    T_cold_design=498.15)
    annotation (Placement(transformation(extent={{20,118},{42,140}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={154,40})));
  ThermoclineModels_1.Thermocline_Insulation thermocline_Insulation(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, geometry(
        Radius_Tank=0.5, Height_Tank=3.55))
    annotation (Placement(transformation(extent={{102,-50},{134,-10}})));
  TRANSFORM.Controls.LimPID MassFlow_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1,
    Ti=5,
    k_s=5e-1,
    k_m=5e-1,
    yMax=30,
    yMin=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=9.7)
    annotation (Placement(transformation(extent={{-6,-194},{-18,-182}})));
  Modelica.Blocks.Sources.Constant const1(k=control_System_Therminol_3_element.T_cold_design)
    annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={12,-184})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    use_m_flow_in=true,
    m_flow=12.6,
    T=280.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{30,-224},{50,-204}})));

  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    p=300000,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{200,-178},{180,-198}})));

  TRANSFORM.HeatExchangers.GenericDistributed_HX Glycol_HX(
    p_b_start_shell=system.p_ambient,
    T_a_start_shell=data.T_hot_side,
    T_b_start_shell=data.T_cold_side,
    p_b_start_tube=boundary1.p,
    counterCurrent=true,
    m_flow_a_start_tube=boundary.m_flow,
    m_flow_a_start_shell=MassFlow_Control.y_start,
    redeclare package Medium_tube =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
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
    annotation (Placement(transformation(extent={{61,-164},{92,-134}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{128,-200},{158,-176}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3)
    annotation (Placement(transformation(extent={{30,-130},{54,-156}})));
  Modelica.Blocks.Sources.Constant const(k=control_System_Therminol_3_element.T_hot_design)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-146,46})));
  TRANSFORM.Controls.LimPID Chromolox_Heater_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    k_s=1,
    k_m=1,
    yMax=250e3,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=200e3)
    annotation (Placement(transformation(extent={{-122,52},{-110,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression[pipe1.geometry.nV](y=
        fill(Chromolox_Heater_Control.y/pipe1.geometry.nV, pipe1.geometry.nV))
    annotation (Placement(transformation(extent={{-94,54},{-74,74}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow_multi
    boundary3(nPorts=pipe1.geometry.nV, use_port=true)
    annotation (Placement(transformation(extent={{-68,54},{-48,74}})));
  Modelica.Blocks.Math.Sum sum1(nin=pipe1.geometry.nV)
    annotation (Placement(transformation(extent={{-72,86},{-60,98}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_charge_outlet(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=90,
        origin={154,-63})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_Charge_Inlet(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=-90,
        origin={84,7})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_discharge_outlet(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=90,
        origin={154,9})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_discharge_Inlet(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,-13},{12,13}},
        rotation=90,
        origin={80,-63})));
  BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
    annotation (Placement(transformation(extent={{-42,94},{-20,118}})));
  BaseClasses.SignalSubBus_SensorOutput sensorSubBus
    annotation (Placement(transformation(extent={{-10,94},{12,118}})));
equation
  connect(tank1.port_b, pipe2.port_a) annotation (Line(points={{21.6,75.2},{
          21.6,76},{46,76}},  color={0,127,255}));
  connect(pipe4.port_b, sensor_T.port_a)
    annotation (Line(points={{-95,-38},{-95,45},{-80,45}},
                                                         color={0,127,255}));
  connect(sensor_T.port_b, pipe1.port_a)
    annotation (Line(points={{-56,45},{-56,46},{-48,46}},
                                                 color={0,127,255}));
  connect(pipe1.port_b, sensor_T1.port_a)
    annotation (Line(points={{-32,46},{-22,46}}, color={0,127,255}));
  connect(sensor_T1.port_b, tank1.port_a) annotation (Line(points={{2,46},{10.4,
          46},{10.4,75.2}}, color={0,127,255}));
  connect(pipe7.port_b, pipe3.port_a) annotation (Line(points={{228,-26},{228,
          -142},{162,-142}},
                      color={0,127,255}));
  connect(sensor_m_flow2.port_b, pipe7.port_a) annotation (Line(points={{228,30},
          {228,-10}},                   color={0,127,255}));
  connect(pipe2.port_b, Valve1.port_a)
    annotation (Line(points={{62,76},{84,76},{84,62}}, color={0,127,255}));
  connect(Valve1.port_b, sensor_m_flow.port_a)
    annotation (Line(points={{84,50},{84,48}}, color={0,127,255}));
  connect(pipe3.port_b, sensor_m_flow1.port_a) annotation (Line(points={{150,
          -142},{150,-144},{144,-144}},
                                color={0,127,255}));
  connect(Valve3.port_a, sensor_m_flow2.port_a) annotation (Line(points={{154,72},
          {154,76},{228,76},{228,50}}, color={0,127,255}));
  connect(pipe2.port_b, Valve2.port_a)
    annotation (Line(points={{62,76},{110,76}}, color={0,127,255}));
  connect(Valve2.port_b, sensor_m_flow2.port_a)
    annotation (Line(points={{122,76},{228,76},{228,50}}, color={0,127,255}));
  connect(Valve5.port_a, sensor_m_flow4.port_b)
    annotation (Line(points={{80,-110},{80,-110}},
                                                 color={0,127,255}));
  connect(valve4.port_a, sensor_m_flow6.port_b) annotation (Line(points={{182,
          -122},{182,-118},{154,-118},{154,-112}},
                                          color={0,127,255}));
  connect(valve4.port_b, pipe3.port_a) annotation (Line(points={{182,-134},{182,
          -142},{162,-142}},
                      color={0,127,255}));
  connect(pump1.port_b, Valve6.port_b)
    annotation (Line(points={{10,-146},{-4,-146}},
                                                color={0,127,255}));
  connect(Valve5.port_b, Valve6.port_b) annotation (Line(points={{80,-122},{80,
          -124},{6,-124},{6,-146},{-4,-146}},
                                      color={0,127,255}));
  connect(Valve6.port_a, sensor_m_flow5.port_a)
    annotation (Line(points={{-16,-146},{-24,-146}},
                                                   color={0,127,255}));
  connect(sensor_m_flow5.port_b, pipe4.port_a) annotation (Line(points={{-42,
          -146},{-95,-146},{-95,-56}},
                               color={0,127,255}));
  connect(sensorSubBus.Valve_1_Opening, Valve1.opening) annotation (Line(
      points={{1,106},{26,106},{26,56},{79.2,56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(control_System_Therminol_3_element.actuatorSubBus, actuatorSubBus)
    annotation (Line(
      points={{30.7067,118.092},{30.7067,106},{-31,106}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(control_System_Therminol_3_element.sensorSubBus, sensorSubBus)
    annotation (Line(
      points={{36.1333,118.092},{36.1333,106},{1,106}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Valve_2_Opening, Valve2.opening) annotation (Line(
      points={{1,106},{116,106},{116,80.8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorSubBus.Valve_3_Opening, Valve3.opening) annotation (Line(
      points={{1,106},{170,106},{170,66},{158.8,66}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorSubBus.Valve_4_Opening, valve4.opening) annotation (Line(
      points={{1,106},{202,106},{202,-128},{186.8,-128}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorSubBus.Valve_5_Opening, Valve5.opening) annotation (Line(
      points={{1,106},{26,106},{26,-116},{75.2,-116}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorSubBus.Valve_6_Opening, Valve6.opening) annotation (Line(
      points={{1,106},{26,106},{26,-116},{-10,-116},{-10,-141.2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Valve3.port_b, sensor_m_flow3.port_b)
    annotation (Line(points={{154,60},{154,50}}, color={0,127,255}));
  connect(const1.y,MassFlow_Control. u_s)
    annotation (Line(points={{7.6,-184},{2,-184},{2,-188},{-4.8,-188}},
                                                     color={0,0,127}));
  connect(boundary.ports[1], Glycol_HX.port_a_tube) annotation (Line(points={{50,-214},
          {56,-214},{56,-149},{61,-149}},     color={0,127,255}));
  connect(Glycol_HX.port_b_tube, sensor_T2.port_a) annotation (Line(points={{92,-149},
          {104,-149},{104,-188},{128,-188}},     color={0,127,255}));
  connect(sensor_T2.port_b,boundary1. ports[1]) annotation (Line(points={{158,
          -188},{180,-188}},                                       color={0,127,
          255}));
  connect(MassFlow_Control.y, boundary.m_flow_in) annotation (Line(points={{-18.6,
          -188},{-22,-188},{-22,-206},{30,-206}}, color={0,0,127}));
  connect(sensor_m_flow1.port_b, Glycol_HX.port_a_shell) annotation (Line(
        points={{118,-144},{92,-144},{92,-142.1}},
                                                color={0,127,255}));
  connect(Glycol_HX.port_b_shell, sensor_T3.port_b) annotation (Line(points={{61,
          -142.1},{54,-142.1},{54,-143}},
                                       color={0,127,255}));
  connect(pump1.port_a, sensor_T3.port_a)
    annotation (Line(points={{22,-146},{30,-146},{30,-143}},
                                                          color={0,127,255}));
  connect(MassFlow_Control.u_m, sensor_T3.T) annotation (Line(points={{-12,
          -195.2},{-12,-196},{42,-196},{42,-147.68}},
                                            color={0,0,127}));
  connect(realExpression.y, boundary3.Q_flow_ext)
    annotation (Line(points={{-73,64},{-62,64}}, color={0,0,127}));
  connect(boundary3.port, pipe1.heatPorts[:, 1])
    annotation (Line(points={{-48,64},{-40,64},{-40,50}}, color={191,0,0}));
  connect(const.y, Chromolox_Heater_Control.u_s) annotation (Line(points={{-139.4,
          46},{-123.2,46}},                     color={0,0,127}));
  connect(sensor_T1.T, Chromolox_Heater_Control.u_m) annotation (Line(points={{-10,
          50.32},{-10,84},{-116,84},{-116,53.2}}, color={0,0,127}));
  connect(sensorSubBus.Pump_Flow, pump1.in_m_flow) annotation (Line(
      points={{1,106},{26,106},{26,-116},{16,-116},{16,-141.62}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(realExpression.y, sum1.u) annotation (Line(points={{-73,64},{-70,64},{
          -70,84},{-80,84},{-80,92},{-73.2,92}}, color={0,0,127}));
  connect(actuatorSubBus.Heater_Input, sum1.y) annotation (Line(
      points={{-31,106},{-50,106},{-50,92},{-59.4,92}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_m_flow3.port_a, T_discharge_outlet.port_b)
    annotation (Line(points={{154,30},{154,21}}, color={0,127,255}));
  connect(T_discharge_outlet.port_a, thermocline_Insulation.port_a) annotation (
     Line(points={{154,-3},{154,-10},{118,-10}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, T_Charge_Inlet.port_a)
    annotation (Line(points={{84,28},{84,19}}, color={0,127,255}));
  connect(T_Charge_Inlet.port_b, thermocline_Insulation.port_a)
    annotation (Line(points={{84,-5},{84,-10},{118,-10}}, color={0,127,255}));
  connect(sensor_m_flow6.port_a, T_charge_outlet.port_a)
    annotation (Line(points={{154,-90},{154,-75}}, color={0,127,255}));
  connect(T_charge_outlet.port_b, thermocline_Insulation.port_b) annotation (
      Line(points={{154,-51},{154,-50},{118,-50}}, color={0,127,255}));
  connect(sensor_m_flow4.port_a, T_discharge_Inlet.port_a)
    annotation (Line(points={{80,-86},{80,-75}}, color={0,127,255}));
  connect(T_discharge_Inlet.port_b, thermocline_Insulation.port_b)
    annotation (Line(points={{80,-51},{80,-50},{118,-50}}, color={0,127,255}));
  connect(actuatorSubBus.T_discharge_outlet, T_discharge_outlet.T) annotation (
      Line(
      points={{-31,106},{202,106},{202,9},{158.68,9}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.T_discharge_inlet, T_discharge_Inlet.T) annotation (
      Line(
      points={{-31,106},{26,106},{26,-63},{75.32,-63}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.T_charge_outlet, T_charge_outlet.T) annotation (Line(
      points={{-31,106},{202,106},{202,-63},{158.68,-63}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.T_charge_inlet, T_Charge_Inlet.T) annotation (Line(
      points={{-31,106},{26,106},{26,7},{79.32,7}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Charging_flowrate, sensor_m_flow6.m_flow) annotation (
      Line(
      points={{-31,106},{202,106},{202,-101},{157.6,-101}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Discharge_FlowRate, sensor_m_flow3.m_flow) annotation (
     Line(
      points={{-31,106},{202,106},{202,40},{157.6,40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Total_Mass_Flow_System, sensor_m_flow1.m_flow)
    annotation (Line(
      points={{-31,106},{240,106},{240,-160},{131,-160},{131,-147.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-220},{240,
            140}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-156,-216},{232,130}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-24,68},{176,-30},{-24,-150},{-24,68}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-220},{
            240,140}})),
    experiment(
      StopTime=7200,
      Interval=1,
      __Dymola_Algorithm="Esdirk45a"));
end TEDSloopTest_Basic;
