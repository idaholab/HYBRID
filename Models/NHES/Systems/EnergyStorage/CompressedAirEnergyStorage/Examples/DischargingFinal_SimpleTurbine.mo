within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Examples;
model DischargingFinal_SimpleTurbine
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
    annotation (Placement(transformation(extent={{172,170},{192,190}})));
  GasTurbine.Turbine.Turbine
                           turbine2(
    redeclare package Medium = Media.Air,
    pstart_in=710000,
    pstart_out=200000,
    Tstart_out=323.15,
    Tstart_in=373.15,
    PR0=5,
    w0=100)         annotation (Placement(transformation(extent={{-8,-126},{52,-66}}, rotation=0)));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port
                                       Cavern(
    redeclare package Medium = Media.Air,
    p_start=2580000,
    T_start=376.05,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=3300000),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{-86,53},{-142,-1}})));
  TRANSFORM.Fluid.Valves.ValveLinear TurbValve(
    redeclare package Medium = Media.Air,
    dp_nominal=1000,
    m_flow_nominal=1)  annotation (Placement(transformation(extent={{-46,16},{-26,36}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink(
    redeclare package Medium = Media.Air,
    p=100000,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(extent={{94,-52},{74,-32}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    yMax=1,
    yMin=0.00001)
                 annotation (Placement(transformation(extent={{114,72},{94,92}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=turbine2.Wt)
    annotation (Placement(transformation(extent={{152,22},{132,42}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(surfaceArea=25000, alpha=25)
    annotation (Placement(transformation(extent={{-120,62},{-172,110}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=298.15)
    annotation (Placement(transformation(extent={{-288,78},{-268,98}})));
  Modelica.Blocks.Sources.RealExpression DischargeTrigger(y=DischargeStopTrig)
    annotation (Placement(transformation(extent={{112,124},{92,144}})));
  Modelica.Blocks.Math.Min min1 annotation (Placement(transformation(extent={{48,104},{28,124}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay              delay1(Ti=1)
    annotation (Placement(transformation(extent={{4,104},{-16,124}})));
  TRANSFORM.Fluid.Valves.CheckValve CavernCheckValve(
    redeclare package Medium = ThermoPower.Media.Air,
    R=0.001,
    checkValve=true) annotation (Placement(transformation(extent={{-84,16},{-64,36}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D conduction1(redeclare package Material =
        TRANSFORM.Media.Solids.CustomSolids.Rock_l_3_d_2700_cp_860, redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_1D (
        nX=3,
        length_x=1,
        length_y=250,
        length_z=100))
    annotation (Placement(transformation(extent={{-202,78},{-222,98}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = ThermoPower.Media.Air,
    p_start=100000,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1000))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-2,-28})));
  Modelica.Blocks.Sources.Constant const(k=45e6)
                                                annotation (Placement(transformation(extent={{182,72},{162,92}})));
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

  connect(realExpression1.y, PID.u_m) annotation (Line(points={{131,32},{104,32},{104,70}},color={0,0,127}));
  connect(Cavern.heatPort, convection.port_a) annotation (Line(points={{-114,42.2},{-114,86},{-127.8,86}},
                                                                                                        color={191,0,0}));
  connect(DischargeTrigger.y, min1.u1) annotation (Line(points={{91,134},{60,134},{60,120},{50,120}}, color={0,0,127}));
  connect(PID.y, min1.u2) annotation (Line(points={{93,82},{60,82},{60,108},{50,108}}, color={0,0,127}));
  connect(min1.y, delay1.u) annotation (Line(points={{27,114},{6,114}}, color={0,0,127}));
  connect(delay1.y, TurbValve.opening) annotation (Line(points={{-17.4,114},{-36,114},{-36,34}}, color={0,0,127}));
  connect(Cavern.port, CavernCheckValve.port_a) annotation (Line(points={{-97.2,26},{-84,26}}, color={0,127,255}));
  connect(CavernCheckValve.port_b, TurbValve.port_a) annotation (Line(points={{-64,26},{-46,26}}, color={0,127,255}));
  connect(convection.port_b, conduction1.port_a1)
    annotation (Line(points={{-164.2,86},{-164.2,88},{-202,88}}, color={191,0,0}));
  connect(conduction1.port_b1, fixedTemperature.port) annotation (Line(points={{-222,88},{-268,88}}, color={191,0,0}));
  connect(Sink.ports[1], turbine2.outlet)
    annotation (Line(points={{74,-42},{60,-42},{60,-72},{40,-72}}, color={0,127,255}));
  connect(TurbValve.port_b, volume.port_a) annotation (Line(points={{-26,26},{-2,26},{-2,-22}}, color={0,127,255}));
  connect(volume.port_b, turbine2.inlet) annotation (Line(points={{-2,-34},{-2,-54},{-2,-72},{4,-72}}, color={0,127,255}));
  connect(const.y, PID.u_s) annotation (Line(points={{161,82},{116,82}}, color={0,0,127}));
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
end DischargingFinal_SimpleTurbine;
