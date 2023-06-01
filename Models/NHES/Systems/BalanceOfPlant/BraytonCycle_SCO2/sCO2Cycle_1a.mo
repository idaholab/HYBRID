within NHES.Systems.BalanceOfPlant.BraytonCycle_SCO2;
model sCO2Cycle_1a
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=8e6);
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{144,58},{164,78}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater1(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    Q_gen=600e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-28,0})));
  GasTurbine.Turbine.Turbine turbine(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    pstart_out=8471000,
    Tstart_in=1023.15,
    Tstart_out=908.05,
    eta0=0.9,
    PR0=2.3126,
    w0=2867)
    annotation (Placement(transformation(
        extent={{18,14},{-18,-14}},
        rotation=180,
        origin={4,-10})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    m_flow=2867,
    T=857.05,
    nPorts=1)
    annotation (Placement(transformation(extent={{-68,-8},{-52,8}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary3(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    p=8471000,
    nPorts=1)
    annotation (Placement(transformation(extent={{46,-5},{34,7}})));
equation
  connect(Heater1.port_b, turbine.inlet) annotation (Line(points={{-22,0},{-6.8,0},{-6.8,1.2}},  color={0,127,255}));
  connect(Heater1.port_a, boundary2.ports[1]) annotation (Line(points={{-34,0},{-52,0}},   color={0,127,255}));
  connect(boundary3.ports[1], turbine.outlet)
    annotation (Line(points={{34,1},{28,1},{28,1.2},{14.8,1.2}},     color={0,127,255}));
end sCO2Cycle_1a;
