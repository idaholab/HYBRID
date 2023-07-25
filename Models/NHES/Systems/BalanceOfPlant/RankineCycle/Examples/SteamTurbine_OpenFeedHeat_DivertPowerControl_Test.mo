within NHES.Systems.BalanceOfPlant.RankineCycle.Examples;
model SteamTurbine_OpenFeedHeat_DivertPowerControl_Test
  "TES use case demonstration of a NuScale-style LWR operating within an energy arbitrage IES, storing and dispensing energy on demand from a two tank molten salt energy storage system nominally using HITEC salt to store heat."
 // parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
 // parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
 parameter Modelica.Units.SI.Time timeScale=60*60
    "Time scale of first table column";
 parameter String fileName=Modelica.Utilities.Files.loadResource(
    "modelica://NHES/Resources/Data/RAVEN/DMM_Dissertation_Demand.txt")
  "File where matrix is stored";
    replaceable package Storage_Medium =
      TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);

    replaceable package Charging_Medium =
      Modelica.Media.Water.StandardWater                                     constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab="General",
        group="Mediums"), choicesAllMatching=true);

    replaceable package Discharging_Medium =
      Modelica.Media.Water.StandardWater                                          constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab="General",
        group="Mediums"), choicesAllMatching=true);

//  Real demandChange=
//  min(1.05,
//  max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
//      + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
//      0.5));

  NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
    annotation (Placement(transformation(extent={{60,38},{100,82}})));
  NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
    annotation (Placement(transformation(extent={{120,40},{160,80}})));
  NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(
        displayUnit="MW") = 53303300, BOP_capacity(displayUnit="MW")=
      1165000000)
    annotation (Placement(transformation(extent={{100,-62},{120,-42}})));
  NHES.Systems.SupervisoryControl.InputSetpointData SC(
    delayStart=0,
    W_nominal_BOP(displayUnit="MW") = 50000000,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://NHES/Resources/Data/RAVEN/Nominal_50_timeSeries.txt"))
    annotation (Placement(transformation(extent={{120,-62},{160,-22}})));

  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{104,54},{116,66}})));

  NHES.Fluid.Sensors.stateSensor stateSensor5(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{30,22},{44,38}})));
  NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(
    port_a1_nominal(
      p(displayUnit="Pa") = 3.398e6,
      h=2.99767e6,
      m_flow=67.07),
    port_b1_nominal(p=3447380, h=629361),
    port_b3_nominal_m_flow={-0.67},
    nPorts_b3=1)
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
    annotation (Placement(transformation(extent={{6,40},{46,80}})));
  NHES.Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-80,60},{-66,76}})));
  NHES.Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-14,60},{0,76}})));
  NHES.Fluid.Sensors.stateSensor stateSensor3(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-66,44},{-80,60}})));
  Modelica.Fluid.Sources.Boundary_pT sink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p(displayUnit="bar") = 3400000,
    T(displayUnit="degC") = 421.15)
    annotation (Placement(transformation(extent={{-120,60},{-104,44}})));
  Modelica.Fluid.Sources.MassFlowSource_T SteamSource(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=67.53,
    T(displayUnit="K") = 581.24,
    nPorts=1)
    annotation (Placement(transformation(extent={{-120,58},{-100,78}})));
  NHES.Fluid.Sensors.stateSensor stateSensor4(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-20,22},{-6,38}})));
  Modelica.Fluid.Sources.MassFlowSource_h Storage_Med_Source(
    redeclare package Medium = Storage_Medium,
    use_m_flow_in=false,
    m_flow=400,
    h=257097,
    nPorts=1) annotation (Placement(transformation(extent={{80,2},{60,22}})));
  Modelica.Fluid.Sources.Boundary_pT Oil_Sink(
    redeclare package Medium = Storage_Medium,
    use_p_in=false,
    p(displayUnit="bar") = 130000,
    T(displayUnit="degC") = 523.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,20},{-24,4}})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                      CHX(
    shell_av_b=true,
    use_derQ=true,
    tau=1,
    NTU=20,
    K_tube=1000,
    K_shell=1000,
    redeclare package Tube_medium = Storage_Medium,
    redeclare package Shell_medium = Charging_Medium,
    V_Tube=10,
    V_Shell=25,
    use_T_start_tube=true,
    T_start_tube_inlet=573.15,
    T_start_tube_outlet=573.15,
    dp_init_tube=20000,
    Q_init=1)          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={14,16})));
  NHES.Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{50,4},{36,20}})));
  NHES.Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-6,4},{-20,20}})));
  Modelica.Blocks.Sources.Pulse pulse_BOP(
    period=7200,
    offset=17,
    startTime=2500,
    amplitude=10)
    annotation (Placement(transformation(extent={{-106,4},{-94,16}})));
  Modelica.Blocks.Math.Add add_BOP
    annotation (Placement(transformation(extent={{-86,10},{-66,30}})));
  Modelica.Blocks.Math.Gain MW_W_Gain_BOP(k=1e6)
    annotation (Placement(transformation(extent={{-58,14},{-46,26}})));
  Modelica.Blocks.Interfaces.RealInput BOP_Demand_MW annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-106,26}), iconTransformation(extent={{-120,48},{-96,72}})));
  Modelica.Blocks.Interfaces.RealOutput BOP_Electric_Power
    annotation (Placement(transformation(extent={{112,16},{128,32}}),
        iconTransformation(extent={{128,68},{152,92}})));
  Modelica.Blocks.Interfaces.RealOutput BOP_Turbine_Pressure
    annotation (Placement(transformation(extent={{112,0},{128,16}}),
        iconTransformation(extent={{128,44},{152,68}})));
equation
   BOP_Electric_Power = BOP.sensorW.W;
   BOP_Turbine_Pressure = BOP.HPT.portHP.p;

  connect(SY.port_Grid, sensorW.port_a)
    annotation (Line(points={{100,60},{104,60}},
                                               color={255,0,0}));
  connect(sensorW.port_b, EG.portElec_a)
    annotation (Line(points={{116,60},{120,60}},
                                               color={255,0,0}));
  connect(EM.port_a2, BOP.port_b)
    annotation (Line(points={{-20,52},{6,52}}, color={0,127,255}));
  connect(EM.port_b2,stateSensor2. port_a) annotation (Line(points={{-20,68},
          {-14,68}},                          color={0,127,255}));
  connect(stateSensor2.port_b, BOP.port_a)
    annotation (Line(points={{1.77636e-15,68},{6,68}}, color={0,127,255}));
  connect(EM.port_a1,stateSensor1. port_b)
    annotation (Line(points={{-60,68},{-66,68}}, color={0,127,255}));
  connect(EM.port_b1,stateSensor3. port_a)
    annotation (Line(points={{-60,52},{-66,52}}, color={0,127,255}));
  connect(stateSensor3.port_b,sink. ports[1]) annotation (Line(points={{-80,52},
          {-104,52}},                       color={0,127,255}));
  connect(SteamSource.ports[1],stateSensor1. port_a) annotation (Line(
        points={{-100,68},{-80,68}},                   color={0,127,255}));
  connect(BOP.portElec_b, SY.port_a[1])
    annotation (Line(points={{46,60},{60,60}}, color={255,0,0}));
  connect(EM.port_b3[1], stateSensor4.port_a) annotation (Line(points={{-32,40},
          {-32,30},{-20,30}},                       color={0,127,255}));
  connect(BOP.port_a1, stateSensor5.port_b) annotation (Line(points={{13.2,40.8},
          {34,40.8},{34,34},{50,34},{50,30},{44,30}},       color={0,127,
          255}));
  connect(stateSensor4.port_b, CHX.Shell_in) annotation (Line(points={{-6,30},{0,
          30},{0,18},{4,18}},         color={0,127,255}));
  connect(CHX.Shell_out, stateSensor5.port_a) annotation (Line(points={{24,18},{
          26,18},{26,30},{30,30}},
                                color={0,127,255}));
  connect(CHX.Tube_in, stateSensor6.port_b)
    annotation (Line(points={{24,12},{36,12}},  color={0,127,255}));
  connect(Storage_Med_Source.ports[1], stateSensor6.port_a)
    annotation (Line(points={{60,12},{50,12}}, color={0,127,255}));
  connect(CHX.Tube_out, stateSensor7.port_a)
    annotation (Line(points={{4,12},{-6,12}},      color={0,127,255}));
  connect(stateSensor7.port_b, Oil_Sink.ports[1])
    annotation (Line(points={{-20,12},{-24,12}},   color={0,127,255}));
  connect(add_BOP.y,MW_W_Gain_BOP. u)
    annotation (Line(points={{-65,20},{-59.2,20}}, color={0,0,127}));
  connect(BOP_Demand_MW,add_BOP. u1) annotation (Line(points={{-106,26},{-88,26}},
                                color={0,0,127}));
  connect(pulse_BOP.y,add_BOP. u2) annotation (Line(points={{-93.4,10},{-88,10},
          {-88,14}},            color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -60},{160,100}}),  graphics={
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
            false, extent={{-120,-60},{160,100}})),
    experiment(
      StopTime=5000,
      Interval=10,
      Tolerance=1e-06,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
    __Dymola_experimentSetupOutput(events=false));
end SteamTurbine_OpenFeedHeat_DivertPowerControl_Test;
