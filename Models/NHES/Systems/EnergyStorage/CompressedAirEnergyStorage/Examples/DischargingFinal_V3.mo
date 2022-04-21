within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Examples;
model DischargingFinal_V3
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
    Ndesign=157.08) annotation (Placement(transformation(extent={{-8,-126},{52,-66}}, rotation=0)));
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
    p=10000,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(extent={{88,-54},{68,-34}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,1.25e8; 1,1.25e8; 2,1.25e8; 3,1.25e8],
                                                                                    timeScale(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{176,72},{156,92}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    yMax=1,
    yMin=0.00001)
                 annotation (Placement(transformation(extent={{114,72},{94,92}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=turbine2.TurbPower)
    annotation (Placement(transformation(extent={{152,22},{132,42}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(surfaceArea=25000, alpha=25)
    annotation (Placement(transformation(extent={{-120,62},{-172,110}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=298.15)
    annotation (Placement(transformation(extent={{-288,78},{-268,98}})));
  Modelica.Blocks.Sources.RealExpression DischargeTrigger(y=DischargeStopTrig)
    annotation (Placement(transformation(extent={{112,124},{92,144}})));
  Modelica.Blocks.Math.Min min1 annotation (Placement(transformation(extent={{48,104},{28,124}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay              delay1(Ti=5)
    annotation (Placement(transformation(extent={{4,104},{-16,124}})));
  Modelica.Blocks.Sources.Constant const(k=150) annotation (Placement(transformation(extent={{-318,-106},{-298,-86}})));
  Modelica.Blocks.Sources.Constant const1(k=1e-6)
                                               annotation (Placement(transformation(extent={{-318,-172},{-298,-152}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{-274,-142},{-254,-122}})));
  Modelica.Blocks.Logical.LessEqual lessEqual annotation (Placement(transformation(extent={{-374,-142},{-354,-122}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=testtrig)
    annotation (Placement(transformation(extent={{-470,-84},{-450,-64}})));
  Modelica.Blocks.Sources.Constant const2(k=0.5)
                                               annotation (Placement(transformation(extent={{-472,-150},{-452,-130}})));
  TRANSFORM.Fluid.Valves.CheckValve checkValve(
    redeclare package Medium = ThermoPower.Media.Air,
    R=0.001,
    checkValve=true) annotation (Placement(transformation(extent={{-84,16},{-64,36}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay              delay2(Ti=5)
    annotation (Placement(transformation(extent={{-236,-142},{-216,-122}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MassFlow(
    redeclare package Medium = ThermoPower.Media.Air,
    use_m_flow_in=true,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{-64,-168},{-44,-148}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink1(
    redeclare package Medium = ThermoPower.Media.Air,
    p=10000,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{98,-172},{78,-152}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D conduction1(redeclare package Material =
        TRANSFORM.Media.Solids.CustomSolids.Rock_l_3_d_2700_cp_860, redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_1D (
        nX=3,
        length_x=1,
        length_y=250,
        length_z=100))
    annotation (Placement(transformation(extent={{-202,78},{-222,98}})));
  GasTurbine.Compressor.Compressor      compressor1(
    redeclare package Medium = ThermoPower.Media.Air,
    pstart_in=1000,
    Tstart_in(displayUnit="degC") = 298.15,
    Tstart_out=298.15,
    eta0=0.98,
    PR0=20,
    w0=1e-6)
            annotation (Placement(transformation(extent={{-20,-188},{24,-156}})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare package Medium = ThermoPower.Media.Air, dp0=
        2500000) annotation (Placement(transformation(extent={{36,-172},{56,-152}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package Medium = Media.Air)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,-24})));
  TRANSFORM.Fluid.Valves.ValveLinear SinkValve(
    redeclare package Medium = Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{-68,-74},{-88,-54}})));
  Modelica.Fluid.Sources.FixedBoundary SinkAtmosphere(
    redeclare package Medium = Media.Air,
    p(displayUnit="bar") = 100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-146,-74},{-126,-54}})));
  Modelica.Blocks.Sources.Constant const3(k=0)  annotation (Placement(transformation(extent={{-186,-44},{-166,-24}})));
initial equation
  DischargeStopTrig = 1;
  testtrig = 1;

equation
  der(DischargeStopTrig) = 1e-20;
  der(testtrig) = 1e-20;
  when Cavern.medium.p <= 18E5 then
    reinit(DischargeStopTrig,0);
  end when;

  when Cavern.medium.p <= 26E5 then
    reinit(testtrig,0);
  end when;

  connect(turbine2.outlet,Sink. ports[1])
    annotation (Line(points={{46,-72},{46,-44},{68,-44}},    color={159,159,223}));
  connect(PID.u_s, timeTable.y) annotation (Line(points={{116,82},{155,82}},   color={0,0,127}));
  connect(realExpression1.y, PID.u_m) annotation (Line(points={{131,32},{104,32},{104,70}},color={0,0,127}));
  connect(Cavern.heatPort, convection.port_a) annotation (Line(points={{-114,42.2},{-114,86},{-127.8,86}},
                                                                                                        color={191,0,0}));
  connect(DischargeTrigger.y, min1.u1) annotation (Line(points={{91,134},{60,134},{60,120},{50,120}}, color={0,0,127}));
  connect(PID.y, min1.u2) annotation (Line(points={{93,82},{60,82},{60,108},{50,108}}, color={0,0,127}));
  connect(min1.y, delay1.u) annotation (Line(points={{27,114},{6,114}}, color={0,0,127}));
  connect(delay1.y, TurbValve.opening) annotation (Line(points={{-17.4,114},{-36,114},{-36,34}}, color={0,0,127}));
  connect(const.y, switch1.u1) annotation (Line(points={{-297,-96},{-286,-96},{-286,-124},{-276,-124}},
                                                                                                      color={0,0,127}));
  connect(const1.y, switch1.u3) annotation (Line(points={{-297,-162},{-286,-162},{-286,-140},{-276,-140}},
                                                                                                         color={0,0,127}));
  connect(lessEqual.y, switch1.u2) annotation (Line(points={{-353,-132},{-276,-132}},
                                                                                    color={255,0,255}));
  connect(realExpression2.y, lessEqual.u1)
    annotation (Line(points={{-449,-74},{-423.5,-74},{-423.5,-132},{-376,-132}},
                                                                               color={0,0,127}));
  connect(const2.y, lessEqual.u2) annotation (Line(points={{-451,-140},{-376,-140}},
                                                                                   color={0,0,127}));
  connect(Cavern.port, checkValve.port_a) annotation (Line(points={{-97.2,26},{-84,26}}, color={0,127,255}));
  connect(checkValve.port_b, TurbValve.port_a) annotation (Line(points={{-64,26},{-46,26}}, color={0,127,255}));
  connect(switch1.y, delay2.u) annotation (Line(points={{-253,-132},{-238,-132}},
                                                                                color={0,0,127}));
  connect(MassFlow.m_flow_in, delay2.y) annotation (Line(points={{-64,-150},{-64,-132},{-214.6,-132}},
                                                                                                    color={0,0,127}));
  connect(convection.port_b, conduction1.port_a1)
    annotation (Line(points={{-164.2,86},{-164.2,88},{-202,88}}, color={191,0,0}));
  connect(conduction1.port_b1, fixedTemperature.port) annotation (Line(points={{-222,88},{-268,88}}, color={191,0,0}));
  connect(MassFlow.ports[1], compressor1.inlet)
    annotation (Line(points={{-44,-158},{-24,-158},{-24,-159.2},{-11.2,-159.2}},color={0,127,255}));
  connect(Sink1.ports[1], resistance.port_b) annotation (Line(points={{78,-162},{53,-162}}, color={0,127,255}));
  connect(resistance.port_a, compressor1.outlet)
    annotation (Line(points={{39,-162},{30,-162},{30,-159.2},{15.2,-159.2}}, color={0,127,255}));
  connect(TurbValve.port_b, teeJunctionIdeal.port_2)
    annotation (Line(points={{-26,26},{-16,26},{-16,-14}}, color={0,127,255}));
  connect(teeJunctionIdeal.port_1, turbine2.inlet)
    annotation (Line(points={{-16,-34},{-16,-72},{-2,-72}}, color={0,127,255}));
  connect(SinkValve.port_a, teeJunctionIdeal.port_3)
    annotation (Line(points={{-68,-64},{-32,-64},{-32,-24},{-26,-24}}, color={0,127,255}));
  connect(SinkValve.port_b, SinkAtmosphere.ports[1]) annotation (Line(points={{-88,-64},{-126,-64}}, color={0,127,255}));
  connect(const3.y, SinkValve.opening) annotation (Line(points={{-165,-34},{-78,-34},{-78,-56}}, color={0,0,127}));
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
end DischargingFinal_V3;
