within NHES.Systems.BalanceOfPlant.Turbine;
model Drum_boiler

  TRANSFORM.Fluid.Volumes.BoilerDrum boilerDrum(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
        (
        length=20,
        r_inner=3,
        th_wall=0.03),
    level_start=11.0,
    p_liquid_start=18000000,
    p_vapor_start=17900000,
    use_T_start=true,
    T_liquid_start=593.15,
    T_vapor_start=643.15,
    use_LiquidHeatPort=false,
    Twall_start=423.15)
    annotation (Placement(transformation(extent={{2,2},{20,24}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Modelica.Media.Water.StandardWater, m_flow_nominal=180)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={18,-22})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                      DHX(
    tau=1,
    NTU=20,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.IdealGases.SingleGases.He,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=18000000,
    h_start_tube_inlet=706000,
    h_start_tube_outlet=1650000,
    p_start_shell=5000000,
    use_T_start_shell=true,
    T_start_shell_inlet=647.15,
    T_start_shell_outlet=473.15,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=44000000)                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-30,-78})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                      DHX1(
    tau=1,
    NTU=20,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.IdealGases.SingleGases.He,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=18000000,
    h_start_tube_inlet=1755270,
    h_start_tube_outlet=2000000,
    p_start_shell=5000000,
    use_T_start_shell=true,
    T_start_shell_inlet=773.15,
    T_start_shell_outlet=647.15,
    dp_init_tube=50000,
    dp_init_shell=50000,
    Q_init=61000000)                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-30,-34})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                      DHX2(
    tau=1,
    NTU=20,
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
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-34,52})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=59,
    T=433.15,
    nPorts=1) annotation (Placement(transformation(extent={{124,-62},{106,-44}})));
  Modelica.Blocks.Sources.RealExpression Level_Boiler(y=boilerDrum.level)
    annotation (Placement(transformation(extent={{106,-42},{126,-22}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-2,
    Ti=10,
    yMin=-0.25,
    xi_start=59)
              annotation (Placement(transformation(extent={{148,-18},{168,2}})));
  Modelica.Blocks.Sources.Constant const(k=10)
    annotation (Placement(transformation(extent={{110,-18},{130,2}})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    dp_nominal=50000,
    m_flow_nominal=50)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-62,-74})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=18000000,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{72,44},{92,64}})));
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
    nPorts=2) annotation (Placement(transformation(extent={{-112,-118},{-92,-98}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary5(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    use_m_flow_in=true,
    m_flow=1.0,
    T=1013.15,
    nPorts=1) annotation (Placement(transformation(extent={{-114,82},{-96,100}})));
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
    annotation (Placement(transformation(extent={{-144,-6},{-124,14}})));
  Modelica.Blocks.Sources.Constant const4(k=40)
    annotation (Placement(transformation(extent={{-170,86},{-150,106}})));
equation
  connect(boilerDrum.downcomerPort, pump.port_a) annotation (Line(points={{17.3,
          4.2},{17.3,-4},{18,-4},{18,-12}}, color={0,127,255}));
  connect(pump.port_b, DHX1.Tube_out) annotation (Line(points={{18,-32},{18,-50},
          {-26,-50},{-26,-44}}, color={0,127,255}));
  connect(DHX1.Tube_in, boilerDrum.riserPort) annotation (Line(points={{-26,-24},
          {-26,4.2},{4.7,4.2}}, color={0,127,255}));
  connect(DHX.Tube_in, boilerDrum.feedwaterPort) annotation (Line(points={{-26,-68},
          {-26,-60},{44,-60},{44,13},{20,13}},      color={0,127,255}));
  connect(boilerDrum.steamPort, DHX2.Tube_out) annotation (Line(points={{17.3,21.36},
          {17.3,36},{-30,36},{-30,42}},        color={0,127,255}));
  connect(const.y,PID. u_s)
    annotation (Line(points={{131,-8},{146,-8}}, color={0,0,127}));
  connect(Level_Boiler.y,PID. u_m) annotation (Line(points={{127,-32},{158,-32},
          {158,-20}},    color={0,0,127}));
  connect(boundary3.ports[1], DHX.Tube_out) annotation (Line(points={{106,-53},
          {82,-53},{82,-96},{-26,-96},{-26,-88}}, color={0,127,255}));
  connect(boundary2.ports[1], DHX1.Shell_out) annotation (Line(points={{-80,-5},
          {-80,-6},{-32,-6},{-32,-24}}, color={0,127,255}));
  connect(DHX1.Shell_in, DHX.Shell_out)
    annotation (Line(points={{-32,-44},{-32,-68}}, color={0,127,255}));
  connect(valveLinear.port_a, DHX.Shell_out) annotation (Line(points={{-62,-64},
          {-48,-64},{-48,-56},{-32,-56},{-32,-68}}, color={0,127,255}));
  connect(DHX.Shell_in, boundary4.ports[1]) annotation (Line(points={{-32,-88},
          {-32,-110},{-92,-110},{-92,-109}}, color={0,127,255}));
  connect(valveLinear.port_b, boundary4.ports[2]) annotation (Line(points={{-62,
          -84},{-62,-100},{-60,-100},{-60,-110},{-92,-110},{-92,-107}}, color={
          0,127,255}));
  connect(boundary5.ports[1], DHX2.Shell_out)
    annotation (Line(points={{-96,91},{-36,91},{-36,62}}, color={0,127,255}));
  connect(DHX2.Shell_in, boundary6.ports[1]) annotation (Line(points={{-36,42},{
          -36,40},{-88,40},{-88,46},{-96,46}},  color={0,127,255}));
  connect(const1.y, valveLinear.opening) annotation (Line(points={{-91,-68},{-78,
          -68},{-78,-74},{-70,-74}}, color={0,0,127}));
  connect(const2.y, boundary2.m_flow_in)
    annotation (Line(points={{-123,4},{-123,2.2},{-98,2.2}}, color={0,0,127}));
  connect(const4.y, boundary5.m_flow_in) annotation (Line(points={{-149,96},{-149,
          98.2},{-114,98.2}}, color={0,0,127}));
  connect(DHX2.Tube_in, boundary1.ports[1]) annotation (Line(points={{-30,62},{
          -30,72},{98,72},{98,54},{92,54}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-120,-120},{100,100}})), Icon(
        coordinateSystem(extent={{-120,-120},{100,100}})));
end Drum_boiler;
