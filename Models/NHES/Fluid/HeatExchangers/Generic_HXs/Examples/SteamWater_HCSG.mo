within NHES.Fluid.HeatExchangers.Generic_HXs.Examples;
model SteamWater_HCSG
  "Evaporation of a subcooled inlet water stream to superheated steam (helical coil tube side) and subcooled water (shell side)"
  extends Modelica.Icons.Example;

  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.Boundary_ph tube_outlet(
    p(displayUnit="MPa") = 5800000,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    h=2.95363e6,
    nPorts=1)
    annotation (Placement(transformation(extent={{45,35},{35,45}})));
  Modelica.Fluid.Sources.MassFlowSource_h tube_inlet(
    m_flow=502.8,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    h=962463,
    nPorts=1) annotation (Placement(transformation(extent={{45,-46},{33,-34}})));
  Modelica.Fluid.Sources.Boundary_pT shell_outlet(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p(displayUnit="MPa") = 15712238,
    T=556.15)
    annotation (Placement(transformation(extent={{-45,-45},{-35,-35}})));
  Modelica.Fluid.Sources.MassFlowSource_T shell_inlet(
    m_flow=4712,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    T=594.15) annotation (Placement(transformation(extent={{-45,34},{-33,46}})));
  Generic_STHX STHX(
    nParallel=8,
    redeclare package Medium_shell =
        Modelica.Media.Water.StandardWater,
    redeclare package Medium_tube =
        Modelica.Media.Water.StandardWater,
    length_shell=7.9,
    D_o_shell=1.64,
    D_i_shell=0.61,
    length_tube=32,
    diameter_tube=0.01324,
    th_tube=0.00211,
    nV_shell=20,
    p_a_start_shell=shell_outlet.p + 1000,
    p_b_start_shell=shell_outlet.p,
    T_a_start_shell=shell_inlet.T,
    T_b_start_shell=shell_outlet.T,
    m_flow_start_shell=shell_inlet.m_flow,
    p_a_start_tube=tube_outlet.p + 1000,
    p_b_start_tube=tube_outlet.p,
    use_Ts_start_tube=false,
    h_a_start_tube=tube_inlet.h,
    h_b_start_tube=tube_outlet.h,
    m_flow_start_tube=tube_inlet.m_flow,
    redeclare model HeatTransfer_tube =
        Pipes.BaseClasses.HeatTransfer.Overall_Evaporation,
    hs_start_tube={1092619.183,1169910.614,1229588.908,1295560.906,1368587.743,
        1449483.535,1539113.913,1638416.293,1748414.32,1870228.947,2005086.711,
        2154323.65,2319377.564,2501734.143,2650870.103,2794340.368,2874110.975,
        2916877.195,2939456.778,2951404.247},
    redeclare package Tube_Material = Media.Solids.Inconel690,
    redeclare model HeatTransfer_shell =
        Pipes.BaseClasses.HeatTransfer.Grimson_FlowAcrossTubeBundels (
        D=STHX.diameter_tube + 2*STHX.th_tube,
        S_T=1.25*(STHX.diameter_tube + 2*STHX.th_tube),
        S_L=1.25*(STHX.diameter_tube + 2*STHX.th_tube)),
    nTubes=750,
    dheight_shell=STHX.length_shell)
    annotation (Placement(transformation(extent={{21,-20},{-21,20}})));
equation
  connect(shell_inlet.ports[1], STHX.port_a_shell) annotation (Line(points={{
          -33,40},{-9.66,40},{-9.66,20}}, color={0,127,255}));
  connect(shell_outlet.ports[1], STHX.port_b_shell) annotation (Line(points={{
          -35,-40},{-22,-40},{-9.66,-40},{-9.66,-20}}, color={0,127,255}));
  connect(tube_inlet.ports[1], STHX.port_a_tube)
    annotation (Line(points={{33,-40},{0,-40},{0,-20}}, color={0,127,255}));
  connect(tube_outlet.ports[1], STHX.port_b_tube)
    annotation (Line(points={{35,40},{0,40},{0,20}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>Helical Coil Steam Generator</p>
</html>"));
end SteamWater_HCSG;
