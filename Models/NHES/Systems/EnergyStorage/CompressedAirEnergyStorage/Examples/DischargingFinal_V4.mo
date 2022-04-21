within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Examples;
model DischargingFinal_V4
  Real DischargeStopTrig, testtrig;

  parameter Real tablePhicT[5, 4]=[1, 90, 100, 110;
                                   2.36, 4.68e-3, 4.68e-3, 4.68e-3;
                                   2.88, 4.68e-3, 4.68e-3, 4.68e-3;
                                   3.56, 4.68e-3, 4.68e-3, 4.68e-3;
                                   4.46, 4.68e-3, 4.68e-3, 4.68e-3];

  parameter Real tableEtaT[5, 4]=[1, 90, 100, 110;
                                  2.36, 89e-2, 89.5e-2, 89.3e-2;
                                  2.88, 90e-2, 90.6e-2, 90.5e-2;
                                  3.56, 90.5e-2, 90.6e-2, 90.5e-2;
                                  4.46, 90.2e-2, 90.3e-2, 90e-2];
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{136,154},{156,174}})));
  Components.Turbine2      turbine2(
    redeclare package Medium = Media.Air,
    pstart_in=710000,
    pstart_out=200000,
    tablePhic=tablePhicT,
    tableEta=tableEtaT,
    Table=NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Data.TableTypes.matrix,
    Tstart_out=323.15,
    Tdes_in=373.15,
    Tstart_in=373.15,
    Ndesign=157.08) annotation (Placement(transformation(extent={{74,-126},{134,-66}},rotation=0)));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port
                                       Cavern(
    redeclare package Medium = Media.Air,
    p_start=2537000,
    T_start=368.35,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1e6),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{-26,53},{-82,-1}})));
  TRANSFORM.Fluid.Valves.ValveLinear TurbValve(
    redeclare package Medium = Media.Air,
    dp_nominal=1000,
    m_flow_nominal=1)  annotation (Placement(transformation(extent={{10,16},{30,36}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink(
    redeclare package Medium = Media.Air,
    p=100000,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(extent={{176,-52},{156,-32}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,1.25e8; 1,1.25e8; 2,1.25e8; 3,1.25e8],
                                                                                    timeScale(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{176,72},{156,92}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    yMax=1,
    yMin=0.00001)
                 annotation (Placement(transformation(extent={{130,72},{110,92}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=turbine2.TurbPower)
    annotation (Placement(transformation(extent={{152,22},{132,42}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(surfaceArea=25000, alpha=25)
    annotation (Placement(transformation(extent={{-54,62},{-106,110}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=298.15)
    annotation (Placement(transformation(extent={{-172,78},{-152,98}})));
  Modelica.Blocks.Sources.RealExpression DischargeTrigger(y=DischargeStopTrig)
    annotation (Placement(transformation(extent={{128,124},{108,144}})));
  Modelica.Blocks.Math.Min min1 annotation (Placement(transformation(extent={{84,104},{64,124}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay              delay1(Ti=5)
    annotation (Placement(transformation(extent={{48,104},{28,124}})));
  TRANSFORM.Fluid.Valves.CheckValve CavernCheckValve(
    redeclare package Medium = Media.Air,
    R=0.001,
    checkValve=true) annotation (Placement(transformation(extent={{-26,16},{-6,36}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D conduction1(redeclare package Material =
        TRANSFORM.Media.Solids.CustomSolids.Rock_l_3_d_2700_cp_860, redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_1D (
        nX=3,
        length_x=1,
        length_y=250,
        length_z=100))
    annotation (Placement(transformation(extent={{-114,78},{-134,98}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package Medium = Media.Air)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={66,-10})));
  TRANSFORM.Fluid.Valves.CheckValve checkValve1(
    redeclare package Medium = Media.Air,
    R=0.001,
    checkValve=true) annotation (Placement(transformation(extent={{18,-20},{38,0}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Media.Air,
    use_m_flow_in=true,
    m_flow=1e-9,
    nPorts=1) annotation (Placement(transformation(extent={{-22,-76},{-2,-56}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Media.Air,
    p_start=100000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1000))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={8,-32})));
  Modelica.Blocks.Sources.Constant const(k=40)  annotation (Placement(transformation(extent={{-146,-32},{-126,-12}})));
  Modelica.Blocks.Sources.Constant const1(k=1e-9)
                                               annotation (Placement(transformation(extent={{-144,-98},{-124,-78}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{-102,-68},{-82,-48}})));
  Modelica.Blocks.Logical.LessEqual lessEqual annotation (Placement(transformation(extent={{-118,-146},{-138,-126}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=testtrig)
    annotation (Placement(transformation(extent={{-50,-128},{-70,-108}})));
  Modelica.Blocks.Sources.Constant const2(k=0.5)
                                               annotation (Placement(transformation(extent={{-50,-166},{-70,-146}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay              delay2(Ti=5)
    annotation (Placement(transformation(extent={{-60,-68},{-40,-48}})));
initial equation
  DischargeStopTrig = 1;
  testtrig = 1;

equation
  der(DischargeStopTrig) = 1e-20;
  der(testtrig) = 1e-20;
  when Cavern.medium.p <= 18E5 then
    reinit(DischargeStopTrig,0);
  end when;

  when Cavern.medium.p <= 25E5 then
    reinit(testtrig,0);
  end when;

  connect(PID.u_s, timeTable.y) annotation (Line(points={{132,82},{155,82}},   color={0,0,127}));
  connect(realExpression1.y, PID.u_m) annotation (Line(points={{131,32},{120,32},{120,70}},color={0,0,127}));
  connect(Cavern.heatPort, convection.port_a) annotation (Line(points={{-54,42.2},{-54,86},{-61.8,86}}, color={191,0,0}));
  connect(min1.y, delay1.u) annotation (Line(points={{63,114},{50,114}},color={0,0,127}));
  connect(delay1.y, TurbValve.opening) annotation (Line(points={{26.6,114},{20,114},{20,34}},    color={0,0,127}));
  connect(Cavern.port, CavernCheckValve.port_a) annotation (Line(points={{-37.2,26},{-26,26}}, color={0,127,255}));
  connect(CavernCheckValve.port_b, TurbValve.port_a) annotation (Line(points={{-6,26},{10,26}},   color={0,127,255}));
  connect(convection.port_b, conduction1.port_a1)
    annotation (Line(points={{-98.2,86},{-98.2,88},{-114,88}},   color={191,0,0}));
  connect(conduction1.port_b1, fixedTemperature.port) annotation (Line(points={{-134,88},{-152,88}}, color={191,0,0}));
  connect(TurbValve.port_b, teeJunctionIdeal.port_2)
    annotation (Line(points={{30,26},{66,26},{66,0}},      color={0,127,255}));
  connect(teeJunctionIdeal.port_1, turbine2.inlet)
    annotation (Line(points={{66,-20},{66,-72},{80,-72}},   color={0,127,255}));
  connect(checkValve1.port_b, teeJunctionIdeal.port_3)
    annotation (Line(points={{38,-10},{56,-10}},                       color={0,127,255}));
  connect(boundary.ports[1], volume.port_a) annotation (Line(points={{-2,-66},{8,-66},{8,-38}},
                                                                                             color={0,127,255}));
  connect(const.y,switch1. u1) annotation (Line(points={{-125,-22},{-114,-22},{-114,-50},{-104,-50}}, color={0,0,127}));
  connect(const1.y,switch1. u3) annotation (Line(points={{-123,-88},{-114,-88},{-114,-66},{-104,-66}},   color={0,0,127}));
  connect(lessEqual.y,switch1. u2) annotation (Line(points={{-139,-136},{-166,-136},{-166,-58},{-104,-58}},
                                                                                    color={255,0,255}));
  connect(realExpression2.y,lessEqual. u1)
    annotation (Line(points={{-71,-118},{-98,-118},{-98,-136},{-116,-136}},    color={0,0,127}));
  connect(const2.y,lessEqual. u2) annotation (Line(points={{-71,-156},{-98,-156},{-98,-144},{-116,-144}},
                                                                                   color={0,0,127}));
  connect(switch1.y,delay2. u) annotation (Line(points={{-81,-58},{-62,-58}},   color={0,0,127}));
  connect(boundary.m_flow_in, delay2.y)
    annotation (Line(points={{-22,-58},{-38.6,-58}},                                                   color={0,0,127}));
  connect(volume.port_b, checkValve1.port_a)
    annotation (Line(points={{8,-26},{8,-10},{18,-10}},                color={0,127,255}));
  connect(Sink.ports[1], turbine2.outlet)
    annotation (Line(points={{156,-42},{142,-42},{142,-72},{128,-72}},
                                                                   color={0,127,255}));
  connect(min1.u2, PID.y) annotation (Line(points={{86,108},{100,108},{100,82},{109,82}}, color={0,0,127}));
  connect(min1.u1, DischargeTrigger.y) annotation (Line(points={{86,120},{98,120},{98,134},{107,134}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-200,-200},{200,200}})),
    Icon(coordinateSystem(extent={{-120,-100},{160,100}}), graphics={
                             Bitmap(extent={{-92,-72},{92,76}},   fileName="modelica://NHES/Icons/EnergyStoragePackage/CAES.jpg")}),
    Documentation(revisions="<html>
<ul>
<li><i>10 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>",
      info="<html>
<p>This model contains the  gas turbine, generator and network models. The network model is based on swing equation.
</html>"),
    experiment(
      StopTime=10000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Esdirk45a"));
end DischargingFinal_V4;
