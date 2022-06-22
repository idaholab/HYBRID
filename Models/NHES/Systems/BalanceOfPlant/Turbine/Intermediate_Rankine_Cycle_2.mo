within NHES.Systems.BalanceOfPlant.Turbine;
model Intermediate_Rankine_Cycle_2 "Two stage BOP model"
  extends BaseClasses.Partial_SubSystem_C(
    redeclare replaceable ControlSystems.CS_IntermediateControl_PID_2 CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare Data.IdealTurbine data);

    parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
    parameter Modelica.Units.SI.Pressure pr3out=200000 annotation(dialog(tab = "Initialization", group = "Pressure"));

  TRANSFORM.Fluid.Machines.SteamTurbine HPT(
    nUnits=1,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=3000000,
    p_b_start=1800000,
    T_a_start=852.15,
    T_b_start=573.15,
    m_flow_nominal=50,
    p_inlet_nominal=3447400,
    p_outlet_nominal=1800000,
    T_nominal=852.15)
    annotation (Placement(transformation(extent={{34,24},{54,44}})));
  Fluid.Vessels.IdealCondenser Condenser(
    p=10000,
    V_total=75,
    V_liquid_start=1.2)
    annotation (Placement(transformation(extent={{50,-98},{30,-78}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    N_nominal=1200,
    dp_nominal=500000,
    m_flow_nominal=200,
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
        origin={-18,60})));

  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=400,
    dp_nominal=100000,
    m_flow_nominal=500)
                       annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-4,40})));
  TRANSFORM.Fluid.Machines.SteamTurbine LPT(
    nUnits=1,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=1800000,
    p_b_start=8000,
    T_a_start=673.15,
    T_b_start=343.15,
    m_flow_nominal=50,
    p_inlet_nominal=1800000,
    p_outlet_nominal=8000,
    T_nominal=473.15) annotation (Placement(transformation(
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
    m_flow_nominal=100) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={86,-24})));
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
    p_nominal=1800000,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-130})));
  StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
    Moisture_Separator(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    p_start=20000,
    T_start=338.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5))
    annotation (Placement(transformation(extent={{58,30},{78,50}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium
      = Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{6,-7},{-6,7}},
        rotation=90,
        origin={47,-62})));
  TRANSFORM.Fluid.Valves.ValveCompressible valve_BV(
    dp_start=100000,
    rho_nominal=Medium.density_ph(port_a_nominal.p, port_a_nominal.h),
    opening_nominal=1,
    p_nominal=port_a_nominal.p,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_nominal=5,
    dp_nominal=2000000)
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
    p_nominal=1500000,
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
  Fluid.HeatExchangers.Generic_HXs.NTU_HX       IP(
    NTU=10,
    K_tube=17000,
    K_shell=500,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=5500000,
    p_start_shell=10000,
    dp_init_shell=1700000,
    Q_init=1e6)
    annotation (Placement(transformation(extent={{66,-118},{86,-138}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX      IP1(
    NTU=20,
    K_tube=17000,
    K_shell=500,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=2600000,
    p_start_shell=2400000,
    Q_init=1e6)
    annotation (Placement(transformation(extent={{-30,-26},{-10,-46}})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=1800000,
    use_T_start=false,
    h_start=3.5e6,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=200),
    nPorts_a=3,
    nPorts_b=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={86,-72})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=4000000,
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
  Modelica.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    T=318.9576,
    nPorts=1)
    annotation (Placement(transformation(extent={{-56,-120},{-36,-100}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package Medium
      = Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{6,-7},{-6,7}},
        rotation=90,
        origin={41,-110})));
  Electrical.Generator      generator1(J=1e4)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={46,-32})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{124,-52},{144,-32}})));
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
      points={{-30,100},{-30,74},{-32,74},{-32,60},{-24,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
      points={{4,40},{16,40}},
      color={0,127,255},
      thickness=0.5));
  connect(LPT.portHP, tee.port_1) annotation (Line(
      points={{52,4},{52,8},{82,8},{82,14}},
      color={0,127,255},
      thickness=0.5));
  connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
      points={{92,24},{92,0},{86,0},{86,-14}},
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
      points={{30,100},{116,100},{116,-24},{94,-24}},
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
      points={{52,-16},{52,-52},{47,-52},{47,-56}},
      color={0,127,255},
      thickness=0.5));

  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{-4,100.1},{-4,46.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_T2.port_b, port_b)
    annotation (Line(points={{-128,-40},{-160,-40}},color={0,127,255}));
  connect(sensor_p.port, TCV.port_a)
    annotation (Line(points={{-18,50},{-18,40},{-12,40}}, color={0,127,255}));
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
  connect(resistance3.port_b, IP1.Shell_in) annotation (Line(points={{-34,-11},{
          -34,-22},{-30,-22},{-30,-34}},                 color={0,127,255}));
  connect(IP1.Shell_out, volume.port_a[1]) annotation (Line(points={{-10,-34},{
          70,-34},{70,-60},{84,-60},{84,-62},{85.3333,-62},{85.3333,-66}},
                                         color={0,127,255}));
  connect(LPT_Bypass.port_b, volume.port_a[2]) annotation (Line(points={{86,-34},
          {86,-66}},                                  color={0,127,255}));
  connect(pump1.port_b, IP.Tube_in) annotation (Line(points={{40,-140},{40,-144},
          {88,-144},{88,-140},{90,-140},{90,-132},{86,-132}},
                               color={0,127,255}));
  connect(Moisture_Separator.port_Liquid, volume.port_a[3]) annotation (Line(
        points={{64,36},{64,-14},{72,-14},{72,-58},{86.6667,-58},{86.6667,-66}},
                                                              color={0,127,255}));
  connect(IP.Tube_out, pump2.port_a) annotation (Line(points={{66,-132},{66,-131},
          {26,-131}},       color={0,127,255}));
  connect(boundary.ports[1], TBV.port_b)
    annotation (Line(points={{-164,74},{-150,74}}, color={0,127,255}));
  connect(TBV.port_a, TCV.port_a) annotation (Line(points={{-134,74},{-124,74},
          {-124,40},{-12,40}}, color={0,127,255}));
  connect(TBV.opening, actuatorBus.TBV) annotation (Line(
      points={{-142,80.4},{-142,100},{30,100}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(valve_BV.opening, actuatorBus.opening_BV) annotation (Line(
      points={{-76,24},{-76,100.1},{30.1,100.1}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_m_flow1.port_b, Condenser.port_a) annotation (Line(points={{47,
          -68},{46,-68},{46,-74},{47,-74},{47,-78}}, color={0,127,255}));
  connect(IP.Shell_out, volume.port_b[1]) annotation (Line(points={{86,-126},{
          88,-126},{88,-78},{86,-78}}, color={0,127,255}));
  connect(IP.Shell_in, sensor_m_flow1.port_a) annotation (Line(points={{66,-126},
          {62,-126},{62,-52},{47,-52},{47,-56}}, color={0,127,255}));
  connect(boundary1.ports[1], Condenser.port_b) annotation (Line(points={{-36,-110},
          {-26,-110},{-26,-98},{40,-98}},
                                        color={0,127,255}));
  connect(boundary1.m_flow_in, actuatorBus.CondensorFlow) annotation (Line(
      points={{-56,-102},{-56,-100},{-72,-100},{-72,-142},{116,-142},{116,100},{
          30,100}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Condenser.port_b, sensor_m_flow2.port_a)
    annotation (Line(points={{40,-98},{41,-98},{41,-104}}, color={0,127,255}));
  connect(pump1.port_a, sensor_m_flow2.port_b) annotation (Line(points={{40,-120},
          {41,-120},{41,-116}}, color={0,127,255}));
  connect(sensor_m_flow1.m_flow, sensorBus.Condensor_Input_mflow) annotation (
      Line(points={{44.48,-62},{30,-62},{30,-64},{-96,-64},{-96,100},{-30,100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_m_flow2.m_flow, sensorBus.Condensor_Output_mflow) annotation (
      Line(points={{38.48,-110},{16,-110},{16,-64},{-96,-64},{-96,100},{-30,100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(LPT.shaft_b, generator1.shaft_a)
    annotation (Line(points={{46,-16},{46,-22}}, color={0,0,0}));
  connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{46,-42},
          {46,-46},{118,-46},{118,-42},{124,-42}}, color={255,0,0}));
  connect(sensorW.port_b, portElec_b) annotation (Line(points={{144,-42},{148,
          -42},{148,-14},{146,-14},{146,0},{160,0}}, color={255,0,0}));
  connect(sensorW.W, sensorBus.Power) annotation (Line(points={{134,-31},{134,
          94},{-30,94},{-30,100}}, color={0,0,127}), Text(
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
      StopTime=500,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>A two stage turbine rankine cycle with feedwater heating internal to the system - can be externally bypassed or LPT can be bypassed both will feedwater heat post bypass</p>
</html>"));
end Intermediate_Rankine_Cycle_2;
