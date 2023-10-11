within NHES.Systems.ExperimentalSystems.MAGNET.Models;
model MAGNET_TEDS_Boundaries_1
  extends TRANSFORM.Icons.Example;

protected
  inner TRANSFORM.Fluid.SystemTF systemTF(
    showColors=true,
    val_min=data.T_hx_co,
    val_max=data.T_vc_rp)
    annotation (Placement(transformation(extent={{190,-76},{210,-56}})));

public
  TRANSFORM.HeatExchangers.Simple_HX MAGNET_TEDS_simpleHX(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    nV=10,
    V_1=1,
    V_2=1,
    UA=PID1.y,
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
    annotation (Placement(transformation(extent={{-30,-50},{-10,-70}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TM_HX_exit_Temp(redeclare package
      Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3)
    annotation (Placement(transformation(extent={{-78,-46},{-58,-26}})));
  TRANSFORM.Controls.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    yb=0,
    k_s=1/data.Q_MAGNET_TEDS,
    k_m=1/data.Q_MAGNET_TEDS,
    yMin=0,
    strict=false)
            annotation (Placement(transformation(extent={{288,-150},{308,-130}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=data.Q_MAGNET_TEDS)
    annotation (Placement(transformation(extent={{248,-150},{268,-130}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=
        MAGNET_TEDS_simpleHX.Q_flow)
    annotation (Placement(transformation(extent={{266,-178},{286,-158}})));
protected
  inner TRANSFORM.Fluid.System system(
    p_ambient=18000,
    T_ambient=498.15,
    m_flow_start=0.84)
    annotation (Placement(transformation(extent={{190,-110},{210,-90}})));
protected
  NHES.Systems.ExperimentalSystems.MAGNET.Data.Data_base_An data
    annotation (Placement(transformation(extent={{188,-136},{208,-116}})));
protected
  package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
  package Medium_cw = Modelica.Media.Water.StandardWater;

protected
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary_TEDS_out(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p=data.p_TEDS_out,
    T=data.T_hot_side,
    nPorts=1)
    annotation (Placement(transformation(extent={{-162,-46},{-142,-26}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_TEDS_in(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_m_flow_in=false,
    m_flow=data.TEDS_nominal_flow_rate,
    T=data.T_cold_side,
    nPorts=1)
    annotation (Placement(transformation(extent={{76,-42},{56,-22}})));
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
    annotation (Placement(transformation(extent={{-102,-172},{-82,-152}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_pipe_vc(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    precision2=3,
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
        origin={-120,-192})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow)
                                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-120,-174})));
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
    annotation (Placement(transformation(extent={{-74,-172},{-54,-152}})));
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
  Modelica.Blocks.Sources.Constant opening_valve_tank2(k=1)
    annotation (Placement(transformation(extent={{54,-112},{42,-100}})));
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
        origin={-42,-116})));
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
        origin={0,-138})));
public
  TRANSFORM.Fluid.Sensors.MassFlowRate m_flow_vc_TEDS(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-42,-90})));
protected
  Modelica.Blocks.Sources.Constant opening_valve_tank1(k=1)
    annotation (Placement(transformation(extent={{-70,-150},{-58,-138}})));
  Modelica.Blocks.Sources.Constant opening_valve_tank3(k=0)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-20,-120})));
  Modelica.Blocks.Sources.RealExpression Tout_vc(y=pT_vc_pipe.T)
    annotation (Placement(transformation(extent={{-10,-336},{10,-316}})));
  Modelica.Blocks.Sources.Constant Tout_vc_design(k=data.T_vc_rp)
    annotation (Placement(transformation(extent={{-12,-314},{0,-302}})));
  Modelica.Blocks.Sources.RealExpression Tin_vc(y=pT_pipe_vc.T)
    annotation (Placement(transformation(extent={{-140,-262},{-120,-242}})));
  Modelica.Blocks.Sources.Constant Tin_vc_design(k=data.T_rp_vc)
    annotation (Placement(transformation(extent={{-144,-234},{-132,-222}})));
  Modelica.Blocks.Sources.Constant opening_valve_tank4(k=data.m_flow)
    annotation (Placement(transformation(extent={{290,-322},{270,-302}})));
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
  Modelica.Blocks.Sources.Constant Tin_vc_design1(k=265 + 273.15)
    annotation (Placement(transformation(extent={{-154,-216},{-142,-204}})));
public
  TRANSFORM.Fluid.Sensors.MassFlowRate TEDS_flow_rate(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p_start=data.p_TEDS_out,
    T_start=data.T_hot_side,
    precision=2)
    annotation (Placement(transformation(extent={{-96,-46},{-116,-26}})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_TEDS(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-42,-144})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_TEDS_rp(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=90,
        origin={0,-106})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_rp(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-20,-162})));
public
  TRANSFORM.Controls.LimPID N2_mf_control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    with_FF=false,
    k=-0.025,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=10,
    yMin=0.001,
    Nd=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.689)
    annotation (Placement(transformation(extent={{50,-318},{70,-298}})));
public
  TRANSFORM.Controls.LimPID cw_mf_control(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    with_FF=false,
    k=-0.001,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=5,
    yMin=0.001,
    Nd=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.689)
    annotation (Placement(transformation(extent={{-112,-238},{-92,-218}})));
  TRANSFORM.Controls.LimPID PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k_s=1,
    k_m=1,
    yMin=0,
    y_start=300)
            annotation (Placement(transformation(extent={{284,-34},{304,-14}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=data.T_vc_rp)
    annotation (Placement(transformation(extent={{246,-34},{266,-14}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=pT_vc_pipe.T)
    annotation (Placement(transformation(extent={{246,-56},{266,-36}})));
  TRANSFORM.Controls.LimPID PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=10,
    yb=2037.7781,
    k_s=1/data.Q_flow_hx,
    k_m=1/data.Q_flow_hx,
    yMin=0) annotation (Placement(transformation(extent={{286,-98},{306,-78}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=data.T_hx_co)
    annotation (Placement(transformation(extent={{248,-98},{268,-78}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=sensor_hx_co.T)
    annotation (Placement(transformation(extent={{248,-120},{268,-100}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate mflow_cw(
    redeclare package Medium = Medium_cw,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=3)
    annotation (Placement(transformation(extent={{-10,-248},{10,-228}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TM_HX_Tin(redeclare package Medium
      =        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3)
    annotation (Placement(transformation(extent={{26,-66},{46,-46}})));
equation
  connect(MAGNET_TEDS_simpleHX.port_b2, TM_HX_exit_Temp.port_b) annotation (
     Line(points={{-30,-56},{-52,-56},{-52,-36},{-58,-36}},
                                                        color={0,127,255}));
  connect(realExpression2.y, PID1.u_s)
    annotation (Line(points={{269,-140},{286,-140}},
                                                   color={0,0,127}));
  connect(realExpression3.y, PID1.u_m) annotation (Line(points={{287,-168},{
          298,-168},{298,-152}},
                               color={0,0,127}));
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
          -258},{-4,-258},{-4,-270},{-42,-270}},
                                       color={0,0,127}));
  connect(pT_co_rp_1.port_b, rp.port_a2) annotation (Line(points={{122,-200},
          {90,-200},{90,-188},{82,-188}}, color={0,127,255}));
  connect(pT_vc_pipe_rp.port_b, rp.port_a1) annotation (Line(points={{54,-162},
          {56,-162},{56,-180},{62,-180}},       color={0,127,255}));
  connect(rp.port_b1, pT_rp_hx_1.port_a) annotation (Line(points={{82,-180},
          {112,-180},{112,-164},{120,-164}}, color={0,127,255}));
  connect(rp.port_b2, pT_rp_pipe_vc.port_a) annotation (Line(points={{62,
          -188},{32,-188},{32,-202},{26,-202}}, color={0,127,255}));
  connect(pT_pipe_vc.port_b, vc.port_a) annotation (Line(points={{-68,-202},
          {-120,-202},{-120,-198}}, color={0,127,255}));
  connect(vc.port_b,resistance. port_a)
    annotation (Line(points={{-120,-186},{-120,-181}},
                                                   color={0,127,255}));
  connect(pT_vc_pipe.port_a, resistance.port_b) annotation (Line(points={{
          -102,-162},{-120,-162},{-120,-167}}, color={0,127,255}));
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
    annotation (Line(points={{-74,-162},{-82,-162}}, color={0,127,255}));
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
    annotation (Line(points={{-42,-106},{-42,-100}},
                                                   color={0,127,255}));
  connect(T_vc_TEDS.port_a, valve_vc_TEDS.port_b) annotation (Line(points={{-42,
          -126},{-42,-138}},                           color={0,127,255}));
  connect(valve_vc_TEDS.port_a, pipe_vc_TEDS.port_b) annotation (Line(points=
          {{-42,-150},{-42,-162},{-54,-162}}, color={0,127,255}));
  connect(opening_valve_tank1.y, valve_vc_TEDS.opening) annotation (Line(
        points={{-57.4,-144},{-46.8,-144}},                         color={
          0,0,127}));
  connect(opening_valve_tank2.y, valve_TEDS_rp.opening) annotation (Line(
        points={{41.4,-106},{4.8,-106}},         color={0,0,127}));
  connect(MAGNET_TEDS_simpleHX.port_b1, valve_TEDS_rp.port_a) annotation (
      Line(points={{-10,-64},{0,-64},{0,-100},{4.44089e-16,-100}},
                                                          color={0,127,255}));
  connect(valve_TEDS_rp.port_b, pT_TEDS_rp.port_a) annotation (Line(points={{
          -4.44089e-16,-112},{-4.44089e-16,-128},{1.77636e-15,-128}},
                                                    color={0,127,255}));
  connect(opening_valve_tank3.y, valve_vc_rp.opening) annotation (Line(
        points={{-20,-124.4},{-20,-157.2}},                       color={0,
          0,127}));
  connect(m_flow_vc_TEDS.port_b, MAGNET_TEDS_simpleHX.port_a1) annotation (
      Line(points={{-42,-80},{-42,-64},{-30,-64}}, color={0,127,255}));
  connect(TM_HX_exit_Temp.port_a, TEDS_flow_rate.port_a)
    annotation (Line(points={{-78,-36},{-96,-36}},
                                               color={0,127,255}));
  connect(TEDS_flow_rate.port_b, boundary_TEDS_out.ports[1])
    annotation (Line(points={{-116,-36},{-142,-36}},
                                                 color={0,127,255}));
  connect(Tout_vc_design.y,N2_mf_control. u_s)
    annotation (Line(points={{0.6,-308},{48,-308}},   color={0,0,127}));
  connect(Tout_vc.y,N2_mf_control. u_m) annotation (Line(points={{11,-326},{
          48,-326},{48,-320},{60,-320}},
                                     color={0,0,127}));
  connect(Tin_vc.y,cw_mf_control. u_m)
    annotation (Line(points={{-119,-252},{-102,-252},{-102,-240}},
                                                           color={0,0,127}));
  connect(realExpression4.y,PID2. u_m)
    annotation (Line(points={{267,-46},{294,-46},{294,-36}},
                                                          color={0,0,127}));
  connect(realExpression1.y,PID2. u_s)
    annotation (Line(points={{267,-24},{282,-24}},
                                                 color={0,0,127}));
  connect(realExpression6.y,PID3. u_m)
    annotation (Line(points={{269,-110},{296,-110},{296,-100}},
                                                             color={0,0,127}));
  connect(realExpression5.y,PID3. u_s)
    annotation (Line(points={{269,-88},{284,-88}}, color={0,0,127}));
  connect(valve_vc_rp.port_a, pipe_vc_TEDS.port_b)
    annotation (Line(points={{-26,-162},{-54,-162}}, color={0,127,255}));
  connect(pipe_vc_rp.port_b, pT_vc_pipe_rp.port_a)
    annotation (Line(points={{26,-162},{34,-162}}, color={0,127,255}));
  connect(pipe_vc_rp.port_a, valve_vc_rp.port_b)
    annotation (Line(points={{6,-162},{-14,-162}}, color={0,127,255}));
  connect(pT_TEDS_rp.port_b, valve_vc_rp.port_b) annotation (Line(points={{0,
          -148},{0,-162},{-14,-162}}, color={0,127,255}));
  connect(mflow_cw.port_a, boundary1.ports[1])
    annotation (Line(points={{-10,-238},{-34,-238}}, color={0,127,255}));
  connect(mflow_cw.port_b, sensor_cw_hx.port_a)
    annotation (Line(points={{10,-238},{28,-238}}, color={0,127,255}));
  connect(boundary_TEDS_in.ports[1], TM_HX_Tin.port_b) annotation (Line(
        points={{56,-32},{46,-32},{46,-56}}, color={0,127,255}));
  connect(TM_HX_Tin.port_a, MAGNET_TEDS_simpleHX.port_a2)
    annotation (Line(points={{26,-56},{-10,-56}}, color={0,127,255}));
  connect(N2_mf_control.y, co.inputSignal) annotation (Line(points={{71,-308},
          {86,-308},{86,-335}}, color={0,0,127}));
  connect(cw_mf_control.y, boundary1.m_flow_in) annotation (Line(points={{-91,
          -228},{-88,-228},{-88,-230},{-54,-230}}, color={0,0,127}));
  connect(Tin_vc_design1.y, cw_mf_control.u_s) annotation (Line(points={{
          -141.4,-210},{-122,-210},{-122,-228},{-114,-228}}, color={0,0,127}));
  annotation (experiment(
      StopTime=40000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"),
    Diagram(coordinateSystem(extent={{-180,-360},{220,0}})),
    Icon(coordinateSystem(extent={{-180,-360},{220,0}})));
end MAGNET_TEDS_Boundaries_1;
