within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_Basic_NoFeedHeat_mFlow_Control "Two stage BOP model"

  // Modified from

  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_SubSystem_C(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp
      CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ED_Dummy ED,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.Data.TESTurbine data(
      p_condensor=7000,
      V_FeedwaterMixVolume=10,
      V_Header=10,
      R_entry=8e4,
      valve_SHS_mflow=30,
      valve_SHS_dp_nominal=1200000,
      valve_TCV_LPT_mflow=30,
      valve_TCV_LPT_dp_nominal=10000,
      InternalBypassValve_mflow_small=0,
      InternalBypassValve_p_spring=15000000,
      InternalBypassValve_K=40,
      LPT_p_in_nominal=1200000,
      LPT_p_exit_nominal=7000,
      LPT_T_in_nominal=491.15,
      LPT_nominal_mflow=27.4,
      LPT_efficiency=1,
      firstfeedpump_p_nominal=2000000,
      secondfeedpump_p_nominal=2000000));

  replaceable
    NHES.Systems.BalanceOfPlant.Turbine.Data.IntermediateTurbineInitialisation
    init(
    FeedwaterMixVolume_p_start=3000000,
    FeedwaterMixVolume_h_start=2e6,
    InternalBypassValve_dp_start=3500000,
    InternalBypassValve_mflow_start=0.1,
    HPT_p_a_start=3000000,
    HPT_p_b_start=10000,
    HPT_T_a_start=523.15,
    HPT_T_b_start=333.15)
    annotation (Placement(transformation(extent={{68,120},{88,140}})));

  NHES.Fluid.Vessels.IdealCondenser Condenser(
    p=data.p_condensor,
    V_total=data.V_condensor,
    V_liquid_start=init.condensor_V_liquid_start)
    annotation (Placement(transformation(extent={{20,-24},{-4,0}})));

  NHES.Electrical.Generator generator1(J=data.generator_MoI) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,20})));

  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{110,10},{130,30}})));

  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{40,30},{60,10}})));

  TRANSFORM.Fluid.Machines.SteamTurbine LPT(
    nUnits=1,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    eta_mech=data.LPT_efficiency,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=0.9),
    p_a_start=init.LPT_p_a_start,
    p_b_start=init.LPT_p_b_start,
    T_a_start=init.LPT_T_a_start,
    T_b_start=init.LPT_T_b_start,
    m_flow_nominal=data.LPT_nominal_mflow,
    p_inlet_nominal=data.LPT_p_in_nominal,
    p_outlet_nominal=data.LPT_p_exit_nominal,
    T_nominal=data.LPT_T_in_nominal) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={0,26})));
  TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater, redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                       annotation (Placement(
        transformation(
        extent={{-86,34},{-66,54}},
        rotation=0)));
  NHES.Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-18,-84},{-44,-56}})));
  NHES.Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-132,6},{-108,34}})));
  NHES.Fluid.Sensors.stateSensor stateSensor3(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-34,6},{-10,34}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled firstfeedpump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_a_start=10000,
    p_b_start=1100000,
    redeclare model FlowChar =
        TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Flow.PerformanceCurve,
    redeclare model EfficiencyChar =
        TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Efficiency.Constant,
    N_nominal=1500,
    dp_nominal=1200000,
    m_flow_nominal=26,
    controlType="m_flow",
    use_port=true)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={54,-64})));

initial equation

equation

  connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{100,20},
          {110,20}},                               color={255,0,0}));
  connect(sensorW.port_b, portElec_b) annotation (Line(points={{130,20},{
          144,20},{144,0},{160,0}},                  color={255,0,0}));
  connect(sensorBus.Power, sensorW.W) annotation (Line(
      points={{-30,100},{-30,74},{120,74},{120,31}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(powerSensor.flange_b, generator1.shaft_a) annotation (Line(points={{60,20},
          {80,20}},                                color={0,0,0}));
  connect(LPT.shaft_b, powerSensor.flange_a)
    annotation (Line(points={{10,26},{32,26},{32,20},{40,20}},
                                                          color={0,0,0}));
  connect(sensorBus.Steam_Pressure,sensor_p. p) annotation (Line(
      points={{-30,100},{-30,38},{-60,38},{-60,44},{-70,44}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Condenser.port_a, LPT.portLP) annotation (Line(points={{16.4,
          -8.88178e-16},{16.4,20},{10,20}},
                                 color={0,127,255}));
  connect(stateSensor1.port_b, port_b) annotation (Line(points={{-44,-70},{
          -144,-70},{-144,-40},{-160,-40}}, color={0,127,255}));
  connect(port_a, stateSensor2.port_a) annotation (Line(points={{-160,40},{
          -136,40},{-136,20},{-132,20}}, color={0,127,255}));
  connect(LPT.portHP, stateSensor3.port_b)
    annotation (Line(points={{-10,20},{-10,20}}, color={0,127,255}));
  connect(sensor_p.port, stateSensor3.port_a)
    annotation (Line(points={{-76,34},{-76,20},{-34,20}},
                                                 color={0,127,255}));
  connect(Condenser.port_b, firstfeedpump1.port_a) annotation (Line(points=
          {{8,-24},{8,-50},{68,-50},{68,-64},{64,-64}}, color={0,127,255}));
  connect(stateSensor1.port_a, firstfeedpump1.port_b) annotation (Line(
        points={{-18,-70},{38,-70},{38,-64},{44,-64}}, color={0,127,255}));
  connect(actuatorBus.Feed_Pump_mFlow, firstfeedpump1.inputSignal)
    annotation (Line(
      points={{30,100},{30,-48},{54,-48},{54,-57}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(stateSensor2.port_b, stateSensor3.port_a)
    annotation (Line(points={{-108,20},{-34,20}}, color={0,127,255}));
annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -140},{160,140}}),                                graphics={
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
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},{
            160,140}})),
    experiment(
      StopTime=1000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>A two stage turbine rankine cycle with feedwater heating internal to the system - can be externally bypassed or LPT can be bypassed both will feedwater heat post bypass</p>
</html>"));
end SteamTurbine_Basic_NoFeedHeat_mFlow_Control;
