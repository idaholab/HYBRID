within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.DoNotUse;
model Model10
  extends Modelica.Icons.Example;

  BaseClasses.OxEonV7_Complex SOEC(V_cathode=0.001, V_anode=0.001)
                                   annotation (Placement(transformation(extent={{120,-17},{150,13}})));
  Modelica.Blocks.Sources.Constant
                               DCPowerControl(k=30000)
                  annotation (Placement(transformation(extent={{34,-12},{54,8}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowOut(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{218,20},{238,40}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow
                                           prescribedPowerFlow
    annotation (Placement(transformation(extent={{64,-12},{84,8}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume AirTH(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    T_start=1063.15,                                                                                                       use_HeatPort=true)
    annotation (Placement(transformation(extent={{92,-64},{112,-44}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow
                                                      boundary(use_port=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={102,-84})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AirTempSensor(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={116,-28})));
  TRANSFORM.Controls.LimPID PID_Air(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{156,-62},{136,-82}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=790 + 273.15) annotation (Placement(transformation(extent={{188,-82},{168,-62}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume FuelTH(redeclare package Medium =
        Media.Electrolysis.CathodeGas,
    p_start(displayUnit="kPa") = 103800,
    T_start=1063.15,
    X_start={0.0122804,0.9877196},                                                                      use_HeatPort=true)
    annotation (Placement(transformation(extent={{96,66},{116,46}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow
                                                      boundary1(use_port=true)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={106,84})));
  TRANSFORM.Controls.LimPID PID_Fuel(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e3,
    Ti=5,
    yMax=1000,
    yMin=0) annotation (Placement(transformation(extent={{146,88},{126,108}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=790 + 273.15)
                                                                        annotation (Placement(transformation(extent={{178,88},{158,108}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelTempSensor(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={118,32})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CathodeOutTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)                                                                                                   annotation (Placement(transformation(extent={{174,20},
            {194,40}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeOutTemp(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)                                                                                                 annotation (Placement(transformation(extent={{196,-40},
            {216,-20}})));
  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed2(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=414.15)
    annotation (Placement(transformation(extent={{-82,28},{-62,48}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn2(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-54,54},{-34,74}})));
  Modelica.Blocks.Sources.Constant CathodeFlowControl2(k=0.003741667)
                                                                     annotation (Placement(transformation(extent={{-116,36},{-96,56}})));
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
    m_flow_start_2=13.47/3600) annotation (Placement(transformation(extent={{4,72},{-16,92}})));
  Modelica.Fluid.Sources.Boundary_pT anodeSink1(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 101300,
    T=504.55,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-14,-184})));
  Modelica.Fluid.Sensors.MassFlowRate AnodeFlowIn1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{200,-146},{180,-126}})));
  Modelica.Fluid.Sources.MassFlowSource_T anodeFeed2(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=293.15) annotation (Placement(transformation(extent={{-76,-96},{-56,-76}})));
  Modelica.Fluid.Sensors.MassFlowRate AnodeFlowIn3(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-48,-96},{-28,-76}})));
  Modelica.Blocks.Sources.Constant AnodeFlowControl2(k=5.555e-3)   annotation (Placement(transformation(extent={{-114,-88},{-94,-68}})));
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
    m_flow_start_2=5.555e-3) annotation (Placement(transformation(extent={{12,-80},{-8,-100}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeOutTemp1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)                                                                                                 annotation (Placement(transformation(extent={{50,-64},
            {70,-44}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOut_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{64,46},{84,66}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelHXOutTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-44,76},{-64,96}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AirHXOutTemp(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-14,-136})));
  TRANSFORM.Fluid.Volumes.SimpleVolume condenser(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p_start(displayUnit="kPa") = 103800,
    T_start=423.65,
    X_start={0.0122804,0.9877196},
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume,
    use_HeatPort=true) annotation (Placement(transformation(extent={{-82,98},{-106,74}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary3(T=313.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-94,114})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-124,76},{-144,96}})));
  Separator.Temp_flashDrum temp_flashDrum_v2_1(
                                          redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-194,40},{-214,60}})));
  Modelica.Fluid.Sources.Boundary_pT Sink_H2(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(extent={{-240,78},{-220,98}})));
  Modelica.Fluid.Sources.Boundary_pT Sink_H2O(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(extent={{-244,-56},{-224,-36}})));
equation
  connect(DCPowerControl.y, prescribedPowerFlow.P_flow) annotation (Line(points={{55,-2},{66,-2}},   color={0,0,127}));
  connect(prescribedPowerFlow.port_b, SOEC.DC_PowerIn) annotation (Line(
      points={{84,-2},{120,-2}},
      color={255,0,0},
      thickness=0.5));
  connect(AirTH.heatPort, boundary.port) annotation (Line(points={{102,-60},{102,-74}}, color={191,0,0}));
  connect(AirTH.port_b, AirTempSensor.port_a) annotation (Line(points={{108,-54},{116,-54},{116,-38}}, color={0,127,255}));
  connect(AirTempSensor.port_b, SOEC.AnodeIn) annotation (Line(points={{116,-18},{116,-9.5},{120,-9.5}}, color={0,127,255}));
  connect(PID_Air.u_s, realExpression.y) annotation (Line(points={{158,-72},{167,-72}},
                                                                                      color={0,0,127}));
  connect(AirTempSensor.T, PID_Air.u_m) annotation (Line(points={{119.6,-28},{146,-28},{146,-60}},
                                                                                                 color={0,0,127}));
  connect(boundary.Q_flow_ext, PID_Air.y) annotation (Line(points={{102,-88},{102,-98},{130,-98},{130,-72},{135,-72}},
                                                                                                                   color={0,0,127}));
  connect(boundary1.port,FuelTH. heatPort) annotation (Line(points={{106,74},{106,62}}, color={191,0,0}));
  connect(FuelTempSensor.port_b, SOEC.CathodeIn) annotation (Line(points={{118,22},{118,5.5},{120,5.5}}, color={0,127,255}));
  connect(PID_Fuel.y, boundary1.Q_flow_ext) annotation (Line(points={{125,98},{106,98},{106,88}},color={0,0,127}));
  connect(PID_Fuel.u_m, FuelTempSensor.T) annotation (Line(points={{136,86},{136,32},{121.6,32}},
                                                                                              color={0,0,127}));
  connect(realExpression1.y, PID_Fuel.u_s) annotation (Line(points={{157,98},{148,98}},
                                                                                      color={0,0,127}));
  connect(cathodeFlowOut.port_a, CathodeOutTemp.port_b) annotation (Line(points={{218,30},{194,30}},color={0,127,255}));
  connect(CathodeOutTemp.port_a, SOEC.CathodeOut) annotation (Line(points={{174,30},{160,30},{160,5.5},{150,5.5}},
                                                                                                               color={0,127,255}));
  connect(AnodeOutTemp.port_a, SOEC.AnodeOut) annotation (Line(points={{196,-30},{160,-30},{160,-9.5},{150,-9.5}},
                                                                                                               color={0,127,255}));
  connect(cathodeFeed2.ports[1],cathodeFlowIn2. port_a) annotation (Line(points={{-62,38},{-60,38},{-60,64},{-54,64}},
                                                                                                     color={0,127,255}));
  connect(cathodeFlowIn2.port_b,FuelHX. port_a2) annotation (Line(points={{-34,64},{-22,64},{-22,78},{-16,78}},
                                                                                                            color={0,127,255}));
  connect(cathodeFlowOut.port_b, FuelHX.port_a1) annotation (Line(points={{238,30},{244,30},{244,114},{14,114},{14,86},{4,86}},
                                                                                                         color={0,127,255}));
  connect(anodeFeed2.ports[1], AnodeFlowIn3.port_a) annotation (Line(points={{-56,-86},{-48,-86}},     color={0,127,255}));
  connect(anodeFeed2.m_flow_in,AnodeFlowControl2. y) annotation (Line(points={{-76,-78},{-93,-78}},
                                                                                                  color={0,0,127}));
  connect(AnodeFlowIn1.port_b, AirHX.port_a1) annotation (Line(points={{180,-136},{22,-136},{22,-94},{12,-94}},        color={0,127,255}));
  connect(AnodeFlowIn3.port_b, AirHX.port_a2) annotation (Line(points={{-28,-86},{-8,-86}},      color={0,127,255}));
  connect(AnodeOutTemp.port_b, AnodeFlowIn1.port_a) annotation (Line(points={{216,-30},{222,-30},{222,-136},{200,-136}},
                                                                                                                     color={0,127,255}));
  connect(AirHX.port_b2, AnodeOutTemp1.port_a) annotation (Line(points={{12,-86},{44,-86},{44,-54},{50,-54}},
                                                                                                color={0,127,255}));
  connect(AnodeOutTemp1.port_b, AirTH.port_a)
    annotation (Line(points={{70,-54},{96,-54}},                                             color={0,127,255}));
  connect(ShellOut_Temp.port_b, FuelTH.port_a) annotation (Line(points={{84,56},{100,56}},  color={0,127,255}));
  connect(CathodeFlowControl2.y, cathodeFeed2.m_flow_in) annotation (Line(points={{-95,46},{-82,46}},   color={0,0,127}));
  connect(FuelTH.port_b, FuelTempSensor.port_a) annotation (Line(points={{112,56},{118,56},{118,42}}, color={0,127,255}));
  connect(FuelHX.port_b2, ShellOut_Temp.port_a) annotation (Line(points={{4,78},{58,78},{58,56},{64,56}}, color={0,127,255}));
  connect(FuelHX.port_b1, FuelHXOutTemp.port_a) annotation (Line(points={{-16,86},{-44,86}}, color={0,127,255}));
  connect(AirHX.port_b1, AirHXOutTemp.port_a) annotation (Line(points={{-8,-94},{-14,-94},{-14,-126}}, color={0,127,255}));
  connect(AirHXOutTemp.port_b, anodeSink1.ports[1]) annotation (Line(points={{-14,-146},{-14,-174}}, color={0,127,255}));
  connect(FuelHXOutTemp.port_b, condenser.port_a) annotation (Line(points={{-64,86},{-86.8,86}}, color={0,127,255}));
  connect(condenser.heatPort, boundary3.port) annotation (Line(points={{-94,93.2},{-94,104}}, color={191,0,0}));
  connect(condenser.port_b, SinkTemp.port_a) annotation (Line(points={{-101.2,86},{-124,86}}, color={0,127,255}));
  connect(temp_flashDrum_v2_1.vaporOutlet, Sink_H2.ports[1]) annotation (Line(points={{-204,59},{-204,88},{-220,88}}, color={0,127,255}));
  connect(temp_flashDrum_v2_1.liquidOutlet, Sink_H2O.ports[1]) annotation (Line(points={{-204,41},{-204,-46},{-224,-46}}, color={0,127,255}));
  connect(SinkTemp.port_b, temp_flashDrum_v2_1.feedInlet) annotation (Line(points={{-144,86},{-186,86},{-186,50},{-196,50}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-250,
            -250},{250,250}})),
            experiment(StopTime=1e3,__Dymola_Algorithm="Dassl"),
  Documentation(info="<html>
  <p>Model of a solid oxide electrolysis cell based on OxEon design. The design has a total of 780 cells based on 65 cells in 12 stacks (65 x 12 = 780). 
  Some of the cell design parameters are chosen from publicly available information for the OxEon Energy SOEC. These details can be found at https://doi.org/10.1016/j.ijhydene.2020.04.074 </p>
    <p>The model's steady state conditions are acquired from an Aspen HYSYS model, which are then used as initial conditions for this model</p>
    <p>The SOEC has a constant area specific resistance (ASR) and operating voltage. These numbers will be modified in the future to account for cell degradation using empirical data.
    The Gibbs Free Energy term is calculated using NASA's 7-term polynomial.
    For any questions regarding the model, please contact Amey Shigrekar (amey.shigreka@inl.gov)</p>        
 </html>"));
end Model10;
