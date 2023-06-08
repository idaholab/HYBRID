within NHES.ExperimentalSystems.TEDS_New.Examples;
model TEDSloop_allmodes_test_DMM
    extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable TEDS_New.CS.CS_Dummy CS(redeclare Data.Data_Dummy
        data=data, redeclare Data.Initial_Data_Dummy data_initial),
    redeclare replaceable TEDS_New.CS.ED_Dummy ED,
    redeclare TEDS_New.Data.Data_Dummy data(m_flow_glycolwater_chiller=14),
    redeclare TEDS_New.Data.Initial_Data_Dummy data_initial);
  //"Test designed to ensure the TEDS loop can operate in all modes."
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Chromolox_Heater(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p_a_start=system.p_ambient,
    T_a_start=system.T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
        (nV=3, dimensions=fill(0.076, Chromolox_Heater.nV)),
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
    length=0.1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={228,-18})));
  TRANSFORM.Fluid.Volumes.ExpansionTank tank1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    A=1,
    V0=0.1,
    p_surface=system.p_ambient,
    p_start=system.p_start,
    level_start=0,
    h_start=Chromolox_Heater.h_b_start)
    annotation (Placement(transformation(extent={{-6,72},{10,88}})));
  inner TRANSFORM.Fluid.System
                        system(
    p_ambient=18000,
    T_ambient=498.15,
    m_flow_start=0.84)
    annotation (Placement(transformation(extent={{220,120},{240,140}})));


  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3)
    annotation (Placement(transformation(extent={{-80,34},{-56,56}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Chromolox_exit_temperature(
      redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{-22,34},{2,58}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe3(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={170,-142})));
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
        origin={228,48})));
  TRANSFORM.Fluid.Sensors.MassFlowRate Chiller_Mass_flow_T66(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3)
    annotation (Placement(transformation(extent={{132,-132},{106,-152}})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=1e-2,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={84,56})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve3(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={154,66})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve5(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={80,-116})));
  TRANSFORM.Fluid.Valves.ValveLinear valve4(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={182,-128})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=false,
    m_flow_start=0.41,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={132,76})));
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
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-38,-146})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow5(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{-62,-154},{-80,-138}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={154,40})));
  Components.Thermocline_Insulation        thermocline_Insulation(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    redeclare package InsulationMaterial = NHES.Media.Solids.FoamGlass,
    geometry(
      Radius_Tank=0.438,
      Porosity=0.5,
      dr=0.00317,
      Insulation_thickness=3*0.051,
      Wall_Thickness=0.019,
      Height_Tank=4.435),
    T_Init=493.15)
    annotation (Placement(transformation(extent={{102,-50},{134,-6}})));
  Modelica.Fluid.Sources.MassFlowSource_T Chiller_Mass_Flow(
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
    T_a_start_shell=data.T_hot_design,
    T_b_start_shell=data.T_cold_design,
    p_b_start_tube=boundary1.p,
    counterCurrent=true,
    m_flow_a_start_tube=dataInitial.MassFlow_Controlstart,
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
    T_a_start_tube=Chiller_Mass_Flow.T,
    T_b_start_tube=boundary1.T,
    p_a_start_shell=system.p_ambient + 100,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=1.0),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=2.0))
    annotation (Placement(transformation(extent={{61,-164},{92,-134}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Ethylene_glycol_exit_temperature(
      redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{128,-200},{158,-176}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort HX_exit_temperature_T66(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{24,-132},{48,-158}})));
  TRANSFORM.Blocks.RealExpression
                            Chromolox_Heater_Control
    annotation (Placement(transformation(extent={{104,136},{116,124}})));
  Modelica.Blocks.Sources.RealExpression realExpression[Chromolox_Heater.geometry.nV](y=fill(
        Chromolox_Heater_Control.u/Chromolox_Heater.geometry.nV,
        Chromolox_Heater.geometry.nV))
    annotation (Placement(transformation(extent={{-94,54},{-74,74}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow_multi
    boundary3(nPorts=Chromolox_Heater.geometry.nV, use_port=true)
    annotation (Placement(transformation(extent={{-68,54},{-48,74}})));
  Modelica.Blocks.Math.Sum chromoloxHeater_Power(nin=Chromolox_Heater.geometry.nV)
    annotation (Placement(transformation(extent={{-72,92},{-60,104}})));
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
  TRANSFORM.Fluid.Sensors.MassFlowRate BOP_Mass_flow(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={106,76})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_inlet_HX(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-10,12},{10,-12}},
        rotation=0,
        origin={146,-142})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_before(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-13,12},{13,-12}},
        rotation=270,
        origin={228,15})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_after(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-13,13},{13,-13}},
        rotation=270,
        origin={227,-65})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_after_tank(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{18,64},{42,88}})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster pump(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_input=true,
    p_nominal=system.p_ambient + 1e4)
    annotation (Placement(transformation(extent={{14,-138},{-2,-154}})));
  TRANSFORM.Fluid.Sensors.Pressure           HX_exit_temperature_T1(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{36,-156},{12,-182}})));
equation
  connect(pipe4.port_b, sensor_T.port_a)
    annotation (Line(points={{-95,-38},{-95,45},{-80,45}},
                                                         color={0,127,255}));
  connect(sensor_T.port_b, Chromolox_Heater.port_a)
    annotation (Line(points={{-56,45},{-56,46},{-48,46}}, color={0,127,255}));
  connect(Chromolox_Heater.port_b, Chromolox_exit_temperature.port_a)
    annotation (Line(points={{-32,46},{-22,46}}, color={0,127,255}));
  connect(Chromolox_exit_temperature.port_b, tank1.port_a) annotation (Line(
        points={{2,46},{-3.6,46},{-3.6,75.2}}, color={0,127,255}));
  connect(pipe2.port_b, Valve1.port_a)
    annotation (Line(points={{62,76},{84,76},{84,62}}, color={0,127,255}));
  connect(Valve1.port_b, sensor_m_flow.port_a)
    annotation (Line(points={{84,50},{84,48}}, color={0,127,255}));
  connect(Valve3.port_a, sensor_m_flow2.port_a) annotation (Line(points={{154,72},
          {154,76},{228,76},{228,58}}, color={0,127,255}));
  connect(Valve2.port_b, sensor_m_flow2.port_a)
    annotation (Line(points={{138,76},{228,76},{228,58}}, color={0,127,255}));
  connect(Valve5.port_a, sensor_m_flow4.port_b)
    annotation (Line(points={{80,-110},{80,-110}},
                                                 color={0,127,255}));
  connect(valve4.port_a, sensor_m_flow6.port_b) annotation (Line(points={{182,
          -122},{182,-118},{154,-118},{154,-112}},
                                          color={0,127,255}));
  connect(valve4.port_b, pipe3.port_a) annotation (Line(points={{182,-134},{182,
          -142},{176,-142}},
                      color={0,127,255}));
  connect(Valve5.port_b, Valve6.port_b) annotation (Line(points={{80,-122},{80,
          -126},{-18,-126},{-18,-146},{-32,-146}},
                                      color={0,127,255}));
  connect(Valve6.port_a, sensor_m_flow5.port_a)
    annotation (Line(points={{-44,-146},{-62,-146}},
                                                   color={0,127,255}));
  connect(sensor_m_flow5.port_b, pipe4.port_a) annotation (Line(points={{-80,
          -146},{-95,-146},{-95,-56}},
                               color={0,127,255}));
  connect(Valve3.port_b, sensor_m_flow3.port_b)
    annotation (Line(points={{154,60},{154,50}}, color={0,127,255}));
  connect(Chiller_Mass_Flow.ports[1], Glycol_HX.port_a_tube) annotation (Line(
        points={{50,-214},{56,-214},{56,-149},{61,-149}}, color={0,127,255}));
  connect(Glycol_HX.port_b_tube, Ethylene_glycol_exit_temperature.port_a)
    annotation (Line(points={{92,-149},{104,-149},{104,-188},{128,-188}}, color=
         {0,127,255}));
  connect(Ethylene_glycol_exit_temperature.port_b, boundary1.ports[1])
    annotation (Line(points={{158,-188},{180,-188}}, color={0,127,255}));
  connect(Chiller_Mass_flow_T66.port_b, Glycol_HX.port_a_shell) annotation (
      Line(points={{106,-142},{92,-142},{92,-142.1}}, color={0,127,255}));
  connect(Glycol_HX.port_b_shell, HX_exit_temperature_T66.port_b) annotation (
      Line(points={{61,-142.1},{48,-142.1},{48,-145}}, color={0,127,255}));
  connect(realExpression.y, boundary3.Q_flow_ext)
    annotation (Line(points={{-73,64},{-62,64}}, color={0,0,127}));
  connect(boundary3.port, Chromolox_Heater.heatPorts[:, 1])
    annotation (Line(points={{-48,64},{-40,64},{-40,50}}, color={191,0,0}));
  connect(realExpression.y, chromoloxHeater_Power.u) annotation (Line(points={{-73,64},
          {-70,64},{-70,88},{-80,88},{-80,98},{-73.2,98}},         color={0,0,
          127}));
  connect(sensor_m_flow3.port_a, T_discharge_outlet.port_b)
    annotation (Line(points={{154,30},{154,21}}, color={0,127,255}));
  connect(T_discharge_outlet.port_a, thermocline_Insulation.port_a) annotation (
     Line(points={{154,-3},{154,-6},{118,-6}},   color={0,127,255}));
  connect(sensor_m_flow.port_b, T_Charge_Inlet.port_a)
    annotation (Line(points={{84,28},{84,19}}, color={0,127,255}));
  connect(T_Charge_Inlet.port_b, thermocline_Insulation.port_a)
    annotation (Line(points={{84,-5},{84,-6},{118,-6}},   color={0,127,255}));
  connect(sensor_m_flow6.port_a, T_charge_outlet.port_a)
    annotation (Line(points={{154,-90},{154,-75}}, color={0,127,255}));
  connect(T_charge_outlet.port_b, thermocline_Insulation.port_b) annotation (
      Line(points={{154,-51},{154,-50},{118,-50}}, color={0,127,255}));
  connect(sensor_m_flow4.port_a, T_discharge_Inlet.port_a)
    annotation (Line(points={{80,-86},{80,-75}}, color={0,127,255}));
  connect(T_discharge_Inlet.port_b, thermocline_Insulation.port_b)
    annotation (Line(points={{80,-51},{80,-50},{118,-50}}, color={0,127,255}));
  connect(pipe2.port_b, BOP_Mass_flow.port_a)
    annotation (Line(points={{62,76},{96,76}}, color={0,127,255}));
  connect(BOP_Mass_flow.port_b, Valve2.port_a)
    annotation (Line(points={{116,76},{126,76}}, color={0,127,255}));
  connect(pipe3.port_b, T_inlet_HX.port_b)
    annotation (Line(points={{164,-142},{156,-142}}, color={0,127,255}));
  connect(T_inlet_HX.port_a, Chiller_Mass_flow_T66.port_a)
    annotation (Line(points={{136,-142},{132,-142}}, color={0,127,255}));
  connect(sensor_m_flow2.port_b, T_chiller_before.port_a)
    annotation (Line(points={{228,38},{228,28}}, color={0,127,255}));
  connect(T_chiller_before.port_b, pipe7.port_a)
    annotation (Line(points={{228,2},{228,-10}}, color={0,127,255}));
  connect(pipe7.port_b, T_chiller_after.port_a) annotation (Line(points={{228,
          -26},{228,-52},{227,-52}}, color={0,127,255}));
  connect(T_chiller_after.port_b, pipe3.port_a) annotation (Line(points={{227,
          -78},{227,-142},{176,-142}}, color={0,127,255}));
  connect(tank1.port_b, sensor_after_tank.port_a)
    annotation (Line(points={{7.6,75.2},{7.6,76},{18,76}}, color={0,127,255}));
  connect(sensor_after_tank.port_b, pipe2.port_a)
    annotation (Line(points={{42,76},{46,76}}, color={0,127,255}));
  connect(HX_exit_temperature_T66.port_a, pump.port_a) annotation (Line(points=
          {{24,-145},{18,-145},{18,-146},{14,-146}}, color={0,127,255}));
  connect(Valve6.port_b, pump.port_b)
    annotation (Line(points={{-32,-146},{-2,-146}}, color={0,127,255}));

  connect(actuatorBus.valve_5_opening, Valve5.opening) annotation (Line(
      points={{30,100},{30,-112},{75.2,-112},{75.2,-116}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_6_opening, Valve6.opening) annotation (Line(
      points={{30,100},{30,-70},{-38,-70},{-38,-141.2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_1_opening, Valve1.opening) annotation (Line(
      points={{30,100},{30,56},{79.2,56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_2_opening, Valve2.opening) annotation (Line(
      points={{30,100},{60,100},{60,96},{128,96},{128,86},{132,86},{132,80.8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorBus.valve_3_opening, Valve3.opening) annotation (Line(
      points={{30,100},{132,100},{132,88},{164,88},{164,66},{158.8,66}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_4_opening, valve4.opening) annotation (Line(
      points={{30,100},{172,100},{172,28},{192,28},{192,-128},{186.8,-128}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.heater_input, chromoloxHeater_Power.y) annotation (Line(
      points={{-30,100},{-44,100},{-44,98},{-59.4,98}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.chiller_mass_flow, Chiller_Mass_flow_T66.m_flow)
    annotation (Line(
      points={{-30,100},{-30,60},{14,60},{14,-130},{54,-130},{54,-132},{96,-132},
          {96,-152},{119,-152},{119,-145.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.BOP_mass_flow, BOP_Mass_flow.m_flow) annotation (Line(
      points={{-30,100},{106,100},{106,79.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.charging_flow_rate, sensor_m_flow6.m_flow) annotation (Line(
      points={{-30,100},{-30,-72},{60,-72},{60,-80},{170,-80},{170,-101},{157.6,
          -101}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_charge_outlet, T_charge_outlet.T) annotation (Line(
      points={{-30,100},{168,100},{168,-44},{172,-44},{172,-63},{158.68,-63}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_discharge_inlet, T_discharge_Inlet.T) annotation (Line(
      points={{-30,100},{-30,26},{60,26},{60,-63},{75.32,-63}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_charge_inlet, T_Charge_Inlet.T) annotation (Line(
      points={{-30,100},{-30,28},{64,28},{64,7},{79.32,7}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_discharge_outlet, T_discharge_outlet.T) annotation (Line(
      points={{-30,100},{170,100},{170,26},{168,26},{168,10},{164,10},{164,9},{158.68,
          9}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.discharging_flow_rate, sensor_m_flow3.m_flow) annotation (
      Line(
      points={{-30,100},{166,100},{166,40},{157.6,40}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.heater_flow_rate, sensor_m_flow5.m_flow) annotation (Line(
      points={{-30,100},{-30,-68},{-71,-68},{-71,-143.12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_Chromolox_Exit, Chromolox_exit_temperature.T) annotation (
     Line(
      points={{-30,100},{-30,64},{-10,64},{-10,60},{4,60},{4,50.32},{-10,50.32}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorBus.heater_power, Chromolox_Heater_Control.u) annotation (
      Line(
      points={{30,100},{96,100},{96,130},{102.8,130}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.pump_dp, pump.in_p) annotation (Line(
      points={{30,100},{304,100},{304,-232},{-40,-232},{-40,-176},{6,-176},{6,-151.84}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(HX_exit_temperature_T66.port_a, HX_exit_temperature_T1.port)
    annotation (Line(points={{24,-145},{24,-156}}, color={0,127,255}));
  connect(sensorBus.pump_inlet_pressure, HX_exit_temperature_T1.p) annotation (
      Line(
      points={{-30,100},{-32,100},{-32,122},{-118,122},{-118,-176},{16.8,-176},{
          16.8,-169}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_therminol_glycolHX_exit, HX_exit_temperature_T66.T)
    annotation (Line(
      points={{-30,100},{-76,100},{-76,86},{-122,86},{-122,-176},{40,-176},{40,-149.68},
          {36,-149.68}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.glycol_water_flow_rate, Chiller_Mass_Flow.m_flow_in)
    annotation (Line(
      points={{30,100},{306,100},{306,-230},{12,-230},{12,-206},{30,-206}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-220},{240,
            140}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-156,-208},{232,138}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-24,68},{176,-30},{-24,-150},{-24,68}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-220},{
            240,140}})),
    experiment(
      StopTime=18000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_Commands(file="../../TEDS/Basic_TEDS_setup.mos" "Basic_TEDS_setup",
        file="../../TEDS/M3_TEDS.mos" "M3_TEDS"));
end TEDSloop_allmodes_test_DMM;
