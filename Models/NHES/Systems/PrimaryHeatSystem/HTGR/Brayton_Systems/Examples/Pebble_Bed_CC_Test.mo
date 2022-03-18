within NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.Examples;
model Pebble_Bed_CC_Test
  extends Modelica.Icons.Example;
  NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.Components.Pebble_Bed_CC
    Pebble_Bed_HTGR(redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.CS_Basic CS,
      redeclare NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.ED_Dummy ED)
    annotation (Placement(transformation(extent={{-48,-44},{22,24}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Intercooler_Source(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=20,
    T=306.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{54,-62},{34,-42}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Water_T1(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={14,-52})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Water_T3(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{-8,9},{8,-9}},
        rotation=270,
        origin={-32,-59})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    p_a_start=200000,
    p_b_start=1000,
    T_a_start=433.15,
    T_b_start=383.15,
    m_flow_start=65,
    m_flow_nominal=65,
    p_inlet_nominal=400000,
    p_outlet_nominal=1000,
    T_nominal=433.15)
    annotation (Placement(transformation(extent={{-26,-90},{-4,-68}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary7(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10000,
    nPorts=1)
    annotation (Placement(transformation(extent={{38,-86},{18,-66}})));
  TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
    annotation (Placement(transformation(extent={{4,-94},{24,-74}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=0,
    T=373.15,
    nPorts=1) annotation (Placement(transformation(extent={{-102,0},{-82,20}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=1500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-98,-36},{-78,-16}})));
  ElectricalGrid.InfiniteGrid.Infinite EG(Q_nominal=280e6)
    annotation (Placement(transformation(extent={{80,-22},{116,14}})));
equation
  connect(Water_T1.port_a,Intercooler_Source. ports[1])
    annotation (Line(points={{24,-52},{34,-52}},          color={0,127,255}));
  connect(Water_T3.port_b,steamTurbine. portHP) annotation (Line(points={{-32,-67},
          {-32,-72.4},{-26,-72.4}},                               color={0,127,255}));
  connect(steamTurbine.portLP,boundary7. ports[1]) annotation (Line(points={{-4,
          -72.4},{-4,-68},{14,-68},{14,-72},{18,-72},{18,-76}},
                                           color={0,127,255}));
  connect(steamTurbine.shaft_b,generator. shaft) annotation (Line(points={{-4,-79},
          {-4,-78},{0,-78},{0,-84.1},{3.9,-84.1}},             color={0,0,0}));
  connect(Pebble_Bed_HTGR.auxiliary_heating_port_a, boundary2.ports[1])
    annotation (Line(points={{-48,10.4},{-48,10},{-82,10}},            color={0,
          127,255}));
  connect(Pebble_Bed_HTGR.auxiliary_heating_port_b, boundary1.ports[1])
    annotation (Line(points={{-48,-25.64},{-78,-25.64},{-78,-26}},
        color={0,127,255}));
  connect(Water_T1.port_b, Pebble_Bed_HTGR.combined_cycle_port_a) annotation (
      Line(points={{4,-52},{-2,-52},{-2,-44},{-1.8,-44}},
                                                   color={0,127,255}));
  connect(Water_T3.port_a, Pebble_Bed_HTGR.combined_cycle_port_b) annotation (
      Line(points={{-32,-51},{-32.6,-51},{-32.6,-44}},   color={0,127,255}));
  connect(EG.portElec_a, Pebble_Bed_HTGR.port_a)
    annotation (Line(points={{80,-4},{80,-3.2},{22,-3.2}}, color={255,0,0}));
end Pebble_Bed_CC_Test;
