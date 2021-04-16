within NHES.Electrolysis.Electrolyzers.Examples;
model SOECstack_openLoopControl "Open-loop control for SOEC stack operation"
  import NHES.Electrolysis;
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp powerSP(
    duration=0,
    startTime=100,
    height=-2*1e6*5,
    offset=9.10627*1e6*5)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Blocks.Sources.Ramp anodeGasFlowSignal(
    duration=20,
    startTime=500,
    offset=4.65587*5,
    height=1.2*5)   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,-10})));
  Electrolysis.Electrolyzers.BaseClasses.SOEC SOECstack(
    numVessels=5,
    numCells_perVessel=68320,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{16,-8},{38,14}})));

  Modelica.Blocks.Sources.Ramp anodeGasFlowSignal2(
    duration=20,
    startTime=2500,
    offset=0,
    height=-0.30*5) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,-44})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-58,-32},{-46,-20}})));
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
    annotation (Placement(transformation(extent={{-46,-4},{-26,16}})));

  Modelica.Fluid.Sources.MassFlowSource_T anodeFeed(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    m_flow=4.65587*5,
    X=Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM*1000}),
    nPorts=1,
    T=1123.15)
    annotation (Placement(transformation(extent={{-32,-44},{-12,-24}})));

  Modelica.Fluid.Sources.Boundary_pT cathodeSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1964000,
    T=1023.15)
    annotation (Placement(transformation(extent={{102,-2},{82,18}})));

  Modelica.Fluid.Sources.Boundary_pT cnodeSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air,
    nPorts=1,
    p=1964000,
    T=1073.15)
    annotation (Placement(transformation(extent={{90,-42},{70,-22}})));
  Modelica.Blocks.Sources.Ramp cathodeGasFlowSignal(
    duration=20,
    offset=0.908085*5,
    startTime=1500,
    height=-0.178*5) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-82,34})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn(redeclare package Medium =
               Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-16,-4},{4,16}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowOut(redeclare package Medium =
               Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{52,-2},{72,18}})));
  Electrolysis.Sources.PrescribedPowerFlow prescribedPowerFlow
    annotation (Placement(transformation(extent={{-22,40},{-2,60}})));
equation
  connect(add.u2,anodeGasFlowSignal2. y) annotation (Line(points={{-59.2,
          -29.6},{-70,-29.6},{-70,-44},{-79,-44}},
                                         color={0,0,127}));
  connect(anodeFeed.ports[1], SOECstack.anodeFlangeIn) annotation (Line(
        points={{-12,-34},{2,-34},{2,-2.94},{18.86,-2.94}}, color={0,127,
          255}));
  connect(SOECstack.anodeFlangeOut, cnodeSink.ports[1]) annotation (Line(
        points={{35.14,-0.74},{48,-0.74},{48,-32},{70,-32}}, color={0,127,
          255}));
  connect(cathodeGasFlowSignal.y,cathodeFeed. m_flow_in) annotation (Line(
        points={{-71,34},{-71,34},{-60,34},{-60,14},{-46,14}}, color={0,0,
          127}));
  connect(add.y,anodeFeed. m_flow_in) annotation (Line(points={{-45.4,-26},
          {-45.4,-26},{-32,-26}}, color={0,0,127}));
  connect(cathodeFeed.ports[1],cathodeFlowIn. port_a) annotation (Line(
        points={{-26,6},{-26,6},{-16,6}}, color={0,127,255}));
  connect(cathodeFlowIn.port_b, SOECstack.cathodeFlangeIn) annotation (
      Line(points={{4,6},{18.86,6},{18.86,6.3}}, color={0,127,255}));
  connect(SOECstack.cathodeFlangeOut, cathodeFlowOut.port_a) annotation (
      Line(points={{35.14,8.5},{42,8.5},{42,8},{52,8}}, color={0,127,255}));
  connect(cathodeFlowOut.port_b,cathodeSink. ports[1])
    annotation (Line(points={{72,8},{77,8},{82,8}}, color={0,127,255}));
  connect(anodeGasFlowSignal.y, add.u1) annotation (Line(points={{-79,-10},
          {-70,-10},{-70,-22.4},{-59.2,-22.4}}, color={0,0,127}));
  connect(powerSP.y, prescribedPowerFlow.P_flow)
    annotation (Line(points={{-29,50},{-20,50}}, color={0,0,127}));
  connect(prescribedPowerFlow.port_b, SOECstack.electricalLoad)
    annotation (Line(points={{-2,50},{10,50},{10,1.9},{18.64,1.9}}, color=
         {255,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=3500, Interval=1),
    __Dymola_experimentSetupOutput);
end SOECstack_openLoopControl;
