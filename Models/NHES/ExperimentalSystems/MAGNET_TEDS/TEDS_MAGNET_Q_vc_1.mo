within NHES.ExperimentalSystems.MAGNET_TEDS;
model TEDS_MAGNET_Q_vc_1
  "Test designed to ensure the TEDS loop can operate in all modes."

package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
package Medium_cw = Modelica.Media.Water.StandardWater;
package Medium_TEDS =
      TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C;

  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689),
    T_start=data.T_hot_side)
    annotation (Placement(transformation(extent={{46,68},{62,84}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe4(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689),
    T_start=data.T_cold_side)
                    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={-123,-75})));
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
    level_start=0)
    annotation (Placement(transformation(extent={{-6,72},{10,88}})));
  inner TRANSFORM.Fluid.System
                        system(
    p_ambient=18000,
    T_ambient=498.15,
    m_flow_start=0.84)
    annotation (Placement(transformation(extent={{220,120},{240,140}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    T_start=data.T_cold_side,                                         precision=
       3)
    annotation (Placement(transformation(extent={{-12,-11},{12,11}},
        rotation=90,
        origin={-122,-39})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort MAGNET_TEDS_HX_exit_Temp(
      redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_hot_side,
      precision=3)
    annotation (Placement(transformation(extent={{-22,34},{2,58}})));
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
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
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
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_cold_side,                                         precision=
       3) annotation (Placement(transformation(extent={{-62,-154},{-80,-138}})));
  Systems.Experiments.TEDS.Control_Systems.Control_System_Therminol_4_element_all_modes
    control_System_Therminol_4_element_all_modes(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_hot_design=598.15,
    T_cold_design=498.15)
    annotation (Placement(transformation(extent={{20,118},{42,140}})));
  Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus
    annotation (Placement(transformation(extent={{-42,94},{-20,118}})));
  Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
    annotation (Placement(transformation(extent={{-10,94},{12,118}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={154,40})));
  Systems.Experiments.TEDS.ThermoclineModels.Thermocline_Insulation thermocline_Insulation(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    redeclare package InsulationMaterial = NHES.Media.Solids.FoamGlass,
    geometry(
      Radius_Tank=0.438,
      Porosity=0.5,
      dr=0.00317,
      Insulation_thickness=3*0.051,
      Wall_Thickness=0.019,
      Height_Tank=4.435))
    annotation (Placement(transformation(extent={{102,-50},{134,-6}})));
  TRANSFORM.Controls.LimPID MassFlow_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1,
    Ti=5,
    k_s=2*5e-1,
    k_m=2*5e-1,
    yMax=30,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=9.7)
    annotation (Placement(transformation(extent={{-6,-194},{-18,-182}})));
  Modelica.Blocks.Sources.Constant const1(k=
        control_System_Therminol_4_element_all_modes.T_cold_design) annotation (
     Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={12,-184})));
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
    T_a_start_shell=data.T_hot_side,
    T_b_start_shell=data.T_cold_side,
    p_b_start_tube=boundary1.p,
    counterCurrent=true,
    m_flow_a_start_tube=Chiller_Mass_Flow.m_flow,
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
  Modelica.Blocks.Sources.Constant const(k=
        control_System_Therminol_4_element_all_modes.T_hot_design) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-144,70})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_charge_outlet(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=90,
        origin={154,-63})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_Charge_Inlet(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
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
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_hot_side,                                          precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={106,76})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_inlet_HX(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-10,12},{10,-12}},
        rotation=0,
        origin={146,-142})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_before(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-13,12},{13,-12}},
        rotation=270,
        origin={228,15})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_after(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-13,13},{13,-13}},
        rotation=270,
        origin={227,-65})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_after_tank(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_hot_side,                                          precision=
       3) annotation (Placement(transformation(extent={{18,64},{42,88}})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster pump(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_input=true,
    p_nominal=system.p_ambient + 1e4)
    annotation (Placement(transformation(extent={{14,-138},{-2,-154}})));
  Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=pump.port_a.p +
        2.0e4)
    annotation (Placement(transformation(extent={{-54,-180},{-32,-158}})));
  MAGNET.Data.Data_base_An data
    annotation (Placement(transformation(extent={{-142,120},{-122,140}})));
  Modelica.Blocks.Sources.RealExpression Heat_from_MAGNET(y=
        MAGNET_TEDS_simpleHX.Q_flow)
    annotation (Placement(transformation(extent={{-94,96},{-74,116}})));
  inner TRANSFORM.Fluid.SystemTF systemTF
    annotation (Placement(transformation(extent={{-208,118},{-188,138}})));
  TRANSFORM.Controls.LimPID MAGNET_flow_control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    with_FF=true,
    derMeas=true,
    k=0.1,
    Ti=10,
    Td=10,
    k_s=1,
    k_m=1,
    k_ff=-0.1,
    yMax=400,
    yMin=0.00001,
    wp=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    y_start=data.Q_vc*1e-3)
    annotation (Placement(transformation(extent={{-118,76},{-106,64}})));
  Modelica.Blocks.Sources.Step step1(
    height=0,
    offset=data.m_flow,
    startTime=5000)
    annotation (Placement(transformation(extent={{-418,-176},{-398,-156}})));
public
  MAGNET.Data.Summary                          summary(
    Ts={sensor_cw_hx.T,sensor_rp_hx_2.T,sensor_hx_co.T,pT_co_rp_1.T,
        pT_rp_hx_1.T,pT_vc_pipe_rp.T,pT_rp_pipe_vc.T,pT_vc_pipe.T},
    ps={sensor_cw_hx.p,sensor_rp_hx_2.p,sensor_hx_co.p,pT_co_rp_1.p,
        pT_rp_hx_1.p,pT_vc_pipe_rp.p,pT_rp_pipe_vc.p,pT_vc_pipe.p},
    m_flows={sensor_co_rp_2.m_flow,m_flow_vc_TEDS.m_flow},
    Q_flows={vc.Q_gen/1e3})
    annotation (Placement(transformation(extent={{-176,120},{-156,140}})));
protected
  TRANSFORM.HeatExchangers.Simple_HX MAGNET_TEDS_simpleHX(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    nV=10,
    V_1=1,
    V_2=1,
    UA=1490.4333,
    p_a_start_1=data.p_vc_rp + 100,
    p_b_start_1=data.p_vc_rp,
    T_a_start_1=data.T_vc_rp,
    T_b_start_1=773.15,
    m_flow_start_1=data.m_flow,
    p_a_start_2=data.p_TEDS_in,
    p_b_start_2=data.p_TEDS_out,
    T_a_start_2=data.T_cold_side,
    T_b_start_2=data.T_hot_side,
    m_flow_start_2=0.689)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
protected
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Medium_cw,
    p=data.p_hx_cw,
    T=data.T_hx_cw,
    nPorts=1)
    annotation (Placement(transformation(extent={{-242,-108},{-262,-88}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_cw(
    redeclare package Medium = Medium_cw,
    p_start=data.p_hx_cw,
    T_start=data.T_hx_cw,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-322,-108},{-302,-88}})));
  TRANSFORM.HeatExchangers.Simple_HX hx(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 = Medium_cw,
    nV=10,
    V_1=1,
    V_2=1,
    UA=data.UA_hx,
    p_a_start_1=data.p_rp_hx,
    p_b_start_1=data.p_hx_co,
    T_a_start_1=data.T_rp_hx,
    T_b_start_1=data.T_hx_co,
    m_flow_start_1=data.m_flow,
    p_a_start_2=data.p_cw_hx,
    p_b_start_2=data.p_hx_cw,
    T_a_start_2=data.T_cw_hx,
    T_b_start_2=data.T_hx_cw,
    m_flow_start_2=data.m_flow_cw,
    R_1=-data.dp_hx_hot/data.m_flow)
    annotation (Placement(transformation(extent={{-352,-110},{-332,-130}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_cw_hx(
    redeclare package Medium = Medium_cw,
    p_start=data.p_cw_hx,
    T_start=data.T_cw_hx,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-386,-106},{-366,-86}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Medium_cw,
    m_flow=data.m_flow_cw,
    T=data.T_cw_hx,
    nPorts=1)
    annotation (Placement(transformation(extent={{-468,-106},{-448,-86}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_hx_2(
    redeclare package Medium = Medium,
    p_start=data.p_rp_hx,
    T_start=data.T_rp_hx,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-298,-146},{-318,-126}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_co(
    redeclare package Medium = Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-364,-146},{-384,-126}})));
  TRANSFORM.Fluid.Valves.ValveIncompressible valve_ps(
    redeclare package Medium = Medium,
    dp_nominal(displayUnit="Pa") = 1e4,
    m_flow_nominal=1,
    opening_nominal=0.5)
    annotation (Placement(transformation(extent={{-466,-146},{-446,-126}})));
  Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
    annotation (Placement(transformation(extent={{-500,-126},{-480,-106}})));
  TRANSFORM.HeatExchangers.Simple_HX  rp(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 = Medium,
    nV=10,
    V_1=1,
    V_2=1,
    UA=data.UA_rp,
    p_a_start_1=data.p_vc_rp,
    p_b_start_1=data.p_rp_hx,
    T_a_start_1=data.T_vc_rp,
    T_b_start_1=data.T_rp_hx,
    m_flow_start_1=data.m_flow,
    p_a_start_2=data.p_co_rp,
    p_b_start_2=data.p_rp_vc,
    T_a_start_2=data.T_co_rp,
    T_b_start_2=data.T_rp_vc,
    m_flow_start_2=data.m_flow,
    R_1=-data.dp_rp_hot/data.m_flow,
    R_2=-data.dp_rp_cold/data.m_flow)
    annotation (Placement(transformation(extent={{-352,-52},{-332,-32}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_co_rp_1(
    redeclare package Medium = Medium,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    precision2=1,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-272,-68},{-292,-48}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_hx_1(
    redeclare package Medium = Medium,
    p_start=data.p_rp_hx,
    T_start=data.T_rp_hx,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-294,-32},{-274,-12}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_pipe_rp(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-386,-30},{-366,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_pipe_vc(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-388,-70},{-408,-50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_pipe(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-516,-30},{-496,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_pipe_vc(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-462,-70},{-482,-50}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume vc(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.1),
    Q_gen=MAGNET_flow_control.y*1e3)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-534,-50})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow)
                                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-534,-32})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume_co(
    redeclare package Medium = Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.01),
    Q_gen=0)      "12022.6"
                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-362,-200})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_co_rp_2(
    redeclare package Medium = Medium,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=2)
    annotation (Placement(transformation(extent={{-298,-210},{-278,-190}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ps(
    redeclare package Medium = Medium,
    p=data.p_hx_co,
    T=data.T_ps,
    nPorts=1)
    annotation (Placement(transformation(extent={{-536,-146},{-516,-126}})));
protected
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_TEDS(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-455,21})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_TEDS_rp(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{7,7},{-7,-7}},
        rotation=90,
        origin={-399,77})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_rp(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-423,-21})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
    redeclare package Medium = Medium,
    p_a_start=data.p_hx_co,
    T_a_start=data.T_hx_co,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_hx_co, length=data.length_hx_co))
    annotation (Placement(transformation(extent={{-416,-210},{-396,-190}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
    redeclare package Medium = Medium,
    p_a_start=data.p_co_rp,
    T_a_start=data.T_co_rp,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_co_rp, length=data.length_co_rp))
    annotation (Placement(transformation(extent={{-250,-210},{-230,-190}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled co(
    redeclare package Medium = Medium,
    p_a_start=data.p_hx_co,
    p_b_start=data.p_co_rp,
    T_a_start=data.T_hx_co,
    T_b_start=data.T_co_rp,
    m_flow_start=data.m_flow,
    redeclare model EfficiencyChar =
        TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Efficiency.Constant
        (eta_constant=0.7027),
    controlType="m_flow",
    use_port=true)
    annotation (Placement(transformation(extent={{-338,-210},{-318,-190}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_vc_rp(
    ths_wall=fill(data.th_4in_sch40, pipe_vc_rp.geometry.nV),
    ths_insulation=fill(data.th_4in_sch40, pipe_vc_rp.geometry.nV),
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_vc_rp, length=data.length_vc_rp),
    redeclare package Medium = Medium,
    p_a_start=data.p_vc_rp,
    T_a_start=data.T_vc_rp,
    m_flow_a_start=data.m_flow,
    redeclare package Material_wall = TRANSFORM.Media.Solids.SS316)
    annotation (Placement(transformation(extent={{-482,-30},{-462,-10}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_vc(
    ths_wall=fill(data.th_4in_sch40, pipe_vc_rp.geometry.nV),
    ths_insulation=fill(data.th_4in_sch40, pipe_vc_rp.geometry.nV),
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_rp_vc, length=data.length_rp_vc),
    redeclare package Medium = Medium,
    p_a_start=data.p_rp_vc,
    T_a_start=data.T_rp_vc,
    m_flow_a_start=data.m_flow)
    annotation (Placement(transformation(extent={{-426,-70},{-446,-50}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_hx(
    ths_wall=fill(data.th_4in_sch40, pipe_vc_rp.geometry.nV),
    ths_insulation=fill(data.th_4in_sch40, pipe_vc_rp.geometry.nV),
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_rp_hx, length=data.length_rp_hx),
    redeclare package Medium = Medium,
    p_a_start=data.p_rp_hx,
    T_a_start=data.T_rp_hx,
    m_flow_a_start=data.m_flow)
    annotation (Placement(transformation(extent={{-252,-146},{-272,-126}})));
  Modelica.Blocks.Sources.Constant opening_valve_tank2(k=1)
    annotation (Placement(transformation(extent={{-354,44},{-374,64}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort T_vc_TEDS(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-456,54})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_TEDS_rp(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-398,4})));
  TRANSFORM.Fluid.Sensors.MassFlowRate m_flow_vc_TEDS(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-456,88})));
  Modelica.Blocks.Sources.Constant opening_valve_tank1(k=1)
    annotation (Placement(transformation(extent={{-500,12},{-480,32}})));
  Modelica.Blocks.Sources.Constant opening_valve_tank3(k=0)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=90,
        origin={-424,34})));
equation
  connect(pipe4.port_b, sensor_T.port_a)
    annotation (Line(points={{-123,-66},{-123,-58.5},{-122,-58.5},{-122,-51}},
                                                         color={0,127,255}));
  connect(MAGNET_TEDS_HX_exit_Temp.port_b, tank1.port_a) annotation (Line(
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
  connect(sensor_m_flow5.port_b, pipe4.port_a) annotation (Line(points={{-80,-146},
          {-123,-146},{-123,-84}},
                               color={0,127,255}));
  connect(sensorSubBus.Valve_1_Opening, Valve1.opening) annotation (Line(
      points={{1,106},{26,106},{26,56},{79.2,56}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(control_System_Therminol_4_element_all_modes.actuatorSubBus,
    actuatorSubBus) annotation (Line(
      points={{30.7067,118.092},{30.7067,106},{-31,106}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(control_System_Therminol_4_element_all_modes.sensorSubBus,
    sensorSubBus) annotation (Line(
      points={{36.1333,118.092},{36.1333,106},{1,106}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Valve_2_Opening, Valve2.opening) annotation (Line(
      points={{1,106},{132,106},{132,80.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorSubBus.Valve_3_Opening, Valve3.opening) annotation (Line(
      points={{1,106},{170,106},{170,66},{158.8,66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorSubBus.Valve_4_Opening, valve4.opening) annotation (Line(
      points={{1,106},{202,106},{202,-128},{186.8,-128}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorSubBus.Valve_5_Opening, Valve5.opening) annotation (Line(
      points={{1,106},{26,106},{26,-116},{75.2,-116}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorSubBus.Valve_6_Opening, Valve6.opening) annotation (Line(
      points={{1,106},{26,106},{26,-116},{-38,-116},{-38,-141.2}},
      color={239,82,82},
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
  connect(Chiller_Mass_Flow.ports[1], Glycol_HX.port_a_tube) annotation (Line(
        points={{50,-214},{56,-214},{56,-149},{61,-149}}, color={0,127,255}));
  connect(Glycol_HX.port_b_tube, Ethylene_glycol_exit_temperature.port_a)
    annotation (Line(points={{92,-149},{104,-149},{104,-188},{128,-188}}, color=
         {0,127,255}));
  connect(Ethylene_glycol_exit_temperature.port_b, boundary1.ports[1])
    annotation (Line(points={{158,-188},{180,-188}}, color={0,127,255}));
  connect(MassFlow_Control.y, Chiller_Mass_Flow.m_flow_in) annotation (Line(
        points={{-18.6,-188},{-22,-188},{-22,-206},{30,-206}}, color={0,0,127}));
  connect(Chiller_Mass_flow_T66.port_b, Glycol_HX.port_a_shell) annotation (
      Line(points={{106,-142},{92,-142},{92,-142.1}}, color={0,127,255}));
  connect(Glycol_HX.port_b_shell, HX_exit_temperature_T66.port_b) annotation (
      Line(points={{61,-142.1},{48,-142.1},{48,-145}}, color={0,127,255}));
  connect(MassFlow_Control.u_m, HX_exit_temperature_T66.T) annotation (Line(
        points={{-12,-195.2},{-12,-196},{36,-196},{36,-149.68}}, color={0,0,127}));
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
  connect(actuatorSubBus.T_discharge_outlet, T_discharge_outlet.T) annotation (
      Line(
      points={{-31,106},{202,106},{202,9},{158.68,9}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.T_discharge_inlet, T_discharge_Inlet.T) annotation (
      Line(
      points={{-31,106},{26,106},{26,-63},{75.32,-63}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.T_charge_outlet, T_charge_outlet.T) annotation (Line(
      points={{-31,106},{202,106},{202,-63},{158.68,-63}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.T_charge_inlet, T_Charge_Inlet.T) annotation (Line(
      points={{-31,106},{26,106},{26,7},{79.32,7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Charging_flowrate, sensor_m_flow6.m_flow) annotation (
      Line(
      points={{-31,106},{202,106},{202,-101},{157.6,-101}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Discharge_FlowRate, sensor_m_flow3.m_flow) annotation (
     Line(
      points={{-31,106},{202,106},{202,40},{157.6,40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Total_Mass_Flow_System, Chiller_Mass_flow_T66.m_flow)
    annotation (Line(
      points={{-31,106},{240,106},{240,-160},{119,-160},{119,-145.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Heater_flowrate, sensor_m_flow5.m_flow) annotation (
      Line(
      points={{-31,106},{26,106},{26,-116},{-71,-116},{-71,-143.12}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(pipe2.port_b, BOP_Mass_flow.port_a)
    annotation (Line(points={{62,76},{96,76}}, color={0,127,255}));
  connect(BOP_Mass_flow.port_b, Valve2.port_a)
    annotation (Line(points={{116,76},{126,76}}, color={0,127,255}));
  connect(actuatorSubBus.heater_BOP_massflow, BOP_Mass_flow.m_flow) annotation (
     Line(
      points={{-31,106},{106,106},{106,79.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
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
  connect(Heater_BOP_Demand.y, pump.in_p) annotation (Line(points={{-30.9,-169},
          {6,-169},{6,-151.84}}, color={0,0,127}));
  connect(MAGNET_TEDS_simpleHX.port_a2, MAGNET_TEDS_HX_exit_Temp.port_a)
    annotation (Line(points={{-70,46},{-22,46}},                   color={0,
          127,255}));
  connect(MAGNET_TEDS_simpleHX.port_b2, sensor_T.port_b) annotation (Line(
        points={{-90,46},{-122,46},{-122,-27}}, color={0,127,255}));
  connect(actuatorSubBus.Heater_Input, Heat_from_MAGNET.y) annotation (Line(
      points={{-31,106},{-73,106}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, MAGNET_flow_control.u_s)
    annotation (Line(points={{-137.4,70},{-119.2,70}}, color={0,0,127}));
  connect(MAGNET_TEDS_HX_exit_Temp.T, MAGNET_flow_control.u_m) annotation (
      Line(points={{-10,50.32},{-10,86},{-112,86},{-112,77.2}}, color={0,0,
          127}));
  connect(sensor_hx_cw.port_b,boundary. ports[1])
    annotation (Line(points={{-302,-98},{-262,-98}},
                                               color={0,127,255}));
  connect(hx.port_a2,sensor_hx_cw. port_a) annotation (Line(points={{-332,
          -116},{-326,-116},{-326,-98},{-322,-98}},
                                  color={0,127,255}));
  connect(sensor_cw_hx.port_b,hx. port_b2) annotation (Line(points={{-366,-96},
          {-358,-96},{-358,-116},{-352,-116}},
                                  color={0,127,255}));
  connect(boundary2.ports[1],sensor_cw_hx. port_a)
    annotation (Line(points={{-448,-96},{-386,-96}},
                                                  color={0,127,255}));
  connect(sensor_rp_hx_2.port_b,hx. port_b1) annotation (Line(points={{-318,
          -136},{-326,-136},{-326,-124},{-332,-124}},
                                          color={0,127,255}));
  connect(hx.port_a1,sensor_hx_co. port_a) annotation (Line(points={{-352,
          -124},{-358,-124},{-358,-136},{-364,-136}},
                                         color={0,127,255}));
  connect(sensor_hx_co.port_b,valve_ps. port_b)
    annotation (Line(points={{-384,-136},{-446,-136}},
                                                    color={0,127,255}));
  connect(opening_valve_tank.y,valve_ps. opening) annotation (Line(points={{-479,
          -116},{-418,-116},{-418,-128},{-456,-128}},
                                       color={0,0,127}));
  connect(pT_co_rp_1.port_b,rp. port_a2) annotation (Line(points={{-292,-58},
          {-324,-58},{-324,-46},{-332,-46}},
                                  color={0,127,255}));
  connect(pT_vc_pipe_rp.port_b,rp. port_a1) annotation (Line(points={{-366,
          -20},{-358,-20},{-358,-38},{-352,-38}},
                                       color={0,127,255}));
  connect(rp.port_b1,pT_rp_hx_1. port_a) annotation (Line(points={{-332,-38},
          {-302,-38},{-302,-22},{-294,-22}},
                               color={0,127,255}));
  connect(rp.port_b2,pT_rp_pipe_vc. port_a) annotation (Line(points={{-352,
          -46},{-382,-46},{-382,-60},{-388,-60}},
                                       color={0,127,255}));
  connect(pT_pipe_vc.port_b,vc. port_a) annotation (Line(points={{-482,-60},{
          -534,-60},{-534,-56}},
                          color={0,127,255}));
  connect(vc.port_b,resistance. port_a)
    annotation (Line(points={{-534,-44},{-534,-39}},
                                                   color={0,127,255}));
  connect(pT_vc_pipe.port_a,resistance. port_b) annotation (Line(points={{-516,
          -20},{-534,-20},{-534,-25}},   color={0,127,255}));
  connect(ps.ports[1],valve_ps. port_a) annotation (Line(points={{-516,-136},
          {-466,-136}},                color={0,127,255}));
  connect(pipe_hx_co.port_b,volume_co. port_a)
    annotation (Line(points={{-396,-200},{-368,-200}},
                                                   color={0,127,255}));
  connect(pipe_hx_co.port_a,valve_ps. port_b) annotation (Line(points={{-416,
          -200},{-434,-200},{-434,-136},{-446,-136}},
                                                  color={0,127,255}));
  connect(sensor_co_rp_2.port_b,pipe_co_rp. port_a)
    annotation (Line(points={{-278,-200},{-250,-200}},
                                                 color={0,127,255}));
  connect(pipe_co_rp.port_b,pT_co_rp_1. port_a) annotation (Line(points={{-230,
          -200},{-216,-200},{-216,-58},{-272,-58}},
                                          color={0,127,255}));
  connect(volume_co.port_b,co. port_a)
    annotation (Line(points={{-356,-200},{-338,-200}},
                                                   color={0,127,255}));
  connect(co.port_b,sensor_co_rp_2. port_a)
    annotation (Line(points={{-318,-200},{-298,-200}},
                                                 color={0,127,255}));
  connect(pipe_vc_rp.port_a,pT_vc_pipe. port_b)
    annotation (Line(points={{-482,-20},{-496,-20}},
                                                   color={0,127,255}));
  connect(pT_pipe_vc.port_a,pipe_ins_rp_vc. port_b)
    annotation (Line(points={{-462,-60},{-446,-60}},
                                                   color={0,127,255}));
  connect(pT_rp_pipe_vc.port_b,pipe_ins_rp_vc. port_a)
    annotation (Line(points={{-408,-60},{-426,-60}},
                                                   color={0,127,255}));
  connect(sensor_rp_hx_2.port_a,pipe_ins_rp_hx. port_b)
    annotation (Line(points={{-298,-136},{-272,-136}},
                                                color={0,127,255}));
  connect(pipe_ins_rp_hx.port_a,pT_rp_hx_1. port_b) annotation (Line(points={{-252,
          -136},{-230,-136},{-230,-22},{-274,-22}},
                                              color={0,127,255}));
  connect(T_vc_TEDS.port_b,m_flow_vc_TEDS. port_a)
    annotation (Line(points={{-456,64},{-456,78}},   color={0,127,255}));
  connect(T_vc_TEDS.port_a,valve_vc_TEDS. port_b) annotation (Line(points={{-456,44},
          {-456,33},{-455,33},{-455,28}},              color={0,127,255}));
  connect(valve_vc_TEDS.port_a,pipe_vc_rp. port_b) annotation (Line(points={{-455,14},
          {-454,14},{-454,-20},{-462,-20}},          color={0,127,255}));
  connect(opening_valve_tank1.y,valve_vc_TEDS. opening) annotation (Line(
        points={{-479,22},{-469.8,22},{-469.8,21},{-460.6,21}},     color={0,
          0,127}));
  connect(opening_valve_tank2.y,valve_TEDS_rp. opening) annotation (Line(
        points={{-375,54},{-386,54},{-386,77},{-393.4,77}},
                                                    color={0,0,127}));
  connect(valve_TEDS_rp.port_b,pT_TEDS_rp. port_a) annotation (Line(points={{-399,70},
          {-399,42},{-398,42},{-398,14}},              color={0,127,255}));
  connect(valve_vc_rp.port_a,pipe_vc_rp. port_b) annotation (Line(points={{-430,
          -21},{-447,-21},{-447,-20},{-462,-20}},  color={0,127,255}));
  connect(valve_vc_rp.port_b,pT_vc_pipe_rp. port_a) annotation (Line(points={{-416,
          -21},{-409,-21},{-409,-20},{-386,-20}},  color={0,127,255}));
  connect(pT_TEDS_rp.port_b,pT_vc_pipe_rp. port_a) annotation (Line(points={{-398,-6},
          {-398,-20},{-386,-20}},        color={0,127,255}));
  connect(opening_valve_tank3.y,valve_vc_rp. opening) annotation (Line(points={{-424,
          25.2},{-424,8},{-423,8},{-423,-15.4}},           color={0,0,127}));
  connect(step1.y,co. inputSignal) annotation (Line(points={{-397,-166},{-328,
          -166},{-328,-193}},
                           color={0,0,127}));
  connect(m_flow_vc_TEDS.port_b, MAGNET_TEDS_simpleHX.port_b1) annotation (
      Line(points={{-456,98},{-306,98},{-306,42},{-70,42},{-70,54}}, color={0,
          127,255}));
  connect(MAGNET_TEDS_simpleHX.port_a1, valve_TEDS_rp.port_a) annotation (
      Line(points={{-90,54},{-172,54},{-172,84},{-399,84}}, color={0,127,255}));
  connect(sensor_T.T, MAGNET_flow_control.u_ff) annotation (Line(points={{
          -125.96,-39},{-138,-39},{-138,60},{-119.2,60},{-119.2,65.2}}, color=
         {0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-540,-220},{240,
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
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-540,-220},{
            240,140}})),
    experiment(StopTime=6000, __Dymola_Algorithm="Esdirk45a"),
    __Dymola_Commands(file="../../TEDS/Basic_TEDS_setup.mos" "Basic_TEDS_setup",
        file="../../TEDS/M3_TEDS.mos" "M3_TEDS"));
end TEDS_MAGNET_Q_vc_1;
