within NHES.Systems.EnergyStorage.SensibleHeatStorage.Examples;
model TypicalSummerDayTest "Compared to Thesis"
  extends Modelica.Icons.Example;

  Typical_Summer_Day
                  ES
    annotation (Placement(transformation(extent={{-44,-38},{36,42}})));

  Modelica.Blocks.Sources.Constant hsg(k=1244*2326)
    annotation (Placement(transformation(extent={{-142,-6},{-122,14}})));
  Modelica.Blocks.Sources.Constant P_HDR(k=825*6894.76)
    annotation (Placement(transformation(extent={{-142,26},{-122,46}})));
  Modelica.Fluid.Sources.Boundary_ph boundary_port_a(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    use_h_in=true)
    annotation (Placement(transformation(extent={{-102,8},{-82,28}})));
  Modelica.Fluid.Sources.Boundary_ph boundary_port_b(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_h_in=false,
    use_p_in=false,
    p(displayUnit="Pa") = 4826.33)
    annotation (Placement(transformation(extent={{-110,-24},{-90,-4}})));
  Electrical.Sources.FrequencySource boundary1
    annotation (Placement(transformation(extent={{82,-8},{62,12}})));
equation
  connect(P_HDR.y,boundary_port_a. p_in) annotation (Line(points={{-121,36},{
          -112,36},{-112,26},{-104,26}},   color={0,0,127}));
  connect(hsg.y,boundary_port_a. h_in) annotation (Line(points={{-121,4},{-114,
          4},{-114,22},{-104,22}},          color={0,0,127}));
  connect(boundary_port_a.ports[1], ES.port_a) annotation (Line(points={{-82,18},
          {-76,18},{-76,20},{-44,20},{-44,18}}, color={0,127,255}));
  connect(ES.port_b, boundary_port_b.ports[1])
    annotation (Line(points={{-44,-14},{-90,-14}}, color={0,127,255}));
  connect(boundary1.portElec_b, ES.portElec_b)
    annotation (Line(points={{62,2},{36,2}}, color={255,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p><span style=\"font-size: 8pt;\">This test is simply a 100 second run for the system. </span></p>
</html>"));
end TypicalSummerDayTest;
