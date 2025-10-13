within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Examples;
model Skid_Size_Two_Tank
  "Build of a skid-sized two-tank TES for experimental applications. Initial build doesn't include heat loss."
  extends Modelica.Icons.Example;
  Two_Tank_SHS_System_NewUpdate two_Tank_SHS_System_NewUpdate(
    redeclare
      NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Controls.CS_Experimental CS,
    redeclare replaceable Data.Data_SHS data(
      ht_level_max=2.0,
      ht_area=1.4075,
      ht_zero_level_volume=0.18,
      hot_tank_init_temp=633.15,
      cold_tank_level_max=2.0,
      cold_tank_area=1.4075,
      ct_zero_level_volume=0.18,
      cold_tank_init_temp=453.15,
      m_flow_ch_min=0.02,
      CHX_NTU=2.0,
      CHX_v_tube=0.1,
      CHX_v_shell=0.1,
      DHX_NTU=2.0,
      DHX_K_tube(unit="1/m4"),
      DHX_K_shell(unit="1/m4") = 1000,
      DHX_v_tube=0.1,
      DHX_v_shell=0.1,
      DHX_use_T_start_tube=true,
      DHX_T_start_tube_inlet=633.15,
      DHX_T_start_tube_outlet=453.15,
      DHX_use_T_start_shell=false,
      DHX_p_start_shell=1250000,
      DHX_h_start_shell_inlet=460e3,
      DHX_h_start_shell_outlet=460e3,
      DHX_m_flow_start_tube=0.6,
      DHX_m_flow_start_shell=0.04,
      DHX_Q_init=-1,
      CHX_use_T_start_tube=true,
      CHX_T_start_tube_inlet=633.15,
      CHX_T_start_tube_outlet=633.15,
      CHX_p_start_shell=100000,
      CHX_use_T_start_shell=true,
      CHX_T_start_shell_inlet=713.15,
      CHX_T_start_shell_outlet=693.15,
      CHX_m_flow_start_tube=0.6,
      CHX_m_flow_start_shell=4,
      CHX_Q_init=1,
      dis_pump_V_flow_nom={0,0.05,0.1},
      dis_pump_head_curve={0.03,0.01,0},
      charge_pump_V_flow_nom={0,0.05,0.1},
      charge_pump_head_curve={0.03,0.01,0},
      ctdp_area=0.001,
      disvalve_m_flow_nom=0.1,
      disvalve_dp_nominal=20000,
      htdp_area=0.001,
      chvalve_m_flow_nom=0.1,
      chvalve_dp_nominal=20000),
    redeclare package Storage_Medium = NHES.Media.HITEC.HITEC,
    redeclare package Charging_Medium =
        TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    m_flow_min=0.1,
    tank_height=2,
    Produced_steam_flow=boundary3.m_flow)
    annotation (Placement(transformation(extent={{-50,-48},{46,54}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Inlet_T(redeclare package
      Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT)
    annotation (Placement(transformation(extent={{-92,-8},{-72,-28}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary5(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    use_m_flow_in=false,
    m_flow=2.4,
    T=723.15,
    nPorts=1) annotation (Placement(transformation(extent={{-126,-28},{-106,-8}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare package
      Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT)
    annotation (Placement(transformation(extent={{-72,22},{-92,42}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    p=100000,
    T=683.15,
    nPorts=1) annotation (Placement(transformation(extent={{-130,24},{-110,44}})));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
    amplitude=9,
    rising=30,
    falling=30,
    offset=0)
    annotation (Placement(transformation(extent={{-156,-6},{-136,14}})));

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=0.02,
    T=383.15,
    nPorts=1) annotation (Placement(transformation(extent={{180,24},{162,42}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{208,-40},{188,-20}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort DHX_Outlet_T1(redeclare package
      Medium = Modelica.Media.Water.WaterIF97_pT)
    annotation (Placement(transformation(extent={{86,-20},{106,-40}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate DHX_Outlet_T2(redeclare package Medium
      = Modelica.Media.Water.WaterIF97_pT)
    annotation (Placement(transformation(extent={{114,22},{94,42}})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=50000,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{132,-20},{152,-40}})));
  TRANSFORM.Controls.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    Ti=15,
    yMax=1.0,
    yMin=1e-3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.01)
              annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={98,-112})));
  Modelica.Blocks.Sources.RealExpression Cold_Tank_Temperature(y=
        two_Tank_SHS_System_NewUpdate.sensor_T_coldtank.T)
    annotation (Placement(transformation(extent={{138,-122},{118,-102}})));
  Modelica.Blocks.Sources.Constant const1(k=180 + 273.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={98,-74})));
equation
  two_Tank_SHS_System_NewUpdate.Charging_Trigger = triggeredTrapezoid.u;
 // two_Tank_SHS_System.Produced_steam_flow = valveLinear.port_a.m_flow;
  connect(boundary5.ports[1], CHX_Inlet_T.port_a) annotation (Line(points={{-106,
          -18},{-92,-18}},            color={0,127,255}));
  connect(CHX_Inlet_T.port_b, two_Tank_SHS_System_NewUpdate.port_ch_a)
    annotation (Line(points={{-72,-18},{-50,-18},{-50,-28.62},{-49.04,-28.62}},
        color={0,127,255}));
  connect(CHX_Discharge_T.port_a, two_Tank_SHS_System_NewUpdate.port_ch_b)
    annotation (Line(points={{-72,32},{-58,32},{-58,30.54},{-49.04,30.54}},
                                      color={0,127,255}));
  connect(CHX_Discharge_T.port_b, boundary1.ports[1])
    annotation (Line(points={{-92,32},{-106,32},{-106,34},{-110,34}},
                                                   color={0,127,255}));
  connect(DHX_Outlet_T1.port_a, two_Tank_SHS_System_NewUpdate.port_dch_b)
    annotation (Line(points={{86,-30},{56,-30},{56,-28.62},{46,-28.62}}, color=
          {0,127,255}));
  connect(boundary3.ports[1], DHX_Outlet_T2.port_a) annotation (Line(points={{
          162,33},{138,33},{138,32},{114,32}}, color={0,127,255}));
  connect(DHX_Outlet_T2.port_b, two_Tank_SHS_System_NewUpdate.port_dch_a)
    annotation (Line(points={{94,32},{54,33},{54,32.58},{45.04,32.58}}, color={
          0,127,255}));
  connect(DHX_Outlet_T1.port_b, valveLinear.port_a)
    annotation (Line(points={{106,-30},{132,-30}}, color={0,127,255}));
  connect(valveLinear.port_b, boundary.ports[1])
    annotation (Line(points={{152,-30},{188,-30}}, color={0,127,255}));
  connect(Cold_Tank_Temperature.y, PID1.u_m)
    annotation (Line(points={{117,-112},{110,-112}}, color={0,0,127}));
  connect(const1.y, PID1.u_s)
    annotation (Line(points={{98,-85},{98,-100}}, color={0,0,127}));
  connect(PID1.y, valveLinear.opening) annotation (Line(points={{98,-123},{98,
          -126},{142,-126},{142,-38}}, color={0,0,127}));
  annotation (experiment(
      StopTime=864000,
      Interval=37,
      __Dymola_Algorithm="Esdirk45a"));
end Skid_Size_Two_Tank;
