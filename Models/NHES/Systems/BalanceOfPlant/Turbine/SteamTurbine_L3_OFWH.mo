within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L3_OFWH
  "Three Stage Turbine with open feed water heating using low and high pressure steam"
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_SubSystem(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3
      CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ED_Dummy ED,
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data);
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_steam_in(redeclare package
      Medium =         Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_return(
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  TRANSFORM.Fluid.Machines.SteamTurbine HPT(
    eta_mech=data.eta_mech,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
         eta_nominal=data.eta_t),
    p_a_start=data.HPT_p_in,
    p_b_start=data.HPT_p_out,
    T_a_start=data.Tin,
    T_b_start=406.65,
    m_flow_start=data.mdot_hpt,
    m_flow_nominal=data.mdot_hpt,
    use_NominalInlet=true,
    p_inlet_nominal=data.HPT_p_in,
    p_outlet_nominal=data.HPT_p_out,
    use_T_nominal=false,
    T_nominal=data.Tin,
    d_nominal=data.d_HPT_in)
    annotation (Placement(transformation(extent={{-48,44},{-28,64}})));
  TRANSFORM.Fluid.Machines.SteamTurbine LPT1(
    eta_mech=data.eta_mech,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
         eta_nominal=data.eta_t),
    p_a_start=data.LPT1_p_in,
    p_b_start=data.LPT1_p_out,
    T_a_start=406.65,
    T_b_start=384.5,
    m_flow_start=data.mdot_lpt1,
    m_flow_nominal=data.mdot_lpt1,
    p_inlet_nominal=data.LPT1_p_in,
    p_outlet_nominal=data.LPT1_p_out,
    use_T_nominal=false,
    d_nominal=data.d_LPT1_in)
    annotation (Placement(transformation(extent={{4,44},{24,64}})));
  TRANSFORM.Fluid.Machines.SteamTurbine LPT2(
    eta_mech=data.eta_mech,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
         eta_nominal=data.eta_t),
    p_a_start=data.LPT2_p_in,
    p_b_start=data.LPT2_p_out,
    T_a_start=384.5,
    T_b_start=314.65,
    m_flow_start=data.mdot_lpt2,
    m_flow_nominal=data.mdot_lpt2,
    p_inlet_nominal=data.LPT2_p_in,
    p_outlet_nominal=data.LPT2_p_out,
    use_T_nominal=false,
    T_nominal=384.45,
    d_nominal=data.d_LPT2_in)
    annotation (Placement(transformation(extent={{74,44},{94,64}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume SteamHeader(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    p_start=data.HPT_p_in - 5,
    T_start=data.Tin,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2))
    annotation (Placement(transformation(extent={{-96,50},{-76,70}})));
  TRANSFORM.Fluid.Volumes.Separator moistureSeperator(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=data.LPT2_p_out - 2,
    T_start=393.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5),
    eta_sep=0.99,
    nPorts_a=1,
    nPorts_b=1) annotation (Placement(transformation(extent={{28,48},{48,68}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_bypass(redeclare package
      Medium =         Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume LPT1_bypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater, V=5,
    p_start=data.HPT_p_out,
    T_start=406.65)
    annotation (Placement(transformation(extent={{-20,70},{0,50}})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT1_bypass_valve(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State prt_b_steamdump(redeclare package
      Medium =         Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  TRANSFORM.Fluid.Valves.ValveLinear TBV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=200000,
    m_flow_nominal=3) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-74,82})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume LPT2_bypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater, V=5,
    p_start=data.LPT2_p_out,
    T_start=384.5)
    annotation (Placement(transformation(extent={{50,70},{70,50}})));
  TRANSFORM.Fluid.Volumes.IdealCondenser condenser(p=data.cond_p, V_total=3.5e3)
    annotation (Placement(transformation(extent={{96,-60},{76,-40}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,44})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_a_elec
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Fluid.Machines.Pump_Pressure      boostpump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_nominal=data.p_i2 - 0.2e5,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{70,-70},{50,-50}})));
  Fluid.Machines.Pump_Pressure      boostpump2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=data.p_i2,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{22,-70},{2,-50}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume OFWH_1(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    p_start=data.LPT2_p_in - 0.2e5,
    T_start=data.Tfeed,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2)) annotation (Placement(transformation(extent={{24,-70},{44,
            -50}})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT2_bypass_valve(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=10000,
    m_flow_nominal=0.1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,0})));
  TRANSFORM.Fluid.Volumes.SimpleVolume OFWH_2(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    p_start=data.LPT2_p_in,
    T_start=data.Tfeed,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2))
    annotation (Placement(transformation(extent={{-22,-70},{-2,-50}})));
  Fluid.Machines.Pump_MassFlow             FWCP(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=true,
    m_flow_nominal=data.mdot_hpt,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-64,-70},{-84,-50}})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=50000,
    m_flow_nominal=data.mdot_hpt)
                              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-62,60})));
  TRANSFORM.Fluid.Sensors.Temperature Feed_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-80,-60},{-100,-80}})));
  TRANSFORM.Fluid.Sensors.Temperature Steam_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-84,32},{-104,12}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-84,32},{-104,52}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={100,20})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_condensor(redeclare package
      Medium =         Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Fluid.Valves.FlowCV     fCV(
    ValvePos_start=0.75,
    FlowRate_target=data.mdpt_HPFH,
    init_time=5000,
    Use_input=false,
    PID_k=0.05,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=75000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-48,-22})));
  Fluid.Machines.Pump_Pressure      boostpump3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=data.HPT_p_in - 1e5,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-22,-70},{-42,-50}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume OFWH_3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=data.LPT2_p_in,
    T_start=data.Tfeed,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2))
    annotation (Placement(transformation(extent={{-64,-70},{-44,-50}})));
equation
  connect(TBV.port_a, SteamHeader.port_b)
    annotation (Line(points={{-74,72},{-74,60},{-80,60}}, color={0,127,255}));
  connect(SteamHeader.port_a, port_a_steam_in)
    annotation (Line(points={{-92,60},{-100,60}}, color={0,127,255}));
  connect(TBV.port_b, prt_b_steamdump) annotation (Line(points={{-74,92},{-74,
          100},{-100,100}}, color={0,127,255}));
  connect(LPT1_bypass.port_3, LPT1_bypass_valve.port_a)
    annotation (Line(points={{-10,50},{-10,0},{-60,0}}, color={0,127,255}));
  connect(LPT1_bypass_valve.port_b, port_b_bypass)
    annotation (Line(points={{-80,0},{-100,0}}, color={0,127,255}));
  connect(moistureSeperator.port_b[1], LPT2_bypass.port_1)
    annotation (Line(points={{44,58},{48,58},{48,60},{50,60}},
                                               color={0,127,255}));
  connect(HPT.shaft_b, LPT1.shaft_a) annotation (Line(points={{-28,54},{-28,
          40},{4,40},{4,54}}, color={0,0,0}));
  connect(LPT1.shaft_b, LPT2.shaft_a)
    annotation (Line(points={{24,54},{24,40},{74,40},{74,54}}, color={0,0,0}));
  connect(LPT2.shaft_b, generator.shaft)
    annotation (Line(points={{94,54},{100,54}}, color={0,0,0}));
  connect(condenser.port_b, boostpump1.port_a) annotation (Line(points={{86,
          -58},{86,-60},{70,-60}}, color={0,127,255}));
  connect(boostpump1.port_b, OFWH_1.port_b)
    annotation (Line(points={{50,-60},{40,-60}}, color={0,127,255}));
  connect(LPT2_bypass.port_3, LPT2_bypass_valve.port_a)
    annotation (Line(points={{60,50},{60,10}}, color={0,127,255}));
  connect(LPT2_bypass_valve.port_b, OFWH_1.port_b) annotation (Line(points={{60,-10},
          {60,-46},{42,-46},{42,-60},{40,-60}},      color={0,127,255}));
  connect(boostpump2.port_a, OFWH_1.port_a)
    annotation (Line(points={{22,-60},{28,-60}}, color={0,127,255}));
  connect(boostpump2.port_b, OFWH_2.port_b)
    annotation (Line(points={{2,-60},{-6,-60}}, color={0,127,255}));
  connect(moistureSeperator.port_Liquid, OFWH_2.port_b) annotation (Line(points={{34,54},
          {34,-46},{0,-46},{0,-60},{-6,-60}},              color={0,127,255}));
  connect(FWCP.port_b, port_b_liquid_return)
    annotation (Line(points={{-84,-60},{-100,-60}}, color={0,127,255}));
  connect(HPT.portLP, LPT1_bypass.port_1)
    annotation (Line(points={{-28,60},{-20,60}}, color={0,127,255}));
  connect(LPT1_bypass.port_2, LPT1.portHP)
    annotation (Line(points={{0,60},{4,60}},     color={0,127,255}));
  connect(LPT1.portLP, moistureSeperator.port_a[1])
    annotation (Line(points={{24,60},{28,60},{28,58},{32,58}},
                                               color={0,127,255}));
  connect(LPT2_bypass.port_2, LPT2.portHP)
    annotation (Line(points={{70,60},{74,60}}, color={0,127,255}));
  connect(LPT2.portLP, condenser.port_a) annotation (Line(points={{94,60},{94,-43},
          {93,-43}},          color={0,127,255}));
  connect(actuatorBus.TBV, TBV.opening) annotation (Line(
      points={{30,100},{30,82},{-66,82}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(HPT.portHP, TCV.port_b)
    annotation (Line(points={{-48,60},{-52,60}}, color={0,127,255}));
  connect(TCV.port_a, SteamHeader.port_b)
    annotation (Line(points={{-72,60},{-80,60}}, color={0,127,255}));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{30.1,82},{-62,82},{-62,68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.LPT2_BV, LPT2_bypass_valve.opening) annotation (Line(
      points={{30,100},{30,0},{40,0},{40,5.55112e-16},{52,5.55112e-16}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.LPT1_BV, LPT1_bypass_valve.opening) annotation (Line(
      points={{30,100},{30,18},{-70,18},{-70,8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(FWCP.port_b, Feed_T.port)
    annotation (Line(points={{-84,-60},{-90,-60}}, color={0,127,255}));
  connect(SteamHeader.port_a, Steam_T.port)
    annotation (Line(points={{-92,60},{-92,32},{-94,32}},
                                                 color={0,127,255}));
  connect(sensorBus.Steam_Temperature, Steam_T.T) annotation (Line(
      points={{-30,100},{-30,144},{-120,144},{-120,22},{-100,22}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Feedwater_Temp, Feed_T.T) annotation (Line(
      points={{-30,100},{-30,78},{-120,78},{-120,-74},{-96,-74},{-96,-70}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensor_p.port, Steam_T.port)
    annotation (Line(points={{-94,32},{-94,32}}, color={0,127,255}));
  connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
      points={{-30,100},{-30,144},{-120,144},{-120,42},{-100,42}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(generator.port, sensorW.port_a)
    annotation (Line(points={{100,34},{100,30}}, color={255,0,0}));
  connect(port_a_elec, sensorW.port_b)
    annotation (Line(points={{100,0},{100,10}}, color={255,0,0}));
  connect(condenser.port_a, port_b_condensor) annotation (Line(points={{93,
          -43},{93,-40},{100,-40}}, color={0,127,255}));
  connect(actuatorBus.Feed_Pump_Speed, FWCP.inputSignal) annotation (Line(
      points={{30,100},{30,-44},{-74,-44},{-74,-52.7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

  connect(sensorBus.W_total, sensorW.W) annotation (Line(
      points={{-29.9,100.1},{-29.9,144},{118,144},{118,20},{111,20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boostpump3.port_b, OFWH_3.port_b)
    annotation (Line(points={{-42,-60},{-48,-60}}, color={0,127,255}));
  connect(OFWH_3.port_a, FWCP.port_a)
    annotation (Line(points={{-60,-60},{-64,-60}}, color={0,127,255}));
  connect(boostpump3.port_a, OFWH_2.port_a)
    annotation (Line(points={{-22,-60},{-18,-60}}, color={0,127,255}));
  connect(fCV.port_b, OFWH_3.port_b)
    annotation (Line(points={{-48,-32},{-48,-60}}, color={0,127,255}));
  connect(fCV.port_a, TCV.port_a) annotation (Line(points={{-48,-12},{-48,
          40},{-72,40},{-72,60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                  Text(
          extent={{-94,-76},{94,-84}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Balance of Plant"),
        Rectangle(
          extent={{-2.09756,2},{83.9024,-2}},
          lineColor={0,0,0},
          origin={-45.902,-64},
          rotation=360,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-1.81329,5},{66.1867,-5}},
          lineColor={0,0,0},
          origin={-68.187,-41},
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
          origin={-18.187,-3},
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
          origin={30.427,-29},
          rotation=0,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.43805,2.7864},{15.9886,-2.7864}},
          lineColor={0,0,0},
          origin={45.214,-41.989},
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
          origin={18.373,-56},
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
          origin={21.422,-39.828},
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
        coordinateSystem(preserveAspectRatio=false)));
end SteamTurbine_L3_OFWH;
