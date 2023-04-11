within NHES.Systems.BalanceOfPlant.Turbine;
model Reheat_cycle_drumOFH_cleanup

  Steam_Drum                         steam_Drum(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=20000000,
    V_drum=20)
    annotation (Placement(transformation(extent={{22,4},{0,26}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    use_input=false,                        m_flow_nominal=200)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={14,-26})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                      DHX(
    tau=10,
    NTU=4.5,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.IdealGases.SingleGases.He,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=18000000,
    use_T_start_tube=false,
    T_start_tube_inlet=423.15,
    T_start_tube_outlet=573.15,
    h_start_tube_inlet=623706,
    h_start_tube_outlet=1494780,
    p_start_shell=5000000,
    use_T_start_shell=false,
    T_start_shell_inlet=623.15,
    T_start_shell_outlet=473.15,
    h_start_shell_inlet=3.26e6,
    h_start_shell_outlet=2.46e6,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=1,
    m_start_tube=57,
    m_start_shell=68)                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-78})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                      DHX1(
    tau=1,
    NTU=5,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.IdealGases.SingleGases.He,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=18000000,
    h_start_tube_inlet=1.693e6,
    h_start_tube_outlet=1.948e6,
    p_start_shell=5000000,
    use_T_start_shell=true,
    T_start_shell_inlet=773.15,
    T_start_shell_outlet=647.15,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=61000000,
    m_start_tube=200,
    m_start_shell=68,
    Tube(medium(T(fixed=true))))     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-34})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                      DHX2(
    tau=1,
    NTU=2.7,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.IdealGases.SingleGases.He,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=18000000,
    h_start_tube_inlet=2509000,
    h_start_tube_outlet=3509000,
    p_start_shell=5000000,
    use_T_start_shell=false,
    T_start_shell_inlet=1013.15,
    T_start_shell_outlet=743.15,
    h_start_shell_inlet=5.26e6,
    h_start_shell_outlet=3.74e6,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=50000000)                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-34,52})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    dp_nominal=50000,
    m_flow_nominal=50)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-62,-74})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    use_m_flow_in=true,
    m_flow=1.0,
    T=773.15,
    nPorts=1) annotation (Placement(transformation(extent={{-132,-20},{-114,-2}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=5000000,
    T=473.15,
    nPorts=1) annotation (Placement(transformation(extent={{-128,-118},{-108,
            -98}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary5(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    use_m_flow_in=true,
    m_flow=1.0,
    T=1013.15,
    nPorts=2) annotation (Placement(transformation(extent={{-128,86},{-110,104}})));
  Modelica.Fluid.Sources.Boundary_pT boundary6(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=5000000,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{-132,26},{-112,46}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-240,-80},{-220,-60}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-8,-78},{10,-64}})));
  Modelica.Blocks.Sources.RealExpression Tsat(y=
        sensor_pT1.Medium.saturationTemperature(sensor_pT1.p))
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-8,-90},{4,-78}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{18,32},{38,52}})));
  Modelica.Blocks.Sources.RealExpression Tsat1(y=
        sensor_pT2.Medium.saturationTemperature(sensor_pT2.p))
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{20,52},{32,64}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT3(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-26,-8},{-6,12}})));
  Modelica.Blocks.Sources.RealExpression Tsat2(y=
        sensor_pT3.Medium.saturationTemperature(sensor_pT3.p))
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-26,10},{-14,22}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT4(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-66,-4},{-46,16}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT5(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-66,-44},{-46,-24}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT6(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-86,-108},{-66,-88}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT7(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{14,-88},{30,-76}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT8(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-6,70},{14,90}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT9(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-80,36},{-60,56}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT10(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-68,90},{-48,110}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT11(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-16,-44},{4,-24}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    use_T_start=false,
    h_a_start=3460000,
    h_b_start=2762000,
    m_flow_start=57,
    m_flow_nominal=57,
    use_Stodola=true,
    use_T_nominal=true,
    nUnits=2,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    p_b_start=850000,
    p_outlet_nominal=830000,
    T_nominal=823.15,
    p_a_start=18000000,
    p_inlet_nominal=18000000,
    portLP(p(fixed=false)))
    annotation (Placement(transformation(extent={{60,86},{80,66}})));
  Electrical.Generator      generator1(J=1e4, f_start=60)
    annotation (Placement(transformation(extent={{218,66},{238,86}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{188,86},{208,66}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX3(
    tau=1,
    NTU=2.7,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.IdealGases.SingleGases.He,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=800000,
    h_start_tube_inlet=2707800,
    h_start_tube_outlet=3660030,
    p_start_shell=5000000,
    use_T_start_shell=true,
    T_start_shell_inlet=1013.15,
    T_start_shell_outlet=743.15,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=5000000)                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-34,152})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT12(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-80,136},{-60,156}})));
  Modelica.Fluid.Sources.Boundary_pT boundary7(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=5000000,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{-132,124},{-112,144}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary8(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    use_m_flow_in=true,
    m_flow=1.0,
    T=1013.15,
    nPorts=1) annotation (Placement(transformation(extent={{-126,168},{-108,186}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT13(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-68,190},{-48,210}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT14(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{76,50},{96,30}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT15(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{2,162},{22,182}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    use_T_start=false,
    h_a_start=3375000,
    m_flow_start=0.08,
    m_flow_nominal=46,
    use_Stodola=true,
    use_T_nominal=true,
    nUnits=2,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    p_b_start=5000,
    p_outlet_nominal=5000,
    T_nominal=823.15,
    p_a_start=400000,
    p_inlet_nominal=830000)
    annotation (Placement(transformation(extent={{148,66},{168,86}})));
  TRANSFORM.Fluid.Volumes.IdealCondenser
                                    condenser(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    V_total=10,
    V_liquid_start=0.5,
    set_m_flow=false,
    p=5000)
    annotation (Placement(transformation(extent={{277,20},{297,40}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=1,
    use_input=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                         annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={181,-93})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=50000,
    m_flow_nominal=12)                            annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={156,16})));
  TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=820000,
    use_T_start=true,
    T_start=458.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    nPorts_a=1,
    nPorts_b=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={114,34})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    V=2,
    p_start=830000,
    T_start=458.15)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={114,64})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT16(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{224,-70},{244,-50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT17(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{190,20},{210,40}})));
  Modelica.Blocks.Sources.RealExpression Tsat3(y=
        sensor_pT17.Medium.saturationTemperature(sensor_pT17.p))
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{190,38},{202,50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT18(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{136,-82},{156,-62}})));
  Modelica.Blocks.Sources.RealExpression Tsat4(y=
        sensor_pT14.Medium.saturationTemperature(sensor_pT14.p))
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{78,16},{90,28}})));
  TRANSFORM.Fluid.Volumes.Deaerator deaerator(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
        (
        V_liquid=10,
        length=10,
        r_inner=2,
        th_wall=0.1),
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    level_start=5,
    p_start=650000,
    use_T_start=false,
    d_wall=1000,
    cp_wall=420,
    Twall_start=373.15)
    annotation (Placement(transformation(extent={{216,-40},{196,-20}})));
  Modelica.Blocks.Sources.RealExpression FWTank_level(y=deaerator.level)
    "level"
    annotation (Placement(transformation(extent={{-110,308},{-98,320}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow2(
    m_flow_nominal=57,
    use_input=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                         annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={267,-11})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=-20,
    duration=1000,
    offset=68,
    startTime=5500)
    annotation (Placement(transformation(extent={{-338,-22},{-324,-8}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-280,4},{-260,24}})));
  Modelica.Blocks.Sources.Ramp ramp3(
    height=-10,
    duration=2001,
    offset=0,
    startTime=10500)
    annotation (Placement(transformation(extent={{-334,14},{-320,28}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-236,10},{-216,30}})));
  Modelica.Blocks.Sources.Ramp ramp4(
    height=-5,
    duration=1001,
    offset=0,
    startTime=16500)
    annotation (Placement(transformation(extent={{-334,44},{-320,58}})));
  replaceable ControlSystems.CS_ReheatOFWH CS constrainedby
    ControlSystems.CS_SteamTSlidingP annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-50,334},{-34,350}})));
  replaceable ControlSystems.ED_Dummy
                                  ED annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-26,334},{-10,350}})));
  BaseClasses.SignalSubBus_ActuatorInput
                             actuatorBus
    annotation (Placement(transformation(extent={{-18,292},{22,332}}),
        iconTransformation(extent={{10,80},{50,120}})));
  BaseClasses.SignalSubBus_SensorOutput
                            sensorBus
    annotation (Placement(transformation(extent={{-78,292},{-38,332}}),
        iconTransformation(extent={{-50,80},{-10,120}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=18000000,
    use_T_start=false,
    h_start=1494780)
    annotation (Placement(transformation(extent={{20,-68},{32,-54}})));
equation
  connect(const1.y, valveLinear.opening) annotation (Line(points={{-219,-70},{
          -219,-74},{-70,-74}},      color={0,0,127}));
  connect(steam_Drum.downcomer_port, pump.port_a) annotation (Line(points={{15.4,4},
          {15.4,-6},{14,-6},{14,-16}},   color={0,127,255}));
  connect(sensor_pT2.port, steam_Drum.steam_port)
    annotation (Line(points={{28,32},{28,26},{11,26}}, color={0,127,255}));
  connect(boundary5.ports[1], DHX2.Shell_in) annotation (Line(points={{-110,
          94.775},{-80,94.775},{-80,92},{-76,92},{-76,84},{-36,84},{-36,62}},
        color={0,127,255}));
  connect(DHX2.Shell_out, boundary6.ports[1]) annotation (Line(points={{-36,42},
          {-36,40},{-52,40},{-52,36},{-112,36}},color={0,127,255}));
  connect(steam_Drum.steam_port, DHX2.Tube_in) annotation (Line(points={{11,26},
          {11,36},{-30,36},{-30,42}}, color={0,127,255}));
  connect(DHX1.Shell_in, boundary2.ports[1])
    annotation (Line(points={{-32,-24},{-32,-11},{-114,-11}},
                                                           color={0,127,255}));
  connect(DHX1.Tube_out, steam_Drum.riser_port) annotation (Line(points={{-26,-24},
          {-26,-14},{4,-14},{4,-2},{6,-2},{6,4},{6.6,4}},         color={0,127,
          255}));
  connect(sensor_pT3.port, DHX1.Tube_out) annotation (Line(points={{-16,-8},{
          -16,-14},{-26,-14},{-26,-24}},
                                     color={0,127,255}));
  connect(pump.port_b, DHX1.Tube_in)
    annotation (Line(points={{14,-36},{14,-50},{12,-50},{12,-52},{-26,-52},{-26,
          -44}},                                           color={0,127,255}));
  connect(sensor_pT1.port, DHX.Tube_out) annotation (Line(points={{1,-78},{-16,
          -78},{-16,-68},{-26,-68}}, color={0,127,255}));
  connect(DHX1.Shell_out, DHX.Shell_in)
    annotation (Line(points={{-32,-44},{-32,-68}}, color={0,127,255}));
  connect(DHX.Shell_out, boundary4.ports[1]) annotation (Line(points={{-32,-88},
          {-32,-108},{-108,-108}},color={0,127,255}));
  connect(valveLinear.port_a, DHX.Shell_in) annotation (Line(points={{-62,-64},
          {-62,-58},{-32,-58},{-32,-68}}, color={0,127,255}));
  connect(valveLinear.port_b, DHX.Shell_out) annotation (Line(points={{-62,-84},
          {-62,-94},{-32,-94},{-32,-88}}, color={0,127,255}));
  connect(DHX1.Shell_in, sensor_pT4.port)
    annotation (Line(points={{-32,-24},{-32,-10},{-56,-10},{-56,-4}},
                                                           color={0,127,255}));
  connect(DHX.Shell_out, sensor_pT6.port) annotation (Line(points={{-32,-88},{
          -32,-108},{-76,-108}}, color={0,127,255}));
  connect(sensor_pT5.port, DHX1.Shell_out) annotation (Line(points={{-56,-44},{
          -56,-50},{-32,-50},{-32,-44}}, color={0,127,255}));
  connect(sensor_pT7.port, DHX.Tube_in) annotation (Line(points={{22,-88},{22,
          -94},{-26,-94},{-26,-88}}, color={0,127,255}));
  connect(DHX2.Tube_out, sensor_pT8.port)
    annotation (Line(points={{-30,62},{-30,70},{4,70}},  color={0,127,255}));
  connect(DHX2.Shell_out, sensor_pT9.port)
    annotation (Line(points={{-36,42},{-36,36},{-70,36}}, color={0,127,255}));
  connect(boundary5.ports[2], sensor_pT10.port) annotation (Line(points={{-110,
          95.225},{-80,95.225},{-80,90},{-58,90}},
        color={0,127,255}));
  connect(pump.port_b, sensor_pT11.port)
    annotation (Line(points={{14,-36},{8,-36},{8,-44},{-6,-44}},
                                                         color={0,127,255}));
  connect(steamTurbine.portHP, DHX2.Tube_out) annotation (Line(points={{60,70},
          {-16,70},{-16,72},{-30,72},{-30,62}},               color={0,127,255}));
  connect(powerSensor.flange_b,generator1. shaft_a)
    annotation (Line(points={{208,76},{218,76}},
                                               color={0,0,0}));
  connect(boundary8.ports[1], DHX3.Shell_in) annotation (Line(points={{-108,177},
          {-36,177},{-36,162}},                   color={0,127,255}));
  connect(DHX3.Shell_out, boundary7.ports[1]) annotation (Line(points={{-36,142},
          {-36,140},{-52,140},{-52,134},{-112,134}},
                                                   color={0,127,255}));
  connect(sensor_pT12.port, DHX3.Shell_out) annotation (Line(points={{-70,136},
          {-52,136},{-52,142},{-36,142}},
                                        color={0,127,255}));
  connect(sensor_pT13.port, DHX3.Shell_in) annotation (Line(points={{-58,190},{
          -60,190},{-60,176},{-36,176},{-36,162}},
                                       color={0,127,255}));
  connect(steamTurbine.portLP, sensor_pT14.port) annotation (Line(points={{80,70},
          {86,70},{86,50}},                         color={0,127,255}));
  connect(steamTurbine1.portLP, condenser.port_a) annotation (Line(points={{168,82},
          {180,82},{180,96},{264,96},{264,37},{280,37}},
                                               color={0,127,255}));
  connect(steamTurbine.portLP, tee1.port_1)
    annotation (Line(points={{80,70},{92,70},{92,64},{104,64}},
                                                           color={0,127,255}));
  connect(tee1.port_2, DHX3.Tube_in) annotation (Line(points={{124,64},{132,64},
          {132,136},{-30,136},{-30,142}},
                                   color={0,127,255}));
  connect(tee1.port_3, FeedwaterMixVolume.port_a[1]) annotation (Line(points={{114,54},
          {114,40}},                     color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_b, sensor_pT18.port) annotation (Line(
        points={{170,-93},{146,-93},{146,-82}},       color={0,127,255}));
  connect(steamTurbine1.portHP, sensor_pT15.port) annotation (Line(points={{148,82},
          {136,82},{136,162},{12,162}},              color={0,127,255}));
  connect(DHX3.Tube_out, steamTurbine1.portHP) annotation (Line(points={{-30,162},
          {136,162},{136,82},{148,82}},         color={0,127,255}));
  connect(FeedwaterMixVolume.port_b[1], LPT_Bypass.port_a) annotation (Line(
        points={{114,28},{114,16},{146,16}},             color={0,127,255}));
  connect(LPT_Bypass.port_b, deaerator.steam)
    annotation (Line(points={{166,16},{199,16},{199,-23}},color={0,127,255}));
  connect(deaerator.drain, pump_SimpleMassFlow1.port_a) annotation (Line(points={{206,-38},
          {206,-94},{204,-94},{204,-93},{192,-93}},
        color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_b, DHX.Tube_in) annotation (Line(points={{170,-93},
          {28,-93},{28,-96},{-26,-96},{-26,-88}},                    color={0,
          127,255}));
  connect(pump_SimpleMassFlow2.port_a, condenser.port_b) annotation (Line(
        points={{278,-11},{287,-11},{287,22}},                 color={0,127,255}));
  connect(sensor_pT17.port, deaerator.steam) annotation (Line(points={{200,20},
          {200,-1.5},{199,-1.5},{199,-23}},     color={0,127,255}));
  connect(sensor_pT16.port, pump_SimpleMassFlow1.port_a) annotation (Line(
        points={{234,-70},{234,-93},{192,-93}},
                                         color={0,127,255}));
  connect(pump_SimpleMassFlow2.port_b, deaerator.feed)
    annotation (Line(points={{256,-11},{228,-11},{228,-23},{213,-23}},
                                                          color={0,127,255}));
  connect(ramp3.y, add1.u1) annotation (Line(points={{-319.3,21},{-300.65,21},{
          -300.65,20},{-282,20}}, color={0,0,127}));
  connect(ramp2.y, add1.u2) annotation (Line(points={{-323.3,-15},{-292,-15},{
          -292,8},{-282,8}}, color={0,0,127}));
  connect(add1.y, add2.u2)
    annotation (Line(points={{-259,14},{-238,14}}, color={0,0,127}));
  connect(ramp4.y, add2.u1) annotation (Line(points={{-319.3,51},{-248,51},{
          -248,26},{-238,26}}, color={0,0,127}));
  connect(add2.y, boundary2.m_flow_in) annotation (Line(points={{-215,20},{-215,
          16},{-132,16},{-132,-3.8}},
                                   color={0,0,127}));
  connect(sensorBus,ED. sensorBus) annotation (Line(
      points={{-58,312},{-20.4,312},{-20.4,334}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus,CS. sensorBus) annotation (Line(
      points={{-58,312},{-58,320},{-44.4,320},{-44.4,334}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus,CS. actuatorBus) annotation (Line(
      points={{2,312},{-39.6,312},{-39.6,334}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus,ED. actuatorBus) annotation (Line(
      points={{2,312},{-15.6,312},{-15.6,334}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Drum_level, steam_Drum.RelLevel) annotation (Line(
      points={{-58,312},{-166,312},{-166,14},{-24,14},{-24,16},{-16,16},{-16,15},
          {-0.22,15}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Feed_Pump_mFlow, pump_SimpleMassFlow1.in_m_flow)
    annotation (Line(
      points={{2,312},{-162,312},{-162,-162},{181,-162},{181,-101.03}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Deaerator_level, FWTank_level.y) annotation (Line(
      points={{-58,312},{-58,314},{-97.4,314}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.CondPump_m, pump_SimpleMassFlow2.in_m_flow) annotation (
      Line(
      points={{2,312},{-162,312},{-162,-164},{268,-164},{268,-32},{267,-32},{
          267,-19.03}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Feedwater_Temp, sensor_pT16.T) annotation (Line(
      points={{-58,312},{-166,312},{-166,-164},{250,-164},{250,-62.2},{240,
          -62.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.FW_valve_opening, LPT_Bypass.opening) annotation (Line(
      points={{2,312},{-162,312},{-162,-162},{156,-162},{156,8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.p_inlet_steamTurbine, sensor_pT8.p) annotation (Line(
      points={{-57.9,312.1},{-158,312.1},{-158,312},{-166,312},{-166,112},{24,
          112},{24,82.4},{10,82.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.PartialAdmission, steamTurbine.partialArc) annotation (
      Line(
      points={{2,312},{-162,312},{-162,114},{34,114},{34,80},{65,80}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Steam_Temperature, sensor_pT8.T) annotation (Line(
      points={{-58,312},{-166,312},{-166,112},{24,112},{24,77.8},{10,77.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.SH_mdot, boundary5.m_flow_in) annotation (Line(
      points={{2,312},{-162,312},{-162,114},{-126,114},{-126,108},{-128,108},{
          -128,102.2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.T_Reheat, sensor_pT15.T) annotation (Line(
      points={{-58,312},{32,312},{32,169.8},{18,169.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.RH_mdot, boundary8.m_flow_in) annotation (Line(
      points={{2,312},{2,224},{-136,224},{-136,184.2},{-126,184.2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(DHX.Tube_out, sensor_m_flow.port_a) annotation (Line(points={{-26,-68},
          {-28,-68},{-28,-61},{20,-61}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, steam_Drum.feed_port) annotation (Line(points={
          {32,-61},{40,-61},{40,15},{22,15}}, color={0,127,255}));
  connect(sensorBus.DrumIn_M_dot, sensor_m_flow.m_flow) annotation (Line(
      points={{-58,312},{-166,312},{-166,-164},{32,-164},{32,-58.48},{26,-58.48}},

      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(steamTurbine.portHP, sensor_pT8.port)
    annotation (Line(points={{60,70},{4,70}}, color={0,127,255}));
  connect(DHX3.Tube_out, sensor_pT15.port)
    annotation (Line(points={{-30,162},{12,162}}, color={0,127,255}));
  connect(steamTurbine.shaft_b, steamTurbine1.shaft_a)
    annotation (Line(points={{80,76},{148,76}}, color={0,0,0}));
  connect(steamTurbine1.shaft_b, powerSensor.flange_a)
    annotation (Line(points={{168,76},{188,76}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(extent={{-120,-120},{300,220}})), Icon(
        coordinateSystem(extent={{-120,-120},{300,220}})),
    experiment(
      StopTime=200,
      Tolerance=0.005,
      __Dymola_Algorithm="Esdirk34a"));
end Reheat_cycle_drumOFH_cleanup;
