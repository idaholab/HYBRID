within NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.Examples.ReversingFlow;
model ComponentFMU
  "Example model demonstrating correct functioning of fmu adaptors including at flow reversal"
  extends Modelica.Icons.Example;
  //Define medium with multiple substances and trace constituents so that X and C are retained on connector
  replaceable package Medium=Modelica.Media.Air.MoistAir(extraPropertiesNames={"CO2"},
                                             C_nominal={1.519E-3});

  PressureToMassFlow                                        pressureToMassFlow(redeclare
      package Medium = Medium)                                     annotation (
      Placement(transformation(
        extent={{-10,-26},{10,26}},
        rotation=180,
        origin={14,0})));
  Modelica.Fluid.Sources.Boundary_pT pressure_source(
    redeclare package Medium = Medium,
    use_p_in=true,
    use_T_in=true,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{8,-9},{-8,9}},
        rotation=180,
        origin={-78,-1})));
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
  Modelica.Blocks.Interfaces.RealInput T_source
    "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-120,-14},{-100,6}})));
  Modelica.Blocks.Interfaces.RealInput p_source "Prescribed boundary pressure"
    annotation (Placement(transformation(extent={{-120,-30},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealOutput C_out[size(pressureToMassFlow.C_out, 1)]
    annotation (Placement(transformation(extent={{72,14},{92,34}})));
  Modelica.Blocks.Interfaces.RealOutput X_out[size(pressureToMassFlow.X_out, 1)]
    annotation (Placement(transformation(extent={{84,8},{104,28}})));
  Modelica.Blocks.Interfaces.RealOutput h_out
    annotation (Placement(transformation(extent={{96,2},{116,22}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_out
    annotation (Placement(transformation(extent={{110,-6},{130,14}})));
  Modelica.Blocks.Interfaces.RealOutput Temperature
    "Temperature in port medium"
    annotation (Placement(transformation(extent={{8,50},{28,70}})));
  Modelica.Blocks.Interfaces.RealInput C_in[size(pressureToMassFlow.C_in, 1)]
    "Prescribed mass fractions"
    annotation (Placement(transformation(extent={{78,46},{56,68}})));
  Modelica.Blocks.Interfaces.RealInput X_in[size(pressureToMassFlow.X_in, 1)]
    "Prescribed mass fractions"
    annotation (Placement(transformation(extent={{92,42},{74,60}})));
  Modelica.Blocks.Interfaces.RealInput h_in "Prescribed specific enthalpy"
    annotation (Placement(transformation(extent={{106,36},{86,56}})));
  Modelica.Blocks.Interfaces.RealInput p_in "Prescribed pressure"
    annotation (Placement(transformation(extent={{92,30},{76,46}})));
equation

  connect(volumeFlowRate1.port_b, pressureToMassFlow.fluidPort) annotation (
      Line(points={{0,0},{16,0},{16,-0.2},{3.8,-0.2}}, color={0,127,255}));
  connect(volumeFlowRate.port_b, volume.ports[1])
    annotation (Line(points={{-40,0},{-32.6667,0}},
                                               color={0,127,255}));
  connect(volumeFlowRate1.port_a, volume.ports[2])
    annotation (Line(points={{-20,0},{-30,0}}, color={0,127,255}));
  connect(volumeFlowRate.port_a, pressure_source.ports[1]) annotation (Line(
        points={{-60,0},{-66,0},{-66,-1},{-70,-1}}, color={0,127,255}));
  connect(temperature.port, volume.ports[3]) annotation (Line(points={{-12,4},
          {-22,4},{-22,0},{-27.3333,0}},
                                    color={0,127,255}));
  connect(pressure_source.T_in, T_source) annotation (Line(points={{-87.6,-4.6},
          {-93.8,-4.6},{-93.8,-4},{-110,-4}}, color={0,0,127}));
  connect(pressure_source.p_in, p_source) annotation (Line(points={{-87.6,-8.2},
          {-94.8,-8.2},{-94.8,-20},{-110,-20}}, color={0,0,127}));
  connect(pressureToMassFlow.C_out, C_out) annotation (Line(points={{26,-6},{64,
          -6},{64,24},{82,24}}, color={0,0,127}));
  connect(pressureToMassFlow.X_out, X_out) annotation (Line(points={{26,-12},{
          68,-12},{68,18},{94,18}}, color={0,0,127}));
  connect(pressureToMassFlow.h_out, h_out) annotation (Line(points={{26,-18},{
          74,-18},{74,12},{106,12}}, color={0,0,127}));
  connect(pressureToMassFlow.m_flow_out, m_flow_out) annotation (Line(points={{
          26,-24},{80,-24},{80,4},{120,4}}, color={0,0,127}));
  connect(temperature.T, Temperature)
    annotation (Line(points={{-5,14},{0,14},{0,60},{18,60}}, color={0,0,127}));
  connect(pressureToMassFlow.C_in, C_in) annotation (Line(points={{26,24},{42,
          24},{42,57},{67,57}}, color={0,0,127}));
  connect(pressureToMassFlow.h_in, h_in) annotation (Line(points={{26,12},{56,
          12},{56,46},{96,46}}, color={0,0,127}));
  connect(pressureToMassFlow.p_in, p_in)
    annotation (Line(points={{26,6},{58,6},{58,38},{84,38}}, color={0,0,127}));
  connect(X_in, pressureToMassFlow.X_in) annotation (Line(points={{83,
          51},{48,51},{48,18},{26,18}}, color={0,0,127}));
  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-05,
      __Dymola_Algorithm="Cvode"), Documentation(info="", revisions="<html>
<!--COPYRIGHT-->
</html>"),
    Diagram(coordinateSystem(extent={{-120,-40},{140,80}}), graphics={Rectangle(
          extent={{36,-28},{-94,30}},
          lineColor={238,46,47},
          lineThickness=1,
          pattern=LinePattern.Dash)}),
    Icon(coordinateSystem(extent={{-120,-40},{140,80}})));
end ComponentFMU;
