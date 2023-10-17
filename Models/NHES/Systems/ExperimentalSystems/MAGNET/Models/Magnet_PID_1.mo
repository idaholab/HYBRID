within NHES.Systems.ExperimentalSystems.MAGNET.Models;
model Magnet_PID_1
  extends TRANSFORM.Icons.Example;

  package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
  package Medium_cw = Modelica.Media.Water.StandardWater;

  inner TRANSFORM.Fluid.SystemTF systemTF(
    showColors=true,
    val_min=data.T_hx_co,
    val_max=data.T_vc_rp)
    annotation (Placement(transformation(extent={{100,98},{120,118}})));
protected
  TRANSFORM.HeatExchangers.Simple_HX  rp(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 = Medium,
    nV=10,
    V_1=0.1,
    V_2=0.1,
    UA=PID.y,
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
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT3(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT6(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-30,-10},{-50,10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT7(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                           annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-40,40})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT8(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    precision2=1,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{30,-10},{10,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
    redeclare package Medium = Medium,
    p=data.p_rp_hx,
    T=data.T_rp_hx,
    nPorts=1)                                                       annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,40})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary7(
    redeclare package Medium = Medium,
    m_flow=data.m_flow,
    T=data.T_co_rp,
    nPorts=1)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={58,0})));
public
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_cold2(
    val=rp.port_a2.m_flow,
    precision=1,
    unitLabel="kg/s")
    annotation (Placement(transformation(extent={{-20,-2},{0,10}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_hot2(
    val=rp.port_a1.m_flow,
    precision=1,
    unitLabel="kg/s")
    annotation (Placement(transformation(extent={{-20,-10},{0,2}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot14(
    val=rp.Q_flow/1e3,
    precision=1,
    unitLabel="kW")
    annotation (Placement(transformation(extent={{-20,26},{0,38}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yb=1017.56006,
    k_s=1/data.Q_flow_rp,
    k_m=1/data.Q_flow_rp,
    yMin=0) annotation (Placement(transformation(extent={{138,20},{158,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=data.Q_flow_rp)
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=rp.Q_flow)
    annotation (Placement(transformation(extent={{100,-2},{120,18}})));
protected
  TRANSFORM.Fluid.Volumes.SimpleVolume vc(
    redeclare package Medium = Medium,
    p_start=data.p_vc_rp,
    T_start=data.T_vc_rp,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.1),
    Q_gen=data.Q_vc) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-162,12})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT1(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-150,30},{-130,50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT2(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-130,-10},{-150,10}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-162,30})));
public
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_vc_rp(
    redeclare package Medium = Medium,
    p_a_start=data.p_vc_rp,
    T_a_start=data.T_vc_rp,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_vc_rp, length=data.d_vc_rp))
    annotation (Placement(transformation(extent={{-288,56},{-268,76}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_vc(
    redeclare package Medium = Medium,
    p_a_start=data.p_rp_vc,
    T_a_start=data.T_rp_vc,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_rp_vc, length=data.d_rp_vc))
    annotation (Placement(transformation(extent={{-246,-32},{-266,-12}})));
protected
  NHES.Systems.ExperimentalSystems.MAGNET.Data.Data_base_An data
    annotation (Placement(transformation(extent={{-168,98},{-148,118}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_vc_rp(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
        (dimension=data.d_vc_rp, length=data.length_vc_rp),
    redeclare package Medium = Medium,
    p_a_start=data.p_vc_rp,
    T_a_start=data.T_vc_rp,
    m_flow_a_start=data.m_flow,
    redeclare package Material = TRANSFORM.Media.Solids.SS304,
    redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 ins_rp_vc(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
        (dimension=data.d_rp_vc, length=data.length_rp_vc),
    redeclare package Medium = Medium,
    p_a_start=data.p_rp_vc,
    T_a_start=data.T_rp_vc,
    m_flow_a_start=data.m_flow,
    redeclare package Material = TRANSFORM.Media.Solids.SS304,
    redeclare package Material_2 = TRANSFORM.Media.Solids.FiberGlassGeneric)
    annotation (Placement(transformation(extent={{-84,-10},{-104,10}})));
equation
  connect(rp.port_b1, sensor_pT3.port_a) annotation (Line(points={{0,24},{6,24},
          {6,40},{10,40}},  color={0,127,255}));
  connect(rp.port_b2, sensor_pT6.port_a) annotation (Line(points={{-20,16},{-26,
          16},{-26,0},{-30,0}},
                            color={0,127,255}));
  connect(sensor_pT7.port_b, rp.port_a1) annotation (Line(points={{-30,40},{-26,
          40},{-26,24},{-20,24}},
                            color={0,127,255}));
  connect(sensor_pT8.port_b, rp.port_a2) annotation (Line(points={{10,0},{6,0},
          {6,16},{0,16}},   color={0,127,255}));
  connect(sensor_pT3.port_b, boundary2.ports[1])
    annotation (Line(points={{30,40},{50,40}}, color={0,127,255}));
  connect(sensor_pT8.port_a, boundary7.ports[1])
    annotation (Line(points={{30,0},{48,0}}, color={0,127,255}));
  connect(realExpression1.y, PID.u_m)
    annotation (Line(points={{121,8},{148,8},{148,18}}, color={0,0,127}));
  connect(realExpression.y, PID.u_s)
    annotation (Line(points={{121,30},{136,30}}, color={0,0,127}));
  connect(sensor_pT2.port_b, vc.port_a)
    annotation (Line(points={{-150,0},{-162,0},{-162,6}}, color={0,127,255}));
  connect(vc.port_b, resistance.port_a)
    annotation (Line(points={{-162,18},{-162,23}}, color={0,127,255}));
  connect(resistance.port_b, sensor_pT1.port_a) annotation (Line(points={{-162,
          37},{-162,40},{-150,40}}, color={0,127,255}));
  connect(sensor_pT1.port_b, ins_vc_rp.port_a)
    annotation (Line(points={{-130,40},{-110,40}}, color={0,127,255}));
  connect(ins_vc_rp.port_b, sensor_pT7.port_a)
    annotation (Line(points={{-90,40},{-50,40}}, color={0,127,255}));
  connect(sensor_pT2.port_a, ins_rp_vc.port_b)
    annotation (Line(points={{-130,0},{-104,0}}, color={0,127,255}));
  connect(ins_rp_vc.port_a, sensor_pT6.port_b)
    annotation (Line(points={{-84,0},{-50,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},
            {140,120}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,120}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
end Magnet_PID_1;
