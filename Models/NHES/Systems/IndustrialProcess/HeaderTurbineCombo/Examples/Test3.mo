within NHES.Systems.IndustrialProcess.HeaderTurbineCombo.Examples;
model Test3
  extends Modelica.Icons.Example;

  StepDownTurbines IP(redeclare ED_Inputs ED)
    annotation (Placement(transformation(extent={{-40,-42},{40,38}})));

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    nPorts=1,
    use_p_in=false,
    p=IP.data.p_HP,
    T=IP.data.T_HP,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-150,30},{-130,50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    nPorts=1,
    p=IP.data.p_LP,
    T=IP.data.T_LP,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-150,-50},{-130,-30}})));
  TRANSFORM.Electrical.Grid grid(Q_nominal=1e10)
    annotation (Placement(transformation(extent={{68,-14},{88,6}})));
equation
  connect(boundary.ports[1], IP.port_a) annotation (Line(points={{-130,40},{
          -86,40},{-86,14},{-40,14}}, color={0,127,255}));
  connect(boundary1.ports[1], IP.port_b) annotation (Line(points={{-130,-40},
          {-86,-40},{-86,-18.8},{-40,-18.8}}, color={0,127,255}));
  connect(IP.portElec, grid.port) annotation (Line(points={{40,-2},{54,-2},{
          54,-4},{68,-4}}, color={255,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false));
end Test3;
