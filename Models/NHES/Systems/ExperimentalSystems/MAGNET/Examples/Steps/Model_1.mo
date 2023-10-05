within NHES.ExperimentalSystems.MAGNET.Examples.Steps;
model Model_1
  extends TRANSFORM.Icons.Example;

  package Medium = Modelica.Media.IdealGases.SingleGases.N2;
  package Medium_cw = Modelica.Media.Water.StandardWater;

  Data.Data_base data
    annotation (Placement(transformation(extent={{120,100},{140,120}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_vc(
    redeclare package Medium = Medium,
    p_a_start=data.p_rp_vc,
    T_a_start=data.T_rp_vc,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_rp_vc, length=data.d_rp_vc))
    annotation (Placement(transformation(extent={{-30,30},{-50,50}})));
  inner TRANSFORM.Fluid.SystemTF systemTF(
    showColors=true,
    val_min=data.T_hx_co,
    val_max=data.T_vc_rp)
    annotation (Placement(transformation(extent={{100,98},{120,118}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_vc_rp(
    redeclare package Medium = Medium,
    p_a_start=data.p_vc_rp,
    T_a_start=data.T_vc_rp,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_vc_rp, length=data.d_vc_rp),
    exposeState_a=false)
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_rp_hx(
    redeclare package Medium = Medium,
    p_a_start=data.p_rp_hx,
    T_a_start=data.T_rp_hx,
    m_flow_a_start=data.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=data.d_rp_hx, length=data.d_rp_hx))
    annotation (Placement(transformation(extent={{60,-50},{40,-30}})));
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
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Medium, m_flow_nominal=data.m_flow)
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
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
        origin={-90,60})));
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
        extent={{-10,-10},{10,10}},
        rotation=270)));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = Medium_cw,                       m_flow=data.m_flow_cw,
    T=data.T_cw_hx,
      nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,-2})));
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
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.01),
    Q_gen=PID.y)
    annotation (Placement(transformation(extent={{-18,-100},{2,-80}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    yb=data.Q_flow_co,
    k_s=1/data.T_co_rp,
    k_m=1/data.T_co_rp,
    yMin=0)
    annotation (Placement(transformation(extent={{-130,-108},{-110,-88}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=data.T_co_rp)
    annotation (Placement(transformation(extent={{-168,-108},{-148,-88}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=sensor_pT8.T)
    annotation (Placement(transformation(extent={{-168,-130},{-148,-110}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ps(
    redeclare package Medium = Medium,
    use_p_in=false,
    p=data.p_ps,
    T=data.T_ps,
    nPorts=1)
    annotation (Placement(transformation(extent={{-170,-70},{-150,-50}})));
  TRANSFORM.Fluid.Valves.ValveIncompressible valve_tank(
    redeclare package Medium = Medium,
    showName=false,
    dp_nominal(displayUnit="Pa") = 1e4,
    m_flow_nominal=1,
    opening_nominal=0.5) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-130,-60})));
  Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
    annotation (Placement(transformation(extent={{-200,-50},{-180,-30}})));
equation
  connect(pump.port_b, pipe_co_rp.port_a)
    annotation (Line(points={{40,-90},{100,-90},{100,-40}},
                                                          color={0,127,255}));
  connect(vc.port_b, sensor_pT1.port_a)
    annotation (Line(points={{-90,66},{-90,80},{-80,80}}, color={0,127,255}));
  connect(sensor_pT1.port_b, pipe_vc_rp.port_a)
    annotation (Line(points={{-60,80},{-50,80}}, color={0,127,255}));
  connect(pipe_rp_vc.port_b, sensor_pT2.port_a)
    annotation (Line(points={{-50,40},{-60,40}}, color={0,127,255}));
  connect(sensor_pT2.port_b, vc.port_a)
    annotation (Line(points={{-80,40},{-90,40},{-90,54}}, color={0,127,255}));
  connect(rp.port_b1, sensor_pT3.port_a) annotation (Line(points={{40,64},{46,
          64},{46,80},{50,80}}, color={0,127,255}));
  connect(sensor_pT3.port_b, pipe_rp_hx.port_a) annotation (Line(points={{70,80},
          {80,80},{80,-40},{60,-40}}, color={0,127,255}));
  connect(sensor_pT5.port_b, pipe_hx_co.port_a) annotation (Line(points={{-90,
          -60},{-100,-60},{-100,-90},{-60,-90}}, color={0,127,255}));
  connect(rp.port_b2, sensor_pT6.port_a) annotation (Line(points={{20,56},{14,
          56},{14,40},{10,40}}, color={0,127,255}));
  connect(sensor_pT6.port_b, pipe_rp_vc.port_a)
    annotation (Line(points={{-10,40},{-30,40}}, color={0,127,255}));
  connect(pipe_vc_rp.port_b, sensor_pT7.port_a)
    annotation (Line(points={{-30,80},{-10,80}}, color={0,127,255}));
  connect(sensor_pT7.port_b, rp.port_a1) annotation (Line(points={{10,80},{14,
          80},{14,64},{20,64}}, color={0,127,255}));
  connect(sensor_pT8.port_b, rp.port_a2) annotation (Line(points={{50,40},{46,
          40},{46,56},{40,56}}, color={0,127,255}));
  connect(pipe_co_rp.port_b, sensor_pT8.port_a)
    annotation (Line(points={{100,-20},{100,40},{70,40}}, color={0,127,255}));
  connect(sensor_pT5.port_a, hx.port_b1) annotation (Line(points={{-70,-60},{
          -66,-60},{-66,-44},{-60,-44}}, color={0,127,255}));
  connect(boundary1.ports[1], sensor_pT9.port_a) annotation (Line(points={{-100,
          -12},{-100,-20},{-90,-20}}, color={0,127,255}));
  connect(sensor_pT9.port_b, hx.port_a2) annotation (Line(points={{-70,-20},{
          -66,-20},{-66,-36},{-60,-36}}, color={0,127,255}));
  connect(hx.port_b2, sensor_pT4.port_a) annotation (Line(points={{-40,-36},{
          -34,-36},{-34,-20},{-30,-20}}, color={0,127,255}));
  connect(sensor_pT4.port_b, boundary.ports[1]) annotation (Line(points={{-10,
          -20},{-1.77636e-15,-20},{-1.77636e-15,-10}}, color={0,127,255}));
  connect(hx.port_a1, sensor_pT10.port_b) annotation (Line(points={{-40,-44},{
          -34,-44},{-34,-60},{-30,-60}}, color={0,127,255}));
  connect(sensor_pT10.port_a, pipe_rp_hx.port_b) annotation (Line(points={{-10,
          -60},{0,-60},{0,-40},{40,-40}}, color={0,127,255}));
  connect(pipe_hx_co.port_b, volume1.port_a)
    annotation (Line(points={{-40,-90},{-14,-90}}, color={0,127,255}));
  connect(volume1.port_b, pump.port_a)
    annotation (Line(points={{-2,-90},{20,-90}}, color={0,127,255}));
  connect(realExpression1.y, PID.u_m) annotation (Line(points={{-147,-120},{
          -120,-120},{-120,-110}}, color={0,0,127}));
  connect(realExpression.y, PID.u_s)
    annotation (Line(points={{-147,-98},{-132,-98}}, color={0,0,127}));
  connect(ps.ports[1], valve_tank.port_a)
    annotation (Line(points={{-150,-60},{-140,-60}}, color={0,127,255}));
  connect(opening_valve_tank.y,valve_tank. opening) annotation (Line(points={{-179,
          -40},{-130,-40},{-130,-52}},    color={0,0,127},
      pattern=LinePattern.Dash));
  connect(valve_tank.port_b, pipe_hx_co.port_a) annotation (Line(points={{-120,
          -60},{-100,-60},{-100,-90},{-60,-90}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -120},{140,120}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,
            120}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
end Model_1;
