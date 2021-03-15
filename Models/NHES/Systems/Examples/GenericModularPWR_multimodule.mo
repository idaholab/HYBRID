within NHES.Systems.Examples;
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

  BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
    port_a_nominal(
      p=EM.port_b2_nominal.p,
      h=EM.port_b2_nominal.h,
      m_flow=-EM.port_b2_nominal.m_flow),
    port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
    port_a3_nominal_p={IP.port_b_nominal.p},
    port_a3_nominal_h={IP.port_b_nominal.h},
    port_a3_nominal_m_flow={-IP.port_b_nominal.m_flow},
    nPorts_a3=1,
    redeclare BalanceOfPlant.Turbine.CS_PressureAndPowerControl CS(
      p_nominal=BOP.port_a_nominal.p,
      W_totalSetpoint=SC.W_totalSetpoint_BOP,
      delayStartTCV=200))
    "{IP.port_b_nominal.p}{IP.port_b_nominal.h}{-IP.port_b_nominal.m_flow}"
    annotation (Placement(transformation(extent={{-18,82},{38,138}})));
  EnergyStorage.Battery.Logical ES(
    capacity_max=dataCapacity.ES_capacity,
    capacity_min=0.2*dataCapacity.ES_capacity,
    chargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
        /Modelica.Units.Conversions.from_hour(1),
    dischargePower_max=0.25*Modelica.Units.Conversions.from_Wh(dataCapacity.ES_capacity)
        /Modelica.Units.Conversions.from_hour(1),
    redeclare EnergyStorage.Battery.CS_InputSetpoint CS(W_totalSetpoint=SC.W_totalSetpoint_ES))
    annotation (Placement(transformation(extent={{-18,2},{38,58}})));
     SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl SES(capacity=
        dataCapacity.SES_capacity, redeclare
      SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
      capacityScaler=SES.capacityScaler,
      delayStart=delayStart.k,
      W_totalSetpoint=SC.W_totalSetpoint_SES))    annotation (Placement(transformation(extent={{-18,-78},{38,-22}})));
     SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=4) annotation (Placement(transformation(extent={{82,2},{138,58}})));
     ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{162,2},{218,58}})));
  IndustrialProcess.HeaderTurbineCombo.StepDownTurbines IP(port_a_nominal(
      p=IP.data.p_HP,
      h=IP.data.h_HP,
      m_flow=IP.data.m_flow_total), port_b_nominal(p=IP.data.p_LP, h=IP.data.h_LP),
    redeclare IndustrialProcess.HeaderTurbineCombo.ED_Inputs ED(
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
