within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L3_HTGR
  extends BaseClasses.Partial_SubSystem(
    redeclare replaceable
      ControlSystems.CS_threeStagedTurbine_HTGR
      CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare Data.IdealTurbine data);
  Real time_altered;
  Real time_initialization = 7e4;
  Real electricity_generation_Norm;
  Real electricity_demand_Norm;
  PrimaryHeatSystem.HTGR.HTGR_Rankine.Data.DataInitial_HTGR_Pebble dataInitial(
      P_LP_Comp_Ref=4000000)
    annotation (Placement(transformation(extent={{64,122},{84,142}})));

  TRANSFORM.Fluid.Machines.SteamTurbine HPT(
    nUnits=1,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=dataInitial_HTGR_BoP_3stage.HPT_P_inlet,
    p_b_start=dataInitial_HTGR_BoP_3stage.HPT_P_outlet,
    T_a_start=dataInitial_HTGR_BoP_3stage.HPT_T_inlet,
    T_b_start=dataInitial_HTGR_BoP_3stage.HPT_T_outlet,
    m_flow_nominal=200,
    p_inlet_nominal=dataInitial_HTGR_BoP_3stage.HPT_P_inlet,
    p_outlet_nominal=dataInitial_HTGR_BoP_3stage.HPT_P_outlet,
    T_nominal=dataInitial_HTGR_BoP_3stage.HPT_T_inlet)
    annotation (Placement(transformation(extent={{34,24},{54,44}})));

  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={238,66})));
  Fluid.Vessels.IdealCondenser Condenser(
    p=10000,
    V_total=2500,
    V_liquid_start=1.2)
    annotation (Placement(transformation(extent={{244,-62},{224,-42}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled FWCP(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    N_nominal=1200,
    dp_nominal=15000000,
    m_flow_nominal=50,
    d_nominal=1000,
    controlType="RPM",
    use_port=true)
    annotation (Placement(transformation(extent={{-24,-48},{-44,-68}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={18,40})));
  TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater, redeclare function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                       annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-14,76})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=3900000,
    T_start=723.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2),
    use_TraceMassPort=false)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-62,48})));

  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=50) annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-4,40})));
  Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
    annotation (Placement(transformation(extent={{-106,108},{-86,116}})));
  TRANSFORM.Fluid.Machines.SteamTurbine LPT1(
    nUnits=1,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=3000000,
    p_b_start=1500000,
    T_a_start=573.15,
    T_b_start=473.15,
    m_flow_nominal=200,
    p_inlet_nominal=2000000,
    p_outlet_nominal=dataInitial_HTGR_BoP_3stage.LPT1_P_outlet,
    T_nominal=423.15)                                  annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={128,34})));

  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=3900000,
    T_start=473.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5.0),
    use_TraceMassPort=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-4,-58})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    V=5,
    p_start=2500000,
    T_start=573.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={94,50})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT1_Bypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=30)
                      annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={94,-16})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-108,-58})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                           pump1(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=5500000,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{40,-92},{20,-72}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{7,-8},{-7,8}},
        rotation=90,
        origin={242,-19})));
  TRANSFORM.Fluid.Valves.ValveLinear TBV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=50) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-74,72})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=12000000,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-116,62},{-96,82}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-150,38},{-130,58}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-150,-68},{-130,-48}})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_e
    annotation (Placement(transformation(extent={{130,-10},{150,10}}),
        iconTransformation(extent={{130,-10},{150,10}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    V=5,
    p_start=1500000,
    T_start=423.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={178,50})));
  TRANSFORM.Fluid.Machines.SteamTurbine LPT2(
    nUnits=1,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=1500000,
    p_b_start=8000,
    T_a_start=523.15,
    T_b_start=343.15,
    m_flow_nominal=200,
    p_inlet_nominal=1500000,
    p_outlet_nominal=dataInitial_HTGR_BoP_3stage.LPT2_P_outlet,
    T_nominal=423.15)                                  annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={208,34})));

  TRANSFORM.Fluid.Valves.ValveLinear LPT2_Bypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=5) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={178,16})));
  Data.DataInitial_HTGR_BoP_3stage dataInitial_HTGR_BoP_3stage(LPT1_T_outlet=
        473.15, LPT2_T_inlet=473.15)
    annotation (Placement(transformation(extent={{90,122},{110,142}})));
  StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
    Moisture_Separator2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=2500000,
    T_start=573.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
    annotation (Placement(transformation(extent={{140,40},{160,60}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=5500000,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-104,-42},{-84,-22}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={28,-32})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T3(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={66,-32})));
initial equation

equation
  port_e.W = generator.power;
  time_altered = time-time_initialization;
  electricity_generation_Norm = generator.power/44E+6;
  electricity_demand_Norm     = CS.trap_LTV1bypass_power.y/44E+6;

  connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
      points={{34,40},{24,40}},
      color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
      points={{-30,100},{4,100},{4,42.16},{18,42.16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed,FWCP. inputSignal) annotation (Line(
      points={{30,100},{258,100},{258,-98},{-34,-98},{-34,-65}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
      points={{-30,100},{-30,76},{-20,76}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
      points={{4,40},{12,40}},
      color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
      points={{-30,100},{-30,76},{-80,76},{-80,112},{-85,112}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(volume1.port_b,FWCP. port_a) annotation (Line(points={{-10,-58},{
          -24,-58}},                color={0,127,255},
      thickness=0.5));
  connect(LPT1.portHP, tee1.port_1) annotation (Line(
      points={{118,40},{118,50},{104,50}},
      color={0,127,255},
      thickness=0.5));
  connect(tee1.port_3, LPT1_Bypass.port_a) annotation (Line(
      points={{94,40},{94,-6}},
      color={0,127,255},
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
      points={{-30,100},{-30,-44},{-56,-44},{-56,-74},{-108,-74},{-108,-61.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{234,-62},
          {234,-82},{40,-82}},                                      color={0,127,
          255},
      thickness=0.5));
  connect(pump1.port_b, volume1.port_a) annotation (Line(points={{20,-82},{16,
          -82},{16,-58},{2,-58}},                    color={0,127,255},
      thickness=0.5));
  connect(HPT.shaft_b, LPT1.shaft_a) annotation (Line(
      points={{54,34},{118,34}},
      color={0,0,0},
      pattern=LinePattern.Dash));
  connect(sensor_m_flow1.port_b,Condenser. port_a)
    annotation (Line(points={{242,-26},{242,-42},{241,-42}},
                                                     color={0,127,255},
      thickness=0.5));

  connect(TBV.port_b, boundary1.ports[1])
    annotation (Line(points={{-82,72},{-96,72}}, color={0,127,255}));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{-4,100.1},{-4,46.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(volume.port_b, TBV.port_a) annotation (Line(points={{-56,48},{-46,
          48},{-46,72},{-66,72}},
                              color={0,127,255}));
  connect(volume.port_b, TCV.port_a)
    annotation (Line(points={{-56,48},{-34,48},{-34,40},{-12,40}},
                                                 color={0,127,255}));
  connect(volume.port_b, sensor_p.port) annotation (Line(points={{-56,48},{
          -34,48},{-34,62},{-14,62},{-14,66}},
                                       color={0,127,255}));
  connect(sensor_T2.port_b, port_b)
    annotation (Line(points={{-118,-58},{-140,-58}},color={0,127,255}));
  connect(TBV.opening, actuatorBus.TBV) annotation (Line(points={{-74,78.4},{-74,
          100},{30,100}},       color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(LPT1.shaft_b, LPT2.shaft_a)
    annotation (Line(points={{138,34},{198,34}}, color={0,0,0}));
  connect(tee2.port_1, LPT2.portHP) annotation (Line(points={{188,50},{192,50},{
          192,40},{198,40}}, color={0,127,255}));
  connect(LPT2.portLP, sensor_m_flow1.port_a)
    annotation (Line(points={{218,40},{242,40},{242,-12}}, color={0,127,255}));
  connect(tee2.port_3, LPT2_Bypass.port_a)
    annotation (Line(points={{178,40},{178,26}},color={0,127,255}));
  connect(LPT2_Bypass.port_b, pump1.port_a) annotation (Line(points={{178,6},
          {178,-82},{40,-82}},color={0,127,255}));
  connect(actuatorBus.Divert_Valve_Position, LPT2_Bypass.opening) annotation (
      Line(
      points={{30,100},{248,100},{248,16},{186,16}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(LPT1.portLP, Moisture_Separator2.port_a) annotation (Line(points={{
          138,40},{138,50},{144,50}}, color={0,127,255}));
  connect(Moisture_Separator2.port_b, tee2.port_2)
    annotation (Line(points={{156,50},{168,50}}, color={0,127,255}));
  connect(Moisture_Separator2.port_Liquid, volume1.port_a) annotation (Line(
        points={{146,46},{146,-58},{2,-58}},                     color={0,127,
          255}));
  connect(HPT.portLP, tee1.port_2) annotation (Line(points={{54,40},{78,40},{
          78,50},{84,50}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, boundary2.ports[1])
    annotation (Line(points={{18,-32},{-84,-32}},color={0,127,255}));
  connect(sensorBus.massflow_LPTv, sensor_m_flow.m_flow) annotation (Line(
      points={{-30,100},{-30,-42},{28,-42},{28,-35.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.openingLPTv, LPT1_Bypass.opening) annotation (Line(
      points={{30,100},{30,20},{116,20},{116,-16},{102,-16}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(generator.shaft, LPT2.shaft_b) annotation (Line(points={{238.1,55.9},
          {238.1,34},{218,34}}, color={0,0,0}));
  connect(sensor_T2.port_a,FWCP. port_b)
    annotation (Line(points={{-98,-58},{-44,-58}}, color={0,127,255}));
  connect(LPT1_Bypass.port_b, sensor_T3.port_a) annotation (Line(points={{94,
          -26},{94,-32},{72,-32}}, color={0,127,255}));
  connect(sensor_T3.port_b, sensor_m_flow.port_a)
    annotation (Line(points={{60,-32},{38,-32}}, color={0,127,255}));
  connect(port_a, volume.port_a)
    annotation (Line(points={{-140,48},{-68,48}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{140,100}}),                                  graphics={
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
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{140,
            100}})),
    experiment(
      StopTime=86400,
      Interval=30,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>A three-stage turbine rankine cycle with feedwater heating internal to the system</p>
<p>Three bypass ways exist using TBV (Turbine bypass valve), LPTBV1 (Low-Pressure Turbine bypass valve-1), and LPTBV2 (Low-Pressure Turbine bypass valve-2).</p>
</html>"));
end SteamTurbine_L3_HTGR;
