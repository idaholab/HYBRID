within NHES.Systems.Examples.TES_Use_Case;
model SMR_SHS_Test_2
 parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
 parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
 Real demandChange=
 min(1.05,
 max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
     + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
     0.5));
  PrimaryHeatSystem.SMR_Generic.Components.SMR_Taveprogram_No_Pump
                                                           SMR_Taveprogram(
    port_b_nominal(
      p=3447380,
      T(displayUnit="degC") = 579.75,
      h=2997670),
    redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave CS(W_turbine=
          intermediate_Rankine_Cycle_TESUC.powerSensor.power, W_Setpoint=SC.W_totalSetpoint_BOP),
    port_a_nominal(
      m_flow=67.07,
      T(displayUnit="degC") = 421.15,
      p=3447380))
    annotation (Placement(transformation(extent={{-84,-26},{-34,30}})));

  EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
      p=SMR_Taveprogram.port_b_nominal.p,
      h=SMR_Taveprogram.port_b_nominal.h,
      m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
          SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h),
    port_b3_nominal_m_flow={-33},
    nPorts_b3=1)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  BalanceOfPlant.Turbine.Intermediate_Rankine_Cycle_TESUC
    intermediate_Rankine_Cycle_TESUC(
    port_a_nominal(
      p=EM.port_b2_nominal.p,
      h=EM.port_b2_nominal.h,
      m_flow=-EM.port_b2_nominal.m_flow),
    port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
    redeclare
      BalanceOfPlant.Turbine.ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp
      CS) annotation (Placement(transformation(extent={{62,-20},{102,20}})));
  SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)
    annotation (Placement(transformation(extent={{112,-22},{152,22}})));
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
  EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_TESUC
    two_Tank_SHS_System_NTU(
    redeclare NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Basic_TESUC CS,
    redeclare replaceable EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        DHX_K_tube(unit="1/m4"), DHX_K_shell(unit="1/m4")),
                                 Produced_steam_flow=10)
    annotation (Placement(transformation(extent={{-20,-78},{20,-38}})));
  TRANSFORM.Fluid.Valves.ValveLinear SHS_Throttle(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=400,
    dp_nominal=500000,
    m_flow_nominal=30) annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={40,-32})));
  Modelica.Blocks.Sources.Constant const(k=0.05)
    annotation (Placement(transformation(extent={{2,36},{22,56}})));
  BalanceOfPlant.Turbine.Intermediate_Rankine_Cycle_TESUC_SmallCycle
                                                    intermediate_Rankine_Cycle_TESUC1(
    redeclare
      BalanceOfPlant.Turbine.ControlSystems.CS_IntermediateControl_PID_6
      CS,
    port_a_nominal(
      p=1150000,
      h=1.1e6,
      m_flow=20),
    port_b_nominal(
      p=1200000,
      h=1.2e6,
      m_flow=-20),
    port_a_start(
      p=1100000,
      h=1.2e6,
      m_flow=20),
    port_b_start(
      p=1200000,
      h=1.1e6,
      m_flow=-20))
    annotation (Placement(transformation(extent={{64,-76},{104,-36}})));
equation
  connect(SMR_Taveprogram.port_b, EM.port_a1) annotation (Line(points={{
          -33.0909,12.7692},{-30,12.7692},{-30,8},{-20,8}}, color={0,127,255}));
  connect(SMR_Taveprogram.port_a, EM.port_b1) annotation (Line(points={{-33.0909,
          -1.44615},{-30,-1.44615},{-30,-8},{-20,-8}}, color={0,127,255}));
  connect(EM.port_b2, intermediate_Rankine_Cycle_TESUC.port_a)
    annotation (Line(points={{20,8},{62,8}}, color={0,127,255}));
  connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
    annotation (Line(points={{20,-8},{62,-8}}, color={0,127,255}));
  connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
    annotation (Line(points={{102,0},{108,0},{108,-1.1},{112,-1.1}}, color={255,
          0,0}));
  connect(SY.port_Grid, EG.portElec_a)
    annotation (Line(points={{152,0},{160,0}}, color={255,0,0}));
  connect(EM.port_b3[1], two_Tank_SHS_System_NTU.port_ch_a) annotation (Line(
        points={{8,-20},{8,-32},{-40,-32},{-40,-70.4},{-19.6,-70.4}}, color={0,
          127,255}));
  connect(SHS_Throttle.port_a, two_Tank_SHS_System_NTU.port_ch_b) annotation (
      Line(points={{32,-32},{16,-32},{16,-34},{-26,-34},{-26,-47.2},{-19.6,-47.2}},
        color={0,127,255}));
  connect(const.y, SHS_Throttle.opening)
    annotation (Line(points={{23,46},{40,46},{40,-25.6}}, color={0,0,127}));
  connect(intermediate_Rankine_Cycle_TESUC1.portElec_b, SY.port_a[2])
    annotation (Line(points={{104,-56},{110,-56},{110,-26},{108,-26},{108,1.1},{
          112,1.1}}, color={255,0,0}));
  connect(two_Tank_SHS_System_NTU.port_dch_a, intermediate_Rankine_Cycle_TESUC1.port_b)
    annotation (Line(points={{19.6,-46.4},{32,-46.4},{32,-64},{64,-64}}, color={
          0,127,255}));
  connect(two_Tank_SHS_System_NTU.port_dch_b, intermediate_Rankine_Cycle_TESUC1.port_a)
    annotation (Line(points={{20,-70.4},{36,-70.4},{36,-70},{48,-70},{48,-48},{64,
          -48}}, color={0,127,255}));
  connect(SHS_Throttle.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
    annotation (Line(points={{48,-32},{60,-32},{60,-28},{69.2,-28},{69.2,-19.2}},
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
                points={{16,62},{116,2},{16,-58},{16,62}})}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{200,100}})),
    experiment(
      StopTime=3600,
      __Dymola_NumberOfIntervals=3600,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
    __Dymola_experimentSetupOutput(events=false));
end SMR_SHS_Test_2;
