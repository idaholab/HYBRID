within NHES.Systems.EnergyStorage;
package SHS_Two_Tank

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
      NHES.Systems.EnergyStorage.SHS_Two_Tank.Components.Two_Tank_SHS_System
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
      Components.Two_Tank_SHS_System_NTU two_Tank_SHS_System_NTU(
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
      Components.Two_Tank_SHS_System_NTU_GMI two_Tank_SHS_System_NTU_GMI(
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
  end Examples;

  model SubSystem_Dummy

    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Dummy CS,
      redeclare replaceable ED_Dummy ED,
      redeclare Data.Data_Dummy data);

  equation

    annotation (
      defaultComponentName="changeMe",
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              140}})),
      Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end SubSystem_Dummy;

  model CS_Dummy

    extends BaseClasses.Partial_ControlSystem;

  equation

  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Dummy;

  model ED_Dummy

    extends BaseClasses.Partial_EventDriver;

  equation

  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end ED_Dummy;

  package Components
    model Two_Tank_SHS_System_BestModel
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Boiler_04 CS,
        redeclare replaceable ED_Dummy ED,
        redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
        replaceable package Storage_Medium =
          TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
          replaceable package Charging_Medium =
          Modelica.Media.Water.StandardWater                                       constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
          replaceable package Discharging_Medium =
          Modelica.Media.Water.StandardWater                                          constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
        parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.50;
        parameter Integer CHXnV = 5;
        parameter Modelica.Units.SI.Length tank_height = 15;

        input Modelica.Units.SI.Temperature Steam_Output_Temp annotation(Dialog(tab = "General"));
        output Boolean Charging_Trigger = hysteresis.y;

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
        tube_av_b=false,
        shell_av_b=false,
        use_derQ=data.DHX_Use_derQ,
        tau=data.DHX_tau,
        NTU=data.DHX_NTU,
        K_tube=data.DHX_K_tube,
        K_shell=data.DHX_K_shell,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Discharging_Medium,
        V_Tube=data.DHX_v_tube,
        V_Shell=data.DHX_v_shell,
        p_start_tube=data.DHX_p_start_tube,
        use_T_start_tube=true,
        T_start_tube_inlet=573.15,
        T_start_tube_outlet=573.15,
        h_start_tube_inlet=data.DHX_h_start_tube_inlet,
        h_start_tube_outlet=data.DHX_h_start_tube_outlet,
        p_start_shell=data.DHX_p_start_shell,
        h_start_shell_inlet=data.DHX_h_start_shell_inlet,
        h_start_shell_outlet=data.DHX_h_start_shell_outlet,
        dp_init_tube=data.DHX_dp_init_tube,
        dp_init_shell = data.DHX_dp_init_shell,
        Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={72,20})));
      TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium
          = Storage_Medium, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=data.ctvolume_volume))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-16})));
      Fluid.Valves.ValveLinear Discharging_Valve(
        redeclare package Medium = Storage_Medium,
        dp_nominal=data.disvalve_dp_nominal,
        m_flow_nominal=data.disvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={68,-42})));
      BaseClasses.DumpTank_Init_T      hot_tank(
        redeclare package Medium = Storage_Medium,
        A=data.ht_area,
        V0=data.ht_zero_level_volume,
        p_surface=data.ht_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ht_surface_pressure,
        level_start=data.ht_init_level,
        h_start=747e3,
        T_start=data.hot_tank_init_temp)
        annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

      TRANSFORM.Fluid.Machines.Pump discharge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.discharge_pump_volume,
        diameter=data.discharge_pump_diameter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.discharge_pump_rpm_nominal,
        diameter_nominal=data.discharge_pump_diameter_nominal,
        dp_nominal=data.discharge_pump_dp_nominal,
        m_flow_nominal=data.discharge_pump_m_flow_nominal,
        d_nominal=data.discharge_pump_rho_nominal,
        N_input=data.discharge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-76})));
      Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
            Discharging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
        redeclare package Medium = Storage_Medium,
        crossArea=data.ctdp_area,
        length=data.ctdp_length,
        dheight=data.ctdp_d_height) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=0,
            origin={12,44})));
      BaseClasses.DumpTank_Init_T      cold_tank(
        redeclare package Medium = Storage_Medium,
        A=data.cold_tank_area,
        V0=data.ct_zero_level_volume,
        p_surface=data.ct_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ct_surface_pressure,
        level_start=data.cold_tank_init_level,
        Use_T_Start=true,
        h_start=133e3,
        T_start=data.cold_tank_init_temp)
        annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
      TRANSFORM.Fluid.Machines.Pump charge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.charge_pump_volume,
        diameter=data.charge_pump_diamter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.charge_pump_rpm_nominal,
        diameter_nominal=data.charge_pump_diameter_nominal,
        dp_nominal=data.charge_pump_dp_nominal,
        m_flow_nominal=data.charge_pump_m_flow_nominal,
        d_nominal=data.charge_pump_rho_nominal,
        N_input=data.charge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-42,8})));
      Fluid.Valves.ValveLinear Charging_Valve(
        redeclare package Medium = Storage_Medium,
        allowFlowReversal=true,
        dp_nominal=data.chvalve_dp_nominal,
        m_flow_nominal=data.chvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-42,-20})));
      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

      Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
        annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
        annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
      Modelica.Fluid.Sources.MassFlowSource_h boundary2(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_h_in=true,
        m_flow=m_flow_min,
        nPorts=1) annotation (Placement(transformation(extent={{-84,-102},{-64,-82}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary4(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_T_in=false,
        m_flow=-m_flow_min,
        T=413.15,
        nPorts=1) annotation (Placement(transformation(extent={{-126,-44},{-106,-24}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.h)
        annotation (Placement(transformation(extent={{-128,-98},{-108,-78}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
        delay1(Ti=0.5)
        annotation (Placement(transformation(extent={{-102,-90},{-94,-86}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0.7, uHigh=11)
        annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=11.7 - hot_tank.level)
        annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
        annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
            Steam_Output_Temp)
        annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
        shell_av_b=true,
        use_derQ=true,
        tau=1,
        NTU=20,
        K_tube=1000,
        K_shell=1000,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Charging_Medium,
        V_Tube=10,
        V_Shell=25,
        use_T_start_tube=true,
        T_start_tube_inlet=573.15,
        T_start_tube_outlet=573.15,
        dp_init_tube=20000,
        Q_init=1)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-44,-54})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package
          Medium =
            Charging_Medium)                                                                           annotation (Placement(
            transformation(extent={{-108,-72},{-88,-52}}), iconTransformation(
              extent={{-108,-72},{-88,-52}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package
          Medium =
            Charging_Medium)                                                                            annotation (Placement(
            transformation(extent={{-108,44},{-88,64}}), iconTransformation(extent={
                {-108,44},{-88,64}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package
          Medium =
            Discharging_Medium)                                                                            annotation (Placement(
            transformation(extent={{88,48},{108,68}}), iconTransformation(extent={{88,
                48},{108,68}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_dch_b(redeclare package
          Medium =
            Discharging_Medium)                                                                             annotation (Placement(
            transformation(extent={{90,-72},{110,-52}}), iconTransformation(extent={
                {90,-72},{110,-52}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
          redeclare package Medium =
            Storage_Medium, R=100)
        annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
      Modelica.Blocks.Sources.RealExpression Coolant_Water_temp(y=sensor_T1.T)
        annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
      Modelica.Blocks.Sources.RealExpression Hot_Tank_Temp(y=hot_tank.T)
        annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{36,34},{56,54}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-86,6})));
    equation
      connect(volume.port_a, Discharging_Valve.port_b)
        annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
      connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
              -96.4},{36,-102},{68,-102},{68,-86}},
                                           color={0,127,255}));
      connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                              color={0,127,255}));
      connect(cold_tank.port_b, charge_pump.port_a)
        annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
      connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
              {-42,-10}},
            color={0,127,255}));
      connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
              -42,44},{-42,40.4}},                                      color={0,
              127,255}));
      connect(discharge_pump.port_b, Discharging_Valve.port_a)
        annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,82},{128,82},{128,-100},{82,-100},{82,-42},{76,-42}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,114},{-81,114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,128},{-83,128}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
          points={{-30,100},{-81,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,86},{-81,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Level_Hot_Tank1.y, delay1.u)
        annotation (Line(points={{-107,-88},{-102.8,-88}},
                                                         color={0,0,127}));
      connect(hysteresis.u, Level_Hot_Tank2.y)
        annotation (Line(points={{-99.2,74},{-113,74}},  color={0,0,127}));
      connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,142},{-83,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
          points={{-30,100},{-30,74},{-85.4,74}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
          points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
              74,30}},                      color={0,127,255}));
      connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
              86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
      connect(boundary2.h_in, delay1.y)
        annotation (Line(points={{-86,-88},{-93.44,-88}}, color={0,0,127}));
      connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
              {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
      connect(CHX.Shell_in, boundary2.ports[1]) annotation (Line(points={{-46,-64},
              {-46,-70},{-58,-70},{-58,-92},{-64,-92}},color={0,127,255}));
      connect(CHX.Shell_out, boundary4.ports[1]) annotation (Line(points={{-46,-44},
              {-46,-36},{-100,-36},{-100,-34},{-106,-34}},
                                          color={0,127,255}));
      connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
              -79.6},{36,-76},{13,-76}},     color={0,127,255}));
      connect(CHX.Tube_out, sensor_T.port_a)
        annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                               color={0,127,255}));
      connect(sensor_T.port_b, resistance.port_a)
        annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
      connect(CHX.Shell_out, sensor_T1.port_b) annotation (Line(points={{-46,-44},{
              -46,-36},{-58,-36},{-58,-30}},           color={0,127,255}));
      connect(port_ch_a, CHX.Shell_in) annotation (Line(points={{-98,-62},{-76,-62},
              {-76,-64},{-46,-64}}, color={0,127,255}));
      connect(sensorBus.Coolant_Water_temp, Coolant_Water_temp.y) annotation (Line(
          points={{-30,100},{-32,100},{-32,86},{-47,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(cold_tank_dump_pipe.port_a, sensor_T2.port_a)
        annotation (Line(points={{22,44},{36,44}}, color={0,127,255}));
      connect(sensor_T2.port_b, DHX.Tube_out)
        annotation (Line(points={{56,44},{68,44},{68,30}}, color={0,127,255}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, sensor_T2.T) annotation (Line(
          points={{-30,100},{-4,100},{-4,66},{46,66},{46,47.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensor_m_flow.port_a, sensor_T1.port_a) annotation (Line(points={{-86,
              -4},{-86,-30},{-78,-30}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, port_ch_b) annotation (Line(points={{-86,16},{
              -88,16},{-88,54},{-98,54}}, color={0,127,255}));
      connect(sensorBus.ChargeSteam_mFlow, sensor_m_flow.m_flow) annotation (Line(
          points={{-30,100},{-30,62},{-80,62},{-80,24},{-102,24},{-102,6},{-89.6,6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(sensorBus.Hot_Tank_Temp, Hot_Tank_Temp.y) annotation (Line(
          points={{-30,100},{-30,124},{-47,124},{-47,106}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (experiment(
          StopTime=432000,
          Interval=37,
          __Dymola_Algorithm="Esdirk45a"), Icon(graphics={
            Ellipse(
              extent={{-56,70},{-6,60}},
              lineColor={175,175,175},
              lineThickness=1),
            Ellipse(
              extent={{-56,14},{-6,0}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-56,66},{-6,6}},
              lineColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1,
              fillColor={215,215,215}),
            Ellipse(
              extent={{18,-56},{72,-68}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{18,-2},{72,-62}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Ellipse(
              extent={{18,4},{72,-8}},
              lineColor={175,175,175},
              lineThickness=1),
            Rectangle(
              extent={{68,44},{24,18}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-8,-36},{-52,-62}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={255,85,85}),
            Rectangle(
              extent={{-6,18},{18,12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-41,3},{41,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-71,15},
              rotation=90),
            Rectangle(
              extent={{-30,3},{30,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-23},
              rotation=180),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-28},
              rotation=90),
            Rectangle(
              extent={{-9,3},{9,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-65,53},
              rotation=180),
            Rectangle(
              extent={{-18,-70},{10,-76}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-7,3},{7,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-69},
              rotation=90),
            Rectangle(
              extent={{4,-54},{18,-60}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-11,3},{11,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={7,-65},
              rotation=90),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={15,20},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={18,29},
              rotation=180),
            Rectangle(
              extent={{32,12},{82,6}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-17,3},{17,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={79,-5},
              rotation=90),
            Rectangle(
              extent={{-5,3},{5,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={77,-19},
              rotation=180),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-62,-70},
              rotation=90),
            Rectangle(
              extent={{-17,2},{17,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-77,-62},
              rotation=180),
            Rectangle(
              extent={{-11,2},{11,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-53,-78},
              rotation=180),
            Rectangle(
              extent={{-8,2},{8,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={56,52},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={35,12},
              rotation=90),
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={74,58},
              rotation=180),
            Rectangle(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={89,-62},
              rotation=180),
            Rectangle(
              extent={{-46,2},{46,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={86,-18},
              rotation=90),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={78,26},
              rotation=180),
            Rectangle(
              extent={{-16,2},{16,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-68,-48},
              rotation=180),
            Rectangle(
              extent={{-52,2},{52,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-82,2},
              rotation=90),
            Rectangle(
              extent={{-9,2},{9,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-71},
              rotation=90),
            Rectangle(
              extent={{-7,2},{7,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-87,52},
              rotation=180),
            Rectangle(
              extent=DynamicSelect({{-56,6},{-6,66}},{{-56,6},{-6,6+60*hot_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1),
            Rectangle(
              extent=DynamicSelect({{18,-62},{72,-2}},{{18,-62},{72,-62+60*cold_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1)}));
    end Two_Tank_SHS_System_BestModel;

    model SHS_Mikk_Two_Tank_NTUs
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Boiler CS,
        redeclare replaceable ED_Dummy ED,
        redeclare replaceable Data.Data_Dummy data);
        replaceable package Storage_Medium =
          TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66;
        parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.0;
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
        annotation (Placement(transformation(extent={{20,34},{38,56}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        m_flow=1.0,
        T=343.15,
        nPorts=1) annotation (Placement(transformation(extent={{74,34},{54,54}})));
      Modelica.Blocks.Sources.RealExpression Level_Boiler(y=boilerDrum.level)
        annotation (Placement(transformation(extent={{-102,48},{-82,68}})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{60,6},{40,26}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=400000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-46,66},{-26,86}})));
      Modelica.Blocks.Sources.RealExpression Boiler_Pressure(y=boilerDrum.medium_vapor.p)
        annotation (Placement(transformation(extent={{-102,62},{-82,82}})));
      TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=50000,
        m_flow_nominal=10)
        annotation (Placement(transformation(extent={{4,66},{-16,86}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
        tube_av_b=false,
        shell_av_b=false,
        NTU=4,
        K_tube=100,
        K_shell=100,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Modelica.Media.Examples.TwoPhaseWater,
        V_Tube=10,
        V_Shell=25,
        p_start_tube=100000,
        h_start_tube_inlet=100e3,
        h_start_tube_outlet=300e3,
        p_start_shell=500000,
        h_start_shell_inlet=1400e3,
        h_start_shell_outlet=2000e3,
        dp_init_tube=1000,
        Q_init=1)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={8,14})));
      TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium
          = Storage_Medium, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=1.0))
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=0,
            origin={50,-10})));
      Fluid.Valves.ValveLinear Discharging_Valve(
        redeclare package Medium = Storage_Medium,
        dp_nominal=100000,
        m_flow_nominal=25)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={82,-28})));
      BaseClasses.DumpTank_Init_T      hot_tank(
        redeclare package Medium = Storage_Medium,
        A=50,
        V0=1,
        p_surface=100000,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        level_start=7,
        h_start=747e3,
        T_start=553.15)
        annotation (Placement(transformation(extent={{38,-94},{58,-74}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe1(
        redeclare package Medium = Storage_Medium,
        crossArea=1,
        length=10,
        dheight=0)
        annotation (Placement(transformation(extent={{10,10},{-10,-10}},
            rotation=180,
            origin={20,-70})));
      TRANSFORM.Fluid.Machines.Pump      pump1(
        redeclare package Medium = Storage_Medium,
        V=1,
        diameter=0.5,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        diameter_nominal=0.5,
        dp_nominal=200000,
        m_flow_nominal=10,
        d_nominal=1000,
        N_input=1500)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={82,-66})));
      Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
            Discharging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe2(
        redeclare package Medium = Storage_Medium,
        crossArea=1,
        length=10,
        dheight=0.0)
        annotation (Placement(transformation(extent={{10,10},{-10,-10}},
            rotation=270,
            origin={-22,26})));
      BaseClasses.DumpTank_Init_T      cold_tank(
        redeclare package Medium = Storage_Medium,
        A=50,
        V0=1,
        p_surface=100000,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=100000,
        level_start=7,
        Use_T_Start=true,
        h_start=133e3,
        T_start=433.15)
        annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
      TRANSFORM.Fluid.Machines.Pump      pump2(
        redeclare package Medium = Storage_Medium,
        V=1,
        diameter=0.5,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        diameter_nominal=0.5,
        dp_nominal=700000,
        m_flow_nominal=20,
        d_nominal=1000,
        N_input=2000)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-48,-2})));
      Fluid.Valves.ValveLinear Charging_Valve(
        redeclare package Medium = Storage_Medium,
        allowFlowReversal=true,
        dp_nominal=100000,
        m_flow_nominal=25)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-26,-26})));
      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,76},{-82,96}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
        use_derQ=false,
        tau=5,
        NTU=2.0,
        K_tube=100,
        K_shell=100,                                           redeclare
          package Tube_medium =
            Storage_Medium,
        redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
        V_Tube=10,
        V_Shell=0.001,
        Q_init=1)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-18,-58})));

      TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare
          package Medium =
                   Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-54,-54},{-74,-34}})));
      Modelica.Fluid.Sources.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=5000000,
        T=343.15,
        nPorts=1) annotation (Placement(transformation(extent={{-108,-54},{-88,-34}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary5(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        m_flow=8,
        T=598.15,
        nPorts=1) annotation (Placement(transformation(extent={{-106,-86},{-86,-66}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Inlet_T(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-48,-68},{-28,-88}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid2(
        amplitude=10,
        rising=500,
        width=8500,
        falling=500,
        period=18000,
        offset=0.0,
        startTime=9000)
        annotation (Placement(transformation(extent={{-180,-64},{-168,-52}})));
      Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
        annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
        annotation (Placement(transformation(extent={{-102,118},{-82,138}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        use_T_in=true,
        m_flow=m_flow_min,
        T=598.15,
        nPorts=1) annotation (Placement(transformation(extent={{-34,-104},{-14,-84}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary4(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        use_T_in=false,
        m_flow=-m_flow_min,
        T=598.15,
        nPorts=1) annotation (Placement(transformation(extent={{-82,-44},{-62,-24}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.T)
        annotation (Placement(transformation(extent={{-88,-100},{-68,-80}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
        delay1(Ti=0.5)
        annotation (Placement(transformation(extent={{-58,-92},{-50,-88}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=
            transportDelayPipe1.state.T)
        annotation (Placement(transformation(extent={{-100,134},{-80,154}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=valveLinear.m_flow)
        annotation (Placement(transformation(extent={{-100,146},{-80,166}})));
    equation
      connect(boundary3.ports[1], boilerDrum.feedwaterPort)
        annotation (Line(points={{54,44},{38,45}},             color={0,127,255}));
      connect(pump.port_a, boilerDrum.downcomerPort) annotation (Line(points={{60,16},
              {64,16},{64,32},{35.3,32},{35.3,36.2}},                       color={0,
              127,255}));
      connect(boilerDrum.steamPort, valveLinear.port_a) annotation (Line(points={{35.3,
              53.36},{34,53.36},{34,76},{4,76}},        color={0,127,255}));
      connect(valveLinear.port_b, boundary.ports[1])
        annotation (Line(points={{-16,76},{-26,76}}, color={0,127,255}));
      connect(pump.port_b, DHX.Shell_out) annotation (Line(points={{40,16},{18,16}},
                                                                  color={0,127,255}));
      connect(DHX.Shell_in, boilerDrum.riserPort) annotation (Line(points={{-2,16},
              {-6,16},{-6,30},{22.7,30},{22.7,36.2}},
                                                    color={0,127,255}));
      connect(volume.port_a, Discharging_Valve.port_b)
        annotation (Line(points={{56,-10},{82,-10},{82,-18}},
                                                       color={0,127,255}));
      connect(hot_tank.port_b, pump1.port_a) annotation (Line(points={{48,-92.4},{
              48,-96},{82,-96},{82,-76}},
                                 color={0,127,255}));
      connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{44,-10},{24,-10},
              {24,10},{18,10}},
                              color={0,127,255}));
      connect(cold_tank.port_b,pump2. port_a) annotation (Line(points={{-48,19.6},{
              -48,8}},                    color={0,127,255}));
      connect(DHX.Tube_out, transportDelayPipe2.port_a) annotation (Line(points={{-2,10},
              {-22,10},{-22,16}},                                            color=
              {0,127,255}));
      connect(boundary1.ports[1],CHX_Discharge_T. port_b)
        annotation (Line(points={{-88,-44},{-74,-44}},
                                                     color={0,127,255}));
      connect(boundary5.ports[1],CHX_Inlet_T. port_a)
        annotation (Line(points={{-86,-76},{-86,-78},{-48,-78}},
                                                     color={0,127,255}));
      connect(pump2.port_b, Charging_Valve.port_a) annotation (Line(points={{-48,-12},
              {-48,-16},{-40,-16},{-40,-14},{-34,-14},{-34,-8},{-26,-8},{-26,-16}},
                                                    color={0,127,255}));
      connect(transportDelayPipe2.port_b, cold_tank.port_a) annotation (Line(points={{-22,36},
              {-22,40},{-34,40},{-34,42},{-48,42},{-48,36.4}},
                        color={0,127,255}));
      connect(transportDelayPipe1.port_b, hot_tank.port_a) annotation (Line(points={{30,-70},
              {48,-70},{48,-75.6}},
                      color={0,127,255}));
      connect(pump1.port_b, Discharging_Valve.port_a) annotation (Line(points={{82,-56},
              {82,-38}},                        color={0,127,255}));
      connect(actuatorBus.Boiler_Steam_Valve, valveLinear.opening) annotation (Line(
          points={{30,100},{30,90},{-6,90},{-6,84}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Boiler_Drum_Pressure, Boiler_Pressure.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,72},{-81,72}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Boiler_Level, Level_Boiler.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,58},{-81,58}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Boiler_Feed_Flow, boundary3.m_flow_in) annotation (Line(
          points={{30,100},{84,100},{84,52},{74,52}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,60},{-64,60},{-64,-26},{-34,-26}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
        annotation (Line(
          points={{30,100},{96,100},{96,-28},{90,-28}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,114},{-81,114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,128},{-81,128}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
          points={{-30,100},{-81,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,86},{-81,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-14,-48},
              {-14,-40},{-26,-40},{-26,-36}}, color={0,127,255}));
      connect(CHX.Tube_out, transportDelayPipe1.port_a) annotation (Line(points={{-14,
              -68},{-14,-70},{10,-70}}, color={0,127,255}));
      connect(CHX_Inlet_T.port_b, CHX.Shell_in) annotation (Line(points={{-28,-78},
              {-20,-78},{-20,-68}}, color={0,127,255}));
      connect(CHX.Shell_out, CHX_Discharge_T.port_a) annotation (Line(points={{-20,
              -48},{-20,-44},{-54,-44}}, color={0,127,255}));
      connect(boundary2.ports[1], CHX.Shell_in) annotation (Line(points={{-14,-94},{
              -10,-94},{-10,-92},{-4,-92},{-4,-84},{-20,-84},{-20,-68}}, color={0,127,
              255}));
      connect(boundary4.ports[1], CHX.Shell_out) annotation (Line(points={{-62,-34},
              {-42,-34},{-42,-44},{-20,-44},{-20,-48}},
                          color={0,127,255}));
      connect(boundary5.m_flow_in, trapezoid2.y)
        annotation (Line(points={{-106,-68},{-106,-58},{-167.4,-58}},
                                                          color={0,0,127}));
      connect(Level_Hot_Tank1.y, delay1.u)
        annotation (Line(points={{-67,-90},{-58.8,-90}}, color={0,0,127}));
      connect(boundary2.T_in, delay1.y)
        annotation (Line(points={{-36,-90},{-49.44,-90}}, color={0,0,127}));
      connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,156},{-79,156}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
          points={{-30,100},{-54,100},{-54,98},{-76,98},{-76,144},{-79,144}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      annotation (experiment(
          StopTime=800000,
          Interval=30,
          __Dymola_Algorithm="Esdirk45a"));
    end SHS_Mikk_Two_Tank_NTUs;

    model SHS_Mikk_Two_Tank_NTUs_New_Control
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Boiler_02 CS,
        redeclare replaceable ED_Dummy ED,
        redeclare replaceable Data.Data_Dummy data);
        replaceable package Storage_Medium =
          TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66;
        parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.0;
        parameter Integer CHXnV = 5;
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
        annotation (Placement(transformation(extent={{18,34},{36,56}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        m_flow=1.0,
        T=343.15,
        nPorts=1) annotation (Placement(transformation(extent={{74,36},{56,54}})));
      Modelica.Blocks.Sources.RealExpression Level_Boiler(y=boilerDrum.level)
        annotation (Placement(transformation(extent={{-102,48},{-82,68}})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater, m_flow_nominal=25)
        annotation (Placement(transformation(extent={{58,6},{38,26}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=400000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-46,66},{-26,86}})));
      Modelica.Blocks.Sources.RealExpression Boiler_Pressure(y=boilerDrum.medium_vapor.p)
        annotation (Placement(transformation(extent={{-102,62},{-82,82}})));
      TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=50000,
        m_flow_nominal=10)
        annotation (Placement(transformation(extent={{4,66},{-16,86}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
        tube_av_b=false,
        shell_av_b=false,
        NTU=4,
        K_tube=100,
        K_shell=100,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Modelica.Media.Examples.TwoPhaseWater,
        V_Tube=10,
        V_Shell=25,
        p_start_tube=100000,
        h_start_tube_inlet=100e3,
        h_start_tube_outlet=300e3,
        p_start_shell=500000,
        h_start_shell_inlet=1400e3,
        h_start_shell_outlet=2000e3,
        dp_init_tube=1000,
        Q_init=1)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={8,14})));
      TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium
          = Storage_Medium, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=1.0))
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=0,
            origin={50,-10})));
      Fluid.Valves.ValveLinear Discharging_Valve(
        redeclare package Medium = Storage_Medium,
        dp_nominal=100000,
        m_flow_nominal=25)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={82,-28})));
      BaseClasses.DumpTank_Init_T      hot_tank(
        redeclare package Medium = Storage_Medium,
        A=50,
        V0=1,
        p_surface=100000,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        level_start=7,
        h_start=747e3,
        T_start=518.15)
        annotation (Placement(transformation(extent={{38,-94},{58,-74}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe1(
        redeclare package Medium = Storage_Medium,
        crossArea=1,
        length=10,
        dheight=0)
        annotation (Placement(transformation(extent={{10,10},{-10,-10}},
            rotation=180,
            origin={20,-70})));
      TRANSFORM.Fluid.Machines.Pump      pump1(
        redeclare package Medium = Storage_Medium,
        V=1,
        diameter=0.5,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        diameter_nominal=0.5,
        dp_nominal=200000,
        m_flow_nominal=10,
        d_nominal=1000,
        N_input=1500)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={82,-66})));
      Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
            Discharging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe2(
        redeclare package Medium = Storage_Medium,
        crossArea=1,
        length=10,
        dheight=0.0)
        annotation (Placement(transformation(extent={{10,10},{-10,-10}},
            rotation=270,
            origin={-22,26})));
      BaseClasses.DumpTank_Init_T      cold_tank(
        redeclare package Medium = Storage_Medium,
        A=50,
        V0=1,
        p_surface=100000,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=100000,
        level_start=7,
        Use_T_Start=true,
        h_start=133e3,
        T_start=433.15)
        annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
      TRANSFORM.Fluid.Machines.Pump      pump2(
        redeclare package Medium = Storage_Medium,
        V=1,
        diameter=0.5,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        diameter_nominal=0.5,
        dp_nominal=700000,
        m_flow_nominal=20,
        d_nominal=1000,
        N_input=2000)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-48,-2})));
      Fluid.Valves.ValveLinear Charging_Valve(
        redeclare package Medium = Storage_Medium,
        allowFlowReversal=true,
        dp_nominal=100000,
        m_flow_nominal=25)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-26,-26})));
      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

      TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare
          package Medium =
                   Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-54,-54},{-74,-34}})));
      Modelica.Fluid.Sources.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=5000000,
        T=343.15,
        nPorts=1) annotation (Placement(transformation(extent={{-108,-54},{-88,-34}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary5(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        m_flow=8,
        T=598.15,
        nPorts=1) annotation (Placement(transformation(extent={{-106,-86},{-86,-66}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Inlet_T(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-52,-68},{-32,-88}})));
      Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
        annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
        annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        use_T_in=true,
        m_flow=m_flow_min,
        T=598.15,
        nPorts=1) annotation (Placement(transformation(extent={{-44,-102},{-24,-82}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary4(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        use_T_in=false,
        m_flow=-m_flow_min,
        T=598.15,
        nPorts=1) annotation (Placement(transformation(extent={{-140,-42},{-120,-22}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.shell.mediums[
            CHXnV].T)
        annotation (Placement(transformation(extent={{-88,-100},{-68,-80}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
        delay1(Ti=0.5)
        annotation (Placement(transformation(extent={{-58,-92},{-50,-88}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=12)
        annotation (Placement(transformation(extent={{-194,-78},{-174,-58}})));
      Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
        amplitude=10,
        rising=600,
        falling=600,
        offset=0)
        annotation (Placement(transformation(extent={{-150,-78},{-130,-58}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=15 - hot_tank.level)
        annotation (Placement(transformation(extent={{-230,-78},{-210,-58}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=
            transportDelayPipe1.state.T)
        annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=valveLinear.m_flow)
        annotation (Placement(transformation(extent={{-104,144},{-84,164}})));
      TRANSFORM.HeatExchangers.GenericDistributed_HX      CHX(
        nParallel=6,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_o_shell=0.1,
            crossAreaEmpty_shell=1,
            nV=CHXnV,
            nTubes=500,
            nR=2,
            length_shell=25,
            dimension_tube=0.04,
            length_tube=25,
            th_wall=0.003),
        redeclare package Medium_shell = Modelica.Media.Water.StandardWater,
        redeclare package Medium_tube = Storage_Medium,
        redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS316,
        redeclare model FlowModel_shell =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
        redeclare model FlowModel_tube =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        p_a_start_tube=1500000,
        p_b_start_tube=800000,
        exposeState_b_shell=false,
        useLumpedPressure_shell=false,
        exposeState_a_tube=false,
        exposeState_b_tube=true,
        redeclare model InternalTraceGen_tube =
            TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration,
        redeclare model InternalHeatGen_tube =
            TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration)
                           annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-8,-60})));

    equation
      connect(boundary3.ports[1], boilerDrum.feedwaterPort)
        annotation (Line(points={{56,45},{36,45}},             color={0,127,255}));
      connect(pump.port_a, boilerDrum.downcomerPort) annotation (Line(points={{58,16},
              {62,16},{62,32},{33.3,32},{33.3,36.2}},                       color={0,
              127,255}));
      connect(boilerDrum.steamPort, valveLinear.port_a) annotation (Line(points={{33.3,
              53.36},{34,53.36},{34,76},{4,76}},        color={0,127,255}));
      connect(valveLinear.port_b, boundary.ports[1])
        annotation (Line(points={{-16,76},{-26,76}}, color={0,127,255}));
      connect(pump.port_b, DHX.Shell_out) annotation (Line(points={{38,16},{18,16}},
                                                                  color={0,127,255}));
      connect(DHX.Shell_in, boilerDrum.riserPort) annotation (Line(points={{-2,16},
              {-6,16},{-6,30},{20.7,30},{20.7,36.2}},
                                                    color={0,127,255}));
      connect(volume.port_a, Discharging_Valve.port_b)
        annotation (Line(points={{56,-10},{82,-10},{82,-18}},
                                                       color={0,127,255}));
      connect(hot_tank.port_b, pump1.port_a) annotation (Line(points={{48,-92.4},{
              48,-96},{82,-96},{82,-76}},
                                 color={0,127,255}));
      connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{44,-10},{24,-10},
              {24,10},{18,10}},
                              color={0,127,255}));
      connect(cold_tank.port_b,pump2. port_a) annotation (Line(points={{-48,19.6},{
              -48,8}},                    color={0,127,255}));
      connect(DHX.Tube_out, transportDelayPipe2.port_a) annotation (Line(points={{-2,10},
              {-22,10},{-22,16}},                                            color=
              {0,127,255}));
      connect(boundary1.ports[1],CHX_Discharge_T. port_b)
        annotation (Line(points={{-88,-44},{-74,-44}},
                                                     color={0,127,255}));
      connect(boundary5.ports[1],CHX_Inlet_T. port_a)
        annotation (Line(points={{-86,-76},{-86,-78},{-52,-78}},
                                                     color={0,127,255}));
      connect(pump2.port_b, Charging_Valve.port_a) annotation (Line(points={{-48,-12},
              {-48,-16},{-40,-16},{-40,-14},{-34,-14},{-34,-8},{-26,-8},{-26,-16}},
                                                    color={0,127,255}));
      connect(transportDelayPipe2.port_b, cold_tank.port_a) annotation (Line(points={{-22,36},
              {-22,40},{-34,40},{-34,42},{-48,42},{-48,36.4}},
                        color={0,127,255}));
      connect(transportDelayPipe1.port_b, hot_tank.port_a) annotation (Line(points={{30,-70},
              {48,-70},{48,-75.6}},
                      color={0,127,255}));
      connect(pump1.port_b, Discharging_Valve.port_a) annotation (Line(points={{82,-56},
              {82,-38}},                        color={0,127,255}));
      connect(actuatorBus.Boiler_Steam_Valve, valveLinear.opening) annotation (Line(
          points={{30,100},{30,90},{-6,90},{-6,84}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Boiler_Drum_Pressure, Boiler_Pressure.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,72},{-81,72}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Boiler_Level, Level_Boiler.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,58},{-81,58}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Boiler_Feed_Flow, boundary3.m_flow_in) annotation (Line(
          points={{30,100},{84,100},{84,52.2},{74,52.2}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,60},{-64,60},{-64,-26},{-34,-26}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
        annotation (Line(
          points={{30,100},{96,100},{96,-28},{90,-28}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,114},{-81,114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,128},{-83,128}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
          points={{-30,100},{-81,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,86},{-81,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Level_Hot_Tank1.y, delay1.u)
        annotation (Line(points={{-67,-90},{-58.8,-90}}, color={0,0,127}));
      connect(boundary2.T_in, delay1.y)
        annotation (Line(points={{-46,-88},{-48,-88},{-48,-90},{-49.44,-90}},
                                                          color={0,0,127}));
      connect(boundary5.m_flow_in, triggeredTrapezoid.y)
        annotation (Line(points={{-106,-68},{-129,-68}}, color={0,0,127}));
      connect(hysteresis.y, triggeredTrapezoid.u)
        annotation (Line(points={{-173,-68},{-152,-68}}, color={255,0,255}));
      connect(hysteresis.u, Level_Hot_Tank2.y)
        annotation (Line(points={{-196,-68},{-209,-68}}, color={0,0,127}));
      connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,142},{-83,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,32},{-173,32},{-173,-68}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,154},{-83,154}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Charging_Valve.port_b, CHX.port_a_tube) annotation (Line(points={{-26,-36},
              {-26,-46},{-8,-46},{-8,-50}},        color={0,127,255}));
      connect(transportDelayPipe1.port_a, CHX.port_b_tube) annotation (Line(points={{10,-70},
              {8,-70},{8,-74},{2,-74},{2,-82},{-8,-82},{-8,-70}},             color=
             {0,127,255}));
      connect(CHX.port_a_shell, CHX_Inlet_T.port_b) annotation (Line(points={{-12.6,
              -70},{-14,-70},{-14,-78},{-32,-78}}, color={0,127,255}));
      connect(boundary2.ports[1], CHX.port_a_shell) annotation (Line(points={{-24,-92},
              {-12.6,-92},{-12.6,-70}},            color={0,127,255}));
      connect(CHX.port_b_shell, CHX_Discharge_T.port_a) annotation (Line(points={{-12.6,
              -50},{-30,-50},{-30,-52},{-48,-52},{-48,-44},{-54,-44}},       color=
              {0,127,255}));
      connect(CHX_Discharge_T.port_b, boundary4.ports[1]) annotation (Line(points={{
              -74,-44},{-74,-32},{-120,-32}}, color={0,127,255}));
      annotation (experiment(
          StopTime=432000,
          Interval=37,
          __Dymola_Algorithm="Esdirk45a"),Icon(graphics={
            Ellipse(
              extent={{-56,70},{-6,60}},
              lineColor={175,175,175},
              lineThickness=1),
            Ellipse(
              extent={{-56,14},{-6,0}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-56,66},{-6,6}},
              lineColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1,
              fillColor={215,215,215}),
            Ellipse(
              extent={{18,-56},{72,-68}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{18,-2},{72,-62}},
              lineColor={175,175,175},
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1),
            Ellipse(
              extent={{18,4},{72,-8}},
              lineColor={175,175,175},
              lineThickness=1),
            Rectangle(
              extent={{68,44},{24,18}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-8,-36},{-52,-62}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={255,85,85}),
            Rectangle(
              extent={{-6,18},{18,12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-41,3},{41,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-71,15},
              rotation=90),
            Rectangle(
              extent={{-30,3},{30,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-23},
              rotation=180),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-28},
              rotation=90),
            Rectangle(
              extent={{-9,3},{9,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-65,53},
              rotation=180),
            Rectangle(
              extent={{-18,-70},{10,-76}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-7,3},{7,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-69},
              rotation=90),
            Rectangle(
              extent={{4,-54},{18,-60}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-11,3},{11,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={7,-65},
              rotation=90),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={15,20},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={18,29},
              rotation=180),
            Rectangle(
              extent={{32,12},{82,6}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-17,3},{17,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={79,-5},
              rotation=90),
            Rectangle(
              extent={{-5,3},{5,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={77,-19},
              rotation=180),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-62,-70},
              rotation=90),
            Rectangle(
              extent={{-17,2},{17,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-77,-62},
              rotation=180),
            Rectangle(
              extent={{-11,2},{11,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-53,-78},
              rotation=180),
            Rectangle(
              extent={{-9,2},{9,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={56,53},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={35,12},
              rotation=90),
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={74,60},
              rotation=180),
            Rectangle(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={91,-60},
              rotation=180),
            Rectangle(
              extent={{-45,2},{45,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={86,-17},
              rotation=90),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={78,26},
              rotation=180),
            Rectangle(
              extent={{-16,2},{16,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-68,-48},
              rotation=180),
            Rectangle(
              extent={{-45,2},{45,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-82,-5},
              rotation=90),
            Rectangle(
              extent={{-9,2},{9,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-71},
              rotation=90),
            Rectangle(
              extent={{-7,2},{7,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-87,38},
              rotation=180),
            Rectangle(
              extent=DynamicSelect({{-56,66},{-6,6}},{{-56,66},{-6,6+60*hot_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1)}));
    end SHS_Mikk_Two_Tank_NTUs_New_Control;

    model Two_Tank_SHS_System
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Boiler_02 CS,
        redeclare replaceable ED_Dummy ED,
        redeclare replaceable Data.Data_SHS data);
        replaceable package Storage_Medium =
          TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
          replaceable package Charging_Medium =
          Modelica.Media.Water.StandardWater                                       constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
          replaceable package Discharging_Medium =
          Modelica.Media.Water.StandardWater                                          constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
        parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.0;
        parameter Integer CHXnV = 5;
        parameter Modelica.Units.SI.Length tank_height = 15;

        input Modelica.Units.SI.MassFlowRate Produced_steam_flow annotation(Dialog(tab = "General"));
        output Boolean Charging_Trigger = hysteresis.y;

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
        tube_av_b=false,
        shell_av_b=false,
        use_derQ=data.DHX_Use_derQ,
        tau=data.DHX_tau,
        NTU=data.DHX_NTU,
        K_tube=data.DHX_K_tube,
        K_shell=data.DHX_K_shell,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Discharging_Medium,
        V_Tube=data.DHX_v_tube,
        V_Shell=data.DHX_v_shell,
        p_start_tube=data.DHX_p_start_tube,
        h_start_tube_inlet=data.DHX_h_start_tube_inlet,
        h_start_tube_outlet=data.DHX_h_start_tube_outlet,
        p_start_shell=data.DHX_p_start_shell,
        h_start_shell_inlet=data.DHX_h_start_shell_inlet,
        h_start_shell_outlet=data.DHX_h_start_shell_outlet,
        dp_init_tube=data.DHX_dp_init_tube,
        dp_init_shell = data.DHX_dp_init_shell,
        Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={8,14})));
      TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium
          = Storage_Medium, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=data.ctvolume_volume))
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=0,
            origin={50,-10})));
      Fluid.Valves.ValveLinear Discharging_Valve(
        redeclare package Medium = Storage_Medium,
        dp_nominal=data.disvalve_dp_nominal,
        m_flow_nominal=data.disvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={82,-28})));
      BaseClasses.DumpTank_Init_T      hot_tank(
        redeclare package Medium = Storage_Medium,
        A=data.ht_area,
        V0=data.ht_zero_level_volume,
        p_surface=data.ht_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ht_surface_pressure,
        level_start=data.ht_init_level,
        h_start=747e3,
        T_start=data.hot_tank_init_temp)
        annotation (Placement(transformation(extent={{38,-94},{58,-74}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe hot_tank_dump_pipe(
        redeclare package Medium = Storage_Medium,
        crossArea=data.htdp_area,
        length=data.htdp_length,
        dheight=data.htdp_d_height) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={20,-70})));
      TRANSFORM.Fluid.Machines.Pump discharge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.discharge_pump_volume,
        diameter=data.discharge_pump_diameter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.discharge_pump_rpm_nominal,
        diameter_nominal=data.discharge_pump_diameter_nominal,
        dp_nominal=data.discharge_pump_dp_nominal,
        m_flow_nominal=data.discharge_pump_m_flow_nominal,
        d_nominal=data.discharge_pump_rho_nominal,
        N_input=data.discharge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={82,-66})));
      Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
            Discharging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
        redeclare package Medium = Storage_Medium,
        crossArea=data.ctdp_area,
        length=data.ctdp_length,
        dheight=data.ctdp_d_height) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=270,
            origin={-22,26})));
      BaseClasses.DumpTank_Init_T      cold_tank(
        redeclare package Medium = Storage_Medium,
        A=data.cold_tank_area,
        V0=data.ct_zero_level_volume,
        p_surface=data.ct_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ct_surface_pressure,
        level_start=data.cold_tank_init_level,
        Use_T_Start=true,
        h_start=133e3,
        T_start=data.cold_tank_init_temp)
        annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
      TRANSFORM.Fluid.Machines.Pump charge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.charge_pump_volume,
        diameter=data.charge_pump_diamter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.charge_pump_rpm_nominal,
        diameter_nominal=data.charge_pump_diameter_nominal,
        dp_nominal=data.charge_pump_dp_nominal,
        m_flow_nominal=data.charge_pump_m_flow_nominal,
        d_nominal=data.charge_pump_rho_nominal,
        N_input=data.charge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-48,-2})));
      Fluid.Valves.ValveLinear Charging_Valve(
        redeclare package Medium = Storage_Medium,
        allowFlowReversal=true,
        dp_nominal=data.chvalve_dp_nominal,
        m_flow_nominal=data.chvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-26,-26})));
      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

      Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
        annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
        annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
      Modelica.Fluid.Sources.MassFlowSource_h boundary2(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_h_in=true,
        m_flow=m_flow_min,
        nPorts=1) annotation (Placement(transformation(extent={{-44,-104},{-24,-84}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary4(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_T_in=false,
        m_flow=-m_flow_min,
        T=598.15,
        nPorts=1) annotation (Placement(transformation(extent={{-98,-2},{-78,18}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=0.5*CHX.shell.mediums[
            1].h + 0.5*CHX.shell.mediums[CHXnV].h)
        annotation (Placement(transformation(extent={{-88,-100},{-68,-80}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
        delay1(Ti=0.5)
        annotation (Placement(transformation(extent={{-62,-92},{-54,-88}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=12)
        annotation (Placement(transformation(extent={{-66,68},{-46,88}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=15 - hot_tank.level)
        annotation (Placement(transformation(extent={{-100,64},{-80,84}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=
            hot_tank_dump_pipe.state.T)
        annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
            Produced_steam_flow)
        annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
      TRANSFORM.HeatExchangers.GenericDistributed_HX      CHX(
        nParallel=6,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_o_shell=0.1,
            crossAreaEmpty_shell=1,
            nV=CHXnV,
            nTubes=500,
            nR=2,
            length_shell=25,
            dimension_tube=0.04,
            length_tube=25,
            th_wall=0.003),
        redeclare package Medium_shell = Charging_Medium,
        redeclare package Medium_tube = Storage_Medium,
        redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS316,
        redeclare model FlowModel_shell =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
        redeclare model FlowModel_tube =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        p_a_start_tube=1500000,
        p_b_start_tube=800000,
        exposeState_b_shell=false,
        useLumpedPressure_shell=false,
        exposeState_a_tube=false,
        exposeState_b_tube=true,
        redeclare model InternalTraceGen_tube =
            TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration,
        redeclare model InternalHeatGen_tube =
            TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration)
                           annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-8,-60})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package
          Medium =
            Charging_Medium)                                                                           annotation (Placement(
            transformation(extent={{-108,-72},{-88,-52}}), iconTransformation(
              extent={{-108,-72},{-88,-52}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package
          Medium =
            Charging_Medium)                                                                            annotation (Placement(
            transformation(extent={{-108,44},{-88,64}}), iconTransformation(extent={
                {-108,44},{-88,64}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package
          Medium =
            Discharging_Medium)                                                                            annotation (Placement(
            transformation(extent={{88,48},{108,68}}), iconTransformation(extent={{88,
                48},{108,68}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_dch_b(redeclare package
          Medium =
            Discharging_Medium)                                                                             annotation (Placement(
            transformation(extent={{90,-72},{110,-52}}), iconTransformation(extent={
                {90,-72},{110,-52}})));
    equation
      connect(volume.port_a, Discharging_Valve.port_b)
        annotation (Line(points={{56,-10},{82,-10},{82,-18}},
                                                       color={0,127,255}));
      connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{48,-92.4},
              {48,-96},{82,-96},{82,-76}}, color={0,127,255}));
      connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{44,-10},{24,-10},
              {24,10},{18,10}},
                              color={0,127,255}));
      connect(cold_tank.port_b, charge_pump.port_a)
        annotation (Line(points={{-48,19.6},{-48,8}}, color={0,127,255}));
      connect(DHX.Tube_out, cold_tank_dump_pipe.port_a)
        annotation (Line(points={{-2,10},{-22,10},{-22,16}}, color={0,127,255}));
      connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-48,
              -12},{-48,-16},{-40,-16},{-40,-14},{-34,-14},{-34,-8},{-26,-8},{-26,-16}},
            color={0,127,255}));
      connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points=
             {{-22,36},{-22,40},{-34,40},{-34,42},{-48,42},{-48,36.4}}, color={0,
              127,255}));
      connect(hot_tank_dump_pipe.port_b, hot_tank.port_a) annotation (Line(points={
              {30,-70},{48,-70},{48,-75.6}}, color={0,127,255}));
      connect(discharge_pump.port_b, Discharging_Valve.port_a)
        annotation (Line(points={{82,-56},{82,-38}}, color={0,127,255}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,60},{-64,60},{-64,-26},{-34,-26}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
        annotation (Line(
          points={{30,100},{96,100},{96,-28},{90,-28}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,114},{-81,114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,128},{-83,128}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
          points={{-30,100},{-81,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,86},{-81,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Level_Hot_Tank1.y, delay1.u)
        annotation (Line(points={{-67,-90},{-62.8,-90}}, color={0,0,127}));
      connect(hysteresis.u, Level_Hot_Tank2.y)
        annotation (Line(points={{-68,78},{-74,78},{-74,74},{-79,74}},
                                                         color={0,0,127}));
      connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,142},{-83,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
          points={{-30,100},{-30,72},{-45,72},{-45,78}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
          points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Charging_Valve.port_b, CHX.port_a_tube) annotation (Line(points={{-26,-36},
              {-26,-46},{-8,-46},{-8,-50}},        color={0,127,255}));
      connect(hot_tank_dump_pipe.port_a, CHX.port_b_tube) annotation (Line(points={
              {10,-70},{8,-70},{8,-74},{2,-74},{2,-82},{-8,-82},{-8,-70}}, color={0,
              127,255}));
      connect(boundary2.ports[1], CHX.port_a_shell) annotation (Line(points={{-24,-94},
              {-12.6,-94},{-12.6,-70}},            color={0,127,255}));
      connect(boundary4.ports[1], CHX.port_b_shell) annotation (Line(points={{-78,8},
              {-68,8},{-68,-50},{-24,-50},{-24,-50},{-12.6,-50}}, color={0,127,255}));
      connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{56,58},{56,
              38},{-6,38},{-6,16},{-2,16}}, color={0,127,255}));
      connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{18,16},{48,16},{48,
              18},{72,18},{72,16},{92,16},{92,-62},{100,-62}}, color={0,127,255}));
      connect(port_ch_a, CHX.port_a_shell) annotation (Line(points={{-98,-62},{-74,-62},
              {-74,-64},{-44,-64},{-44,-70},{-12.6,-70}}, color={0,127,255}));
      connect(CHX.port_b_shell, port_ch_b) annotation (Line(points={{-12.6,-50},{-50,
              -50},{-50,-32},{-76,-32},{-76,54},{-98,54}}, color={0,127,255}));
      connect(boundary2.h_in, delay1.y)
        annotation (Line(points={{-46,-90},{-53.44,-90}}, color={0,0,127}));
      annotation (experiment(
          StopTime=432000,
          Interval=37,
          __Dymola_Algorithm="Esdirk45a"), Icon(graphics={
            Ellipse(
              extent={{-56,70},{-6,60}},
              lineColor={175,175,175},
              lineThickness=1),
            Ellipse(
              extent={{-56,14},{-6,0}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-56,66},{-6,6}},
              lineColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1,
              fillColor={215,215,215}),
            Ellipse(
              extent={{18,-56},{72,-68}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{18,-2},{72,-62}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Ellipse(
              extent={{18,4},{72,-8}},
              lineColor={175,175,175},
              lineThickness=1),
            Rectangle(
              extent={{68,44},{24,18}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-8,-36},{-52,-62}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={255,85,85}),
            Rectangle(
              extent={{-6,18},{18,12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-41,3},{41,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-71,15},
              rotation=90),
            Rectangle(
              extent={{-30,3},{30,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-23},
              rotation=180),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-28},
              rotation=90),
            Rectangle(
              extent={{-9,3},{9,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-65,53},
              rotation=180),
            Rectangle(
              extent={{-18,-70},{10,-76}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-7,3},{7,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-69},
              rotation=90),
            Rectangle(
              extent={{4,-54},{18,-60}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-11,3},{11,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={7,-65},
              rotation=90),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={15,20},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={18,29},
              rotation=180),
            Rectangle(
              extent={{32,12},{82,6}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-17,3},{17,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={79,-5},
              rotation=90),
            Rectangle(
              extent={{-5,3},{5,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={77,-19},
              rotation=180),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-62,-70},
              rotation=90),
            Rectangle(
              extent={{-17,2},{17,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-77,-62},
              rotation=180),
            Rectangle(
              extent={{-11,2},{11,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-53,-78},
              rotation=180),
            Rectangle(
              extent={{-8,2},{8,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={56,52},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={35,12},
              rotation=90),
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={74,58},
              rotation=180),
            Rectangle(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={89,-62},
              rotation=180),
            Rectangle(
              extent={{-46,2},{46,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={86,-18},
              rotation=90),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={78,26},
              rotation=180),
            Rectangle(
              extent={{-16,2},{16,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-68,-48},
              rotation=180),
            Rectangle(
              extent={{-52,2},{52,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-82,2},
              rotation=90),
            Rectangle(
              extent={{-9,2},{9,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-71},
              rotation=90),
            Rectangle(
              extent={{-7,2},{7,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-87,52},
              rotation=180),
            Rectangle(
              extent=DynamicSelect({{-56,6},{-6,66}},{{-56,6},{-6,6+60*hot_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1),
            Rectangle(
              extent=DynamicSelect({{18,-62},{72,-2}},{{18,-62},{72,-62+60*cold_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1)}));
    end Two_Tank_SHS_System;

    model Two_Tank_SHS_System_NTU
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Boiler_04 CS,
        redeclare replaceable ED_Dummy ED,
        redeclare replaceable Data.Data_SHS data);
        replaceable package Storage_Medium =
          TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
          replaceable package Charging_Medium =
          Modelica.Media.Water.StandardWater                                       constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
          replaceable package Discharging_Medium =
          Modelica.Media.Water.StandardWater                                          constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
        parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.50;
        parameter Integer CHXnV = 5;
        parameter Modelica.Units.SI.Length tank_height = 15;

        input Modelica.Units.SI.MassFlowRate Produced_steam_flow annotation(Dialog(tab = "General"));
        output Boolean Charging_Trigger = hysteresis.y;

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
        tube_av_b=false,
        shell_av_b=false,
        use_derQ=data.DHX_Use_derQ,
        tau=data.DHX_tau,
        NTU=data.DHX_NTU,
        K_tube=data.DHX_K_tube,
        K_shell=data.DHX_K_shell,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Discharging_Medium,
        V_Tube=data.DHX_v_tube,
        V_Shell=data.DHX_v_shell,
        p_start_tube=data.DHX_p_start_tube,
        h_start_tube_inlet=data.DHX_h_start_tube_inlet,
        h_start_tube_outlet=data.DHX_h_start_tube_outlet,
        p_start_shell=data.DHX_p_start_shell,
        h_start_shell_inlet=data.DHX_h_start_shell_inlet,
        h_start_shell_outlet=data.DHX_h_start_shell_outlet,
        dp_init_tube=data.DHX_dp_init_tube,
        dp_init_shell = data.DHX_dp_init_shell,
        Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={8,14})));
      TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium
          = Storage_Medium, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=data.ctvolume_volume))
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=0,
            origin={50,-10})));
      Fluid.Valves.ValveLinear Discharging_Valve(
        redeclare package Medium = Storage_Medium,
        dp_nominal=data.disvalve_dp_nominal,
        m_flow_nominal=data.disvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={82,-28})));
      BaseClasses.DumpTank_Init_T      hot_tank(
        redeclare package Medium = Storage_Medium,
        A=data.ht_area,
        V0=data.ht_zero_level_volume,
        p_surface=data.ht_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ht_surface_pressure,
        level_start=data.ht_init_level,
        h_start=747e3,
        T_start=data.hot_tank_init_temp)
        annotation (Placement(transformation(extent={{34,-98},{54,-78}})));

      TRANSFORM.Fluid.Machines.Pump discharge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.discharge_pump_volume,
        diameter=data.discharge_pump_diameter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.discharge_pump_rpm_nominal,
        diameter_nominal=data.discharge_pump_diameter_nominal,
        dp_nominal=data.discharge_pump_dp_nominal,
        m_flow_nominal=data.discharge_pump_m_flow_nominal,
        d_nominal=data.discharge_pump_rho_nominal,
        N_input=data.discharge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={82,-66})));
      Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
            Discharging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
        redeclare package Medium = Storage_Medium,
        crossArea=data.ctdp_area,
        length=data.ctdp_length,
        dheight=data.ctdp_d_height) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=270,
            origin={-22,26})));
      BaseClasses.DumpTank_Init_T      cold_tank(
        redeclare package Medium = Storage_Medium,
        A=data.cold_tank_area,
        V0=data.ct_zero_level_volume,
        p_surface=data.ct_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ct_surface_pressure,
        level_start=data.cold_tank_init_level,
        Use_T_Start=true,
        h_start=133e3,
        T_start=data.cold_tank_init_temp)
        annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
      TRANSFORM.Fluid.Machines.Pump charge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.charge_pump_volume,
        diameter=data.charge_pump_diamter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.charge_pump_rpm_nominal,
        diameter_nominal=data.charge_pump_diameter_nominal,
        dp_nominal=data.charge_pump_dp_nominal,
        m_flow_nominal=data.charge_pump_m_flow_nominal,
        d_nominal=data.charge_pump_rho_nominal,
        N_input=data.charge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-48,-2})));
      Fluid.Valves.ValveLinear Charging_Valve(
        redeclare package Medium = Storage_Medium,
        allowFlowReversal=true,
        dp_nominal=data.chvalve_dp_nominal,
        m_flow_nominal=data.chvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-26,-26})));
      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

      Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
        annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
        annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
      Modelica.Fluid.Sources.MassFlowSource_h boundary2(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_h_in=true,
        m_flow=m_flow_min,
        nPorts=1) annotation (Placement(transformation(extent={{-44,-104},{-24,-84}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary4(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_T_in=false,
        m_flow=-m_flow_min,
        T=598.15,
        nPorts=1) annotation (Placement(transformation(extent={{-124,-52},{-104,-32}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.h)
        annotation (Placement(transformation(extent={{-88,-100},{-68,-80}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
        delay1(Ti=0.5)
        annotation (Placement(transformation(extent={{-62,-92},{-54,-88}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=12)
        annotation (Placement(transformation(extent={{-66,68},{-46,88}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=15 - hot_tank.level)
        annotation (Placement(transformation(extent={{-100,64},{-80,84}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
        annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
            Produced_steam_flow)
        annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
        shell_av_b=true,
        use_derQ=true,
        tau=1,
        NTU=0.9,
        K_tube=1000,
        K_shell=1000,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Charging_Medium,
        V_Tube=10,
        V_Shell=25,
        Q_init=1)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-14,-60})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package
          Medium =
            Charging_Medium)                                                                           annotation (Placement(
            transformation(extent={{-108,-72},{-88,-52}}), iconTransformation(
              extent={{-108,-72},{-88,-52}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package
          Medium =
            Charging_Medium)                                                                            annotation (Placement(
            transformation(extent={{-108,44},{-88,64}}), iconTransformation(extent={
                {-108,44},{-88,64}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package
          Medium =
            Discharging_Medium)                                                                            annotation (Placement(
            transformation(extent={{88,48},{108,68}}), iconTransformation(extent={{88,
                48},{108,68}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_dch_b(redeclare package
          Medium =
            Discharging_Medium)                                                                             annotation (Placement(
            transformation(extent={{90,-72},{110,-52}}), iconTransformation(extent={
                {90,-72},{110,-52}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
          redeclare package Medium =
            Storage_Medium, R=100)
        annotation (Placement(transformation(extent={{24,-84},{44,-64}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{0,-88},{20,-68}})));
    equation
      connect(volume.port_a, Discharging_Valve.port_b)
        annotation (Line(points={{56,-10},{82,-10},{82,-18}},
                                                       color={0,127,255}));
      connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{44,-96.4},
              {44,-108},{82,-108},{82,-76}},
                                           color={0,127,255}));
      connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{44,-10},{24,-10},
              {24,10},{18,10}},
                              color={0,127,255}));
      connect(cold_tank.port_b, charge_pump.port_a)
        annotation (Line(points={{-48,19.6},{-48,8}}, color={0,127,255}));
      connect(DHX.Tube_out, cold_tank_dump_pipe.port_a)
        annotation (Line(points={{-2,10},{-22,10},{-22,16}}, color={0,127,255}));
      connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-48,
              -12},{-48,-16},{-40,-16},{-40,-14},{-34,-14},{-34,-8},{-26,-8},{-26,-16}},
            color={0,127,255}));
      connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points=
             {{-22,36},{-22,40},{-34,40},{-34,42},{-48,42},{-48,36.4}}, color={0,
              127,255}));
      connect(discharge_pump.port_b, Discharging_Valve.port_a)
        annotation (Line(points={{82,-56},{82,-38}}, color={0,127,255}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,60},{-64,60},{-64,-26},{-34,-26}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
        annotation (Line(
          points={{30,100},{96,100},{96,-28},{90,-28}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,114},{-81,114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,128},{-83,128}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
          points={{-30,100},{-81,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,86},{-81,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Level_Hot_Tank1.y, delay1.u)
        annotation (Line(points={{-67,-90},{-62.8,-90}}, color={0,0,127}));
      connect(hysteresis.u, Level_Hot_Tank2.y)
        annotation (Line(points={{-68,78},{-74,78},{-74,74},{-79,74}},
                                                         color={0,0,127}));
      connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,142},{-83,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
          points={{-30,100},{-30,72},{-45,72},{-45,78}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
          points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{56,58},{56,
              38},{-6,38},{-6,16},{-2,16}}, color={0,127,255}));
      connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{18,16},{48,16},{48,
              18},{72,18},{72,16},{92,16},{92,-62},{100,-62}}, color={0,127,255}));
      connect(boundary2.h_in, delay1.y)
        annotation (Line(points={{-46,-90},{-53.44,-90}}, color={0,0,127}));
      connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-10,-50},
              {-10,-44},{-26,-44},{-26,-36}}, color={0,127,255}));
      connect(CHX.Shell_in, boundary2.ports[1]) annotation (Line(points={{-16,-70},{
              -16,-84},{-14,-84},{-14,-94},{-24,-94}}, color={0,127,255}));
      connect(CHX.Shell_in, port_ch_a) annotation (Line(points={{-16,-70},{-16,-74},
              {-82,-74},{-82,-62},{-98,-62}}, color={0,127,255}));
      connect(CHX.Shell_out, boundary4.ports[1]) annotation (Line(points={{-16,-50},
              {-52,-50},{-52,-42},{-104,-42}},
                                          color={0,127,255}));
      connect(CHX.Shell_out, port_ch_b) annotation (Line(points={{-16,-50},{-52,-50},
              {-52,-42},{-88,-42},{-88,54},{-98,54}}, color={0,127,255}));
      connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{44,-79.6},
              {58,-79.6},{58,-74},{41,-74}}, color={0,127,255}));
      connect(CHX.Tube_out, sensor_T.port_a)
        annotation (Line(points={{-10,-70},{-10,-78},{0,-78}}, color={0,127,255}));
      connect(sensor_T.port_b, resistance.port_a)
        annotation (Line(points={{20,-78},{27,-78},{27,-74}}, color={0,127,255}));
      annotation (experiment(
          StopTime=432000,
          Interval=37,
          __Dymola_Algorithm="Esdirk45a"), Icon(graphics={
            Ellipse(
              extent={{-56,70},{-6,60}},
              lineColor={175,175,175},
              lineThickness=1),
            Ellipse(
              extent={{-56,14},{-6,0}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-56,66},{-6,6}},
              lineColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1,
              fillColor={215,215,215}),
            Ellipse(
              extent={{18,-56},{72,-68}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{18,-2},{72,-62}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Ellipse(
              extent={{18,4},{72,-8}},
              lineColor={175,175,175},
              lineThickness=1),
            Rectangle(
              extent={{68,44},{24,18}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-8,-36},{-52,-62}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={255,85,85}),
            Rectangle(
              extent={{-6,18},{18,12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-41,3},{41,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-71,15},
              rotation=90),
            Rectangle(
              extent={{-30,3},{30,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-23},
              rotation=180),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-28},
              rotation=90),
            Rectangle(
              extent={{-9,3},{9,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-65,53},
              rotation=180),
            Rectangle(
              extent={{-18,-70},{10,-76}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-7,3},{7,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-69},
              rotation=90),
            Rectangle(
              extent={{4,-54},{18,-60}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-11,3},{11,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={7,-65},
              rotation=90),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={15,20},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={18,29},
              rotation=180),
            Rectangle(
              extent={{32,12},{82,6}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-17,3},{17,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={79,-5},
              rotation=90),
            Rectangle(
              extent={{-5,3},{5,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={77,-19},
              rotation=180),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-62,-70},
              rotation=90),
            Rectangle(
              extent={{-17,2},{17,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-77,-62},
              rotation=180),
            Rectangle(
              extent={{-11,2},{11,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-53,-78},
              rotation=180),
            Rectangle(
              extent={{-8,2},{8,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={56,52},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={35,12},
              rotation=90),
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={74,58},
              rotation=180),
            Rectangle(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={89,-62},
              rotation=180),
            Rectangle(
              extent={{-46,2},{46,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={86,-18},
              rotation=90),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={78,26},
              rotation=180),
            Rectangle(
              extent={{-16,2},{16,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-68,-48},
              rotation=180),
            Rectangle(
              extent={{-52,2},{52,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-82,2},
              rotation=90),
            Rectangle(
              extent={{-9,2},{9,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-71},
              rotation=90),
            Rectangle(
              extent={{-7,2},{7,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-87,52},
              rotation=180),
            Rectangle(
              extent=DynamicSelect({{-56,6},{-6,66}},{{-56,6},{-6,6+60*hot_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1),
            Rectangle(
              extent=DynamicSelect({{18,-62},{72,-2}},{{18,-62},{72,-62+60*cold_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1)}));
    end Two_Tank_SHS_System_NTU;

    model Two_Tank_SHS_System_NTU_GMI
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Boiler_04 CS,
        redeclare replaceable ED_Dummy ED,
        redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
        replaceable package Storage_Medium =
          TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
          replaceable package Charging_Medium =
          Modelica.Media.Water.StandardWater                                       constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
          replaceable package Discharging_Medium =
          Modelica.Media.Water.StandardWater                                          constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
        parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.50;
        parameter Integer CHXnV = 5;
        parameter Modelica.Units.SI.Length tank_height = 15;

        input Modelica.Units.SI.MassFlowRate Produced_steam_flow annotation(Dialog(tab = "General"));
        output Boolean Charging_Trigger = hysteresis.y;

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
        tube_av_b=false,
        shell_av_b=false,
        use_derQ=data.DHX_Use_derQ,
        tau=data.DHX_tau,
        NTU=data.DHX_NTU,
        K_tube=data.DHX_K_tube,
        K_shell=data.DHX_K_shell,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Discharging_Medium,
        V_Tube=data.DHX_v_tube,
        V_Shell=data.DHX_v_shell,
        p_start_tube=data.DHX_p_start_tube,
        h_start_tube_inlet=data.DHX_h_start_tube_inlet,
        h_start_tube_outlet=data.DHX_h_start_tube_outlet,
        p_start_shell=data.DHX_p_start_shell,
        h_start_shell_inlet=data.DHX_h_start_shell_inlet,
        h_start_shell_outlet=data.DHX_h_start_shell_outlet,
        dp_init_tube=data.DHX_dp_init_tube,
        dp_init_shell = data.DHX_dp_init_shell,
        Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={72,20})));
      TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium
          = Storage_Medium, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=data.ctvolume_volume))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-16})));
      Fluid.Valves.ValveLinear Discharging_Valve(
        redeclare package Medium = Storage_Medium,
        dp_nominal=data.disvalve_dp_nominal,
        m_flow_nominal=data.disvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={68,-42})));
      BaseClasses.DumpTank_Init_T      hot_tank(
        redeclare package Medium = Storage_Medium,
        A=data.ht_area,
        V0=data.ht_zero_level_volume,
        p_surface=data.ht_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ht_surface_pressure,
        level_start=data.ht_init_level,
        h_start=747e3,
        T_start=data.hot_tank_init_temp)
        annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

      TRANSFORM.Fluid.Machines.Pump discharge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.discharge_pump_volume,
        diameter=data.discharge_pump_diameter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.discharge_pump_rpm_nominal,
        diameter_nominal=data.discharge_pump_diameter_nominal,
        dp_nominal=data.discharge_pump_dp_nominal,
        m_flow_nominal=data.discharge_pump_m_flow_nominal,
        d_nominal=data.discharge_pump_rho_nominal,
        N_input=data.discharge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-76})));
      Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
            Discharging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
        redeclare package Medium = Storage_Medium,
        crossArea=data.ctdp_area,
        length=data.ctdp_length,
        dheight=data.ctdp_d_height) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=0,
            origin={12,44})));
      BaseClasses.DumpTank_Init_T      cold_tank(
        redeclare package Medium = Storage_Medium,
        A=data.cold_tank_area,
        V0=data.ct_zero_level_volume,
        p_surface=data.ct_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ct_surface_pressure,
        level_start=data.cold_tank_init_level,
        Use_T_Start=true,
        h_start=133e3,
        T_start=data.cold_tank_init_temp)
        annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
      TRANSFORM.Fluid.Machines.Pump charge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.charge_pump_volume,
        diameter=data.charge_pump_diamter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.charge_pump_rpm_nominal,
        diameter_nominal=data.charge_pump_diameter_nominal,
        dp_nominal=data.charge_pump_dp_nominal,
        m_flow_nominal=data.charge_pump_m_flow_nominal,
        d_nominal=data.charge_pump_rho_nominal,
        N_input=data.charge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-42,8})));
      Fluid.Valves.ValveLinear Charging_Valve(
        redeclare package Medium = Storage_Medium,
        allowFlowReversal=true,
        dp_nominal=data.chvalve_dp_nominal,
        m_flow_nominal=data.chvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-42,-20})));
      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

      Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
        annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
        annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
      Modelica.Fluid.Sources.MassFlowSource_h boundary2(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_h_in=true,
        m_flow=m_flow_min,
        nPorts=1) annotation (Placement(transformation(extent={{-84,-102},{-64,-82}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary4(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_T_in=false,
        m_flow=-m_flow_min,
        T=473.15,
        nPorts=1) annotation (Placement(transformation(extent={{-126,24},{-106,44}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.h)
        annotation (Placement(transformation(extent={{-128,-98},{-108,-78}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
        delay1(Ti=0.5)
        annotation (Placement(transformation(extent={{-102,-90},{-94,-86}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=12)
        annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=15 - hot_tank.level)
        annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
        annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
            Produced_steam_flow)
        annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
        shell_av_b=true,
        use_derQ=true,
        tau=1,
        NTU=0.9,
        K_tube=1000,
        K_shell=1000,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Charging_Medium,
        V_Tube=10,
        V_Shell=25,
        Q_init=1)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-44,-54})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package
          Medium =
            Charging_Medium)                                                                           annotation (Placement(
            transformation(extent={{-108,-72},{-88,-52}}), iconTransformation(
              extent={{-108,-72},{-88,-52}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package
          Medium =
            Charging_Medium)                                                                            annotation (Placement(
            transformation(extent={{-108,44},{-88,64}}), iconTransformation(extent={
                {-108,44},{-88,64}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package
          Medium =
            Discharging_Medium)                                                                            annotation (Placement(
            transformation(extent={{88,48},{108,68}}), iconTransformation(extent={{88,
                48},{108,68}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_dch_b(redeclare package
          Medium =
            Discharging_Medium)                                                                             annotation (Placement(
            transformation(extent={{90,-72},{110,-52}}), iconTransformation(extent={
                {90,-72},{110,-52}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
          redeclare package Medium =
            Storage_Medium, R=100)
        annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
    equation
      connect(volume.port_a, Discharging_Valve.port_b)
        annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
      connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
              -96.4},{36,-102},{68,-102},{68,-86}},
                                           color={0,127,255}));
      connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                              color={0,127,255}));
      connect(cold_tank.port_b, charge_pump.port_a)
        annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
      connect(DHX.Tube_out, cold_tank_dump_pipe.port_a)
        annotation (Line(points={{68,30},{68,44},{22,44}},   color={0,127,255}));
      connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
              {-42,-10}},
            color={0,127,255}));
      connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
              -42,44},{-42,40.4}},                                      color={0,
              127,255}));
      connect(discharge_pump.port_b, Discharging_Valve.port_a)
        annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,82},{128,82},{128,-100},{82,-100},{82,-42},{76,-42}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,114},{-81,114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,128},{-83,128}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
          points={{-30,100},{-81,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,86},{-81,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Level_Hot_Tank1.y, delay1.u)
        annotation (Line(points={{-107,-88},{-102.8,-88}},
                                                         color={0,0,127}));
      connect(hysteresis.u, Level_Hot_Tank2.y)
        annotation (Line(points={{-99.2,74},{-113,74}},  color={0,0,127}));
      connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,142},{-83,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
          points={{-30,100},{-30,74},{-85.4,74}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
          points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
              74,30}},                      color={0,127,255}));
      connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
              86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
      connect(boundary2.h_in, delay1.y)
        annotation (Line(points={{-86,-88},{-93.44,-88}}, color={0,0,127}));
      connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
              {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
      connect(CHX.Shell_in, boundary2.ports[1]) annotation (Line(points={{-46,-64},
              {-46,-70},{-58,-70},{-58,-92},{-64,-92}},color={0,127,255}));
      connect(CHX.Shell_in, port_ch_a) annotation (Line(points={{-46,-64},{-46,-70},
              {-82,-70},{-82,-62},{-98,-62}}, color={0,127,255}));
      connect(CHX.Shell_out, boundary4.ports[1]) annotation (Line(points={{-46,-44},
              {-46,-36},{-84,-36},{-84,34},{-106,34}},
                                          color={0,127,255}));
      connect(CHX.Shell_out, port_ch_b) annotation (Line(points={{-46,-44},{-46,-36},
              {-84,-36},{-84,54},{-98,54}},           color={0,127,255}));
      connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
              -79.6},{36,-76},{13,-76}},     color={0,127,255}));
      connect(CHX.Tube_out, sensor_T.port_a)
        annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                               color={0,127,255}));
      connect(sensor_T.port_b, resistance.port_a)
        annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
      annotation (experiment(
          StopTime=432000,
          Interval=37,
          __Dymola_Algorithm="Esdirk45a"), Icon(graphics={
            Ellipse(
              extent={{-56,70},{-6,60}},
              lineColor={175,175,175},
              lineThickness=1),
            Ellipse(
              extent={{-56,14},{-6,0}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-56,66},{-6,6}},
              lineColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1,
              fillColor={215,215,215}),
            Ellipse(
              extent={{18,-56},{72,-68}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{18,-2},{72,-62}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Ellipse(
              extent={{18,4},{72,-8}},
              lineColor={175,175,175},
              lineThickness=1),
            Rectangle(
              extent={{68,44},{24,18}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-8,-36},{-52,-62}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={255,85,85}),
            Rectangle(
              extent={{-6,18},{18,12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-41,3},{41,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-71,15},
              rotation=90),
            Rectangle(
              extent={{-30,3},{30,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-23},
              rotation=180),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-28},
              rotation=90),
            Rectangle(
              extent={{-9,3},{9,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-65,53},
              rotation=180),
            Rectangle(
              extent={{-18,-70},{10,-76}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-7,3},{7,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-69},
              rotation=90),
            Rectangle(
              extent={{4,-54},{18,-60}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-11,3},{11,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={7,-65},
              rotation=90),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={15,20},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={18,29},
              rotation=180),
            Rectangle(
              extent={{32,12},{82,6}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-17,3},{17,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={79,-5},
              rotation=90),
            Rectangle(
              extent={{-5,3},{5,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={77,-19},
              rotation=180),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-62,-70},
              rotation=90),
            Rectangle(
              extent={{-17,2},{17,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-77,-62},
              rotation=180),
            Rectangle(
              extent={{-11,2},{11,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-53,-78},
              rotation=180),
            Rectangle(
              extent={{-8,2},{8,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={56,52},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={35,12},
              rotation=90),
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={74,58},
              rotation=180),
            Rectangle(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={89,-62},
              rotation=180),
            Rectangle(
              extent={{-46,2},{46,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={86,-18},
              rotation=90),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={78,26},
              rotation=180),
            Rectangle(
              extent={{-16,2},{16,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-68,-48},
              rotation=180),
            Rectangle(
              extent={{-52,2},{52,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-82,2},
              rotation=90),
            Rectangle(
              extent={{-9,2},{9,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-71},
              rotation=90),
            Rectangle(
              extent={{-7,2},{7,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-87,52},
              rotation=180),
            Rectangle(
              extent=DynamicSelect({{-56,6},{-6,66}},{{-56,6},{-6,6+60*hot_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1),
            Rectangle(
              extent=DynamicSelect({{18,-62},{72,-2}},{{18,-62},{72,-62+60*cold_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1)}));
    end Two_Tank_SHS_System_NTU_GMI;

    model Two_Tank_SHS_System_NTU_TESUC
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Basic_TESUC CS,
        redeclare replaceable ED_Dummy ED,
        redeclare replaceable Data.Data_SHS data(
          DHX_p_start_shell=1100000,
          DHX_Q_init=1e6,
          discharge_pump_dp_nominal=200000));
        replaceable package Storage_Medium =
          TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
          replaceable package Charging_Medium =
          Modelica.Media.Water.StandardWater                                       constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
          replaceable package Discharging_Medium =
          Modelica.Media.Water.StandardWater                                          constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
        parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.50;
        parameter Integer CHXnV = 5;
        parameter Modelica.Units.SI.Length tank_height = 15;

        input Modelica.Units.SI.MassFlowRate Power_Demand annotation(Dialog(tab = "General", group = "Inputs"));
        input Modelica.Units.SI.Temperature T_Steam "Used for control of power production in the case of steam cycle on the discharge side, could be replaced with gas temp if a Brayton cycle used." annotation(Dialog(tab = "General", group = "Inputs"));
      output Boolean Charging_Trigger=greaterThreshold.y;

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
        tube_av_b=false,
        shell_av_b=false,
        use_derQ=data.DHX_Use_derQ,
        tau=data.DHX_tau,
        NTU=data.DHX_NTU,
        K_tube=data.DHX_K_tube,
        K_shell=data.DHX_K_shell,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Discharging_Medium,
        V_Tube=data.DHX_v_tube,
        V_Shell=data.DHX_v_shell,
        p_start_tube=data.DHX_p_start_tube,
        h_start_tube_inlet=data.DHX_h_start_tube_inlet,
        h_start_tube_outlet=data.DHX_h_start_tube_outlet,
        p_start_shell=data.DHX_p_start_shell,
        h_start_shell_inlet=data.DHX_h_start_shell_inlet,
        h_start_shell_outlet=data.DHX_h_start_shell_outlet,
        dp_init_tube=data.DHX_dp_init_tube,
        dp_init_shell = data.DHX_dp_init_shell,
        Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={8,14})));
      TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium
          = Storage_Medium, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=data.ctvolume_volume))
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=0,
            origin={50,-10})));
      Fluid.Valves.ValveLinear Discharging_Valve(
        redeclare package Medium = Storage_Medium,
        dp_nominal=data.disvalve_dp_nominal,
        m_flow_nominal=data.disvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={76,-30})));
      BaseClasses.DumpTank_Init_T      hot_tank(
        redeclare package Medium = Storage_Medium,
        A=data.ht_area,
        V0=data.ht_zero_level_volume,
        p_surface=data.ht_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ht_surface_pressure,
        level_start=data.ht_init_level,
        h_start=747e3,
        T_start=data.hot_tank_init_temp)
        annotation (Placement(transformation(extent={{34,-98},{54,-78}})));

      TRANSFORM.Fluid.Machines.Pump discharge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.discharge_pump_volume,
        diameter=data.discharge_pump_diameter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.discharge_pump_rpm_nominal,
        diameter_nominal=data.discharge_pump_diameter_nominal,
        dp_nominal=data.discharge_pump_dp_nominal,
        m_flow_nominal=data.discharge_pump_m_flow_nominal,
        d_nominal=data.discharge_pump_rho_nominal,
        N_input=data.discharge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={82,-66})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
        redeclare package Medium = Storage_Medium,
        crossArea=data.ctdp_area,
        length=data.ctdp_length,
        dheight=data.ctdp_d_height) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=270,
            origin={-22,26})));
      BaseClasses.DumpTank_Init_T      cold_tank(
        redeclare package Medium = Storage_Medium,
        A=data.cold_tank_area,
        V0=data.ct_zero_level_volume,
        p_surface=data.ct_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ct_surface_pressure,
        level_start=data.cold_tank_init_level,
        Use_T_Start=true,
        h_start=133e3,
        T_start=data.cold_tank_init_temp)
        annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
      TRANSFORM.Fluid.Machines.Pump charge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.charge_pump_volume,
        diameter=data.charge_pump_diamter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.charge_pump_rpm_nominal,
        diameter_nominal=data.charge_pump_diameter_nominal,
        dp_nominal=data.charge_pump_dp_nominal,
        m_flow_nominal=data.charge_pump_m_flow_nominal,
        d_nominal=data.charge_pump_rho_nominal,
        N_input=data.charge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-48,-2})));
      Fluid.Valves.ValveLinear Charging_Valve(
        redeclare package Medium = Storage_Medium,
        allowFlowReversal=true,
        dp_nominal=data.chvalve_dp_nominal,
        m_flow_nominal=data.chvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-26,-26})));
      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-104,90},{-84,110}})));

      Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
        annotation (Placement(transformation(extent={{-104,104},{-84,124}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
        annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
      Modelica.Fluid.Sources.MassFlowSource_h boundary2(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_h_in=true,
        m_flow=m_flow_min,
        nPorts=1) annotation (Placement(transformation(extent={{-44,-104},{-24,-84}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary4(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_T_in=false,
        m_flow=-m_flow_min,
        T=598.15,
        nPorts=1) annotation (Placement(transformation(extent={{-124,-52},{-104,-32}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.h)
        annotation (Placement(transformation(extent={{-88,-100},{-68,-80}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
        delay1(Ti=0.5)
        annotation (Placement(transformation(extent={{-62,-92},{-54,-88}})));
      Modelica.Blocks.Logical.GreaterThreshold
                                         greaterThreshold(     threshold=0.0)
        annotation (Placement(transformation(extent={{-96,68},{-76,88}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=Power_Demand)
        annotation (Placement(transformation(extent={{-132,68},{-112,88}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
        annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
      Modelica.Blocks.Sources.RealExpression Steam_Temp(y=T_Steam)
        annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
        shell_av_b=true,
        use_derQ=true,
        tau=1,
        NTU=0.9,
        K_tube=1000,
        K_shell=1000,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Charging_Medium,
        V_Tube=10,
        V_Shell=25,
        Q_init=1)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-14,-60})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package
          Medium =
            Charging_Medium)                                                                           annotation (Placement(
            transformation(extent={{-108,-72},{-88,-52}}), iconTransformation(
              extent={{-108,-72},{-88,-52}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package
          Medium =
            Charging_Medium)                                                                            annotation (Placement(
            transformation(extent={{-108,44},{-88,64}}), iconTransformation(extent={
                {-108,44},{-88,64}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package
          Medium =
            Discharging_Medium)                                                                            annotation (Placement(
            transformation(extent={{88,48},{108,68}}), iconTransformation(extent={{88,
                48},{108,68}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_dch_b(redeclare package
          Medium =
            Discharging_Medium)                                                                             annotation (Placement(
            transformation(extent={{90,-72},{110,-52}}), iconTransformation(extent={
                {90,-72},{110,-52}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
          redeclare package Medium =
            Storage_Medium, R=100)
        annotation (Placement(transformation(extent={{24,-84},{44,-64}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{0,-88},{20,-68}})));
    equation
      connect(volume.port_a, Discharging_Valve.port_b)
        annotation (Line(points={{56,-10},{76,-10},{76,-20}},
                                                       color={0,127,255}));
      connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{44,-96.4},
              {44,-108},{82,-108},{82,-76}},
                                           color={0,127,255}));
      connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{44,-10},{24,-10},
              {24,10},{18,10}},
                              color={0,127,255}));
      connect(cold_tank.port_b, charge_pump.port_a)
        annotation (Line(points={{-48,19.6},{-48,8}}, color={0,127,255}));
      connect(DHX.Tube_out, cold_tank_dump_pipe.port_a)
        annotation (Line(points={{-2,10},{-22,10},{-22,16}}, color={0,127,255}));
      connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-48,
              -12},{-48,-16},{-40,-16},{-40,-14},{-34,-14},{-34,-8},{-26,-8},{-26,-16}},
            color={0,127,255}));
      connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points=
             {{-22,36},{-22,40},{-34,40},{-34,42},{-48,42},{-48,36.4}}, color={0,
              127,255}));
      connect(discharge_pump.port_b, Discharging_Valve.port_a)
        annotation (Line(points={{82,-56},{82,-40},{76,-40}},
                                                     color={0,127,255}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,60},{-64,60},{-64,-26},{-34,-26}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
        annotation (Line(
          points={{30,100},{96,100},{96,-30},{84,-30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,128},{-83,128}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
          points={{-30,100},{-76,100},{-76,114},{-83,114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-83,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Level_Hot_Tank1.y, delay1.u)
        annotation (Line(points={{-67,-90},{-62.8,-90}}, color={0,0,127}));
      connect(greaterThreshold.u, Level_Hot_Tank2.y)
        annotation (Line(points={{-98,78},{-111,78}}, color={0,0,127}));
      connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,142},{-83,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, greaterThreshold.y) annotation (Line(
          points={{-30,100},{-68,100},{-68,78},{-75,78}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{56,58},{56,
              38},{-6,38},{-6,16},{-2,16}}, color={0,127,255}));
      connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{18,16},{48,16},{48,
              18},{72,18},{72,16},{92,16},{92,-62},{100,-62}}, color={0,127,255}));
      connect(boundary2.h_in, delay1.y)
        annotation (Line(points={{-46,-90},{-53.44,-90}}, color={0,0,127}));
      connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-10,-50},
              {-10,-44},{-26,-44},{-26,-36}}, color={0,127,255}));
      connect(CHX.Shell_in, boundary2.ports[1]) annotation (Line(points={{-16,-70},{
              -16,-84},{-14,-84},{-14,-94},{-24,-94}}, color={0,127,255}));
      connect(CHX.Shell_in, port_ch_a) annotation (Line(points={{-16,-70},{-16,-74},
              {-82,-74},{-82,-62},{-98,-62}}, color={0,127,255}));
      connect(CHX.Shell_out, boundary4.ports[1]) annotation (Line(points={{-16,-50},
              {-52,-50},{-52,-42},{-104,-42}},
                                          color={0,127,255}));
      connect(CHX.Shell_out, port_ch_b) annotation (Line(points={{-16,-50},{-52,-50},
              {-52,-42},{-88,-42},{-88,54},{-98,54}}, color={0,127,255}));
      connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{44,-79.6},
              {58,-79.6},{58,-74},{41,-74}}, color={0,127,255}));
      connect(CHX.Tube_out, sensor_T.port_a)
        annotation (Line(points={{-10,-70},{-10,-78},{0,-78}}, color={0,127,255}));
      connect(sensor_T.port_b, resistance.port_a)
        annotation (Line(points={{20,-78},{27,-78},{27,-74}}, color={0,127,255}));
      connect(sensorBus.Steam_Temp, Steam_Temp.y) annotation (Line(
          points={{-30,100},{-62,100},{-62,140},{-51,140}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      annotation (experiment(
          StopTime=432000,
          Interval=37,
          __Dymola_Algorithm="Esdirk45a"), Icon(graphics={
            Ellipse(
              extent={{-56,70},{-6,60}},
              lineColor={175,175,175},
              lineThickness=1),
            Ellipse(
              extent={{-56,14},{-6,0}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-56,66},{-6,6}},
              lineColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1,
              fillColor={215,215,215}),
            Ellipse(
              extent={{18,-56},{72,-68}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{18,-2},{72,-62}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Ellipse(
              extent={{18,4},{72,-8}},
              lineColor={175,175,175},
              lineThickness=1),
            Rectangle(
              extent={{68,44},{24,18}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-8,-36},{-52,-62}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={255,85,85}),
            Rectangle(
              extent={{-6,18},{18,12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-41,3},{41,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-71,15},
              rotation=90),
            Rectangle(
              extent={{-30,3},{30,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-23},
              rotation=180),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-28},
              rotation=90),
            Rectangle(
              extent={{-9,3},{9,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-65,53},
              rotation=180),
            Rectangle(
              extent={{-18,-70},{10,-76}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-7,3},{7,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-69},
              rotation=90),
            Rectangle(
              extent={{4,-54},{18,-60}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-11,3},{11,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={7,-65},
              rotation=90),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={15,20},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={18,29},
              rotation=180),
            Rectangle(
              extent={{32,12},{82,6}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-17,3},{17,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={79,-5},
              rotation=90),
            Rectangle(
              extent={{-5,3},{5,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={77,-19},
              rotation=180),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-62,-70},
              rotation=90),
            Rectangle(
              extent={{-17,2},{17,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-77,-62},
              rotation=180),
            Rectangle(
              extent={{-11,2},{11,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-53,-78},
              rotation=180),
            Rectangle(
              extent={{-8,2},{8,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={56,52},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={35,12},
              rotation=90),
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={74,58},
              rotation=180),
            Rectangle(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={89,-62},
              rotation=180),
            Rectangle(
              extent={{-46,2},{46,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={86,-18},
              rotation=90),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={78,26},
              rotation=180),
            Rectangle(
              extent={{-16,2},{16,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-68,-48},
              rotation=180),
            Rectangle(
              extent={{-52,2},{52,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-82,2},
              rotation=90),
            Rectangle(
              extent={{-9,2},{9,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-71},
              rotation=90),
            Rectangle(
              extent={{-7,2},{7,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-87,52},
              rotation=180),
            Rectangle(
              extent=DynamicSelect({{-56,6},{-6,66}},{{-56,6},{-6,6+60*hot_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1),
            Rectangle(
              extent=DynamicSelect({{18,-62},{72,-2}},{{18,-62},{72,-62+60*cold_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1)}));
    end Two_Tank_SHS_System_NTU_TESUC;

    model Two_Tank_SHS_System_NTU_GMI_TempControl
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Boiler_04 CS,
        redeclare replaceable ED_Dummy ED,
        redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
        replaceable package Storage_Medium =
          TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
          replaceable package Charging_Medium =
          Modelica.Media.Water.StandardWater                                       constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
          replaceable package Discharging_Medium =
          Modelica.Media.Water.StandardWater                                          constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
        parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.50;
        parameter Integer CHXnV = 5;
        parameter Modelica.Units.SI.Length tank_height = 15;

        input Modelica.Units.SI.Temperature Steam_Output_Temp annotation(Dialog(tab = "General"));
        output Boolean Charging_Trigger = hysteresis.y;

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
        tube_av_b=false,
        shell_av_b=false,
        use_derQ=data.DHX_Use_derQ,
        tau=data.DHX_tau,
        NTU=data.DHX_NTU,
        K_tube=data.DHX_K_tube,
        K_shell=data.DHX_K_shell,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Discharging_Medium,
        V_Tube=data.DHX_v_tube,
        V_Shell=data.DHX_v_shell,
        p_start_tube=data.DHX_p_start_tube,
        use_T_start_tube=true,
        T_start_tube_inlet=573.15,
        T_start_tube_outlet=573.15,
        h_start_tube_inlet=data.DHX_h_start_tube_inlet,
        h_start_tube_outlet=data.DHX_h_start_tube_outlet,
        p_start_shell=data.DHX_p_start_shell,
        h_start_shell_inlet=data.DHX_h_start_shell_inlet,
        h_start_shell_outlet=data.DHX_h_start_shell_outlet,
        dp_init_tube=data.DHX_dp_init_tube,
        dp_init_shell = data.DHX_dp_init_shell,
        Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={72,20})));
      TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium
          = Storage_Medium, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=data.ctvolume_volume))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-16})));
      Fluid.Valves.ValveLinear Discharging_Valve(
        redeclare package Medium = Storage_Medium,
        dp_nominal=data.disvalve_dp_nominal,
        m_flow_nominal=data.disvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={68,-42})));
      BaseClasses.DumpTank_Init_T      hot_tank(
        redeclare package Medium = Storage_Medium,
        A=data.ht_area,
        V0=data.ht_zero_level_volume,
        p_surface=data.ht_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ht_surface_pressure,
        level_start=data.ht_init_level,
        h_start=747e3,
        T_start=data.hot_tank_init_temp)
        annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

      TRANSFORM.Fluid.Machines.Pump discharge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.discharge_pump_volume,
        diameter=data.discharge_pump_diameter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.discharge_pump_rpm_nominal,
        diameter_nominal=data.discharge_pump_diameter_nominal,
        dp_nominal=data.discharge_pump_dp_nominal,
        m_flow_nominal=data.discharge_pump_m_flow_nominal,
        d_nominal=data.discharge_pump_rho_nominal,
        N_input=data.discharge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-76})));
      Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
            Discharging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
        redeclare package Medium = Storage_Medium,
        crossArea=data.ctdp_area,
        length=data.ctdp_length,
        dheight=data.ctdp_d_height) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=0,
            origin={12,44})));
      BaseClasses.DumpTank_Init_T      cold_tank(
        redeclare package Medium = Storage_Medium,
        A=data.cold_tank_area,
        V0=data.ct_zero_level_volume,
        p_surface=data.ct_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ct_surface_pressure,
        level_start=data.cold_tank_init_level,
        Use_T_Start=true,
        h_start=133e3,
        T_start=data.cold_tank_init_temp)
        annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
      TRANSFORM.Fluid.Machines.Pump charge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.charge_pump_volume,
        diameter=data.charge_pump_diamter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.charge_pump_rpm_nominal,
        diameter_nominal=data.charge_pump_diameter_nominal,
        dp_nominal=data.charge_pump_dp_nominal,
        m_flow_nominal=data.charge_pump_m_flow_nominal,
        d_nominal=data.charge_pump_rho_nominal,
        N_input=data.charge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-42,8})));
      Fluid.Valves.ValveLinear Charging_Valve(
        redeclare package Medium = Storage_Medium,
        allowFlowReversal=true,
        dp_nominal=data.chvalve_dp_nominal,
        m_flow_nominal=data.chvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-42,-20})));
      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

      Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
        annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
        annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
      Modelica.Fluid.Sources.MassFlowSource_h boundary2(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_h_in=true,
        m_flow=m_flow_min,
        nPorts=1) annotation (Placement(transformation(extent={{-84,-102},{-64,-82}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary4(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_T_in=false,
        m_flow=-m_flow_min,
        T=413.15,
        nPorts=2) annotation (Placement(transformation(extent={{-126,24},{-106,44}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.h)
        annotation (Placement(transformation(extent={{-128,-98},{-108,-78}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
        delay1(Ti=0.5)
        annotation (Placement(transformation(extent={{-102,-90},{-94,-86}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=97)
        annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=100 - hot_tank.level)
        annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
        annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
            Steam_Output_Temp)
        annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
        shell_av_b=true,
        use_derQ=true,
        tau=1,
        NTU=20,
        K_tube=1000,
        K_shell=1000,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Charging_Medium,
        V_Tube=10,
        V_Shell=25,
        use_T_start_tube=true,
        T_start_tube_inlet=573.15,
        T_start_tube_outlet=573.15,
        dp_init_tube=20000,
        Q_init=1)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-44,-54})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package
          Medium =
            Charging_Medium)                                                                           annotation (Placement(
            transformation(extent={{-108,-72},{-88,-52}}), iconTransformation(
              extent={{-108,-72},{-88,-52}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package
          Medium =
            Charging_Medium)                                                                            annotation (Placement(
            transformation(extent={{-108,44},{-88,64}}), iconTransformation(extent={
                {-108,44},{-88,64}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package
          Medium =
            Discharging_Medium)                                                                            annotation (Placement(
            transformation(extent={{88,48},{108,68}}), iconTransformation(extent={{88,
                48},{108,68}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_dch_b(redeclare package
          Medium =
            Discharging_Medium)                                                                             annotation (Placement(
            transformation(extent={{90,-72},{110,-52}}), iconTransformation(extent={
                {90,-72},{110,-52}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
          redeclare package Medium =
            Storage_Medium, R=100)
        annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
      Modelica.Blocks.Sources.RealExpression Coolant_Water_temp(y=sensor_T1.T)
        annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
      Modelica.Blocks.Sources.RealExpression Cold_Tank_Temp(y=cold_tank.T)
        annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-82,-40},{-62,-20}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{36,34},{56,54}})));
    equation
      connect(volume.port_a, Discharging_Valve.port_b)
        annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
      connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
              -96.4},{36,-102},{68,-102},{68,-86}},
                                           color={0,127,255}));
      connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                              color={0,127,255}));
      connect(cold_tank.port_b, charge_pump.port_a)
        annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
      connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
              {-42,-10}},
            color={0,127,255}));
      connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
              -42,44},{-42,40.4}},                                      color={0,
              127,255}));
      connect(discharge_pump.port_b, Discharging_Valve.port_a)
        annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,82},{128,82},{128,-100},{82,-100},{82,-42},{76,-42}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,114},{-81,114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,128},{-83,128}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
          points={{-30,100},{-81,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,86},{-81,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Level_Hot_Tank1.y, delay1.u)
        annotation (Line(points={{-107,-88},{-102.8,-88}},
                                                         color={0,0,127}));
      connect(hysteresis.u, Level_Hot_Tank2.y)
        annotation (Line(points={{-99.2,74},{-113,74}},  color={0,0,127}));
      connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,142},{-83,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
          points={{-30,100},{-30,74},{-85.4,74}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
          points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
              74,30}},                      color={0,127,255}));
      connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
              86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
      connect(boundary2.h_in, delay1.y)
        annotation (Line(points={{-86,-88},{-93.44,-88}}, color={0,0,127}));
      connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
              {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
      connect(CHX.Shell_in, boundary2.ports[1]) annotation (Line(points={{-46,-64},
              {-46,-70},{-58,-70},{-58,-92},{-64,-92}},color={0,127,255}));
      connect(CHX.Shell_out, boundary4.ports[1]) annotation (Line(points={{-46,-44},
              {-46,-36},{-84,-36},{-84,34.5},{-106,34.5}},
                                          color={0,127,255}));
      connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
              -79.6},{36,-76},{13,-76}},     color={0,127,255}));
      connect(CHX.Tube_out, sensor_T.port_a)
        annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                               color={0,127,255}));
      connect(sensor_T.port_b, resistance.port_a)
        annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
      connect(sensorBus.Cold_Tank_Temp, Cold_Tank_Temp.y) annotation (Line(
          points={{-30,100},{-30,124},{-47,124},{-47,106}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(CHX.Shell_out, sensor_T1.port_b) annotation (Line(points={{-46,-44},{
              -46,-34},{-56,-34},{-56,-30},{-62,-30}}, color={0,127,255}));
      connect(port_ch_b, sensor_T1.port_a) annotation (Line(points={{-98,54},{-84,
              54},{-84,32},{-86,32},{-86,-30},{-82,-30}}, color={0,127,255}));
      connect(port_ch_a, CHX.Shell_in) annotation (Line(points={{-98,-62},{-76,-62},
              {-76,-64},{-46,-64}}, color={0,127,255}));
      connect(sensorBus.Coolant_Water_temp, Coolant_Water_temp.y) annotation (Line(
          points={{-30,100},{-32,100},{-32,86},{-47,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(cold_tank_dump_pipe.port_a, sensor_T2.port_a)
        annotation (Line(points={{22,44},{36,44}}, color={0,127,255}));
      connect(sensor_T2.port_b, DHX.Tube_out)
        annotation (Line(points={{56,44},{68,44},{68,30}}, color={0,127,255}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, sensor_T2.T) annotation (Line(
          points={{-30,100},{-4,100},{-4,66},{46,66},{46,47.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      annotation (experiment(
          StopTime=432000,
          Interval=37,
          __Dymola_Algorithm="Esdirk45a"), Icon(graphics={
            Ellipse(
              extent={{-56,70},{-6,60}},
              lineColor={175,175,175},
              lineThickness=1),
            Ellipse(
              extent={{-56,14},{-6,0}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-56,66},{-6,6}},
              lineColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1,
              fillColor={215,215,215}),
            Ellipse(
              extent={{18,-56},{72,-68}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{18,-2},{72,-62}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Ellipse(
              extent={{18,4},{72,-8}},
              lineColor={175,175,175},
              lineThickness=1),
            Rectangle(
              extent={{68,44},{24,18}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-8,-36},{-52,-62}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={255,85,85}),
            Rectangle(
              extent={{-6,18},{18,12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-41,3},{41,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-71,15},
              rotation=90),
            Rectangle(
              extent={{-30,3},{30,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-23},
              rotation=180),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-28},
              rotation=90),
            Rectangle(
              extent={{-9,3},{9,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-65,53},
              rotation=180),
            Rectangle(
              extent={{-18,-70},{10,-76}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-7,3},{7,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-69},
              rotation=90),
            Rectangle(
              extent={{4,-54},{18,-60}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-11,3},{11,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={7,-65},
              rotation=90),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={15,20},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={18,29},
              rotation=180),
            Rectangle(
              extent={{32,12},{82,6}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-17,3},{17,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={79,-5},
              rotation=90),
            Rectangle(
              extent={{-5,3},{5,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={77,-19},
              rotation=180),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-62,-70},
              rotation=90),
            Rectangle(
              extent={{-17,2},{17,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-77,-62},
              rotation=180),
            Rectangle(
              extent={{-11,2},{11,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-53,-78},
              rotation=180),
            Rectangle(
              extent={{-8,2},{8,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={56,52},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={35,12},
              rotation=90),
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={74,58},
              rotation=180),
            Rectangle(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={89,-62},
              rotation=180),
            Rectangle(
              extent={{-46,2},{46,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={86,-18},
              rotation=90),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={78,26},
              rotation=180),
            Rectangle(
              extent={{-16,2},{16,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-68,-48},
              rotation=180),
            Rectangle(
              extent={{-52,2},{52,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-82,2},
              rotation=90),
            Rectangle(
              extent={{-9,2},{9,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-71},
              rotation=90),
            Rectangle(
              extent={{-7,2},{7,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-87,52},
              rotation=180),
            Rectangle(
              extent=DynamicSelect({{-56,6},{-6,66}},{{-56,6},{-6,6+60*hot_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1),
            Rectangle(
              extent=DynamicSelect({{18,-62},{72,-2}},{{18,-62},{72,-62+60*cold_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1)}));
    end Two_Tank_SHS_System_NTU_GMI_TempControl;

    model Two_Tank_SHS_System_NTU_GMI_TempControl_2
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Boiler_04 CS,
        redeclare replaceable ED_Dummy ED,
        redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
        replaceable package Storage_Medium =
          TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
          replaceable package Charging_Medium =
          Modelica.Media.Water.StandardWater                                       constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
          replaceable package Discharging_Medium =
          Modelica.Media.Water.StandardWater                                          constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
        parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.50;
        parameter Integer CHXnV = 5;
        parameter Modelica.Units.SI.Length tank_height = 15;

        input Modelica.Units.SI.Temperature Steam_Output_Temp annotation(Dialog(tab = "General"));
        output Boolean Charging_Trigger = hysteresis.y;

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
        tube_av_b=false,
        shell_av_b=false,
        use_derQ=data.DHX_Use_derQ,
        tau=data.DHX_tau,
        NTU=data.DHX_NTU,
        K_tube=data.DHX_K_tube,
        K_shell=data.DHX_K_shell,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Discharging_Medium,
        V_Tube=data.DHX_v_tube,
        V_Shell=data.DHX_v_shell,
        p_start_tube=data.DHX_p_start_tube,
        use_T_start_tube=true,
        T_start_tube_inlet=573.15,
        T_start_tube_outlet=573.15,
        h_start_tube_inlet=data.DHX_h_start_tube_inlet,
        h_start_tube_outlet=data.DHX_h_start_tube_outlet,
        p_start_shell=data.DHX_p_start_shell,
        h_start_shell_inlet=data.DHX_h_start_shell_inlet,
        h_start_shell_outlet=data.DHX_h_start_shell_outlet,
        dp_init_tube=data.DHX_dp_init_tube,
        dp_init_shell = data.DHX_dp_init_shell,
        Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={72,20})));
      TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium
          = Storage_Medium, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=data.ctvolume_volume))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-16})));
      Fluid.Valves.ValveLinear Discharging_Valve(
        redeclare package Medium = Storage_Medium,
        dp_nominal=data.disvalve_dp_nominal,
        m_flow_nominal=data.disvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={68,-42})));
      BaseClasses.DumpTank_Init_T      hot_tank(
        redeclare package Medium = Storage_Medium,
        A=data.ht_area,
        V0=data.ht_zero_level_volume,
        p_surface=data.ht_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ht_surface_pressure,
        level_start=data.ht_init_level,
        h_start=747e3,
        T_start=data.hot_tank_init_temp)
        annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

      TRANSFORM.Fluid.Machines.Pump discharge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.discharge_pump_volume,
        diameter=data.discharge_pump_diameter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.discharge_pump_rpm_nominal,
        diameter_nominal=data.discharge_pump_diameter_nominal,
        dp_nominal=data.discharge_pump_dp_nominal,
        m_flow_nominal=data.discharge_pump_m_flow_nominal,
        d_nominal=data.discharge_pump_rho_nominal,
        N_input=data.discharge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-76})));
      Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
            Discharging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
        redeclare package Medium = Storage_Medium,
        crossArea=data.ctdp_area,
        length=data.ctdp_length,
        dheight=data.ctdp_d_height) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=0,
            origin={12,44})));
      BaseClasses.DumpTank_Init_T      cold_tank(
        redeclare package Medium = Storage_Medium,
        A=data.cold_tank_area,
        V0=data.ct_zero_level_volume,
        p_surface=data.ct_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ct_surface_pressure,
        level_start=data.cold_tank_init_level,
        Use_T_Start=true,
        h_start=133e3,
        T_start=data.cold_tank_init_temp)
        annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
      TRANSFORM.Fluid.Machines.Pump charge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.charge_pump_volume,
        diameter=data.charge_pump_diamter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.charge_pump_rpm_nominal,
        diameter_nominal=data.charge_pump_diameter_nominal,
        dp_nominal=data.charge_pump_dp_nominal,
        m_flow_nominal=data.charge_pump_m_flow_nominal,
        d_nominal=data.charge_pump_rho_nominal,
        N_input=data.charge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-42,8})));
      Fluid.Valves.ValveLinear Charging_Valve(
        redeclare package Medium = Storage_Medium,
        allowFlowReversal=true,
        dp_nominal=data.chvalve_dp_nominal,
        m_flow_nominal=data.chvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-42,-20})));
      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

      Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
        annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
        annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=997)
        annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=1000 - hot_tank.level)
        annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
        annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
            Steam_Output_Temp)
        annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
        shell_av_b=true,
        use_derQ=true,
        tau=1,
        NTU=20,
        K_tube=1000,
        K_shell=1000,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Charging_Medium,
        V_Tube=10,
        V_Shell=25,
        use_T_start_tube=true,
        T_start_tube_inlet=573.15,
        T_start_tube_outlet=573.15,
        dp_init_tube=20000,
        Q_init=1)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-44,-54})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package
          Medium =
            Charging_Medium)                                                                           annotation (Placement(
            transformation(extent={{-108,-72},{-88,-52}}), iconTransformation(
              extent={{-108,-72},{-88,-52}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package
          Medium =
            Charging_Medium)                                                                            annotation (Placement(
            transformation(extent={{-108,44},{-88,64}}), iconTransformation(extent={
                {-108,44},{-88,64}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package
          Medium =
            Discharging_Medium)                                                                            annotation (Placement(
            transformation(extent={{88,48},{108,68}}), iconTransformation(extent={{88,
                48},{108,68}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_dch_b(redeclare package
          Medium =
            Discharging_Medium)                                                                             annotation (Placement(
            transformation(extent={{90,-72},{110,-52}}), iconTransformation(extent={
                {90,-72},{110,-52}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
          redeclare package Medium =
            Storage_Medium, R=100)
        annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
      Modelica.Blocks.Sources.RealExpression Coolant_Water_temp(y=sensor_T1.T)
        annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
      Modelica.Blocks.Sources.RealExpression Hot_Tank_Temp(y=hot_tank.T)
        annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{36,34},{56,54}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-86,6})));
      Modelica.Fluid.Sources.MassFlowSource_h boundary2(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_h_in=true,
        m_flow=m_flow_min,
        nPorts=1) annotation (Placement(transformation(extent={{-126,-182},{-106,
                -162}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
        delay1(Ti=0.5)
        annotation (Placement(transformation(extent={{-144,-170},{-136,-166}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank1(y=CHX.Shell.medium.h)
        annotation (Placement(transformation(extent={{-170,-178},{-150,-158}})));
      Modelica.Fluid.Sources.MassFlowSource_T boundary4(
        redeclare package Medium = Charging_Medium,
        use_m_flow_in=false,
        use_T_in=false,
        m_flow=-m_flow_min,
        T=413.15,
        nPorts=2) annotation (Placement(transformation(extent={{-168,-56},{-148,-36}})));
    equation
      connect(volume.port_a, Discharging_Valve.port_b)
        annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
      connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
              -96.4},{36,-102},{68,-102},{68,-86}},
                                           color={0,127,255}));
      connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                              color={0,127,255}));
      connect(cold_tank.port_b, charge_pump.port_a)
        annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
      connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
              {-42,-10}},
            color={0,127,255}));
      connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
              -42,44},{-42,40.4}},                                      color={0,
              127,255}));
      connect(discharge_pump.port_b, Discharging_Valve.port_a)
        annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,82},{128,82},{128,-100},{82,-100},{82,-42},{76,-42}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,114},{-81,114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,128},{-83,128}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
          points={{-30,100},{-81,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,86},{-81,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(hysteresis.u, Level_Hot_Tank2.y)
        annotation (Line(points={{-99.2,74},{-113,74}},  color={0,0,127}));
      connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,142},{-83,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
          points={{-30,100},{-30,74},{-85.4,74}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
          points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
              74,30}},                      color={0,127,255}));
      connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
              86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
      connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
              {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
      connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
              -79.6},{36,-76},{13,-76}},     color={0,127,255}));
      connect(CHX.Tube_out, sensor_T.port_a)
        annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                               color={0,127,255}));
      connect(sensor_T.port_b, resistance.port_a)
        annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
      connect(CHX.Shell_out, sensor_T1.port_b) annotation (Line(points={{-46,-44},{
              -46,-36},{-58,-36},{-58,-30}},           color={0,127,255}));
      connect(port_ch_a, CHX.Shell_in) annotation (Line(points={{-98,-62},{-76,-62},
              {-76,-64},{-46,-64}}, color={0,127,255}));
      connect(sensorBus.Coolant_Water_temp, Coolant_Water_temp.y) annotation (Line(
          points={{-30,100},{-32,100},{-32,86},{-47,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(cold_tank_dump_pipe.port_a, sensor_T2.port_a)
        annotation (Line(points={{22,44},{36,44}}, color={0,127,255}));
      connect(sensor_T2.port_b, DHX.Tube_out)
        annotation (Line(points={{56,44},{68,44},{68,30}}, color={0,127,255}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, sensor_T2.T) annotation (Line(
          points={{-30,100},{-4,100},{-4,66},{46,66},{46,47.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensor_m_flow.port_a, sensor_T1.port_a) annotation (Line(points={{-86,
              -4},{-86,-30},{-78,-30}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, port_ch_b) annotation (Line(points={{-86,16},{
              -88,16},{-88,54},{-98,54}}, color={0,127,255}));
      connect(sensorBus.ChargeSteam_mFlow, sensor_m_flow.m_flow) annotation (Line(
          points={{-30,100},{-30,62},{-80,62},{-80,24},{-102,24},{-102,6},{-89.6,6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(sensorBus.Hot_Tank_Temp, Hot_Tank_Temp.y) annotation (Line(
          points={{-30,100},{-30,124},{-47,124},{-47,106}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(CHX.Shell_in,boundary2. ports[1]) annotation (Line(points={{-46,-64},
              {-46,-150},{-100,-150},{-100,-172},{-106,-172}},
                                                       color={0,127,255}));
      connect(CHX.Shell_out,boundary4. ports[1]) annotation (Line(points={{-46,-44},
              {-46,-40},{-120,-40},{-120,-45.5},{-148,-45.5}},
                                          color={0,127,255}));
      annotation (experiment(
          StopTime=432000,
          Interval=37,
          __Dymola_Algorithm="Esdirk45a"), Icon(graphics={
            Ellipse(
              extent={{-56,70},{-6,60}},
              lineColor={175,175,175},
              lineThickness=1),
            Ellipse(
              extent={{-56,14},{-6,0}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-56,66},{-6,6}},
              lineColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1,
              fillColor={215,215,215}),
            Ellipse(
              extent={{18,-56},{72,-68}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{18,-2},{72,-62}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Ellipse(
              extent={{18,4},{72,-8}},
              lineColor={175,175,175},
              lineThickness=1),
            Rectangle(
              extent={{68,44},{24,18}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-8,-36},{-52,-62}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={255,85,85}),
            Rectangle(
              extent={{-6,18},{18,12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-41,3},{41,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-71,15},
              rotation=90),
            Rectangle(
              extent={{-30,3},{30,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-23},
              rotation=180),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-28},
              rotation=90),
            Rectangle(
              extent={{-9,3},{9,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-65,53},
              rotation=180),
            Rectangle(
              extent={{-18,-70},{10,-76}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-7,3},{7,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-69},
              rotation=90),
            Rectangle(
              extent={{4,-54},{18,-60}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-11,3},{11,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={7,-65},
              rotation=90),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={15,20},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={18,29},
              rotation=180),
            Rectangle(
              extent={{32,12},{82,6}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-17,3},{17,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={79,-5},
              rotation=90),
            Rectangle(
              extent={{-5,3},{5,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={77,-19},
              rotation=180),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-62,-70},
              rotation=90),
            Rectangle(
              extent={{-17,2},{17,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-77,-62},
              rotation=180),
            Rectangle(
              extent={{-11,2},{11,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-53,-78},
              rotation=180),
            Rectangle(
              extent={{-8,2},{8,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={56,52},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={35,12},
              rotation=90),
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={74,58},
              rotation=180),
            Rectangle(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={89,-62},
              rotation=180),
            Rectangle(
              extent={{-46,2},{46,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={86,-18},
              rotation=90),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={78,26},
              rotation=180),
            Rectangle(
              extent={{-16,2},{16,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-68,-48},
              rotation=180),
            Rectangle(
              extent={{-52,2},{52,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-82,2},
              rotation=90),
            Rectangle(
              extent={{-9,2},{9,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-71},
              rotation=90),
            Rectangle(
              extent={{-7,2},{7,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-87,52},
              rotation=180),
            Rectangle(
              extent=DynamicSelect({{-56,6},{-6,66}},{{-56,6},{-6,6+60*hot_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1),
            Rectangle(
              extent=DynamicSelect({{18,-62},{72,-2}},{{18,-62},{72,-62+60*cold_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1)}));
    end Two_Tank_SHS_System_NTU_GMI_TempControl_2;

    model Two_Tank_SHS_System_NTU_GMI_TempControl_2_new_pumps
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Boiler_04 CS,
        redeclare replaceable ED_Dummy ED,
        redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
        replaceable package Storage_Medium =
          TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
          replaceable package Charging_Medium =
          Modelica.Media.Water.StandardWater                                       constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
          replaceable package Discharging_Medium =
          Modelica.Media.Water.StandardWater                                          constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
        parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.50;
        parameter Integer CHXnV = 5;
        parameter Modelica.Units.SI.Length tank_height = 15;

        input Modelica.Units.SI.Temperature Steam_Output_Temp annotation(Dialog(tab = "General"));
        output Boolean Charging_Trigger = hysteresis.y;

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
        tube_av_b=false,
        shell_av_b=false,
        use_derQ=data.DHX_Use_derQ,
        tau=data.DHX_tau,
        NTU=data.DHX_NTU,
        K_tube=data.DHX_K_tube,
        K_shell=data.DHX_K_shell,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Discharging_Medium,
        V_Tube=data.DHX_v_tube,
        V_Shell=data.DHX_v_shell,
        p_start_tube=data.DHX_p_start_tube,
        use_T_start_tube=true,
        T_start_tube_inlet=573.15,
        T_start_tube_outlet=573.15,
        h_start_tube_inlet=data.DHX_h_start_tube_inlet,
        h_start_tube_outlet=data.DHX_h_start_tube_outlet,
        p_start_shell=data.DHX_p_start_shell,
        h_start_shell_inlet=data.DHX_h_start_shell_inlet,
        h_start_shell_outlet=data.DHX_h_start_shell_outlet,
        dp_init_tube=data.DHX_dp_init_tube,
        dp_init_shell = data.DHX_dp_init_shell,
        Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={72,20})));
      TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium
          = Storage_Medium, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=data.ctvolume_volume))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-16})));
      Fluid.Valves.ValveLinear Discharging_Valve(
        redeclare package Medium = Storage_Medium,
        dp_nominal=data.disvalve_dp_nominal,
        m_flow_nominal=data.disvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={68,-42})));
      BaseClasses.DumpTank_Init_T      hot_tank(
        redeclare package Medium = Storage_Medium,
        A=data.ht_area,
        V0=data.ht_zero_level_volume,
        p_surface=data.ht_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ht_surface_pressure,
        level_start=data.ht_init_level,
        h_start=747e3,
        T_start=data.hot_tank_init_temp)
        annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

      TRANSFORM.Fluid.Machines.Pump discharge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.discharge_pump_volume,
        diameter=data.discharge_pump_diameter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,0.5*(data.discharge_pump_m_flow_nominal/data.discharge_pump_rho_nominal),
                (data.discharge_pump_m_flow_nominal/data.discharge_pump_rho_nominal)},
              head_curve={(data.discharge_pump_dp_nominal/(9.81*data.discharge_pump_rho_nominal)),
                (data.discharge_pump_dp_nominal/(9.81*data.discharge_pump_rho_nominal))
                *0.4,0}),
        N_nominal=data.discharge_pump_rpm_nominal,
        diameter_nominal=data.discharge_pump_diameter_nominal,
        dp_nominal=data.discharge_pump_dp_nominal,
        m_flow_nominal=data.discharge_pump_m_flow_nominal,
        d_nominal=data.discharge_pump_rho_nominal,
        N_input=data.discharge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-76})));
      Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
            Discharging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
        redeclare package Medium = Storage_Medium,
        crossArea=data.ctdp_area,
        length=data.ctdp_length,
        dheight=data.ctdp_d_height) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=0,
            origin={12,44})));
      BaseClasses.DumpTank_Init_T      cold_tank(
        redeclare package Medium = Storage_Medium,
        A=data.cold_tank_area,
        V0=data.ct_zero_level_volume,
        p_surface=data.ct_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ct_surface_pressure,
        level_start=data.cold_tank_init_level,
        Use_T_Start=true,
        h_start=133e3,
        T_start=data.cold_tank_init_temp)
        annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
      TRANSFORM.Fluid.Machines.Pump charge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.charge_pump_volume,
        diameter=data.charge_pump_diamter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,0.5*(data.charge_pump_m_flow_nominal/data.charge_pump_rho_nominal),
                (data.charge_pump_m_flow_nominal/data.charge_pump_rho_nominal)},
              head_curve={(data.charge_pump_dp_nominal/(9.81*data.charge_pump_rho_nominal)),
                (data.charge_pump_dp_nominal/(9.81*data.charge_pump_rho_nominal))*
                0.4,0}),
        N_nominal=data.charge_pump_rpm_nominal,
        diameter_nominal=data.charge_pump_diameter_nominal,
        dp_nominal=data.charge_pump_dp_nominal,
        m_flow_nominal=data.charge_pump_m_flow_nominal,
        d_nominal=data.charge_pump_rho_nominal,
        N_input=data.charge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-42,8})));
      Fluid.Valves.ValveLinear Charging_Valve(
        redeclare package Medium = Storage_Medium,
        allowFlowReversal=true,
        dp_nominal=data.chvalve_dp_nominal,
        m_flow_nominal=data.chvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-42,-20})));
      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

      Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
        annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
        annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=3, uHigh=997)
        annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=1000 - hot_tank.level)
        annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
        annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
            Steam_Output_Temp)
        annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
        shell_av_b=true,
        use_derQ=true,
        tau=1,
        NTU=20,
        K_tube=1000,
        K_shell=1000,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Charging_Medium,
        V_Tube=10,
        V_Shell=25,
        use_T_start_tube=true,
        T_start_tube_inlet=573.15,
        T_start_tube_outlet=573.15,
        dp_init_tube=20000,
        Q_init=1)          annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-44,-54})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package
          Medium =
            Charging_Medium)                                                                           annotation (Placement(
            transformation(extent={{-108,-72},{-88,-52}}), iconTransformation(
              extent={{-108,-72},{-88,-52}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package
          Medium =
            Charging_Medium)                                                                            annotation (Placement(
            transformation(extent={{-108,44},{-88,64}}), iconTransformation(extent={
                {-108,44},{-88,64}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package
          Medium =
            Discharging_Medium)                                                                            annotation (Placement(
            transformation(extent={{88,48},{108,68}}), iconTransformation(extent={{88,
                48},{108,68}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_dch_b(redeclare package
          Medium =
            Discharging_Medium)                                                                             annotation (Placement(
            transformation(extent={{90,-72},{110,-52}}), iconTransformation(extent={
                {90,-72},{110,-52}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
          redeclare package Medium =
            Storage_Medium, R=100)
        annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
      Modelica.Blocks.Sources.RealExpression Coolant_Water_temp(y=sensor_T1.T)
        annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
      Modelica.Blocks.Sources.RealExpression Hot_Tank_Temp(y=hot_tank.T)
        annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{36,34},{56,54}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-86,6})));
    equation
      connect(volume.port_a, Discharging_Valve.port_b)
        annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
      connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
              -96.4},{36,-102},{68,-102},{68,-86}},
                                           color={0,127,255}));
      connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                              color={0,127,255}));
      connect(cold_tank.port_b, charge_pump.port_a)
        annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
      connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
              {-42,-10}},
            color={0,127,255}));
      connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
              -42,44},{-42,40.4}},                                      color={0,
              127,255}));
      connect(discharge_pump.port_b, Discharging_Valve.port_a)
        annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,82},{128,82},{128,-100},{82,-100},{82,-42},{76,-42}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,114},{-81,114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,128},{-83,128}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
          points={{-30,100},{-81,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,86},{-81,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(hysteresis.u, Level_Hot_Tank2.y)
        annotation (Line(points={{-99.2,74},{-113,74}},  color={0,0,127}));
      connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,142},{-83,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
          points={{-30,100},{-30,74},{-85.4,74}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
          points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
              74,30}},                      color={0,127,255}));
      connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
              86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
      connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
              {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
      connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
              -79.6},{36,-76},{13,-76}},     color={0,127,255}));
      connect(CHX.Tube_out, sensor_T.port_a)
        annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                               color={0,127,255}));
      connect(sensor_T.port_b, resistance.port_a)
        annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
      connect(CHX.Shell_out, sensor_T1.port_b) annotation (Line(points={{-46,-44},{
              -46,-36},{-58,-36},{-58,-30}},           color={0,127,255}));
      connect(port_ch_a, CHX.Shell_in) annotation (Line(points={{-98,-62},{-76,-62},
              {-76,-64},{-46,-64}}, color={0,127,255}));
      connect(sensorBus.Coolant_Water_temp, Coolant_Water_temp.y) annotation (Line(
          points={{-30,100},{-32,100},{-32,86},{-47,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(cold_tank_dump_pipe.port_a, sensor_T2.port_a)
        annotation (Line(points={{22,44},{36,44}}, color={0,127,255}));
      connect(sensor_T2.port_b, DHX.Tube_out)
        annotation (Line(points={{56,44},{68,44},{68,30}}, color={0,127,255}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, sensor_T2.T) annotation (Line(
          points={{-30,100},{-4,100},{-4,66},{46,66},{46,47.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensor_m_flow.port_a, sensor_T1.port_a) annotation (Line(points={{-86,
              -4},{-86,-30},{-78,-30}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, port_ch_b) annotation (Line(points={{-86,16},{
              -88,16},{-88,54},{-98,54}}, color={0,127,255}));
      connect(sensorBus.ChargeSteam_mFlow, sensor_m_flow.m_flow) annotation (Line(
          points={{-30,100},{-30,62},{-80,62},{-80,24},{-102,24},{-102,6},{-89.6,6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(sensorBus.Hot_Tank_Temp, Hot_Tank_Temp.y) annotation (Line(
          points={{-30,100},{-30,124},{-47,124},{-47,106}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (experiment(
          StopTime=432000,
          Interval=37,
          __Dymola_Algorithm="Esdirk45a"), Icon(graphics={
            Ellipse(
              extent={{-56,70},{-6,60}},
              lineColor={175,175,175},
              lineThickness=1),
            Ellipse(
              extent={{-56,14},{-6,0}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-56,66},{-6,6}},
              lineColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1,
              fillColor={215,215,215}),
            Ellipse(
              extent={{18,-56},{72,-68}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{18,-2},{72,-62}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Ellipse(
              extent={{18,4},{72,-8}},
              lineColor={175,175,175},
              lineThickness=1),
            Rectangle(
              extent={{68,44},{24,18}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-8,-36},{-52,-62}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={255,85,85}),
            Rectangle(
              extent={{-6,18},{18,12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-41,3},{41,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-71,15},
              rotation=90),
            Rectangle(
              extent={{-30,3},{30,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-23},
              rotation=180),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-28},
              rotation=90),
            Rectangle(
              extent={{-9,3},{9,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-65,53},
              rotation=180),
            Rectangle(
              extent={{-18,-70},{10,-76}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-7,3},{7,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-69},
              rotation=90),
            Rectangle(
              extent={{4,-54},{18,-60}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-11,3},{11,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={7,-65},
              rotation=90),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={15,20},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={18,29},
              rotation=180),
            Rectangle(
              extent={{32,12},{82,6}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-17,3},{17,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={79,-5},
              rotation=90),
            Rectangle(
              extent={{-5,3},{5,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={77,-19},
              rotation=180),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-62,-70},
              rotation=90),
            Rectangle(
              extent={{-17,2},{17,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-77,-62},
              rotation=180),
            Rectangle(
              extent={{-11,2},{11,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-53,-78},
              rotation=180),
            Rectangle(
              extent={{-8,2},{8,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={56,52},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={35,12},
              rotation=90),
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={74,58},
              rotation=180),
            Rectangle(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={89,-62},
              rotation=180),
            Rectangle(
              extent={{-46,2},{46,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={86,-18},
              rotation=90),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={78,26},
              rotation=180),
            Rectangle(
              extent={{-16,2},{16,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-68,-48},
              rotation=180),
            Rectangle(
              extent={{-52,2},{52,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-82,2},
              rotation=90),
            Rectangle(
              extent={{-9,2},{9,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-71},
              rotation=90),
            Rectangle(
              extent={{-7,2},{7,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-87,52},
              rotation=180),
            Rectangle(
              extent=DynamicSelect({{-56,6},{-6,66}},{{-56,6},{-6,6+60*hot_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1),
            Rectangle(
              extent=DynamicSelect({{18,-62},{72,-2}},{{18,-62},{72,-62+60*cold_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1)}));
    end Two_Tank_SHS_System_NTU_GMI_TempControl_2_new_pumps;

    model
      Two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks_DirectCoupling_HTGR
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Boiler_04 CS,
        redeclare replaceable ED_Dummy ED,
        redeclare replaceable Data.Data_SHS data(DHX_v_shell=1.0));
        replaceable package Storage_Medium =
          TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
          replaceable package Charging_Medium =
          Modelica.Media.Water.StandardWater                                       constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
          replaceable package Discharging_Medium =
          Modelica.Media.Water.StandardWater                                          constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab=
              "General",
            group="Mediums"), choicesAllMatching=true);
        parameter Modelica.Units.SI.MassFlowRate m_flow_min = 2.50;
        parameter Integer CHXnV = 5;
        parameter Modelica.Units.SI.Length tank_height = 15;

        input Modelica.Units.SI.Temperature Steam_Output_Temp annotation(Dialog(tab = "General"));
        output Boolean Charging_Trigger = hysteresis.y;

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
        tube_av_b=false,
        shell_av_b=false,
        use_derQ=data.DHX_Use_derQ,
        tau=data.DHX_tau,
        NTU=data.DHX_NTU,
        K_tube=data.DHX_K_tube,
        K_shell=data.DHX_K_shell,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Discharging_Medium,
        V_Tube=data.DHX_v_tube,
        V_Shell=data.DHX_v_shell,
        p_start_tube=data.DHX_p_start_tube,
        use_T_start_tube=true,
        T_start_tube_inlet=573.15,
        T_start_tube_outlet=573.15,
        h_start_tube_inlet=data.DHX_h_start_tube_inlet,
        h_start_tube_outlet=data.DHX_h_start_tube_outlet,
        p_start_shell=data.DHX_p_start_shell,
        h_start_shell_inlet=data.DHX_h_start_shell_inlet,
        h_start_shell_outlet=data.DHX_h_start_shell_outlet,
        dp_init_tube=data.DHX_dp_init_tube,
        dp_init_shell = data.DHX_dp_init_shell,
        Q_init=data.DHX_Q_init)          annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={72,20})));
      TRANSFORM.Fluid.Volumes.SimpleVolume     volume(redeclare package Medium
          = Storage_Medium, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=data.ctvolume_volume))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-16})));
      Fluid.Valves.ValveLinear Discharging_Valve(
        redeclare package Medium = Storage_Medium,
        dp_nominal=data.disvalve_dp_nominal,
        m_flow_nominal=data.disvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={68,-42})));
      BaseClasses.DumpTank_Init_T      hot_tank(
        redeclare package Medium = Storage_Medium,
        A=data.ht_area,
        V0=data.ht_zero_level_volume,
        p_surface=data.ht_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ht_surface_pressure,
        level_start=data.ht_init_level,
        h_start=747e3,
        T_start=data.hot_tank_init_temp)
        annotation (Placement(transformation(extent={{26,-98},{46,-78}})));

      TRANSFORM.Fluid.Machines.Pump discharge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.discharge_pump_volume,
        diameter=data.discharge_pump_diameter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.discharge_pump_rpm_nominal,
        diameter_nominal=data.discharge_pump_diameter_nominal,
        dp_nominal=data.discharge_pump_dp_nominal,
        m_flow_nominal=data.discharge_pump_m_flow_nominal,
        d_nominal=data.discharge_pump_rho_nominal,
        N_input=data.discharge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={68,-76})));
      Modelica.Blocks.Sources.RealExpression Discharge_Mass_Flow(y=
            Discharging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,104},{-82,124}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
        redeclare package Medium = Storage_Medium,
        crossArea=data.ctdp_area,
        length=data.ctdp_length,
        dheight=data.ctdp_d_height) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=0,
            origin={12,44})));
      BaseClasses.DumpTank_Init_T      cold_tank(
        redeclare package Medium = Storage_Medium,
        A=data.cold_tank_area,
        V0=data.ct_zero_level_volume,
        p_surface=data.ct_surface_pressure,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        p_start=data.ct_surface_pressure,
        level_start=data.cold_tank_init_level,
        Use_T_Start=true,
        h_start=133e3,
        T_start=data.cold_tank_init_temp)
        annotation (Placement(transformation(extent={{-52,22},{-32,42}})));
      TRANSFORM.Fluid.Machines.Pump charge_pump(
        redeclare package Medium = Storage_Medium,
        V=data.charge_pump_volume,
        diameter=data.charge_pump_diamter,
        redeclare model FlowChar =
            TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models.Head.PerformanceCurve
            (V_flow_curve={0,1,2}, head_curve={20,8,0}),
        N_nominal=data.charge_pump_rpm_nominal,
        diameter_nominal=data.charge_pump_diameter_nominal,
        dp_nominal=data.charge_pump_dp_nominal,
        m_flow_nominal=data.charge_pump_m_flow_nominal,
        d_nominal=data.charge_pump_rho_nominal,
        N_input=data.charge_pump_constantRPM)
                      annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-42,8})));
      Fluid.Valves.ValveLinear Charging_Valve(
        redeclare package Medium = Storage_Medium,
        allowFlowReversal=true,
        dp_nominal=data.chvalve_dp_nominal,
        m_flow_nominal=data.chvalve_m_flow_nom)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-42,-20})));
      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=Charging_Valve.m_flow)
        annotation (Placement(transformation(extent={{-102,76},{-82,96}})));

      Modelica.Blocks.Sources.RealExpression Level_Cold_Tank(y=cold_tank.level)
        annotation (Placement(transformation(extent={{-102,90},{-82,110}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank(y=hot_tank.level)
        annotation (Placement(transformation(extent={{-104,118},{-84,138}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=0.7, uHigh=11)
        annotation (Placement(transformation(extent={{-98,80},{-86,68}})));
      Modelica.Blocks.Sources.RealExpression Level_Hot_Tank2(y=11.7 - hot_tank.level)
        annotation (Placement(transformation(extent={{-134,64},{-114,84}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature(y=sensor_T.T)
        annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
      Modelica.Blocks.Sources.RealExpression Charging_Temperature1(y=
            Steam_Output_Temp)
        annotation (Placement(transformation(extent={{-30,130},{-50,150}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase CHX(
        shell_av_b=true,
        use_derQ=true,
        tau=1,
        NTU=20,
        K_tube=1000,
        K_shell=1000,
        redeclare package Tube_medium = Storage_Medium,
        redeclare package Shell_medium = Charging_Medium,
        V_Tube=10,
        V_Shell=25,
        use_T_start_tube=true,
        T_start_tube_inlet=573.15,
        T_start_tube_outlet=573.15,
        p_start_shell=14000000,
        use_T_start_shell=true,
        T_start_shell_inlet=813.15,
        T_start_shell_outlet=481.15,
        dp_init_tube=20000,
        Q_init=1,
        m_start_shell=50)  annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-44,-54})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_ch_a(redeclare package
          Medium =
            Charging_Medium)                                                                           annotation (Placement(
            transformation(extent={{-108,-80},{-88,-60}}), iconTransformation(
              extent={{-108,-80},{-88,-60}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_ch_b(redeclare package
          Medium =
            Charging_Medium)                                                                            annotation (Placement(
            transformation(extent={{-124,44},{-104,64}}),iconTransformation(extent={{-124,44},
                {-104,64}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_dch_a(redeclare package
          Medium =
            Discharging_Medium)                                                                            annotation (Placement(
            transformation(extent={{88,48},{108,68}}), iconTransformation(extent={{88,
                48},{108,68}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_dch_b(redeclare package
          Medium =
            Discharging_Medium)                                                                             annotation (Placement(
            transformation(extent={{90,-72},{110,-52}}), iconTransformation(extent={
                {90,-72},{110,-52}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
          redeclare package Medium =
            Storage_Medium, R=100)
        annotation (Placement(transformation(extent={{-4,-86},{16,-66}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{-34,-86},{-14,-66}})));
      Modelica.Blocks.Sources.RealExpression Coolant_Water_temp(y=sensor_T1.T)
        annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
      Modelica.Blocks.Sources.RealExpression Hot_Tank_Temp(y=hot_tank.T)
        annotation (Placement(transformation(extent={{-68,96},{-48,116}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
          Medium =
            Storage_Medium)
        annotation (Placement(transformation(extent={{36,34},{56,54}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-86,6})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-176,26},{-156,46}})));
      TRANSFORM.Fluid.Valves.ValveLinear PRV(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=400)                  annotation (Placement(transformation(
            extent={{-8,8},{8,-8}},
            rotation=180,
            origin={-136,36})));
      TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
            Modelica.Media.Water.StandardWater, redeclare function iconUnit =
            TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                           annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-60,-50})));
    equation
      connect(volume.port_a, Discharging_Valve.port_b)
        annotation (Line(points={{68,-22},{68,-32}},   color={0,127,255}));
      connect(hot_tank.port_b, discharge_pump.port_a) annotation (Line(points={{36,
              -96.4},{36,-102},{68,-102},{68,-86}},
                                           color={0,127,255}));
      connect(volume.port_b, DHX.Tube_in) annotation (Line(points={{68,-10},{68,10}},
                              color={0,127,255}));
      connect(cold_tank.port_b, charge_pump.port_a)
        annotation (Line(points={{-42,23.6},{-42,18}},color={0,127,255}));
      connect(charge_pump.port_b, Charging_Valve.port_a) annotation (Line(points={{-42,-2},
              {-42,-10}},
            color={0,127,255}));
      connect(cold_tank_dump_pipe.port_b, cold_tank.port_a) annotation (Line(points={{2,44},{
              -42,44},{-42,40.4}},                                      color={0,
              127,255}));
      connect(discharge_pump.port_b, Discharging_Valve.port_a)
        annotation (Line(points={{68,-66},{68,-52}}, color={0,127,255}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,60},{-72,60},{-72,-20},{-50,-20}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve.opening)
        annotation (Line(
          points={{30,100},{30,82},{128,82},{128,-100},{82,-100},{82,-42},{76,-42}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.discharge_m_flow, Discharge_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,114},{-81,114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, Level_Hot_Tank.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,128},{-83,128}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level,Level_Cold_Tank. y) annotation (Line(
          points={{-30,100},{-81,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,86},{-81,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(hysteresis.u, Level_Hot_Tank2.y)
        annotation (Line(points={{-99.2,74},{-113,74}},  color={0,0,127}));
      connect(sensorBus.Charge_Temp, Charging_Temperature.y) annotation (Line(
          points={{-30,100},{-76,100},{-76,142},{-83,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, hysteresis.y) annotation (Line(
          points={{-30,100},{-30,74},{-85.4,74}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, Charging_Temperature1.y) annotation (Line(
          points={{-30,100},{-30,114},{-58,114},{-58,140},{-51,140}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(port_dch_a, DHX.Shell_in) annotation (Line(points={{98,58},{74,58},{
              74,30}},                      color={0,127,255}));
      connect(DHX.Shell_out, port_dch_b) annotation (Line(points={{74,10},{74,-4},{
              86,-4},{86,-40},{94,-40},{94,-62},{100,-62}},    color={0,127,255}));
      connect(CHX.Tube_in, Charging_Valve.port_b) annotation (Line(points={{-40,-44},
              {-40,-38},{-42,-38},{-42,-30}}, color={0,127,255}));
      connect(hot_tank.port_a, resistance.port_b) annotation (Line(points={{36,
              -79.6},{36,-76},{13,-76}},     color={0,127,255}));
      connect(CHX.Tube_out, sensor_T.port_a)
        annotation (Line(points={{-40,-64},{-40,-76},{-34,-76}},
                                                               color={0,127,255}));
      connect(sensor_T.port_b, resistance.port_a)
        annotation (Line(points={{-14,-76},{-1,-76}},         color={0,127,255}));
      connect(CHX.Shell_out, sensor_T1.port_b) annotation (Line(points={{-46,-44},{
              -46,-36},{-58,-36},{-58,-30}},           color={0,127,255}));
      connect(port_ch_a, CHX.Shell_in) annotation (Line(points={{-98,-70},{-76,-70},
              {-76,-64},{-46,-64}}, color={0,127,255}));
      connect(sensorBus.Coolant_Water_temp, Coolant_Water_temp.y) annotation (Line(
          points={{-30,100},{-32,100},{-32,86},{-47,86}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(cold_tank_dump_pipe.port_a, sensor_T2.port_a)
        annotation (Line(points={{22,44},{36,44}}, color={0,127,255}));
      connect(sensor_T2.port_b, DHX.Tube_out)
        annotation (Line(points={{56,44},{68,44},{68,30}}, color={0,127,255}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, sensor_T2.T) annotation (Line(
          points={{-30,100},{-4,100},{-4,66},{46,66},{46,47.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensor_m_flow.port_a, sensor_T1.port_a) annotation (Line(points={{-86,
              -4},{-86,-30},{-78,-30}}, color={0,127,255}));
      connect(sensorBus.ChargeSteam_mFlow, sensor_m_flow.m_flow) annotation (Line(
          points={{-30,100},{-30,62},{-80,62},{-80,24},{-102,24},{-102,6},{-89.6,6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(sensorBus.Hot_Tank_Temp, Hot_Tank_Temp.y) annotation (Line(
          points={{-30,100},{-30,124},{-47,124},{-47,106}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.TBV,PRV. opening) annotation (Line(
          points={{30,100},{-136,100},{-136,42.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(PRV.port_a, CHX.Shell_in) annotation (Line(points={{-128,36},{-118,36},
              {-118,-12},{-142,-12},{-142,-50},{-72,-50},{-72,-64},{-46,-64}},
            color={0,127,255}));
      connect(boundary.ports[1], PRV.port_b)
        annotation (Line(points={{-156,36},{-144,36}}, color={0,127,255}));
      connect(sensorBus.Steam_Pressure,sensor_p. p) annotation (Line(
          points={{-30,100},{-30,-50},{-66,-50}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensor_p.port, CHX.Shell_in) annotation (Line(points={{-60,-60},{-60,
              -64},{-46,-64}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, port_ch_b)
        annotation (Line(points={{-86,16},{-86,54},{-114,54}}, color={0,127,255}));
      annotation (experiment(
          StopTime=432000,
          Interval=37,
          __Dymola_Algorithm="Esdirk45a"), Icon(graphics={
            Ellipse(
              extent={{-56,70},{-6,60}},
              lineColor={175,175,175},
              lineThickness=1),
            Ellipse(
              extent={{-56,14},{-6,0}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-56,66},{-6,6}},
              lineColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1,
              fillColor={215,215,215}),
            Ellipse(
              extent={{18,-56},{72,-68}},
              lineColor={175,175,175},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{18,-2},{72,-62}},
              lineColor={175,175,175},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Ellipse(
              extent={{18,4},{72,-8}},
              lineColor={175,175,175},
              lineThickness=1),
            Rectangle(
              extent={{68,44},{24,18}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={0,128,255}),
            Rectangle(
              extent={{-8,-36},{-52,-62}},
              lineColor={175,175,175},
              lineThickness=1,
              fillPattern=FillPattern.CrossDiag,
              fillColor={255,85,85}),
            Rectangle(
              extent={{-6,18},{18,12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-41,3},{41,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-71,15},
              rotation=90),
            Rectangle(
              extent={{-30,3},{30,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-23},
              rotation=180),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-28},
              rotation=90),
            Rectangle(
              extent={{-9,3},{9,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-65,53},
              rotation=180),
            Rectangle(
              extent={{-18,-70},{10,-76}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-7,3},{7,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-15,-69},
              rotation=90),
            Rectangle(
              extent={{4,-54},{18,-60}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-11,3},{11,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={7,-65},
              rotation=90),
            Rectangle(
              extent={{-8,3},{8,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={15,20},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={18,29},
              rotation=180),
            Rectangle(
              extent={{32,12},{82,6}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-17,3},{17,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={79,-5},
              rotation=90),
            Rectangle(
              extent={{-5,3},{5,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={77,-19},
              rotation=180),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-62,-70},
              rotation=90),
            Rectangle(
              extent={{-17,2},{17,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-77,-62},
              rotation=180),
            Rectangle(
              extent={{-11,2},{11,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-53,-78},
              rotation=180),
            Rectangle(
              extent={{-8,2},{8,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={56,52},
              rotation=90),
            Rectangle(
              extent={{-6,3},{6,-3}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={35,12},
              rotation=90),
            Rectangle(
              extent={{-20,2},{20,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={74,58},
              rotation=180),
            Rectangle(
              extent={{-5,2},{5,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={89,-62},
              rotation=180),
            Rectangle(
              extent={{-46,2},{46,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={86,-18},
              rotation=90),
            Rectangle(
              extent={{-10,2},{10,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={78,26},
              rotation=180),
            Rectangle(
              extent={{-16,2},{16,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-68,-48},
              rotation=180),
            Rectangle(
              extent={{-52,2},{52,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-82,2},
              rotation=90),
            Rectangle(
              extent={{-9,2},{9,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={170,255,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-44,-71},
              rotation=90),
            Rectangle(
              extent={{-7,2},{7,-2}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={85,170,255},
              fillPattern=FillPattern.HorizontalCylinder,
              origin={-87,52},
              rotation=180),
            Rectangle(
              extent=DynamicSelect({{-56,6},{-6,66}},{{-56,6},{-6,6+60*hot_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1),
            Rectangle(
              extent=DynamicSelect({{18,-62},{72,-2}},{{18,-62},{72,-62+60*cold_tank.level/tank_height}}),
              lineColor={175,175,175},
              fillColor={85,85,255},
              fillPattern=FillPattern.HorizontalCylinder,
              lineThickness=1)}));
    end Two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks_DirectCoupling_HTGR;
  end Components;

  package Data

    model Data_Dummy

      extends BaseClasses.Record_Data;

      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_Dummy;

    model Data_Default

      extends BaseClasses.Record_Data;
      parameter Modelica.Units.SI.Length hot_tank_level_max = 15;
      parameter Modelica.Units.SI.Length cold_tank_level_max = 15;
      parameter Modelica.Units.SI.Temperature hot_tank_ref_temp = 273.15+245;
      parameter Modelica.Units.SI.Temperature cold_tank_ref_temp = 273.15+160;

      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_Default;

    model Data_CS

      extends BaseClasses.Record_Data;
      parameter Modelica.Units.SI.Length hot_tank_level_min = 1.0;
      parameter Modelica.Units.SI.Length cold_tank_level_min = 1.0;
      parameter Modelica.Units.SI.Temperature hot_tank_ref_temp = 273.15+245;
      parameter Modelica.Units.SI.Temperature cold_tank_ref_temp = 273.15+160;
      parameter Modelica.Units.SI.MassFlowRate steam_prod_rate = 2.5;
      parameter Modelica.Units.SI.MassFlowRate reference_charging_m_flow = 20;
      parameter Modelica.Units.SI.MassFlowRate reference_discharging_m_flow = 10;
      parameter Real discharge_control_ref_value = 100 "Change this value based on what control is based on. For temperature, make sure to enter in K";

      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_CS;

    model Data_SHS

      extends BaseClasses.Record_Data;
      parameter Modelica.Units.SI.Length ht_level_max = 15 annotation(Dialog(group = "Hot Tank"));
      parameter Modelica.Units.SI.Area ht_area = 50 annotation(Dialog(group = "Hot Tank"));
      parameter Modelica.Units.SI.Volume ht_zero_level_volume = 1 annotation(Dialog(group = "Hot Tank"));
      parameter Modelica.Units.SI.Pressure ht_surface_pressure = 101325 annotation(Dialog(group = "Hot Tank"));
      parameter Modelica.Units.SI.Length ht_init_level = ht_level_max*0.5 annotation(Dialog(tab = "Initialization", group = "Hot Tank"));
      parameter Modelica.Units.SI.Temperature hot_tank_init_temp = 273.15+240 annotation(Dialog(tab = "Initialization", group = "Hot Tank"));
      parameter Modelica.Units.SI.Length cold_tank_level_max = 15 annotation(Dialog(group = "Cold Tank"));
      parameter Modelica.Units.SI.Area cold_tank_area = 50 annotation(Dialog(group = "Cold Tank"));
      parameter Modelica.Units.SI.Volume ct_zero_level_volume = 1 annotation(Dialog(group = "Cold Tank"));
      parameter Modelica.Units.SI.Pressure ct_surface_pressure = 101325 annotation(Dialog(group = "Cold Tank"));
      parameter Modelica.Units.SI.Length cold_tank_init_level = ht_level_max*0.5 annotation(Dialog(tab = "Initialization", group = "Cold Tank"));
      parameter Modelica.Units.SI.Temperature cold_tank_init_temp = 273.15+240 annotation(Dialog(tab = "Initialization", group = "Cold Tank"));
      parameter Modelica.Units.SI.MassFlowRate m_flow_ch_min = 2.0;
      parameter Integer CHXnV = 5 "Number of nodes in CHX" annotation(Dialog(tab = "Heat Exchangers", group = "CHX"));
      parameter Real DHX_NTU = 4.0 "DHX NTU value" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
      parameter Boolean DHX_Use_derQ = true annotation (Evaluate = true,
                    Dialog(enable = use_derQ, tab = "Heat Exchangers", group = "DHX"));
      parameter Modelica.Units.SI.Time DHX_tau = 1.0 annotation(Dialog(tab="Heat Exchangers", group = "DHX"));
      parameter Real DHX_K_tube(unit = "1/m4") = 100 "Pressure drop coefficient" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
      parameter Real DHX_K_shell(unit = "1/m4") = 100 "Pressure drop coefficient" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
      parameter Modelica.Units.SI.Volume DHX_v_tube = 10 "Tube side (SHS side) volume" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));
      parameter Modelica.Units.SI.Volume DHX_v_shell = 10 "Shell side volume" annotation(Dialog(tab = "Heat Exchangers", group = "DHX"));

      parameter Modelica.Units.SI.Pressure DHX_p_start_tube = 100000 annotation(Dialog(tab = "Initialization", group = "DHX"));
      parameter Modelica.Units.SI.Pressure DHX_dp_init_tube = 1000 annotation(Dialog(tab = "Initialization", group = "DHX"));
      parameter Modelica.Units.SI.SpecificEnthalpy DHX_h_start_tube_inlet = 300e3 annotation(Dialog(tab = "Initialization", group = "DHX"));
      parameter Modelica.Units.SI.SpecificEnthalpy DHX_h_start_tube_outlet = 100e3 annotation(Dialog(tab = "Initialization", group = "DHX"));
      parameter Modelica.Units.SI.Pressure DHX_p_start_shell = 5e5 annotation(Dialog(tab = "Initialization", group = "DHX"));
      parameter Modelica.Units.SI.Pressure DHX_dp_init_shell = 1000 annotation(Dialog(tab = "Initialization", group = "DHX"));
      parameter Modelica.Units.SI.SpecificEnthalpy DHX_h_start_shell_inlet = 1400e3 annotation(Dialog(tab = "Initialization", group = "DHX"));
      parameter Modelica.Units.SI.SpecificEnthalpy DHX_h_start_shell_outlet = 2000e3 annotation(Dialog(tab = "Initialization", group = "DHX"));
      parameter Modelica.Units.SI.Power DHX_Q_init = 1 "Do not set to 0" annotation(Dialog(tab = "Initialization", group = "DHX"));

      parameter Modelica.Units.SI.Volume discharge_pump_volume = 1 annotation(Dialog(tab = "Pumps", group = "Discharge"));
      parameter Modelica.Units.SI.Length discharge_pump_diameter = 0.5  annotation(Dialog(tab = "Pumps", group = "Discharge"));
      parameter Modelica.Units.NonSI.AngularVelocity_rpm discharge_pump_rpm_nominal = 1500  annotation(Dialog(tab = "Pumps", group = "Discharge"));
      parameter Modelica.Units.SI.Length discharge_pump_diameter_nominal = 0.5  annotation(Dialog(tab = "Pumps", group = "Discharge"));
      parameter Modelica.Units.SI.Pressure discharge_pump_dp_nominal = 2e5  annotation(Dialog(tab = "Pumps", group = "Discharge"));
      parameter Modelica.Units.SI.MassFlowRate discharge_pump_m_flow_nominal = 10  annotation(Dialog(tab = "Pumps", group = "Discharge"));
      parameter Modelica.Units.SI.Density discharge_pump_rho_nominal = 1  annotation(Dialog(tab = "Pumps", group = "Discharge"));
      parameter Modelica.Units.NonSI.AngularVelocity_rpm discharge_pump_constantRPM = 1500  annotation(Dialog(tab = "Pumps", group = "Discharge"));

      parameter Modelica.Units.SI.Volume charge_pump_volume = 1 annotation(Dialog(tab = "Pumps", group = "Charge"));
      parameter Modelica.Units.SI.Length charge_pump_diamter = 0.5  annotation(Dialog(tab = "Pumps", group = "Charge"));
      parameter Modelica.Units.NonSI.AngularVelocity_rpm charge_pump_rpm_nominal = 1500  annotation(Dialog(tab = "Pumps", group = "Charge"));
      parameter Modelica.Units.SI.Length charge_pump_diameter_nominal = 0.5  annotation(Dialog(tab = "Pumps", group = "Charge"));
      parameter Modelica.Units.SI.Pressure charge_pump_dp_nominal = 7e5  annotation(Dialog(tab = "Pumps", group = "Charge"));
      parameter Modelica.Units.SI.MassFlowRate charge_pump_m_flow_nominal = 20  annotation(Dialog(tab = "Pumps", group = "Charge"));
      parameter Modelica.Units.SI.Density charge_pump_rho_nominal = 1  annotation(Dialog(tab = "Pumps", group = "Charge"));
      parameter Modelica.Units.NonSI.AngularVelocity_rpm charge_pump_constantRPM = 2000  annotation(Dialog(tab = "Pumps", group = "Charge"));

      parameter Modelica.Units.SI.Area ctdp_area = 1 annotation(Dialog(tab = "Piping", group = "Discharge"));
      parameter Modelica.Units.SI.Length ctdp_length = 10 annotation(Dialog(tab = "Piping", group = "Discharge"));
      parameter Modelica.Units.SI.Length ctdp_d_height = 0.0 annotation(Dialog(tab = "Piping", group = "Discharge"));
      parameter Modelica.Units.SI.Volume ctvolume_volume = 1.0 annotation(Dialog(tab = "Piping", group = "Disharge"));
      parameter Modelica.Units.SI.MassFlowRate disvalve_m_flow_nom = 25 annotation(Dialog(tab = "Piping", group = "Discharge"));
      parameter Modelica.Units.SI.Pressure disvalve_dp_nominal = 1e5 annotation(Dialog(tab = "Piping", group = "Discharge"));
      parameter Modelica.Units.SI.Area htdp_area = 1 annotation(Dialog(tab = "Piping", group = "Charge"));
      parameter Modelica.Units.SI.Length htdp_length = 10 annotation(Dialog(tab = "Piping", group = "Charge"));
      parameter Modelica.Units.SI.Length htdp_d_height = 0.0 annotation(Dialog(tab = "Piping", group = "Charge"));
      parameter Modelica.Units.SI.MassFlowRate chvalve_m_flow_nom = 25 annotation(Dialog(tab = "Piping", group = "Charge"));
      parameter Modelica.Units.SI.Pressure chvalve_dp_nominal = 1e5 annotation(Dialog(tab = "Piping", group = "Charge"));
      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_SHS;
  end Data;

  package BaseClasses
    extends TRANSFORM.Icons.BasesPackage;

    partial model Partial_SubSystem

      extends NHES.Systems.BaseClasses.Partial_SubSystem;

      extends Record_SubSystem;

      replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
          Placement(transformation(extent={{-18,122},{-2,138}})));
      replaceable Partial_EventDriver ED annotation (choicesAllMatching=true,
          Placement(transformation(extent={{2,122},{18,138}})));
      replaceable Record_Data data
        annotation (Placement(transformation(extent={{42,122},{58,138}})));

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,80},{50,120}}),
            iconTransformation(extent={{10,80},{50,120}})));
      SignalSubBus_SensorOutput sensorBus
        annotation (Placement(transformation(extent={{-50,80},{-10,120}}),
            iconTransformation(extent={{-50,80},{-10,120}})));

    equation
      connect(sensorBus, ED.sensorBus) annotation (Line(
          points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus, CS.sensorBus) annotation (Line(
          points={{-30,100},{-12.4,100},{-12.4,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, CS.actuatorBus) annotation (Line(
          points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, ED.actuatorBus) annotation (Line(
          points={{30,100},{20,100},{12.4,100},{12.4,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      annotation (
        defaultComponentName="changeMe",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,140}})));
    end Partial_SubSystem;

    partial model Partial_SubSystem_A

      extends Partial_SubSystem;

      extends Record_SubSystem_A;

      annotation (
        defaultComponentName="changeMe",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                140}})));
    end Partial_SubSystem_A;

    partial model Record_Data

      extends Modelica.Icons.Record;

      annotation (defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_Data;

    partial record Record_SubSystem

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem;

    partial record Record_SubSystem_A

      extends Record_SubSystem;

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem_A;

    partial model Partial_ControlSystem

      extends NHES.Systems.BaseClasses.Partial_ControlSystem;

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
            iconTransformation(extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput sensorBus
        annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
            iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));

    end Partial_ControlSystem;

    partial model Partial_EventDriver

      extends NHES.Systems.BaseClasses.Partial_EventDriver;

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
            iconTransformation(extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput sensorBus
        annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
            iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="ED",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})));

    end Partial_EventDriver;

    expandable connector SignalSubBus_ActuatorInput

      extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

      annotation (defaultComponentName="actuatorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput;

    expandable connector SignalSubBus_SensorOutput

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

      annotation (defaultComponentName="sensorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_SensorOutput;

    model DumpTank_Init_T "Expansion tank with cover gas"
      import Modelica.Fluid.Types.Dynamics;
      extends TRANSFORM.Fluid.Interfaces.Records.Medium_fluid;
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_a(
        redeclare package Medium = Medium,
        m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
        "Fluid connector a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-20,60},{20,100}}, rotation=0),
            iconTransformation(extent={{-10,74},{10,94}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(
        redeclare package Medium = Medium,
        m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-20,-100},{20,-60}}, rotation=
               0), iconTransformation(extent={{-10,-94},{10,-74}})));
      parameter SI.Area A "Cross-sectional area";
      parameter SI.Volume V0=0 "Volume at zero level";
      input SI.Pressure p_surface=p_start "Liquid surface/gas pressure"
        annotation (Dialog(group="Inputs"));
      parameter Boolean allowFlowReversal=true
        "= true to allow flow reversal, false restricts to design direction"
        annotation (Dialog(tab="Advanced"));
      parameter Dynamics energyDynamics=Dynamics.DynamicFreeInitial
        "Formulation of energy balances"
        annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
      parameter Dynamics massDynamics=energyDynamics "Formulation of mass balances"
        annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
      final parameter Dynamics substanceDynamics=massDynamics
        "Formulation of substance balances"
        annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
      parameter Dynamics traceDynamics=massDynamics
        "Formulation of trace substance balances"
        annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
      input Real g_n=Modelica.Constants.g_n annotation(Dialog(tab="Advanced"));
      // Initialization
      parameter SI.Pressure p_start=1e5 annotation (Dialog(tab="Initialization"));
      parameter SI.Length level_start "Start level"
        annotation (Dialog(tab="Initialization"));
        parameter Boolean Use_T_Start = true annotation(Dialog(tab = "Initialization"));

      parameter SI.SpecificEnthalpy h_start=1e5
        annotation (Dialog(tab="Initialization", enable = not Use_T_Start));
        parameter SI.Temperature T_start = 150 annotation(Dialog(tab = "Initialization", enable = Use_T_Start));
      parameter SI.MassFraction X_start[Medium.nX]=Medium.X_default "Mass fraction"
        annotation (Dialog(
          tab="Initialization",
          group="Start Value: Species Mass Fraction",
          enable=Medium.nXi > 0));
      parameter TRANSFORM.Units.ExtraProperty C_start[Medium.nC]=fill(0, Medium.nC)
        "Mass-Specific value" annotation (Dialog(
          tab="Initialization",
          group="Start Value: Trace Substances",
          enable=Medium.nC > 0));
      SI.Length level(start=level_start, stateSelect=StateSelect.prefer)
        "Level";
      SI.Volume V "Volume";
      SI.Mass m "Mmass";
      SI.InternalEnergy U "Liquid internal energy";
      Medium.SpecificEnthalpy h(start=h_start, stateSelect=StateSelect.prefer)
        "Specific enthalpy";
      Medium.AbsolutePressure p(start=p_start) "Pressure";
      Medium.ThermodynamicState state=Medium.setState_phX(p_surface, h,Xi)
        "Thermodynamic state";
      Medium.Density d=Medium.density(state) "Density";
      Medium.Temperature T = Medium.temperature(state) "Temperature";
      SI.Mass mXi[Medium.nXi] "Species mass";
      SI.MassFraction Xi[Medium.nXi](start=Medium.reference_X[1:Medium.nXi])
        "Structurally independent mass fractions";
      TRANSFORM.Units.ExtraPropertyExtrinsic mC[Medium.nC]
        "Trace substance extrinsic value";
      TRANSFORM.Units.ExtraProperty C[Medium.nC](stateSelect=StateSelect.prefer,
          start=C_start) "Trace substance mass-specific value";
      // Mass Balance
      SI.MassFlowRate mb=port_a.m_flow + port_b.m_flow
        "Mass flow rate source/sinks within volumes";
      // Energy Balance
      SI.HeatFlowRate Ub=port_a.m_flow*actualStream(port_a.h_outflow) + port_b.m_flow
          *actualStream(port_b.h_outflow) + Q_flow_internal + Q_gen
        "Energy source/sinks within volumes (e.g., ohmic heating, external convection)";
      // Species Balance
      SI.MassFlowRate mXib[Medium.nXi]={port_a.m_flow*actualStream(port_a.Xi_outflow[
          i]) + port_b.m_flow*actualStream(port_b.Xi_outflow[i]) for i in 1:Medium.nXi}
        "Species mass flow rates source/sinks within volumes";
      // Trace Balance
      TRANSFORM.Units.ExtraPropertyFlowRate mCb[Medium.nC]={port_a.m_flow*
          actualStream(port_a.C_outflow[i]) + port_b.m_flow*actualStream(port_b.C_outflow[
          i]) + mC_gen[i] + mC_flow_internal[i] for i in 1:Medium.nC}
        "Trace flow rate source/sinks within volumes (e.g., chemical reactions, external convection)";
      parameter Boolean use_HeatPort=false "=true to toggle heat port"
        annotation (Dialog(tab="Advanced", group="Heat Transfer"), Evaluate=true);
      input SI.HeatFlowRate Q_gen=0 "Internal heat generation"
        annotation (Dialog(tab="Advanced", group="Heat Transfer"));
      parameter Boolean use_TraceMassPort=false "=true to toggle trace mass port"
        annotation (Dialog(tab="Advanced", group="Trace Mass Transfer"), Evaluate=true);
      parameter Real MMs[Medium.nC]=fill(1, Medium.nC)
        "Conversion from fluid mass-specific value to moles (e.g., molar mass [kg/mol] or Avogadro's number [atoms/mol])" annotation (Dialog(
          tab="Advanced",
          group="Trace Mass Transfer",
          enable=use_TraceMassPort));
      input TRANSFORM.Units.ExtraPropertyFlowRate mC_gen[Medium.nC]=fill(0, Medium.nC)
        "Internal trace mass generation"
        annotation (Dialog(tab="Advanced", group="Trace Mass Transfer"));
      TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_State heatPort(T=T, Q_flow=
            Q_flow_internal) if use_HeatPort annotation (Placement(transformation(
              extent={{74,-10},{94,10}}), iconTransformation(extent={{74,-10},{94,10}})));
      TRANSFORM.HeatAndMassTransfer.Interfaces.MolePort_State traceMassPort(
        nC=Medium.nC,
        C=C .* d ./ MMs,
        n_flow=mC_flow_internal ./ MMs) if use_TraceMassPort annotation (Placement(
            transformation(extent={{50,-70},{70,-50}}), iconTransformation(extent={{
                50,-70},{70,-50}})));
      // Visualization
      parameter Boolean showName=true annotation (Dialog(tab="Visualization"));
    protected
      SI.HeatFlowRate Q_flow_internal;
      TRANSFORM.Units.ExtraPropertyFlowRate mC_flow_internal[Medium.nC];
    initial equation
      // Mass Balance
      if massDynamics == Dynamics.FixedInitial then
        level = level_start;
      elseif massDynamics == Dynamics.SteadyStateInitial then
        der(level) = 0;
      end if;
      // Energy Balance
      if energyDynamics == Dynamics.FixedInitial then
        if Use_T_Start then
          h = Medium.specificEnthalpy_pTX(p_start, T_start, Medium.X_default);
          else
        h = h_start;
        end if;
      elseif energyDynamics == Dynamics.SteadyStateInitial then
        der(h) = 0;
      end if;
      // Species Balance
      if substanceDynamics == Dynamics.FixedInitial then
        Xi = X_start[1:Medium.nXi];
      elseif substanceDynamics == Dynamics.SteadyStateInitial then
        der(Xi) = zeros(Medium.nXi);
      end if;
      // Trace Balance
      if traceDynamics == Dynamics.FixedInitial then
        C = C_start;
      elseif traceDynamics == Dynamics.SteadyStateInitial then
        der(mC) = zeros(Medium.nC);
      end if;
    equation
      if not use_HeatPort then
        Q_flow_internal = 0;
      end if;
      if not use_TraceMassPort then
        mC_flow_internal = zeros(Medium.nC);
      end if;
      // Total Quantities
      V = V0 + A*level;
      m = V*d;
      U = m*Medium.specificInternalEnergy(state);
      p = p_surface + d*g_n*0.5*level;
      mC = m*C;
      // Mass Balance
      if massDynamics == Dynamics.SteadyState then
        0 = mb;
      else
        der(m) = mb;
      end if;
      // Energy Balance
      if massDynamics == Dynamics.SteadyState then
        0 = Ub;
      else
        der(U) = Ub;
      end if;
      // Species Balance
      if massDynamics == Dynamics.SteadyState then
        zeros(Medium.nXi) = mXib;
      else
        der(mXi) = mXib;
      end if;
      // Trace Balance
      if traceDynamics == Dynamics.SteadyState then
        zeros(Medium.nC) = mCb;
      else
        der(mC) = mCb;
      end if;
      // Boundary Conditions
      port_a.p = p_surface;
      port_b.p = p_surface + d*g_n*level;
      port_a.h_outflow = h;
      port_b.h_outflow = h;
      port_a.Xi_outflow = Xi;
      port_b.Xi_outflow = Xi;
      port_a.C_outflow = C;
      port_b.C_outflow = C;
      annotation (defaultComponentName="tank",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={
            Ellipse(
              extent={{-85,85},{85,-85}},
              fillColor={0,128,255},
              fillPattern=FillPattern.Sphere,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Ellipse(
              extent={{-85,-85},{85,85}},
              pattern=LinePattern.None,
              lineColor={135,135,135},
              fillColor={255,255,255},
              fillPattern=FillPattern.Sphere,
              startAngle=0,
              endAngle=180),
            Text(
              extent={{-150,20},{150,-20}},
              lineColor={0,0,255},
              textString="%name",
              visible=DynamicSelect(true, showName),
              origin={-111,0},
              rotation=90)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}})),
        Documentation(info="<html>
<p>Tank where port_a is assumped to empty at the liquid surface level (regardless of level), i.e., port_a.p=p_surface.</p>
<p>p = p_surface + 0.5*fluid pressure</p>
<p>port_b.p = p_surface + fluid pressure</p>
</html>"));
    end DumpTank_Init_T;
  end BaseClasses;

  package ControlSystems
    model CS_Default

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-96,86},{-76,106}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=25,
        rising=500,
        width=2600,
        falling=500,
        period=10800,
        offset=0.0,
        startTime=7200)
        annotation (Placement(transformation(extent={{-54,-56},{-42,-44}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid1(
        amplitude=25,
        rising=500,
        width=2600,
        falling=500,
        period=10800,
        offset=0.0,
        startTime=1800)
        annotation (Placement(transformation(extent={{-38,34},{-24,48}})));
      Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
        annotation (Placement(transformation(extent={{-16,-62},{-4,-50}})));
      Modelica.Blocks.Sources.Constant cold_tank_level_max(k=data.cold_tank_level_max)
        annotation (Placement(transformation(extent={{-92,6},{-84,14}})));
      Modelica.Blocks.Sources.Constant hot_tank_max_level(k=data.hot_tank_level_max)
        annotation (Placement(transformation(extent={{-96,-34},{-88,-26}})));
      Modelica.Blocks.Sources.Constant zero(k=0)
        annotation (Placement(transformation(extent={{-54,-26},{-48,-20}})));
      Modelica.Blocks.Sources.Constant one(k=1)
        annotation (Placement(transformation(extent={{-80,-22},{-72,-14}})));
      Modelica.Blocks.Math.MultiProduct multiProduct1(nu=3)
        annotation (Placement(transformation(extent={{-14,2},{-2,14}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-62,-34},{-54,-26}})));
      Modelica.Blocks.Math.Add add(k2=-1)
        annotation (Placement(transformation(extent={{-80,-36},{-72,-28}})));
      Modelica.Blocks.Math.Max max1
        annotation (Placement(transformation(extent={{-36,-28},{-30,-22}})));
      Modelica.Blocks.Math.Max max2
        annotation (Placement(transformation(extent={{-56,24},{-48,32}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-72,22},{-66,28}})));
      Modelica.Blocks.Sources.Constant zero1(k=0)
        annotation (Placement(transformation(extent={{-78,32},{-70,40}})));
      Modelica.Blocks.Sources.Constant one1(k=1)
        annotation (Placement(transformation(extent={{-92,24},{-86,30}})));
      Modelica.Blocks.Math.Max max3
        annotation (Placement(transformation(extent={{-30,4},{-24,10}})));
      Modelica.Blocks.Sources.Constant zero2(k=0)
        annotation (Placement(transformation(extent={{-48,6},{-42,12}})));
      Modelica.Blocks.Math.Min min3
        annotation (Placement(transformation(extent={{-56,-2},{-48,6}})));
      Modelica.Blocks.Math.Add add1(k2=-1)
        annotation (Placement(transformation(extent={{-74,-4},{-66,4}})));
      Modelica.Blocks.Sources.Constant one2(k=1)
        annotation (Placement(transformation(extent={{-74,10},{-66,18}})));
      Modelica.Blocks.Math.Min min4
        annotation (Placement(transformation(extent={{-64,-78},{-58,-72}})));
      Modelica.Blocks.Math.Max max4
        annotation (Placement(transformation(extent={{-48,-72},{-40,-64}})));
      Modelica.Blocks.Sources.Constant zero3(k=0)
        annotation (Placement(transformation(extent={{-70,-68},{-62,-60}})));
      Modelica.Blocks.Sources.Constant one3(k=1)
        annotation (Placement(transformation(extent={{-84,-76},{-78,-70}})));
    equation

      connect(add.u1, hot_tank_max_level.y) annotation (Line(points={{-80.8,-29.6},
              {-80,-29.6},{-80,-30},{-87.6,-30}}, color={0,0,127}));
      connect(sensorBus.hot_tank_level, add.u2) annotation (Line(
          points={{-30,-100},{-86,-100},{-86,-34.4},{-80.8,-34.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(min1.u2, add.y)
        annotation (Line(points={{-62.8,-32.4},{-71.6,-32}}, color={0,0,127}));
      connect(one.y, min1.u1) annotation (Line(points={{-71.6,-18},{-62.8,-18},{
              -62.8,-27.6}}, color={0,0,127}));
      connect(max1.u2, min1.y) annotation (Line(points={{-36.6,-26.8},{-48,-26.8},{
              -48,-30},{-53.6,-30}}, color={0,0,127}));
      connect(zero.y, max1.u1) annotation (Line(points={{-47.7,-23},{-47.7,-23.2},{
              -36.6,-23.2}}, color={0,0,127}));
      connect(zero1.y, max2.u1) annotation (Line(points={{-69.6,36},{-56.8,36},{
              -56.8,30.4}}, color={0,0,127}));
      connect(one1.y, min2.u1) annotation (Line(points={{-85.7,27},{-85.7,26.8},{
              -72.6,26.8}}, color={0,0,127}));
      connect(sensorBus.hot_tank_level, min2.u2) annotation (Line(
          points={{-30,-100},{-86,-100},{-86,-38},{-102,-38},{-102,18},{-78,18},{
              -78,23.2},{-72.6,23.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(trapezoid.y, multiProduct.u[1]) annotation (Line(points={{-41.4,-50},
              {-22,-50},{-22,-53.2},{-16,-53.2}},
                                              color={0,0,127}));
      connect(max1.y, multiProduct.u[2]) annotation (Line(points={{-29.7,-25},{-22,
              -25},{-22,-56},{-16,-56}}, color={0,0,127}));
      connect(actuatorBus.m_flow_charge, multiProduct.y) annotation (Line(
          points={{30,-100},{28,-100},{28,-56},{-2.98,-56}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(min2.y, max2.u2) annotation (Line(points={{-65.7,25},{-62,25},{-62,
              25.6},{-56.8,25.6}}, color={0,0,127}));
      connect(max3.u2, min3.y) annotation (Line(points={{-30.6,5.2},{-42,5.2},{-42,
              2},{-47.6,2}}, color={0,0,127}));
      connect(zero2.y, max3.u1) annotation (Line(points={{-41.7,9},{-41.7,8.8},{
              -30.6,8.8}}, color={0,0,127}));
      connect(min3.u2, add1.y)
        annotation (Line(points={{-56.8,-0.4},{-65.6,0}}, color={0,0,127}));
      connect(one2.y, min3.u1) annotation (Line(points={{-65.6,14},{-60,14},{-60,
              4.4},{-56.8,4.4}}, color={0,0,127}));
      connect(add1.u1, cold_tank_level_max.y) annotation (Line(points={{-74.8,2.4},
              {-80,2.4},{-80,10},{-83.6,10}}, color={0,0,127}));
      connect(sensorBus.cold_tank_level, add1.u2) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-8},{-74.8,-8},{-74.8,-2.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(trapezoid1.y, multiProduct1.u[1]) annotation (Line(points={{-23.3,41},
              {-16,41},{-16,10.8},{-14,10.8}}, color={0,0,127}));
      connect(min4.y, max4.u2) annotation (Line(points={{-57.7,-75},{-50,-75},{-50,
              -70.4},{-48.8,-70.4}}, color={0,0,127}));
      connect(zero3.y, max4.u1) annotation (Line(points={{-61.6,-64},{-48.8,-64},{
              -48.8,-65.6}}, color={0,0,127}));
      connect(one3.y, min4.u1) annotation (Line(points={{-77.7,-73},{-77.7,-73.2},{
              -64.6,-73.2}}, color={0,0,127}));
      connect(max3.y, multiProduct1.u[2])
        annotation (Line(points={{-23.7,7},{-14,8}}, color={0,0,127}));
      connect(sensorBus.cold_tank_level, min4.u2) annotation (Line(
          points={{-30,-100},{-66,-100},{-66,-76.8},{-64.6,-76.8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.m_flow_discharge, multiProduct1.y) annotation (Line(
          points={{30,-100},{28,-100},{28,8},{-0.98,8}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(max2.y, multiProduct1.u[3]) annotation (Line(points={{-47.6,28},{-40,
              28},{-40,26},{-34,26},{-34,5.2},{-14,5.2}}, color={0,0,127}));
      connect(max4.y, multiProduct.u[3]) annotation (Line(points={{-39.6,-68},{-22,
              -68},{-22,-58.8},{-16,-58.8}},
                                         color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Default;

    model CS_Boiler

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      TRANSFORM.Controls.LimPID PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-3,
        Ti=15,
        yMax=1.0,
        yMin=0.0) annotation (Placement(transformation(extent={{-2,-56},{18,-36}})));
      Modelica.Blocks.Sources.Constant const1(k=5e5)
        annotation (Placement(transformation(extent={{-48,-56},{-28,-36}})));
      Modelica.Blocks.Sources.Constant const(k=10)
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
      TRANSFORM.Controls.LimPID PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-2,
        Ti=10,
        yMin=-0.25)
                  annotation (Placement(transformation(extent={{-22,-20},{-2,0}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-4)
        annotation (Placement(transformation(extent={{2,6},{22,26}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,20},{-12,14}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-4,
        Ti=10,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,26},{-38,20}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid1(
        amplitude=20,
        rising=500,
        width=8500,
        falling=500,
        period=18000,
        offset=0,
        startTime=9000)
        annotation (Placement(transformation(extent={{-62,20},{-56,26}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,12},{-50,18}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,6},{-72,14}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,6},{-90,10}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,14},{-62,20}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-4,
        Ti=10,
        yMax=1.0,
        yMin=0.0,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=20,
        rising=500,
        width=8500,
        falling=500,
        period=18000,
        offset=0.0,
        startTime=0)
        annotation (Placement(transformation(extent={{-74,42},{-62,54}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-4) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
    equation

      connect(PID1.u_s, const1.y)
        annotation (Line(points={{-4,-46},{-27,-46}}, color={0,0,127}));
      connect(sensorBus.Boiler_Drum_Pressure, PID1.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{8,-70},{8,-58}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Boiler_Steam_Valve, PID1.y) annotation (Line(
          points={{30,-100},{30,-46},{19,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID.u_s,const. y)
        annotation (Line(points={{-24,-10},{-39,-10}},
                                                    color={0,0,127}));
      connect(sensorBus.Boiler_Level, PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-60},{-52,-60},{-52,-28},{-12,-28},{-12,-22}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Boiler_Feed_Flow, PID.y) annotation (Line(
          points={{30,-100},{30,-10},{-1,-10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points=
             {{-11.7,17},{-8,17},{-8,16},{0,16}}, color={0,0,127}));
      connect(add2.y,product2. u1) annotation (Line(points={{-49.7,15},{-22,15},{
              -22,16},{-18.6,16},{-18.6,15.2}},                 color={0,0,127}));
      connect(PID5.y,product2. u2) annotation (Line(points={{-37.7,23},{-24,23},{
              -24,18.8},{-18.6,18.8}},                          color={0,0,127}));
      connect(trapezoid1.y,PID5. u_s)
        annotation (Line(points={{-55.7,23},{-44.6,23}},     color={0,0,127}));
      connect(min2.y,add2. u2) annotation (Line(points={{-71.6,10},{-60,10},{-60,
              13.2},{-56.6,13.2}},                                         color={0,
              0,127}));
      connect(one4.y,min2. u2) annotation (Line(points={{-89.8,8},{-88,8},{-88,7.6},
              {-80.8,7.6}},            color={0,0,127}));
      connect(add2.u1, one5.y) annotation (Line(points={{-56.6,16.8},{-56.6,17},{
              -61.7,17}}, color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
        annotation (Line(
          points={{30,-100},{30,16},{23.4,16}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,30},{-41,30},{-41,26.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,12.4},{-80.8,12.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(trapezoid.y,PID3. u_s)
        annotation (Line(points={{-61.4,48},{-42,48},{-42,58},{-36.8,58}},
                                                         color={0,0,127}));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.discharge_m_flow, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,30},{-36,30},{-36,38},{-32,
              38},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Boiler;

    model CS_Boiler_02

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      TRANSFORM.Controls.LimPID PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-3,
        Ti=15,
        yMax=1.0,
        yMin=0.0) annotation (Placement(transformation(extent={{-2,-56},{18,-36}})));
      Modelica.Blocks.Sources.Constant const1(k=5e5)
        annotation (Placement(transformation(extent={{-48,-56},{-28,-36}})));
      Modelica.Blocks.Sources.Constant const(k=10)
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
      TRANSFORM.Controls.LimPID PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-2,
        Ti=10,
        yMin=-0.25)
                  annotation (Placement(transformation(extent={{-22,-20},{-2,0}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-4)
        annotation (Placement(transformation(extent={{2,6},{22,26}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,20},{-12,14}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-7.5e-4,
        Ti=30,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,24},{-38,18}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,12},{-50,18}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,6},{-72,14}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,6},{-90,10}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,14},{-62,20}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-2,
        Ti=10,
        yMax=1.0,
        yMin=0.0,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=2.0,
        rising=500,
        width=8500,
        falling=500,
        period=18000,
        offset=0.0,
        startTime=0)
        annotation (Placement(transformation(extent={{-58,48},{-46,60}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-4) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Sources.Constant one1(k=273.15 + 245)
        annotation (Placement(transformation(extent={{-58,22},{-52,28}})));
      Modelica.Blocks.Math.Add add3(k1=0.1)
        annotation (Placement(transformation(extent={{-30,24},{-24,30}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,32},{-46,36}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,30},{-54,32}})));
      Modelica.Blocks.Sources.Constant one7(k=22.0)
        annotation (Placement(transformation(extent={{-56,38},{-54,40}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,38},{-34,32}})));
    equation

      connect(PID1.u_s, const1.y)
        annotation (Line(points={{-4,-46},{-27,-46}}, color={0,0,127}));
      connect(sensorBus.Boiler_Drum_Pressure, PID1.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{8,-70},{8,-58}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Boiler_Steam_Valve, PID1.y) annotation (Line(
          points={{30,-100},{30,-46},{19,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID.u_s,const. y)
        annotation (Line(points={{-24,-10},{-39,-10}},
                                                    color={0,0,127}));
      connect(sensorBus.Boiler_Level, PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-52,-70},{-52,-28},{-12,-28},{-12,-22}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Boiler_Feed_Flow, PID.y) annotation (Line(
          points={{30,-100},{30,-10},{-1,-10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points=
             {{-11.7,17},{-8,17},{-8,16},{0,16}}, color={0,0,127}));
      connect(add2.y,product2. u1) annotation (Line(points={{-49.7,15},{-22,15},{
              -22,16},{-18.6,16},{-18.6,15.2}},                 color={0,0,127}));
      connect(min2.y,add2. u2) annotation (Line(points={{-71.6,10},{-60,10},{-60,
              13.2},{-56.6,13.2}},                                         color={0,
              0,127}));
      connect(one4.y,min2. u2) annotation (Line(points={{-89.8,8},{-88,8},{-88,7.6},
              {-80.8,7.6}},            color={0,0,127}));
      connect(add2.u1, one5.y) annotation (Line(points={{-56.6,16.8},{-56.6,17},{
              -61.7,17}}, color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
        annotation (Line(
          points={{30,-100},{30,16},{23.4,16}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,12.4},{-80.8,12.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(trapezoid.y,PID3. u_s)
        annotation (Line(points={{-45.4,54},{-40,54},{-40,58},{-36.8,58}},
                                                         color={0,0,127}));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,25},{-44.6,25},{
              -44.6,21}}, color={0,0,127}));
      connect(sensorBus.Charge_Temp, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,30},{-41,30},{-41,24.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,21},{-34,21},{-34,
              25.2},{-30.6,25.2}}, color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,18.8},{-22,18.8},
              {-22,27},{-23.7,27}}, color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,35.6},{-52,35.6},
              {-52,39},{-53.9,39}}, color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,32.4},{-50.4,31},
              {-53.9,31}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,34},{-45.8,35},{
              -40.6,35}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,28.8},{-33.7,28.8},{
              -33.7,35}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-37,42},{-37,38.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,34},{-50.4,34}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Boiler_02;

    model CS_Boiler_03

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-4)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-7.5e-4,
        Ti=30,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-2,
        Ti=10,
        yMax=1.0,
        yMin=0.0,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=2.0,
        rising=500,
        width=8500,
        falling=500,
        period=18000,
        offset=0.0,
        startTime=0)
        annotation (Placement(transformation(extent={{-58,48},{-46,60}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-4) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Sources.Constant one1(k=273.15 + 245)
        annotation (Placement(transformation(extent={{-58,-16},{-52,-10}})));
      Modelica.Blocks.Math.Add add3(k1=0.1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=22.0)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
    equation

      connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
              -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
      connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
              -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
      connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
              -24.8},{-56.6,-24.8}},                                       color={0,
              0,127}));
      connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
              -30.4},{-80.8,-30.4}},   color={0,0,127}));
      connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
              -61.7,-21}},color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
        annotation (Line(
          points={{30,-100},{30,-22},{23.4,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(trapezoid.y,PID3. u_s)
        annotation (Line(points={{-45.4,54},{-40,54},{-40,58},{-36.8,58}},
                                                         color={0,0,127}));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,-13},{-44.6,-13},{
              -44.6,-17}},color={0,0,127}));
      connect(sensorBus.Charge_Temp, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-64},{-102,-64},{-102,-4},{-41,-4},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Boiler_03;

    model CS_Boiler_04

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-4)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-2.5e-3,
        Ti=3,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-2,
        Ti=10,
        yMax=1.0,
        yMin=0.0,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=2.0,
        rising=500,
        width=8500,
        falling=500,
        period=18000,
        offset=0.0,
        startTime=0)
        annotation (Placement(transformation(extent={{-58,48},{-46,60}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-4) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Sources.Constant one1(k=273.15 + 245)
        annotation (Placement(transformation(extent={{-58,-16},{-52,-10}})));
      Modelica.Blocks.Math.Add add3(k1=0.1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=22.0)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
    equation

      connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
              -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
      connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
              -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
      connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
              -24.8},{-56.6,-24.8}},                                       color={0,
              0,127}));
      connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
              -30.4},{-80.8,-30.4}},   color={0,0,127}));
      connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
              -61.7,-21}},color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
        annotation (Line(
          points={{30,-100},{30,-22},{23.4,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(trapezoid.y,PID3. u_s)
        annotation (Line(points={{-45.4,54},{-40,54},{-40,58},{-36.8,58}},
                                                         color={0,0,127}));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,-13},{-44.6,-13},{
              -44.6,-17}},color={0,0,127}));
      connect(sensorBus.Charge_Temp, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-64},{-102,-64},{-102,-4},{-41,-4},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Boiler_04;

    model CS_Boiler_03_GMI

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-4)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-7.5e-4,
        Ti=30,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-2,
        Ti=1,
        yMax=1.0,
        yMin=0.0,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=10,
        rising=10,
        width=9480,
        falling=10,
        period=18000,
        offset=0.0,
        startTime=0)
        annotation (Placement(transformation(extent={{-58,48},{-46,60}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=0.3)  annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Sources.Constant one1(k=273.15 + 245)
        annotation (Placement(transformation(extent={{-58,-16},{-52,-10}})));
      Modelica.Blocks.Math.Add add3(k1=0.1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=22.0)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
    equation

      connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
              -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
      connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
              -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
      connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
              -24.8},{-56.6,-24.8}},                                       color={0,
              0,127}));
      connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
              -30.4},{-80.8,-30.4}},   color={0,0,127}));
      connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
              -61.7,-21}},color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
        annotation (Line(
          points={{30,-100},{30,-22},{23.4,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(trapezoid.y,PID3. u_s)
        annotation (Line(points={{-45.4,54},{-40,54},{-40,58},{-36.8,58}},
                                                         color={0,0,127}));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,-13},{-44.6,-13},{
              -44.6,-17}},color={0,0,127}));
      connect(sensorBus.Charge_Temp, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-64},{-102,-64},{-102,-4},{-41,-4},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Discharge_Steam, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Boiler_03_GMI;

    model CS_Basic_TESUC

      extends BaseClasses.Partial_ControlSystem;
      parameter Modelica.Units.SI.Temperature steam_ref;
      input Modelica.Units.SI.MassFlowRate Ref_Charge_Flow "TES should supply expected charging mass flow rate given demand" annotation(Dialog(tab = "General"));
      replaceable Data.Data_CS data
        annotation (Placement(transformation(extent={{-92,18},{-72,38}})), Dialog(tab = "General", choicesAllMatching=true));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=2e-4)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-2.5e-3,
        Ti=3,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.01*data.discharge_control_ref_value,
        Ti=10,
        yMax=1.0,
        yMin=0.0,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
    end CS_Basic_TESUC;

    model CS_Case_1

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-2, max=1)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=7.5e-5,
        Ti=5,
        yMax=1.0,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=5)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-4)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-3,
        Ti=20,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-2) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=915.5)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
      Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
        annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
      Modelica.Blocks.Math.Product product3
        annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
      Modelica.Blocks.Sources.Constant one1(k=24)
        annotation (Placement(transformation(extent={{-118,4},{-108,14}})));
      Modelica.Blocks.Sources.Constant one9(k=0.015)
        annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
      Modelica.Blocks.Math.Add add4
        annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
    equation

      connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
              -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
      connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
              -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
      connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
              -24.8},{-56.6,-24.8}},                                       color={0,
              0,127}));
      connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
              -30.4},{-80.8,-30.4}},   color={0,0,127}));
      connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
              -61.7,-21}},color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
        annotation (Line(
          points={{30,-100},{30,-22},{23.4,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
              -36.8,54},{-36.8,58}}, color={0,0,127}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one1.y, product3.u1) annotation (Line(points={{-107.5,9},{-107.5,8.4},
              {-86.8,8.4}}, color={0,0,127}));
      connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
              -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
      connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
              14.8},{-70.6,14.8}}, color={0,0,127}));
      connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
              11.2},{-70.6,11.2}}, color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Case_1;

    model CS_Case_3

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-2, max=1)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=7.5e-5,
        Ti=5,
        yMax=1.0,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=5)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-4)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-3,
        Ti=20,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-2) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=915.5)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
      Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
        annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
      Modelica.Blocks.Math.Product product3
        annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
      Modelica.Blocks.Sources.Constant one1(k=28)
        annotation (Placement(transformation(extent={{-118,4},{-108,14}})));
      Modelica.Blocks.Sources.Constant one9(k=0.015)
        annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
      Modelica.Blocks.Math.Add add4
        annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
    equation

      connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
              -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
      connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
              -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
      connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
              -24.8},{-56.6,-24.8}},                                       color={0,
              0,127}));
      connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
              -30.4},{-80.8,-30.4}},   color={0,0,127}));
      connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
              -61.7,-21}},color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
        annotation (Line(
          points={{30,-100},{30,-22},{23.4,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
              -36.8,54},{-36.8,58}}, color={0,0,127}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one1.y, product3.u1) annotation (Line(points={{-107.5,9},{-107.5,8.4},
              {-86.8,8.4}}, color={0,0,127}));
      connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
              -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
      connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
              14.8},{-70.6,14.8}}, color={0,0,127}));
      connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
              11.2},{-70.6,11.2}}, color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Case_3;

    model CS_BestExample

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-2, max=1)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=7.5e-5,
        Ti=5,
        yMax=1.0,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-3,
        Ti=20,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-2) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=915.5)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
      Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
        annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
      Modelica.Blocks.Math.Product product3
        annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
      Modelica.Blocks.Sources.Constant one1(k=240 + 273.15)
        annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
      Modelica.Blocks.Sources.Constant one9(k=0.015)
        annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
      Modelica.Blocks.Math.Add add4
        annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
      TRANSFORM.Controls.LimPID PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-2,
        Ti=20,
        yMax=40,
        yMin=-9,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
      Modelica.Blocks.Math.Add add5
        annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
      Modelica.Blocks.Sources.Constant one10(k=30)
        annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
    equation

      connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
              -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
      connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
              -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
      connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
              -24.8},{-56.6,-24.8}},                                       color={0,
              0,127}));
      connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
              -30.4},{-80.8,-30.4}},   color={0,0,127}));
      connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
              -61.7,-21}},color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
        annotation (Line(
          points={{30,-100},{30,-22},{23.4,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
              -36.8,54},{-36.8,58}}, color={0,0,127}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
              -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
      connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
              14.8},{-70.6,14.8}}, color={0,0,127}));
      connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
              11.2},{-70.6,11.2}}, color={0,0,127}));
      connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
              -143.15,8},{-136.8,8}}, color={0,0,127}));
      connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
              -120,20.8},{-116.6,20.8}}, color={0,0,127}));
      connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
              -116.6,17.2}}, color={0,0,127}));
      connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
              -92,8.4},{-86.8,8.4}}, color={0,0,127}));
      connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}),
        Diagram(graphics={Text(
              extent={{-170,20},{-126,14}},
              textColor={28,108,200},
              textString="Don't set lower bound lower than -9
"),     Line(points={{-142,16},{-136,12}}, color={28,108,200})}));
    end CS_BestExample;

    model CS_DirectCoupling

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-2, max=1)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=7.5e-5,
        Ti=5,
        yMax=1.0,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-3,
        Ti=20,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-2) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=915.5)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
      Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
        annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
      Modelica.Blocks.Math.Product product3
        annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
      Modelica.Blocks.Sources.Constant one1(k=240 + 273.15)
        annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
      Modelica.Blocks.Sources.Constant one9(k=0.015)
        annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
      Modelica.Blocks.Math.Add add4
        annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
      TRANSFORM.Controls.LimPID PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-2,
        Ti=20,
        yMax=40,
        yMin=-10,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
      Modelica.Blocks.Math.Add add5
        annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
      Modelica.Blocks.Sources.Constant one10(k=15)
        annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
    equation

      connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
              -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
      connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
              -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
      connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
              -24.8},{-56.6,-24.8}},                                       color={0,
              0,127}));
      connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
              -30.4},{-80.8,-30.4}},   color={0,0,127}));
      connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
              -61.7,-21}},color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
        annotation (Line(
          points={{30,-100},{30,-22},{23.4,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
              -36.8,54},{-36.8,58}}, color={0,0,127}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
              -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
      connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
              14.8},{-70.6,14.8}}, color={0,0,127}));
      connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
              11.2},{-70.6,11.2}}, color={0,0,127}));
      connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
              -143.15,8},{-136.8,8}}, color={0,0,127}));
      connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
              -120,20.8},{-116.6,20.8}}, color={0,0,127}));
      connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
              -116.6,17.2}}, color={0,0,127}));
      connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
              -92,8.4},{-86.8,8.4}}, color={0,0,127}));
      connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}),
        Diagram(graphics={Text(
              extent={{-170,20},{-126,14}},
              textColor={28,108,200},
              textString="Don't set lower bound lower than -9
"),     Line(points={{-142,16},{-136,12}}, color={28,108,200})}));
    end CS_DirectCoupling;

    model CS_Case_1_HTGR

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-2, max=1)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=7.5e-5,
        Ti=5,
        yMax=1.0,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-3,
        Ti=20,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-2) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=915.5)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
      Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
        annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
      Modelica.Blocks.Math.Product product3
        annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
      Modelica.Blocks.Sources.Constant one1(k=240 + 273.15)
        annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
      Modelica.Blocks.Sources.Constant one9(k=0.015)
        annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
      Modelica.Blocks.Math.Add add4
        annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
      TRANSFORM.Controls.LimPID PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-2,
        Ti=20,
        yMax=40,
        yMin=-9,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
      Modelica.Blocks.Math.Add add5
        annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
      Modelica.Blocks.Sources.Constant one10(k=30)
        annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
    equation

      connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
              -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
      connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
              -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
      connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
              -24.8},{-56.6,-24.8}},                                       color={0,
              0,127}));
      connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
              -30.4},{-80.8,-30.4}},   color={0,0,127}));
      connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
              -61.7,-21}},color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
        annotation (Line(
          points={{30,-100},{30,-22},{23.4,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
              -36.8,54},{-36.8,58}}, color={0,0,127}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
              -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
      connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
              14.8},{-70.6,14.8}}, color={0,0,127}));
      connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
              11.2},{-70.6,11.2}}, color={0,0,127}));
      connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
              -143.15,8},{-136.8,8}}, color={0,0,127}));
      connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
              -120,20.8},{-116.6,20.8}}, color={0,0,127}));
      connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
              -116.6,17.2}}, color={0,0,127}));
      connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
              -92,8.4},{-86.8,8.4}}, color={0,0,127}));
      connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}),
        Diagram(graphics={Text(
              extent={{-170,20},{-126,14}},
              textColor={28,108,200},
              textString="Don't set lower bound lower than -9
"),     Line(points={{-142,16},{-136,12}}, color={28,108,200})}));
    end CS_Case_1_HTGR;

    model CS_DirectCoupling_HTGR

      extends BaseClasses.Partial_ControlSystem;

      Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Charging_Valve_Position_MinMax(min=1e-2, max=1)
        annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=7.5e-5,
        Ti=5,
        yMax=1.0,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
      Modelica.Blocks.Math.Add add2
        annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
      Modelica.Blocks.Sources.Constant one4(k=1.25)
        annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
      Modelica.Blocks.Sources.Constant one5(k=-0.25)
        annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-3,
        Ti=20,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
      BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        Discharging_Valve_Position(min=1e-2) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={12,64})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
      Modelica.Blocks.Sources.Constant one3(k=-0.25)
        annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
      Modelica.Blocks.Sources.Constant one2(k=1.25)
        annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
      Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
        annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
      Modelica.Blocks.Sources.Constant one6(k=0.0)
        annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
      Modelica.Blocks.Sources.Constant one7(k=915.5)
        annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-2,
        Ti=10,
        yMax=1,
        yMin=0.01,
        initType=Modelica.Blocks.Types.Init.NoInit,
        y_start=0.0)
        annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
      Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
        annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
      Modelica.Blocks.Math.Product product3
        annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
      Modelica.Blocks.Sources.Constant one1(k=340 + 273.15)
        annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
      Modelica.Blocks.Sources.Constant one9(k=0.015)
        annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
      Modelica.Blocks.Math.Add add4
        annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
      TRANSFORM.Controls.LimPID PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-2,
        Ti=20,
        yMax=70,
        yMin=-9,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1)
        annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
      Modelica.Blocks.Math.Add add5
        annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
      Modelica.Blocks.Sources.Constant one10(k=30)
        annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{120,-44},{140,-24}})));
      Modelica.Blocks.Sources.Constant const9(k=165e5)
        annotation (Placement(transformation(extent={{80,-44},{100,-24}})));
    equation

      connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
              -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
      connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
              -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
      connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
              -24.8},{-56.6,-24.8}},                                       color={0,
              0,127}));
      connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
              -30.4},{-80.8,-30.4}},   color={0,0,127}));
      connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
              -61.7,-21}},color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
        annotation (Line(
          points={{30,-100},{30,-22},{23.4,-22}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
          points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(product1.y, Discharging_Valve_Position.u)
        annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
      connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
              -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
      connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
              -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
      connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
              74.8},{-36.6,74.8}},                                    color={0,0,
              127}));
      connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
              -36.6,71.2}},                                      color={0,0,127}));
      connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
              {-56.8,62},{-56.8,63.6}},
                                     color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,64},{23.4,64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
              -12.8},{-30.6,-12.8}},
                                   color={0,0,127}));
      connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
              -19.2},{-22,-11},{-23.7,-11}},
                                    color={0,0,127}));
      connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
              {-53.9,-1}},          color={0,0,127}));
      connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
              {-53.9,-7}}, color={0,0,127}));
      connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
              -40.6,-3}}, color={0,0,127}));
      connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
              -33.7,-3}}, color={0,0,127}));
      connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
              -37,0.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
              -36.8,54},{-36.8,58}}, color={0,0,127}));
      connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
          points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
              -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
      connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
              14.8},{-70.6,14.8}}, color={0,0,127}));
      connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
              11.2},{-70.6,11.2}}, color={0,0,127}));
      connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
              -143.15,8},{-136.8,8}}, color={0,0,127}));
      connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
              -120,20.8},{-116.6,20.8}}, color={0,0,127}));
      connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
              -116.6,17.2}}, color={0,0,127}));
      connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
              -92,8.4},{-86.8,8.4}}, color={0,0,127}));
      connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
          points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(const9.y,PI_TBV. u_s)
        annotation (Line(points={{101,-34},{118,-34}},
                                                     color={0,0,127}));
      connect(sensorBus.Steam_Pressure,PI_TBV. u_m) annotation (Line(
          points={{-30,-100},{58,-100},{58,-70},{130,-70},{130,-46}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TBV,PI_TBV. y) annotation (Line(
          points={{30,-100},{30,-50},{148,-50},{148,-34},{141,-34}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}),
        Diagram(graphics={Text(
              extent={{-170,20},{-126,14}},
              textColor={28,108,200},
              textString="Don't set lower bound lower than -9
"),     Line(points={{-142,16},{-136,12}}, color={28,108,200})}));
    end CS_DirectCoupling_HTGR;

    package ObseleteControlSystems
      model CS_Boiler_03_GMI_TESUC

        extends BaseClasses.Partial_ControlSystem;

        Data.Data_Default data
          annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
        BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
          Charging_Valve_Position_MinMax(min=1e-4)
          annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
        Modelica.Blocks.Math.Product product2
          annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
        TRANSFORM.Controls.LimPID PID5(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=-7.5e-4,
          Ti=30,
          yMin=0.0,
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=0.0)
          annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
        Modelica.Blocks.Math.Add add2
          annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
        Modelica.Blocks.Math.Min min2
          annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
        Modelica.Blocks.Sources.Constant one4(k=1.25)
          annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
        Modelica.Blocks.Sources.Constant one5(k=-0.25)
          annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
        TRANSFORM.Controls.LimPID PID3(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=2e-2,
          Ti=1,
          yMax=1.0,
          yMin=0.0,
          y_start=0.0)
          annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
        Modelica.Blocks.Sources.Trapezoid trapezoid(
          amplitude=200,
          rising=10,
          width=9480,
          falling=10,
          period=18000,
          offset=0.0,
          startTime=0)
          annotation (Placement(transformation(extent={{-58,48},{-46,60}})));
        BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
          Discharging_Valve_Position(min=1e-4) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={12,64})));
        Modelica.Blocks.Math.Product product1
          annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
        Modelica.Blocks.Math.Add add1
          annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
        Modelica.Blocks.Math.Min min1
          annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
        Modelica.Blocks.Sources.Constant one3(k=-0.25)
          annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
        Modelica.Blocks.Sources.Constant one2(k=1.25)
          annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
        Modelica.Blocks.Sources.Constant one1(k=273.15 + 245)
          annotation (Placement(transformation(extent={{-58,-16},{-52,-10}})));
        Modelica.Blocks.Math.Add add3(k1=0.1)
          annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
        Modelica.Blocks.Logical.Switch switch1
          annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
        Modelica.Blocks.Sources.Constant one6(k=0.0)
          annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
        Modelica.Blocks.Sources.Constant one7(k=22.0)
          annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
        TRANSFORM.Controls.LimPID PID2(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=2.5e-2,
          Ti=10,
          yMax=1.0,
          yMin=0.0,
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=0.0)
          annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
      equation

        connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
                -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
        connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
                -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
        connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
                -24.8},{-56.6,-24.8}},                                       color={0,
                0,127}));
        connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
                -30.4},{-80.8,-30.4}},   color={0,0,127}));
        connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
                -61.7,-21}},color={0,0,127}));
        connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
          annotation (Line(
            points={{30,-100},{30,-22},{23.4,-22}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
            points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(trapezoid.y,PID3. u_s)
          annotation (Line(points={{-45.4,54},{-40,54},{-40,58},{-36.8,58}},
                                                           color={0,0,127}));
        connect(product1.y, Discharging_Valve_Position.u)
          annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
        connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
                -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
        connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
                -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
        connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
                74.8},{-36.6,74.8}},                                    color={0,0,
                127}));
        connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
                -36.6,71.2}},                                      color={0,0,127}));
        connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
                {-56.8,62},{-56.8,63.6}},
                                       color={0,0,127}));
        connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
          annotation (Line(
            points={{30,-100},{30,64},{23.4,64}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,-13},{-44.6,-13},{
                -44.6,-17}},color={0,0,127}));
        connect(sensorBus.Charge_Temp, PID5.u_m) annotation (Line(
            points={{-30,-100},{-30,-64},{-102,-64},{-102,-10},{-41,-10},{-41,-13.4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
                -12.8},{-30.6,-12.8}},
                                     color={0,0,127}));
        connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
                -19.2},{-22,-11},{-23.7,-11}},
                                      color={0,0,127}));
        connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
                {-53.9,-1}},          color={0,0,127}));
        connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
                {-53.9,-7}}, color={0,0,127}));
        connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
                -40.6,-3}}, color={0,0,127}));
        connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
                -33.7,-3}}, color={0,0,127}));
        connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
            points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
                -37,0.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.Discharge_Steam, PID3.u_m) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
      annotation(defaultComponentName="changeMe_CS", Icon(graphics={
              Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Change Me")}));
      end CS_Boiler_03_GMI_TESUC;

      model CS_Boiler_03_GMI_TempControl

        extends BaseClasses.Partial_ControlSystem;

        Data.Data_Default data
          annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
        BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
          Charging_Valve_Position_MinMax(min=1e-2, max=1)
          annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
        Modelica.Blocks.Math.Product product2
          annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
        TRANSFORM.Controls.LimPID PID5(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=-7.5e-4,
          Ti=1,
          yMax=1.0,
          yMin=0.001,
          initType=Modelica.Blocks.Types.Init.NoInit,
          y_start=0.0)
          annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
        Modelica.Blocks.Math.Add add2
          annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
        Modelica.Blocks.Math.Min min2
          annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
        Modelica.Blocks.Sources.Constant one4(k=1.25)
          annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
        Modelica.Blocks.Sources.Constant one5(k=-0.25)
          annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
        TRANSFORM.Controls.LimPID PID3(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=2e-4,
          Ti=5,
          yMax=1.0,
          yMin=0.0,
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=1)
          annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
        BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
          Discharging_Valve_Position(min=1e-3) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={12,64})));
        Modelica.Blocks.Math.Product product1
          annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
        Modelica.Blocks.Math.Add add1
          annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
        Modelica.Blocks.Math.Min min1
          annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
        Modelica.Blocks.Sources.Constant one3(k=-0.25)
          annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
        Modelica.Blocks.Sources.Constant one2(k=1.25)
          annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
        Modelica.Blocks.Sources.Constant one1(k=273.15 + 140)
          annotation (Placement(transformation(extent={{-58,-16},{-52,-10}})));
        Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
          annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
        Modelica.Blocks.Logical.Switch switch1
          annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
        Modelica.Blocks.Sources.Constant one6(k=0.0)
          annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
        Modelica.Blocks.Sources.Constant one7(k=915.5)
          annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
        TRANSFORM.Controls.LimPID PID2(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=2.5e-2,
          Ti=10,
          yMax=1,
          yMin=0.01,
          initType=Modelica.Blocks.Types.Init.NoInit,
          y_start=0.0)
          annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
        Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
          annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
      equation

        connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
                -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
        connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
                -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
        connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
                -24.8},{-56.6,-24.8}},                                       color={0,
                0,127}));
        connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
                -30.4},{-80.8,-30.4}},   color={0,0,127}));
        connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
                -61.7,-21}},color={0,0,127}));
        connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
          annotation (Line(
            points={{30,-100},{30,-22},{23.4,-22}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
            points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(product1.y, Discharging_Valve_Position.u)
          annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
        connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
                -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
        connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
                -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
        connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
                74.8},{-36.6,74.8}},                                    color={0,0,
                127}));
        connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
                -36.6,71.2}},                                      color={0,0,127}));
        connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
                {-56.8,62},{-56.8,63.6}},
                                       color={0,0,127}));
        connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
          annotation (Line(
            points={{30,-100},{30,64},{23.4,64}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(one1.y, PID5.u_s) annotation (Line(points={{-51.7,-13},{-44.6,-13},{
                -44.6,-17}},color={0,0,127}));
        connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
                -12.8},{-30.6,-12.8}},
                                     color={0,0,127}));
        connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
                -19.2},{-22,-11},{-23.7,-11}},
                                      color={0,0,127}));
        connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
                {-53.9,-1}},          color={0,0,127}));
        connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
                {-53.9,-7}}, color={0,0,127}));
        connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
                -40.6,-3}}, color={0,0,127}));
        connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
                -33.7,-3}}, color={0,0,127}));
        connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
            points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
                -37,0.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
                -36.8,54},{-36.8,58}}, color={0,0,127}));
        connect(sensorBus.Coolant_Water_temp, PID5.u_m) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-3,-6},{-3,-6}},
            horizontalAlignment=TextAlignment.Right));
      annotation(defaultComponentName="changeMe_CS", Icon(graphics={
              Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Change Me")}));
      end CS_Boiler_03_GMI_TempControl;

      model CS_Boiler_03_GMI_TempControl_2

        extends BaseClasses.Partial_ControlSystem;

        Data.Data_Default data
          annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
        BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
          Charging_Valve_Position_MinMax(min=1e-2, max=1)
          annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
        Modelica.Blocks.Math.Product product2
          annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
        TRANSFORM.Controls.LimPID PID5(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=7.5e-5,
          Ti=5,
          yMax=1.0,
          yMin=0.01,
          initType=Modelica.Blocks.Types.Init.NoInit,
          y_start=0.0)
          annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
        Modelica.Blocks.Math.Add add2
          annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
        Modelica.Blocks.Math.Min min2
          annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
        Modelica.Blocks.Sources.Constant one4(k=5)
          annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
        Modelica.Blocks.Sources.Constant one5(k=-4)
          annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
        TRANSFORM.Controls.LimPID PID3(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=2e-3,
          Ti=20,
          yMax=1.0,
          yMin=0.0,
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=1)
          annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
        BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
          Discharging_Valve_Position(min=1e-2) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={12,64})));
        Modelica.Blocks.Math.Product product1
          annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
        Modelica.Blocks.Math.Add add1
          annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
        Modelica.Blocks.Math.Min min1
          annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
        Modelica.Blocks.Sources.Constant one3(k=-0.25)
          annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
        Modelica.Blocks.Sources.Constant one2(k=1.25)
          annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
        Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
          annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
        Modelica.Blocks.Logical.Switch switch1
          annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
        Modelica.Blocks.Sources.Constant one6(k=0.0)
          annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
        Modelica.Blocks.Sources.Constant one7(k=915.5)
          annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
        TRANSFORM.Controls.LimPID PID2(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=2.5e-2,
          Ti=10,
          yMax=1,
          yMin=0.01,
          initType=Modelica.Blocks.Types.Init.NoInit,
          y_start=0.0)
          annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
        Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
          annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
        Modelica.Blocks.Math.Product product3
          annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
        Modelica.Blocks.Sources.Constant one1(k=26)
          annotation (Placement(transformation(extent={{-118,4},{-108,14}})));
        Modelica.Blocks.Sources.Constant one9(k=0.015)
          annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
        Modelica.Blocks.Math.Add add4
          annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
      equation

        connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
                -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
        connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
                -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
        connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
                -24.8},{-56.6,-24.8}},                                       color={0,
                0,127}));
        connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
                -30.4},{-80.8,-30.4}},   color={0,0,127}));
        connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
                -61.7,-21}},color={0,0,127}));
        connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
          annotation (Line(
            points={{30,-100},{30,-22},{23.4,-22}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
            points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(product1.y, Discharging_Valve_Position.u)
          annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
        connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
                -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
        connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
                -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
        connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
                74.8},{-36.6,74.8}},                                    color={0,0,
                127}));
        connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
                -36.6,71.2}},                                      color={0,0,127}));
        connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
                {-56.8,62},{-56.8,63.6}},
                                       color={0,0,127}));
        connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
          annotation (Line(
            points={{30,-100},{30,64},{23.4,64}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
                -12.8},{-30.6,-12.8}},
                                     color={0,0,127}));
        connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
                -19.2},{-22,-11},{-23.7,-11}},
                                      color={0,0,127}));
        connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
                {-53.9,-1}},          color={0,0,127}));
        connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
                {-53.9,-7}}, color={0,0,127}));
        connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
                -40.6,-3}}, color={0,0,127}));
        connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
                -33.7,-3}}, color={0,0,127}));
        connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
            points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
                -37,0.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
                -36.8,54},{-36.8,58}}, color={0,0,127}));
        connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-3,-6},{-3,-6}},
            horizontalAlignment=TextAlignment.Right));
        connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(one1.y, product3.u1) annotation (Line(points={{-107.5,9},{-107.5,8.4},
                {-86.8,8.4}}, color={0,0,127}));
        connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
                -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
        connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
                14.8},{-70.6,14.8}}, color={0,0,127}));
        connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
                11.2},{-70.6,11.2}}, color={0,0,127}));
      annotation(defaultComponentName="changeMe_CS", Icon(graphics={
              Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Change Me")}));
      end CS_Boiler_03_GMI_TempControl_2;

      model CS_Boiler_03_GMI_TempControl_4

        extends BaseClasses.Partial_ControlSystem;

        Data.Data_Default data
          annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
        BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
          Charging_Valve_Position_MinMax(min=1e-2, max=1)
          annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
        Modelica.Blocks.Math.Product product2
          annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
        TRANSFORM.Controls.LimPID PID5(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=7.5e-5,
          Ti=5,
          yMax=1.0,
          yMin=0.01,
          initType=Modelica.Blocks.Types.Init.NoInit,
          y_start=0.0)
          annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
        Modelica.Blocks.Math.Add add2
          annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
        Modelica.Blocks.Math.Min min2
          annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
        Modelica.Blocks.Sources.Constant one4(k=5)
          annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
        Modelica.Blocks.Sources.Constant one5(k=-4)
          annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
        TRANSFORM.Controls.LimPID PID3(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=2e-3,
          Ti=20,
          yMax=1.0,
          yMin=0.0,
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=1)
          annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
        BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
          Discharging_Valve_Position(min=1e-2) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={12,64})));
        Modelica.Blocks.Math.Product product1
          annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
        Modelica.Blocks.Math.Add add1
          annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
        Modelica.Blocks.Math.Min min1
          annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
        Modelica.Blocks.Sources.Constant one3(k=-0.25)
          annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
        Modelica.Blocks.Sources.Constant one2(k=1.25)
          annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
        Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
          annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
        Modelica.Blocks.Logical.Switch switch1
          annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
        Modelica.Blocks.Sources.Constant one6(k=0.0)
          annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
        Modelica.Blocks.Sources.Constant one7(k=915.5)
          annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
        TRANSFORM.Controls.LimPID PID2(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=2.5e-2,
          Ti=10,
          yMax=1,
          yMin=0.01,
          initType=Modelica.Blocks.Types.Init.NoInit,
          y_start=0.0)
          annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
        Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
          annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
        Modelica.Blocks.Math.Product product3
          annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
        Modelica.Blocks.Sources.Constant one1(k=240 + 273.15)
          annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
        Modelica.Blocks.Sources.Constant one9(k=0.015)
          annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
        Modelica.Blocks.Math.Add add4
          annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
        TRANSFORM.Controls.LimPID PID1(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=-1e-2,
          Ti=20,
          yMax=20,
          yMin=-20,
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=1)
          annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
        Modelica.Blocks.Math.Add add5
          annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
        Modelica.Blocks.Sources.Constant one10(k=28)
          annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
      equation

        connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
                -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
        connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
                -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
        connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
                -24.8},{-56.6,-24.8}},                                       color={0,
                0,127}));
        connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
                -30.4},{-80.8,-30.4}},   color={0,0,127}));
        connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
                -61.7,-21}},color={0,0,127}));
        connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
          annotation (Line(
            points={{30,-100},{30,-22},{23.4,-22}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
            points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(product1.y, Discharging_Valve_Position.u)
          annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
        connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
                -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
        connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
                -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
        connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
                74.8},{-36.6,74.8}},                                    color={0,0,
                127}));
        connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
                -36.6,71.2}},                                      color={0,0,127}));
        connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
                {-56.8,62},{-56.8,63.6}},
                                       color={0,0,127}));
        connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
          annotation (Line(
            points={{30,-100},{30,64},{23.4,64}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
                -12.8},{-30.6,-12.8}},
                                     color={0,0,127}));
        connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
                -19.2},{-22,-11},{-23.7,-11}},
                                      color={0,0,127}));
        connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
                {-53.9,-1}},          color={0,0,127}));
        connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
                {-53.9,-7}}, color={0,0,127}));
        connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
                -40.6,-3}}, color={0,0,127}));
        connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
                -33.7,-3}}, color={0,0,127}));
        connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
            points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
                -37,0.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
                -36.8,54},{-36.8,58}}, color={0,0,127}));
        connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-3,-6},{-3,-6}},
            horizontalAlignment=TextAlignment.Right));
        connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
                -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
        connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
                14.8},{-70.6,14.8}}, color={0,0,127}));
        connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
                11.2},{-70.6,11.2}}, color={0,0,127}));
        connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
                -143.15,8},{-136.8,8}}, color={0,0,127}));
        connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
                -120,20.8},{-116.6,20.8}}, color={0,0,127}));
        connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
                -116.6,17.2}}, color={0,0,127}));
        connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
                -92,8.4},{-86.8,8.4}}, color={0,0,127}));
        connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
            points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-3,-6},{-3,-6}},
            horizontalAlignment=TextAlignment.Right));
      annotation(defaultComponentName="changeMe_CS", Icon(graphics={
              Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Change Me")}));
      end CS_Boiler_03_GMI_TempControl_4;

      model CS_Boiler_03_GMI_TempControl_5

        extends BaseClasses.Partial_ControlSystem;

        Data.Data_Default data
          annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
        BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
          Charging_Valve_Position_MinMax(min=1e-2, max=1)
          annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
        Modelica.Blocks.Math.Product product2
          annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
        TRANSFORM.Controls.LimPID PID5(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=7.5e-5,
          Ti=5,
          yMax=1.0,
          yMin=0.01,
          initType=Modelica.Blocks.Types.Init.NoInit,
          y_start=0.0)
          annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
        Modelica.Blocks.Math.Add add2
          annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
        Modelica.Blocks.Math.Min min2
          annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
        Modelica.Blocks.Sources.Constant one4(k=1.25)
          annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
        Modelica.Blocks.Sources.Constant one5(k=-0.25)
          annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
        TRANSFORM.Controls.LimPID PID3(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=2e-3,
          Ti=20,
          yMax=1.0,
          yMin=0.0,
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=1)
          annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
        BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
          Discharging_Valve_Position(min=1e-2) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={12,64})));
        Modelica.Blocks.Math.Product product1
          annotation (Placement(transformation(extent={{-20,60},{-12,68}})));
        Modelica.Blocks.Math.Add add1
          annotation (Placement(transformation(extent={{-36,70},{-30,76}})));
        Modelica.Blocks.Math.Min min1
          annotation (Placement(transformation(extent={{-56,62},{-48,70}})));
        Modelica.Blocks.Sources.Constant one3(k=-0.25)
          annotation (Placement(transformation(extent={{-52,76},{-46,82}})));
        Modelica.Blocks.Sources.Constant one2(k=1.25)
          annotation (Placement(transformation(extent={{-74,60},{-68,66}})));
        Modelica.Blocks.Math.Add add3(k1=0.1, k2=1)
          annotation (Placement(transformation(extent={{-30,-14},{-24,-8}})));
        Modelica.Blocks.Logical.Switch switch1
          annotation (Placement(transformation(extent={{-50,-6},{-46,-2}})));
        Modelica.Blocks.Sources.Constant one6(k=0.0)
          annotation (Placement(transformation(extent={{-56,-8},{-54,-6}})));
        Modelica.Blocks.Sources.Constant one7(k=915.5)
          annotation (Placement(transformation(extent={{-56,-2},{-54,0}})));
        TRANSFORM.Controls.LimPID PID2(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=2.5e-2,
          Ti=10,
          yMax=1,
          yMin=0.01,
          initType=Modelica.Blocks.Types.Init.NoInit,
          y_start=0.0)
          annotation (Placement(transformation(extent={{-40,0},{-34,-6}})));
        Modelica.Blocks.Sources.Constant one8(k=273.15 + 180)
          annotation (Placement(transformation(extent={{-52,50},{-46,56}})));
        Modelica.Blocks.Math.Product product3
          annotation (Placement(transformation(extent={{-86,2},{-78,10}})));
        Modelica.Blocks.Sources.Constant one1(k=240 + 273.15)
          annotation (Placement(transformation(extent={{-160,2},{-150,12}})));
        Modelica.Blocks.Sources.Constant one9(k=0.015)
          annotation (Placement(transformation(extent={{-86,16},{-80,22}})));
        Modelica.Blocks.Math.Add add4
          annotation (Placement(transformation(extent={{-70,10},{-64,16}})));
        TRANSFORM.Controls.LimPID PID1(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=-1e-2,
          Ti=20,
          yMax=20,
          yMin=-9,
          initType=Modelica.Blocks.Types.Init.InitialOutput,
          y_start=1)
          annotation (Placement(transformation(extent={{-136,4},{-128,12}})));
        Modelica.Blocks.Math.Add add5
          annotation (Placement(transformation(extent={{-116,16},{-110,22}})));
        Modelica.Blocks.Sources.Constant one10(k=28)
          annotation (Placement(transformation(extent={{-148,26},{-142,32}})));
      equation

        connect(product2.y, Charging_Valve_Position_MinMax.u) annotation (Line(points={{-11.7,
                -21},{-8,-21},{-8,-22},{0,-22}},    color={0,0,127}));
        connect(add2.y,product2. u1) annotation (Line(points={{-49.7,-23},{-22,-23},{
                -22,-22},{-18.6,-22},{-18.6,-22.8}},              color={0,0,127}));
        connect(min2.y,add2. u2) annotation (Line(points={{-71.6,-28},{-60,-28},{-60,
                -24.8},{-56.6,-24.8}},                                       color={0,
                0,127}));
        connect(one4.y,min2. u2) annotation (Line(points={{-89.8,-30},{-88,-30},{-88,
                -30.4},{-80.8,-30.4}},   color={0,0,127}));
        connect(add2.u1, one5.y) annotation (Line(points={{-56.6,-21.2},{-56.6,-21},{
                -61.7,-21}},color={0,0,127}));
        connect(actuatorBus.Charge_Valve_Position, Charging_Valve_Position_MinMax.y)
          annotation (Line(
            points={{30,-100},{30,-22},{23.4,-22}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.cold_tank_level, min2.u1) annotation (Line(
            points={{-30,-100},{-30,-108},{-102,-108},{-102,-25.6},{-80.8,-25.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(product1.y, Discharging_Valve_Position.u)
          annotation (Line(points={{-11.6,64},{0,64}}, color={0,0,127}));
        connect(PID3.y,product1. u2) annotation (Line(points={{-27.6,58},{-26,58},{
                -26,52},{-20.8,52},{-20.8,61.6}},                  color={0,0,127}));
        connect(add1.y,product1. u1) annotation (Line(points={{-29.7,73},{-24,73},{
                -24,66.4},{-20.8,66.4}},                     color={0,0,127}));
        connect(one3.y,add1. u1) annotation (Line(points={{-45.7,79},{-40,79},{-40,
                74.8},{-36.6,74.8}},                                    color={0,0,
                127}));
        connect(min1.y,add1. u2) annotation (Line(points={{-47.6,66},{-36.6,66},{
                -36.6,71.2}},                                      color={0,0,127}));
        connect(one2.y,min1. u2) annotation (Line(points={{-67.7,63},{-60,63},{-60,62},
                {-56.8,62},{-56.8,63.6}},
                                       color={0,0,127}));
        connect(actuatorBus.Discharge_Valve_Position, Discharging_Valve_Position.y)
          annotation (Line(
            points={{30,-100},{30,64},{23.4,64}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.hot_tank_level, min1.u1) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,68.4},{-56.8,68.4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(PID5.y, add3.u2) annotation (Line(points={{-37.7,-17},{-34,-17},{-34,
                -12.8},{-30.6,-12.8}},
                                     color={0,0,127}));
        connect(product2.u2, add3.y) annotation (Line(points={{-18.6,-19.2},{-22,
                -19.2},{-22,-11},{-23.7,-11}},
                                      color={0,0,127}));
        connect(switch1.u1, one7.y) annotation (Line(points={{-50.4,-2.4},{-50.4,-1},
                {-53.9,-1}},          color={0,0,127}));
        connect(switch1.u3, one6.y) annotation (Line(points={{-50.4,-5.6},{-50.4,-7},
                {-53.9,-7}}, color={0,0,127}));
        connect(switch1.y, PID2.u_s) annotation (Line(points={{-45.8,-4},{-45.8,-3},{
                -40.6,-3}}, color={0,0,127}));
        connect(add3.u1, PID2.y) annotation (Line(points={{-30.6,-9.2},{-33.7,-9.2},{
                -33.7,-3}}, color={0,0,127}));
        connect(sensorBus.charge_m_flow, PID2.u_m) annotation (Line(
            points={{-30,-100},{-30,-28},{-8,-28},{-8,-24},{-6,-24},{-6,6},{-37,6},{
                -37,0.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.Charging_Logical, switch1.u2) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,-4},{-50.4,-4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(one8.y, PID3.u_s) annotation (Line(points={{-45.7,53},{-45.7,54},{
                -36.8,54},{-36.8,58}}, color={0,0,127}));
        connect(sensorBus.Cold_Tank_Entrance_Temp, PID3.u_m) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,42},{-32,42},{-32,53.2}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-3,-6},{-3,-6}},
            horizontalAlignment=TextAlignment.Right));
        connect(sensorBus.charge_m_flow, PID5.u_m) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,-8},{-41,-8},{-41,-13.4}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.ChargeSteam_mFlow, product3.u2) annotation (Line(
            points={{-30,-100},{-30,-70},{-102,-70},{-102,0},{-86.8,0},{-86.8,3.6}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(add4.y, PID5.u_s) annotation (Line(points={{-63.7,13},{-62,13},{-62,
                -14},{-48,-14},{-48,-17},{-44.6,-17}}, color={0,0,127}));
        connect(one9.y, add4.u1) annotation (Line(points={{-79.7,19},{-76,19},{-76,
                14.8},{-70.6,14.8}}, color={0,0,127}));
        connect(product3.y, add4.u2) annotation (Line(points={{-77.6,6},{-74,6},{-74,
                11.2},{-70.6,11.2}}, color={0,0,127}));
        connect(one1.y, PID1.u_s) annotation (Line(points={{-149.5,7},{-143.15,7},{
                -143.15,8},{-136.8,8}}, color={0,0,127}));
        connect(one10.y, add5.u1) annotation (Line(points={{-141.7,29},{-120,29},{
                -120,20.8},{-116.6,20.8}}, color={0,0,127}));
        connect(PID1.y, add5.u2) annotation (Line(points={{-127.6,8},{-116.6,8},{
                -116.6,17.2}}, color={0,0,127}));
        connect(add5.y, product3.u1) annotation (Line(points={{-109.7,19},{-92,19},{
                -92,8.4},{-86.8,8.4}}, color={0,0,127}));
        connect(sensorBus.Hot_Tank_Temp, PID1.u_m) annotation (Line(
            points={{-30,-100},{-30,-70},{-132,-70},{-132,3.2}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-3,-6},{-3,-6}},
            horizontalAlignment=TextAlignment.Right));
      annotation(defaultComponentName="changeMe_CS", Icon(graphics={
              Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Change Me")}),
          Diagram(graphics={Text(
                extent={{-170,20},{-126,14}},
                textColor={28,108,200},
                textString="Don't set lower bound lower than -9
"),       Line(points={{-142,16},{-136,12}}, color={28,108,200})}));
      end CS_Boiler_03_GMI_TempControl_5;
    end ObseleteControlSystems;
  end ControlSystems;
end SHS_Two_Tank;
