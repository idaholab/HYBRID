within NHES.Desalination.Machines.Examples;
model PumpingSystem_test
  extends Modelica.Icons.Example;

  //parameter SI.Time T_pumpFilter = 8 "Time constant for the pump actuator";

  //parameter Real FBctrl_pH2O_out_k = (1/699.066666666667)*3 "Gain"  annotation (Dialog(tab="PI controller", group="Parameters"));
  //parameter Real FBctrl_pH2O_out_T = 7.86284785139149 "Time constant" annotation (Dialog(tab="PI controller", group="Parameters"));

  //outer Modelica.Fluid.System system "System wide properties";
  //replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium in the component" annotation (choicesAllMatching = true);
  //parameter Boolean allowFlowReversal = system.allowFlowReversal
  //  "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)";
  //parameter Integer NoPumps = 1 "Number of pumps";
  //parameter SI.Volume V = 0 "Volume inside the pump";
  //parameter SI.Conversions.NonSIunits.AngularVelocity_rpm Nrpm0 = 1800
  //"Nominal rotational speed for flow characteristic [rpm]" annotation (Dialog(tab="General", group="Characteristics"));
  //final parameter SI.AngularVelocity N0 = Modelica.SIunits.Conversions.from_rpm(Nrpm0)
  //  "Rated rotational speed of the shaft in rad/s";
  //parameter Real eta_nominal = 0.8 "Nominal efficiency";

  final parameter Integer NoVesselUnits_per_pump = 111
    "Number of RO vessel units per pump";
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=
      4.36917117117117*NoVesselUnits_per_pump*1 "Guess value of m_flow = port_a.m_flow" annotation (Dialog(tab="Initialization"));
 // parameter SI.Pressure pin_start = 1.01325*1e5 "Start value for the oulet pressure" annotation (Dialog(tab="Initialization"));
  //parameter SI.Pressure pout_start = 17.5133*1e5 "Start value for the oulet pressure" annotation (Dialog(tab="Initialization"));

  Modelica.Fluid.Sources.Boundary_pT brineSource(
    use_p_in=false,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    X=NHES.Desalination.Media.BrineProp.Xi2X({0.003502}),
    nPorts=1,
    p=system.p_ambient,
    T=system.T_ambient)                                   annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,0})));
  inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=298.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.Boundary_pT brineSink(
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    nPorts=1,
    p(displayUnit="bar") = 1751330)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));

  PumpingSystem pumpingSystem(
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    V=1,
    NoPumps=1,
    NoVesselUnits_per_pump=NoVesselUnits_per_pump)
         annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Electrolysis.Sensors.TempSensorWithThermowell Tout_sensor(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium = Media.BrineProp.BrineDriesner,
    y_start=25 + 273.15)
    annotation (Placement(transformation(extent={{28,20},{48,40}})));
  Modelica.Blocks.Sources.Ramp Voltage_signal(
    duration=0,
    startTime=10,
    offset=9736.677,
    height=-2650)    annotation (Placement(transformation(extent={{-40,20},{-20,
            40}}, rotation=0)));
equation
  connect(brineSource.ports[1], pumpingSystem.port_a)
    annotation (Line(points={{-60,0},{-35,0},{-10,0}}, color={0,127,255}));
  connect(brineSink.ports[1], pumpingSystem.port_b)
    annotation (Line(points={{70,0},{40,0},{10,0}}, color={0,127,255}));
  connect(Tout_sensor.port, pumpingSystem.port_b) annotation (Line(points={{38,
          20},{38,20},{38,0},{10,0}}, color={0,127,255}));
  connect(Voltage_signal.y, pumpingSystem.Voltage)
    annotation (Line(points={{-19,30},{0,30},{0,9.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=100,
      Interval=0.1,
      __Dymola_Algorithm="Esdirk45a"));
end PumpingSystem_test;
