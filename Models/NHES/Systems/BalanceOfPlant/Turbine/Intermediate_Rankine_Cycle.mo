within NHES.Systems.BalanceOfPlant.Turbine;
model Intermediate_Rankine_Cycle "Two stage BOP model"
  extends BaseClasses.Partial_SubSystem_C(
    redeclare replaceable ControlSystems.CS_IntermediateControl CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare Data.IdealTurbine data);

    parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
    parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));

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
    p_outlet_nominal=2500000,
    T_nominal=673.15)
    annotation (Placement(transformation(extent={{34,24},{54,44}})));
  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{34,-34},{14,-14}})));
  Fluid.Vessels.IdealCondenser Condenser(
    p=10000,
    V_total=75,
    V_liquid_start=1.2)
    annotation (Placement(transformation(extent={{56,-62},{36,-42}})));
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
    p_inlet_nominal=14000000,
    p_outlet_nominal=8000,
    T_nominal=673.15) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={46,-6})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
      package Medium = Modelica.Media.Water.StandardWater, V=5,
    p_start=2500000)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={82,24})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=2.5) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={86,-34})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-118,-40})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                           pump1(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=10000000,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{36,-84},{56,-64}})));
  StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
    Moisture_Separator(redeclare package Medium =
        Modelica.Media.Water.StandardWater, redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
    annotation (Placement(transformation(extent={{58,30},{78,50}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium
      = Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{6,-7},{-6,7}},
        rotation=90,
        origin={55,-24})));
  TRANSFORM.Fluid.Valves.ValveCompressible valve_BV(
    dp_start=100000,
    rho_nominal=Medium.density_ph(port_a_nominal.p, port_a_nominal.h),
    opening_nominal=1,
    p_nominal=port_a_nominal.p,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_nominal=port_a_nominal.m_flow,
    dp_nominal=100000)
    annotation (Placement(transformation(extent={{-86,6},{-66,26}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance3(R=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-34,-4})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                           pump2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=11500000,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{26,-142},{4,-120}})));
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
  Fluid.HeatExchangers.Generic_HXs.NTU_HX      IP(
    NTU=IP_NTU,
    K_tube=17000,
    K_shell=500,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=2000000,
    p_start_shell=200000,
    Q_init=1e6)
    annotation (Placement(transformation(extent={{66,-118},{86,-138}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX      IP1(
    NTU=IP_NTU,
    K_tube=17000,
    K_shell=500,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=2400000,
    p_start_shell=14000000,
    Q_init=1e6)
    annotation (Placement(transformation(extent={{-30,-26},{-10,-46}})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=pr3out,
    use_T_start=false,
    h_start=1200e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.2),
    nPorts_a=3,
    nPorts_b=1)
    annotation (Placement(transformation(extent={{68,-114},{88,-94}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=12000000,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-184,64},{-164,84}})));
  TRANSFORM.Fluid.Valves.ValveLinear TBV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=50) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-142,74})));
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
      points={{52,4},{52,8},{82,8},{82,14}},
      color={0,127,255},
      thickness=0.5));
  connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
      points={{92,24},{92,0},{86,0},{86,-24}},
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
  connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{46,-62},{36,
          -62},{36,-74}},                                           color={0,127,
          255},
      thickness=0.5));
  connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
      points={{54,34},{54,14},{46,14},{46,4}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
      Line(
      points={{30,100},{116,100},{116,-34},{94,-34}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HPT.portLP, Moisture_Separator.port_a) annotation (Line(
      points={{54,40},{62,40}},
      color={0,127,255},
      thickness=0.5));
  connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
      points={{74,40},{82,40},{82,34}},
      color={0,127,255},
      thickness=0.5));
  connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
      points={{52,-16},{52,-18},{55,-18}},
      color={0,127,255},
      thickness=0.5));
  connect(sensor_m_flow1.port_b,Condenser. port_a)
    annotation (Line(points={{55,-30},{55,-36},{53,-36},{53,-42}},
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
  connect(valve_BV.opening, actuatorBus.opening_BV) annotation (Line(points={{-76,24},
          {-76,100.1},{30.1,100.1}},     color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_p.port, TCV.port_a)
    annotation (Line(points={{-18,66},{-18,40},{-12,40}}, color={0,127,255}));
  connect(port_a, TCV.port_a)
    annotation (Line(points={{-160,40},{-12,40}}, color={0,127,255}));
  connect(valve_BV.port_a, TCV.port_a) annotation (Line(points={{-86,16},{-90,
          16},{-90,40},{-12,40}}, color={0,127,255}));
  connect(pump.port_a, volume1.port_a)
    annotation (Line(points={{-62,-40},{-52,-40}}, color={0,127,255}));
  connect(valve_BV.port_b, resistance3.port_a) annotation (Line(points={{-66,16},
          {-34,16},{-34,3}},                                  color={0,127,255}));
  connect(volume1.port_b, IP1.Tube_out)
    annotation (Line(points={{-40,-40},{-30,-40}}, color={0,127,255}));
  connect(IP1.Tube_in, pump2.port_b) annotation (Line(points={{-10,-40},{-2,-40},
          {-2,-131},{4,-131}}, color={0,127,255}));
  connect(resistance3.port_b, IP1.Shell_in) annotation (Line(points={{-34,-11},
          {-34,-34},{-30,-34}},                          color={0,127,255}));
  connect(IP1.Shell_out, volume.port_a[1]) annotation (Line(points={{-10,-34},{
          10,-34},{10,-104.667},{72,-104.667}},
                                         color={0,127,255}));
  connect(LPT_Bypass.port_b, volume.port_a[2]) annotation (Line(points={{86,-44},
          {86,-90},{66,-90},{66,-104},{72,-104}},     color={0,127,255}));
  connect(pump1.port_b, IP.Tube_in) annotation (Line(points={{56,-74},{96,-74},{
          96,-132},{86,-132}}, color={0,127,255}));
  connect(Moisture_Separator.port_Liquid, volume.port_a[3]) annotation (Line(
        points={{64,36},{62,36},{62,-103.333},{72,-103.333}}, color={0,127,255}));
  connect(IP.Tube_out, pump2.port_a) annotation (Line(points={{66,-132},{66,
          -131},{26,-131}}, color={0,127,255}));
  connect(IP.Shell_in, Condenser.port_a) annotation (Line(points={{66,-126},{50,
          -126},{50,-88},{30,-88},{30,-34},{48,-34},{48,-42},{53,-42}}, color={
          0,127,255}));
  connect(volume.port_b[1], IP.Shell_out) annotation (Line(points={{84,-104},{
          88,-104},{88,-126},{86,-126}}, color={0,127,255}));
  connect(boundary.ports[1], TBV.port_b)
    annotation (Line(points={{-164,74},{-150,74}}, color={0,127,255}));
  connect(TBV.port_a, TCV.port_a) annotation (Line(points={{-134,74},{-124,74},
          {-124,40},{-12,40}}, color={0,127,255}));
  connect(TBV.opening, actuatorBus.TBV) annotation (Line(points={{-142,80.4},{
          -142,100},{30,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
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
end Intermediate_Rankine_Cycle;
