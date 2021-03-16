within NHES.Fluid.HeatExchangers.Generic_HXs.Examples;
model OilWater_CTHX
  "Example of an oil and water concentric tube heat exchanger"

  extends Modelica.Icons.Example;

  //parameter SIadd

   parameter SI.TemperatureDifference DT_lm = 43.2 "Log mean temperature difference";
   parameter SI.CoefficientOfHeatTransfer U_shell = 38.1 "Overall heat transfer coefficient - shell side";

  Modelica.Fluid.Sources.MassFlowSource_T tube_inlet(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=0.2,
    T(displayUnit="degC") = 303.15)
              annotation (Placement(transformation(extent={{45,-46},{33,-34}})));
  Modelica.Fluid.Sources.Boundary_pT tube_outlet(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="bar") = 100000,
    T(displayUnit="degC") = 313.15)
              annotation (Placement(transformation(extent={{45,35},{35,45}})));
  Modelica.Fluid.Sources.MassFlowSource_T shell_inlet(
    nPorts=1,
    m_flow=0.1,
    T(displayUnit="degC") = 373.15,
    redeclare package Medium = Media.Incompressible.EngineOilUnused)
    annotation (Placement(transformation(extent={{-45,34},{-33,46}})));
  Modelica.Fluid.Sources.Boundary_pT shell_outlet(
    nPorts=1,
    p(displayUnit="bar") = 100000,
    T(displayUnit="degC") = 333.15,
    redeclare package Medium = Media.Incompressible.EngineOilUnused)
    annotation (Placement(transformation(extent={{-45,-45},{-35,-35}})));
  Generic_STHX STHX(
    modelStructure_tube=Modelica.Fluid.Types.ModelStructure.av_b,
    modelStructure_shell=Modelica.Fluid.Types.ModelStructure.av_b,
    allowFlowReversal=system.allowFlowReversal,
    energyDynamics=system.energyDynamics,
    massDynamics=system.massDynamics,
    momentumDynamics=system.momentumDynamics,
    p_a_start_shell(displayUnit="Pa") = shell_outlet.p + 100,
    p_b_start_shell(displayUnit="Pa") = shell_outlet.p,
    T_a_start_shell=shell_inlet.T,
    T_b_start_shell=shell_outlet.T,
    p_a_start_tube(displayUnit="Pa") = tube_outlet.p + 100,
    p_b_start_tube(displayUnit="Pa") = tube_outlet.p,
    T_a_start_tube=tube_inlet.T,
    T_b_start_tube=tube_outlet.T,
    m_flow_start_shell=shell_inlet.m_flow,
    m_flow_start_tube=tube_inlet.m_flow,
    redeclare package Medium_tube =
        Modelica.Media.Water.StandardWater,
    length_shell=65.9,
    diameter_tube=0.025,
    th_tube=0.0001,
    nV_shell=10,
    isCircular_shell=true,
    D_o_shell=0.045,
    redeclare package Medium_shell =
        Media.Incompressible.EngineOilUnused,
    redeclare package Tube_Material = NHES.Media.Solids.SS316,
    redeclare model HeatTransfer_shell =
        Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    redeclare model HeatTransfer_tube =
        Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer)
    annotation (Placement(transformation(extent={{21,-20},{-21,20}})));
  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

equation
  connect(shell_inlet.ports[1], STHX.port_a_shell) annotation (Line(points={{-33,40},
          {-9.66,40},{-9.66,20}},     color={0,127,255}));
  connect(shell_outlet.ports[1], STHX.port_b_shell) annotation (Line(points={{-35,
          -40},{-9.66,-40},{-9.66,-20}}, color={0,127,255}));
  connect(tube_inlet.ports[1], STHX.port_a_tube) annotation (Line(points={{33,-40},
          {33,-40},{0,-40},{0,-20}}, color={0,127,255}));
  connect(tube_outlet.ports[1], STHX.port_b_tube)
    annotation (Line(points={{35,40},{0,40},{0,20}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>Example 11.1 (pp. 680-682).</p>
<p>A counterflow, concentric tube heat exchanger with oil and water taken from Example 11.1 (pp. 680-682) of Fundamentals of Heat and Mass Transfer by Incropera and DeWitt.</p>
</html>"));
end OilWater_CTHX;
