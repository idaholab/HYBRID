within NHES.Systems.EnergyStorage.Concrete_Solid_Media.Examples;
model CTES_GMI
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.MassFlowRate shell_flow_shim=1.5;
  parameter Modelica.Units.SI.MassFlowRate tube_flow_shim=1.5;
  Modelica.Units.SI.Power Q_Ch;
  Modelica.Units.SI.Power Q_Dis;
  parameter Modelica.Units.SI.Power Ref_Ch_Power = 6e6;
  parameter Modelica.Units.SI.Power Ref_Dis_Power = 6e6; //e6 makes it MW
  parameter Modelica.Units.SI.Time ramp_speed=90; //seconds

  Components.Dual_Pipe_Model CTES(
    nY=7,
    nX=9,
    tau=0.05,
    nPipes=250,
    dX=150,
    dY=0.3,
    redeclare package TES_Med = BaseClasses.HeatCrete,
    HTF_h_start_hot=2500e3,
    HTF_h_start_cold=600e3,
    Hot_Con_Start=443.15,
    Cold_Con_Start=363.15)
    annotation (Placement(transformation(extent={{-34,-28},{36,42}})));

  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Condensate(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=2000000,
    h=500e3,
    nPorts=1) annotation (Placement(transformation(extent={{100,48},{80,68}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Discharge_Exit(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=110000,
    h=2500e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-94,-38},{-74,-18}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Charge_Source(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=2130000,
    h=3000e3,
    nPorts=1) annotation (Placement(transformation(extent={{-200,6},{-180,26}})));
  Modelica.Blocks.Sources.Trapezoid Charge_Position_Signal(
    amplitude=1,
    rising=900,
    width=28100,
    falling=900,
    period=86400,
    offset=0,
    startTime=90000)
    annotation (Placement(transformation(extent={{-180,30},{-160,50}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort Charge_Out(redeclare package
      Medium = Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{18,70},{56,46}})));
  TRANSFORM.Fluid.Valves.ValveLinear Charge_Valve(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=100000,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{-158,0},{-126,32}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort Discharge_out(redeclare
      package Medium = Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-28,-38},{-60,-18}})));
  Modelica.Blocks.Sources.Trapezoid Dicharge_Power_Signal(
    amplitude=5e6,
    rising=ramp_speed,
    width=29720,
    falling=ramp_speed,
    period=86400,
    offset=0,
    startTime=135000)
    annotation (Placement(transformation(extent={{62,18},{82,38}})));
  TRANSFORM.Fluid.Valves.ValveLinear Discharge_Valve(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=150000,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{160,-14},{122,24}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Discharge_Source(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=250000,
    h=500e3,
    nPorts=1) annotation (Placement(transformation(extent={{214,-4},{194,16}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort Discharge_in(redeclare
      package Medium = Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{88,-4},{56,16}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort Charge_In(redeclare package
      Medium = Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-86,26},{-48,2}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-7,
    yMax=1.0,
    yMin=0.0) annotation (Placement(transformation(extent={{138,40},{158,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Q_Dis)
    annotation (Placement(transformation(extent={{92,10},{112,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=Q_Ch)
    annotation (Placement(transformation(extent={{-62,56},{-82,76}})));
  Modelica.Blocks.Sources.Trapezoid Charge_Power_Signal(
    amplitude=5e6,
    rising=90,
    width=29720,
    falling=90,
    period=86400,
    offset=0,
    startTime=135000)
    annotation (Placement(transformation(extent={{-54,80},{-74,100}})));
  TRANSFORM.Controls.LimPID PID_Charge(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-7,
    yMax=1.0,
    yMin=0.0)
    annotation (Placement(transformation(extent={{-96,80},{-116,100}})));
  Modelica.Blocks.Sources.Trapezoid Discharge_Position_Signal(
    amplitude=1,
    rising=900,
    width=28100,
    falling=900,
    period=86400,
    offset=0,
    startTime=135000)
    annotation (Placement(transformation(extent={{212,46},{192,66}})));
equation

  Q_Ch = Charge_In.port_a.m_flow*(Charge_In.h_out-Charge_Out.h_out);
  Q_Dis = Discharge_in.port_a.m_flow*(Discharge_out.h_out-Discharge_in.h_out);

  connect(Charge_Valve.port_a, Charge_Source.ports[1]) annotation (Line(points={{-158,16},
          {-180,16}},                            color={0,127,255}));
  connect(Charge_Position_Signal.y, Charge_Valve.opening) annotation (Line(
        points={{-159,40},{-144,40},{-144,36},{-142,36},{-142,28.8}}, color={0,0,
          127}));
  connect(Discharge_Source.ports[1], Discharge_Valve.port_a) annotation (Line(
        points={{194,6},{160,5}},                 color={0,127,255}));
  connect(CTES.Charge_Outlet, Charge_Out.port_a) annotation (Line(points={{11.5,
          28.7},{11.5,28},{14,28},{14,58},{18,58}}, color={0,127,255}));
  connect(CTES.Discharge_Outlet, Discharge_out.port_a) annotation (Line(points={
          {-4.6,-12.6},{-12,-12.6},{-12,-28},{-28,-28}}, color={0,127,255}));
  connect(Charge_Out.port_b, Condensate.ports[1])
    annotation (Line(points={{56,58},{80,58}}, color={0,127,255}));
  connect(Discharge_out.port_b, Discharge_Exit.ports[1])
    annotation (Line(points={{-60,-28},{-74,-28}}, color={0,127,255}));

  connect(Discharge_Valve.port_b, Discharge_in.port_a)
    annotation (Line(points={{122,5},{88,6}}, color={0,127,255}));
  connect(Discharge_in.port_b, CTES.Discharge_Inlet)
    annotation (Line(points={{56,6},{28.3,6.3}}, color={0,127,255}));
  connect(CTES.Charge_Inlet, Charge_In.port_b) annotation (Line(points={{-26.3,14.7},
          {-37.15,14.7},{-37.15,14},{-48,14}}, color={0,127,255}));
  connect(Charge_In.port_a, Charge_Valve.port_b) annotation (Line(points={{-86,14},
          {-120,14.7},{-120,16},{-126,16}}, color={0,127,255}));
  connect(PID.u_m, realExpression.y) annotation (Line(points={{148,38},{148,28},
          {118,28},{118,20},{113,20}}, color={0,0,127}));
  connect(Dicharge_Power_Signal.y, PID.u_s) annotation (Line(points={{83,28},{88,
          28},{88,30},{108,30},{108,46},{136,46},{136,50}}, color={0,0,127}));
  connect(Discharge_Valve.opening, PID.y) annotation (Line(points={{141,20.2},{172,
          20.2},{172,50},{159,50}},     color={0,0,127}));
  connect(Charge_Power_Signal.y, PID_Charge.u_s) annotation (Line(points={{-75,90},
          {-94,90}},
        color={0,0,127}));
  connect(PID_Charge.u_m, realExpression1.y) annotation (Line(points={{-106,78},
          {-106,66},{-83,66}},                      color={0,0,127}));
  annotation (experiment(
      StopTime=864000,
      __Dymola_NumberOfIntervals=1957,
      __Dymola_Algorithm="Esdirk45a"),
    Diagram(coordinateSystem(extent={{-120,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-120,-100},{160,100}})));
end CTES_GMI;
