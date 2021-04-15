within NHES.Systems.EnergyStorage.ThermoclineHeatStorage.Examples;
model Thermocline_Insulation_Test
  "Ensuring the system operates properly and with the right time constants."
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_m_flow_in=true,
    T=598.15,
    nPorts=1) annotation (Placement(transformation(extent={{-42,28},{-22,48}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p(displayUnit="Pa") = 1e5,
    T=498.15,
    nPorts=1) annotation (Placement(transformation(extent={{58,-50},{38,-30}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=-190.74*0,
    width=50,
    period(displayUnit="h") = 28800,
    offset=190.74*0)
    annotation (Placement(transformation(extent={{-80,36},{-60,56}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,-100; 3600,-100; 7200,
        50; 10800,100; 14400,0; 18000,0])
    annotation (Placement(transformation(extent={{-96,70},{-76,90}})));
  NHES.Systems.EnergyStorage.ThermoclineHeatStorage.ThermoclineModels.Thermocline_Insulation
    testerofwall_extender(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    redeclare package InsulationMaterial =
        TRANSFORM.Media.Solids.FiberGlassGeneric,
    redeclare package WallMaterial = TRANSFORM.Media.Solids.SS316,
    geometry(
      Radius_Tank=7.6,
      Porosity=0.6,
      dr=0.00317,
      Insulation_thickness=0.051*4,
      Wall_Thickness=0.051,
      Height_Tank=14.6,
      T_amb=293.15))
    annotation (Placement(transformation(extent={{-20,-28},{24,24}})));

equation
  connect(pulse.y, boundary.m_flow_in)
    annotation (Line(points={{-59,46},{-42,46}}, color={0,0,127}));
  connect(boundary.ports[1], testerofwall_extender.port_a)
    annotation (Line(points={{-22,38},{2,38},{2,24}}, color={0,127,255}));
  connect(testerofwall_extender.port_b, boundary1.ports[1])
    annotation (Line(points={{2,-28},{2,-40},{38,-40}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=18000,
      Interval=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p>Assuming a Large tank. As the surface area to volume ratio increases the more temperature loss there will be. </p>
<p>Height = 14.6m</p>
<p>Radius = 0.436m </p>
<p>Insulation = 0.204m; ~8in</p>
<p>Wall thickness = 0.051 m</p>
</html>"));
end Thermocline_Insulation_Test;
