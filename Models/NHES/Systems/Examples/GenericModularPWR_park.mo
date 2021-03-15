within NHES.Systems.Examples;
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
  BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
    redeclare BalanceOfPlant.Turbine.CS_PressureAndPowerControl CS(p_nominal=
          BOP.port_a_nominal.p, W_totalSetpoint=SC.W_totalSetpoint_BOP),
    port_a_nominal(
      p=EM.port_b2_nominal.p,
      h=EM.port_b2_nominal.h,
      m_flow=-EM.port_b2_nominal.m_flow),
    port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h))
    "{IP.port_b_nominal.p}{IP.port_b_nominal.h}{-IP.port_b_nominal.m_flow}"
    annotation (Placement(transformation(extent={{-18,82},{38,138}})));
     IndustrialProcess.HighTempSteamElectrolysis.TightlyCoupled_SteamFlowCtrl_FY17
       IP(
    capacity=dataCapacity.IP_capacity,
    port_a_nominal(m_flow=IP.capacityScaler_steamFlow*7.311637),
    redeclare
      IndustrialProcess.HighTempSteamElectrolysis.CS_TightlyCoupled_SteamFlowCtrl_stepInput_FY17
      CS(capacityScaler=IP.capacityScaler),
    flowSplit(port_2(h_outflow(start=2.95398e6, fixed=false))),
    returnPump(PR0=62.7/51.3042, pstart_out=6270000),
    hEX_nuclearHeatCathodeGasRecup_ROM(hShell_out(start=962881, fixed=false)))  annotation (Placement(transformation(extent={{-118,-38},{-62,18}})));
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
  connect(PHS.port_a, volume1.port_b[1:3]) annotation (Line(points={{-142,98.8},
          {-134,98.8},{-134,98.6667},{-126,98.6667}}, color={0,127,255}));
  connect(volume1.port_a[1], EM.port_b1) annotation (Line(points={{-114,98},{
          -106,98},{-106,98.8},{-98,98.8}}, color={0,127,255}));
  connect(volume.port_b[1], EM.port_a1) annotation (Line(points={{-114,120},{
          -106,120},{-106,121.2},{-98,121.2}}, color={0,127,255}));
  connect(PHS.port_b, volume.port_a[1:3]) annotation (Line(points={{-142,121.2},
          {-134,121.2},{-134,120.667},{-126,120.667}}, color={0,127,255}));
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
