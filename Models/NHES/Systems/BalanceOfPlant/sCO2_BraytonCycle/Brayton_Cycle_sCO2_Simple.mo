within NHES.Systems.BalanceOfPlant.sCO2_BraytonCycle;
model Brayton_Cycle_sCO2_Simple
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15); //Default pressure and temperature to create subcritical CO2 conditions
  extends BaseClasses.Partial_SubSystem_A(redeclare replaceable CS_Dummy CS, redeclare replaceable ED_Dummy ED);

     Modelica.Units.SI.Power Q_gen;

  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                                     HX1(
    NTU=operatingConditions.HTR_NTU,
    K_tube=operatingConditions.HTR_K_tube,
    K_shell=operatingConditions.HTR_K_shell,
    redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    V_Tube=operatingConditions.HTR_volume_tube,
    V_Shell=operatingConditions.HTR_volume_shell,
    p_start_tube=initialConditions.HTR_PStart_Tube,
    h_start_tube_inlet=initialConditions.HTR_HStart_Tube_In,
    h_start_tube_outlet=initialConditions.HTR_HStart_Tube_Out,
    p_start_shell=initialConditions.HTR_PStart_Shell,
    h_start_shell_inlet=initialConditions.HTR_HStart_Shell_In,
    h_start_shell_outlet=initialConditions.HTR_HStart_Shell_Out,
    dp_init_tube=initialConditions.HTR_dp_Tube,
    dp_init_shell=initialConditions.HTR_dp_Shell,
    Q_init=-1438e6,
    Cr_init=initialConditions.CR_init_HTR,
    m_start_tube=initialConditions.HTR_MassFlowStart_Tube,
    m_start_shell=initialConditions.HTR_MassFlowStart_Shell)
               annotation (Placement(transformation(extent={{26,-20},{0,4}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{44,0},{66,20}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-30,1},{-8,22}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{64,-30},{42,-10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-10,-28},{-32,-8}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{102,92},{122,112}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State     BoundaryOut(
    redeclare package Medium = Medium)
              annotation (Placement(transformation(extent={{-110,-28},{-90,-8}}),iconTransformation(extent={{-110,-28},{-90,-8}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                     HX2(
    NTU=operatingConditions.LTR_NTU,
    K_tube=operatingConditions.LTR_K_tube,
    K_shell=operatingConditions.LTR_K_shell,
    redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
    redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
    V_Tube=operatingConditions.LTR_volume_tube,
    V_Shell=operatingConditions.LTR_volume_shell,
    p_start_tube=initialConditions.LTR_PStart_Tube,
    h_start_tube_inlet=initialConditions.LTR_HStart_Tube_In,
    h_start_tube_outlet=initialConditions.LTR_HStart_Tube_Out,
    p_start_shell=initialConditions.LTR_PStart_Shell,
    h_start_shell_inlet=initialConditions.LTR_HStart_Shell_In,
    h_start_shell_outlet=initialConditions.LTR_HStart_Shell_Out,
    Q_init=370.1e6,
    Cr_init=initialConditions.CR_init_LTR,
    m_start_tube=initialConditions.LTR_MassFlowStart_Tube,
    m_start_shell=initialConditions.LTR_MassFlowStart_Shell)
    annotation (Placement(transformation(extent={{28,-70},{2,-46}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{44,-58},{64,-37}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-32,-60},{-10,-37}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{64,-83},{40,-62}})));
  TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
    redeclare package Medium = Medium,
    precision=2,
    precision2=1) annotation (Placement(transformation(extent={{-4,-82},{-28,-62}})));
  Components.Turbine_v2         Turbine(
    redeclare package Medium = Medium,
    pstart_out=initialConditions.Turbine_P_ref,
    Tstart_in=initialConditions.Turbine_TStart_In,
    Tstart_out=initialConditions.Turbine_TStart_Out,
    eta0=operatingConditions.Turbine_Efficiency,
    PR0=operatingConditions.Turbine_PressureRatio,
    w0=operatingConditions.Turbine_NominalMassFlowRate)
    annotation (Placement(transformation(
        extent={{18,14},{-18,-14}},
        rotation=180,
        origin={-74,14})));
  Components.Compressor_v2              Comp2(
    redeclare package Medium = Medium,
    pstart_in=initialConditions.Comp2_P_ref,
    Tstart_in=initialConditions.Comp2_TStart_In,
    Tstart_out=initialConditions.Comp2_TStart_Out,
    eta0=operatingConditions.Comp2_Efficiency,
    PR0=operatingConditions.Comp2_PressureRatio,
    w0=operatingConditions.Comp2_NominalMassFlowRate)
             annotation (Placement(transformation(extent={{-100,-69},{-74,-47}})));
  Components.Compressor_v2              Comp1(
    redeclare package Medium = Medium,
    pstart_in=initialConditions.Comp1_P_ref,
    Tstart_in=initialConditions.Comp1_TStart_In,
    Tstart_out=initialConditions.Comp1_TStart_Out,
    eta0=operatingConditions.Comp1_Efficiency,
    PR0=operatingConditions.Comp1_PressureRatio,
    w0=operatingConditions.Comp1_NominalMassFlowRate)
             annotation (Placement(transformation(extent={{32,-144},{58,-122}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=initialConditions.Cooler_PStart,
    T_start=initialConditions.Cooler_TStart,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
    redeclare package Medium = Medium,
    use_HeatPort=true)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-110,-86})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary(T=309.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-86})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{86,-107},{100,-93}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow      BoundaryIn(
    redeclare package Medium = Medium)
              annotation (Placement(transformation(extent={{-110,22},{-90,43}}),  iconTransformation(extent={{-110,21},{-90,43}})));
  InitialConditions initialConditions annotation (Placement(transformation(extent={{124,126},{144,146}})));
  OperatingConditions operatingConditions annotation (Placement(transformation(extent={{86,126},{106,146}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=
        0.378250591016547) annotation (Placement(transformation(extent={{-76,-134},{-96,-114}})));
  Modelica.Fluid.Fittings.TeeJunctionVolume Split(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p_start=8411000,
    T_start=372.25,
    V=0.1)
    annotation (Placement(transformation(extent={{-52,-131},{-38,-117}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1
         - FlowResistance1.R) annotation (Placement(transformation(extent={{-12,-134},{8,-114}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-9,
    Ti=15,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1)
            annotation (Placement(transformation(extent={{6,52},{-14,72}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Turbine.pout) annotation (Placement(transformation(extent={{64,22},{44,42}})));
  Modelica.Blocks.Sources.Constant const(k=84.4e5)
                                                  annotation (Placement(transformation(extent={{64,52},{44,72}})));
  Modelica.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    dp_nominal=1000,
    m_flow_nominal=1)  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-42,52})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=8451000,
    T=908.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-42,84})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Merge1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-49,21},{-35,35}})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_elec
    annotation (Placement(transformation(extent={{132,-10},{154,12}}), iconTransformation(extent={{86,-10},{108,12}})));
equation

Q_gen = Turbine.Wt - Comp1.Wc - Comp2.Wc; //Net power(electricity) of the system = TurbinePower - Comp1Power - Comp2Power
  port_elec.W = Q_gen; //Connecting Net power to electrical port

  connect(boundary.port, Cooler.heatPort) annotation (Line(points={{-130,-86},{-116,-86}},  color={191,0,0}));
  connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
    annotation (Line(points={{26,-3.2},{44,-3.2},{44,10}},             color={0,127,255}));
  connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
    annotation (Line(points={{42,-20},{38,-20},{38,-10.4},{26,-10.4}}, color={0,127,255}));
  connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
    annotation (Line(points={{0,-10.4},{0,-18},{-10,-18}},         color={0,127,255}));
  connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
    annotation (Line(points={{28,-53.2},{36,-53.2},{36,-47.5},{44,-47.5}},
                                                                       color={0,127,255}));
  connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
    annotation (Line(points={{40,-72.5},{32,-72.5},{32,-60.4},{28,-60.4}},
                                                                     color={0,127,255}));
  connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
    annotation (Line(points={{2,-60.4},{-2,-60.4},{-2,-72},{-4,-72}},
                                                                 color={0,127,255}));
  connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-110,-80},{-110,-48},{-94.8,-48},{-94.8,-49.2}}, color={0,127,255}));
  connect(FlowResistance1.port_a,Split. port_1) annotation (Line(points={{-79,-124},{-52,-124}},
                                                                                               color={0,127,255}));
  connect(Split.port_2,FlowResistance2. port_a) annotation (Line(points={{-38,-124},{-9,-124}},
                                                                                            color={0,127,255}));
  connect(PID.y, valveLinear.opening) annotation (Line(points={{-15,62},{-22,62},{-22,52},{-34,52}},
                                                                                   color={0,0,127}));
  connect(const.y, PID.u_s) annotation (Line(points={{43,62},{8,62}},    color={0,0,127}));
  connect(realExpression.y, PID.u_m) annotation (Line(points={{43,32},{-4,32},{-4,50}},             color={0,0,127}));
  connect(Sink.ports[1], valveLinear.port_b) annotation (Line(points={{-42,77},{-42,62}},             color={0,127,255}));
  connect(Comp1.outlet, Merge.port_2) annotation (Line(points={{52.8,-124.2},{52.8,-122},{108,-122},{108,-100},{100,-100}},
                                                                                                     color={0,127,255}));

  connect(Cooler.port_a, FlowResistance1.port_b) annotation (Line(points={{-110,-92},{-110,-124},{-93,-124}},
                                                                                                            color={0,127,255}));
  connect(HX1_sensor_TubeIn.port_b, HX1.Tube_in) annotation (Line(points={{-8,11.5},{0,11.5},{0,-3.2}},
                                                                                                     color={0,127,255}));
  connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a) annotation (Line(points={{66,10},{68,10},{68,-72.5},{64,-72.5}},
                                                                                                                             color={0,127,255}));
  connect(HX2_sensor_TubeIn.port_b, HX2.Tube_in) annotation (Line(points={{-10,-48.5},{-4,-48.5},{-4,-53.2},{2,-53.2}},
                                                                                                                    color={0,127,255}));
  connect(Comp2.outlet, HX2_sensor_TubeIn.port_a) annotation (Line(points={{-79.2,-49.2},{-78,-49.2},{-78,-48.5},{-32,-48.5}},
                                                                                                                           color={0,127,255}));
  connect(HX2_sensor_TubeOut.port_b, Merge.port_1) annotation (Line(points={{64,-47.5},{80,-47.5},{80,-100},{86,-100}},
                                                                                                                  color={0,127,255}));
  connect(HX2_sensor_ShellOut.port_b, Split.port_3) annotation (Line(points={{-28,-72},{-45,-72},{-45,-117}},color={0,127,255}));
  connect(Merge.port_3, HX1_sensor_ShellIn.port_a) annotation (Line(points={{93,-93},{92,-93},{92,-20},{64,-20}},
                                                                                                                color={0,127,255}));
  connect(valveLinear.port_a, Merge1.port_3) annotation (Line(points={{-42,42},{-42,35}}, color={0,127,255}));
  connect(Turbine.outlet, Merge1.port_1) annotation (Line(points={{-63.2,25.2},{-62,25.2},{-62,28},{-49,28}}, color={0,127,255}));
  connect(Merge1.port_2, HX1_sensor_TubeIn.port_a) annotation (Line(points={{-35,28},{-30,28},{-30,11.5}}, color={0,127,255}));
  connect(Turbine.inlet, BoundaryIn) annotation (Line(points={{-84.8,25.2},{-84.8,32},{-94,32},{-94,32.5},{-100,32.5}},
                                                                                                      color={0,127,255}));
  connect(HX1_sensor_ShellOut.port_b, BoundaryOut) annotation (Line(points={{-32,-18},{-100,-18}},
                                                                                                 color={0,127,255}));
  connect(FlowResistance2.port_b, Comp1.inlet) annotation (Line(points={{5,-124},{37.2,-124},{37.2,-124.2}}, color={0,127,255}));
   annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,-150},{
             150,150}})),
                 Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-80,50},{80,-50}},
          textColor={28,108,200},
          textString="sCO2 Brayton_Cycle")}),
          experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=591,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
    <p>An example of a supercritical CO2 Brayton Cycle that produces power via gas turbine. This model requires a heat source to be connected via the fluid ports on the left hand side of the default model orientation.</p>
    <p>This model uses CoolProp CO2 medium with a default operating pressure of 75 bars. One should be careful about the dummy assignments in turbomachinery components as the default values of 1 bar could cause issues. Modify the default values to 10 bars instead</p>
    <p>This model is mostly based on the model presented in the following article: https://doi.org/10.1115/IMECE2011-63073</p>
    </html>"));
end Brayton_Cycle_sCO2_Simple;
