within NHES.Systems.BalanceOfPlant.Turbine;
model Reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA0

  replaceable package LT_HTF =
      Modelica.Media.IdealGases.SingleGases.He annotation (__Dymola_choicesAllMatching=true);

  replaceable package HT_HTF =
      Modelica.Media.IdealGases.SingleGases.He annotation (__Dymola_choicesAllMatching=true);

replaceable package Medium = Modelica.Media.Water.StandardWater annotation (__Dymola_choicesAllMatching=true);

  Fluid.Vessels.Steam_Drum           steam_Drum(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=20000000,
    V_drum=20)
    annotation (Placement(transformation(extent={{22,4},{0,26}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    use_input=true,
    m_flow_nominal=210)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={14,-26})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                      DHX2(
    tau=1,
    NTU=2.7,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=18000000,
    h_start_tube_inlet=2509000,
    h_start_tube_outlet=3409000,
    p_start_shell=5000000,
    use_T_start_shell=true,
    T_start_shell_inlet=1013.15,
    T_start_shell_outlet=873.15,
    h_start_shell_inlet=5.26e6,
    h_start_shell_outlet=3.74e6,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=50000000)                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-34,52})));
  Modelica.Fluid.Interfaces.FluidPort_b LT_out(redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{-128,-118},{-108,-98}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow        pump2(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
      use_input=true)
              annotation (Placement(transformation(extent={{-100,86},{-82,104}})));
  Modelica.Fluid.Interfaces.FluidPort_b HT_SH_out(redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
                                                  annotation (Placement(
        transformation(extent={{-130,42},{-110,62}}), iconTransformation(extent=
           {{-130,42},{-110,62}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-332,-94},{-312,-74}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-24,-66},{-6,-52}})));
  Modelica.Blocks.Sources.RealExpression Tsat(y=
        sensor_pT1.Medium.saturationTemperature(sensor_pT1.p) - 273.15)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-8,-90},{4,-78}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{18,32},{38,52}})));
  Modelica.Blocks.Sources.RealExpression Tsat1(y=
        sensor_pT2.Medium.saturationTemperature(sensor_pT2.p) - 273.15)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{20,52},{32,64}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT3(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-26,-8},{-6,12}})));
  Modelica.Blocks.Sources.RealExpression Tsat2(y=
        sensor_pT3.Medium.saturationTemperature(sensor_pT3.p) - 273.15)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-26,10},{-14,22}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT7(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{14,-88},{30,-76}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT8(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-8,70},{12,90}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT9(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{-80,36},{-60,56}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT10(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{-68,90},{-48,110}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT11(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-16,-44},{4,-24}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=0.9),
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
    redeclare package Shell_medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=800000,
    h_start_tube_inlet=2707800,
    h_start_tube_outlet=3060030,
    p_start_shell=5000000,
    use_T_start_shell=true,
    T_start_shell_inlet=913.15,
    T_start_shell_outlet=743.15,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=500000)                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-34,152})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT12(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{-80,136},{-60,156}})));
  Modelica.Fluid.Interfaces.FluidPort_b HT_RH_out(redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
                                                  annotation (Placement(
        transformation(extent={{-128,130},{-108,150}}), iconTransformation(
          extent={{-128,130},{-108,150}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow        pump1(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
      use_input=true)
              annotation (Placement(transformation(extent={{-90,166},{-72,184}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT13(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
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
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=0.9),
    use_T_start=false,
    T_a_start=823.15,
    T_b_start=313.15,
    h_a_start=3375000,
    m_flow_start=40,
    m_flow_nominal=46,
    use_Stodola=true,
    use_T_nominal=true,
    nUnits=2,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    p_b_start=5000,
    p_outlet_nominal=5000,
    T_nominal=823.15,
    p_a_start=800000,
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
  Fluid.Machines.Pump_MassFlow                 pump_SimpleMassFlow1(
    m_flow_nominal=1,
    use_input=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    eta=0.8)                                             annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={181,-93})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=500000,
    m_flow_nominal=17)                            annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={156,16})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT16(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{224,-70},{244,-50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT17(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{190,20},{210,40}})));
  Modelica.Blocks.Sources.RealExpression Tsat3(y=
        sensor_pT17.Medium.saturationTemperature(sensor_pT17.p) - 273.15)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{190,38},{202,50}})));
  Modelica.Blocks.Sources.RealExpression Tsat4(y=
        sensor_pT14.Medium.saturationTemperature(sensor_pT14.p) - 273.15)
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
    annotation (Placement(transformation(extent={{-124,248},{-112,260}})));
  Fluid.Machines.Pump_MassFlow                 pump_SimpleMassFlow2(
    m_flow_nominal=57,
    use_input=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    eta=0.8)                                             annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={267,-11})));
  replaceable ControlSystems.CS_ReheatOFWH_f
                                           CS(FWH_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=-0.008,
      Ti=15,
      yMin=0.002),delay3(Ti=5))               constrainedby
    ControlSystems.CS_SteamTSlidingP annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-50,258},{-34,274}})));
  replaceable ControlSystems.ED_Dummy
                                  ED annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-26,258},{-10,274}})));
  BaseClasses.SignalSubBus_ActuatorInput
                             actuatorBus
    annotation (Placement(transformation(extent={{-18,216},{22,256}}),
        iconTransformation(extent={{102,190},{142,230}})));
  BaseClasses.SignalSubBus_SensorOutput
                            sensorBus
    annotation (Placement(transformation(extent={{-78,216},{-38,256}}),
        iconTransformation(extent={{42,190},{82,230}})));
  Modelica.Fluid.Interfaces.FluidPort_a HT_SH_in(redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-130,84},{-110,104}}),
        iconTransformation(extent={{-130,92},{-110,112}})));
  Modelica.Fluid.Interfaces.FluidPort_a HT_RH_in(redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-130,166},{-110,186}}),
        iconTransformation(extent={{-126,198},{-106,218}})));
  Modelica.Fluid.Interfaces.FluidPort_a LT_in(redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-128,-24},{-108,-4}}),
        iconTransformation(extent={{-128,-44},{-108,-24}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT6(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{-92,-106},{-72,-86}})));

  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX(
    tau=10,
    NTU=3.0,
    K_tube=100,
    K_shell=50,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium =
        Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=18000000,
    use_T_start_tube=false,
    T_start_tube_inlet=423.15,
    T_start_tube_outlet=573.15,
    h_start_tube_inlet=623706,
    h_start_tube_outlet=1494780,
    p_start_shell=5000000,
    use_T_start_shell=true,
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
        origin={-36,-76})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase DHX1(
    tau=1,
    NTU=5,
    K_tube=100,
    K_shell=50,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium =
        Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
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
    m_start_shell=68)     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-36,-32})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT5(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{-76,-52},{-56,-32}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT4(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{-72,-2},{-52,18}})));
  Modelica.Blocks.Sources.RealExpression Tsat5(y=pump_SimpleMassFlow1.m_flow*
        5.8)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{74,-54},{86,-42}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{50,-26},{62,-14}})));
  Modelica.Blocks.Logical.Greater greater5
    annotation (Placement(transformation(extent={{68,-16},{80,-28}})));
  Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV
    annotation (Placement(transformation(extent={{112,-16},{124,-28}})));
  Modelica.Blocks.Sources.Constant const3(k=205)
    annotation (Placement(transformation(extent={{90,-16},{102,-4}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay3(Ti=200)
    annotation (Placement(transformation(extent={{82,-70},{68,-58}})));
  Modelica.Blocks.Sources.Constant const2(k=1000)
    annotation (Placement(transformation(extent={{52,-2},{64,10}})));
  Modelica.Blocks.Sources.RealExpression Q_in(y=DHX.Q + DHX1.Q + DHX2.Q + DHX3.Q)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-36,200},{-24,212}})));
  Modelica.Blocks.Sources.RealExpression Eta(y=(powerSensor.power -
        pump_SimpleMassFlow1.W - pump_SimpleMassFlow2.W)/Q_in.y)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-36,190},{-24,202}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-0.50,
    duration=500,
    offset=0.5,
    startTime=500)
    annotation (Placement(transformation(extent={{-350,-62},{-338,-50}})));
  Fluid.Pipes.NonLinear_Break nonLinear_Break(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{124,30},{144,50}})));
  TRANSFORM.Controls.LimPID PID2(
    k=1e-2,
    Ti=100,
    k_m=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1.0,
    yMin=0.0,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-216,6},{-208,14}})));
  Modelica.Blocks.Sources.Constant one1(k=220 + 273.15)
    annotation (Placement(transformation(extent={{-244,8},{-238,14}})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    dp_nominal=2000,
    redeclare package Medium = Media.SolarSalt.ConstantPropertyLiquidSolarSalt,
    m_flow_nominal=50)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-64,-74})));

  Fluid.Pipes.NonLinear_Break nonLinear_Break1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{2,-62},{-18,-42}})));
  Fluid.Pipes.NonLinear_Break nonLinear_Break2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{0,26},{-20,46}})));
equation
  connect(steam_Drum.downcomer_port, pump.port_a) annotation (Line(points={{15.4,4},
          {15.4,-6},{14,-6},{14,-16}},   color={0,127,255}));
  connect(sensor_pT2.port, steam_Drum.steam_port)
    annotation (Line(points={{28,32},{28,26},{11,26}}, color={0,127,255}));
  connect(DHX2.Shell_out, sensor_pT9.port)
    annotation (Line(points={{-36,42},{-36,36},{-70,36}}, color={0,127,255}));
  connect(pump.port_b, sensor_pT11.port)
    annotation (Line(points={{14,-36},{8,-36},{8,-44},{-6,-44}},
                                                         color={0,127,255}));
  connect(steamTurbine.portHP, DHX2.Tube_out) annotation (Line(points={{60,70},
          {-16,70},{-16,72},{-30,72},{-30,62}},               color={0,127,255}));
  connect(powerSensor.flange_b,generator1. shaft_a)
    annotation (Line(points={{208,76},{218,76}},
                                               color={0,0,0}));
  connect(sensor_pT12.port, DHX3.Shell_out) annotation (Line(points={{-70,136},
          {-52,136},{-52,142},{-36,142}},
                                        color={0,127,255}));
  connect(sensor_pT13.port, DHX3.Shell_in) annotation (Line(points={{-58,190},{
          -60,190},{-60,176},{-36,176},{-36,162}},
                                       color={0,127,255}));
  connect(steamTurbine.portLP, sensor_pT14.port) annotation (Line(points={{80,70},
          {86,70},{86,50}},                         color={0,127,255}));
  connect(steamTurbine1.portLP, condenser.port_a) annotation (Line(points={{168,82},
          {176,82},{176,102},{280,102},{280,37}},
                                               color={0,127,255}));
  connect(steamTurbine1.portHP, sensor_pT15.port) annotation (Line(points={{148,82},
          {136,82},{136,162},{12,162}},              color={0,127,255}));
  connect(DHX3.Tube_out, steamTurbine1.portHP) annotation (Line(points={{-30,162},
          {136,162},{136,82},{148,82}},         color={0,127,255}));
  connect(LPT_Bypass.port_b, deaerator.steam)
    annotation (Line(points={{166,16},{199,16},{199,-23}},color={0,127,255}));
  connect(deaerator.drain, pump_SimpleMassFlow1.port_a) annotation (Line(points={{206,-38},
          {206,-94},{204,-94},{204,-93},{192,-93}},
        color={0,127,255}));
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
  connect(sensorBus,ED. sensorBus) annotation (Line(
      points={{-58,236},{-20.4,236},{-20.4,258}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus,CS. sensorBus) annotation (Line(
      points={{-58,236},{-58,244},{-44.4,244},{-44.4,258}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus,CS. actuatorBus) annotation (Line(
      points={{2,236},{-39.6,236},{-39.6,258}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus,ED. actuatorBus) annotation (Line(
      points={{2,236},{-15.6,236},{-15.6,258}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Drum_level, steam_Drum.RelLevel) annotation (Line(
      points={{-58,236},{-166,236},{-166,14},{-24,14},{-24,16},{-16,16},{-16,15},
          {-0.22,15}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Deaerator_level, FWTank_level.y) annotation (Line(
      points={{-58,236},{-104,236},{-104,254},{-111.4,254}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Feedwater_Temp, sensor_pT16.T) annotation (Line(
      points={{-58,236},{-166,236},{-166,-128},{248,-128},{248,-62.2},{240,
          -62.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.FW_valve_opening, LPT_Bypass.opening) annotation (Line(
      points={{2,236},{-162,236},{-162,-122},{156,-122},{156,8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.p_inlet_steamTurbine, sensor_pT8.p) annotation (Line(
      points={{-57.9,236.1},{-160,236.1},{-160,236},{-166,236},{-166,112},{24,
          112},{24,82.4},{8,82.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Steam_Temperature, sensor_pT8.T) annotation (Line(
      points={{-58,236},{-166,236},{-166,112},{24,112},{24,77.8},{8,77.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.T_Reheat, sensor_pT15.T) annotation (Line(
      points={{-58,236},{32,236},{32,169.8},{18,169.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(steamTurbine.portHP, sensor_pT8.port)
    annotation (Line(points={{60,70},{2,70}}, color={0,127,255}));
  connect(DHX3.Tube_out, sensor_pT15.port)
    annotation (Line(points={{-30,162},{12,162}}, color={0,127,255}));
  connect(steamTurbine.shaft_b, steamTurbine1.shaft_a)
    annotation (Line(points={{80,76},{148,76}}, color={0,0,0}));
  connect(steamTurbine1.shaft_b, powerSensor.flange_a)
    annotation (Line(points={{168,76},{188,76}}, color={0,0,0}));
  connect(pump2.port_b, DHX2.Shell_in) annotation (Line(points={{-82,95},{-80,95},
          {-80,76},{-36,76},{-36,62}},     color={0,127,255}));
  connect(sensor_pT10.port, DHX2.Shell_in) annotation (Line(points={{-58,90},{
          -60,90},{-60,76},{-36,76},{-36,62}}, color={0,127,255}));
  connect(pump1.port_b, DHX3.Shell_in) annotation (Line(points={{-72,175},{-36,
          175},{-36,162}}, color={0,127,255}));
  connect(HT_RH_in, pump1.port_a) annotation (Line(points={{-120,176},{-103,176},
          {-103,175},{-90,175}}, color={0,127,255}));
  connect(HT_SH_in, pump2.port_a) annotation (Line(points={{-120,94},{-120,95},{
          -100,95}}, color={0,127,255}));
  connect(actuatorBus.RH_mdot, pump1.in_m_flow) annotation (Line(
      points={{2,236},{-162,236},{-162,192},{-80,192},{-80,186},{-81,186},{-81,
          181.57}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

  connect(actuatorBus.SH_mdot, pump2.in_m_flow) annotation (Line(
      points={{2,236},{-162,236},{-162,114},{-94,114},{-94,101.57},{-91,101.57}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(DHX3.Shell_out, HT_RH_out) annotation (Line(points={{-36,142},{-36,140},
          {-52,140},{-52,128},{-100,128},{-100,140},{-118,140}}, color={0,127,255}));
  connect(HT_SH_out, DHX2.Shell_out) annotation (Line(points={{-120,52},{-88,52},
          {-88,28},{-36,28},{-36,42}}, color={0,127,255}));
  connect(LT_in, DHX1.Shell_in) annotation (Line(points={{-118,-14},{-118,-22},{
          -38,-22}}, color={0,127,255}));
  connect(sensor_pT4.port, DHX1.Shell_in) annotation (Line(points={{-62,-2},{-64,
          -2},{-64,-22},{-38,-22}}, color={0,127,255}));
  connect(DHX1.Tube_out, steam_Drum.riser_port) annotation (Line(points={{-32,-22},
          {0,-22},{0,4},{6.6,4}}, color={0,127,255}));
  connect(sensor_pT3.port, DHX1.Tube_out) annotation (Line(points={{-16,-8},{-24,
          -8},{-24,-22},{-32,-22}}, color={0,127,255}));
  connect(DHX.Tube_out, steam_Drum.feed_port) annotation (Line(points={{-32,-66},
          {-10,-66},{-10,-64},{44,-64},{44,15},{22,15}}, color={0,127,255}));
  connect(DHX.Tube_in, pump_SimpleMassFlow1.port_b) annotation (Line(points={{-32,
          -86},{-32,-104},{152,-104},{152,-93},{170,-93}}, color={0,127,255}));
  connect(DHX.Tube_out, sensor_pT1.port)
    annotation (Line(points={{-32,-66},{-15,-66}}, color={0,127,255}));
  connect(sensor_pT7.port, pump_SimpleMassFlow1.port_b) annotation (Line(points=
         {{22,-88},{22,-104},{152,-104},{152,-93},{170,-93}}, color={0,127,255}));
  connect(DHX.Shell_out, LT_out) annotation (Line(points={{-38,-86},{-38,-116},{
          -100,-116},{-100,-108},{-118,-108}}, color={0,127,255}));
  connect(sensor_pT6.port, DHX.Shell_out) annotation (Line(points={{-82,-106},{-84,
          -106},{-84,-116},{-38,-116},{-38,-86}}, color={0,127,255}));
  connect(DHX.Shell_in, DHX1.Shell_out)
    annotation (Line(points={{-38,-66},{-38,-42}}, color={0,127,255}));
  connect(sensor_pT5.port, DHX1.Shell_out) annotation (Line(points={{-66,-52},{-38,
          -52},{-38,-42}}, color={0,127,255}));
  connect(greater5.y,switch_P_setpoint_TCV. u2)
    annotation (Line(points={{80.6,-22},{110.8,-22}}, color={255,0,255}));
  connect(clock.y,greater5. u1) annotation (Line(points={{62.6,-20},{64.7,-20},{
          64.7,-22},{66.8,-22}},
                       color={0,0,127}));
  connect(const2.y,greater5. u2) annotation (Line(points={{64.6,4},{64.6,-8},{66.8,
          -8},{66.8,-17.2}},    color={0,0,127}));
  connect(const3.y,switch_P_setpoint_TCV. u3) annotation (Line(points={{102.6,-10},
          {102.6,-17.2},{110.8,-17.2}},
                                      color={0,0,127}));
  connect(Tsat5.y,switch_P_setpoint_TCV. u1) annotation (Line(points={{86.6,-48},
          {110.8,-48},{110.8,-26.8}},                      color={0,0,127}));
  connect(switch_P_setpoint_TCV.y,delay3. u) annotation (Line(points={{124.6,-22},
          {124.6,-24},{132,-24},{132,-56},{96,-56},{96,-64},{83.4,-64}},
                                        color={0,0,127}));
  connect(delay3.y, pump.in_m_flow) annotation (Line(points={{67.02,-64},{48,-64},
          {48,-36},{32,-36},{32,-26},{21.3,-26}},
                                     color={0,0,127}));
  connect(actuatorBus.Feed_Pump_mFlow, pump_SimpleMassFlow1.inputSignal)
    annotation (Line(
      points={{2,236},{-162,236},{-162,-122},{180,-122},{180,-112},{181,-112},{
          181,-101.03}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.CondPump_m, pump_SimpleMassFlow2.inputSignal) annotation (
     Line(
      points={{2,236},{-162,236},{-162,-122},{268,-122},{268,-70},{267,-70},{
          267,-19.03}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(LPT_Bypass.port_a, nonLinear_Break.port_b) annotation (Line(points={{
          146,16},{148,16},{148,24},{144,24},{144,40}}, color={0,127,255}));
  connect(one1.y,PID2. u_s) annotation (Line(points={{-237.7,11},{-237.7,10},{
          -216.8,10}},             color={0,0,127}));
  connect(sensor_pT6.T,PID2. u_m) annotation (Line(points={{-76,-98.2},{-68,
          -98.2},{-68,-88},{-64,-88},{-64,-112},{-212,-112},{-212,5.2}},
        color={0,0,127}));
  connect(PID2.y,valveLinear. opening) annotation (Line(points={{-207.6,10},{
          -140,10},{-140,-74},{-72,-74}}, color={0,0,127}));
  connect(valveLinear.port_b, LT_out) annotation (Line(points={{-64,-84},{-64,
          -116},{-100,-116},{-100,-108},{-118,-108}}, color={0,127,255}));
  connect(valveLinear.port_a, DHX1.Shell_out) annotation (Line(points={{-64,-64},
          {-52,-64},{-52,-58},{-38,-58},{-38,-42}}, color={0,127,255}));
  connect(pump.port_b, nonLinear_Break1.port_a) annotation (Line(points={{14,
          -36},{14,-48},{12,-48},{12,-52},{2,-52}}, color={0,127,255}));
  connect(nonLinear_Break1.port_b, DHX1.Tube_in) annotation (Line(points={{-18,
          -52},{-32,-52},{-32,-42}}, color={0,127,255}));
  connect(steamTurbine.portLP, nonLinear_Break.port_a) annotation (Line(points=
          {{80,70},{116,70},{116,40},{124,40}}, color={0,127,255}));
  connect(DHX3.Tube_in, nonLinear_Break.port_a) annotation (Line(points={{-30,
          142},{92,142},{92,70},{116,70},{116,40},{124,40}}, color={0,127,255}));
  connect(sensorBus.P_LPT_in, sensor_pT15.p) annotation (Line(
      points={{-58,236},{32,236},{32,174.4},{18,174.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(steam_Drum.steam_port, nonLinear_Break2.port_a)
    annotation (Line(points={{11,26},{11,36},{0,36}}, color={0,127,255}));
  connect(nonLinear_Break2.port_b, DHX2.Tube_in)
    annotation (Line(points={{-20,36},{-30,36},{-30,42}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-280,-180},{300,300}})), Icon(
        coordinateSystem(extent={{-280,-180},{300,300}}), graphics={
                              Bitmap(extent={{-116,-124},{222,212}}, fileName=
              "modelica://NHES/Resources/Images/Systems/subSystem.jpg"),
                  Text(
          extent={{-34,-70},{154,-78}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Balance of Plant"),
        Rectangle(
          extent={{-46.5,3},{46.5,-3}},
          lineColor={0,0,0},
          fillColor={64,164,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={103,118.5},
          rotation=90),
        Rectangle(
          extent={{-52,3},{52,-3}},
          lineColor={0,0,0},
          fillColor={64,164,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={14,145},
          rotation=360),
        Rectangle(
          extent={{-10,2},{10,-2}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={12,84},
          rotation=-90),
        Rectangle(
          extent={{-3.19992,4},{116.803,-4}},
          lineColor={0,0,0},
          origin={37.1999,62},
          rotation=0,
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-38,94},{10,88}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{10,76},{10,46},{40,28},{40,96},{10,76}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{73,54},{83,68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="HPT"),
        Ellipse(
          extent={{150,76},{178,50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-0.601938,3},{23.3253,-3}},
          lineColor={0,0,0},
          origin={126.602,35},
          rotation=0,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.43805,2.7864},{15.9886,-2.7864}},
          lineColor={0,0,0},
          origin={149.214,22.011},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{136,24},{164,-2}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-1.99999,2.0001},{79.9994,-2.0001}},
          lineColor={0,0,0},
          origin={39.9994,-60.0001},
          rotation=180,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{40,-54},{52,-66}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{42,-64},{38,-68},{54,-68},{50,-64},{42,-64}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Ellipse(
          extent={{186,167},{204,149}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{196,167},{194,179}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{186,181},{204,179}},
          lineColor={0,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{197,167},{193,149}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={162,162,0}),
        Text(
          extent={{159,54},{169,68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="G"),
        Text(
          extent={{145,4},{155,18}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="C"),
        Polygon(
          points={{47,-57},{47,-63},{43,-60},{47,-57}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Polygon(
          points={{100,76},{100,46},{130,28},{130,96},{100,76}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{111,54},{126,68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="LPT"),
        Rectangle(
          extent={{52,-20},{78,-30}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{48,-20},{58,-30}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{72,-20},{82,-30}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{60,-16},{70,-26}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-1.91998,3},{70.0814,-3}},
          lineColor={0,0,0},
          origin={81.9186,-25},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.748356,2},{29.9344,-2}},
          lineColor={0,0,0},
          origin={64,-59.9344},
          rotation=90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.373344,2},{13.6267,-2}},
          lineColor={0,0,0},
          origin={64.373,-60},
          rotation=180,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-80,3},{80,-3}},
          lineColor={0,0,0},
          fillColor={64,164,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={65,64},
          rotation=270),
        Rectangle(
          extent={{-11.5,3},{11.5,-3}},
          lineColor={0,0,0},
          fillColor={64,164,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={51,31.5},
          rotation=180),
        Rectangle(
          extent={{-0.619868,1.29302},{24.7948,-1.29301}},
          lineColor={0,0,0},
          origin={151.293,-3.20525},
          rotation=270,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-13,4},{13,-4}},
          lineColor={238,46,47},
          pattern=LinePattern.None,
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={28,108,200},
          origin={-41,-48},
          rotation=90),
        Line(
          points={{-13,0},{13,0}},
          color={255,0,0},
          thickness=1,
          origin={-41,-48},
          rotation=90),
        Rectangle(
          extent={{-13,4},{13,-4}},
          lineColor={238,46,47},
          pattern=LinePattern.None,
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={28,108,200},
          origin={-41,80},
          rotation=90),
        Line(
          points={{-13,0},{13,0}},
          color={255,0,0},
          thickness=1,
          origin={-41,80},
          rotation=90),
        Rectangle(
          extent={{-13,4},{13,-4}},
          lineColor={238,46,47},
          pattern=LinePattern.None,
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={28,108,200},
          origin={-41,156},
          rotation=90),
        Line(
          points={{-13,0},{13,0}},
          color={255,0,0},
          thickness=1,
          origin={-41,156},
          rotation=90),
        Rectangle(
          extent={{-72,4},{72,-4}},
          lineColor={0,0,0},
          fillColor={64,164,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={34,166},
          rotation=360),
        Rectangle(
          extent={{-2.68294,2},{107.316,-2}},
          lineColor={0,0,0},
          origin={-36,-37.3164},
          rotation=90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{112,-18},{124,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{114,-28},{110,-32},{126,-32},{122,-28},{114,-28}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Polygon(
          points={{119,-21},{119,-27},{115,-24},{119,-21}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-108,208},{-44,204}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-110,104},{-46,100}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-114,-32},{-42,-36}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-6,2},{6,-2}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-44,98},
          rotation=-90),
        Rectangle(
          extent={{-18,2},{18,-2}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-46,186},
          rotation=-90),
        Rectangle(
          extent={{-116,144},{-40,140}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-32,-2},{32,2}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-78,52},
          rotation=180),
        Rectangle(
          extent={{9,2},{-9,-2}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-44,59},
          rotation=90),
        Rectangle(
          extent={{-32,-2},{32,2}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-76,-108},
          rotation=180),
        Rectangle(
          extent={{26,2},{-26,-2}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-42,-86},
          rotation=90)}),
    experiment(
      StopTime=200,
      Tolerance=0.005,
      __Dymola_Algorithm="Esdirk34a"),
    conversion(noneFromVersion=""));
end Reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA0;
