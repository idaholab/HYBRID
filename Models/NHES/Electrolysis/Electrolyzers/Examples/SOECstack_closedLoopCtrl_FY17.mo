within NHES.Electrolysis.Electrolyzers.Examples;
model SOECstack_closedLoopCtrl_FY17
  "Closed-loop control for SOEC stack operation"
  import NHES.Electrolysis;
  import NHES;
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp power_set(
    offset=9.10627*1e6*5,
    duration=0,
    startTime=10,
    height=-1.929*1e6*5*3)
    annotation (Placement(transformation(extent={{-68,44},{-52,60}})));

  Modelica.Fluid.Sources.Boundary_pT cathodeGasSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1767600,
    T=1023.15)
    annotation (Placement(transformation(extent={{80,-4},{62,14}})));

  Modelica.Fluid.Sources.Boundary_pT anodeGasSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=1767600,
    T=1023.15)
    annotation (Placement(transformation(extent={{80,-34},{62,-16}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow prescribedPowerFlow
    annotation (Placement(transformation(extent={{-40,42},{-20,62}})));
  Modelica.Fluid.Valves.ValveLinear PCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=controlledSOEC.wCathode_out_start,
    m_flow(start=controlledSOEC.wCathode_out_start),
    m_flow_nominal=controlledSOEC.wCathode_out_start,
    dp_nominal=controlledSOEC.cathodePCV_valveOpening_start*((19.64 -
        17.676)*1e5),
    dp_start=((19.64 - 17.676)*1e5))
                           annotation (Placement(transformation(
        extent={{7,7},{-7,-7}},
        rotation=180,
        origin={47,5})));

  Modelica.Fluid.Valves.ValveLinear PCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=controlledSOEC.wAnode_out_start,
    m_flow(start=controlledSOEC.wAnode_out_start),
    m_flow_nominal=controlledSOEC.wAnode_out_start,
    dp_nominal=controlledSOEC.anodePCV_valveOpening_start*((19.64 -
        17.676)*1e5),
    dp_start=((19.64 - 17.676)*1e5))       annotation (Placement(
        transformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={47,-25})));
  Modelica.Blocks.Continuous.FirstOrder actuator_pAnSOEC(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=controlledSOEC.anodePCV_valveOpening_start)
                 annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={28,-44})));
  Modelica.Blocks.Continuous.FirstOrder actuator_wAnode_in(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=controlledSOEC.anodeFCV_valveOpening_start)
          annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-28,-44})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasSource(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    X=Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*
        1000}),
    p(displayUnit="bar") = 2182222,
    T=1123.15)
    annotation (Placement(transformation(extent={{-80,-6},{-62,12}})));

  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=
        288.15)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Fluid.Valves.ValveLinear FCV_catSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    m_flow_start=controlledSOEC.wCathode_in_start,
    m_flow(start=controlledSOEC.wCathode_in_start),
    m_flow_nominal=controlledSOEC.wCathode_in_start,
    dp_nominal=controlledSOEC.cathodeFCV_valveOpening_start*((21.82222 -
        19.64)*1e5),
    dp_start=(21.82222 - 19.64)*1e5)
                           annotation (Placement(transformation(
        extent={{7,7},{-7,-7}},
        rotation=180,
        origin={-47,3})));

  Modelica.Blocks.Continuous.FirstOrder actuator_pCatSOEC(
    k=1,
    T=4,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=controlledSOEC.cathodePCV_valveOpening_start)
                 annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={28,22})));
  Modelica.Blocks.Continuous.FirstOrder actuator_wCathode_in(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=4,
    y_start=controlledSOEC.cathodeFCV_valveOpening_start)
                                                       annotation (
      Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-28,22})));
  Modelica.Fluid.Sources.Boundary_pT anodeGasSource(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    nPorts=1,
    p(displayUnit="bar") = 2182222,
    T=1123.15)
    annotation (Placement(transformation(extent={{-80,-34},{-62,-16}})));

  Modelica.Fluid.Valves.ValveLinear FCV_anSOEC(
    m_flow_small=0.001,
    show_T=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    m_flow_start=controlledSOEC.wAnode_in_start,
    m_flow(start=controlledSOEC.wAnode_in_start),
    m_flow_nominal=controlledSOEC.wAnode_in_start,
    dp_nominal=controlledSOEC.anodeFCV_valveOpening_start*((21.82222 -
        19.64)*1e5),
    dp_start=(21.82222 - 19.64)*1e5)      annotation (Placement(
        transformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={-47,-25})));
  NHES.Electrolysis.Electrolyzers.ControlledSOEC_integratedWithHTSEplant_FY17
    controlledSOEC(
    numCells_perVessel=68320,
    numVessels=5,
    initType_cathodeFCV=Modelica.Blocks.Types.Init.SteadyState,
    initType_anodeFCV=Modelica.Blocks.Types.Init.SteadyState,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState,
    initType_cathodePCV=Modelica.Blocks.Types.Init.InitialOutput,
    initType_anodePCV=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(power_set.y, prescribedPowerFlow.P_flow)
    annotation (Line(points={{-51.2,52},{-51.2,52},{-38,52}},
                                                 color={0,0,127}));
  connect(PCV_catSOEC.port_b, cathodeGasSink.ports[1])
    annotation (Line(points={{54,5},{54,5},{62,5}}, color={0,127,255}));
  connect(PCV_anSOEC.port_b, anodeGasSink.ports[1]) annotation (Line(
        points={{54,-25},{54,-25},{62,-25}}, color={0,127,255}));
  connect(actuator_pAnSOEC.y, PCV_anSOEC.opening) annotation (Line(points={{36.8,
          -44},{47,-44},{47,-30.6}},       color={0,0,127}));
  connect(FCV_catSOEC.port_a, cathodeGasSource.ports[1]) annotation (Line(
        points={{-54,3},{-54,3},{-62,3}}, color={0,127,255}));
  connect(actuator_pCatSOEC.y, PCV_catSOEC.opening) annotation (Line(
        points={{36.8,22},{47,22},{47,10.6}}, color={0,0,127}));
  connect(actuator_wCathode_in.y, FCV_catSOEC.opening) annotation (Line(
        points={{-36.8,22},{-47,22},{-47,8.6}},  color={0,0,127}));
  connect(anodeGasSource.ports[1], FCV_anSOEC.port_a) annotation (Line(
        points={{-62,-25},{-58,-25},{-54,-25}}, color={0,127,255}));
  connect(actuator_wAnode_in.y, FCV_anSOEC.opening) annotation (Line(
        points={{-36.8,-44},{-47,-44},{-47,-30.6}}, color={0,0,127}));
  connect(controlledSOEC.ctrlCathodeIn, FCV_catSOEC.port_b)
    annotation (Line(points={{-7.4,3},{-24,3},{-40,3}}, color={0,127,255}));
  connect(controlledSOEC.ctrlCathodeOut, PCV_catSOEC.port_a)
    annotation (Line(points={{7.4,5},{16,5},{40,5}}, color={0,127,255}));
  connect(controlledSOEC.ctrlAnodeOut, PCV_anSOEC.port_a) annotation (Line(
        points={{7.4,-3.4},{20,-3.4},{20,-25},{40,-25}}, color={0,127,255}));
  connect(controlledSOEC.ctrlAnodeIn, FCV_anSOEC.port_b) annotation (Line(
        points={{-7.4,-5.4},{-20,-5.4},{-20,-25},{-40,-25}}, color={0,127,255}));
  connect(controlledSOEC.ctrlElectricalLoad, prescribedPowerFlow.port_b)
    annotation (Line(points={{-7.6,-1},{-10,-1},{-14,-1},{-14,52},{-20,52}},
        color={255,0,0}));
  connect(controlledSOEC.c_wCathode, actuator_wCathode_in.u)
    annotation (Line(points={{-2,6},{-2,22},{-18.4,22}}, color={0,0,127}));
  connect(controlledSOEC.c_pCathode, actuator_pCatSOEC.u)
    annotation (Line(points={{2,6},{2,22},{18.4,22}}, color={0,0,127}));
  connect(controlledSOEC.c_wAnodeIn, actuator_wAnode_in.u) annotation (Line(
        points={{-2.8,-7.4},{-2.8,-44},{-18.4,-44}}, color={0,0,127}));
  connect(controlledSOEC.c_pAnode, actuator_pAnSOEC.u) annotation (Line(points={
          {1.2,-7.4},{1.2,-20},{1.2,-44},{18.4,-44}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=600,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end SOECstack_closedLoopCtrl_FY17;
