within NHES.Systems.IndustrialProcess.IP_Dummy.Examples;
model Test
  extends Modelica.Icons.Example;

  Components.Simple_IP
                  simple_IP(
    redeclare NHES.Systems.IndustrialProcess.IP_Dummy.CS.CS_Dummy CS,
    redeclare NHES.Systems.IndustrialProcess.IP_Dummy.CS.ED_Dummy ED,
    redeclare NHES.Systems.IndustrialProcess.IP_Dummy.Data.Data_Dummy data,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_input=500000,
    T_ref_output=363.15,
    T_ref_input=623.15,
    m_input_nom=15)
    annotation (Placement(transformation(extent={{-40,-42},{40,38}})));

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    use_T_in=true,
    m_flow=12,
    T=603.15,
    nPorts=1) annotation (Placement(transformation(extent={{-92,4},{-72,24}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000,
    T=283.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=20,
    f=1/600,
    offset=330 + 273.15)
    annotation (Placement(transformation(extent={{-154,4},{-134,24}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=6,
    rising=300,
    width=600,
    falling=300,
    period=1800,
    offset=12,
    startTime=1200)
    annotation (Placement(transformation(extent={{-158,38},{-138,58}})));
equation
  connect(simple_IP.port_b, boundary1.ports[1]) annotation (Line(points={{-40,
          -18.8},{-114,-18.8},{-114,-20},{-120,-20}}, color={0,127,255}));
  connect(simple_IP.port_a, boundary.ports[1])
    annotation (Line(points={{-40,14},{-72,14}}, color={0,127,255}));
  connect(sine.y, boundary.T_in) annotation (Line(points={{-133,14},{-102,14},{
          -102,18},{-94,18}}, color={0,0,127}));
  connect(trapezoid.y, boundary.m_flow_in)
    annotation (Line(points={{-137,48},{-92,48},{-92,22}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=18640,
      __Dymola_NumberOfIntervals=12200,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput);
end Test;
