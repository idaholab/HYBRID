within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.DoNotUse;
model Condenser_v4
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    use_m_flow_in=false,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.64,0.36}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.00177,
    T=424.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-148,0},{-128,20}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 101.3,
    T=424.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{152,0},{132,20}})));

    //SI.SpecificEnthalpy h_h2;
//   SI.SpecificEnthalpy q=sink.medium.h;
//   SI.SpecificEnthalpy q2=sink1.medium.h;

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellInTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-98,0},{-78,20}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOutTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface
                                       pipe(  redeclare package Medium =
        Media.Electrolysis.CathodeGas,
    T_a_start=424.15,
    T_b_start=424.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (                                                                                                          dimension=0.01, nSurfaces=1),
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal)
                                                                                                                           annotation (Placement(transformation(extent={{-30,-18},
            {22,38}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary(use_port=false, Q_flow=-500)
    annotation (Placement(transformation(extent={{-74,46},{-54,66}})));
equation

  connect(ShellOutTemp.port_b, cathodeSink.ports[1]) annotation (Line(points={{100,10},{132,10}},                     color={0,127,255}));
  connect(cathodeFeed.ports[1], ShellInTemp.port_a) annotation (Line(points={{-128,10},{-98,10}},                        color={0,127,255}));
  connect(ShellInTemp.port_b, pipe.port_a) annotation (Line(points={{-78,10},{-30,10}}, color={0,127,255}));
  connect(pipe.port_b, ShellOutTemp.port_a) annotation (Line(points={{22,10},{80,10}}, color={0,127,255}));
  connect(boundary.port, pipe.heatPorts[1, 1]) annotation (Line(points={{-54,56},{-4,56},{-4,24}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}})),
            experiment(StopTime=1e3, __Dymola_Algorithm="esdirk45a"),
  Documentation(info="<html>
  <p>Model of a solid oxide electrolysis cell based on OxEon design. The design has a total of 780 cells based on 65 cells in 12 stacks (65 x 12 = 780). 
  Some of the cell design parameters are chosen from publicly available information for the OxEon Energy SOEC. These details can be found at https://doi.org/10.1016/j.ijhydene.2020.04.074 </p>
    <p>The model's steady state conditions are acquired from an Aspen HYSYS model, which are then used as initial conditions for this model</p>
    <p>The SOEC has a constant area specific resistance (ASR) and operating voltage. These numbers will be modified in the future to account for cell degradation using empirical data.
    The Gibbs Free Energy term is calculated using NASA's 7-term polynomial.
    For any questions regarding the model, please contact Amey Shigrekar (amey.shigreka@inl.gov)</p>        
 </html>"));
end Condenser_v4;
