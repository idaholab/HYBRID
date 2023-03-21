within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L2_OpenFeedHeat_VN "Two stage BOP model"
  extends BaseClasses.Partial_SubSystem_C(
    redeclare replaceable
      ControlSystems.CS_SteamTurbine_L2_OFWH_VN               CS,
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

  TRANSFORM.Fluid.Sensors.PressureTemperature
                                       sensor_pT(
                                                redeclare package Medium =
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

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-58,-40})));

  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow
                                           firstfeedpump(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater,
    use_input=true,
    m_flow_nominal=25,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={108,-144})));

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
        origin={28,-54})));

  Electrical.Generator      generator1(J=data.generator_MoI)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={44,-38})));

  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{110,-58},{130,-38}})));

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

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T4(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={80,-144})));

  replaceable Data.Turbine_2_init init(FeedwaterMixVolume_h_start=2e6)
    annotation (Placement(transformation(extent={{68,120},{88,140}})));

  TRANSFORM.Fluid.Volumes.Deaerator deaerator(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
        (
        V_liquid=10,
        length=5,
        r_inner=2,
        th_wall=0.1),
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    level_start=4,
    p_start=300000,
    use_T_start=false,
    d_wall=1000,
    cp_wall=420,
    Twall_start=373.15)
    annotation (Placement(transformation(extent={{56,-122},{36,-102}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_entry1(R=data.R_entry,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,-80})));
  Modelica.Blocks.Sources.RealExpression FWTank_level(y=deaerator.level)
    "level"
    annotation (Placement(transformation(extent={{180,-138},{192,-126}})));
  Modelica.Blocks.Sources.Constant const1(k=3)
    annotation (Placement(transformation(extent={{178,-108},{192,-94}})));
  TRANSFORM.Controls.LimPID Pump_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    with_FF=false,
    k=30,
    Ti=500,
    yb=0.01,
    k_s=0.9,
    k_m=0.9,
    yMax=40,
    yMin=2,
    wp=1,
    Ni=0.001,
    xi_start=0,
    y_start=0.01)
    annotation (Placement(transformation(extent={{220,-120},{234,-106}})));
  StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
    Moisture_Separator(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=init.moisturesep_p_start,
    T_start=init.moisturesep_T_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.V_moistureseperator))
    annotation (Placement(transformation(extent={{58,24},{78,44}})));
initial equation

equation

  connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
      points={{32,38},{30,38},{30,40},{28,40}},
      color={0,127,255},
      thickness=0.5));
  connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
      points={{4,40},{16,40}},
      color={0,127,255},
      thickness=0.5));
  connect(LPT.portHP, tee.port_1) annotation (Line(
      points={{50,4},{50,8},{82,8},{82,14}},
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

  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{-4,100.1},{-4,46.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_pT.port, TCV.port_a)
    annotation (Line(points={{-18,50},{-18,40},{-12,40}}, color={0,127,255}));

  connect(LPT.shaft_b, generator1.shaft_a)
    annotation (Line(points={{44,-16},{44,-28}}, color={0,0,0}));
  connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{44,-48},
          {110,-48}},                              color={255,0,0}));
  connect(sensorW.port_b, portElec_b) annotation (Line(points={{130,-48},{146,
          -48},{146,0},{160,0}},                     color={255,0,0}));
  connect(sensorBus.Steam_Pressure, sensor_pT.p) annotation (Line(
      points={{-30,100},{-30,62.4},{-24,62.4}},
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
  connect(firstfeedpump.port_b, sensor_T4.port_b) annotation (Line(points={{98,-144},
          {90,-144}},                              color={0,127,255}));
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
  connect(tee.port_3, FeedwaterMixVolume.port_a[1]) annotation (Line(points={{92,24},
          {94,24},{94,12},{27.75,12},{27.75,-48}},
        color={0,127,255}));
  connect(deaerator.feed, sensor_T4.port_a) annotation (Line(points={{53,-105},
          {64,-105},{64,-144},{70,-144}}, color={0,127,255}));
  connect(deaerator.steam, R_entry1.port_b) annotation (Line(points={{39,-105},
          {39,-96},{46,-96},{46,-87},{30,-87}}, color={0,127,255}));
  connect(R_entry1.port_a, FeedwaterMixVolume.port_b[1])
    annotation (Line(points={{30,-73},{30,-60},{28,-60}}, color={0,127,255}));
  connect(FWTank_level.y,Pump_Speed. u_m)
    annotation (Line(points={{192.6,-132},{227,-132},{227,-121.4}},
                                                           color={0,0,127}));
  connect(const1.y,Pump_Speed. u_s) annotation (Line(points={{192.7,-101},{
          192.7,-102},{214,-102},{214,-113},{218.6,-113}},
                              color={0,0,127}));
  connect(Pump_Speed.y, firstfeedpump.in_m_flow) annotation (Line(points={{
          234.7,-113},{234.7,-136.7},{108,-136.7}}, color={0,0,127}));
  connect(HPT.portLP, Moisture_Separator.port_a)
    annotation (Line(points={{52,38},{52,34},{62,34}}, color={0,127,255}));
  connect(Moisture_Separator.port_b, tee.port_2)
    annotation (Line(points={{74,34},{82,34}}, color={0,127,255}));
  connect(Moisture_Separator.port_Liquid, FeedwaterMixVolume.port_a[2])
    annotation (Line(points={{64,30},{60,30},{60,12},{28.25,12},{28.25,-48}},
        color={0,127,255}));
  connect(sensorBus.Steam_Temperature, sensor_pT.T) annotation (Line(
      points={{-30,100},{-30,57.8},{-24,57.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(deaerator.drain, sensor_T2.port_a) annotation (Line(points={{46,-120},
          {46,-128},{-42,-128},{-42,-40},{-48,-40}}, color={0,127,255}));
annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          extent={{32,-40},{60,-66}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-0.373344,2},{13.6267,-2}},
          lineColor={0,0,0},
          origin={18.3733,-54},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.341463,2},{13.6587,-2}},
          lineColor={0,0,0},
          origin={20,-42.3415},
          rotation=-90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-1.41463,2.0001},{56.5851,-2.0001}},
          lineColor={0,0,0},
          origin={-25.4149,-62.0001},
          rotation=180,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-26,-56},{-14,-68}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{-24,-66},{-28,-70},{-12,-70},{-16,-66},{-24,-66}},
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
          extent={{41,-60},{51,-46}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="C"),
        Polygon(
          points={{-19,-59},{-19,-65},{-23,-62},{-19,-59}},
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
          extent={{-14,-40},{12,-50}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-18,-40},{-8,-50}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,-40},{16,-50}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,-36},{4,-46}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-0.213341,2},{7.7867,-2}},
          lineColor={0,0,0},
          origin={14.2133,-44},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.341463,2},{13.6587,-2}},
          lineColor={0,0,0},
          origin={-2,-62.3415},
          rotation=90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.373344,2},{13.6267,-2}},
          lineColor={0,0,0},
          origin={-1.6267,-62},
          rotation=180,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder)}),         Diagram(
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
end SteamTurbine_L2_OpenFeedHeat_VN;
