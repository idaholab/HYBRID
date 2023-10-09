within NHES.Systems.ExperimentalSystems.MAGNET.Examples.Steps;
model Model_1a
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
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
    redeclare package Medium = Medium,
    p=data.p_rp_hx,
    T=data.T_rp_hx,
    nPorts=1)                                                       annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={100,80})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Medium,
    m_flow=data.m_flow,
    T=data.T_vc_rp,
    nPorts=1)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-38,80})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary4(
    redeclare package Medium = Medium,
    p=data.p_hx_co,
    T=data.T_hx_co,
    nPorts=1)                                                       annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-120,-60})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary5(
    redeclare package Medium = Medium,
    m_flow=data.m_flow,
    T=data.T_rp_hx,
    nPorts=1)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={18,-60})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary6(
    redeclare package Medium = Medium,
    p=data.p_rp_vc,
    T=data.T_rp_vc,
    nPorts=1)                                                       annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,40})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary7(
    redeclare package Medium = Medium,
    m_flow=data.m_flow,
    T=data.T_co_rp,
    nPorts=1)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={98,40})));
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
  connect(boundary4.ports[1], sensor_pT5.port_b)
    annotation (Line(points={{-110,-60},{-90,-60}}, color={0,127,255}));
  connect(boundary5.ports[1], sensor_pT10.port_a)
    annotation (Line(points={{8,-60},{-10,-60}}, color={0,127,255}));
  connect(boundary3.ports[1], sensor_pT7.port_a)
    annotation (Line(points={{-28,80},{-10,80}}, color={0,127,255}));
  connect(sensor_pT3.port_b, boundary2.ports[1])
    annotation (Line(points={{70,80},{90,80}}, color={0,127,255}));
  connect(sensor_pT8.port_a, boundary7.ports[1])
    annotation (Line(points={{70,40},{88,40}}, color={0,127,255}));
  connect(sensor_pT6.port_b, boundary6.ports[1])
    annotation (Line(points={{-10,40},{-30,40}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},
            {140,120}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,120}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
end Model_1a;
