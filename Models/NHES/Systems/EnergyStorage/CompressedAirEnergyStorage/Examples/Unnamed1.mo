within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Examples;
model Unnamed1
  Real Trig;

  parameter Real tablePR[11,7]=[0, 72, 80, 90, 95, 100, 105;
1, 2.36, 11.84, 23.70, 30.22, 34.29, 42.13;
2, 2.20, 11.28, 22.64, 28.80, 32.96, 40.20;
3, 2.05, 10.73, 21.58, 27.38, 31.63, 38.27;
4, 1.89, 10.17, 20.52, 25.96, 30.30, 36.34;
5, 1.73, 9.61, 19.46, 24.54, 28.97, 34.41;
6, 0.88, 8.40, 17.80, 22.60, 27.00, 32.00;
7, 1.88, 8.91, 17.69, 22.00, 26.60, 30.80;
8, 2.16, 8.71, 16.91, 20.80, 25.50, 29.00;
9, 0.63, 7.15, 15.31, 19.00, 24.30, 27.10;
10, 0.72, 6.48, 13.69, 17.00, 21.50, 24.20];

parameter Real tablePhicC[11,7]= [0, 72, 80, 90, 95, 100, 105;
1, 0.008, 0.017, 0.028, 0.033, 0.038, 0.044;
2, 0.010, 0.019, 0.029, 0.034, 0.039, 0.045;
3, 0.012, 0.020, 0.030, 0.035, 0.040, 0.045;
4, 0.014, 0.022, 0.032, 0.036, 0.041, 0.046;
5, 0.016, 0.024, 0.033, 0.037, 0.042, 0.046;
6, 0.019, 0.026, 0.034, 0.038, 0.043, 0.047;
7, 0.020, 0.027, 0.035, 0.039, 0.044, 0.048;
8, 0.023, 0.029, 0.037, 0.041, 0.045, 0.048;
9, 0.025, 0.031, 0.038, 0.042, 0.046, 0.049;
10, 0.026, 0.032, 0.039, 0.042, 0.047, 0.049];

parameter Real tableEtaC[11,7]= [0, 72, 80, 90, 95, 100, 105;
            1, 0.877, 0.869, 0.858, 0.855, 0.842, 0.845;
     2, 0.876, 0.867, 0.855, 0.850, 0.838, 0.839;
     3, 0.870, 0.855, 0.834, 0.824, 0.811, 0.801;
     4, 0.879, 0.870, 0.858, 0.853, 0.841, 0.843;
     5, 0.878, 0.866, 0.852, 0.846, 0.834, 0.832;
     6, 0.869, 0.853, 0.833, 0.825, 0.810, 0.805;
     7, 0.882, 0.867, 0.848, 0.840, 0.829, 0.820;
     8, 0.868, 0.855, 0.839, 0.832, 0.822, 0.815;
     9, 0.899, 0.873, 0.841, 0.825, 0.812, 0.790;
     10, 0.855, 0.834, 0.807, 0.795, 0.780, 0.765];

  NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Components.MainCompressor_test
                            mainCompressor_test(
    redeclare package Medium = NHES.Media.Air,
    tablePhic=tablePhicC,
    tableEta=tableEtaC,
    pstart_in=100000,
    pstart_out=200000,
    Tstart_in=298.15,
    tablePR=tablePR,
    Table=ThermoPower.Choices.TurboMachinery.TableTypes.matrix,
    Tstart_out=298.15,
    explicitIsentropicEnthalpy=true,
    Tdes_in=298.15,
    Ndesign=157.08) annotation (Placement(transformation(extent={{-46,-82},{-22,-58}},  rotation=0)));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SourceP1(
    redeclare package Medium = NHES.Media.Air,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{-68,-54},{-58,-44}},   rotation=0)));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port Cavern(
    redeclare package Medium = NHES.Media.Air,
    p_start=mainCompressor_test.pstart_out,
    T_start=298.15,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=3300000))
    annotation (Placement(transformation(extent={{52,86},{80,58}}, rotation=0)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package Medium = NHES.Media.Air)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-15,-11})));
  TRANSFORM.Fluid.Valves.ValveLinear SinkValve(
    redeclare package Medium = NHES.Media.Air,
    dp_start=100,
    dp_nominal=1500000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{-32,-18},{-46,-4}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay1(Ti=1)
    annotation (Placement(transformation(extent={{-64,12},{-50,26}})));
  Modelica.Blocks.Sources.RealExpression TriggerValue(y=Trig)
    annotation (Placement(transformation(extent={{-102,11},{-88,27}})));
  Modelica.Fluid.Sources.FixedBoundary SinkAtmosphere(
    redeclare package Medium = NHES.Media.Air,
    p(displayUnit="bar") = 100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-76,-16},{-66,-6}})));
  TRANSFORM.Fluid.Valves.CheckValve checkValve(
    redeclare package Medium = ThermoPower.Media.Air,
    R=0.001,
    checkValve=true) annotation (Placement(transformation(extent={{14,66},{26,78}})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-176,82},{-164,94}})));
  Modelica.Blocks.Sources.RealExpression SinkValveValue(y=-1*SinkValve.opening)
    annotation (Placement(transformation(extent={{-176,36},{-164,50}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-126,74},{-112,88}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay2(Ti=5)
    annotation (Placement(transformation(extent={{-78,74},{-64,88}})));
  TRANSFORM.Fluid.Valves.ValveLinear CavernValve(
    redeclare package Medium = NHES.Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-15,53})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=165)
    annotation (Placement(transformation(extent={{58,-90},{38,-70}})));
initial equation
  Trig = 0;

equation
    der(Trig) = 1e-20;
  when Cavern.medium.p >= 42E5 then
    reinit(Trig,1);
  end when;
  connect(mainCompressor_test.inlet, SourceP1.ports[1])
    annotation (Line(points={{-43.6,-60.4},{-42,-60.4},{-42,-49},{-58,-49}}, color={0,127,255}));
  connect(teeJunctionIdeal.port_1, mainCompressor_test.outlet)
    annotation (Line(points={{-15,-18},{-15,-60.4},{-24.4,-60.4}}, color={0,127,255}));
  connect(teeJunctionIdeal.port_3, SinkValve.port_a) annotation (Line(points={{-22,-11},{-32,-11}}, color={0,127,255}));
  connect(SinkValve.port_b, SinkAtmosphere.ports[1]) annotation (Line(points={{-46,-11},{-66,-11}}, color={0,127,255}));
  connect(delay1.y, SinkValve.opening) annotation (Line(points={{-49.02,19},{-39,19},{-39,-5.4}}, color={0,0,127}));
  connect(Cavern.port, checkValve.port_b) annotation (Line(points={{57.6,72},{26,72}},
                                                                                     color={0,127,255}));
  connect(delay1.u, TriggerValue.y) annotation (Line(points={{-65.4,19},{-87.3,19}}, color={0,0,127}));
  connect(checkValve.port_a, CavernValve.port_b) annotation (Line(points={{14,72},{-15,72},{-15,60}}, color={0,127,255}));
  connect(CavernValve.port_a, teeJunctionIdeal.port_2) annotation (Line(points={{-15,46},{-15,-4}}, color={0,127,255}));
  connect(delay2.y, CavernValve.opening) annotation (Line(points={{-63.02,81},{-28,81},{-28,53},{-20.6,53}}, color={0,0,127}));
  connect(delay2.u, add.y) annotation (Line(points={{-79.4,81},{-111.3,81}}, color={0,0,127}));
  connect(const.y, add.u1) annotation (Line(points={{-163.4,88},{-127.4,88},{-127.4,85.2}}, color={0,0,127}));
  connect(SinkValveValue.y, add.u2)
    annotation (Line(points={{-163.4,43},{-146.7,43},{-146.7,76.8},{-127.4,76.8}}, color={0,0,127}));
  connect(constantSpeed.flange, mainCompressor_test.shaft_b)
    annotation (Line(points={{38,-80},{-16,-80},{-16,-70},{-26.8,-70}}, color={0,0,0}));
  annotation ();
end Unnamed1;
