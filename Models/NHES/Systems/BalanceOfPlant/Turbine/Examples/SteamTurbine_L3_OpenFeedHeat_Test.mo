within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model SteamTurbine_L3_OpenFeedHeat_Test
  extends Modelica.Icons.Example;
  SteamTurbine_L3_HPOFWH                        BOP(
    redeclare replaceable ControlSystems.CS_L3_HTGR CS(data(
        HPT_p_in=14000000,
        p_dump=16000000,
        Tin=788.15,
        Tfeed=481.15,
        d_HPT_in(displayUnit="kg/m3") = 43.049187,
        d_LPT1_in(displayUnit="kg/m3") = 1.783316,
        d_LPT2_in(displayUnit="kg/m3"),
        mdot_total=50.55,
        mdot_fh=10.6,
        mdot_hpt=39.945,
        mdot_lpt1=39.945,
        mdot_lpt2=35.7553,
        eta_t=0.9,
        eta_mech=0.95), Power_set(y=1e10)),
    redeclare replaceable Data.Data_L3 data(
      HPT_p_in=14000000,
      p_dump=16000000,
      Tin=788.15,
      Tfeed=481.15,
      d_HPT_in(displayUnit="kg/m3") = 43.049187,
      d_LPT1_in(displayUnit="kg/m3") = 1.783316,
      d_LPT2_in(displayUnit="kg/m3"),
      mdot_total=50.55,
      mdot_fh=10.6,
      mdot_hpt=39.945,
      mdot_lpt1=39.945,
      mdot_lpt2=35.7553,
      eta_t=0.9,
      eta_mech=0.95),
    OFWH_1(T_start=333.15),
    OFWH_2(T_start=353.15))
    annotation (Placement(transformation(extent={{32,-34},{112,46}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=280000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-26,-74},{-6,-54}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-26,66},{-6,86}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{154,-4},{134,16}})));
  Data.Data_L3                        data(
    HPT_p_in=14000000,
    p_dump=16000000,
    Tin=788.15,
    Tfeed=481.15,
    d_HPT_in(displayUnit="kg/m3") = 43.049187,
    d_LPT1_in(displayUnit="kg/m3") = 1.783316,
    d_LPT2_in(displayUnit="kg/m3"),
    mdot_total=50.55,
    mdot_fh=10.6,
    mdot_hpt=39.945,
    mdot_lpt1=39.945,
    mdot_lpt2=35.7553,
    eta_t=0.9,
    eta_mech=0.95)
    annotation (Placement(transformation(extent={{-126,72},{-106,92}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=50.55,
    T=788.15,
    nPorts=1) annotation (Placement(transformation(extent={{-96,18},{-76,38}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=13950000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-98,-28},{-78,-8}})));
equation
  connect(bypassdump.ports[1],BOP. port_b_bypass)
    annotation (Line(points={{-6,-64},{22,-64},{22,6},{32,6}},
                                             color={0,127,255}));
  connect(steamdump.ports[1],BOP. prt_b_steamdump)
    annotation (Line(points={{-6,76},{24,76},{24,46},{32,46}},
                                               color={0,127,255}));
  connect(boundary.port,BOP. port_a_elec)
    annotation (Line(points={{134,6},{112,6}}, color={255,0,0}));
  connect(boundary2.ports[1], BOP.port_b_feed)
    annotation (Line(points={{-78,-18},{32,-18}}, color={0,127,255}));
  connect(boundary1.ports[1], BOP.port_a_steam) annotation (Line(points={{-76,
          28},{24,28},{24,30},{32,30}}, color={0,127,255}));
  annotation (experiment(
      StopTime=100000,
      Interval=100,
      __Dymola_Algorithm="Dassl"));
end SteamTurbine_L3_OpenFeedHeat_Test;
