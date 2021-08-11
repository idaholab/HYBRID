within NHES.Systems.EnergyStorage.Concrete_Solid_Media.Examples;
model Dual_Pipe_CTES
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.MassFlowRate shell_flow_shim=1.5;
  parameter Modelica.Units.SI.MassFlowRate tube_flow_shim=1.5;
  Components.Dual_Pipe_Model CTES(
    nY=7,
    nX=9,
    tau=0.05,
    nPipes=250,
    dX=150,
    dY=0.3,
    redeclare package TES_Med = BaseClasses.HeatCrete,
    Hot_Con_Start=443.15,
    Cold_Con_Start=363.15)
    annotation (Placement(transformation(extent={{-34,-28},{36,42}})));

  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Condensate(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=2000000,
    h=500e3,
    nPorts=1) annotation (Placement(transformation(extent={{100,48},{80,68}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Discharge_Exit(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=110000,
    h=2500e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-94,-38},{-74,-18}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Charge_Source(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=2130000,
    h=3000e3,
    nPorts=1) annotation (Placement(transformation(extent={{-116,4},{-96,24}})));
  Modelica.Blocks.Sources.Trapezoid Charge_Signal(
    amplitude=1,
    rising=900,
    width=28100,
    falling=900,
    period=86400,
    offset=0,
    startTime=90000)
    annotation (Placement(transformation(extent={{-102,36},{-82,56}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort Condensate_out(redeclare
      package Medium = Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{18,70},{56,46}})));
  TRANSFORM.Fluid.Valves.ValveLinear Charge_Valve(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=100000,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{-78,0},{-46,32}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort Discharge_out(redeclare
      package Medium = Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-28,-38},{-60,-18}})));
  Modelica.Blocks.Sources.Trapezoid Discharge_Signal(
    amplitude=1,
    rising=900,
    width=28100,
    falling=900,
    period=86400,
    offset=0,
    startTime=135000)
    annotation (Placement(transformation(extent={{44,20},{64,40}})));
  TRANSFORM.Fluid.Valves.ValveLinear Discharge_Valve(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=150000,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{112,-12},{74,26}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Discharge_Source(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=250000,
    h=500e3,
    nPorts=1) annotation (Placement(transformation(extent={{152,-4},{132,16}})));
equation

  connect(Charge_Valve.port_a, Charge_Source.ports[1]) annotation (Line(points=
          {{-78,16},{-88,16},{-88,14},{-96,14}}, color={0,127,255}));
  connect(Charge_Signal.y, Charge_Valve.opening)
    annotation (Line(points={{-81,46},{-62,46},{-62,28.8}}, color={0,0,127}));
  connect(Discharge_Source.ports[1], Discharge_Valve.port_a) annotation (Line(
        points={{132,6},{126,6},{126,7},{112,7}}, color={0,127,255}));
  connect(Discharge_Signal.y, Discharge_Valve.opening)
    annotation (Line(points={{65,30},{93,30},{93,22.2}}, color={0,0,127}));
  connect(CTES.Charge_Inlet, Charge_Valve.port_b) annotation (Line(points={{-26.3,
          14.7},{-38,14.7},{-38,18},{-44,18},{-44,16},{-46,16}}, color={0,127,255}));
  connect(CTES.Charge_Outlet, Condensate_out.port_a) annotation (Line(points={{11.5,
          28.7},{11.5,28},{14,28},{14,58},{18,58}}, color={0,127,255}));
  connect(CTES.Discharge_Inlet, Discharge_Valve.port_b) annotation (Line(points=
         {{28.3,6.3},{68.15,6.3},{68.15,7},{74,7}}, color={0,127,255}));
  connect(CTES.Discharge_Outlet, Discharge_out.port_a) annotation (Line(points={
          {-4.6,-12.6},{-12,-12.6},{-12,-28},{-28,-28}}, color={0,127,255}));
  connect(Condensate_out.port_b, Condensate.ports[1])
    annotation (Line(points={{56,58},{80,58}}, color={0,127,255}));
  connect(Discharge_out.port_b, Discharge_Exit.ports[1])
    annotation (Line(points={{-60,-28},{-74,-28}}, color={0,127,255}));

  annotation (experiment(
      StopTime=864000,
      __Dymola_NumberOfIntervals=1957,
      __Dymola_Algorithm="Esdirk45a"),
    Diagram(coordinateSystem(extent={{-120,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-120,-100},{160,100}})));
end Dual_Pipe_CTES;
