within NHES.Desalination.MEE.Examples;
model MEE_ss_test_delay_fix
  "Test of a single effect with constant UA"
  parameter Modelica.Units.SI.Area AX =1e4;

  Multiple_Effect.MEE_FC_ss_delay_fix
                            mEE_FC_ss_delay_fix(
                                      redeclare replaceable Data.MEE_Data
      data(nE=12, T_b_in=333.15),
    Cs_in=0.03,
    firstOrder(y_start=1.1),
    Ax={4.2e4,9.2e4,7.6e4,6.7e4,5.8e4,5.1e4,AX,1e4,1e4,1e4,1e4,1e4},
    ramp(height=-1.2, offset=1.2),
    HXs(m_start=1.1),
    HX(m_start=1.2))
    annotation (Placement(transformation(extent={{-38,-44},{42,36}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=0.001,
    T=396.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-120,12},{-100,32}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-120,-38},{-100,-18}})));
equation
  connect(boundary1.ports[1], mEE_FC_ss_delay_fix.port_b)
    annotation (Line(points={{-100,-28},{-38,-28}}, color={0,127,255}));
  connect(mEE_FC_ss_delay_fix.port_a, boundary.ports[1]) annotation (Line(
        points={{-38,20},{-70,20},{-70,22},{-100,22}}, color={0,127,255}));
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
      StopTime=150,
      Interval=0.5,
      __Dymola_Algorithm="Esdirk45a"));
end MEE_ss_test_delay_fix;
