within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model ReheatCycle_Test_a
  import NHES;
  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.Reheat_cycle_drumOFH_connectors2
    reheat_cycle_drumOFH_connectors2_1(pump(m_flow_nominal=190), steam_Drum(
        p_start=15000000))
    annotation (Placement(transformation(extent={{12,-38},{110,42}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=-20,
    duration=1000,
    offset=206,
    startTime=5500)
    annotation (Placement(transformation(extent={{-304,-14},{-290,0}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-248,10},{-228,30}})));
  Modelica.Blocks.Sources.Ramp ramp3(
    height=-10,
    duration=2001,
    offset=0,
    startTime=10500)
    annotation (Placement(transformation(extent={{-302,20},{-288,34}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-204,16},{-184,36}})));
  Modelica.Blocks.Sources.Ramp ramp4(
    height=-5,
    duration=1001,
    offset=0,
    startTime=16500)
    annotation (Placement(transformation(extent={{-302,50},{-288,64}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    use_m_flow_in=true,
    m_flow=1.0,
    T=773.15,
    nPorts=1) annotation (Placement(transformation(extent={{-96,-56},{-78,-38}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    p=200000,
    T=473.15,
    nPorts=1) annotation (Placement(transformation(extent={{-96,-112},{-76,-92}})));
  Modelica.Fluid.Sources.Boundary_pT boundary6(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=5000000,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{-98,-6},{-78,14}})));
  Modelica.Fluid.Sources.Boundary_pT boundary7(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=5000000,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{-98,60},{-78,80}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=5000000,
    T=1013.15,
    nPorts=1) annotation (Placement(transformation(extent={{-100,88},{-80,108}})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=5000000,
    T=1013.15,
    nPorts=1) annotation (Placement(transformation(extent={{-98,22},{-78,42}})));
equation

  connect(ramp3.y,add1. u1) annotation (Line(points={{-287.3,27},{-258,27},{
          -258,26},{-250,26}},    color={0,0,127}));
  connect(ramp2.y,add1. u2) annotation (Line(points={{-289.3,-7},{-289.3,-10},{
          -260,-10},{-260,14},{-250,14}},
                             color={0,0,127}));
  connect(add1.y,add2. u2)
    annotation (Line(points={{-227,20},{-206,20}}, color={0,0,127}));
  connect(ramp4.y,add2. u1) annotation (Line(points={{-287.3,57},{-216,57},{
          -216,32},{-206,32}}, color={0,0,127}));
  connect(add2.y,boundary2. m_flow_in) annotation (Line(points={{-183,26},{-102,
          26},{-102,-39.8},{-96,-39.8}},
                                   color={0,0,127}));
  connect(boundary2.ports[1], reheat_cycle_drumOFH_connectors2_1.LT_in)
    annotation (Line(points={{-78,-47},{-78,-48},{-72,-48},{-72,-17.7647},{
          12.4667,-17.7647}}, color={0,127,255}));
  connect(reheat_cycle_drumOFH_connectors2_1.LT_out, boundary4.ports[1])
    annotation (Line(points={{12.4667,-35.1765},{-68,-35.1765},{-68,-102},{-76,
          -102}}, color={0,127,255}));
  connect(reheat_cycle_drumOFH_connectors2_1.HT_SH_out, boundary6.ports[1])
    annotation (Line(points={{12,2.47059},{10,2.47059},{10,4},{-78,4}}, color={
          0,127,255}));
  connect(reheat_cycle_drumOFH_connectors2_1.HT_RH_out, boundary7.ports[1])
    annotation (Line(points={{12.4667,23.1765},{-20,23.1765},{-20,70},{-78,70}},
        color={0,127,255}));
  connect(boundary1.ports[1], reheat_cycle_drumOFH_connectors2_1.HT_RH_in)
    annotation (Line(points={{-80,98},{4,98},{4,39.1765},{12.9333,39.1765}},
        color={0,127,255}));
  connect(boundary3.ports[1], reheat_cycle_drumOFH_connectors2_1.HT_SH_in)
    annotation (Line(points={{-78,32},{-22,32},{-22,14.2353},{12,14.2353}},
        color={0,127,255}));
  annotation (experiment(
      StopTime=500,
      Tolerance=0.001,
      __Dymola_Algorithm="Esdirk34a"));
end ReheatCycle_Test_a;
