within NHES.Systems.Examples.IntegratedEnergySystem;
model TightlyCoupled_SteamFlowCtrl_FY18_TES_V2_EVM
  "Convert HTSE to PEM and NG to Storage Tank"

 parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
 parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;

  extends BaseClasses.PartialExample_A(
    redeclare PrimaryHeatSystem.FourLoopPWR.Components.NSSS PHS(redeclare
        NHES.Systems.PrimaryHeatSystem.FourLoopPWR.CS_SteadyNominalPower CS(
          delayStart_SGpump=500, delayStart_CR=200)),
    redeclare EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(
      port_a1_nominal(
        p=PHS.port_b_nominal.p,
        h=PHS.port_b_nominal.h,
        m_flow=-PHS.port_b_nominal.m_flow),
      port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
      nPorts_b3=2,
      port_b3_nominal_m_flow={-IP.port_a_nominal.m_flow,-ES.port_a_nominal.m_flow}),
    redeclare BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries
      BOP(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      nPorts_a3=2,
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_PressureAndPowerControl
        CS(p_nominal=BOP.port_a_nominal.p, W_totalSetpoint=SC.W_totalSetpoint_BOP),
      port_a3_nominal_m_flow={-IP.port_b_nominal.m_flow,-ES.port_b_nominal.m_flow},
      port_a3_nominal_p={IP.port_b_nominal.p,ES.port_b_nominal.p},
      port_a3_nominal_h={IP.port_b_nominal.h,ES.port_b_nominal.h}),
    redeclare
      EnergyStorage.SensibleHeatStorage.Models.TwentyPercentNominal3400MWtPWR
      ES(redeclare
        EnergyStorage.SensibleHeatStorage.ControlSystems.CS_TextRead CS(
          W_totalSetpoint=SC.W_totalSetpoint_ES)),
    redeclare SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=4),
    redeclare ElectricalGrid.InfiniteGrid.Infinite EG,
      redeclare IndustrialProcess.HighTempSteamElectrolysis.Models.PEMElectrolyzer_Coupling_V1_EVM
                                                                                        IP(
        capacity=dataCapacity.IP_capacity,
        port_a_nominal(m_flow=IP.capacityScaler_feed*7.311637),
      redeclare
        NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.ControlSystems.CS_Dummy
        CS),
           redeclare SupervisoryControl.InputSetpointData SC(
      W_nominal_IP(displayUnit="MW") = 53303300,
      delayStart=delayStart.k,
      W_nominal_BOP=0.35*(1 - fracNominal_Other)*(PHS.data.Q_total_th)));
    //redeclare SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl SES(
    //    capacity=dataCapacity.SES_capacity, redeclare
    //    NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
    //    capacityScaler=SES.capacityScaler,
    //    delayStart=delayStart.k,
    //    W_totalSetpoint=SC.W_totalSetpoint_SES)),

    // Remove natural gas SES, replaced below by H2 tank (do NOT redeclare SES here)                                                        // keep same pattern; replace later if you have a PEM-specific CS
    //redeclare
    //  IndustrialProcess.HighTempSteamElectrolysis.Models.TightlyCoupled_SteamFlowCtrl_FY17
    //  IP(
    //  capacity=dataCapacity.IP_capacity,
    //  port_a_nominal(m_flow=IP.capacityScaler_steamFlow*7.311637),

    // Keep dataCapacity and delayStart as in original FY18_TES (Page 1, Section 4/4)
    BaseClasses.Data_Capacity dataCapacity(
      IP_capacity(displayUnit="MW")=53303300,
      BOP_capacity=0.35*(1 - fracNominal_Other)*PHS.data.Q_total_th)
      annotation (Placement(transformation(extent={{-220,160},{-200,180}})));

      Modelica.Blocks.Sources.Constant delayStart(k=1800)
      annotation (Placement(transformation(extent={{-202,160},{-182,180}})));

    // NEW: Hydrogen storage tank to replace SES
    //NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Models.H2StorageTankforCoupling
    NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Models.H2StorageTankforCoupling H2Tank(m_init=0, m_max=5e5)
    annotation (Placement(transformation(extent={{40,-120},{80,-80}})));

    // Tank discharge placeholder (no export requested): set outflow to 0 by default
    Modelica.Blocks.Sources.Constant tankOutflow(k=0)
    annotation (Placement(transformation(extent={{0,-128},{20,-108}})));

   // redeclare
   //   NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Models.TightlyCoupled_SteamFlowCtrl_FY17
   //   IP(
   //   capacity=dataCapacity.IP_capacity,
   //   port_a_nominal(m_flow=IP.capacityScaler_steamFlow*7.311637),
   //   redeclare
   //     NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.ControlSystems.CS_TightlyCoupled_SteamFlowCtrl_stepInput_FY17
   //     CS(capacityScaler=IP.capacityScaler),
   //   flowSplit(port_2(h_outflow(start=2.95398e6, fixed=false))),
   //   returnPump(PR0=62.7/51.3042, pstart_out=6270000),
   //   hEX_nuclearHeatCathodeGasRecup_ROM(hShell_out(start=962881, fixed=false))),


      // Steam extraction to PEM preheater:
    // Use one of the BOP auxiliary ports as a steam source. Here we tap BOP.port_a3[1] line conceptually.
    // Practically, connect an available steam line to IP.steamIn/steamOut.
    // (You may need to adjust indices based on your BOP model structure.)
    // We'll connect BOP.port_a3[1] -> IP.steamIn and IP.steamOut -> BOP.port_a3[1] as a loop placeholder.
    // Replace with a real extraction/return pair in your plant model.

  //BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
  //    53303300, BOP_capacity=0.35*(1 - fracNominal_Other)*PHS.data.Q_total_th)
  //  annotation (Placement(transformation(extent={{-220,160},{-200,180}})));
 // Modelica.Blocks.Sources.Constant delayStart(k=1800)
 //   annotation (Placement(transformation(extent={{-200,160},{-180,180}})));
equation
  //connect(PHS.port_b, EM.port_a1) annotation (Line(points={{-142,121.2},{-130,121.2},
  //        {-130,121.2},{-118,121.2}}, color={0,127,255}));
 // connect(PHS.port_a, EM.port_b1) annotation (Line(points={{-142,98.8},{-130,98.8},
  //        {-130,98.8},{-118,98.8}}, color={0,127,255}));
 // connect(EM.port_a2, BOP.port_b) annotation (Line(points={{-62,98.8},{-40,98.8},
  //        {-40,98.8},{-18,98.8}}, color={0,127,255}));
 // connect(EM.port_b2, BOP.port_a) annotation (Line(points={{-62,121.2},{-40,121.2},
  //        {-40,121.2},{-18,121.2}}, color={0,127,255}));
 // connect(IP.port_a, EM.port_b3[1]) annotation (Line(points={{-118,1.2},{-130,1.2},
  //        {-130,60},{-78.8,60},{-78.8,82}}, color={0,127,255}));
 // connect(IP.port_b, BOP.port_a3[1]) annotation (Line(points={{-118,-21.2},{-140,
  //        -21.2},{-140,74},{-1.2,74},{-1.2,82}}, color={0,127,255}));
 // connect(BOP.portElec_b, SY.port_a[1]) annotation (Line(points={{38,110},{50,110},
  //        {50,30},{82,30}}, color={255,0,0}));
 // connect(ES.portElec_b, SY.port_a[2])
 //   annotation (Line(points={{38,30},{82,30}}, color={255,0,0}));
 // connect(SES.portElec_b, SY.port_a[3]) annotation (Line(points={{38,-50},{50,-50},
  //        {50,30},{82,30}}, color={255,0,0}));
 // connect(IP.portElec_a, SY.port_a[4]) annotation (Line(points={{-62,-10},{-50,-10},
  //        {-50,-90},{50,-90},{50,30},{82,30}}, color={255,0,0}));
 // connect(SY.port_Grid, EG.portElec_a)
 //   annotation (Line(points={{138,30},{162,30}}, color={255,0,0}));
 // connect(EM.port_b3[2], ES.port_a) annotation (Line(points={{-78.8,82},{-78,82},
  //        {-78,41.2},{-18,41.2}}, color={0,127,255}));
 // connect(ES.port_b, BOP.port_a3[2]) annotation (Line(points={{-18,18.8},{-32,
  //        18.8},{-32,20},{-36,20},{-36,68},{-1.2,68},{-1.2,82}}, color={0,127,
  //        255}));
 // annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
 //       coordinateSystem(preserveAspectRatio=false)),
 //   experiment(
 //     StopTime=7200,
 //     __Dymola_NumberOfIntervals=720,
 //     __Dymola_Algorithm="Esdirk45a"));

      // Original FY18_TES plant connections preserved (Page 1, Section 4/4)
    connect(PHS.port_b, EM.port_a1) annotation (Line(points={{-142,121.2},{-118,121.2}}, color={0,127,255}));
    connect(PHS.port_a, EM.port_b1) annotation (Line(points={{-142,98.8},{-118,98.8}}, color={0,127,255}));

    connect(EM.port_a2, BOP.port_b) annotation (Line(points={{-62,98.8},{-18,98.8}}, color={0,127,255}));
    connect(EM.port_b2, BOP.port_a) annotation (Line(points={{-62,121.2},{-18,121.2}}, color={0,127,255}));

    connect(IP.port_a, EM.port_b3[1]) annotation (Line(points={{-118,1.2},{-78.8,82}}, color={0,127,255}));
    connect(IP.port_b, BOP.port_a3[1]) annotation (Line(points={{-118,-21.2},{-1.2,82}}, color={0,127,255}));

    connect(EM.port_b3[2], ES.port_a) annotation (Line(points={{-78.8,82},{-18,41.2}}, color={0,127,255}));
    connect(ES.port_b, BOP.port_a3[2]) annotation (Line(points={{-18,18.8},{-1.2,82}}, color={0,127,255}));

    // Electrical switchyard: keep the same connection point for IP
    connect(BOP.portElec_b, SY.port_a[1]) annotation (Line(points={{38,110},{82,30}}, color={255,0,0}));
    connect(ES.portElec_b, SY.port_a[2]) annotation (Line(points={{38,30},{82,30}}, color={255,0,0}));
    // port_a[3] was SES; now leave unused or connect a dummy. We will not connect it.
    connect(IP.portElec_a, SY.port_a[4]) annotation (Line(points={{-62,-10},{82,30}}, color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a) annotation (Line(points={{138,30},{162,30}}, color={255,0,0}));

    // Hydrogen to storage tank
    connect(IP.mH2_toTank, H2Tank.m_flow_in) annotation (Line(points={{-31.2,18},
          {54,18},{54,-100},{40,-100}},                                                                          color={0,0,127}));
    connect(tankOutflow.y, H2Tank.m_flow_out) annotation (Line(points={{21,-118},{30,-118},{30,-110},{40,-110}}, color={0,0,127}));

    // Turbine steam -> PEM feedwater preheat (placeholder connection)
    // Replace these with the correct turbine extraction/return ports available in your BOP model.
    connect(BOP.port_a3[1], IP.steamIn) annotation (Line(points={{-1.2,82},{-60,
          82},{-60,16.32},{-146,16.32}},                                                                 color={0,127,255}));
    connect(IP.steamOut, BOP.port_a3[1]) annotation (Line(points={{-146,6.8},{-60,
          6.8},{-60,82},{-1.2,82}},                                                                       color={0,127,255}));

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=7200, __Dymola_NumberOfIntervals=720, __Dymola_Algorithm="Esdirk45a"));
end TightlyCoupled_SteamFlowCtrl_FY18_TES_V2_EVM;
