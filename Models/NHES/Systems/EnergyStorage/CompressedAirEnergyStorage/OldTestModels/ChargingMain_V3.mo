within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.OldTestModels;
model ChargingMain_V3
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
    T_start=298.15,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1500000))
    annotation (Placement(transformation(extent={{126,80},{166,40}}, rotation=0)));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SourceP1(
    redeclare package Medium = NHES.Media.Air,
    T=298.15,
    nPorts=1) annotation (Placement(transformation(extent={{-60,-120},{-40,-100}}, rotation=0)));
  inner ThermoPower.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{168,170},{188,190}})));
  TRANSFORM.Fluid.Valves.ValveLinear CavernValve(
    redeclare package Medium = NHES.Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{52,50},{72,70}})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-66,160},{-46,180}})));
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
    p(displayUnit="bar") = 100000,                                                          nPorts=1)
    annotation (Placement(transformation(extent={{-102,-44},{-82,-24}})));
  TRANSFORM.Fluid.Valves.ValveLinear SinkValve(
    redeclare package Medium = NHES.Media.Air,
    dp_start=100,
    dp_nominal=1000,
    m_flow_nominal=94) annotation (Placement(transformation(extent={{0,-44},{-20,-24}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Cavern.medium.p)
    annotation (Placement(transformation(extent={{-276,82},{-256,102}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{-122,40},{-102,60}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
                                              annotation (Placement(transformation(extent={{-170,0},{-150,20}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay1(Ti=1)
    annotation (Placement(transformation(extent={{-78,-2},{-58,18}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=5,
    offset=0,
    startTime=0) annotation (Placement(transformation(extent={{-170,80},{-150,100}})));
  Modelica.Blocks.Sources.Constant const1(k=26.5e5)
                                              annotation (Placement(transformation(extent={{-274,-2},{-254,18}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual annotation (Placement(transformation(extent={{-214,40},{-194,60}})));
  Modelica.Blocks.Sources.RealExpression SinkValveValue(y=-1*SinkValve.opening)
    annotation (Placement(transformation(extent={{-66,116},{-46,136}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-14,154},{6,174}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay              delay2(Ti=5)
    annotation (Placement(transformation(extent={{34,154},{54,174}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,1.45e8; 1,1.45e8; 2,1.45e8; 3,1.45e8], timeScale(displayUnit="h")=
         3600)
    annotation (Placement(transformation(extent={{266,-116},{240,-90}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    yMax=157.08,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=157.08)
                 annotation (Placement(transformation(extent={{196,-112},{176,-92}})));
  Modelica.Blocks.Sources.RealExpression CompressorPower(y=mainCompressor.omega*mainCompressor.tau*mainCompressor.eta_mech)
    annotation (Placement(transformation(extent={{260,-164},{240,-144}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay              delay3(Ti=1)
    annotation (Placement(transformation(extent={{132,-164},{112,-144}})));
  TRANSFORM.Mechanics.Rotational.Sources.VariableSpeed variableSpeed(use_port=true)
    annotation (Placement(transformation(extent={{74,-164},{54,-144}})));
equation
  connect(CavernValve.port_b, checkValve.port_a) annotation (Line(points={{72,60},{90,60}}, color={0,127,255}));
  connect(CavernValve.port_a, teeJunctionIdeal.port_2)
    annotation (Line(points={{52,60},{38,60},{38,-24},{36,-24}}, color={0,127,255}));
  connect(teeJunctionIdeal.port_1, mainCompressor.outlet)
    annotation (Line(points={{36,-44},{36,-130},{22,-130}}, color={0,127,255}));
  connect(const3.y, switch1.u3) annotation (Line(points={{-149,10},{-134,10},{-134,42},{-124,42}},     color={0,0,127}));
  connect(SinkValve.port_b, SinkAtmosphere.ports[1]) annotation (Line(points={{-20,-34},{-82,-34}}, color={0,127,255}));
  connect(SinkValve.port_a, teeJunctionIdeal.port_3) annotation (Line(points={{0,-34},{26,-34}}, color={0,127,255}));
  connect(ramp.y, switch1.u1) annotation (Line(points={{-149,90},{-136,90},{-136,58},{-124,58}},     color={0,0,127}));
  connect(switch1.y, delay1.u) annotation (Line(points={{-101,50},{-90,50},{-90,8},{-80,8}},   color={0,0,127}));
  connect(delay1.y, SinkValve.opening) annotation (Line(points={{-56.6,8},{-10,8},{-10,-26}},   color={0,0,127}));
  connect(checkValve.port_b, Cavern.port) annotation (Line(points={{110,60},{134,60}}, color={0,127,255}));
  connect(realExpression.y, greaterEqual.u1)
    annotation (Line(points={{-255,92},{-236,92},{-236,50},{-216,50}},   color={0,0,127}));
  connect(const1.y, greaterEqual.u2) annotation (Line(points={{-253,8},{-234,8},{-234,42},{-216,42}},   color={0,0,127}));
  connect(greaterEqual.y, switch1.u2) annotation (Line(points={{-193,50},{-124,50}}, color={255,0,255}));
  connect(SourceP1.ports[1], mainCompressor.inlet)
    annotation (Line(points={{-40,-110},{-26,-110},{-26,-130}}, color={0,127,255}));
  connect(const.y, add.u1) annotation (Line(points={{-45,170},{-16,170}},
                                                                        color={0,0,127}));
  connect(SinkValveValue.y, add.u2) annotation (Line(points={{-45,126},{-26,126},{-26,158},{-16,158}},
                                                                                                 color={0,0,127}));
  connect(add.y, delay2.u) annotation (Line(points={{7,164},{32,164}},  color={0,0,127}));
  connect(delay2.y, CavernValve.opening) annotation (Line(points={{55.4,164},{62,164},{62,68}}, color={0,0,127}));
  connect(CompressorPower.y, PID.u_m) annotation (Line(points={{239,-154},{186,-154},{186,-114}}, color={0,0,127}));
  connect(timeTable.y, PID.u_s) annotation (Line(points={{238.7,-103},{198,-102}}, color={0,0,127}));
  connect(variableSpeed.flange, mainCompressor.shaft_b) annotation (Line(points={{54,-154},{16,-154}}, color={0,0,0}));
  connect(delay3.y, variableSpeed.w_ext) annotation (Line(points={{110.6,-154},{76,-154}}, color={0,0,127}));
  connect(delay3.u, PID.y) annotation (Line(points={{134,-154},{166,-154},{166,-102},{175,-102}}, color={0,0,127}));
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
end ChargingMain_V3;
