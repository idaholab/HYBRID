within NHES.Systems.Examples;
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
  BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
    redeclare BalanceOfPlant.Turbine.CS_PressureAndPowerControl CS(p_nominal=
          BOP.port_a_nominal.p, W_totalSetpoint=SC.W_totalSetpoint_BOP),
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
  IndustrialProcess.HeaderTurbineCombo.StepDownTurbine IP(port_a_nominal(
      p=IP.data.p_HP,
      h=IP.data.h_HP,
      m_flow=IP.data.m_flow_total), port_b_nominal(p=IP.data.p_IP, h=IP.data.h_IP))
    annotation (Placement(transformation(extent={{-150,2},{-94,58}})));
  IndustrialProcess.HeaderTurbineCombo.StepDownTurbine IP1(port_a_nominal(
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
