within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.OldTestModels;
model DischargingFinal_V2
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
    Tstart_out=423.15,
    Tdes_in=473.15,
    Tstart_in=473.15,
    Ndesign=157.08) annotation (Placement(transformation(extent={{-18,-108},{42,-48}},rotation=0)));
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
    T=423.15,
    nPorts=1) annotation (Placement(transformation(extent={{78,-36},{58,-16}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume vol2(
    redeclare package Medium = Media.Air,
    p_start=turbine2.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.00001))
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={-12,-10})));
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
  Modelica.Blocks.Sources.Constant const(k=150) annotation (Placement(transformation(extent={{-192,-60},{-172,-40}})));
  Modelica.Blocks.Sources.Constant const1(k=1e-6)
                                               annotation (Placement(transformation(extent={{-192,-126},{-172,-106}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{-148,-96},{-128,-76}})));
  Modelica.Blocks.Logical.LessEqual lessEqual annotation (Placement(transformation(extent={{-248,-96},{-228,-76}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=testtrig)
    annotation (Placement(transformation(extent={{-344,-38},{-324,-18}})));
  Modelica.Blocks.Sources.Constant const2(k=0.5)
                                               annotation (Placement(transformation(extent={{-346,-104},{-326,-84}})));
  TRANSFORM.Fluid.Valves.CheckValve checkValve(
    redeclare package Medium = ThermoPower.Media.Air,
    R=0.001,
    checkValve=true) annotation (Placement(transformation(extent={{-84,16},{-64,36}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay              delay2(Ti=5)
    annotation (Placement(transformation(extent={{-110,-96},{-90,-76}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MassFlow(
    redeclare package Medium = ThermoPower.Media.Air,
    use_m_flow_in=true,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{-64,-168},{-44,-148}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink1(
    redeclare package Medium = ThermoPower.Media.Air,
    p=10000,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{96,-172},{76,-152}})));
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
            annotation (Placement(transformation(extent={{-18,-186},{26,-154}})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare package Medium = ThermoPower.Media.Air, dp0=
        2500000) annotation (Placement(transformation(extent={{34,-172},{54,-152}})));
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
    annotation (Line(points={{36,-54},{36,-26},{58,-26}},    color={159,159,223}));
  connect(vol2.port_b,turbine2. inlet)
    annotation (Line(points={{-12,-17.2},{-12,-54}},
                                                 color={0,127,255}));
  connect(PID.u_s, timeTable.y) annotation (Line(points={{116,82},{155,82}},   color={0,0,127}));
  connect(realExpression1.y, PID.u_m) annotation (Line(points={{131,32},{104,32},{104,70}},color={0,0,127}));
  connect(Cavern.heatPort, convection.port_a) annotation (Line(points={{-114,42.2},{-114,86},{-127.8,86}},
                                                                                                        color={191,0,0}));
  connect(vol2.port_a, TurbValve.port_b) annotation (Line(points={{-12,-2.8},{-12,26},{-26,26}},
                                                                                               color={0,127,255}));
  connect(DischargeTrigger.y, min1.u1) annotation (Line(points={{91,134},{60,134},{60,120},{50,120}}, color={0,0,127}));
  connect(PID.y, min1.u2) annotation (Line(points={{93,82},{60,82},{60,108},{50,108}}, color={0,0,127}));
  connect(min1.y, delay1.u) annotation (Line(points={{27,114},{6,114}}, color={0,0,127}));
  connect(delay1.y, TurbValve.opening) annotation (Line(points={{-17.4,114},{-36,114},{-36,34}}, color={0,0,127}));
  connect(const.y, switch1.u1) annotation (Line(points={{-171,-50},{-160,-50},{-160,-78},{-150,-78}}, color={0,0,127}));
  connect(const1.y, switch1.u3) annotation (Line(points={{-171,-116},{-160,-116},{-160,-94},{-150,-94}}, color={0,0,127}));
  connect(lessEqual.y, switch1.u2) annotation (Line(points={{-227,-86},{-150,-86}}, color={255,0,255}));
  connect(realExpression2.y, lessEqual.u1)
    annotation (Line(points={{-323,-28},{-297.5,-28},{-297.5,-86},{-250,-86}}, color={0,0,127}));
  connect(const2.y, lessEqual.u2) annotation (Line(points={{-325,-94},{-250,-94}}, color={0,0,127}));
  connect(Cavern.port, checkValve.port_a) annotation (Line(points={{-97.2,26},{-84,26}}, color={0,127,255}));
  connect(checkValve.port_b, TurbValve.port_a) annotation (Line(points={{-64,26},{-46,26}}, color={0,127,255}));
  connect(switch1.y, delay2.u) annotation (Line(points={{-127,-86},{-112,-86}}, color={0,0,127}));
  connect(MassFlow.m_flow_in, delay2.y) annotation (Line(points={{-64,-150},{-64,-86},{-88.6,-86}}, color={0,0,127}));
  connect(convection.port_b, conduction1.port_a1)
    annotation (Line(points={{-164.2,86},{-164.2,88},{-202,88}}, color={191,0,0}));
  connect(conduction1.port_b1, fixedTemperature.port) annotation (Line(points={{-222,88},{-268,88}}, color={191,0,0}));
  connect(MassFlow.ports[1], compressor1.inlet)
    annotation (Line(points={{-44,-158},{-26,-158},{-26,-157.2},{-9.2,-157.2}}, color={0,127,255}));
  connect(Sink1.ports[1], resistance.port_b) annotation (Line(points={{76,-162},{51,-162}}, color={0,127,255}));
  connect(resistance.port_a, compressor1.outlet)
    annotation (Line(points={{37,-162},{28,-162},{28,-157.2},{17.2,-157.2}}, color={0,127,255}));
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
end DischargingFinal_V2;
