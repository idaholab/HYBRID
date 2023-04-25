within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model ReheatCycle_Test_a3
  import NHES;
  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.Reheat_cycle_drumOFH_connectors_salt3
    reheat_cycle_drumOFH_connectors_salt3_1(
    pump(m_flow_nominal=200),
    steam_Drum(p_start=18000000, alphag_start=0.6),
    CS(delay3(Ti=10)),
    DHX(
      NTU=3.5,
      T_start_shell_inlet=633.15,
      T_start_shell_outlet=623.15,
      dp_general=10000,
      m_start_shell=200),
    const1(k=0),
    valveLinear(dp_nominal=10000),
    DHX2(use_T_start_shell=false),
    DHX3(
      T_start_shell_inlet=1023.15,
      T_start_shell_outlet=773.15,
      Q_init=1,
      m_start_shell=100,
      Tube(medium(T(start=750, fixed=true), p(start=800000, fixed=true)))),
    steamTurbine1(use_T_nominal=false, d_nominal(displayUnit="kg/m3") = 2.05))
    annotation (Placement(transformation(extent={{12,-38},{110,42}})));
  Modelica.Fluid.Sources.Boundary_pT boundary6(
    redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    p=200000,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{-98,-6},{-78,14}})));
  Modelica.Fluid.Sources.Boundary_pT boundary7(
    redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    p=200000,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{-98,60},{-78,80}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    p=200000,
    T=1013.15,
    nPorts=1) annotation (Placement(transformation(extent={{-100,88},{-80,108}})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    p=200000,
    T=1013.15,
    nPorts=1) annotation (Placement(transformation(extent={{-98,22},{-78,42}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=-45,
    duration=1000,
    offset=236,
    startTime=5500)
    annotation (Placement(transformation(extent={{-354,-26},{-340,-12}})));
  Modelica.Blocks.Math.Add         add1
    annotation (Placement(transformation(extent={{-296,0},{-276,20}})));
  Modelica.Blocks.Sources.Ramp ramp3(
    height=-120,
    duration=3001,
    offset=0,
    startTime=10500)
    annotation (Placement(transformation(extent={{-350,10},{-336,24}})));
  Modelica.Blocks.Math.Add         add2
    annotation (Placement(transformation(extent={{-252,6},{-232,26}})));
  Modelica.Blocks.Sources.Ramp ramp4(
    height=-30,
    duration=2001,
    offset=0,
    startTime=15500)
    annotation (Placement(transformation(extent={{-350,40},{-336,54}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    use_m_flow_in=true,
    m_flow=1.0,
    T=773.15,
    nPorts=1) annotation (Placement(transformation(extent={{-148,-24},{-130,-6}})));
  Modelica.Fluid.Sources.Boundary_pT boundary4(
    redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    p=200000,
    T=473.15,
    nPorts=1) annotation (Placement(transformation(extent={{-144,-122},{-124,
            -102}})));
equation

  connect(reheat_cycle_drumOFH_connectors_salt3_1.HT_SH_out, boundary6.ports[1])
    annotation (Line(points={{12,2.47059},{10,2.47059},{10,4},{-78,4}}, color={
          0,127,255}));
  connect(reheat_cycle_drumOFH_connectors_salt3_1.HT_RH_out, boundary7.ports[1])
    annotation (Line(points={{12.4667,23.1765},{-20,23.1765},{-20,70},{-78,70}},
        color={0,127,255}));
  connect(boundary1.ports[1], reheat_cycle_drumOFH_connectors_salt3_1.HT_RH_in)
    annotation (Line(points={{-80,98},{4,98},{4,39.1765},{12.9333,39.1765}},
        color={0,127,255}));
  connect(boundary3.ports[1], reheat_cycle_drumOFH_connectors_salt3_1.HT_SH_in)
    annotation (Line(points={{-78,32},{-22,32},{-22,14.2353},{12,14.2353}},
        color={0,127,255}));
  connect(ramp3.y,add1. u1) annotation (Line(points={{-335.3,17},{-306,17},{
          -306,16},{-298,16}},    color={0,0,127}));
  connect(ramp2.y,add1. u2) annotation (Line(points={{-339.3,-19},{-339.3,-20},
          {-308,-20},{-308,4},{-298,4}},
                             color={0,0,127}));
  connect(add1.y,add2. u2)
    annotation (Line(points={{-275,10},{-254,10}}, color={0,0,127}));
  connect(ramp4.y,add2. u1) annotation (Line(points={{-335.3,47},{-264,47},{
          -264,22},{-254,22}}, color={0,0,127}));
  connect(add2.y,boundary2. m_flow_in) annotation (Line(points={{-231,16},{-154,
          16},{-154,-7.8},{-148,-7.8}},
                                   color={0,0,127}));
  connect(boundary2.ports[1], reheat_cycle_drumOFH_connectors_salt3_1.LT_in)
    annotation (Line(points={{-130,-15},{-130,-16},{4,-16},{4,-17.7647},{
          12.4667,-17.7647}}, color={0,127,255}));
  connect(boundary4.ports[1], reheat_cycle_drumOFH_connectors_salt3_1.LT_out)
    annotation (Line(points={{-124,-112},{4,-112},{4,-35.1765},{12.4667,
          -35.1765}}, color={0,127,255}));
  annotation (experiment(
      StopTime=20000,
      Tolerance=0.005,
      __Dymola_Algorithm="Esdirk34a"));
end ReheatCycle_Test_a3;
