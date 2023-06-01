within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.DoNotUse;
model Condenser
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    use_m_flow_in=false,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.64,0.36}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.001772,
    T=424.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-66,10},{-46,30}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 101.3,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{76,14},{56,34}})));
  Modelica.Fluid.Sources.MassFlowSource_T GlycolFeed(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    use_m_flow_in=false,
    m_flow=0.5,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(extent={{80,-24},{60,-4}})));
  Modelica.Fluid.Sources.Boundary_pT glycolSink(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    p(displayUnit="Pa") = 101.3,
    T=286.45,
    nPorts=1) annotation (Placement(transformation(extent={{-66,-28},{-46,-8}})));
  Fluid.HeatExchangers.Generic_HXs.Generic_STHX Condenser(
  redeclare package Medium_shell =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
  redeclare package Medium_tube =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    redeclare package Tube_Material = NHES.Media.Solids.SS304,
    length_shell=1.2,
    nTubes=85,
    diameter_tube=0.01575,
    th_tube=0.00165,
    nV_shell=5,
    p_a_start_shell=10330000,
    p_b_start_shell=10130000,
    T_a_start_shell=424.15,
    T_b_start_shell=313.15,
    Xs_start_shell={0.1659,0.8341},
    m_flow_start_shell=1.772e-3,
    p_a_start_tube=10530000,
    p_b_start_tube=10130000,
    T_a_start_tube=283.15,
    T_b_start_tube=286.45,
    m_flow_start_tube=0.5,
    D_o_shell=0.27305,
    D_i_shell=0.26624)         annotation (Placement(transformation(extent={{-22,-21},{22,21}},
        rotation=90,
        origin={3,2})));

    //SI.SpecificEnthalpy h_h2;
//   SI.SpecificEnthalpy q=sink.medium.h;
//   SI.SpecificEnthalpy q2=sink1.medium.h;

equation

  connect(GlycolFeed.ports[1], Condenser.port_a_tube)
    annotation (Line(points={{60,-14},{34,-14},{34,2},{24,2}},                       color={0,127,255}));
  connect(Condenser.port_b_tube, glycolSink.ports[1])
    annotation (Line(points={{-18,2},{-36,2},{-36,-18},{-46,-18}},                     color={0,127,255}));
  connect(cathodeFeed.ports[1], Condenser.port_a_shell) annotation (Line(points={{-46,20},{-28,20},{-28,12.12},{-18,12.12}}, color={0,127,255}));
  connect(Condenser.port_b_shell, cathodeSink.ports[1]) annotation (Line(points={{24,12.12},{46,12.12},{46,24},{56,24}}, color={0,127,255}));
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
end Condenser;
