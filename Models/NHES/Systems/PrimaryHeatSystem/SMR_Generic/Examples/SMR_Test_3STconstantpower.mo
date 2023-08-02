within NHES.Systems.PrimaryHeatSystem.SMR_Generic.Examples;
model SMR_Test_3STconstantpower
  extends Modelica.Icons.Example;

  BalanceOfPlant.Turbine.SteamTurbine_L3_HPOFWH BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3_SMR CS(data(
        HPT_p_in=3450000,
        Tin=579.25,
        Tfeed=421.15,
        mdot_total=70,
        mdot_fh=5.7,
        mdot_hpt=65,
        mdot_lpt1=65,
        mdot_lpt2=59.5)),
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data(
      HPT_p_in=3450000,
      Tin=579.25,
      Tfeed=421.15,
      d_HPT_in(displayUnit="kg/m3") = 14.156995,
      d_LPT1_in(displayUnit="kg/m3") = 1.7598669,
      mdot_total=70,
      mdot_fh=5.7,
      mdot_hpt=65,
      mdot_lpt1=65,
      mdot_lpt2=53.4891209),
    OFWH_1(T_start=333.15),
    OFWH_2(T_start=353.15),
    HPT_bypass_valve(dp_nominal=40000))
    annotation (Placement(transformation(extent={{20,-20},{100,60}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=280000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{140,10},{120,30}})));
  Components.SMR_High_fidelity_no_pump
    nuScale_Tave_enthalpy_Pressurizer_CR(
    port_a_nominal(
      m_flow=90,
      T(displayUnit="degC") = 421.15,
      p=3447380),
    port_b_nominal(
      T(displayUnit="degC") = 579.75,
      h=2997670,
      p=3447380),
    redeclare CS_SMR_highfidelity CS(
      SG_exit_enthalpy=3e6,
      m_setpoint=90.0,
      Q_nom(displayUnit="MW") = 200000000,
      demand=1.0,
      PID_CR(Ti=15)),
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-124,-28},{-20,84}})));
equation
  connect(bypassdump.ports[1], BOP.port_b_bypass)
    annotation (Line(points={{-20,-50},{0,-50},{0,20},{20,20}},
                                             color={0,127,255}));
  connect(steamdump.ports[1], BOP.prt_b_steamdump)
    annotation (Line(points={{-20,90},{0,90},{0,60},{20,60}},
                                               color={0,127,255}));
  connect(boundary.port, BOP.port_a_elec)
    annotation (Line(points={{120,20},{100,20}},
                                               color={255,0,0}));
  connect(nuScale_Tave_enthalpy_Pressurizer_CR.port_b, BOP.port_a_steam)
    annotation (Line(points={{-18.4,44},{20,44}}, color={0,127,255}));
  connect(BOP.port_b_feed, nuScale_Tave_enthalpy_Pressurizer_CR.port_a)
    annotation (Line(points={{20,-4},{-10,-4},{-10,17.6},{-18.4,17.6}}, color={
          0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
            {100,100}})),
    experiment(
      StopTime=10000,
      Interval=20,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})));
end SMR_Test_3STconstantpower;
