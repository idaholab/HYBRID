within NHES.Systems.Experiments.TEDS.Examples;
model TEDS_Test "Ensuring the system operates properly and with the right time constants."
  extends Modelica.Icons.Example;

  ThermoclineModels.Thermocline_fluidprops thermocline_fluidprops(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(extent={{-20,-18},{24,26}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_m_flow_in=true,
    T=668.15,
    nPorts=1) annotation (Placement(transformation(extent={{-42,28},{-22,48}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p(displayUnit="Pa") = 1e5,
    T=583.15,
    nPorts=1) annotation (Placement(transformation(extent={{58,-50},{38,-30}})));
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation (__Dymola_choicesAllMatching=true);
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=-128.74*2,
    width=50,
    period(displayUnit="h") = 28800,
    offset=128.74)
    annotation (Placement(transformation(extent={{-96,36},{-76,56}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,-100; 3600,-100; 7200,
        50; 10800,100; 14400,0; 18000,0])
    annotation (Placement(transformation(extent={{-96,66},{-76,86}})));
equation
  connect(boundary.ports[1], thermocline_fluidprops.port_a)
    annotation (Line(points={{-22,38},{2,38},{2,26}}, color={0,127,255}));
  connect(boundary1.ports[1], thermocline_fluidprops.port_b)
    annotation (Line(points={{38,-40},{2,-40},{2,-18}}, color={0,127,255}));
  connect(pulse.y, boundary.m_flow_in)
    annotation (Line(points={{-75,46},{-42,46}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=18000,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end TEDS_Test;
