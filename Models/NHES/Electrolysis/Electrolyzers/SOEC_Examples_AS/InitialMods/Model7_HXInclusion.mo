within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model Model7_HXInclusion
  extends Modelica.Icons.Example;

  BaseClasses.OxEonV7_Complex SOEC(V_cathode=0.001, V_anode=0.001)
                                   annotation (Placement(transformation(extent={{-12,-17},{18,13}})));
  Modelica.Blocks.Sources.Constant
                               DCPowerControl(k=30000)
                  annotation (Placement(transformation(extent={{-98,-12},{-78,8}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowOut(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{86,20},{106,40}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow
                                           prescribedPowerFlow
    annotation (Placement(transformation(extent={{-68,-12},{-48,8}})));
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
  TRANSFORM.Fluid.Volumes.SimpleVolume FuelTH(redeclare package Medium =
        Media.Electrolysis.CathodeGas,
    p_start(displayUnit="kPa") = 103800,
    X_start={0.0122804,0.9877196},                                                                      use_HeatPort=true)
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
        Media.Electrolysis.CathodeGas)                                                                                                   annotation (Placement(transformation(extent={{42,20},
            {62,40}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeOutTemp(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)                                                                                                 annotation (Placement(transformation(extent={{64,-40},
            {84,-20}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink1(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=423.65,
    nPorts=1)
    annotation (Placement(transformation(extent={{-242,106},{-222,126}})));
  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed2(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=414.15)
    annotation (Placement(transformation(extent={{-214,28},{-194,48}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn2(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-186,54},{-166,74}})));
  Modelica.Blocks.Sources.Constant CathodeFlowControl2(k=0.003741667)
                                                                     annotation (Placement(transformation(extent={{-248,36},{-228,56}})));
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
    m_flow_start_2=13.47/3600) annotation (Placement(transformation(extent={{-128,72},{-148,92}})));
  Modelica.Fluid.Sources.Boundary_pT anodeSink1(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 101300,
    T=504.55,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-146,-184})));
  Modelica.Fluid.Sensors.MassFlowRate AnodeFlowIn1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{68,-146},{48,-126}})));
  Modelica.Fluid.Sources.MassFlowSource_T anodeFeed2(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=293.15) annotation (Placement(transformation(extent={{-208,-96},{-188,-76}})));
  Modelica.Fluid.Sensors.MassFlowRate AnodeFlowIn3(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-180,-96},{-160,-76}})));
  Modelica.Blocks.Sources.Constant AnodeFlowControl2(k=5.555e-3)   annotation (Placement(transformation(extent={{-246,-88},{-226,-68}})));
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
    m_flow_start_2=5.555e-3) annotation (Placement(transformation(extent={{-120,-80},{-140,-100}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AnodeOutTemp1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)                                                                                                 annotation (Placement(transformation(extent={{-82,-64},
            {-62,-44}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOut_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-68,46},{-48,66}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelHXOutTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-176,76},{-196,96}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort AirHXOutTemp(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-146,-136})));
equation
  connect(DCPowerControl.y, prescribedPowerFlow.P_flow) annotation (Line(points={{-77,-2},{-66,-2}}, color={0,0,127}));
  connect(prescribedPowerFlow.port_b, SOEC.DC_PowerIn) annotation (Line(
      points={{-48,-2},{-12,-2}},
      color={255,0,0},
      thickness=0.5));
  connect(AirTH.heatPort, boundary.port) annotation (Line(points={{-30,-60},{-30,-74}}, color={191,0,0}));
  connect(AirTH.port_b, AirTempSensor.port_a) annotation (Line(points={{-24,-54},{-16,-54},{-16,-38}}, color={0,127,255}));
  connect(AirTempSensor.port_b, SOEC.AnodeIn) annotation (Line(points={{-16,-18},{-16,-9.5},{-12,-9.5}}, color={0,127,255}));
  connect(PID_Air.u_s, realExpression.y) annotation (Line(points={{26,-72},{35,-72}}, color={0,0,127}));
  connect(AirTempSensor.T, PID_Air.u_m) annotation (Line(points={{-12.4,-28},{14,-28},{14,-60}}, color={0,0,127}));
  connect(boundary.Q_flow_ext, PID_Air.y) annotation (Line(points={{-30,-88},{-30,-98},{-2,-98},{-2,-72},{3,-72}}, color={0,0,127}));
  connect(boundary1.port,FuelTH. heatPort) annotation (Line(points={{-26,74},{-26,62}}, color={191,0,0}));
  connect(FuelTempSensor.port_b, SOEC.CathodeIn) annotation (Line(points={{-14,22},{-14,5.5},{-12,5.5}}, color={0,127,255}));
  connect(PID_Fuel.y, boundary1.Q_flow_ext) annotation (Line(points={{-7,98},{-26,98},{-26,88}}, color={0,0,127}));
  connect(PID_Fuel.u_m, FuelTempSensor.T) annotation (Line(points={{4,86},{4,32},{-10.4,32}}, color={0,0,127}));
  connect(realExpression1.y, PID_Fuel.u_s) annotation (Line(points={{25,98},{16,98}}, color={0,0,127}));
  connect(cathodeFlowOut.port_a, CathodeOutTemp.port_b) annotation (Line(points={{86,30},{62,30}},  color={0,127,255}));
  connect(CathodeOutTemp.port_a, SOEC.CathodeOut) annotation (Line(points={{42,30},{28,30},{28,5.5},{18,5.5}}, color={0,127,255}));
  connect(AnodeOutTemp.port_a, SOEC.AnodeOut) annotation (Line(points={{64,-30},{28,-30},{28,-9.5},{18,-9.5}}, color={0,127,255}));
  connect(cathodeFeed2.ports[1],cathodeFlowIn2. port_a) annotation (Line(points={{-194,38},{-192,38},{-192,64},{-186,64}},
                                                                                                     color={0,127,255}));
  connect(cathodeFlowIn2.port_b,FuelHX. port_a2) annotation (Line(points={{-166,64},{-154,64},{-154,78},{-148,78}},
                                                                                                            color={0,127,255}));
  connect(cathodeFlowOut.port_b, FuelHX.port_a1) annotation (Line(points={{106,30},{112,30},{112,114},{-118,114},{-118,86},{-128,86}},
                                                                                                         color={0,127,255}));
  connect(anodeFeed2.ports[1], AnodeFlowIn3.port_a) annotation (Line(points={{-188,-86},{-180,-86}},   color={0,127,255}));
  connect(anodeFeed2.m_flow_in,AnodeFlowControl2. y) annotation (Line(points={{-208,-78},{-225,-78}},
                                                                                                  color={0,0,127}));
  connect(AnodeFlowIn1.port_b, AirHX.port_a1) annotation (Line(points={{48,-136},{-110,-136},{-110,-94},{-120,-94}},   color={0,127,255}));
  connect(AnodeFlowIn3.port_b, AirHX.port_a2) annotation (Line(points={{-160,-86},{-140,-86}},   color={0,127,255}));
  connect(AnodeOutTemp.port_b, AnodeFlowIn1.port_a) annotation (Line(points={{84,-30},{90,-30},{90,-136},{68,-136}}, color={0,127,255}));
  connect(AirHX.port_b2, AnodeOutTemp1.port_a) annotation (Line(points={{-120,-86},{-88,-86},{-88,-54},{-82,-54}},
                                                                                                color={0,127,255}));
  connect(AnodeOutTemp1.port_b, AirTH.port_a)
    annotation (Line(points={{-62,-54},{-36,-54}},                                           color={0,127,255}));
  connect(ShellOut_Temp.port_b, FuelTH.port_a) annotation (Line(points={{-48,56},{-32,56}}, color={0,127,255}));
  connect(CathodeFlowControl2.y, cathodeFeed2.m_flow_in) annotation (Line(points={{-227,46},{-214,46}}, color={0,0,127}));
  connect(FuelTH.port_b, FuelTempSensor.port_a) annotation (Line(points={{-20,56},{-14,56},{-14,42}}, color={0,127,255}));
  connect(FuelHX.port_b2, ShellOut_Temp.port_a) annotation (Line(points={{-128,78},{-74,78},{-74,56},{-68,56}}, color={0,127,255}));
  connect(FuelHX.port_b1, FuelHXOutTemp.port_a) annotation (Line(points={{-148,86},{-176,86}}, color={0,127,255}));
  connect(FuelHXOutTemp.port_b, cathodeSink1.ports[1]) annotation (Line(points={{-196,86},{-212,86},{-212,116},{-222,116}}, color={0,127,255}));
  connect(AirHX.port_b1, AirHXOutTemp.port_a) annotation (Line(points={{-140,-94},{-146,-94},{-146,-126}}, color={0,127,255}));
  connect(AirHXOutTemp.port_b, anodeSink1.ports[1]) annotation (Line(points={{-146,-146},{-146,-174}}, color={0,127,255}));
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
end Model7_HXInclusion;
