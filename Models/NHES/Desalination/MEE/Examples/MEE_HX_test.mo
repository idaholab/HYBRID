within NHES.Desalination.MEE.Examples;
model MEE_HX_test "Test of a multi effect with heat transfer correlations"

  MEE.Multiple_Effect.MEE_HX mEE_HXw(redeclare replaceable MEE.Data.MEE_Data
      data(
      nE=3,
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
    use_m_flow_in=false,
    m_flow=1,
    T=398.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
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
equation
  connect(Tube_Inlet.ports[1], mEE_HXw.port_a_steam)
    annotation (Line(points={{-80,24},{-54,24}}, color={0,127,255}));
  connect(mEE_HXw.port_b_liquid_return, Liquid_Return.ports[1])
    annotation (Line(points={{-54,-16},{-80,-16}}, color={0,127,255}));
  connect(mEE_HXw.port_b_liquid_cond, Steam_Exit.ports[1])
    annotation (Line(points={{46,-16},{80,-16}}, color={0,127,255}));
  connect(ramp.y, Liquid_Return.p_in) annotation (Line(points={{-173,-22},{
          -112,-22},{-112,-8},{-102,-8}}, color={0,0,127}));
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
      StopTime=2000,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"));
end MEE_HX_test;
