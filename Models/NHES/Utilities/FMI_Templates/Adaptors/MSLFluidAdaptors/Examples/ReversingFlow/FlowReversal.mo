within NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.Examples.ReversingFlow;
model FlowReversal
  "Example model demonstrating correct functioning of fmu adaptors including at flow reversal"
  extends Modelica.Icons.Example;
  //Define medium with multiple substances and trace constituents so that X and C are retained on connector
  replaceable package Medium=Modelica.Media.Air.MoistAir(extraPropertiesNames={"CO2"},
                                             C_nominal={1.519E-3});

  Modelica.Fluid.Sources.Boundary_pT pressure_sink(
    redeclare package Medium = Medium,
    p=100000,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-8,-9},{8,9}},
        rotation=180,
        origin={92,-1})));
  Modelica.Fluid.Sources.Boundary_pT pressure_source(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{8,-9},{-8,9}},
        rotation=180,
        origin={-78,-1})));
  Modelica.Blocks.Sources.Sine p_source(
    amplitude=0.1e5,
    f=1,
    offset=1e5)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate volumeFlowRate(
    redeclare package Medium = Medium,
    a=1e5,
    b=1e5) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Vessels.ClosedVolume volume(
    redeclare package Medium =  Medium,
    use_portsData=false,
    V(displayUnit="l") = 0.0005,
    nPorts=3) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate volumeFlowRate1(
    redeclare package Medium = Medium,
    a=1e5,
    b=1e5) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package
      Medium =
        Medium)
    annotation (Placement(transformation(extent={{-22,4},{-2,24}})));
  Modelica.Blocks.Sources.Constant T_source(k=293.15)
    annotation (Placement(transformation(extent={{-40,40},{-60,60}})));
  PressureToMassFlow pressureToMassFlow1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{26,-26},{6,26}})));
  MassFlowToPressure massFlowToPressure1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{74,-26},{54,26}})));
equation

  connect(volumeFlowRate.port_b, volume.ports[1])
    annotation (Line(points={{-40,0},{-32.6667,0}},
                                               color={0,127,255}));
  connect(volumeFlowRate1.port_a, volume.ports[2])
    annotation (Line(points={{-20,0},{-30,0}}, color={0,127,255}));
  connect(volumeFlowRate.port_a, pressure_source.ports[1]) annotation (Line(
        points={{-60,0},{-66,0},{-66,-1},{-70,-1}}, color={0,127,255}));
  connect(pressure_source.p_in, p_source.y) annotation (Line(points={{-87.6,
          -8.2},{-98,-8.2},{-98,34},{-76,34},{-76,50},{-79,50}}, color={0,0,127}));
  connect(temperature.port, volume.ports[3]) annotation (Line(points={{-12,4},
          {-22,4},{-22,0},{-27.3333,0}},
                                    color={0,127,255}));
  connect(T_source.y, pressure_source.T_in) annotation (Line(points={{-61,50},{
          -68,50},{-68,32},{-96,32},{-96,-4.6},{-87.6,-4.6}}, color={0,0,127}));
  connect(volumeFlowRate1.port_b, pressureToMassFlow1.fluidPort)
    annotation (Line(points={{0,0},{2,0},{2,0.2},{5.8,0.2}}, color={0,
          127,255}));
  connect(pressure_sink.ports[1], massFlowToPressure1.fluidPort)
    annotation (Line(points={{84,-1},{80,-1},{80,0},{74,0}}, color={0,
          127,255}));
  connect(pressureToMassFlow1.m_flow_out, massFlowToPressure1.m_flow_in)
    annotation (Line(points={{28,24},{52,24}}, color={0,0,127}));
  connect(pressureToMassFlow1.h_out, massFlowToPressure1.h_in)
    annotation (Line(points={{28,18},{52,18}}, color={0,0,127}));
  connect(pressureToMassFlow1.X_out, massFlowToPressure1.X_in)
    annotation (Line(points={{28,12},{52,12}}, color={0,0,127}));
  connect(massFlowToPressure1.p_out, pressureToMassFlow1.p_in)
    annotation (Line(points={{52,-6},{28,-6}}, color={0,0,127}));
  connect(massFlowToPressure1.h_out, pressureToMassFlow1.h_in)
    annotation (Line(points={{52,-12},{28,-12}}, color={0,0,127}));
  connect(massFlowToPressure1.X_out, pressureToMassFlow1.X_in)
    annotation (Line(points={{52,-18},{28,-18}}, color={0,0,127}));
  connect(pressureToMassFlow1.C_out, massFlowToPressure1.C_in)
    annotation (Line(points={{28,6},{52,6}}, color={0,0,127}));
  connect(massFlowToPressure1.C_out, pressureToMassFlow1.C_in)
    annotation (Line(points={{52,-24},{28,-24}}, color={0,0,127}));
  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-05,
      __Dymola_Algorithm="Cvode"), Documentation(info="", revisions="<html>
<!--COPYRIGHT-->
</html>"),
    Diagram(coordinateSystem(extent={{-100,-40},{100,60}}), graphics={Rectangle(
          extent={{36,-28},{-94,30}},
          lineColor={238,46,47},
          lineThickness=1,
          pattern=LinePattern.Dash)}),
    Icon(coordinateSystem(extent={{-100,-40},{100,60}})));
end FlowReversal;
