within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L3_HPOFWH_HRSG_MEE
  "Three Stage Turbine with open feed water heating using high pressure steam"
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_SubSystem(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3
      CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ED_Dummy ED,
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data);
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
    annotation (Placement(transformation(extent={{54,42},{74,62}})));
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
    annotation (Placement(transformation(extent={{92,-94},{72,-74}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,44})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_a_elec
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Fluid.Machines.Pump_Pressure                  pump1(redeclare package Medium
      = Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=data.HPT_p_in - 0.5e5,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
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
  TRANSFORM.Fluid.Sensors.Temperature Feed_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-68,-66},{-88,-86}})));
  TRANSFORM.Fluid.Sensors.Temperature Steam_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-82,32},{-102,12}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-76,38},{-96,58}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={100,20})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_cond(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow
    annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_wasteheat(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Fluid.Valves.PressureCV pressureCV(redeclare package Medium =
        Modelica.Media.Water.StandardWater, Use_input=false) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={110,-62})));
equation
  connect(TBV.port_b, prt_b_steamdump) annotation (Line(points={{-74,92},{-74,
          100},{-100,100}}, color={0,127,255}));
  connect(LPT1_bypass.port_3, LPT1_bypass_valve.port_a)
    annotation (Line(points={{-10,50},{-10,0},{-46,0}}, color={0,127,255}));
  connect(HPT.shaft_b, LPT1.shaft_a) annotation (Line(points={{-26,54},{-26,
          40},{4,40},{4,54}}, color={0,0,0}));
  connect(LPT1.shaft_b, LPT2.shaft_a)
    annotation (Line(points={{24,54},{24,40},{50,40},{50,38},{54,38},{54,52}},
                                                               color={0,0,0}));
  connect(LPT2.shaft_b, generator.shaft)
    annotation (Line(points={{74,52},{86,52},{86,54},{100,54}},
                                                color={0,0,0}));
  connect(pump1.port_b, OFWH_2.port_b)
    annotation (Line(points={{-10,-60},{-22,-60}}, color={0,127,255}));
  connect(HPT.portLP, LPT1_bypass.port_1)
    annotation (Line(points={{-26,60},{-20,60}}, color={0,127,255}));
  connect(LPT1_bypass.port_2, LPT1.portHP)
    annotation (Line(points={{0,60},{4,60}},     color={0,127,255}));
  connect(actuatorBus.TBV, TBV.opening) annotation (Line(
      points={{30,100},{30,82},{-66,82}},
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
  connect(sensorBus.Steam_Temperature, Steam_T.T) annotation (Line(
      points={{-30,100},{-30,142},{-122,142},{-122,22},{-98,22}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Feedwater_Temp, Feed_T.T) annotation (Line(
      points={{-30,100},{-30,144},{-120,144},{-120,-76},{-84,-76}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensor_p.port, Steam_T.port)
    annotation (Line(points={{-86,38},{-92,38},{-92,32}},
                                                 color={0,127,255}));
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
      points={{-30,100},{-30,68},{-68,68},{-68,48},{-92,48}},
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

  connect(HPT_bypass_valve.port_b, OFWH_2.port_b) annotation (Line(points={{-38,-26},
          {-38,-46},{-14,-46},{-14,-60},{-22,-60}},           color={0,127,
          255}));
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
  connect(HPT_bypass_valve.port_a, port_a_steam) annotation (Line(points={{-38,
          -6},{-66,-6},{-66,60},{-100,60}}, color={0,127,255}));
  connect(port_a_steam, TBV.port_a)
    annotation (Line(points={{-100,60},{-74,60},{-74,72}}, color={0,127,255}));
  connect(HPT.portHP, port_a_steam)
    annotation (Line(points={{-46,60},{-100,60}}, color={0,127,255}));
  connect(sensor_p.port, HPT.portHP) annotation (Line(points={{-86,38},{-88,38},
          {-88,34},{-58,34},{-58,60},{-46,60}}, color={0,127,255}));
  connect(OFWH_2.port_a, port_b_feed)
    annotation (Line(points={{-34,-60},{-100,-60}}, color={0,127,255}));
  connect(Feed_T.port, port_b_feed) annotation (Line(points={{-78,-66},{-78,-60},
          {-100,-60}}, color={0,127,255}));
  connect(LPT2.portLP, port_b_wasteheat) annotation (Line(points={{74,58},{86,
          58},{86,60},{100,60}}, color={0,127,255}));
  connect(LPT1.portLP, LPT2.portHP) annotation (Line(points={{24,60},{26,60},{
          26,58},{54,58}}, color={0,127,255}));
  connect(pump1.port_a, condenser.port_b) annotation (Line(points={{10,-60},{66,
          -60},{66,-98},{82,-98},{82,-92}}, color={0,127,255}));
  connect(pressureCV.port_a, port_a_cond) annotation (Line(points={{110,-52},{
          124,-52},{124,-40},{100,-40}}, color={0,127,255}));
  connect(pressureCV.port_b, condenser.port_a) annotation (Line(points={{110,
          -72},{110,-77},{89,-77}}, color={0,127,255}));
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
        coordinateSystem(preserveAspectRatio=false)));
end SteamTurbine_L3_HPOFWH_HRSG_MEE;
