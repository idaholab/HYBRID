within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.OldTestModels;
model ChargingMain
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

  parameter Real tablePhicT[5, 4]=[1, 90, 100, 110; 2.36, 4.68e-3, 4.68e-3,
      4.68e-3; 2.88, 4.68e-3, 4.68e-3, 4.68e-3; 3.56, 4.68e-3, 4.68e-3,
      4.68e-3; 4.46, 4.68e-3, 4.68e-3, 4.68e-3];
  parameter Real tableEtaT[5, 4]=[1, 90, 100, 110; 2.36, 89e-2, 89.5e-2,
      89.3e-2; 2.88, 90e-2, 90.6e-2, 90.5e-2; 3.56, 90.5e-2, 90.6e-2,
      90.5e-2; 4.46, 90.2e-2, 90.3e-2, 90e-2];
  Components.MainCompressor mainCompressor(
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
    Ndesign=157.08) annotation (Placement(transformation(extent={{-32,-184},{28,-124}}, rotation=0)));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port Cavern(
    redeclare package Medium = NHES.Media.Air,
    p_start=mainCompressor.pstart_out,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=150000),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{122,80},{162,40}}, rotation=0)));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SourceP1(
    redeclare package Medium = NHES.Media.Air,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{-60,-120},{-40,-100}}, rotation=0)));
  inner ThermoPower.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{168,170},{188,190}})));
  TRANSFORM.Fluid.Valves.ValveLinear CompValve(
    redeclare package Medium = NHES.Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{52,50},{72,70}})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-30,104},{-10,124}})));
  TRANSFORM.Fluid.Valves.CheckValve checkValve(
    redeclare package Medium = ThermoPower.Media.Air,
    R=0.001,
    checkValve=true) annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package Medium = ThermoPower.Media.Air)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={36,-34})));
  Modelica.Fluid.Sources.FixedBoundary SinkAtmosphere(redeclare package Medium = ThermoPower.Media.Air,
    p=1000000,                                                                              nPorts=1)
    annotation (Placement(transformation(extent={{-102,-44},{-82,-24}})));
  TRANSFORM.Fluid.Valves.ValveLinear SinkValve(
    redeclare package Medium = NHES.Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{0,-44},{-20,-24}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Cavern.medium.p)
    annotation (Placement(transformation(extent={{-280,124},{-260,144}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{-126,82},{-106,102}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
                                              annotation (Placement(transformation(extent={{-180,42},{-160,62}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay1(Ti=1)
    annotation (Placement(transformation(extent={{-82,12},{-62,32}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=5,
    offset=0,
    startTime=0) annotation (Placement(transformation(extent={{-174,122},{-154,142}})));
  Modelica.Blocks.Sources.Constant const1(k=26.5e5)
                                              annotation (Placement(transformation(extent={{-280,40},{-260,60}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual annotation (Placement(transformation(extent={{-218,82},{-198,102}})));
  Modelica.Blocks.Sources.RealExpression SinkValveValue(y=SinkValve.opening)
    annotation (Placement(transformation(extent={{98,-62},{118,-42}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=157.08)
    annotation (Placement(transformation(extent={{74,-164},{54,-144}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(surfaceArea=25000, alpha=25)
    annotation (Placement(transformation(extent={{170,86},{222,134}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=298.15)
    annotation (Placement(transformation(extent={{292,116},{272,136}})));
equation
  connect(const.y, CompValve.opening) annotation (Line(points={{-9,114},{62,114},{62,68}},   color={0,0,127}));
  connect(CompValve.port_b, checkValve.port_a) annotation (Line(points={{72,60},{90,60}},   color={0,127,255}));
  connect(CompValve.port_a, teeJunctionIdeal.port_2)
    annotation (Line(points={{52,60},{38,60},{38,-24},{36,-24}},
                                                             color={0,127,255}));
  connect(teeJunctionIdeal.port_1, mainCompressor.outlet)
    annotation (Line(points={{36,-44},{36,-130},{22,-130}}, color={0,127,255}));
  connect(const3.y, switch1.u3) annotation (Line(points={{-159,52},{-138,52},{-138,84},{-128,84}},     color={0,0,127}));
  connect(SinkValve.port_b, SinkAtmosphere.ports[1]) annotation (Line(points={{-20,-34},{-82,-34}}, color={0,127,255}));
  connect(SinkValve.port_a, teeJunctionIdeal.port_3) annotation (Line(points={{0,-34},{26,-34}}, color={0,127,255}));
  connect(ramp.y, switch1.u1) annotation (Line(points={{-153,132},{-140,132},{-140,100},{-128,100}}, color={0,0,127}));
  connect(switch1.y, delay1.u) annotation (Line(points={{-105,92},{-94,92},{-94,22},{-84,22}}, color={0,0,127}));
  connect(delay1.y, SinkValve.opening) annotation (Line(points={{-60.6,22},{-10,22},{-10,-26}}, color={0,0,127}));
  connect(checkValve.port_b, Cavern.port) annotation (Line(points={{110,60},{130,60}}, color={0,127,255}));
  connect(realExpression.y, greaterEqual.u1)
    annotation (Line(points={{-259,134},{-240,134},{-240,92},{-220,92}}, color={0,0,127}));
  connect(const1.y, greaterEqual.u2) annotation (Line(points={{-259,50},{-238,50},{-238,84},{-220,84}}, color={0,0,127}));
  connect(greaterEqual.y, switch1.u2) annotation (Line(points={{-197,92},{-128,92}}, color={255,0,255}));
  connect(constantSpeed.flange, mainCompressor.shaft_b) annotation (Line(points={{54,-154},{16,-154}}, color={0,0,0}));
  connect(SourceP1.ports[1], mainCompressor.inlet)
    annotation (Line(points={{-40,-110},{-26,-110},{-26,-130}}, color={0,127,255}));
  connect(convection.port_a, Cavern.heatPort) annotation (Line(points={{177.8,110},{142,110},{142,72}}, color={191,0,0}));
  connect(convection.port_b, fixedTemperature.port)
    annotation (Line(points={{214.2,110},{238,110},{238,126},{272,126}}, color={191,0,0}));
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
</html>"));
end ChargingMain;
