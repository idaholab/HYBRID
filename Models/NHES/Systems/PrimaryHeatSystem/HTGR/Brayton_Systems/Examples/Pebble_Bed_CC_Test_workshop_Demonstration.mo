within NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.Examples;
model Pebble_Bed_CC_Test_workshop_Demonstration
  extends Modelica.Icons.Example;
  Real total_efficiency;
  NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.Components.Pebble_Bed_CC
    Pebble_Bed_HTGR(redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.CS_Basic CS,
      redeclare NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.ED_Dummy ED)
    annotation (Placement(transformation(extent={{-48,-20},{20,44}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Intercooler_Source(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=20,
    T=306.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{58,-40},{38,-20}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Water_T1(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-6,8},{6,-8}},
        rotation=180,
        origin={18,-30})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Water_T3(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{8,9},{-8,-9}},
        rotation=270,
        origin={-92,-15})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    nUnits=2,
    eta_mech=0.93,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
    p_a_start=400000,
    p_b_start=1000,
    T_a_start=433.15,
    T_b_start=323.15,
    m_flow_start=20,
    partialArc_nominal=0.1,
    m_flow_nominal=20,
    use_Stodola=true,
    Kt_constant=0.025,
    use_NominalInlet=false,
    p_inlet_nominal=400000,
    p_outlet_nominal=8000,
    T_nominal=433.15)
    annotation (Placement(transformation(extent={{-82,-58},{-54,-30}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph CC_Dump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10000,
    nPorts=1) annotation (Placement(transformation(
        extent={{4,-5},{-4,5}},
        rotation=90,
        origin={-42,-31})));
  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{-42,-58},{-16,-32}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Steam_Offtake_Source(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=15,
    T=308.15,
    nPorts=1) annotation (Placement(transformation(extent={{-86,20},{-66,40}})));
  ElectricalGrid.InfiniteGrid.Infinite EG(Q_nominal=280e6)
    annotation (Placement(transformation(extent={{50,-6},{104,42}})));
  EnergyStorage.Concrete_Solid_Media.Components.Dual_Pipe_Model_Two_HTFs
    dual_Pipe_Model_Two_HTFs(Hot_Con_Start=673.15, Cold_Con_Start=398.15)
    annotation (Placement(transformation(extent={{-54,-16},{-82,4}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Offtake_Dump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=2000000,
    nPorts=1) annotation (Placement(transformation(
        extent={{3,-4},{-3,4}},
        rotation=90,
        origin={-72,13})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=12,
    rising=300,
    width=6600,
    falling=300,
    period=18000,
    nperiod=22)
    annotation (Placement(transformation(extent={{-104,34},{-96,42}})));
equation
  total_efficiency = (steamTurbine.Q_mech+Pebble_Bed_HTGR.port_a.W)/Pebble_Bed_HTGR.core.Q_total.y;
  connect(Water_T1.port_a,Intercooler_Source. ports[1])
    annotation (Line(points={{24,-30},{38,-30}},          color={0,127,255}));
  connect(steamTurbine.shaft_b,generator. shaft) annotation (Line(points={{-54,-44},
          {-54,-45.13},{-42.13,-45.13}},                       color={0,0,0}));
  connect(Pebble_Bed_HTGR.auxiliary_heating_port_a, Steam_Offtake_Source.ports[
    1]) annotation (Line(points={{-48,31.2},{-48,30},{-66,30}}, color={0,127,
          255}));
  connect(Water_T1.port_b, Pebble_Bed_HTGR.combined_cycle_port_a) annotation (
      Line(points={{12,-30},{-2,-30},{-2,-24},{-3.12,-24},{-3.12,-20}},
                                                   color={0,127,255}));
  connect(Water_T3.port_a, Pebble_Bed_HTGR.combined_cycle_port_b) annotation (
      Line(points={{-92,-23},{-92,-68},{-12,-68},{-12,-32},{-33.04,-32},{-33.04,
          -20}},                                         color={0,127,255}));
  connect(EG.portElec_a, Pebble_Bed_HTGR.port_a) annotation (Line(points={{50,18},
          {20,18.4}},                         color={255,0,0}));
  connect(Pebble_Bed_HTGR.auxiliary_heating_port_b, dual_Pipe_Model_Two_HTFs.Charge_Inlet)
    annotation (Line(points={{-48,-2.72},{-60,-2.72},{-60,-2},{-57.08,-2},{
          -57.08,-3.8}},
                   color={0,127,255}));
  connect(dual_Pipe_Model_Two_HTFs.Charge_Outlet, Steam_Offtake_Dump.ports[1])
    annotation (Line(points={{-72.2,0.2},{-72,10}}, color={0,127,255}));
  connect(steamTurbine.portHP, dual_Pipe_Model_Two_HTFs.Discharge_Outlet)
    annotation (Line(points={{-82,-35.6},{-86,-35.6},{-86,-26},{-66,-26},{-66,
          -16},{-65.76,-16},{-65.76,-11.6}},
                   color={0,127,255}));
  connect(Water_T3.port_b, dual_Pipe_Model_Two_HTFs.Discharge_Inlet)
    annotation (Line(points={{-92,-7},{-92,-6.2},{-78.92,-6.2}},
                            color={0,127,255}));
  connect(trapezoid.y, Steam_Offtake_Source.m_flow_in) annotation (Line(points={{-95.6,
          38},{-86,38}},                           color={0,0,127}));
  connect(steamTurbine.portLP, CC_Dump.ports[1]) annotation (Line(points={{-54,
          -35.6},{-54,-38},{-42,-38},{-42,-35}},                     color={0,
          127,255}));
  annotation (experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"));
end Pebble_Bed_CC_Test_workshop_Demonstration;
