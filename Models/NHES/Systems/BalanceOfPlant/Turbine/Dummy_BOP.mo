within NHES.Systems.BalanceOfPlant.Turbine;
model Dummy_BOP
  extends BaseClasses.Partial_SubSystem;

  extends NHES.Icons.DummyIcon;

  NHES.Electrical.Sources.PowerSource toBOP_elec(W=980)
    annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  Modelica.Fluid.Sources.Boundary_pT To_BOP(
    p(displayUnit="MPa") = 5800000,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T(displayUnit="K") = 591,
    nPorts=1) annotation (Placement(transformation(extent={{-50,30},{-70,50}})));
  Modelica.Fluid.Sources.MassFlowSource_T From_BOP(
    m_flow=492.8,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T(displayUnit="K") = 497,
    nPorts=1)
    annotation (Placement(transformation(extent={{-52,-30},{-72,-50}})));
equation
  connect(toBOP_elec.portElec_a, portElec_b)
    annotation (Line(points={{72,0},{100,0}}, color={17,163,27}));
  connect(From_BOP.ports[1], port_b) annotation (Line(points={{-72,-40},{-86,
          -40},{-100,-40}}, color={0,127,255}));
  connect(To_BOP.ports[1], port_a) annotation (Line(points={{-70,40},{-100,40},
          {-100,40}}, color={0,127,255}));
annotation(defaultComponentName="BOP");
end Dummy_BOP;
