within NHES.Electrolysis.Machines.Examples;
model PumpControlledPressure_test
  extends Modelica.Icons.Example;

  replaceable package Medium = Modelica.Media.Water.StandardWater annotation (
      __Dymola_choicesAllMatching=true);
  Machines.PumpControlledPressure pumpControlledPressure(redeclare package
      Medium = Modelica.Media.Water.StandardWater, V=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.Boundary_pT recycledWaterFeed(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=4317930,
    T=488.293) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,0})));
  Modelica.Fluid.Sources.Boundary_pT recyledWaterSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=6270000,
    T=488.293) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,0})));
  Modelica.Fluid.Sensors.Temperature TH2O_in(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Modelica.Fluid.Sensors.Temperature TH2O_out(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
equation
  connect(recycledWaterFeed.ports[1], pumpControlledPressure.port_a)
    annotation (Line(points={{-60,0},{-10,0}}, color={0,127,255}));
  connect(TH2O_in.port, pumpControlledPressure.port_a) annotation (Line(
        points={{-20,10},{-20,0},{-10,0}}, color={0,127,255}));
  connect(TH2O_out.port, pumpControlledPressure.port_b) annotation (Line(
        points={{20,10},{20,10},{20,0},{10,0}}, color={0,127,255}));
  connect(recyledWaterSink.ports[1], pumpControlledPressure.port_b)
    annotation (Line(points={{60,0},{35,0},{10,0}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end PumpControlledPressure_test;
