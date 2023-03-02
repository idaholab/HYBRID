within NHES.Systems.PrimaryHeatSystem.SFR.Examples;
model SFR_Example3TSBOP
  package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT;
  package IL_Medium = NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt;

  Components.SFR_Intermediate_Loop sFR_Intermediate_Loop(redeclare package
      Medium_IHX_Loop = IL_Medium,
    port_SG_a,
    SG(p_start_tube=12550000),
    pump(m_flow_nominal=325))
    annotation (Placement(transformation(extent={{-18,-24},{66,42}})));
  Components.SFR_02_NTUHX sFR_02_NTUHX(redeclare replaceable CS_01 CS(
        rho_CR_Init=-1.0),             redeclare package Medium_IHX_Loop =
        IL_Medium)
    annotation (Placement(transformation(extent={{-140,-24},{-60,42}})));
  BalanceOfPlant.Turbine.SteamTurbine_L3_HPOFWHsimplified BOP(
    redeclare replaceable BalanceOfPlant.Turbine.ControlSystems.CS_L3_SMR CS(
      data(
        Power_nom=80e6,
        HPT_p_in=12500000,
        p_dump=14500000,
        Tin=637.15,
        Tfeed=483.15,
        d_HPT_in(displayUnit="kg/m3") = 57.49421,
        d_LPT1_in(displayUnit="kg/m3") = 1.999,
        d_LPT2_in(displayUnit="kg/m3"),
        mdot_total=50.14,
        mdot_fh=2.4,
        mdpt_HPFH=10,
        mdot_hpt=37.99,
        mdot_lpt1=37.99,
        mdot_lpt2=30.016,
        eta_t=0.9,
        eta_mech=0.95),
      booleanStep(startTime=10),
      LPT2_BV_PID(k=1e-3, Ti=100),
      ramp(duration=1e3, startTime=4e4),
      FeedPump_PID(k=-1e-3, yMin=15),
      hysteresis(uLow=135)),
    redeclare replaceable BalanceOfPlant.Turbine.Data.Data_L3 data(
      Power_nom=80e6,
      HPT_p_in=12500000,
      p_dump=14500000,
      Tin=637.15,
      Tfeed=483.15,
      d_HPT_in(displayUnit="kg/m3") = 57.49421,
      d_LPT1_in(displayUnit="kg/m3") = 1.999,
      d_LPT2_in(displayUnit="kg/m3"),
      mdot_total=50.14,
      mdot_fh=2.4,
      mdpt_HPFH=10,
      mdot_hpt=37.99,
      mdot_lpt1=37.99,
      mdot_lpt2=30.016,
      eta_t=0.9,
      eta_mech=0.95),
    OFWH_1(T_start=333.15),
    OFWH_2(T_start=353.15))
    annotation (Placement(transformation(extent={{144,-26},{224,54}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=280000,
    nPorts=1)
    annotation (Placement(transformation(extent={{88,-68},{108,-48}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{88,74},{108,94}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{268,2},{248,22}})));
equation
  connect(sFR_02_NTUHX.port_a, sFR_Intermediate_Loop.port_IHX_b) annotation (
      Line(points={{-61.2,-3.21},{-38,-3.21},{-38,-2},{-28,-2},{-28,-2.55},{
          -16.74,-2.55}}, color={0,127,255}));
  connect(sFR_02_NTUHX.port_b, sFR_Intermediate_Loop.port_IHX_a) annotation (
      Line(points={{-61.2,23.85},{-42,23.85},{-42,24},{-30,24},{-30,23.85},{
          -16.74,23.85}}, color={0,127,255}));
  connect(bypassdump.ports[1],BOP. port_b_bypass)
    annotation (Line(points={{108,-58},{136,-58},{136,14},{144,14}},
                                             color={0,127,255}));
  connect(steamdump.ports[1],BOP. prt_b_steamdump)
    annotation (Line(points={{108,84},{138,84},{138,54},{144,54}},
                                               color={0,127,255}));
  connect(boundary.port,BOP. port_a_elec)
    annotation (Line(points={{248,12},{236,12},{236,14},{224,14}},
                                               color={255,0,0}));
  connect(sFR_Intermediate_Loop.port_SG_b, BOP.port_a_steam) annotation (Line(
        points={{64.74,23.85},{136,23.85},{136,38},{144,38}}, color={0,127,255}));
  connect(BOP.port_b_feed, sFR_Intermediate_Loop.port_SG_a) annotation (Line(
        points={{144,-10},{74,-10},{74,-3.21},{64.74,-3.21}}, color={0,127,255}));
  annotation (experiment(
      StopTime=100000,
      Interval=1000,
      __Dymola_Algorithm="Esdirk45a"));
end SFR_Example3TSBOP;
