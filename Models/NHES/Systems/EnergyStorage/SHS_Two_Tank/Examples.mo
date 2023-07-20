within NHES.Systems.EnergyStorage.SHS_Two_Tank;
package Examples
  extends Modelica.Icons.ExamplesPackage;

  model Test_2
    extends Modelica.Icons.Example;
    parameter Modelica.Units.SI.Time t_extend = 300;

    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      experiment(
        StopTime=100,
        __Dymola_NumberOfIntervals=100,
        __Dymola_Algorithm="Esdirk45a"),
      __Dymola_experimentSetupOutput);
  end Test_2;

  model Build_Test
    "Initial build test of two tank system. No reference documents were used, the test is simply to evaluate overall system behavior."
    extends Modelica.Icons.Example;
    NHES.Systems.EnergyStorage.SHS_Two_Tank.Models.Two_Tank_SHS_System
      two_Tank_SHS_System(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems.CS_Boiler_03
        CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_SHS data(DHX_K_tube(
            unit="1/m4"), DHX_K_shell(unit="1/m4")),
      Produced_steam_flow=valveLinear.port_a.m_flow)
      annotation (Placement(transformation(extent={{-50,-50},{46,52}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Inlet_T(redeclare package
        Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-92,-8},{-72,-28}})));
    Modelica.Fluid.Sources.MassFlowSource_T boundary5(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      m_flow=8,
      T=598.15,
      nPorts=1) annotation (Placement(transformation(extent={{-144,-28},{-124,-8}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare
        package Medium =
                 Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-94,6},{-114,26}})));
    Modelica.Fluid.Sources.Boundary_pT boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=5000000,
      T=343.15,
      nPorts=1) annotation (Placement(transformation(extent={{-148,6},{-128,26}})));
    Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
      amplitude=10,
      rising=600,
      falling=600,
      offset=0)
      annotation (Placement(transformation(extent={{-176,-20},{-156,0}})));

    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater, m_flow_nominal=25)
      annotation (Placement(transformation(extent={{126,2},{106,22}})));
    TRANSFORM.Fluid.Volumes.BoilerDrum boilerDrum(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
          (
          length=20,
          r_inner=3,
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
      nPorts=1) annotation (Placement(transformation(extent={{142,32},{124,50}})));
    TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=50000,
      m_flow_nominal=10)
      annotation (Placement(transformation(extent={{72,62},{52,82}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=400000,
      nPorts=1)
      annotation (Placement(transformation(extent={{22,62},{42,82}})));
    Modelica.Blocks.Sources.Constant const1(k=5e5)
      annotation (Placement(transformation(extent={{2,102},{22,122}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-3,
      Ti=15,
      yMax=1.0,
      yMin=0.0) annotation (Placement(transformation(extent={{48,102},{68,122}})));
    Modelica.Blocks.Sources.RealExpression Boiler_Pressure(y=boilerDrum.medium_vapor.p)
      annotation (Placement(transformation(extent={{28,82},{48,102}})));
    Modelica.Blocks.Sources.RealExpression Level_Boiler(y=boilerDrum.level)
      annotation (Placement(transformation(extent={{124,52},{144,72}})));
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-2,
      Ti=10,
      yMin=-0.25)
                annotation (Placement(transformation(extent={{166,76},{186,96}})));
    Modelica.Blocks.Sources.Constant const(k=10)
      annotation (Placement(transformation(extent={{128,76},{148,96}})));
  equation
    two_Tank_SHS_System.Charging_Trigger = triggeredTrapezoid.u;
   // two_Tank_SHS_System.Produced_steam_flow = valveLinear.port_a.m_flow;
    connect(boundary5.ports[1], CHX_Inlet_T.port_a) annotation (Line(points={{-124,
            -18},{-92,-18}},            color={0,127,255}));
    connect(CHX_Inlet_T.port_b, two_Tank_SHS_System.port_ch_a) annotation (Line(
          points={{-72,-18},{-50,-18},{-50,-30.62},{-49.04,-30.62}}, color={0,127,
            255}));
    connect(CHX_Discharge_T.port_a, two_Tank_SHS_System.port_ch_b) annotation (
        Line(points={{-94,16},{-84,16},{-84,22},{-68,22},{-68,32},{-49.04,32},{-49.04,
            28.54}}, color={0,127,255}));
    connect(CHX_Discharge_T.port_b, boundary1.ports[1])
      annotation (Line(points={{-114,16},{-128,16}}, color={0,127,255}));
    connect(boundary5.m_flow_in, triggeredTrapezoid.y)
      annotation (Line(points={{-144,-10},{-155,-10}},
                                                     color={0,0,127}));
    connect(pump.port_a,boilerDrum. downcomerPort) annotation (Line(points={{126,12},
            {130,12},{130,28},{101.3,28},{101.3,32.2}},                   color={0,
            127,255}));
    connect(boilerDrum.steamPort,valveLinear. port_a) annotation (Line(points={{101.3,
            49.36},{102,49.36},{102,72},{72,72}},     color={0,127,255}));
    connect(valveLinear.port_b,boundary. ports[1])
      annotation (Line(points={{52,72},{42,72}},   color={0,127,255}));
    connect(pump.port_b, two_Tank_SHS_System.port_dch_b) annotation (Line(points={{106,12},
            {94,12},{94,16},{80,16},{80,-30.62},{46,-30.62}},          color={0,127,
            255}));
    connect(two_Tank_SHS_System.port_dch_a, boilerDrum.riserPort) annotation (
        Line(points={{45.04,30.58},{88.7,30.58},{88.7,32.2}}, color={0,127,255}));
    connect(boundary3.ports[1], boilerDrum.feedwaterPort)
      annotation (Line(points={{124,41},{104,41}}, color={0,127,255}));
    connect(PID1.u_s,const1. y)
      annotation (Line(points={{46,112},{23,112}},  color={0,0,127}));
    connect(PID1.y, valveLinear.opening) annotation (Line(points={{69,112},{88,112},
            {88,86},{64,86},{64,80},{62,80}}, color={0,0,127}));
    connect(Boiler_Pressure.y, PID1.u_m)
      annotation (Line(points={{49,92},{58,92},{58,100}}, color={0,0,127}));
    connect(const.y, PID.u_s)
      annotation (Line(points={{149,86},{164,86}}, color={0,0,127}));
    connect(Level_Boiler.y, PID.u_m) annotation (Line(points={{145,62},{174,62},{174,
            74},{176,74}}, color={0,0,127}));
    connect(PID.y, boundary3.m_flow_in) annotation (Line(points={{187,86},{214,86},
            {214,48.2},{142,48.2}}, color={0,0,127}));
    annotation (experiment(
        StopTime=432000,
        Interval=37,
        __Dymola_Algorithm="Esdirk45a"));
  end Build_Test;

  model Build_Test_NTU
    "Initial build test of two tank system. No reference documents were used, the test is simply to evaluate overall system behavior."
    extends Modelica.Icons.Example;
    Models.Two_Tank_SHS_System_NTU two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems.CS_Boiler_03
        CS,
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
      annotation (Placement(transformation(extent={{-92,-8},{-72,-28}})));
    Modelica.Fluid.Sources.MassFlowSource_T boundary5(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      m_flow=8,
      T=598.15,
      nPorts=1) annotation (Placement(transformation(extent={{-142,-28},{-122,-8}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare
        package Medium =
                 Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-94,6},{-114,26}})));
    Modelica.Fluid.Sources.Boundary_pT boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=5000000,
      T=343.15,
      nPorts=1) annotation (Placement(transformation(extent={{-148,6},{-128,26}})));
    Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
      amplitude=9,
      rising=30,
      falling=30,
      offset=0)
      annotation (Placement(transformation(extent={{-174,-20},{-154,0}})));

    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater, m_flow_nominal=25)
      annotation (Placement(transformation(extent={{126,2},{106,22}})));
    TRANSFORM.Fluid.Volumes.BoilerDrum boilerDrum(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
          (
          length=20,
          r_inner=3,
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
      nPorts=1) annotation (Placement(transformation(extent={{142,32},{124,50}})));
    TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=50000,
      m_flow_nominal=10)
      annotation (Placement(transformation(extent={{72,62},{52,82}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-14,64},{6,84}})));
    Modelica.Blocks.Sources.Constant const1(k=5e5)
      annotation (Placement(transformation(extent={{2,102},{22,122}})));
    TRANSFORM.Controls.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-3,
      Ti=15,
      yMax=1.0,
      yMin=0.0) annotation (Placement(transformation(extent={{48,102},{68,122}})));
    Modelica.Blocks.Sources.RealExpression Boiler_Pressure(y=boilerDrum.medium_vapor.p)
      annotation (Placement(transformation(extent={{28,82},{48,102}})));
    Modelica.Blocks.Sources.RealExpression Level_Boiler(y=boilerDrum.level)
      annotation (Placement(transformation(extent={{124,52},{144,72}})));
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-2,
      Ti=30,
      yMin=-1.5)
                annotation (Placement(transformation(extent={{166,76},{186,96}})));
    Modelica.Blocks.Sources.Constant const(k=10)
      annotation (Placement(transformation(extent={{128,76},{148,96}})));
    Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid1(
      amplitude=10,
      rising=30,
      falling=30,
      offset=0)
      annotation (Placement(transformation(extent={{184,30},{164,50}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=10)
      annotation (Placement(transformation(extent={{218,30},{198,50}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=15 - boilerDrum.level)
      annotation (Placement(transformation(extent={{172,-6},{192,14}})));
  equation
    two_Tank_SHS_System_NTU.Charging_Trigger = triggeredTrapezoid.u;
   // two_Tank_SHS_System.Produced_steam_flow = valveLinear.port_a.m_flow;
    connect(boundary5.ports[1], CHX_Inlet_T.port_a) annotation (Line(points={{-122,
            -18},{-92,-18}},            color={0,127,255}));
    connect(CHX_Inlet_T.port_b, two_Tank_SHS_System_NTU.port_ch_a) annotation (
        Line(points={{-72,-18},{-50,-18},{-50,-28.62},{-49.04,-28.62}}, color={0,
            127,255}));
    connect(CHX_Discharge_T.port_a, two_Tank_SHS_System_NTU.port_ch_b)
      annotation (Line(points={{-94,16},{-84,16},{-84,22},{-68,22},{-68,32},{
            -49.04,32},{-49.04,30.54}},
                                 color={0,127,255}));
    connect(CHX_Discharge_T.port_b, boundary1.ports[1])
      annotation (Line(points={{-114,16},{-128,16}}, color={0,127,255}));
    connect(boundary5.m_flow_in, triggeredTrapezoid.y)
      annotation (Line(points={{-142,-10},{-153,-10}},
                                                     color={0,0,127}));
    connect(pump.port_a,boilerDrum. downcomerPort) annotation (Line(points={{126,12},
            {130,12},{130,28},{101.3,28},{101.3,32.2}},                   color={0,
            127,255}));
    connect(boilerDrum.steamPort,valveLinear. port_a) annotation (Line(points={{101.3,
            49.36},{102,49.36},{102,72},{72,72}},     color={0,127,255}));
    connect(pump.port_b, two_Tank_SHS_System_NTU.port_dch_b) annotation (Line(
          points={{106,12},{94,12},{94,16},{80,16},{80,-28.62},{46,-28.62}},
          color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, boilerDrum.riserPort) annotation (
       Line(points={{45.04,32.58},{88.7,32.58},{88.7,32.2}}, color={0,127,255}));
    connect(boundary3.ports[1], boilerDrum.feedwaterPort)
      annotation (Line(points={{124,41},{104,41}}, color={0,127,255}));
    connect(PID1.u_s,const1. y)
      annotation (Line(points={{46,112},{23,112}},  color={0,0,127}));
    connect(PID1.y, valveLinear.opening) annotation (Line(points={{69,112},{88,112},
            {88,86},{64,86},{64,80},{62,80}}, color={0,0,127}));
    connect(Boiler_Pressure.y, PID1.u_m)
      annotation (Line(points={{49,92},{58,92},{58,100}}, color={0,0,127}));
    connect(const.y, PID.u_s)
      annotation (Line(points={{149,86},{164,86}}, color={0,0,127}));
    connect(Level_Boiler.y, PID.u_m) annotation (Line(points={{145,62},{174,62},{174,
            74},{176,74}}, color={0,0,127}));
    connect(triggeredTrapezoid1.u, hysteresis.y)
      annotation (Line(points={{186,40},{197,40}}, color={255,0,255}));
    connect(realExpression.y, hysteresis.u) annotation (Line(points={{193,4},{250,
            4},{250,40},{220,40}}, color={0,0,127}));
    connect(PID.y, boundary3.m_flow_in) annotation (Line(points={{187,86},{198,86},
            {198,84},{210,84},{210,64},{158,64},{158,44},{142,44},{142,48.2}},
          color={0,0,127}));
    connect(valveLinear.port_b, boundary.ports[1])
      annotation (Line(points={{52,72},{52,74},{6,74}}, color={0,127,255}));
    annotation (experiment(
        StopTime=864000,
        Interval=37,
        __Dymola_Algorithm="Esdirk45a"));
  end Build_Test_NTU;

  model Build_Test_NTU_GMI
    "Initial build test of two tank system. No reference documents were used, the test is simply to evaluate overall system behavior."
    extends Modelica.Icons.Example;
    Models.Two_Tank_SHS_System_NTU_GMI two_Tank_SHS_System_NTU_GMI(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems.CS_Boiler_03_GMI
        CS,
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
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare
        package Medium =
                 Modelica.Media.Water.StandardWater)
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
      annotation (Placement(transformation(extent={{-152,-30},{-132,-10}})));

    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
        Medium =
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
      annotation (Line(points={{-118,-20},{-131,-20}},
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

  model Two_Tank_SHS_HT_Power_Test "TES use case demonstration of a NuScale-style LWR operating within an energy 
  arbitrage IES, storing and dispensing energy on demand from a two tank molten 
  salt energy storage system nominally using HITEC salt to store heat."
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_Basic_NoFeedHeat_mFlow_Control
      Dch_BOP(
      port_a_nominal(
        p=3388000,
        h=2.99767e+6,
        m_flow=66.4),
      port_b_nominal(p=3447380, h=629361),
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_NoFeedHeat_mFlow_Control
        CS(electric_demand_large=MW_W_Gain_TES.y),
      init(condensor_V_liquid_start=50))
      annotation (Placement(transformation(extent={{-34,12},{32,68}})));
   // parameter Real fracNominal_BOP = abs(-66.4)/67.07;
   // parameter Real fracNominal_Other = sum(abs({-0.67}))/67.07;
   parameter Modelica.Units.SI.Time timeScale=60*60
      "Time scale of first table column";
   parameter String fileName=Modelica.Utilities.Files.loadResource(
      "modelica://NHES/Resources/Data/RAVEN/DMM_Dissertation_Demand.txt")
    "File where matrix is stored";
   // Real demandChange=
   // min(1.05,
   // max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
   //     + sum(boundary5.m_flow/-0.67)*fracNominal_Other,
   //     0.5));

    NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
      annotation (Placement(transformation(extent={{38,18},{78,62}})));
    NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG(redeclare
        NHES.Systems.ElectricalGrid.InfiniteGrid.CS_Dummy CS, redeclare
        NHES.Systems.ElectricalGrid.InfiniteGrid.ED_Dummy ED)
      annotation (Placement(transformation(extent={{100,20},{140,60}})));
    NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(
          displayUnit="MW") = 53303300, BOP_capacity(displayUnit="MW")=
        1165000000)
      annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
    NHES.Systems.SupervisoryControl.InputSetpointData SC(
      delayStart=0,
      W_nominal_BOP(displayUnit="MW") = 50000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Nominal_50_timeSeries.txt"))
      annotation (Placement(transformation(extent={{100,-60},{140,-20}})));

    NHES.Fluid.Sensors.stateSensor stateSensor4(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-118,20},{-104,36}})));
    NHES.Fluid.Sensors.stateSensor stateSensor5(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-104,42},{-118,58}})));
    NHES.Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-54,24},{-40,40}})));
    NHES.Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-40,40},{-54,56}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{82,34},{96,46}})));

    Modelica.Fluid.Sources.Boundary_pT Sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      nPorts=1,
      p(displayUnit="bar") = 3406400,
      T(displayUnit="degC") = 453.15)
      annotation (Placement(transformation(extent={{-140,58},{-124,42}})));
    Modelica.Fluid.Sources.Boundary_pT Source(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      nPorts=1,
      p(displayUnit="bar") = 3406500,
      T(displayUnit="degC") = 581.236)
      annotation (Placement(transformation(extent={{-140,36},{-124,20}})));
    Modelica.Blocks.Math.Add add_TES
      annotation (Placement(transformation(extent={{-100,-16},{-80,4}})));
    Modelica.Blocks.Sources.Pulse pulse_TES(
      period=7200,
      offset=0,
      startTime=2400,
      amplitude=-4.5)
      annotation (Placement(transformation(extent={{-120,-20},{-108,-8}})));
    Modelica.Blocks.Math.Gain MW_W_Gain_TES(k=1e6)
      annotation (Placement(transformation(extent={{-72,-12},{-60,0}})));
    Modelica.Blocks.Interfaces.RealInput TES_Demand_MW annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=0,
          origin={-120,0}),   iconTransformation(extent={{-120,-12},{-96,12}})));
    Modelica.Blocks.Interfaces.RealOutput TES_HotTank_Level
      annotation (Placement(transformation(extent={{48,-6},{64,10}}),
          iconTransformation(extent={{106,-28},{130,-4}})));
    Modelica.Blocks.Interfaces.RealOutput TES_HT_Level_Ramprate annotation (
        Placement(transformation(extent={{48,-20},{64,-4}}),
          iconTransformation(extent={{128,-40},{152,-16}})));
    NHES.Systems.EnergyStorage.SHS_Two_Tank.Models.Two_Tank_SHS_HT_Power_ANL
      TES(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems.CS_TES_HT_Power_ANL
        CS(electric_demand_TES=MW_W_Gain_TES.y, Round_Trip_Efficiency=0.21),
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_SHS data(
        ht_level_max=11.7,
        ht_area=3390,
        ht_surface_pressure=120000,
        hot_tank_init_temp=513.15,
        cold_tank_level_max=11.7,
        cold_tank_area=3390,
        ct_surface_pressure=120000,
        cold_tank_init_temp=453.15,
        m_flow_ch_min=0.1,
        DHX_NTU=20,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4"),
        DHX_p_start_tube=120000,
        DHX_h_start_tube_inlet=272e3,
        DHX_h_start_tube_outlet=530e3,
        charge_pump_dp_nominal=1200000,
        charge_pump_m_flow_nominal=900,
        charge_pump_constantRPM=3000,
        disvalve_dp_nominal=100000,
        chvalve_m_flow_nom=900,
        disvalve_m_flow_nom=900,
        chvalve_dp_nominal=100000),
      redeclare package Storage_Medium = NHES.Media.Hitec.Hitec,
      tank_height=11.7,
      Steam_Output_Temp=stateSensor6.temperature.T)
      annotation (Placement(transformation(extent={{-100,20},{-60,68}})));

  equation

     TES_HotTank_Level = TES.hot_tank.level;
     TES_HT_Level_Ramprate = der(TES.hot_tank.level);

    connect(stateSensor6.port_b, Dch_BOP.port_a) annotation (Line(points={{-40,32},
            {-36,32},{-36,42},{-21.625,42},{-21.625,48}}, color={0,127,255}));
    connect(stateSensor7.port_a, Dch_BOP.port_b) annotation (Line(points={{-40,48},
            {-30,48},{-30,32},{-21.625,32}},      color={0,127,255}));
    connect(Dch_BOP.portElec_b, SY.port_a[1]) annotation (Line(
        points={{19.625,40},{38,40}},
        color={255,0,0}));
    connect(SY.port_Grid, sensorW.port_a)
      annotation (Line(points={{78,40},{82,40}}, color={255,0,0}));
    connect(sensorW.port_b, EG.portElec_a)
      annotation (Line(points={{96,40},{100,40}},color={255,0,0}));
    connect(stateSensor5.port_b,Sink. ports[1])
      annotation (Line(points={{-118,50},{-124,50}},
                                                   color={0,127,255}));
    connect(stateSensor4.port_a, Source.ports[1])
      annotation (Line(points={{-118,28},{-124,28}}, color={0,127,255}));
    connect(TES_Demand_MW,add_TES. u1)
      annotation (Line(points={{-120,0},{-102,0}},       color={0,0,127}));
    connect(pulse_TES.y,add_TES. u2)
      annotation (Line(points={{-107.4,-14},{-102,-14},{-102,-12}},
                                                           color={0,0,127}));
    connect(add_TES.y,MW_W_Gain_TES. u)
      annotation (Line(points={{-79,-6},{-73.2,-6}},     color={0,0,127}));
    connect(TES.port_dch_a, stateSensor7.port_b) annotation (Line(points={{-60.4,
            51.6},{-60.4,52},{-54,52},{-54,48}},   color={0,127,255}));
    connect(TES.port_dch_b, stateSensor6.port_a) annotation (Line(points={{-60,
            27.6},{-60,28},{-54,28},{-54,32}},       color={0,127,255}));
    connect(stateSensor5.port_a, TES.port_ch_b) annotation (Line(points={{-104,50},
            {-99.6,50},{-99.6,50.8}},                            color={0,127,255}));
    connect(stateSensor4.port_b, TES.port_ch_a) annotation (Line(points={{-104,28},
            {-99.6,28},{-99.6,27.6}},                                 color={0,127,
            255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
              -60},{140,80}}),   graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-54,-102},{146,98}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{16,62},{116,2},{16,-58},{16,62}})}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-140,-60},{140,80}})),
      experiment(
        StopTime=7000,
        Interval=10,
        Tolerance=1e-06,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end Two_Tank_SHS_HT_Power_Test;
end Examples;
