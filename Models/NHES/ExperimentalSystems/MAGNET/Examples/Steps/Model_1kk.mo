within NHES.ExperimentalSystems.MAGNET.Examples.Steps;
model Model_1kk
  extends TRANSFORM.Icons.Example;

  Data.Summary summary(
    Ts={sensor_pT8.T,sensor_pT6.T,sensor_pT2.T,sensor_pT1.T,sensor_pT7.T,
        sensor_pT3.T,sensor_pT10.T,sensor_pT5.T},
    ps={sensor_pT8.p,sensor_pT6.p,sensor_pT2.p,sensor_pT1.p,sensor_pT7.p,
        sensor_pT3.p,sensor_pT10.p,sensor_pT5.p},
    m_flows={sensor_m_flow.m_flow},
    Q_flows={vc.Q_gen})
    annotation (Placement(transformation(extent={{120,100},{140,120}})));

protected
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
  package Medium_cw = Modelica.Media.Water.StandardWater;

  Data.Data_base data
    annotation (Placement(transformation(extent={{120,80},{140,100}})));
  inner TRANSFORM.Fluid.SystemTF systemTF(
    showColors=true,
    val_min=data.T_hx_co,
    val_max=data.T_vc_rp)
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  TRANSFORM.HeatExchangers.Simple_HX  rp(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 = Medium,
    nV=10,
    V_1=1,
    V_2=1,
    UA=47.9299,
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
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  TRANSFORM.HeatExchangers.Simple_HX  hx(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 = Medium_cw,
    nV=10,
    V_1=1,
    V_2=1,
    UA=317.208,
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
    redeclare package Medium = Medium_cw,                       m_flow=data.m_flow_cw,
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
    Q_gen=trapezoid.y) annotation (Placement(transformation(
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
    controlType="RPM",
    use_port=true)
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume_co(
    redeclare package Medium = Medium,
    p_start=data.p_hx_co,
    T_start=data.T_hx_co,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.01),
    Q_gen=0) "12022.6"
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ps(
    redeclare package Medium = Medium,
    use_p_in=false,
    p=data.p_hx_co,
    T=data.T_ps,
    nPorts=1)
    annotation (Placement(transformation(extent={{-190,-50},{-170,-30}})));
  TRANSFORM.Fluid.Valves.ValveIncompressible valve_ps(
    redeclare package Medium = Medium,
    showName=false,
    dp_nominal(displayUnit="Pa") = 1e4,
    m_flow_nominal=1,
    opening_nominal=0.5) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-150,-40})));
  Modelica.Blocks.Sources.Constant opening_valve_tank(k=1)
    annotation (Placement(transformation(extent={{-220,-30},{-200,-10}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Medium, precision=2)
    annotation (Placement(transformation(extent={{50,-100},{70,-80}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=data.Q_vc,
    rising=1000,
    width=1000,
    falling=1000,
    period=4000,
    offset=0,
    startTime=1000)
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));

  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yb=1500,
    k_s=1/data.m_flow,
    k_m=1/data.m_flow)
    annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=data.m_flow)
    annotation (Placement(transformation(extent={{98,-80},{78,-60}})));
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
  connect(pipe_hx_co.port_b, volume_co.port_a)
    annotation (Line(points={{-40,-90},{-16,-90}}, color={0,127,255}));
  connect(volume_co.port_b, co.port_a)
    annotation (Line(points={{-4,-90},{10,-90}}, color={0,127,255}));
  connect(ps.ports[1], valve_ps.port_a)
    annotation (Line(points={{-170,-40},{-160,-40}}, color={0,127,255}));
  connect(opening_valve_tank.y, valve_ps.opening) annotation (Line(
      points={{-199,-20},{-150,-20},{-150,-32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(valve_ps.port_b, sensor_pT5.port_b) annotation (Line(points={{-140,
          -40},{-100,-40},{-100,-60},{-90,-60}}, color={0,127,255}));
  connect(co.port_b, sensor_m_flow.port_a)
    annotation (Line(points={{30,-90},{50,-90}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, pipe_co_rp.port_a) annotation (Line(points={{70,
          -90},{100,-90},{100,-40}}, color={0,127,255}));
  connect(realExpression.y, PID.u_s)
    annotation (Line(points={{77,-70},{72,-70}}, color={0,0,127}));
  connect(PID.u_m, sensor_m_flow.m_flow)
    annotation (Line(points={{60,-82},{60,-86.4}}, color={0,0,127}));
  connect(PID.y, co.inputSignal)
    annotation (Line(points={{49,-70},{20,-70},{20,-83}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,
            -120},{140,120}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-240,-120},{140,
            120}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
end Model_1kk;
