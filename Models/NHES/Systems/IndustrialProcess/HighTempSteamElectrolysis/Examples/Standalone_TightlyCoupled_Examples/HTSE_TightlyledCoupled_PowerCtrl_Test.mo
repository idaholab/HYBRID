within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Examples.Standalone_TightlyCoupled_Examples;
model HTSE_TightlyledCoupled_PowerCtrl_Test
  import NHES.Electrolysis;
  extends Modelica.Icons.Example;

  TightlyCoupled_PowerCtrl_Standalone IP(
    redeclare CS_TightlyCoupled_PowerCtrl CS,
    capacityScaler=1.5,
    port_a_nominal(m_flow=IP.capacityScaler*9.0942),
    port_b_nominal(p=4317930))
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
  Modelica.Fluid.Sources.Boundary_pT sink(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T(displayUnit="degC") = 488.293,
    p(displayUnit="bar") = 4317930)
    annotation (Placement(transformation(extent={{-66,-2},{-46,-22}})));
  Modelica.Fluid.Sources.MassFlowSource_T source(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    m_flow=9.0942,
    T(displayUnit="degC") = 591,
    use_m_flow_in=true)
    annotation (Placement(transformation(extent={{-66,2},{-46,22}})));
  Modelica.Blocks.Sources.Ramp m_flow_in_stepInput(
    startTime=1000,
    duration=0,
    height=IP.capacityScaler*(6.84844 - 9.0942),
    offset=IP.capacityScaler*9.0942)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Electrical.Grid             grid(
                     n=1,
    f_nominal=60,
    Q_nominal=1e11,
    droop=0.5)
             annotation (Placement(transformation(extent={{48,-10},{68,10}})));
equation
  connect(sink.ports[1], IP.port_b)
    annotation (Line(points={{-46,-12},{-30,-12}}, color={0,127,255}));
  connect(IP.port_a, source.ports[1])
    annotation (Line(points={{-30,12},{-46,12}}, color={0,127,255}));
  connect(source.m_flow_in, m_flow_in_stepInput.y)
    annotation (Line(points={{-66,20},{-79,20}}, color={0,0,127}));
  connect(grid.ports[1], IP.portElec_a)
    annotation (Line(points={{48,0},{30,0}}, color={255,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=8100, Interval=1),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end HTSE_TightlyledCoupled_PowerCtrl_Test;
