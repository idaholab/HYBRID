within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L1_boundaries

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
  TRANSFORM.Fluid.Volumes.SimpleVolume feedWaterHeater(
    use_HeatPort=true,
    redeclare package Medium = Medium,
    p_start=port_b_start.p,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5),
    use_T_start=false,
    h_start=port_b_start.h)
    annotation (Placement(transformation(extent={{-70,-90},{-90,-70}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow    boundary(use_port=
        true)
    annotation (Placement(transformation(extent={{-102,-110},{-82,-90}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yb=1e8,
    k=1e8,
    k_s=1/port_b_nominal.T,
    k_m=1/port_b_nominal.T)
    annotation (Placement(transformation(extent={{-108,-96},{-100,-104}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=port_b_nominal.T)
    annotation (Placement(transformation(extent={{-124,-106},{-114,-94}})));
  TRANSFORM.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-96,-82},{-104,-90}})));
  Modelica.Fluid.Fittings.MultiPort multiPort1(redeclare package Medium =
        Medium, nPorts_b=if nPorts_a3 > 0 then nPorts_a3+2 else 2)
                       annotation (Placement(transformation(
        extent={{-4,-10},{4,10}},
        rotation=90,
        origin={80,-66})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(
      redeclare package Medium = Medium, R=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-130,-80})));
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
  connect(boundary.port,feedWaterHeater. heatPort)
    annotation (Line(points={{-82,-100},{-80,-100},{-80,-86}},
                                                             color={191,0,0}));
  connect(temperature.T,PID. u_m) annotation (Line(points={{-102.4,-86},{-104,
          -86},{-104,-95.2}},
                        color={0,0,127}));
  connect(realExpression.y,PID. u_s)
    annotation (Line(points={{-113.5,-100},{-108.8,-100}},
                                                         color={0,0,127}));
  connect(PID.y,boundary. Q_flow_ext)
    annotation (Line(points={{-99.6,-100},{-96,-100}}, color={0,0,127}));
  connect(temperature.port,feedWaterHeater. port_b) annotation (Line(points={{-100,
          -82},{-100,-80},{-86,-80}},color={0,127,255}));
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
  connect(resistance1.port_a, feedWaterHeater.port_b)
    annotation (Line(points={{-123,-80},{-86,-80}}, color={0,127,255}));
  connect(resistance1.port_b, port_b) annotation (Line(points={{-137,-80},{-140,
          -80},{-140,-40},{-160,-40}}, color={0,127,255}));
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
  connect(feedWaterHeater.port_a, resistance2.port_b)
    annotation (Line(points={{-74,-80},{-57,-80}}, color={0,127,255}));
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
end SteamTurbine_L1_boundaries;
