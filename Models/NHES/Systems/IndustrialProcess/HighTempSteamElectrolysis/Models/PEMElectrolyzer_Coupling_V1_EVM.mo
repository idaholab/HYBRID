within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Models;
model PEMElectrolyzer_Coupling_V1_EVM
  // ============================================================================
// PEM subsystem replacing HTSE (keeps reporting pattern + electrical port point)
// Note: This is written in the same "subsystem" style as FY17, but simplified.
//       Thermal recuperation is re-defined for PEM feedwater preheat HX.
// ============================================================================

//package IndustrialProcess
//package PEMElectrolysis
//  model TightlyCoupled_SteamFlowCtrl_PEM_FY17
    import      Modelica.Units.SI;
    import TRANSFORM.Icons.InterfacesPackage;
    import NHES.Systems.Interfaces;

    extends BaseClasses.Partial_SubSystem_B(
      allowFlowReversal=system.allowFlowReversal,
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      port_a_nominal(p=5.8e6, T=591, m_flow=7.311637*capacityScaler_feed),
      port_b_nominal(p=6.19e6, T=497.15),
      redeclare Data.TightlyCoupled data(IP_Q_totalElec(displayUnit="MW")=53303300));
      // Keep nominal port structure similar to FY17 (water/steam side)

    // --------------------------
    // Capacity + reporting pattern (as FY17)
    // --------------------------
    final parameter SI.Power capacity_nom(displayUnit="MW") = 53.3033e6
      "Nominal electrical power consumption";
    parameter SI.Power capacity(displayUnit="MW") = capacity_nom "System capacity";
    final parameter Real capacityScaler = capacity/capacity_nom;
    final parameter Real capacityScaler_minThreshhold = 0.85;
    final parameter Real capacityScaler_maxThreshhold = 2.4;
    final parameter Real capacityScaler_feed=
      if capacityScaler < capacityScaler_minThreshhold then capacityScaler_minThreshhold
      elseif capacityScaler > capacityScaler_maxThreshhold then capacityScaler_maxThreshhold
      else capacityScaler;

    // --------------------------
    // PEM operating temperature target (low-temp)
    // --------------------------
    parameter SI.Temperature T_PEM_set = 353.15
      "Target PEM feedwater temperature [K]";

    // --------------------------
    // Reporting variables (keep pattern)
    // --------------------------
    SI.MassFlowRate mH2_sec "H2 produced during electrolysis per second";
    NHES.Electrolysis.Types.AnnualMassFlowRate mH2_yr "H2 produced per year";

    SI.MassFlowRate mO2_sec "O2 produced during electrolysis per second";
    NHES.Electrolysis.Types.AnnualMassFlowRate mO2_yr "O2 produced per year";

    // Thermal “recuperation” updated: turbine steam -> feedwater preheat
    SI.Power Q_steamToFeedwater "Heat transferred from turbine steam to PEM feedwater";
    SI.Power Wq_steamToFeedwater "Electrical equiv. of Q (optional)";
    SI.Power W_total "Total energy consumption in PEM plant";
    Real We_PEM_percent(min=0,max=100,unit="1",displayUnit="%");
    Real Wq_PEM_percent(min=0,max=100,unit="1",displayUnit="%");

    // --------------------------
    // Electrical interface (maintain connection point via portElec_a)
    // (FY17 uses PowerSource + Electrical.Load + PowerSensorScalable) (Page 4)
    // --------------------------
    Electrolysis.Sensors.PowerSensorScalable W_PEM(capacityScaler=capacityScaler)
      annotation (Placement(transformation(extent={{8,-8},{-8,8}}, rotation=90, origin={180,20})));

    Electrical.Sources.PowerSource W_IP(use_W_in=true, W(displayUnit="MW")=capacity_nom)
      annotation (Placement(transformation(extent={{-6,6},{6,-6}}, rotation=270, origin={180,46})));

    Electrical.Load load_IP(Wn=0, fn=60)
      annotation (Placement(transformation(extent={{-14,-14},{14,14}}, rotation=180, origin={176,-40})));

    // Drive power from "capacity" (placeholder; replace with real PEM stack power)
    Modelica.Blocks.Sources.RealExpression Wcmd(y=capacity)
      annotation (Placement(transformation(extent={{150,58},{170,78}})));

    // --------------------------
    // Water side: feedwater comes from plant port_a, returns to port_b
    // Add a heat exchanger between turbine steam (hot side) and feedwater (cold side).
    // We'll implement a simple heater/cooler style using Modelica.Fluid heat exchanger shell.
    // --------------------------
    Modelica.Fluid.Sensors.Temperature T_feed_in(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-182,30},{-198,46}})));
    Modelica.Fluid.Sensors.Temperature T_feed_toPEM(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-182,-10},{-198,6}})));
    Modelica.Fluid.Sensors.MassFlowRate mH2O_in(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{8,-8},{-8,8}}, rotation=90, origin={-180,0})));

    // Cold side: feedwater pipe
    Modelica.Fluid.Pipes.StaticPipe feedPipe(
      redeclare package Medium = Medium,
      length=5, diameter=0.2)
      annotation (Placement(transformation(extent={{-150,10},{-130,30}})));

    // "Preheater" using a simple prescribed heat flow (keeps model robust without needing a full HX model library)
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor feedCap(C=1e6)
      annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Qdot_preheat
      annotation (Placement(transformation(extent={{-150,-40},{-130,-20}})));
    Modelica.Blocks.Continuous.FirstOrder preheatActuator(k=1, T=10)
      annotation (Placement(transformation(extent={{-180,-40},{-160,-20}})));

    // Hot side “turbine steam” interface into this subsystem: reuse port_a/port_b? No—keep water ports as in FY17,
    // but add an extra steam inlet/outlet pair for the preheater.
    Modelica.Fluid.Interfaces.FluidPort_a steamIn(redeclare package Medium =
        Modelica.Media.Water.IdealSteam)
      annotation (Placement(transformation(extent={{-210,84},{-190,104}})));
    Modelica.Fluid.Interfaces.FluidPort_b steamOut(redeclare package Medium =
        Modelica.Media.Water.IdealSteam)
      annotation (Placement(transformation(extent={{-210,50},{-190,70}})));

    // Measure steam-side temperatures for reporting only
    Modelica.Fluid.Sensors.Temperature T_steam_in(redeclare package Medium =
        Modelica.Media.Water.IdealSteam)
      annotation (Placement(transformation(extent={{-176,82},{-160,98}})));
    Modelica.Fluid.Sensors.Temperature T_steam_out(redeclare package Medium =
        Modelica.Media.Water.IdealSteam)
      annotation (Placement(transformation(extent={{-176,52},{-160,68}})));

    // --------------------------
    // Simple PEM hydrogen production surrogate:
    // Use electrical power to set H2 production proportional to capacity.
    // Keep same reporting pattern as FY17 (Page 1, Section 4/4).
    // --------------------------
    parameter Real eta_elec_to_H2(unit="kg/J") = 1.0e-8
      "Placeholder conversion: kg H2 per Joule electric";
    Modelica.Blocks.Interfaces.RealOutput mH2_toTank(unit="kg/s")
      annotation (Placement(transformation(extent={{200,90},{220,110}})));

    // Inner system like FY17 (Page 6)
    inner Modelica.Fluid.System system(allowFlowReversal=false, T_ambient=298.15, m_flow_start=7.311637)
      annotation (Placement(transformation(extent={{180,120},{200,140}})));

equation
    // Water-side main connections
    connect(mH2O_in.port_a, port_a) annotation (Line(points={{-180,8},{-180,20},{-200,20}}, color={0,127,255}));
    connect(T_feed_in.port, port_a) annotation (Line(points={{-190,30},{-190,20},{-200,20}}, color={0,127,255}));
    connect(port_a, feedPipe.port_a) annotation (Line(points={{-200,20},{-150,20}}, color={0,127,255}));
    connect(feedPipe.port_b, port_b) annotation (Line(points={{-130,20},{-120,20},
          {-120,-140},{-200,-140}},                                                                       color={0,127,255}));
    connect(T_feed_toPEM.port, port_b) annotation (Line(points={{-190,-10},{-190,
          -140},{-200,-140}},                                                                      color={0,127,255}));

    // Electrical: maintain same pattern connection point
    connect(Wcmd.y, W_IP.W_in) annotation (Line(points={{171,68},{180,68},{180,53.2}},
                                                                                     color={0,0,127}));
    connect(W_IP.portElec_a, load_IP.portElec_a) annotation (Line(points={{180,40},
          {176,40},{176,-51.2}},                                                                        color={255,0,0}));
    connect(load_IP.portElec_a, W_PEM.port_a) annotation (Line(points={{176,
          -51.2},{180,-51.2},{180,28}},                                                                     color={255,0,0}));
    connect(load_IP.portElec_a, portElec_a) annotation (Line(points={{176,-51.2},
          {200,-51.2},{200,-60}},                                                                    color={255,0,0}));

    // Steam ports (for preheat reporting only; a full HX is out of scope here without adding a specific HX library component)
    connect(steamIn, T_steam_in.port) annotation (Line(points={{-200,94},{-184,
          94},{-184,82},{-168,82}},                                                  color={0,127,255}));
    connect(T_steam_out.port, steamOut) annotation (Line(points={{-168,52},{-184,
          52},{-184,60},{-200,60}},                                                    color={0,127,255}));

    // Preheat control: drive heat flow to move feedwater toward T_PEM_set
    preheatActuator.u = (T_PEM_set - T_feed_in.T);
    Qdot_preheat.Q_flow = preheatActuator.y*1e6;

    connect(Qdot_preheat.port, feedCap.port) annotation (Line(points={{-130,-30},
          {-120,-30},{-120,-40},{-110,-40}},                                                  color={191,0,0}));

    // Thermal reporting placeholders
    Q_steamToFeedwater = max(0, Qdot_preheat.Q_flow);
    Wq_steamToFeedwater = Q_steamToFeedwater*0.318; // reuse eta_powerCycle idea (FY17 has eta_powerCycle=0.318) (Page 1)
    W_total = W_PEM.W + Wq_steamToFeedwater;
    We_PEM_percent = if W_total > 0 then (W_PEM.W/W_total)*100 else 0;
    Wq_PEM_percent = if W_total > 0 then (Wq_steamToFeedwater/W_total)*100 else 0;

    // H2/O2 production and annual reporting (keep FY17 pattern) (Page 1, Section 4/4)
    mH2_sec = capacity * eta_elec_to_H2;
    mH2_yr = mH2_sec*60*60*24*365;

    mO2_sec = 0.5*mH2_sec; // placeholder stoichiometry (mass basis not exact)
    mO2_yr = mO2_sec*60*60*24*365;

    mH2_toTank = mH2_sec;

//  end TightlyCoupled_SteamFlowCtrl_PEM_FY17;
//end PEMElectrolysis;
//end IndustrialProcess
    annotation (
      defaultComponentName="IP",
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-220},{200,140}})),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}, fillColor={245,245,245},
            fillPattern =                                                                                   FillPattern.Solid),
          Text(extent={{-96,74},{96,66}}, textString="PEM Electrolysis"),
          Text(extent={{-96,54},{96,46}}, textString="(Low-Temperature)")}),
      experiment(StopTime=4000, __Dymola_NumberOfIntervals=4000, __Dymola_Algorithm="Esdirk45a"),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PEMElectrolyzer_Coupling_V1_EVM;
