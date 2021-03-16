within NHES.Systems.IndustrialProcess.HeaderTurbineCombo;
model StepDownTurbine

   extends BaseClasses.Partial_SubSystem_A(
     redeclare replaceable CS_Dummy CS,
     redeclare replaceable ED_Dummy ED,
     redeclare Data.Data_Dummy data,
     replaceable package Medium = Modelica.Media.Water.StandardWater,
     port_b_nominal(m_flow = -(port_a_nominal.m_flow-m_flow_nominal_toProcess)));

parameter SI.MassFlowRate m_flow_nominal_toProcess = 0.1*port_a_nominal.m_flow "Nominal flow rate to process from steam header";

  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_port_a(
      redeclare package Medium = Medium, R=1*p_units/port_a_nominal.m_flow)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume_header(
    nPorts_a=1,
    nPorts_b=2,
    redeclare package Medium = Medium,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    p_start=port_a_start.p,
    use_T_start=false,
    h_start=port_a_start.h)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T sink(
    redeclare package Medium = Medium,
    nPorts=1,
    m_flow=-m_flow_nominal_toProcess)
              annotation (Placement(transformation(extent={{-10,40},{-30,60}})));

  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    redeclare package Medium = Medium,
    use_T_start=false,
    h_a_start=port_a_start.h,
    h_b_start=port_b_start.h,
    m_flow_start=port_a_start.m_flow - m_flow_nominal_toProcess,
    p_a_start=port_a_start.p,
    p_b_start=port_b_start.p)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume_turbine(
    nPorts_a=1,
    redeclare package Medium = Medium,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    p_start=port_b_start.p,
    use_T_start=false,
    h_start=port_b_start.h,
    nPorts_b=1)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_port_b(
      redeclare package Medium = Medium, R=1*p_units/abs(port_b_nominal.m_flow))
    annotation (Placement(transformation(extent={{-60,-50},{-80,-30}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator(J=1000)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
protected
  final parameter SI.Pressure p_units = 1;

equation

  connect(resistance_port_a.port_b, volume_header.port_a[1])
    annotation (Line(points={{-63,40},{-56,40}}, color={0,127,255}));
  connect(steamTurbine.portHP, volume_header.port_b[1]) annotation (Line(points=
         {{-30,6},{-36,6},{-36,39.5},{-44,39.5}}, color={0,127,255}));
  connect(volume_turbine.port_a[1], steamTurbine.portLP) annotation (Line(
        points={{-6,-30},{-10,-30},{-10,6}},   color={0,127,255}));
  connect(sink.ports[1], volume_header.port_b[2]) annotation (Line(points={{-30,
          50},{-36,50},{-36,40.5},{-44,40.5}}, color={0,127,255}));
  connect(steamTurbine.shaft_b, generator.shaft)
    annotation (Line(points={{-10,0},{0,0}}, color={0,0,0}));
  connect(generator.port, sensorW.port_a)
    annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
  connect(port_a, resistance_port_a.port_a)
    annotation (Line(points={{-100,40},{-77,40}}, color={0,127,255}));
  connect(port_b, resistance_port_b.port_b)
    annotation (Line(points={{-100,-40},{-77,-40}}, color={0,127,255}));
  connect(sensorW.port_b, portElec)
    annotation (Line(points={{60,0},{100,0}}, color={255,0,0}));
  connect(volume_turbine.port_b[1], resistance_port_b.port_a) annotation (Line(
        points={{6,-30},{10,-30},{10,-40},{-63,-40}}, color={0,127,255}));
  annotation (
    defaultComponentName="IP",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{50,12},{78,-14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-32,54},{2,48}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-14,3},{14,-3}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={10,27},
          rotation=90),
        Rectangle(
          extent={{-22,42},{12,36}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Header + Step Down Turbine"),
        Text(
          extent={{59,-8},{69,6}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="G"),
        Rectangle(
          extent={{-1.81332,3},{66.1869,-3}},
          lineColor={0,0,0},
          origin={-14.1867,-1},
          rotation=0,
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{6,16},{6,-14},{36,-32},{36,36},{6,16}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{15,-8},{25,6}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Rectangle(
          extent={{-0.4,3},{15.5,-3}},
          lineColor={0,0,0},
          origin={36.4272,-29},
          rotation=0,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-82,46},{-34,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-18,54},{-46,26}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{-3.37009,3},{130.603,-3}},
          lineColor={0,0,0},
          origin={-78.6031,-41},
          rotation=0,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.465408,2.7136},{18.0346,-2.7136}},
          lineColor={0,0,0},
          origin={50.7136,-43.5346},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder)}),
    experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000));
end StepDownTurbine;
