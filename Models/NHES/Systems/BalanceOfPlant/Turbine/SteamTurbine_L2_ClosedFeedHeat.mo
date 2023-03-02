within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L2_ClosedFeedHeat "Two stage BOP model"
  extends BaseClasses.Partial_SubSystem_C(
    redeclare replaceable
      ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare replaceable Data.Turbine_2 data(InternalBypassValve_p_spring=
          6500000));

  TRANSFORM.Fluid.Machines.SteamTurbine HPT(
    nUnits=1,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    Q_units_start={1e7},
    eta_mech=data.HPT_efficiency,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=init.HPT_p_a_start,
    p_b_start=init.HPT_p_b_start,
    T_a_start=init.HPT_T_a_start,
    T_b_start=init.HPT_T_b_start,
    m_flow_nominal=data.HPT_nominal_mflow,
    p_inlet_nominal= data.p_in_nominal,
    p_outlet_nominal=data.HPT_p_exit_nominal,
    T_nominal=data.HPT_T_in_nominal)
    annotation (Placement(transformation(extent={{32,22},{52,42}})));

  Fluid.Vessels.IdealCondenser Condenser(
    p= data.p_condensor,
    V_total=data.V_condensor,
    V_liquid_start=init.condensor_V_liquid_start)
    annotation (Placement(transformation(extent={{156,-112},{136,-92}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={22,40})));

  TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater, redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                       annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-18,60})));

  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=400,
    dp_nominal=data.valve_TCV_dp_nominal,
    m_flow_nominal=data.valve_TCV_mflow)
                       annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-4,40})));

  TRANSFORM.Fluid.Machines.SteamTurbine LPT(
    nUnits=1,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    Q_units_start={3e7},
    eta_mech=data.LPT_efficiency,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=init.LPT_p_a_start,
    p_b_start=init.LPT_p_b_start,
    T_a_start=init.LPT_T_a_start,
    T_b_start=init.LPT_T_b_start,
    m_flow_nominal=data.LPT_nominal_mflow,
    p_inlet_nominal= data.LPT_p_in_nominal,
    p_outlet_nominal=data.LPT_p_exit_nominal,
    T_nominal=data.LPT_T_in_nominal) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={44,-6})));

  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
      package Medium = Modelica.Media.Water.StandardWater, V=data.V_tee,
    p_start=init.tee_p_start,
    T_start=init.moisturesep_T_start)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={82,24})));

  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=data.valve_LPT_Bypass_dp_nominal,
    m_flow_nominal=data.valve_LPT_Bypass_mflow)   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={84,-26})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-58,-40})));

  TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                           firstfeedpump(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=data.firstfeedpump_p_nominal,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={108,-144})));

  StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
    Moisture_Separator(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    p_start=init.moisturesep_p_start,
    T_start=init.moisturesep_T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.V_moistureseperator))
    annotation (Placement(transformation(extent={{58,30},{78,50}})));

  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass(R=data.R_bypass,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-24,-2})));

  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase MainFeedwaterHeater(
    NTU=data.MainFeedHeater_NTU,
    K_tube=data.MainFeedHeater_K_tube,
    K_shell=data.MainFeedHeater_K_shell,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=data.MainFeedHeater_V_tube,
    V_Shell=data.MainFeedHeater_V_shell,
    p_start_tube=init.MainFeedHeater_p_start_tube,
    h_start_tube_inlet=init.MainFeedHeater_h_start_tube_inlet,
    h_start_tube_outlet=init.MainFeedHeater_h_start_tube_outlet,
    p_start_shell=init.MainFeedHeater_p_start_shell,
    h_start_shell_inlet=init.MainFeedHeater_h_start_shell_inlet,
    h_start_shell_outlet=init.MainFeedHeater_h_start_shell_outlet,
    dp_init_tube=init.MainFeedHeater_dp_init_tube,
    dp_init_shell=init.MainFeedHeater_dp_init_shell,
    Q_init=init.MainFeedHeater_Q_init,
    m_start_tube=init.MainFeedHeater_m_start_tube,
    m_start_shell=init.MainFeedHeater_m_start_shell)
    annotation (Placement(transformation(extent={{40,-118},{60,-138}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase BypassFeedwaterHeater(
    NTU=data.BypassFeedHeater_NTU,
    K_tube=data.BypassFeedHeater_K_tube,
    K_shell=data.BypassFeedHeater_K_shell,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=data.BypassFeedHeater_V_tube,
    V_Shell=data.BypassFeedHeater_V_shell,
    p_start_tube=init.BypassFeedHeater_p_start_tube,
    h_start_tube_inlet=init.BypassFeedHeater_h_start_tube_inlet,
    h_start_tube_outlet=init.BypassFeedHeater_h_start_tube_outlet,
    p_start_shell=init.BypassFeedHeater_p_start_shell,
    h_start_shell_inlet=init.BypassFeedHeater_h_start_shell_inlet,
    h_start_shell_outlet=init.BypassFeedHeater_h_start_shell_outlet,
    dp_init_tube=init.BypassFeedHeater_dp_init_tube,
    dp_init_shell=init.BypassFeedHeater_dp_init_shell,
    Q_init=init.BypassFeedHeater_Q_init,
    m_start_tube=init.BypassFeedHeater_m_start_tube,
    m_start_shell=init.BypassFeedHeater_m_start_shell)
    annotation (Placement(transformation(extent={{-20,-26},{0,-46}})));

  TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=init.FeedwaterMixVolume_p_start,
    use_T_start=false,
    h_start=init.FeedwaterMixVolume_h_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.V_FeedwaterMixVolume),
    nPorts_a=3,
    nPorts_b=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={34,-94})));

  Electrical.Generator      generator1(J=data.generator_MoI)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={44,-38})));

  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{110,-58},{130,-38}})));

  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_feedwater(R=data.R_feedwater,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,-110})));

  TRANSFORM.Fluid.Machines.Pump_PressureBooster SecondFeedwaterPump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=data.secondfeedpump_p_nominal,
    allowFlowReversal=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={6,-76})));

  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_entry(R=data.R_entry,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-132,40})));

  TRANSFORM.Fluid.Volumes.MixingVolume header(
    use_T_start=false,
    h_start=init.header_h_start,
    p_start=init.header_p_start,
    nPorts_a=1,
    nPorts_b=2,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-122,30},{-102,50}})));

  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=data.controlledfeedpump_mflow_nominal,
    use_input=true,
    redeclare package Medium =
        Modelica.Media.Water.StandardWater)              annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={-121,-41})));

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=data.p_boundary,
    T=data.T_boundary,
    nPorts=1)
    annotation (Placement(transformation(extent={{-168,64},{-148,84}})));

  TRANSFORM.Fluid.Valves.ValveLinear TBV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=data.valve_TBV_dp_nominal,
    m_flow_nominal=data.valve_TBV_mflow) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-128,74})));

  StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve InternalBypassValve(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_start=init.InternalBypassValve_dp_start,
    m_flow_start=init.InternalBypassValve_mflow_start,
    m_flow_small=data.InternalBypassValve_mflow_small,
    p_spring=data.InternalBypassValve_p_spring,
    K=data.InternalBypassValve_K,
    opening_init=0,
    tau=data.InternalBypassValve_tau)
    annotation (Placement(transformation(extent={{-82,10},{-62,30}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T4(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={80,-144})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T6(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={20,-132})));

  replaceable Data.Turbine_2_init init(FeedwaterMixVolume_h_start=2e6)
    annotation (Placement(transformation(extent={{68,120},{88,140}})));

initial equation

equation

  connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
      points={{32,38},{30,38},{30,40},{28,40}},
      color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
      points={{-30,100},{4,100},{4,50},{22,50},{22,42.16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
      points={{4,40},{16,40}},
      color={0,127,255},
      thickness=0.5));
  connect(LPT.portHP, tee.port_1) annotation (Line(
      points={{50,4},{50,8},{82,8},{82,14}},
      color={0,127,255},
      thickness=0.5));
  connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
      points={{92,24},{92,0},{84,0},{84,-16}},
      color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
      points={{-30,100},{-44,100},{-44,-56},{-58,-56},{-58,-43.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
      points={{52,32},{52,14},{44,14},{44,4}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(HPT.portLP, Moisture_Separator.port_a) annotation (Line(
      points={{52,38},{58,38},{58,40},{62,40}},
      color={0,127,255},
      thickness=0.5));
  connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
      points={{74,40},{82,40},{82,34}},
      color={0,127,255},
      thickness=0.5));

  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{-4,100.1},{-4,46.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_p.port, TCV.port_a)
    annotation (Line(points={{-18,50},{-18,40},{-12,40}}, color={0,127,255}));
  connect(R_InternalBypass.port_b, BypassFeedwaterHeater.Shell_in) annotation (
      Line(points={{-24,-9},{-24,-34},{-20,-34}}, color={0,127,255}));
  connect(BypassFeedwaterHeater.Shell_out, FeedwaterMixVolume.port_a[1])
    annotation (Line(points={{0,-34},{30,-34},{30,-80},{33.6667,-80},{33.6667,
          -88}},                   color={0,127,255}));
  connect(LPT_Bypass.port_b, FeedwaterMixVolume.port_a[2])
    annotation (Line(points={{84,-36},{84,-44},{72,-44},{72,-58},{34,-58},{34,
          -88}},                                          color={0,127,255}));
  connect(Moisture_Separator.port_Liquid, FeedwaterMixVolume.port_a[3])
    annotation (Line(points={{64,36},{64,-44},{72,-44},{72,-58},{34.3333,-58},{
          34.3333,-88}},
                 color={0,127,255}));

  connect(LPT.shaft_b, generator1.shaft_a)
    annotation (Line(points={{44,-16},{44,-28}}, color={0,0,0}));
  connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{44,-48},
          {110,-48}},                              color={255,0,0}));
  connect(sensorW.port_b, portElec_b) annotation (Line(points={{130,-48},{146,
          -48},{146,0},{160,0}},                     color={255,0,0}));
  connect(FeedwaterMixVolume.port_b[1], MainFeedwaterHeater.Shell_in)
    annotation (Line(points={{34,-100},{34,-126},{40,-126}},
        color={0,127,255}));
  connect(MainFeedwaterHeater.Shell_out,R_feedwater. port_b) annotation (Line(
        points={{60,-126},{90,-126},{90,-117}}, color={0,127,255}));
  connect(SecondFeedwaterPump.port_b, BypassFeedwaterHeater.Tube_in)
    annotation (Line(points={{6,-66},{6,-40},{0,-40}}, color={0,127,255}));
  connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
      Line(
      points={{30,100},{114,100},{114,-26},{92,-26}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
      points={{-30,100},{-30,60},{-24,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Power, sensorW.W) annotation (Line(
      points={{-30,100},{120,100},{120,-37}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(port_a, R_entry.port_a)
    annotation (Line(points={{-160,40},{-139,40}}, color={0,127,255}));
  connect(R_entry.port_b, header.port_a[1])
    annotation (Line(points={{-125,40},{-118,40}}, color={0,127,255}));
  connect(header.port_b[1], TCV.port_a)
    annotation (Line(points={{-106,39.75},{-60,39.75},{-60,40},{-12,40}},
                                                  color={0,127,255}));
  connect(actuatorBus.Feed_Pump_Speed, pump_SimpleMassFlow1.in_m_flow)
    annotation (Line(
      points={{30,100},{-90,100},{-90,-58},{-121,-58},{-121,-49.03}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(TBV.port_a, TCV.port_a) annotation (Line(points={{-120,74},{-104,74},
          {-104,40},{-12,40}}, color={0,127,255}));
  connect(boundary.ports[1], TBV.port_b)
    annotation (Line(points={{-148,74},{-136,74}}, color={0,127,255}));
  connect(actuatorBus.TBV, TBV.opening) annotation (Line(
      points={{30,100},{-128,100},{-128,80.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(InternalBypassValve.port_a, header.port_b[2]) annotation (Line(points={{-82,20},
          {-104,20},{-104,40},{-106,40},{-106,40.25}},         color={0,127,255}));
  connect(InternalBypassValve.port_b, R_InternalBypass.port_a)
    annotation (Line(points={{-62,20},{-24,20},{-24,5}}, color={0,127,255}));
  connect(firstfeedpump.port_b, sensor_T4.port_b) annotation (Line(points={{98,-144},
          {90,-144}},                              color={0,127,255}));
  connect(sensor_T4.port_a, MainFeedwaterHeater.Tube_in) annotation (Line(
        points={{70,-144},{64,-144},{64,-132},{60,-132}}, color={0,127,255}));
  connect(MainFeedwaterHeater.Tube_out, sensor_T6.port_a)
    annotation (Line(points={{40,-132},{30,-132}}, color={0,127,255}));
  connect(sensor_T6.port_b, SecondFeedwaterPump.port_a)
    annotation (Line(points={{10,-132},{4,-132},{4,-90},{6,-90},{6,-86}},
                                                          color={0,127,255}));
  connect(sensor_T2.port_a, BypassFeedwaterHeater.Tube_out)
    annotation (Line(points={{-48,-40},{-20,-40}}, color={0,127,255}));
  connect(port_b, pump_SimpleMassFlow1.port_b) annotation (Line(points={{-160,-40},
          {-132,-40},{-132,-41}},                            color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_a, sensor_T2.port_b) annotation (Line(
        points={{-110,-41},{-94,-41},{-94,-42},{-68,-42},{-68,-40}}, color={0,
          127,255}));
  connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
          -112},{146,-144},{118,-144}},         color={0,127,255}));
  connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{50,-16},{60,
          -16},{60,-64},{154,-64},{154,-86},{153,-86},{153,-92}},
                                                         color={0,127,255}));
  connect(R_feedwater.port_a, Condenser.port_a) annotation (Line(points={{90,-103},
          {90,-78},{153,-78},{153,-92}},                 color={0,127,255}));
annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-24,2},{24,-2}},
          lineColor={0,0,0},
          fillColor={64,164,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={20,-42},
          rotation=180),
        Rectangle(
          extent={{-11.5,3},{11.5,-3}},
          lineColor={0,0,0},
          fillColor={64,164,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-1,-28.5},
          rotation=90),
        Rectangle(
          extent={{-4.5,2.5},{4.5,-2.5}},
          lineColor={0,0,0},
          fillColor={64,164,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-8.5,-31.5},
          rotation=360),
        Rectangle(
          extent={{-0.800004,5},{29.1996,-5}},
          lineColor={0,0,0},
          origin={-71.1996,-49},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-18,3},{18,-3}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-39,28},
          rotation=-90),
        Rectangle(
          extent={{-1.81332,3},{66.1869,-3}},
          lineColor={0,0,0},
          origin={-18.1867,-3},
          rotation=0,
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-70,46},{-36,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{-42,12},{-42,-18},{-12,-36},{-12,32},{-42,12}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-31,-10},{-21,4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="HPT"),
        Ellipse(
          extent={{46,12},{74,-14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-0.601938,3},{23.3253,-3}},
          lineColor={0,0,0},
          origin={22.6019,-29},
          rotation=0,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.43805,2.7864},{15.9886,-2.7864}},
          lineColor={0,0,0},
          origin={45.2136,-41.989},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{32,-42},{60,-68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-0.373344,2},{13.6267,-2}},
          lineColor={0,0,0},
          origin={18.3733,-56},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.341463,2},{13.6587,-2}},
          lineColor={0,0,0},
          origin={20,-44.3415},
          rotation=-90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-1.41463,2.0001},{56.5851,-2.0001}},
          lineColor={0,0,0},
          origin={18.5851,-46.0001},
          rotation=180,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-46,-40},{-34,-52}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{-44,-50},{-48,-54},{-32,-54},{-36,-50},{-44,-50}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Ellipse(
          extent={{-56,49},{-38,31}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{-46,49},{-48,61}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-56,63},{-38,61}},
          lineColor={0,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-45,49},{-49,31}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={162,162,0}),
        Text(
          extent={{55,-10},{65,4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="G"),
        Text(
          extent={{41,-62},{51,-48}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="C"),
        Polygon(
          points={{-39,-43},{-39,-49},{-43,-46},{-39,-43}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Polygon(
          points={{-4,12},{-4,-18},{26,-36},{26,32},{-4,12}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{7,-10},{17,4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="LPT"),
        Rectangle(
          extent={{-4,-40},{22,-48}},
          lineColor={238,46,47},
          pattern=LinePattern.None,
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={28,108,200}),
        Line(
          points={{-4,-44},{22,-44}},
          color={255,0,0},
          thickness=1)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>A two stage turbine rankine cycle with feedwater heating internal to the system - can be externally bypassed or LPT can be bypassed both will feedwater heat post bypass</p>
<p>&nbsp; </p>
<p align=\"center\"><img src=\"file:///C:/Users/RIGBAC/AppData/Local/Temp/1/msohtmlclip1/01/clip_image002.jpg\"/> </p>
<p><b><span style=\"font-size: 18pt;\">Design Purpose</span></b> </p>
<p>The main purpose of this model is to provide a simple and flexible two stage BOP with realistic accounting of feedwater heating. It should be used in cases where a more rigorous accounting of efficiency is required compared to the SteamTurbines_L1_boundaries model and the StageByStage turbine model would add unnecessary complexity. </p>
<p><b><span style=\"font-size: 18pt;\">Location and Examples</span></b> </p>
<p>The location of this model is at NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L2_ClosedFeedHeat the best use case example of this model is at NHES.Systems.Examples.SMR_highfidelity_L2_Turbine. </p>
<p>&nbsp; </p>
<p><b><span style=\"font-size: 18pt;\">Normal Operation</span></b> </p>
<p>The model uses two TRANSFORM SteamTurbine models with the intermediate pressure to be chosen by the user (nominally set at 7 Bar). Any liquid condensing in the turbines is removed via a moisture separator. The model has closed feedwater heating with steam bled from between the two turbines fed to the main NTU heat exchanger with contact to the main feedwater flow. Additional feedwater heating can be provided with an internal bypass loop from the main steam line to a supplementary NTU heat exchanger with this flow controlled by a set pressure spring valve. This steam is used again in the main NTU heat exchanger after mixing in the feedwater mixing volume. The model uses an ideal condenser with a fixed pressure that must be specified by the user (nominally set to 0.1 Bar). In the feedwater line &ndash; fixed &ldquo;pressure booster&rdquo; pumps are used to move the steam away from saturation conditions. Depending on the set pressure between turbines these pumps must be set sufficiently to prevent saturation in either of the heat exchangers tube sides. An additional final feedwater pump is used to control pressure exiting the primary heat system. Finally, the model also has a blow-off valve to an external boundary condition on the main steam line to prevent over-pressurization. </p>
<p><b><span style=\"font-size: 18pt;\">Control system</span></b> </p>
<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\" width=\"662\"><tr>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 11pt;\">Label</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Name</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Controlling</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Nominal Setpoint</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 11pt;\">1</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Turbine Control Valve</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Power (HPT and LPT)</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">40 MW</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 11pt;\">2</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Low Pressure Turbine Bypass</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Feedwater Temperature</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">148&deg;C</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 11pt;\">3</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Internal Bypass Valve</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Bypass Mass Flow</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">0 kg/s</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 11pt;\">4</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Feedwater Pump</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Steam Inlet Pressure (HPT)</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">34 bar</span> </p></td>
</tr>
<tr>
<td valign=\"top\"><p align=\"center\"><span style=\"font-size: 11pt;\">5</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Pressure Relief Valve</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">Pressure Overloads</span> </p></td>
<td valign=\"top\"><p><span style=\"font-size: 11pt;\">150 bar</span> </p></td>
</tr>
</table>
<p><br><img src=\"file:///C:/Users/RIGBAC/AppData/Local/Temp/1/msohtmlclip1/01/clip_image004.png\"/> </p>
<p>&nbsp; </p>
<p>The control system is designed to ensure nominal conditions in normal operation. In load follow or extreme transients additional control elements may be required in the model. The three key required setpoint conditions are power, feedwater temperature and steam inlet pressure to the BOP. These are specified in the data table in the control system model. The internal bypass valve spring pressure is not a controlled variable and is set in the BOP model data table. Depending on the K value of this valve (also specified in the BOP data table) one can control the leakage mass flow required for the supplementary heat exchanger to prevent no flow errors. </p>
<p><b><span style=\"font-size: 18pt;\">Changing Parameters</span></b> </p>
<p>All parameters in the model should be accessible and changed in the data table data. All initialization conditions should be changed using the init table. These have initial value in to guide your choices or aid simulation set up. </p>
<p><b><span style=\"font-size: 18pt;\">Considerations In Parameters</span></b> </p>
<p>The key considerations when changing the turbine parameters to match an arbitrary Rankine cycle are the pressures in the fixed pressure booster pumps. These should be adjusted so the outlets of the HX tube sides are pushed away from saturation conditions. The further these exit flows are away from the saturation condition the better reliability in transient operation the model will have but this will impact your efficiencies. These pump pressures are a function of setting the intermediate pressure and the first feed pump should always be sufficiently low pressure rise for heat to flow from the bypass stream to the feedwater heat not the other way round. </p>
<p>Other considerations when parameterizing the model are listed below </p>
<p>1.<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Valve sizes </p>
<p>a.<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Internal Bypass Valve K value should be low enough to allow a nominal flow through the supplementary HX. </p>
<p>b.<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Nominal conditions on TCV and LPT_Bypass should be tuned to allow the full range of desired operating conditions </p>
<p>c.<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>TBV should be set that it only opens in extreme circumstances </p>
<p>2.<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Turbine nominal conditions </p>
<p>a.<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>These must be fine tuned to desired power output for given steam conditions. There doesn&rsquo;t seem to be an exact way to do this but it would be good to know if found. </p>
<p>3.<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Volumes in system </p>
<p>a.<span style=\"font-family: Times New Roman; font-size: 7pt;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Many of the volumes are set too large to aid initialization. These may be changed to reflect actual BOP designs, but initialization may be more difficult. </p>
<p><b><span style=\"font-size: 18pt;\">Contact Deatils</span></b> </p>
<p>This model was designed by Aidan Rigby (<a href=\"mailto:aidan.rigby@inl.gov\">aidan.rigby@inl.gov</a> , <a href=\"mailto:acrigby@wisc.edu\">acrigby@wisc.edu</a> ). All initial questions should be directed to Daniel Mikkelson (<a href=\"mailto:Daniel.Mikkelson@inl.gov\">Daniel.Mikkelson@inl.gov</a>). </p>
</html>"));
end SteamTurbine_L2_ClosedFeedHeat;
