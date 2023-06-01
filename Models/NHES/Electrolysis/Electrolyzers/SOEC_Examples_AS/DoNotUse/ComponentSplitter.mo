within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.DoNotUse;
model ComponentSplitter
  extends Modelica.Icons.Example;

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{62,-10},{42,10}})));
  Separator.Temp_flashDrumVessel
                           temp_flashDrumVessel(
                                          redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  Modelica.Fluid.Sources.Boundary_pT Sink_H2(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(extent={{-144,32},{-124,52}})));
  Modelica.Fluid.Sources.Boundary_pT Sink_H2O(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(extent={{-150,-46},{-130,-26}})));
  Modelica.Fluid.Sources.MassFlowSource_T ShellFeed(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.64,0.34}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=424.15) annotation (Placement(transformation(extent={{104,-10},{84,10}})));
  Modelica.Blocks.Sources.Constant ShellFlowControl(k=0.001772)   annotation (Placement(transformation(extent={{140,-2},{120,18}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume condenser(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p_start(displayUnit="kPa") = 103800,
    T_start=423.65,
    X_start={0.0122804,0.9877196},
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume,
    use_HeatPort=true) annotation (Placement(transformation(extent={{-36,54},{-60,30}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary3(T=313.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-48,68})));
  TRANSFORM.Fluid.Volumes.SimpleVolume condenser1(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p_start(displayUnit="kPa") = 103800,
    T_start=423.65,
    X_start={0.0122804,0.9877196},
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume,
    use_HeatPort=true) annotation (Placement(transformation(extent={{-36,-24},{-60,-48}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary1(T=313.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-48,-10})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelHXOutTempH2(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-2,32},{-22,52}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTempH2(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-80,32},{-100,52}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelHXOutTempH2O(redeclare package
                                                                                Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-6,-46},{-26,-26}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTempH2O(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-92,-46},{-112,-26}})));
equation
  connect(SinkTemp.port_b, temp_flashDrumVessel.feedInlet) annotation (Line(points={{42,0},{8,0}}, color={0,127,255}));
  connect(ShellFeed.m_flow_in,ShellFlowControl. y) annotation (Line(points={{104,8},{119,8}},     color={0,0,127}));
  connect(ShellFeed.ports[1], SinkTemp.port_a) annotation (Line(points={{84,0},{62,0}}, color={0,127,255}));
  connect(condenser.heatPort, boundary3.port) annotation (Line(points={{-48,49.2},{-48,58}}, color={191,0,0}));
  connect(condenser1.heatPort, boundary1.port) annotation (Line(points={{-48,-28.8},{-48,-20}}, color={191,0,0}));
  connect(condenser.port_b, SinkTempH2.port_a) annotation (Line(points={{-55.2,42},{-80,42}}, color={0,127,255}));
  connect(SinkTempH2.port_b, Sink_H2.ports[1]) annotation (Line(points={{-100,42},{-124,42}}, color={0,127,255}));
  connect(temp_flashDrumVessel.vaporOutlet, FuelHXOutTempH2.port_a) annotation (Line(points={{0,9},{0,42},{-2,42}}, color={0,127,255}));
  connect(FuelHXOutTempH2.port_b, condenser.port_a) annotation (Line(points={{-22,42},{-40.8,42}}, color={0,127,255}));
  connect(condenser1.port_b, SinkTempH2O.port_a) annotation (Line(points={{-55.2,-36},{-92,-36}}, color={0,127,255}));
  connect(SinkTempH2O.port_b, Sink_H2O.ports[1]) annotation (Line(points={{-112,-36},{-130,-36}}, color={0,127,255}));
  connect(temp_flashDrumVessel.liquidOutlet, FuelHXOutTempH2O.port_a) annotation (Line(points={{0,-9},{0,-36},{-6,-36}}, color={0,127,255}));
  connect(FuelHXOutTempH2O.port_b, condenser1.port_a) annotation (Line(points={{-26,-36},{-40.8,-36}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-250,
            -250},{250,250}})),
            experiment(StopTime=1e3,__Dymola_Algorithm="Dassl"),
  Documentation(info="<html>
  <p>Model of a solid oxide electrolysis cell based on OxEon design. The design has a total of 780 cells based on 65 cells in 12 stacks (65 x 12 = 780). 
  Some of the cell design parameters are chosen from publicly available information for the OxEon Energy SOEC. These details can be found at https://doi.org/10.1016/j.ijhydene.2020.04.074 </p>
    <p>The model's steady state conditions are acquired from an Aspen HYSYS model, which are then used as initial conditions for this model</p>
    <p>The SOEC has a constant area specific resistance (ASR) and operating voltage. These numbers will be modified in the future to account for cell degradation using empirical data.
    The Gibbs Free Energy term is calculated using NASA's 7-term polynomial.
    For any questions regarding the model, please contact Amey Shigrekar (amey.shigreka@inl.gov)</p>        
 </html>"));
end ComponentSplitter;
