within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS;
model HTSEFinal
  extends Modelica.Icons.Example;

  NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.HTSE_V4_Final HTSE annotation (Placement(transformation(extent={{-34,-36},{38,36}})));
  Modelica.Blocks.Sources.Ramp DCPowerControl(
    height=10000,
    duration=100,
    offset=30000,
    startTime=500)
                  annotation (Placement(transformation(extent={{-140,-10},{-120,10}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow
                                           prescribedPowerFlow
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T SteamSource(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=0.908085*5,
    T=414.15,
    nPorts=1) annotation (Placement(transformation(extent={{-100,52},{-80,72}})));
  Modelica.Blocks.Sources.Constant SteamFlowIn(k=3.6929e-003) annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
  Modelica.Fluid.Sources.Boundary_pT H2ProductOut(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    p(displayUnit="Pa") = 101300,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={90,0})));
  Modelica.Fluid.Sources.Boundary_pT CondensateSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-90,27})));
  Modelica.Fluid.Sources.MassFlowSource_T AirSource(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    m_flow=0.908085*5,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(extent={{-100,-88},{-80,-68}})));
  Modelica.Blocks.Sources.Constant AirFlowIn(k=5.555e-3) annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  Modelica.Fluid.Sources.Boundary_pT AirExhaust(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 101300,
    T=504.55,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={34,-90})));
equation
  connect(DCPowerControl.y,prescribedPowerFlow. P_flow) annotation (Line(points={{-119,0},{-98,0}},  color={0,0,127}));
  connect(SteamSource.m_flow_in, SteamFlowIn.y) annotation (Line(points={{-100,70},{-119,70}}, color={0,0,127}));
  connect(H2ProductOut.ports[1], HTSE.H2Port_Out) annotation (Line(points={{80,0},{37.28,0}}, color={0,127,255}));
  connect(SteamSource.ports[1], HTSE.SteamIn_Port) annotation (Line(points={{-80,62},{-40,62},{-40,28.8},{-34,28.8}},  color={0,127,255}));
  connect(prescribedPowerFlow.port_b, HTSE.electricalLoad)
    annotation (Line(
      points={{-80,0},{-34,0}},
      color={255,0,0},
      thickness=0.5));
  connect(CondensateSink.ports[1], HTSE.WaterPort_Out) annotation (Line(points={{-80,27},{-42,27},{-42,14.4},{-34,14.4}},  color={0,127,255}));
  connect(AirSource.m_flow_in, AirFlowIn.y) annotation (Line(points={{-100,-70},{-119,-70}}, color={0,0,127}));
  connect(HTSE.AirIn_Port, AirSource.ports[1]) annotation (Line(points={{-5.2,-35.28},{-4,-35.28},{-4,-78},{-80,-78}}, color={0,127,255}));
  connect(HTSE.AirPort_Out, AirExhaust.ports[1]) annotation (Line(points={{9.2,-35.28},{8,-35.28},{8,-70},{34,-70},{34,-80}}, color={0,127,255}));
  annotation (
  experiment(StopTime=1e5,__Dymola_Algorithm="Dassl"));
end HTSEFinal;
