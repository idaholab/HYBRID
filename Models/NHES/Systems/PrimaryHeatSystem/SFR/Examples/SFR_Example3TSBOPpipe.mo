within NHES.Systems.PrimaryHeatSystem.SFR.Examples;
model SFR_Example3TSBOPpipe
  package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT;
  package IL_Medium = NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt;

  BalanceOfPlant.Turbine.SteamTurbine_L3_HPOFWH BOP(
    redeclare replaceable BalanceOfPlant.Turbine.ControlSystems.CS_L3_SMR CS(
        data(
        Power_nom=80e6,
        HPT_p_in=12500000,
        p_dump=14500000,
        Tin=637.15,
        Tfeed=483.15,
        d_HPT_in(displayUnit="kg/m3") = 57.49421,
        d_LPT1_in(displayUnit="kg/m3") = 2.036,
        d_LPT2_in(displayUnit="kg/m3"),
        mdot_total=50.14,
        mdot_fh=12.15,
        mdot_hpt=37.99,
        mdot_lpt1=37.99,
        mdot_lpt2=30.016,
        eta_t=0.9,
        eta_mech=0.95)),
    redeclare replaceable BalanceOfPlant.Turbine.Data.Data_L3 data(
      Power_nom=80e6,
      HPT_p_in=12500000,
      p_dump=14500000,
      Tin=637.15,
      Tfeed=483.15,
      d_HPT_in(displayUnit="kg/m3") = 57.49421,
      d_LPT1_in(displayUnit="kg/m3") = 2.036,
      d_LPT2_in(displayUnit="kg/m3"),
      mdot_total=50.14,
      mdot_fh=12.15,
      mdot_hpt=37.99,
      mdot_lpt1=37.99,
      mdot_lpt2=30.016,
      eta_t=0.9,
      eta_mech=0.95),
    OFWH_1(T_start=333.15),
    OFWH_2(T_start=353.15))
    annotation (Placement(transformation(extent={{172,-34},{252,46}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=280000,
    nPorts=1)
    annotation (Placement(transformation(extent={{114,-74},{134,-54}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{114,66},{134,86}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{294,-4},{274,16}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=14600000,
    T_start=648.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    Q_gen=100e6) annotation (Placement(transformation(extent={{40,2},{60,22}})));
  Components.SFR_Intermediate_Loop sFR_Intermediate_Loop(redeclare package
      Medium_IHX_Loop = IL_Medium, SG(
      p_start_tube=12600000,
      use_T_start_tube=true,
      T_start_tube_inlet=483.15,
      T_start_tube_outlet=648.15,
      dp_init_tube=100000,
      m_start_tube=200.54))
    annotation (Placement(transformation(extent={{-258,-20},{-174,46}})));
  BalanceOfPlant.Turbine.SteamTurbine_L3_HPOFWH BOP1(redeclare replaceable
      BalanceOfPlant.Turbine.ControlSystems.CS_L3_SMR CS(data(
        Power_nom=200e6,
        HPT_p_in=12500000,
        p_dump=14500000,
        Tin=637.15,
        Tfeed=483.15,
        d_HPT_in(displayUnit="kg/m3") = 57.49421,
        d_LPT1_in(displayUnit="kg/m3") = 2.036,
        d_LPT2_in(displayUnit="kg/m3"),
        mdot_total=200.54,
        mdot_fh=48.6,
        mdot_hpt=151.94,
        mdot_lpt1=151.94,
        mdot_lpt2=120.05,
        eta_t=0.9,
        eta_mech=0.95), T_in_set1(y=200)), redeclare replaceable
      BalanceOfPlant.Turbine.Data.Data_L3 data(
      Power_nom=200e6,
      HPT_p_in=12500000,
      p_dump=14500000,
      Tin=637.15,
      Tfeed=483.15,
      d_HPT_in(displayUnit="kg/m3") = 57.49421,
      d_LPT1_in(displayUnit="kg/m3") = 2.036,
      d_LPT2_in(displayUnit="kg/m3"),
      mdot_total=200.54,
      mdot_fh=48.6,
      mdot_hpt=151.94,
      mdot_lpt1=151.94,
      mdot_lpt2=120.05,
      eta_t=0.9,
      eta_mech=0.95))
    annotation (Placement(transformation(extent={{-118,-36},{-38,44}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=280000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-182,-56},{-162,-36}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-176,64},{-156,84}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary1
    annotation (Placement(transformation(extent={{4,-6},{-16,14}})));
equation
  connect(bypassdump.ports[1],BOP. port_b_bypass)
    annotation (Line(points={{134,-64},{164,-64},{164,6},{172,6}},
                                             color={0,127,255}));
  connect(steamdump.ports[1],BOP. prt_b_steamdump)
    annotation (Line(points={{134,76},{166,76},{166,46},{172,46}},
                                               color={0,127,255}));
  connect(boundary.port,BOP. port_a_elec)
    annotation (Line(points={{274,6},{252,6}}, color={255,0,0}));
  connect(volume.port_b, BOP.port_a_steam_in) annotation (Line(points={{56,12},
          {164,12},{164,30},{172,30}}, color={0,127,255}));
  connect(BOP.port_b_liquid_return, volume.port_a) annotation (Line(points={{
          172,-18},{34,-18},{34,12},{44,12}}, color={0,127,255}));
  connect(bypassdump1.ports[1], BOP1.port_b_bypass) annotation (Line(points={{
          -162,-46},{-128,-46},{-128,4},{-118,4}}, color={0,127,255}));
  connect(steamdump1.ports[1], BOP1.prt_b_steamdump) annotation (Line(points={{
          -156,74},{-126,74},{-126,44},{-118,44}}, color={0,127,255}));
  connect(boundary1.port, BOP1.port_a_elec)
    annotation (Line(points={{-16,4},{-38,4}}, color={255,0,0}));
  connect(BOP1.port_a_steam_in, sFR_Intermediate_Loop.port_SG_b) annotation (
      Line(points={{-118,28},{-146.63,28},{-146.63,27.85},{-175.26,27.85}},
        color={0,127,255}));
  connect(sFR_Intermediate_Loop.port_SG_a, BOP1.port_b_liquid_return)
    annotation (Line(points={{-175.26,0.79},{-128,0.79},{-128,-20},{-118,-20}},
        color={0,127,255}));
  annotation (experiment(
      StopTime=100000,
      __Dymola_NumberOfIntervals=20,
      __Dymola_Algorithm="Esdirk45a"));
end SFR_Example3TSBOPpipe;
