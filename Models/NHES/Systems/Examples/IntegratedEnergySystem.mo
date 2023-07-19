within NHES.Systems.Examples;
package IntegratedEnergySystem
  model TightlyCoupled_SteamFlowCtrl_FY18

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
        nPorts_b3=1,
        port_b3_nominal_m_flow={-IP.port_a_nominal.m_flow}),
      redeclare BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries
        BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
        port_a3_nominal_p={IP.port_b_nominal.p},
        port_a3_nominal_h={IP.port_b_nominal.h},
        nPorts_a3=1,
        port_a3_nominal_m_flow={-IP.port_b_nominal.m_flow},
        redeclare
          NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_PressureAndPowerControl
          CS(p_nominal=BOP.port_a_nominal.p, W_totalSetpoint=SC.W_totalSetpoint_BOP)),
      redeclare EnergyStorage.Battery.Models.Logical ES(
        capacity_max=dataCapacity.ES_capacity,
        capacity_min=0.2*dataCapacity.ES_capacity,
        chargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
            /Modelica.Units.Conversions.from_hour(1),
        dischargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
            /Modelica.Units.Conversions.from_hour(1),
        redeclare
          NHES.Systems.EnergyStorage.Battery.ControlSystems.CS_InputSetpoint CS(
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
        IndustrialProcess.HighTempSteamElectrolysis.Models.TightlyCoupled_SteamFlowCtrl_FY17
        IP(
        capacity=dataCapacity.IP_capacity,
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*7.311637),
        redeclare
          NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.ControlSystems.CS_TightlyCoupled_SteamFlowCtrl_stepInput_FY17
          CS(capacityScaler=IP.capacityScaler),
        flowSplit(port_2(h_outflow(start=2.95398e6, fixed=false))),
        returnPump(PR0=62.7/51.3042, pstart_out=6270000),
        hEX_nuclearHeatCathodeGasRecup_ROM(hShell_out(start=962881, fixed=false))),
      redeclare SupervisoryControl.InputSetpointData SC(
        W_nominal_IP(displayUnit="MW") = 53303300,
        delayStart=delayStart.k,
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
        StopTime=7200,
        __Dymola_NumberOfIntervals=720,
        __Dymola_Algorithm="Esdirk45a"));
  end TightlyCoupled_SteamFlowCtrl_FY18;

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
      redeclare PrimaryHeatSystem.FourLoopPWR.Components.NSSS PHS(redeclare
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
      redeclare BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries
        BOP(
        port_a_nominal(
          p=EM.port_b2_nominal.p,
          h=EM.port_b2_nominal.h,
          m_flow=-EM.port_b2_nominal.m_flow),
        port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
        port_a3_nominal_p={IP.port_b_nominal.p},
        port_a3_nominal_h={IP.port_b_nominal.h},
        nPorts_a3=1,
        port_a3_nominal_m_flow={-IP.port_b_nominal.m_flow},
        redeclare
          NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_PressureAndPowerControl
          CS(p_nominal=BOP.port_a_nominal.p, W_totalSetpoint=SC.W_totalSetpoint_BOP)),
      redeclare EnergyStorage.Battery.Models.Logical ES(
        capacity_max=dataCapacity.ES_capacity,
        capacity_min=0.2*dataCapacity.ES_capacity,
        chargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
            /Modelica.Units.Conversions.from_hour(1),
        dischargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
            /Modelica.Units.Conversions.from_hour(1),
        redeclare
          NHES.Systems.EnergyStorage.Battery.ControlSystems.CS_InputSetpoint CS(
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
        IndustrialProcess.HighTempSteamElectrolysis.Models.TightlyCoupled_SteamFlowCtrl_FY17
        IP(
        capacity=dataCapacity.IP_capacity,
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*7.311637),
        redeclare
          NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.ControlSystems.CS_TightlyCoupled_SteamFlowCtrl_stepInput_FY17
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

  model TightlyCoupled_SteamFlowCtrl_FY18_TES

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
      redeclare SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl SES(
          capacity=dataCapacity.SES_capacity, redeclare
          NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
          capacityScaler=SES.capacityScaler,
          delayStart=delayStart.k,
          W_totalSetpoint=SC.W_totalSetpoint_SES)),
      redeclare
        IndustrialProcess.HighTempSteamElectrolysis.Models.TightlyCoupled_SteamFlowCtrl_FY17
        IP(
        capacity=dataCapacity.IP_capacity,
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*7.311637),
        redeclare
          NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.ControlSystems.CS_TightlyCoupled_SteamFlowCtrl_stepInput_FY17
          CS(capacityScaler=IP.capacityScaler),
        flowSplit(port_2(h_outflow(start=2.95398e6, fixed=false))),
        returnPump(PR0=62.7/51.3042, pstart_out=6270000),
        hEX_nuclearHeatCathodeGasRecup_ROM(hShell_out(start=962881, fixed=false))),
      redeclare SupervisoryControl.InputSetpointData SC(
        W_nominal_IP(displayUnit="MW") = 53303300,
        delayStart=delayStart.k,
        W_nominal_BOP=0.35*(1 - fracNominal_Other)*PHS.data.Q_total_th));

    BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
        53303300, BOP_capacity=0.35*(1 - fracNominal_Other)*PHS.data.Q_total_th)
      annotation (Placement(transformation(extent={{-220,160},{-200,180}})));
    Modelica.Blocks.Sources.Constant delayStart(k=1800)
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
    connect(EM.port_b3[2], ES.port_a) annotation (Line(points={{-78.8,82},{-78,82},
            {-78,41.2},{-18,41.2}}, color={0,127,255}));
    connect(ES.port_b, BOP.port_a3[2]) annotation (Line(points={{-18,18.8},{-32,
            18.8},{-32,20},{-36,20},{-36,68},{-1.2,68},{-1.2,82}}, color={0,127,
            255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=7200,
        __Dymola_NumberOfIntervals=720,
        __Dymola_Algorithm="Esdirk45a"));
  end TightlyCoupled_SteamFlowCtrl_FY18_TES;

  model SMR_Coupling_Test
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   Real demandChange=
   min(1.05,
   max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
       + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
       0.5));
    PrimaryHeatSystem.SMR_Generic.Components.SMR_Taveprogram SMR_Taveprogram(
      port_b_nominal(
        p=3447380,
        T(displayUnit="degC") = 579.75,
        h=2997670),
      redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave CS(W_turbine=BOP.powerSensor.power,
          W_Setpoint=SC.W_totalSetpoint_BOP),
      port_a_nominal(
        m_flow=70,
        T(displayUnit="degC") = 421.15,
        p=3447380))
      annotation (Placement(transformation(extent={{-86,-26},{-36,30}})));
    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=SMR_Taveprogram.port_b_nominal.p,
        h=SMR_Taveprogram.port_b_nominal.h,
        m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
            SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h))
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries BOP(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare BalanceOfPlant.RankineCycle.ControlSystems.CS_OTSG_Pressure CS(
        W_totalSetpoint=SC.W_totalSetpoint_BOP,
        p_nominal=BOP.port_a_nominal.p,
        Reactor_Power(displayUnit="MW") = 160000000,
        Nominal_Power(displayUnit="MW") = 160000000))
      annotation (Placement(transformation(extent={{42,-20},{82,20}})));
    SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
      annotation (Placement(transformation(extent={{100,-22},{140,22}})));
    ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
        53303300, BOP_capacity(displayUnit="MW") = 1165000000)
      annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
    Modelica.Blocks.Sources.Constant delayStart(k=0)
      annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
    SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
      W_nominal_BOP(displayUnit="MW") = 50000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Nominal_50_timeSeries.txt"))
      annotation (Placement(transformation(extent={{160,60},{200,100}})));
  equation
    connect(SMR_Taveprogram.port_b, EM.port_a1) annotation (Line(points={{
            -35.0909,12.7692},{-30,12.7692},{-30,8},{-20,8}}, color={0,127,255}));
    connect(SMR_Taveprogram.port_a, EM.port_b1) annotation (Line(points={{-35.0909,
            -1.44615},{-30,-1.44615},{-30,-8},{-20,-8}}, color={0,127,255}));
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{20,8},{42,8}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{20,-8},{42,-8}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1])
      annotation (Line(points={{82,0},{100,0}}, color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{140,0},{160,0}}, color={255,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{200,100}}), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-54,-102},{146,98}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{16,62},{116,2},{16,-58},{16,62}})}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{200,100}})),
      experiment(
        StopTime=3600,
        __Dymola_NumberOfIntervals=360,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_Coupling_Test;

  model SMR_Coupling_4_loop_control
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   Real demandChange=
   min(1.05,
   max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
       + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
       0.5));
    PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
      nuScale_Tave_enthalpy(
      port_a_nominal(
        m_flow=70,
        T(displayUnit="degC") = 421.15,
        p=3447380),
      port_b_nominal(
        T(displayUnit="degC") = 579.75,
        h=2997670,
        p=3447380),
      redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy CS(
        demand=demandChange,
        T_SG_exit=579.15,
        Q_nom=160e6))
      annotation (Placement(transformation(extent={{-86,-26},{-36,30}})));
    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=nuScale_Tave_enthalpy.port_b_nominal.p,
        h=nuScale_Tave_enthalpy.port_b_nominal.h,
        m_flow=-nuScale_Tave_enthalpy.port_b_nominal.m_flow), port_b1_nominal(p=
            nuScale_Tave_enthalpy.port_a_nominal.p, h=nuScale_Tave_enthalpy.port_a_nominal.h))
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries BOP(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.RankineCycle.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
        CS(W_totalSetpoint=SC.W_totalSetpoint_BOP, p_nominal=3447400))
      annotation (Placement(transformation(extent={{42,-20},{82,20}})));
    SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
      annotation (Placement(transformation(extent={{100,-22},{140,22}})));
    ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
        53303300, BOP_capacity(displayUnit="MW") = 1165000000)
      annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
    Modelica.Blocks.Sources.Constant delayStart(k=0)
      annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
    SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
      W_nominal_BOP(displayUnit="MW") = 50000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Test_timeSeries.txt"))
      annotation (Placement(transformation(extent={{160,60},{200,100}})));
  equation
    connect(nuScale_Tave_enthalpy.port_b, EM.port_a1) annotation (Line(points={{
            -35.0909,12.7692},{-30,12.7692},{-30,8},{-20,8}}, color={0,127,255}));
    connect(nuScale_Tave_enthalpy.port_a, EM.port_b1) annotation (Line(points={{-35.0909,
            -1.44615},{-30,-1.44615},{-30,-8},{-20,-8}}, color={0,127,255}));
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{20,8},{42,8}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{20,-8},{42,-8}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1])
      annotation (Line(points={{82,0},{100,0}}, color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{140,0},{160,0}}, color={255,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{200,100}}), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-54,-102},{146,98}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{8,60},{108,0},{8,-60},{8,60}})}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{200,100}})),
      experiment(
        StopTime=18000,
        Interval=50,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system capable of load following with demand. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: <span style=\"font-family: monospace,monospace; background-color: #f9f9f9;\">Frick, Konor L.&nbsp;<i>Status Report on the NuScale Module Developed in the Modelica Framework</i>. United States: N. p., 2019. Web. doi:10.2172/1569288.</span></p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_Coupling_4_loop_control;

  model SMR_highfidelity
    "High Fidelity Natural Circulation Model based on NuScale reactor. Hot channel calcs, pressurizer, and beginning of cycle reactivity feedback"
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   Real demandChange=
   min(1.05,
   max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
       + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
       0.5));
    PrimaryHeatSystem.SMR_Generic.Components.SMR_High_fidelity
      nuScale_Tave_enthalpy_Pressurizer_CR(
      port_a_nominal(
        m_flow=90,
        T(displayUnit="degC") = 421.15,
        p=3447380),
      port_b_nominal(
        T(displayUnit="degC") = 579.75,
        h=2997670,
        p=3447380),
      redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_highfidelity CS(
        SG_exit_enthalpy=3e6,
        m_setpoint=90.0,
        Q_nom(displayUnit="MW") = 200000000,
        demand=1.0),
      redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-92,-24},{-38,34}})));
    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.p,
        h=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.h,
        m_flow=-nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.m_flow),
        port_b1_nominal(p=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.p,
          h=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.h))
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries BOP(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
        CS(
        delayStartTCV=100,
        p_nominal=3447400,
        W_totalSetpoint=SC.W_totalSetpoint_BOP))
      annotation (Placement(transformation(extent={{42,-20},{82,20}})));
    SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
      annotation (Placement(transformation(extent={{100,-22},{140,22}})));
    ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
        53303300, BOP_capacity(displayUnit="MW") = 60000000)
      annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
    Modelica.Blocks.Sources.Constant delayStart(k=0)
      annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
    SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
      W_nominal_BOP(displayUnit="MW") = 60000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Uprate_timeSeries.txt"))
      annotation (Placement(transformation(extent={{158,60},{198,100}})));
  equation
    connect(nuScale_Tave_enthalpy_Pressurizer_CR.port_b, EM.port_a1) annotation (
        Line(points={{-37.1692,13.2857},{-30,13.2857},{-30,8},{-20,8}}, color={0,
            127,255}));
    connect(nuScale_Tave_enthalpy_Pressurizer_CR.port_a, EM.port_b1) annotation (
        Line(points={{-37.1692,-0.385714},{-30,-0.385714},{-30,-8},{-20,-8}},
          color={0,127,255}));
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{20,8},{42,8}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{20,-8},{42,-8}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1])
      annotation (Line(points={{82,0},{100,0}}, color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{140,0},{160,0}}, color={255,0,0}));
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
  end SMR_highfidelity;

  model SMR_highfidelity_L2_Turbine
    "High Fidelity Natural Circulation Model based on NuScale reactor. Hot channel calcs, pressurizer, and beginning of cycle reactivity feedback"
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   Real demandChange=
   min(1.05,
   max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
       + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
       0.5));
    PrimaryHeatSystem.SMR_Generic.Components.SMR_High_fidelity_no_pump
      nuScale_Tave_enthalpy_Pressurizer_CR(
      port_a_nominal(
        m_flow=90,
        T(displayUnit="degC") = 421.15,
        p=3447380),
      port_b_nominal(
        T(displayUnit="degC") = 579.75,
        h=2997670,
        p=3447380),
      redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_highfidelity CS(
        SG_exit_enthalpy=3e6,
        m_setpoint=90.0,
        Q_nom(displayUnit="MW") = 200000000,
        demand=1.0),
      redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-92,-24},{-38,32}})));
    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.p,
        h=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.h,
        m_flow=-nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.m_flow),
        port_b1_nominal(p=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.p,
          h=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.h))
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    BalanceOfPlant.RankineCycle.Models.SteamTurbine_L2_ClosedFeedHeat BOP(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp
        CS(electric_demand_int=SC.demand_BOP.y[1]))
      annotation (Placement(transformation(extent={{42,-20},{82,20}})));
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
  equation
    connect(nuScale_Tave_enthalpy_Pressurizer_CR.port_b, EM.port_a1) annotation (
        Line(points={{-37.1692,12},{-30,12},{-30,8},{-20,8}},           color={0,
            127,255}));
    connect(nuScale_Tave_enthalpy_Pressurizer_CR.port_a, EM.port_b1) annotation (
        Line(points={{-37.1692,-1.2},{-30,-1.2},{-30,-8},{-20,-8}},
          color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{20,-8},{42,-8}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1])
      annotation (Line(points={{82,0},{100,0}}, color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{140,0},{160,0}}, color={255,0,0}));
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{20,8},{42,8}}, color={0,127,255}));
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
        StopTime=10000,
        Interval=20,
        __Dymola_Algorithm="Esdirk45a"));
  end SMR_highfidelity_L2_Turbine;

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

  model HTGR_Open_Turbine
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
    BalanceOfPlant.RankineCycle.Models.HTGR_RankineCycles.HTGR_Rankine_Cycle_Transient
      BOP(redeclare
        BalanceOfPlant.RankineCycle.ControlSystems.CS_Rankine_Xe100_Based_Secondary_TransientControl
        CS) annotation (Placement(transformation(extent={{46,-22},{86,22}})));
  equation
      hTGR_PebbleBed_Primary_Loop_TESUC.input_steam_pressure =
      BOP.sensor_p.p;
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
    connect(stateSensor2.statePort, stateDisplay2.statePort) annotation (Line(
          points={{17.035,9.045},{17.035,23.5225},{19,23.5225},{19,37.1}}, color={
            0,0,0}));
    connect(BOP.port_e, SY.port_a[1])
      annotation (Line(points={{86,0},{100,0}}, color={255,0,0}));
    connect(stateSensor2.port_b, BOP.port_a)
      annotation (Line(points={{24,9},{24,8.8},{46,8.8}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b) annotation (Line(points={{6,-6},{40,-6},{40,-8.8},
            {46,-8.8}}, color={0,127,255}));
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
  end HTGR_Open_Turbine;

  model SMR_IES_CTES

    EnergyStorage.Concrete_Solid_Media.Models.Dual_Pipe_CTES_Controlled
      dual_Pipe_CTES_Controlled(redeclare
        NHES.Systems.EnergyStorage.Concrete_Solid_Media.ControlSystems.CS_DFV
        CS) annotation (Placement(transformation(extent={{110,-42},{204,26}})));
    PrimaryHeatSystem.SMR_Generic.Components.SMR_High_fidelity_no_pump            Reactor(
      Q_total_th=160e6,
      Q_total_el=52e6,
      redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_highfidelity CS(
        SG_exit_enthalpy=3000e3,
        m_setpoint=675,
        Q_nom=1,
        demand=1),
      port_a_nominal(
        m_flow=70,
        p=3447380,
        T(displayUnit="degC") = 421.15),
      port_b_nominal(
        p=3447380,
        T(displayUnit="degC") = 579.25,
        h=2997670))
      annotation (Placement(transformation(extent={{-130,-54},{-24,42}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.NuScale_Modal_Secondary_Arbitrage_Ports
      SecSide(redeclare
        BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.CS_Modal
        CS, Q_nom=52e6)
      annotation (Placement(transformation(extent={{12,-46},{84,24}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Components.Economic_Sim_IPCO_July
      ES annotation (Placement(transformation(extent={{-4,44},{42,90}})));
  equation
    dual_Pipe_CTES_Controlled.External_Demand = SecSide.Demand_Internal;
    dual_Pipe_CTES_Controlled.External_Power = SecSide.generator.power;
      Reactor.Q_total.y = SecSide.Q_RX_Internal;
    SecSide.DFV_Ancticipatory_Internal = ES.Anticipatory_Signals.y;
    SecSide.Demand_Internal = ES.Net_Demand.y;

    connect(dual_Pipe_CTES_Controlled.port_charge_a, SecSide.TBV_Send)
      annotation (Line(points={{116.043,6.28},{94,6.28},{94,9.3},{85.44,9.3}},
          color={0,127,255}));
    connect(SecSide.TBV_Return, dual_Pipe_CTES_Controlled.port_charge_b)
      annotation (Line(points={{85.44,-30.6},{100,-30.6},{100,-30},{102,-30},{102,
            30},{192,30},{192,7.64},{185.2,7.64}}, color={0,127,255}));
    connect(SecSide.Arbitrage_Return, dual_Pipe_CTES_Controlled.port_discharge_b)
      annotation (Line(points={{66,-46},{66,-56},{108,-56},{108,-48},{112,-48},
            {112,-27.04},{116.043,-27.04}},
                                       color={0,127,255}));
    connect(SecSide.Arbitrage_Send, dual_Pipe_CTES_Controlled.port_discharge_a)
      annotation (Line(points={{41.52,-46.7},{41.52,-72},{220,-72},{220,-36},{
            183.186,-36},{183.186,-25.68}},
                                    color={0,127,255}));
    connect(Reactor.port_b, SecSide.SG_Return) annotation (Line(points={{
            -22.3692,7.71429},{-6.1846,7.71429},{-6.1846,5.8},{11.28,5.8}},
                                                                   color={0,127,255}));
    connect(Reactor.port_a, SecSide.Feedwater) annotation (Line(points={{
            -22.3692,-14.9143},{0,-14.9143},{0,-29.9},{11.28,-29.9}},
                                                             color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{200,100}}), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-54,-102},{146,98}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{8,60},{108,0},{8,-60},{8,60}})}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{200,100}})),
      experiment(
        StartTime=120,
        StopTime=3600,
        __Dymola_NumberOfIntervals=279,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system capable of load following with demand. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: <span style=\"font-family: monospace,monospace; background-color: #f9f9f9;\">Frick, Konor L.&nbsp;<i>Status Report on the NuScale Module Developed in the Modelica Framework</i>. United States: N. p., 2019. Web. doi:10.2172/1569288.</span></p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_IES_CTES;

  model GenericModularPWR_park

  //  parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
  //  parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;

    PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS[3]
      annotation (Placement(transformation(extent={{-198,82},{-142,138}})));
       SupervisoryControl.InputSetpointData SC(
                                  W_nominal_IP(displayUnit="MW") = 53303300,
           delayStart=delayStart.k,
      fileName=Modelica.Utilities.Files.loadResource("modelica://NHES/Resources/Data/RAVEN/timeSeriesData.txt"),
      W_nominal_BOP=dataCapacity.BOP_capacity)                               annotation (Placement(transformation(extent={{122,102},{178,158}})));

     BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
         53303300) "0.35*(1 - fracNominal_Other)*PHS.data.Q_total"
       annotation (Placement(transformation(extent={{-220,160},{-200,180}})));
     Modelica.Blocks.Sources.Constant delayStart(k=7200)
       annotation (Placement(transformation(extent={{-200,160},{-180,180}})));
      EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=PHS[1].port_b_nominal.p,
        h=PHS[1].port_b_nominal.h,
        m_flow=sum(-PHS.port_b_nominal.m_flow)), port_b1_nominal(p=PHS[1].port_a_nominal.p,
          h=PHS[1].port_a_nominal.h))
      "{-IP.port_a_nominal.m_flow}"                                                                              annotation (Placement(transformation(extent={{-98,82},
              {-42,138}})));
    BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries BOP(
      redeclare
        BalanceOfPlant.RankineCycle.ControlSystems.CS_PressureAndPowerControl CS(
          p_nominal=BOP.port_a_nominal.p, W_totalSetpoint=SC.W_totalSetpoint_BOP),
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h))
      "{IP.port_b_nominal.p}{IP.port_b_nominal.h}{-IP.port_b_nominal.m_flow}"
      annotation (Placement(transformation(extent={{-18,82},{38,138}})));

    IndustrialProcess.HighTempSteamElectrolysis.Models.TightlyCoupled_SteamFlowCtrl_FY17
      IP(
      capacity=dataCapacity.IP_capacity,
      port_a_nominal(m_flow=IP.capacityScaler_steamFlow*7.311637),
      redeclare
        IndustrialProcess.HighTempSteamElectrolysis.ControlSystems.CS_TightlyCoupled_SteamFlowCtrl_stepInput_FY17
        CS(capacityScaler=IP.capacityScaler),
      flowSplit(port_2(h_outflow(start=2.95398e6, fixed=false))),
      returnPump(PR0=62.7/51.3042, pstart_out=6270000),
      hEX_nuclearHeatCathodeGasRecup_ROM(hShell_out(start=962881, fixed=false)))
      annotation (Placement(transformation(extent={{-118,-38},{-62,18}})));
    EnergyStorage.Battery.Models.Logical ES(
      capacity_max=dataCapacity.ES_capacity,
      capacity_min=0.2*dataCapacity.ES_capacity,
      chargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
          /Modelica.Units.Conversions.from_hour(1),
      dischargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
          /Modelica.Units.Conversions.from_hour(1),
      redeclare EnergyStorage.Battery.ControlSystems.CS_InputSetpoint CS(
          W_totalSetpoint=SC.W_totalSetpoint_ES))
      annotation (Placement(transformation(extent={{-18,2},{38,58}})));
       SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl SES(capacity=
          dataCapacity.SES_capacity, redeclare
        SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
        capacityScaler=SES.capacityScaler,
        delayStart=delayStart.k,
        W_totalSetpoint=SC.W_totalSetpoint_SES))    annotation (Placement(transformation(extent={{-18,-78},{38,-22}})));
       SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=4) annotation (Placement(transformation(extent={{82,2},{138,58}})));
       ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,2},{218,58}})));
    Modelica.Fluid.Sources.Boundary_pT heatingMedium_in(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      p=5800000,
      T=591.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-182,-6},{-164,12}})));
    Modelica.Fluid.Sources.Boundary_pT heatingMedium_out(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      p=6270000,
      T=497.457) annotation (Placement(transformation(
          extent={{9,9},{-9,-9}},
          rotation=180,
          origin={-173,-22})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=PHS[1].port_b_nominal.p,
      use_T_start=false,
      h_start=PHS[1].port_b_nominal.h,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.001),
      nPorts_b=1,
      nPorts_a=3)
      annotation (Placement(transformation(extent={{-130,110},{-110,130}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_T_start=false,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.001),
      p_start=PHS[1].port_a_nominal.p,
      h_start=PHS[1].port_a_nominal.h,
      nPorts_b=3,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-110,88},{-130,108}})));
  equation
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{-42,121.2},{-18,121.2}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{-42,98.8},{-18,98.8}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1]) annotation (Line(points={{38,110},{60,
            110},{60,27.9},{82,27.9}}, color={255,0,0}));
    connect(ES.portElec_b, SY.port_a[2]) annotation (Line(points={{38,30},{60,30},
            {60,29.3},{82,29.3}}, color={255,0,0}));
    connect(IP.portElec_a, SY.port_a[3]) annotation (Line(points={{-62,-10},{60,
            -10},{60,30.7},{82,30.7}}, color={255,0,0}));
    connect(SES.portElec_b, SY.port_a[4]) annotation (Line(points={{38,-50},{60,
            -50},{60,32.1},{82,32.1}}, color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{138,30},{162,30}}, color={255,0,0}));
    connect(heatingMedium_in.ports[1], IP.port_a) annotation (Line(points={{-164,
            3},{-142,3},{-142,1.2},{-118,1.2}}, color={0,127,255}));
    connect(heatingMedium_out.ports[1], IP.port_b) annotation (Line(points={{-164,
            -22},{-142,-22},{-142,-21.2},{-118,-21.2}}, color={0,127,255}));
    connect(PHS.port_a, volume1.port_b[1:3]) annotation (Line(points={{-142,
            98.8},{-134,98.8},{-134,98.6667},{-126,98.6667}},
                                                        color={0,127,255}));
    connect(volume1.port_a[1], EM.port_b1) annotation (Line(points={{-114,98},{
            -106,98},{-106,98.8},{-98,98.8}}, color={0,127,255}));
    connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-114,120},{
            -106,120},{-106,121.2},{-98,121.2}}, color={0,127,255}));
    connect(PHS.port_b, volume.port_a[1:3]) annotation (Line(points={{-142,
            121.2},{-134,121.2},{-134,120.667},{-126,120.667}},
                                                         color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent = {{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),Diagram(coordinateSystem(extent={{-220,-100},{240,180}},
            preserveAspectRatio=false)),
      experiment(
        StopTime=86400,
        __Dymola_NumberOfIntervals=8640,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>Setup for a large scale integration of a NuScale size reactor within an integrated energy system park. </p>
<p>Note: This generic PWR has a pump within it to ease the calculation. </p>
</html>"));
  end GenericModularPWR_park;

  model GenericModularPWR_stepdownturbines

  //  parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
  //  parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;

    PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS[3]
      annotation (Placement(transformation(extent={{-198,82},{-142,138}})));
       SupervisoryControl.InputSetpointData SC(
                                  W_nominal_IP(displayUnit="MW") = 53303300,
           delayStart=delayStart.k,
      fileName=Modelica.Utilities.Files.loadResource("modelica://NHES/Resources/Data/RAVEN/timeSeriesData.txt"),
      W_nominal_BOP=dataCapacity.BOP_capacity)                               annotation (Placement(transformation(extent={{122,102},{178,158}})));

     BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
         53303300) "0.35*(1 - fracNominal_Other)*PHS.data.Q_total"
       annotation (Placement(transformation(extent={{-220,160},{-200,180}})));
     Modelica.Blocks.Sources.Constant delayStart(k=7200)
       annotation (Placement(transformation(extent={{-200,160},{-180,180}})));
      EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=PHS[1].port_b_nominal.p,
        h=PHS[1].port_b_nominal.h,
        m_flow=sum(-PHS.port_b_nominal.m_flow)), port_b1_nominal(p=PHS[1].port_a_nominal.p,
          h=PHS[1].port_a_nominal.h),
      port_b3_nominal_m_flow={-IP.port_a_nominal.m_flow},
      nPorts_b3=1)
      "{-IP.port_a_nominal.m_flow}"                                                                              annotation (Placement(transformation(extent={{-98,82},
              {-42,138}})));
    BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries BOP(
      redeclare
        BalanceOfPlant.RankineCycle.ControlSystems.CS_PressureAndPowerControl CS(
          p_nominal=BOP.port_a_nominal.p, W_totalSetpoint=SC.W_totalSetpoint_BOP),
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      nPorts_a3=1,
      port_a3_nominal_p={IP1.port_b_nominal.p},
      port_a3_nominal_h={IP1.port_b_nominal.h},
      port_a3_nominal_m_flow={-IP1.port_b_nominal.m_flow})
      "{IP.port_b_nominal.p}{IP.port_b_nominal.h}{-IP.port_b_nominal.m_flow}"
      annotation (Placement(transformation(extent={{-18,82},{38,138}})));

    EnergyStorage.Battery.Models.Logical ES(
      capacity_max=dataCapacity.ES_capacity,
      capacity_min=0.2*dataCapacity.ES_capacity,
      chargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
          /Modelica.Units.Conversions.from_hour(1),
      dischargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
          /Modelica.Units.Conversions.from_hour(1),
      redeclare EnergyStorage.Battery.ControlSystems.CS_InputSetpoint CS(
          W_totalSetpoint=SC.W_totalSetpoint_ES))
      annotation (Placement(transformation(extent={{-18,2},{38,58}})));
       SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl SES(capacity=
          dataCapacity.SES_capacity, redeclare
        SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
        capacityScaler=SES.capacityScaler,
        delayStart=delayStart.k,
        W_totalSetpoint=SC.W_totalSetpoint_SES))    annotation (Placement(transformation(extent={{-18,-78},{38,-22}})));
       SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=5) annotation (Placement(transformation(extent={{82,2},{138,58}})));
       ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,2},{218,58}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=PHS[1].port_b_nominal.p,
      use_T_start=false,
      h_start=PHS[1].port_b_nominal.h,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.001),
      nPorts_b=1,
      nPorts_a=3)
      annotation (Placement(transformation(extent={{-130,110},{-110,130}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_T_start=false,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.001),
      p_start=PHS[1].port_a_nominal.p,
      h_start=PHS[1].port_a_nominal.h,
      nPorts_b=3,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-110,88},{-130,108}})));
    IndustrialProcess.HeaderTurbineCombo.Models.StepDownTurbine IP(
        port_a_nominal(
        p=IP.data.p_HP,
        h=IP.data.h_HP,
        m_flow=IP.data.m_flow_total), port_b_nominal(p=IP.data.p_IP, h=IP.data.h_IP))
      annotation (Placement(transformation(extent={{-150,2},{-94,58}})));
    IndustrialProcess.HeaderTurbineCombo.Models.StepDownTurbine IP1(
        port_a_nominal(
        p=IP.data.p_IP,
        h=IP.data.h_IP,
        m_flow=IP.data.m_flow_HP), port_b_nominal(p=IP.data.p_LP, h=IP.data.h_LP))
      annotation (Placement(transformation(extent={{-150,-78},{-94,-22}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow(redeclare
        package Medium = Modelica.Media.Water.StandardWater, m_flow_nominal=IP.port_a_nominal.m_flow)
      annotation (Placement(transformation(extent={{-206,30},{-186,50}})));
  equation
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{-42,121.2},{-18,121.2}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{-42,98.8},{-18,98.8}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1]) annotation (Line(points={{38,110},{60,
            110},{60,27.76},{82,27.76}},
                                       color={255,0,0}));
    connect(ES.portElec_b, SY.port_a[2]) annotation (Line(points={{38,30},{60,30},
            {60,28.88},{82,28.88}},
                                  color={255,0,0}));
    connect(SES.portElec_b, SY.port_a[3]) annotation (Line(points={{38,-50},{60,
            -50},{60,30},{82,30}},     color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{138,30},{162,30}}, color={255,0,0}));
    connect(PHS.port_a, volume1.port_b[1:3]) annotation (Line(points={{-142,98.8},
            {-134,98.8},{-134,98.6667},{-126,98.6667}}, color={0,127,255}));
    connect(volume1.port_a[1], EM.port_b1) annotation (Line(points={{-114,98},{
            -106,98},{-106,98.8},{-98,98.8}}, color={0,127,255}));
    connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-114,120},{
            -106,120},{-106,121.2},{-98,121.2}}, color={0,127,255}));
    connect(PHS.port_b, volume.port_a[1:3]) annotation (Line(points={{-142,121.2},
            {-134,121.2},{-134,120.667},{-126,120.667}}, color={0,127,255}));
    connect(IP.port_b, IP1.port_a) annotation (Line(points={{-150,18.24},{-160,
            18.24},{-160,-38.8},{-150,-38.8}}, color={0,127,255}));
    connect(IP1.port_b, BOP.port_a3[1]) annotation (Line(points={{-150,-61.76},{
            -154,-61.76},{-154,-62},{-166,-62},{-166,70},{-1.2,70},{-1.2,82}},
          color={0,127,255}));
    connect(IP.portElec, SY.port_a[4]) annotation (Line(points={{-94,30},{-60,30},
            {-60,-90},{60,-90},{60,31.12},{82,31.12}}, color={255,0,0}));
    connect(IP1.portElec, SY.port_a[5]) annotation (Line(points={{-94,-50},{-80,
            -50},{-80,-90},{60,-90},{60,32.24},{82,32.24}}, color={255,0,0}));
    connect(EM.port_b3[1], pump_SimpleMassFlow.port_a) annotation (Line(points={{
            -58.8,82},{-58.8,74},{-210,74},{-210,40},{-206,40}}, color={0,127,255}));
    connect(pump_SimpleMassFlow.port_b, IP.port_a) annotation (Line(points={{-186,
            40},{-168,40},{-168,41.2},{-150,41.2}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent = {{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),Diagram(coordinateSystem(extent={{-220,-100},{240,180}},
            preserveAspectRatio=false)),
      experiment(
        StopTime=86400,
        __Dymola_NumberOfIntervals=8640,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>Integration of a modular PWR with several step-down turbines to look at potential steam offtake of the secondary side. </p>
</html>"));
  end GenericModularPWR_stepdownturbines;

  model GenericModularPWR_multimodule

  //  parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
  //  parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;

   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   Real demandChange=
   min(1.05,
   max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
       + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
       0.5));

    PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS(redeclare
        PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
      annotation (Placement(transformation(extent={{-198,82},{-142,138}})));
       SupervisoryControl.InputSetpointDatanew
                                            SC(
           delayStart=delayStart.k,
      W_nominal_BOP=dataCapacity.BOP_capacity,
      W_nominal_IP(displayUnit="MW") = dataCapacity.IP_capacity,
      W_nominal_SES=dataCapacity.SES_capacity,
      W_nominal_ES=dataCapacity.ES_capacity,
      fileName=Modelica.Utilities.Files.loadResource("modelica://NHES/Resources/Data/RAVEN/timeSeriesDataFY18_southeast.txt"))
                                                                             annotation (Placement(transformation(extent={{122,102},{178,158}})));

     BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
         53303300, BOP_capacity=42e6)
                   "0.35*(1 - fracNominal_Other)*PHS.data.Q_total"
       annotation (Placement(transformation(extent={{-220,160},{-200,180}})));
     Modelica.Blocks.Sources.Constant delayStart(k=7200) "7200"
       annotation (Placement(transformation(extent={{-200,160},{-180,180}})));
      EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(
      port_b3_nominal_m_flow={-IP.port_a_nominal.m_flow},
      port_a1_nominal(
        p=PHS.port_b_nominal.p,
        h=PHS.port_b_nominal.h,
        m_flow=-PHS.port_b_nominal.m_flow - PHS1.port_b_nominal.m_flow - PHS2.port_b_nominal.m_flow),
      port_b1_nominal(p=PHS.port_a_nominal.p, h=PHS.port_a_nominal.h),
      nPorts_b3=1)
      "{-IP.port_a_nominal.m_flow}"                                                                              annotation (Placement(transformation(extent={{-98,82},
              {-42,138}})));

    BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries BOP(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      port_a3_nominal_p={IP.port_b_nominal.p},
      port_a3_nominal_h={IP.port_b_nominal.h},
      port_a3_nominal_m_flow={-IP.port_b_nominal.m_flow},
      nPorts_a3=1,
      redeclare
        BalanceOfPlant.RankineCycle.ControlSystems.CS_PressureAndPowerControl CS(
        p_nominal=BOP.port_a_nominal.p,
        W_totalSetpoint=SC.W_totalSetpoint_BOP,
        delayStartTCV=200))
      "{IP.port_b_nominal.p}{IP.port_b_nominal.h}{-IP.port_b_nominal.m_flow}"
      annotation (Placement(transformation(extent={{-18,82},{38,138}})));
    EnergyStorage.Battery.Models.Logical ES(
      capacity_max=dataCapacity.ES_capacity,
      capacity_min=0.2*dataCapacity.ES_capacity,
      chargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
          /Modelica.Units.Conversions.from_hour(1),
      dischargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
          /Modelica.Units.Conversions.from_hour(1),
      redeclare EnergyStorage.Battery.ControlSystems.CS_InputSetpoint CS(
          W_totalSetpoint=SC.W_totalSetpoint_ES))
      annotation (Placement(transformation(extent={{-18,2},{38,58}})));
       SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl SES(capacity=
          dataCapacity.SES_capacity, redeclare
        SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
        capacityScaler=SES.capacityScaler,
        delayStart=delayStart.k,
        W_totalSetpoint=SC.W_totalSetpoint_SES))    annotation (Placement(transformation(extent={{-18,-78},{38,-22}})));
       SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=4) annotation (Placement(transformation(extent={{82,2},{138,58}})));
       ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,2},{218,58}})));
    IndustrialProcess.HeaderTurbineCombo.Models.StepDownTurbines IP(
      port_a_nominal(
        p=IP.data.p_HP,
        h=IP.data.h_HP,
        m_flow=IP.data.m_flow_total),
      port_b_nominal(p=IP.data.p_LP, h=IP.data.h_LP),
      redeclare IndustrialProcess.HeaderTurbineCombo.ControlSystems.ED_Inputs
        ED(
        m_flow_IP_toProcess=IP_signal.y,
        m_flow_LP_toProcess=LP_signal.y,
        m_flow_HP_toProcess=HP_signalmod.y))
      annotation (Placement(transformation(extent={{-98,2},{-42,58}})));
    PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS1(redeclare
        PrimaryHeatSystem.GenericModular_PWR.CS_SteadyState CS)
      annotation (Placement(transformation(extent={{-198,22},{-142,78}})));
    PrimaryHeatSystem.GenericModular_PWR.GenericModule PHS2(redeclare
        PrimaryHeatSystem.GenericModular_PWR.CS_LoadFollow CS(Q_total_setpoint=
            demandChange*PHS2.data.Q_total))
      annotation (Placement(transformation(extent={{-198,-38},{-142,18}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_T_start=false,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.001),
      nPorts_b=1,
      p_start=PHS.port_b_nominal.p,
      h_start=PHS.port_b_nominal.h,
      nPorts_a=3,
      showName=false)
      annotation (Placement(transformation(extent={{-126,114},{-106,134}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_T_start=false,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.001),
      nPorts_a=1,
      p_start=PHS.port_a_nominal.p,
      h_start=PHS.port_a_nominal.h,
      nPorts_b=3,
      showName=false)
      annotation (Placement(transformation(extent={{-106,86},{-126,106}})));
    Modelica.Blocks.Sources.Trapezoid LP_signal(
      amplitude=IP.data.m_flow_IP_toProcess,
      rising=3600,
      width=43200,
      falling=3600,
      period=86400,
      startTime=10000)
      annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
    Modelica.Blocks.Sources.SawTooth IP_signal(
      amplitude=2*IP.data.m_flow_IP_toProcess,
      period=64800,
      startTime=10000)
      annotation (Placement(transformation(extent={{-130,-80},{-110,-60}})));
    Modelica.Blocks.Sources.Sine HP_signal(
      offset=IP.data.m_flow_HP_toProcess,
      amplitude=0.2*IP.data.m_flow_HP_toProcess,
      f=1/43200,
      startTime=10000)
      annotation (Placement(transformation(extent={{-180,-80},{-160,-60}})));
    Modelica.Blocks.Sources.RealExpression HP_signalmod(y=if time < HP_signal.startTime
           then 0 else HP_signal.y)
      annotation (Placement(transformation(extent={{-154,-80},{-134,-60}})));
  equation
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{-42,121.2},{-18,121.2}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{-42,98.8},{-18,98.8}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1]) annotation (Line(points={{38,110},{60,
            110},{60,27.9},{82,27.9}}, color={255,0,0}));
    connect(ES.portElec_b, SY.port_a[2]) annotation (Line(points={{38,30},{60,30},
            {60,29.3},{82,29.3}}, color={255,0,0}));
    connect(SES.portElec_b, SY.port_a[3]) annotation (Line(points={{38,-50},{60,
            -50},{60,30.7},{82,30.7}}, color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{138,30},{162,30}}, color={255,0,0}));
    connect(IP.portElec, SY.port_a[4]) annotation (Line(points={{-42,30},{-30,30},
            {-30,-90},{60,-90},{60,32.1},{82,32.1}}, color={255,0,0}));
    connect(volume1.port_a[1], EM.port_b1) annotation (Line(points={{-110,96},{
            -104,96},{-104,98.8},{-98,98.8}}, color={0,127,255}));
    connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-110,124},{
            -106,124},{-106,121.2},{-98,121.2}}, color={0,127,255}));
    connect(PHS.port_b, volume.port_a[1]) annotation (Line(points={{-142,121.2},{
            -128,121.2},{-128,123.333},{-122,123.333}}, color={0,127,255}));
    connect(PHS1.port_b, volume.port_a[2]) annotation (Line(points={{-142,61.2},{
            -128,61.2},{-128,124},{-122,124}}, color={0,127,255}));
    connect(PHS2.port_b, volume.port_a[3]) annotation (Line(points={{-142,1.2},{
            -128,1.2},{-128,124.667},{-122,124.667}}, color={0,127,255}));
    connect(PHS.port_a, volume1.port_b[1]) annotation (Line(points={{-142,98.8},{
            -134,98.8},{-134,95.3333},{-122,95.3333}}, color={0,127,255}));
    connect(PHS1.port_a, volume1.port_b[2]) annotation (Line(points={{-142,38.8},
            {-134,38.8},{-134,96},{-122,96}}, color={0,127,255}));
    connect(PHS2.port_a, volume1.port_b[3]) annotation (Line(points={{-142,-21.2},
            {-134,-21.2},{-134,96.6667},{-122,96.6667}}, color={0,127,255}));
    connect(IP.port_a, EM.port_b3[1]) annotation (Line(points={{-98,41.2},{-110,
            41.2},{-110,74},{-58.8,74},{-58.8,82}}, color={0,127,255}));
    connect(IP.port_b, BOP.port_a3[1]) annotation (Line(points={{-98,18.24},{-106,
            18.24},{-106,68},{-1.2,68},{-1.2,82}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent = {{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),Diagram(coordinateSystem(extent={{-220,-100},{240,180}},
            preserveAspectRatio=false)),
      experiment(
        StopTime=96400,
        __Dymola_NumberOfIntervals=9640,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>Modular PWR setup for a site that may include several reactors all feeding a single load. </p>
<p>Note: Simulation takes awhile to initialize. </p>
</html>"));
  end GenericModularPWR_multimodule;

  model SMR_Coupling_4_loop_control_FMUME
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   Real demandChange=
   min(1.05,
   max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
       + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
       0.5));
    PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
      nuScale_Tave_enthalpy(
      port_a_nominal(
        m_flow=70,
        T(displayUnit="degC") = 421.15,
        p=3447380),
      port_b_nominal(
        T(displayUnit="degC") = 579.75,
        h=2997670,
        p=3447380),
      redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy CS(
        demand=demandChange,
        T_SG_exit=579.15,
        Q_nom=160e6))
      annotation (Placement(transformation(extent={{-102,-26},{-52,30}})));
    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=nuScale_Tave_enthalpy.port_b_nominal.p,
        h=nuScale_Tave_enthalpy.port_b_nominal.h,
        m_flow=-nuScale_Tave_enthalpy.port_b_nominal.m_flow), port_b1_nominal(p=
            nuScale_Tave_enthalpy.port_a_nominal.p, h=nuScale_Tave_enthalpy.port_a_nominal.h))
      annotation (Placement(transformation(extent={{-36,-20},{4,20}})));
    SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
      annotation (Placement(transformation(extent={{104,-22},{144,22}})));
    ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
        53303300, BOP_capacity(displayUnit="MW") = 1165000000)
      annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
    Modelica.Blocks.Sources.Constant delayStart(k=0)
      annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
    SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
      W_nominal_BOP(displayUnit="MW") = 50000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Test_timeSeries.txt"))
      annotation (Placement(transformation(extent={{160,60},{200,100}})));
    NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.MassFlowToPressure
      massFlowToPressure
      annotation (Placement(transformation(extent={{14,14},{20,36}})));
    NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.PressureToMassFlow
      pressureToMassFlow
      annotation (Placement(transformation(extent={{20,-30},{14,-12}})));
    FMIs.BOP_ME_fmu
               bOP_ME_fmu(
      _BOP_Demand_start=50e6,
      _h_in_port_a_start=3e6,
      _p_in_port_a_start=5.6e6,
      _m_in_port_b_start=67,
      _h_in_port_b_start=9e5)
      annotation (Placement(transformation(extent={{38,-20},{74,16}})));
    TRANSFORM.Electrical.Sources.FrequencySource boundary(use_port=false)
      annotation (Placement(transformation(extent={{82,-60},{102,-40}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=SC.W_totalSetpoint_BOP)
      annotation (Placement(transformation(extent={{-20,-64},{0,-44}})));
  equation
    connect(nuScale_Tave_enthalpy.port_b, EM.port_a1) annotation (Line(points={{
            -51.0909,12.7692},{-46,12.7692},{-46,8},{-36,8}}, color={0,127,255}));
    connect(nuScale_Tave_enthalpy.port_a, EM.port_b1) annotation (Line(points={{
            -51.0909,-1.44615},{-46,-1.44615},{-46,-8},{-36,-8}},
                                                         color={0,127,255}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{144,0},{160,0}}, color={255,0,0}));
    connect(EM.port_b2, massFlowToPressure.fluidPort) annotation (Line(points={{4,
            8},{10,8},{10,25},{14,25}}, color={0,127,255}));
    connect(EM.port_a2, pressureToMassFlow.fluidPort) annotation (Line(points={{4,-8},{
            10,-8},{10,-20.9308},{13.94,-20.9308}},      color={0,127,255}));
    connect(boundary.port, SY.port_a[1]) annotation (Line(points={{102,-50},{112,
            -50},{112,-32},{98,-32},{98,0},{104,0}}, color={255,0,0}));
    connect(realExpression.y, bOP_ME_fmu.BOP_Demand) annotation (Line(points={{1,
            -54},{12,-54},{12,10.06},{37.28,10.06}}, color={0,0,127}));
    connect(massFlowToPressure.h_out, bOP_ME_fmu.h_in_port_a) annotation (Line(
          points={{20.6,19.9231},{30,19.9231},{30,4.12},{37.28,4.12}}, color={0,0,
            127}));
    connect(massFlowToPressure.p_out, bOP_ME_fmu.p_in_port_a) annotation (Line(
          points={{20.6,22.4615},{30,22.4615},{30,-2},{37.28,-2}}, color={0,0,127}));
    connect(pressureToMassFlow.m_flow_out, bOP_ME_fmu.m_in_port_b) annotation (
        Line(points={{20.6,-12.6923},{28.3,-12.6923},{28.3,-7.94},{37.28,-7.94}},
          color={0,0,127}));
    connect(pressureToMassFlow.h_out, bOP_ME_fmu.h_in_port_b) annotation (Line(
          points={{20.6,-14.7692},{28.3,-14.7692},{28.3,-13.88},{37.28,-13.88}},
          color={0,0,127}));
    connect(bOP_ME_fmu.h_out_port_b, pressureToMassFlow.h_in) annotation (Line(
          points={{75.8,-14.78},{80,-14.78},{80,-30},{26,-30},{26,-25.1538},{20.6,
            -25.1538}}, color={0,0,127}));
    connect(bOP_ME_fmu.p_out_port_b, pressureToMassFlow.p_in) annotation (Line(
          points={{75.8,-9.56},{82,-9.56},{82,-32},{26,-32},{26,-23.0769},{20.6,
            -23.0769}}, color={0,0,127}));
    connect(bOP_ME_fmu.m_flow_out_port_a, massFlowToPressure.m_flow_in)
      annotation (Line(points={{75.8,0.7},{84,0.7},{84,35.1538},{20.6,35.1538}},
          color={0,0,127}));
    connect(bOP_ME_fmu.h_out_port_a, massFlowToPressure.h_in) annotation (Line(
          points={{75.8,-4.52},{88,-4.52},{88,32.6154},{20.6,32.6154}}, color={0,
            0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{200,100}}), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-54,-102},{146,98}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{8,60},{108,0},{8,-60},{8,60}})}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{200,100}})),
      experiment(
        StopTime=18000,
        Interval=1,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system capable of load following with demand. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: <span style=\"font-family: monospace,monospace; background-color: #f9f9f9;\">Frick, Konor L.&nbsp;<i>Status Report on the NuScale Module Developed in the Modelica Framework</i>. United States: N. p., 2019. Web. doi:10.2172/1569288.</span></p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_Coupling_4_loop_control_FMUME;

  model IES_SMR_Rx_GasTurbine
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   Real demandChange=
   min(1.05,
   max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
       + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
       0.5));
    PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
      nuScale_Tave_enthalpy(
      port_a_nominal(
        m_flow=70,
        T(displayUnit="degC") = 421.15,
        p=3447380),
      port_b_nominal(
        T(displayUnit="degC") = 579.75,
        h=2997670,
        p=3447380),
      redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy CS(
        demand=demandChange,
        T_SG_exit=579.15,
        Q_nom=160e6))
      annotation (Placement(transformation(extent={{-86,-26},{-36,30}})));
    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=nuScale_Tave_enthalpy.port_b_nominal.p,
        h=nuScale_Tave_enthalpy.port_b_nominal.h,
        m_flow=-nuScale_Tave_enthalpy.port_b_nominal.m_flow), port_b1_nominal(p=
            nuScale_Tave_enthalpy.port_a_nominal.p, h=nuScale_Tave_enthalpy.port_a_nominal.h))
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries BOP(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.RankineCycle.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
        CS(
        delayStartTCV=0,
        W_totalSetpoint=SC.W_totalSetpoint_BOP,
        p_nominal=3447400))
      annotation (Placement(transformation(extent={{42,-20},{82,20}})));
    SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)
      annotation (Placement(transformation(extent={{100,-22},{140,22}})));
    ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
        53303300, BOP_capacity(displayUnit="MW") = 1165000000)
      annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
    Modelica.Blocks.Sources.Constant delayStart(k=0)
      annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
    SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
      W_nominal_BOP(displayUnit="MW") = 50000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Rx_GT_timeSeries.txt"))
      annotation (Placement(transformation(extent={{160,60},{200,100}})));
    SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl SES(redeclare
        SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(delayStart=0,
          W_totalSetpoint=SC.W_totalSetpoint_SES))
      annotation (Placement(transformation(extent={{42,-80},{84,-40}})));
  equation
    connect(nuScale_Tave_enthalpy.port_b, EM.port_a1) annotation (Line(points={{
            -35.0909,12.7692},{-30,12.7692},{-30,8},{-20,8}}, color={0,127,255}));
    connect(nuScale_Tave_enthalpy.port_a, EM.port_b1) annotation (Line(points={{-35.0909,
            -1.44615},{-30,-1.44615},{-30,-8},{-20,-8}}, color={0,127,255}));
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{20,8},{42,8}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{20,-8},{42,-8}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1])
      annotation (Line(points={{82,0},{100,0},{100,-1.1}},
                                                color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{140,0},{160,0}}, color={255,0,0}));
    connect(SES.portElec_b, SY.port_a[2]) annotation (Line(points={{84,-60},{92,
            -60},{92,0},{100,0},{100,1.1}}, color={255,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{200,100}}), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-54,-102},{146,98}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{8,60},{108,0},{8,-60},{8,60}})}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{200,100}})),
      experiment(
        StopTime=10800,
        Interval=50,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system capable of load following with demand. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: <span style=\"font-family: monospace,monospace; background-color: #f9f9f9;\">Frick, Konor L.&nbsp;<i>Status Report on the NuScale Module Developed in the Modelica Framework</i>. United States: N. p., 2019. Web. doi:10.2172/1569288.</span></p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end IES_SMR_Rx_GasTurbine;

  model TightlyCoupled_SteamFlowCtrl_microgrid
    BaseClasses.Data_Capacity dataCapacity(
      IP_capacity(displayUnit="MW") = 240000000,
                  BOP_capacity=0.35*(1 - fracNominal_Other)*PHS.data.Q_total_th,
      SES_capacity=180000000)
      annotation (Placement(transformation(extent={{-220,160},{-200,180}})));

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
      redeclare SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl SES(
          capacity=dataCapacity.SES_capacity, redeclare
          NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
          capacityScaler=SES.capacityScaler,
          delayStart=delayStart.k,
          W_totalSetpoint=SC.W_totalSetpoint_SES)),
      redeclare
        IndustrialProcess.HighTempSteamElectrolysis.Models.TightlyCoupled_SteamFlowCtrl_FY17
        IP(
        capacity=dataCapacity.IP_capacity,
        port_a_nominal(m_flow=IP.capacityScaler_steamFlow*7.311637),
        redeclare
          IndustrialProcess.HighTempSteamElectrolysis.ControlSystems.CS_TightlyCoupled_SteamFlowCtrl_FY17
          CS(
          delayStart=delayStart.k,
          capacityScaler=dataCapacity.IP_capacity/IP.CS.W_IP_nom,
          W_totalSetpoint=SC.W_totalSetpoint_IP),
        flowSplit(port_2(h_outflow(start=2.95398e6, fixed=false))),
        returnPump(PR0=62.7/51.3042, pstart_out=6270000),
        hEX_nuclearHeatCathodeGasRecup_ROM(hShell_out(start=962881, fixed=false))),
      redeclare SupervisoryControl.InputSetpointData SC(
        W_nominal_IP(displayUnit="MW") = 240000000,
        delayStart=delayStart.k,
        W_nominal_BOP=0.35*(1 - fracNominal_Other)*PHS.data.Q_total_th,
        W_nominal_SES=180000000,
        fileName=Modelica.Utilities.Files.loadResource(
            "modelica://NHES/Resources/Data/RAVEN/IES_IAEA_timeSeries.txt")));

    Modelica.Blocks.Sources.Constant delayStart(k=300)
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
    connect(EM.port_b3[2], ES.port_a) annotation (Line(points={{-78.8,82},{-78,82},
            {-78,41.2},{-18,41.2}}, color={0,127,255}));
    connect(ES.port_b, BOP.port_a3[2]) annotation (Line(points={{-18,18.8},{-32,
            18.8},{-32,20},{-36,20},{-36,68},{-1.2,68},{-1.2,82}}, color={0,127,
            255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=10800,
        __Dymola_NumberOfIntervals=720,
        Tolerance=1e-06,
        __Dymola_Algorithm="Esdirk45a"));
  end TightlyCoupled_SteamFlowCtrl_microgrid;

  model FARM_Control_BOP_TES_SES_Test
    "TES use case demonstration of a NuScale-style LWR operating within an energy arbitrage IES, storing and dispensing energy on demand from a two tank molten salt energy storage system nominally using HITEC salt to store heat."
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   parameter Modelica.Units.SI.Time timeScale=60*60
      "Time scale of first table column";
   parameter String fileName=Modelica.Utilities.Files.loadResource(
      "modelica://NHES/Resources/Data/RAVEN/DMM_Dissertation_Demand.txt")
    "File where matrix is stored";
   Real demandChange=
   min(1.05,
   max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
       + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
       0.5));

    NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(
      port_a1_nominal(
        p(displayUnit="Pa") = 3.398e6,
        h=2.99767e6,
        m_flow=67.07),
      port_b1_nominal(p=3447380, h=629361),
      port_b3_nominal_m_flow={-0.67,-1.0},
      nPorts_b3=2)
      annotation (Placement(transformation(extent={{-60,40},{-20,80}})));

    NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_OpenFeedHeat_DivertPowerControl
      BOP(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_DivertPowerControl_ANL_v2
        CS(electric_demand_large=MW_W_Gain_BOP.y, data(Q_Nom=49e6)))
      annotation (Placement(transformation(extent={{10,40},{50,80}})));
    NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=3)
      annotation (Placement(transformation(extent={{60,38},{100,82}})));
    NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{120,40},{160,80}})));
    NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(
          displayUnit="MW") = 53303300, BOP_capacity(displayUnit="MW")=
        1165000000)
      annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
    NHES.Systems.SupervisoryControl.InputSetpointData SC(
      delayStart=0,
      W_nominal_BOP(displayUnit="MW") = 50000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Nominal_50_timeSeries.txt"))
      annotation (Placement(transformation(extent={{-80,-100},{-40,-60}})));

    NHES.Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-80,60},{-66,76}})));
    NHES.Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-14,60},{0,76}})));
    NHES.Fluid.Sensors.stateSensor stateSensor3(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-66,44},{-80,60}})));
    NHES.Fluid.Sensors.stateSensor stateSensor4(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-30,-20},{-16,-4}})));
    NHES.Fluid.Sensors.stateSensor stateSensor5(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-14,28},{0,44}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{104,54},{116,66}})));

    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      nPorts=1,
      p(displayUnit="bar") = 3000000,
      T(displayUnit="degC") = 421.15)
      annotation (Placement(transformation(extent={{-120,60},{-104,44}})));
    Modelica.Fluid.Sources.MassFlowSource_T SteamSource(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=87.53,
      T(displayUnit="K") = 581.24,
      nPorts=1)
      annotation (Placement(transformation(extent={{-120,58},{-100,78}})));
    Modelica.Fluid.Sources.Boundary_pT pBalance_sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      nPorts=1,
      p(displayUnit="bar") = 3790000,
      T(displayUnit="K") = 580)
      annotation (Placement(transformation(extent={{-120,38},{-104,22}})));
    NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.Examples.Standalone_Examples.GTPP_PowerCtrl_fixedCapacity
      SES(redeclare
        NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
        delayStart=3,
        W_SES_nom(displayUnit="MW") = 50000000,
        W_totalSetpoint=MW_W_Gain_SES.y))
      annotation (Placement(transformation(extent={{58,-80},{102,-40}})));
    Modelica.Blocks.Interfaces.RealOutput BOP_Electric_Power
      annotation (Placement(transformation(extent={{120,14},{140,34}}),
          iconTransformation(extent={{128,68},{152,92}})));
    Modelica.Blocks.Interfaces.RealOutput BOP_Turbine_Pressure
      annotation (Placement(transformation(extent={{120,-2},{140,18}}),
          iconTransformation(extent={{128,44},{152,68}})));
    Modelica.Blocks.Interfaces.RealOutput SES_Electric_Power
      annotation (Placement(transformation(extent={{120,-82},{140,-62}}),
          iconTransformation(extent={{128,-72},{152,-48}})));
    Modelica.Blocks.Interfaces.RealOutput SES_Firing_Temperature
      annotation (Placement(transformation(extent={{120,-98},{140,-78}}),
          iconTransformation(extent={{128,-96},{152,-72}})));
    Modelica.Blocks.Interfaces.RealOutput TES_HotTank_Level
      annotation (Placement(transformation(extent={{120,-24},{140,-4}}),
          iconTransformation(extent={{116,-28},{140,-4}})));
    Modelica.Blocks.Interfaces.RealOutput TES_HT_Level_Ramprate annotation (
        Placement(transformation(extent={{120,-42},{140,-22}}),
          iconTransformation(extent={{128,-40},{152,-16}})));
    Modelica.Blocks.Sources.Pulse pulse_BOP(
      period=7200,
      offset=7,
      startTime=2000,
      amplitude=10)
      annotation (Placement(transformation(extent={{-146,-16},{-134,-4}})));
    Modelica.Blocks.Math.Add add_BOP
      annotation (Placement(transformation(extent={{-126,-10},{-106,10}})));
    Modelica.Blocks.Math.Gain MW_W_Gain_BOP(k=1e6)
      annotation (Placement(transformation(extent={{-98,-6},{-86,6}})));
    Modelica.Blocks.Math.Add add_SES
      annotation (Placement(transformation(extent={{-126,-90},{-106,-70}})));
    Modelica.Blocks.Sources.Pulse pulse_SES(
      period=7200,
      offset=13,
      startTime=1500,
      amplitude=13)
      annotation (Placement(transformation(extent={{-146,-96},{-134,-84}})));
    Modelica.Blocks.Math.Gain MW_W_Gain_SES(k=1e6)
      annotation (Placement(transformation(extent={{-98,-86},{-86,-74}})));
    Modelica.Blocks.Math.Add add_TES
      annotation (Placement(transformation(extent={{-126,-50},{-106,-30}})));
    Modelica.Blocks.Sources.Pulse pulse_TES(
      period=7200,
      offset=0,
      startTime=2500,
      amplitude=14)
      annotation (Placement(transformation(extent={{-146,-56},{-134,-44}})));
    Modelica.Blocks.Math.Gain MW_W_Gain_TES(k=1e6)
      annotation (Placement(transformation(extent={{-98,-46},{-86,-34}})));
    Modelica.Blocks.Interfaces.RealInput BOP_Demand_MW annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=0,
          origin={-146,6}),  iconTransformation(extent={{-120,48},{-96,72}})));
    Modelica.Blocks.Interfaces.RealInput SES_Demand_MW annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=0,
          origin={-146,-74}), iconTransformation(extent={{-120,-72},{-96,-48}})));
    Modelica.Blocks.Interfaces.RealInput TES_Demand_MW annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=0,
          origin={-146,-34}), iconTransformation(extent={{-120,-12},{-96,12}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_Basic_NoFeedHeat_mFlow_Control
      Dch_BOP(
      port_a_nominal(
        p=3388000,
        h=2.99767e+6,
        m_flow=66.4),
      port_b_nominal(p=3447380, h=629361),
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_NoFeedHeat_mFlow_Control
        CS(electric_demand_large=MW_W_Gain_TES.y),
      init(condensor_V_liquid_start=50))
      annotation (Placement(transformation(extent={{46,-28},{112,28}})));
    NHES.Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{34,-16},{48,0}})));
    NHES.Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{48,0},{34,16}})));
    NHES.Systems.EnergyStorage.SHS_Two_Tank.Models.Two_Tank_SHS_HT_Power_ANL
      TES(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems.CS_TES_HT_Power_ANL
        CS(electric_demand_TES=MW_W_Gain_TES.y, Round_Trip_Efficiency=0.21),
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_SHS data(
        ht_level_max=11.7,
        ht_area=3390,
        ht_surface_pressure=120000,
        hot_tank_init_temp=513.15,
        cold_tank_level_max=11.7,
        cold_tank_area=3390,
        ct_surface_pressure=120000,
        cold_tank_init_temp=453.15,
        m_flow_ch_min=0.1,
        DHX_NTU=20,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4"),
        DHX_p_start_tube=120000,
        DHX_h_start_tube_inlet=272e3,
        DHX_h_start_tube_outlet=530e3,
        charge_pump_dp_nominal=1200000,
        charge_pump_m_flow_nominal=900,
        charge_pump_constantRPM=3000,
        disvalve_dp_nominal=100000,
        chvalve_m_flow_nom=900,
        disvalve_m_flow_nom=900,
        chvalve_dp_nominal=100000),
      redeclare package Storage_Medium = NHES.Media.Hitec.Hitec,
      tank_height=11.7,
      Steam_Output_Temp=stateSensor6.temperature.T)
      annotation (Placement(transformation(extent={{-12,-20},{28,28}})));
  equation
     BOP_Electric_Power = BOP.sensorW.W;
     BOP_Turbine_Pressure = BOP.HPT.portHP.p;

     SES_Electric_Power = -1*SES.portElec_b.W;
     SES_Firing_Temperature = SES.GTunit.Tf;

     TES_HotTank_Level = TES.hot_tank.level;
     TES_HT_Level_Ramprate = der(TES.hot_tank.level);

    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{-20,52},{10,52}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1])
      annotation (Line(points={{50,60},{60,60},{60,58.5333}},
                                                           color={255,0,0}));
    connect(EM.port_b2, stateSensor2.port_a) annotation (Line(points={{-20,68},
            {-14,68}},                          color={0,127,255}));
    connect(stateSensor2.port_b, BOP.port_a)
      annotation (Line(points={{1.77636e-15,68},{10,68}}, color={0,127,255}));
    connect(stateSensor4.port_a, EM.port_b3[1]) annotation (Line(points={{-30,-12},
            {-32,-12},{-32,39}},          color={0,127,255}));
    connect(stateSensor5.port_b, BOP.port_a1) annotation (Line(points={{1.77636e-15,
            36},{17.2,36},{17.2,40.8}}, color={0,127,255}));
    connect(SY.port_Grid, sensorW.port_a)
      annotation (Line(points={{100,60},{104,60}},
                                                 color={255,0,0}));
    connect(sensorW.port_b, EG.portElec_a)
      annotation (Line(points={{116,60},{120,60}},
                                                 color={255,0,0}));
    connect(EM.port_a1, stateSensor1.port_b)
      annotation (Line(points={{-60,68},{-66,68}}, color={0,127,255}));
    connect(EM.port_b1, stateSensor3.port_a)
      annotation (Line(points={{-60,52},{-66,52}}, color={0,127,255}));
    connect(stateSensor3.port_b, sink.ports[1]) annotation (Line(points={{-80,52},
            {-104,52}},                       color={0,127,255}));
    connect(SteamSource.ports[1], stateSensor1.port_a) annotation (Line(
          points={{-100,68},{-80,68}},                   color={0,127,255}));
    connect(pBalance_sink.ports[1], EM.port_b3[2]) annotation (Line(points={{-104,30},
            {-92,30},{-92,36},{-32,36},{-32,41}},     color={0,127,255}));
    connect(SES.portElec_b, SY.port_a[2]) annotation (Line(points={{102,-60},{106,
            -60},{106,30},{56,30},{56,60},{60,60},{60,60}},
                                        color={255,0,0}));
    connect(add_BOP.y,MW_W_Gain_BOP. u)
      annotation (Line(points={{-105,0},{-99.2,0}},  color={0,0,127}));
    connect(BOP_Demand_MW,add_BOP. u1) annotation (Line(points={{-146,6},{
            -128,6}},             color={0,0,127}));
    connect(pulse_BOP.y,add_BOP. u2) annotation (Line(points={{-133.4,-10},{
            -128,-10},{-128,-6}}, color={0,0,127}));
    connect(SES_Demand_MW,add_SES. u1)
      annotation (Line(points={{-146,-74},{-128,-74}},
                                                    color={0,0,127}));
    connect(pulse_SES.y,add_SES. u2) annotation (Line(points={{-133.4,-90},{
            -128,-90},{-128,-86}},
                          color={0,0,127}));
    connect(add_SES.y,MW_W_Gain_SES. u)
      annotation (Line(points={{-105,-80},{-99.2,-80}},
                                                 color={0,0,127}));
    connect(TES_Demand_MW,add_TES. u1)
      annotation (Line(points={{-146,-34},{-128,-34}},   color={0,0,127}));
    connect(pulse_TES.y,add_TES. u2)
      annotation (Line(points={{-133.4,-50},{-128,-50},{-128,-46}},
                                                           color={0,0,127}));
    connect(add_TES.y,MW_W_Gain_TES. u)
      annotation (Line(points={{-105,-40},{-99.2,-40}},  color={0,0,127}));
    connect(stateSensor6.port_b,Dch_BOP. port_a) annotation (Line(points={{48,-8},
            {50,-8},{50,2},{58.375,2},{58.375,8}},        color={0,127,255}));
    connect(stateSensor7.port_a,Dch_BOP. port_b) annotation (Line(points={{48,8},{
            54,8},{54,-8},{58.375,-8}},           color={0,127,255}));
    connect(TES.port_dch_a,stateSensor7. port_b) annotation (Line(points={{27.6,11.6},
            {27.6,12},{34,12},{34,8}},             color={0,127,255}));
    connect(TES.port_dch_b,stateSensor6. port_a) annotation (Line(points={{28,-12.4},
            {28,-12},{34,-12},{34,-8}},              color={0,127,255}));
    connect(Dch_BOP.portElec_b, SY.port_a[3]) annotation (Line(points={{99.625,
            0},{106,0},{106,30},{56,30},{56,61.4667},{60,61.4667}},
                                                                 color={255,0,0}));
    connect(stateSensor4.port_b, TES.port_ch_a)
      annotation (Line(points={{-16,-12},{-11.6,-12.4}}, color={0,127,255}));
    connect(stateSensor5.port_a, TES.port_ch_b) annotation (Line(points={{-14,36},
            {-18,36},{-18,10.8},{-11.6,10.8}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
              -100},{160,100}}), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-30,64},{70,4},{-30,-56},{-30,64}})}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-160,-100},{160,100}})),
      experiment(
        StopTime=10800,
        Interval=10,
        Tolerance=1e-06,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end FARM_Control_BOP_TES_SES_Test;
end IntegratedEnergySystem;
