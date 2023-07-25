within NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems;
model CS_Default

  extends BaseClasses.Partial_ControlSystem;

  Data.Data_Default data
    annotation (Placement(transformation(extent={{-96,86},{-76,106}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=25,
    rising=500,
    width=2600,
    falling=500,
    period=10800,
    offset=0.0,
    startTime=7200)
    annotation (Placement(transformation(extent={{-54,-56},{-42,-44}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=25,
    rising=500,
    width=2600,
    falling=500,
    period=10800,
    offset=0.0,
    startTime=1800)
    annotation (Placement(transformation(extent={{-38,34},{-24,48}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
    annotation (Placement(transformation(extent={{-16,-62},{-4,-50}})));
  Modelica.Blocks.Sources.Constant cold_tank_level_max(k=data.cold_tank_level_max)
    annotation (Placement(transformation(extent={{-92,6},{-84,14}})));
  Modelica.Blocks.Sources.Constant hot_tank_max_level(k=data.hot_tank_level_max)
    annotation (Placement(transformation(extent={{-96,-34},{-88,-26}})));
  Modelica.Blocks.Sources.Constant zero(k=0)
    annotation (Placement(transformation(extent={{-54,-26},{-48,-20}})));
  Modelica.Blocks.Sources.Constant one(k=1)
    annotation (Placement(transformation(extent={{-80,-22},{-72,-14}})));
  Modelica.Blocks.Math.MultiProduct multiProduct1(nu=3)
    annotation (Placement(transformation(extent={{-14,2},{-2,14}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{-62,-34},{-54,-26}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-80,-36},{-72,-28}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{-36,-28},{-30,-22}})));
  Modelica.Blocks.Math.Max max2
    annotation (Placement(transformation(extent={{-56,24},{-48,32}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{-72,22},{-66,28}})));
  Modelica.Blocks.Sources.Constant zero1(k=0)
    annotation (Placement(transformation(extent={{-78,32},{-70,40}})));
  Modelica.Blocks.Sources.Constant one1(k=1)
    annotation (Placement(transformation(extent={{-92,24},{-86,30}})));
  Modelica.Blocks.Math.Max max3
    annotation (Placement(transformation(extent={{-30,4},{-24,10}})));
  Modelica.Blocks.Sources.Constant zero2(k=0)
    annotation (Placement(transformation(extent={{-48,6},{-42,12}})));
  Modelica.Blocks.Math.Min min3
    annotation (Placement(transformation(extent={{-56,-2},{-48,6}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{-74,-4},{-66,4}})));
  Modelica.Blocks.Sources.Constant one2(k=1)
    annotation (Placement(transformation(extent={{-74,10},{-66,18}})));
  Modelica.Blocks.Math.Min min4
    annotation (Placement(transformation(extent={{-64,-78},{-58,-72}})));
  Modelica.Blocks.Math.Max max4
    annotation (Placement(transformation(extent={{-48,-72},{-40,-64}})));
  Modelica.Blocks.Sources.Constant zero3(k=0)
    annotation (Placement(transformation(extent={{-70,-68},{-62,-60}})));
  Modelica.Blocks.Sources.Constant one3(k=1)
    annotation (Placement(transformation(extent={{-84,-76},{-78,-70}})));
equation

  connect(add.u1, hot_tank_max_level.y) annotation (Line(points={{-80.8,-29.6},
          {-80,-29.6},{-80,-30},{-87.6,-30}}, color={0,0,127}));
  connect(sensorBus.hot_tank_level, add.u2) annotation (Line(
      points={{-30,-100},{-86,-100},{-86,-34.4},{-80.8,-34.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(min1.u2, add.y)
    annotation (Line(points={{-62.8,-32.4},{-71.6,-32}}, color={0,0,127}));
  connect(one.y, min1.u1) annotation (Line(points={{-71.6,-18},{-62.8,-18},{
          -62.8,-27.6}}, color={0,0,127}));
  connect(max1.u2, min1.y) annotation (Line(points={{-36.6,-26.8},{-48,-26.8},{
          -48,-30},{-53.6,-30}}, color={0,0,127}));
  connect(zero.y, max1.u1) annotation (Line(points={{-47.7,-23},{-47.7,-23.2},{
          -36.6,-23.2}}, color={0,0,127}));
  connect(zero1.y, max2.u1) annotation (Line(points={{-69.6,36},{-56.8,36},{
          -56.8,30.4}}, color={0,0,127}));
  connect(one1.y, min2.u1) annotation (Line(points={{-85.7,27},{-85.7,26.8},{
          -72.6,26.8}}, color={0,0,127}));
  connect(sensorBus.hot_tank_level, min2.u2) annotation (Line(
      points={{-30,-100},{-86,-100},{-86,-38},{-102,-38},{-102,18},{-78,18},{
          -78,23.2},{-72.6,23.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(trapezoid.y, multiProduct.u[1]) annotation (Line(points={{-41.4,-50},
          {-22,-50},{-22,-53.2},{-16,-53.2}},
                                          color={0,0,127}));
  connect(max1.y, multiProduct.u[2]) annotation (Line(points={{-29.7,-25},{-22,
          -25},{-22,-56},{-16,-56}}, color={0,0,127}));
  connect(actuatorBus.m_flow_charge, multiProduct.y) annotation (Line(
      points={{30,-100},{28,-100},{28,-56},{-2.98,-56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(min2.y, max2.u2) annotation (Line(points={{-65.7,25},{-62,25},{-62,
          25.6},{-56.8,25.6}}, color={0,0,127}));
  connect(max3.u2, min3.y) annotation (Line(points={{-30.6,5.2},{-42,5.2},{-42,
          2},{-47.6,2}}, color={0,0,127}));
  connect(zero2.y, max3.u1) annotation (Line(points={{-41.7,9},{-41.7,8.8},{
          -30.6,8.8}}, color={0,0,127}));
  connect(min3.u2, add1.y)
    annotation (Line(points={{-56.8,-0.4},{-65.6,0}}, color={0,0,127}));
  connect(one2.y, min3.u1) annotation (Line(points={{-65.6,14},{-60,14},{-60,
          4.4},{-56.8,4.4}}, color={0,0,127}));
  connect(add1.u1, cold_tank_level_max.y) annotation (Line(points={{-74.8,2.4},
          {-80,2.4},{-80,10},{-83.6,10}}, color={0,0,127}));
  connect(sensorBus.cold_tank_level, add1.u2) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-8},{-74.8,-8},{-74.8,-2.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(trapezoid1.y, multiProduct1.u[1]) annotation (Line(points={{-23.3,41},
          {-16,41},{-16,10.8},{-14,10.8}}, color={0,0,127}));
  connect(min4.y, max4.u2) annotation (Line(points={{-57.7,-75},{-50,-75},{-50,
          -70.4},{-48.8,-70.4}}, color={0,0,127}));
  connect(zero3.y, max4.u1) annotation (Line(points={{-61.6,-64},{-48.8,-64},{
          -48.8,-65.6}}, color={0,0,127}));
  connect(one3.y, min4.u1) annotation (Line(points={{-77.7,-73},{-77.7,-73.2},{
          -64.6,-73.2}}, color={0,0,127}));
  connect(max3.y, multiProduct1.u[2])
    annotation (Line(points={{-23.7,7},{-14,8}}, color={0,0,127}));
  connect(sensorBus.cold_tank_level, min4.u2) annotation (Line(
      points={{-30,-100},{-66,-100},{-66,-76.8},{-64.6,-76.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.m_flow_discharge, multiProduct1.y) annotation (Line(
      points={{30,-100},{28,-100},{28,8},{-0.98,8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(max2.y, multiProduct1.u[3]) annotation (Line(points={{-47.6,28},{-40,
          28},{-40,26},{-34,26},{-34,5.2},{-14,5.2}}, color={0,0,127}));
  connect(max4.y, multiProduct.u[3]) annotation (Line(points={{-39.6,-68},{-22,
          -68},{-22,-58.8},{-16,-58.8}},
                                     color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_Default;
