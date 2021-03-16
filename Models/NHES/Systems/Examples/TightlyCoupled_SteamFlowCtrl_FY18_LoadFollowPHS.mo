within NHES.Systems.Examples;
model TightlyCoupled_SteamFlowCtrl_FY18_LoadFollowPHS

  //Real demandChange = min(1.05, max(SC.sensorBus.subBus_BOP.W_totalSetpoint/SC.W_nominal_BOP, 0.5));
 parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
 parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
 Real demandChange=
 min(1.05,
 max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
     + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
     0.5));
  //Real demandChange = min(1.05, max(EM.port_b2.m_flow/(EM.port_b2_nominal.m_flow+sum(EM.port_b3_nominal_m_flow)) + sum(EM.port_b3.m_flow)/(EM.port_b2_nominal.m_flow+sum(EM.port_b3_nominal_m_flow)),  0.5));

  extends BaseClasses.PartialExample_A(
    redeclare PrimaryHeatSystem.FourLoopPWR.NSSS PHS(redeclare
        PrimaryHeatSystem.FourLoopPWR.CS_LoadFollow CS(
        delayStart_SGpump=500,
        delayStart_CR=200,
        demandChange=demandChange)),
    redeclare EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(
      port_a1_nominal(
        p=PHS.port_b_nominal.p,
        h=PHS.port_b_nominal.h,
        m_flow=-PHS.port_b_nominal.m_flow),
      port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
      nPorts_b3=1,
      port_b3_nominal_m_flow={-IP.port_a_nominal.m_flow}),
    redeclare BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      port_a3_nominal_p={IP.port_b_nominal.p},
      port_a3_nominal_h={IP.port_b_nominal.h},
      nPorts_a3=1,
      port_a3_nominal_m_flow={-IP.port_b_nominal.m_flow},
      redeclare NHES.Systems.BalanceOfPlant.Turbine.CS_PressureAndPowerControl
        CS(p_nominal=BOP.port_a_nominal.p, W_totalSetpoint=SC.W_totalSetpoint_BOP)),
    redeclare EnergyStorage.Battery.Logical ES(
      capacity_max=dataCapacity.ES_capacity,
      capacity_min=0.2*dataCapacity.ES_capacity,
      chargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
          /Modelica.Units.Conversions.from_hour(1),
      dischargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
          /Modelica.Units.Conversions.from_hour(1),
      redeclare NHES.Systems.EnergyStorage.Battery.CS_InputSetpoint CS(
          W_totalSetpoint=SC.W_totalSetpoint_ES)),
    redeclare SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=4),
    redeclare ElectricalGrid.InfiniteGrid.Infinite EG,
    redeclare SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl SES(
        capacity=dataCapacity.SES_capacity, redeclare
        NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
        capacityScaler=SES.capacityScaler,
        delayStart=delayStart.k,
        W_totalSetpoint=SC.W_totalSetpoint_SES)),
    redeclare
      IndustrialProcess.HighTempSteamElectrolysis.TightlyCoupled_SteamFlowCtrl_FY17
      IP(
      capacity=dataCapacity.IP_capacity,
      port_a_nominal(m_flow=IP.capacityScaler_steamFlow*7.311637),
      redeclare
        NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.CS_TightlyCoupled_SteamFlowCtrl_stepInput_FY17
        CS(capacityScaler=IP.capacityScaler),
      flowSplit(port_2(h_outflow(start=2.95398e6, fixed=false))),
      returnPump(PR0=62.7/51.3042, pstart_out=6270000),
      hEX_nuclearHeatCathodeGasRecup_ROM(hShell_out(start=962881, fixed=false))),
    redeclare SupervisoryControl.InputSetpointData SC(
      delayStart=delayStart.k,
      W_nominal_IP(displayUnit="MW") = 53303300,
      W_nominal_BOP=0.35*(1 - fracNominal_Other)*PHS.data.Q_total_th,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/timeSeriesDataFY18.txt")));

  BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
      53303300, BOP_capacity=0.35*(1 - fracNominal_Other)*PHS.data.Q_total_th)
    annotation (Placement(transformation(extent={{-220,160},{-200,180}})));
  Modelica.Blocks.Sources.Constant delayStart(k=7200)
    annotation (Placement(transformation(extent={{-200,160},{-180,180}})));
equation
  connect(PHS.port_b, EM.port_a1) annotation (Line(points={{-142,121.2},{-130,121.2},
          {-130,121.2},{-118,121.2}}, color={0,127,255}));
  connect(PHS.port_a, EM.port_b1) annotation (Line(points={{-142,98.8},{-130,98.8},
          {-130,98.8},{-118,98.8}}, color={0,127,255}));
  connect(EM.port_a2, BOP.port_b) annotation (Line(points={{-62,98.8},{-40,98.8},
          {-40,98.8},{-18,98.8}}, color={0,127,255}));
  connect(EM.port_b2, BOP.port_a) annotation (Line(points={{-62,121.2},{-40,121.2},
          {-40,121.2},{-18,121.2}}, color={0,127,255}));
  connect(IP.port_a, EM.port_b3[1]) annotation (Line(points={{-118,1.2},{-130,1.2},
          {-130,60},{-78.8,60},{-78.8,82}}, color={0,127,255}));
  connect(IP.port_b, BOP.port_a3[1]) annotation (Line(points={{-118,-21.2},{-140,
          -21.2},{-140,74},{-1.2,74},{-1.2,82}}, color={0,127,255}));
  connect(BOP.portElec_b, SY.port_a[1]) annotation (Line(points={{38,110},{50,110},
          {50,30},{82,30}}, color={255,0,0}));
  connect(ES.portElec_b, SY.port_a[2])
    annotation (Line(points={{38,30},{82,30}}, color={255,0,0}));
  connect(SES.portElec_b, SY.port_a[3]) annotation (Line(points={{38,-50},{50,-50},
          {50,30},{82,30}}, color={255,0,0}));
  connect(IP.portElec_a, SY.port_a[4]) annotation (Line(points={{-62,-10},{-50,-10},
          {-50,-90},{50,-90},{50,30},{82,30}}, color={255,0,0}));
  connect(SY.port_Grid, EG.portElec_a)
    annotation (Line(points={{138,30},{162,30}}, color={255,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      __Dymola_NumberOfIntervals=8640,
      __Dymola_Algorithm="Esdirk45a"));
end TightlyCoupled_SteamFlowCtrl_FY18_LoadFollowPHS;
