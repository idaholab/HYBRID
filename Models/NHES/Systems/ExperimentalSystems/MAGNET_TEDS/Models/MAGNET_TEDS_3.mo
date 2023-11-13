within NHES.Systems.ExperimentalSystems.MAGNET_TEDS.Models;
model MAGNET_TEDS_3
  extends TRANSFORM.Icons.Example;

protected
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Medium_cw,
    p=data.p_hx_cw,
    T=data.T_hx_cw,                                       nPorts=1)
    annotation (Placement(transformation(extent={{56,2},{36,22}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_cw(
    redeclare package Medium = Medium_cw,
    p_start=data.p_hx_cw,
    T_start=data.T_hx_cw,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-24,2},{-4,22}})));
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
    annotation (Placement(transformation(extent={{-54,0},{-34,-20}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_cw_hx(
    redeclare package Medium = Medium_cw,
    p_start=data.p_cw_hx,
    T_start=data.T_cw_hx,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-88,4},{-68,24}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = Medium_cw,
    m_flow=data.m_flow_cw,
    T=data.T_cw_hx,
      nPorts=1)
    annotation (Placement(transformation(extent={{-170,4},{-150,24}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_rp_hx_2(
    redeclare package Medium = Medium,
    p_start=data.p_rp_hx,
    T_start=data.T_rp_hx,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{0,-36},{-20,-16}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_hx_co(
    redeclare package Medium = Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-66,-36},{-86,-16}})));
  TRANSFORM.Fluid.Valves.ValveIncompressible valve_ps(
    redeclare package Medium = Medium,
    dp_nominal(displayUnit="Pa") = 1e4,
    m_flow_nominal=1,
    opening_nominal=0.5)
    annotation (Placement(transformation(extent={{-168,-36},{-148,-16}})));
  Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
    annotation (Placement(transformation(extent={{-202,-16},{-182,4}})));
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
    annotation (Placement(transformation(extent={{-54,58},{-34,78}})));
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
    annotation (Placement(transformation(extent={{26,42},{6,62}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_hx_1(
    redeclare package Medium = Medium,
    p_start=data.p_rp_hx,
    T_start=data.T_rp_hx,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{4,78},{24,98}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_pipe_rp(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-88,80},{-68,100}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_rp_pipe_vc(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-90,40},{-110,60}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_vc_pipe(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-218,80},{-198,100}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort pT_pipe_vc(
    redeclare package Medium = Medium,
    p_start=data.p_rp_vc,
    T_start=data.T_rp_vc,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-164,40},{-184,60}})));
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
        origin={-236,60})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow)
                                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-236,78})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume_co(redeclare package Medium =
        Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
                redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.01),
    Q_gen=0)      "12022.6"
                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-64,-90})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_co_rp_2(
    redeclare package Medium = Medium,
    p_start=data.p_co_rp,
    T_start=data.T_co_rp,
    precision=2)
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ps(
    redeclare package Medium = Medium,
    p=data.p_hx_co,
    T=data.T_ps,
    nPorts=1)
    annotation (Placement(transformation(extent={{-238,-36},{-218,-16}})));
protected
  inner TRANSFORM.Fluid.SystemTF systemTF(
    showColors=true,
    val_min=data.T_hx_co,
    val_max=data.T_vc_rp)
    annotation (Placement(transformation(extent={{74,184},{94,204}})));
public
  NHES.Systems.ExperimentalSystems.MAGNET.Data.Summary summary(
    Ts={sensor_cw_hx.T,sensor_rp_hx_2.T,sensor_hx_co.T,pT_co_rp_1.T,pT_rp_hx_1.T,
        pT_vc_pipe_rp.T,pT_rp_pipe_vc.T,pT_vc_pipe.T,TM_HX_exit_Temp.T},
    ps={sensor_cw_hx.p,sensor_rp_hx_2.p,sensor_hx_co.p,pT_co_rp_1.p,pT_rp_hx_1.p,
        pT_vc_pipe_rp.p,pT_rp_pipe_vc.p,pT_vc_pipe.p},
    m_flows={sensor_co_rp_2.m_flow,TEDS_flow_rate.m_flow,m_flow_vc_TEDS.m_flow},
    Q_flows={vc.Q_gen/1e3})
    annotation (Placement(transformation(extent={{74,160},{94,180}})));

protected
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_TEDS(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-157,131})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_TEDS_rp(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{7,7},{-7,-7}},
        rotation=90,
        origin={-101,187})));
  TRANSFORM.Fluid.Valves.ValveLinear valve_vc_rp(
    redeclare package Medium = Medium,
    dp_nominal=3000,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-125,89})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=vc.Q_gen)
    annotation (Placement(transformation(extent={{-92,256},{-72,276}})));
protected
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TM_HX_exit_Temp(redeclare package
      Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      precision=3)
    annotation (Placement(transformation(extent={{-196,216},{-176,236}})));
public
  TRANSFORM.Controls.LimPID TEDS_MassFlowControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    with_FF=false,
    k=-0.000025,
    Ti=5,
    k_s=1,
    k_m=1,
    yMax=0.689,
    yMin=0.001,
    Nd=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0.689)
    annotation (Placement(transformation(extent={{-40,246},{-20,266}})));
  Modelica.Blocks.Sources.Step step(
    height=-50e3,
    offset=250e3,
    startTime=5000)
    annotation (Placement(transformation(extent={{-280,80},{-260,100}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-100e3,
    duration=2500,
    offset=250e3,
    startTime=5000)
    annotation (Placement(transformation(extent={{-280,120},{-260,140}})));
  Modelica.Blocks.Sources.Step step1(
    height=0,
    offset=data.m_flow,
    startTime=5000)
    annotation (Placement(transformation(extent={{-120,-66},{-100,-46}})));
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
    m_flow_start_1=data.m_flow/2,
    p_a_start_2=data.p_TEDS_in,
    p_b_start_2=data.p_TEDS_out,
    T_a_start_2=data.T_cold_side,
    T_b_start_2=data.T_hot_side,
    m_flow_start_2=boundary_TEDS_in.m_flow)
    annotation (Placement(transformation(extent={{-148,228},{-128,208}})));
protected
  inner TRANSFORM.Fluid.System system(
    p_ambient=18000,
    T_ambient=498.15,
    m_flow_start=0.84)
    annotation (Placement(transformation(extent={{74,246},{94,266}})));
protected
  NHES.Systems.ExperimentalSystems.MAGNET.Data.Data_base_An data
    annotation (Placement(transformation(extent={{74,220},{94,240}})));
protected
  package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
  package Medium_cw = Modelica.Media.Water.StandardWater;

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
    redeclare package Medium = Medium,
    p_a_start=data.p_hx_co,
    T_a_start=data.T_hx_co,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_hx_co, length=data.length_hx_co))
    annotation (Placement(transformation(extent={{-118,-100},{-98,-80}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
    redeclare package Medium = Medium,
    p_a_start=data.p_co_rp,
    T_a_start=data.T_co_rp,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_co_rp, length=data.length_co_rp))
    annotation (Placement(transformation(extent={{48,-100},{68,-80}})));
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
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
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
    annotation (Placement(transformation(extent={{-184,80},{-164,100}})));
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
    annotation (Placement(transformation(extent={{-128,40},{-148,60}})));
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
    annotation (Placement(transformation(extent={{46,-36},{26,-16}})));
protected
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary_TEDS_out(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p=system.p_ambient,
    T=data.T_hot_side,
    nPorts=1)
    annotation (Placement(transformation(extent={{-284,216},{-264,236}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_TEDS_in(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_m_flow_in=true,
    m_flow=0.689,
    T=data.T_cold_side,
    nPorts=1)
    annotation (Placement(transformation(extent={{-70,212},{-90,232}})));
  Modelica.Blocks.Sources.Constant TEDS_Temp_SP(k=data.T_hot_side)
    annotation (Placement(transformation(extent={{-120,246},{-100,266}})));
  Modelica.Blocks.Sources.Constant opening_valve_tank2(k=1)
    annotation (Placement(transformation(extent={{-38,176},{-58,196}})));
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
        origin={-158,164})));
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
        origin={-100,114})));
  TRANSFORM.Fluid.Sensors.MassFlowRate TEDS_flow_rate(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p_start=data.p_TEDS_out,
    T_start=data.T_hot_side,
    precision=2)
    annotation (Placement(transformation(extent={{-246,216},{-226,236}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate m_flow_vc_TEDS(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    precision=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-158,198})));
  Modelica.Blocks.Sources.Constant opening_valve_tank1(k=1)
    annotation (Placement(transformation(extent={{-202,122},{-182,142}})));
  Modelica.Blocks.Sources.Constant opening_valve_tank3(k=0)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=90,
        origin={-126,144})));
protected
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(table=[0,0; 60.037,
        4.6; 120.102,15.5; 180.084,12.5; 240.044,11.2; 300.005,12.3; 360.053,
        12.3; 420.031,12.3; 480.073,12.7; 540.034,12.5; 600.1,12.9; 660.04,
        13.1; 720.053,13.1; 780.104,14.9; 840.009,14.9; 900.102,13.1; 960.017,
        13.4; 1020.048,11.8; 1080.101,15.5; 1140.049,13.6; 1200.034,13.6;
        1260.061,13.8; 1320.034,13.8; 1380.071,14; 1440.045,14; 1500.036,14;
        1560.072,13.8; 1620.051,14; 1680.043,14.4; 1740.005,14.8; 1800.046,
        13.1; 1860.05,13.1; 1920.049,12.9; 1980.001,14.8; 2040.038,14.8;
        2100.029,10.6; 2160.022,2.1; 2220.024,2.1; 2280.022,2.8; 2340.009,2.4;
        2400.054,2.7; 2460.095,2.6; 2520.051,2.6; 2580.027,2.3; 2640.006,2.4;
        2700.069,2.2; 2760.052,2.3; 2820.005,13.8; 2880.091,16.2; 2940.004,
        16.6; 3000.104,15.5; 3060.098,15.7; 3120.006,15.9; 3180.088,16.4;
        3240.023,17.9; 3300.085,16.4; 3360,16.4; 3420.08,16.6; 3480.011,16.4;
        3540.045,7.2; 3600.004,2.9; 3660.056,2.4; 3720.046,3.7; 3780.006,3.3;
        3840.06,3.1; 3900.017,3.4; 3960.022,1.3; 4020.025,3.2; 4080.071,3;
        4140.062,3.1; 4200.044,3.1; 4260.064,3.1; 4320.004,5.1; 4380.049,5.1;
        4440.066,3.9; 4500.078,5.6; 4560.066,5.4; 4620.067,5.9; 4680.066,5.8;
        4740.042,5.8; 4800.06,5.9; 4860.063,6; 4920.016,5.8; 4980.064,5.6;
        5040.008,5.9; 5100.052,6; 5160.084,4.1; 5220.067,6.1; 5280.06,6.1;
        5340.057,5.9; 5400.037,6.4; 5460.098,6.2; 5520.065,6.2; 5580.075,6.3;
        5640.084,6.3; 5700.07,4.4; 5760.079,6.2; 5820.01,6.5; 5880.016,6.3;
        5940.03,6.3; 6000.077,6.3; 6060.054,4.6; 6120.051,6.6; 6180.064,6.5;
        6240.028,6.5; 6300.007,6.5; 6360.029,6.4; 6420.027,6.6; 6480.06,6.7;
        6540.037,6.8; 6600.102,5.1; 6660.008,6.6; 6720.087,4.9; 6780.045,5;
        6840.093,6.9; 6900.03,6.8; 6960.032,6.8; 7020.073,5.1; 7080.016,6.9;
        7140.014,6.9; 7200.001,7; 7260.097,7; 7320.05,7; 7380.005,6.9;
        7440.073,7.1; 7500.025,7.1; 7560.028,7.1; 7620.033,7.1; 7680.087,7.1;
        7740.006,6.9; 7800.018,7.4; 7860.076,5.5; 7920.068,7.3; 7980.034,7.1;
        8040.079,5.6; 8100.045,7.3; 8160.033,7.1; 8220.024,7.3; 8280.023,5.4;
        8340.102,5.6; 8400.029,7.4; 8460.068,7.6; 8520.075,7.6; 8580.089,7.7;
        8640.018,7.7; 8700.062,7.5; 8760.035,7.9; 8820.051,6.5; 8880.026,6.6;
        8940.084,5.7; 9000.083,5.1; 9060.067,4.9; 9120.004,4.8; 9180.009,4.9;
        9240.017,4.7; 9300.034,4.8; 9360.029,4.8; 9420.037,4.9; 9480.03,4.8;
        9540.085,4.8; 9600.001,4.8; 9660.002,0; 9720.008,0; 9780.021,0;
        9840.026,0; 9900.107,0; 9960.082,0; 10020.102,0; 10080.057,0;
        10140.046,0; 10200.023,0; 10260.022,0; 10320.031,0; 10380.067,0;
        10440.067,0; 10500.014,0; 10560.005,0; 10620.033,0; 10680.079,0;
        10740.041,0; 10800.087,0; 10860,0; 10920.101,0; 10980.009,0;
        11040.052,0; 11100.055,0; 11160.013,0; 11220.056,0; 11280.088,0;
        11340.092,0; 11400.08,0; 11460.084,0; 11520.065,0; 11580.049,0;
        11640.019,0; 11700.041,0; 11760.021,0; 11820.093,0; 11880.074,0;
        11940.02,0; 12000.03,0; 12060.016,0; 12120.007,0; 12180.093,0;
        12240.046,0; 12300.093,0; 12360.065,0; 12420.094,0; 12480.049,0;
        12540.058,0; 12600.025,0.7; 12660.036,3.6; 12720.045,3.5; 12780.012,4;
        12840.059,2.1; 12900.102,1.9; 12960.007,3.4; 13020.063,3.4; 13080.096,
        3.4; 13140.097,3.3; 13200.069,3.4; 13260.095,3.2; 13320.07,3.3;
        13380.047,3.3; 13440.045,3.2; 13500.019,5.2; 13560.1,3.3; 13620.087,
        3.1; 13680.02,3.4; 13740.054,5.1; 13800.07,3.2; 13860.082,3.2;
        13920.035,3.2; 13980.006,3.4; 14040.067,3.2; 14100.06,3.2; 14160.1,
        3.2; 14220.062,3.2; 14280.075,3.2; 14340.095,3.2; 14400.045,3.2;
        14460.078,3.2; 14520.031,3.2; 14580.023,3.2; 14640.075,3.3; 14700.04,
        3.3; 14760.064,3; 14820.07,3; 14880.007,2.9; 14940.071,3.1; 15000.09,
        3.1; 15060.084,29.2; 15120.028,2.1; 15180.081,0; 15240.094,0;
        15300.085,0; 15360.016,0; 15420.034,0; 15480.101,0; 15540.005,0;
        15600.092,0; 15660.037,0; 15720.058,0; 15780.026,0; 15840.049,0;
        15900.057,0; 15960.04,0; 16020.1,0; 16080.085,0; 16140.048,0; 16200,0;
        16260.014,0; 16320.025,0; 16380.073,0; 16440.033,0; 16500.008,0;
        16560.089,0; 16620.078,1.3; 16680.043,3; 16740.083,2.4; 16800.008,3.6;
        16860.093,2.1; 16920.024,3.8; 16980.057,3.7; 17040.081,0; 17100.028,0;
        17160.039,0; 17220.018,0; 17280.081,0; 17340.028,0; 17400.09,0;
        17460.039,0; 17520.06,0; 17580.086,0; 17640.061,33.8; 17700.01,7.4;
        17760.103,0; 17820.062,13.9; 17880.037,16.7; 17940.06,17.9; 18000.035,
        18.7; 18060.076,18.7; 18120.057,19.2; 18180.013,7.4; 18240.098,3.1;
        18300.063,3.5; 18360.074,0.9; 18420.076,6.4; 18480.001,6.6; 18540.093,
        5.3; 18600.009,7.1; 18660.02,7.1; 18720.11,7.1; 18780.009,5.4;
        18840.035,7.2; 18900.045,7.2; 18960.088,7.2; 19020.04,7.4; 19080.096,
        7.4; 19140.036,7.4; 19200.098,7.5; 19260.102,7.5; 19320.039,5.6;
        19380.001,7.6; 19440.041,7.4; 19500.014,5.9; 19560.093,7.8; 19620.098,
        7.9; 19680.043,7.9; 19740.024,7.9; 19800.035,7.9; 19860.04,8;
        19920.075,6.4; 19980.01,8.2; 20040.035,8.2; 20100.081,6.3; 20160.06,8;
        20220.062,8.3; 20280.08,8.3; 20340.004,6.6; 20400.033,6.8; 20460.004,
        0; 20520.061,0], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-280,40},{-260,60}})));
equation
  connect(sensor_hx_cw.port_b, boundary.ports[1])
    annotation (Line(points={{-4,12},{36,12}}, color={0,127,255}));
  connect(hx.port_a2, sensor_hx_cw.port_a) annotation (Line(points={{-34,-6},{-28,
          -6},{-28,12},{-24,12}}, color={0,127,255}));
  connect(sensor_cw_hx.port_b, hx.port_b2) annotation (Line(points={{-68,14},{-60,
          14},{-60,-6},{-54,-6}}, color={0,127,255}));
  connect(boundary1.ports[1], sensor_cw_hx.port_a)
    annotation (Line(points={{-150,14},{-88,14}}, color={0,127,255}));
  connect(sensor_rp_hx_2.port_b, hx.port_b1) annotation (Line(points={{-20,-26},
          {-28,-26},{-28,-14},{-34,-14}}, color={0,127,255}));
  connect(hx.port_a1, sensor_hx_co.port_a) annotation (Line(points={{-54,-14},{
          -60,-14},{-60,-26},{-66,-26}}, color={0,127,255}));
  connect(sensor_hx_co.port_b, valve_ps.port_b)
    annotation (Line(points={{-86,-26},{-148,-26}}, color={0,127,255}));
  connect(opening_valve_tank.y, valve_ps.opening) annotation (Line(points={{-181,-6},
          {-120,-6},{-120,-18},{-158,-18}},
                                       color={0,0,127}));
  connect(pT_co_rp_1.port_b, rp.port_a2) annotation (Line(points={{6,52},{-26,
          52},{-26,64},{-34,64}}, color={0,127,255}));
  connect(pT_vc_pipe_rp.port_b, rp.port_a1) annotation (Line(points={{-68,90},
          {-60,90},{-60,72},{-54,72}}, color={0,127,255}));
  connect(rp.port_b1, pT_rp_hx_1.port_a) annotation (Line(points={{-34,72},{-4,
          72},{-4,88},{4,88}}, color={0,127,255}));
  connect(rp.port_b2, pT_rp_pipe_vc.port_a) annotation (Line(points={{-54,64},
          {-84,64},{-84,50},{-90,50}}, color={0,127,255}));
  connect(pT_pipe_vc.port_b, vc.port_a) annotation (Line(points={{-184,50},{-236,
          50},{-236,54}}, color={0,127,255}));
  connect(vc.port_b, resistance.port_a)
    annotation (Line(points={{-236,66},{-236,71}}, color={0,127,255}));
  connect(pT_vc_pipe.port_a, resistance.port_b) annotation (Line(points={{
          -218,90},{-236,90},{-236,85}}, color={0,127,255}));
  connect(ps.ports[1], valve_ps.port_a) annotation (Line(points={{-218,-26},{
          -168,-26}},                  color={0,127,255}));
  connect(pipe_hx_co.port_b, volume_co.port_a)
    annotation (Line(points={{-98,-90},{-70,-90}}, color={0,127,255}));
  connect(pipe_hx_co.port_a, valve_ps.port_b) annotation (Line(points={{-118,
          -90},{-136,-90},{-136,-26},{-148,-26}}, color={0,127,255}));
  connect(sensor_co_rp_2.port_b, pipe_co_rp.port_a)
    annotation (Line(points={{20,-90},{48,-90}}, color={0,127,255}));
  connect(pipe_co_rp.port_b, pT_co_rp_1.port_a) annotation (Line(points={{68,
          -90},{82,-90},{82,52},{26,52}}, color={0,127,255}));
  connect(volume_co.port_b, co.port_a)
    annotation (Line(points={{-58,-90},{-40,-90}}, color={0,127,255}));
  connect(co.port_b, sensor_co_rp_2.port_a)
    annotation (Line(points={{-20,-90},{0,-90}}, color={0,127,255}));
  connect(pipe_vc_rp.port_a, pT_vc_pipe.port_b)
    annotation (Line(points={{-184,90},{-198,90}}, color={0,127,255}));
  connect(pT_pipe_vc.port_a, pipe_ins_rp_vc.port_b)
    annotation (Line(points={{-164,50},{-148,50}}, color={0,127,255}));
  connect(pT_rp_pipe_vc.port_b, pipe_ins_rp_vc.port_a)
    annotation (Line(points={{-110,50},{-128,50}}, color={0,127,255}));
  connect(sensor_rp_hx_2.port_a, pipe_ins_rp_hx.port_b)
    annotation (Line(points={{0,-26},{26,-26}}, color={0,127,255}));
  connect(pipe_ins_rp_hx.port_a, pT_rp_hx_1.port_b) annotation (Line(points={
          {46,-26},{68,-26},{68,88},{24,88}}, color={0,127,255}));
  connect(TM_HX_exit_Temp.T, TEDS_MassFlowControl.u_m) annotation (Line(
        points={{-186,229.6},{-186,240},{-30,240},{-30,244}}, color={0,0,
          127}));
  connect(TEDS_Temp_SP.y, TEDS_MassFlowControl.u_s)
    annotation (Line(points={{-99,256},{-42,256}}, color={0,0,127}));
  connect(TEDS_MassFlowControl.y, boundary_TEDS_in.m_flow_in) annotation (
      Line(points={{-19,256},{-19,230},{-70,230}}, color={0,0,127}));
  connect(MAGNET_TEDS_simpleHX.port_b2, TM_HX_exit_Temp.port_b) annotation (
      Line(points={{-148,222},{-164,222},{-164,226},{-176,226}}, color={0,127,
          255}));
  connect(MAGNET_TEDS_simpleHX.port_a2, boundary_TEDS_in.ports[1])
    annotation (Line(points={{-128,222},{-90,222}}, color={0,127,255}));
  connect(TEDS_flow_rate.port_b, TM_HX_exit_Temp.port_a)
    annotation (Line(points={{-226,226},{-196,226}}, color={0,127,255}));
  connect(TEDS_flow_rate.port_a, boundary_TEDS_out.ports[1])
    annotation (Line(points={{-246,226},{-264,226}}, color={0,127,255}));
  connect(T_vc_TEDS.port_b, m_flow_vc_TEDS.port_a)
    annotation (Line(points={{-158,174},{-158,188}}, color={0,127,255}));
  connect(m_flow_vc_TEDS.port_b, MAGNET_TEDS_simpleHX.port_a1) annotation (
      Line(points={{-158,208},{-158,213},{-148,213},{-148,214}}, color={0,127,
          255}));
  connect(T_vc_TEDS.port_a, valve_vc_TEDS.port_b) annotation (Line(points={{
          -158,154},{-158,143},{-157,143},{-157,138}}, color={0,127,255}));
  connect(valve_vc_TEDS.port_a, pipe_vc_rp.port_b) annotation (Line(points={{
          -157,124},{-156,124},{-156,90},{-164,90}}, color={0,127,255}));
  connect(opening_valve_tank1.y, valve_vc_TEDS.opening) annotation (Line(
        points={{-181,132},{-171.8,132},{-171.8,131},{-162.6,131}}, color={0,
          0,127}));
  connect(opening_valve_tank2.y, valve_TEDS_rp.opening) annotation (Line(
        points={{-59,186},{-95.4,186},{-95.4,187}}, color={0,0,127}));
  connect(MAGNET_TEDS_simpleHX.port_b1, valve_TEDS_rp.port_a) annotation (
      Line(points={{-128,214},{-100,214},{-100,194},{-101,194}}, color={0,127,
          255}));
  connect(valve_TEDS_rp.port_b, pT_TEDS_rp.port_a) annotation (Line(points={{
          -101,180},{-101,152},{-100,152},{-100,124}}, color={0,127,255}));
  connect(valve_vc_rp.port_a, pipe_vc_rp.port_b) annotation (Line(points={{-132,89},
          {-149,89},{-149,90},{-164,90}},          color={0,127,255}));
  connect(valve_vc_rp.port_b, pT_vc_pipe_rp.port_a) annotation (Line(points={{-118,89},
          {-111,89},{-111,90},{-88,90}},           color={0,127,255}));
  connect(pT_TEDS_rp.port_b, pT_vc_pipe_rp.port_a) annotation (Line(points={{
          -100,104},{-100,90},{-88,90}}, color={0,127,255}));
  connect(opening_valve_tank3.y, valve_vc_rp.opening) annotation (Line(points={{-126,
          135.2},{-126,118},{-125,118},{-125,94.6}},       color={0,0,127}));
  connect(realExpression2.y, TEDS_MassFlowControl.u_ff) annotation (Line(
        points={{-71,266},{-68,266},{-68,264},{-42,264}}, color={0,0,127}));
  connect(step1.y, co.inputSignal) annotation (Line(points={{-99,-56},{-30,
          -56},{-30,-83}}, color={0,0,127}));
  annotation (experiment(
      StopTime=600,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"),
    Diagram(coordinateSystem(extent={{-300,-120},{100,280}})),
    Icon(coordinateSystem(extent={{-300,-120},{100,280}})));
end MAGNET_TEDS_3;
