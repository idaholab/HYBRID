within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model Model5_HXInclusion
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
    T=983.25)
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
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-60,46},{-40,66}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowOut(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{108,20},{128,40}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow
                                           prescribedPowerFlow
    annotation (Placement(transformation(extent={{-68,-12},{-48,8}})));
  Modelica.Blocks.Sources.Constant CathodeFlowControl(k=0.003741667) annotation (Placement(transformation(extent={{-120,54},{-100,74}})));
  Modelica.Blocks.Sources.Constant AnodeFlowControl(k=0.005556) annotation (Placement(transformation(extent={{-120,-56},{-100,-36}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume AirTH(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,                                                                 use_HeatPort=true)
    annotation (Placement(transformation(extent={{-40,-64},{-20,-44}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow
                                                      boundary(use_port=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-84})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AirTempSensor(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-16,-28})));
  TRANSFORM.Controls.LimPID PID_Air(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{24,-62},{4,-82}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=790 + 273.15) annotation (Placement(transformation(extent={{56,-82},{36,-62}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume AirTH1(redeclare package Medium =
        Media.Electrolysis.CathodeGas,                                                                  use_HeatPort=true)
    annotation (Placement(transformation(extent={{-36,66},{-16,46}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow
                                                      boundary1(use_port=true)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-26,84})));
  TRANSFORM.Controls.LimPID PID_Fuel(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{14,88},{-6,108}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=790 + 273.15)
                                                                        annotation (Placement(transformation(extent={{46,88},{26,108}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelTempSensor(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-14,32})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CathodeOutTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)                                                                                                   annotation (Placement(transformation(extent={{64,20},
            {84,40}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeOutTemp(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)                                                                                                 annotation (Placement(transformation(extent={{64,-40},
            {84,-20}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink1(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=423.65,
    nPorts=1)
    annotation (Placement(transformation(extent={{278,150},{258,170}})));
  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed2(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=414.15)
    annotation (Placement(transformation(extent={{282,112},{262,132}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn2(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{252,112},{232,132}})));
  Modelica.Blocks.Sources.Constant CathodeFlowControl2(k=13.47/3600) annotation (Placement(transformation(extent={{320,120},{300,140}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink2(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=981.25,
    nPorts=1)
    annotation (Placement(transformation(extent={{134,108},{154,128}})));
  TRANSFORM.HeatExchangers.Simple_HX FuelHX(
    redeclare package Medium_1 = Media.Electrolysis.CathodeGas,
    redeclare package Medium_2 = Media.Electrolysis.CathodeGas,
    nV=20,
    V_1=0.01,
    V_2=0.01,
    UA=148.9,
    p_a_start_1(displayUnit="kPa") = 103300,
    p_b_start_1(displayUnit="kPa") = 103100,
    T_a_start_1=1063.15,
    T_b_start_1=423.65,
    m_flow_start_1=6.379/3600,
    p_a_start_2(displayUnit="kPa") = 105300,
    p_b_start_2(displayUnit="kPa") = 105000,
    T_a_start_2=414.15,
    T_b_start_2=981.25,
    X_a_start_2={0.0122804,0.9877196},
    X_b_start_2={0.0122804,0.9877196},
    m_flow_start_2=13.47/3600) annotation (Placement(transformation(extent={{192,126},{212,146}})));
  Modelica.Fluid.Sources.Boundary_pT anodeSink1(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 101300,
    T=504.55,
    nPorts=1) annotation (Placement(transformation(extent={{298,-82},{278,-62}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{116,-86},{136,-66}})));
  Modelica.Fluid.Sources.MassFlowSource_T anodeFeed2(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=293.15) annotation (Placement(transformation(extent={{302,-120},{282,-100}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn3(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{272,-120},{252,-100}})));
  Modelica.Blocks.Sources.Constant AnodeFlowControl2(k=5.555e-3)   annotation (Placement(transformation(extent={{340,-112},{320,-92}})));
  Modelica.Fluid.Sources.Boundary_pT anodeSink2(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 103300,
    T=1053.15,
    nPorts=1) annotation (Placement(transformation(extent={{62,-150},{82,-130}})));
  TRANSFORM.HeatExchangers.Simple_HX AirHX(
    redeclare package Medium_1 = Media.Electrolysis.AnodeGas_air,
    redeclare package Medium_2 = Media.Electrolysis.AnodeGas_air,
    nV=20,
    V_1=0.01,
    V_2=0.01,
    UA=72.75,
    p_a_start_1(displayUnit="kPa") = 103300,
    p_b_start_1(displayUnit="kPa") = 103100,
    T_a_start_1=1063.15,
    T_b_start_1=504.55,
    m_flow_start_1=7.524e-3,
    p_a_start_2(displayUnit="kPa") = 103300,
    p_b_start_2(displayUnit="kPa") = 103200,
    T_a_start_2=293.15,
    T_b_start_2=1053.15,
    m_flow_start_2=5.555e-3) annotation (Placement(transformation(extent={{212,-106},{232,-86}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeOutTemp1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)                                                                                                 annotation (Placement(transformation(extent={{182,
            -110},{162,-90}})));
equation
  connect(cathodeFeed.ports[1],cathodeFlowIn. port_a) annotation (Line(
        points={{-64,56},{-60,56}},       color={0,127,255}));
  connect(DCPowerControl.y, prescribedPowerFlow.P_flow) annotation (Line(points={{-77,-2},{-66,-2}}, color={0,0,127}));
  connect(prescribedPowerFlow.port_b, SOEC.electricalLoad)
    annotation (Line(
      points={{-48,-2},{-12,-2}},
      color={255,0,0},
      thickness=0.5));
  connect(cathodeFeed.m_flow_in, CathodeFlowControl.y) annotation (Line(points={{-84,64},{-99,64}}, color={0,0,127}));
  connect(anodeFeed.m_flow_in, AnodeFlowControl.y) annotation (Line(points={{-68,-46},{-99,-46}}, color={0,0,127}));
  connect(anodeFeed.ports[1], AirTH.port_a) annotation (Line(points={{-48,-54},{-36,-54}}, color={0,127,255}));
  connect(AirTH.heatPort, boundary.port) annotation (Line(points={{-30,-60},{-30,-74}}, color={191,0,0}));
  connect(AirTH.port_b, AirTempSensor.port_a) annotation (Line(points={{-24,-54},{-16,-54},{-16,-38}}, color={0,127,255}));
  connect(AirTempSensor.port_b, SOEC.AnodeIn) annotation (Line(points={{-16,-18},{-16,-9.5},{-12,-9.5}}, color={0,127,255}));
  connect(PID_Air.u_s, realExpression.y) annotation (Line(points={{26,-72},{35,-72}}, color={0,0,127}));
  connect(AirTempSensor.T, PID_Air.u_m) annotation (Line(points={{-12.4,-28},{14,-28},{14,-60}}, color={0,0,127}));
  connect(boundary.Q_flow_ext, PID_Air.y) annotation (Line(points={{-30,-88},{-30,-98},{-2,-98},{-2,-72},{3,-72}}, color={0,0,127}));
  connect(cathodeFlowIn.port_b, AirTH1.port_a) annotation (Line(points={{-40,56},{-32,56}}, color={0,127,255}));
  connect(boundary1.port, AirTH1.heatPort) annotation (Line(points={{-26,74},{-26,62}}, color={191,0,0}));
  connect(AirTH1.port_b, FuelTempSensor.port_a) annotation (Line(points={{-20,56},{-14,56},{-14,42}}, color={0,127,255}));
  connect(FuelTempSensor.port_b, SOEC.CathodeIn) annotation (Line(points={{-14,22},{-14,5.5},{-12,5.5}}, color={0,127,255}));
  connect(PID_Fuel.y, boundary1.Q_flow_ext) annotation (Line(points={{-7,98},{-26,98},{-26,88}}, color={0,0,127}));
  connect(PID_Fuel.u_m, FuelTempSensor.T) annotation (Line(points={{4,86},{4,32},{-10.4,32}}, color={0,0,127}));
  connect(realExpression1.y, PID_Fuel.u_s) annotation (Line(points={{25,98},{16,98}}, color={0,0,127}));
  connect(cathodeFlowOut.port_a, CathodeOutTemp.port_b) annotation (Line(points={{108,30},{84,30}}, color={0,127,255}));
  connect(CathodeOutTemp.port_a, SOEC.CathodeOut) annotation (Line(points={{64,30},{28,30},{28,5.5},{18,5.5}}, color={0,127,255}));
  connect(AnodeOutTemp.port_a, SOEC.AnodeOut) annotation (Line(points={{64,-30},{28,-30},{28,-9.5},{18,-9.5}}, color={0,127,255}));
  connect(cathodeFeed2.ports[1],cathodeFlowIn2. port_a) annotation (Line(points={{262,122},{252,122}},
                                                                                                     color={0,127,255}));
  connect(cathodeFeed2.m_flow_in,CathodeFlowControl2. y) annotation (Line(points={{282,130},{299,130}},color={0,0,127}));
  connect(FuelHX.port_b1, cathodeSink1.ports[1]) annotation (Line(points={{212,140},{248,140},{248,160},{258,160}}, color={0,127,255}));
  connect(cathodeFlowIn2.port_b,FuelHX. port_a2) annotation (Line(points={{232,122},{224,122},{224,132},{212,132}},
                                                                                                            color={0,127,255}));
  connect(FuelHX.port_b2,cathodeSink2. ports[1]) annotation (Line(points={{192,132},{162,132},{162,118},{154,118}},
                                                                                                               color={0,127,255}));
  connect(cathodeFlowOut.port_b, FuelHX.port_a1) annotation (Line(points={{128,30},{128,140},{192,140}}, color={0,127,255}));
  connect(anodeFeed2.ports[1],cathodeFlowIn3. port_a) annotation (Line(points={{282,-110},{272,-110}},
                                                                                                   color={0,127,255}));
  connect(anodeFeed2.m_flow_in,AnodeFlowControl2. y) annotation (Line(points={{302,-102},{319,-102}},
                                                                                                  color={0,0,127}));
  connect(cathodeFlowIn1.port_b,AirHX. port_a1) annotation (Line(points={{136,-76},{202,-76},{202,-92},{212,-92}},color={0,127,255}));
  connect(AirHX.port_b1, anodeSink1.ports[1]) annotation (Line(points={{232,-92},{268,-92},{268,-72},{278,-72}}, color={0,127,255}));
  connect(cathodeFlowIn3.port_b,AirHX. port_a2) annotation (Line(points={{252,-110},{244,-110},{244,-100},{232,-100}},
                                                                                                               color={0,127,255}));
  connect(AnodeOutTemp.port_b, cathodeFlowIn1.port_a) annotation (Line(points={{84,-30},{106,-30},{106,-76},{116,-76}}, color={0,127,255}));
  connect(AirHX.port_b2, AnodeOutTemp1.port_a) annotation (Line(points={{212,-100},{182,-100}}, color={0,127,255}));
  connect(AnodeOutTemp1.port_b, anodeSink2.ports[1]) annotation (Line(points={{162,-100},{88,-100},{88,-140},{82,-140}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}})),
            experiment(StopTime=1e3),
  Documentation(info="<html>
  <p>Model of a solid oxide electrolysis cell based on OxEon design. The design has a total of 780 cells based on 65 cells in 12 stacks (65 x 12 = 780). 
  Some of the cell design parameters are chosen from publicly available information for the OxEon Energy SOEC. These details can be found at https://doi.org/10.1016/j.ijhydene.2020.04.074 </p>
    <p>The model's steady state conditions are acquired from an Aspen HYSYS model, which are then used as initial conditions for this model</p>
    <p>The SOEC has a constant area specific resistance (ASR) and operating voltage. These numbers will be modified in the future to account for cell degradation using empirical data.
    The Gibbs Free Energy term is calculated using NASA's 7-term polynomial.
    For any questions regarding the model, please contact Amey Shigrekar (amey.shigreka@inl.gov)</p>        
 </html>"));
end Model5_HXInclusion;
