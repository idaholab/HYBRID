within NHES.Systems.Examples;
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
