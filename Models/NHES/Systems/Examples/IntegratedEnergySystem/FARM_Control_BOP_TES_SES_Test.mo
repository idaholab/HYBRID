within NHES.Systems.Examples.IntegratedEnergySystem;
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
