within NHES.Systems.BalanceOfPlant.Turbine;
model Intermediate_Rankine_Cycle_TESUC_SmallCycle "Two stage BOP model"
  extends BaseClasses.Partial_SubSystem_C(
    redeclare replaceable ControlSystems.CS_IntermediateControl_PID_4 CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare Data.IntermediateTurbine data(
      p_steam_vent=15000000,
      T_Steam_Ref=491.15,
      Q_Nom=18.57e6,
      T_Feedwater=310.15,
      p_steam=1200000,
      p_in_nominal=1200000,
      p_condensor=8000,
      V_FeedwaterMixVolume=0.01,
      T_boundary=473.15,
      valve_TCV_mflow=30,
      valve_TCV_dp_nominal=10000,
      InternalBypassValve_mflow_small=0,
      InternalBypassValve_p_spring=15000000,
      InternalBypassValve_K=60,
      HPT_p_exit_nominal=8000,
      HPT_T_in_nominal=491.15,
      HPT_nominal_mflow=30,
      firstfeedpump_p_nominal=1200000));

  Data.IntermediateTurbineInitialisation init(
    p_steam_vent=15000000,
    T_Steam_Ref=491.15,
    Q_Nom=20e6,
    T_Feedwater=309.15,
    p_steam=1200000,
    FeedwaterMixVolume_p_start=1200000,
    header_p_start=1000000,
    header_h_start=2e6,
    FeedwaterMixVolume_h_start=1e6,
    InternalBypassValve_dp_start=3500000,
    InternalBypassValve_mflow_start=0.1,
    HPT_p_a_start=1000000,
    HPT_p_b_start=10000,
    HPT_T_a_start=491.15,
    HPT_T_b_start=313.15)
  annotation (Placement(transformation(extent={{68,120},{88,140}})));

  Fluid.Vessels.IdealCondenser Condenser(
    p= data.p_condensor,
    V_total=data.V_condensor,
    V_liquid_start=init.condensor_V_liquid_start)
    annotation (Placement(transformation(extent={{156,-112},{136,-92}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T1(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    p_start=3500000,
    T_start=579.15)                                    annotation (Placement(
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

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-72,-42})));

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

  TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=init.FeedwaterMixVolume_p_start,
    use_T_start=true,
    T_start=309.15,
    h_start=init.FeedwaterMixVolume_h_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.V_FeedwaterMixVolume),
    nPorts_a=1,
    nPorts_b=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-40})));

  Electrical.Generator      generator1(J=data.generator_MoI)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={98,-38})));

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
    annotation (Placement(transformation(extent={{-122,32},{-102,52}})));

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

  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{78,44},{98,24}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Modelica.Media.Water.StandardWater, m_flow)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-102,-170},{-82,-150}}),
        iconTransformation(extent={{-74,-106},{-54,-86}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass1(R=data.R_bypass,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={64,-22})));

  TRANSFORM.Fluid.Machines.SteamTurbine HPT(
    nUnits=1,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    eta_mech=data.HPT_efficiency,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=init.HPT_p_a_start,
    p_b_start=init.HPT_p_b_start,
    T_a_start=init.HPT_T_a_start,
    T_b_start=init.HPT_T_b_start,
    m_flow_nominal=data.HPT_nominal_mflow,
    use_Stodola=false,
    p_inlet_nominal=data.p_in_nominal,
    p_outlet_nominal=data.HPT_p_exit_nominal,
    T_nominal=data.HPT_T_in_nominal)
    annotation (Placement(transformation(extent={{36,24},{56,44}})));
initial equation

equation

  connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
      points={{-30,100},{4,100},{4,50},{22,50},{22,42.16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
      points={{4,40},{16,40}},
      color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
      points={{-30,100},{-30,12},{-48,12},{-48,-58},{-72,-58},{-72,-45.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{-4,100.1},{-4,46.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_p.port, TCV.port_a)
    annotation (Line(points={{-18,50},{-18,40},{-12,40}}, color={0,127,255}));

  connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{98,-48},
          {110,-48}},                              color={255,0,0}));
  connect(sensorW.port_b, portElec_b) annotation (Line(points={{130,-48},{146,
          -48},{146,0},{160,0}},                     color={255,0,0}));
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
    annotation (Line(points={{-125,40},{-122,40},{-122,42},{-118,42}},
                                                   color={0,127,255}));
  connect(header.port_b[1], TCV.port_a)
    annotation (Line(points={{-106,42},{-84,42},{-84,40},{-12,40}},
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
  connect(TBV.port_a, TCV.port_a) annotation (Line(points={{-120,74},{-68,74},{
          -68,40},{-12,40}},   color={0,127,255}));
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
        points={{-110,-41},{-110,-42},{-82,-42}},                    color={0,
          127,255}));
  connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
          -112},{146,-144},{118,-144}},         color={0,127,255}));
  connect(powerSensor.flange_b, generator1.shaft_a) annotation (Line(points={{98,34},
          {102,34},{102,-22},{98,-22},{98,-28}},   color={0,0,0}));
  connect(sensor_T2.port_a, FeedwaterMixVolume.port_a[1]) annotation (Line(
        points={{-62,-42},{-42,-42},{-42,-40},{-36,-40}}, color={0,127,255}));
  connect(FeedwaterMixVolume.port_b[1], sensor_T4.port_a) annotation (Line(
        points={{-24,-40.5},{-10,-40.5},{-10,-42},{32,-42},{32,-144},{70,-144}},
        color={0,127,255}));
  connect(FeedwaterMixVolume.port_b[2], port_a1) annotation (Line(points={{-24,
          -39.5},{-20,-39.5},{-20,-108},{-92,-108},{-92,-160}},
                                                            color={0,127,255}));
  connect(R_InternalBypass1.port_b, Condenser.port_a) annotation (Line(points={{
          64,-29},{64,-82},{154,-82},{154,-92},{153,-92}}, color={0,127,255}));
  connect(sensor_T1.port_b, HPT.portHP)
    annotation (Line(points={{28,40},{36,40}}, color={0,127,255}));
  connect(HPT.portLP, R_InternalBypass1.port_a)
    annotation (Line(points={{56,40},{64,40},{64,-15}}, color={0,127,255}));
  connect(HPT.shaft_b, powerSensor.flange_a)
    annotation (Line(points={{56,34},{78,34}}, color={0,0,0}));
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
end Intermediate_Rankine_Cycle_TESUC_SmallCycle;
