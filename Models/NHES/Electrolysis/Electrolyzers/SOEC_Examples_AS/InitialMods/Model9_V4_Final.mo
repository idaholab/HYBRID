within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model Model9_V4_Final
  //extends Modelica.Icons.Example;

  BaseClasses.OxEonV7_Complex SOEC(V_cathode=0.001, V_anode=0.001)
                                   annotation (Placement(transformation(extent={{194,-55},{224,-25}})));
  Modelica.Blocks.Sources.Constant
                               DCPowerControl(k=30000)
                  annotation (Placement(transformation(extent={{114,-50},{134,-30}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowOut(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{292,-18},{312,2}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow
                                           prescribedPowerFlow
    annotation (Placement(transformation(extent={{144,-50},{164,-30}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume AirTH(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,                                                                 use_HeatPort=true)
    annotation (Placement(transformation(extent={{166,-102},{186,-82}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow
                                                      boundary(use_port=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={176,-122})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AirTempSensor(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={190,-66})));
  TRANSFORM.Controls.LimPID PID_Air(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{230,-100},{210,-120}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=790 + 273.15) annotation (Placement(transformation(extent={{262,-120},{242,-100}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume FuelTH(redeclare package Medium =
        Media.Electrolysis.CathodeGas,
    p_start(displayUnit="kPa") = 103800,
    X_start={0.0122804,0.9877196},                                                                      use_HeatPort=true)
    annotation (Placement(transformation(extent={{170,28},{190,8}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow
                                                      boundary1(use_port=true)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={180,46})));
  TRANSFORM.Controls.LimPID PID_Fuel(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{220,50},{200,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=790 + 273.15)
                                                                        annotation (Placement(transformation(extent={{252,50},{232,70}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelTempSensor(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={192,-6})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CathodeOutTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)                                                                                                   annotation (Placement(transformation(extent={{248,-18},
            {268,2}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeOutTemp(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)                                                                                                 annotation (Placement(transformation(extent={{270,-78},
            {290,-58}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink1(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-78,286})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn2(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{20,102},{40,122}})));
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
    m_flow_start_2=13.47/3600) annotation (Placement(transformation(extent={{78,120},{58,140}})));
  Modelica.Fluid.Sources.Boundary_pT anodeSink1(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 101300,
    T=504.55,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-222})));
  Modelica.Fluid.Sensors.MassFlowRate AnodeFlowIn1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{274,-184},{254,-164}})));
  Modelica.Fluid.Sources.MassFlowSource_T anodeFeed2(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=293.15) annotation (Placement(transformation(extent={{-2,-134},{18,-114}})));
  Modelica.Fluid.Sensors.MassFlowRate AnodeFlowIn3(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{26,-134},{46,-114}})));
  Modelica.Blocks.Sources.Constant AnodeFlowControl2(k=5.555e-3)   annotation (Placement(transformation(extent={{-40,-126},{-20,-106}})));
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
    m_flow_start_2=5.555e-3) annotation (Placement(transformation(extent={{86,-118},{66,-138}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeOutTemp1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)                                                                                                 annotation (Placement(transformation(extent={{124,
            -102},{144,-82}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOut_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{138,8},{158,28}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelHXOutTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{30,124},{10,144}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AirHXOutTemp(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,-174})));
  TRANSFORM.Fluid.Volumes.SimpleVolume condenser(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p_start(displayUnit="kPa") = 103800,
    X_start={0.0122804,0.9877196},
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (                                                                                                   V=0.1),
    use_HeatPort=true) annotation (Placement(transformation(extent={{-8,146},{-32,122}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary3(T=313.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,162})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-46,124},{-66,144}})));
  Modelica.Fluid.Sensors.MassFractions X_H2(redeclare package Medium =
        Media.Electrolysis.CathodeGas,                                                                substanceName="H2")
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-88,156})));
  Modelica.Fluid.Sensors.MassFractions X_H2O(redeclare package Medium =
        Media.Electrolysis.CathodeGas,                                                                 substanceName="H2O")
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-68,184})));
  Modelica.Blocks.Math.Product mH2_sep_out annotation (Placement(
        transformation(
        extent={{9,-9},{-9,9}},
        rotation=0,
        origin={-123,217})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-78,222})));
  Modelica.Blocks.Math.Product mH2O_sep_out annotation (Placement(
        transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-33,217})));
  Modelica.Fluid.Sources.MassFlowSource_T H2_flowOut(
    use_m_flow_in=true,
    m_flow=1.35415,
    use_T_in=true,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    nPorts=1,
    use_X_in=false,
    T=618.329) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-160,228})));
  Modelica.Fluid.Sources.MassFlowSource_T H2O_flowOut(
    use_m_flow_in=true,
    m_flow=1.35415,
    use_T_in=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_X_in=false,
    T=618.329,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={12,229})));
  Modelica.Fluid.Sources.Boundary_pT CondensateSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={46,229})));
  Modelica.Fluid.Sources.Boundary_pT H2Product(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-200,230})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-90,258})));
  Modelica.Fluid.Sources.MassFlowSource_T SteamFlowControl(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=0.908085*5,
    T=414.15,
    nPorts=1) annotation (Placement(transformation(extent={{-174,-12},{-154,8}})));
  Modelica.Blocks.Sources.Constant SteamFlowIn(k=3.6919e-003) annotation (Placement(transformation(extent={{-208,-2},{-188,18}})));
  Modelica.Fluid.Sensors.MassFractions X_H1(redeclare package Medium =
        Media.Electrolysis.CathodeGas,                                                                substanceName="H2")
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-64,60})));
  Modelica.Fluid.Sources.MassFlowSource_T H2_recycleFeed(
    use_m_flow_in=true,
    m_flow=1.35415,
    use_T_in=false,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    nPorts=1,
    use_X_in=false,
    T=414.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-182,50})));
  Separator.Combiner_H2_Steam combiner_FinalV2_1 annotation (Placement(transformation(extent={{-106,26},{-86,46}})));
  TRANSFORM.Controls.LimPID PID_Fuel1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{-114,84},{-134,104}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0.0123)      annotation (Placement(transformation(extent={{-86,84},{-106,104}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTemp1(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-44,12},{-24,32}})));
  Modelica.Fluid.Sensors.MassFlowRate SteamFlowMeasure(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-144,-12},{-124,8}})));
  Modelica.Fluid.Sensors.MassFlowRate H2_recycleMassFlowRate(redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.H2)
    annotation (Placement(transformation(extent={{-154,40},{-134,60}})));
  Modelica.Fluid.Interfaces.FluidPort_b H2Port_Out(redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.H2)
    annotation (Placement(transformation(extent={{-222,-256},{-202,-236}}),
                                                                         iconTransformation(extent={{-10,-100},{10,-80}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=mH2_sep_out.y - H2_recycleMassFlowRate.m_flow)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-220,-152})));
  Modelica.Fluid.Sources.MassFlowSource_T H2_feed2(
    use_m_flow_in=true,
    m_flow=1.35415,
    use_T_in=false,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    nPorts=1,
    use_X_in=false,
    T=414.15)  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-212,-198})));
  Modelica.Fluid.Sources.Boundary_pT H2Product1(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-252,-276})));
equation
  connect(DCPowerControl.y, prescribedPowerFlow.P_flow) annotation (Line(points={{135,-40},{146,-40}},
                                                                                                     color={0,0,127}));
  connect(AirTH.heatPort, boundary.port) annotation (Line(points={{176,-98},{176,-112}},color={191,0,0}));
  connect(AirTH.port_b, AirTempSensor.port_a) annotation (Line(points={{182,-92},{190,-92},{190,-76}}, color={0,127,255}));
  connect(AirTempSensor.port_b, SOEC.AnodeIn) annotation (Line(points={{190,-56},{190,-47.5},{194,-47.5}},
                                                                                                         color={0,127,255}));
  connect(PID_Air.u_s, realExpression.y) annotation (Line(points={{232,-110},{241,-110}},
                                                                                      color={0,0,127}));
  connect(AirTempSensor.T, PID_Air.u_m) annotation (Line(points={{193.6,-66},{220,-66},{220,-98}},
                                                                                                 color={0,0,127}));
  connect(boundary.Q_flow_ext, PID_Air.y) annotation (Line(points={{176,-126},{176,-136},{204,-136},{204,-110},{209,-110}},
                                                                                                                   color={0,0,127}));
  connect(boundary1.port,FuelTH. heatPort) annotation (Line(points={{180,36},{180,24}}, color={191,0,0}));
  connect(FuelTempSensor.port_b, SOEC.CathodeIn) annotation (Line(points={{192,-16},{192,-32.5},{194,-32.5}},
                                                                                                         color={0,127,255}));
  connect(PID_Fuel.y, boundary1.Q_flow_ext) annotation (Line(points={{199,60},{180,60},{180,50}},color={0,0,127}));
  connect(PID_Fuel.u_m, FuelTempSensor.T) annotation (Line(points={{210,48},{210,-6},{195.6,-6}},
                                                                                              color={0,0,127}));
  connect(realExpression1.y, PID_Fuel.u_s) annotation (Line(points={{231,60},{222,60}},
                                                                                      color={0,0,127}));
  connect(cathodeFlowOut.port_a, CathodeOutTemp.port_b) annotation (Line(points={{292,-8},{268,-8}},color={0,127,255}));
  connect(CathodeOutTemp.port_a, SOEC.CathodeOut) annotation (Line(points={{248,-8},{234,-8},{234,-32.5},{224,-32.5}},
                                                                                                               color={0,127,255}));
  connect(AnodeOutTemp.port_a, SOEC.AnodeOut) annotation (Line(points={{270,-68},{234,-68},{234,-47.5},{224,-47.5}},
                                                                                                               color={0,127,255}));
  connect(cathodeFlowIn2.port_b,FuelHX. port_a2) annotation (Line(points={{40,112},{52,112},{52,126},{58,126}},
                                                                                                            color={0,127,255}));
  connect(cathodeFlowOut.port_b, FuelHX.port_a1) annotation (Line(points={{312,-8},{318,-8},{318,162},{88,162},{88,134},{78,134}},
                                                                                                         color={0,127,255}));
  connect(anodeFeed2.ports[1], AnodeFlowIn3.port_a) annotation (Line(points={{18,-124},{26,-124}},     color={0,127,255}));
  connect(anodeFeed2.m_flow_in,AnodeFlowControl2. y) annotation (Line(points={{-2,-116},{-19,-116}},
                                                                                                  color={0,0,127}));
  connect(AnodeFlowIn1.port_b, AirHX.port_a1) annotation (Line(points={{254,-174},{96,-174},{96,-132},{86,-132}},      color={0,127,255}));
  connect(AnodeFlowIn3.port_b, AirHX.port_a2) annotation (Line(points={{46,-124},{66,-124}},     color={0,127,255}));
  connect(AnodeOutTemp.port_b, AnodeFlowIn1.port_a) annotation (Line(points={{290,-68},{316,-68},{316,-174},{274,-174}},
                                                                                                                     color={0,127,255}));
  connect(AirHX.port_b2, AnodeOutTemp1.port_a) annotation (Line(points={{86,-124},{118,-124},{118,-92},{124,-92}},
                                                                                                color={0,127,255}));
  connect(AnodeOutTemp1.port_b, AirTH.port_a)
    annotation (Line(points={{144,-92},{170,-92}},                                           color={0,127,255}));
  connect(ShellOut_Temp.port_b, FuelTH.port_a) annotation (Line(points={{158,18},{174,18}}, color={0,127,255}));
  connect(FuelTH.port_b, FuelTempSensor.port_a) annotation (Line(points={{186,18},{192,18},{192,4}},  color={0,127,255}));
  connect(FuelHX.port_b2, ShellOut_Temp.port_a) annotation (Line(points={{78,126},{132,126},{132,18},{138,18}},
                                                                                                          color={0,127,255}));
  connect(FuelHX.port_b1, FuelHXOutTemp.port_a) annotation (Line(points={{58,134},{30,134}}, color={0,127,255}));
  connect(AirHX.port_b1, AirHXOutTemp.port_a) annotation (Line(points={{66,-132},{60,-132},{60,-164}}, color={0,127,255}));
  connect(AirHXOutTemp.port_b, anodeSink1.ports[1]) annotation (Line(points={{60,-184},{60,-212}},   color={0,127,255}));
  connect(FuelHXOutTemp.port_b, condenser.port_a) annotation (Line(points={{10,134},{-12.8,134}},color={0,127,255}));
  connect(condenser.heatPort, boundary3.port) annotation (Line(points={{-20,141.2},{-20,152}},color={191,0,0}));
  connect(condenser.port_b, SinkTemp.port_a) annotation (Line(points={{-27.2,134},{-46,134},{-46,134}},
                                                                                              color={0,127,255}));
  connect(H2O_flowOut.m_flow_in, mH2O_sep_out.y) annotation (Line(points={{2,221},{-12,221},{-12,217},{-23.1,217}}, color={0,0,127}));
  connect(H2_flowOut.ports[1], H2Product.ports[1]) annotation (Line(points={{-170,228},{-180,228},{-180,230},{-190,230}},
                                                                                                    color={0,127,255}));
  connect(H2O_flowOut.ports[1], CondensateSink.ports[1]) annotation (Line(points={{22,229},{22,230},{36,230},{36,229}}, color={0,127,255}));
  connect(SteamFlowControl.m_flow_in, SteamFlowIn.y) annotation (Line(points={{-174,6},{-180,6},{-180,8},{-187,8}},
                                                                                                  color={0,0,127}));
  connect(combiner_FinalV2_1.Outlet, X_H1.port) annotation (Line(points={{-96,27},{-96,22},{-64,22},{-64,50}},     color={0,127,255}));
  connect(X_H1.Xi, PID_Fuel1.u_m) annotation (Line(points={{-53,60},{-40,60},{-40,82},{-124,82}},              color={0,0,127}));
  connect(realExpression2.y, PID_Fuel1.u_s) annotation (Line(points={{-107,94},{-112,94}}, color={0,0,127}));
  connect(H2_recycleFeed.m_flow_in, PID_Fuel1.y) annotation (Line(points={{-192,58},{-192,94},{-135,94}}, color={0,0,127}));
  connect(X_H1.port, SinkTemp1.port_a) annotation (Line(points={{-64,50},{-64,22},{-44,22}},    color={0,127,255}));
  connect(SteamFlowControl.ports[1], SteamFlowMeasure.port_a) annotation (Line(points={{-154,-2},{-144,-2}}, color={0,127,255}));
  connect(SteamFlowMeasure.port_b, combiner_FinalV2_1.liquidInlet)
    annotation (Line(points={{-124,-2},{-112,-2},{-112,30},{-106,30}}, color={0,127,255}));
  connect(H2_recycleFeed.ports[1], H2_recycleMassFlowRate.port_a) annotation (Line(points={{-172,50},{-154,50}}, color={0,127,255}));
  connect(H2_recycleMassFlowRate.port_b, combiner_FinalV2_1.vaporInlet)
    annotation (Line(points={{-134,50},{-112,50},{-112,42},{-106,42}}, color={0,127,255}));
  connect(cathodeFlowIn2.port_a, SinkTemp1.port_b) annotation (Line(points={{20,112},{-10,112},{-10,22},{-24,22}},  color={0,127,255}));
  connect(H2_feed2.ports[1], H2Port_Out) annotation (Line(points={{-212,-208},{-212,-246}},      color={0,127,255}));
  connect(SinkTemp.port_b, massFlowRate.port_a) annotation (Line(points={{-66,134},{-78,134},{-78,212}}, color={0,127,255}));
  connect(massFlowRate.port_b, temperature.port) annotation (Line(points={{-78,232},{-78,258},{-80,258}}, color={0,127,255}));
  connect(temperature.port, cathodeSink1.ports[1]) annotation (Line(points={{-80,258},{-80,276},{-78,276}}, color={0,127,255}));
  connect(SinkTemp.port_b, X_H2.port) annotation (Line(points={{-66,134},{-78,134},{-78,156}}, color={0,127,255}));
  connect(SinkTemp.port_b, X_H2O.port) annotation (Line(points={{-66,134},{-78,134},{-78,184}}, color={0,127,255}));
  connect(H2_flowOut.m_flow_in, mH2_sep_out.y) annotation (Line(points={{-150,220},{-150,218},{-132.9,218},{-132.9,217}}, color={0,0,127}));
  connect(X_H2O.Xi, mH2O_sep_out.u2) annotation (Line(points={{-68,195},{-68,204},{-52,204},{-52,211.6},{-43.8,211.6}}, color={0,0,127}));
  connect(X_H2.Xi, mH2_sep_out.u2) annotation (Line(points={{-88,167},{-88,196},{-112.2,196},{-112.2,211.6}}, color={0,0,127}));
  connect(massFlowRate.m_flow, mH2_sep_out.u1) annotation (Line(points={{-89,222},{-100,222},{-100,222.4},{-112.2,222.4}}, color={0,0,127}));
  connect(massFlowRate.m_flow, mH2O_sep_out.u1)
    annotation (Line(points={{-89,222},{-100,222},{-100,208},{-56,208},{-56,232},{-43.8,232},{-43.8,222.4}}, color={0,0,127}));
  connect(H2_flowOut.T_in, temperature.T) annotation (Line(points={{-148,224},{-148,240},{-90,240},{-90,251}}, color={0,0,127}));
  connect(temperature.T, H2O_flowOut.T_in) annotation (Line(points={{-90,251},{-90,240},{-12,240},{-12,225},{0,225}}, color={0,0,127}));
  connect(realExpression3.y, H2_feed2.m_flow_in) annotation (Line(points={{-220,-163},{-220,-188}},
                                                                                                color={0,0,127}));
  connect(prescribedPowerFlow.port_b, SOEC.DC_PowerIn) annotation (Line(
      points={{164,-40},{194,-40}},
      color={255,0,0},
      thickness=0.5));
  connect(H2Product1.ports[1], H2Port_Out) annotation (Line(points={{-242,-276},{-212,-276},{-212,-246}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-300,
            -300},{300,300}},
Icon(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}})))),
            experiment(StopTime=1e3,__Dymola_Algorithm="Dassl"),
  Documentation(info="<html>
  <p>Model of a solid oxide electrolysis cell based on OxEon design. The design has a total of 780 cells based on 65 cells in 12 stacks (65 x 12 = 780). 
  Some of the cell design parameters are chosen from publicly available information for the OxEon Energy SOEC. These details can be found at https://doi.org/10.1016/j.ijhydene.2020.04.074 </p>
    <p>The model's steady state conditions are acquired from an Aspen HYSYS model, which are then used as initial conditions for this model</p>
    <p>The SOEC has a constant area specific resistance (ASR) and operating voltage. These numbers will be modified in the future to account for cell degradation using empirical data.
    The Gibbs Free Energy term is calculated using NASA's 7-term polynomial.
    For any questions regarding the model, please contact Amey Shigrekar (amey.shigreka@inl.gov)</p>        
 </html>"));
end Model9_V4_Final;
