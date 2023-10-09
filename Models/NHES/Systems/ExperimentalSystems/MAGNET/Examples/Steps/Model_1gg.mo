within NHES.Systems.ExperimentalSystems.MAGNET.Examples.Steps;
model Model_1gg
  extends TRANSFORM.Icons.Example;

  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
  package Medium_cw = Modelica.Media.Water.StandardWater;

  Data.Data_base data
    annotation (Placement(transformation(extent={{120,100},{140,120}})));
  inner TRANSFORM.Fluid.SystemTF systemTF(
    showColors=true,
    val_min=data.T_hx_co,
    val_max=data.T_vc_rp)
    annotation (Placement(transformation(extent={{100,98},{120,118}})));
  TRANSFORM.HeatExchangers.LMTD_HX_UA rp(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 = Medium,
    p_start_1=data.p_vc_rp,
    p_start_2=data.p_co_rp,
    T_start_1=data.T_vc_rp,
    T_start_2=data.T_co_rp,
    m_flow_start_1=data.m_flow,
    m_flow_start_2=data.m_flow,
    R_1=-data.dp_rp_hot/data.m_flow,
    R_2=-data.dp_rp_cold/data.m_flow,
    Q_flow0=data.Q_flow_rp)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  TRANSFORM.HeatExchangers.LMTD_HX_UA hx(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 = Medium_cw,
    p_start_1=data.p_rp_hx,
    p_start_2=data.p_cw_hx,
    T_start_1=data.T_rp_hx,
    T_start_2=data.T_cw_hx,
    m_flow_start_1=data.m_flow,
    m_flow_start_2=data.m_flow_cw,
    R_1=-data.dp_hx_hot/data.m_flow,
    Q_flow0=data.Q_flow_hx)
    annotation (Placement(transformation(extent={{-40,-30},{-60,-50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Medium_cw,
    p=data.p_hx_cw,
    T=data.T_hx_cw,                                       nPorts=1) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={20,-20})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = Medium_cw,
    use_m_flow_in=true,                                         m_flow=data.m_flow_cw,
    T=data.T_cw_hx,
      nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-118,-20})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT3(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{50,70},{70,90}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT5(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
                                                           annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-80,-60})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT6(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{10,30},{-10,50}})));
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
        origin={0,80})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT8(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    precision2=1,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT4(
    redeclare package Medium = Medium_cw,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT9(
    redeclare package Medium = Medium_cw,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT10(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-10,-70},{-30,-50}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_hx(
    redeclare package Medium = Medium,
    p_a_start=data.p_rp_hx,
    T_a_start=data.T_rp_hx,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_rp_hx, length=data.d_rp_hx))
    annotation (Placement(transformation(extent={{60,-50},{40,-30}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_vc(
    redeclare package Medium = Medium,
    p_a_start=data.p_rp_vc,
    T_a_start=data.T_rp_vc,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_rp_vc, length=data.d_rp_vc))
    annotation (Placement(transformation(extent={{-30,30},{-50,50}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_vc_rp(
    redeclare package Medium = Medium,
    p_a_start=data.p_vc_rp,
    T_a_start=data.T_vc_rp,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_vc_rp, length=data.d_vc_rp))
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
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
        origin={-92,52})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT1(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT2(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Medium, R=-data.dp_vc/data.m_flow) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-92,70})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_hx_co(
    redeclare package Medium = Medium,
    p_a_start=data.p_hx_co,
    T_a_start=data.T_hx_co,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_hx_co, length=data.d_hx_co))
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_co_rp(
    redeclare package Medium = Medium,
    p_a_start=data.p_co_rp,
    T_a_start=data.T_co_rp,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_co_rp, length=data.d_co_rp)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={100,-30})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Medium, m_flow_nominal=data.m_flow)
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.01),
    Q_gen=data.Q_flow_co)
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1,
    yb=data.m_flow_cw,
    k_s=1/data.T_co_rp,
    k_m=1/data.T_co_rp,
    yMin=0) annotation (Placement(transformation(extent={{-170,-8},{-150,12}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=data.T_co_rp)
    annotation (Placement(transformation(extent={{-208,-8},{-188,12}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=sensor_pT8.T)
    annotation (Placement(transformation(extent={{-208,-30},{-188,-10}})));
equation
  connect(rp.port_b1, sensor_pT3.port_a) annotation (Line(points={{40,64},{46,64},
          {46,80},{50,80}}, color={0,127,255}));
  connect(rp.port_b2, sensor_pT6.port_a) annotation (Line(points={{20,56},{14,56},
          {14,40},{10,40}}, color={0,127,255}));
  connect(sensor_pT7.port_b, rp.port_a1) annotation (Line(points={{10,80},{14,80},
          {14,64},{20,64}}, color={0,127,255}));
  connect(sensor_pT8.port_b, rp.port_a2) annotation (Line(points={{50,40},{46,40},
          {46,56},{40,56}}, color={0,127,255}));
  connect(sensor_pT5.port_a, hx.port_b1) annotation (Line(points={{-70,-60},{-66,
          -60},{-66,-44},{-60,-44}}, color={0,127,255}));
  connect(boundary1.ports[1], sensor_pT9.port_a)
    annotation (Line(points={{-108,-20},{-90,-20}}, color={0,127,255}));
  connect(sensor_pT9.port_b, hx.port_a2) annotation (Line(points={{-70,-20},{-66,
          -20},{-66,-36},{-60,-36}}, color={0,127,255}));
  connect(hx.port_b2, sensor_pT4.port_a) annotation (Line(points={{-40,-36},{-34,
          -36},{-34,-20},{-30,-20}}, color={0,127,255}));
  connect(sensor_pT4.port_b, boundary.ports[1])
    annotation (Line(points={{-10,-20},{10,-20}}, color={0,127,255}));
  connect(hx.port_a1, sensor_pT10.port_b) annotation (Line(points={{-40,-44},{-34,
          -44},{-34,-60},{-30,-60}}, color={0,127,255}));
  connect(sensor_pT3.port_b, pipe_rp_hx.port_a) annotation (Line(points={{70,80},
          {80,80},{80,-40},{60,-40}}, color={0,127,255}));
  connect(pipe_rp_hx.port_b, sensor_pT10.port_a) annotation (Line(points={{40,
          -40},{0,-40},{0,-60},{-10,-60}}, color={0,127,255}));
  connect(sensor_pT1.port_b, pipe_vc_rp.port_a)
    annotation (Line(points={{-60,80},{-50,80}}, color={0,127,255}));
  connect(pipe_rp_vc.port_b, sensor_pT2.port_a)
    annotation (Line(points={{-50,40},{-60,40}}, color={0,127,255}));
  connect(sensor_pT2.port_b, vc.port_a)
    annotation (Line(points={{-80,40},{-92,40},{-92,46}}, color={0,127,255}));
  connect(pipe_vc_rp.port_b, sensor_pT7.port_a)
    annotation (Line(points={{-30,80},{-10,80}}, color={0,127,255}));
  connect(pipe_rp_vc.port_a, sensor_pT6.port_b)
    annotation (Line(points={{-30,40},{-10,40}}, color={0,127,255}));
  connect(vc.port_b, resistance.port_a)
    annotation (Line(points={{-92,58},{-92,63}}, color={0,127,255}));
  connect(resistance.port_b, sensor_pT1.port_a)
    annotation (Line(points={{-92,77},{-92,80},{-80,80}}, color={0,127,255}));
  connect(pipe_hx_co.port_a, sensor_pT5.port_b) annotation (Line(points={{-60,
          -90},{-100,-90},{-100,-60},{-90,-60}}, color={0,127,255}));
  connect(pipe_co_rp.port_b, sensor_pT8.port_a)
    annotation (Line(points={{100,-20},{100,40},{70,40}}, color={0,127,255}));
  connect(pump.port_b, pipe_co_rp.port_a) annotation (Line(points={{80,-90},{
          100,-90},{100,-40}}, color={0,127,255}));
  connect(pipe_hx_co.port_b, volume1.port_a)
    annotation (Line(points={{-40,-90},{14,-90}}, color={0,127,255}));
  connect(volume1.port_b, pump.port_a)
    annotation (Line(points={{26,-90},{60,-90}}, color={0,127,255}));
  connect(realExpression1.y, PID.u_m) annotation (Line(points={{-187,-20},{-160,
          -20},{-160,-10}}, color={0,0,127}));
  connect(realExpression.y, PID.u_s)
    annotation (Line(points={{-187,2},{-172,2}}, color={0,0,127}));
  connect(PID.y, boundary1.m_flow_in) annotation (Line(points={{-149,2},{-136,2},
          {-136,-12},{-128,-12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},
            {140,120}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,120}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
end Model_1gg;
