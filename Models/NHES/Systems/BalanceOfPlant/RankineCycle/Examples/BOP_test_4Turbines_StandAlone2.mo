within NHES.Systems.BalanceOfPlant.RankineCycle.Examples;
model BOP_test_4Turbines_StandAlone2
  extends Modelica.Icons.Example;
  parameter Real P_ext=138;
  parameter Real P_demand=1;
  parameter Modelica.Units.SI.Density d_ext= 42.55456924 "kg/m3";
  parameter Modelica.Units.SI.MassFlowRate m_ext=0;

  NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_L3_HPOFWHsimplified BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_L3_HTGR_extraction_logan_newDataPackage4Turbines
      CS(redeclare NHES.Systems.BalanceOfPlant.RankineCycle.Data.Data_4Turbines data(
        HPT_p_in=7340000,
        p_dump=20000000,
        p_i1=1155000,
        p_i2=390000,
        Tin=565.15,
        Tfeed=429.85,
        d_HPT_in=37845.1727,
        d_LPT1_in=6969.164714,
        d_LPT2_in=2111.864686,
        mdot_total=1607.044208,
        mdot_fh=368.7799897,
        mdot_hpt=1238.264218,
        mdot_lpt1=1238.264218,
        mdot_lpt2=995.6221656,
        eta_t=0.93,
        eta_mech=1,
        eta_p=0.9)),
    redeclare replaceable NHES.Systems.BalanceOfPlant.RankineCycle.Data.Data_4Turbines data(
      HPT_p_in=7340000,
      p_dump=20000000,
      p_i1=1155000,
      p_i2=390000,
      Tin=565.15,
      Tfeed=429.85,
      d_HPT_in=37845.1727,
      d_LPT1_in=6969.164714,
      d_LPT2_in=2111.864686,
      mdot_total=1607.044208,
      mdot_fh=368.7799897,
      mdot_hpt=1238.264218,
      mdot_lpt1=1238.264218,
      mdot_lpt2=995.6221656,
      eta_t=0.93,
      eta_mech=1,
      eta_p=0.9),
    OFWH_1(T_start=333.15),
    OFWH_2(T_start=353.15),
    LPT1_bypass_valve(dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=10*m_ext),
    moistureSeperator(T_start=413.15))
    annotation (Placement(transformation(extent={{58,-20},{118,40}})));
     // booleanStep2(startTime=100000),
      //Steam_Extraction(y=data.m_ext),
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=7537000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-24,-72},{-4,-52}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{0,74},{20,94}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{194,22},{174,42}})));

  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{170,66},{190,86}})));
  NHES.Electrical.PowerSensor sensorW
    annotation (Placement(transformation(extent={{140,42},{160,22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=2000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-42,-18},{-22,2}})));
  NHES.Systems.BalanceOfPlant.RankineCycle.Data.Data_4Turbines data
    annotation (Placement(transformation(extent={{-98,82},{-78,102}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h
                                                 bypassdump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    use_h_in=false,
    m_flow=1650,
    h=3043e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-54,28},{-34,48}})));
initial equation

equation

  connect(steamdump.ports[1],BOP. prt_b_steamdump)
    annotation (Line(points={{20,84},{52,84},{52,40},{58,40}},
                                               color={0,127,255}));
  connect(BOP.port_a_elec, sensorW.port_a) annotation (Line(points={{118,10},{134,
          10},{134,32},{140,32}},                   color={255,0,0}));
  connect(boundary.port, sensorW.port_b) annotation (Line(points={{174,32},{167,
          32},{167,32.2},{160,32.2}},
                             color={255,0,0}));
  connect(sensorW.W, integrator.u) annotation (Line(points={{150,41.4},{150,76},
          {168,76}},                   color={0,0,127}));
  connect(bypassdump.ports[1], BOP.port_b_feed) annotation (Line(points={{-4,-62},
          {48,-62},{48,-8},{58,-8}}, color={0,127,255}));
  connect(bypassdump2.ports[1], BOP.port_b_bypass) annotation (Line(points={{-22,
          -8},{44,-8},{44,10},{58,10}}, color={0,127,255}));
  connect(bypassdump1.ports[1], BOP.port_a_steam) annotation (Line(points={{-34,
          38},{48,38},{48,28},{58,28}}, color={0,127,255}));
  annotation (experiment(
      StopTime=2,
      __Dymola_NumberOfIntervals=20,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Test of Pebble_Bed_Three-Stage_Rankine. The simulation should experience transient where external electricity demand is oscilating and control valves are opening and closing corresponding to the required power demand. </p>
<p>The ThreeStaged Turbine BOP model contains four control elements: </p>
<p>1. maintaining steam (steam generator outlet) pressure by using TCV</p>
<p>2. controling amount of electricity generated by using LPTBV1</p>
<p>3. maintaining feedwater temperature by using LPTBV2</p>
<p>4. maintaining steam (steam generator outlet) temperature by controlling feedwater pump RPM</p>
</html>"),
    __Dymola_Commands(executeCall=Design.Experimentation.sweepParameter(
          Design.Internal.Records.ModelDependencySetup(
          Model=
            "NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples.Rankine_HTGR_Test_AR",
          dependencyParameters={Design.Internal.Records.DependencyParameter(
            name="hTGR_PebbleBed_Primary_Loop.CS.const11.k", values=linspace(
            1e-05,
            1e-06,
            6))},
          VariablesToPlot={Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.CS.CR.y"),
            Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.core.Q_total.y"),
            Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.core.fuelModel[2].T_Fuel")},
          integrator=Design.Internal.Records.Integrator(
            startTime=0,
            stopTime=1004200,
            numberOfIntervals=0,
            outputInterval=10,
            method="Esdirk45a",
            tolerance=0.0001,
            fixedStepSize=0)))),
    __Dymola_experimentSetupOutput(events=false));
end BOP_test_4Turbines_StandAlone2;
