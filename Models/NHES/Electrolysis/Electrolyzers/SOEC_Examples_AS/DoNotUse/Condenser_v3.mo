within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.DoNotUse;
model Condenser_v3
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    use_m_flow_in=false,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.64,0.36}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.001772,
    T=424.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-168,16},{-148,36}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 101.3,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{144,10},{124,30}})));
  Modelica.Fluid.Sources.MassFlowSource_T GlycolFeed(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    use_m_flow_in=false,
    m_flow=0.035,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(extent={{148,-28},{128,-8}})));
  Modelica.Fluid.Sources.Boundary_pT glycolSink(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    p(displayUnit="Pa") = 101.3,
    T=286.45,
    nPorts=1) annotation (Placement(transformation(extent={{-168,-22},{-148,-2}})));
  TRANSFORM.HeatExchangers.Simple_HX             Condenser(
    redeclare package Medium_1 = Media.Electrolysis.CathodeGas,
    redeclare package Medium_2 =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    V_1=0.1,
    V_2=0.1,
    UA=150,
    p_a_start_1=10330000,
    p_b_start_1=10320000,
    T_a_start_1=424.15,
    T_b_start_1=283.27,
    m_flow_start_1=0.001772,
    p_a_start_2=10130000,
    p_b_start_2=10120000,
    T_a_start_2=283.15,
    T_b_start_2=287.1,
    m_flow_start_2=0.5)        annotation (Placement(transformation(extent={{22,21},{-22,-21}},
        rotation=180,
        origin={3,4})));

    //SI.SpecificEnthalpy h_h2;
//   SI.SpecificEnthalpy q=sink.medium.h;
//   SI.SpecificEnthalpy q2=sink1.medium.h;

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellInTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-98,0},{-78,20}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOutTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort GlycolInTemp(redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water)
    annotation (Placement(transformation(extent={{94,-28},{74,-8}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort GlycolOutTemp(redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water)
    annotation (Placement(transformation(extent={{-104,-22},{-124,-2}})));
equation

  connect(ShellOutTemp.port_b, cathodeSink.ports[1]) annotation (Line(points={{80,10},{114,10.12},{114,20},{124,20}}, color={0,127,255}));
  connect(cathodeFeed.ports[1], ShellInTemp.port_a) annotation (Line(points={{-148,26},{-130,26},{-130,10.12},{-98,10}}, color={0,127,255}));
  connect(GlycolFeed.ports[1], GlycolInTemp.port_a) annotation (Line(points={{128,-18},{94,-18}}, color={0,127,255}));
  connect(GlycolOutTemp.port_b, glycolSink.ports[1]) annotation (Line(points={{-124,-12},{-148,-12}}, color={0,127,255}));
  connect(Condenser.port_a1, ShellInTemp.port_b) annotation (Line(points={{-19,12.4},{-70,12.4},{-70,10},{-78,10}}, color={0,127,255}));
  connect(Condenser.port_b1, ShellOutTemp.port_a) annotation (Line(points={{25,12.4},{52,12.4},{52,10},{60,10}}, color={0,127,255}));
  connect(GlycolInTemp.port_b, Condenser.port_a2) annotation (Line(points={{74,-18},{34,-18},{34,-4.4},{25,-4.4}}, color={0,127,255}));
  connect(Condenser.port_b2, GlycolOutTemp.port_a) annotation (Line(points={{-19,-4.4},{-96,-4.4},{-96,-12},{-104,-12}}, color={0,127,255}));
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
end Condenser_v3;
