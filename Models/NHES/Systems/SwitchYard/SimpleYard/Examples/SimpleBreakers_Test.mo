within NHES.Systems.SwitchYard.SimpleYard.Examples;
model SimpleBreakers_Test
  import NHES;
  extends Modelica.Icons.Example;
  NHES.Systems.SwitchYard.SimpleYard.SimpleBreakers SY(W_balance_total=sum(
        W_balance.y))
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Electrical.Generator
            generator
    annotation (Placement(transformation(extent={{-78,40},{-58,60}})));
  Modelica.Fluid.Sources.Boundary_ph
                source(             h=3.3e6,
    nPorts=1,
    use_p_in=true,
    p=15000000,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-148,60},{-128,80}})));
  Modelica.Fluid.Sources.Boundary_ph
              sink(         h=2e6,
    nPorts=1,
    use_p_in=true,
    p=10000,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-68,20},{-88,0}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=1,
    height=+79e5,
    offset=1e5,
    startTime=3)
    annotation (Placement(transformation(extent={{-38,-8},{-58,12}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-70e5,
    duration=1,
    offset=150e5,
    startTime=1)
    annotation (Placement(transformation(extent={{-178,68},{-158,88}})));
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
    annotation (Placement(transformation(extent={{-108,40},{-88,60}})));
  inner Fluid.System_TP      system
    annotation (Placement(transformation(extent={{2,68},{22,88}})));
  Electrical.Generator
            generator1
    annotation (Placement(transformation(extent={{-78,-46},{-58,-26}})));
  Modelica.Fluid.Sources.Boundary_ph
                source1(            h=3.3e6,
    nPorts=1,
    use_p_in=true,
    p=15000000,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-148,-26},{-128,-6}})));
  Modelica.Fluid.Sources.Boundary_ph
              sink1(        h=2e6,
    nPorts=1,
    use_p_in=true,
    p=10000,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-68,-66},{-88,-86}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    duration=1,
    height=+79e5,
    offset=1e5,
    startTime=3)
    annotation (Placement(transformation(extent={{-38,-94},{-58,-74}})));
  Modelica.Blocks.Sources.Ramp ramp3(
    height=-70e5,
    duration=1,
    startTime=1,
    offset=100e5)
    annotation (Placement(transformation(extent={{-178,-18},{-158,2}})));
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
    annotation (Placement(transformation(extent={{-108,-46},{-88,-26}})));
  Electrical.Battery batteryLevel_0_1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-24,-50})));
  Modelica.Blocks.Sources.Constant const(k=5000000)
    annotation (Placement(transformation(extent={{0,-94},{-20,-74}})));
  Electrical.Battery batteryLevel_0_2
    annotation (Placement(transformation(extent={{30,-70},{10,-50}})));
  Modelica.Blocks.Sources.Ramp     const1(
    duration=5,
    startTime=2,
    height=1e7)
    annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
  Electrical.Grid             grid(
    Q_nominal=10e10, n=1)
             annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.Constant W_balance[6](k={1e5,1e6,1e7,0,0,0})
    annotation (Placement(transformation(extent={{50,30},{30,50}})));

equation

  connect(source.ports[1],steamTurbine.portHP)  annotation (Line(points={{-128,70},
          {-118,70},{-118,56},{-108,56}},     color={0,127,255}));
  connect(steamTurbine.portLP,sink. ports[1]) annotation (Line(points={{-91,40},
          {-91,10},{-88,10}},      color={0,127,255}));
  connect(ramp1.y,sink. p_in)
    annotation (Line(points={{-59,2},{-59,2},{-66,2}},    color={0,0,127}));
  connect(steamTurbine.shaft_b,generator. shaft_a)
    annotation (Line(points={{-88,50},{-78,50}},
                                               color={0,0,0}));
  connect(source1.ports[1],steamTurbine1. portHP) annotation (Line(points={{-128,
          -16},{-118,-16},{-118,-30},{-108,-30}},
                                               color={0,127,255}));
  connect(steamTurbine1.portLP,sink1. ports[1]) annotation (Line(points={{-91,-46},
          {-91,-76},{-88,-76}}, color={0,127,255}));
  connect(ramp2.y,sink1. p_in)
    annotation (Line(points={{-59,-84},{-59,-84},{-66,-84}},
                                                          color={0,0,127}));
  connect(steamTurbine1.shaft_b,generator1. shaft_a)
    annotation (Line(points={{-88,-36},{-78,-36}},
                                                 color={0,0,0}));
  connect(ramp3.y,source1. p_in)
    annotation (Line(points={{-157,-8},{-150,-8}},        color={0,0,127}));
  connect(ramp.y, source.p_in)
    annotation (Line(points={{-157,78},{-150,78},{-150,78}}, color={0,0,127}));
  connect(generator1.portElec, SY.portElec_a2) annotation (Line(points={{-58,-36},
          {-30,-36},{-30,0},{-20,0}}, color={255,0,0}));
  connect(generator.portElec, SY.portElec_a1) annotation (Line(points={{-58,50},
          {-30,50},{-30,8},{-20,8}}, color={255,0,0}));
  connect(const.y, batteryLevel_0_1.W_setpoint) annotation (Line(points={{-21,-84},
          {-24,-84},{-24,-60.8}}, color={0,0,127}));
  connect(const1.y, batteryLevel_0_2.W_setpoint) annotation (Line(points={{39,-60},
          {30.8,-60},{30.8,-60}}, color={0,0,127}));
  connect(batteryLevel_0_2.port, SY.portElec_b1)
    annotation (Line(points={{10,-60},{0,-60},{0,-20}}, color={255,0,0}));
  connect(batteryLevel_0_1.port, SY.portElec_a3) annotation (Line(points={{-24,-40},
          {-24,-40},{-24,-14},{-24,-8},{-20,-8}}, color={255,0,0}));
  connect(SY.portElec_Grid, grid.ports[1]) annotation (Line(points={{20,0},{30.2,
          0},{30.2,0},{40,0}},        color={255,0,0}));

  annotation (experiment(StopTime=10, __Dymola_NumberOfIntervals=100));
end SimpleBreakers_Test;
