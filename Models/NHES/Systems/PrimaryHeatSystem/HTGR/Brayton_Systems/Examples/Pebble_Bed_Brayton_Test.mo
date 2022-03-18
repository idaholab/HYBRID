within NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.Examples;
model Pebble_Bed_Brayton_Test
  extends Modelica.Icons.Example;
  NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.Components.Pebble_Bed_Brayton
    Pebble_Bed_HTGR(redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.CS_Basic CS, redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems.ED_Dummy ED,
    redeclare package Coolant_Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-48,-42},{20,22}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=0,
    T=373.15,
    nPorts=1) annotation (Placement(transformation(extent={{-88,0},{-68,20}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=1500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-88,-36},{-64,-12}})));
  ElectricalGrid.InfiniteGrid.Infinite EG(Q_nominal=280e6)
    annotation (Placement(transformation(extent={{62,-20},{82,0}})));
equation
  connect(Pebble_Bed_HTGR.auxiliary_heating_port_a, boundary2.ports[1])
    annotation (Line(points={{-48,9.2},{-48,10},{-68,10}}, color={0,127,255}));
  connect(Pebble_Bed_HTGR.auxiliary_heating_port_b, boundary1.ports[1])
    annotation (Line(points={{-48,-24.72},{-64,-24.72},{-64,-24}},
        color={0,127,255}));
  connect(EG.portElec_a, Pebble_Bed_HTGR.port_a)
    annotation (Line(points={{62,-10},{20,-10}}, color={255,0,0}));
  annotation (experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"));
end Pebble_Bed_Brayton_Test;
