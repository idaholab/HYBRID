within NHES.Electrolysis.Electrolyzers.Examples;
model SOECstack_closedLoopControl
  "Closed-loop control for SOEC stack operation"
  import NHES.Electrolysis;
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp power_set(
    startTime=100,
    offset=9.10627*1e6*5,
    duration=0,
    height=-1.929*1e6*5*3)
    annotation (Placement(transformation(extent={{-68,40},{-48,60}})));

  Electrolysis.Electrolyzers.ControlledSOEC controlledSOEC(
    numVessels=5,
    numCells_perVessel=68320,
    FBctrl_SUfactor(x(start=4.540425/controlledSOEC.FBctrl_SUfactor.k)))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*
        1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=1123.15)
    annotation (Placement(transformation(extent={{-48,-6},{-28,14}})));

  Modelica.Fluid.Sources.MassFlowSource_T anodeFeed(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    m_flow=4.65587*5,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    nPorts=1,
    T=1123.15)
    annotation (Placement(transformation(extent={{-48,-34},{-28,-14}})));

  Modelica.Fluid.Sources.Boundary_pT cathodeSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1964000,
    T=1023.15)
    annotation (Placement(transformation(extent={{38,-4},{20,14}})));

  Modelica.Fluid.Sources.Boundary_pT anodeSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=1964000,
    T=1073.15)
    annotation (Placement(transformation(extent={{38,-36},{20,-18}})));
  Electrolysis.Sources.PrescribedPowerFlow prescribedPowerFlow
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
equation
  connect(cathodeFeed.ports[1], controlledSOEC.ctrlCathodeIn) annotation (
     Line(points={{-28,4},{-7.4,4},{-7.4,3}}, color={0,127,255}));
  connect(anodeFeed.ports[1], controlledSOEC.ctrlAnodeIn) annotation (
      Line(points={{-28,-24},{-20,-24},{-20,-5.4},{-7.4,-5.4}}, color={0,
          127,255}));
  connect(controlledSOEC.ctrlCathodeOut,cathodeSink. ports[1])
    annotation (Line(points={{7.4,5},{20,5}},               color={0,127,
          255}));
  connect(controlledSOEC.ctrlAnodeOut,anodeSink. ports[1]) annotation (
      Line(points={{7.4,-3.4},{14,-3.4},{14,-27},{20,-27}}, color={0,127,
          255}));
  connect(controlledSOEC.c_wCathode, cathodeFeed.m_flow_in) annotation (
      Line(points={{0,6},{0,24},{-60,24},{-60,12},{-48,12}}, color={0,0,
          127}));
  connect(controlledSOEC.c_wAnodeIn, anodeFeed.m_flow_in) annotation (
      Line(points={{-0.8,-7.4},{-0.8,-7.4},{-0.8,-36},{-60,-36},{-60,-16},
          {-48,-16}}, color={0,0,127}));
  connect(prescribedPowerFlow.port_b, controlledSOEC.ctrlElectricalLoad)
    annotation (Line(points={{-20,50},{-14,50},{-14,-1},{-7.6,-1}}, color=
         {255,0,0}));
  connect(power_set.y, prescribedPowerFlow.P_flow)
    annotation (Line(points={{-47,50},{-38,50}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=3500, Interval=1),
    __Dymola_experimentSetupOutput);
end SOECstack_closedLoopControl;
