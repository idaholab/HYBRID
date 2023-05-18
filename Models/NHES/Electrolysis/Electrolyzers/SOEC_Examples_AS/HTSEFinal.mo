within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS;
model HTSEFinal
  extends Modelica.Icons.Example;

  NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.HTSE_V4_Final HTSE annotation (Placement(transformation(extent={{-34,-36},{38,36}})));
  Modelica.Blocks.Sources.Constant
                               DCPowerControl(k=30000)
                  annotation (Placement(transformation(extent={{-172,-10},{-152,10}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow
                                           prescribedPowerFlow
    annotation (Placement(transformation(extent={{-142,-10},{-122,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T SteamSource(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=0.908085*5,
    T=414.15,
    nPorts=1) annotation (Placement(transformation(extent={{-150,50},{-130,70}})));
  Modelica.Blocks.Sources.Constant SteamFlowIn(k=3.6929e-003) annotation (Placement(transformation(extent={{-192,58},{-172,78}})));
  Modelica.Fluid.Sources.Boundary_pT H2ProductOut(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={100,0})));
  Modelica.Fluid.Sources.Boundary_pT CondensateSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-118,27})));
  Modelica.Fluid.Sources.MassFlowSource_T AirSource(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    m_flow=0.908085*5,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(extent={{-56,-88},{-36,-68}})));
  Modelica.Blocks.Sources.Constant AnodeFlowControl2(k=5.555e-3)   annotation (Placement(transformation(extent={{-94,-80},{-74,-60}})));
  Modelica.Fluid.Sources.Boundary_pT AirExhaust(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 101300,
    T=504.55,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={34,-86})));
equation
  connect(DCPowerControl.y,prescribedPowerFlow. P_flow) annotation (Line(points={{-151,0},{-140,0}}, color={0,0,127}));
  connect(SteamSource.m_flow_in, SteamFlowIn.y) annotation (Line(points={{-150,68},{-171,68}}, color={0,0,127}));
  connect(H2ProductOut.ports[1], HTSE.H2Port_Out) annotation (Line(points={{90,0},{37.28,0}}, color={0,127,255}));
  connect(SteamSource.ports[1], HTSE.SteamIn_Port) annotation (Line(points={{-130,60},{-40,60},{-40,28.8},{-34,28.8}}, color={0,127,255}));
  connect(prescribedPowerFlow.port_b, HTSE.electricalLoad)
    annotation (Line(
      points={{-122,0},{-34,0}},
      color={255,0,0},
      thickness=0.5));
  connect(CondensateSink.ports[1], HTSE.WaterPort_Out) annotation (Line(points={{-108,27},{-42,27},{-42,14.4},{-34,14.4}}, color={0,127,255}));
  connect(AirSource.m_flow_in, AnodeFlowControl2.y) annotation (Line(points={{-56,-70},{-73,-70}}, color={0,0,127}));
  connect(HTSE.AirIn_Port, AirSource.ports[1]) annotation (Line(points={{-5.2,-35.28},{-4,-35.28},{-4,-78},{-36,-78}}, color={0,127,255}));
  connect(HTSE.AirPort_Out, AirExhaust.ports[1]) annotation (Line(points={{9.2,-35.28},{8,-35.28},{8,-70},{34,-70},{34,-76}}, color={0,127,255}));
  annotation (
  experiment(StopTime=1e5,__Dymola_Algorithm="Dassl"));
end HTSEFinal;
