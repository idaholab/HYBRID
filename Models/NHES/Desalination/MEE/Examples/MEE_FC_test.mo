within NHES.Desalination.MEE.Examples;
model MEE_FC_test "Test of a multi effect with full condensing"

  Multiple_Effect.MEE_FC mEE_FCwPH(
    redeclare replaceable Data.MEE_Data data(
      nE=8,
      use_preheater=false,
      T_b_in=298.15,
      T_h=353.15,
      p_h=70000,
      use_flowrates=false,
      X_nom=0.09),
    Brine_Source(X={0.99,0.01}),
    PCV(
      ValvePos_start=0.7,
      init_time=10,
      PID_k=-0.5e-6),
    SCV(dp_nominal=100000))
    annotation (Placement(transformation(extent={{-56,-46},{44,54}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
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
equation
  connect(Tube_Inlet.ports[1], mEE_FCwPH.port_a_steam)
    annotation (Line(points={{-80,24},{-56,24}}, color={0,127,255}));
  connect(mEE_FCwPH.port_b_liquid_return, Liquid_Return.ports[1])
    annotation (Line(points={{-56,-16},{-80,-16}}, color={0,127,255}));
  connect(mEE_FCwPH.port_b_liquid_cond, Steam_Exit.ports[1])
    annotation (Line(points={{44,-16},{80,-16}}, color={0,127,255}));
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
      Interval=50,
      __Dymola_Algorithm="Esdirk45a"));
end MEE_FC_test;
