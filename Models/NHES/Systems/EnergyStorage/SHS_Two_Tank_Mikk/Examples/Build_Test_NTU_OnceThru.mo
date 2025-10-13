within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Examples;
model Build_Test_NTU_OnceThru "Using old model to start new one"
  extends Modelica.Icons.Example;

  Two_Tank_SHS_System_NewUpdate
                          two_Tank_SHS_System_NewUpdate(
    redeclare
      NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Controls.CS_Experimental_03
      CS,
    redeclare replaceable Data.Data_SHS data(
      ht_level_max=2,
      ht_area=100,
      hot_tank_init_temp=633.15,
      cold_tank_level_max=2,
      cold_tank_area=100,
      cold_tank_init_temp=453.15,
      CHX_NTU=1.0,
      CHX_v_tube=5,
      CHX_v_shell=0.5,
      DHX_K_tube(unit="1/m4"),
      DHX_K_shell(unit="1/m4"),
      DHX_v_tube=5,
      DHX_v_shell=5,
      DHX_use_T_start_shell=false,
      DHX_T_start_shell_inlet=353.15,
      DHX_T_start_shell_outlet=448.15,
      DHX_h_start_shell_inlet=600e3,
      DHX_h_start_shell_outlet=2000e3,
      DHX_m_flow_start_shell=25,
      DHX_Q_init=-1,
      CHX_use_T_start_shell=true,
      CHX_T_start_shell_inlet=598.15,
      CHX_T_start_shell_outlet=453.15,
      dis_pump_head_curve={0,10,25},
      charge_pump_head_curve={0,1,2.5},
      disvalve_dp_nominal=10000),
    redeclare package Charging_Medium =
        TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    m_flow_min=0.1,
    tank_height=2,
    Produced_steam_flow=DHX_Discharge_T.T)
    annotation (Placement(transformation(extent={{-50,-48},{46,54}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Inlet_T(redeclare package
      Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT)
    annotation (Placement(transformation(extent={{-92,-8},{-72,-28}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary5(
    redeclare package Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    use_m_flow_in=true,
    m_flow=8,
    T=713.15,
    nPorts=1) annotation (Placement(transformation(extent={{-142,-28},{-122,-8}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare package
      Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT)
    annotation (Placement(transformation(extent={{-94,6},{-114,26}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    p=5000000,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{-148,6},{-128,26}})));
  Modelica.Blocks.Sources.RealExpression     realExpression1(y=2.4)
    annotation (Placement(transformation(extent={{-178,-20},{-158,0}})));

  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    use_input=true,
    m_flow_nominal=0.2)
    annotation (Placement(transformation(extent={{110,0},{90,20}})));
  TRANSFORM.Fluid.Volumes.DumpTank   tank(
    redeclare package Medium = Modelica.Media.Water.WaterIF97_pT,
    A=3,
    p_surface=400000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    p_start=500000,
    level_start=4.0,
    h_start=400e3)
    annotation (Placement(transformation(extent={{86,30},{106,48}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=1.0,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{142,32},{124,50}})));
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
  Modelica.Blocks.Sources.RealExpression Boiler_Pressure(y=tank.port_b.p)
    annotation (Placement(transformation(extent={{28,82},{48,102}})));
  Modelica.Blocks.Sources.RealExpression Level_Boiler(y=tank.level)
    annotation (Placement(transformation(extent={{124,52},{144,72}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=0.1,
    yMin=0.0,
    wp=200)   annotation (Placement(transformation(extent={{166,76},{186,96}})));
  Modelica.Blocks.Sources.Constant const(k=2)
    annotation (Placement(transformation(extent={{128,76},{148,96}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid1(
    amplitude=-120,
    rising=5,
    falling=5,
    offset=0)
    annotation (Placement(transformation(extent={{184,30},{164,50}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=(0.1)*(const.k), uHigh=0.3
        *(const.k)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={186,-22})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=2*const.k - tank.level)
    annotation (Placement(transformation(extent={{128,-54},{148,-34}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={192,12})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{154,-14},{134,6}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort DHX_Discharge_T(redeclare package
      Medium = Modelica.Media.Water.WaterIF97_pT)
    annotation (Placement(transformation(extent={{40,64},{20,84}})));
  Modelica.Blocks.Sources.Trapezoid          trapezoid(
    amplitude=-0.1995,
    rising=30,
    width=7170,
    falling=30,
    period=10770,
    offset=0.2,
    startTime=10800)
    annotation (Placement(transformation(extent={{102,-50},{82,-30}})));
equation
//  two_Tank_SHS_System_NewUpdate.Charging_Trigger = realExpression1.u;
//  two_Tank_SHS_System_NTU.y = triggeredTrapezoid.u;
 // two_Tank_SHS_System.Produced_steam_flow = valveLinear.port_a.m_flow;
  connect(boundary5.ports[1], CHX_Inlet_T.port_a) annotation (Line(points={{-122,
          -18},{-92,-18}},            color={0,127,255}));
  connect(CHX_Inlet_T.port_b, two_Tank_SHS_System_NewUpdate.port_ch_a)
    annotation (Line(points={{-72,-18},{-50,-18},{-50,-28.62},{-49.04,-28.62}},
        color={0,127,255}));
  connect(CHX_Discharge_T.port_a, two_Tank_SHS_System_NewUpdate.port_ch_b)
    annotation (Line(points={{-94,16},{-84,16},{-84,22},{-68,22},{-68,32},{-49.04,
          32},{-49.04,30.54}}, color={0,127,255}));
  connect(CHX_Discharge_T.port_b, boundary1.ports[1])
    annotation (Line(points={{-114,16},{-128,16}}, color={0,127,255}));
  connect(boundary5.m_flow_in, realExpression1.y)
    annotation (Line(points={{-142,-10},{-157,-10}}, color={0,0,127}));
  connect(PID1.u_s,const1. y)
    annotation (Line(points={{46,112},{23,112}},  color={0,0,127}));
  connect(Boiler_Pressure.y, PID1.u_m)
    annotation (Line(points={{49,92},{58,92},{58,100}}, color={0,0,127}));
  connect(const.y, PID.u_s)
    annotation (Line(points={{149,86},{164,86}}, color={0,0,127}));
  connect(Level_Boiler.y, PID.u_m) annotation (Line(points={{145,62},{174,62},{174,
          74},{176,74}}, color={0,0,127}));
  connect(realExpression.y, hysteresis.u) annotation (Line(points={{149,-44},{
          186,-44},{186,-34}},   color={0,0,127}));
  connect(pump.port_b, two_Tank_SHS_System_NewUpdate.port_dch_a) annotation (
      Line(points={{90,10},{56,10},{56,32.58},{45.04,32.58}}, color={0,127,255}));
  connect(hysteresis.y, not1.u) annotation (Line(points={{186,-11},{186,-6},{
          192,-6},{192,0}}, color={255,0,255}));
  connect(not1.y, triggeredTrapezoid1.u) annotation (Line(points={{192,23},{192,
          32},{194,32},{194,40},{186,40}}, color={255,0,255}));
  connect(add.u1, PID.y) annotation (Line(points={{156,2},{164,2},{164,24},{158,
          24},{158,60},{194,60},{194,86},{187,86}}, color={0,0,127}));
  connect(add.u2, triggeredTrapezoid1.y) annotation (Line(points={{156,-10},{
          164,-10},{164,-22},{128,-22},{128,26},{154,26},{154,40},{163,40}},
        color={0,0,127}));
  connect(add.y, boundary3.m_flow_in) annotation (Line(points={{133,-4},{126,-4},
          {126,24},{148,24},{148,48.2},{142,48.2}}, color={0,0,127}));
  connect(boundary3.ports[1], tank.port_a) annotation (Line(points={{124,41},{
          112,41},{112,58},{96,58},{96,46.56}}, color={0,127,255}));
  connect(tank.port_b, pump.port_a) annotation (Line(points={{96,31.44},{96,22},
          {120,22},{120,10},{110,10}}, color={0,127,255}));
  connect(DHX_Discharge_T.port_b, boundary.ports[1])
    annotation (Line(points={{20,74},{6,74}}, color={0,127,255}));
  connect(DHX_Discharge_T.port_a, two_Tank_SHS_System_NewUpdate.port_dch_b)
    annotation (Line(points={{40,74},{70,74},{70,-28},{46,-28},{46,-28.62}},
        color={0,127,255}));
  connect(trapezoid.y, pump.in_m_flow) annotation (Line(points={{81,-40},{78,
          -40},{78,17.3},{100,17.3}}, color={0,0,127}));
  annotation (experiment(
      StopTime=86400,
      Interval=37,
      Tolerance=0.001,
      __Dymola_Algorithm="Esdirk45a"));
end Build_Test_NTU_OnceThru;
