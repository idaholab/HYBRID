within NHES.Systems.BalanceOfPlant.Turbine;
model Intermediate_Rankine_Cycle_Control "Two stage BOP model"
  extends BaseClasses.Partial_SubSystem_C(
    redeclare replaceable ControlSystems.CS_IntermediateControl CS,
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
    p_a_start=3000000,
    p_b_start=8000,
    T_a_start=673.15,
    T_b_start=343.15,
    m_flow_nominal=200,
    p_inlet_nominal=14000000,
    p_outlet_nominal=3000000,
    T_nominal=673.15)
    annotation (Placement(transformation(extent={{34,24},{54,44}})));
  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{34,-34},{14,-14}})));
  Fluid.Vessels.IdealCondenser Condenser(
    p=10000,
    V_total=200,
    V_liquid_start=1.2)
    annotation (Placement(transformation(extent={{56,-58},{36,-38}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    N_nominal=1200,
    dp_nominal=1000000,
    m_flow_nominal=50,
    d_nominal=1000,
    controlType="RPM",
    use_port=true)
    annotation (Placement(transformation(extent={{-62,-30},{-82,-50}})));
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
        origin={-18,76})));

  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=400,
    dp_nominal=100000,
    m_flow_nominal=500)
                       annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-4,40})));
  Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
    annotation (Placement(transformation(extent={{-100,106},{-88,120}})));
  TRANSFORM.Fluid.Machines.SteamTurbine LPT(
    nUnits=1,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=3000000,
    p_b_start=8000,
    T_a_start=673.15,
    T_b_start=343.15,
    m_flow_nominal=200,
    p_inlet_nominal=2500000,
    p_outlet_nominal=8000,
    T_nominal=673.15) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={46,-6})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
      package Medium = Modelica.Media.Water.StandardWater,
    V=0.1,
    p_start=3000000)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={76,26})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=2.5) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={94,-32})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-118,-40})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{6,-7},{-6,7}},
        rotation=90,
        origin={61,-24})));
  TRANSFORM.Fluid.Valves.ValveCompressible valve_BV(
    dp_start=100000,
    rho_nominal=Medium.density_ph(port_a_nominal.p, port_a_nominal.h),
    opening_nominal=1,
    p_nominal=port_a_nominal.p,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_nominal=port_a_nominal.m_flow,
    dp_nominal=100000)
    annotation (Placement(transformation(extent={{-50,6},{-30,26}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance3(R=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-10})));
  Modelica.Fluid.Fittings.MultiPort multiPort(redeclare package Medium =
        Modelica.Media.Water.StandardWater, nPorts_b=2)
                       annotation (Placement(transformation(
        extent={{-4,-10},{4,10}},
        rotation=90,
        origin={64,-106})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                           pump2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=12000000,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{26,-140},{4,-118}})));
  Modelica.Fluid.Fittings.MultiPort multiPort1(redeclare package Medium =
        Modelica.Media.Water.StandardWater, nPorts_b=2)
                       annotation (Placement(transformation(
        extent={{6,-14},{-6,14}},
        rotation=180,
        origin={-26,-40})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    p_start=8000000,
    use_T_start=true,
    T_start=473.15,
    h_start=port_a_start.h,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    "included for numeric purposes"
    annotation (Placement(transformation(extent={{-56,-50},{-36,-30}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume2(
    p_start=1810000,
    use_T_start=true,
    T_start=473.15,
    h_start=port_a_start.h,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.01),
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    "included for numeric purposes"
    annotation (Placement(transformation(extent={{38,-142},{58,-122}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(R=10,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={94,-72})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                           pump3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=1800000,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{46,-88},{70,-64}})));
initial equation

equation

  connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
      points={{34,40},{28,40}},
      color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
      points={{-30,100},{4,100},{4,50},{22,50},{22,42.16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
      points={{30,100},{116,100},{116,-142},{-72,-142},{-72,-47}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
      points={{-30,100},{-30,76},{-24,76}},
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
  connect(LPT.portHP, tee.port_1) annotation (Line(
      points={{52,4},{52,8},{76,8},{76,16}},
      color={0,127,255},
      thickness=0.5));
  connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
      points={{86,26},{94,26},{94,-22}},
      color={0,127,255},
      thickness=0.5));
  connect(sensor_T2.port_a, pump.port_b)
    annotation (Line(points={{-108,-40},{-82,-40}},
                                                  color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
      points={{-30,100},{-96,100},{-96,-56},{-118,-56},{-118,-43.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
      points={{54,34},{54,14},{46,14},{46,4}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
      Line(
      points={{30,100},{116,100},{116,-32},{102,-32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
      points={{52,-16},{52,-18},{61,-18}},
      color={0,127,255},
      thickness=0.5));
  connect(sensor_m_flow1.port_b,Condenser. port_a)
    annotation (Line(points={{61,-30},{61,-36},{53,-36},{53,-38}},
                                                     color={0,127,255},
      thickness=0.5));

  connect(LPT.shaft_b, generator.shaft) annotation (Line(points={{46,-16},{46,-24.1},
          {34.1,-24.1}}, color={0,0,0}));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{-4,100.1},{-4,46.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_T2.port_b, port_b)
    annotation (Line(points={{-128,-40},{-160,-40}},color={0,127,255}));
  connect(sensor_p.port, TCV.port_a)
    annotation (Line(points={{-18,66},{-18,40},{-12,40}}, color={0,127,255}));
  connect(port_a, TCV.port_a)
    annotation (Line(points={{-160,40},{-12,40}}, color={0,127,255}));
  connect(valve_BV.port_a, TCV.port_a) annotation (Line(points={{-50,16},{-64,
          16},{-64,40},{-12,40}}, color={0,127,255}));
  connect(pump2.port_b, multiPort1.ports_b[1]) annotation (Line(points={{4,-129},
          {0,-129},{0,-42.8},{-20,-42.8}},                 color={0,127,255}));
  connect(pump.port_a, volume1.port_a)
    annotation (Line(points={{-62,-40},{-52,-40}}, color={0,127,255}));
  connect(volume1.port_b, multiPort1.port_a)
    annotation (Line(points={{-40,-40},{-32,-40}}, color={0,127,255}));
  connect(volume2.port_a, pump2.port_a) annotation (Line(points={{42,-132},{28,-132},
          {28,-129},{26,-129}}, color={0,127,255}));
  connect(multiPort.port_a, volume2.port_b) annotation (Line(points={{64,-110},{
          64,-132},{54,-132}}, color={0,127,255}));
  connect(valve_BV.port_b, resistance3.port_a) annotation (Line(points={{-30,16},
          {-16,16},{-16,8},{4.44089e-16,8},{4.44089e-16,-3}}, color={0,127,255}));
  connect(resistance3.port_b, multiPort1.ports_b[2]) annotation (Line(points={{0,
          -17},{2,-17},{2,-37.2},{-20,-37.2}}, color={0,127,255}));
  connect(valve_BV.opening, actuatorBus.opening_BV) annotation (Line(points={{-40,
          24},{-42,24},{-42,60},{30.1,60},{30.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(HPT.portLP, tee.port_2)
    annotation (Line(points={{54,40},{76,40},{76,36}}, color={0,127,255}));
  connect(multiPort.ports_b[1], resistance1.port_b) annotation (Line(points={{62,-102},
          {62,-102},{62,-92},{94,-92},{94,-79}},       color={0,127,255}));
  connect(resistance1.port_a, LPT_Bypass.port_b)
    annotation (Line(points={{94,-65},{94,-42}}, color={0,127,255}));
  connect(pump3.port_b, multiPort.ports_b[2]) annotation (Line(points={{70,-76},
          {72,-76},{72,-92},{74,-92},{66,-92},{66,-102}}, color={0,127,255}));
  connect(Condenser.port_b, pump3.port_a) annotation (Line(points={{46,-58},{32,
          -58},{32,-76},{46,-76}}, color={0,127,255}));
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
<p>A two stage turbine rankine cycle with feedwater heating internal to the system - can be externally bypassed or LPT can be bypassed both will feedwater heat post bypass</p>
</html>"));
end Intermediate_Rankine_Cycle_Control;
