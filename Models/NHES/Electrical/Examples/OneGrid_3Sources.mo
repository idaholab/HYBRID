within NHES.Electrical.Examples;
model OneGrid_3Sources

  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.BooleanPulse booleanPulse(
    width=50,
    period=5,
    startTime=5)
    annotation (Placement(transformation(extent={{54,72},{74,92}})));
  Generator generator
    annotation (Placement(transformation(extent={{0,44},{20,64}})));
  Modelica.Fluid.Sources.Boundary_ph
                source(             h=3.3e6,
    nPorts=1,
    use_p_in=true,
    p=15000000,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-70,64},{-50,84}})));
  Modelica.Fluid.Sources.Boundary_ph
              sink(         h=2e6,
    nPorts=1,
    use_p_in=true,
    p=10000,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,24},{-10,4}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=1,
    height=+79e5,
    offset=1e5,
    startTime=3)
    annotation (Placement(transformation(extent={{40,-4},{20,16}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-70e5,
    duration=1,
    offset=150e5,
    startTime=1)
    annotation (Placement(transformation(extent={{-100,72},{-80,92}})));
  Fluid.Machines.SteamTurbineStodola
                      steamTurbine(
    eta_mech=0.98,
    m_flow_start=70,
    m_flow_nominal=70,
    Kt_constant=0.0025,
    h_a_start=3.3e6,
    h_b_start=2e6,
    use_T_start=false,
    use_NominalInlet=false,
    redeclare model Eta_wetSteam =
        Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (eta_nominal=
           0.92),
    p_a_start=15000000,
    p_b_start=100000)
    annotation (Placement(transformation(extent={{-30,44},{-10,64}})));
  inner Fluid.System_TP      system
    annotation (Placement(transformation(extent={{80,72},{100,92}})));
  Generator generator1
    annotation (Placement(transformation(extent={{0,-42},{20,-22}})));
  Modelica.Fluid.Sources.Boundary_ph
                source1(            h=3.3e6,
    nPorts=1,
    use_p_in=true,
    p=15000000,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-70,-22},{-50,-2}})));
  Modelica.Fluid.Sources.Boundary_ph
              sink1(        h=2e6,
    nPorts=1,
    use_p_in=true,
    p=10000,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,-62},{-10,-82}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    duration=1,
    height=+79e5,
    offset=1e5,
    startTime=3)
    annotation (Placement(transformation(extent={{40,-90},{20,-70}})));
  Modelica.Blocks.Sources.Ramp ramp3(
    height=-70e5,
    duration=1,
    startTime=1,
    offset=100e5)
    annotation (Placement(transformation(extent={{-100,-14},{-80,6}})));
  Fluid.Machines.SteamTurbineStodola
                      steamTurbine1(
    eta_mech=0.98,
    m_flow_start=70,
    m_flow_nominal=70,
    Kt_constant=0.0025,
    h_a_start=3.3e6,
    h_b_start=2e6,
    use_T_start=false,
    use_NominalInlet=false,
    redeclare model Eta_wetSteam =
        Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (eta_nominal=
           0.92),
    p_a_start=10000000,
    p_b_start=100000)
    annotation (Placement(transformation(extent={{-30,-42},{-10,-22}})));
  Grid grid(
    Q_nominal=10e10,
    droop=0.05,
    n=3) annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Utilities.Visualizers.displayReal display(x=grid.ports[2].W/10^6)
    annotation (Placement(transformation(extent={{58,22},{78,42}})));
  Utilities.Visualizers.displayReal display2(x=grid.ports[2].f)
    annotation (Placement(transformation(extent={{80,22},{100,42}})));
  Utilities.Visualizers.displayReal display4(x=grid.ports[1].W/10^6)
    annotation (Placement(transformation(extent={{58,34},{78,54}})));
  Utilities.Visualizers.displayReal display5(x=grid.ports[1].f)
    annotation (Placement(transformation(extent={{80,34},{100,54}})));
  Utilities.Visualizers.displayReal display1(x=grid.ports[3].W/10^6)
    annotation (Placement(transformation(extent={{58,10},{78,30}})));
  Utilities.Visualizers.displayReal display3(x=grid.ports[3].f)
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
equation
  connect(source.ports[1],steamTurbine.portHP)  annotation (Line(points={{-50,74},
          {-40,74},{-40,60},{-30,60}},        color={0,127,255}));
  connect(steamTurbine.portLP,sink. ports[1]) annotation (Line(points={{-13,44},
          {-13,14},{-10,14}},      color={0,127,255}));
  connect(ramp.y,source. p_in)
    annotation (Line(points={{-79,82},{-76,82},{-72,82}}, color={0,0,127}));
  connect(ramp1.y,sink. p_in)
    annotation (Line(points={{19,6},{19,6},{12,6}},       color={0,0,127}));
  connect(steamTurbine.shaft_b, generator.shaft_a)
    annotation (Line(points={{-10,54},{0,54}}, color={0,0,0}));
  connect(source1.ports[1], steamTurbine1.portHP) annotation (Line(points={{-50,
          -12},{-40,-12},{-40,-26},{-30,-26}}, color={0,127,255}));
  connect(steamTurbine1.portLP, sink1.ports[1]) annotation (Line(points={{-13,-42},
          {-13,-72},{-10,-72}}, color={0,127,255}));
  connect(ramp2.y, sink1.p_in)
    annotation (Line(points={{19,-80},{19,-80},{12,-80}}, color={0,0,127}));
  connect(steamTurbine1.shaft_b, generator1.shaft_a)
    annotation (Line(points={{-10,-32},{0,-32}}, color={0,0,0}));
  connect(ramp3.y, source1.p_in)
    annotation (Line(points={{-79,-4},{-72,-4},{-72,-4}}, color={0,0,127}));
  connect(generator.portElec, grid.ports[1]) annotation (Line(points={{20,54},{
          50,54},{50,2.66667},{80,2.66667}}, color={255,0,0}));
  connect(generator1.portElec, grid.ports[2]) annotation (Line(points={{20,-32},
          {50,-32},{50,-2.22045e-016},{80,-2.22045e-016}}, color={255,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OneGrid_3Sources;
