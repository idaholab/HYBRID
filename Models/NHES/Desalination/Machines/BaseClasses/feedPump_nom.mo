within NHES.Desalination.Machines.BaseClasses;
model feedPump_nom
  extends Modelica.Icons.Example;

  //parameter SI.Time T_pumpFilter = 8 "Time constant for the pump actuator";

  //parameter Real FBctrl_pH2O_out_k = (1/699.066666666667)*3 "Gain"  annotation (Dialog(tab="PI controller", group="Parameters"));
  //parameter Real FBctrl_pH2O_out_T = 7.86284785139149 "Time constant" annotation (Dialog(tab="PI controller", group="Parameters"));

  //outer Modelica.Fluid.System system "System wide properties";
  //replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium in the component" annotation (choicesAllMatching = true);
  parameter Boolean allowFlowReversal = system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)";
  parameter Integer NoPumps = 1 "Number of pumps";
  parameter Real eta_nominal = 0.8 "Nominal efficiency";
  parameter SI.Volume V = 0 "Volume inside the pump";
  parameter Modelica.Units.NonSI.AngularVelocity_rpm Nrpm0=1800
    "Nominal rotational speed for flow characteristic [rpm]";
  parameter SI.Pressure pout_start = 17.5133*1e5 "Start value for the oulet pressure";
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=
      4.36917117117117*111*NoPumps "Guess value of m_flow = port_a.m_flow";

  Modelica.Fluid.Machines.PrescribedPump feedPump(
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    use_N_in=true,
    allowFlowReversal=allowFlowReversal,
    use_powerCharacteristic=false,
    redeclare replaceable function efficiencyCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
        (eta_nominal=eta_nominal),
    checkValve=true,
    V=V,
    use_HeatTransfer=false,
    p_a_start=system.p_ambient,
    p_b_start=pout_start,
    T_start=system.T_ambient,
    rho_nominal=1000.24,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          head_nominal={20,168.213313804152,220}, V_flow_nominal={0.969729664880429,
            0.484864832440214,0.060608104055027}),
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_start=m_flow_start,
    nParallel=NoPumps,
    N_nominal=Nrpm0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.Boundary_pT brineSource(
    nPorts=1,
    use_p_in=false,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    X=NHES.Desalination.Media.BrineProp.Xi2X({0.003502}),
    T=298.15)                                             annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,0})));
  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=298.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.Boundary_pT brineSink(
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    p(displayUnit="bar") = 1751330,
    nPorts=1)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));

  Modelica.Blocks.Sources.Ramp N_signal(
    duration=0,
    startTime=10,
    offset=1800,
    height=-200)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
equation
  connect(brineSource.ports[1], feedPump.port_a)
    annotation (Line(points={{-40,0},{-25,0},{-10,0}}, color={0,127,255}));
  connect(N_signal.y, feedPump.N_in)
    annotation (Line(points={{-19,50},{0,50},{0,10}}, color={0,0,127}));
  connect(brineSink.ports[1], feedPump.port_b)
    annotation (Line(points={{70,0},{40,0},{10,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=100,
      Interval=0.1,
      __Dymola_Algorithm="Esdirk45a"));
end feedPump_nom;
