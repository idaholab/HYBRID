within NHES.Desalination.Machines;
model PumpingSystem
  extends NHES.Desalination.Icons.PumpingSystem;

  //parameter SI.Time T_pumpFilter = 8 "Time constant for the pump actuator";

  //parameter Real FBctrl_pH2O_out_k = (1/699.066666666667)*3 "Gain"  annotation (Dialog(tab="PI controller", group="Parameters"));
  //parameter Real FBctrl_pH2O_out_T = 7.86284785139149 "Time constant" annotation (Dialog(tab="PI controller", group="Parameters"));

  outer Modelica.Fluid.System system "System wide properties";
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium in the component" annotation (choicesAllMatching = true);
  parameter Boolean allowFlowReversal = system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)";
  parameter Integer NoPumps = 1 "Number of pumps in parallel" annotation (Dialog(tab="General", group="Characteristics"));
  parameter Integer NoVesselUnits_per_pump = 111 "Number of RO vessel units per pump" annotation (Dialog(tab="General", group="Characteristics"));
  parameter Modelica.Units.SI.Volume V=0 "Volume inside the pump";

  parameter Modelica.Units.NonSI.AngularVelocity_rpm Nrpm0=1800
    "Nominal rotational speed for flow characteristic [rpm]"
    annotation (Dialog(tab="General", group="Characteristics"));
  final parameter Modelica.Units.SI.AngularVelocity N0=
      Modelica.Units.Conversions.from_rpm(Nrpm0)
    "Rated rotational speed of the shaft in rad/s";
  parameter Real eta_nominal = 0.8 "Nominal efficiency" annotation (Dialog(tab="General", group="Characteristics"));

  parameter Modelica.Units.SI.Pressure pin_start=system.p_ambient
    "Start value for the oulet pressure"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Pressure pout_start=17.5133*1e5
    "Start value for the oulet pressure"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_start=4.36917117117117*
      NoVesselUnits_per_pump*NoPumps "Guess value of m_flow = port_a.m_flow"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Inertia Jm=1142.7 "Motor Inertia"
    annotation (Dialog(tab="General", group="Characteristics"));

  Modelica.Fluid.Machines.Pump           feedPump(
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
    m_flow_start=m_flow_start,
    N_nominal=Nrpm0,
    redeclare package Medium = Medium,
    p_a_start=system.p_ambient,
    nParallel=NoPumps)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  SimpleMotor                                  motor(
    Rm=20,
    Lm=0.1,
    kT=35,
    dm=1,
    n(start=Nrpm0, fixed=true),
    Damper(phi_rel(start=0, fixed=true)),
    J(phi(start=0),
      a(start=0),
      flange_a(tau(start=5305.3375, fixed=true)),
      w(start=N0)),
    inPort(unit="V", quantity="ElectricPotential"),
    Jm=Jm)          annotation (Placement(transformation(extent={{-9,-10},{9,10}},
          rotation=0,
        origin={-9,60})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a( redeclare package Medium =
       Medium) annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b( redeclare package Medium =
       Medium) annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput Voltage(
    min=0,
    final unit="V",
    displayUnit="V",
    final quantity="ElectricPotential") annotation (Placement(transformation(
          extent={{-14,-14},{14,14}},
        rotation=270,
        origin={0,106}),                iconTransformation(extent={{-14,-14},{14,
            14}},
        rotation=270,
        origin={0,98})));
  Modelica.Mechanics.Rotational.Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=270,
        origin={8.88178e-016,34})));
  Modelica.Blocks.Interfaces.RealOutput Load(
    min=0,
    final quantity="Power",
    final unit="W",
    displayUnit="MW") annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=180,
        origin={-108,40}),
                         iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=180,
        origin={-102,40})));
equation

  connect(feedPump.port_b, port_b)
    annotation (Line(points={{10,0},{62,0},{100,0}},  color={0,127,255}));
  connect(port_a, feedPump.port_a)
    annotation (Line(points={{-100,0},{-10,0}},        color={0,127,255}));
  connect(motor.flange_b, multiSensor.flange_a)
    annotation (Line(points={{0.72,60},{0.72,42},{2.33147e-015,42}},
                                                         color={0,0,0}));
  connect(feedPump.shaft, multiSensor.flange_b)
    annotation (Line(points={{0,10},{0,26},{-6.66134e-016,26}},
                                                    color={0,0,0}));
  connect(Voltage, motor.inPort) annotation (Line(points={{0,106},{0,80},{-30,
          80},{-30,60},{-17.91,60}}, color={0,0,127}));
  connect(Load, multiSensor.power) annotation (Line(points={{-108,40},{-8.8,40},
          {-8.8,38.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=100,
      Interval=0.1,
      __Dymola_Algorithm="Esdirk45a"));
end PumpingSystem;
