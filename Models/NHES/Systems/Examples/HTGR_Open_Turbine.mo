within NHES.Systems.Examples;
model HTGR_Open_Turbine
  "High Fidelity Natural Circulation Model based on NuScale reactor. Hot channel calcs, pressurizer, and beginning of cycle reactivity feedback"
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
 parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
 parameter SI.Time timeScale=60*60 "Time scale of first table column";
 parameter String fileName=Modelica.Utilities.Files.loadResource(
    "modelica://NHES/Resources/Data/RAVEN/DMM_Dissertation_Demand.txt")
  "File where matrix is stored";
 Real demandChange=
 min(1.05,
 max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
     + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
     0.5));

  SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
    annotation (Placement(transformation(extent={{100,-22},{140,22}})));
  ElectricalGrid.InfiniteGrid.Infinite EG
    annotation (Placement(transformation(extent={{160,-20},{200,20}})));
  BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
      53303300, BOP_capacity(displayUnit="MW") = 60000000)
    annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
  Modelica.Blocks.Sources.Constant delayStart(k=10000)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
    W_nominal_BOP(displayUnit="MW") = 60000000,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://NHES/Resources/Data/RAVEN/Uprate_timeSeries.txt"))
    annotation (Placement(transformation(extent={{158,60},{198,100}})));
  EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
      p=14000000,
      h=3e6,
      m_flow=50), port_b1_nominal(p=14100000, h=2e6))
    annotation (Placement(transformation(extent={{-34,-18},{6,22}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-80,28},{-34,58}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-52,2},{-38,20}})));
  Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{10,0},{24,18}})));
  Fluid.Sensors.stateDisplay stateDisplay2
    annotation (Placement(transformation(extent={{-4,26},{42,56}})));
  Fluid.Sensors.stateSensor stateSensor3(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-44,-14},{-58,2}})));
  PrimaryHeatSystem.HTGR.RankineCycle.Models.PebbleBed_PrimaryLoop_STHX
    hTGR_PebbleBed_Primary_Loop_TESUC(redeclare
      PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems.CS_Rankine_Primary_SS_ClosedFeedheat
      CS(data(P_Steam_Ref=14000000)))
    annotation (Placement(transformation(extent={{-106,-20},{-62,22}})));
  Fluid.Sensors.stateDisplay stateDisplay3
    annotation (Placement(transformation(extent={{-120,-54},{-76,-22}})));
  BalanceOfPlant.RankineCycle.Models.HTGR_RankineCycles.HTGR_Rankine_Cycle_Transient
    BOP(redeclare
      BalanceOfPlant.RankineCycle.ControlSystems.CS_Rankine_Xe100_Based_Secondary_TransientControl
      CS) annotation (Placement(transformation(extent={{46,-22},{86,22}})));
equation
    hTGR_PebbleBed_Primary_Loop_TESUC.input_steam_pressure =
    BOP.sensor_p.p;
  connect(SY.port_Grid, EG.portElec_a)
    annotation (Line(points={{140,0},{160,0}}, color={255,0,0}));
  connect(stateSensor1.port_b, EM.port_a1) annotation (Line(points={{-38,11},{-38,
          10},{-34,10}},                            color={0,127,255}));
  connect(stateSensor1.statePort,stateDisplay1. statePort) annotation (Line(
        points={{-44.965,11.045},{-50,11.045},{-50,14},{-48,14},{-48,24},{-57,24},
          {-57,39.1}}, color={0,0,0}));
  connect(EM.port_b2, stateSensor2.port_a) annotation (Line(points={{6,10},{4,10},
          {4,12},{6,12},{6,9},{10,9}}, color={0,127,255}));
  connect(stateSensor3.port_a, EM.port_b1)
    annotation (Line(points={{-44,-6},{-34,-6}}, color={0,127,255}));
  connect(stateDisplay3.statePort,stateSensor3. statePort) annotation (Line(
        points={{-98,-42.16},{-98,-58},{-50,-58},{-50,-10},{-51.035,-10},{-51.035,
          -5.96}}, color={0,0,0}));
  connect(hTGR_PebbleBed_Primary_Loop_TESUC.port_b,stateSensor1. port_a)
    annotation (Line(points={{-62.66,11.29},{-52,11}}, color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop_TESUC.port_a,stateSensor3. port_b)
    annotation (Line(points={{-62.66,-5.93},{-62.66,-6},{-58,-6}}, color={0,127,
          255}));
  connect(stateSensor2.statePort, stateDisplay2.statePort) annotation (Line(
        points={{17.035,9.045},{17.035,23.5225},{19,23.5225},{19,37.1}}, color={
          0,0,0}));
  connect(BOP.port_e, SY.port_a[1])
    annotation (Line(points={{86,0},{100,0}}, color={255,0,0}));
  connect(stateSensor2.port_b, BOP.port_a)
    annotation (Line(points={{24,9},{24,8.8},{46,8.8}}, color={0,127,255}));
  connect(EM.port_a2, BOP.port_b) annotation (Line(points={{6,-6},{40,-6},{40,-8.8},
          {46,-8.8}}, color={0,127,255}));
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
      StopTime=1000000,
      Interval=3.5,
      __Dymola_Algorithm="Esdirk45a"));
end HTGR_Open_Turbine;
