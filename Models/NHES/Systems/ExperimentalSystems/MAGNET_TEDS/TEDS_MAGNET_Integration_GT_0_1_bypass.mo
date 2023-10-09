within NHES.Systems.ExperimentalSystems.MAGNET_TEDS;
model TEDS_MAGNET_Integration_GT_0_1_bypass
  "Dynamic simulation of the integrated system of MAGNET, TEDS, and Gas turbine with a central control system"
  extends TRANSFORM.Icons.Example;

protected
  inner TRANSFORM.Fluid.SystemTF systemTF(
    showColors=true,
    val_min=data.T_hx_co,
    val_max=data.T_vc_rp)
    annotation (Placement(transformation(extent={{-256,-326},{-236,-306}})));

protected
  inner TRANSFORM.Fluid.System system(
    p_ambient=18000,
    T_ambient=498.15,
    m_flow_start=0.84)
    annotation (Placement(transformation(extent={{-256,-356},{-236,-336}})));
protected
  NHES.Systems.ExperimentalSystems.MAGNET.Data.Data_base_An data
    annotation (Placement(transformation(extent={{-256,-290},{-236,-270}})));
protected
  package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
  package Medium_cw = Modelica.Media.Water.StandardWater;
  package Medium_TEDS =
      TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C;

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
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T m_source_cw(
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
    annotation (Placement(transformation(extent={{64,-192},{84,-172}})));
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
    annotation (Placement(transformation(extent={{124,-210},{104,-190}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_hx_1(
    redeclare package Medium = Medium,
    p_start=data.p_rp_hx,
    T_start=data.T_rp_hx,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{104,-172},{124,-152}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_pipe_rp(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{32,-172},{52,-152}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_pipe_vc(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{54,-210},{34,-190}})));
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
    annotation (Placement(transformation(extent={{-48,-210},{-68,-190}})));
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
    annotation (Placement(transformation(extent={{152,-210},{132,-190}})));
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
    annotation (Placement(transformation(extent={{-12,-210},{-32,-190}})));
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
        origin={-64,-118})));
public
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
        origin={0,-112})));
public
  TRANSFORM.Fluid.Sensors.MassFlowRate m_flow_vc_TEDS(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-64,-90})));
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
    annotation (Placement(transformation(extent={{2,-172},{22,-152}})));
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
        origin={0,-142})));
protected
  Modelica.Blocks.Sources.RealExpression Tout_vc(y=pT_vc_pipe.T)
    annotation (Placement(transformation(extent={{204,-4},{222,14}})));
  Modelica.Blocks.Sources.RealExpression Tin_vc(y=pT_pipe_vc.T)
    annotation (Placement(transformation(extent={{204,-16},{222,2}})));
public
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_TEDS(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-64,-142})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_TEDS_rp(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=90,
        origin={0,-90})));
  TRANSFORM.Fluid.Sensors.MassFlowRate mflow_cw(
    redeclare package Medium = Medium_cw,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=3)
    annotation (Placement(transformation(extent={{-10,-248},{10,-228}})));
  Modelica.Blocks.Sources.RealExpression mflow_inside_MAGNET(y=mflow_MAGNET.m_flow)
    annotation (Placement(transformation(extent={{204,8},{222,24}})));
  GasTurbine.Turbine.Turbine turbine(
    redeclare package Medium = Medium,
    explicitIsentropicEnthalpy=true,
    Tstart_in=data.T_vc_rp,
    Tstart_out=489.15,
    PR0=2.975,
    w0=data.m_flow/2)
              annotation (Placement(transformation(
        extent={{-22,-17},{22,17}},
        rotation=90,
        origin={-201,-48})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_GT(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-214,-124})));
  TRANSFORM.Fluid.Sensors.MassFlowRate mflow_vc_GT(
    redeclare package Medium = Medium,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=3)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-214,-76})));
  Modelica.Blocks.Sources.RealExpression GT_Power(y=data.eta_mech*(turbine.Wt
         - compressor.Wc))
    annotation (Placement(transformation(extent={{204,18},{222,34}})));
public
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_GT_co(
    redeclare package Medium = Medium,
    p_start=data.p_atm,
    T_start=data.T_vc_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-214,-12})));
public
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_co_rp(
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
        rotation=0,
        origin={-114,12})));
public
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_GT(
    redeclare package Medium = Medium,
    p_start=data.p_atm,
    T_start=data.T_vc_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-214,-102})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary3(use_port=
        false, T=306.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-238,26})));
  GasTurbine.Compressor.Compressor compressor(
    redeclare package Medium = Medium,
    pstart_in=data.p_atm,
    Tstart_in=306.15,
    Tstart_out=723.15,
    PR0=2.975,
    w0=data.m_flow/2)
    annotation (Placement(transformation(extent={{-160,-10},{-124,14}})));
public
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_co_rp1(
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
        rotation=0,
        origin={-174,12})));
  Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
    springBallValve(
    redeclare package Medium = Medium,
    p_spring=data.P_Release,
    K=1,
    opening_init=0.)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-192,28})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
    redeclare package Medium = Medium,
    p=data.P_Release,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-142,40})));
  TRANSFORM.Fluid.Sensors.MassFlowRate mflow_GT_rp(
    redeclare package Medium = Medium,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=3) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-88,-6})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp/2.975,
    T_start=306.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-206,12})));
public
  TRANSFORM.HeatExchangers.Simple_HX MAGNET_TEDS_simpleHX1(
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
    T_b_start_1=502.15,
    m_flow_start_1=data.m_flow,
    p_a_start_2=data.p_TEDS_in,
    p_b_start_2=data.p_TEDS_out,
    T_a_start_2=data.T_cold_side,
    T_b_start_2=data.T_hot_side,
    m_flow_start_2=data.m_flow_TEDS)
    annotation (Placement(transformation(extent={{266,-92},{246,-72}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.1),
    T_start=data.T_hot_side)
    annotation (Placement(transformation(extent={{392,-60},{408,-44}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe4(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.1),
    T_start=data.T_cold_side)
                    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={236,-202})));
  Modelica.Fluid.Pipes.DynamicPipe pipe7(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    length=0.1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.1))
                    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={562,-146})));
  TRANSFORM.Fluid.Volumes.ExpansionTank tank1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    A=1,
    V0=0.1,
    p_surface=system.p_ambient,
    p_start=system.p_start,
    level_start=0,
    h_start=Medium.specificEnthalpy_pT(system.p_start, data.T_hot_side))
    annotation (Placement(transformation(extent={{332,-56},{352,-36}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_002(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    T_start=data.T_cold_side,
    precision=3) annotation (Placement(transformation(
        extent={{-12,-11},{12,11}},
        rotation=90,
        origin={236,-167})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_003(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_hot_side,
    precision=3)
    annotation (Placement(transformation(extent={{290,-98},{316,-74}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate m_Chg_In(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={418,-84})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={562,-80})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_049(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=1e-2,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={418,-66})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_050(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={488,-66})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_051(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={418,-260})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_052(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={488,-240})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_006(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=false,
    m_flow_start=0.41,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={466,-52})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_201(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=-90,
        origin={419,-239})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_202(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{-9,-10},{9,10}},
        rotation=-90,
        origin={488,-255})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_004(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={272,-290})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_003(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_cold_side,
    precision=3)
    annotation (Placement(transformation(extent={{302,-298},{284,-282}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate m_Dch_Out(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={488,-84})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_Chg_Out(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{-9,10},{9,-10}},
        rotation=90,
        origin={488,-219})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_Chg_In(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={418,-110})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_Dch_Out(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={488,-110})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_Dch_In(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{-9.5,-8.5},{9.5,8.5}},
        rotation=90,
        origin={419,-219.5})));
  TRANSFORM.Fluid.Sensors.MassFlowRate BOP_Mass_flow(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_hot_side,
    precision=3)
          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={440,-52})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_before(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-13,12},{13,-12}},
        rotation=270,
        origin={562,-113})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_after(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-13,13},{13,-13}},
        rotation=270,
        origin={561,-193})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_003a(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_hot_side,
    precision=3)
    annotation (Placement(transformation(extent={{362,-64},{386,-40}})));
  Systems.Experiments.TEDS.ThermoclineModels.Thermocline_Insulation_An
    thermocline_Insulation_An(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    redeclare package InsulationMaterial = Media.Solids.FoamGlass,
    geometry(
      Radius_Tank=0.438,
      Porosity=0.5,
      nodes=30,
      dr=0.00317,
      Insulation_thickness=3*0.051,
      Wall_Thickness=0.019,
      Height_Tank=4.435))
    annotation (Placement(transformation(extent={{440,-180},{468,-148}})));
  Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput sensorSubBus
    annotation (Placement(transformation(extent={{292,-34},{314,-10}})));
  Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput actuatorSubBus
    annotation (Placement(transformation(extent={{324,-34},{346,-10}})));
  Modelica.Blocks.Sources.RealExpression MAGNET_heater_input(y=
        MAGNET_TEDS_simpleHX1.Q_flow)
    annotation (Placement(transformation(extent={{204,28},{222,44}})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster P_001(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_input=true,
    p_nominal=system.p_ambient + 1e4)
    annotation (Placement(transformation(extent={{344,-298},{328,-282}})));
  Magnet_TEDS.MAGNET_TEDS_ControlSystem.Control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1_bypass
    control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1_HW(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    TEDS_Heat_Load_Demand=TEDS_Heat_Demand_W.y,
    Gas_Turbine_Elec_Demand=PCU_Elec_Demand_W.y,
    T_hot_design=598.15,
    T_cold_design=498.15)
    annotation (Placement(transformation(extent={{362,2},{396,36}})));
  Modelica.Blocks.Sources.CombiTimeTable TEDS_Heat_Demand_kW(table=[0.0,100;
        1800,100; 3600,100; 4800,100; 7200,100; 9000,100; 9999.9,100; 10000,10;
        12200,10; 14400,10; 18000,30; 22000,30; 24500,50; 30000,50; 33000,50;
        45000,50; 48000,0; 50000,0], startTime=0)
    annotation (Placement(transformation(extent={{282,-158},{296,-144}})));
  Modelica.Blocks.Math.Gain TEDS_Heat_Demand_W(k=1000)
    annotation (Placement(transformation(extent={{306,-156},{316,-146}})));
  Modelica.Blocks.Sources.Constant PCU_Elec_Demand_kW(k=30)
    annotation (Placement(transformation(extent={{282,-186},{296,-172}})));
  Modelica.Blocks.Math.Gain PCU_Elec_Demand_W(k=1000)
    annotation (Placement(transformation(extent={{306,-184},{316,-174}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_201(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{-9,10},{9,-10}},
        rotation=-90,
        origin={454,-135})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_202(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{-9,-10},{9,10}},
        rotation=90,
        origin={454,-191})));
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
        origin={532,-290})));
  TRANSFORM.Fluid.Sensors.MassFlowRate FM_002(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{10.5,11},{-10.5,-11}},
        rotation=0,
        origin={485.5,-329})));
  Modelica.Fluid.Sources.MassFlowSource_T Chiller_Mass_Flow(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    use_m_flow_in=true,
    m_flow=12.6,
    T=280.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{366,-368},{386,-348}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    p=300000,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{520,-346},{500,-366}})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX HX_001(
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
    T_b_start_tube=m_source_cw.T,
    p_a_start_shell=system.p_ambient + 100,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=1.0),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=2.0))
    annotation (Placement(transformation(extent={{411,-352},{442,-322}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Ethylene_glycol_exit_temperature(
      redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{460,-368},{484,-344}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_006(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(extent={{358,-302},{382,-278}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_004(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{-9,12},{9,-12}},
        rotation=0,
        origin={460,-329})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_012(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={354,-330})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_009(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={436,-290})));
  Fluid.Pipes.NonLinear_Break nonLinear_Break(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{6,-8},{-6,8}},
        rotation=0,
        origin={402,-330})));
  Fluid.Pipes.NonLinear_Break nonLinear_Break2(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{6,-8},{-6,8}},
        rotation=0,
        origin={350,-290})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TC_005(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(
        extent={{-10,12},{10,-12}},
        rotation=0,
        origin={376,-330})));
  Fluid.Pipes.NonLinear_Break nonLinear_Break3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{6,-8},{-6,8}},
        rotation=0,
        origin={456,-290})));
  TRANSFORM.Fluid.Valves.ValveLinear PV_008(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=100,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=90,
        origin={522,-302})));
  Modelica.Fluid.Pipes.DynamicPipe pipe8(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=7,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=10, m_flow_nominal=0.84))
                    annotation (Placement(transformation(
        extent={{7,7},{-7,-7}},
        rotation=0,
        origin={509,-329})));
  Modelica.Blocks.Sources.Constant const2(k=12.6)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={342,-350})));
equation
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
  connect(pT_co_rp_1.port_b, rp.port_a2) annotation (Line(points={{104,-200},{
          92,-200},{92,-186},{84,-186}},  color={0,127,255}));
  connect(pT_vc_pipe_rp.port_b, rp.port_a1) annotation (Line(points={{52,-162},
          {56,-162},{56,-178},{64,-178}},       color={0,127,255}));
  connect(rp.port_b1, pT_rp_hx_1.port_a) annotation (Line(points={{84,-178},{92,
          -178},{92,-162},{104,-162}},       color={0,127,255}));
  connect(rp.port_b2, pT_rp_pipe_vc.port_a) annotation (Line(points={{64,-186},
          {54,-186},{54,-200}},                 color={0,127,255}));
  connect(pT_pipe_vc.port_b, vc.port_a) annotation (Line(points={{-68,-200},{
          -146,-200},{-146,-198}},  color={0,127,255}));
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
    annotation (Line(points={{136,-342},{182,-342},{182,-200},{152,-200}},
                                                     color={0,127,255}));
  connect(pipe_co_rp.port_b, pT_co_rp_1.port_a) annotation (Line(points={{132,
          -200},{124,-200}},                           color={0,127,255}));
  connect(volume_co.port_b,co. port_a)
    annotation (Line(points={{58,-342},{76,-342}}, color={0,127,255}));
  connect(co.port_b, mflow_MAGNET.port_a)
    annotation (Line(points={{96,-342},{116,-342}}, color={0,127,255}));
  connect(pipe_vc_TEDS.port_a, pT_vc_pipe.port_b)
    annotation (Line(points={{-100,-162},{-108,-162}}, color={0,127,255}));
  connect(pT_pipe_vc.port_a, pipe_ins_rp_vc.port_b)
    annotation (Line(points={{-48,-200},{-32,-200}}, color={0,127,255}));
  connect(pT_rp_pipe_vc.port_b, pipe_ins_rp_vc.port_a)
    annotation (Line(points={{34,-200},{-12,-200}},color={0,127,255}));
  connect(sensor_rp_hx_2.port_a,pipe_ins_rp_hx. port_b)
    annotation (Line(points={{116,-278},{142,-278}},
                                                color={0,127,255}));
  connect(pipe_ins_rp_hx.port_a, pT_rp_hx_1.port_b) annotation (Line(points={{162,
          -278},{204,-278},{204,-162},{124,-162}},      color={0,127,255}));
  connect(T_vc_TEDS.port_b, m_flow_vc_TEDS.port_a)
    annotation (Line(points={{-64,-108},{-64,-100}},
                                                   color={0,127,255}));
  connect(T_vc_TEDS.port_a, valve_vc_TEDS.port_b) annotation (Line(points={{-64,
          -128},{-64,-136}},                           color={0,127,255}));
  connect(valve_vc_TEDS.port_a, pipe_vc_TEDS.port_b) annotation (Line(points={{-64,
          -148},{-64,-162},{-80,-162}}, color={0,127,255}));
  connect(valve_TEDS_rp.port_b, pT_TEDS_rp.port_a) annotation (Line(points={{
          -3.88578e-16,-96},{-3.88578e-16,-101},{1.77636e-15,-101},{1.77636e-15,
          -102}},                                   color={0,127,255}));
  connect(pipe_vc_rp.port_b, pT_vc_pipe_rp.port_a)
    annotation (Line(points={{22,-162},{32,-162}}, color={0,127,255}));
  connect(mflow_cw.port_a, m_source_cw.ports[1])
    annotation (Line(points={{-10,-238},{-34,-238}}, color={0,127,255}));
  connect(mflow_cw.port_b, sensor_cw_hx.port_a)
    annotation (Line(points={{10,-238},{28,-238}}, color={0,127,255}));
  connect(volume_MT.port_a, pT_TEDS_rp.port_b) annotation (Line(points={{
          1.11022e-15,-136},{1.11022e-15,-129},{-1.83187e-15,-129},{
          -1.83187e-15,-122}},
        color={0,127,255}));
  connect(mflow_vc_GT.port_b, turbine.inlet) annotation (Line(points={{-214,-66},
          {-214.6,-66},{-214.6,-61.2}}, color={0,127,255}));
  connect(valve_vc_GT.port_a, pipe_vc_TEDS.port_b) annotation (Line(points={{-214,
          -130},{-214,-152},{-64,-152},{-64,-162},{-80,-162}},
                                                        color={0,127,255}));
  connect(volume_MT.port_b, pipe_vc_rp.port_a) annotation (Line(points={{
          -1.11022e-15,-148},{-1.11022e-15,-162},{2,-162}}, color={0,127,255}));
  connect(turbine.outlet, pT_GT_co.port_a) annotation (Line(points={{-214.6,
          -34.8},{-214.6,-26},{-214,-26},{-214,-22}},
                                        color={0,127,255}));
  connect(valve_vc_GT.port_b, pT_vc_GT.port_a)
    annotation (Line(points={{-214,-118},{-214,-112}}, color={0,127,255}));
  connect(pT_vc_GT.port_b, mflow_vc_GT.port_a)
    annotation (Line(points={{-214,-92},{-214,-86}}, color={0,127,255}));
  connect(compressor.outlet, pT_co_rp.port_a) annotation (Line(points={{-131.2,
          11.6},{-124.6,11.6},{-124.6,12},{-124,12}},
                                                  color={0,127,255}));
  connect(pT_co_rp1.port_b, compressor.inlet) annotation (Line(points={{-164,12},
          {-158.4,12},{-158.4,11.6},{-152.8,11.6}},
                                      color={0,127,255}));
  connect(springBallValve.port_b,boundary5. ports[1])
    annotation (Line(points={{-192,34},{-192,40},{-152,40}},
                                                          color={0,127,255}));
  connect(pT_co_rp.port_b, mflow_GT_rp.port_a)
    annotation (Line(points={{-104,12},{-88,12},{-88,4}}, color={0,127,255}));
  connect(mflow_GT_rp.port_b, pT_TEDS_rp.port_b) annotation (Line(points={{-88,-16},
          {-88,-130},{-1.77636e-15,-130},{-1.77636e-15,-122}},    color={0,127,
          255}));
  connect(pT_GT_co.port_b, Cooler.port_a) annotation (Line(points={{-214,-2},{
          -214,12},{-212,12}}, color={0,127,255}));
  connect(Cooler.port_b, pT_co_rp1.port_a)
    annotation (Line(points={{-200,12},{-184,12}}, color={0,127,255}));
  connect(springBallValve.port_a, pT_co_rp1.port_a) annotation (Line(points={{-192,22},
          {-192,12},{-184,12}},          color={0,127,255}));
  connect(boundary3.port, Cooler.heatPort)
    annotation (Line(points={{-228,26},{-206,26},{-206,18}}, color={191,0,0}));
  connect(m_flow_vc_TEDS.port_b, MAGNET_TEDS_simpleHX1.port_a1) annotation (
      Line(points={{-64,-80},{-64,-64},{266,-64},{266,-78}}, color={0,127,255}));
  connect(pipe4.port_b, TC_002.port_a)
    annotation (Line(points={{236,-194},{236,-179}}, color={0,127,255}));
  connect(TC_003.port_b, tank1.port_a) annotation (Line(points={{316,-86},{334,
          -86},{334,-52},{335,-52}},           color={0,127,255}));
  connect(pipe2.port_b,PV_049. port_a)
    annotation (Line(points={{408,-52},{418,-52},{418,-60}},
                                                       color={0,127,255}));
  connect(PV_049.port_b, m_Chg_In.port_a)
    annotation (Line(points={{418,-72},{418,-74}}, color={0,127,255}));
  connect(PV_050.port_a,sensor_m_flow2. port_a) annotation (Line(points={{488,-60},
          {488,-52},{562,-52},{562,-70}},
                                       color={0,127,255}));
  connect(PV_006.port_b,sensor_m_flow2. port_a)
    annotation (Line(points={{472,-52},{562,-52},{562,-70}},
                                                          color={0,127,255}));
  connect(PV_051.port_a, FM_201.port_b) annotation (Line(points={{418,-254},{
          419,-254},{419,-248}}, color={0,127,255}));
  connect(actuatorSubBus.Valve_4_Opening, PV_052.opening) annotation (Line(
      points={{335,-22},{536,-22},{536,-240},{492.8,-240}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorSubBus.Valve_5_Opening, PV_051.opening) annotation (Line(
      points={{335,-22},{360,-22},{360,-268},{404,-268},{404,-260},{413.2,-260}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(actuatorSubBus.Valve_6_Opening, PV_004.opening) annotation (Line(
      points={{335,-22},{360,-22},{360,-260},{272,-260},{272,-285.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(PV_050.port_b, m_Dch_Out.port_b)
    annotation (Line(points={{488,-72},{488,-74}}, color={0,127,255}));
  connect(m_Dch_Out.port_a, T_Dch_Out.port_b)
    annotation (Line(points={{488,-94},{488,-100}}, color={0,127,255}));
  connect(m_Chg_In.port_b, T_Chg_In.port_a)
    annotation (Line(points={{418,-94},{418,-100}}, color={0,127,255}));
  connect(FM_201.port_a, T_Dch_In.port_a)
    annotation (Line(points={{419,-230},{419,-229}}, color={0,127,255}));
  connect(sensorSubBus.T_discharge_outlet, T_Dch_Out.T) annotation (Line(
      points={{303,-22},{536,-22},{536,-110},{491.6,-110}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorSubBus.T_discharge_inlet, T_Dch_In.T) annotation (Line(
      points={{303,-22},{360,-22},{360,-220},{388,-220},{388,-219.5},{415.94,-219.5}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorSubBus.T_charge_outlet, T_Chg_Out.T) annotation (Line(
      points={{303,-22},{536,-22},{536,-219},{491.6,-219}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.T_charge_inlet, T_Chg_In.T) annotation (Line(
      points={{303,-22},{360,-22},{360,-110},{414.4,-110}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Charging_flowrate, FM_202.m_flow) annotation (Line(
      points={{303,-22},{536,-22},{536,-256},{491.6,-256},{491.6,-255}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Heater_flowrate, FM_003.m_flow) annotation (Line(
      points={{303,-22},{360,-22},{360,-260},{294,-260},{294,-276},{293,-276},{
          293,-287.12}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(pipe2.port_b,BOP_Mass_flow. port_a)
    annotation (Line(points={{408,-52},{430,-52}},
                                               color={0,127,255}));
  connect(BOP_Mass_flow.port_b,PV_006. port_a)
    annotation (Line(points={{450,-52},{460,-52}},
                                                 color={0,127,255}));
  connect(sensorSubBus.heater_BOP_massflow, BOP_Mass_flow.m_flow) annotation (
      Line(
      points={{303,-22},{440,-22},{440,-48.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_m_flow2.port_b,T_chiller_before. port_a)
    annotation (Line(points={{562,-90},{562,-100}},
                                                 color={0,127,255}));
  connect(T_chiller_before.port_b,pipe7. port_a)
    annotation (Line(points={{562,-126},{562,-138}},
                                                 color={0,127,255}));
  connect(pipe7.port_b,T_chiller_after. port_a) annotation (Line(points={{562,
          -154},{562,-180},{561,-180}},
                                     color={0,127,255}));
  connect(tank1.port_b, TC_003a.port_a)
    annotation (Line(points={{349,-52},{362,-52}}, color={0,127,255}));
  connect(TC_003a.port_b, pipe2.port_a)
    annotation (Line(points={{386,-52},{392,-52}}, color={0,127,255}));
  connect(sensorSubBus.Tin_TEDSide, TC_002.T) annotation (Line(
      points={{303,-22},{232.04,-22},{232.04,-167}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(MAGNET_TEDS_simpleHX1.port_b1, valve_TEDS_rp.port_a) annotation (Line(
        points={{246,-78},{0,-78},{0,-72},{4.44089e-16,-72},{4.44089e-16,-84}},
        color={0,127,255}));
  connect(TC_002.port_b, MAGNET_TEDS_simpleHX1.port_a2) annotation (Line(points
        ={{236,-155},{236,-86},{246,-86}}, color={0,127,255}));
  connect(MAGNET_TEDS_simpleHX1.port_b2, TC_003.port_a)
    annotation (Line(points={{266,-86},{290,-86}}, color={0,127,255}));
  connect(sensorSubBus.mflow_inside_MAGNET, mflow_inside_MAGNET.y) annotation (
      Line(
      points={{303,-22},{276,-22},{276,16},{222.9,16}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Tout_vc, Tout_vc.y) annotation (Line(
      points={{303,-22},{276,-22},{276,5},{222.9,5}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Tin_vc, Tin_vc.y) annotation (Line(
      points={{303,-22},{276,-22},{276,-7},{222.9,-7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_flow, m_flow_vc_TEDS.m_flow) annotation (Line(
      points={{303,-22},{-84,-22},{-84,-90},{-67.6,-90}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_TEDS_HX_Tin, T_vc_TEDS.T) annotation (Line(
      points={{303,-22},{-62,-22},{-62,-112}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.MAGNET_TEDS_HX_Tout, pT_TEDS_rp.T) annotation (Line(
      points={{303,-22},{32,-22},{32,-118},{-2,-118}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.MAGNET_valve3_opening, valve_TEDS_rp.opening)
    annotation (Line(
      points={{335,-22},{32,-22},{32,-90},{4.8,-90}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.MAGNET_valve_opening, valve_vc_TEDS.opening)
    annotation (Line(
      points={{335,-22},{-90,-22},{-90,-142},{-68.8,-142}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.MAGNET_flow_control, co.inputSignal) annotation (Line(
      points={{335,-22},{224,-22},{224,-302},{86,-302},{86,-335}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.GT_Power, GT_Power.y) annotation (Line(
      points={{303,-22},{276,-22},{276,26},{222.9,26}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.mf_vc_GT, mflow_vc_GT.m_flow) annotation (Line(
      points={{303,-22},{-174,-22},{-174,-76},{-210.4,-76}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.CW_control, m_source_cw.m_flow_in) annotation (Line(
      points={{335,-22},{-106,-22},{-106,-230},{-54,-230}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.MAGNET_valve2_opening, valve_vc_GT.opening)
    annotation (Line(
      points={{335,-22},{-174,-22},{-174,-124},{-209.2,-124}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Tout_TEDSide, TC_003.T) annotation (Line(
      points={{303,-22},{303,-81.68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus.Heater_Input, MAGNET_heater_input.y) annotation (Line(
      points={{303,-22},{276,-22},{276,36},{222.9,36}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Pump_Flow, P_001.in_p) annotation (Line(
      points={{335,-22},{360,-22},{360,-260},{336,-260},{336,-284.16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TEDS_Heat_Demand_kW.y[1],TEDS_Heat_Demand_W. u)
    annotation (Line(points={{296.7,-151},{305,-151}}, color={0,0,127}));
  connect(PCU_Elec_Demand_kW.y,PCU_Elec_Demand_W. u)
    annotation (Line(points={{296.7,-179},{305,-179}}, color={0,0,127}));
  connect(sensorSubBus,
    control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1_HW.sensorBus)
    annotation (Line(
      points={{303,-22},{372.956,-22},{372.956,2.40476}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus,
    control_System_Therminol_4_element_all_modes_MAGNET_GT_dyn_0_1_HW.actuatorBus)
    annotation (Line(
      points={{335,-22},{385.611,-22},{385.611,2.40476}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Valve_1_Opening, PV_049.opening) annotation (Line(
      points={{335,-22},{360,-22},{360,-66},{413.2,-66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Valve_3_Opening, PV_050.opening) annotation (Line(
      points={{335,-22},{508,-22},{508,-66},{492.8,-66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.Valve_2_Opening, PV_006.opening) annotation (Line(
      points={{335,-22},{466,-22},{466,-47.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(thermocline_Insulation_An.port_a, TC_201.port_b)
    annotation (Line(points={{454,-148},{454,-144}}, color={0,127,255}));
  connect(T_Chg_In.port_b, TC_201.port_a) annotation (Line(points={{418,-120},{
          418,-126},{454,-126}}, color={0,127,255}));
  connect(T_Dch_Out.port_a, TC_201.port_a) annotation (Line(points={{488,-120},
          {488,-126},{454,-126}}, color={0,127,255}));
  connect(thermocline_Insulation_An.port_b, TC_202.port_b)
    annotation (Line(points={{454,-180},{454,-182}}, color={0,127,255}));
  connect(T_Dch_In.port_b, TC_202.port_a) annotation (Line(points={{419,-210},{
          419,-200},{454,-200}}, color={0,127,255}));
  connect(T_Chg_Out.port_b, TC_202.port_a) annotation (Line(points={{488,-210},
          {488,-200},{454,-200}}, color={0,127,255}));
  connect(Chiller_Mass_Flow.ports[1], HX_001.port_a_tube) annotation (Line(
        points={{386,-358},{396,-358},{396,-338},{411,-338},{411,-337}}, color=
          {0,127,255}));
  connect(HX_001.port_b_tube, Ethylene_glycol_exit_temperature.port_a)
    annotation (Line(points={{442,-337},{442,-338},{460,-338},{460,-356}},
        color={0,127,255}));
  connect(Ethylene_glycol_exit_temperature.port_b,boundary1. ports[1])
    annotation (Line(points={{484,-356},{500,-356}}, color={0,127,255}));
  connect(HX_001.port_b_shell, nonLinear_Break.port_a) annotation (Line(points=
          {{411,-330.1},{412,-330},{408,-330}}, color={0,127,255}));
  connect(TC_006.port_a,nonLinear_Break2. port_a) annotation (Line(points={{358,
          -290},{356,-290}},    color={0,127,255}));
  connect(nonLinear_Break2.port_b, P_001.port_a)
    annotation (Line(points={{344,-290},{344,-290}}, color={0,127,255}));
  connect(PV_009.port_b,TC_006. port_b)
    annotation (Line(points={{430,-290},{382,-290}},
                                                   color={0,127,255}));
  connect(HX_001.port_a_shell, TC_004.port_a) annotation (Line(points={{442,
          -330.1},{444,-329},{451,-329}}, color={0,127,255}));
  connect(FM_002.port_b, TC_004.port_b)
    annotation (Line(points={{475,-329},{469,-329}}, color={0,127,255}));
  connect(nonLinear_Break3.port_b,PV_009. port_a) annotation (Line(points={{450,
          -290},{442,-290}},                      color={0,127,255}));
  connect(pipe3.port_b,nonLinear_Break3. port_a)
    annotation (Line(points={{526,-290},{462,-290}}, color={0,127,255}));
  connect(PV_008.port_a,pipe3. port_b) annotation (Line(points={{522,-296},{522,
          -290},{526,-290}}, color={0,127,255}));
  connect(pipe8.port_b, FM_002.port_a)
    annotation (Line(points={{502,-329},{496,-329}}, color={0,127,255}));
  connect(PV_008.port_b,pipe8. port_a) annotation (Line(points={{522,-308},{522,
          -329},{516,-329}}, color={0,127,255}));
  connect(const2.y, Chiller_Mass_Flow.m_flow_in)
    annotation (Line(points={{346.4,-350},{366,-350}}, color={0,0,127}));
  connect(T_chiller_after.port_b, pipe3.port_a) annotation (Line(points={{561,
          -206},{561,-290},{538,-290}}, color={0,127,255}));
  connect(sensorSubBus.TC006, TC_006.T) annotation (Line(
      points={{303,-22},{360,-22},{360,-268},{370,-268},{370,-285.68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.PV012, PV_012.opening) annotation (Line(
      points={{335,-22},{360,-22},{360,-260},{354,-260},{354,-325.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.PV008, PV_008.opening) annotation (Line(
      points={{335,-22},{580,-22},{580,-302},{526.8,-302}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus.PV009, PV_009.opening) annotation (Line(
      points={{335,-22},{360,-22},{360,-268},{436,-268},{436,-285.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TC_005.port_a, PV_012.port_a)
    annotation (Line(points={{366,-330},{360,-330}}, color={0,127,255}));
  connect(TC_005.port_b, nonLinear_Break.port_b)
    annotation (Line(points={{386,-330},{396,-330}}, color={0,127,255}));
  connect(PV_012.port_b, TC_006.port_b) annotation (Line(points={{348,-330},{
          342,-330},{342,-314},{406,-314},{406,-290},{382,-290}}, color={0,127,
          255}));
  connect(T_Chg_Out.port_a, PV_052.port_a)
    annotation (Line(points={{488,-228},{488,-234}}, color={0,127,255}));
  connect(PV_052.port_b, FM_202.port_a)
    annotation (Line(points={{488,-246},{488,-246}}, color={0,127,255}));
  connect(FM_202.port_b, PV_008.port_b) annotation (Line(points={{488,-264},{
          488,-314},{522,-314},{522,-308}}, color={0,127,255}));
  connect(pipe4.port_a, PV_004.port_a) annotation (Line(points={{236,-210},{236,
          -290},{266,-290}}, color={0,127,255}));
  connect(PV_004.port_b, FM_003.port_b)
    annotation (Line(points={{278,-290},{284,-290}}, color={0,127,255}));
  connect(FM_003.port_a, P_001.port_b)
    annotation (Line(points={{302,-290},{328,-290}}, color={0,127,255}));
  connect(PV_051.port_b, P_001.port_b) annotation (Line(points={{418,-266},{418,
          -276},{314,-276},{314,-290},{328,-290}}, color={0,127,255}));
  connect(sensorSubBus.Discharge_FlowRate, FM_201.m_flow) annotation (Line(
      points={{303,-22},{360,-22},{360,-240},{388,-240},{388,-239},{415.76,-239}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  annotation (experiment(
      StopTime=50400,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"),
    Diagram(coordinateSystem(extent={{-260,-420},{580,60}})),
    Icon(coordinateSystem(extent={{-260,-420},{580,60}})));
end TEDS_MAGNET_Integration_GT_0_1_bypass;
