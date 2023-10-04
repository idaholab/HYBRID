within NHES.ExperimentalSystems.MAGNET_TEDS;
model TEDS_MAGNET_Integration_3
  extends TRANSFORM.Icons.Example;

protected
  inner TRANSFORM.Fluid.SystemTF systemTF(
    showColors=true,
    val_min=data.T_hx_co,
    val_max=data.T_vc_rp)
    annotation (Placement(transformation(extent={{-68,-114},{-48,-94}})));

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
    m_flow_start_2=data.TEDS_nominal_flow_rate)
    annotation (Placement(transformation(extent={{292,-90},{272,-70}})));
protected
  inner TRANSFORM.Fluid.System system(
    p_ambient=18000,
    T_ambient=498.15,
    m_flow_start=0.84)
    annotation (Placement(transformation(extent={{-68,-148},{-48,-128}})));
protected
  NHES.ExperimentalSystems.MAGNET.Data.Data_base_An data
    annotation (Placement(transformation(extent={{-68,-80},{-48,-60}})));
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
    annotation (Placement(transformation(extent={{220,-250},{200,-230}})));
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
    annotation (Placement(transformation(extent={{164,-250},{184,-230}})));
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
    annotation (Placement(transformation(extent={{134,-252},{154,-272}})));
public
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_cw_hx(
    redeclare package Medium = Medium_cw,
    p_start=data.p_cw_hx,
    T_start=data.T_cw_hx,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{100,-248},{120,-228}})));
protected
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Cold_water_inlet(
    redeclare package Medium = Medium_cw,
    use_m_flow_in=true,
    m_flow=data.m_flow_cw,
    T=data.T_cw_hx,
    nPorts=1)
    annotation (Placement(transformation(extent={{18,-248},{38,-228}})));
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
    annotation (Placement(transformation(extent={{188,-288},{168,-268}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_co(
    redeclare package Medium = Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{122,-288},{102,-268}})));
protected
  TRANSFORM.Fluid.Valves.ValveIncompressible valve_ps(
    redeclare package Medium = Medium,
    dp_nominal(displayUnit="Pa") = 1e4,
    m_flow_nominal=1,
    opening_nominal=0.5)
    annotation (Placement(transformation(extent={{20,-288},{40,-268}})));
  Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
    annotation (Placement(transformation(extent={{-14,-268},{6,-248}})));
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
    annotation (Placement(transformation(extent={{134,-194},{154,-174}})));
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
    annotation (Placement(transformation(extent={{214,-210},{194,-190}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_hx_1(
    redeclare package Medium = Medium,
    p_start=data.p_rp_hx,
    T_start=data.T_rp_hx,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{192,-174},{212,-154}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_pipe_rp(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{106,-172},{126,-152}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_pipe_vc(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{98,-212},{78,-192}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_pipe(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    precision2=3,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-56,-172},{-36,-152}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_pipe_vc(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{24,-212},{4,-192}})));
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
        origin={-68,-192})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow)
                                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,-174})));
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
        origin={124,-342})));
public
  TRANSFORM.Fluid.Sensors.MassFlowRate mflow_MAGNET(
    redeclare package Medium = Medium,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=2)
    annotation (Placement(transformation(extent={{188,-352},{208,-332}})));
protected
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ps(
    redeclare package Medium = Medium,
    p=data.p_hx_co,
    T=data.T_ps,
    nPorts=1)
    annotation (Placement(transformation(extent={{-50,-288},{-30,-268}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
    redeclare package Medium = Medium,
    p_a_start=data.p_hx_co,
    T_a_start=data.T_hx_co,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_hx_co, length=data.length_hx_co))
    annotation (Placement(transformation(extent={{70,-352},{90,-332}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
    redeclare package Medium = Medium,
    p_a_start=data.p_co_rp,
    T_a_start=data.T_co_rp,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_co_rp, length=data.length_co_rp))
    annotation (Placement(transformation(extent={{214,-352},{234,-332}})));
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
    annotation (Placement(transformation(extent={{148,-352},{168,-332}})));
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
    annotation (Placement(transformation(extent={{-28,-172},{-8,-152}})));
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
    annotation (Placement(transformation(extent={{60,-212},{40,-192}})));
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
    annotation (Placement(transformation(extent={{218,-288},{198,-268}})));
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
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={8,-98})));
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
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={72,-112})));
public
  TRANSFORM.Fluid.Sensors.MassFlowRate m_flow_vc_TEDS(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={8,-54})));
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
    annotation (Placement(transformation(extent={{78,-172},{98,-152}})));
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
        origin={72,-138})));
protected
  Modelica.Blocks.Sources.RealExpression Tout_vc(y=pT_vc_pipe.T)
    annotation (Placement(transformation(extent={{176,-128},{194,-110}})));
  Modelica.Blocks.Sources.RealExpression Tin_vc(y=pT_pipe_vc.T)
    annotation (Placement(transformation(extent={{176,-140},{194,-122}})));
public
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_TEDS(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={8,-132})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_TEDS_rp(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=90,
        origin={72,-82})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_rp(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={52,-162})));
  TRANSFORM.Fluid.Sensors.MassFlowRate mflow_cw(
    redeclare package Medium = Medium_cw,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=3)
    annotation (Placement(transformation(extent={{62,-248},{82,-228}})));
  Modelica.Blocks.Sources.RealExpression mflow_inside_MAGNET(y=mflow_MAGNET.m_flow)
    annotation (Placement(transformation(extent={{176,-116},{194,-100}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate mflow_vc_rp(
    redeclare package Medium = Medium,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=3)
    annotation (Placement(transformation(extent={{16,-172},{36,-152}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.051,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=600, m_flow_nominal=0.689),
    T_start=data.T_hot_side)
    annotation (Placement(transformation(extent={{416,-74},{432,-58}})));
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
        origin={261,-217})));
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
        origin={586,-160})));
  TRANSFORM.Fluid.Volumes.ExpansionTank tank1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    A=1,
    V0=0.1,
    p_surface=system.p_ambient,
    p_start=system.p_start,
    level_start=0)
    annotation (Placement(transformation(extent={{348,-70},{368,-50}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    T_start=data.T_cold_side,
    precision=3)
    annotation (Placement(transformation(extent={{-12,-11},{12,11}},
        rotation=90,
        origin={262,-181})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort MAGNET_TEDS_HX_exit_Temp(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_hot_side,
    precision=3)
    annotation (Placement(transformation(extent={{312,-96},{336,-72}})));
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
        origin={528,-284})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={442,-104})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={586,-94})));
  TRANSFORM.Fluid.Sensors.MassFlowRate Chiller_Mass_flow_T66(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3)
    annotation (Placement(transformation(extent={{490,-274},{464,-294}})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=1e-2,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={442,-86})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve3(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={512,-76})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve5(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={438,-258})));
  TRANSFORM.Fluid.Valves.ValveLinear valve4(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={540,-270})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=false,
    m_flow_start=0.41,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={490,-66})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow4(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,-10},{12,10}},
        rotation=-90,
        origin={438,-240})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow6(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-11,-10},{11,10}},
        rotation=-90,
        origin={512,-243})));
  TRANSFORM.Fluid.Valves.ValveLinear Valve6(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    allowFlowReversal=true,
    m_flow_start=0.41,
    dp_nominal=3000,
    m_flow_nominal=0.840) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={320,-288})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow5(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_cold_side,
    precision=3)
          annotation (Placement(transformation(extent={{296,-296},{278,-280}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={512,-102})));
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
    annotation (Placement(transformation(extent={{352,-326},{340,-314}})));
  Modelica.Blocks.Sources.Constant const1(k=
        control_System_Therminol_4_element_all_modes_MAGNET.T_cold_design) annotation (
     Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={370,-320})));
  Modelica.Fluid.Sources.MassFlowSource_T Chiller_Mass_Flow(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    use_m_flow_in=true,
    m_flow=12.6,
    T=280.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{388,-356},{408,-336}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    p=300000,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{558,-320},{538,-340}})));
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
    T_b_start_tube=Cold_water_inlet.T,
    p_a_start_shell=system.p_ambient + 100,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=1.0),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=2.0))
    annotation (Placement(transformation(extent={{419,-306},{450,-276}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Ethylene_glycol_exit_temperature(
      redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{486,-342},{516,-318}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort HX_exit_temperature_T66(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(extent={{382,-274},{408,-302}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_charge_outlet(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=90,
        origin={512,-205})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_Charge_Inlet(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=-90,
        origin={442,-135})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_discharge_outlet(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,13},{12,-13}},
        rotation=90,
        origin={512,-133})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_discharge_Inlet(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision=
       3) annotation (Placement(transformation(
        extent={{-12,-13},{12,13}},
        rotation=90,
        origin={438,-205})));
  TRANSFORM.Fluid.Sensors.MassFlowRate BOP_Mass_flow(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_hot_side,
    precision=3)
          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={464,-66})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_inlet_HX(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-10,12},{10,-12}},
        rotation=0,
        origin={504,-284})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_before(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-13,12},{13,-12}},
        rotation=270,
        origin={586,-127})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort T_chiller_after(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3) annotation (Placement(transformation(
        extent={{-13,13},{13,-13}},
        rotation=270,
        origin={585,-207})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_after_tank(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_start=data.T_hot_side,
    precision=3)
          annotation (Placement(transformation(extent={{386,-78},{410,-54}})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster pump(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_input=true,
    p_nominal=system.p_ambient + 1e4)
    annotation (Placement(transformation(extent={{372,-280},{356,-296}})));
  Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand(y=pump.port_a.p +
        2.0e4)
    annotation (Placement(transformation(extent={{282,-320},{304,-298}})));
public
  Systems.Experiments.TEDS.Control_Systems.Control_System_Therminol_4_element_all_modes_MAGNET
    control_System_Therminol_4_element_all_modes_MAGNET(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    T_hot_design=598.15,
    T_cold_design=498.15)
    annotation (Placement(transformation(extent={{378,-22},{400,0}})));
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
    annotation (Placement(transformation(extent={{464,-184},{492,-152}})));
  Systems.Experiments.TEDS.BaseClasses.SignalSubBus_ActuatorInput actuatorSubBus1
    annotation (Placement(transformation(extent={{316,-48},{338,-24}})));
  Systems.Experiments.TEDS.BaseClasses.SignalSubBus_SensorOutput sensorSubBus1
    annotation (Placement(transformation(extent={{348,-48},{370,-24}})));
  Modelica.Blocks.Sources.CombiTimeTable Heater_Demand(table=[0.0,1; 1800,1;
        3600,1; 4800,1; 7200,1; 9000,1; 9600,1; 10800,0; 12000,0; 14400,1;
        18000,1], startTime=0)
    annotation (Placement(transformation(extent={{-62,-236},{-48,-222}})));
equation
  connect(sensor_hx_cw.port_b,boundary. ports[1])
    annotation (Line(points={{184,-240},{200,-240}},
                                               color={0,127,255}));
  connect(hx.port_a2,sensor_hx_cw. port_a) annotation (Line(points={{154,-258},
          {160,-258},{160,-240},{164,-240}},
                                  color={0,127,255}));
  connect(sensor_cw_hx.port_b,hx. port_b2) annotation (Line(points={{120,-238},
          {128,-238},{128,-258},{134,-258}},
                                  color={0,127,255}));
  connect(sensor_rp_hx_2.port_b,hx. port_b1) annotation (Line(points={{168,-278},
          {160,-278},{160,-266},{154,-266}},
                                          color={0,127,255}));
  connect(hx.port_a1,sensor_hx_co. port_a) annotation (Line(points={{134,-266},
          {128,-266},{128,-278},{122,-278}},
                                         color={0,127,255}));
  connect(sensor_hx_co.port_b,valve_ps. port_b)
    annotation (Line(points={{102,-278},{40,-278}}, color={0,127,255}));
  connect(opening_valve_tank.y,valve_ps. opening) annotation (Line(points={{7,-258},
          {30,-258},{30,-270}},        color={0,0,127}));
  connect(pT_co_rp_1.port_b, rp.port_a2) annotation (Line(points={{194,-200},{
          162,-200},{162,-188},{154,-188}},
                                          color={0,127,255}));
  connect(pT_vc_pipe_rp.port_b, rp.port_a1) annotation (Line(points={{126,-162},
          {128,-162},{128,-180},{134,-180}},    color={0,127,255}));
  connect(rp.port_b1, pT_rp_hx_1.port_a) annotation (Line(points={{154,-180},{
          184,-180},{184,-164},{192,-164}},  color={0,127,255}));
  connect(rp.port_b2, pT_rp_pipe_vc.port_a) annotation (Line(points={{134,-188},
          {104,-188},{104,-202},{98,-202}},     color={0,127,255}));
  connect(pT_pipe_vc.port_b, vc.port_a) annotation (Line(points={{4,-202},{-68,
          -202},{-68,-198}},        color={0,127,255}));
  connect(vc.port_b,resistance. port_a)
    annotation (Line(points={{-68,-186},{-68,-181}},
                                                   color={0,127,255}));
  connect(pT_vc_pipe.port_a, resistance.port_b) annotation (Line(points={{-56,
          -162},{-68,-162},{-68,-167}},        color={0,127,255}));
  connect(ps.ports[1],valve_ps. port_a) annotation (Line(points={{-30,-278},{20,
          -278}},                      color={0,127,255}));
  connect(pipe_hx_co.port_b,volume_co. port_a)
    annotation (Line(points={{90,-342},{118,-342}},color={0,127,255}));
  connect(pipe_hx_co.port_a,valve_ps. port_b) annotation (Line(points={{70,-342},
          {52,-342},{52,-278},{40,-278}},         color={0,127,255}));
  connect(mflow_MAGNET.port_b, pipe_co_rp.port_a)
    annotation (Line(points={{208,-342},{214,-342}}, color={0,127,255}));
  connect(pipe_co_rp.port_b, pT_co_rp_1.port_a) annotation (Line(points={{234,
          -342},{248,-342},{248,-200},{214,-200}},     color={0,127,255}));
  connect(volume_co.port_b,co. port_a)
    annotation (Line(points={{130,-342},{148,-342}},
                                                   color={0,127,255}));
  connect(co.port_b, mflow_MAGNET.port_a)
    annotation (Line(points={{168,-342},{188,-342}},color={0,127,255}));
  connect(pipe_vc_TEDS.port_a, pT_vc_pipe.port_b)
    annotation (Line(points={{-28,-162},{-36,-162}},   color={0,127,255}));
  connect(pT_pipe_vc.port_a, pipe_ins_rp_vc.port_b)
    annotation (Line(points={{24,-202},{40,-202}},   color={0,127,255}));
  connect(pT_rp_pipe_vc.port_b, pipe_ins_rp_vc.port_a)
    annotation (Line(points={{78,-202},{60,-202}}, color={0,127,255}));
  connect(sensor_rp_hx_2.port_a,pipe_ins_rp_hx. port_b)
    annotation (Line(points={{188,-278},{198,-278}},
                                                color={0,127,255}));
  connect(pipe_ins_rp_hx.port_a, pT_rp_hx_1.port_b) annotation (Line(points={{218,
          -278},{226,-278},{226,-164},{212,-164}},      color={0,127,255}));
  connect(T_vc_TEDS.port_b, m_flow_vc_TEDS.port_a)
    annotation (Line(points={{8,-88},{8,-64}},     color={0,127,255}));
  connect(T_vc_TEDS.port_a, valve_vc_TEDS.port_b) annotation (Line(points={{8,-108},
          {8,-126}},                                   color={0,127,255}));
  connect(valve_vc_TEDS.port_a, pipe_vc_TEDS.port_b) annotation (Line(points={{8,-138},
          {8,-162},{-8,-162}},          color={0,127,255}));
  connect(valve_TEDS_rp.port_b, pT_TEDS_rp.port_a) annotation (Line(points={{72,-88},
          {72,-102}},                               color={0,127,255}));
  connect(m_flow_vc_TEDS.port_b, MAGNET_TEDS_simpleHX.port_a1) annotation (
      Line(points={{8,-44},{338,-44},{338,-76},{292,-76}},
                                                   color={0,127,255}));
  connect(pipe_vc_rp.port_b, pT_vc_pipe_rp.port_a)
    annotation (Line(points={{98,-162},{106,-162}},color={0,127,255}));
  connect(pipe_vc_rp.port_a, valve_vc_rp.port_b)
    annotation (Line(points={{78,-162},{58,-162}}, color={0,127,255}));
  connect(mflow_cw.port_a, Cold_water_inlet.ports[1])
    annotation (Line(points={{62,-238},{38,-238}}, color={0,127,255}));
  connect(mflow_cw.port_b, sensor_cw_hx.port_a)
    annotation (Line(points={{82,-238},{100,-238}},color={0,127,255}));
  connect(mflow_vc_rp.port_a, pipe_vc_TEDS.port_b)
    annotation (Line(points={{16,-162},{-8,-162}},   color={0,127,255}));
  connect(mflow_vc_rp.port_b, valve_vc_rp.port_a)
    annotation (Line(points={{36,-162},{46,-162}},   color={0,127,255}));
  connect(volume_MT.port_a, pT_TEDS_rp.port_b) annotation (Line(points={{72,-132},
          {72,-122}},
        color={0,127,255}));
  connect(volume_MT.port_b, valve_vc_rp.port_b) annotation (Line(points={{72,-144},
          {72,-162},{58,-162}},                  color={0,127,255}));
  connect(pipe4.port_b,sensor_T. port_a)
    annotation (Line(points={{261,-208},{261,-200.5},{262,-200.5},{262,-193}},
                                                         color={0,127,255}));
  connect(MAGNET_TEDS_HX_exit_Temp.port_b,tank1. port_a) annotation (Line(
        points={{336,-84},{351,-84},{351,-66}},color={0,127,255}));
  connect(pipe2.port_b,Valve1. port_a)
    annotation (Line(points={{432,-66},{442,-66},{442,-80}},
                                                       color={0,127,255}));
  connect(Valve1.port_b,sensor_m_flow. port_a)
    annotation (Line(points={{442,-92},{442,-94}},
                                               color={0,127,255}));
  connect(Valve3.port_a,sensor_m_flow2. port_a) annotation (Line(points={{512,-70},
          {512,-66},{586,-66},{586,-84}},
                                       color={0,127,255}));
  connect(Valve2.port_b,sensor_m_flow2. port_a)
    annotation (Line(points={{496,-66},{586,-66},{586,-84}},
                                                          color={0,127,255}));
  connect(Valve5.port_a,sensor_m_flow4. port_b)
    annotation (Line(points={{438,-252},{438,-252}},
                                                 color={0,127,255}));
  connect(valve4.port_a,sensor_m_flow6. port_b) annotation (Line(points={{540,
          -264},{540,-260},{512,-260},{512,-254}},
                                          color={0,127,255}));
  connect(valve4.port_b,pipe3. port_a) annotation (Line(points={{540,-276},{540,
          -284},{534,-284}},
                      color={0,127,255}));
  connect(Valve5.port_b,Valve6. port_b) annotation (Line(points={{438,-264},{
          438,-268},{340,-268},{340,-288},{326,-288}},
                                      color={0,127,255}));
  connect(Valve6.port_a,sensor_m_flow5. port_a)
    annotation (Line(points={{314,-288},{296,-288}},
                                                   color={0,127,255}));
  connect(sensor_m_flow5.port_b,pipe4. port_a) annotation (Line(points={{278,
          -288},{261,-288},{261,-226}},
                               color={0,127,255}));
  connect(sensorSubBus1.Valve_1_Opening, Valve1.opening) annotation (Line(
      points={{359,-36},{384,-36},{384,-86},{437.2,-86}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorSubBus1.Valve_2_Opening, Valve2.opening) annotation (Line(
      points={{359,-36},{490,-36},{490,-61.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorSubBus1.Valve_3_Opening, Valve3.opening) annotation (Line(
      points={{359,-36},{528,-36},{528,-76},{516.8,-76}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorSubBus1.Valve_4_Opening, valve4.opening) annotation (Line(
      points={{359,-36},{560,-36},{560,-270},{544.8,-270}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorSubBus1.Valve_5_Opening, Valve5.opening) annotation (Line(
      points={{359,-36},{384,-36},{384,-258},{433.2,-258}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorSubBus1.Valve_6_Opening, Valve6.opening) annotation (Line(
      points={{359,-36},{384,-36},{384,-258},{320,-258},{320,-283.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Valve3.port_b,sensor_m_flow3. port_b)
    annotation (Line(points={{512,-82},{512,-92}},
                                                 color={0,127,255}));
  connect(const1.y,MassFlow_Control. u_s)
    annotation (Line(points={{365.6,-320},{353.2,-320}},
                                                     color={0,0,127}));
  connect(Chiller_Mass_Flow.ports[1],Glycol_HX. port_a_tube) annotation (Line(
        points={{408,-346},{414,-346},{414,-291},{419,-291}},
                                                          color={0,127,255}));
  connect(Glycol_HX.port_b_tube,Ethylene_glycol_exit_temperature. port_a)
    annotation (Line(points={{450,-291},{462,-291},{462,-330},{486,-330}},color=
         {0,127,255}));
  connect(Ethylene_glycol_exit_temperature.port_b,boundary1. ports[1])
    annotation (Line(points={{516,-330},{538,-330}}, color={0,127,255}));
  connect(MassFlow_Control.y,Chiller_Mass_Flow. m_flow_in) annotation (Line(
        points={{339.4,-320},{336,-320},{336,-338},{388,-338}},color={0,0,127}));
  connect(Chiller_Mass_flow_T66.port_b,Glycol_HX. port_a_shell) annotation (
      Line(points={{464,-284},{450,-284},{450,-284.1}},
                                                      color={0,127,255}));
  connect(Glycol_HX.port_b_shell,HX_exit_temperature_T66. port_b) annotation (
      Line(points={{419,-284.1},{408,-284.1},{408,-288}},
                                                       color={0,127,255}));
  connect(MassFlow_Control.u_m,HX_exit_temperature_T66. T) annotation (Line(
        points={{346,-327.2},{346,-328},{395,-328},{395,-293.04}},
                                                                 color={0,0,127}));
  connect(sensor_m_flow3.port_a,T_discharge_outlet. port_b)
    annotation (Line(points={{512,-112},{512,-121}},
                                                 color={0,127,255}));
  connect(sensor_m_flow.port_b,T_Charge_Inlet. port_a)
    annotation (Line(points={{442,-114},{442,-123}},
                                               color={0,127,255}));
  connect(sensor_m_flow6.port_a,T_charge_outlet. port_a)
    annotation (Line(points={{512,-232},{512,-217}},
                                                   color={0,127,255}));
  connect(sensor_m_flow4.port_a,T_discharge_Inlet. port_a)
    annotation (Line(points={{438,-228},{438,-217}},
                                                 color={0,127,255}));
  connect(actuatorSubBus1.T_discharge_outlet, T_discharge_outlet.T) annotation (
     Line(
      points={{327,-36},{560,-36},{560,-133},{516.68,-133}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.T_discharge_inlet, T_discharge_Inlet.T) annotation (
      Line(
      points={{327,-36},{384,-36},{384,-205},{433.32,-205}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.T_charge_outlet, T_charge_outlet.T) annotation (Line(
      points={{327,-36},{560,-36},{560,-205},{516.68,-205}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.T_charge_inlet, T_Charge_Inlet.T) annotation (Line(
      points={{327,-36},{384,-36},{384,-135},{437.32,-135}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.Charging_flowrate, sensor_m_flow6.m_flow) annotation (
     Line(
      points={{327,-36},{560,-36},{560,-243},{515.6,-243}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.Discharge_FlowRate, sensor_m_flow3.m_flow)
    annotation (Line(
      points={{327,-36},{560,-36},{560,-102},{515.6,-102}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.Total_Mass_Flow_System, Chiller_Mass_flow_T66.m_flow)
    annotation (Line(
      points={{327,-36},{598,-36},{598,-302},{477,-302},{477,-287.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.Heater_flowrate, sensor_m_flow5.m_flow) annotation (
      Line(
      points={{327,-36},{384,-36},{384,-258},{287,-258},{287,-285.12}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(pipe2.port_b,BOP_Mass_flow. port_a)
    annotation (Line(points={{432,-66},{454,-66}},
                                               color={0,127,255}));
  connect(BOP_Mass_flow.port_b,Valve2. port_a)
    annotation (Line(points={{474,-66},{484,-66}},
                                                 color={0,127,255}));
  connect(actuatorSubBus1.heater_BOP_massflow, BOP_Mass_flow.m_flow)
    annotation (Line(
      points={{327,-36},{464,-36},{464,-62.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(pipe3.port_b,T_inlet_HX. port_b)
    annotation (Line(points={{522,-284},{514,-284}}, color={0,127,255}));
  connect(T_inlet_HX.port_a,Chiller_Mass_flow_T66. port_a)
    annotation (Line(points={{494,-284},{490,-284}}, color={0,127,255}));
  connect(sensor_m_flow2.port_b,T_chiller_before. port_a)
    annotation (Line(points={{586,-104},{586,-114}},
                                                 color={0,127,255}));
  connect(T_chiller_before.port_b,pipe7. port_a)
    annotation (Line(points={{586,-140},{586,-152}},
                                                 color={0,127,255}));
  connect(pipe7.port_b,T_chiller_after. port_a) annotation (Line(points={{586,
          -168},{586,-194},{585,-194}},
                                     color={0,127,255}));
  connect(T_chiller_after.port_b,pipe3. port_a) annotation (Line(points={{585,
          -220},{585,-284},{534,-284}},color={0,127,255}));
  connect(tank1.port_b,sensor_after_tank. port_a)
    annotation (Line(points={{365,-66},{386,-66}},         color={0,127,255}));
  connect(sensor_after_tank.port_b,pipe2. port_a)
    annotation (Line(points={{410,-66},{416,-66}},
                                               color={0,127,255}));
  connect(HX_exit_temperature_T66.port_a,pump. port_a) annotation (Line(points={{382,
          -288},{372,-288}},                         color={0,127,255}));
  connect(Valve6.port_b,pump. port_b)
    annotation (Line(points={{326,-288},{356,-288}},color={0,127,255}));
  connect(Heater_BOP_Demand.y,pump. in_p) annotation (Line(points={{305.1,-309},
          {364,-309},{364,-293.84}},
                                 color={0,0,127}));
  connect(sensorSubBus1, control_System_Therminol_4_element_all_modes_MAGNET.sensorSubBus)
    annotation (Line(
      points={{359,-36},{391.444,-36},{391.444,-21.7963}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1, control_System_Therminol_4_element_all_modes_MAGNET.actuatorSubBus)
    annotation (Line(
      points={{327,-36},{387.656,-36},{387.656,-21.7963}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.Tin_TEDSide, sensor_T.T) annotation (Line(
      points={{327,-36},{258.04,-36},{258.04,-181}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(thermocline_Insulation_An.port_a,T_Charge_Inlet. port_b) annotation (
      Line(points={{478,-152},{478,-148},{442,-148},{442,-147}},
        color={0,127,255}));
  connect(thermocline_Insulation_An.port_a,T_discharge_outlet. port_a)
    annotation (Line(points={{478,-152},{478,-148},{512,-148},{512,-145}},
                color={0,127,255}));
  connect(T_discharge_Inlet.port_b,thermocline_Insulation_An. port_b)
    annotation (Line(points={{438,-193},{438,-186},{478,-186},{478,-184}},
                     color={0,127,255}));
  connect(thermocline_Insulation_An.port_b,T_charge_outlet. port_b) annotation (
     Line(points={{478,-184},{478,-186},{512,-186},{512,-193}},
                                                            color={0,127,255}));
  connect(MAGNET_TEDS_simpleHX.port_b1, valve_TEDS_rp.port_a)
    annotation (Line(points={{272,-76},{72,-76}}, color={0,127,255}));
  connect(sensor_T.port_b, MAGNET_TEDS_simpleHX.port_a2) annotation (Line(
        points={{262,-169},{262,-84},{272,-84}}, color={0,127,255}));
  connect(MAGNET_TEDS_simpleHX.port_b2, MAGNET_TEDS_HX_exit_Temp.port_a)
    annotation (Line(points={{292,-84},{312,-84}}, color={0,127,255}));
  connect(actuatorSubBus1.mflow_inside_MAGNET, mflow_inside_MAGNET.y)
    annotation (Line(
      points={{327,-36},{224,-36},{224,-108},{194.9,-108}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.Tout_vc, Tout_vc.y) annotation (Line(
      points={{327,-36},{224,-36},{224,-119},{194.9,-119}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.Tin_vc, Tin_vc.y) annotation (Line(
      points={{327,-36},{224,-36},{224,-131},{194.9,-131}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.MAGNET_flow, m_flow_vc_TEDS.m_flow) annotation (Line(
      points={{327,-36},{4.4,-36},{4.4,-54}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.MAGNET_TEDS_HX_Tin, T_vc_TEDS.T) annotation (Line(
      points={{327,-36},{-36,-36},{-36,-92},{6,-92}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.MAGNET_TEDS_HX_Tout, pT_TEDS_rp.T) annotation (Line(
      points={{327,-36},{122,-36},{122,-118},{74,-118}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorSubBus1.mf_vc_rp, mflow_vc_rp.m_flow) annotation (Line(
      points={{327,-36},{26,-36},{26,-158.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus1.MAGNET_valve3_opening, valve_TEDS_rp.opening)
    annotation (Line(
      points={{359,-36},{122,-36},{122,-82},{76.8,-82}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus1.MAGNET_valve_opening, valve_vc_TEDS.opening)
    annotation (Line(
      points={{359,-36},{-36,-36},{-36,-132},{3.2,-132}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus1.MAGNET_valve2_opening, valve_vc_rp.opening) annotation (
     Line(
      points={{359,-36},{52,-36},{52,-157.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus1.CW_control, Cold_water_inlet.m_flow_in) annotation (
      Line(
      points={{359,-36},{-36,-36},{-36,-230},{18,-230}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorSubBus1.MAGNET_flow_control, co.inputSignal) annotation (Line(
      points={{359,-36},{248,-36},{248,-316},{158,-316},{158,-335}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (experiment(
      StopTime=18000,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-80,-360},{620,0}})),
    Icon(coordinateSystem(extent={{-80,-360},{620,0}})));
end TEDS_MAGNET_Integration_3;
