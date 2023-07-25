within NHES.Desalination.MEE.Examples;
model MEE_FC_test3 "Test of a multi effect with full condensing"

  TRANSFORM.Fluid.Interfaces.BoundaryConditions.Boundary_ph Liquid_Return(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.MassFlowSource_T Tube_Inlet(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=1,
    T=398.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
  Multiple_Effect.MEE_FC mEE_FCwPH(
    redeclare replaceable Data.MEE_Data data(
      nE=8,
      use_preheater=true,
      T_b_in=298.15,
      T_h=353.15,
      p_h=70000,
      use_flowrates=false,
      X_nom=0.09),
    Brine_Source(X={0.99,0.01}),
    PCV(
      ValvePos_start=0.9,
      init_time=1,
      PID_k=-1e-4,
      m_flow_nominal=8),
    SCV(PID_k=-5, m_flow_nominal=16),
    Effect(m_brine_out=1, KV=-0.1))
    annotation (Placement(transformation(extent={{-34,-30},{46,50}})));
  TRANSFORM.Fluid.Interfaces.BoundaryConditions.Boundary_pT Purified_Water(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=5000,
    T=328.15,
    nPorts=1) annotation (Placement(transformation(extent={{78,-16},{58,4}})));
  Modelica.Blocks.Sources.Step step(offset=1, startTime=3000)
    annotation (Placement(transformation(extent={{-160,20},{-140,40}})));
equation
  connect(mEE_FCwPH.port_b_liquid_cond, Purified_Water.ports[1])
    annotation (Line(points={{46,-6},{58,-6}}, color={0,127,255}));
  connect(Tube_Inlet.ports[1], mEE_FCwPH.port_a_steam) annotation (Line(
        points={{-80,24},{-42,24},{-42,26},{-34,26}}, color={0,127,255}));
  connect(Liquid_Return.ports[1], mEE_FCwPH.port_b_liquid_return)
    annotation (Line(points={{-80,-16},{-44,-16},{-44,-6},{-34,-6}}, color=
          {0,127,255}));
  connect(step.y, Tube_Inlet.m_flow_in) annotation (Line(points={{-139,30},
          {-139,32},{-100,32}}, color={0,0,127}));
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
      StopTime=5000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end MEE_FC_test3;
