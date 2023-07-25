within NHES.Systems.EnergyStorage.SHS_Two_Tank.Examples;
model Two_Tank_SHS_HT_Power_Test "TES use case demonstration of a NuScale-style LWR operating within an energy 
  arbitrage IES, storing and dispensing energy on demand from a two tank molten 
  salt energy storage system nominally using HITEC salt to store heat."
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
    annotation (Placement(transformation(extent={{-34,12},{32,68}})));
 // parameter Real fracNominal_BOP = abs(-66.4)/67.07;
 // parameter Real fracNominal_Other = sum(abs({-0.67}))/67.07;
 parameter Modelica.Units.SI.Time timeScale=60*60
    "Time scale of first table column";
 parameter String fileName=Modelica.Utilities.Files.loadResource(
    "modelica://NHES/Resources/Data/RAVEN/DMM_Dissertation_Demand.txt")
  "File where matrix is stored";
 // Real demandChange=
 // min(1.05,
 // max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
 //     + sum(boundary5.m_flow/-0.67)*fracNominal_Other,
 //     0.5));

  NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
    annotation (Placement(transformation(extent={{38,18},{78,62}})));
  NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG(redeclare
      NHES.Systems.ElectricalGrid.InfiniteGrid.CS_Dummy CS, redeclare
      NHES.Systems.ElectricalGrid.InfiniteGrid.ED_Dummy ED)
    annotation (Placement(transformation(extent={{100,20},{140,60}})));
  NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(
        displayUnit="MW") = 53303300, BOP_capacity(displayUnit="MW")=
      1165000000)
    annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
  NHES.Systems.SupervisoryControl.InputSetpointData SC(
    delayStart=0,
    W_nominal_BOP(displayUnit="MW") = 50000000,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://NHES/Resources/Data/RAVEN/Nominal_50_timeSeries.txt"))
    annotation (Placement(transformation(extent={{100,-60},{140,-20}})));

  NHES.Fluid.Sensors.stateSensor stateSensor4(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-118,20},{-104,36}})));
  NHES.Fluid.Sensors.stateSensor stateSensor5(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-104,42},{-118,58}})));
  NHES.Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-54,24},{-40,40}})));
  NHES.Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-40,40},{-54,56}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{82,34},{96,46}})));

  Modelica.Fluid.Sources.Boundary_pT Sink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p(displayUnit="bar") = 3406400,
    T(displayUnit="degC") = 453.15)
    annotation (Placement(transformation(extent={{-140,58},{-124,42}})));
  Modelica.Fluid.Sources.Boundary_pT Source(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p(displayUnit="bar") = 3406500,
    T(displayUnit="degC") = 581.236)
    annotation (Placement(transformation(extent={{-140,36},{-124,20}})));
  Modelica.Blocks.Math.Add add_TES
    annotation (Placement(transformation(extent={{-100,-16},{-80,4}})));
  Modelica.Blocks.Sources.Pulse pulse_TES(
    period=7200,
    offset=0,
    startTime=2400,
    amplitude=-4.5)
    annotation (Placement(transformation(extent={{-120,-20},{-108,-8}})));
  Modelica.Blocks.Math.Gain MW_W_Gain_TES(k=1e6)
    annotation (Placement(transformation(extent={{-72,-12},{-60,0}})));
  Modelica.Blocks.Interfaces.RealInput TES_Demand_MW annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-120,0}),   iconTransformation(extent={{-120,-12},{-96,12}})));
  Modelica.Blocks.Interfaces.RealOutput TES_HotTank_Level
    annotation (Placement(transformation(extent={{48,-6},{64,10}}),
        iconTransformation(extent={{106,-28},{130,-4}})));
  Modelica.Blocks.Interfaces.RealOutput TES_HT_Level_Ramprate annotation (
      Placement(transformation(extent={{48,-20},{64,-4}}),
        iconTransformation(extent={{128,-40},{152,-16}})));
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
    annotation (Placement(transformation(extent={{-100,20},{-60,68}})));

equation

   TES_HotTank_Level = TES.hot_tank.level;
   TES_HT_Level_Ramprate = der(TES.hot_tank.level);

  connect(stateSensor6.port_b, Dch_BOP.port_a) annotation (Line(points={{-40,32},
          {-36,32},{-36,42},{-21.625,42},{-21.625,48}}, color={0,127,255}));
  connect(stateSensor7.port_a, Dch_BOP.port_b) annotation (Line(points={{-40,48},
          {-30,48},{-30,32},{-21.625,32}},      color={0,127,255}));
  connect(Dch_BOP.portElec_b, SY.port_a[1]) annotation (Line(
      points={{19.625,40},{38,40}},
      color={255,0,0}));
  connect(SY.port_Grid, sensorW.port_a)
    annotation (Line(points={{78,40},{82,40}}, color={255,0,0}));
  connect(sensorW.port_b, EG.portElec_a)
    annotation (Line(points={{96,40},{100,40}},color={255,0,0}));
  connect(stateSensor5.port_b,Sink. ports[1])
    annotation (Line(points={{-118,50},{-124,50}},
                                                 color={0,127,255}));
  connect(stateSensor4.port_a, Source.ports[1])
    annotation (Line(points={{-118,28},{-124,28}}, color={0,127,255}));
  connect(TES_Demand_MW,add_TES. u1)
    annotation (Line(points={{-120,0},{-102,0}},       color={0,0,127}));
  connect(pulse_TES.y,add_TES. u2)
    annotation (Line(points={{-107.4,-14},{-102,-14},{-102,-12}},
                                                         color={0,0,127}));
  connect(add_TES.y,MW_W_Gain_TES. u)
    annotation (Line(points={{-79,-6},{-73.2,-6}},     color={0,0,127}));
  connect(TES.port_dch_a, stateSensor7.port_b) annotation (Line(points={{-60.4,
          51.6},{-60.4,52},{-54,52},{-54,48}},   color={0,127,255}));
  connect(TES.port_dch_b, stateSensor6.port_a) annotation (Line(points={{-60,
          27.6},{-60,28},{-54,28},{-54,32}},       color={0,127,255}));
  connect(stateSensor5.port_a, TES.port_ch_b) annotation (Line(points={{-104,50},
          {-99.6,50},{-99.6,50.8}},                            color={0,127,255}));
  connect(stateSensor4.port_b, TES.port_ch_a) annotation (Line(points={{-104,28},
          {-99.6,28},{-99.6,27.6}},                                 color={0,127,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -60},{140,80}}),   graphics={
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
            false, extent={{-140,-60},{140,80}})),
    experiment(
      StopTime=7000,
      Interval=10,
      Tolerance=1e-06,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
    __Dymola_experimentSetupOutput(events=false));
end Two_Tank_SHS_HT_Power_Test;
