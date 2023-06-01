within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Examples;
model ChargingMain_V4
  Real Trig;

  parameter Real tableEtaC[6, 4]=[0, 95, 100, 105;
                                  1, 82.5e-2, 81e-2, 80.5e-2;
                                  2, 84e-2, 82.9e-2, 82e-2;
                                  3, 83.2e-2, 82.2e-2, 81.5e-2;
                                  4, 82.5e-2, 81.2e-2, 79e-2;
                                  5, 79.5e-2, 78e-2, 76.5e-2];
  parameter Real tablePhicC[6, 4]=[0, 95, 100, 105;
                                   1, 38.3e-3, 43e-3, 46.8e-3;
                                   2, 39.3e-3, 43.8e-3, 47.9e-3;
                                   3, 40.6e-3, 45.2e-3, 48.4e-3;
                                   4, 41.6e-3, 46.1e-3, 48.9e-3;
                                   5, 42.3e-3, 46.6e-3, 49.3e-3];
  parameter Real tablePR[6, 4]=[0, 95, 100, 105;
                                1, 22.6, 27, 32;
                                2, 22, 26.6, 30.8;
                                3, 20.8, 25.5, 29;
                                4, 19, 24.3, 27.1;
                                5, 17, 21.5, 24.2];

  Components.MainCompressor mainCompressor(
    redeclare package Medium = Media.Air,
    tablePhic=tablePhicC,
    tableEta=tableEtaC,
    pstart_in=100000,
    pstart_out=200000,
    Tstart_in=298.15,
    tablePR=tablePR,
    Table=NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Data.TableTypes.matrix,
    Tstart_out=298.15,
    explicitIsentropicEnthalpy=true,
    Tdes_in=298.15,
    Ndesign=157.08) annotation (Placement(transformation(extent={{-122,-176},{-62,-116}},
                                                                                        rotation=0)));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port Cavern(
    redeclare package Medium = Media.Air,
    p_start=mainCompressor.pstart_out,
    T_start=298.15,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1e6),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{16,80},{56,40}},   rotation=0)));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SourceP1(
    redeclare package Medium = Media.Air,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{-150,-112},{-130,-92}},rotation=0)));
  TRANSFORM.Fluid.Valves.ValveLinear CavernValve(
    redeclare package Medium = Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-170,120},{-150,140}})));
  TRANSFORM.Fluid.Valves.CheckValve checkValve(
    redeclare package Medium = Media.Air,
    R=0.001,
    checkValve=true) annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package Medium = Media.Air)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-56,-34})));
  Modelica.Fluid.Sources.FixedBoundary SinkAtmosphere(
    redeclare package Medium = Media.Air,
    p(displayUnit="bar") = 100000,                                                          nPorts=1)
    annotation (Placement(transformation(extent={{-164,-44},{-144,-24}})));
  TRANSFORM.Fluid.Valves.ValveLinear SinkValve(
    redeclare package Medium = Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{-84,-44},{-104,-24}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay1(Ti=1)
    annotation (Placement(transformation(extent={{-130,-2},{-110,18}})));
  Modelica.Blocks.Sources.RealExpression SinkValveValue(y=-1*SinkValve.opening)
    annotation (Placement(transformation(extent={{-170,76},{-150,96}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-118,114},{-98,134}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay              delay2(Ti=5)
    annotation (Placement(transformation(extent={{-70,114},{-50,134}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,1.25E8; 1,1.25E8; 2,1.25E8; 3,1.25E8; 4,1.25E8; 5,1.25E8; 6,
        1.25E8; 7,1.25E8],                                                                      timeScale(displayUnit="h")=
         3600)
    annotation (Placement(transformation(extent={{162,-106},{136,-80}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    yMax=157.08,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=157.08)
                 annotation (Placement(transformation(extent={{98,-104},{78,-84}})));
  Modelica.Blocks.Sources.RealExpression CompressorPower(y=mainCompressor.omega*mainCompressor.tau*mainCompressor.eta_mech)
    annotation (Placement(transformation(extent={{164,-156},{144,-136}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay              delay3(Ti=1)
    annotation (Placement(transformation(extent={{38,-156},{18,-136}})));
  TRANSFORM.Mechanics.Rotational.Sources.VariableSpeed variableSpeed(use_port=true)
    annotation (Placement(transformation(extent={{-4,-156},{-24,-136}})));
  Modelica.Blocks.Sources.RealExpression TriggerValue(y=Trig)
    annotation (Placement(transformation(extent={{-168,-2},{-148,18}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(surfaceArea=25000, alpha=25)
    annotation (Placement(transformation(extent={{44,90},{96,138}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=298.15)
    annotation (Placement(transformation(extent={{166,104},{146,124}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D conduction1(redeclare package Material =
        TRANSFORM.Media.Solids.CustomSolids.Rock_l_3_d_2700_cp_860, redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_1D (
        nX=3,
        length_x=1,
        length_y=250,
        length_z=100))
    annotation (Placement(transformation(extent={{106,104},{126,124}})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{140,158},{160,178}})));
initial equation
  Trig = 0;

equation
  der(Trig) = 1e-20;
  when Cavern.medium.p >= 26.5E5 then
    reinit(Trig,1);
  end when;

  connect(CavernValve.port_b, checkValve.port_a) annotation (Line(points={{-30,60},{-10,60}},
                                                                                            color={0,127,255}));
  connect(teeJunctionIdeal.port_1, mainCompressor.outlet)
    annotation (Line(points={{-56,-44},{-56,-122},{-68,-122}},
                                                            color={0,127,255}));
  connect(SinkValve.port_b, SinkAtmosphere.ports[1]) annotation (Line(points={{-104,-34},{-144,-34}},
                                                                                                    color={0,127,255}));
  connect(SinkValve.port_a, teeJunctionIdeal.port_3) annotation (Line(points={{-84,-34},{-66,-34}},
                                                                                                 color={0,127,255}));
  connect(delay1.y, SinkValve.opening) annotation (Line(points={{-108.6,8},{-94,8},{-94,-26}},  color={0,0,127}));
  connect(checkValve.port_b, Cavern.port) annotation (Line(points={{10,60},{24,60}},   color={0,127,255}));
  connect(SourceP1.ports[1], mainCompressor.inlet)
    annotation (Line(points={{-130,-102},{-116,-102},{-116,-122}},
                                                                color={0,127,255}));
  connect(const.y, add.u1) annotation (Line(points={{-149,130},{-120,130}},
                                                                        color={0,0,127}));
  connect(SinkValveValue.y, add.u2) annotation (Line(points={{-149,86},{-130,86},{-130,118},{-120,118}},
                                                                                                 color={0,0,127}));
  connect(add.y, delay2.u) annotation (Line(points={{-97,124},{-72,124}},
                                                                        color={0,0,127}));
  connect(delay2.y, CavernValve.opening) annotation (Line(points={{-48.6,124},{-40,124},{-40,68}},
                                                                                                color={0,0,127}));
  connect(CompressorPower.y, PID.u_m) annotation (Line(points={{143,-146},{88,-146},{88,-106}},   color={0,0,127}));
  connect(timeTable.y, PID.u_s) annotation (Line(points={{134.7,-93},{100,-94}},   color={0,0,127}));
  connect(variableSpeed.flange, mainCompressor.shaft_b) annotation (Line(points={{-24,-146},{-74,-146}},
                                                                                                       color={0,0,0}));
  connect(delay3.y, variableSpeed.w_ext) annotation (Line(points={{16.6,-146},{-2,-146}},  color={0,0,127}));
  connect(delay3.u, PID.y) annotation (Line(points={{40,-146},{70,-146},{70,-94},{77,-94}},       color={0,0,127}));
  connect(TriggerValue.y, delay1.u) annotation (Line(points={{-147,8},{-132,8}},color={0,0,127}));
  connect(convection.port_a, Cavern.heatPort) annotation (Line(points={{51.8,114},{36,114},{36,72}}, color={191,0,0}));
  connect(convection.port_b, conduction1.port_a1)
    annotation (Line(points={{88.2,114},{106,114}},                      color={191,0,0}));
  connect(conduction1.port_b1, fixedTemperature.port) annotation (Line(points={{126,114},{146,114}}, color={191,0,0}));
  connect(teeJunctionIdeal.port_2, CavernValve.port_a)
    annotation (Line(points={{-56,-24},{-56,60},{-50,60}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1)),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={170,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-140,140},{140,-140}},
          lineColor={170,170,255},
          textString="P")}),
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
    experiment(StopTime=19800, __Dymola_Algorithm="Dassl"));
end ChargingMain_V4;
