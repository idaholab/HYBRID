within NHES.Systems.EnergyManifold.SteamManifold.Examples;
model SteamManifold_Test
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.Boundary_pT sink_1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p(displayUnit="MPa") = EM.port_b1_nominal.p,
    T(displayUnit="K") = EM.port_b1_nominal.T)
    annotation (Placement(transformation(extent={{-80,-2},{-60,-22}})));
  Modelica.Fluid.Sources.MassFlowSource_T source_1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=EM.port_a1_nominal.m_flow,
    T(displayUnit="K") = EM.port_a1_nominal.T)
    annotation (Placement(transformation(extent={{-80,2},{-60,22}})));
  Modelica.Fluid.Sources.Boundary_pT sink_2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p(displayUnit="MPa") = EM.port_b2_nominal.p,
    T(displayUnit="K") = EM.port_b2_nominal.T)
    annotation (Placement(transformation(extent={{80,2},{60,22}})));
  Modelica.Fluid.Sources.MassFlowSource_T source_2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=EM.port_a2_nominal.m_flow,
    T(displayUnit="K") = EM.port_a2_nominal.T)
    annotation (Placement(transformation(extent={{80,-2},{60,-22}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     sink_3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=-EM.port_a3_nominal.m_flow,
    T(displayUnit="K") = EM.port_b3_nominal.T)
    annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
  Modelica.Fluid.Sources.MassFlowSource_T source_3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=EM.port_a3_nominal.m_flow,
    T(displayUnit="K") = EM.port_a3_nominal.T)
                                             annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-60})));
  SteamManifold EM
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
equation

  connect(EM.port_b2, sink_2.ports[1])
    annotation (Line(points={{30,12},{60,12}}, color={0,127,255}));
  connect(EM.port_a2, source_2.ports[1])
    annotation (Line(points={{30,-12},{46,-12},{60,-12}}, color={0,127,255}));
  connect(EM.port_a1, source_1.ports[1])
    annotation (Line(points={{-30,12},{-45,12},{-60,12}}, color={0,127,255}));
  connect(EM.port_b1, sink_1.ports[1]) annotation (Line(points={{-30,-12},{-46,
          -12},{-60,-12}}, color={0,127,255}));
  connect(source_3.ports[1], EM.port_a3) annotation (Line(points={{-20,-60},{-12,
          -60},{-12,-30}}, color={0,127,255}));
  connect(sink_3.ports[1], EM.port_b3)
    annotation (Line(points={{20,-60},{12,-60},{12,-30}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput);
end SteamManifold_Test;
