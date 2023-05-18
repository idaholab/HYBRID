within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model WorkingModel123
  extends Modelica.Icons.Example;

  BaseClasses.OxEonV6_Complex                                 SOEC annotation (Placement(transformation(extent={{-12,-17},{18,13}})));
  Modelica.Blocks.Sources.Ramp DCPowerControl(
    duration=30,
    startTime=20,
    height=0*10000,
    offset=30000) annotation (Placement(transformation(extent={{-98,-12},{-78,8}})));
  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=1063.15)
    annotation (Placement(transformation(extent={{-84,46},{-64,66}})));
  Modelica.Fluid.Sources.MassFlowSource_T anodeFeed(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    m_flow=4.65587*5,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    T=1063.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-70,-64},{-50,-44}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p(displayUnit="Pa") = 103299.8,
    T=1063.15)
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
  Modelica.Fluid.Sources.Boundary_pT anodeSink(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    p(displayUnit="Pa") = 103299.8,
    T=1063.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-54,46},{-34,66}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowOut(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{54,20},{74,40}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow
                                           prescribedPowerFlow
    annotation (Placement(transformation(extent={{-68,-12},{-48,8}})));
  Modelica.Blocks.Sources.Constant CathodeFlowControl(k=0.003741667) annotation (Placement(transformation(extent={{-118,54},{-98,74}})));
  Modelica.Blocks.Sources.Constant AnodeFlowControl(k=0.005556) annotation (Placement(transformation(extent={{-120,-56},{-100,-36}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CathodeOutTemp( redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)                                                                                 annotation (Placement(transformation(extent={{28,20},
            {48,40}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeOutTemp( redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air)                                                                               annotation (Placement(transformation(extent={{38,-40},{58,-20}})));
equation
  connect(cathodeFeed.ports[1],cathodeFlowIn. port_a) annotation (Line(
        points={{-64,56},{-54,56}},       color={0,127,255}));
  connect(cathodeFlowOut.port_b,cathodeSink. ports[1])
    annotation (Line(points={{74,30},{80,30}},      color={0,127,255}));
  connect(DCPowerControl.y, prescribedPowerFlow.P_flow) annotation (Line(points={{-77,-2},{-66,-2}}, color={0,0,127}));
  connect(cathodeFlowIn.port_b, SOEC.CathodeIn) annotation (Line(points={{-34,56},{-14,56},{-14,5.5},{-12,5.5}}, color={0,127,255}));
  connect(anodeFeed.ports[1], SOEC.AnodeIn) annotation (Line(points={{-50,-54},{-16,-54},{-16,-9.5},{-12,-9.5}}, color={0,127,255}));
  connect(prescribedPowerFlow.port_b, SOEC.electricalLoad)
    annotation (Line(
      points={{-48,-2},{-12,-2}},
      color={255,0,0},
      thickness=0.5));
  connect(cathodeFeed.m_flow_in, CathodeFlowControl.y) annotation (Line(points={{-84,64},{-97,64}}, color={0,0,127}));
  connect(anodeFeed.m_flow_in, AnodeFlowControl.y) annotation (Line(points={{-70,-46},{-99,-46}}, color={0,0,127}));
  connect(cathodeFlowOut.port_a, CathodeOutTemp.port_b) annotation (Line(points={{54,30},{48,30}}, color={0,127,255}));
  connect(CathodeOutTemp.port_a, SOEC.CathodeOut) annotation (Line(points={{28,30},{18,30},{18,5.5}}, color={0,127,255}));
  connect(anodeSink.ports[1], AnodeOutTemp.port_b) annotation (Line(points={{80,-30},{58,-30}}, color={0,127,255}));
  connect(AnodeOutTemp.port_a, SOEC.AnodeOut) annotation (Line(points={{38,-30},{24,-30},{24,-9.5},{18,-9.5}}, color={0,127,255}));
end WorkingModel123;
