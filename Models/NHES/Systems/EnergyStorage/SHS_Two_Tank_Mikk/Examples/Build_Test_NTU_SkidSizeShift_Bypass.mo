within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Examples;
model Build_Test_NTU_SkidSizeShift_Bypass "Using old model to start new one"
  extends Modelica.Icons.Example;

  Two_Tank_SHS_System_NewUpdate_Bypasses
                          two_Tank_SHS_System_NewUpdate_Bypasses(
    redeclare
      NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Controls.CS_Experimental_02_bypass
      CS(m_flow_rate_steam_trigger=0.08),
    redeclare replaceable Data.Data_SHS data(
      ht_level_max=2,
      ht_area=1.4,
      ht_init_level=1.0,
      hot_tank_init_temp=633.15,
      cold_tank_level_max=2,
      cold_tank_area=1.4,
      cold_tank_init_level=1.0,
      cold_tank_init_temp=453.15,
      m_flow_ch_min=0.1,
      CHX_NTU=2.0,
      CHX_v_tube=0.2,
      CHX_v_shell=0.2,
      DHX_NTU=2.0,
      DHX_K_tube(unit="1/m4"),
      DHX_K_shell(unit="1/m4"),
      DHX_v_tube=0.2,
      DHX_v_shell=0.2,
      DHX_use_T_start_shell=true,
      DHX_T_start_shell_inlet=423.15,
      DHX_T_start_shell_outlet=423.15,
      DHX_h_start_shell_inlet=660e3,
      DHX_h_start_shell_outlet=660e3,
      DHX_m_flow_start_shell=25,
      DHX_Q_init=-1,
      CHX_use_T_start_tube=true,
      CHX_T_start_tube_inlet=633.15,
      CHX_T_start_tube_outlet=633.15,
      CHX_use_T_start_shell=true,
      CHX_T_start_shell_inlet=598.15,
      CHX_T_start_shell_outlet=453.15,
      dis_pump_head_curve={0,10,25},
      charge_pump_head_curve={0,1,2.5},
      ctdp_area=0.05,
      ctdp_length=0.5,
      ctvolume_volume=0.025,
      disvalve_m_flow_nom=2.0,
      disvalve_dp_nominal=10000,
      htdp_area=0.05,
      htdp_length=0.5),
    redeclare package Storage_Medium =
        NHES.Media.HITEC.ConstantPropertyLiquidHITEC,
    redeclare package Charging_Medium =
        TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    m_flow_min=0.1,
    tank_height=2,
    Produced_steam_flow=valveLinear.port_a.m_flow)
    annotation (Placement(transformation(extent={{-48,-50},{48,52}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Inlet_T(redeclare package
      Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT)
    annotation (Placement(transformation(extent={{-92,-8},{-72,-28}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary5(
    redeclare package Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    use_m_flow_in=true,
    m_flow=8,
    T=723.15,
    nPorts=1) annotation (Placement(transformation(extent={{-142,-28},{-122,-8}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare package
      Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT)
    annotation (Placement(transformation(extent={{-78,20},{-98,42}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    p=5000000,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{-148,22},{-128,42}})));
  Modelica.Blocks.Sources.RealExpression     realExpression1(y=2.4)
    annotation (Placement(transformation(extent={{-178,-20},{-158,0}})));

  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Modelica.Media.Water.StandardWater, m_flow_nominal=5.0)
    annotation (Placement(transformation(extent={{108,0},{88,20}})));
  TRANSFORM.Fluid.Volumes.BoilerDrum boilerDrum(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
        (
        length=2.0,
        r_inner=2.5,
        th_wall=0.03),
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    level_start=1.62,
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
    annotation (Placement(transformation(extent={{8,62},{28,82}})));
  Modelica.Blocks.Sources.Constant const1(k=5e5)
    annotation (Placement(transformation(extent={{2,102},{22,122}})));
  TRANSFORM.Controls.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-3,
    Ti=15,
    yMax=1.0,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0)
              annotation (Placement(transformation(extent={{48,102},{68,122}})));
  Modelica.Blocks.Sources.RealExpression Boiler_Pressure(y=boilerDrum.medium_vapor.p)
    annotation (Placement(transformation(extent={{28,82},{48,102}})));
  Modelica.Blocks.Sources.RealExpression Level_Boiler(y=boilerDrum.level)
    annotation (Placement(transformation(extent={{124,52},{144,72}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=0.1,
    yMin=0.0,
    wp=200)   annotation (Placement(transformation(extent={{164,74},{184,94}})));
  Modelica.Blocks.Sources.Constant const(k=boilerDrum.geometry.length*0.8)
    annotation (Placement(transformation(extent={{128,74},{148,94}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid1(
    amplitude=-120,
    rising=5,
    falling=5,
    offset=0)
    annotation (Placement(transformation(extent={{184,30},{164,50}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=(0.05)*(boilerDrum.geometry.length),
      uHigh=0.15*(boilerDrum.geometry.length),
    pre_y_start=true)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={186,-22})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=boilerDrum.geometry.length
         - boilerDrum.level)
    annotation (Placement(transformation(extent={{126,-58},{146,-38}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={192,12})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{154,-14},{134,6}})));
equation
//  two_Tank_SHS_System_NewUpdate.Charging_Trigger = realExpression1.u;
//  two_Tank_SHS_System_NTU.y = triggeredTrapezoid.u;
 // two_Tank_SHS_System.Produced_steam_flow = valveLinear.port_a.m_flow;
  connect(boundary5.ports[1], CHX_Inlet_T.port_a) annotation (Line(points={{-122,
          -18},{-92,-18}},            color={0,127,255}));
  connect(CHX_Inlet_T.port_b, two_Tank_SHS_System_NewUpdate_Bypasses.port_ch_a)
    annotation (Line(points={{-72,-18},{-50,-18},{-50,-30.62},{-47.04,-30.62}},
        color={0,127,255}));
  connect(CHX_Discharge_T.port_a, two_Tank_SHS_System_NewUpdate_Bypasses.port_ch_b)
    annotation (Line(points={{-78,31},{-58,31},{-58,28.54},{-47.04,28.54}},
        color={0,127,255}));
  connect(CHX_Discharge_T.port_b, boundary1.ports[1])
    annotation (Line(points={{-98,31},{-112,31},{-112,32},{-128,32}},
                                                   color={0,127,255}));
  connect(boundary5.m_flow_in, realExpression1.y)
    annotation (Line(points={{-142,-10},{-157,-10}}, color={0,0,127}));
  connect(pump.port_a,boilerDrum. downcomerPort) annotation (Line(points={{108,10},
          {116,10},{116,24},{102,24},{102,32.2},{101.3,32.2}},          color={0,
          127,255}));
  connect(boilerDrum.steamPort,valveLinear. port_a) annotation (Line(points={{101.3,
          49.36},{102,49.36},{102,72},{72,72}},     color={0,127,255}));
  connect(boundary3.ports[1], boilerDrum.feedwaterPort)
    annotation (Line(points={{124,41},{104,41}}, color={0,127,255}));
  connect(PID1.u_s,const1. y)
    annotation (Line(points={{46,112},{23,112}},  color={0,0,127}));
  connect(PID1.y, valveLinear.opening) annotation (Line(points={{69,112},{88,112},
          {88,86},{64,86},{64,80},{62,80}}, color={0,0,127}));
  connect(Boiler_Pressure.y, PID1.u_m)
    annotation (Line(points={{49,92},{58,92},{58,100}}, color={0,0,127}));
  connect(const.y, PID.u_s)
    annotation (Line(points={{149,84},{162,84}}, color={0,0,127}));
  connect(Level_Boiler.y, PID.u_m) annotation (Line(points={{145,62},{174,62},{
          174,72}},      color={0,0,127}));
  connect(realExpression.y, hysteresis.u) annotation (Line(points={{147,-48},{
          186,-48},{186,-34}},   color={0,0,127}));
  connect(valveLinear.port_b, boundary.ports[1])
    annotation (Line(points={{52,72},{28,72}},        color={0,127,255}));
  connect(pump.port_b, two_Tank_SHS_System_NewUpdate_Bypasses.port_dch_a)
    annotation (Line(points={{88,10},{56,10},{56,30.58},{47.04,30.58}}, color={
          0,127,255}));
  connect(boilerDrum.riserPort, two_Tank_SHS_System_NewUpdate_Bypasses.port_dch_b)
    annotation (Line(points={{88.7,32.2},{80,32.2},{80,-30.62},{48,-30.62}},
        color={0,127,255}));
  connect(hysteresis.y, not1.u) annotation (Line(points={{186,-11},{186,-6},{192,
          -6},{192,0}}, color={255,0,255}));
  connect(not1.y, triggeredTrapezoid1.u) annotation (Line(points={{192,23},{192,
          32},{194,32},{194,40},{186,40}}, color={255,0,255}));
  connect(add.u1, PID.y) annotation (Line(points={{156,2},{164,2},{164,24},{158,
          24},{158,60},{194,60},{194,84},{185,84}}, color={0,0,127}));
  connect(add.u2, triggeredTrapezoid1.y) annotation (Line(points={{156,-10},{164,
          -10},{164,-22},{128,-22},{128,26},{154,26},{154,40},{163,40}}, color={
          0,0,127}));
  connect(add.y, boundary3.m_flow_in) annotation (Line(points={{133,-4},{126,-4},
          {126,24},{148,24},{148,48.2},{142,48.2}}, color={0,0,127}));
  annotation (experiment(
      StopTime=86400,
      Interval=37,
      Tolerance=0.001,
      __Dymola_Algorithm="Esdirk45a"));
end Build_Test_NTU_SkidSizeShift_Bypass;
