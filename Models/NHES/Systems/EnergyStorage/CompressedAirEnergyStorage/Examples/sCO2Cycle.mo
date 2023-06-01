within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Examples;
model sCO2Cycle
  package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=8e6);
  TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
    p_start=turbine.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
                                                                 redeclare package Medium = Medium,
    Q_gen=600e6)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-68,70})));
  NHES.GasTurbine.Turbine.Turbine turbine(
    redeclare package Medium = Medium,
    pstart_out=8400000,
    Tstart_in=1023.15,
    Tstart_out=908.15,
    eta0=0.9,
    PR0=2.31,
    w0=2867)
            annotation (Placement(transformation(extent={{18,14},{-18,-14}},
        rotation=180,
        origin={-40,60})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
    p_start=Comp2.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.0001),
    redeclare package Medium = Medium,
    Q_gen=-304.8E6)                    annotation (Placement(transformation(extent={{-44,-70},{-64,-50}})));
  NHES.GasTurbine.Compressor.Compressor Comp2(
    redeclare package Medium = Medium,
    pstart_in=8431000,
    Tstart_in=309.15,
    Tstart_out=347.8,
    eta0=0.9,
    PR0=2.39,
    w0=1783) annotation (Placement(transformation(extent={{-56,-42},{-30,-20}})));
  NHES.GasTurbine.Compressor.Compressor Comp1(
    redeclare package Medium = Medium,
    pstart_in=8431000,
    Tstart_in=372.25,
    Tstart_out=458.15,
    eta0=0.9,
    PR0=2.384,
    w0=1084) annotation (Placement(transformation(extent={{54,-82},{82,-58}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Combine(redeclare package Medium = Medium)
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={77,5})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal Split(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-2,-67},{12,-53}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume2( redeclare package Medium = Medium,
    p_start=HighTempRecuperator.Shell.p_start,                                     redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.0001))
                                                                                   annotation (Placement(transformation(extent={{50,16},
            {34,32}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_DMM HighTempRecuperator(
    NTU=10.6,
    redeclare package Tube_medium = Medium,
    redeclare package Shell_medium = Medium,
    K_tube=0.1,
    K_shell=0.1,
    V_Tube=0.193,
    V_Shell=2.272,
    p_start_tube=8471000,
    h_start_tube_inlet=1147600,
    h_start_tube_outlet=643750,
    p_start_shell=20100000,
    h_start_shell_inlet=576280,
    h_start_shell_outlet=1077200,
    dp_init_tube=20000,
    dp_init_shell=20000,
    Q_init=-1438e6,
    Cr_init=0.8506,
    m_start_tube=2867,
    m_start_shell=2867)
    annotation (Placement(transformation(
        extent={{9.5,-9},{-9.5,9}},
        rotation=0,
        origin={-4.5,27})));
  inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{72,72},{92,92}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_DMM LowTempRecuperator(
    NTU=1.255,                                                               redeclare package Tube_medium = Medium,
                                     redeclare package Shell_medium = Medium,
    K_tube=0.1,
    K_shell=0.1,
    V_Tube=0.193,
    V_Shell=2.272,
    p_start_tube=20130000,
    h_start_tube_inlet=361690,
    h_start_tube_outlet=576280,
    h_start_shell_inlet=643750,
    h_start_shell_outlet=515350,
    dp_init_tube=30000,
    dp_init_shell=20000,
    Q_init=-370.1e6,
    Cr_init=0.7114,
    m_start_tube=1783,
    m_start_shell=2867)
    annotation (Placement(transformation(
        extent={{9.5,9},{-9.5,-9}},
        rotation=90,
        origin={32.5,-14})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium = Medium,R=0.3783)
    annotation (Placement(transformation(extent={{26,-70},{46,-50}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium = Medium, R=1 -
        resistance.R)
    annotation (Placement(transformation(extent={{-16,-70},{-36,-50}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume3(redeclare package Medium = Medium,
    p_start=Comp2.pstart_out,                                                     redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.0001))
                                                                                   annotation (Placement(transformation(extent={{-16,-24},
            {0,-8}})));
  Modelica.Fluid.Pipes.StaticPipe      pipe(
    redeclare package Medium = Medium,
    diameter=1,
    crossArea=1,
    length=1,
    p_a_start=20080000,
    p_b_start=20000000,
    m_flow_start=2867)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-82,44})));
  Modelica.Fluid.Pipes.StaticPipe      pipe1(
    redeclare package Medium = Medium,
    diameter=1,
    crossArea=1,
    length=1,
    p_a_start=20080000,
    p_b_start=20000000,
    m_flow_start=1084)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={90,-36})));
equation
  connect(Heater.port_b, turbine.inlet) annotation (Line(points={{-62,70},{-50.8,70},{-50.8,71.2}}, color={0,127,255}));
  connect(HighTempRecuperator.Tube_out, LowTempRecuperator.Shell_in)
    annotation (Line(points={{5,30.6},{16,30.6},{16,4},{30.7,4},{30.7,-4.5}},
                                                                   color={0,127,255}));
  connect(LowTempRecuperator.Shell_out, Split.port_3)
    annotation (Line(points={{30.7,-23.5},{30.7,-48},{5,-48},{5,-53}},
                                                             color={0,127,255}));
  connect(LowTempRecuperator.Tube_out, Combine.port_1)
    annotation (Line(points={{36.1,-4.5},{36.1,5},{70,5}},       color={0,127,255}));
  connect(Split.port_2, resistance.port_a) annotation (Line(points={{12,-60},{29,-60}}, color={0,127,255}));
  connect(resistance.port_b, Comp1.inlet) annotation (Line(points={{43,-60},{59.6,-60},{59.6,-60.4}}, color={0,127,255}));
  connect(Comp2.outlet, volume3.port_a)
    annotation (Line(points={{-35.2,-22.2},{-34,-22.2},{-34,-16},{-12.8,-16}}, color={0,127,255}));
  connect(volume3.port_b, LowTempRecuperator.Tube_in)
    annotation (Line(points={{-3.2,-16},{16,-16},{16,-30},{36.1,-30},{36.1,-23.5}},  color={0,127,255}));
  connect(resistance1.port_a, Split.port_1) annotation (Line(points={{-19,-60},{-2,-60}}, color={0,127,255}));
  connect(resistance1.port_b, Cooler.port_a) annotation (Line(points={{-33,-60},{-48,-60}}, color={0,127,255}));
  connect(Cooler.port_b, Comp2.inlet)
    annotation (Line(points={{-60,-60},{-68,-60},{-68,-16},{-50.8,-16},{-50.8,-22.2}}, color={0,127,255}));
  connect(volume2.port_a, Combine.port_3)
    annotation (Line(points={{46.8,24},{78,24},{78,14},{77,14},{77,12}}, color={0,127,255}));
  connect(volume2.port_b, HighTempRecuperator.Shell_in)
    annotation (Line(points={{37.2,24},{37.2,25.2},{5,25.2}}, color={0,127,255}));
  connect(HighTempRecuperator.Shell_out, pipe.port_a)
    annotation (Line(points={{-14,25.2},{-82,25.2},{-82,34}}, color={0,127,255}));
  connect(pipe.port_b, Heater.port_a) annotation (Line(points={{-82,54},{-82,70},{-74,70}}, color={0,127,255}));
  connect(Comp1.outlet, pipe1.port_a) annotation (Line(points={{76.4,-60.4},{76.4,-50},{90,-50},{90,-46}}, color={0,127,255}));
  connect(pipe1.port_b, Combine.port_2) annotation (Line(points={{90,-26},{90,5},{84,5}}, color={0,127,255}));
  connect(turbine.outlet, HighTempRecuperator.Tube_in) annotation (Line(points={{-29.2,71.2},{-28,71.2},{-28,78},{-16,78},
          {-16,40},{-18,40},{-18,30.6},{-14,30.6}}, color={0,127,255}));
end sCO2Cycle;
