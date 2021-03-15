within NHES.Systems.EnergyStorage.SensibleHeatStorage.Examples;
model Twentypercentofnominal3400MWtPWR2 "Compared to Thesis"
  extends Modelica.Icons.Example;
  TwentyPercentNominal3400MWtPWR2
                  ES(redeclare CS_20PercentNominal CS)
    annotation (Placement(transformation(extent={{-44,-38},{36,42}})));

  Modelica.Blocks.Sources.Constant hsg(k=1192.6*2326)
    annotation (Placement(transformation(extent={{-142,-6},{-122,14}})));
  Modelica.Blocks.Sources.Constant P_HDR(k=1000*6894.76)
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
    annotation (Placement(transformation(extent={{-102,-24},{-82,-4}})));
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
    annotation (Line(points={{-44,-14},{-82,-14}}, color={0,127,255}));
  connect(boundary1.portElec_b, ES.portElec_b)
    annotation (Line(points={{62,2},{36,2}}, color={255,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=93600,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p>Sensible Heat System designed to be able to handle 20&percnt; of nominal steam flow from a full 3400MWt Westinghouse 4-loop plant. </p>
</html>"));
end Twentypercentofnominal3400MWtPWR2;
