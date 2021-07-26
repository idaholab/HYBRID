within NHES.Systems.EnergyStorage.Latent_Heat_TES.Examples;
model Test2_Dimensions
  extends Modelica.Icons.Example;
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    use_T_in=true,
    m_flow=2.65*10E-3,
    T=343.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000,
    h=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,0})));
  FVM_LHTES fVM_LHTES(
    Length=7.5*0.0254,
    ThicknessF=0.097*0.0254,
    ThicknessT=0.028*0.0254,
    ThicknessP=0.251*0.0254) annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=41,
    width=500,
    falling=50,
    period=1050,
    offset=273.15 + 19)
    annotation (Placement(transformation(extent={{-86,26},{-66,46}})));
equation
  connect(boundary.ports[1], fVM_LHTES.port_a)
    annotation (Line(points={{-24,0},{-4,-0.1}}, color={0,127,255}));
  connect(fVM_LHTES.port_b, boundary1.ports[1])
    annotation (Line(points={{16,0.1},{40,6.66134e-16}}, color={0,127,255}));
  connect(trapezoid.y, boundary.T_in)
    annotation (Line(points={{-65,36},{-52,36},{-52,4},{-46,4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test2_Dimensions;
