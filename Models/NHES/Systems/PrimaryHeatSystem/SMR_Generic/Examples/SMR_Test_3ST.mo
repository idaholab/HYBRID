within NHES.Systems.PrimaryHeatSystem.SMR_Generic.Examples;
model SMR_Test_3ST
  extends Modelica.Icons.Example;

  BalanceOfPlant.Turbine.SteamTurbine_L3_HPOFWH BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3_SMR CS(data(
        Power_nom=80e6,
        HPT_p_in=3450000,
        Tin=579.25,
        Tfeed=421.15,
        mdot_total=70,
        mdot_fh=5.7,
        mdpt_HPFH=5,
        mdot_hpt=65,
        mdot_lpt1=65,
        mdot_lpt2=59.5)),
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data(
      Power_nom=80e6,
      HPT_p_in=3450000,
      Tin=579.25,
      Tfeed=421.15,
      d_HPT_in(displayUnit="kg/m3") = 14.156995,
      d_LPT1_in(displayUnit="kg/m3") = 1.7598669,
      mdot_total=70,
      mdot_fh=5.7,
      mdpt_HPFH=5,
      mdot_hpt=65,
      mdot_lpt1=65,
      mdot_lpt2=53.4891209),
    OFWH_1(T_start=333.15),
    OFWH_2(T_start=353.15),
    HPT_bypass_valve(dp_nominal=40000))
    annotation (Placement(transformation(extent={{88,-34},{168,46}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=280000,
    nPorts=1)
    annotation (Placement(transformation(extent={{50,-4},{70,16}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{48,36},{68,56}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{208,-4},{188,16}})));
  Components.SMR_Taveprogram_No_Pump                                           Reactor(
    redeclare CS_SMR_Tave_Enthalpy_RXPower CS,
    port_a_nominal(
      m_flow=70,
      p=3447380,
      T(displayUnit="degC") = 421.15),
    port_b_nominal(
      p=3447380,
      T(displayUnit="degC") = 579.25,
      h=2997670))
    annotation (Placement(transformation(extent={{-102,-52},{-8,58}})));
equation
  connect(bypassdump.ports[1], BOP.port_b_bypass)
    annotation (Line(points={{70,6},{88,6}}, color={0,127,255}));
  connect(steamdump.ports[1], BOP.prt_b_steamdump)
    annotation (Line(points={{68,46},{88,46}}, color={0,127,255}));
  connect(boundary.port, BOP.port_a_elec)
    annotation (Line(points={{188,6},{168,6}}, color={255,0,0}));
  connect(Reactor.port_b, BOP.port_a_steam_in) annotation (Line(points={{
          -6.29091,24.1538},{78,24.1538},{78,30},{88,30}}, color={0,127,255}));
  connect(BOP.port_b_liquid_return, Reactor.port_a) annotation (Line(points={{
          88,-18},{38,-18},{38,-2},{-6.29091,-2},{-6.29091,-3.76923}}, color={0,
          127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
            {100,100}})),
    experiment(
      StopTime=10000,
      Interval=17,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})));
end SMR_Test_3ST;
