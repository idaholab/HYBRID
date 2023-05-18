within NHES.ExperimentalSystems.TEDS.Obselete_Files_from_Building;
model TEDSloop_Valving_test
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
    use_HeatTransfer=false,
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
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={226,-16})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_input=false,
    m_flow_nominal=0.8814)
    annotation (Placement(transformation(extent={{68,-76},{56,-64}})));
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
    m_flow_start=pump1.m_flow_nominal)
    annotation (Placement(transformation(extent={{140,120},{160,140}})));
  Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{212,-80},{222,-68}})));
  Data.Data_TEDS data(T_hot_side=598.15, T_cold_side=498.15)
    annotation (Placement(transformation(extent={{-100,124},{-80,144}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3)
    annotation (Placement(transformation(extent={{-76,64},{-52,86}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3)
    annotation (Placement(transformation(extent={{-18,64},{6,88}})));
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
        origin={124,-68})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={84,32})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={228,40})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{112,-76},{94,-60}})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={84,54})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={154,54})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={154,34})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={86,-36})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear3(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={150,-48})));
  Modelica.Fluid.Pipes.DynamicPipe pipe8(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={118,8})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear4(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={116,76})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow4(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={86,-18})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow6(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={150,-20})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear5(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=1000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={22,-70})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow5(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{-18,-78},{-36,-62}})));
  Control_Systems.Control_System_B control_System_B
    annotation (Placement(transformation(extent={{0,122},{20,142}})));
  BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
    annotation (Placement(transformation(extent={{-40,94},{-18,118}})));
  BaseClasses.SignalSubBus_SensorOutput sensorSubBus
    annotation (Placement(transformation(extent={{-16,96},{4,116}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{-92,92},{-72,112}})));
  Modelica.Blocks.Sources.Constant const6(k=1)
    annotation (Placement(transformation(extent={{-72,110},{-52,130}})));
equation
  connect(tank1.port_b, pipe2.port_a) annotation (Line(points={{25.6,75.2},{
          25.6,76},{40,76}},  color={0,127,255}));
  connect(pipe7.port_b, temperature3.port) annotation (Line(points={{226,-22},{
          226,-80},{217,-80}}, color={0,127,255}));
  connect(pipe4.port_b, sensor_T.port_a)
    annotation (Line(points={{-96,24},{-96,75},{-76,75}},color={0,127,255}));
  connect(sensor_T.port_b, pipe1.port_a)
    annotation (Line(points={{-52,75},{-52,76},{-44,76}},
                                                 color={0,127,255}));
  connect(pipe1.port_b, sensor_T1.port_a)
    annotation (Line(points={{-28,76},{-18,76}}, color={0,127,255}));
  connect(sensor_T1.port_b, tank1.port_a) annotation (Line(points={{6,76},{14.4,
          76},{14.4,75.2}}, color={0,127,255}));
  connect(pipe7.port_b, pipe3.port_a) annotation (Line(points={{226,-22},{226,
          -68},{130,-68}}, color={0,127,255}));
  connect(sensor_m_flow2.port_b, pipe7.port_a) annotation (Line(points={{228,30},
          {228,-2},{226,-2},{226,-10}}, color={0,127,255}));
  connect(pipe2.port_b, valveLinear.port_a)
    annotation (Line(points={{56,76},{84,76},{84,60}}, color={0,127,255}));
  connect(valveLinear.port_b, sensor_m_flow.port_a)
    annotation (Line(points={{84,48},{84,42}}, color={0,127,255}));
  connect(pipe3.port_b, sensor_m_flow1.port_a)
    annotation (Line(points={{118,-68},{112,-68}}, color={0,127,255}));
  connect(valveLinear1.port_b, sensor_m_flow3.port_a)
    annotation (Line(points={{154,48},{154,44}}, color={0,127,255}));
  connect(valveLinear1.port_a, sensor_m_flow2.port_a) annotation (Line(points={
          {154,60},{154,76},{228,76},{228,50}}, color={0,127,255}));
  connect(pipe2.port_b, valveLinear4.port_a)
    annotation (Line(points={{56,76},{110,76}}, color={0,127,255}));
  connect(valveLinear4.port_b, sensor_m_flow2.port_a)
    annotation (Line(points={{122,76},{228,76},{228,50}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, pipe8.port_a)
    annotation (Line(points={{84,22},{118,22},{118,18}}, color={0,127,255}));
  connect(sensor_m_flow3.port_b, pipe8.port_a) annotation (Line(points={{154,24},
          {154,22},{118,22},{118,18}}, color={0,127,255}));
  connect(valveLinear2.port_a, sensor_m_flow4.port_b)
    annotation (Line(points={{86,-30},{86,-28}}, color={0,127,255}));
  connect(valveLinear3.port_a, sensor_m_flow6.port_b)
    annotation (Line(points={{150,-42},{150,-30}}, color={0,127,255}));
  connect(pipe8.port_b, sensor_m_flow4.port_a)
    annotation (Line(points={{118,-2},{118,-8},{86,-8}}, color={0,127,255}));
  connect(pipe8.port_b, sensor_m_flow6.port_a) annotation (Line(points={{118,-2},
          {118,-8},{150,-8},{150,-10}}, color={0,127,255}));
  connect(sensor_m_flow1.port_b, pump1.port_a) annotation (Line(points={{94,-68},
          {82,-68},{82,-70},{68,-70}}, color={0,127,255}));
  connect(valveLinear3.port_b, pipe3.port_a) annotation (Line(points={{150,-54},
          {150,-68},{130,-68}}, color={0,127,255}));
  connect(pump1.port_b, valveLinear5.port_b)
    annotation (Line(points={{56,-70},{28,-70}}, color={0,127,255}));
  connect(valveLinear2.port_b, valveLinear5.port_b) annotation (Line(points={{
          86,-42},{86,-48},{42,-48},{42,-70},{28,-70}}, color={0,127,255}));
  connect(valveLinear5.port_a, sensor_m_flow5.port_a)
    annotation (Line(points={{16,-70},{-18,-70}}, color={0,127,255}));
  connect(sensor_m_flow5.port_b, pipe4.port_a) annotation (Line(points={{-36,
          -70},{-96,-70},{-96,12}}, color={0,127,255}));
  connect(sensorSubBus.Valve_1_Opening, valveLinear.opening) annotation (Line(
      points={{-6,106},{-6,92},{34,92},{34,54},{79.2,54}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorSubBus.Valve1, const2.y) annotation (Line(
      points={{-29,106},{-50,106},{-50,102},{-71,102}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Demand, const6.y) annotation (Line(
      points={{-28.945,106.06},{-40,106.06},{-40,120},{-51,120}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(control_System_B.actuatorSubBus, actuatorSubBus) annotation (Line(
      points={{4.76923,122.077},{4.76923,120},{-22,120},{-22,106},{-29,106}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(control_System_B.sensorSubBus, sensorSubBus) annotation (Line(
      points={{10.7692,122.077},{10.7692,106},{-6,106}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Valve_2_Opening, valveLinear4.opening) annotation (Line(
      points={{-6,106},{116,106},{116,80.8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorSubBus.Valve_3_Opening, valveLinear1.opening) annotation (Line(
      points={{-6,106},{170,106},{170,54},{158.8,54}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorSubBus.Valve_4_Opening, valveLinear3.opening) annotation (Line(
      points={{-6,106},{170,106},{170,-48},{154.8,-48}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorSubBus.Valve_5_Opening, valveLinear2.opening) annotation (Line(
      points={{-6,106},{-6,92},{34,92},{34,-36},{81.2,-36}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorSubBus.Valve_6_Opening, valveLinear5.opening) annotation (Line(
      points={{-6,106},{-6,92},{34,92},{34,-36},{22,-36},{22,-65.2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{240,
            140}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            240,140}})),
    experiment(
      StopTime=7200,
      Interval=0.1,
      __Dymola_Algorithm="Esdirk45a"));
end TEDSloop_Valving_test;
