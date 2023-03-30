within NHES.Systems.BalanceOfPlant.Turbine;
model Drum_boiler4ba

  Steam_Drum                         steam_Drum(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=20000000,
    V_drum=20)
    annotation (Placement(transformation(extent={{0,4},{22,26}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Modelica.Media.Water.StandardWater, m_flow_nominal=200)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={26,-22})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                      DHX(
    tau=10,
    NTU=5,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.IdealGases.SingleGases.He,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=18000000,
    use_T_start_tube=true,
    T_start_tube_inlet=423.15,
    T_start_tube_outlet=573.15,
    h_start_tube_inlet=706000,
    h_start_tube_outlet=706000,
    p_start_shell=5000000,
    use_T_start_shell=true,
    T_start_shell_inlet=623.15,
    T_start_shell_outlet=473.15,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=1,
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
    h_start_tube_inlet=1755270,
    h_start_tube_outlet=1900000,
    p_start_shell=5000000,
    use_T_start_shell=true,
    T_start_shell_inlet=773.15,
    T_start_shell_outlet=647.15,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=61000000,
    m_start_tube=180,
    m_start_shell=68,
    Tube(medium(T(start=400, fixed=true))))
                                     annotation (Placement(transformation(
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
    h_start_tube_inlet=2507800,
    h_start_tube_outlet=3460030,
    p_start_shell=5000000,
    use_T_start_shell=true,
    T_start_shell_inlet=1013.15,
    T_start_shell_outlet=743.15,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=50000000)                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-34,52})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=65,
    T=438.15,
    nPorts=1) annotation (Placement(transformation(extent={{124,-62},{106,-44}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=-2000,
    Ti=90,
    yb=0.01,
    k_s=-1,
    k_m=-1,
    yMax=120,
    yMin=1,
    Ni=0.05,
    xi_start=59)
              annotation (Placement(transformation(extent={{148,-18},{168,2}})));
  Modelica.Blocks.Sources.Constant const(k=0.6)
    annotation (Placement(transformation(extent={{110,-18},{130,2}})));
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
    nPorts=1) annotation (Placement(transformation(extent={{-98,-14},{-80,4}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=5000000,
    T=473.15,
    nPorts=1) annotation (Placement(transformation(extent={{-112,-118},{-92,-98}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary5(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    use_m_flow_in=true,
    m_flow=1.0,
    T=1013.15,
    nPorts=2) annotation (Placement(transformation(extent={{-102,82},{-84,100}})));
  Modelica.Fluid.Sources.Boundary_pT boundary6(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=5000000,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{-116,36},{-96,56}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-112,-78},{-92,-58}})));
  Modelica.Blocks.Sources.Constant const3(k=1)
    annotation (Placement(transformation(extent={{-14,90},{6,110}})));
  Modelica.Blocks.Sources.Constant const2(k=68)
    annotation (Placement(transformation(extent={{-218,-34},{-198,-14}})));
  Modelica.Blocks.Sources.Constant const4(k=40)
    annotation (Placement(transformation(extent={{-168,122},{-148,142}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{46,-56},{66,-36}})));
  Modelica.Blocks.Sources.RealExpression Tsat(y=
        sensor_pT1.Medium.saturationTemperature(sensor_pT1.p))
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{48,-36},{60,-24}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{18,32},{38,52}})));
  Modelica.Blocks.Sources.RealExpression Tsat1(y=
        sensor_pT2.Medium.saturationTemperature(sensor_pT2.p))
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{20,52},{32,64}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT3(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-40,8},{-20,28}})));
  Modelica.Blocks.Sources.RealExpression Tsat2(y=
        sensor_pT3.Medium.saturationTemperature(sensor_pT3.p))
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-56,20},{-44,32}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT4(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-72,-4},{-52,16}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT5(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-66,-44},{-46,-24}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT6(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-86,-108},{-66,-88}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT7(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{20,-84},{40,-64}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT8(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{38,72},{58,92}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT9(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-80,36},{-60,56}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT10(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-68,90},{-48,110}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT11(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-2,-44},{18,-24}})));
  TRANSFORM.Controls.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1,
    Ti=150,
    yb=0.01,
    k_s=-1,
    k_m=-1,
    yMax=120,
    yMin=1,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=40,
    strict=false)
              annotation (Placement(transformation(extent={{-164,88},{-144,108}})));
  Modelica.Blocks.Sources.Constant const5(k=565 + 273.15)
    annotation (Placement(transformation(extent={{-202,86},{-182,106}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay2(Ti=20)
    annotation (Placement(transformation(extent={{-30,126},{-44,138}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    use_T_start=false,
    h_a_start=3375000,
    m_flow_start=0.08,
    m_flow_nominal=57,
    use_Stodola=true,
    use_T_nominal=true,
    nUnits=2,
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    p_b_start=5000,
    p_outlet_nominal=830000,
    T_nominal=823.15,
    p_a_start=400000,
    p_inlet_nominal=18000000)
    annotation (Placement(transformation(extent={{122,52},{142,72}})));
  Electrical.Generator      generator1(J=1e4, f_start=60)
    annotation (Placement(transformation(extent={{188,52},{208,72}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{158,72},{178,52}})));
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
        origin={12,188})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT12(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-34,172},{-14,192}})));
  Modelica.Fluid.Sources.Boundary_pT boundary7(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=5000000,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{-70,172},{-50,192}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary8(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    use_m_flow_in=true,
    m_flow=1.0,
    T=1013.15,
    nPorts=1) annotation (Placement(transformation(extent={{-56,218},{-38,236}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT13(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-22,226},{-2,246}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT14(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{120,86},{140,106}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT15(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{40,248},{60,268}})));
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
    annotation (Placement(transformation(extent={{72,232},{92,252}})));
  TRANSFORM.Controls.LimPID PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1,
    Ti=150,
    yb=0.01,
    k_s=-1,
    k_m=-1,
    yMax=120,
    yMin=1,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=40,
    strict=false)
              annotation (Placement(transformation(extent={{-136,244},{-116,224}})));
  Modelica.Blocks.Sources.Constant const6(k=565 + 273.15)
    annotation (Placement(transformation(extent={{-174,222},{-154,242}})));
  TRANSFORM.Fluid.Volumes.IdealCondenser
                                    condenser(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    V_total=10,
    V_liquid_start=0.5,
    set_m_flow=false,
    p=5000)
    annotation (Placement(transformation(extent={{389,98},{409,118}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    m_flow_nominal=1,
    use_input=true,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
                                                         annotation (
      Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={379,31})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-20,
    duration=2000,
    offset=68,
    startTime=5000)
    annotation (Placement(transformation(extent={{-174,-4},{-160,10}})));
  Modelica.Blocks.Sources.Constant const7(k=18e6)
    annotation (Placement(transformation(extent={{38,38},{58,58}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-0.25,
    duration=2000,
    offset=1,
    startTime=5000)
    annotation (Placement(transformation(extent={{82,40},{96,54}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10000000,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{190,26},{210,46}})));
  TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=700000,
    m_flow_nominal=15)                            annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={322,92})));
  TRANSFORM.Fluid.Volumes.MixingVolume FeedwaterMixVolume(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=800000,
    use_T_start=true,
    T_start=483.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2),
    nPorts_a=1,
    nPorts_b=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={252,96})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_InternalBypass1(R=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={306,60})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    V=2,
    p_start=800000,
    T_start=473.15)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={148,126})));
  Modelica.Blocks.Sources.Constant const8(k=0.7)
    annotation (Placement(transformation(extent={{276,138},{296,158}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase FWH(
    tau=1,
    NTU=4,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=2,
    V_Shell=1,
    p_start_tube=18000000,
    use_T_start_tube=true,
    T_start_tube_inlet=303.15,
    T_start_tube_outlet=423.15,
    h_start_tube_inlet=1755270,
    h_start_tube_outlet=1900000,
    p_start_shell=800000,
    use_T_start_shell=true,
    T_start_shell_inlet=483.15,
    T_start_shell_outlet=323.15,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=1000,
    m_start_tube=60,
    m_start_shell=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={266,34})));
  TRANSFORM.Controls.LimPID Turb_Divert_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-3,
    Ti=10,
    Td=0.1,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{190,200},{210,220}})));
  Modelica.Blocks.Sources.Constant const9(k=273.15 + 150)
    annotation (Placement(transformation(extent={{156,202},{176,222}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT16(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{224,30},{244,50}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay1(Ti=20)
    annotation (Placement(transformation(extent={{286,206},{300,218}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT17(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{284,36},{304,56}})));
equation
  connect(const.y,PID. u_s)
    annotation (Line(points={{131,-8},{146,-8}}, color={0,0,127}));
  connect(const1.y, valveLinear.opening) annotation (Line(points={{-91,-68},{-78,
          -68},{-78,-74},{-70,-74}}, color={0,0,127}));
  connect(steam_Drum.downcomer_port, pump.port_a) annotation (Line(points={{6.6,
          4},{6.6,-6},{26,-6},{26,-12}}, color={0,127,255}));
  connect(sensor_pT2.port, steam_Drum.steam_port)
    annotation (Line(points={{28,32},{28,26},{11,26}}, color={0,127,255}));
  connect(boundary5.ports[1], DHX2.Shell_in) annotation (Line(points={{-84,
          90.775},{-78,90.775},{-78,90},{-74,90},{-74,68},{-36,68},{-36,62}},
        color={0,127,255}));
  connect(DHX2.Shell_out, boundary6.ports[1]) annotation (Line(points={{-36,42},
          {-36,36},{-90,36},{-90,46},{-96,46}}, color={0,127,255}));
  connect(steam_Drum.steam_port, DHX2.Tube_in) annotation (Line(points={{11,26},
          {11,36},{-30,36},{-30,42}}, color={0,127,255}));
  connect(DHX1.Shell_in, boundary2.ports[1])
    annotation (Line(points={{-32,-24},{-32,-5},{-80,-5}}, color={0,127,255}));
  connect(DHX1.Tube_out, steam_Drum.riser_port) annotation (Line(points={{-26,
          -24},{-26,-12},{10,-12},{10,0},{12,0},{12,4},{15.4,4}}, color={0,127,
          255}));
  connect(sensor_pT3.port, DHX1.Tube_out) annotation (Line(points={{-30,8},{-30,
          -18},{-26,-18},{-26,-24}}, color={0,127,255}));
  connect(boundary3.ports[1], DHX.Tube_in) annotation (Line(points={{106,-53},{
          106,-54},{72,-54},{72,-94},{-26,-94},{-26,-88}}, color={0,127,255}));
  connect(DHX.Tube_out, steam_Drum.feed_port) annotation (Line(points={{-26,-68},
          {-26,-50},{-14,-50},{-14,15},{0,15}}, color={0,127,255}));
  connect(pump.port_b, DHX1.Tube_in)
    annotation (Line(points={{26,-32},{26,-44},{-26,-44}}, color={0,127,255}));
  connect(sensor_pT1.port, DHX.Tube_out) annotation (Line(points={{56,-56},{56,
          -62},{-26,-62},{-26,-68}}, color={0,127,255}));
  connect(PID.y, boundary3.m_flow_in) annotation (Line(points={{169,-8},{174,-8},
          {174,-45.8},{124,-45.8}}, color={0,0,127}));
  connect(PID.u_m, steam_Drum.RelLevel) annotation (Line(points={{158,-20},{158,
          -28},{66,-28},{66,15},{22.22,15}}, color={0,0,127}));
  connect(DHX1.Shell_out, DHX.Shell_in)
    annotation (Line(points={{-32,-44},{-32,-68}}, color={0,127,255}));
  connect(DHX.Shell_out, boundary4.ports[1]) annotation (Line(points={{-32,-88},
          {-32,-108},{-92,-108}}, color={0,127,255}));
  connect(valveLinear.port_a, DHX.Shell_in) annotation (Line(points={{-62,-64},
          {-62,-58},{-32,-58},{-32,-68}}, color={0,127,255}));
  connect(valveLinear.port_b, DHX.Shell_out) annotation (Line(points={{-62,-84},
          {-62,-94},{-32,-94},{-32,-88}}, color={0,127,255}));
  connect(DHX1.Shell_in, sensor_pT4.port)
    annotation (Line(points={{-32,-24},{-32,-4},{-62,-4}}, color={0,127,255}));
  connect(DHX.Shell_out, sensor_pT6.port) annotation (Line(points={{-32,-88},{
          -32,-108},{-76,-108}}, color={0,127,255}));
  connect(sensor_pT5.port, DHX1.Shell_out) annotation (Line(points={{-56,-44},{
          -56,-50},{-32,-50},{-32,-44}}, color={0,127,255}));
  connect(sensor_pT7.port, DHX.Tube_in) annotation (Line(points={{30,-84},{30,
          -94},{-26,-94},{-26,-88}}, color={0,127,255}));
  connect(DHX2.Tube_out, sensor_pT8.port)
    annotation (Line(points={{-30,62},{-30,72},{48,72}}, color={0,127,255}));
  connect(DHX2.Shell_out, sensor_pT9.port)
    annotation (Line(points={{-36,42},{-36,36},{-70,36}}, color={0,127,255}));
  connect(boundary5.ports[2], sensor_pT10.port) annotation (Line(points={{-84,
          91.225},{-78,91.225},{-78,90},{-74,90},{-74,84},{-58,84},{-58,90}},
        color={0,127,255}));
  connect(pump.port_b, sensor_pT11.port)
    annotation (Line(points={{26,-32},{26,-44},{8,-44}}, color={0,127,255}));
  connect(const5.y, PID1.u_s) annotation (Line(points={{-181,96},{-174,96},{
          -174,98},{-166,98}}, color={0,0,127}));
  connect(sensor_pT8.T, delay2.u) annotation (Line(points={{54,79.8},{64,79.8},
          {64,132},{-28.6,132}}, color={0,0,127}));
  connect(delay2.y, PID1.u_m) annotation (Line(points={{-44.98,132},{-130,132},
          {-130,74},{-154,74},{-154,86}}, color={0,0,127}));
  connect(steamTurbine.portHP, DHX2.Tube_out) annotation (Line(points={{122,68},
          {64,68},{64,70},{42,70},{42,72},{-30,72},{-30,62}}, color={0,127,255}));
  connect(powerSensor.flange_b,generator1. shaft_a)
    annotation (Line(points={{178,62},{188,62}},
                                               color={0,0,0}));
  connect(steamTurbine.shaft_b, powerSensor.flange_a)
    annotation (Line(points={{142,62},{158,62}}, color={0,0,0}));
  connect(PID1.y, boundary5.m_flow_in) annotation (Line(points={{-143,98},{
          -122.5,98},{-122.5,98.2},{-102,98.2}}, color={0,0,127}));
  connect(boundary8.ports[1], DHX3.Shell_in) annotation (Line(points={{-38,227},
          {-30,227},{-30,204},{10,204},{10,198}}, color={0,127,255}));
  connect(DHX3.Shell_out, boundary7.ports[1]) annotation (Line(points={{10,178},
          {10,164},{-44,164},{-44,182},{-50,182}}, color={0,127,255}));
  connect(sensor_pT12.port, DHX3.Shell_out) annotation (Line(points={{-24,172},
          {-24,164},{10,164},{10,178}}, color={0,127,255}));
  connect(sensor_pT13.port, DHX3.Shell_in) annotation (Line(points={{-12,226},{
          -12,204},{10,204},{10,198}}, color={0,127,255}));
  connect(steamTurbine.portLP, sensor_pT14.port) annotation (Line(points={{142,
          68},{148,68},{148,80},{130,80},{130,86}}, color={0,127,255}));
  connect(DHX3.Tube_out, sensor_pT15.port)
    annotation (Line(points={{16,198},{16,248},{50,248}}, color={0,127,255}));
  connect(DHX3.Tube_out, steamTurbine1.portHP)
    annotation (Line(points={{16,198},{16,248},{72,248}}, color={0,127,255}));
  connect(steamTurbine1.shaft_b, steamTurbine.shaft_a) annotation (Line(points=
          {{92,242},{100,242},{100,62},{122,62}}, color={0,0,0}));
  connect(const6.y, PID2.u_s) annotation (Line(points={{-153,232},{-153,234},{
          -138,234}}, color={0,0,127}));
  connect(PID2.y, boundary8.m_flow_in) annotation (Line(points={{-115,234},{
          -85.5,234},{-85.5,234.2},{-56,234.2}}, color={0,0,127}));
  connect(sensor_pT15.T, PID2.u_m) annotation (Line(points={{56,255.8},{84,
          255.8},{84,260},{-126,260},{-126,246}}, color={0,0,127}));
  connect(steamTurbine1.portLP, condenser.port_a) annotation (Line(points={{92,
          248},{384,248},{384,115},{392,115}}, color={0,127,255}));
  connect(condenser.port_b, pump_SimpleMassFlow1.port_a)
    annotation (Line(points={{399,100},{399,31},{390,31}}, color={0,127,255}));
  connect(ramp.y, boundary2.m_flow_in) annotation (Line(points={{-159.3,3},{
          -158,3},{-158,2.2},{-98,2.2}}, color={0,0,127}));
  connect(ramp1.y, steamTurbine.partialArc) annotation (Line(points={{96.7,47},
          {116,47},{116,58},{127,58}}, color={0,0,127}));
  connect(R_InternalBypass1.port_a,LPT_Bypass. port_a)
    annotation (Line(points={{306,67},{306,92},{312,92}},  color={0,127,255}));
  connect(LPT_Bypass.port_b, condenser.port_a) annotation (Line(points={{332,92},
          {384,92},{384,115},{392,115}}, color={0,127,255}));
  connect(steamTurbine.portLP, tee1.port_1)
    annotation (Line(points={{142,68},{148,68},{148,116}}, color={0,127,255}));
  connect(tee1.port_2, DHX3.Tube_in) annotation (Line(points={{148,136},{148,
          160},{16,160},{16,178}}, color={0,127,255}));
  connect(tee1.port_3, FeedwaterMixVolume.port_a[1]) annotation (Line(points={{
          158,126},{252,126},{252,102}}, color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_b, FWH.Tube_out) annotation (Line(points={{
          368,31},{366,31},{366,30},{276,30}}, color={0,127,255}));
  connect(FWH.Tube_in, boundary1.ports[1]) annotation (Line(points={{256,30},{
          216,30},{216,36},{210,36}}, color={0,127,255}));
  connect(R_InternalBypass1.port_b, FWH.Shell_in)
    annotation (Line(points={{306,53},{306,36},{276,36}}, color={0,127,255}));
  connect(FWH.Shell_out, FeedwaterMixVolume.port_b[1]) annotation (Line(points=
          {{256,36},{250,36},{250,80},{252,80},{252,90}}, color={0,127,255}));
  connect(const9.y,Turb_Divert_Valve. u_s)
    annotation (Line(points={{177,212},{177,210},{188,210}},
                                                     color={0,0,127}));
  connect(FWH.Tube_in, sensor_pT16.port)
    annotation (Line(points={{256,30},{234,30}}, color={0,127,255}));
  connect(pump_SimpleMassFlow1.in_m_flow, PID.y)
    annotation (Line(points={{379,22.97},{379,-8},{169,-8}}, color={0,0,127}));
  connect(delay1.y, LPT_Bypass.opening) annotation (Line(points={{300.98,212},{
          322,212},{322,100}}, color={0,0,127}));
  connect(Turb_Divert_Valve.u_m, sensor_pT16.T) annotation (Line(points={{200,
          198},{200,74},{186,74},{186,46},{184,46},{184,20},{240,20},{240,37.8}},
        color={0,0,127}));
  connect(Turb_Divert_Valve.y, delay1.u) annotation (Line(points={{211,210},{
          214,210},{214,212},{284.6,212}}, color={0,0,127}));
  connect(R_InternalBypass1.port_b, sensor_pT17.port)
    annotation (Line(points={{306,53},{306,36},{294,36}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-120,-120},{100,100}})), Icon(
        coordinateSystem(extent={{-120,-120},{100,100}})),
    experiment(StopTime=1000, __Dymola_Algorithm="Esdirk34a"));
end Drum_boiler4ba;
