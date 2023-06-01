within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model HXModeling_v3
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T TubeFeed(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.64,0.36}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=1063.15) annotation (Placement(transformation(extent={{-146,144},{-126,164}})));
  Modelica.Fluid.Sources.Boundary_pT TubeSink(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=423.65,
    nPorts=1) annotation (Placement(transformation(extent={{146,144},{126,164}})));
  Modelica.Fluid.Sensors.MassFlowRate TubeFlowMeasure(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-122,144},{-102,164}})));
  Modelica.Blocks.Sources.Constant TubeControl(k=6.379/3600) annotation (Placement(transformation(extent={{-182,152},{-162,172}})));
  Modelica.Fluid.Sources.MassFlowSource_T ShellFeed(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=414.15) annotation (Placement(transformation(extent={{152,74},{132,94}})));
  Modelica.Fluid.Sensors.MassFlowRate ShellFlowMeasure(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{122,74},{102,94}})));
  Modelica.Blocks.Sources.Constant ShellFlowControl(k=13.47/3600) annotation (Placement(transformation(extent={{188,82},{168,102}})));
  Modelica.Fluid.Sources.Boundary_pT ShellSink(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=981.25,
    nPorts=1) annotation (Placement(transformation(extent={{-142,72},{-122,92}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_V2 FuelHX1(
    NTU=9,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium = Media.Electrolysis.CathodeGas,
    redeclare package Shell_medium = Media.Electrolysis.CathodeGas,
    p_start_tube(displayUnit="kPa") = 103800,
    h_start_tube_inlet=4.341e6,
    h_start_tube_outlet=1.65549e6,
    p_start_shell(displayUnit="kPa") = 103800,
    h_start_shell_inlet=831088,
    h_start_shell_outlet=2.09956e6,
    dp_init_tube=10000,
    dp_init_shell=10000,
    Q_init=4773,
    Cr_init=0.98,
    m_start_tube=6.379/3600,
    m_start_shell=13.47/3600)  annotation (Placement(transformation(extent={{26,100},{-20,146}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeIn_Temp(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-84,144},{-64,164}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeOut_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{64,144},{84,164}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellIn_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{92,74},{72,94}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOut_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-84,72},{-104,92}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort ShellOutEnth(redeclare
      package                                                                    Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-44,72},{-64,92}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort ShellInEnth(redeclare package
                                                                                Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{60,74},{40,94}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort TubeOutEnth(redeclare package
                                                                                Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{94,144},{114,164}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort TubeInEnth(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-56,144},{-36,164}})));

  Modelica.Fluid.Sources.MassFlowSource_T TubeFeed1(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=293.15)  annotation (Placement(transformation(extent={{-144,-38},{-124,-18}})));
  Modelica.Fluid.Sources.Boundary_pT TubeSink1(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 103300,
    T=1053.15,
    nPorts=1) annotation (Placement(transformation(extent={{148,-38},{128,-18}})));
  Modelica.Fluid.Sensors.MassFlowRate TubeFlowMeasure1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-120,-38},{-100,-18}})));
  Modelica.Blocks.Sources.Constant TubeControl1(k=20/3600)   annotation (Placement(transformation(extent={{-180,-30},{-160,-10}})));
  Modelica.Fluid.Sources.MassFlowSource_T ShellFeed1(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.5987,0.4013}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=1063.15)
              annotation (Placement(transformation(extent={{154,-108},{134,-88}})));
  Modelica.Fluid.Sensors.MassFlowRate ShellFlowMeasure1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{124,-108},{104,-88}})));
  Modelica.Blocks.Sources.Constant ShellFlowControl1(k=27.09/3600)
                                                                  annotation (Placement(transformation(extent={{190,-100},{170,-80}})));
  Modelica.Fluid.Sources.Boundary_pT ShellSink1(
    redeclare package Medium = Media.Electrolysis.AnodeGas_air,
    p(displayUnit="Pa") = 101.3,
    T=504.55,
    nPorts=1) annotation (Placement(transformation(extent={{-140,-110},{-120,-90}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_V2 AirHx(
    NTU=12.95,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium = Media.Electrolysis.AnodeGas_air,
    redeclare package Shell_medium = Media.Electrolysis.AnodeGas_air,
    p_start_tube(displayUnit="kPa") = 103300,
    h_start_tube_inlet=295537,
    p_start_shell(displayUnit="kPa") = 103300,
    h_start_shell_inlet=1.1065e6,
    dp_init_tube=10000,
    dp_init_shell=10000,
    Q_init=4588,
    Cr_init=0.654,
    m_start_tube=20/3600,
    m_start_shell=27.09/3600) annotation (Placement(transformation(extent={{28,-82},{-18,-36}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeIn_Temp1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-82,-38},{-62,-18}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeOut_Temp1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{66,-38},{86,-18}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellIn_Temp1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{94,-108},{74,-88}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOut_Temp1(redeclare package Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-82,-110},{-102,-90}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort ShellOutEnth1(redeclare
      package                                                                     Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-42,-110},{-62,-90}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort ShellInEnth1(redeclare
      package                                                                    Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{62,-108},{42,-88}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort TubeOutEnth1(redeclare
      package                                                                    Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{96,-38},{116,-18}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort TubeInEnth1(redeclare package
                                                                                Medium =
        Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-54,-38},{-34,-18}})));
equation
  connect(TubeFeed.ports[1], TubeFlowMeasure.port_a) annotation (Line(points={{-126,154},{-122,154}},
                                                                                                    color={0,127,255}));
  connect(TubeFeed.m_flow_in, TubeControl.y) annotation (Line(points={{-146,162},{-161,162}},
                                                                                            color={0,0,127}));
  connect(ShellFeed.ports[1], ShellFlowMeasure.port_a) annotation (Line(points={{132,84},{122,84}},   color={0,127,255}));
  connect(ShellFeed.m_flow_in, ShellFlowControl.y) annotation (Line(points={{152,92},{167,92}},   color={0,0,127}));
  connect(TubeFlowMeasure.port_b, TubeIn_Temp.port_a) annotation (Line(points={{-102,154},{-84,154}},
                                                                                                    color={0,127,255}));
  connect(FuelHX1.Tube_out, TubeOut_Temp.port_a) annotation (Line(points={{26,132.2},{54,132.2},{54,154},{64,154}},
                                                                                             color={0,127,255}));
  connect(ShellFlowMeasure.port_b, ShellIn_Temp.port_a) annotation (Line(points={{102,84},{92,84}},   color={0,127,255}));
  connect(ShellOut_Temp.port_b, ShellSink.ports[1]) annotation (Line(points={{-104,82},{-122,82}},   color={0,127,255}));
  connect(FuelHX1.Shell_out, ShellOutEnth.port_a) annotation (Line(points={{-20,118.4},{-34,118.4},{-34,82},{-44,82}}, color={0,127,255}));
  connect(ShellOutEnth.port_b, ShellOut_Temp.port_a) annotation (Line(points={{-64,82},{-84,82}},   color={0,127,255}));
  connect(ShellIn_Temp.port_b, ShellInEnth.port_a) annotation (Line(points={{72,84},{60,84}},   color={0,127,255}));
  connect(ShellInEnth.port_b, FuelHX1.Shell_in) annotation (Line(points={{40,84},{34,84},{34,118.4},{26,118.4}}, color={0,127,255}));
  connect(TubeOut_Temp.port_b, TubeOutEnth.port_a) annotation (Line(points={{84,154},{94,154}},
                                                                                              color={0,127,255}));
  connect(TubeOutEnth.port_b, TubeSink.ports[1]) annotation (Line(points={{114,154},{126,154}},
                                                                                              color={0,127,255}));
  connect(TubeIn_Temp.port_b, TubeInEnth.port_a) annotation (Line(points={{-64,154},{-56,154}},
                                                                                              color={0,127,255}));
  connect(TubeInEnth.port_b, FuelHX1.Tube_in) annotation (Line(points={{-36,154},{-30,154},{-30,132.2},{-20,132.2}},
                                                                                                               color={0,127,255}));
  connect(TubeFeed1.ports[1], TubeFlowMeasure1.port_a) annotation (Line(points={{-124,-28},{-120,-28}}, color={0,127,255}));
  connect(TubeFeed1.m_flow_in, TubeControl1.y) annotation (Line(points={{-144,-20},{-159,-20}}, color={0,0,127}));
  connect(ShellFeed1.ports[1], ShellFlowMeasure1.port_a) annotation (Line(points={{134,-98},{124,-98}}, color={0,127,255}));
  connect(ShellFeed1.m_flow_in, ShellFlowControl1.y) annotation (Line(points={{154,-90},{169,-90}}, color={0,0,127}));
  connect(TubeFlowMeasure1.port_b, TubeIn_Temp1.port_a) annotation (Line(points={{-100,-28},{-82,-28}}, color={0,127,255}));
  connect(AirHx.Tube_out, TubeOut_Temp1.port_a) annotation (Line(points={{28,-49.8},{56,-49.8},{56,-28},{66,-28}}, color={0,127,255}));
  connect(ShellFlowMeasure1.port_b, ShellIn_Temp1.port_a) annotation (Line(points={{104,-98},{94,-98}}, color={0,127,255}));
  connect(ShellOut_Temp1.port_b, ShellSink1.ports[1]) annotation (Line(points={{-102,-100},{-120,-100}}, color={0,127,255}));
  connect(AirHx.Shell_out, ShellOutEnth1.port_a) annotation (Line(points={{-18,-63.6},{-32,-63.6},{-32,-100},{-42,-100}}, color={0,127,255}));
  connect(ShellOutEnth1.port_b, ShellOut_Temp1.port_a) annotation (Line(points={{-62,-100},{-82,-100}}, color={0,127,255}));
  connect(ShellIn_Temp1.port_b, ShellInEnth1.port_a) annotation (Line(points={{74,-98},{62,-98}}, color={0,127,255}));
  connect(ShellInEnth1.port_b, AirHx.Shell_in) annotation (Line(points={{42,-98},{36,-98},{36,-63.6},{28,-63.6}}, color={0,127,255}));
  connect(TubeOut_Temp1.port_b, TubeOutEnth1.port_a) annotation (Line(points={{86,-28},{96,-28}}, color={0,127,255}));
  connect(TubeOutEnth1.port_b, TubeSink1.ports[1]) annotation (Line(points={{116,-28},{128,-28}}, color={0,127,255}));
  connect(TubeIn_Temp1.port_b, TubeInEnth1.port_a) annotation (Line(points={{-62,-28},{-54,-28}}, color={0,127,255}));
  connect(TubeInEnth1.port_b, AirHx.Tube_in) annotation (Line(points={{-34,-28},{-28,-28},{-28,-49.8},{-18,-49.8}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}})),
            experiment(StopTime=1e4,
            __Dymola_Algorithm="Esdirk45a"),
  Documentation(info="<html>
  <p>HX analysis to model recuperative heat exchangers for the HTSE setup. Simple HXs are causing an issue with the volume, therefore need to look into the single_phase NTU HX. Use the NTU_new model as it has some unnecessary equations removed. For now, the NTU HX is very slow. Need to figure out how to speed it up.</p>   
 </html>"));
end HXModeling_v3;
