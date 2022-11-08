within NHES.Systems.PrimaryHeatSystem.SFR.Examples;
model SFR_Example_04
  package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT;
  package IL_Medium = NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt;

  Components.SFR_Intermediate_Loop sFR_Intermediate_Loop(redeclare package
      Medium_IHX_Loop = IL_Medium)
    annotation (Placement(transformation(extent={{-120,-20},{-32,50}})));
  Components.SFR_02_NTUHX sFR_02_NTUHX(redeclare replaceable CS_01 CS(
        rho_CR_Init=-0.5),             redeclare package Medium_IHX_Loop =
        IL_Medium)
    annotation (Placement(transformation(extent={{-214,-20},{-130,50}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{108,6},{88,26}})));
  BalanceOfPlant.Turbine.SteamTurbine_L2_ClosedFeedHeat              BOP(
    redeclare
      BalanceOfPlant.Turbine.ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp
      CS(data(
        p_steam=2500000,
        T_Steam_Ref=553.15,
        Q_Nom=45e6,
        T_Feedwater=393.15,
        p_steam_vent=11000000)),
    redeclare replaceable BalanceOfPlant.Turbine.Data.Turbine_2 data(
      p_steam_vent=15000000,
      T_Steam_Ref=543.15,
      Q_Nom=100e3,
      T_Feedwater=398.15,
      p_steam=11300000,
      V_tee=50,
      valve_TCV_mflow=150,
      valve_TCV_dp_nominal=100000,
      valve_TBV_mflow=4,
      valve_TBV_dp_nominal=2000000,
      InternalBypassValve_p_spring=6500000,
      InternalBypassValve_K(unit="1/(m.kg)"),
      InternalBypassValve_tau(unit="1/s"),
      HPT_p_exit_nominal=2500000,
      HPT_T_in_nominal=673.15,
      HPT_nominal_mflow=120,
      firstfeedpump_p_nominal=2000000,
      secondfeedpump_p_nominal=12500000,
      controlledfeedpump_mflow_nominal=120,
      MainFeedHeater_K_tube(unit="1/m4"),
      MainFeedHeater_K_shell(unit="1/m4"),
      BypassFeedHeater_K_tube(unit="1/m4"),
      BypassFeedHeater_K_shell(unit="1/m4")),
    port_a_nominal(
      m_flow=67,
      p=3400000,
      h=3e6),
    port_b_nominal(p=3500000, h=1e6),
    init(
      tee_p_start=800000,
      moisturesep_p_start=700000,
      FeedwaterMixVolume_p_start=100000,
      HPT_T_b_start=578.15,
      MainFeedHeater_p_start_shell=100000,
      MainFeedHeater_h_start_shell_inlet=2e6,
      MainFeedHeater_h_start_shell_outlet=1.8e6,
      MainFeedHeater_dp_init_shell=90000,
      MainFeedHeater_m_start_tube=67,
      MainFeedHeater_m_start_shell=67,
      BypassFeedHeater_h_start_tube_inlet=1.1e6,
      BypassFeedHeater_h_start_tube_outlet=1.2e6,
      BypassFeedHeater_m_start_tube=67,
      BypassFeedHeater_m_start_shell=4))
    annotation (Placement(transformation(extent={{6,-10},{66,50}})));
equation
  connect(sFR_02_NTUHX.port_a, sFR_Intermediate_Loop.port_IHX_b) annotation (
      Line(points={{-131.26,2.05},{-136,2.05},{-136,4},{-126,4},{-126,2.75},{
          -118.68,2.75}},                                          color={0,127,
          255}));
  connect(sFR_02_NTUHX.port_b, sFR_Intermediate_Loop.port_IHX_a) annotation (
      Line(points={{-131.26,30.75},{-140,30.75},{-140,30},{-128,30},{-128,30.75},
          {-118.68,30.75}},                                        color={0,127,
          255}));
  connect(sinkElec.port, BOP.portElec_b) annotation (Line(points={{88,16},{74,
          16},{74,20},{66,20}}, color={255,0,0}));
  connect(BOP.port_a, sFR_Intermediate_Loop.port_SG_b) annotation (Line(points=
          {{6,32},{-10,32},{-10,30.75},{-33.32,30.75}}, color={0,127,255}));
  connect(sFR_Intermediate_Loop.port_SG_a, BOP.port_b) annotation (Line(points=
          {{-33.32,2.05},{-4,2.05},{-4,8},{6,8}}, color={0,127,255}));
  annotation (experiment(StopTime=100000, __Dymola_Algorithm="Esdirk45a"));
end SFR_Example_04;
