within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model WorkingModel_v3
  extends Modelica.Icons.Example;

  BaseClasses.OxEonV6_Complex SOEC annotation (Placement(transformation(extent={{-12,-17},{18,13}})));
  Modelica.Blocks.Sources.Ramp DCPowerControl(
    duration=30,
    startTime=20,
    height=0,
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
    T=1055.95,
    nPorts=1)
    annotation (Placement(transformation(extent={{-68,-64},{-48,-44}})));
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
    annotation (Placement(transformation(extent={{46,20},{66,40}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow
                                           prescribedPowerFlow
    annotation (Placement(transformation(extent={{-68,-12},{-48,8}})));
  Modelica.Blocks.Sources.Constant CathodeFlowControl(k=0.003741667) annotation (Placement(transformation(extent={{-118,54},{-98,74}})));
  Modelica.Blocks.Sources.Constant AnodeFlowControl(k=0.005556) annotation (Placement(transformation(extent={{-120,-56},{-100,-36}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume AirTH(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,                                                                 use_HeatPort=true)
    annotation (Placement(transformation(extent={{-40,-64},{-20,-44}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow
                                                      boundary(use_port=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-84})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T( redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-16,-28})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{24,-62},{4,-82}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=790 + 273.15) annotation (Placement(transformation(extent={{56,-82},{36,-62}})));
equation
  connect(cathodeFeed.ports[1],cathodeFlowIn. port_a) annotation (Line(
        points={{-64,56},{-54,56}},       color={0,127,255}));
  connect(cathodeFlowOut.port_b,cathodeSink. ports[1])
    annotation (Line(points={{66,30},{80,30}},      color={0,127,255}));
  connect(DCPowerControl.y, prescribedPowerFlow.P_flow) annotation (Line(points={{-77,-2},{-66,-2}}, color={0,0,127}));
  connect(cathodeFlowIn.port_b, SOEC.CathodeIn) annotation (Line(points={{-34,56},{-14,56},{-14,5.5},{-12,5.5}}, color={0,127,255}));
  connect(cathodeFlowOut.port_a, SOEC.CathodeOut) annotation (Line(points={{46,30},{28,30},{28,5.5},{18,5.5}}, color={0,127,255}));
  connect(anodeSink.ports[1], SOEC.AnodeOut) annotation (Line(points={{80,-30},{28,-30},{28,-9.5},{18,-9.5}}, color={0,127,255}));
  connect(prescribedPowerFlow.port_b, SOEC.electricalLoad)
    annotation (Line(
      points={{-48,-2},{-12,-2}},
      color={255,0,0},
      thickness=0.5));
  connect(cathodeFeed.m_flow_in, CathodeFlowControl.y) annotation (Line(points={{-84,64},{-97,64}}, color={0,0,127}));
  connect(anodeFeed.m_flow_in, AnodeFlowControl.y) annotation (Line(points={{-68,-46},{-99,-46}}, color={0,0,127}));
  connect(anodeFeed.ports[1], AirTH.port_a) annotation (Line(points={{-48,-54},{-36,-54}}, color={0,127,255}));
  connect(AirTH.heatPort, boundary.port) annotation (Line(points={{-30,-60},{-30,-74}}, color={191,0,0}));
  connect(AirTH.port_b, sensor_T.port_a) annotation (Line(points={{-24,-54},{-16,-54},{-16,-38}}, color={0,127,255}));
  connect(sensor_T.port_b, SOEC.AnodeIn) annotation (Line(points={{-16,-18},{-16,-9.5},{-12,-9.5}}, color={0,127,255}));
  connect(PID.u_s, realExpression.y) annotation (Line(points={{26,-72},{35,-72}}, color={0,0,127}));
  connect(sensor_T.T, PID.u_m) annotation (Line(points={{-12.4,-28},{14,-28},{14,-60}}, color={0,0,127}));
  connect(boundary.Q_flow_ext, PID.y) annotation (Line(points={{-30,-88},{-30,-98},{-2,-98},{-2,-72},{3,-72}}, color={0,0,127}));
  annotation (experiment(StopTime=1e6),
  Documentation(info="<html>
  <p>Model of a solid oxide electrolysis cell based on OxEon design. The design has a total of 780 cells based on 65 cells in 12 stacks (65 x 12 = 780). 
  Some of the cell design parameters are chosen from publicly available information for the OxEon Energy SOEC. These details can be found at https://doi.org/10.1016/j.ijhydene.2020.04.074 </p>
    <p>The model's steady state conditions are acquired from an Aspen HYSYS model, which are then used as initial conditions for this model</p>
    <p>The SOEC has a constant area specific resistance (ASR) and operating voltage. These numbers will be modified in the future to account for cell degradation using empirical data.
    The Gibbs Free Energy term is calculated using NASA's 7-term polynomial.
    For any questions regarding the model, please contact Amey Shigrekar (amey.shigreka@inl.gov)</p>        
 </html>"));
end WorkingModel_v3;
