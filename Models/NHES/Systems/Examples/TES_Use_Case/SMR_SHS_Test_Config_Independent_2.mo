within NHES.Systems.Examples.TES_Use_Case;
model SMR_SHS_Test_Config_Independent_2
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
  BalanceOfPlant.Turbine.Intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2_AR
    intermediate_Rankine_Cycle_TESUC(
    port_a_nominal(
      p=EM.port_b2_nominal.p,
      h=EM.port_b2_nominal.h,
      m_flow=-EM.port_b2_nominal.m_flow),
    port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_IntermediateControl_PID_TESUC_ImpControl_2_AR
      CS(electric_demand=const.y, Overall_Power=sensorW.W))
    annotation (Placement(transformation(extent={{60,-20},{100,20}})));
  SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)
    annotation (Placement(transformation(extent={{112,-22},{152,22}})));
  ElectricalGrid.InfiniteGrid.Infinite EG
    annotation (Placement(transformation(extent={{200,-20},{240,20}})));
  BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
      53303300, BOP_capacity(displayUnit="MW") = 1165000000)
    annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
  Modelica.Blocks.Sources.Constant delayStart(k=0)
    annotation (Placement(transformation(extent={{-62,78},{-42,98}})));
  SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
    W_nominal_BOP(displayUnit="MW") = 50000000,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://NHES/Resources/Data/RAVEN/Nominal_50_timeSeries.txt"))
    annotation (Placement(transformation(extent={{160,60},{200,100}})));
  EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI_TempControl_2
    two_Tank_SHS_System_NTU(
    redeclare
      NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TempControl_3
      CS,
    redeclare replaceable
      NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
      ht_level_max=500,
      ht_area=100,
      ht_surface_pressure=120000,
      hot_tank_init_temp=513.15,
      cold_tank_level_max=500,
      cold_tank_area=100,
      ct_surface_pressure=120000,
      cold_tank_init_temp=453.15,
      m_flow_ch_min=0.1,
      DHX_NTU=7,
      DHX_K_tube(unit="1/m4"),
      DHX_K_shell(unit="1/m4"),
      DHX_p_start_tube=120000,
      DHX_h_start_tube_inlet=272e3,
      DHX_h_start_tube_outlet=530e3,
      charge_pump_m_flow_nominal=100,
      disvalve_m_flow_nom=250,
      disvalve_dp_nominal=100000,
      chvalve_m_flow_nom=200,
      chvalve_dp_nominal=100000),
    redeclare package Storage_Medium =
        NHES.Media.Hitec.Hitec,
    m_flow_min=0.1,
    tank_height=500,
    Steam_Output_Temp=stateSensor6.temperature.T)
    annotation (Placement(transformation(extent={{-18,-76},{22,-36}})));

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
    amplitude=17.5e6,
    f=1/20000,
    offset=42e6,
    startTime=2000)
    annotation (Placement(transformation(extent={{-26,72},{-6,92}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=-15.58e6,
    rising=100,
    width=8000,
    falling=100,
    period=20000,
    offset=42e6,
    startTime=2000)
    annotation (Placement(transformation(extent={{68,80},{88,100}})));
  BalanceOfPlant.Turbine.Intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle
    intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle(
    port_a_nominal(
      p=EM.port_b2_nominal.p,
      h=EM.port_b2_nominal.h,
      m_flow=-EM.port_b2_nominal.m_flow),
    port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle_AR_2
      CS(electric_demand=const.y))
    annotation (Placement(transformation(extent={{108,-84},{146,-42}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{166,-10},{186,10}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{110,64},{130,84}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=25.14e6,
    rising=100,
    width=8000,
    falling=100,
    period=20000,
    offset=0,
    startTime=14000)
    annotation (Placement(transformation(extent={{68,48},{88,68}})));
  Modelica.Blocks.Sources.Constant const(k=47.5e6)
    annotation (Placement(transformation(extent={{18,68},{38,88}})));
equation

  connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
    annotation (Line(points={{28,-6},{44,-6},{44,-8},{60,-8}},
                                               color={0,127,255}));
  connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
    annotation (Line(points={{100,0},{108,0},{108,-1.1},{112,-1.1}}, color={255,
          0,0}));
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
    annotation (Line(points={{52,9},{54,9},{54,10},{60,10},{60,8}}, color={0,127,
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
    annotation (Line(points={{-24,-68},{-17.6,-68.4}}, color={0,127,255}));
  connect(stateSensor4.port_a, EM.port_b3[1]) annotation (Line(points={{-38,-68},
          {-38,-24},{16,-24},{16,-18}}, color={0,127,255}));
  connect(stateDisplay4.statePort, stateSensor4.statePort) annotation (Line(
        points={{-76,-94.16},{-76,-100},{-30.965,-100},{-30.965,-67.96}}, color=
         {0,0,0}));
  connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
      Line(points={{-17.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
  connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
        points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
        color={0,0,0}));
  connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
      Line(points={{22,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
  connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
        points={{55.035,-67.96},{55.035,-74},{56,-74},{56,-82},{72,-82},{72,-96.16}},
                                                                    color={0,0,0}));
  connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
        points={{57.95,-54.975},{62,-54.975},{62,-50},{78,-50},{78,-44.16}},
                        color={0,0,0}));
  connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
      Line(points={{21.6,-44.4},{42,-44.4},{42,-55},{48,-55}},          color={0,
          127,255}));
  connect(stateSensor5.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
    annotation (Line(points={{30,-30},{67.2,-30},{67.2,-19.2}}, color={0,127,255}));
  connect(stateSensor6.port_b,
    intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_a)
    annotation (Line(points={{62,-68},{100,-68},{100,-60},{102,-60},{102,-56},{
          108,-56},{108,-54.6}},
                             color={0,127,255}));
  connect(stateSensor7.port_a,
    intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_b)
    annotation (Line(points={{68,-55},{68,-71.4},{108,-71.4}}, color={0,127,255}));
  connect(intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.portElec_b,
    SY.port_a[2]) annotation (Line(points={{146,-63},{152,-63},{152,-26},{108,
          -26},{108,1.1},{112,1.1}},
                                color={255,0,0}));
  connect(SY.port_Grid, sensorW.port_a)
    annotation (Line(points={{152,0},{166,0}}, color={255,0,0}));
  connect(sensorW.port_b, EG.portElec_a)
    annotation (Line(points={{186,0},{200,0}}, color={255,0,0}));
  connect(trapezoid.y, add.u1) annotation (Line(points={{89,90},{102,90},{102,
          80},{108,80}}, color={0,0,127}));
  connect(trapezoid1.y, add.u2) annotation (Line(points={{89,58},{102,58},{102,
          68},{108,68}}, color={0,0,127}));
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
      StopTime=200000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
    __Dymola_experimentSetupOutput(events=false));
end SMR_SHS_Test_Config_Independent_2;
