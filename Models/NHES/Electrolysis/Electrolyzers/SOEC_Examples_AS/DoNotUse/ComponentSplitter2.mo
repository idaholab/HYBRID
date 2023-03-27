within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.DoNotUse;
model ComponentSplitter2
  extends NHES.Electrolysis.Icons.FlashDrum;
  replaceable package Medium = Electrolysis.Media.Electrolysis.CathodeGas;

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{18,-10},{-2,10}})));
  Separator.Temp_flashDrumVessel
                           temp_flashDrumVessel(
                                          redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-6,-10},{-26,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T ShellFeed(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.64,0.34}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=424.15) annotation (Placement(transformation(extent={{42,-10},{22,10}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume condenser(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p_start(displayUnit="kPa") = 103800,
    T_start=423.65,
    X_start={0.0122804,0.9877196},
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume,
    use_HeatPort=true) annotation (Placement(transformation(extent={{-42,54},{-66,30}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary3(T=313.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-54,68})));
  TRANSFORM.Fluid.Volumes.SimpleVolume condenser1(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p_start(displayUnit="kPa") = 103800,
    T_start=423.65,
    X_start={0.0122804,0.9877196},
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume,
    use_HeatPort=true) annotation (Placement(transformation(extent={{-46,-22},{-70,-46}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                      boundary1(T=313.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-58,-8})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelHXOutTempH2(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-22,32},{-42,52}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTempH2(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-70,32},{-90,52}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort FuelHXOutTempH2O(redeclare package
                                                                                Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-22,-44},{-42,-24}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort SinkTempH2O(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-72,-44},{-92,-24}})));
  Modelica.Fluid.Interfaces.FluidPort_b vaporOutlet(redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-108,32},{-88,52}}),iconTransformation(extent={{
            -10,80},{10,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b liquidOutlet(redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-110,-44},{-90,-24}}),iconTransformation(extent=
           {{-10,-100},{10,-80}})));
  Modelica.Fluid.Interfaces.FluidPort_a feedInlet(redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{88,-10},{108,10}}),  iconTransformation(extent={
            {-90,-10},{-70,10}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{80,80},{60,60}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeGasShellSink(
    nPorts=1,
    redeclare package Medium = Medium,
    p(displayUnit="kPa") = 103300,
    T=424.15) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={30,70})));
equation
  connect(SinkTemp.port_b, temp_flashDrumVessel.feedInlet) annotation (Line(points={{-2,0},{-8,0}},color={0,127,255}));
  connect(ShellFeed.ports[1], SinkTemp.port_a) annotation (Line(points={{22,0},{18,0}}, color={0,127,255}));
  connect(condenser.heatPort, boundary3.port) annotation (Line(points={{-54,49.2},{-54,58}}, color={191,0,0}));
  connect(condenser1.heatPort, boundary1.port) annotation (Line(points={{-58,-26.8},{-58,-18}}, color={191,0,0}));
  connect(condenser.port_b, SinkTempH2.port_a) annotation (Line(points={{-61.2,42},{-70,42}}, color={0,127,255}));
  connect(temp_flashDrumVessel.vaporOutlet, FuelHXOutTempH2.port_a) annotation (Line(points={{-16,9},{-16,42},{-22,42}},
                                                                                                                    color={0,127,255}));
  connect(FuelHXOutTempH2.port_b, condenser.port_a) annotation (Line(points={{-42,42},{-46.8,42}}, color={0,127,255}));
  connect(condenser1.port_b, SinkTempH2O.port_a) annotation (Line(points={{-65.2,-34},{-72,-34}}, color={0,127,255}));
  connect(temp_flashDrumVessel.liquidOutlet, FuelHXOutTempH2O.port_a) annotation (Line(points={{-16,-9},{-16,-34},{-22,-34}},
                                                                                                                         color={0,127,255}));
  connect(FuelHXOutTempH2O.port_b, condenser1.port_a) annotation (Line(points={{-42,-34},{-50.8,-34}}, color={0,127,255}));
  connect(SinkTempH2.port_b, vaporOutlet) annotation (Line(points={{-90,42},{-98,42}}, color={0,127,255}));
  connect(SinkTempH2O.port_b, liquidOutlet) annotation (Line(points={{-92,-34},{-100,-34}}, color={0,127,255}));
  connect(feedInlet, massFlowRate.port_a) annotation (Line(points={{98,0},{82,0},{82,56},{84,56},{84,70},{80,70}}, color={0,127,255}));
  connect(massFlowRate.port_b, cathodeGasShellSink.ports[1]) annotation (Line(points={{60,70},{40,70}}, color={0,127,255}));
  connect(massFlowRate.m_flow, ShellFeed.m_flow_in) annotation (Line(points={{70,59},{70,14},{42,14},{42,8}}, color={0,0,127}));

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
 </html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
            Documentation(info="<html>
  <p>Model of a solid oxide electrolysis cell based on OxEon design. The design has a total of 780 cells based on 65 cells in 12 stacks (65 x 12 = 780). 
  Some of the cell design parameters are chosen from publicly available information for the OxEon Energy SOEC. These details can be found at https://doi.org/10.1016/j.ijhydene.2020.04.074 </p>
    <p>The model's steady state conditions are acquired from an Aspen HYSYS model, which are then used as initial conditions for this model</p>
    <p>The SOEC has a constant area specific resistance (ASR) and operating voltage. These numbers will be modified in the future to account for cell degradation using empirical data.
    The Gibbs Free Energy term is calculated using NASA's 7-term polynomial.
    For any questions regarding the model, please contact Amey Shigrekar (amey.shigreka@inl.gov)</p>        
 </html>"),
 graphics={     Text(
          extent={{-150,20},{150,-20}},
          lineColor={0,0,255},
          origin={128,-1},
          rotation=90)}),             Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end ComponentSplitter2;
