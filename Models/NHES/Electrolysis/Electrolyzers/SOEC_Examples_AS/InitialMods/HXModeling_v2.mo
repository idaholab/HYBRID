within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model HXModeling_v2
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.64,0.36}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=1063.15)
    annotation (Placement(transformation(extent={{-64,166},{-44,186}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink(
    redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=423.65,
    nPorts=1)
    annotation (Placement(transformation(extent={{78,170},{58,190}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-40,166},{-20,186}})));
  Modelica.Blocks.Sources.Constant CathodeFlowControl(k=6.379/3600)  annotation (Placement(transformation(extent={{-100,174},{-80,194}})));
  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed1(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=414.15)
    annotation (Placement(transformation(extent={{82,132},{62,152}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn1(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{52,132},{32,152}})));
  Modelica.Blocks.Sources.Constant CathodeFlowControl1(k=13.47/3600) annotation (Placement(transformation(extent={{120,140},{100,160}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink1(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=981.25,
    nPorts=1)
    annotation (Placement(transformation(extent={{-66,128},{-46,148}})));
  TRANSFORM.HeatExchangers.Simple_HX FuelHX(
    redeclare package Medium_1 = Media.Electrolysis.CathodeGas,
    redeclare package Medium_2 = Media.Electrolysis.CathodeGas,
    nV=20,
    V_1=0.01,
    V_2=0.01,
    UA=148.9,
    p_a_start_1(displayUnit="kPa") = 103300,
    p_b_start_1(displayUnit="kPa") = 103100,
    T_a_start_1=1063.15,
    T_b_start_1=423.65,
    m_flow_start_1=6.379/3600,
    p_a_start_2(displayUnit="kPa") = 105300,
    p_b_start_2(displayUnit="kPa") = 105000,
    T_a_start_2=414.15,
    T_b_start_2=981.25,
    m_flow_start_2=13.47/3600) annotation (Placement(transformation(extent={{-8,146},{12,166}})));

  Modelica.Fluid.Sources.MassFlowSource_T anodeFeed(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.5987,0.4013}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=1063.15) annotation (Placement(transformation(extent={{-62,80},{-42,100}})));
  Modelica.Fluid.Sources.Boundary_pT anodeSink(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 101300,
    T=504.55,
    nPorts=1) annotation (Placement(transformation(extent={{78,84},{58,104}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn2(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Modelica.Blocks.Sources.Constant AnodeFlowControl(k=7.524e-3)   annotation (Placement(transformation(extent={{-100,88},{-80,108}})));
  Modelica.Fluid.Sources.MassFlowSource_T anodeFeed2(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.79,0.21}, {Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=293.15) annotation (Placement(transformation(extent={{82,46},{62,66}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn3(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air)
    annotation (Placement(transformation(extent={{52,46},{32,66}})));
  Modelica.Blocks.Sources.Constant AnodeFlowControl2(k=5.555e-3)   annotation (Placement(transformation(extent={{120,54},{100,74}})));
  Modelica.Fluid.Sources.Boundary_pT anodeSink2(
    redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    p(displayUnit="kPa") = 103300,
    T=1053.15,
    nPorts=1) annotation (Placement(transformation(extent={{-66,42},{-46,62}})));
  TRANSFORM.HeatExchangers.Simple_HX AirHX(
    redeclare package Medium_1 =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    redeclare package Medium_2 =
        NHES.Electrolysis.Media.Electrolysis.AnodeGas_air,
    nV=20,
    V_1=0.01,
    V_2=0.01,
    UA=72.75,
    p_a_start_1(displayUnit="kPa") = 103300,
    p_b_start_1(displayUnit="kPa") = 103100,
    T_a_start_1=1063.15,
    T_b_start_1=504.55,
    m_flow_start_1=7.524e-3,
    p_a_start_2(displayUnit="kPa") = 103300,
    p_b_start_2(displayUnit="kPa") = 103200,
    T_a_start_2=293.15,
    T_b_start_2=1053.15,
    m_flow_start_2=5.555e-3) annotation (Placement(transformation(extent={{-8,60},{12,80}})));
  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed2(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.64,0.36}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=1063.15)
    annotation (Placement(transformation(extent={{-124,-24},{-104,-4}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink2(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=423.65,
    nPorts=1)
    annotation (Placement(transformation(extent={{130,-20},{110,0}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn4(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-100,-24},{-80,-4}})));
  Modelica.Blocks.Sources.Constant CathodeFlowControl2(k=6.379/3600) annotation (Placement(transformation(extent={{-160,-16},{-140,4}})));
  Modelica.Fluid.Sources.MassFlowSource_T cathodeFeed3(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=414.15)
    annotation (Placement(transformation(extent={{134,-58},{114,-38}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn5(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{104,-58},{84,-38}})));
  Modelica.Blocks.Sources.Constant CathodeFlowControl3(k=13.47/3600) annotation (Placement(transformation(extent={{172,-50},{152,-30}})));
  Modelica.Fluid.Sources.Boundary_pT cathodeSink3(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103299.8,
    T=981.25,
    nPorts=1)
    annotation (Placement(transformation(extent={{-126,-82},{-106,-62}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                                                       FuelHX1(
    NTU=19.02,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium = Media.Electrolysis.CathodeGas,
    redeclare package Shell_medium = Media.Electrolysis.AnodeGas_air,
    p_start_tube(displayUnit="kPa") = 103800,
    h_start_tube_inlet=4.341e6,
    h_start_tube_outlet=1.65549e6,
    p_start_shell(displayUnit="kPa") = 103800,
    h_start_shell_inlet=831088,
    h_start_shell_outlet=2.09956e6,
    dp_init_tube=10000,
    dp_init_shell=10000,
    Q_init=-4773,
    Cr_init=0.98,
    m_start_tube=cathodeFeed2.m_flow,
    m_start_shell=cathodeFeed3.m_flow)
                               annotation (Placement(transformation(extent={{8,-44},{-12,-24}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeIn_Temp(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-58,-40},{-38,-20}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeOut_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{38,-40},{58,-20}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellIn_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{58,-58},{38,-38}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOut_Temp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{-68,-66},{-88,-46}})));
equation
  connect(cathodeFeed.ports[1],cathodeFlowIn. port_a) annotation (Line(
        points={{-44,176},{-40,176}},     color={0,127,255}));
  connect(cathodeFeed.m_flow_in, CathodeFlowControl.y) annotation (Line(points={{-64,184},{-79,184}},
                                                                                                    color={0,0,127}));
  connect(cathodeFeed1.ports[1], cathodeFlowIn1.port_a) annotation (Line(points={{62,142},{52,142}}, color={0,127,255}));
  connect(cathodeFeed1.m_flow_in, CathodeFlowControl1.y) annotation (Line(points={{82,150},{99,150}},  color={0,0,127}));
  connect(cathodeFlowIn.port_b, FuelHX.port_a1) annotation (Line(points={{-20,176},{-14,176},{-14,160},{-8,160}},
                                                                                                                color={0,127,255}));
  connect(FuelHX.port_b1, cathodeSink.ports[1]) annotation (Line(points={{12,160},{48,160},{48,180},{58,180}},
                                                                                                             color={0,127,255}));
  connect(cathodeFlowIn1.port_b, FuelHX.port_a2) annotation (Line(points={{32,142},{24,142},{24,152},{12,152}},
                                                                                                            color={0,127,255}));
  connect(FuelHX.port_b2, cathodeSink1.ports[1]) annotation (Line(points={{-8,152},{-38,152},{-38,138},{-46,138}},
                                                                                                               color={0,127,255}));
  connect(anodeFeed.ports[1], cathodeFlowIn2.port_a) annotation (Line(points={{-42,90},{-40,90}},   color={0,127,255}));
  connect(anodeFeed.m_flow_in, AnodeFlowControl.y) annotation (Line(points={{-62,98},{-79,98}}, color={0,0,127}));
  connect(anodeFeed2.ports[1], cathodeFlowIn3.port_a) annotation (Line(points={{62,56},{52,56}},   color={0,127,255}));
  connect(anodeFeed2.m_flow_in, AnodeFlowControl2.y) annotation (Line(points={{82,64},{99,64}},   color={0,0,127}));
  connect(cathodeFlowIn2.port_b, AirHX.port_a1) annotation (Line(points={{-20,90},{-14,90},{-14,74},{-8,74}},     color={0,127,255}));
  connect(AirHX.port_b1, anodeSink.ports[1]) annotation (Line(points={{12,74},{48,74},{48,94},{58,94}},   color={0,127,255}));
  connect(cathodeFlowIn3.port_b, AirHX.port_a2) annotation (Line(points={{32,56},{24,56},{24,66},{12,66}},     color={0,127,255}));
  connect(AirHX.port_b2, anodeSink2.ports[1]) annotation (Line(points={{-8,66},{-38,66},{-38,52},{-46,52}},     color={0,127,255}));
  connect(cathodeFeed2.ports[1], cathodeFlowIn4.port_a) annotation (Line(points={{-104,-14},{-100,-14}},
                                                                                                       color={0,127,255}));
  connect(cathodeFeed2.m_flow_in, CathodeFlowControl2.y) annotation (Line(points={{-124,-6},{-139,-6}},
                                                                                                      color={0,0,127}));
  connect(cathodeFeed3.ports[1],cathodeFlowIn5. port_a) annotation (Line(points={{114,-48},{104,-48}},
                                                                                                     color={0,127,255}));
  connect(cathodeFeed3.m_flow_in,CathodeFlowControl3. y) annotation (Line(points={{134,-40},{151,-40}},color={0,0,127}));
  connect(cathodeFlowIn4.port_b, TubeIn_Temp.port_a) annotation (Line(points={{-80,-14},{-74,-14},{-74,-30},{-58,-30}}, color={0,127,255}));
  connect(TubeIn_Temp.port_b, FuelHX1.Tube_in) annotation (Line(points={{-38,-30},{-12,-30}}, color={0,127,255}));
  connect(FuelHX1.Tube_out, TubeOut_Temp.port_a) annotation (Line(points={{8,-30},{38,-30}}, color={0,127,255}));
  connect(TubeOut_Temp.port_b, cathodeSink2.ports[1]) annotation (Line(points={{58,-30},{100,-30},{100,-10},{110,-10}}, color={0,127,255}));
  connect(cathodeFlowIn5.port_b, ShellIn_Temp.port_a) annotation (Line(points={{84,-48},{58,-48}}, color={0,127,255}));
  connect(ShellIn_Temp.port_b, FuelHX1.Shell_in) annotation (Line(points={{38,-48},{14,-48},{14,-36},{8,-36}}, color={0,127,255}));
  connect(FuelHX1.Shell_out, ShellOut_Temp.port_a) annotation (Line(points={{-12,-36},{-40,-36},{-40,-56},{-68,-56}}, color={0,127,255}));
  connect(ShellOut_Temp.port_b, cathodeSink3.ports[1]) annotation (Line(points={{-88,-56},{-96,-56},{-96,-72},{-106,-72}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}})),
            experiment(StopTime=1e6),
  Documentation(info="<html>
  <p>HX analysis to model recuperative heat exchangers for the HTSE setup. Simple HXs are causing an issue with the volume, therefore need to look into the single_phase NTU HX. Use the NTU_new model as it has some unnecessary equations removed. For now, the NTU HX is very slow. Need to figure out how to speed it up.</p>   
 </html>"));
end HXModeling_v2;
