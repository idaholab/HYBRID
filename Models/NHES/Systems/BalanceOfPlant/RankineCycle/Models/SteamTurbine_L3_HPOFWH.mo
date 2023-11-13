within NHES.Systems.BalanceOfPlant.RankineCycle.Models;
model SteamTurbine_L3_HPOFWH
  "Three Stage Turbine with open feed water heating using high pressure steam"
  extends
    NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_SubSystem(
    redeclare replaceable
      ControlSystems.CS_L3_HTGR_extraction_logan                    CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.ED_Dummy ED,
    redeclare replaceable NHES.Systems.BalanceOfPlant.RankineCycle.Data.Data_L3
      data(
      HPT_p_in=12000000,
      p_dump=20000000,
      p_i1=2000000,
      p_i2=150000,
      cond_p=10000,
      Tin=846.3,
      Tfeed=604.8,
      d_HPT_in=288573.3428,
      d_LPT1_in=56430,
      mdot_total=288.5733428,
      mdot_fh=56.43116714,
      mdot_hpt=232.1421757,
      mdot_lpt1=232.1421757,
      mdot_lpt2=217.023541));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_steam(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_feed(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
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
    annotation (Placement(transformation(extent={{-46,44},{-26,64}})));
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
    annotation (Placement(transformation(extent={{-46,-10},{-66,10}})));
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
  TRANSFORM.Fluid.Volumes.IdealCondenser condenser(p=data.cond_p, V_total=3.5e3)
    annotation (Placement(transformation(extent={{96,-60},{76,-40}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,44})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_a_elec
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Fluid.Machines.Pump_Pressure                  pump(redeclare package Medium
      = Modelica.Media.Water.StandardWater,
    p_nominal=data.p_i2,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{66,-70},{46,-50}})));
  Fluid.Machines.Pump_Pressure                  pump1(redeclare package Medium
      = Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=data.HPT_p_in - 0.5e5,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume OFWH_1(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    p_start=data.LPT2_p_in,
    T_start=333.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2)) annotation (Placement(transformation(extent={{16,-70},{36,-50}})));
  TRANSFORM.Fluid.Valves.ValveLinear HPT_bypass_valve(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=50000,
    m_flow_nominal=data.mdot_fh*1.5)
                        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-38,-16})));
  TRANSFORM.Fluid.Volumes.SimpleVolume OFWH_2(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    p_start=data.HPT_p_in - 0.5e5,
    T_start=data.Tfeed,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2))
    annotation (Placement(transformation(extent={{-38,-70},{-18,-50}})));
  Fluid.Machines.Pump_MassFlow             FWCP(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=true,
    m_flow_nominal=data.mdot_hpt,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-46,-70},{-66,-50}})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=1000,
    m_flow_nominal=data.mdot_total)
                              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-62,60})));
  TRANSFORM.Fluid.Sensors.Temperature Feed_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-70,-60},{-90,-80}})));
  TRANSFORM.Fluid.Sensors.Temperature Steam_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-82,32},{-102,12}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-84,32},{-104,52}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={100,20})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_cond(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
      = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
equation
  connect(TBV.port_a, SteamHeader.port_b)
    annotation (Line(points={{-74,72},{-74,60},{-80,60}}, color={0,127,255}));
  connect(SteamHeader.port_a, port_a_steam)
    annotation (Line(points={{-92,60},{-100,60}}, color={0,127,255}));
  connect(TBV.port_b, prt_b_steamdump) annotation (Line(points={{-74,92},{-74,
          100},{-100,100}}, color={0,127,255}));
  connect(LPT1_bypass.port_3, LPT1_bypass_valve.port_a)
    annotation (Line(points={{-10,50},{-10,0},{-46,0}}, color={0,127,255}));
  connect(HPT.shaft_b, LPT1.shaft_a) annotation (Line(points={{-26,54},{-26,
          40},{4,40},{4,54}}, color={0,0,0}));
  connect(LPT1.shaft_b, LPT2.shaft_a)
    annotation (Line(points={{24,54},{24,40},{74,40},{74,54}}, color={0,0,0}));
  connect(LPT2.shaft_b, generator.shaft)
    annotation (Line(points={{94,54},{100,54}}, color={0,0,0}));
  connect(condenser.port_b, pump.port_a)
    annotation (Line(points={{86,-58},{86,-60},{66,-60}}, color={0,127,255}));
  connect(pump.port_b, OFWH_1.port_b)
    annotation (Line(points={{46,-60},{32,-60}}, color={0,127,255}));
  connect(pump1.port_a, OFWH_1.port_a)
    annotation (Line(points={{10,-60},{20,-60}},color={0,127,255}));
  connect(pump1.port_b, OFWH_2.port_b)
    annotation (Line(points={{-10,-60},{-22,-60}}, color={0,127,255}));
  connect(FWCP.port_a, OFWH_2.port_a)
    annotation (Line(points={{-46,-60},{-34,-60}}, color={0,127,255}));
  connect(FWCP.port_b, port_b_feed)
    annotation (Line(points={{-66,-60},{-100,-60}}, color={0,127,255}));
  connect(HPT.portLP, LPT1_bypass.port_1)
    annotation (Line(points={{-26,60},{-20,60}}, color={0,127,255}));
  connect(LPT1_bypass.port_2, LPT1.portHP)
    annotation (Line(points={{0,60},{4,60}},     color={0,127,255}));
  connect(LPT1.portLP, moistureSeperator.port_a[1])
    annotation (Line(points={{24,60},{28,60},{28,58},{32,58}},
                                               color={0,127,255}));
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
    annotation (Line(points={{-46,60},{-52,60}}, color={0,127,255}));
  connect(TCV.port_a, SteamHeader.port_b)
    annotation (Line(points={{-72,60},{-80,60}}, color={0,127,255}));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{30.1,76},{-60,76},{-60,72},{-62,72},{-62,68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.LPT2_BV, HPT_bypass_valve.opening) annotation (Line(
      points={{30,100},{30,-4},{-30,-4},{-30,-16}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.LPT1_BV, LPT1_bypass_valve.opening) annotation (Line(
      points={{30,100},{30,38},{-56,38},{-56,8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(FWCP.port_b, Feed_T.port)
    annotation (Line(points={{-66,-60},{-80,-60}}, color={0,127,255}));
  connect(SteamHeader.port_a, Steam_T.port)
    annotation (Line(points={{-92,60},{-92,32}}, color={0,127,255}));
  connect(sensorBus.Steam_Temperature, Steam_T.T) annotation (Line(
      points={{-30,100},{-30,144},{-120,144},{-120,22},{-98,22}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Feedwater_Temp, Feed_T.T) annotation (Line(
      points={{-30,100},{-30,144},{-120,144},{-120,-70},{-86,-70}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensor_p.port, Steam_T.port)
    annotation (Line(points={{-94,32},{-92,32}}, color={0,127,255}));
  connect(sensorBus.W_total, sensorW.W) annotation (Line(
      points={{-29.9,100.1},{-29.9,122},{-30,122},{-30,144},{120,144},{120,
          20},{111,20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
  connect(actuatorBus.Feed_Pump_Speed, FWCP.inputSignal) annotation (Line(
      points={{30,100},{30,-18},{-22,-18},{-22,-36},{-56,-36},{-56,-52.7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

  connect(moistureSeperator.port_Liquid, OFWH_1.port_b) annotation (Line(
        points={{34,54},{34,-46},{42,-46},{42,-60},{32,-60}}, color={0,127,
          255}));
  connect(moistureSeperator.port_b[1], LPT2.portHP) annotation (Line(points=
         {{44,58},{46,58},{46,60},{74,60}}, color={0,127,255}));
  connect(HPT_bypass_valve.port_b, OFWH_2.port_b) annotation (Line(points={{-38,-26},
          {-38,-46},{-14,-46},{-14,-60},{-22,-60}},           color={0,127,
          255}));
  connect(SteamHeader.port_b, HPT_bypass_valve.port_a) annotation (Line(
        points={{-80,60},{-74,60},{-74,16},{-50,16},{-50,-6},{-38,-6}},
        color={0,127,255}));
  connect(sensorBus.Extract_flow, sensor_m_flow.m_flow) annotation (Line(
      points={{-30,100},{-30,144},{-120,144},{-120,16},{-80,16},{-80,3.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensor_m_flow.port_a, LPT1_bypass_valve.port_b)
    annotation (Line(points={{-70,0},{-66,0}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, port_b_bypass)
    annotation (Line(points={{-90,0},{-100,0}}, color={0,127,255}));
  connect(port_a_cond, pump.port_a) annotation (Line(points={{100,-40},{72,-40},
          {72,-60},{66,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Three stage steam turbine model with open feed water heating. </p>
<p>This model allows for steam extraction/insertion from inbetween the HPT and LPT1 sections. Moisure is removed between the LPT1 and LPT2 sections and used for feed heating. The remaining feed heating is done using steam from the steam header. </p>
<p>Nominal conditions are need to step up this model. This conditions can be calculated using the steady state design model found in HYBRID/Steady_State/Systems/BalanceOfPlant/RankineCycle/Models .</p>
<p>Key parameters are obtained from the steady state design model&apos;s inputs and outputs, and should be placed into the data packages for both the top level model and CS model. Turbines should be initalized using densities NOT temperatures. </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"100%\"><tr>
<td><p>Key Parameter</p></td>
<td><p>Description</p></td>
</tr>
<tr>
<td><p>HPT_p_in</p></td>
<td><p>High Pressure Turbine Inlet Pressure (bar)</p></td>
</tr>
<tr>
<td><p>p_i1</p></td>
<td><p>Nomial Pressure Between HPT and LPT1 (bar)</p></td>
</tr>
<tr>
<td><p>p_i2</p></td>
<td><p>Nomial Pressure Between LPT1 and LPT2 (bar)</p></td>
</tr>
<tr>
<td><p>cond_p</p></td>
<td><p>Condenser Pressure (bar)</p></td>
</tr>
<tr>
<td><p>Tin</p></td>
<td><p>Inlet Steam Temperature (C)</p></td>
</tr>
<tr>
<td><p>Tfeed</p></td>
<td><p>Feed Water Temperature (C)</p></td>
</tr>
<tr>
<td><p>d_HPT_in</p></td>
<td><p>HPT inlet density (kg/m3)</p></td>
</tr>
<tr>
<td><p>d_LPT1_in</p></td>
<td><p>LPT1 inlet density (kg/m3)</p></td>
</tr>
<tr>
<td><p>d_LPT2_in</p></td>
<td><p>LPT2 inlet density (kg/m3)</p></td>
</tr>
<tr>
<td><p>mdot_total</p></td>
<td><p>Nominal feed pump flow rate (kg/s)</p></td>
</tr>
<tr>
<td><p>mdot_fh</p></td>
<td><p>Nominal feed heating bypass flow rate (kg/s)</p></td>
</tr>
<tr>
<td><p>mdot_hpt</p></td>
<td><p>Nominal HPT flow rate (kg/s)</p></td>
</tr>
<tr>
<td><p>mdot_lpt1</p></td>
<td><p>Nominal LPT1 flow rate (kg/s)</p></td>
</tr>
<tr>
<td><p>mdot_lpt2</p></td>
<td><p>Nominal LPT2 flow rate (kg/s)</p></td>
</tr>
<tr>
<td><p>eta_t</p></td>
<td><p>Turbine isentropic efficiency</p></td>
</tr>
<tr>
<td><p>eta_mech</p></td>
<td><p>Turbine mechincal efficiency</p></td>
</tr>
<tr>
<td><p>eta_p</p></td>
<td><p>Pump isentropic efficiency</p></td>
</tr>
</table>
<p><br><br><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></p>
<p>Documented September 2023</p>
<p>More imformation on this model can be found at <a href=\"https://doi.org/10.2172/1988132\">https://doi.org/10.2172/1988132</a> </p>
</html>"));
end SteamTurbine_L3_HPOFWH;
