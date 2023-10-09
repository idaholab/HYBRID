within NHES.ExperimentalSystems.MAGNET_TEDS;
model MAGNET_TEDS_valve_3
  extends TRANSFORM.Icons.Example;

protected
  inner TRANSFORM.Fluid.SystemTF systemTF(
    showColors=true,
    val_min=data.T_hx_co,
    val_max=data.T_vc_rp)
    annotation (Placement(transformation(extent={{-96,-338},{-76,-318}})));

public
  TRANSFORM.HeatExchangers.Simple_HX MAGNET_TEDS_simpleHX(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    nV=10,
    V_1=1,
    V_2=1,
    UA=data.UA_MAGNET_TEDS,
    p_a_start_1=data.p_vc_rp + 100,
    p_b_start_1=data.p_vc_rp,
    T_a_start_1=data.T_vc_rp,
    T_b_start_1=773.15,
    m_flow_start_1=data.m_flow,
    p_a_start_2=data.p_TEDS_in,
    p_b_start_2=data.p_TEDS_out,
    T_a_start_2=data.T_cold_side,
    T_b_start_2=data.T_hot_side,
    m_flow_start_2=boundary_TEDS_in.m_flow)
    annotation (Placement(transformation(extent={{-30,-40},{-10,-60}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TM_HX_exit_Temp(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3)
    annotation (Placement(transformation(extent={{-78,-36},{-58,-16}})));
protected
  inner TRANSFORM.Fluid.System system(
    p_ambient=18000,
    T_ambient=498.15,
    m_flow_start=0.84)
    annotation (Placement(transformation(extent={{-164,-338},{-144,-318}})));
protected
  NHES.ExperimentalSystems.MAGNET.Data.Data_base_An data
    annotation (Placement(transformation(extent={{-132,-336},{-112,-316}})));
protected
  package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
  package Medium_cw = Modelica.Media.Water.StandardWater;
  package Medium_TEDS =
      TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C;

protected
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary_TEDS_out(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p=data.p_TEDS_out,
    T=data.T_hot_side,
    nPorts=1)
    annotation (Placement(transformation(extent={{-162,-36},{-142,-16}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_TEDS_in(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=data.TEDS_nominal_flow_rate,
    T=data.T_cold_side,
    nPorts=1)
    annotation (Placement(transformation(extent={{76,-32},{56,-12}})));
protected
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Medium_cw,
    p=data.p_hx_cw,
    T=data.T_hx_cw,
    nPorts=1)
    annotation (Placement(transformation(extent={{172,-250},{152,-230}})));
public
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_cw(
    redeclare package Medium = Medium_cw,
    p_start=data.p_hx_cw,
    T_start=data.T_hx_cw,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{92,-250},{112,-230}})));
protected
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
    annotation (Placement(transformation(extent={{62,-252},{82,-272}})));
public
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_cw_hx(
    redeclare package Medium = Medium_cw,
    p_start=data.p_cw_hx,
    T_start=data.T_cw_hx,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{28,-248},{48,-228}})));
protected
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = Medium_cw,
    use_m_flow_in=true,
    m_flow=data.m_flow_cw,
    T=data.T_cw_hx,
    nPorts=1)
    annotation (Placement(transformation(extent={{-54,-248},{-34,-228}})));
public
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_hx_2(
    redeclare package Medium = Medium,
    p_start=data.p_rp_hx,
    T_start=data.T_rp_hx,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{116,-288},{96,-268}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_co(
    redeclare package Medium = Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{50,-288},{30,-268}})));
protected
  TRANSFORM.Fluid.Valves.ValveIncompressible valve_ps(
    redeclare package Medium = Medium,
    dp_nominal(displayUnit="Pa") = 1e4,
    m_flow_nominal=1,
    opening_nominal=0.5)
    annotation (Placement(transformation(extent={{-52,-288},{-32,-268}})));
  Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
    annotation (Placement(transformation(extent={{-86,-268},{-66,-248}})));
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
    annotation (Placement(transformation(extent={{62,-194},{82,-174}})));
public
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
    annotation (Placement(transformation(extent={{142,-210},{122,-190}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_hx_1(
    redeclare package Medium = Medium,
    p_start=data.p_rp_hx,
    T_start=data.T_rp_hx,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{120,-174},{140,-154}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_pipe_rp(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{34,-172},{54,-152}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_pipe_vc(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{26,-212},{6,-192}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_pipe(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    precision2=3,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-128,-172},{-108,-152}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_pipe_vc(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-48,-212},{-68,-192}})));
protected
  TRANSFORM.Fluid.Volumes.SimpleVolume vc(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.1),
    Q_gen=data.Q_vc)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-146,-192})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow)
                                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-146,-174})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume_co(
    redeclare package Medium = Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.01),
    Q_gen=0) "12022.6"
                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={52,-342})));
public
  TRANSFORM.Fluid.Sensors.MassFlowRate mflow_MAGNET(
    redeclare package Medium = Medium,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=2)
    annotation (Placement(transformation(extent={{116,-352},{136,-332}})));
protected
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ps(
    redeclare package Medium = Medium,
    p=data.p_hx_co,
    T=data.T_ps,
    nPorts=1)
    annotation (Placement(transformation(extent={{-122,-288},{-102,-268}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
    redeclare package Medium = Medium,
    p_a_start=data.p_hx_co,
    T_a_start=data.T_hx_co,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_hx_co, length=data.length_hx_co))
    annotation (Placement(transformation(extent={{-2,-352},{18,-332}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
    redeclare package Medium = Medium,
    p_a_start=data.p_co_rp,
    T_a_start=data.T_co_rp,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_co_rp, length=data.length_co_rp))
    annotation (Placement(transformation(extent={{164,-352},{184,-332}})));
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
    annotation (Placement(transformation(extent={{76,-352},{96,-332}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_vc_TEDS(
    ths_wall=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
    ths_insulation=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_vc_rp, length=data.length_vc_rp/2),
    redeclare package Medium = Medium,
    p_a_start=data.p_vc_rp,
    T_a_start=data.T_vc_rp,
    m_flow_a_start=data.m_flow,
    redeclare package Material_wall = TRANSFORM.Media.Solids.SS316)
    annotation (Placement(transformation(extent={{-100,-172},{-80,-152}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_vc(
    ths_wall=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
    ths_insulation=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_rp_vc, length=data.length_rp_vc),
    redeclare package Medium = Medium,
    p_a_start=data.p_rp_vc,
    T_a_start=data.T_rp_vc,
    m_flow_a_start=data.m_flow)
    annotation (Placement(transformation(extent={{-12,-212},{-32,-192}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_ins_rp_hx(
    ths_wall=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
    ths_insulation=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_rp_hx, length=data.length_rp_hx),
    redeclare package Medium = Medium,
    p_a_start=data.p_rp_hx,
    T_a_start=data.T_rp_hx,
    m_flow_a_start=data.m_flow)
    annotation (Placement(transformation(extent={{162,-288},{142,-268}})));
public
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
        origin={-64,-110})));
protected
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
        origin={0,-106})));
public
  TRANSFORM.Fluid.Sensors.MassFlowRate m_flow_vc_TEDS(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-64,-80})));
protected
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallAndInsulation pipe_vc_rp(
    ths_wall=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
    ths_insulation=fill(data.th_4in_sch40, pipe_vc_TEDS.geometry.nV),
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_vc_rp, length=data.length_vc_rp/2),
    redeclare package Medium = Medium,
    p_a_start=data.p_vc_rp,
    T_a_start=data.T_vc_rp,
    m_flow_a_start=data.m_flow,
    redeclare package Material_wall = TRANSFORM.Media.Solids.SS316,
    pipe(flowModel(dps_fg(start={-128.03918155874314}))))
    annotation (Placement(transformation(extent={{6,-172},{26,-152}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume_MT(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.01),
    Q_gen=0) "12022.6" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-148})));
protected
  Modelica.Blocks.Sources.RealExpression Tout_vc(y=pT_vc_pipe.T)
    annotation (Placement(transformation(extent={{-80,12},{-62,30}})));
  Modelica.Blocks.Sources.RealExpression Tin_vc(y=pT_pipe_vc.T)
    annotation (Placement(transformation(extent={{-80,0},{-62,18}})));
public
  TRANSFORM.Fluid.Sensors.MassFlowRate TEDS_flow_rate(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p_start=data.p_TEDS_out,
    T_start=data.T_hot_side,
    precision=2)
    annotation (Placement(transformation(extent={{-114,-36},{-134,-16}})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_TEDS(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-64,-138})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_TEDS_rp(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=90,
        origin={0,-78})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_rp(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-20,-162})));
  TRANSFORM.Fluid.Sensors.MassFlowRate mflow_cw(
    redeclare package Medium = Medium_cw,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=3)
    annotation (Placement(transformation(extent={{-10,-248},{10,-228}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TM_HX_Tin(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{6,-56},{26,-36}})));
  Magnet_TEDS.MAGNET_TEDS_ControlSystem.MAGNET_ControlSystem_1 MAGNET_ControlSystem_1_1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_hot_design=598.15,
    T_cold_design=498.15)
    annotation (Placement(transformation(extent={{38,18},{60,40}})));
  Modelica.Blocks.Sources.RealExpression mflow_inside_MAGNET(y=mflow_MAGNET.m_flow)
    annotation (Placement(transformation(extent={{-80,24},{-62,40}})));
  Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput
    actuatorSubBus
    annotation (Placement(transformation(extent={{-14,-8},{6,12}})));
  Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus
    annotation (Placement(transformation(extent={{22,-8},{42,12}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate mflow_vc_rp(
    redeclare package Medium = Medium,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=3)
    annotation (Placement(transformation(extent={{-56,-172},{-36,-152}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-0.688888,
    duration=3000,
    offset=0.689,
    startTime=2000)
    annotation (Placement(transformation(extent={{126,-24},{106,-4}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-15,
    duration=2000,
    offset=225 + 273.15,
    startTime=1000)
    annotation (Placement(transformation(extent={{126,-62},{106,-42}})));
equation
  connect(MAGNET_TEDS_simpleHX.port_b2, TM_HX_exit_Temp.port_b) annotation (
     Line(points={{-30,-46},{-52,-46},{-52,-26},{-58,-26}},
                                                        color={0,127,255}));
  connect(sensor_hx_cw.port_b,boundary. ports[1])
    annotation (Line(points={{112,-240},{152,-240}},
                                               color={0,127,255}));
  connect(hx.port_a2,sensor_hx_cw. port_a) annotation (Line(points={{82,-258},
          {88,-258},{88,-240},{92,-240}},
                                  color={0,127,255}));
  connect(sensor_cw_hx.port_b,hx. port_b2) annotation (Line(points={{48,-238},
          {56,-238},{56,-258},{62,-258}},
                                  color={0,127,255}));
  connect(sensor_rp_hx_2.port_b,hx. port_b1) annotation (Line(points={{96,-278},
          {88,-278},{88,-266},{82,-266}}, color={0,127,255}));
  connect(hx.port_a1,sensor_hx_co. port_a) annotation (Line(points={{62,-266},
          {56,-266},{56,-278},{50,-278}},color={0,127,255}));
  connect(sensor_hx_co.port_b,valve_ps. port_b)
    annotation (Line(points={{30,-278},{-32,-278}}, color={0,127,255}));
  connect(opening_valve_tank.y,valve_ps. opening) annotation (Line(points={{-65,
          -258},{-42,-258},{-42,-270}},color={0,0,127}));
  connect(pT_co_rp_1.port_b, rp.port_a2) annotation (Line(points={{122,-200},
          {90,-200},{90,-188},{82,-188}}, color={0,127,255}));
  connect(pT_vc_pipe_rp.port_b, rp.port_a1) annotation (Line(points={{54,-162},{
          56,-162},{56,-180},{62,-180}},        color={0,127,255}));
  connect(rp.port_b1, pT_rp_hx_1.port_a) annotation (Line(points={{82,-180},
          {112,-180},{112,-164},{120,-164}}, color={0,127,255}));
  connect(rp.port_b2, pT_rp_pipe_vc.port_a) annotation (Line(points={{62,
          -188},{32,-188},{32,-202},{26,-202}}, color={0,127,255}));
  connect(pT_pipe_vc.port_b, vc.port_a) annotation (Line(points={{-68,-202},{-146,
          -202},{-146,-198}},       color={0,127,255}));
  connect(vc.port_b,resistance. port_a)
    annotation (Line(points={{-146,-186},{-146,-181}},
                                                   color={0,127,255}));
  connect(pT_vc_pipe.port_a, resistance.port_b) annotation (Line(points={{-128,-162},
          {-146,-162},{-146,-167}},            color={0,127,255}));
  connect(ps.ports[1],valve_ps. port_a) annotation (Line(points={{-102,-278},
          {-52,-278}},                 color={0,127,255}));
  connect(pipe_hx_co.port_b,volume_co. port_a)
    annotation (Line(points={{18,-342},{46,-342}}, color={0,127,255}));
  connect(pipe_hx_co.port_a,valve_ps. port_b) annotation (Line(points={{-2,-342},
          {-20,-342},{-20,-278},{-32,-278}},      color={0,127,255}));
  connect(mflow_MAGNET.port_b, pipe_co_rp.port_a)
    annotation (Line(points={{136,-342},{164,-342}}, color={0,127,255}));
  connect(pipe_co_rp.port_b, pT_co_rp_1.port_a) annotation (Line(points={{
          184,-342},{198,-342},{198,-200},{142,-200}}, color={0,127,255}));
  connect(volume_co.port_b,co. port_a)
    annotation (Line(points={{58,-342},{76,-342}}, color={0,127,255}));
  connect(co.port_b, mflow_MAGNET.port_a)
    annotation (Line(points={{96,-342},{116,-342}}, color={0,127,255}));
  connect(pipe_vc_TEDS.port_a, pT_vc_pipe.port_b)
    annotation (Line(points={{-100,-162},{-108,-162}}, color={0,127,255}));
  connect(pT_pipe_vc.port_a, pipe_ins_rp_vc.port_b)
    annotation (Line(points={{-48,-202},{-32,-202}}, color={0,127,255}));
  connect(pT_rp_pipe_vc.port_b, pipe_ins_rp_vc.port_a)
    annotation (Line(points={{6,-202},{-12,-202}}, color={0,127,255}));
  connect(sensor_rp_hx_2.port_a,pipe_ins_rp_hx. port_b)
    annotation (Line(points={{116,-278},{142,-278}},
                                                color={0,127,255}));
  connect(pipe_ins_rp_hx.port_a, pT_rp_hx_1.port_b) annotation (Line(points=
         {{162,-278},{184,-278},{184,-164},{140,-164}}, color={0,127,255}));
  connect(T_vc_TEDS.port_b, m_flow_vc_TEDS.port_a)
    annotation (Line(points={{-64,-100},{-64,-90}},color={0,127,255}));
  connect(T_vc_TEDS.port_a, valve_vc_TEDS.port_b) annotation (Line(points={{-64,
          -120},{-64,-132}},                           color={0,127,255}));
  connect(valve_vc_TEDS.port_a, pipe_vc_TEDS.port_b) annotation (Line(points={{-64,
          -144},{-64,-162},{-80,-162}}, color={0,127,255}));
  connect(MAGNET_TEDS_simpleHX.port_b1, valve_TEDS_rp.port_a) annotation (
      Line(points={{-10,-54},{0,-54},{0,-72},{4.44089e-16,-72}},
                                                          color={0,127,255}));
  connect(valve_TEDS_rp.port_b, pT_TEDS_rp.port_a) annotation (Line(points={{
          -3.88578e-16,-84},{-3.88578e-16,-87},{1.77636e-15,-87},{1.77636e-15,
          -96}},                                    color={0,127,255}));
  connect(m_flow_vc_TEDS.port_b, MAGNET_TEDS_simpleHX.port_a1) annotation (
      Line(points={{-64,-70},{-64,-54},{-30,-54}}, color={0,127,255}));
  connect(TM_HX_exit_Temp.port_a, TEDS_flow_rate.port_a)
    annotation (Line(points={{-78,-26},{-114,-26}},
                                               color={0,127,255}));
  connect(TEDS_flow_rate.port_b, boundary_TEDS_out.ports[1])
    annotation (Line(points={{-134,-26},{-142,-26}},
                                                 color={0,127,255}));
  connect(pipe_vc_rp.port_b, pT_vc_pipe_rp.port_a)
    annotation (Line(points={{26,-162},{34,-162}}, color={0,127,255}));
  connect(pipe_vc_rp.port_a, valve_vc_rp.port_b)
    annotation (Line(points={{6,-162},{-14,-162}}, color={0,127,255}));
  connect(mflow_cw.port_a, boundary1.ports[1])
    annotation (Line(points={{-10,-238},{-34,-238}}, color={0,127,255}));
  connect(mflow_cw.port_b, sensor_cw_hx.port_a)
    annotation (Line(points={{10,-238},{28,-238}}, color={0,127,255}));
  connect(boundary_TEDS_in.ports[1], TM_HX_Tin.port_b)
    annotation (Line(points={{56,-22},{26,-22},{26,-46}},
                                                      color={0,127,255}));
  connect(TM_HX_Tin.port_a, MAGNET_TEDS_simpleHX.port_a2)
    annotation (Line(points={{6,-46},{-10,-46}}, color={0,127,255}));
  connect(MAGNET_ControlSystem_1_1.actuatorSubBus,actuatorSubBus)  annotation (
      Line(
      points={{47.5333,18.0611},{47.5333,2},{-4,2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(MAGNET_ControlSystem_1_1.sensorSubBus,sensorSubBus)  annotation (Line(
      points={{51.4444,18.0611},{51.4444,2},{32,2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.y)
    annotation (Line(
      points={{-4,2},{-4,32},{-61.1,32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Heater_flowrate, TEDS_flow_rate.m_flow) annotation (
      Line(
      points={{-4,2},{-124,2},{-124,-22.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Tin_TEDSide, TM_HX_Tin.T) annotation (Line(
      points={{-4,2},{16,2},{16,-42.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.MAGNET_flow, m_flow_vc_TEDS.m_flow) annotation (Line(
      points={{-4,2},{-102,2},{-102,-80},{-67.6,-80}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.MAGNET_TEDS_HX_Tin, T_vc_TEDS.T) annotation (Line(
      points={{-4,2},{-102,2},{-102,-104},{-62,-104}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.MAGNET_TEDS_HX_Tout, pT_TEDS_rp.T) annotation (Line(
      points={{-4,2},{-102,2},{-102,-126},{-2,-126},{-2,-112}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(mflow_vc_rp.port_a, pipe_vc_TEDS.port_b)
    annotation (Line(points={{-56,-162},{-80,-162}}, color={0,127,255}));
  connect(mflow_vc_rp.port_b, valve_vc_rp.port_a)
    annotation (Line(points={{-36,-162},{-26,-162}}, color={0,127,255}));
  connect(actuatorSubBus.mf_vc_rp, mflow_vc_rp.m_flow) annotation (Line(
      points={{-4,2},{-102,2},{-102,-126},{-46,-126},{-46,-158.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_valve_opening, valve_vc_TEDS.opening) annotation (
     Line(
      points={{32,2},{-102,2},{-102,-138},{-68.8,-138}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_valve3_opening, valve_TEDS_rp.opening)
    annotation (Line(
      points={{32,2},{32,-78},{4.8,-78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_valve2_opening, valve_vc_rp.opening) annotation (
      Line(
      points={{32,2},{32,-138},{-20,-138},{-20,-157.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(ramp.y, boundary_TEDS_in.m_flow_in) annotation (Line(points={{105,-14},
          {76,-14}},                 color={0,0,127}));
  connect(ramp1.y, boundary_TEDS_in.T_in) annotation (Line(points={{105,-52},{
          84,-52},{84,-18},{78,-18}},
                                  color={0,0,127}));
  connect(volume_MT.port_a, pT_TEDS_rp.port_b) annotation (Line(points={{
          1.11022e-15,-142},{1.11022e-15,-126},{-1.83187e-15,-126},{
          -1.83187e-15,-116}},
        color={0,127,255}));
  connect(volume_MT.port_b, valve_vc_rp.port_b) annotation (Line(points={{
          -1.11022e-15,-154},{-1.11022e-15,-162},{-14,-162}},
                                                 color={0,127,255}));
  connect(actuatorSubBus.Tout_vc, Tout_vc.y) annotation (Line(
      points={{-4,2},{-4,21},{-61.1,21}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Tin_vc, Tin_vc.y) annotation (Line(
      points={{-4,2},{-4,9},{-61.1,9}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.CW_control, boundary1.m_flow_in) annotation (Line(
      points={{32,2},{-168,2},{-168,-230},{-54,-230}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_flow_control, co.inputSignal) annotation (Line(
      points={{32,2},{206,2},{206,-308},{86,-308},{86,-335}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (experiment(
      StopTime=40000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"),
    Diagram(coordinateSystem(extent={{-180,-360},{220,40}})),
    Icon(coordinateSystem(extent={{-180,-360},{220,40}})));
end MAGNET_TEDS_valve_3;
