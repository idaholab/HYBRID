within NHES.Desalination.Machines.Examples;
model PumpWithMotor_test
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
    "Nominal rotational speed for flow characteristic [rpm]"
    annotation (Dialog(tab="General", group="Characteristics"));
  final parameter SI.AngularVelocity N0 = Modelica.Units.Conversions.from_rpm(  Nrpm0)
    "Rated rotational speed of the shaft in rad/s";

  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=
      4.36917117117117*111*NoPumps "Guess value of m_flow = port_a.m_flow" annotation (Dialog(tab="Initialization"));
  parameter SI.Pressure pin_start = 1.01325*1e5 "Start value for the oulet pressure" annotation (Dialog(tab="Initialization"));
  parameter SI.Pressure pout_start = 17.5133*1e5 "Start value for the oulet pressure" annotation (Dialog(tab="Initialization"));

  Modelica.Fluid.Machines.Pump           feedPump(
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    allowFlowReversal=allowFlowReversal,
    use_powerCharacteristic=false,
    redeclare replaceable function efficiencyCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
        (eta_nominal=eta_nominal),
    checkValve=true,
    V=V,
    use_HeatTransfer=false,
    p_b_start=pout_start,
    T_start=system.T_ambient,
    rho_nominal=1000.24,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          head_nominal={20,168.213313804152,220}, V_flow_nominal={0.969729664880429,
            0.484864832440214,0.060608104055027}),
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    p_a_start=pin_start,
    m_flow_start=m_flow_start,
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
        origin={-70,0})));
  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=298.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.Boundary_pT brineSink(
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    nPorts=1,
    p(displayUnit="bar") = 1400000)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));

  Modelica.Fluid.Valves.ValveLinear LCV(
    m_flow_small=0.001,
    show_T=true,
    dp_nominal=0.8*((17.5133 - 14)*1e5),
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    dp_start=((17.5133 - 14)*1e5),
    m_flow_start=m_flow_start,
    m_flow(start=m_flow_start),
    m_flow_nominal=m_flow_start)        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={40,0})));
  Modelica.Blocks.Sources.Ramp LCV_opening(
    height=0,
    duration=0,
    offset=0.8,
    startTime=10)
    annotation (Placement(transformation(extent={{80,50},{60,70}})));

  SimpleMotor                                  motor(
    Rm=20,
    Lm=0.1,
    kT=35,
    dm=1,
    Jm=289,
    n(start=Nrpm0, fixed=true),
    Damper(phi_rel(start=0, fixed=true)),
    J(phi(start=0),
      a(start=0),
      flange_a(tau(start=5305.3375, fixed=true)),
      w(start=N0))) annotation (Placement(transformation(extent={{-30,50},{-10,
            70}}, rotation=0)));
  Modelica.Blocks.Sources.Ramp Voltage_signal(
    duration=0,
    startTime=10,
    height=0,
    offset=9736.677*45)
                     annotation (Placement(transformation(extent={{-70,50},{-50,
            70}}, rotation=0)));
equation
  connect(brineSource.ports[1], feedPump.port_a)
    annotation (Line(points={{-60,-1.33227e-015},{-48,-1.33227e-015},{-48,0},{
          -10,0}},                                     color={0,127,255}));
  connect(brineSink.ports[1], LCV.port_b)
    annotation (Line(points={{70,0},{70,-1.33227e-015},{50,-1.33227e-015}},
                                                    color={0,127,255}));
  connect(feedPump.port_b, LCV.port_a)
    annotation (Line(points={{10,0},{30,0}},        color={0,127,255}));
  connect(LCV.opening, LCV_opening.y)
    annotation (Line(points={{40,8},{40,60},{59,60}}, color={0,0,127}));
  connect(motor.flange_b, feedPump.shaft)
    annotation (Line(points={{-9.2,60},{0,60},{0,10}},   color={0,0,0}));
  connect(Voltage_signal.y, motor.inPort)
    annotation (Line(points={{-49,60},{-42,60},{-29.9,60}},
                                                  color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=100,
      Interval=0.1,
      __Dymola_Algorithm="Esdirk45a"));
end PumpWithMotor_test;
