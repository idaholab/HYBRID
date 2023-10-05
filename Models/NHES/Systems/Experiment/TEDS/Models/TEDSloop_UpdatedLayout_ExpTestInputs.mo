within NHES.ExperimentalSystems.TEDS.Examples;
model TEDSloop_UpdatedLayout_ExpTestInputs
  "Test designed to ensure the TEDS loop can operate in all modes."

  parameter Real FV_opening=0.00250;


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
    annotation (Placement(transformation(extent={{-66,66},{-50,82}})));

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
        origin={-103,-47})));
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
        origin={214,-18})));
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
    T_ambient=298.15,
    m_flow_start=0.84)
    annotation (Placement(transformation(extent={{-154,92},{-134,112}})));
  Data.Data_TEDS data(T_hot_side=523.15, T_cold_side=298.15)
    annotation (Placement(transformation(extent={{-154,118},{-134,138}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_002(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{-98,62},{-74,84}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_003(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{-40,62},{-16,86}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe3(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=700, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={206,-144})));
  TRANSFORM.Fluid.Sensors.MassFlowRate m_thot(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,46})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={214,48})));
  TRANSFORM.Fluid.Sensors.MassFlowRate Chiller_Mass_flow_T66(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3)
    annotation (Placement(transformation(extent={{9.5,10.5},{-9.5,-10.5}},
        rotation=90,
        origin={124.5,-199.5})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_049(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=1e-2,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={84,66})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_050(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={176,66})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_051(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={56,-106})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_052(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={182,-134})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_006(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=3000,
    m_flow_nominal=0.840,
    dp(start=100, fixed=true))
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={132,76})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_201(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,-10},{12,10}},
        rotation=0,
        origin={24,-106})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_202(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={160,-105})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_004(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-90,-146})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_003(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{9,-8},{-9,8}},
        rotation=270,
        origin={-103,-98})));
  Control_Systems.Control_System_TEDS_ExpTest
    control_System_Therminol_4_element_all_modes_ExpTest3_1(T_hot_design=523.15)
    annotation (Placement(transformation(extent={{0,154},{40,190}})));
  BaseClasses.SignalSubBus_ActuatorInput SensorSubBus
    annotation (Placement(transformation(extent={{-72,130},{-50,154}})));
  BaseClasses.SignalSubBus_SensorOutput ActuatorSubBus
    annotation (Placement(transformation(extent={{-30,130},{-8,154}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{11,-11},{-11,11}},
        rotation=180,
        origin={157,47})));
  ThermoclineModels.Thermocline_Insulation thermocline_Insulation(
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
    T_Init=303.15)
    annotation (Placement(transformation(extent={{22,-46},{54,-2}})));
  Modelica.Fluid.Sources.MassFlowSource_T Chiller_Mass_Flow(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    use_m_flow_in=true,
    m_flow=12.6,
    T=280.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{30,-248},{50,-228}})));

  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    p=300000,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{210,-230},{190,-250}})));

  TRANSFORM.HeatExchangers.GenericDistributed_HX Glycol_HX(
    p_b_start_shell=system.p_ambient,
    T_a_start_shell=data.T_hot_side,
    T_b_start_shell=data.T_cold_side,
    p_b_start_tube=boundary1.p,
    counterCurrent=true,
    m_flow_a_start_tube=Chiller_Mass_Flow.m_flow,
    m_flow_a_start_shell=12.6,
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
        length_shell=3.0,
        dimension_tube=0.013,
        length_tube=3.0,
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
    annotation (Placement(transformation(extent={{77,-254},{108,-224}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Ethylene_glycol_exit_temperature(
      redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{140,-252},{170,-228}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_006(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{16,-132},{40,-158}})));
  Modelica.Blocks.Sources.RealExpression realExpression[Chromolox_Heater.geometry.nV](y=fill(
        W_heater.y/Chromolox_Heater.geometry.nV, Chromolox_Heater.geometry.nV))
    annotation (Placement(transformation(extent={{-120,88},{-100,108}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow_multi
    boundary3(nPorts=Chromolox_Heater.geometry.nV, use_port=true)
    annotation (Placement(transformation(extent={{-86,82},{-66,102}})));
  Modelica.Blocks.Math.Sum chromoloxHeater_Power(nin=Chromolox_Heater.geometry.nV)
    annotation (Placement(transformation(extent={{-78,114},{-66,126}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_ch_o(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=180,
        origin={126,-105})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_201(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=-90,
        origin={38,21})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_discharge_outlet(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=0,
        origin={124,47})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_202(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,-13},{12,13}},
        rotation=90,
        origin={38,-69})));
  TRANSFORM.Fluid.Sensors.MassFlowRate BOP_Mass_flow(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={106,76})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_004(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-9,12},{9,-12}},
        rotation=90,
        origin={124,-223})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_before(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-13,12},{13,-12}},
        rotation=270,
        origin={214,15})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_after(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-13,13},{13,-13}},
        rotation=270,
        origin={215,-65})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_003a(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{18,64},{42,88}})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster pump(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_input=true,
    p_nominal=system.p_ambient + 1e4)
    annotation (Placement(transformation(extent={{-4,-154},{-20,-138}})));
  Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=pump.port_a.p +
        2.0e4)
    annotation (Placement(transformation(extent={{24,-140},{-2,-116}})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_012(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={56,-182})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_009(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={92,-144})));
  Fluid.Pipes.NonLinear_Break nonLinear_Break(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{6,-8},{-6,8}},
        rotation=270,
        origin={56,-226})));
  Fluid.Pipes.NonLinear_Break nonLinear_Break2(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{6,-8},{-6,8}},
        rotation=0,
        origin={6,-146})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_001(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{-24,-154},{-42,-138}})));
  TRANSFORM.Fluid.Valves.ValveLinear ValveFl(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={-54,-146})));
  Fluid.Pipes.NonLinear_Break nonLinear_Break1(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{-6,-8},{6,8}},
        rotation=0,
        origin={-62,-106})));
  Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand2(y=1/
        FM_001.Medium.density_ph(FM_001.port_b.p, FM_001.port_b.h_outflow))
    annotation (Placement(transformation(extent={{28,12},{-28,-12}},
        rotation=90,
        origin={-36,2})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-50,-76},{-70,-56}})));
  Modelica.Blocks.Sources.RealExpression Q_GHX(y=Glycol_HX.port_a_shell.m_flow*
        (Chiller_Mass_flow_T66.port_b.h_outflow - Glycol_HX.port_b_shell.h_outflow))
    annotation (Placement(transformation(extent={{64,-218},{102,-196}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_005(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,12},{10,-12}},
        rotation=270,
        origin={56,-160})));
  Fluid.Pipes.NonLinear_Break nonLinear_Break3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{6,-8},{-6,8}},
        rotation=0,
        origin={112,-144})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=10,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{-26,-114},{-10,-98}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe5(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=4,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{80,40},{66,54}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe6(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=10,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689))
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=180,
        origin={68,-88})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_008(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=100,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=90,
        origin={198,-170})));
  Modelica.Fluid.Pipes.DynamicPipe pipe8(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=7,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=10, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={148,-180})));
  Modelica.Fluid.Pipes.DynamicPipe pipe9(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={98,-106})));
  Modelica.Fluid.Pipes.DynamicPipe pipe10(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=100, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={100,48})));
  Modelica.Blocks.Math.Gain W_heater(k=1)
    annotation (Placement(transformation(extent={{-114,114},{-100,128}})));
equation
  connect(pipe4.port_b, TC_002.port_a)
    annotation (Line(points={{-103,-38},{-104,-38},{-104,74},{-102,74},{-102,73},
          {-98,73}},                                       color={0,127,255}));
  connect(TC_002.port_b, Chromolox_Heater.port_a)
    annotation (Line(points={{-74,73},{-74,74},{-66,74}}, color={0,127,255}));
  connect(Chromolox_Heater.port_b, TC_003.port_a)
    annotation (Line(points={{-50,74},{-40,74}}, color={0,127,255}));
  connect(TC_003.port_b, tank1.port_a) annotation (Line(points={{-16,74},{-16,
          75.2},{-3.6,75.2}},
                        color={0,127,255}));
  connect(pipe2.port_b,PV_049. port_a)
    annotation (Line(points={{62,76},{84,76},{84,72}}, color={0,127,255}));
  connect(PV_050.port_a, sensor_m_flow2.port_a) annotation (Line(points={{176,72},
          {176,76},{214,76},{214,58}}, color={0,127,255}));
  connect(PV_006.port_b, sensor_m_flow2.port_a)
    annotation (Line(points={{138,76},{214,76},{214,58}}, color={0,127,255}));
  connect(PV_052.port_a, FM_202.port_b) annotation (Line(points={{182,-128},{
          182,-105},{171,-105}},        color={0,127,255}));
  connect(PV_004.port_a, FM_003.port_a) annotation (Line(points={{-96,-146},{
          -103,-146},{-103,-107}},        color={0,127,255}));
  connect(PV_050.port_b, sensor_m_flow3.port_b)
    annotation (Line(points={{176,60},{176,47},{168,47}},
                                                 color={0,127,255}));
  connect(Chiller_Mass_Flow.ports[1], Glycol_HX.port_a_tube) annotation (Line(
        points={{50,-238},{50,-239},{77,-239}},           color={0,127,255}));
  connect(Glycol_HX.port_b_tube, Ethylene_glycol_exit_temperature.port_a)
    annotation (Line(points={{108,-239},{108,-240},{140,-240}},           color=
         {0,127,255}));
  connect(Ethylene_glycol_exit_temperature.port_b, boundary1.ports[1])
    annotation (Line(points={{170,-240},{190,-240}}, color={0,127,255}));
  connect(realExpression.y, boundary3.Q_flow_ext)
    annotation (Line(points={{-99,98},{-92,98},{-92,92},{-80,92}},
                                                 color={0,0,127}));
  connect(boundary3.port, Chromolox_Heater.heatPorts[:, 1])
    annotation (Line(points={{-66,92},{-58,92},{-58,78}}, color={191,0,0}));
  connect(realExpression.y, chromoloxHeater_Power.u) annotation (Line(points={{-99,98},
          {-92,98},{-92,120},{-79.2,120}},                         color={0,0,
          127}));
  connect(sensor_m_flow3.port_a, T_discharge_outlet.port_b)
    annotation (Line(points={{146,47},{136,47}}, color={0,127,255}));
  connect(m_thot.port_b, TC_201.port_a)
    annotation (Line(points={{40,46},{38,46},{38,33}},
                                               color={0,127,255}));
  connect(TC_201.port_b, thermocline_Insulation.port_a)
    annotation (Line(points={{38,9},{38,-2}},           color={0,127,255}));
  connect(FM_202.port_a, T_ch_o.port_a)
    annotation (Line(points={{149,-105},{138,-105}},
                                                   color={0,127,255}));
  connect(TC_202.port_b, thermocline_Insulation.port_b)
    annotation (Line(points={{38,-57},{38,-46}},           color={0,127,255}));
  connect(pipe2.port_b, BOP_Mass_flow.port_a)
    annotation (Line(points={{62,76},{96,76}}, color={0,127,255}));
  connect(BOP_Mass_flow.port_b,PV_006. port_a)
    annotation (Line(points={{116,76},{126,76}}, color={0,127,255}));
  connect(sensor_m_flow2.port_b, T_chiller_before.port_a)
    annotation (Line(points={{214,38},{214,28}}, color={0,127,255}));
  connect(T_chiller_before.port_b, pipe7.port_a)
    annotation (Line(points={{214,2},{214,-10}}, color={0,127,255}));
  connect(pipe7.port_b, T_chiller_after.port_a) annotation (Line(points={{214,-26},
          {214,-52},{215,-52}},      color={0,127,255}));
  connect(T_chiller_after.port_b, pipe3.port_a) annotation (Line(points={{215,-78},
          {214,-78},{214,-144},{212,-144}},
                                       color={0,127,255}));
  connect(tank1.port_b, TC_003a.port_a)
    annotation (Line(points={{7.6,75.2},{7.6,76},{18,76}}, color={0,127,255}));
  connect(TC_003a.port_b, pipe2.port_a)
    annotation (Line(points={{42,76},{46,76}}, color={0,127,255}));
  connect(Heater_BOP_Demand.y, pump.in_p) annotation (Line(points={{-3.3,-128},
          {-12,-128},{-12,-140.16}},
                                 color={0,0,127}));
  connect(Glycol_HX.port_b_shell, nonLinear_Break.port_a) annotation (Line(
        points={{77,-232.1},{56,-232.1},{56,-232}}, color={0,127,255}));
  connect(nonLinear_Break.port_b, PV_012.port_a)
    annotation (Line(points={{56,-220},{56,-188}}, color={0,127,255}));
  connect(TC_006.port_a, nonLinear_Break2.port_a) annotation (Line(points={{16,-145},
          {16,-146},{12,-146}}, color={0,127,255}));
  connect(nonLinear_Break2.port_b, pump.port_a) annotation (Line(points={{0,-146},
          {-4,-146}},                color={0,127,255}));
  connect(PV_009.port_b, TC_006.port_b)
    annotation (Line(points={{86,-144},{40,-145}}, color={0,127,255}));
  connect(FM_001.port_a, pump.port_b)
    annotation (Line(points={{-24,-146},{-20,-146}}, color={0,127,255}));
  connect(PV_004.port_b, ValveFl.port_b)
    annotation (Line(points={{-84,-146},{-60,-146}}, color={0,127,255}));
  connect(ValveFl.port_a, FM_001.port_b)
    annotation (Line(points={{-48,-146},{-42,-146}}, color={0,127,255}));
  connect(nonLinear_Break1.port_a,PV_004. port_b) annotation (Line(points={{-68,
          -106},{-78,-106},{-78,-146},{-84,-146}}, color={0,127,255}));
  connect(FM_001.m_flow, product1.u2) annotation (Line(points={{-33,-143.12},{
          -36,-143.12},{-36,-72},{-48,-72}},
                  color={0,0,127}));
  connect(Heater_BOP_Demand2.y, product1.u1) annotation (Line(points={{-36,
          -28.8},{-36,-60},{-48,-60}},
                       color={0,0,127}));
  connect(Glycol_HX.port_a_shell, TC_004.port_a) annotation (Line(points={{108,
          -232.1},{124,-232.1},{124,-232}},
                                    color={0,127,255}));
  connect(PV_012.port_b, TC_005.port_b)
    annotation (Line(points={{56,-176},{56,-170}}, color={0,127,255}));
  connect(TC_005.port_a, TC_006.port_b) annotation (Line(points={{56,-150},{56,
          -145},{40,-145}},
                      color={0,127,255}));
  connect(Chiller_Mass_flow_T66.port_b, TC_004.port_b) annotation (Line(points={
          {124.5,-209},{126,-209},{126,-212},{124,-212},{124,-214}}, color={0,127,
          255}));
  connect(nonLinear_Break3.port_b, PV_009.port_a) annotation (Line(points={{106,
          -144},{98,-144}},                       color={0,127,255}));
  connect(pipe1.port_a, nonLinear_Break1.port_b) annotation (Line(points={{-26,
          -106},{-56,-106}},                     color={0,127,255}));
  connect(pipe1.port_b, FM_201.port_a)
    annotation (Line(points={{-10,-106},{12,-106}},color={0,127,255}));
  connect(FM_201.port_b, PV_051.port_b)
    annotation (Line(points={{36,-106},{50,-106}}, color={0,127,255}));
  connect(TC_202.port_a, pipe6.port_b)
    annotation (Line(points={{38,-81},{38,-88},{62,-88}},
                                                 color={0,127,255}));
  connect(pipe6.port_a,PV_051. port_a)
    annotation (Line(points={{74,-88},{74,-106},{62,-106}},
                                                  color={0,127,255}));
  connect(pipe3.port_b, nonLinear_Break3.port_a)
    annotation (Line(points={{200,-144},{118,-144}}, color={0,127,255}));
  connect(PV_008.port_a, pipe3.port_b) annotation (Line(points={{198,-164},{198,
          -144},{200,-144}}, color={0,127,255}));
  connect(pipe8.port_b, Chiller_Mass_flow_T66.port_a) annotation (Line(points={{
          142,-180},{124.5,-180},{124.5,-190}}, color={0,127,255}));
  connect(PV_052.port_b, pipe8.port_a) annotation (Line(points={{182,-140},{182,
          -180},{154,-180}}, color={0,127,255}));
  connect(PV_008.port_b, pipe8.port_a) annotation (Line(points={{198,-176},{198,
          -180},{154,-180}}, color={0,127,255}));
  connect(PV_051.port_a, pipe9.port_a) annotation (Line(points={{62,-106},{92,
          -106}},     color={0,127,255}));
  connect(pipe9.port_b, T_ch_o.port_b) annotation (Line(points={{104,-106},{114,
          -106},{114,-105}},              color={0,127,255}));
  connect(pipe5.port_b, m_thot.port_a)
    annotation (Line(points={{66,47},{66,46},{60,46}}, color={0,127,255}));
  connect(PV_049.port_b, pipe5.port_a) annotation (Line(points={{84,60},{84,47},
          {80,47}},                    color={0,127,255}));
  connect(T_discharge_outlet.port_a, pipe10.port_b) annotation (Line(points={{112,47},
          {112,48},{106,48}},                    color={0,127,255}));
  connect(pipe10.port_a, pipe5.port_a) annotation (Line(points={{94,48},{94,47},
          {80,47}},           color={0,127,255}));
  connect(ActuatorSubBus,
    control_System_Therminol_4_element_all_modes_ExpTest3_1.ActuatorSubBus)
    annotation (Line(
      points={{-19,142},{29.3333,142},{29.3333,154.15}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(SensorSubBus, control_System_Therminol_4_element_all_modes_ExpTest3_1.SensorSubBus)
    annotation (Line(
      points={{-61,142},{19.4667,142},{19.4667,154.15}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActuatorSubBus.PV008, PV_008.opening) annotation (Line(
      points={{-19,142},{240,142},{240,-168},{222,-168},{222,-170},{202.8,-170}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(ActuatorSubBus.PV004, PV_004.opening) annotation (Line(
      points={{-19,142},{-160,142},{-160,-260},{-90,-260},{-90,-150.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(SensorSubBus.TC006, TC_006.T) annotation (Line(
      points={{-61,142},{-160,142},{-160,-210},{28,-210},{28,-149.68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActuatorSubBus.PV012, PV_012.opening) annotation (Line(
      points={{-19,142},{240,142},{240,-260},{-18,-260},{-18,-182},{51.2,-182}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActuatorSubBus.PV009, PV_009.opening) annotation (Line(
      points={{-19,142},{240,142},{240,-158},{92,-158},{92,-148.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));

  connect(SensorSubBus.Volume_flow_rate, product1.y) annotation (Line(
      points={{-61,142},{-160,142},{-160,-66},{-71,-66}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActuatorSubBus.Valve_fl, ValveFl.opening) annotation (Line(
      points={{-19,142},{-160,142},{-160,-260},{-54,-260},{-54,-150.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActuatorSubBus.PV006[1], PV_006.opening) annotation (Line(
      points={{-19,142},{132,142},{132,80.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActuatorSubBus.PV049, PV_049.opening) annotation (Line(
      points={{-19,142},{74,142},{74,66},{79.2,66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActuatorSubBus.PV049, PV_052.opening) annotation (Line(
      points={{-19,142},{240,142},{240,-134},{186.8,-134}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ActuatorSubBus.PV050[1], PV_050.opening) annotation (Line(
      points={{-19,142},{208,142},{208,66},{180.8,66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ActuatorSubBus.PV051, PV_051.opening) annotation (Line(
      points={{-19,142},{240,142},{240,-124},{56,-124},{56,-110.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(SensorSubBus.TC003, TC_003.T) annotation (Line(
      points={{-61,142},{-28,142},{-28,78.32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActuatorSubBus.W_heater, W_heater.u) annotation (Line(
      points={{-19,142},{-128,142},{-128,121},{-115.4,121}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ActuatorSubBus.M_dot_glycol, Chiller_Mass_Flow.m_flow_in) annotation (
     Line(
      points={{-19,142},{240,142},{240,-260},{-18,-260},{-18,-230},{30,-230}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(FM_003.port_b, pipe4.port_a)
    annotation (Line(points={{-103,-89},{-103,-56}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-260},{240,140}}),
                    graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-156,-208},{232,138}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-24,68},{176,-30},{-24,-150},{-24,68}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-260},{240,
            140}})),
    experiment(
      StopTime=16000,
      Interval=10,
      Tolerance=0.001,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_Commands(file="../../TEDS/Basic_TEDS_setup.mos" "Basic_TEDS_setup",
        file="../../TEDS/M3_TEDS.mos" "M3_TEDS"),
    conversion(noneFromVersion=""));
end TEDSloop_UpdatedLayout_ExpTestInputs;
