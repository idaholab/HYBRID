within NHES.ExperimentalSystems.MAGNET.Examples.Steps;
model Model_1hh
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
  TRANSFORM.HeatExchangers.Simple_HX  hx(
    redeclare package Medium_1 = Medium,
    redeclare package Medium_2 = Medium_cw,
    nV=10,
    V_1=0.1,
    V_2=0.1,
    UA=PID1.y,
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
    annotation (Placement(transformation(extent={{0,-30},{-20,-50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Medium_cw,
    p=data.p_hx_cw,
    T=data.T_hx_cw,                                       nPorts=1) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,-20})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = Medium_cw,                       m_flow=data.m_flow_cw,
    T=data.T_cw_hx,
      nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-78,-20})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT3(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
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
        origin={-40,-60})));
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
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT4(
    redeclare package Medium = Medium_cw,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT9(
    redeclare package Medium = Medium_cw,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT10(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{30,-70},{10,-50}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Medium,
    m_flow=data.m_flow,
    T=data.T_vc_rp,
    nPorts=1)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-78,40})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary6(
    redeclare package Medium = Medium,
    p=data.p_rp_vc,
    T=data.T_rp_vc,
    nPorts=1)                                                       annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,0})));
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
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary5(
    redeclare package Medium = Medium,
    m_flow=data.m_flow,
    T=data.T_rp_hx,
    nPorts=1)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={58,-60})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary4(
    redeclare package Medium = Medium,
    p=data.p_hx_co,
    T=data.T_hx_co,
    nPorts=1)                                                       annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,-60})));
  TRANSFORM.HeatExchangers.LMTD_HX_UA rp1(
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
    annotation (Placement(transformation(extent={{-180,10},{-160,30}})));
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
    annotation (Placement(transformation(extent={{-190,-10},{-210,10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT11(
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
        origin={-200,40})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT12(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    precision2=1,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-130,-10},{-150,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary8(
    redeclare package Medium = Medium,
    p=data.p_rp_hx,
    T=data.T_rp_hx,
    nPorts=1)                                                       annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-100,40})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary9(
    redeclare package Medium = Medium,
    m_flow=data.m_flow,
    T=data.T_vc_rp,
    nPorts=1)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-238,40})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary10(
    redeclare package Medium = Medium,
    p=data.p_rp_vc,
    T=data.T_rp_vc,
    nPorts=1)                                                       annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-240,0})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary11(
    redeclare package Medium = Medium,
    m_flow=data.m_flow,
    T=data.T_co_rp,
    nPorts=1)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-102,0})));
  TRANSFORM.HeatExchangers.LMTD_HX_UA hx1(
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
    annotation (Placement(transformation(extent={{-160,-30},{-180,-50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary12(
    redeclare package Medium = Medium_cw,
    p=data.p_hx_cw,
    T=data.T_hx_cw,
    nPorts=1)                                                       annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-100,-20})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary13(
    redeclare package Medium = Medium_cw,
    m_flow=data.m_flow_cw,
    T=data.T_cw_hx,
    nPorts=1)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-238,-20})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT13(
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
        origin={-200,-60})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT14(
    redeclare package Medium = Medium_cw,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-150,-30},{-130,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT15(
    redeclare package Medium = Medium_cw,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-210,-30},{-190,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort sensor_pT16(
    redeclare package Medium = Medium,
    precision=1,
    redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar,
    redeclare function iconUnit2 =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC)
    annotation (Placement(transformation(extent={{-130,-70},{-150,-50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary14(
    redeclare package Medium = Medium,
    p=data.p_hx_co,
    T=data.T_hx_co,
    nPorts=1)                                                       annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-240,-60})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary15(
    redeclare package Medium = Medium,
    m_flow=data.m_flow,
    T=data.T_rp_hx,
    nPorts=1)   annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-102,-60})));
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
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_hot1(
    val=rp1.port_a1.m_flow,
    precision=1,
    unitLabel="kg/s")
    annotation (Placement(transformation(extent={{-180,-10},{-160,2}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_cold1(
    val=rp1.port_a2.m_flow,
    precision=1,
    unitLabel="kg/s")
    annotation (Placement(transformation(extent={{-180,-2},{-160,10}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot1(
    val=rp1.Q_flow/1e3,
    precision=1,
    unitLabel="kW")
    annotation (Placement(transformation(extent={{-180,26},{-160,38}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_hot3(
    val=hx1.port_a1.m_flow,
    precision=1,
    unitLabel="kg/s")
    annotation (Placement(transformation(extent={{-180,-66},{-160,-54}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_cold3(
    val=hx1.port_a2.m_flow,
    precision=1,
    unitLabel="kg/s")
    annotation (Placement(transformation(extent={{-180,-58},{-160,-46}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot2(
    val=hx1.Q_flow/1e3,
    precision=1,
    unitLabel="kW")
    annotation (Placement(transformation(extent={{-180,-30},{-160,-18}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_hot4(
    val=hx.port_a1.m_flow,
    precision=1,
    unitLabel="kg/s")
    annotation (Placement(transformation(extent={{-20,-66},{0,-54}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_rhx_cold4(
    val=hx.port_a2.m_flow,
    precision=1,
    unitLabel="kg/s")
    annotation (Placement(transformation(extent={{-20,-58},{0,-46}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot3(
    val=hx.Q_flow/1e3,
    precision=1,
    unitLabel="kW")
    annotation (Placement(transformation(extent={{-20,-30},{0,-18}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot4(val=rp1.UA
        /1e3, precision=4)
    annotation (Placement(transformation(extent={{-148,14},{-128,26}})));
  TRANSFORM.Utilities.Visualizers.displayReal sensor_m_flow_htr_hot5(val=hx1.UA
        /1e3, precision=4)
    annotation (Placement(transformation(extent={{-148,-46},{-128,-34}})));
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
  TRANSFORM.Controls.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=100,
    yb=2037.7781,
    k_s=1/data.Q_flow_hx,
    k_m=1/data.Q_flow_hx,
    yMin=0) annotation (Placement(transformation(extent={{140,-44},{160,-24}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=data.Q_flow_hx)
    annotation (Placement(transformation(extent={{102,-44},{122,-24}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=hx.Q_flow)
    annotation (Placement(transformation(extent={{102,-66},{122,-46}})));
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
  connect(sensor_pT5.port_a, hx.port_b1) annotation (Line(points={{-30,-60},{
          -26,-60},{-26,-44},{-20,-44}},
                                     color={0,127,255}));
  connect(boundary1.ports[1], sensor_pT9.port_a)
    annotation (Line(points={{-68,-20},{-50,-20}},  color={0,127,255}));
  connect(sensor_pT9.port_b, hx.port_a2) annotation (Line(points={{-30,-20},{
          -26,-20},{-26,-36},{-20,-36}},
                                     color={0,127,255}));
  connect(hx.port_b2, sensor_pT4.port_a) annotation (Line(points={{0,-36},{6,
          -36},{6,-20},{10,-20}},    color={0,127,255}));
  connect(sensor_pT4.port_b, boundary.ports[1])
    annotation (Line(points={{30,-20},{50,-20}},  color={0,127,255}));
  connect(hx.port_a1, sensor_pT10.port_b) annotation (Line(points={{0,-44},{6,
          -44},{6,-60},{10,-60}},    color={0,127,255}));
  connect(sensor_pT6.port_b,boundary6. ports[1])
    annotation (Line(points={{-50,0},{-70,0}},   color={0,127,255}));
  connect(boundary3.ports[1], sensor_pT7.port_a)
    annotation (Line(points={{-68,40},{-50,40}}, color={0,127,255}));
  connect(sensor_pT3.port_b, boundary2.ports[1])
    annotation (Line(points={{30,40},{50,40}}, color={0,127,255}));
  connect(sensor_pT8.port_a, boundary7.ports[1])
    annotation (Line(points={{30,0},{48,0}}, color={0,127,255}));
  connect(boundary5.ports[1], sensor_pT10.port_a)
    annotation (Line(points={{48,-60},{30,-60}}, color={0,127,255}));
  connect(boundary4.ports[1], sensor_pT5.port_b)
    annotation (Line(points={{-70,-60},{-50,-60}}, color={0,127,255}));
  connect(rp1.port_b1, sensor_pT1.port_a) annotation (Line(points={{-160,24},{
          -154,24},{-154,40},{-150,40}}, color={0,127,255}));
  connect(rp1.port_b2, sensor_pT2.port_a) annotation (Line(points={{-180,16},{
          -186,16},{-186,0},{-190,0}}, color={0,127,255}));
  connect(sensor_pT11.port_b, rp1.port_a1) annotation (Line(points={{-190,40},{
          -186,40},{-186,24},{-180,24}}, color={0,127,255}));
  connect(sensor_pT12.port_b, rp1.port_a2) annotation (Line(points={{-150,0},{
          -154,0},{-154,16},{-160,16}}, color={0,127,255}));
  connect(boundary9.ports[1], sensor_pT11.port_a)
    annotation (Line(points={{-228,40},{-210,40}}, color={0,127,255}));
  connect(sensor_pT1.port_b,boundary8. ports[1])
    annotation (Line(points={{-130,40},{-110,40}},
                                               color={0,127,255}));
  connect(sensor_pT12.port_a, boundary11.ports[1])
    annotation (Line(points={{-130,0},{-112,0}}, color={0,127,255}));
  connect(sensor_pT2.port_b, boundary10.ports[1])
    annotation (Line(points={{-210,0},{-230,0}}, color={0,127,255}));
  connect(sensor_pT13.port_a, hx1.port_b1) annotation (Line(points={{-190,-60},
          {-186,-60},{-186,-44},{-180,-44}}, color={0,127,255}));
  connect(boundary13.ports[1], sensor_pT15.port_a)
    annotation (Line(points={{-228,-20},{-210,-20}}, color={0,127,255}));
  connect(sensor_pT15.port_b, hx1.port_a2) annotation (Line(points={{-190,-20},
          {-186,-20},{-186,-36},{-180,-36}}, color={0,127,255}));
  connect(hx1.port_b2, sensor_pT14.port_a) annotation (Line(points={{-160,-36},
          {-154,-36},{-154,-20},{-150,-20}}, color={0,127,255}));
  connect(sensor_pT14.port_b, boundary12.ports[1])
    annotation (Line(points={{-130,-20},{-110,-20}}, color={0,127,255}));
  connect(hx1.port_a1, sensor_pT16.port_b) annotation (Line(points={{-160,-44},
          {-154,-44},{-154,-60},{-150,-60}}, color={0,127,255}));
  connect(boundary14.ports[1], sensor_pT13.port_b)
    annotation (Line(points={{-230,-60},{-210,-60}}, color={0,127,255}));
  connect(boundary15.ports[1], sensor_pT16.port_a)
    annotation (Line(points={{-112,-60},{-130,-60}}, color={0,127,255}));
  connect(realExpression1.y, PID.u_m)
    annotation (Line(points={{121,8},{148,8},{148,18}}, color={0,0,127}));
  connect(realExpression.y, PID.u_s)
    annotation (Line(points={{121,30},{136,30}}, color={0,0,127}));
  connect(realExpression3.y, PID1.u_m)
    annotation (Line(points={{123,-56},{150,-56},{150,-46}}, color={0,0,127}));
  connect(realExpression2.y, PID1.u_s)
    annotation (Line(points={{123,-34},{138,-34}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},
            {140,120}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,120}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Esdirk45a"));
end Model_1hh;
