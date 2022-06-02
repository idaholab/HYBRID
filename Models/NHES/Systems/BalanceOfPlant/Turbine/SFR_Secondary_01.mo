within NHES.Systems.BalanceOfPlant.Turbine;
model SFR_Secondary_01
  "Brief steam cycle model developed for use with basic developed SFR loop"
  extends BaseClasses.Partial_SubSystem(
    redeclare replaceable Examples.CS_SFR_01 CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare Data.IdealTurbine data);

  PrimaryHeatSystem.HTGR.HTGR_Rankine.Data.DataInitial_HTGR_Pebble dataInitial(
      P_LP_Comp_Ref=4000000)
    annotation (Placement(transformation(extent={{78,120},{98,140}})));

  TRANSFORM.Fluid.Machines.SteamTurbine HPT(
    nUnits=1,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=12500000,
    p_b_start=8000,
    T_a_start=623.15,
    T_b_start=363.15,
    m_flow_nominal=230,
    p_inlet_nominal=12000000,
    p_outlet_nominal=10000,
    use_T_nominal=false,
    T_nominal=683.15,
    d_nominal=70)
    annotation (Placement(transformation(extent={{34,24},{54,44}})));
  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{62,24},{82,44}})));
  Fluid.Vessels.IdealCondenser Condenser(
    p=10000,
    V_total=5000,
    V_liquid_start=1.2)
    annotation (Placement(transformation(extent={{56,-28},{36,-8}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    N_nominal=1500,
    dp_nominal=12000000,
      m_flow_nominal=215,
    d_nominal=1100,
    N_input=1500)
    annotation (Placement(transformation(extent={{24,-30},{4,-50}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={22,40})));

  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=50) annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-4,40})));
  Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
    annotation (Placement(transformation(extent={{-100,106},{-88,120}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12500000,
    T_start=481.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5.0),
    use_HeatPort=true,
    use_TraceMassPort=false)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-36,-40})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-72,-40})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow    boundary1(use_port=
        true, Q_flow=5000000)
    annotation (Placement(transformation(extent={{-66,-80},{-46,-60}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a
    annotation (Placement(transformation(extent={{-108,28},{-86,50}}),
        iconTransformation(extent={{-108,28},{-86,50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b
    annotation (Placement(transformation(extent={{-108,-52},{-86,-30}}),
        iconTransformation(extent={{-108,-52},{-86,-30}})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_e
    annotation (Placement(transformation(extent={{92,4},{112,24}})));
initial equation

equation
  port_e.W = generator.power;

  connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
      points={{34,40},{28,40}},
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
  connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
      points={{-30,100},{-80,100},{-80,112},{-84,112},{-84,113},{-87.4,113}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
      points={{-30,100},{-118,100},{-118,-62},{-72,-62},{-72,-43.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{-4,100.1},{-4,46.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HPT.shaft_b, generator.shaft) annotation (Line(points={{54,34},{58,34},
          {58,33.9},{61.9,33.9}}, color={0,0,0}));
  connect(Condenser.port_a, HPT.portLP) annotation (Line(points={{53,-8},{80,-8},
          {80,22},{86,22},{86,42},{56,42},{56,40},{54,40}}, color={0,127,255}));
  connect(pump.port_a, Condenser.port_b) annotation (Line(points={{24,-40},{46,
          -40},{46,-28}},              color={0,127,255}));
  connect(sensor_T2.port_a, volume1.port_b)
    annotation (Line(points={{-62,-40},{-42,-40}}, color={0,127,255}));
  connect(pump.port_b, volume1.port_a)
    annotation (Line(points={{4,-40},{-30,-40}},   color={0,127,255}));
  connect(boundary1.port, volume1.heatPort) annotation (Line(points={{-46,-70},{
          -34,-70},{-34,-46},{-36,-46}},                     color={191,0,0}));
  connect(port_b, sensor_T2.port_b) annotation (Line(points={{-97,-41},{-90,-41},
          {-90,-40},{-82,-40}}, color={0,127,255}));
  connect(actuatorBus.Q_FWH, boundary1.Q_flow_ext) annotation (Line(
      points={{30,100},{96,100},{96,102},{146,102},{146,-92},{-86,-92},{-86,-84},
          {-76,-84},{-76,-70},{-60,-70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TCV.port_a, port_a)
    annotation (Line(points={{-12,40},{-97,39}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-2.09756,2},{83.9024,-2}},
          lineColor={0,0,0},
          origin={-45.9024,-64},
          rotation=360,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-1.81329,5},{66.1867,-5}},
          lineColor={0,0,0},
          origin={-68.1867,-41},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-16,3},{16,-3}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={4,30},
          rotation=-90),
        Rectangle(
          extent={{-1.81332,3},{66.1869,-3}},
          lineColor={0,0,0},
          origin={-18.1867,-3},
          rotation=0,
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-70,46},{-22,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{0,16},{0,-14},{30,-32},{30,36},{0,16}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{11,-8},{21,6}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Ellipse(
          extent={{46,12},{74,-14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-0.4,3},{15.5,-3}},
          lineColor={0,0,0},
          origin={30.4272,-29},
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
          extent={{-0.487802,2},{19.5122,-2}},
          lineColor={0,0,0},
          origin={20,-38.488},
          rotation=-90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.243902,2},{9.7562,-2}},
          lineColor={0,0,0},
          origin={-46,-62.244},
          rotation=-90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.578156,2.1722},{23.1262,-2.1722}},
          lineColor={0,0,0},
          origin={21.4218,-39.828},
          rotation=180,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-4,-34},{8,-46}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{-2,-44},{-6,-48},{10,-48},{6,-44},{-2,-44}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-20,46},{6,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-30,49},{-12,31}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{-20,49},{-22,61}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-30,63},{-12,61}},
          lineColor={0,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-19,49},{-23,31}},
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
          points={{3,-37},{3,-43},{-1,-40},{3,-37}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=30,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
end SFR_Secondary_01;
