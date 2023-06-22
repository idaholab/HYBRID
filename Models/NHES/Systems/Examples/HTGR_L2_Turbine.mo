within NHES.Systems.Examples;
model HTGR_L2_Turbine
  "High Fidelity Natural Circulation Model based on NuScale reactor. Hot channel calcs, pressurizer, and beginning of cycle reactivity feedback"
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
 parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
 parameter SI.Time timeScale=60*60 "Time scale of first table column";
 parameter String fileName=Modelica.Utilities.Files.loadResource(
    "modelica://NHES/Resources/Data/RAVEN/DMM_Dissertation_Demand.txt")
  "File where matrix is stored";
 Real demandChange=
 min(1.05,
 max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
     + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
     0.5));
 Real Efficiency = (BOP.generator1.Q_mech/hTGR_PebbleBed_Primary_Loop_TESUC.core.Q_total.y)*100;

  BalanceOfPlant.RankineCycle.Models.HTGR_RankineCycles.SteamTurbine_L2_ClosedFeedHeat_HTGR
    BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.RankineCycle.Data.Turbine_2 data(
      p_in_nominal=14000000,
      V_condensor=20000,
      R_bypass=1000,
      R_entry=1,
      R_feedwater=1000,
      valve_TCV_mflow=50,
      valve_TCV_dp_nominal=100000,
      valve_LPT_Bypass_mflow=16,
      valve_LPT_Bypass_dp_nominal=10000,
      valve_TBV_mflow=200,
      valve_TBV_dp_nominal=1500000,
      InternalBypassValve_mflow_small=1e-2,
      InternalBypassValve_p_spring=16000000,
      InternalBypassValve_K(unit="1/(m.kg)") = 1500,
      InternalBypassValve_tau(unit="1/s") = 300,
      HPT_p_exit_nominal=2500000,
      HPT_T_in_nominal=813.15,
      HPT_nominal_mflow=44,
      HPT_efficiency=1,
      LPT_p_in_nominal=1400000,
      LPT_T_in_nominal=753.15,
      LPT_nominal_mflow=28,
      LPT_efficiency=1,
      firstfeedpump_p_nominal=3500000,
      secondfeedpump_p_nominal=1000000,
      controlledfeedpump_mflow_nominal=50,
      MainFeedHeater_NTU=20,
      MainFeedHeater_K_tube(unit="1/m4"),
      MainFeedHeater_K_shell(unit="1/m4") = 500,
      BypassFeedHeater_K_tube(unit="1/m4"),
      BypassFeedHeater_K_shell(unit="1/m4")),
    port_a_nominal(
      p=EM.port_b2_nominal.p,
      h=EM.port_b2_nominal.h,
      m_flow=-EM.port_b2_nominal.m_flow),
    port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
    redeclare
      NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp_HTGR
      CS(electric_demand_int=SC.demand_BOP.y[1], data(
        p_steam=14000000,
        Q_Nom=40e6,
        T_Feedwater=481.15,
        p_steam_vent=16000000)),
    init(
      tee_p_start=2500000,
      moisturesep_p_start=2400000,
      FeedwaterMixVolume_p_start=1000000,
      header_p_start=14000000,
      FeedwaterMixVolume_h_start=3e6,
      moisturesep_T_start=573.15,
      HPT_p_a_start=14000000,
      HPT_p_b_start=2500000,
      HPT_T_a_start=673.15,
      LPT_p_a_start=2500000,
      MainFeedHeater_p_start_tube=1000000,
      MainFeedHeater_p_start_shell=1000000,
      MainFeedHeater_h_start_tube_inlet=1.7e5,
      MainFeedHeater_h_start_tube_outlet=6e5,
      MainFeedHeater_h_start_shell_outlet=1e6,
      MainFeedHeater_dp_init_tube=100000,
      MainFeedHeater_m_start_shell=10,
      BypassFeedHeater_p_start_tube=5500000,
      BypassFeedHeater_p_start_shell=100000))
    annotation (Placement(transformation(extent={{44,-20},{84,20}})));
  SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
    annotation (Placement(transformation(extent={{100,-22},{140,22}})));
  ElectricalGrid.InfiniteGrid.Infinite EG
    annotation (Placement(transformation(extent={{160,-20},{200,20}})));
  BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
      53303300, BOP_capacity(displayUnit="MW") = 60000000)
    annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
  Modelica.Blocks.Sources.Constant delayStart(k=10000)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
    W_nominal_BOP(displayUnit="MW") = 60000000,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://NHES/Resources/Data/RAVEN/Uprate_timeSeries.txt"))
    annotation (Placement(transformation(extent={{158,60},{198,100}})));
  EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
      p=14000000,
      h=3e6,
      m_flow=50), port_b1_nominal(p=14100000, h=2e6))
    annotation (Placement(transformation(extent={{-34,-18},{6,22}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-80,28},{-34,58}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-52,2},{-38,20}})));
  Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,0},{24,18}})));
  Fluid.Sensors.stateDisplay stateDisplay2
    annotation (Placement(transformation(extent={{-4,26},{42,56}})));
  Fluid.Sensors.stateSensor stateSensor3(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-44,-14},{-58,2}})));
  PrimaryHeatSystem.HTGR.RankineCycle.Models.PebbleBed_PrimaryLoop_STHX
    hTGR_PebbleBed_Primary_Loop_TESUC(redeclare
      PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems.CS_Rankine_Primary_SS_ClosedFeedheat
      CS(data(P_Steam_Ref=14000000)))
    annotation (Placement(transformation(extent={{-106,-20},{-62,22}})));
  Fluid.Sensors.stateDisplay stateDisplay3
    annotation (Placement(transformation(extent={{-120,-54},{-76,-22}})));
equation
    hTGR_PebbleBed_Primary_Loop_TESUC.input_steam_pressure =
    BOP.sensor_p.p;
  connect(BOP.portElec_b, SY.port_a[1])
    annotation (Line(points={{84,0},{100,0}}, color={255,0,0}));
  connect(SY.port_Grid, EG.portElec_a)
    annotation (Line(points={{140,0},{160,0}}, color={255,0,0}));
  connect(stateSensor1.port_b, EM.port_a1) annotation (Line(points={{-38,11},{-38,
          10},{-34,10}},                            color={0,127,255}));
  connect(stateSensor1.statePort,stateDisplay1. statePort) annotation (Line(
        points={{-44.965,11.045},{-50,11.045},{-50,14},{-48,14},{-48,24},{-57,24},
          {-57,39.1}}, color={0,0,0}));
  connect(EM.port_b2, stateSensor2.port_a) annotation (Line(points={{6,10},{4,10},
          {4,12},{6,12},{6,9},{10,9}}, color={0,127,255}));
  connect(stateSensor3.port_a, EM.port_b1)
    annotation (Line(points={{-44,-6},{-34,-6}}, color={0,127,255}));
  connect(stateDisplay3.statePort,stateSensor3. statePort) annotation (Line(
        points={{-98,-42.16},{-98,-58},{-50,-58},{-50,-10},{-51.035,-10},{-51.035,
          -5.96}}, color={0,0,0}));
  connect(hTGR_PebbleBed_Primary_Loop_TESUC.port_b,stateSensor1. port_a)
    annotation (Line(points={{-62.66,11.29},{-52,11}}, color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop_TESUC.port_a,stateSensor3. port_b)
    annotation (Line(points={{-62.66,-5.93},{-62.66,-6},{-58,-6}}, color={0,127,
          255}));
  connect(EM.port_a2, BOP.port_b) annotation (Line(points={{6,-6},{36,-6},{36,-8},
          {44,-8}}, color={0,127,255}));
  connect(stateSensor2.port_b, BOP.port_a)
    annotation (Line(points={{24,9},{24,8},{44,8}}, color={0,127,255}));
  connect(stateSensor2.statePort, stateDisplay2.statePort) annotation (Line(
        points={{17.035,9.045},{17.035,23.5225},{19,23.5225},{19,37.1}}, color={
          0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{220,100}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-38,-104},{162,96}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{26,52},{126,-8},{26,-68},{26,52}})}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{220,100}})),
    experiment(
      StopTime=1000000,
      Interval=3.5,
      __Dymola_Algorithm="Esdirk45a"));
end HTGR_L2_Turbine;
