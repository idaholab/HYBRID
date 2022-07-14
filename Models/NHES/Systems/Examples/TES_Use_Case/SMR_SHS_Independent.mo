within NHES.Systems.Examples.TES_Use_Case;
model SMR_SHS_Independent "Nuscale SMR with two tank independent heat system"
 parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
 parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
 Real demandChange=
 min(1.05,
 max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
     + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
     0.5));
  PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
    nuScale_Tave_enthalpy_Pressurizer_CR(
    port_a_nominal(
      m_flow=90,
      T(displayUnit="degC") = 421.15,
      p=3447380),
    port_b_nominal(
      T(displayUnit="degC") = 579.75,
      h=2997670,
      p=3447380),
    redeclare NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy
      CS(T_SG_exit=579.15, Q_nom=200),
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-92,-24},{-38,34}})));
  EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
      p=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.p,
      h=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.h,
      m_flow=-nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.m_flow),
      port_b1_nominal(p=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.p,
        h=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.h),
    port_b3_nominal_m_flow={-33},
    nPorts_b3=1)
    annotation (Placement(transformation(extent={{-12,-20},{28,20}})));
  BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
    port_a_nominal(
      p=EM.port_b2_nominal.p,
      h=EM.port_b2_nominal.h,
      m_flow=-EM.port_b2_nominal.m_flow),
    port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
      CS(
      delayStartTCV=100,
      p_nominal=3447400,
      W_totalSetpoint=26e6),
    nPorts_a3=1)
    annotation (Placement(transformation(extent={{40,-20},{80,20}})));
  SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)
    annotation (Placement(transformation(extent={{100,-22},{140,22}})));
  ElectricalGrid.InfiniteGrid.Infinite EG
    annotation (Placement(transformation(extent={{160,-20},{200,20}})));
  BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
      53303300, BOP_capacity(displayUnit="MW") = 60000000)
    annotation (Placement(transformation(extent={{-98,82},{-78,102}})));
  Modelica.Blocks.Sources.Constant delayStart(k=100)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
    W_nominal_BOP(displayUnit="MW") = 60000000,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://NHES/Resources/Data/RAVEN/Uprate_timeSeries.txt"))
    annotation (Placement(transformation(extent={{158,60},{198,100}})));
  EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU
    two_Tank_SHS_System_NTU(redeclare replaceable
      NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
      DHX_K_tube(unit="1/m4"),
      DHX_K_shell(unit="1/m4"),
      DHX_p_start_shell=500000), Produced_steam_flow=10)
    annotation (Placement(transformation(extent={{-20,-76},{20,-36}})));
  BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP1(
    port_a_nominal(
      p=EM.port_b2_nominal.p,
      h=EM.port_b2_nominal.h,
      m_flow=-EM.port_b2_nominal.m_flow),
    port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
    redeclare
      BalanceOfPlant.Turbine.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
      CS(
      delayStartTCV=100,
      p_nominal=1200000,
      W_totalSetpoint=192e3),
    nPorts_a3=1)
    annotation (Placement(transformation(extent={{42,-74},{82,-34}})));
equation
  connect(nuScale_Tave_enthalpy_Pressurizer_CR.port_b, EM.port_a1) annotation (
      Line(points={{-37.0182,16.1538},{-30,16.1538},{-30,8},{-12,8}}, color={0,
          127,255}));
  connect(nuScale_Tave_enthalpy_Pressurizer_CR.port_a, EM.port_b1) annotation (
      Line(points={{-37.0182,1.43077},{-30,1.43077},{-30,-8},{-12,-8}},
        color={0,127,255}));
  connect(EM.port_b2, BOP.port_a)
    annotation (Line(points={{28,8},{40,8}}, color={0,127,255}));
  connect(EM.port_a2, BOP.port_b)
    annotation (Line(points={{28,-8},{40,-8}}, color={0,127,255}));
  connect(BOP.portElec_b, SY.port_a[1])
    annotation (Line(points={{80,0},{92,0},{92,-1.1},{100,-1.1}},
                                              color={255,0,0}));
  connect(SY.port_Grid, EG.portElec_a)
    annotation (Line(points={{140,0},{160,0}}, color={255,0,0}));
  connect(BOP1.portElec_b, SY.port_a[2]) annotation (Line(points={{82,-54},{88,
          -54},{88,1.1},{100,1.1}}, color={255,0,0}));
  connect(two_Tank_SHS_System_NTU.port_ch_a, EM.port_b3[1]) annotation (Line(
        points={{-19.6,-68.4},{-32,-68.4},{-32,-26},{16,-26},{16,-20}}, color={
          0,127,255}));
  connect(two_Tank_SHS_System_NTU.port_ch_b, BOP.port_a3[1]) annotation (Line(
        points={{-19.6,-45.2},{-24,-45.2},{-24,-28},{52,-28},{52,-20}}, color={
          0,127,255}));
  connect(two_Tank_SHS_System_NTU.port_dch_a, BOP1.port_b) annotation (Line(
        points={{19.6,-44.4},{26,-44.4},{26,-62},{42,-62}}, color={0,127,255}));
  connect(two_Tank_SHS_System_NTU.port_dch_b, BOP1.port_a) annotation (Line(
        points={{20,-68.4},{28,-68.4},{28,-66},{36,-66},{36,-46},{42,-46}},
        color={0,127,255}));
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
      StopTime=18000,
      Interval=1,
      __Dymola_Algorithm="Esdirk45a"));
end SMR_SHS_Independent;
