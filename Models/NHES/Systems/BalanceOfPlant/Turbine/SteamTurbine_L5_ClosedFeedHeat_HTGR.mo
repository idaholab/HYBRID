within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L5_ClosedFeedHeat_HTGR "Two stage BOP model"
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
        origin={82,-26})));

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

  TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=init.FeedwaterMixVolume_p_start,
    use_T_start=false,
    h_start=init.FeedwaterMixVolume_h_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.V_FeedwaterMixVolume),
    nPorts_a=2,
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
        origin={90,-112})));

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
    nPorts_b=1,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-122,30},{-102,50}})));

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

  TRANSFORM.Fluid.Machines.Pump                pump_SimpleMassFlow2(
    p_a_start=5500000,
    use_T_start=true,
    h_start=1e6,
    N_nominal=1200,
    dp_nominal=15000000,
    m_flow_nominal=50,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    d_nominal=1000,
    controlType="RPM",
    use_port=true)                                       annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={-121,-41})));
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
      points={{92,24},{92,0},{82,0},{82,-16}},
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
  connect(LPT_Bypass.port_b, FeedwaterMixVolume.port_a[1])
    annotation (Line(points={{82,-36},{82,-44},{72,-44},{72,-58},{33.5,-58},{
          33.5,-88}},                                     color={0,127,255}));
  connect(Moisture_Separator.port_Liquid, FeedwaterMixVolume.port_a[2])
    annotation (Line(points={{64,36},{64,-44},{72,-44},{72,-58},{34.5,-58},{
          34.5,-88}},
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
        points={{60,-126},{90,-126},{90,-119}}, color={0,127,255}));
  connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
      Line(
      points={{30,100},{114,100},{114,-26},{90,-26}},
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
    annotation (Line(points={{-106,40},{-60,40},{-60,40},{-12,40}},
                                                  color={0,127,255}));
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
  connect(firstfeedpump.port_b, sensor_T4.port_b) annotation (Line(points={{98,-144},
          {90,-144}},                              color={0,127,255}));
  connect(sensor_T4.port_a, MainFeedwaterHeater.Tube_in) annotation (Line(
        points={{70,-144},{64,-144},{64,-132},{60,-132}}, color={0,127,255}));
  connect(MainFeedwaterHeater.Tube_out, sensor_T6.port_a)
    annotation (Line(points={{40,-132},{30,-132}}, color={0,127,255}));
  connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
          -112},{146,-144},{118,-144}},         color={0,127,255}));
  connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{50,-16},{60,
          -16},{60,-64},{154,-64},{154,-86},{153,-86},{153,-92}},
                                                         color={0,127,255}));
  connect(R_feedwater.port_a, Condenser.port_a) annotation (Line(points={{90,-105},
          {90,-78},{153,-78},{153,-92}},                 color={0,127,255}));
  connect(actuatorBus.Feed_Pump_Speed,pump_SimpleMassFlow2. inputSignal)
    annotation (Line(
      points={{30,100},{-56,100},{-56,-26},{-104,-26},{-104,-56},{-121,-56},{
          -121,-48.7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(port_b, pump_SimpleMassFlow2.port_b) annotation (Line(points={{-160,
          -40},{-146,-40},{-146,-41},{-132,-41}}, color={0,127,255}));
  connect(pump_SimpleMassFlow2.port_a, sensor_T2.port_b) annotation (Line(
        points={{-110,-41},{-94,-41},{-94,-42},{-68,-42},{-68,-40}}, color={0,
          127,255}));
  connect(sensor_T6.port_b, sensor_T2.port_a) annotation (Line(points={{10,-132},
          {-22,-132},{-22,-40},{-48,-40}}, color={0,127,255}));
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
</html>"));
end SteamTurbine_L5_ClosedFeedHeat_HTGR;
