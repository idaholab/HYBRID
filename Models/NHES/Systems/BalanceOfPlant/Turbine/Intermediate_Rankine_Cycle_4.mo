within NHES.Systems.BalanceOfPlant.Turbine;
model Intermediate_Rankine_Cycle_4 "Two stage BOP model"
  extends BaseClasses.Partial_SubSystem_C(
    redeclare replaceable ControlSystems.CS_IntermediateControl_PID_4 CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare Data.IntermediateTurbine data);

    parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
    parameter Modelica.Units.SI.Pressure pr3out=200000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter SI.Pressure p_condenser=1e4 "Condenser operating pressure";
    parameter SI.Pressure p_reservoir=port_b_nominal.p "Reservoir operating pressure";

  TRANSFORM.Fluid.Machines.SteamTurbine HPT(
    nUnits=1,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=3000000,
    p_b_start=1800000,
    T_a_start=852.15,
    T_b_start=573.15,
    m_flow_nominal=70,
    p_inlet_nominal=3447400,
    p_outlet_nominal=700000,
    T_nominal=563.15)
    annotation (Placement(transformation(extent={{32,22},{52,42}})));
  Fluid.Vessels.IdealCondenser Condenser(
    p=10000,
    V_total=150,
    V_liquid_start=1.2)
    annotation (Placement(transformation(extent={{50,-98},{30,-78}})));
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
    dp_nominal=1000000,
    m_flow_nominal=300)
                       annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={-4,40})));
  TRANSFORM.Fluid.Machines.SteamTurbine LPT(
    nUnits=1,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=1800000,
    p_b_start=8000,
    T_a_start=673.15,
    T_b_start=343.15,
    m_flow_nominal=70,
    p_inlet_nominal=700000,
    p_outlet_nominal=8000,
    T_nominal=523.15) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={44,-6})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
      package Medium = Modelica.Media.Water.StandardWater, V=5,
    p_start=700000)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={82,24})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=10000,
    m_flow_nominal=5)   annotation (Placement(transformation(
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
                                           pump1(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=1000000,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={40,-152})));
  StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
    Moisture_Separator(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    p_start=20000,
    T_start=338.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.01))
    annotation (Placement(transformation(extent={{58,30},{78,50}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium
      = Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{6,-7},{-6,7}},
        rotation=90,
        origin={47,-62})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance3(R=1000,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-34,-4})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                IP(
    NTU=20,
    K_tube=17000,
    K_shell=500,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=1000000,
    h_start_tube_inlet=1e6,
    h_start_tube_outlet=1.05e6,
    p_start_shell=600000,
    h_start_shell_inlet=3e6,
    h_start_shell_outlet=2.9e6,
    dp_init_tube=0,
    dp_init_shell=100000,
    Q_init=1e6,
    m_start_tube=50,
    m_start_shell=26)
    annotation (Placement(transformation(extent={{66,-118},{86,-138}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                               IP1(
    NTU=20,
    K_tube=17000,
    K_shell=500,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=3600000,
    h_start_tube_outlet=3e6,
    p_start_shell=2400000,
    Q_init=1e6)
    annotation (Placement(transformation(extent={{-20,-26},{0,-46}})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=650000,
    use_T_start=false,
    h_start=3.5e6,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=80),
    nPorts_a=3,
    nPorts_b=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={88,-72})));
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
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(R=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,-110})));
  TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                           pump2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=3600000,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={8,-76})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance4(R=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-132,40})));
  TRANSFORM.Fluid.Volumes.MixingVolume header(
    use_T_start=false,
    h_start=port_a_start.h,
    p_start=port_a_start.p,
    nPorts_a=1,
    nPorts_b=2,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-122,30},{-102,50}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=80,
    use_input=true,
    redeclare package Medium =
        Modelica.Media.Water.StandardWater)              annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={-121,-41})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=12000000,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-168,64},{-148,84}})));
  TRANSFORM.Fluid.Valves.ValveLinear TBV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=50) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-128,74})));
  StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
    springBallValve(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_start=1000000,
    m_flow_start=0,
    m_flow_small=1e-2,
    p_spring=5500000,
    K=60,
    opening_init=0,
    tau=0.0001)
    annotation (Placement(transformation(extent={{-82,10},{-62,30}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T4(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={74,-152})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T5(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={6,-150})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T6(redeclare package Medium =
        Modelica.Media.Water.StandardWater)            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={42,-132})));
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
      points={{-30,100},{-30,18},{-48,18},{-48,-26},{-40,-26},{-40,-56},{-58,
          -56},{-58,-43.6}},
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
  connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
      points={{50,-16},{50,-52},{47,-52},{47,-56}},
      color={0,127,255},
      thickness=0.5));

  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{-4,100.1},{-4,46.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensor_p.port, TCV.port_a)
    annotation (Line(points={{-18,50},{-18,40},{-12,40}}, color={0,127,255}));
  connect(resistance3.port_b, IP1.Shell_in) annotation (Line(points={{-34,-11},{
          -34,-26},{-24,-26},{-24,-34},{-20,-34}},       color={0,127,255}));
  connect(IP1.Shell_out, volume.port_a[1]) annotation (Line(points={{0,-34},{30,
          -34},{30,-50},{72,-50},{72,-58},{84,-58},{84,-66},{87.3333,-66}},
                                         color={0,127,255}));
  connect(LPT_Bypass.port_b, volume.port_a[2]) annotation (Line(points={{84,-36},
          {84,-66},{88,-66}},                         color={0,127,255}));
  connect(Moisture_Separator.port_Liquid, volume.port_a[3]) annotation (Line(
        points={{64,36},{64,-14},{72,-14},{72,-58},{88.6667,-58},{88.6667,-66}},
                                                              color={0,127,255}));

  connect(sensor_m_flow1.port_b, Condenser.port_a) annotation (Line(points={{47,
          -68},{46,-68},{46,-74},{47,-74},{47,-78}}, color={0,127,255}));
  connect(Condenser.port_b, sensor_m_flow2.port_a)
    annotation (Line(points={{40,-98},{41,-98},{41,-104}}, color={0,127,255}));
  connect(LPT.shaft_b, generator1.shaft_a)
    annotation (Line(points={{44,-16},{44,-20},{46,-20},{46,-22}},
                                                 color={0,0,0}));
  connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{46,-42},
          {46,-46},{118,-46},{118,-42},{124,-42}}, color={255,0,0}));
  connect(sensorW.port_b, portElec_b) annotation (Line(points={{144,-42},{148,
          -42},{148,-14},{146,-14},{146,0},{160,0}}, color={255,0,0}));
  connect(volume.port_b[1], IP.Shell_in) annotation (Line(points={{88,-78},{88,
          -90},{58,-90},{58,-126},{66,-126}}, color={0,127,255}));
  connect(resistance1.port_a, sensor_m_flow1.port_a) annotation (Line(points={{90,-103},
          {66,-103},{66,-52},{47,-52},{47,-56}},          color={0,127,255}));
  connect(IP.Shell_out, resistance1.port_b) annotation (Line(points={{86,-126},
          {90,-126},{90,-117}}, color={0,127,255}));
  connect(pump2.port_b, IP1.Tube_in) annotation (Line(points={{8,-66},{8,-40},{
          0,-40}},         color={0,127,255}));
  connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
      Line(
      points={{30,100},{116,100},{116,-26},{92,-26}},
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
      points={{-30,100},{134,100},{134,-31}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Condensor_Input_mflow, sensor_m_flow1.m_flow) annotation (
      Line(
      points={{-30,100},{-30,18},{28,18},{28,-62},{44.48,-62}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Condensor_Output_mflow, sensor_m_flow2.m_flow) annotation (
      Line(
      points={{-30,100},{-30,18},{28,18},{28,-110},{38.48,-110}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(port_a, resistance4.port_a)
    annotation (Line(points={{-160,40},{-139,40}}, color={0,127,255}));
  connect(resistance4.port_b, header.port_a[1])
    annotation (Line(points={{-125,40},{-118,40}}, color={0,127,255}));
  connect(header.port_b[1], TCV.port_a)
    annotation (Line(points={{-106,39.5},{-60,39.5},{-60,40},{-12,40}},
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
  connect(springBallValve.port_a, header.port_b[2]) annotation (Line(points={{
          -82,20},{-86,20},{-86,40.5},{-106,40.5}}, color={0,127,255}));
  connect(springBallValve.port_b, resistance3.port_a)
    annotation (Line(points={{-62,20},{-34,20},{-34,3}}, color={0,127,255}));
  connect(pump1.port_b, sensor_T4.port_b) annotation (Line(points={{50,-152},{
          64,-152}},                               color={0,127,255}));
  connect(sensor_T4.port_a, IP.Tube_in) annotation (Line(points={{84,-152},{92,
          -152},{92,-132},{86,-132}}, color={0,127,255}));
  connect(sensor_T5.port_a, pump1.port_a) annotation (Line(points={{16,-150},{
          24,-150},{24,-152},{30,-152}}, color={0,127,255}));
  connect(IP.Tube_out, sensor_T6.port_a)
    annotation (Line(points={{66,-132},{52,-132}}, color={0,127,255}));
  connect(sensor_T6.port_b, pump2.port_a) annotation (Line(points={{32,-132},{8,
          -132},{8,-86}},                       color={0,127,255}));
  connect(sensor_T2.port_a, IP1.Tube_out)
    annotation (Line(points={{-48,-40},{-20,-40}}, color={0,127,255}));
  connect(sensor_m_flow2.port_b, sensor_T5.port_b) annotation (Line(points={{41,
          -116},{10,-116},{10,-118},{-8,-118},{-8,-150},{-4,-150}}, color={0,
          127,255}));
  connect(port_b, pump_SimpleMassFlow1.port_b) annotation (Line(points={{-160,
          -40},{-152,-40},{-152,-38},{-132,-38},{-132,-41}}, color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_a, sensor_T2.port_b) annotation (Line(
        points={{-110,-41},{-94,-41},{-94,-42},{-68,-42},{-68,-40}}, color={0,
          127,255}));
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
end Intermediate_Rankine_Cycle_4;
