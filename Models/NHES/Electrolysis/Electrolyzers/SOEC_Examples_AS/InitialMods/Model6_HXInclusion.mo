within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model Model6_HXInclusion
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
  Modelica.Fluid.Sources.Boundary_pT anodeSink1(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 101300,
    T=504.55,
    nPorts=1) annotation (Placement(transformation(extent={{298,-82},{278,-62}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{180,-86},{200,-66}})));
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
    nPorts=1) annotation (Placement(transformation(extent={{154,-124},{174,-104}})));
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
  Modelica.Fluid.Sources.Boundary_pT TubeSink(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=423.65,
    nPorts=1) annotation (Placement(transformation(extent={{462,134},{442,154}})));
  Modelica.Fluid.Sources.MassFlowSource_T ShellFeed(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=414.15) annotation (Placement(transformation(extent={{468,64},{448,84}})));
  Modelica.Fluid.Sensors.MassFlowRate ShellFlowMeasure(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{438,64},{418,84}})));
  Modelica.Blocks.Sources.Constant ShellFlowControl(k=13.47/3600) annotation (Placement(transformation(extent={{504,72},{484,92}})));
  Modelica.Fluid.Sources.Boundary_pT ShellSink(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=981.25,
    nPorts=1) annotation (Placement(transformation(extent={{174,62},{194,82}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_V2 FuelHX1(
    NTU=9,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium = Media.Electrolysis.CathodeGas,
    redeclare package Shell_medium = Media.Electrolysis.CathodeGas,
    p_start_tube(displayUnit="kPa") = 103800,
    h_start_tube_inlet=4.341e6,
    h_start_tube_outlet=1.65549e6,
    p_start_shell(displayUnit="kPa") = 103800,
    h_start_shell_inlet=831088,
    h_start_shell_outlet=2.09956e6,
    dp_init_tube=10000,
    dp_init_shell=10000,
    Q_init=4773,
    Cr_init=0.98,
    m_start_tube=6.379/3600,
    m_start_shell=13.47/3600)  annotation (Placement(transformation(extent={{340,94},{294,140}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeIn_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{232,134},{252,154}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeOut_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{380,134},{400,154}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellIn_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{408,64},{388,84}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOut_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{232,62},{212,82}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort ShellOutEnth(redeclare
      package                                                                    Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{272,62},{252,82}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort ShellInEnth(redeclare package
                                                                                Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{376,64},{356,84}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort TubeOutEnth(redeclare package
                                                                                Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{410,134},{430,154}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort TubeInEnth(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{260,134},{280,154}})));
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
  connect(anodeFeed2.ports[1],cathodeFlowIn3. port_a) annotation (Line(points={{282,-110},{272,-110}},
                                                                                                   color={0,127,255}));
  connect(anodeFeed2.m_flow_in,AnodeFlowControl2. y) annotation (Line(points={{302,-102},{319,-102}},
                                                                                                  color={0,0,127}));
  connect(cathodeFlowIn1.port_b,AirHX. port_a1) annotation (Line(points={{200,-76},{206,-76},{206,-92},{212,-92}},color={0,127,255}));
  connect(AirHX.port_b1, anodeSink1.ports[1]) annotation (Line(points={{232,-92},{268,-92},{268,-72},{278,-72}}, color={0,127,255}));
  connect(cathodeFlowIn3.port_b,AirHX. port_a2) annotation (Line(points={{252,-110},{244,-110},{244,-100},{232,-100}},
                                                                                                               color={0,127,255}));
  connect(AirHX.port_b2,anodeSink2. ports[1]) annotation (Line(points={{212,-100},{182,-100},{182,-114},{174,-114}},
                                                                                                                color={0,127,255}));
  connect(AnodeOutTemp.port_b, cathodeFlowIn1.port_a) annotation (Line(points={{84,-30},{106,-30},{106,-76},{180,-76}}, color={0,127,255}));
  connect(ShellFeed.ports[1],ShellFlowMeasure. port_a) annotation (Line(points={{448,74},{438,74}},   color={0,127,255}));
  connect(ShellFeed.m_flow_in,ShellFlowControl. y) annotation (Line(points={{468,82},{483,82}},   color={0,0,127}));
  connect(FuelHX1.Tube_out,TubeOut_Temp. port_a) annotation (Line(points={{340,126.2},{370,126.2},{370,144},{380,144}},
                                                                                             color={0,127,255}));
  connect(ShellFlowMeasure.port_b,ShellIn_Temp. port_a) annotation (Line(points={{418,74},{408,74}},  color={0,127,255}));
  connect(ShellOut_Temp.port_b,ShellSink. ports[1]) annotation (Line(points={{212,72},{194,72}},     color={0,127,255}));
  connect(FuelHX1.Shell_out,ShellOutEnth. port_a) annotation (Line(points={{294,112.4},{282,112.4},{282,72},{272,72}}, color={0,127,255}));
  connect(ShellOutEnth.port_b,ShellOut_Temp. port_a) annotation (Line(points={{252,72},{232,72}},   color={0,127,255}));
  connect(ShellIn_Temp.port_b,ShellInEnth. port_a) annotation (Line(points={{388,74},{376,74}}, color={0,127,255}));
  connect(ShellInEnth.port_b,FuelHX1. Shell_in) annotation (Line(points={{356,74},{350,74},{350,112.4},{340,112.4}},
                                                                                                                 color={0,127,255}));
  connect(TubeOut_Temp.port_b,TubeOutEnth. port_a) annotation (Line(points={{400,144},{410,144}},
                                                                                              color={0,127,255}));
  connect(TubeOutEnth.port_b,TubeSink. ports[1]) annotation (Line(points={{430,144},{442,144}},
                                                                                              color={0,127,255}));
  connect(TubeIn_Temp.port_b,TubeInEnth. port_a) annotation (Line(points={{252,144},{260,144}},
                                                                                              color={0,127,255}));
  connect(TubeInEnth.port_b,FuelHX1. Tube_in) annotation (Line(points={{280,144},{286,144},{286,126.2},{294,126.2}},
                                                                                                               color={0,127,255}));
  connect(cathodeFlowOut.port_b, TubeIn_Temp.port_a) annotation (Line(points={{128,30},{166,30},{166,144},{232,144}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-250,
            -250},{250,250}})),
            experiment(StopTime=1e3,
            __Dymola_Algorithm="Esdirk45a"),
  Documentation(info="<html>
  <p>Model of a solid oxide electrolysis cell based on OxEon design. The design has a total of 780 cells based on 65 cells in 12 stacks (65 x 12 = 780). 
  Some of the cell design parameters are chosen from publicly available information for the OxEon Energy SOEC. These details can be found at https://doi.org/10.1016/j.ijhydene.2020.04.074 </p>
    <p>The model's steady state conditions are acquired from an Aspen HYSYS model, which are then used as initial conditions for this model</p>
    <p>The SOEC has a constant area specific resistance (ASR) and operating voltage. These numbers will be modified in the future to account for cell degradation using empirical data.
    The Gibbs Free Energy term is calculated using NASA's 7-term polynomial.
    For any questions regarding the model, please contact Amey Shigrekar (amey.shigreka@inl.gov)</p>        
 </html>"));
end Model6_HXInclusion;
