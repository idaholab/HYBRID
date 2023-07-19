within NHES.Systems.EnergyManifold.SteamManifold;
model SteamManifold_L1_boundaries
  import NHES;
  extends BaseClasses.Partial_SubSystem_C(
    redeclare replaceable CS_Dummy CS(nPorts_b3=nPorts_b3),
    redeclare replaceable ED_Dummy ED,
    redeclare Data.SteamManifold data,
    redeclare final package Medium_1 = Medium,
    redeclare final package Medium_2 = Medium,
    redeclare final package Medium_3 = Medium,
    port_b2_nominal(p=port_a1_nominal.p - dp_nominal_valve_b2));

  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium annotation (
      choicesAllMatching=true);

  parameter SI.PressureDifference dp_nominal_valve_b2=1e4
    "Nominal pressure drop at full opening"
    annotation (Dialog(tab="Nominal Conditions"));

  parameter Boolean use_pipeDelay_b2=false
    "=true to use include pipe effects due to distance"
    annotation (Dialog(group="port_b2 (e.g., Balance of Plant)"));
  parameter SI.Length length_b2=10 "Length of pipe to port_b2" annotation (
      Dialog(group="port_b2 (e.g., Balance of Plant)", enable=use_pipeDelay_b2));
  parameter SI.Diameter diameter_b2=2.5 "Diameter of pipe to port_b2"
    annotation (Dialog(group="port_b2 (e.g., Balance of Plant)", enable=
          use_pipeDelay_b2));

  parameter Boolean use_pipeDelay_a2=use_pipeDelay_b2
    "=true to use include pipe effects due to distance"
    annotation (Dialog(group="port_a2 (e.g., Balance of Plant)"));
  parameter SI.Length length_a2=length_b2 "Length of pipe from port_a2"
    annotation (Dialog(group="port_a2 (e.g., Balance of Plant)", enable=
          use_pipeDelay_b2));
  parameter SI.Diameter diameter_a2=diameter_b2 "Diameter of pipe from port_a2"
    annotation (Dialog(group="port_a2 (e.g., Balance of Plant)", enable=
          use_pipeDelay_b2));

  parameter Boolean use_pipeDelay_b3=false
    "=true to use include pipe effects due to distance"
    annotation (Dialog(group="port_b3 (e.g., Industrial Process)"));
  parameter SI.Length[nPorts_b3] length_b3=fill(10, nPorts_b3)
    "Lengtsh of pipe to port_b3" annotation (Dialog(group="port_b3 (e.g., Industrial Process)",
        enable=use_pipeDelay_b3));
  parameter SI.Diameter[nPorts_b3] diameter_b3=fill(2.5, nPorts_b3)
    "Diameter of pipes to ports_b3" annotation (Dialog(group="port_b3 (e.g., Industrial Process)",
        enable=use_pipeDelay_b3));

  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=1,
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  TRANSFORM.Fluid.Volumes.MixingVolume steamHeader(
    use_T_start=false,
    nPorts_a=1,
    nPorts_b=1 + nPorts_b3,
    redeclare package Medium = Medium,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=20),
    p_start=port_a1_start.p,
    h_start=port_a1_start.h)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  TRANSFORM.Fluid.Valves.ValveIncompressible valve_b2(
    rho_nominal=Medium_1.density_ph(port_a1_nominal.p, port_a1_nominal.h),
    redeclare package Medium = Medium,
    m_flow_nominal=port_a1_nominal.m_flow,
    dp_nominal=dp_nominal_valve_b2)
    annotation (Placement(transformation(extent={{30,30},{50,50}})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_b2(
    redeclare package Medium = Medium,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=diameter_b2,
        length=length_b2,
        nV=2),
    exposeState_b=true,
    use_Ts_start=false,
    h_a_start=port_a1_start.h,
    h_b_start=port_a1_start.h,
    p_a_start=port_a1_start.p - valve_b2.dp_start,
    m_flow_a_start=-port_b2_start.m_flow)
    annotation (Placement(transformation(extent={{60,30},{80,50}})));

  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_a2(
    redeclare package Medium = Medium,
    exposeState_b=true,
    use_Ts_start=false,
    p_a_start=port_a2_start.p,
    h_a_start=port_a2_start.h,
    h_b_start=port_a2_start.h,
    m_flow_a_start=port_a2_start.m_flow,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        nV=2,
        dimension=diameter_a2,
        length=length_a2))
    annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph source_b3[nPorts_b3](
    redeclare package Medium = Medium,
    each nPorts=1,
    each use_p_in=true,
    each use_h_in=true) if nPorts_b3 > 0 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,-80})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_b3[
    nPorts_b3](redeclare package Medium = Medium, each R=1) if
                                                     nPorts_b3 > 0 and use_pipeDelay_b3
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,-80})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe_b3[nPorts_b3](
    redeclare package Medium = Medium,
    each exposeState_b=true,
    h_a_start=fill(port_a1_start.h, nPorts_b3),
    h_b_start=fill(port_a1_start.h, nPorts_b3),
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        each nV=2,
        dimension=diameter_b3,
        length=length_b3),
    m_flow_a_start=-port_b3_start_m_flow,
    each use_Ts_start=false,
    p_a_start={port_a1_start.p for i in 1:nPorts_b3}) if
                                nPorts_b3 > 0 and use_pipeDelay_b3 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={0,-80})));
  TRANSFORM.Fluid.Sensors.MassFlowRate massFlowRate_b3[nPorts_b3](redeclare
      package Medium = Medium) if nPorts_b3 > 0
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort specificEnthalpy_b3_return[
    nPorts_b3](redeclare package Medium = Medium) if
                                           nPorts_b3 > 0
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Modelica.Blocks.Sources.RealExpression pressure_steamHeader[nPorts_b3](each y=
        steamHeader.medium.p) if nPorts_b3 > 0
    annotation (Placement(transformation(extent={{-120,-76},{-100,-56}})));
  Modelica.Blocks.Sources.RealExpression specificEnthalpy_steamHeader[nPorts_b3](each y=
        steamHeader.medium.h) if nPorts_b3 > 0
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h sink_b3[nPorts_b3](
    redeclare package Medium = Medium,
    each nPorts=1,
    each use_m_flow_in=true,
    each use_h_in=true) if nPorts_b3 > 0 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-2,0})));
  Modelica.Blocks.Math.Gain gain[nPorts_b3](each k=-1) if nPorts_b3 > 0
    annotation (Placement(transformation(extent={{20,-12},{12,-4}})));
equation

  // Conditional Connections based on # of ports
  for i in 1:nPorts_b3 loop
    connect(sink_b3[i].ports[1],steamHeader.port_b[i+1]);
    connect(massFlowRate_b3[i].port_b, specificEnthalpy_b3_return[i].port_a);
    connect(port_b3[i], specificEnthalpy_b3_return[i].port_b);
  end for;

  // Conditional pipe delay to port_b3
  if use_pipeDelay_b3 then
    for i in 1:nPorts_b3 loop
      connect(source_b3[i].ports[1], resistance_b3[i].port_a);
      connect(resistance_b3[i].port_b, pipe_b3[i].port_a);
      connect(massFlowRate_b3[i].port_a, pipe_b3[i].port_b);
    end for;
  else
    for i in 1:nPorts_b3 loop
      connect(source_b3[i].ports[1], massFlowRate_b3[i].port_a);
    end for;
  end if;

  // Conditional pipe delay to port_b2
  if use_pipeDelay_b2 then
    connect(valve_b2.port_b, pipe_b2.port_a);
    connect(pipe_b2.port_b, port_b2);
  else
    connect(valve_b2.port_b, port_b2);
  end if;

  // Conditional pipe delay from port_a2
  if use_pipeDelay_a2 then
    connect(port_a2, pipe_a2.port_a);
    connect(pipe_a2.port_b, port_b1);
  else
    connect(port_a2, port_b1);
  end if;

  connect(port_a1, resistance.port_a)
    annotation (Line(points={{-100,40},{-77,40}}, color={0,127,255}));
  connect(resistance.port_b, steamHeader.port_a[1])
    annotation (Line(points={{-63,40},{-46,40}}, color={0,127,255}));
  connect(steamHeader.port_b[1], valve_b2.port_a)
    annotation (Line(points={{-34,40},{30,40}}, color={0,127,255}));
  connect(actuatorBus.opening_valve_toBOP, valve_b2.opening)
    annotation (Line(
      points={{30.1,100.1},{60,100.1},{60,60},{40,60},{40,48}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(pressure_steamHeader.y, source_b3.p_in) annotation (Line(points={{-99,
          -66},{-90,-66},{-90,-72},{-72,-72}}, color={0,0,127}));
  connect(specificEnthalpy_steamHeader.y, source_b3.h_in) annotation (Line(
        points={{-99,-80},{-90,-80},{-90,-76},{-72,-76}}, color={0,0,127}));
  connect(massFlowRate_b3.m_flow, gain.u)
    annotation (Line(points={{30,-76.4},{30,-8},{20.8,-8}},
                                                          color={0,0,127}));
  connect(gain.y, sink_b3.m_flow_in)
    annotation (Line(points={{11.6,-8},{8,-8}}, color={0,0,127}));
  connect(specificEnthalpy_b3_return.h_out, sink_b3.h_in)
    annotation (Line(points={{60,-76.4},{60,-4},{10,-4}},
                                                        color={0,0,127}));
  annotation (
    defaultComponentName="EM",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}}), graphics={Text(
          extent={{-14,-92},{16,-98}},
          lineColor={0,0,0},
          textString="Conditionally connected
based on exterior connections")}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-3.73323,6},{136.271,-6}},
          lineColor={0,0,0},
          origin={-64.2668,-40},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-68,46},{-20,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-19,6},{19,-6}},
          lineColor={0,0,0},
          origin={13,40},
          rotation=0,
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-38,6},{19,-6}},
          lineColor={0,0,0},
          origin={23,2},
          rotation=-45,
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{34,46},{72,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-26,6},{26,-6}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={39,-42},
          rotation=90),
        Ellipse(
          extent={{24,50},{42,32}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Ellipse(
          extent={{30,-4},{48,-22}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{34,50},{32,62}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{40,-4},{38,8}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{30,10},{48,8}},
          lineColor={0,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{24,64},{42,62}},
          lineColor={0,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{6,57},{-28,23}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Sphere,
          fillColor={175,175,175}),
        Ellipse(
          extent={{35,50},{31,32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={162,162,0}),
        Ellipse(
          extent={{41,-4},{37,-22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={162,162,0}),
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Steam Manifold")}),
    experiment(StopTime=20));
end SteamManifold_L1_boundaries;
