within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model L2_CE_test
  extends Modelica.Icons.Example;
  SteamTurbine_L2_OFWH_CE       BOP(redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L2 CS(redeclare
        NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data(
        HPT_p_in=12000000,
        p_dump=14000000,
        p_i1=500000,
        Tin=813.15,
        Tfeed=473.15,
        d_HPT_in(displayUnit="kg/m3") = 34.69607167,
        d_LPT1_in(displayUnit="kg/m3") = 2.668129353,
        mdot_total=5.7714,
        mdot_fh=1.1529,
        mdot_hpt=4.6185,
        mdot_lpt1=4.6085,
        m_ext=0.01,
        eta_t=0.9,
        eta_mech=0.99,
        eta_p=0.8)), redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data(
      HPT_p_in=12000000,
      p_dump=14000000,
      p_i1=500000,
      Tin=813.15,
      Tfeed=473.15,
      d_HPT_in(displayUnit="kg/m3") = 34.69607167,
      d_LPT1_in(displayUnit="kg/m3") = 2.668129353,
      mdot_total=5.7714,
      mdot_fh=1.1529,
      mdot_hpt=4.6185,
      mdot_lpt1=4.6085,
      m_ext=0.01,
      eta_t=0.9,
      eta_mech=0.99,
      eta_p=0.8))
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12000000,
    T_start=813.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    Q_gen(displayUnit="MW") = 15000000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,0})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=10)
    annotation (Placement(transformation(extent={{-74,14},{-54,34}})));
equation
  connect(boundary.port, BOP.port_a_elec)
    annotation (Line(points={{60,0},{40,0}}, color={255,0,0}));
  connect(BOP.port_b_feed, volume.port_a) annotation (Line(points={{-40,-24},{
          -80,-24},{-80,-6}},           color={0,127,255}));
  connect(volume.port_b, resistance.port_a)
    annotation (Line(points={{-80,6},{-80,24},{-71,24}}, color={0,127,255}));
  connect(resistance.port_b, BOP.port_a_steam)
    annotation (Line(points={{-57,24},{-40,24}}, color={0,127,255}));
  connect(BOP.prt_b_steamdump, BOP.port_a_return) annotation (Line(points={{-40,
          40},{-48,40},{-48,-50},{0,-50},{0,-40}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=20000,
      Interval=20,
      __Dymola_Algorithm="Esdirk45a"));
end L2_CE_test;
