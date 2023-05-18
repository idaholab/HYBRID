within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.DoNotUse;
model Condenser_v2
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
  TRANSFORM.HeatExchangers.GenericDistributed_HX Condenser(
  redeclare package Medium_shell =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas,
  redeclare package Medium_tube =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_3Region,
    p_a_start_shell=10330000,
    p_b_start_shell=10130000,
    T_a_start_shell=424.15,
    T_b_start_shell=283.75,
    Xs_start_shell={0.1659,0.8341},
    p_a_start_tube=10530000,
    p_b_start_tube=10130000,
    T_a_start_tube=283.15,
    T_b_start_tube=285.05)     annotation (Placement(transformation(extent={{-22,21},{22,-21}},
        rotation=180,
        origin={3,0})));

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

  connect(Condenser.port_b_shell, ShellOutTemp.port_a) annotation (Line(points={{25,9.66},{42,9.66},{42,10},{60,10}},   color={0,127,255}));
  connect(ShellOutTemp.port_b, cathodeSink.ports[1]) annotation (Line(points={{80,10},{114,10.12},{114,20},{124,20}}, color={0,127,255}));
  connect(cathodeFeed.ports[1], ShellInTemp.port_a) annotation (Line(points={{-148,26},{-130,26},{-130,10.12},{-98,10}}, color={0,127,255}));
  connect(ShellInTemp.port_b, Condenser.port_a_shell) annotation (Line(points={{-78,10},{-48,10},{-48,9.66},{-19,9.66}},   color={0,127,255}));
  connect(GlycolFeed.ports[1], GlycolInTemp.port_a) annotation (Line(points={{128,-18},{94,-18}}, color={0,127,255}));
  connect(GlycolInTemp.port_b, Condenser.port_a_tube)
    annotation (Line(points={{74,-18},{40,-18},{40,0},{32,0},{32,-3.55271e-15},{25,-3.55271e-15}}, color={0,127,255}));
  connect(Condenser.port_b_tube, GlycolOutTemp.port_a)
    annotation (Line(points={{-19,3.55271e-15},{-28,3.55271e-15},{-28,0},{-36,0},{-36,-12},{-104,-12}}, color={0,127,255}));
  connect(GlycolOutTemp.port_b, glycolSink.ports[1]) annotation (Line(points={{-124,-12},{-148,-12}}, color={0,127,255}));
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
end Condenser_v2;
