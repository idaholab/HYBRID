within NHES.Systems.Examples.TES_Use_Case;
model SMR_SHS_Test_Config_Peaking_ImpControl
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
      p(displayUnit="Pa") = 3398e3,
      T(displayUnit="degC") = 580.05,
      h=2997670),
    redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave CS(W_turbine=
          intermediate_Rankine_Cycle_TESUC.powerSensor.power, W_Setpoint=sine.y),
    port_a_nominal(
      m_flow=67.07,
      T(displayUnit="degC") = 422.05,
      p=3447380))
    annotation (Placement(transformation(extent={{-102,-26},{-52,30}})));

  EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
      p=SMR_Taveprogram.port_b_nominal.p,
      h=SMR_Taveprogram.port_b_nominal.h,
      m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
          SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h),
    port_b3_nominal_m_flow={-0.67},
    nPorts_b3=1)
    annotation (Placement(transformation(extent={{-12,-18},{28,22}})));
  BalanceOfPlant.Turbine.Intermediate_Rankine_Cycle_TESUC_3_Peaking_IC
    intermediate_Rankine_Cycle_TESUC(
    port_a_nominal(
      p=EM.port_b2_nominal.p,
      h=EM.port_b2_nominal.h,
      m_flow=-EM.port_b2_nominal.m_flow),
    port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
    redeclare
      BalanceOfPlant.Turbine.ControlSystems.CS_IntermediateControl_PID_TESUC_ImpControl
      CS(electric_demand=sine.y))
    annotation (Placement(transformation(extent={{62,-20},{102,20}})));
  SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
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
  EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI_TempControl
    two_Tank_SHS_System_NTU(
    redeclare
      NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TempControl
      CS,
    redeclare replaceable
      NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
      ht_level_max=100,
      ht_area=100,
      hot_tank_init_temp=513.15,
      cold_tank_level_max=100,
      cold_tank_area=100,
      cold_tank_init_temp=453.15,
      m_flow_ch_min=0.1,
      DHX_K_tube(unit="1/m4"),
      DHX_K_shell(unit="1/m4"),
      DHX_p_start_tube=120000,
      DHX_h_start_tube_inlet=272e3,
      DHX_h_start_tube_outlet=530e3,
      discharge_pump_dp_nominal=10000,
      charge_pump_dp_nominal=10000,
      disvalve_m_flow_nom=1000,
      disvalve_dp_nominal=10000,
      chvalve_m_flow_nom=5000,
      chvalve_dp_nominal=10000),
    redeclare package Storage_Medium =
        NHES.Media.Hitec.Hitec,
    m_flow_min=0.1,
    tank_height=100,
    Steam_Output_Temp=stateSensor6.temperature.T)
    annotation (Placement(transformation(extent={{-20,-76},{20,-36}})));

  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-52,28},{-6,58}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-38,2},{-24,20}})));
  Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{38,0},{52,18}})));
  Fluid.Sensors.stateDisplay stateDisplay2
    annotation (Placement(transformation(extent={{24,26},{70,56}})));
  Fluid.Sensors.stateSensor stateSensor3(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-26,-14},{-40,2}})));
  Fluid.Sensors.stateDisplay stateDisplay3
    annotation (Placement(transformation(extent={{-98,-56},{-54,-24}})));
  Fluid.Sensors.stateSensor stateSensor4(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-38,-76},{-24,-60}})));
  Fluid.Sensors.stateDisplay stateDisplay4
    annotation (Placement(transformation(extent={{-98,-106},{-54,-74}})));
  Fluid.Sensors.stateSensor stateSensor5(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{16,-38},{30,-22}})));
  Fluid.Sensors.stateDisplay stateDisplay5
    annotation (Placement(transformation(extent={{-18,-106},{26,-74}})));
  Fluid.Sensors.stateDisplay stateDisplay6
    annotation (Placement(transformation(extent={{56,-56},{100,-24}})));
  Fluid.Sensors.stateDisplay stateDisplay7
    annotation (Placement(transformation(extent={{50,-108},{94,-76}})));
  Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{48,-76},{62,-60}})));
  Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{68,-60},{48,-50}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=20e6,
    f=1/10000,
    offset=40e6,
    startTime=1000)
    annotation (Placement(transformation(extent={{-26,72},{-6,92}})));
equation

  connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
    annotation (Line(points={{28,-6},{44,-6},{44,-8},{62,-8}},
                                               color={0,127,255}));
  connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
    annotation (Line(points={{102,0},{108,0},{108,0},{112,0}},       color={255,
          0,0}));
  connect(SY.port_Grid, EG.portElec_a)
    annotation (Line(points={{152,0},{160,0}}, color={255,0,0}));
  connect(SMR_Taveprogram.port_b, stateSensor1.port_a) annotation (Line(points={{
          -51.0909,12.7692},{-51.0909,11},{-38,11}},  color={0,127,255}));
  connect(stateSensor1.port_b, EM.port_a1) annotation (Line(points={{-24,11},{-22,
          11},{-22,12},{-16,12},{-16,10},{-12,10}}, color={0,127,255}));
  connect(stateSensor1.statePort, stateDisplay1.statePort) annotation (Line(
        points={{-30.965,11.045},{-22,11.045},{-22,14},{-20,14},{-20,24},{-29,24},
          {-29,39.1}}, color={0,0,0}));
  connect(EM.port_b2, stateSensor2.port_a) annotation (Line(points={{28,10},{30,
          10},{30,12},{34,12},{34,9},{38,9}}, color={0,127,255}));
  connect(stateSensor2.port_b, intermediate_Rankine_Cycle_TESUC.port_a)
    annotation (Line(points={{52,9},{54,9},{54,10},{62,10},{62,8}}, color={0,127,
          255}));
  connect(stateSensor2.statePort, stateDisplay2.statePort) annotation (Line(
        points={{45.035,9.045},{45.035,37.1},{47,37.1}}, color={0,0,0}));
  connect(SMR_Taveprogram.port_a, stateSensor3.port_b) annotation (Line(points={{
          -51.0909,-1.44615},{-46,-1.44615},{-46,-6},{-40,-6}},  color={0,127,255}));
  connect(stateSensor3.port_a, EM.port_b1)
    annotation (Line(points={{-26,-6},{-12,-6}}, color={0,127,255}));
  connect(stateDisplay3.statePort, stateSensor3.statePort) annotation (Line(
        points={{-76,-44.16},{-76,-50},{-44,-50},{-44,-12},{-33.035,-12},{-33.035,
          -5.96}}, color={0,0,0}));
  connect(stateSensor4.port_b, two_Tank_SHS_System_NTU.port_ch_a)
    annotation (Line(points={{-24,-68},{-19.6,-68.4}}, color={0,127,255}));
  connect(stateSensor4.port_a, EM.port_b3[1]) annotation (Line(points={{-38,-68},
          {-38,-24},{16,-24},{16,-18}}, color={0,127,255}));
  connect(stateDisplay4.statePort, stateSensor4.statePort) annotation (Line(
        points={{-76,-94.16},{-76,-100},{-30.965,-100},{-30.965,-67.96}}, color=
         {0,0,0}));
  connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
      Line(points={{-19.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
  connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
        points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
        color={0,0,0}));
  connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
      Line(points={{20,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
  connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
        points={{55.035,-67.96},{55.035,-74},{56,-74},{56,-82},{72,-82},{72,-96.16}},
                                                                    color={0,0,0}));
  connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
        points={{57.95,-54.975},{62,-54.975},{62,-50},{78,-50},{78,-44.16}},
                        color={0,0,0}));
  connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
      Line(points={{19.6,-44.4},{42,-44.4},{42,-55},{48,-55}},          color={0,
          127,255}));
  connect(stateSensor6.port_b, intermediate_Rankine_Cycle_TESUC.port_a2)
    annotation (Line(points={{62,-68},{108,-68},{108,13.6},{101.6,13.6}}, color=
         {0,127,255}));
  connect(stateSensor7.port_a, intermediate_Rankine_Cycle_TESUC.port_b1)
    annotation (Line(points={{68,-55},{68,-54},{106,-54},{106,-10.4},{101.6,-10.4}},
        color={0,127,255}));
  connect(stateSensor5.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
    annotation (Line(points={{30,-30},{69.2,-30},{69.2,-19.2}}, color={0,127,255}));
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
      StopTime=20000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
    __Dymola_experimentSetupOutput(events=false));
end SMR_SHS_Test_Config_Peaking_ImpControl;
