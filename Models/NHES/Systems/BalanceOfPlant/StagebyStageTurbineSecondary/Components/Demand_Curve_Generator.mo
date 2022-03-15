within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Components;
model Demand_Curve_Generator
  extends BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  parameter Modelica.Units.SI.Time Ramp_Stor=600 "Time allowed for demand ramp";
  parameter Modelica.Units.SI.Time Ramp_Dis=600 "Time allowed for demand ramp";
  parameter Modelica.Units.SI.Power Q_nom=52000000;

  Modelica.Blocks.Math.Sum Anticipatory_Signals(nin=7) annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={16,-12})));
  Modelica.Blocks.Math.Add  Net_Demand
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-34,-26})));
  Modelica.Blocks.Sources.Constant NomPower(k=Q_nom)
    annotation (Placement(transformation(extent={{-74,38},{-64,48}})));
  Modelica.Blocks.Sources.Ramp      Ch1(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=5000)               annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-57,117})));
  Modelica.Blocks.Sources.Ramp      Ch2(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=8000)                annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-57,107})));
  Modelica.Blocks.Sources.Ramp      Ch3(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=11000)                annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-57,97})));
  Modelica.Blocks.Sources.Ramp      Ch4(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=14000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={-41,127})));
  Modelica.Blocks.Sources.Ramp      Ch5(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=17000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-27,117})));
  Modelica.Blocks.Sources.Ramp      Ch6(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=20000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-27,107})));
  Modelica.Blocks.Sources.Ramp      Ch7(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=23000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-27,97})));
  Modelica.Blocks.Math.Sum Charge_Sum(nin=28)
                                             annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-38,58})));
  Modelica.Blocks.Sources.Trapezoid Ant7(
    amplitude=1,
    rising=Ramp_Dis,
    width=1800,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=655200 - Ramp_Dis) annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={33,29})));
  Modelica.Blocks.Sources.Trapezoid Ant6(
    amplitude=1,
    rising=Ramp_Dis,
    width=1800,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=489600 - Ramp_Dis) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={25,35})));
  Modelica.Blocks.Sources.Trapezoid Ant5(
    amplitude=1,
    rising=Ramp_Dis,
    width=1800,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=396000 - Ramp_Dis) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={15,35})));
  Modelica.Blocks.Sources.Trapezoid Ant4(
    amplitude=1,
    rising=Ramp_Dis,
    width=1800,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=313200 - Ramp_Dis) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={5,35})));
  Modelica.Blocks.Sources.Trapezoid Ant3(
    amplitude=1,
    rising=Ramp_Dis,
    width=1800,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=226800 - Ramp_Dis) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-1,29})));
  Modelica.Blocks.Sources.Trapezoid Ant2(
    amplitude=1,
    rising=Ramp_Dis,
    width=1800,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=129600 - Ramp_Dis) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-1,19})));
  Modelica.Blocks.Sources.Trapezoid Ant1(
    amplitude=1,
    rising=Ramp_Dis,
    width=1800,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=46800 - Ramp_Dis) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-1,9})));
  Modelica.Blocks.Sources.Ramp      Ch8(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=43000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={19,97})));
  Modelica.Blocks.Sources.Ramp      Ch9(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=40000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={19,107})));
  Modelica.Blocks.Sources.Ramp      Ch10(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=37000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={19,117})));
  Modelica.Blocks.Sources.Ramp      Ch11(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=34000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={5,127})));
  Modelica.Blocks.Sources.Ramp      Ch12(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=25000)              annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-11,117})));
  Modelica.Blocks.Sources.Ramp      Ch13(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=28000)               annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-11,107})));
  Modelica.Blocks.Sources.Ramp      Ch14(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=31000)                annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-11,97})));
  Modelica.Blocks.Sources.Ramp      Ch15(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=63000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-101,97})));
  Modelica.Blocks.Sources.Ramp      Ch16(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=60000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-101,107})));
  Modelica.Blocks.Sources.Ramp      Ch17(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=57000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-101,117})));
  Modelica.Blocks.Sources.Ramp      Ch18(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=54000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={-115,127})));
  Modelica.Blocks.Sources.Ramp      Ch19(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=45000)              annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-131,117})));
  Modelica.Blocks.Sources.Ramp      Ch20(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=48000)               annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-131,107})));
  Modelica.Blocks.Sources.Ramp      Ch21(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=51000)                annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-131,97})));
  Modelica.Blocks.Sources.Ramp      Ch22(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=83000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={93,93})));
  Modelica.Blocks.Sources.Ramp      Ch23(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=80000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={93,103})));
  Modelica.Blocks.Sources.Ramp      Ch24(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=77000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={93,113})));
  Modelica.Blocks.Sources.Ramp      Ch25(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=74000)                annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={79,123})));
  Modelica.Blocks.Sources.Ramp      Ch26(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=65000)              annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={63,113})));
  Modelica.Blocks.Sources.Ramp      Ch27(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=68000)               annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={63,103})));
  Modelica.Blocks.Sources.Ramp      Ch28(
    height=-1e6,
    duration=20,
    offset=0,
    startTime=71000)                annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={63,93})));
equation
  connect(actuatorBus.Demand, Net_Demand.y) annotation (Line(
      points={{30,-100},{28,-100},{28,-54},{-48,-54},{-48,-37},{-34,-37}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Charge_Sum.y,Net_Demand. u2) annotation (Line(points={{-38,51.4},{-38,
          -14},{-40,-14}},                        color={0,0,127}));
  connect(Ch1.y,Charge_Sum. u[1]) annotation (Line(points={{-53.7,117},{-36,117},
          {-36,70},{-36.8429,70},{-36.8429,65.2}},
                                      color={0,0,127}));
  connect(Ch2.y,Charge_Sum. u[2]) annotation (Line(points={{-53.7,107},{-36,107},
          {-36,70},{-36.9286,70},{-36.9286,65.2}},
                            color={0,0,127}));
  connect(Ch4.y,Charge_Sum. u[4]) annotation (Line(points={{-41,123.7},{-41,116},
          {-36,116},{-36,70},{-37.1,70},{-37.1,65.2}},
                               color={0,0,127}));
  connect(Ch5.y,Charge_Sum. u[5]) annotation (Line(points={{-30.3,117},{-36,117},
          {-36,70},{-37.1857,70},{-37.1857,65.2}},
                            color={0,0,127}));
  connect(Ch6.y,Charge_Sum. u[6]) annotation (Line(points={{-30.3,107},{-36,107},
          {-36,70},{-37.2714,70},{-37.2714,65.2}},
                            color={0,0,127}));
  connect(Ch7.y,Charge_Sum. u[7]) annotation (Line(points={{-30.3,97},{-36,97},
          {-36,70},{-37.3571,70},{-37.3571,65.2}},
                            color={0,0,127}));
  connect(Ch3.y,Charge_Sum. u[3]) annotation (Line(points={{-53.7,97},{-36,97},
          {-36,70},{-37.0143,70},{-37.0143,65.2}},
                            color={0,0,127}));
  connect(Ant1.y, Anticipatory_Signals.u[1]) annotation (Line(points={{2.3,9},{
          18,9},{18,-4.8},{17.0286,-4.8}}, color={0,0,127}));
  connect(Ant2.y, Anticipatory_Signals.u[2]) annotation (Line(points={{2.3,19},
          {16.6857,19},{16.6857,-4.8}}, color={0,0,127}));
  connect(Ant3.y, Anticipatory_Signals.u[3]) annotation (Line(points={{2.3,29},
          {16.3429,29},{16.3429,-4.8}}, color={0,0,127}));
  connect(Ant4.y, Anticipatory_Signals.u[4]) annotation (Line(points={{5,31.7},
          {5,28},{16,28},{16,-4.8}}, color={0,0,127}));
  connect(Ant5.y, Anticipatory_Signals.u[5])
    annotation (Line(points={{15,31.7},{15.6571,-4.8}}, color={0,0,127}));
  connect(Ant6.y, Anticipatory_Signals.u[6]) annotation (Line(points={{25,31.7},
          {25,28},{15.3143,28},{15.3143,-4.8}}, color={0,0,127}));
  connect(Ant7.y, Anticipatory_Signals.u[7]) annotation (Line(points={{29.7,29},
          {14,29},{14,-4.8},{14.9714,-4.8}}, color={0,0,127}));
  connect(Ch14.y, Charge_Sum.u[8]) annotation (Line(points={{-7.7,97},{2,97},{2,
          65.2},{-37.4429,65.2}}, color={0,0,127}));
  connect(Ch8.y, Charge_Sum.u[14]) annotation (Line(points={{15.7,97},{6,97},{6,
          65.2},{-37.9571,65.2}}, color={0,0,127}));
  connect(Ch9.y, Charge_Sum.u[13]) annotation (Line(points={{15.7,107},{4,107},
          {4,65.2},{-37.8714,65.2}}, color={0,0,127}));
  connect(Ch10.y, Charge_Sum.u[12]) annotation (Line(points={{15.7,117},{4,117},
          {4,65.2},{-37.7857,65.2}}, color={0,0,127}));
  connect(Ch11.y, Charge_Sum.u[11]) annotation (Line(points={{5,123.7},{4,123.7},
          {4,65.2},{-37.7,65.2}}, color={0,0,127}));
  connect(Ch12.y, Charge_Sum.u[10]) annotation (Line(points={{-7.7,117},{4,117},
          {4,65.2},{-37.6143,65.2}}, color={0,0,127}));
  connect(Ch13.y, Charge_Sum.u[9]) annotation (Line(points={{-7.7,107},{4,107},
          {4,65.2},{-37.5286,65.2}}, color={0,0,127}));
  connect(Ch28.y, Charge_Sum.u[15]) annotation (Line(points={{66.3,93},{74,93},
          {74,65.2},{-38.0429,65.2}}, color={0,0,127}));
  connect(Ch27.y, Charge_Sum.u[16]) annotation (Line(points={{66.3,103},{
          -38.1286,103},{-38.1286,65.2}}, color={0,0,127}));
  connect(Ch26.y, Charge_Sum.u[17]) annotation (Line(points={{66.3,113},{82,113},
          {82,65.2},{-38.2143,65.2}}, color={0,0,127}));
  connect(Ch25.y, Charge_Sum.u[18]) annotation (Line(points={{79,119.7},{79,
          65.2},{-38.3,65.2}}, color={0,0,127}));
  connect(Ch22.y, Charge_Sum.u[19]) annotation (Line(points={{89.7,93},{78,93},
          {78,65.2},{-38.3857,65.2}}, color={0,0,127}));
  connect(Ch23.y, Charge_Sum.u[20]) annotation (Line(points={{89.7,103},{76,103},
          {76,65.2},{-38.4714,65.2}}, color={0,0,127}));
  connect(Ch24.y, Charge_Sum.u[21]) annotation (Line(points={{89.7,113},{78,113},
          {78,65.2},{-38.5571,65.2}}, color={0,0,127}));
  connect(Ch15.y, Charge_Sum.u[22]) annotation (Line(points={{-104.3,97},{-114,
          97},{-114,65.2},{-38.6429,65.2}}, color={0,0,127}));
  connect(Ch16.y, Charge_Sum.u[23]) annotation (Line(points={{-104.3,107},{-118,
          107},{-118,65.2},{-38.7286,65.2}}, color={0,0,127}));
  connect(Ch17.y, Charge_Sum.u[24]) annotation (Line(points={{-104.3,117},{-118,
          117},{-118,62},{-38.8143,62},{-38.8143,65.2}}, color={0,0,127}));
  connect(Ch18.y, Charge_Sum.u[25]) annotation (Line(points={{-115,123.7},{-115,
          65.2},{-38.9,65.2}}, color={0,0,127}));
  connect(Ch19.y, Charge_Sum.u[26]) annotation (Line(points={{-127.7,117},{-116,
          117},{-116,65.2},{-38.9857,65.2}}, color={0,0,127}));
  connect(Ch20.y, Charge_Sum.u[27]) annotation (Line(points={{-127.7,107},{-114,
          107},{-114,65.2},{-39.0714,65.2}}, color={0,0,127}));
  connect(Ch21.y, Charge_Sum.u[28]) annotation (Line(points={{-127.7,97},{-114,
          97},{-114,65.2},{-39.1571,65.2}}, color={0,0,127}));
  connect(Net_Demand.u1, NomPower.y) annotation (Line(points={{-28,-14},{-28,40},
          {-26,40},{-26,43},{-63.5,43}}, color={0,0,127}));
annotation(defaultComponentName="SC", experiment(StopTime=3600,
        __Dymola_NumberOfIntervals=3600),
    Diagram(coordinateSystem(extent={{-160,-100},{160,180}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
                  Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Input Setpoints: Modelica Path")}));
end Demand_Curve_Generator;
