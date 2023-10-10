within NHES.Desalination.MEE.Examples;
model MEE_Test_SS "Test of a single effect with constant UA"

  MEE.Multiple_Effect.MEE_FC_ss_UTextnode mEE_FC_ss_UTextnode(redeclare replaceable
                  MEE.Data.MEE_Data data(nE=12, p_h=150000), Cs_in=0.03)
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=2,
    h=2700e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-120,14},{-100,34}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-120,-34},{-100,-14}})));
equation
  connect(boundary1.ports[1], mEE_FC_ss_UTextnode.port_b)
    annotation (Line(points={{-100,-24},{-40,-24}}, color={0,127,255}));
  connect(mEE_FC_ss_UTextnode.port_a, boundary.ports[1])
    annotation (Line(points={{-40,24},{-100,24}}, color={0,127,255}));
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
end MEE_Test_SS;
