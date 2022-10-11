within NHES.Systems.BalanceOfPlant.Turbine;
package HTGR_RankineCycles
  model SteamTurbine_L2_ClosedFeedHeat_HTGR "Two stage BOP model"
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
      Q_units_start={1e7},
      eta_mech=data.LPT_efficiency,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=init.LPT_p_a_start,
      p_b_start=init.LPT_p_b_start,
      T_a_start=init.LPT_T_a_start,
      T_b_start=init.LPT_T_b_start,
      partialArc_nominal=2,
      m_flow_nominal=data.LPT_nominal_mflow,
      use_Stodola=true,
      p_inlet_nominal= data.LPT_p_in_nominal,
      p_outlet_nominal=data.LPT_p_exit_nominal,
      T_nominal=data.LPT_T_in_nominal) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={42,-6})));

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
          origin={-134,-40})));

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
          origin={34,-94})));

    Electrical.Generator      generator1(J=data.generator_MoI)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={10,-38})));

    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{110,-58},{130,-38}})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_feedwater(R=data.R_feedwater,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={114,-112})));

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
      dp_nominal=10500000,
      m_flow_nominal=25,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)                                       annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-85,-41})));
    TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume1(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=init.FeedwaterMixVolume_p_start,
      use_T_start=false,
      h_start=init.FeedwaterMixVolume_h_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_FeedwaterMixVolume),
      nPorts_a=1,
      nPorts_b=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={86,-112})));
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
        points={{48,4},{48,8},{82,8},{82,14}},
        color={0,127,255},
        thickness=0.5));
    connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
        points={{92,24},{92,0},{82,0},{82,-16}},
        color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-30,-60},{-134,-60},{-134,-43.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
        points={{52,32},{52,14},{42,14},{42,4}},
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
      annotation (Line(points={{82,-36},{82,-44},{72,-44},{72,-58},{33.75,-58},
            {33.75,-88}},                                   color={0,127,255}));
    connect(Moisture_Separator.port_Liquid, FeedwaterMixVolume.port_a[2])
      annotation (Line(points={{64,36},{64,-44},{72,-44},{72,-58},{34.25,-58},{
            34.25,-88}},
                   color={0,127,255}));

    connect(LPT.shaft_b, generator1.shaft_a)
      annotation (Line(points={{42,-16},{42,-22},{10,-22},{10,-28}},
                                                   color={0,0,0}));
    connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{10,-48},
            {10,-52},{104,-52},{104,-48},{110,-48}}, color={255,0,0}));
    connect(sensorW.port_b, portElec_b) annotation (Line(points={{130,-48},{146,
            -48},{146,0},{160,0}},                     color={255,0,0}));
    connect(FeedwaterMixVolume.port_b[1], MainFeedwaterHeater.Shell_in)
      annotation (Line(points={{34,-100},{34,-126},{40,-126}},
          color={0,127,255}));
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
    connect(Condenser.port_b, firstfeedpump.port_a) annotation (Line(points={{146,
            -112},{146,-144},{118,-144}},         color={0,127,255}));
    connect(actuatorBus.Feed_Pump_Speed,pump_SimpleMassFlow2. inputSignal)
      annotation (Line(
        points={{30,100},{-56,100},{-56,-26},{-100,-26},{-100,-56},{-85,-56},{
            -85,-48.7}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(MainFeedwaterHeater.Shell_out, FeedwaterMixVolume1.port_a[1])
      annotation (Line(points={{60,-126},{72,-126},{72,-112},{80,-112}}, color=
            {0,127,255}));
    connect(FeedwaterMixVolume1.port_b[1], R_feedwater.port_a)
      annotation (Line(points={{92,-112},{107,-112}}, color={0,127,255}));
    connect(R_feedwater.port_b, Condenser.port_a) annotation (Line(points={{121,
            -112},{130,-112},{130,-84},{152,-84},{152,-88},{153,-88},{153,-92}},
          color={0,127,255}));
    connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{48,-16},{52,
            -16},{52,-74},{153,-74},{153,-92}}, color={0,127,255}));
    connect(port_b, sensor_T2.port_b)
      annotation (Line(points={{-160,-40},{-144,-40}}, color={0,127,255}));
    connect(sensor_T2.port_a, pump_SimpleMassFlow2.port_b) annotation (Line(
          points={{-124,-40},{-110,-40},{-110,-41},{-96,-41}}, color={0,127,255}));
    connect(pump_SimpleMassFlow2.port_a, sensor_T6.port_b) annotation (Line(
          points={{-74,-41},{-6,-41},{-6,-132},{10,-132}}, color={0,127,255}));
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
  end SteamTurbine_L2_ClosedFeedHeat_HTGR;

  model HTGR_Rankine_Cycle_Transient
    extends BaseClasses.Partial_SubSystem(
      redeclare replaceable ControlSystems.CS_Rankine_Xe100_Based_Secondary CS,
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
      V_total=2500,
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
          origin={-62,40})));

    TRANSFORM.Fluid.Valves.ValveLinear TCV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
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
          origin={-4,-40})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5,
      p_start=2500000,
      T_start=573.15)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={76,26})));
    TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=5)   annotation (Placement(transformation(
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
          Modelica.Media.Water.StandardWater,
      p_start=2500000,
      T_start=573.15,                         redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
      annotation (Placement(transformation(extent={{56,30},{76,50}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{6,-7},{-6,7}},
          rotation=90,
          origin={53,-26})));
    TRANSFORM.Fluid.Valves.ValveLinear TBV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=180,
          origin={-74,72})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=12000000,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-116,62},{-96,82}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium
        = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium
        = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
    TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_e
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
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
    connect(pump1.port_b, volume1.port_a) annotation (Line(points={{20,-64},{16,-64},
            {16,-40},{2,-40}},                         color={0,127,255},
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
        points={{52,-16},{52,-20},{53,-20}},
        color={0,127,255},
        thickness=0.5));
    connect(sensor_m_flow1.port_b,Condenser. port_a)
      annotation (Line(points={{53,-32},{53,-38}},     color={0,127,255},
        thickness=0.5));

    connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-82,72},{-96,
            72}},                                      color={0,127,255}));
    connect(LPT.shaft_b, generator.shaft) annotation (Line(points={{46,-16},{46,-24.1},
            {34.1,-24.1}}, color={0,0,0}));
    connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
        points={{30.1,100.1},{-4,100.1},{-4,46.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume.port_b, TBV.port_a) annotation (Line(points={{-56,40},{-46,40},
            {-46,72},{-66,72}}, color={0,127,255}));
    connect(volume.port_b, TCV.port_a)
      annotation (Line(points={{-56,40},{-12,40}}, color={0,127,255}));
    connect(volume.port_b, sensor_p.port) annotation (Line(points={{-56,40},{-34,40},
            {-34,62},{-18,62},{-18,66}}, color={0,127,255}));
    connect(port_a, volume.port_a)
      annotation (Line(points={{-100,40},{-68,40}}, color={0,127,255}));
    connect(sensor_T2.port_b, port_b)
      annotation (Line(points={{-80,-40},{-100,-40}}, color={0,127,255}));
    connect(TBV.opening, actuatorBus.TBV) annotation (Line(points={{-74,78.4},{-74,
            100},{30,100}},       color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(LPT_Bypass.port_b, pump1.port_a)
      annotation (Line(points={{86,-44},{86,-64},{40,-64}}, color={0,127,255}));
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
  end HTGR_Rankine_Cycle_Transient;

  model SteamTurbine_Basic_DirectCoupling_HTGR "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable Data.TESTurbine data(
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
        LPT_nominal_mflow=26.83,
        LPT_efficiency=1,
        firstfeedpump_p_nominal=2000000,
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

    Electrical.Generator      generator1(J=data.generator_MoI)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={84,-92})));

    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{110,-58},{130,-38}})));

    Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
      annotation (Placement(transformation(extent={{52,-66},{72,-86}})));

    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      Q_units_start={2e7},
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
    TRANSFORM.Fluid.Valves.ValveLinear Discharge_OnOff(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=100000,
      m_flow_nominal=100)
                         annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={126,-146})));
    TRANSFORM.Fluid.Machines.Pump_Controlled firstfeedpump1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_a_start=10000,
      p_b_start=1100000,
      N_nominal=1500,
      dp_nominal=5000000,
      m_flow_nominal=30,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={94,-142})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                         annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-124,60})));
  initial equation

  equation

    connect(generator1.portElec, sensorW.port_a) annotation (Line(points={{84,-102},
            {84,-106},{104,-106},{104,-48},{110,-48}},
                                                     color={255,0,0}));
    connect(sensorW.port_b, portElec_b) annotation (Line(points={{130,-48},{146,
            -48},{146,0},{160,0}},                     color={255,0,0}));
    connect(sensorBus.Power, sensorW.W) annotation (Line(
        points={{-30,100},{120,100},{120,-37}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(powerSensor.flange_b, generator1.shaft_a) annotation (Line(points={{72,-76},
            {84,-76},{84,-82}},                      color={0,0,0}));
    connect(LPT.shaft_b, powerSensor.flange_a)
      annotation (Line(points={{46,-50},{46,-76},{52,-76}}, color={0,0,0}));
    connect(LPT.portLP, Condenser.port_a) annotation (Line(points={{52,-50},{52,-58},
            {38,-58},{38,-112},{118,-112},{118,-84},{153,-84},{153,-92}}, color={0,
            127,255}));
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
    connect(TCV_LPT.port_b, sensor_T3.port_b)
      annotation (Line(points={{112,72},{124,72}}, color={0,127,255}));
    connect(actuatorBus.Discharge_OnOff_Throttle, Discharge_OnOff.opening)
      annotation (Line(
        points={{30,100},{186,100},{186,-132},{126,-132},{126,-139.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(firstfeedpump1.port_a, Condenser.port_b) annotation (Line(points={{84,-142},
            {78,-142},{78,-128},{146,-128},{146,-112}},       color={0,127,255}));
    connect(firstfeedpump1.port_b, Discharge_OnOff.port_a) annotation (Line(
          points={{104,-142},{112,-142},{112,-146},{118,-146}}, color={0,127,255}));
    connect(TCV_LPT.port_a, LPT.portHP)
      annotation (Line(points={{96,72},{52,72},{52,-30}}, color={0,127,255}));
    connect(Discharge_OnOff.port_b, port_b) annotation (Line(points={{134,-146},{
            144,-146},{144,-160},{-144,-160},{-144,-40},{-160,-40}}, color={0,127,
            255}));
    connect(actuatorBus.Feed_Pump_Speed, firstfeedpump1.inputSignal) annotation (
        Line(
        points={{30,100},{112,100},{112,102},{206,102},{206,-138},{114,-138},{114,
            -132},{94,-132},{94,-135}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.Steam_Pressure,sensor_p. p) annotation (Line(
        points={{-30,100},{-30,60},{-130,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(port_a, sensor_p.port) annotation (Line(points={{-160,40},{-124,40},{
            -124,50}}, color={0,127,255}));
    connect(sensor_p.port, sensor_T3.port_a) annotation (Line(points={{-124,50},{
            -124,40},{150,40},{150,72},{144,72}}, color={0,127,255}));
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
  end SteamTurbine_Basic_DirectCoupling_HTGR;

  model SteamTurbine_OpenFeedHeat_DivertPowerControl_PowerBoostLoop_HTGR
    "Two stage BOP model"
    extends BaseClasses.Partial_SubSystem_C(
      redeclare replaceable
        ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable Data.TESTurbine data(
        p_condensor=7000,
        V_FeedwaterMixVolume=25,
        V_Header=10,
        valve_TCV_mflow=67,
        valve_TCV_dp_nominal=100000,
        valve_SHS_mflow=30,
        valve_SHS_dp_nominal=1200000,
        valve_TCV_LPT_mflow=30,
        valve_TCV_LPT_dp_nominal=10000,
        InternalBypassValve_mflow_small=0,
        InternalBypassValve_p_spring=15000000,
        InternalBypassValve_K=40,
        HPT_efficiency=1,
        LPT_efficiency=1,
        firstfeedpump_p_nominal=2000000,
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

    TRANSFORM.Fluid.Machines.Pump                pump_SimpleMassFlow1(
      p_a_start=5500000,
      p_b_start=25000000,
      use_T_start=false,
      T_start=481.15,
      h_start=1e6,
      m_flow_start=50,
      N_nominal=1500,
      dp_nominal=8500000,
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
      Q_units_start={2e7},
      eta_mech=data.HPT_efficiency,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant
          ( eta_nominal=0.9),
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
      p_start=init.tee_p_start,
      T_start=523.15)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={90,4})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
      Q_units_start={2e7},
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
      m_flow_start=100,
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
      dp_nominal=400000,
      m_flow_nominal=26) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={126,-146})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             firstfeedpump1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=1400000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={94,-148})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-136,-42})));
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
  end SteamTurbine_OpenFeedHeat_DivertPowerControl_PowerBoostLoop_HTGR;

  model SteamTurbine_OpenFeedHeat_DivertPowerControl_HTGR "Two stage BOP model"
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

    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-102,-170},{-82,-150}}),
          iconTransformation(extent={{-74,-106},{-54,-86}})));

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
          origin={-62,-102})));
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
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_entry1(R=10,
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-92,-128})));
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
    connect(SHS_charge_control.port_b, FeedwaterMixVolume.port_b[3]) annotation (
        Line(points={{-54,-102},{-20,-102},{-20,-39.3333},{-24,-39.3333}}, color=
            {0,127,255}));
    connect(actuatorBus.SHS_throttle, SHS_charge_control.opening) annotation (
        Line(
        points={{30,100},{-90,100},{-90,-84},{-62,-84},{-62,-95.6}},
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
    connect(port_a1, R_entry1.port_a)
      annotation (Line(points={{-92,-160},{-92,-135}}, color={0,127,255}));
    connect(R_entry1.port_b, SHS_charge_control.port_a) annotation (Line(points={
            {-92,-121},{-92,-102},{-70,-102}}, color={0,127,255}));
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
  end SteamTurbine_OpenFeedHeat_DivertPowerControl_HTGR;

  model HTGR_Rankine_Cycle
    extends BaseClasses.Partial_SubSystem(
      redeclare replaceable ControlSystems.CS_Rankine_Xe100_Based_Secondary CS,
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
          origin={-62,40})));

    TRANSFORM.Fluid.Valves.ValveLinear TCV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
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
      p_nominal=2000000,
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
          origin={53,-26})));
    TRANSFORM.Fluid.Valves.ValveLinear TBV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=180,
          origin={-74,72})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=12000000,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-116,62},{-96,82}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
    TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_e
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
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
    connect(pump1.port_b, volume1.port_a) annotation (Line(points={{20,-64},{16,-64},
            {16,-40},{2,-40}},                         color={0,127,255},
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
        points={{52,-16},{52,-20},{53,-20}},
        color={0,127,255},
        thickness=0.5));
    connect(sensor_m_flow1.port_b,Condenser. port_a)
      annotation (Line(points={{53,-32},{53,-38}},     color={0,127,255},
        thickness=0.5));

    connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-82,72},{-96,
            72}},                                      color={0,127,255}));
    connect(LPT.shaft_b, generator.shaft) annotation (Line(points={{46,-16},{46,-24.1},
            {34.1,-24.1}}, color={0,0,0}));
    connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
        points={{30.1,100.1},{-4,100.1},{-4,46.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume.port_b, TBV.port_a) annotation (Line(points={{-56,40},{-46,40},
            {-46,72},{-66,72}}, color={0,127,255}));
    connect(volume.port_b, TCV.port_a)
      annotation (Line(points={{-56,40},{-12,40}}, color={0,127,255}));
    connect(volume.port_b, sensor_p.port) annotation (Line(points={{-56,40},{-34,40},
            {-34,62},{-18,62},{-18,66}}, color={0,127,255}));
    connect(port_a, volume.port_a)
      annotation (Line(points={{-100,40},{-68,40}}, color={0,127,255}));
    connect(sensor_T2.port_b, port_b)
      annotation (Line(points={{-80,-40},{-100,-40}}, color={0,127,255}));
    connect(TBV.opening, actuatorBus.TBV) annotation (Line(points={{-74,78.4},{-74,
            100},{30,100}},       color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
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
  end HTGR_Rankine_Cycle;
end HTGR_RankineCycles;
