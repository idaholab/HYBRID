within NHES.Systems.PrimaryHeatSystem.SFR.Examples;
model SFR_Example3TSBOP
  package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT;
  package IL_Medium = NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt;

  Components.SFR_Intermediate_Loop sFR_Intermediate_Loop(redeclare package
      Medium_IHX_Loop = IL_Medium,
    SG(
      p_start_tube=12500000,
      use_T_start_tube=true,
      T_start_tube_inlet=483.15,
      T_start_tube_outlet=648.15,
      dp_init_tube=100000,
      Q_init(displayUnit="MW"),
      m_start_tube=50),
    port_SG_a)
    annotation (Placement(transformation(extent={{-18,-24},{66,42}})));
  Components.SFR_02_NTUHX sFR_02_NTUHX(redeclare replaceable CS_01 CS(
        rho_CR_Init=-1.0),             redeclare package Medium_IHX_Loop =
        IL_Medium)
    annotation (Placement(transformation(extent={{-140,-24},{-60,42}})));
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
    annotation (Placement(transformation(extent={{146,-28},{226,52}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=280000,
    nPorts=1)
    annotation (Placement(transformation(extent={{88,-68},{108,-48}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{88,72},{108,92}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{268,2},{248,22}})));
equation
  connect(sFR_02_NTUHX.port_a, sFR_Intermediate_Loop.port_IHX_b) annotation (
      Line(points={{-61.2,-3.21},{-38,-3.21},{-38,-2},{-28,-2},{-28,-2.55},{
          -16.74,-2.55}},                                          color={0,127,
          255}));
  connect(sFR_02_NTUHX.port_b, sFR_Intermediate_Loop.port_IHX_a) annotation (
      Line(points={{-61.2,23.85},{-42,23.85},{-42,24},{-30,24},{-30,23.85},{
          -16.74,23.85}},                                          color={0,127,
          255}));
  connect(bypassdump.ports[1],BOP. port_b_bypass)
    annotation (Line(points={{108,-58},{136,-58},{136,12},{146,12}},
                                             color={0,127,255}));
  connect(steamdump.ports[1],BOP. prt_b_steamdump)
    annotation (Line(points={{108,82},{138,82},{138,52},{146,52}},
                                               color={0,127,255}));
  connect(boundary.port,BOP. port_a_elec)
    annotation (Line(points={{248,12},{226,12}},
                                               color={255,0,0}));
  connect(sFR_Intermediate_Loop.port_SG_b, BOP.port_a_steam_in) annotation (
      Line(points={{64.74,23.85},{136,23.85},{136,36},{146,36}}, color={0,127,
          255}));
  connect(BOP.port_b_liquid_return, sFR_Intermediate_Loop.port_SG_a)
    annotation (Line(points={{146,-12},{72,-12},{72,-3.21},{64.74,-3.21}},
        color={0,127,255}));
  annotation (experiment(StopTime=100000, __Dymola_Algorithm="Esdirk45a"));
end SFR_Example3TSBOP;
