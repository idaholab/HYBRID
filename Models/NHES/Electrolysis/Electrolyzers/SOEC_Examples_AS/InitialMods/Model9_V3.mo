within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model Model9_V3
  extends Modelica.Icons.Example;

  BaseClasses.OxEonV7_Complex SOEC(V_cathode=0.001, V_anode=0.001)
                                   annotation (Placement(transformation(extent={{196,-75},{226,-45}})));
  Modelica.Blocks.Sources.Constant
                               DCPowerControl(k=30000)
                  annotation (Placement(transformation(extent={{110,-70},{130,-50}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowOut(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{294,-38},{314,-18}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow
                                           prescribedPowerFlow
    annotation (Placement(transformation(extent={{140,-70},{160,-50}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume AirTH(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,                                                                 use_HeatPort=true)
    annotation (Placement(transformation(extent={{168,-122},{188,-102}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow
                                                      boundary(use_port=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={178,-142})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AirTempSensor(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={192,-86})));
  TRANSFORM.Controls.LimPID PID_Air(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{232,-120},{212,-140}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=790 + 273.15) annotation (Placement(transformation(extent={{264,-140},{244,-120}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume FuelTH(redeclare package Medium =
        Media.Electrolysis.CathodeGas,
    p_start(displayUnit="kPa") = 103800,
    X_start={0.0122804,0.9877196},                                                                      use_HeatPort=true)
    annotation (Placement(transformation(extent={{172,8},{192,-12}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow
                                                      boundary1(use_port=true)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={182,26})));
  TRANSFORM.Controls.LimPID PID_Fuel(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{222,30},{202,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=790 + 273.15)
                                                                        annotation (Placement(transformation(extent={{254,30},{234,50}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelTempSensor(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={194,-26})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CathodeOutTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)                                                                                                   annotation (Placement(transformation(extent={{250,-38},
            {270,-18}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeOutTemp(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)                                                                                                 annotation (Placement(transformation(extent={{272,-98},
            {292,-78}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink1(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-352,154},{-332,174}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn2(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{22,82},{42,102}})));
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
    m_flow_start_2=13.47/3600) annotation (Placement(transformation(extent={{80,100},{60,120}})));
  Modelica.Fluid.Sources.Boundary_pT anodeSink1(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 101300,
    T=504.55,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={62,-242})));
  Modelica.Fluid.Sensors.MassFlowRate AnodeFlowIn1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{276,-204},{256,-184}})));
  Modelica.Fluid.Sources.MassFlowSource_T anodeFeed2(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=293.15) annotation (Placement(transformation(extent={{0,-154},{20,-134}})));
  Modelica.Fluid.Sensors.MassFlowRate AnodeFlowIn3(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{28,-154},{48,-134}})));
  Modelica.Blocks.Sources.Constant AnodeFlowControl2(k=5.555e-3)   annotation (Placement(transformation(extent={{-38,-146},{-18,-126}})));
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
    m_flow_start_2=5.555e-3) annotation (Placement(transformation(extent={{88,-138},{68,-158}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeOutTemp1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)                                                                                                 annotation (Placement(transformation(extent={{126,
            -122},{146,-102}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOut_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{140,-12},{160,8}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelHXOutTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{32,104},{12,124}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AirHXOutTemp(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={62,-194})));
  TRANSFORM.Fluid.Volumes.SimpleVolume condenser(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p_start(displayUnit="kPa") = 103800,
    X_start={0.0122804,0.9877196},
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (                                                                                                   V=0.1),
    use_HeatPort=true) annotation (Placement(transformation(extent={{-6,126},{-30,102}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary3(T=313.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-18,142})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-158,154},{-178,174}})));
  Modelica.Fluid.Sensors.MassFractions X_H2(redeclare package Medium =
        Media.Electrolysis.CathodeGas,                                                                substanceName="H2")
    annotation (Placement(transformation(extent={{-184,136},{-204,116}})));
  Modelica.Fluid.Sensors.MassFractions X_H2O(redeclare package Medium =
        Media.Electrolysis.CathodeGas,                                                                 substanceName="H2O")
    annotation (Placement(transformation(extent={{-204,182},{-224,202}})));
  Modelica.Blocks.Math.Product mH2_sep_out annotation (Placement(
        transformation(
        extent={{-9,-9},{9,9}},
        rotation=-90,
        origin={-247,105})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-258,154},{-278,174}})));
  Modelica.Blocks.Math.Product mH2O_sep_out annotation (Placement(
        transformation(
        extent={{9,-9},{-9,9}},
        rotation=-90,
        origin={-249,217})));
  Modelica.Fluid.Sources.MassFlowSource_T H2_feed(
    use_m_flow_in=true,
    m_flow=1.35415,
    use_T_in=true,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    nPorts=1,
    use_X_in=false,
    T=618.329) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-272,66})));
  Modelica.Fluid.Sources.MassFlowSource_T H2O_feed(
    use_m_flow_in=true,
    m_flow=1.35415,
    use_T_in=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_X_in=false,
    T=618.329,
    nPorts=1)  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-272,250})));
  Modelica.Fluid.Sources.Boundary_pT CondensateSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-272,284})));
  Modelica.Fluid.Sources.Boundary_pT H2Product(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-272,32})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-316,164},{-296,184}})));
  Modelica.Fluid.Sources.MassFlowSource_T SteamFlowControl(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=0.908085*5,
    T=414.15,
    nPorts=1) annotation (Placement(transformation(extent={{-172,-72},{-152,-52}})));
  Modelica.Blocks.Sources.Constant SteamFlowIn(k=3.6919e-003) annotation (Placement(transformation(extent={{-206,-64},{-186,-44}})));
  Modelica.Fluid.Sensors.MassFractions X_H1(redeclare package Medium =
        Media.Electrolysis.CathodeGas,                                                                substanceName="H2")
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-62,0})));
  Modelica.Fluid.Sources.MassFlowSource_T H2_feed1(
    use_m_flow_in=true,
    m_flow=1.35415,
    use_T_in=false,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    nPorts=1,
    use_X_in=false,
    T=414.15)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-180,-10})));
  Separator.Combiner_H2_Steam combiner_FinalV2_1 annotation (Placement(transformation(extent={{-104,-34},{-84,-14}})));
  TRANSFORM.Controls.LimPID PID_Fuel1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{-112,30},{-132,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0.0123)      annotation (Placement(transformation(extent={{-80,30},{-100,50}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTemp1(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-42,-48},{-22,-28}})));
  Modelica.Fluid.Sensors.MassFlowRate SteamFlowMeasure(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-142,-72},{-122,-52}})));
  Modelica.Fluid.Sensors.MassFlowRate H2MassFlowRate(redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.H2)
    annotation (Placement(transformation(extent={{-152,-20},{-132,0}})));
equation
  connect(DCPowerControl.y, prescribedPowerFlow.P_flow) annotation (Line(points={{131,-60},{142,-60}},
                                                                                                     color={0,0,127}));
  connect(prescribedPowerFlow.port_b, SOEC.DC_PowerIn) annotation (Line(
      points={{160,-60},{196,-60}},
      color={255,0,0},
      thickness=0.5));
  connect(AirTH.heatPort, boundary.port) annotation (Line(points={{178,-118},{178,-132}},
                                                                                        color={191,0,0}));
  connect(AirTH.port_b, AirTempSensor.port_a) annotation (Line(points={{184,-112},{192,-112},{192,-96}},
                                                                                                       color={0,127,255}));
  connect(AirTempSensor.port_b, SOEC.AnodeIn) annotation (Line(points={{192,-76},{192,-67.5},{196,-67.5}},
                                                                                                         color={0,127,255}));
  connect(PID_Air.u_s, realExpression.y) annotation (Line(points={{234,-130},{243,-130}},
                                                                                      color={0,0,127}));
  connect(AirTempSensor.T, PID_Air.u_m) annotation (Line(points={{195.6,-86},{222,-86},{222,-118}},
                                                                                                 color={0,0,127}));
  connect(boundary.Q_flow_ext, PID_Air.y) annotation (Line(points={{178,-146},{178,-156},{206,-156},{206,-130},{211,-130}},
                                                                                                                   color={0,0,127}));
  connect(boundary1.port,FuelTH. heatPort) annotation (Line(points={{182,16},{182,4}},  color={191,0,0}));
  connect(FuelTempSensor.port_b, SOEC.CathodeIn) annotation (Line(points={{194,-36},{194,-52.5},{196,-52.5}},
                                                                                                         color={0,127,255}));
  connect(PID_Fuel.y, boundary1.Q_flow_ext) annotation (Line(points={{201,40},{182,40},{182,30}},color={0,0,127}));
  connect(PID_Fuel.u_m, FuelTempSensor.T) annotation (Line(points={{212,28},{212,-26},{197.6,-26}},
                                                                                              color={0,0,127}));
  connect(realExpression1.y, PID_Fuel.u_s) annotation (Line(points={{233,40},{224,40}},
                                                                                      color={0,0,127}));
  connect(cathodeFlowOut.port_a, CathodeOutTemp.port_b) annotation (Line(points={{294,-28},{270,-28}},
                                                                                                    color={0,127,255}));
  connect(CathodeOutTemp.port_a, SOEC.CathodeOut) annotation (Line(points={{250,-28},{236,-28},{236,-52.5},{226,-52.5}},
                                                                                                               color={0,127,255}));
  connect(AnodeOutTemp.port_a, SOEC.AnodeOut) annotation (Line(points={{272,-88},{236,-88},{236,-67.5},{226,-67.5}},
                                                                                                               color={0,127,255}));
  connect(cathodeFlowIn2.port_b,FuelHX. port_a2) annotation (Line(points={{42,92},{54,92},{54,106},{60,106}},
                                                                                                            color={0,127,255}));
  connect(cathodeFlowOut.port_b, FuelHX.port_a1) annotation (Line(points={{314,-28},{320,-28},{320,142},{90,142},{90,114},{80,114}},
                                                                                                         color={0,127,255}));
  connect(anodeFeed2.ports[1], AnodeFlowIn3.port_a) annotation (Line(points={{20,-144},{28,-144}},     color={0,127,255}));
  connect(anodeFeed2.m_flow_in,AnodeFlowControl2. y) annotation (Line(points={{0,-136},{-17,-136}},
                                                                                                  color={0,0,127}));
  connect(AnodeFlowIn1.port_b, AirHX.port_a1) annotation (Line(points={{256,-194},{98,-194},{98,-152},{88,-152}},      color={0,127,255}));
  connect(AnodeFlowIn3.port_b, AirHX.port_a2) annotation (Line(points={{48,-144},{68,-144}},     color={0,127,255}));
  connect(AnodeOutTemp.port_b, AnodeFlowIn1.port_a) annotation (Line(points={{292,-88},{298,-88},{298,-194},{276,-194}},
                                                                                                                     color={0,127,255}));
  connect(AirHX.port_b2, AnodeOutTemp1.port_a) annotation (Line(points={{88,-144},{120,-144},{120,-112},{126,-112}},
                                                                                                color={0,127,255}));
  connect(AnodeOutTemp1.port_b, AirTH.port_a)
    annotation (Line(points={{146,-112},{172,-112}},                                         color={0,127,255}));
  connect(ShellOut_Temp.port_b, FuelTH.port_a) annotation (Line(points={{160,-2},{176,-2}}, color={0,127,255}));
  connect(FuelTH.port_b, FuelTempSensor.port_a) annotation (Line(points={{188,-2},{194,-2},{194,-16}},color={0,127,255}));
  connect(FuelHX.port_b2, ShellOut_Temp.port_a) annotation (Line(points={{80,106},{134,106},{134,-2},{140,-2}},
                                                                                                          color={0,127,255}));
  connect(FuelHX.port_b1, FuelHXOutTemp.port_a) annotation (Line(points={{60,114},{32,114}}, color={0,127,255}));
  connect(AirHX.port_b1, AirHXOutTemp.port_a) annotation (Line(points={{68,-152},{62,-152},{62,-184}}, color={0,127,255}));
  connect(AirHXOutTemp.port_b, anodeSink1.ports[1]) annotation (Line(points={{62,-204},{62,-232}},   color={0,127,255}));
  connect(FuelHXOutTemp.port_b, condenser.port_a) annotation (Line(points={{12,114},{-10.8,114}},color={0,127,255}));
  connect(condenser.heatPort, boundary3.port) annotation (Line(points={{-18,121.2},{-18,132}},color={191,0,0}));
  connect(condenser.port_b, SinkTemp.port_a) annotation (Line(points={{-25.2,114},{-92,114},{-92,164},{-158,164}},
                                                                                              color={0,127,255}));
  connect(X_H2O.Xi, mH2O_sep_out.u1) annotation (Line(points={{-225,192},{-246,192},{-246,202},{-243.6,202},{-243.6,206.2}},
                                                                                                              color={0,0,127}));
  connect(massFlowRate.m_flow, mH2O_sep_out.u2)
    annotation (Line(points={{-268,175},{-268,182},{-254.4,182},{-254.4,206.2}},                 color={0,0,127}));
  connect(mH2_sep_out.y, H2_feed.m_flow_in) annotation (Line(points={{-247,95.1},{-247,76},{-264,76}},                 color={0,0,127}));
  connect(H2O_feed.m_flow_in, mH2O_sep_out.y) annotation (Line(points={{-264,240},{-249,240},{-249,226.9}},        color={0,0,127}));
  connect(H2_feed.ports[1], H2Product.ports[1]) annotation (Line(points={{-272,56},{-272,42}}, color={0,127,255}));
  connect(massFlowRate.port_a, SinkTemp.port_b) annotation (Line(points={{-258,164},{-178,164}}, color={0,127,255}));
  connect(X_H2.port, SinkTemp.port_b) annotation (Line(points={{-194,136},{-194,164},{-178,164}}, color={0,127,255}));
  connect(X_H2O.port, SinkTemp.port_b) annotation (Line(points={{-214,182},{-214,164},{-178,164}}, color={0,127,255}));
  connect(massFlowRate.m_flow, mH2_sep_out.u2)
    annotation (Line(points={{-268,175},{-268,182},{-248,182},{-248,122},{-252.4,122},{-252.4,115.8}}, color={0,0,127}));
  connect(X_H2.Xi, mH2_sep_out.u1) annotation (Line(points={{-205,126},{-240,126},{-240,120},{-241.6,120},{-241.6,115.8}}, color={0,0,127}));
  connect(massFlowRate.port_b, temperature.port) annotation (Line(points={{-278,164},{-306,164}}, color={0,127,255}));
  connect(temperature.port, cathodeSink1.ports[1]) annotation (Line(points={{-306,164},{-332,164}}, color={0,127,255}));
  connect(H2O_feed.ports[1], CondensateSink.ports[1]) annotation (Line(points={{-272,260},{-272,274}}, color={0,127,255}));
  connect(H2O_feed.T_in, temperature.T) annotation (Line(points={{-268,238},{-268,184},{-290,184},{-290,174},{-299,174}}, color={0,0,127}));
  connect(H2_feed.T_in, temperature.T) annotation (Line(points={{-268,78},{-268,148},{-286,148},{-286,174},{-299,174}}, color={0,0,127}));
  connect(SteamFlowControl.m_flow_in, SteamFlowIn.y) annotation (Line(points={{-172,-54},{-185,-54}},
                                                                                                  color={0,0,127}));
  connect(combiner_FinalV2_1.Outlet, X_H1.port) annotation (Line(points={{-94,-33},{-94,-38},{-62,-38},{-62,-10}}, color={0,127,255}));
  connect(X_H1.Xi, PID_Fuel1.u_m) annotation (Line(points={{-51,0},{-46,0},{-46,22},{-122,22},{-122,28}},      color={0,0,127}));
  connect(realExpression2.y, PID_Fuel1.u_s) annotation (Line(points={{-101,40},{-110,40}}, color={0,0,127}));
  connect(H2_feed1.m_flow_in, PID_Fuel1.y) annotation (Line(points={{-190,-2},{-190,40},{-133,40}}, color={0,0,127}));
  connect(X_H1.port, SinkTemp1.port_a) annotation (Line(points={{-62,-10},{-62,-38},{-42,-38}}, color={0,127,255}));
  connect(SteamFlowControl.ports[1], SteamFlowMeasure.port_a) annotation (Line(points={{-152,-62},{-142,-62}},
                                                                                                             color={0,127,255}));
  connect(SteamFlowMeasure.port_b, combiner_FinalV2_1.liquidInlet)
    annotation (Line(points={{-122,-62},{-110,-62},{-110,-30},{-104,-30}},
                                                                       color={0,127,255}));
  connect(H2_feed1.ports[1], H2MassFlowRate.port_a) annotation (Line(points={{-170,-10},{-152,-10}},
                                                                                                   color={0,127,255}));
  connect(H2MassFlowRate.port_b, combiner_FinalV2_1.vaporInlet)
    annotation (Line(points={{-132,-10},{-110,-10},{-110,-18},{-104,-18}},
                                                                       color={0,127,255}));
  connect(cathodeFlowIn2.port_a, SinkTemp1.port_b) annotation (Line(points={{22,92},{-8,92},{-8,-38},{-22,-38}},    color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-350,
            -350},{350,350}})),
            experiment(StopTime=1e3,__Dymola_Algorithm="Dassl"),
  Documentation(info="<html>
  <p>Model of a solid oxide electrolysis cell based on OxEon design. The design has a total of 780 cells based on 65 cells in 12 stacks (65 x 12 = 780). 
  Some of the cell design parameters are chosen from publicly available information for the OxEon Energy SOEC. These details can be found at https://doi.org/10.1016/j.ijhydene.2020.04.074 </p>
    <p>The model's steady state conditions are acquired from an Aspen HYSYS model, which are then used as initial conditions for this model</p>
    <p>The SOEC has a constant area specific resistance (ASR) and operating voltage. These numbers will be modified in the future to account for cell degradation using empirical data.
    The Gibbs Free Energy term is calculated using NASA's 7-term polynomial.
    For any questions regarding the model, please contact Amey Shigrekar (amey.shigreka@inl.gov)</p>        
 </html>"));
end Model9_V3;
