within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Examples;
model Build_Test_NTU_GMI
  "Initial build test of two tank system. No reference documents were used, the test is simply to evaluate overall system behavior."
  extends Modelica.Icons.Example;
  Two_Tank_SHS_System_NTU_GMI
    two_Tank_SHS_System_NTU_GMI(
    redeclare NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI CS,
    redeclare replaceable Data.Data_SHS data(
      ht_area=100,
      cold_tank_area=100,
      DHX_K_tube(unit="1/m4"),
      DHX_K_shell(unit="1/m4")),
    m_flow_min=0.1,
    tank_height=15,
      Produced_steam_flow=valveLinear.port_a.m_flow)
    annotation (Placement(transformation(extent={{-50,-48},{46,54}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Inlet_T(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-88,-18},{-68,-38}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary5(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=8,
    T=598.15,
    nPorts=1) annotation (Placement(transformation(extent={{-118,-38},{-98,-18}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-68,22},{-88,42}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=5000000,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{-118,22},{-98,42}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
    amplitude=9,
    rising=30,
    falling=30,
    offset=0)
    annotation (Placement(transformation(extent={{-150,-30},{-130,-10}})));

  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Modelica.Media.Water.StandardWater, m_flow_nominal=25)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={64,10})));
  TRANSFORM.Fluid.Volumes.BoilerDrum boilerDrum(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
        (
        length=20,
        r_inner=1,
        th_wall=0.03),
    level_start=11.0,
    p_liquid_start=500000,
    p_vapor_start=500000,
    use_LiquidHeatPort=false,
    Twall_start=343.15)
    annotation (Placement(transformation(extent={{86,30},{104,52}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=1.0,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=90,
        origin={123,27})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=50000,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{92,52},{72,72}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{44,52},{64,72}})));
  Modelica.Blocks.Sources.Constant const1(k=5e5)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={82,114})));
  TRANSFORM.Controls.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-3,
    Ti=15,
    yMax=1.0,
    yMin=0.0) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={82,86})));
  Modelica.Blocks.Sources.RealExpression Boiler_Pressure(y=boilerDrum.medium_vapor.p)
    annotation (Placement(transformation(extent={{122,76},{102,96}})));
  Modelica.Blocks.Sources.RealExpression Level_Boiler(y=boilerDrum.level)
    annotation (Placement(transformation(extent={{74,-16},{94,4}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-2,
    Ti=30,
    yMin=-1.5)
              annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={116,-6})));
  Modelica.Blocks.Sources.Constant const(k=10)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={116,-38})));
equation
  two_Tank_SHS_System_NTU_GMI.Charging_Trigger = triggeredTrapezoid.u;
 // two_Tank_SHS_System.Produced_steam_flow = valveLinear.port_a.m_flow;
  connect(boundary5.ports[1], CHX_Inlet_T.port_a) annotation (Line(points={{-98,-28},
          {-88,-28}},                 color={0,127,255}));
  connect(CHX_Inlet_T.port_b, two_Tank_SHS_System_NTU_GMI.port_ch_a)
    annotation (Line(points={{-68,-28},{-49.04,-28.62}}, color={0,127,255}));
  connect(CHX_Discharge_T.port_a, two_Tank_SHS_System_NTU_GMI.port_ch_b)
    annotation (Line(points={{-68,32},{-56,32},{-56,30.54},{-49.04,30.54}},
        color={0,127,255}));
  connect(CHX_Discharge_T.port_b, boundary1.ports[1])
    annotation (Line(points={{-88,32},{-98,32}},   color={0,127,255}));
  connect(boundary5.m_flow_in, triggeredTrapezoid.y)
    annotation (Line(points={{-118,-20},{-129,-20}},
                                                   color={0,0,127}));
  connect(pump.port_a,boilerDrum. downcomerPort) annotation (Line(points={{64,20},
          {64,28},{101.3,28},{101.3,32.2}},                             color={0,
          127,255}));
  connect(boilerDrum.steamPort,valveLinear. port_a) annotation (Line(points={{101.3,
          49.36},{102,49.36},{102,62},{92,62}},     color={0,127,255}));
  connect(pump.port_b, two_Tank_SHS_System_NTU_GMI.port_dch_b) annotation (Line(
        points={{64,0},{64,-28.62},{46,-28.62}}, color={0,127,255}));
  connect(two_Tank_SHS_System_NTU_GMI.port_dch_a, boilerDrum.riserPort)
    annotation (Line(points={{45.04,32.58},{88.7,32.58},{88.7,32.2}}, color={0,
          127,255}));
  connect(boundary3.ports[1], boilerDrum.feedwaterPort)
    annotation (Line(points={{123,36},{118,36},{118,41},{104,41}},
                                                 color={0,127,255}));
  connect(PID1.u_s,const1. y)
    annotation (Line(points={{82,98},{82,103}},   color={0,0,127}));
  connect(PID1.y, valveLinear.opening) annotation (Line(points={{82,75},{82,70}},
                                            color={0,0,127}));
  connect(Boiler_Pressure.y, PID1.u_m)
    annotation (Line(points={{101,86},{94,86}},         color={0,0,127}));
  connect(const.y, PID.u_s)
    annotation (Line(points={{116,-27},{116,-18}},
                                                 color={0,0,127}));
  connect(Level_Boiler.y, PID.u_m) annotation (Line(points={{95,-6},{104,-6}},
                         color={0,0,127}));
  connect(PID.y, boundary3.m_flow_in) annotation (Line(points={{116,5},{116,18},
          {115.8,18}},
        color={0,0,127}));
  connect(valveLinear.port_b, boundary.ports[1])
    annotation (Line(points={{72,62},{64,62}},        color={0,127,255}));
  annotation (experiment(
      StopTime=864000,
      Interval=37,
      __Dymola_Algorithm="Esdirk45a"), Diagram(graphics={
        Text(
          extent={{-166,28},{-66,-18}},
          textColor={28,108,200},
          textString="Boundary conditions for charging."),
        Text(
          extent={{76,32},{172,-12}},
          textColor={28,108,200},
          textString="Level control in the boiler drum."),
        Text(
          extent={{-26,122},{70,78}},
          textColor={28,108,200},
          textString="Steam release at 5bar.")}));
end Build_Test_NTU_GMI;
