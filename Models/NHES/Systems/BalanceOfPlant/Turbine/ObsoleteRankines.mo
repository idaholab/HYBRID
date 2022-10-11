within NHES.Systems.BalanceOfPlant.Turbine;
package ObsoleteRankines
  model Intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_3 "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.TESTurbine data(
        V_FeedwaterMixVolume=10,
        V_Header=10,
        valve_SHS_mflow=30,
        valve_SHS_dp_nominal=1200000,
        valve_TCV_LPT_mflow=30,
        valve_TCV_LPT_dp_nominal=10000,
        InternalBypassValve_mflow_small=0,
        InternalBypassValve_p_spring=15000000,
        InternalBypassValve_K=40,
        firstfeedpump_p_nominal=2000000,
        secondfeedpump_p_nominal=2000000));

    Data.IntermediateTurbineInitialisation init(
      FeedwaterMixVolume_p_start=3000000,
        FeedwaterMixVolume_h_start=2e6,
      InternalBypassValve_dp_start=3500000,
      InternalBypassValve_mflow_start=0.1,
      HPT_p_a_start=3000000,
      HPT_p_b_start=10000,
      HPT_T_a_start=523.15,
      HPT_T_b_start=333.15)
    annotation (Placement(transformation(extent={{68,120},{88,140}})));

    Fluid.Vessels.IdealCondenser Condenser(
      p= data.p_condensor,
      V_total=data.V_condensor,
      V_liquid_start=init.condensor_V_liquid_start)
      annotation (Placement(transformation(extent={{156,-112},{136,-92}})));

    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)                                    annotation (Placement(
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
          origin={40,-128})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass(R=data.R_bypass,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-24,-2})));

    TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=init.FeedwaterMixVolume_p_start,
      use_T_start=true,
      T_start=421.15,
      h_start=init.FeedwaterMixVolume_h_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_FeedwaterMixVolume),
      nPorts_a=1,
      nPorts_b=3) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-30,-40})));

    Electrical.Generator      generator1(J=data.generator_MoI)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={84,-92})));

    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{110,-58},{130,-38}})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_entry(R=data.R_entry,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-102,40})));

    TRANSFORM.Fluid.Volumes.MixingVolume header(
      use_T_start=false,
      h_start=init.header_h_start,
      p_start=init.header_p_start,
      nPorts_a=1,
      nPorts_b=2,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-92,30},{-72,50}})));

    TRANSFORM.Fluid.Machines.Pump_Controlled pump_controlled(
      N_nominal=1500,
      dp_nominal=500000,
      m_flow_nominal=67,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      controlType="RPM",
      use_port=true) annotation (Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-105,-41})));

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=data.p_boundary,
      T=data.T_boundary,
      nPorts=1)
      annotation (Placement(transformation(extent={{-168,64},{-148,84}})));

    TRANSFORM.Fluid.Valves.ValveLinear PRV(
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
          origin={0,-128})));

    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{52,-66},{72,-86}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-102,-170},{-82,-150}}),
          iconTransformation(extent={{-74,-106},{-54,-86}})));

    TRANSFORM.Fluid.Valves.ValveLinear InternalBypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1500000,
      m_flow_nominal=15) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-60,24})));
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
      p_inlet_nominal=data.p_in_nominal,
      p_outlet_nominal=data.HPT_p_exit_nominal,
      T_nominal=data.HPT_T_in_nominal)
      annotation (Placement(transformation(extent={{32,24},{52,44}})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      V=data.V_tee,
      p_start=init.tee_p_start)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={90,4})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      eta_mech=data.LPT_efficiency,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=init.LPT_p_a_start,
      p_b_start=init.LPT_p_b_start,
      T_a_start=init.LPT_T_a_start,
      T_b_start=init.LPT_T_b_start,
      m_flow_nominal=data.LPT_nominal_mflow,
      p_inlet_nominal=data.LPT_p_in_nominal,
      p_outlet_nominal=data.LPT_p_exit_nominal,
      T_nominal=data.LPT_T_in_nominal) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={46,-40})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{150,62},{170,82}}),
          iconTransformation(extent={{88,58},{108,78}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{150,-156},{170,-136}}),
          iconTransformation(extent={{88,-62},{108,-42}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T3(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={134,72})));
    TRANSFORM.Fluid.Valves.ValveLinear TCV_LPT(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=data.valve_TCV_LPT_dp_nominal,
      m_flow_nominal=data.valve_TCV_LPT_mflow) annotation (Placement(
          transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={104,72})));
    TRANSFORM.Fluid.Valves.ValveLinear SHS_charge_control(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=data.valve_SHS_dp_nominal,
      m_flow_nominal=data.valve_SHS_mflow) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-62,-102})));
    TRANSFORM.Fluid.Valves.ValveLinear Discharge_OnOff(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=500000,
      m_flow_nominal=20) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={126,-146})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             firstfeedpump1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=2000000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={94,-148})));
    TRANSFORM.Fluid.Valves.ValveLinear RMF(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1000,
      m_flow_nominal=67) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-106,-96})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-124,-106},{-144,-86}})));
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

    connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{84,-102},
            {84,-106},{104,-106},{104,-48},{110,-48}},
                                                     color={255,0,0}));
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
    connect(R_entry.port_b, header.port_a[1])
      annotation (Line(points={{-95,40},{-88,40}},   color={0,127,255}));
    connect(header.port_b[1], TCV.port_a)
      annotation (Line(points={{-76,39.5},{-76,40},{-12,40}},
                                                    color={0,127,255}));
    connect(PRV.port_a, TCV.port_a) annotation (Line(points={{-120,74},{-60,74},{
            -60,40},{-12,40}},   color={0,127,255}));
    connect(boundary.ports[1],PRV. port_b)
      annotation (Line(points={{-148,74},{-136,74}}, color={0,127,255}));
    connect(actuatorBus.TBV,PRV. opening) annotation (Line(
        points={{30,100},{-128,100},{-128,80.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(firstfeedpump.port_b, sensor_T4.port_b) annotation (Line(points={{30,-128},
            {10,-128}},                              color={0,127,255}));
    connect(pump_controlled.port_a, sensor_T2.port_b) annotation (Line(points={{-94,
            -41},{-94,-42},{-82,-42}}, color={0,127,255}));
    connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
            -112},{146,-128},{50,-128}},          color={0,127,255}));
    connect(powerSensor.flange_b, generator1.shaft_a) annotation (Line(points={{72,-76},
            {84,-76},{84,-82}},                      color={0,0,0}));
    connect(sensor_T2.port_a, FeedwaterMixVolume.port_a[1]) annotation (Line(
          points={{-62,-42},{-42,-42},{-42,-40},{-36,-40}}, color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[1], R_InternalBypass.port_b)
      annotation (Line(points={{-24,-40.6667},{-24,-9}},
                                                      color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[2], sensor_T4.port_a) annotation (Line(
          points={{-24,-40},{-20,-40},{-20,-128},{-10,-128}},
          color={0,127,255}));
    connect(InternalBypass.port_a, header.port_b[2]) annotation (Line(points={{-68,24},
            {-76,24},{-76,40.5}},                             color={0,127,255}));
    connect(InternalBypass.port_b, R_InternalBypass.port_a) annotation (Line(
          points={{-52,24},{-24,24},{-24,5}},                   color={0,127,255}));
    connect(actuatorBus.Divert_Valve_Position, InternalBypass.opening)
      annotation (Line(
        points={{30,100},{-64,100},{-64,36},{-60,36},{-60,30.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(HPT.shaft_b,LPT. shaft_a) annotation (Line(
        points={{52,34},{56,34},{56,-24},{46,-24},{46,-30}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(LPT.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{46,-50},{46,-76},{52,-76}}, color={0,0,0}));
    connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{52,-50},{52,-58},
            {38,-58},{38,-112},{118,-112},{118,-84},{153,-84},{153,-92}}, color={0,
            127,255}));
    connect(sensor_T1.port_b, HPT.portHP) annotation (Line(points={{28,40},{32,40}},
                            color={0,127,255}));
    connect(HPT.portLP, tee.port_2) annotation (Line(points={{52,40},{72,40},{72,
            36},{90,36},{90,14}}, color={0,127,255}));
    connect(LPT.portHP, tee.port_1) annotation (Line(points={{52,-30},{66,-30},{
            66,-28},{90,-28},{90,-6}}, color={0,127,255}));
    connect(sensorBus.SHS_Return_T, sensor_T3.T) annotation (Line(
        points={{-30,100},{-30,74},{88,74},{88,58},{134,58},{134,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TCV_SHS, TCV_LPT.opening) annotation (Line(
        points={{30,100},{104,100},{104,78.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(port_a1, SHS_charge_control.port_a) annotation (Line(points={{-92,
            -160},{-92,-102},{-70,-102}}, color={0,127,255}));
    connect(SHS_charge_control.port_b, FeedwaterMixVolume.port_b[3]) annotation (
        Line(points={{-54,-102},{-20,-102},{-20,-39.3333},{-24,-39.3333}}, color=
            {0,127,255}));
    connect(actuatorBus.SHS_throttle, SHS_charge_control.opening) annotation (
        Line(
        points={{30,100},{-90,100},{-90,-84},{-62,-84},{-62,-95.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TCV_LPT.port_b, sensor_T3.port_b)
      annotation (Line(points={{112,72},{124,72}}, color={0,127,255}));
    connect(sensor_T3.port_a, port_a2)
      annotation (Line(points={{144,72},{160,72}}, color={0,127,255}));
    connect(TCV_LPT.port_a, tee.port_3) annotation (Line(points={{96,72},{90,72},
            {90,52},{104,52},{104,4},{100,4}}, color={0,127,255}));
    connect(Discharge_OnOff.port_b, port_b1)
      annotation (Line(points={{134,-146},{160,-146}}, color={0,127,255}));
    connect(actuatorBus.Discharge_OnOff_Throttle, Discharge_OnOff.opening)
      annotation (Line(
        points={{30,100},{186,100},{186,-132},{126,-132},{126,-139.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(firstfeedpump1.port_a, Condenser.port_b) annotation (Line(points={{84,
            -148},{78,-148},{78,-128},{146,-128},{146,-112}}, color={0,127,255}));
    connect(firstfeedpump1.port_b, Discharge_OnOff.port_a) annotation (Line(
          points={{104,-148},{112,-148},{112,-146},{118,-146}}, color={0,127,255}));
    connect(actuatorBus.Feed_Pump_Speed, pump_controlled.inputSignal) annotation (
       Line(
        points={{30,100},{-56,100},{-56,-60},{-105,-60},{-105,-48.7}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(RMF.port_b, pump_controlled.port_b) annotation (Line(points={{-98,-96},
            {-92,-96},{-92,-62},{-122,-62},{-122,-41},{-116,-41}}, color={0,127,
            255}));
    connect(actuatorBus.Reactor_mflow, RMF.opening) annotation (Line(
        points={{30,100},{-68,100},{-68,34},{-70,34},{-70,22},{-126,22},{-126,-82},
            {-106,-82},{-106,-89.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.Reactor_mflow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-94,100},{-94,54},{-130,54},{-130,-82},{-134,-82},{
            -134,-92.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(port_a, R_entry.port_a)
      annotation (Line(points={{-160,40},{-109,40}}, color={0,127,255}));
    connect(sensor_m_flow.port_a, RMF.port_a)
      annotation (Line(points={{-124,-96},{-114,-96}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, port_b) annotation (Line(points={{-144,-96},{
            -148,-96},{-148,-54},{-146,-54},{-146,-40},{-160,-40}}, color={0,127,
            255}));
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
  end Intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_3;

  model Intermediate_Rankine_Cycle_TESUC_1_Independent "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.TESTurbine data(
        V_FeedwaterMixVolume=10,
        V_Header=10,
        valve_SHS_mflow=30,
        valve_SHS_dp_nominal=1200000,
        valve_TCV_LPT_mflow=30,
        valve_TCV_LPT_dp_nominal=10000,
        InternalBypassValve_mflow_small=0,
        InternalBypassValve_p_spring=15000000,
        InternalBypassValve_K=40,
        firstfeedpump_p_nominal=2000000,
        secondfeedpump_p_nominal=2000000));

    Data.IntermediateTurbineInitialisation init(
      FeedwaterMixVolume_p_start=3000000,
        FeedwaterMixVolume_h_start=2e6,
      InternalBypassValve_dp_start=3500000,
      InternalBypassValve_mflow_start=0.1,
      HPT_p_a_start=3000000,
      HPT_p_b_start=10000,
      HPT_T_a_start=523.15,
      HPT_T_b_start=333.15)
    annotation (Placement(transformation(extent={{68,120},{88,140}})));

    Fluid.Vessels.IdealCondenser Condenser(
      p= data.p_condensor,
      V_total=data.V_condensor,
      V_liquid_start=init.condensor_V_liquid_start)
      annotation (Placement(transformation(extent={{156,-112},{136,-92}})));

    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)                                    annotation (Placement(
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
          origin={40,-128})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass(R=data.R_bypass,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-24,-2})));

    TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=init.FeedwaterMixVolume_p_start,
      use_T_start=true,
      T_start=421.15,
      h_start=init.FeedwaterMixVolume_h_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_FeedwaterMixVolume),
      nPorts_a=1,
      nPorts_b=3) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-30,-40})));

    Electrical.Generator      generator1(J=data.generator_MoI)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={84,-92})));

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
      nPorts_b=2,
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
          origin={0,-128})));

    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{52,-66},{72,-86}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-102,-170},{-82,-150}}),
          iconTransformation(extent={{-74,-106},{-54,-86}})));

    TRANSFORM.Fluid.Valves.ValveLinear InternalBypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1500000,
      m_flow_nominal=15) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-74,22})));
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
      p_inlet_nominal=data.p_in_nominal,
      p_outlet_nominal=data.HPT_p_exit_nominal,
      T_nominal=data.HPT_T_in_nominal)
      annotation (Placement(transformation(extent={{32,24},{52,44}})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      eta_mech=data.LPT_efficiency,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=init.LPT_p_a_start,
      p_b_start=init.LPT_p_b_start,
      T_a_start=init.LPT_T_a_start,
      T_b_start=init.LPT_T_b_start,
      m_flow_nominal=data.LPT_nominal_mflow,
      p_inlet_nominal=data.LPT_p_in_nominal,
      p_outlet_nominal=data.LPT_p_exit_nominal,
      T_nominal=data.LPT_T_in_nominal) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={46,-40})));
    TRANSFORM.Fluid.Valves.ValveLinear SHS_charge_control(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=data.valve_SHS_dp_nominal,
      m_flow_nominal=data.valve_SHS_mflow) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-62,-102})));
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

    connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{84,-102},
            {84,-106},{104,-106},{104,-48},{110,-48}},
                                                     color={255,0,0}));
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
      annotation (Line(points={{-106,41.5},{-60,41.5},{-60,40},{-12,40}},
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
    connect(firstfeedpump.port_b, sensor_T4.port_b) annotation (Line(points={{30,-128},
            {10,-128}},                              color={0,127,255}));
    connect(port_b, pump_SimpleMassFlow1.port_b) annotation (Line(points={{-160,-40},
            {-132,-40},{-132,-41}},                            color={0,127,255}));
    connect(pump_SimpleMassFlow1.port_a, sensor_T2.port_b) annotation (Line(
          points={{-110,-41},{-110,-42},{-82,-42}},                    color={0,
            127,255}));
    connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
            -112},{146,-128},{50,-128}},          color={0,127,255}));
    connect(powerSensor.flange_b, generator1.shaft_a) annotation (Line(points={{72,-76},
            {84,-76},{84,-82}},                      color={0,0,0}));
    connect(sensor_T2.port_a, FeedwaterMixVolume.port_a[1]) annotation (Line(
          points={{-62,-42},{-42,-42},{-42,-40},{-36,-40}}, color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[1], R_InternalBypass.port_b)
      annotation (Line(points={{-24,-40.6667},{-24,-9}},
                                                      color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[2], sensor_T4.port_a) annotation (Line(
          points={{-24,-40},{-20,-40},{-20,-128},{-10,-128}},
          color={0,127,255}));
    connect(InternalBypass.port_a, header.port_b[2]) annotation (Line(points={{
            -82,22},{-94,22},{-94,24},{-106,24},{-106,42.5}}, color={0,127,255}));
    connect(InternalBypass.port_b, R_InternalBypass.port_a) annotation (Line(
          points={{-66,22},{-44,22},{-44,20},{-24,20},{-24,5}}, color={0,127,255}));
    connect(actuatorBus.Divert_Valve_Position, InternalBypass.opening)
      annotation (Line(
        points={{30,100},{-74,100},{-74,28.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(HPT.shaft_b,LPT. shaft_a) annotation (Line(
        points={{52,34},{56,34},{56,-24},{46,-24},{46,-30}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(LPT.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{46,-50},{46,-76},{52,-76}}, color={0,0,0}));
    connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{52,-50},{52,-58},
            {38,-58},{38,-112},{118,-112},{118,-84},{153,-84},{153,-92}}, color={0,
            127,255}));
    connect(sensor_T1.port_b, HPT.portHP) annotation (Line(points={{28,40},{32,40}},
                            color={0,127,255}));
    connect(port_a1, SHS_charge_control.port_a) annotation (Line(points={{-92,
            -160},{-92,-102},{-70,-102}}, color={0,127,255}));
    connect(SHS_charge_control.port_b, FeedwaterMixVolume.port_b[3]) annotation (
        Line(points={{-54,-102},{-20,-102},{-20,-39.3333},{-24,-39.3333}}, color=
            {0,127,255}));
    connect(actuatorBus.SHS_throttle, SHS_charge_control.opening) annotation (
        Line(
        points={{30,100},{-90,100},{-90,-84},{-62,-84},{-62,-95.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(LPT.portHP, HPT.portLP) annotation (Line(points={{52,-30},{52,-26},{
            64,-26},{64,40},{52,40}}, color={0,127,255}));
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
  end Intermediate_Rankine_Cycle_TESUC_1_Independent;

  model Intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2 "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.TESTurbine data(
        V_FeedwaterMixVolume=10,
        V_Header=10,
        valve_SHS_mflow=30,
        valve_SHS_dp_nominal=1200000,
        valve_TCV_LPT_mflow=30,
        valve_TCV_LPT_dp_nominal=10000,
        InternalBypassValve_mflow_small=0,
        InternalBypassValve_p_spring=15000000,
        InternalBypassValve_K=40,
        firstfeedpump_p_nominal=2000000,
        secondfeedpump_p_nominal=2000000));

    Data.IntermediateTurbineInitialisation init(
      FeedwaterMixVolume_p_start=3000000,
        FeedwaterMixVolume_h_start=2e6,
      InternalBypassValve_dp_start=3500000,
      InternalBypassValve_mflow_start=0.1,
      HPT_p_a_start=3000000,
      HPT_p_b_start=10000,
      HPT_T_a_start=523.15,
      HPT_T_b_start=333.15)
    annotation (Placement(transformation(extent={{68,120},{88,140}})));

    Fluid.Vessels.IdealCondenser Condenser(
      p= data.p_condensor,
      V_total=data.V_condensor,
      V_liquid_start=init.condensor_V_liquid_start)
      annotation (Placement(transformation(extent={{156,-112},{136,-92}})));

    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)                                    annotation (Placement(
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
          origin={40,-128})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass(R=data.R_bypass,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-24,-2})));

    TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=init.FeedwaterMixVolume_p_start,
      use_T_start=true,
      T_start=421.15,
      h_start=init.FeedwaterMixVolume_h_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_FeedwaterMixVolume),
      nPorts_a=1,
      nPorts_b=3) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-30,-40})));

    Electrical.Generator      generator1(J=data.generator_MoI)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={84,-92})));

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
      nPorts_b=2,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-122,32},{-102,52}})));

    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
      use_input=true,
      m_flow_nominal=data.controlledfeedpump_mflow_nominal,
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

    TRANSFORM.Fluid.Valves.ValveLinear PRV(
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
          origin={0,-128})));

    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{52,-66},{72,-86}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-102,-170},{-82,-150}}),
          iconTransformation(extent={{-74,-106},{-54,-86}})));

    TRANSFORM.Fluid.Valves.ValveLinear InternalBypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1500000,
      m_flow_nominal=15) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-74,22})));
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
      p_inlet_nominal=data.p_in_nominal,
      p_outlet_nominal=data.HPT_p_exit_nominal,
      T_nominal=data.HPT_T_in_nominal)
      annotation (Placement(transformation(extent={{32,24},{52,44}})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      V=data.V_tee,
      p_start=init.tee_p_start)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={90,4})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      eta_mech=data.LPT_efficiency,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=init.LPT_p_a_start,
      p_b_start=init.LPT_p_b_start,
      T_a_start=init.LPT_T_a_start,
      T_b_start=init.LPT_T_b_start,
      m_flow_nominal=data.LPT_nominal_mflow,
      p_inlet_nominal=data.LPT_p_in_nominal,
      p_outlet_nominal=data.LPT_p_exit_nominal,
      T_nominal=data.LPT_T_in_nominal) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={46,-40})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{150,62},{170,82}}),
          iconTransformation(extent={{88,58},{108,78}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{150,-156},{170,-136}}),
          iconTransformation(extent={{88,-62},{108,-42}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T3(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={134,72})));
    TRANSFORM.Fluid.Valves.ValveLinear TCV_LPT(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=data.valve_TCV_LPT_dp_nominal,
      m_flow_nominal=data.valve_TCV_LPT_mflow) annotation (Placement(
          transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={104,72})));
    TRANSFORM.Fluid.Valves.ValveLinear SHS_charge_control(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=data.valve_SHS_dp_nominal,
      m_flow_nominal=data.valve_SHS_mflow) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-62,-102})));
    TRANSFORM.Fluid.Valves.ValveLinear Discharge_OnOff(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=500000,
      m_flow_nominal=20) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={126,-146})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             firstfeedpump1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=2000000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={94,-148})));
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

    connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{84,-102},
            {84,-106},{104,-106},{104,-48},{110,-48}},
                                                     color={255,0,0}));
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
      annotation (Line(points={{-106,41.5},{-60,41.5},{-60,40},{-12,40}},
                                                    color={0,127,255}));
    connect(PRV.port_a, TCV.port_a) annotation (Line(points={{-120,74},{-104,74},
            {-104,40},{-12,40}}, color={0,127,255}));
    connect(boundary.ports[1],PRV. port_b)
      annotation (Line(points={{-148,74},{-136,74}}, color={0,127,255}));
    connect(actuatorBus.TBV,PRV. opening) annotation (Line(
        points={{30,100},{-128,100},{-128,80.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(firstfeedpump.port_b, sensor_T4.port_b) annotation (Line(points={{30,-128},
            {10,-128}},                              color={0,127,255}));
    connect(port_b, pump_SimpleMassFlow1.port_b) annotation (Line(points={{-160,-40},
            {-132,-40},{-132,-41}},                            color={0,127,255}));
    connect(pump_SimpleMassFlow1.port_a, sensor_T2.port_b) annotation (Line(
          points={{-110,-41},{-110,-42},{-82,-42}},                    color={0,
            127,255}));
    connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
            -112},{146,-128},{50,-128}},          color={0,127,255}));
    connect(powerSensor.flange_b, generator1.shaft_a) annotation (Line(points={{72,-76},
            {84,-76},{84,-82}},                      color={0,0,0}));
    connect(sensor_T2.port_a, FeedwaterMixVolume.port_a[1]) annotation (Line(
          points={{-62,-42},{-42,-42},{-42,-40},{-36,-40}}, color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[1], R_InternalBypass.port_b)
      annotation (Line(points={{-24,-40.6667},{-24,-9}},
                                                      color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[2], sensor_T4.port_a) annotation (Line(
          points={{-24,-40},{-20,-40},{-20,-128},{-10,-128}},
          color={0,127,255}));
    connect(InternalBypass.port_a, header.port_b[2]) annotation (Line(points={{
            -82,22},{-94,22},{-94,24},{-106,24},{-106,42.5}}, color={0,127,255}));
    connect(InternalBypass.port_b, R_InternalBypass.port_a) annotation (Line(
          points={{-66,22},{-44,22},{-44,20},{-24,20},{-24,5}}, color={0,127,255}));
    connect(actuatorBus.Divert_Valve_Position, InternalBypass.opening)
      annotation (Line(
        points={{30,100},{-74,100},{-74,28.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(HPT.shaft_b,LPT. shaft_a) annotation (Line(
        points={{52,34},{56,34},{56,-24},{46,-24},{46,-30}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(LPT.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{46,-50},{46,-76},{52,-76}}, color={0,0,0}));
    connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{52,-50},{52,-58},
            {38,-58},{38,-112},{118,-112},{118,-84},{153,-84},{153,-92}}, color={0,
            127,255}));
    connect(sensor_T1.port_b, HPT.portHP) annotation (Line(points={{28,40},{32,40}},
                            color={0,127,255}));
    connect(HPT.portLP, tee.port_2) annotation (Line(points={{52,40},{72,40},{72,
            36},{90,36},{90,14}}, color={0,127,255}));
    connect(LPT.portHP, tee.port_1) annotation (Line(points={{52,-30},{66,-30},{
            66,-28},{90,-28},{90,-6}}, color={0,127,255}));
    connect(sensorBus.SHS_Return_T, sensor_T3.T) annotation (Line(
        points={{-30,100},{-30,74},{88,74},{88,58},{134,58},{134,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TCV_SHS, TCV_LPT.opening) annotation (Line(
        points={{30,100},{104,100},{104,78.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(port_a1, SHS_charge_control.port_a) annotation (Line(points={{-92,
            -160},{-92,-102},{-70,-102}}, color={0,127,255}));
    connect(SHS_charge_control.port_b, FeedwaterMixVolume.port_b[3]) annotation (
        Line(points={{-54,-102},{-20,-102},{-20,-39.3333},{-24,-39.3333}}, color=
            {0,127,255}));
    connect(actuatorBus.SHS_throttle, SHS_charge_control.opening) annotation (
        Line(
        points={{30,100},{-90,100},{-90,-84},{-62,-84},{-62,-95.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TCV_LPT.port_b, sensor_T3.port_b)
      annotation (Line(points={{112,72},{124,72}}, color={0,127,255}));
    connect(sensor_T3.port_a, port_a2)
      annotation (Line(points={{144,72},{160,72}}, color={0,127,255}));
    connect(TCV_LPT.port_a, tee.port_3) annotation (Line(points={{96,72},{90,72},
            {90,52},{104,52},{104,4},{100,4}}, color={0,127,255}));
    connect(Discharge_OnOff.port_b, port_b1)
      annotation (Line(points={{134,-146},{160,-146}}, color={0,127,255}));
    connect(actuatorBus.Discharge_OnOff_Throttle, Discharge_OnOff.opening)
      annotation (Line(
        points={{30,100},{186,100},{186,-132},{126,-132},{126,-139.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(firstfeedpump1.port_a, Condenser.port_b) annotation (Line(points={{84,
            -148},{78,-148},{78,-128},{146,-128},{146,-112}}, color={0,127,255}));
    connect(firstfeedpump1.port_b, Discharge_OnOff.port_a) annotation (Line(
          points={{104,-148},{112,-148},{112,-146},{118,-146}}, color={0,127,255}));
    connect(actuatorBus.Feed_Pump_Speed, pump_SimpleMassFlow1.in_m_flow)
      annotation (Line(
        points={{30,100},{-92,100},{-92,-56},{-121,-56},{-121,-49.03}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
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
  end Intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2;

  model Intermediate_Rankine_Cycle_TESUC_3_Peaking_IC "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.TESTurbine data(
        valve_SHS_mflow=35,
        valve_SHS_dp_nominal=1000000,
        valve_TCV_LPT_mflow=30,
        valve_TCV_LPT_dp_nominal=10000,
        InternalBypassValve_mflow_small=0,
        InternalBypassValve_p_spring=15000000,
        InternalBypassValve_K=40,
        firstfeedpump_p_nominal=2000000,
        secondfeedpump_p_nominal=2000000));

    Data.IntermediateTurbineInitialisation init(
      FeedwaterMixVolume_p_start=3000000,
        FeedwaterMixVolume_h_start=2e6,
      InternalBypassValve_dp_start=3500000,
      InternalBypassValve_mflow_start=0.1,
      HPT_p_a_start=3000000,
      HPT_p_b_start=10000,
      HPT_T_a_start=523.15,
      HPT_T_b_start=333.15)
    annotation (Placement(transformation(extent={{68,120},{88,140}})));

    Fluid.Vessels.IdealCondenser Condenser(
      p= data.p_condensor,
      V_total=data.V_condensor,
      V_liquid_start=init.condensor_V_liquid_start)
      annotation (Placement(transformation(extent={{156,-112},{136,-92}})));

    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)                                    annotation (Placement(
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
          origin={40,-128})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass(R=data.R_bypass,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-24,-2})));

    TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=init.FeedwaterMixVolume_p_start,
      use_T_start=true,
      T_start=421.15,
      h_start=init.FeedwaterMixVolume_h_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_FeedwaterMixVolume),
      nPorts_a=1,
      nPorts_b=3) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-30,-40})));

    Electrical.Generator      generator1(J=data.generator_MoI)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={84,-92})));

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
      nPorts_b=2,
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
          origin={0,-128})));

    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{52,-66},{72,-86}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-102,-170},{-82,-150}}),
          iconTransformation(extent={{-74,-106},{-54,-86}})));

    TRANSFORM.Fluid.Valves.ValveLinear InternalBypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1500000,
      m_flow_nominal=15) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-74,22})));
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
      p_inlet_nominal=data.p_in_nominal,
      p_outlet_nominal=data.HPT_p_exit_nominal,
      T_nominal=data.HPT_T_in_nominal)
      annotation (Placement(transformation(extent={{32,24},{52,44}})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      V=data.V_tee,
      p_start=init.tee_p_start)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={90,4})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      eta_mech=data.LPT_efficiency,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=init.LPT_p_a_start,
      p_b_start=init.LPT_p_b_start,
      T_a_start=init.LPT_T_a_start,
      T_b_start=init.LPT_T_b_start,
      m_flow_nominal=data.LPT_nominal_mflow,
      p_inlet_nominal=data.LPT_p_in_nominal,
      p_outlet_nominal=data.LPT_p_exit_nominal,
      T_nominal=data.LPT_T_in_nominal) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={46,-40})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{150,62},{170,82}}),
          iconTransformation(extent={{88,58},{108,78}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{150,-156},{170,-136}}),
          iconTransformation(extent={{88,-62},{108,-42}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow2(
      m_flow_nominal=data.controlledfeedpump_mflow_nominal,
      use_input=true,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                           annotation (
        Placement(transformation(
          extent={{11,-11},{-11,11}},
          rotation=180,
          origin={137,-143})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T3(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={134,72})));
    TRANSFORM.Fluid.Valves.ValveLinear TCV_LPT(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=data.valve_TCV_LPT_dp_nominal,
      m_flow_nominal=data.valve_TCV_LPT_mflow) annotation (Placement(
          transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={104,72})));
    TRANSFORM.Fluid.Valves.ValveLinear SHS_charge_control(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=data.valve_SHS_dp_nominal,
      m_flow_nominal=data.valve_SHS_mflow) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-62,-102})));
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

    connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{84,-102},
            {84,-106},{104,-106},{104,-48},{110,-48}},
                                                     color={255,0,0}));
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
      annotation (Line(points={{-106,41.5},{-60,41.5},{-60,40},{-12,40}},
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
    connect(firstfeedpump.port_b, sensor_T4.port_b) annotation (Line(points={{30,-128},
            {10,-128}},                              color={0,127,255}));
    connect(port_b, pump_SimpleMassFlow1.port_b) annotation (Line(points={{-160,-40},
            {-132,-40},{-132,-41}},                            color={0,127,255}));
    connect(pump_SimpleMassFlow1.port_a, sensor_T2.port_b) annotation (Line(
          points={{-110,-41},{-110,-42},{-82,-42}},                    color={0,
            127,255}));
    connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
            -112},{146,-128},{50,-128}},          color={0,127,255}));
    connect(powerSensor.flange_b, generator1.shaft_a) annotation (Line(points={{72,-76},
            {84,-76},{84,-82}},                      color={0,0,0}));
    connect(sensor_T2.port_a, FeedwaterMixVolume.port_a[1]) annotation (Line(
          points={{-62,-42},{-42,-42},{-42,-40},{-36,-40}}, color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[1], R_InternalBypass.port_b)
      annotation (Line(points={{-24,-40.6667},{-24,-9}},
                                                      color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[2], sensor_T4.port_a) annotation (Line(
          points={{-24,-40},{-20,-40},{-20,-128},{-10,-128}},
          color={0,127,255}));
    connect(InternalBypass.port_a, header.port_b[2]) annotation (Line(points={{
            -82,22},{-94,22},{-94,24},{-106,24},{-106,42.5}}, color={0,127,255}));
    connect(InternalBypass.port_b, R_InternalBypass.port_a) annotation (Line(
          points={{-66,22},{-44,22},{-44,20},{-24,20},{-24,5}}, color={0,127,255}));
    connect(actuatorBus.Divert_Valve_Position, InternalBypass.opening)
      annotation (Line(
        points={{30,100},{-74,100},{-74,28.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(HPT.shaft_b,LPT. shaft_a) annotation (Line(
        points={{52,34},{56,34},{56,-24},{46,-24},{46,-30}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(LPT.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{46,-50},{46,-76},{52,-76}}, color={0,0,0}));
    connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{52,-50},{52,-58},
            {38,-58},{38,-112},{118,-112},{118,-84},{153,-84},{153,-92}}, color={0,
            127,255}));
    connect(sensor_T1.port_b, HPT.portHP) annotation (Line(points={{28,40},{32,40}},
                            color={0,127,255}));
    connect(HPT.portLP, tee.port_2) annotation (Line(points={{52,40},{72,40},{72,
            36},{90,36},{90,14}}, color={0,127,255}));
    connect(LPT.portHP, tee.port_1) annotation (Line(points={{52,-30},{66,-30},{
            66,-28},{90,-28},{90,-6}}, color={0,127,255}));
    connect(pump_SimpleMassFlow2.port_b, port_b1) annotation (Line(points={{148,
            -143},{152,-143},{152,-146},{160,-146}}, color={0,127,255}));
    connect(pump_SimpleMassFlow2.port_a, firstfeedpump.port_a) annotation (Line(
          points={{126,-143},{122,-143},{122,-128},{50,-128}}, color={0,127,255}));
    connect(actuatorBus.condensor_pump, pump_SimpleMassFlow2.in_m_flow)
      annotation (Line(
        points={{30,100},{190,100},{190,-160},{137,-160},{137,-151.03}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.SHS_Return_T, sensor_T3.T) annotation (Line(
        points={{-30,100},{-30,74},{88,74},{88,58},{134,58},{134,68.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TCV_SHS, TCV_LPT.opening) annotation (Line(
        points={{30,100},{104,100},{104,78.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(port_a1, SHS_charge_control.port_a) annotation (Line(points={{-92,
            -160},{-92,-102},{-70,-102}}, color={0,127,255}));
    connect(SHS_charge_control.port_b, FeedwaterMixVolume.port_b[3]) annotation (
        Line(points={{-54,-102},{-20,-102},{-20,-39.3333},{-24,-39.3333}}, color=
            {0,127,255}));
    connect(actuatorBus.SHS_throttle, SHS_charge_control.opening) annotation (
        Line(
        points={{30,100},{-90,100},{-90,-84},{-62,-84},{-62,-95.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TCV_LPT.port_b, sensor_T3.port_b)
      annotation (Line(points={{112,72},{124,72}}, color={0,127,255}));
    connect(sensor_T3.port_a, port_a2)
      annotation (Line(points={{144,72},{160,72}}, color={0,127,255}));
    connect(TCV_LPT.port_a, tee.port_3) annotation (Line(points={{96,72},{90,72},
            {90,52},{104,52},{104,4},{100,4}}, color={0,127,255}));
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
  end Intermediate_Rankine_Cycle_TESUC_3_Peaking_IC;

  model Intermediate_Rankine_Cycle_TESUC_3_Peaking "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.TESTurbine data(
        InternalBypassValve_mflow_small=0,
        InternalBypassValve_p_spring=15000000,
        InternalBypassValve_K=40,
        firstfeedpump_p_nominal=2000000,
        secondfeedpump_p_nominal=2000000));

    Data.IntermediateTurbineInitialisation init(
      FeedwaterMixVolume_p_start=3000000,
        FeedwaterMixVolume_h_start=2e6,
      InternalBypassValve_dp_start=3500000,
      InternalBypassValve_mflow_start=0.1,
      HPT_p_a_start=3000000,
      HPT_p_b_start=10000,
      HPT_T_a_start=523.15,
      HPT_T_b_start=333.15)
    annotation (Placement(transformation(extent={{68,120},{88,140}})));

    Fluid.Vessels.IdealCondenser Condenser(
      p= data.p_condensor,
      V_total=data.V_condensor,
      V_liquid_start=init.condensor_V_liquid_start)
      annotation (Placement(transformation(extent={{156,-112},{136,-92}})));

    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)                                    annotation (Placement(
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
          origin={40,-128})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass(R=data.R_bypass,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-24,-2})));

    TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=init.FeedwaterMixVolume_p_start,
      use_T_start=true,
      T_start=421.15,
      h_start=init.FeedwaterMixVolume_h_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_FeedwaterMixVolume),
      nPorts_a=1,
      nPorts_b=3) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-30,-40})));

    Electrical.Generator      generator1(J=data.generator_MoI)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={84,-92})));

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
      nPorts_b=2,
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
          origin={0,-128})));

    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{52,-66},{72,-86}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-102,-170},{-82,-150}}),
          iconTransformation(extent={{-74,-106},{-54,-86}})));

    TRANSFORM.Fluid.Valves.ValveLinear InternalBypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1500000,
      m_flow_nominal=15) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-74,22})));
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
      p_inlet_nominal=data.p_in_nominal,
      p_outlet_nominal=data.HPT_p_exit_nominal,
      T_nominal=data.HPT_T_in_nominal)
      annotation (Placement(transformation(extent={{32,24},{52,44}})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      V=data.V_tee,
      p_start=init.tee_p_start)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={90,4})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      eta_mech=data.LPT_efficiency,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=init.LPT_p_a_start,
      p_b_start=init.LPT_p_b_start,
      T_a_start=init.LPT_T_a_start,
      T_b_start=init.LPT_T_b_start,
      m_flow_nominal=data.LPT_nominal_mflow,
      p_inlet_nominal=data.LPT_p_in_nominal,
      p_outlet_nominal=data.LPT_p_exit_nominal,
      T_nominal=data.LPT_T_in_nominal) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={46,-40})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{150,62},{170,82}}),
          iconTransformation(extent={{88,58},{108,78}})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             firstfeedpump1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=data.secondfeedpump_p_nominal,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={138,-146})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{150,-156},{170,-136}}),
          iconTransformation(extent={{88,-62},{108,-42}})));
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

    connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{84,-102},
            {84,-106},{104,-106},{104,-48},{110,-48}},
                                                     color={255,0,0}));
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
      annotation (Line(points={{-106,41.5},{-60,41.5},{-60,40},{-12,40}},
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
    connect(firstfeedpump.port_b, sensor_T4.port_b) annotation (Line(points={{30,-128},
            {10,-128}},                              color={0,127,255}));
    connect(port_b, pump_SimpleMassFlow1.port_b) annotation (Line(points={{-160,-40},
            {-132,-40},{-132,-41}},                            color={0,127,255}));
    connect(pump_SimpleMassFlow1.port_a, sensor_T2.port_b) annotation (Line(
          points={{-110,-41},{-110,-42},{-82,-42}},                    color={0,
            127,255}));
    connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
            -112},{146,-128},{50,-128}},          color={0,127,255}));
    connect(powerSensor.flange_b, generator1.shaft_a) annotation (Line(points={{72,-76},
            {84,-76},{84,-82}},                      color={0,0,0}));
    connect(sensor_T2.port_a, FeedwaterMixVolume.port_a[1]) annotation (Line(
          points={{-62,-42},{-42,-42},{-42,-40},{-36,-40}}, color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[1], R_InternalBypass.port_b)
      annotation (Line(points={{-24,-40.6667},{-24,-9}},
                                                      color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[2], sensor_T4.port_a) annotation (Line(
          points={{-24,-40},{-20,-40},{-20,-128},{-10,-128}},
          color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[3], port_a1) annotation (Line(points={{-24,
            -39.3333},{-20,-39.3333},{-20,-108},{-92,-108},{-92,-160}},
                                                              color={0,127,255}));
    connect(InternalBypass.port_a, header.port_b[2]) annotation (Line(points={{
            -82,22},{-94,22},{-94,24},{-106,24},{-106,42.5}}, color={0,127,255}));
    connect(InternalBypass.port_b, R_InternalBypass.port_a) annotation (Line(
          points={{-66,22},{-44,22},{-44,20},{-24,20},{-24,5}}, color={0,127,255}));
    connect(actuatorBus.Divert_Valve_Position, InternalBypass.opening)
      annotation (Line(
        points={{30,100},{-74,100},{-74,28.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(HPT.shaft_b,LPT. shaft_a) annotation (Line(
        points={{52,34},{56,34},{56,-24},{46,-24},{46,-30}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(LPT.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{46,-50},{46,-76},{52,-76}}, color={0,0,0}));
    connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{52,-50},{52,-58},
            {38,-58},{38,-112},{118,-112},{118,-84},{153,-84},{153,-92}}, color={0,
            127,255}));
    connect(tee.port_3, port_a2) annotation (Line(points={{100,4},{144,4},{144,72},
            {160,72}},                       color={0,127,255}));
    connect(Condenser.port_b, firstfeedpump1.port_a) annotation (Line(points={{146,
            -112},{146,-132},{118,-132},{118,-146},{128,-146}}, color={0,127,255}));
    connect(firstfeedpump1.port_b, port_b1)
      annotation (Line(points={{148,-146},{160,-146}}, color={0,127,255}));
    connect(sensor_T1.port_b, HPT.portHP) annotation (Line(points={{28,40},{32,40}},
                            color={0,127,255}));
    connect(HPT.portLP, tee.port_2) annotation (Line(points={{52,40},{72,40},{72,
            36},{90,36},{90,14}}, color={0,127,255}));
    connect(LPT.portHP, tee.port_1) annotation (Line(points={{52,-30},{66,-30},{
            66,-28},{90,-28},{90,-6}}, color={0,127,255}));
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
  end Intermediate_Rankine_Cycle_TESUC_3_Peaking;

  model Intermediate_Rankine_Cycle_TESUC_SmallCycle_Pressure
    "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.TESTurbine data(
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
        firstfeedpump_p_nominal=100000));

    Data.IntermediateTurbineInitialisation init(
      p_steam_vent=15000000,
      T_Steam_Ref=491.15,
      Q_Nom=20e6,
      T_Feedwater=309.15,
      p_steam=1200000,
      FeedwaterMixVolume_p_start=100000,
      header_p_start=1197000,
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
      use_T_start=true,
      T_start=523.15,
      h_start=init.header_h_start,
      p_start=init.header_p_start,
      nPorts_a=1,
      nPorts_b=1,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-122,32},{-102,52}})));

    TRANSFORM.Fluid.Machines.Pump_PressureBooster pump_SimpleMassFlow1(
      use_input=true,
      redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      p_nominal=1200000)                                   annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-125,-39})));

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
    connect(port_b, pump_SimpleMassFlow1.port_b) annotation (Line(points={{-160,
            -40},{-136,-40},{-136,-39}},                       color={0,127,255}));
    connect(pump_SimpleMassFlow1.port_a, sensor_T2.port_b) annotation (Line(
          points={{-114,-39},{-114,-42},{-82,-42}},                    color={0,
            127,255}));
    connect(powerSensor.flange_b, generator1.shaft_a) annotation (Line(points={{98,34},
            {102,34},{102,-22},{98,-22},{98,-28}},   color={0,0,0}));
    connect(R_InternalBypass1.port_b, Condenser.port_a) annotation (Line(points={{
            64,-29},{64,-82},{154,-82},{154,-92},{153,-92}}, color={0,127,255}));
    connect(sensor_T1.port_b, HPT.portHP)
      annotation (Line(points={{28,40},{36,40}}, color={0,127,255}));
    connect(HPT.portLP, R_InternalBypass1.port_a)
      annotation (Line(points={{56,40},{64,40},{64,-15}}, color={0,127,255}));
    connect(HPT.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{56,34},{78,34}}, color={0,0,0}));
    connect(actuatorBus.Feed_Pump_Speed, pump_SimpleMassFlow1.in_p) annotation (
        Line(
        points={{30,100},{-102,100},{-102,-58},{-125,-58},{-125,-47.03}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensor_T4.port_b, Condenser.port_b) annotation (Line(points={{90,-144},
            {114,-144},{114,-142},{146,-142},{146,-112}}, color={0,127,255}));
    connect(sensor_T2.port_a, sensor_T4.port_a) annotation (Line(points={{-62,-42},
            {-10,-42},{-10,-144},{70,-144}}, color={0,127,255}));
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
  end Intermediate_Rankine_Cycle_TESUC_SmallCycle_Pressure;

  model SteamTurbine_L1_boundaries_no_heat_pump

    extends BaseClasses.Partial_SubSystem_B(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.IdealTurbine data);

    parameter SI.Pressure p_condenser=1e4 "Condenser operating pressure";
    parameter SI.Pressure p_reservoir=port_b_nominal.p "Reservoir operating pressure";

    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
      redeclare package Medium = Medium,
      use_T_start=false,
      h_a_start=port_a_start.h,
      m_flow_start=port_a_start.m_flow,
      m_flow_nominal=port_a_nominal.m_flow,
      use_T_nominal=false,
      nUnits=2,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      p_b_start=p_condenser,
      p_outlet_nominal=p_condenser,
      d_nominal=Medium.density_ph(steamTurbine.p_inlet_nominal, port_a_nominal.h),
      p_a_start=header.p_start -valve_TCV.dp_start,
      p_inlet_nominal=port_a_nominal.p -valve_TCV.dp_nominal)
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    Electrical.Generator      generator1(J=1e4)
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{130,-10},{150,10}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Medium, R=1)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={80,-30})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                                      condenser(
      redeclare package Medium = Medium,
      set_m_flow=true,
      p=p_condenser)
      annotation (Placement(transformation(extent={{77,-94},{97,-74}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = Medium,
      use_T_start=false,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.01),
      p_start=p_condenser,
      h_start=steamTurbine.h_b_start)
      annotation (Placement(transformation(extent={{58,-30},{78,-10}})));
    TRANSFORM.Fluid.Volumes.DumpTank reservoir(
      redeclare package Medium = Medium,
      A=10,
      p_start=p_reservoir,
      level_start=10)
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Fluid.Fittings.MultiPort multiPort(redeclare package Medium =
          Medium, nPorts_b=2)
                         annotation (Placement(transformation(
          extent={{-4,-10},{4,10}},
          rotation=90,
          origin={0,-80})));
    Modelica.Fluid.Fittings.MultiPort multiPort1(redeclare package Medium =
          Medium, nPorts_b=if nPorts_a3 > 0 then nPorts_a3+2 else 2)
                         annotation (Placement(transformation(
          extent={{-4,-10},{4,10}},
          rotation=90,
          origin={80,-66})));
    TRANSFORM.Fluid.Sensors.Pressure pressure(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
    TRANSFORM.Fluid.Valves.ValveCompressible valve_BV(
      rho_nominal=Medium.density_ph(port_a_nominal.p, port_a_nominal.h),
      p_nominal=port_a_nominal.p,
      redeclare package Medium = Medium,
      m_flow_nominal=port_a_nominal.m_flow,
      dp_nominal=100000)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume_bypass(
      use_T_start=false,
      h_start=port_a_start.h,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.01),
      redeclare package Medium = Medium,
      p_start=p_condenser)
                     "included for numeric purposes"
      annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance3(R=1,
        redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,-10})));
    Modelica.Blocks.Sources.RealExpression W_balance1
      "Electricity loss/gain not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]"
      annotation (Placement(transformation(extent={{-96,118},{-84,130}})));
    TRANSFORM.Fluid.Valves.ValveCompressible valve_TCV(
      rho_nominal=Medium.density_ph(port_a_nominal.p, port_a_nominal.h),
      p_nominal=port_a_nominal.p,
      redeclare package Medium = Medium,
      m_flow_nominal=port_a_nominal.m_flow,
      dp_nominal=100000)
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    TRANSFORM.Fluid.Volumes.MixingVolume header(
      use_T_start=false,
      h_start=port_a_start.h,
      p_start=port_a_start.p,
      nPorts_a=1,
      nPorts_b=3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance4(R=1,
        redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-130,40})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary_a3[nPorts_a3](
      redeclare package Medium = Medium,
      each nPorts=1,
      p=port_a3_nominal_p,
      h=port_a3_nominal_h) if nPorts_a3 > 0
      annotation (Placement(transformation(extent={{50,-150},{30,-130}})));
     TRANSFORM.Fluid.Valves.CheckValve checkValve[nPorts_a3](redeclare package
        Medium =  Medium, m_flow_start=port_a3_start_m_flow) if nPorts_a3 > 0
       annotation (Placement(transformation(extent={{0,-150},{20,-130}})));
     TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary_m_flow_a3[
       nPorts_a3](
       redeclare package Medium = Medium,
       each nPorts=1,
      each use_m_flow_in=true,
      each use_h_in=true)  if nPorts_a3 > 0
       annotation (Placement(transformation(extent={{72,-150},{92,-130}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate massFlowRate[nPorts_a3](redeclare
        package Medium = Medium) if nPorts_a3 > 0
      annotation (Placement(transformation(extent={{-30,-150},{-10,-130}})));
    TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort
                                             specificEnthalpy[nPorts_a3](
        redeclare package Medium = Medium) if nPorts_a3 > 0
      annotation (Placement(transformation(extent={{-60,-150},{-40,-130}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{70,10},{90,-10}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(R=1,
        redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-50,-80})));
    TRANSFORM.Controls.LimPID_Hysteresis PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k_s=1/reservoir.level_start,
      k_m=1/reservoir.level_start,
      k=1e2,
      yMin=0,
      eOn=0.1*reservoir.level_start)
      annotation (Placement(transformation(extent={{-62,-50},{-42,-30}})));
    Modelica.Blocks.Sources.RealExpression level_setpoint(y=reservoir.level_start)
      annotation (Placement(transformation(extent={{-94,-42},{-74,-22}})));
    Modelica.Blocks.Sources.RealExpression level_measure(y=reservoir.level)
      "noEvent(if time < 10 then reservoir.level_start else reservoir.level)"
      annotation (Placement(transformation(extent={{-94,-62},{-74,-42}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      T=298.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-28,-70},{-8,-50}})));
  equation

  for i in 1:nPorts_a3 loop
      connect(specificEnthalpy[i].port_a, port_a3[i]);
      connect(specificEnthalpy[i].port_b, massFlowRate[i].port_a);
       connect(checkValve[i].port_a, massFlowRate[i].port_b);
       connect(checkValve[i].port_b, boundary_a3[i].ports[1]);
  connect(boundary_m_flow_a3[i].ports[1], multiPort1.ports_b[i+2]);

  end for;

    connect(generator1.portElec, sensorW.port_a)
      annotation (Line(points={{120,0},{130,0}}, color={255,0,0}));
    connect(sensorW.port_b, portElec_b)
      annotation (Line(points={{150,0},{160,0}}, color={255,0,0}));
    connect(steamTurbine.portLP, volume.port_a)
      annotation (Line(points={{60,6},{60,-20},{62,-20}},   color={0,127,255}));
    connect(multiPort.port_a, reservoir.port_a)
      annotation (Line(points={{0,-84},{0,-91.6}}, color={0,127,255}));
    connect(volume.port_b, resistance.port_a)
      annotation (Line(points={{74,-20},{80,-20},{80,-23}}, color={0,127,255}));
    connect(multiPort1.port_a, condenser.port_a)
      annotation (Line(points={{80,-70},{80,-77}}, color={0,127,255}));
    connect(condenser.port_b, multiPort.ports_b[1]) annotation (Line(points={{87,-92},
            {87,-100},{20,-100},{20,-68},{-2,-68},{-2,-76}}, color={0,127,255}));
    connect(sensorBus.p_inlet_steamTurbine, pressure.p)
      annotation (Line(
        points={{-29.9,100.1},{-94,100.1},{-94,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume_bypass.port_a, valve_BV.port_b)
      annotation (Line(points={{-26,0},{-60,0}}, color={0,127,255}));
    connect(volume_bypass.port_b, resistance3.port_a)
      annotation (Line(points={{-14,0},{4.44089e-16,0},{4.44089e-16,-3}},
                                                         color={0,127,255}));
    connect(resistance3.port_b, multiPort1.ports_b[1]) annotation (Line(points={{
            -4.44089e-16,-17},{-4.44089e-16,-28},{0,-28},{0,-40},{80,-40},{80,-62}},
                                                        color={0,127,255}));
    connect(resistance.port_b, multiPort1.ports_b[2]) annotation (Line(points={{80,-37},
            {80,-62}},                        color={0,127,255}));
    connect(valve_BV.port_a, header.port_b[1]) annotation (Line(points={{-80,0},{
            -100,0},{-100,39.3333},{-104,39.3333}}, color={0,127,255}));
    connect(valve_TCV.port_a, header.port_b[2]) annotation (Line(points={{-80,40},
            {-92,40},{-92,40},{-104,40}},     color={0,127,255}));
    connect(port_a, resistance4.port_a)
      annotation (Line(points={{-160,40},{-137,40}}, color={0,127,255}));
    connect(resistance4.port_b, header.port_a[1])
      annotation (Line(points={{-123,40},{-116,40}}, color={0,127,255}));
    connect(massFlowRate.m_flow, boundary_m_flow_a3.m_flow_in) annotation (Line(
          points={{-20,-136.4},{-20,-124},{62,-124},{62,-132},{72,-132}},
                                                                        color={0,0,
            127}));
    connect(specificEnthalpy.h_out, boundary_m_flow_a3.h_in) annotation (Line(
          points={{-50,-136.4},{-50,-126},{60,-126},{60,-136},{70,-136}},
                                                                        color={0,0,
            127}));
    connect(steamTurbine.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{60,0},{70,0}}, color={0,0,0}));
    connect(powerSensor.flange_b, generator1.shaft_a)
      annotation (Line(points={{90,0},{100,0}}, color={0,0,0}));
    connect(valve_TCV.port_b, steamTurbine.portHP)
      annotation (Line(points={{-60,40},{40,40},{40,6}}, color={0,127,255}));
    connect(pressure.port, header.port_b[3]) annotation (Line(points={{-100,50},{
            -100,40},{-104,40},{-104,40.6667}},     color={0,127,255}));
    connect(actuatorBus.opening_TCV,valve_TCV. opening)
      annotation (Line(
        points={{30.1,100.1},{30.1,100.1},{-8,100.1},{-8,102},{-70,102},{-70,48}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(resistance2.port_a, reservoir.port_b) annotation (Line(points={{-43,
            -80},{-40,-80},{-40,-114},{0,-114},{0,-108.4}}, color={0,127,255}));
    connect(actuatorBus.opening_BV, valve_BV.opening)
      annotation (Line(
        points={{30.1,100.1},{-8,100.1},{-8,102},{-50,102},{-50,20},{-70,20},{-70,
            8}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_total, sensorW.W) annotation (Line(
        points={{-29.9,100.1},{140,100.1},{140,11}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(level_measure.y, PID1.u_m)
      annotation (Line(points={{-73,-52},{-52,-52}}, color={0,0,127}));
    connect(level_setpoint.y, PID1.u_s)
      annotation (Line(points={{-73,-32},{-68,-32},{-68,-40},{-64,-40}},
                                                     color={0,0,127}));
    connect(PID1.y, boundary2.m_flow_in) annotation (Line(points={{-41,-40},{-38,
            -40},{-38,-52},{-28,-52}}, color={0,0,127}));
    connect(boundary2.ports[1], multiPort.ports_b[2])
      annotation (Line(points={{-8,-60},{2,-60},{2,-76}}, color={0,127,255}));
    connect(port_b, resistance2.port_b) annotation (Line(points={{-160,-40},{-148,
            -40},{-148,-38},{-132,-38},{-132,-80},{-57,-80}}, color={0,127,255}));
    annotation (defaultComponentName="BOP", Icon(coordinateSystem(extent={{-100,-100},
              {100,100}}),                       graphics={
          Rectangle(
            extent={{-2.09756,2},{83.9024,-2}},
            lineColor={0,0,0},
            origin={-39.9024,-64},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.578156,2.1722},{23.1262,-2.1722}},
            lineColor={0,0,0},
            origin={27.4218,-39.8278},
            rotation=180,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-1.81332,3},{66.1869,-3}},
            lineColor={0,0,0},
            origin={-14.1867,-1},
            rotation=0,
            fillColor={135,135,135},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.373344,2},{13.6267,-2}},
            lineColor={0,0,0},
            origin={24.3733,-56},
            rotation=0,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.4,3},{15.5,-3}},
            lineColor={0,0,0},
            origin={36.4272,-29},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-14,46},{12,34}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-64,46},{-16,34}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-24,49},{-6,31}},
            lineColor={95,95,95},
            fillColor={175,175,175},
            fillPattern=FillPattern.Sphere),
          Ellipse(
            extent={{-13,49},{-17,31}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={162,162,0}),
          Rectangle(
            extent={{-24,63},{-6,61}},
            lineColor={0,0,0},
            fillColor={181,0,0},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-14,49},{-16,61}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{-16,3},{16,-3}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={10,30},
            rotation=-90),
          Polygon(
            points={{6,16},{6,-14},{36,-32},{36,36},{6,16}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-1.81329,5},{66.1867,-5}},
            lineColor={0,0,0},
            origin={-62.1867,-41},
            rotation=0,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Line(points={{10,-42}}, color={0,0,0}),
          Rectangle(
            extent={{-0.43805,2.7864},{15.9886,-2.7864}},
            lineColor={0,0,0},
            origin={49.2136,-41.9886},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Text(
            extent={{15,-8},{25,6}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="T"),
          Polygon(
            points={{4,-44},{0,-48},{16,-48},{12,-44},{4,-44}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder),
          Ellipse(
            extent={{2,-34},{14,-46}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,100,199}),
          Polygon(
            points={{9,-37},{9,-43},{5,-40},{9,-37}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={255,255,255}),
          Ellipse(
            extent={{50,12},{78,-14}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{59,-8},{69,6}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="G"),
          Rectangle(
            extent={{-0.487802,2},{19.5122,-2}},
            lineColor={0,0,0},
            origin={26,-38.4878},
            rotation=-90,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{36,-42},{64,-68}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{45,-62},{55,-48}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="C"),
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Turbine"),
          Rectangle(
            extent={{-0.243902,2},{9.7562,-2}},
            lineColor={0,0,0},
            origin={-40,-62.2438},
            rotation=-90,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder)}),
      Diagram(coordinateSystem(extent={{-160,-160},{160,140}})),
      experiment(StopTime=1000));
  end SteamTurbine_L1_boundaries_no_heat_pump;

  model Intermediate_Rankine_Cycle_TESUC_2 "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.TESTurbine data(
        V_FeedwaterMixVolume=0.01,
        valve_TCV_mflow=300,
        valve_TCV_dp_nominal=10000,
        InternalBypassValve_mflow_small=0,
        InternalBypassValve_p_spring=15000000,
        InternalBypassValve_K=40,
        HPT_p_exit_nominal=10000,
        HPT_T_in_nominal=579.15,
        firstfeedpump_p_nominal=2000000));

    Data.IntermediateTurbineInitialisation init(
      FeedwaterMixVolume_p_start=3000000,
        FeedwaterMixVolume_h_start=2e6,
      InternalBypassValve_dp_start=3500000,
      InternalBypassValve_mflow_start=0.1,
      HPT_p_a_start=3000000,
      HPT_p_b_start=10000,
      HPT_T_a_start=523.15,
      HPT_T_b_start=333.15)
    annotation (Placement(transformation(extent={{68,120},{88,140}})));

    Fluid.Vessels.IdealCondenser Condenser(
      p= data.p_condensor,
      V_total=data.V_condensor,
      V_liquid_start=init.condensor_V_liquid_start)
      annotation (Placement(transformation(extent={{156,-112},{136,-92}})));

    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)                                    annotation (Placement(
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

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass(R=data.R_bypass,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-24,-2})));

    TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=init.FeedwaterMixVolume_p_start,
      use_T_start=true,
      T_start=421.15,
      h_start=init.FeedwaterMixVolume_h_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_FeedwaterMixVolume),
      nPorts_a=1,
      nPorts_b=3) annotation (Placement(transformation(
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
      nPorts_b=2,
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
    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_T_start=false,
      h_a_start=port_a_start.h,
      m_flow_start=port_a_start.m_flow,
      m_flow_nominal=port_a_nominal.m_flow,
      use_Stodola=true,
      use_T_nominal=true,
      nUnits=2,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      p_b_start=data.p_condensor,
      p_outlet_nominal=data.p_condensor,
      T_nominal=579.15,
      d_nominal=Medium.density_ph(steamTurbine.p_inlet_nominal, port_a_nominal.h),
      p_a_start=header.p_start - TCV.dp_start,
      p_inlet_nominal=port_a_nominal.p)
      annotation (Placement(transformation(extent={{40,22},{60,42}})));

    TRANSFORM.Fluid.Valves.ValveLinear InternalBypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1500000,
      m_flow_nominal=15) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-74,22})));
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
      annotation (Line(points={{-106,41.5},{-60,41.5},{-60,40},{-12,40}},
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
          points={{-110,-41},{-110,-42},{-82,-42}},                    color={0,
            127,255}));
    connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
            -112},{146,-144},{118,-144}},         color={0,127,255}));
    connect(powerSensor.flange_b, generator1.shaft_a) annotation (Line(points={{98,34},
            {102,34},{102,-22},{98,-22},{98,-28}},   color={0,0,0}));
    connect(sensor_T2.port_a, FeedwaterMixVolume.port_a[1]) annotation (Line(
          points={{-62,-42},{-42,-42},{-42,-40},{-36,-40}}, color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[1], R_InternalBypass.port_b)
      annotation (Line(points={{-24,-40.6667},{-24,-9}},
                                                      color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[2], sensor_T4.port_a) annotation (Line(
          points={{-24,-40},{-10,-40},{-10,-42},{32,-42},{32,-144},{70,-144}},
          color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[3], port_a1) annotation (Line(points={{-24,
            -39.3333},{-20,-39.3333},{-20,-108},{-92,-108},{-92,-160}},
                                                              color={0,127,255}));
    connect(R_InternalBypass1.port_b, Condenser.port_a) annotation (Line(points={{
            64,-29},{64,-82},{154,-82},{154,-92},{153,-92}}, color={0,127,255}));
    connect(steamTurbine.portLP, R_InternalBypass1.port_a)
      annotation (Line(points={{60,38},{64,38},{64,-15}}, color={0,127,255}));
    connect(steamTurbine.portHP, sensor_T1.port_b)
      annotation (Line(points={{40,38},{34,38},{34,40},{28,40}},
                                                 color={0,127,255}));
    connect(steamTurbine.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{60,32},{68,32},{68,34},{78,34}},
                                                 color={0,0,0}));
    connect(InternalBypass.port_a, header.port_b[2]) annotation (Line(points={{
            -82,22},{-94,22},{-94,24},{-106,24},{-106,42.5}}, color={0,127,255}));
    connect(InternalBypass.port_b, R_InternalBypass.port_a) annotation (Line(
          points={{-66,22},{-44,22},{-44,20},{-24,20},{-24,5}}, color={0,127,255}));
    connect(actuatorBus.Divert_Valve_Position, InternalBypass.opening)
      annotation (Line(
        points={{30,100},{-74,100},{-74,28.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
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
  end Intermediate_Rankine_Cycle_TESUC_2;

  model SteamTurbine_L1_boundaries_no_heat

    extends BaseClasses.Partial_SubSystem_B(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.IdealTurbine data);

    parameter SI.Pressure p_condenser=1e4 "Condenser operating pressure";
    parameter SI.Pressure p_reservoir=port_b_nominal.p "Reservoir operating pressure";

    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
      redeclare package Medium = Medium,
      use_T_start=false,
      h_a_start=port_a_start.h,
      m_flow_start=port_a_start.m_flow,
      m_flow_nominal=port_a_nominal.m_flow,
      use_T_nominal=false,
      nUnits=2,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      p_b_start=p_condenser,
      p_outlet_nominal=p_condenser,
      d_nominal=Medium.density_ph(steamTurbine.p_inlet_nominal, port_a_nominal.h),
      p_a_start=header.p_start -valve_TCV.dp_start,
      p_inlet_nominal=port_a_nominal.p -valve_TCV.dp_nominal)
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    Electrical.Generator      generator1(J=1e4)
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{130,-10},{150,10}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Medium, R=1)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={80,-30})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                                      condenser(
      redeclare package Medium = Medium,
      set_m_flow=true,
      p=p_condenser)
      annotation (Placement(transformation(extent={{77,-94},{97,-74}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = Medium,
      use_T_start=false,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.01),
      p_start=p_condenser,
      h_start=steamTurbine.h_b_start)
      annotation (Placement(transformation(extent={{58,-30},{78,-10}})));
    TRANSFORM.Fluid.Volumes.DumpTank reservoir(
      redeclare package Medium = Medium,
      A=10,
      p_start=p_reservoir,
      level_start=10)
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Fluid.Fittings.MultiPort multiPort(redeclare package Medium =
          Medium, nPorts_b=2)
                         annotation (Placement(transformation(
          extent={{-4,-10},{4,10}},
          rotation=90,
          origin={0,-80})));
    Modelica.Fluid.Fittings.MultiPort multiPort1(redeclare package Medium =
          Medium, nPorts_b=if nPorts_a3 > 0 then nPorts_a3+2 else 2)
                         annotation (Placement(transformation(
          extent={{-4,-10},{4,10}},
          rotation=90,
          origin={80,-66})));
    TRANSFORM.Fluid.Sensors.Pressure pressure(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
    TRANSFORM.Fluid.Valves.ValveCompressible valve_BV(
      rho_nominal=Medium.density_ph(port_a_nominal.p, port_a_nominal.h),
      p_nominal=port_a_nominal.p,
      redeclare package Medium = Medium,
      m_flow_nominal=port_a_nominal.m_flow,
      dp_nominal=100000)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume_bypass(
      use_T_start=false,
      h_start=port_a_start.h,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.01),
      redeclare package Medium = Medium,
      p_start=p_condenser)
                     "included for numeric purposes"
      annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance3(R=1,
        redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,-10})));
    Modelica.Blocks.Sources.RealExpression W_balance1
      "Electricity loss/gain not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]"
      annotation (Placement(transformation(extent={{-96,118},{-84,130}})));
    TRANSFORM.Fluid.Valves.ValveCompressible valve_TCV(
      rho_nominal=Medium.density_ph(port_a_nominal.p, port_a_nominal.h),
      p_nominal=port_a_nominal.p,
      redeclare package Medium = Medium,
      m_flow_nominal=port_a_nominal.m_flow,
      dp_nominal=100000)
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    TRANSFORM.Fluid.Volumes.MixingVolume header(
      use_T_start=false,
      h_start=port_a_start.h,
      p_start=port_a_start.p,
      nPorts_a=1,
      nPorts_b=3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance4(R=1,
        redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-130,40})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary_a3[nPorts_a3](
      redeclare package Medium = Medium,
      each nPorts=1,
      p=port_a3_nominal_p,
      h=port_a3_nominal_h) if nPorts_a3 > 0
      annotation (Placement(transformation(extent={{50,-150},{30,-130}})));
     TRANSFORM.Fluid.Valves.CheckValve checkValve[nPorts_a3](redeclare package
        Medium =  Medium, m_flow_start=port_a3_start_m_flow) if nPorts_a3 > 0
       annotation (Placement(transformation(extent={{0,-150},{20,-130}})));
     TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary_m_flow_a3[
       nPorts_a3](
       redeclare package Medium = Medium,
       each nPorts=1,
      each use_m_flow_in=true,
      each use_h_in=true)  if nPorts_a3 > 0
       annotation (Placement(transformation(extent={{72,-150},{92,-130}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate massFlowRate[nPorts_a3](redeclare
        package Medium = Medium) if nPorts_a3 > 0
      annotation (Placement(transformation(extent={{-30,-150},{-10,-130}})));
    TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort
                                             specificEnthalpy[nPorts_a3](
        redeclare package Medium = Medium) if nPorts_a3 > 0
      annotation (Placement(transformation(extent={{-60,-150},{-40,-130}})));
    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{70,10},{90,-10}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(R=1,
        redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-50,-80})));
    TRANSFORM.Controls.LimPID_Hysteresis PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k_s=1/reservoir.level_start,
      k_m=1/reservoir.level_start,
      k=1e2,
      yMin=0,
      eOn=0.1*reservoir.level_start)
      annotation (Placement(transformation(extent={{-62,-50},{-42,-30}})));
    Modelica.Blocks.Sources.RealExpression level_setpoint(y=reservoir.level_start)
      annotation (Placement(transformation(extent={{-94,-42},{-74,-22}})));
    Modelica.Blocks.Sources.RealExpression level_measure(y=reservoir.level)
      "noEvent(if time < 10 then reservoir.level_start else reservoir.level)"
      annotation (Placement(transformation(extent={{-94,-62},{-74,-42}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      T=298.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-28,-70},{-8,-50}})));
  equation

  for i in 1:nPorts_a3 loop
      connect(specificEnthalpy[i].port_a, port_a3[i]);
      connect(specificEnthalpy[i].port_b, massFlowRate[i].port_a);
       connect(checkValve[i].port_a, massFlowRate[i].port_b);
       connect(checkValve[i].port_b, boundary_a3[i].ports[1]);
  connect(boundary_m_flow_a3[i].ports[1], multiPort1.ports_b[i+2]);

  end for;

    connect(generator1.portElec, sensorW.port_a)
      annotation (Line(points={{120,0},{130,0}}, color={255,0,0}));
    connect(sensorW.port_b, portElec_b)
      annotation (Line(points={{150,0},{160,0}}, color={255,0,0}));
    connect(steamTurbine.portLP, volume.port_a)
      annotation (Line(points={{60,6},{60,-20},{62,-20}},   color={0,127,255}));
    connect(multiPort.port_a, reservoir.port_a)
      annotation (Line(points={{0,-84},{0,-91.6}}, color={0,127,255}));
    connect(volume.port_b, resistance.port_a)
      annotation (Line(points={{74,-20},{80,-20},{80,-23}}, color={0,127,255}));
    connect(multiPort1.port_a, condenser.port_a)
      annotation (Line(points={{80,-70},{80,-77}}, color={0,127,255}));
    connect(condenser.port_b, multiPort.ports_b[1]) annotation (Line(points={{87,-92},
            {87,-100},{20,-100},{20,-68},{-2,-68},{-2,-76}}, color={0,127,255}));
    connect(sensorBus.p_inlet_steamTurbine, pressure.p)
      annotation (Line(
        points={{-29.9,100.1},{-94,100.1},{-94,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume_bypass.port_a, valve_BV.port_b)
      annotation (Line(points={{-26,0},{-60,0}}, color={0,127,255}));
    connect(volume_bypass.port_b, resistance3.port_a)
      annotation (Line(points={{-14,0},{4.44089e-16,0},{4.44089e-16,-3}},
                                                         color={0,127,255}));
    connect(resistance3.port_b, multiPort1.ports_b[1]) annotation (Line(points={{
            -4.44089e-16,-17},{-4.44089e-16,-28},{0,-28},{0,-40},{80,-40},{80,-62}},
                                                        color={0,127,255}));
    connect(resistance.port_b, multiPort1.ports_b[2]) annotation (Line(points={{80,-37},
            {80,-62}},                        color={0,127,255}));
    connect(valve_BV.port_a, header.port_b[1]) annotation (Line(points={{-80,0},{
            -100,0},{-100,39.3333},{-104,39.3333}}, color={0,127,255}));
    connect(valve_TCV.port_a, header.port_b[2]) annotation (Line(points={{-80,40},
            {-92,40},{-92,40},{-104,40}},     color={0,127,255}));
    connect(port_a, resistance4.port_a)
      annotation (Line(points={{-160,40},{-137,40}}, color={0,127,255}));
    connect(resistance4.port_b, header.port_a[1])
      annotation (Line(points={{-123,40},{-116,40}}, color={0,127,255}));
    connect(massFlowRate.m_flow, boundary_m_flow_a3.m_flow_in) annotation (Line(
          points={{-20,-136.4},{-20,-124},{62,-124},{62,-132},{72,-132}},
                                                                        color={0,0,
            127}));
    connect(specificEnthalpy.h_out, boundary_m_flow_a3.h_in) annotation (Line(
          points={{-50,-136.4},{-50,-126},{60,-126},{60,-136},{70,-136}},
                                                                        color={0,0,
            127}));
    connect(steamTurbine.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{60,0},{70,0}}, color={0,0,0}));
    connect(powerSensor.flange_b, generator1.shaft_a)
      annotation (Line(points={{90,0},{100,0}}, color={0,0,0}));
    connect(valve_TCV.port_b, steamTurbine.portHP)
      annotation (Line(points={{-60,40},{40,40},{40,6}}, color={0,127,255}));
    connect(pressure.port, header.port_b[3]) annotation (Line(points={{-100,50},{
            -100,40},{-104,40},{-104,40.6667}},     color={0,127,255}));
    connect(actuatorBus.opening_TCV,valve_TCV. opening)
      annotation (Line(
        points={{30.1,100.1},{30.1,100.1},{-8,100.1},{-8,102},{-70,102},{-70,48}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(resistance2.port_a, reservoir.port_b) annotation (Line(points={{-43,
            -80},{-40,-80},{-40,-114},{0,-114},{0,-108.4}}, color={0,127,255}));
    connect(actuatorBus.opening_BV, valve_BV.opening)
      annotation (Line(
        points={{30.1,100.1},{-8,100.1},{-8,102},{-50,102},{-50,20},{-70,20},{-70,
            8}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_total, sensorW.W) annotation (Line(
        points={{-29.9,100.1},{140,100.1},{140,11}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(level_measure.y, PID1.u_m)
      annotation (Line(points={{-73,-52},{-52,-52}}, color={0,0,127}));
    connect(level_setpoint.y, PID1.u_s)
      annotation (Line(points={{-73,-32},{-68,-32},{-68,-40},{-64,-40}},
                                                     color={0,0,127}));
    connect(PID1.y, boundary2.m_flow_in) annotation (Line(points={{-41,-40},{-38,
            -40},{-38,-52},{-28,-52}}, color={0,0,127}));
    connect(boundary2.ports[1], multiPort.ports_b[2])
      annotation (Line(points={{-8,-60},{2,-60},{2,-76}}, color={0,127,255}));
    connect(port_b, resistance2.port_b) annotation (Line(points={{-160,-40},{-148,
            -40},{-148,-38},{-132,-38},{-132,-80},{-57,-80}}, color={0,127,255}));
    annotation (defaultComponentName="BOP", Icon(coordinateSystem(extent={{-100,-100},
              {100,100}}),                       graphics={
          Rectangle(
            extent={{-2.09756,2},{83.9024,-2}},
            lineColor={0,0,0},
            origin={-39.9024,-64},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.578156,2.1722},{23.1262,-2.1722}},
            lineColor={0,0,0},
            origin={27.4218,-39.8278},
            rotation=180,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-1.81332,3},{66.1869,-3}},
            lineColor={0,0,0},
            origin={-14.1867,-1},
            rotation=0,
            fillColor={135,135,135},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.373344,2},{13.6267,-2}},
            lineColor={0,0,0},
            origin={24.3733,-56},
            rotation=0,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.4,3},{15.5,-3}},
            lineColor={0,0,0},
            origin={36.4272,-29},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-14,46},{12,34}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-64,46},{-16,34}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-24,49},{-6,31}},
            lineColor={95,95,95},
            fillColor={175,175,175},
            fillPattern=FillPattern.Sphere),
          Ellipse(
            extent={{-13,49},{-17,31}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={162,162,0}),
          Rectangle(
            extent={{-24,63},{-6,61}},
            lineColor={0,0,0},
            fillColor={181,0,0},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-14,49},{-16,61}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{-16,3},{16,-3}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={10,30},
            rotation=-90),
          Polygon(
            points={{6,16},{6,-14},{36,-32},{36,36},{6,16}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-1.81329,5},{66.1867,-5}},
            lineColor={0,0,0},
            origin={-62.1867,-41},
            rotation=0,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Line(points={{10,-42}}, color={0,0,0}),
          Rectangle(
            extent={{-0.43805,2.7864},{15.9886,-2.7864}},
            lineColor={0,0,0},
            origin={49.2136,-41.9886},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Text(
            extent={{15,-8},{25,6}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="T"),
          Polygon(
            points={{4,-44},{0,-48},{16,-48},{12,-44},{4,-44}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder),
          Ellipse(
            extent={{2,-34},{14,-46}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,100,199}),
          Polygon(
            points={{9,-37},{9,-43},{5,-40},{9,-37}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={255,255,255}),
          Ellipse(
            extent={{50,12},{78,-14}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{59,-8},{69,6}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="G"),
          Rectangle(
            extent={{-0.487802,2},{19.5122,-2}},
            lineColor={0,0,0},
            origin={26,-38.4878},
            rotation=-90,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{36,-42},{64,-68}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{45,-62},{55,-48}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="C"),
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Turbine"),
          Rectangle(
            extent={{-0.243902,2},{9.7562,-2}},
            lineColor={0,0,0},
            origin={-40,-62.2438},
            rotation=-90,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder)}),
      Diagram(coordinateSystem(extent={{-160,-160},{160,140}})),
      experiment(StopTime=1000));
  end SteamTurbine_L1_boundaries_no_heat;

  model Intermediate_Rankine_Cycle_TESUC_SmallCycle "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.TESTurbine data(
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
        firstfeedpump_p_nominal=100000));

    Data.IntermediateTurbineInitialisation init(
      p_steam_vent=15000000,
      T_Steam_Ref=491.15,
      Q_Nom=20e6,
      T_Feedwater=309.15,
      p_steam=1200000,
      FeedwaterMixVolume_p_start=100000,
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

  model Intermediate_Rankine_Cycle_TESUC "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.TESTurbine data(
        V_FeedwaterMixVolume=0.01,
        valve_TCV_mflow=300,
        valve_TCV_dp_nominal=10000,
        InternalBypassValve_mflow_small=0,
        InternalBypassValve_p_spring=15000000,
        InternalBypassValve_K=40,
        HPT_p_exit_nominal=10000,
        HPT_T_in_nominal=579.15,
        firstfeedpump_p_nominal=2000000));

    Data.IntermediateTurbineInitialisation init(
      FeedwaterMixVolume_p_start=3000000,
        FeedwaterMixVolume_h_start=2e6,
      InternalBypassValve_dp_start=3500000,
      InternalBypassValve_mflow_start=0.1,
      HPT_p_a_start=3000000,
      HPT_p_b_start=10000,
      HPT_T_a_start=523.15,
      HPT_T_b_start=333.15)
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

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass(R=data.R_bypass,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-24,-2})));

    TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=init.FeedwaterMixVolume_p_start,
      use_T_start=true,
      T_start=421.15,
      h_start=init.FeedwaterMixVolume_h_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_FeedwaterMixVolume),
      nPorts_a=1,
      nPorts_b=3) annotation (Placement(transformation(
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
      nPorts_b=2,
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

    StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve InternalBypassValve(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_start=init.InternalBypassValve_dp_start,
      m_flow_start=init.InternalBypassValve_mflow_start,
      m_flow_small=data.InternalBypassValve_mflow_small,
      p_spring=data.InternalBypassValve_p_spring,
      K=data.InternalBypassValve_K,
      opening_init=0,
      tau=data.InternalBypassValve_tau)
      annotation (Placement(transformation(extent={{-82,10},{-62,30}})));

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
    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_T_start=false,
      h_a_start=port_a_start.h,
      m_flow_start=port_a_start.m_flow,
      m_flow_nominal=port_a_nominal.m_flow,
      use_Stodola=true,
      use_T_nominal=true,
      nUnits=2,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      p_b_start=data.p_condensor,
      p_outlet_nominal=data.p_condensor,
      T_nominal=579.15,
      d_nominal=Medium.density_ph(steamTurbine.p_inlet_nominal, port_a_nominal.h),
      p_a_start=header.p_start - TCV.dp_start,
      p_inlet_nominal=port_a_nominal.p)
      annotation (Placement(transformation(extent={{40,22},{60,42}})));

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
      annotation (Line(points={{-106,41.5},{-60,41.5},{-60,40},{-12,40}},
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
    connect(InternalBypassValve.port_a, header.port_b[2]) annotation (Line(points={{-82,20},
            {-104,20},{-104,40},{-106,40},{-106,42.5}},          color={0,127,255}));
    connect(InternalBypassValve.port_b, R_InternalBypass.port_a)
      annotation (Line(points={{-62,20},{-24,20},{-24,5}}, color={0,127,255}));
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
    connect(FeedwaterMixVolume.port_b[1], R_InternalBypass.port_b)
      annotation (Line(points={{-24,-40.6667},{-24,-9}},
                                                      color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[2], sensor_T4.port_a) annotation (Line(
          points={{-24,-40},{-10,-40},{-10,-42},{32,-42},{32,-144},{70,-144}},
          color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[3], port_a1) annotation (Line(points={{-24,
            -39.3333},{-20,-39.3333},{-20,-108},{-92,-108},{-92,-160}},
                                                              color={0,127,255}));
    connect(R_InternalBypass1.port_b, Condenser.port_a) annotation (Line(points={{
            64,-29},{64,-82},{154,-82},{154,-92},{153,-92}}, color={0,127,255}));
    connect(steamTurbine.portLP, R_InternalBypass1.port_a)
      annotation (Line(points={{60,38},{64,38},{64,-15}}, color={0,127,255}));
    connect(steamTurbine.portHP, sensor_T1.port_b)
      annotation (Line(points={{40,38},{34,38},{34,40},{28,40}},
                                                 color={0,127,255}));
    connect(steamTurbine.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{60,32},{68,32},{68,34},{78,34}},
                                                 color={0,0,0}));
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
  end Intermediate_Rankine_Cycle_TESUC;

  model Intermediate_Rankine_Cycle_3 "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.TESTurbine data);

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
      m_flow_nominal=50,
      p_inlet_nominal=3447400,
      p_outlet_nominal=2400000,
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
      dp_nominal=10000,
      m_flow_nominal=80) annotation (Placement(transformation(
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
      m_flow_nominal=80,
      p_inlet_nominal=2400000,
      p_outlet_nominal=8000,
      T_nominal=523.15) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={44,-6})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5,
      p_start=2400000)
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
          origin={-118,-40})));
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
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
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
      p_start_shell=2200000,
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
      p_start_tube=1000000,
      p_start_shell=2400000,
      Q_init=1e6)
      annotation (Placement(transformation(extent={{-20,-26},{0,-46}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=2300000,
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
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
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
    Modelica.Blocks.Sources.RealExpression level_setpoint(y=reservoir.level_start)
      annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
    Modelica.Blocks.Sources.RealExpression level_measure(y=reservoir.level)
      "noEvent(if time < 10 then reservoir.level_start else reservoir.level)"
      annotation (Placement(transformation(extent={{-154,-30},{-134,-10}})));
    TRANSFORM.Controls.LimPID_Hysteresis PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k_s=1/reservoir.level_start,
      k_m=1/reservoir.level_start,
      k=1e2,
      yMin=0,
      eOn=0.1*reservoir.level_start)
      annotation (Placement(transformation(extent={{-124,-16},{-104,4}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      use_T_in=true,
      T=348.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-84,-38},{-64,-18}})));
    TRANSFORM.Fluid.Volumes.DumpTank reservoir(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      A=10,
      p_start=p_reservoir,
      level_start=10,
      h_start=1e6)
      annotation (Placement(transformation(extent={{-70,-78},{-50,-58}})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             pump2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=3600000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={4,-88})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T3(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-46,-40})));
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
          origin={-141,-63})));
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
      K=50,
      opening_init=0,
      tau=0.0001)
      annotation (Placement(transformation(extent={{-82,10},{-62,30}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T4(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={74,-142})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T5(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={16,-144})));
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
        points={{-30,100},{-96,100},{-96,-56},{-118,-56},{-118,-43.6}},
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
    connect(level_measure.y, PID1.u_m) annotation (Line(points={{-133,-20},{-128,-20},
            {-128,-26},{-114,-26},{-114,-18}}, color={0,0,127}));
    connect(level_setpoint.y, PID1.u_s) annotation (Line(points={{-133,0},{-132,0},
            {-132,-6},{-126,-6}},           color={0,0,127}));
    connect(PID1.y, boundary2.m_flow_in) annotation (Line(points={{-103,-6},{-100,
            -6},{-100,-20},{-84,-20}}, color={0,0,127}));
    connect(boundary2.ports[1], reservoir.port_a) annotation (Line(points={{-64,-28},
            {-60,-28},{-60,-59.6}}, color={0,127,255}));
    connect(pump2.port_b, IP1.Tube_in) annotation (Line(points={{4,-78},{4,-40},{0,
            -40}},           color={0,127,255}));
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
    connect(sensor_T2.port_a, reservoir.port_b) annotation (Line(points={{-108,-40},
            {-104,-40},{-104,-82},{-60,-82},{-60,-76.4}}, color={0,127,255}));
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
    connect(sensor_T3.port_b, reservoir.port_a) annotation (Line(points={{-56,-40},
            {-60,-40},{-60,-59.6}}, color={0,127,255}));
    connect(sensor_T3.port_a, IP1.Tube_out)
      annotation (Line(points={{-36,-40},{-20,-40}}, color={0,127,255}));
    connect(port_a, resistance4.port_a)
      annotation (Line(points={{-160,40},{-139,40}}, color={0,127,255}));
    connect(resistance4.port_b, header.port_a[1])
      annotation (Line(points={{-125,40},{-118,40}}, color={0,127,255}));
    connect(header.port_b[1], TCV.port_a)
      annotation (Line(points={{-106,39.5},{-60,39.5},{-60,40},{-12,40}},
                                                    color={0,127,255}));
    connect(sensor_T3.T, boundary2.T_in) annotation (Line(points={{-46,-36.4},{-46,
            -12},{-92,-12},{-92,-24},{-86,-24}}, color={0,0,127}));
    connect(port_b, pump_SimpleMassFlow1.port_b) annotation (Line(points={{-160,
            -40},{-152,-40},{-152,-63}},       color={0,127,255}));
    connect(sensor_T2.port_b, pump_SimpleMassFlow1.port_a) annotation (Line(
          points={{-128,-40},{-132,-40},{-132,-54},{-126,-54},{-126,-63},{-130,
            -63}},                                   color={0,127,255}));
    connect(actuatorBus.Feed_Pump_Speed, pump_SimpleMassFlow1.in_m_flow)
      annotation (Line(
        points={{30,100},{-176,100},{-176,-80},{-141,-80},{-141,-71.03}},
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
            50,-166},{60,-166},{60,-142},{64,-142}}, color={0,127,255}));
    connect(sensor_T4.port_a, IP.Tube_in) annotation (Line(points={{84,-142},{90,
            -142},{90,-132},{86,-132}}, color={0,127,255}));
    connect(sensor_m_flow2.port_b, sensor_T5.port_b) annotation (Line(points={{41,
            -116},{40,-116},{40,-126},{-4,-126},{-4,-144},{6,-144}}, color={0,127,
            255}));
    connect(sensor_T5.port_a, pump1.port_a) annotation (Line(points={{26,-144},{
            28,-144},{28,-152},{30,-152}}, color={0,127,255}));
    connect(IP.Tube_out, sensor_T6.port_a)
      annotation (Line(points={{66,-132},{52,-132}}, color={0,127,255}));
    connect(sensor_T6.port_b, pump2.port_a) annotation (Line(points={{32,-132},{
            18,-132},{18,-112},{4,-112},{4,-98}}, color={0,127,255}));
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
        StopTime=1000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>A two stage turbine rankine cycle with feedwater heating internal to the system - can be externally bypassed or LPT can be bypassed both will feedwater heat post bypass</p>
</html>"));
  end Intermediate_Rankine_Cycle_3;

  model Intermediate_Rankine_Cycle_2 "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_2 CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.IdealTurbine data);

      parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
      parameter Modelica.Units.SI.Pressure pr3out=200000 annotation(dialog(tab = "Initialization", group = "Pressure"));
      parameter SI.Pressure p_condenser=1e4 "Condenser operating pressure";
      parameter SI.Pressure p_reservoir=port_b_nominal.p "Reservoir operating pressure";

    TRANSFORM.Fluid.Machines.SteamTurbine HPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=1800000,
      T_a_start=852.15,
      T_b_start=573.15,
      m_flow_nominal=200,
      p_inlet_nominal=3447400,
      p_outlet_nominal=2500000,
      T_nominal=563.15)
      annotation (Placement(transformation(extent={{34,24},{54,44}})));
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
      dp_nominal=10000,
      m_flow_nominal=200)
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
      m_flow_nominal=100,
      p_inlet_nominal=2400000,
      p_outlet_nominal=8000,
      T_nominal=473.15) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={46,-6})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5,
      p_start=2400000)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={82,24})));
    TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=10000,
      m_flow_nominal=10)  annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={84,-26})));
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
      p_nominal=1000000,
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
          (V=0.01))
      annotation (Placement(transformation(extent={{58,30},{78,50}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
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
      dp_nominal=100000)
      annotation (Placement(transformation(extent={{-86,6},{-66,26}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance3(R=1,
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
      p_start_shell=2200000,
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
      p_start_tube=1000000,
      p_start_shell=2400000,
      Q_init=1e6)
      annotation (Placement(transformation(extent={{-32,-26},{-12,-46}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=2300000,
      use_T_start=false,
      h_start=3.5e6,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=200),
      nPorts_a=3,
      nPorts_b=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={88,-72})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
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
    Modelica.Fluid.Sources.MassFlowSource_T boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      T=318.9576,
      nPorts=1)
      annotation (Placement(transformation(extent={{-56,-120},{-36,-100}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{6,-7},{-6,7}},
          rotation=180,
          origin={-15,-110})));
    Modelica.Blocks.Sources.RealExpression level_setpoint(y=reservoir.level_start)
      annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
    Modelica.Blocks.Sources.RealExpression level_measure(y=reservoir.level)
      "noEvent(if time < 10 then reservoir.level_start else reservoir.level)"
      annotation (Placement(transformation(extent={{-154,-30},{-134,-10}})));
    TRANSFORM.Controls.LimPID_Hysteresis PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k_s=1/reservoir.level_start,
      k_m=1/reservoir.level_start,
      k=1e2,
      yMin=0,
      eOn=0.1*reservoir.level_start)
      annotation (Placement(transformation(extent={{-122,-18},{-102,2}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      T=298.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-86,-38},{-66,-18}})));
    TRANSFORM.Fluid.Volumes.DumpTank reservoir(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      A=10,
      p_start=p_reservoir,
      level_start=10,
      h_start=1e6)
      annotation (Placement(transformation(extent={{-70,-78},{-50,-58}})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             pump2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=3600000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={4,-88})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      N_nominal=1200,
      dp_nominal=100000,
      m_flow_nominal=200,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{-76,-70},{-96,-90}})));
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
        points={{92,24},{92,0},{84,0},{84,-16}},
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
    connect(valve_BV.port_b, resistance3.port_a) annotation (Line(points={{-66,16},
            {-34,16},{-34,3}},                                  color={0,127,255}));
    connect(resistance3.port_b, IP1.Shell_in) annotation (Line(points={{-34,-11},
            {-34,-22},{-32,-22},{-32,-34}},                color={0,127,255}));
    connect(IP1.Shell_out, volume.port_a[1]) annotation (Line(points={{-12,-34},{
            70,-34},{70,-60},{84,-60},{84,-62},{87.3333,-62},{87.3333,-66}},
                                           color={0,127,255}));
    connect(LPT_Bypass.port_b, volume.port_a[2]) annotation (Line(points={{84,-36},
            {84,-66},{88,-66}},                         color={0,127,255}));
    connect(pump1.port_b, IP.Tube_in) annotation (Line(points={{40,-140},{40,-144},
            {88,-144},{88,-140},{90,-140},{90,-132},{86,-132}},
                                 color={0,127,255}));
    connect(Moisture_Separator.port_Liquid, volume.port_a[3]) annotation (Line(
          points={{64,36},{64,-14},{72,-14},{72,-58},{88.6667,-58},{88.6667,-66}},
                                                                color={0,127,255}));

    connect(sensor_m_flow1.port_b, Condenser.port_a) annotation (Line(points={{47,
            -68},{46,-68},{46,-74},{47,-74},{47,-78}}, color={0,127,255}));
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
    connect(volume.port_b[1], IP.Shell_in) annotation (Line(points={{88,-78},{88,
            -90},{58,-90},{58,-126},{66,-126}}, color={0,127,255}));
    connect(resistance1.port_a, sensor_m_flow1.port_a) annotation (Line(points={{
            90,-103},{74,-103},{74,-52},{47,-52},{47,-56}}, color={0,127,255}));
    connect(IP.Shell_out, resistance1.port_b) annotation (Line(points={{86,-126},
            {90,-126},{90,-117}}, color={0,127,255}));
    connect(boundary1.m_flow_in, actuatorBus.CondensorFlow) annotation (Line(
        points={{-56,-102},{-56,-100},{-72,-100},{-72,-142},{116,-142},{116,100},
            {30,100}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(boundary1.ports[1], sensor_m_flow3.port_a)
      annotation (Line(points={{-36,-110},{-21,-110}}, color={0,127,255}));
    connect(sensor_m_flow3.port_b, sensor_m_flow2.port_a) annotation (Line(points=
           {{-9,-110},{8,-110},{8,-102},{40,-102},{40,-100},{41,-100},{41,-104}},
          color={0,127,255}));
    connect(level_measure.y, PID1.u_m) annotation (Line(points={{-133,-20},{-128,-20},
            {-128,-26},{-112,-26},{-112,-20}}, color={0,0,127}));
    connect(level_setpoint.y, PID1.u_s) annotation (Line(points={{-133,0},{-132,0},
            {-132,-6},{-124,-6},{-124,-8}}, color={0,0,127}));
    connect(PID1.y, boundary2.m_flow_in) annotation (Line(points={{-101,-8},{-100,
            -8},{-100,-20},{-86,-20}}, color={0,0,127}));
    connect(boundary2.ports[1], reservoir.port_a) annotation (Line(points={{-66,-28},
            {-60,-28},{-60,-59.6}}, color={0,127,255}));
    connect(IP.Tube_out, pump2.port_a) annotation (Line(points={{66,-132},{36,-132},
            {36,-122},{4,-122},{4,-98}}, color={0,127,255}));
    connect(pump2.port_b, IP1.Tube_in) annotation (Line(points={{4,-78},{2,-78},{2,
            -40},{-12,-40}}, color={0,127,255}));
    connect(IP1.Tube_out, reservoir.port_a) annotation (Line(points={{-32,-40},{-60,
            -40},{-60,-59.6}}, color={0,127,255}));
    connect(actuatorBus.opening_BV, valve_BV.opening) annotation (Line(
        points={{30.1,100.1},{-16,100.1},{-16,102},{-76,102},{-76,24}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
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
    connect(pump.port_a, reservoir.port_b) annotation (Line(points={{-76,-80},{
            -76,-94},{-60,-94},{-60,-76.4}}, color={0,127,255}));
    connect(sensor_T2.port_a, pump.port_b) annotation (Line(points={{-108,-40},{
            -104,-40},{-104,-82},{-96,-82},{-96,-80}}, color={0,127,255}));
    connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
        points={{30,100},{74,100},{74,102},{116,102},{116,-142},{-86,-142},{-86,
            -87}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
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
        StopTime=1000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>A two stage turbine rankine cycle with feedwater heating internal to the system - can be externally bypassed or LPT can be bypassed both will feedwater heat post bypass</p>
</html>"));
  end Intermediate_Rankine_Cycle_2;

  model Intermediate_Rankine_Cycle_Basic "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable ControlSystems.ObsoleteCS.CS_IntermediateControl CS,
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
      p_outlet_nominal=2500000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{34,24},{54,44}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{34,-34},{14,-14}})));
    Fluid.Vessels.IdealCondenser Condenser(
      p=10000,
      V_total=75,
      V_liquid_start=1.2)
      annotation (Placement(transformation(extent={{56,-58},{36,-38}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      N_nominal=1200,
      dp_nominal=15000000,
      m_flow_nominal=50,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{-24,-30},{-44,-50}})));
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
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=5500000,
      T_start=473.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-4,-40})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={76,26})));
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
          origin={-70,-40})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             pump1(redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=5500000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{40,-74},{20,-54}})));
    StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
      Moisture_Separator(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
      annotation (Placement(transformation(extent={{56,30},{76,50}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{6,-7},{-6,7}},
          rotation=90,
          origin={61,-24})));
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
        points={{30,100},{116,100},{116,-82},{-34,-82},{-34,-47}},
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
    connect(volume1.port_b, pump.port_a) annotation (Line(points={{-10,-40},{-24,-40}},
                                      color={0,127,255},
        thickness=0.5));
    connect(LPT.portHP, tee.port_1) annotation (Line(
        points={{52,4},{52,8},{76,8},{76,16}},
        color={0,127,255},
        thickness=0.5));
    connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
        points={{86,26},{86,-24}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT_Bypass.port_b, volume1.port_a) annotation (Line(
        points={{86,-44},{86,-72},{16,-72},{16,-40},{2,-40}},
        color={0,127,255},
        thickness=0.5));
    connect(sensor_T2.port_a, pump.port_b)
      annotation (Line(points={{-60,-40},{-44,-40}},color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-118,100},{-118,-62},{-70,-62},{-70,-43.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{46,-58},{46,
            -64},{40,-64}},                                           color={0,127,
            255},
        thickness=0.5));
    connect(pump1.port_b, volume1.port_a) annotation (Line(points={{20,-64},{16,
            -64},{16,-40},{2,-40}},                    color={0,127,255},
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
        points={{54,40},{60,40}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
        points={{72,40},{76,40},{76,36}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_Liquid, volume1.port_a) annotation (Line(
        points={{62,36},{62,18},{16,18},{16,-40},{2,-40}},
        color={0,127,255},
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
      annotation (Line(points={{-80,-40},{-160,-40}}, color={0,127,255}));
    connect(sensor_p.port, TCV.port_a)
      annotation (Line(points={{-18,66},{-18,40},{-12,40}}, color={0,127,255}));
    connect(port_a, TCV.port_a)
      annotation (Line(points={{-160,40},{-12,40}}, color={0,127,255}));
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
  end Intermediate_Rankine_Cycle_Basic;

  model Intermediate_Rankine_Cycle_Control "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable ControlSystems.ObsoleteCS.CS_IntermediateControl CS,
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
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
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

  model Intermediate_Rankine_Cycle "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_2 CS,
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
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=5000000,
      p_outlet_nominal=2500000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{34,24},{54,44}})));
    Fluid.Vessels.IdealCondenser Condenser(
      p=10000,
      V_total=75,
      V_liquid_start=1.2)
      annotation (Placement(transformation(extent={{50,-98},{30,-78}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      N_nominal=1200,
      dp_nominal=4000000,
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
      p_nominal=5500000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={40,-130})));
    StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
      Moisture_Separator(redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      p_start=4000000,
      T_start=773.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5))
      annotation (Placement(transformation(extent={{58,30},{78,50}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
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
      p_nominal=2500000,
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
      NTU=20,
      K_tube=17000,
      K_shell=500,
      V_Tube=5,
      V_Shell=5,
      p_start_tube=2000000,
      p_start_shell=200000,
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
      p_start=3000000,
      use_T_start=false,
      h_start=3.5e6,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=80),
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
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
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
  end Intermediate_Rankine_Cycle;

  model SteamTurbine_OpenFeedHeat_DirectCoupling "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable Data.TESTurbine data(
        p_condensor=8000,
        V_FeedwaterMixVolume=25,
        V_Header=10,
        valve_TCV_mflow=67,
        valve_TCV_dp_nominal=100000,
        valve_SHS_mflow=30,
        valve_SHS_dp_nominal=600000,
        valve_TCV_LPT_mflow=30,
        valve_TCV_LPT_dp_nominal=10000,
        InternalBypassValve_mflow_small=0,
        InternalBypassValve_p_spring=15000000,
        InternalBypassValve_K=40,
        HPT_p_exit_nominal=700000,
        HPT_T_in_nominal=579.15,
        HPT_nominal_mflow=67,
        HPT_efficiency=1,
        LPT_p_in_nominal=700000,
        LPT_p_exit_nominal=7000,
        LPT_T_in_nominal=523.15,
        LPT_nominal_mflow=20,
        LPT_efficiency=1,
        firstfeedpump_p_nominal=2500000,
        secondfeedpump_p_nominal=2000000));

    replaceable Data.IntermediateTurbineInitialisation init(
      FeedwaterMixVolume_p_start=3000000,
        FeedwaterMixVolume_h_start=2e6,
      InternalBypassValve_dp_start=3500000,
      InternalBypassValve_mflow_start=0.1,
      HPT_p_a_start=3000000,
      HPT_p_b_start=10000,
      HPT_T_a_start=523.15,
      HPT_T_b_start=333.15)
    annotation (Placement(transformation(extent={{68,120},{88,140}})));

    Fluid.Vessels.IdealCondenser Condenser(
      p= data.p_condensor,
      V_total=data.V_condensor,
      V_liquid_start=init.condensor_V_liquid_start)
      annotation (Placement(transformation(extent={{156,-112},{136,-92}})));

    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)                                    annotation (Placement(
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
          origin={40,-128})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass(R=data.R_bypass,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-24,-2})));

    TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=init.FeedwaterMixVolume_p_start,
      use_T_start=true,
      T_start=421.15,
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
          origin={84,-92})));

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
      nPorts_b=2,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-122,32},{-102,52}})));

    TRANSFORM.Fluid.Machines.Pump                pump_SimpleMassFlow1(
      N_nominal=1500,
      dp_nominal=CS.data.p_steam,
      m_flow_nominal=data.controlledfeedpump_mflow_nominal,
      redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_port=true)                                       annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-109,-41})));

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=data.p_boundary,
      T=data.T_boundary,
      nPorts=1)
      annotation (Placement(transformation(extent={{-168,64},{-148,84}})));

    TRANSFORM.Fluid.Valves.ValveLinear PRV(
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
          origin={0,-128})));

    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{52,-66},{72,-86}})));

    TRANSFORM.Fluid.Valves.ValveLinear InternalBypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1000000,
      m_flow_nominal=15) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-74,22})));
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
      p_inlet_nominal=data.p_in_nominal,
      p_outlet_nominal=data.HPT_p_exit_nominal,
      T_nominal=data.HPT_T_in_nominal)
      annotation (Placement(transformation(extent={{32,24},{52,44}})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      V=data.V_tee,
      p_start=init.tee_p_start)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={90,4})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      eta_mech=data.LPT_efficiency,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant
          ( eta_nominal=0.9),
      p_a_start=init.LPT_p_a_start,
      p_b_start=init.LPT_p_b_start,
      T_a_start=init.LPT_T_a_start,
      T_b_start=init.LPT_T_b_start,
      m_flow_nominal=data.LPT_nominal_mflow,
      p_inlet_nominal=data.LPT_p_in_nominal,
      p_outlet_nominal=data.LPT_p_exit_nominal,
      T_nominal=data.LPT_T_in_nominal) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={46,-40})));
    TRANSFORM.Fluid.Valves.ValveLinear SHS_charge_control(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=data.valve_SHS_dp_nominal,
      m_flow_nominal=data.valve_SHS_mflow) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-50,40})));
    TRANSFORM.Fluid.Valves.ValveLinear Discharge_OnOff(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=100000000,
      m_flow_nominal=20) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={126,-146})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-136,-42})));
    Modelica.Blocks.Sources.Constant const(k=1)
      annotation (Placement(transformation(extent={{50,-156},{70,-136}})));
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

    connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{84,-102},
            {84,-106},{104,-106},{104,-48},{110,-48}},
                                                     color={255,0,0}));
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
    connect(boundary.ports[1],PRV. port_b)
      annotation (Line(points={{-148,74},{-136,74}}, color={0,127,255}));
    connect(actuatorBus.TBV,PRV. opening) annotation (Line(
        points={{30,100},{-128,100},{-128,80.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(firstfeedpump.port_b, sensor_T4.port_b) annotation (Line(points={{30,-128},
            {10,-128}},                              color={0,127,255}));
    connect(pump_SimpleMassFlow1.port_a, sensor_T2.port_b) annotation (Line(
          points={{-98,-41},{-98,-42},{-82,-42}},                      color={0,
            127,255}));
    connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
            -112},{146,-128},{50,-128}},          color={0,127,255}));
    connect(powerSensor.flange_b, generator1.shaft_a) annotation (Line(points={{72,-76},
            {84,-76},{84,-82}},                      color={0,0,0}));
    connect(sensor_T2.port_a, FeedwaterMixVolume.port_a[1]) annotation (Line(
          points={{-62,-42},{-42,-42},{-42,-40},{-36,-40}}, color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[1], R_InternalBypass.port_b)
      annotation (Line(points={{-24,-40.5},{-24,-9}}, color={0,127,255}));
    connect(FeedwaterMixVolume.port_b[2], sensor_T4.port_a) annotation (Line(
          points={{-24,-39.5},{-20,-39.5},{-20,-128},{-10,-128}},
          color={0,127,255}));
    connect(InternalBypass.port_a, header.port_b[1]) annotation (Line(points={{-82,22},
            {-94,22},{-94,24},{-106,24},{-106,41.5}},         color={0,127,255}));
    connect(InternalBypass.port_b, R_InternalBypass.port_a) annotation (Line(
          points={{-66,22},{-44,22},{-44,20},{-24,20},{-24,5}}, color={0,127,255}));
    connect(actuatorBus.Divert_Valve_Position, InternalBypass.opening)
      annotation (Line(
        points={{30,100},{-74,100},{-74,28.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(HPT.shaft_b,LPT. shaft_a) annotation (Line(
        points={{52,34},{56,34},{56,-24},{46,-24},{46,-30}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(LPT.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{46,-50},{46,-76},{52,-76}}, color={0,0,0}));
    connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{52,-50},{52,-58},
            {38,-58},{38,-112},{118,-112},{118,-84},{153,-84},{153,-92}}, color={0,
            127,255}));
    connect(sensor_T1.port_b, HPT.portHP) annotation (Line(points={{28,40},{32,40}},
                            color={0,127,255}));
    connect(HPT.portLP, tee.port_2) annotation (Line(points={{52,40},{72,40},{72,
            36},{90,36},{90,14}}, color={0,127,255}));
    connect(LPT.portHP, tee.port_1) annotation (Line(points={{52,-30},{66,-30},{
            66,-28},{90,-28},{90,-6}}, color={0,127,255}));
    connect(actuatorBus.SHS_throttle, SHS_charge_control.opening) annotation (
        Line(
        points={{30,100},{-54,100},{-54,46},{-50,46},{-50,46.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Feed_Pump_Speed, pump_SimpleMassFlow1.inputSignal)
      annotation (Line(
        points={{30,100},{-92,100},{-92,-56},{-109,-56},{-109,-48.7}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(port_b, sensor_m_flow.port_b) annotation (Line(points={{-160,-40},{
            -154,-40},{-154,-42},{-146,-42}}, color={0,127,255}));
    connect(pump_SimpleMassFlow1.port_b, sensor_m_flow.port_a) annotation (Line(
          points={{-120,-41},{-124,-41},{-124,-42},{-126,-42}}, color={0,127,255}));
    connect(sensorBus.Condensor_Output_mflow, sensor_m_flow.m_flow) annotation (
        Line(
        points={{-30,100},{-108,100},{-108,98},{-180,98},{-180,-68},{-136,-68},{
            -136,-45.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const.y, Discharge_OnOff.opening) annotation (Line(points={{71,-146},
            {76,-146},{76,-132},{126,-132},{126,-139.6}}, color={0,0,127}));
    connect(Discharge_OnOff.port_a, firstfeedpump.port_a) annotation (Line(points=
           {{118,-146},{114,-146},{114,-128},{50,-128}}, color={0,127,255}));
    connect(Discharge_OnOff.port_b, tee.port_3)
      annotation (Line(points={{134,-146},{134,4},{100,4}}, color={0,127,255}));
    connect(SHS_charge_control.port_b, TCV.port_a)
      annotation (Line(points={{-42,40},{-12,40}}, color={0,127,255}));
    connect(PRV.port_a, SHS_charge_control.port_a) annotation (Line(points={{
            -120,74},{-64,74},{-64,40},{-58,40}}, color={0,127,255}));
    connect(header.port_b[2], SHS_charge_control.port_a) annotation (Line(
          points={{-106,42.5},{-106,24},{-94,24},{-94,40},{-86,40},{-86,74},{
            -64,74},{-64,40},{-58,40}}, color={0,127,255}));
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
  end SteamTurbine_OpenFeedHeat_DirectCoupling;

  model SteamTurbine_L3_ClosedFeedHeat_HTGR "Two stage BOP model"
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
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=init.FeedwaterMixVolume_p_start,
      use_T_start=false,
      h_start=init.FeedwaterMixVolume_h_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_FeedwaterMixVolume),
      nPorts_a=1,
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

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_feedwater(R=1,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={90,-110})));

    TRANSFORM.Fluid.Machines.Pump_PressureBooster SecondFeedwaterPump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=data.secondfeedpump_p_nominal,
      allowFlowReversal=false) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-26,-78})));

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
      annotation (Line(points={{82,-36},{82,-44},{72,-44},{72,-58},{34,-58},{34,
            -88}},                                          color={0,127,255}));

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
          points={{60,-126},{90,-126},{90,-117}}, color={0,127,255}));
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
    connect(sensor_T6.port_b, SecondFeedwaterPump.port_a)
      annotation (Line(points={{10,-132},{-26,-132},{-26,-88}},
                                                            color={0,127,255}));
    connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
            -112},{146,-144},{118,-144}},         color={0,127,255}));
    connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{50,-16},{60,
            -16},{60,-64},{154,-64},{154,-86},{153,-86},{153,-92}},
                                                           color={0,127,255}));
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
    connect(SecondFeedwaterPump.port_b, sensor_T2.port_a) annotation (Line(points={{-26,-68},
            {-26,-40},{-48,-40}},                 color={0,127,255}));
    connect(R_feedwater.port_a, Condenser.port_a) annotation (Line(points={{90,
            -103},{90,-76},{153,-76},{153,-92}}, color={0,127,255}));
    connect(Moisture_Separator.port_Liquid, firstfeedpump.port_b) annotation (
        Line(points={{64,36},{66,36},{66,-130},{98,-130},{98,-144}}, color={0,127,
            255}));
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
  end SteamTurbine_L3_ClosedFeedHeat_HTGR;

  model SteamTurbine_L2_ClosedFeedHeat_HTGR_Old "Two stage BOP model"
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

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass(R=1,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-24,-2})));

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
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase BypassFeedwaterHeater(
      NTU=data.BypassFeedHeater_NTU,
      K_tube=data.BypassFeedHeater_K_tube,
      K_shell=data.BypassFeedHeater_K_shell,
      redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
      redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
      V_Tube=data.BypassFeedHeater_V_tube,
      V_Shell=data.BypassFeedHeater_V_shell,
      p_start_tube=init.BypassFeedHeater_p_start_tube,
      h_start_tube_inlet=init.BypassFeedHeater_h_start_tube_inlet,
      h_start_tube_outlet=init.BypassFeedHeater_h_start_tube_outlet,
      p_start_shell=init.BypassFeedHeater_p_start_shell,
      h_start_shell_inlet=init.BypassFeedHeater_h_start_shell_inlet,
      h_start_shell_outlet=init.BypassFeedHeater_h_start_shell_outlet,
      dp_init_tube=init.BypassFeedHeater_dp_init_tube,
      dp_init_shell=init.BypassFeedHeater_dp_init_shell,
      Q_init=init.BypassFeedHeater_Q_init,
      m_start_tube=init.BypassFeedHeater_m_start_tube,
      m_start_shell=init.BypassFeedHeater_m_start_shell)
      annotation (Placement(transformation(extent={{-20,-26},{0,-46}})));

    TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=init.FeedwaterMixVolume_p_start,
      use_T_start=false,
      h_start=init.FeedwaterMixVolume_h_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_FeedwaterMixVolume),
      nPorts_a=3,
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
          origin={90,-110})));

    TRANSFORM.Fluid.Machines.Pump_PressureBooster SecondFeedwaterPump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=data.secondfeedpump_p_nominal,
      allowFlowReversal=false) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={6,-76})));

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
      nPorts_b=2,
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
    TRANSFORM.Fluid.Valves.ValveLinear TBV1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=14000000,
      m_flow_nominal=5)                    annotation (Placement(transformation(
          extent={{11,11},{-11,-11}},
          rotation=180,
          origin={-73,-7})));
    Modelica.Blocks.Sources.Constant const(k=1)
      annotation (Placement(transformation(extent={{-120,2},{-100,22}})));
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
    connect(R_InternalBypass.port_b, BypassFeedwaterHeater.Shell_in) annotation (
        Line(points={{-24,-9},{-24,-34},{-20,-34}}, color={0,127,255}));
    connect(BypassFeedwaterHeater.Shell_out, FeedwaterMixVolume.port_a[1])
      annotation (Line(points={{0,-34},{30,-34},{30,-80},{33.3333,-80},{33.3333,
            -88}},                   color={0,127,255}));
    connect(LPT_Bypass.port_b, FeedwaterMixVolume.port_a[2])
      annotation (Line(points={{82,-36},{82,-44},{72,-44},{72,-58},{34,-58},{34,
            -88}},                                          color={0,127,255}));
    connect(Moisture_Separator.port_Liquid, FeedwaterMixVolume.port_a[3])
      annotation (Line(points={{64,36},{64,-44},{72,-44},{72,-58},{34.6667,-58},{
            34.6667,-88}},
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
          points={{60,-126},{90,-126},{90,-117}}, color={0,127,255}));
    connect(SecondFeedwaterPump.port_b, BypassFeedwaterHeater.Tube_in)
      annotation (Line(points={{6,-66},{6,-40},{0,-40}}, color={0,127,255}));
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
      annotation (Line(points={{-106,39.5},{-60,39.5},{-60,40},{-12,40}},
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
    connect(sensor_T6.port_b, SecondFeedwaterPump.port_a)
      annotation (Line(points={{10,-132},{4,-132},{4,-90},{6,-90},{6,-86}},
                                                            color={0,127,255}));
    connect(sensor_T2.port_a, BypassFeedwaterHeater.Tube_out)
      annotation (Line(points={{-48,-40},{-20,-40}}, color={0,127,255}));
    connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
            -112},{146,-144},{118,-144}},         color={0,127,255}));
    connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{50,-16},{60,
            -16},{60,-64},{154,-64},{154,-86},{153,-86},{153,-92}},
                                                           color={0,127,255}));
    connect(R_feedwater.port_a, Condenser.port_a) annotation (Line(points={{90,-103},
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
    connect(header.port_b[2], TBV1.port_a) annotation (Line(points={{-106,40.5},{
            -90,40.5},{-90,-7},{-84,-7}}, color={0,127,255}));
    connect(TBV1.port_b, R_InternalBypass.port_a) annotation (Line(points={{-62,
            -7},{-38,-7},{-38,12},{-24,12},{-24,5}}, color={0,127,255}));
    connect(const.y, TBV1.opening)
      annotation (Line(points={{-99,12},{-73,12},{-73,1.8}}, color={0,0,127}));
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
  end SteamTurbine_L2_ClosedFeedHeat_HTGR_Old;
end ObsoleteRankines;
