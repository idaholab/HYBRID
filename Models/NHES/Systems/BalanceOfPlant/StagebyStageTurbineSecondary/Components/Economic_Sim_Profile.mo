within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Components;
model Economic_Sim_Profile
  extends BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  parameter Modelica.Units.SI.Time Ramp_Stor=600 "Time allowed for demand ramp";
  parameter Modelica.Units.SI.Time Ramp_Dis=600 "Time allowed for demand ramp";
  parameter Modelica.Units.SI.Power Q_nom=52000000;

  Modelica.Blocks.Math.Sum Charge_Sum(nin=7) annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-58,44})));
  Modelica.Blocks.Sources.Trapezoid Dch1(
    amplitude=12e6,
    rising=Ramp_Dis,
    width=8*3600 - Ramp_Dis,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=46800 - Ramp_Dis/2) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-35,47})));
  Modelica.Blocks.Sources.Trapezoid Ch1(
    amplitude=-0.45*Q_nom,
    rising=Ramp_Stor,
    width=3600*8 - Ramp_Stor,
    falling=Ramp_Stor,
    period=864000,
    offset=0,
    startTime=3600 - Ramp_Stor/2) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-77,81})));
  Modelica.Blocks.Math.Sum Anticipatory_Signals(nin=7) annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={16,0})));
  Modelica.Blocks.Sources.Constant NomPower(k=Q_nom)
    annotation (Placement(transformation(extent={{-94,2},{-84,12}})));
  Modelica.Blocks.Math.Sum Discharge_Sum(nin=7) annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-20,32})));
  Modelica.Blocks.Math.Add3 Net_Demand
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-44,-28})));
  Modelica.Blocks.Sources.Trapezoid Ch2(
    amplitude=-0.45*Q_nom,
    rising=Ramp_Stor,
    width=3600*3 - Ramp_Stor,
    falling=Ramp_Stor,
    period=864000,
    offset=0,
    startTime=90000 - Ramp_Stor/2) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-77,71})));
  Modelica.Blocks.Sources.Trapezoid Ch3(
    amplitude=-0.45*Q_nom,
    rising=Ramp_Stor,
    width=3600*1 - Ramp_Stor,
    falling=Ramp_Stor,
    period=864000,
    offset=0,
    startTime=255600 - Ramp_Stor/2) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-77,61})));
  Modelica.Blocks.Sources.Trapezoid Ch4(
    amplitude=-0.45*Q_nom,
    rising=Ramp_Stor,
    width=3600 - Ramp_Stor,
    falling=Ramp_Stor,
    period=864000,
    offset=0,
    startTime=270000 - Ramp_Stor/2) annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=90,
        origin={-61,91})));
  Modelica.Blocks.Sources.Trapezoid Ch5(
    amplitude=-0.45*Q_nom,
    rising=Ramp_Stor,
    width=6*3600 - Ramp_Stor,
    falling=Ramp_Stor,
    period=864000,
    offset=0,
    startTime=342000 - Ramp_Stor/2) annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-47,81})));
  Modelica.Blocks.Sources.Trapezoid Ch6(
    amplitude=-0.45*Q_nom,
    rising=Ramp_Stor,
    width=2*3600 - Ramp_Stor,
    falling=Ramp_Stor,
    period=864000,
    offset=0,
    startTime=439200 - Ramp_Stor/2) annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-47,71})));
  Modelica.Blocks.Sources.Trapezoid Ch7(
    amplitude=-0.45*Q_nom,
    rising=Ramp_Stor,
    width=3*3600 - Ramp_Stor,
    falling=Ramp_Stor,
    period=864000,
    offset=0,
    startTime=612000 - Ramp_Stor/2) annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-47,61})));
  Modelica.Blocks.Sources.Trapezoid DCh2(
    amplitude=12e6,
    rising=Ramp_Dis,
    width=5*3600 - Ramp_Dis,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=129600 - Ramp_Dis/2) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-35,57})));
  Modelica.Blocks.Sources.Trapezoid DCh3(
    amplitude=12e6,
    rising=Ramp_Dis,
    width=2*3600 - Ramp_Dis,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=226800 - Ramp_Dis/2) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-35,67})));
  Modelica.Blocks.Sources.Trapezoid DCh4(
    amplitude=12e6,
    rising=Ramp_Dis,
    width=2*3600 - Ramp_Dis,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=313200 - Ramp_Dis/2) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={-31,75})));
  Modelica.Blocks.Sources.Trapezoid DCh5(
    amplitude=12e6,
    rising=Ramp_Dis,
    width=6*3600 - Ramp_Dis,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=396000 - Ramp_Dis/2) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={-21,75})));
  Modelica.Blocks.Sources.Trapezoid DCh6(
    amplitude=12e6,
    rising=Ramp_Dis,
    width=1*3600 - Ramp_Dis,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=489600 - Ramp_Dis/2) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={-11,75})));
  Modelica.Blocks.Sources.Trapezoid DCh7(
    amplitude=12e6,
    rising=Ramp_Dis,
    width=2*3600 - Ramp_Dis,
    falling=Ramp_Dis,
    period=864000,
    offset=0,
    startTime=655200 - Ramp_Dis/2) annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-5,67})));
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
        origin={35,31})));
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
        origin={27,37})));
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
        origin={17,37})));
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
        origin={7,37})));
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
        origin={1,31})));
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
        origin={1,21})));
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
        origin={1,11})));
equation
  connect(NomPower.y,Net_Demand. u3) annotation (Line(points={{-83.5,7},{-74,7},
          {-74,8},{-64,8},{-64,-16},{-52,-16}},
                                   color={0,0,127}));
  connect(Charge_Sum.y,Net_Demand. u2) annotation (Line(points={{-58,37.4},{-58,
          -10},{-44,-10},{-44,-16}},              color={0,0,127}));
  connect(Discharge_Sum.y,Net_Demand. u1) annotation (Line(points={{-20,25.4},{-20,
          12},{-22,12},{-22,-12},{-30,-12},{-30,-16},{-36,-16}},
                                            color={0,0,127}));
  connect(Ch1.y,Charge_Sum. u[1]) annotation (Line(points={{-73.7,81},{-62,81},
          {-62,51.2},{-56.9714,51.2}},color={0,0,127}));
  connect(Dch1.y,Discharge_Sum. u[1]) annotation (Line(points={{-31.7,47},{
          -18.9714,47},{-18.9714,39.2}},
                                 color={0,0,127}));
  connect(Ant1.y,Anticipatory_Signals. u[1]) annotation (Line(points={{4.3,11},
          {17.0286,11},{17.0286,7.2}},  color={0,0,127}));
  connect(Ch2.y,Charge_Sum. u[2]) annotation (Line(points={{-73.7,71},{-57.3143,
          71},{-57.3143,51.2}},
                            color={0,0,127}));
  connect(Ant2.y,Anticipatory_Signals. u[2]) annotation (Line(points={{4.3,21},
          {16.6857,21},{16.6857,7.2}},   color={0,0,127}));
  connect(DCh2.y,Discharge_Sum. u[2]) annotation (Line(points={{-31.7,57},{
          -19.3143,57},{-19.3143,39.2}},
                                 color={0,0,127}));
  connect(Ant3.y,Anticipatory_Signals. u[3]) annotation (Line(points={{4.3,31},
          {16.3429,31},{16.3429,7.2}},   color={0,0,127}));
  connect(DCh3.y,Discharge_Sum. u[3]) annotation (Line(points={{-31.7,67},{
          -19.6571,67},{-19.6571,39.2}},
                                 color={0,0,127}));
  connect(Ch4.y,Charge_Sum. u[4]) annotation (Line(points={{-61,87.7},{-61,76},{
          -58,76},{-58,51.2}}, color={0,0,127}));
  connect(DCh4.y,Discharge_Sum. u[4]) annotation (Line(points={{-31,71.7},{-31,55.85},
          {-20,55.85},{-20,39.2}},                   color={0,0,127}));
  connect(Ant4.y,Anticipatory_Signals. u[4]) annotation (Line(points={{7,33.7},{
          7,26},{16,26},{16,7.2}},         color={0,0,127}));
  connect(Ch5.y,Charge_Sum. u[5]) annotation (Line(points={{-50.3,81},{-58.3429,
          81},{-58.3429,51.2}},
                            color={0,0,127}));
  connect(DCh5.y,Discharge_Sum. u[5]) annotation (Line(points={{-21,71.7},{-21,
          55.85},{-20.3429,55.85},{-20.3429,39.2}},  color={0,0,127}));
  connect(Ant5.y,Anticipatory_Signals. u[5]) annotation (Line(points={{17,33.7},
          {17,19.85},{15.6571,19.85},{15.6571,7.2}},     color={0,0,127}));
  connect(Ch6.y,Charge_Sum. u[6]) annotation (Line(points={{-50.3,71},{-58.6857,
          71},{-58.6857,51.2}},
                            color={0,0,127}));
  connect(DCh6.y,Discharge_Sum. u[6]) annotation (Line(points={{-11,71.7},{-11,
          68},{-20.6857,68},{-20.6857,39.2}},  color={0,0,127}));
  connect(Ant6.y,Anticipatory_Signals. u[6]) annotation (Line(points={{27,33.7},
          {27,28},{15.3143,28},{15.3143,7.2}},     color={0,0,127}));
  connect(Ch7.y,Charge_Sum. u[7]) annotation (Line(points={{-50.3,61},{-59.0286,
          61},{-59.0286,51.2}},
                            color={0,0,127}));
  connect(Ant7.y,Anticipatory_Signals. u[7]) annotation (Line(points={{31.7,31},
          {14.9714,31},{14.9714,7.2}},   color={0,0,127}));
  connect(DCh7.y,Discharge_Sum. u[7]) annotation (Line(points={{-8.3,67},{
          -21.0286,67},{-21.0286,39.2}},
                                 color={0,0,127}));
  connect(Ch3.y,Charge_Sum. u[3]) annotation (Line(points={{-73.7,61},{-57.6571,
          61},{-57.6571,51.2}},
                            color={0,0,127}));
  connect(actuatorBus.Demand, Net_Demand.y) annotation (Line(
      points={{30,-100},{28,-100},{28,-54},{-48,-54},{-48,-39},{-44,-39}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
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
end Economic_Sim_Profile;
