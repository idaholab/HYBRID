within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.DoNotUse;
model ComponentSplitter_test
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.Boundary_pT Sink_H2(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(extent={{-78,42},{-58,62}})));
  Modelica.Fluid.Sources.Boundary_pT Sink_H2O(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(extent={{-88,-114},{-68,-94}})));
  Modelica.Blocks.Sources.Constant ShellFlowControl(k=0.001772)   annotation (Placement(transformation(extent={{140,-2},{120,18}})));
  ComponentSplitter2 componentSplitter2_1 annotation (Placement(transformation(extent={{18,-22},{-20,20}})));
  Modelica.Fluid.Sources.MassFlowSource_T ShellFeed(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.64,0.34}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=313.15) annotation (Placement(transformation(extent={{92,-10},{72,10}})));
equation
  connect(componentSplitter2_1.vaporOutlet, Sink_H2.ports[1]) annotation (Line(points={{-1,17.9},{-1,52},{-58,52}}, color={0,127,255}));
  connect(componentSplitter2_1.liquidOutlet, Sink_H2O.ports[1]) annotation (Line(points={{-1,-19.9},{-1,-104},{-68,-104}}, color={0,127,255}));
  connect(componentSplitter2_1.feedInlet, ShellFeed.ports[1]) annotation (Line(points={{14.2,-1},{72,0}}, color={0,127,255}));
  connect(ShellFlowControl.y, ShellFeed.m_flow_in) annotation (Line(points={{119,8},{92,8}}, color={0,0,127}));
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
end ComponentSplitter_test;
