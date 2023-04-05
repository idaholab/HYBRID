within NHES.Systems.IndustrialProcess.IS_Dummy.Examples;
model SMR_Coupling_Test_IP_Dummy
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
        W_Setpoint=SC.W_totalSetpoint_BOP,
      PID_FeedPump(yMax=87)),
    port_a_nominal(
      m_flow=70,
      T(displayUnit="degC") = 421.15,
      p=3447380))
    annotation (Placement(transformation(extent={{-86,-26},{-36,30}})));
  EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
      p=SMR_Taveprogram.port_b_nominal.p,
      h=SMR_Taveprogram.port_b_nominal.h,
      m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
          SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h),
    port_b3_nominal_p={SMR_Taveprogram.port_b_nominal.p},
    port_b3_nominal_h={SMR_Taveprogram.port_b_nominal.h},
    port_b3_nominal_m_flow={5},
    nPorts_b3=1)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
    port_a_nominal(
      p=EM.port_b2_nominal.p,
      h=EM.port_b2_nominal.h,
      m_flow=-EM.port_b2_nominal.m_flow),
    port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
    redeclare BalanceOfPlant.Turbine.ControlSystems.CS_OTSG_Pressure CS(
      W_totalSetpoint=SC.W_totalSetpoint_BOP,
      p_nominal=BOP.port_a_nominal.p,
      Reactor_Power(displayUnit="MW") = 160000000,
      Nominal_Power(displayUnit="MW") = 160000000),
    port_a3_nominal_p={101325},
    port_a3_nominal_h={800e3},
    port_a3_nominal_m_flow={5},
    nPorts_a3=1)
    annotation (Placement(transformation(extent={{42,-20},{82,20}})));
  SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
    annotation (Placement(transformation(extent={{100,-22},{140,22}})));
  ElectricalGrid.InfiniteGrid.Infinite EG
    annotation (Placement(transformation(extent={{160,-20},{200,20}})));
  NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(
        displayUnit="MW") = 53303300, BOP_capacity(displayUnit="MW") =
      1165000000)
    annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
  Modelica.Blocks.Sources.Constant delayStart(k=0)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
    W_nominal_BOP(displayUnit="MW") = 50000000,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://NHES/Resources/Data/RAVEN/Nominal_50_timeSeries.txt"))
    annotation (Placement(transformation(extent={{160,60},{200,100}})));
  Components.IS_Dummy_connections
                  iS_Dummy_connections(redeclare
      NHES.Systems.IndustrialProcess.IS_Dummy.CS.CS_IES CS(demand=DemandSignal.y))
    annotation (Placement(transformation(extent={{-30,28},{30,-28}},
        rotation=270,
        origin={44,-70})));
  Modelica.Blocks.Sources.Trapezoid DemandSignal(
    amplitude=10,
    rising=600,
    width=1800,
    falling=600,
    period=4800,
    startTime=400)
    annotation (Placement(transformation(extent={{-12,84},{8,104}})));
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
  connect(EM.port_b3[1], iS_Dummy_connections.port_a) annotation (Line(points={
          {8,-20},{8,-30},{28.88,-30},{28.88,-39.4}}, color={0,127,255}));
  connect(iS_Dummy_connections.port_b, BOP.port_a3[1]) annotation (Line(points=
          {{57.44,-39.4},{57.44,-28},{54,-28},{54,-20}}, color={0,127,255}));
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
end SMR_Coupling_Test_IP_Dummy;
