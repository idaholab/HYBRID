within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS;
model HTSEExample
  extends Modelica.Icons.Example;

  HTSE_Recycle_Seperator HTSE
    annotation (Placement(transformation(extent={{-34,-36},{38,36}})));
  Modelica.Blocks.Sources.Ramp DCPowerControl(
    height=5000,
    duration=200,
    offset=30000,
    startTime=5000)
                  annotation (Placement(transformation(extent={{-140,-10},{-120,10}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow
                                           prescribedPowerFlow
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T SteamSource(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    m_flow=0.908085*5,
    T=414.15,
    X={0,1},
    nPorts=1) annotation (Placement(transformation(extent={{-100,52},{-80,72}})));
  Modelica.Blocks.Sources.Constant SteamFlowIn(k=3.6929e-003) annotation (Placement(transformation(extent={{-140,62},
            {-120,82}})));
  Modelica.Fluid.Sources.Boundary_pT H2ProductOut(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    p(displayUnit="bar") = 100000,
    T=313.15,
    X(displayUnit="1") = {0.6786,0.3214},
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={126,0})));

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
    p(displayUnit="bar") = 100000,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={34,-90})));
  Modelica.Fluid.Sources.Boundary_pT CondensateSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="bar") = 100000,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-104,25})));
  Modelica.Blocks.Sources.RealExpression Efficiency(y=(141.88e6*H2_MassFlowRate.m_flow
        *X_H1.Xi)/(-prescribedPowerFlow.port_b.W + HTSE.boundary.Q_flow_ext +
        HTSE.boundary1.Q_flow_ext + HTSE.pump_recycle.W))
    annotation (Placement(transformation(extent={{-26,60},{16,90}})));
  Modelica.Fluid.Sensors.MassFlowRate H2_MassFlowRate(redeclare package Medium
      = Media.Electrolysis.CathodeGas) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,0})));
  Modelica.Fluid.Sensors.MassFractions X_H1(redeclare package Medium =
        Media.Electrolysis.CathodeGas, substanceName="H2")
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={94,14})));
  Modelica.Blocks.Interaction.Show.RealValue realValue
    annotation (Placement(transformation(extent={{40,64},{64,86}})));
equation
  connect(DCPowerControl.y,prescribedPowerFlow. P_flow) annotation (Line(points={{-119,0},{-98,0}},  color={0,0,127}));
  connect(SteamSource.m_flow_in, SteamFlowIn.y) annotation (Line(points={{-100,70},
          {-110,70},{-110,72},{-119,72}},                                                      color={0,0,127}));
  connect(SteamSource.ports[1], HTSE.SteamIn_Port) annotation (Line(points={{-80,62},{-40,62},{-40,28.8},{-34,28.8}},  color={0,127,255}));
  connect(prescribedPowerFlow.port_b, HTSE.electricalLoad)
    annotation (Line(
      points={{-80,0},{-34,0}},
      color={255,0,0},
      thickness=0.5));
  connect(AirSource.m_flow_in, AirFlowIn.y) annotation (Line(points={{-100,-70},{-119,-70}}, color={0,0,127}));
  connect(HTSE.AirIn_Port, AirSource.ports[1]) annotation (Line(points={{-5.2,-35.28},{-4,-35.28},{-4,-78},{-80,-78}}, color={0,127,255}));
  connect(HTSE.AirPort_Out, AirExhaust.ports[1]) annotation (Line(points={{9.2,-35.28},{8,-35.28},{8,-70},{34,-70},{34,-80}}, color={0,127,255}));
  connect(CondensateSink.ports[1], HTSE.WaterPort_Out) annotation (Line(points=
          {{-94,25},{-44,25},{-44,14.4},{-34,14.4}}, color={0,127,255}));
  connect(HTSE.H2Port_Out, H2_MassFlowRate.port_a)
    annotation (Line(points={{37.28,0},{50,0}}, color={0,127,255}));
  connect(H2_MassFlowRate.port_b, H2ProductOut.ports[1]) annotation (Line(
        points={{70,0},{110,0},{110,-1},{116,-1}}, color={0,127,255}));
  connect(X_H1.port, H2ProductOut.ports[2]) annotation (Line(points={{94,4},{94,
          0},{110,0},{110,1},{116,1}}, color={0,127,255}));
  connect(Efficiency.y, realValue.numberPort)
    annotation (Line(points={{18.1,75},{38.2,75}}, color={0,0,127}));
  annotation (
  experiment(
      StopTime=1000,
      Interval=1,
      __Dymola_Algorithm="Esdirk45a"));
end HTSEExample;
