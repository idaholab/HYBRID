within NHES.Nuclear.CoreSubchannels.Examples;
model FuelGapClad_Test
  extends Modelica.Icons.Example;

  FuelGapClad coreSubchannel(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare package fuelType = Media.Solids.UO2,
    redeclare package gapType = Media.Solids.Helium,
    redeclare package cladType = Media.Solids.ZrNb_E125,
    nParallel=23496,
    nFuelPins=23496,
    length=4.27,
    crossArea=2.726627/23496,
    perimeter=767.6466/23496,
    r_outer_fuel=0.5*0.0081915,
    r_outer_gap=0.5*0.0083566,
    r_outer_clad=0.5*0.0095,
    T_start_gap=[{coreSubchannel.T_start_fuel[end, 1]},{coreSubchannel.T_start_fuel[
        end, 2]},{coreSubchannel.T_start_fuel[end, 3]},{coreSubchannel.T_start_fuel[
        end, 4]}; 553.68194580078,564.57482910156,574.96258544922,
        584.95745849609; 548.8427734375,559.76531982422,570.18103027344,
        580.20251464844],
    T_start_clad=[{coreSubchannel.T_start_gap[end, 1]},{coreSubchannel.T_start_gap[
        end, 2]},{coreSubchannel.T_start_gap[end, 3]},{coreSubchannel.T_start_gap[
        end, 4]}; 611.67974853516,622.14379882812,632.13140869141,
        641.74914550781; 558.82666015625,569.68823242187,580.04644775391,
        590.01318359375],
    T_start_fuel(displayUnit="K") = [817.624633789063,829.4697265625,
      840.789428710938,851.702392578125; 776.643981933594,788.022216796875,
      798.894226074219,809.374206542969; 663.184448242188,673.302185058594,
      682.965942382813,692.277893066406],
    p_a_start=P_boundary.p + 100,
    p_b_start=P_boundary.p,
    T_a_start=m_boundary.T,
    T_b_start=P_boundary.T,
    m_flow_start=m_boundary.m_flow,
    redeclare model HeatTransfer =
        Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    Teffref_fuel=745.394,
    Teffref_coolant=547.25,
    Tref_fuel=743.15,
    Tref_gap=623.15,
    Tref_clad=573.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.Boundary_pT P_boundary(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T(displayUnit="K") = 600,
    p(displayUnit="Pa") = 15649100)
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T m_boundary(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=8*589,
    T(displayUnit="K") = 520)
    annotation (Placement(transformation(extent={{-108,-10},{-88,10}})));
  inner Fluid.System_TP system(
    m_flow_start=m_boundary.m_flow,
    p_start=P_boundary.p,
    T_start=0.5*(m_boundary.T + P_boundary.T),
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.Step     ControlRod_Reactivity(
      startTime=100, height=0.001)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Sources.Step     Other_Reactivity(                startTime=
        250, height=-0.001)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.Constant S_external(k=0)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
equation
  connect(coreSubchannel.port_b, P_boundary.ports[1])
    annotation (Line(points={{10,0},{50,0},{90,0}}, color={0,127,255}));
  connect(coreSubchannel.port_a, m_boundary.ports[1])
    annotation (Line(points={{-10,0},{-49,0},{-88,0}}, color={0,127,255}));
  connect(ControlRod_Reactivity.y, coreSubchannel.Reactivity_CR_input)
    annotation (Line(points={{-39,80},{-18,80},{0,80},{0,5.2}}, color={0,0,127}));
  connect(Other_Reactivity.y, coreSubchannel.Reactivity_Other_input)
    annotation (Line(points={{-39,50},{-4,50},{-4,5.2}}, color={0,0,127}));
  connect(S_external.y, coreSubchannel.S_external_input)
    annotation (Line(points={{-39,20},{-8,20},{-8,5.2}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000),
    __Dymola_experimentSetupOutput);
end FuelGapClad_Test;
