within NHES.Desalination.MEE.Examples;
model MEE_HX_testcompair
  "Test of a multi effect with heat transfer correlations"

  Multiple_Effect.MEE_HX mEE_HXw(redeclare replaceable Data.MEE_Data data(
      nE=3,
      T_b_in=323.15,
      p_h=90000,
      use_flowrates=false,
      Axnom=1e4,
      pTsys={200000,100000,500000}), PCV(PID(yMin=0.1)))
    annotation (Placement(transformation(extent={{-54,-46},{46,54}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    p=10000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Tube_Inlet(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=1,
    T=398.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-102,14},{-82,34}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Steam_Exit(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=5000,
    T=328.15,
    nPorts=1) annotation (Placement(transformation(extent={{100,-26},{80,-6}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1.9e5,
    duration=100,
    offset=0.1e5,
    startTime=5)
    annotation (Placement(transformation(extent={{-194,-32},{-174,-12}})));
  Multiple_Effect.MEE_FC_ss_UTextnode mEE_FC_ss_UTextnode(
    mEE_innernodelized(h_b_innom=188e3),
    redeclare replaceable Data.MEE_Data data(
      nE=3,
      T_b_in=313.15,
      p_h=90000),
    Cs_in=0.08,
    nV=20,
    m_flow_input=1)
    annotation (Placement(transformation(extent={{-16,-172},{64,-92}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=1,
    T=398.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-96,-118},{-76,-98}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-96,-166},{-76,-146}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=0.5,
    duration=100,
    offset=1,
    startTime=3000)
    annotation (Placement(transformation(extent={{-148,-66},{-128,-46}})));
equation
  connect(Tube_Inlet.ports[1], mEE_HXw.port_a_steam)
    annotation (Line(points={{-82,24},{-54,24}}, color={0,127,255}));
  connect(mEE_HXw.port_b_liquid_return, Liquid_Return.ports[1])
    annotation (Line(points={{-54,-16},{-80,-16}}, color={0,127,255}));
  connect(mEE_HXw.port_b_liquid_cond, Steam_Exit.ports[1])
    annotation (Line(points={{46,-16},{80,-16}}, color={0,127,255}));
  connect(ramp.y, Liquid_Return.p_in) annotation (Line(points={{-173,-22},{
          -112,-22},{-112,-8},{-102,-8}}, color={0,0,127}));
  connect(boundary1.ports[1],mEE_FC_ss_UTextnode. port_b)
    annotation (Line(points={{-76,-156},{-16,-156}},color={0,127,255}));
  connect(mEE_FC_ss_UTextnode.port_a,boundary. ports[1])
    annotation (Line(points={{-16,-108},{-76,-108}},
                                                  color={0,127,255}));
  connect(ramp1.y, Tube_Inlet.m_flow_in) annotation (Line(points={{-127,-56},{
          -122,-56},{-122,32},{-102,32}}, color={0,0,127}));
  connect(boundary.m_flow_in, ramp1.y) annotation (Line(points={{-96,-100},{
          -122,-100},{-122,-56},{-127,-56}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),                               graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    experiment(
      StopTime=6000,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"));
end MEE_HX_testcompair;
