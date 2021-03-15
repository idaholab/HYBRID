within NHES.Systems.IndustrialProcess.HeaderTurbineCombo;
model StepDownTurbines_standAlone

  extends BaseClasses.Partial_SubSystem(
    redeclare replaceable CS_Dummy CS,
    redeclare replaceable ED_Dummy ED,
    redeclare Data.Data_Dummy data);

    package Medium = Modelica.Media.Water.StandardWater;
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Medium,
    p=data.p_HP,
    T=data.T_HP,
    nPorts=1)
    annotation (Placement(transformation(extent={{-150,30},{-130,50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = Medium,
    p=data.p_LP,
    T=data.T_LP,
    nPorts=1)
    annotation (Placement(transformation(extent={{-150,-50},{-130,-30}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_inlet(
      redeclare package Medium = Medium, R=1*p_units/data.m_flow_total)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume_HP(
    nPorts_a=1,
    nPorts_b=2,
    redeclare package Medium = Medium,
    p_start=data.p_HP,
    T_start=data.T_HP,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1))
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T sink_HP(
      redeclare package Medium = Medium,
    m_flow=data.m_flow_HP_toProcess,
    T=data.T_HP,
    nPorts=1)
    annotation (Placement(transformation(extent={{0,50},{-20,70}})));

  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    redeclare package Medium = Medium,
    p_a_start=data.p_HP,
    p_b_start=data.p_IP,
    T_a_start=data.T_HP,
    T_b_start=data.T_IP,
    m_flow_start=data.m_flow_HP)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{14,-36},{34,-16}})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume_IP(
    nPorts_a=1,
    redeclare package Medium = Medium,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    p_start=data.p_IP,
    T_start=data.T_IP,
    nPorts_b=2)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine1(
    redeclare package Medium = Medium,
    p_a_start=data.p_IP,
    p_b_start=data.p_LP,
    T_a_start=data.T_IP,
    T_b_start=data.T_LP,
    m_flow_start=data.m_flow_IP)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator1
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T sink_IP(
    redeclare package Medium = Medium,
    m_flow=data.m_flow_IP_toProcess,
    T=data.T_IP,
    nPorts=1)
    annotation (Placement(transformation(extent={{40,50},{20,70}})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume_LP(
    nPorts_a=1,
    redeclare package Medium = Medium,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    p_start=data.p_LP,
    T_start=data.T_LP,
    nPorts_b=2)
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_outlet(
      redeclare package Medium = Medium, R=1*p_units/data.m_flow_total)
    annotation (Placement(transformation(extent={{-60,-50},{-80,-30}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T sink_LP(
    redeclare package Medium = Medium,
    m_flow=data.m_flow_LP_toProcess,
    T=data.T_LP,
    nPorts=1)
    annotation (Placement(transformation(extent={{80,50},{60,70}})));
protected
  final parameter SI.Pressure p_units = 1;

equation

  connect(boundary.ports[1], resistance_inlet.port_a)
    annotation (Line(points={{-130,40},{-77,40}}, color={0,127,255}));
  connect(resistance_inlet.port_b, volume_HP.port_a[1])
    annotation (Line(points={{-63,40},{-56,40}}, color={0,127,255}));
  connect(steamTurbine.portHP, volume_HP.port_b[1]) annotation (Line(points={{-30,6},
          {-36,6},{-36,39.5},{-44,39.5}},      color={0,127,255}));
  connect(steamTurbine.shaft_b, generator.shaft) annotation (Line(points={{-10,0},
          {-6,0},{-6,-26.1},{13.9,-26.1}},color={0,0,0}));
  connect(volume_IP.port_a[1], steamTurbine.portLP)
    annotation (Line(points={{-6,40},{-10,40},{-10,6}},    color={0,127,255}));
  connect(steamTurbine1.shaft_b, generator1.shaft) annotation (Line(points={{30,0},{
          44,0},{44,-0.1},{45.9,-0.1}},           color={0,0,0}));
  connect(sink_HP.ports[1], volume_HP.port_b[2]) annotation (Line(points={{-20,60},
          {-36,60},{-36,40.5},{-44,40.5}}, color={0,127,255}));
  connect(volume_LP.port_a[1], steamTurbine1.portLP)
    annotation (Line(points={{34,40},{30,40},{30,6}},     color={0,127,255}));
  connect(boundary1.ports[1], resistance_outlet.port_b)
    annotation (Line(points={{-130,-40},{-77,-40}}, color={0,127,255}));
  connect(steamTurbine1.portHP, volume_IP.port_b[1])
    annotation (Line(points={{10,6},{10,39.5},{6,39.5}}, color={0,127,255}));
  connect(sink_IP.ports[1], volume_IP.port_b[2]) annotation (Line(points={{20,
          60},{10,60},{10,40.5},{6,40.5}}, color={0,127,255}));
  connect(volume_LP.port_b[1], resistance_outlet.port_a) annotation (Line(
        points={{46,39.5},{52,39.5},{52,-40},{-63,-40}}, color={0,127,255}));
  connect(sink_LP.ports[1], volume_LP.port_b[2]) annotation (Line(points={{60,
          60},{52,60},{52,40.5},{46,40.5}}, color={0,127,255}));
  annotation (
    defaultComponentName="IP",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}),
    experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000));
end StepDownTurbines_standAlone;
