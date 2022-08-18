within NHES.Systems.Examples.TES_Use_Case;
package ObsoleteTESUseCaseExamples
  model SMR_SHS_Test_Config_Independent_2_Mikk
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
    BalanceOfPlant.Turbine.SteamTurbine_OpenFeedHeat_DivertPowerControl
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_DivertPowerControl
        CS(electric_demand=sum1.y, Overall_Power=sensorW.W))
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
      annotation (Placement(transformation(extent={{158,60},{198,100}})));
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI_TempControl_2_new_pumps
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TempControl_4
        CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        ht_level_max=12,
        ht_area=3900,
        ht_zero_level_volume=0.25*3900,
        ht_surface_pressure=120000,
        hot_tank_init_temp=493.15,
        cold_tank_level_max=12,
        cold_tank_area=4200,
        ct_zero_level_volume=0.25*4200,
        ct_surface_pressure=120000,
        cold_tank_init_temp=453.15,
        m_flow_ch_min=0.1,
        DHX_NTU=7,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4"),
        DHX_p_start_tube=120000,
        DHX_h_start_tube_inlet=272e3,
        DHX_h_start_tube_outlet=530e3,
        discharge_pump_dp_nominal=25000,
        discharge_pump_m_flow_nominal=125,
        discharge_pump_rho_nominal=1800,
        charge_pump_dp_nominal=25000,
        charge_pump_m_flow_nominal=125,
        charge_pump_rho_nominal=1800,
        disvalve_m_flow_nom=250,
        disvalve_dp_nominal=25000,
        chvalve_m_flow_nom=50,
        chvalve_dp_nominal=25000),
      redeclare package Storage_Medium =
          NHES.Media.Hitec.Hitec,
      m_flow_min=0.1,
      tank_height=12,
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
      amplitude=-20.58e6,
      rising=100,
      width=9800,
      falling=100,
      period=20000,
      offset=47e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{68,80},{88,100}})));
    BalanceOfPlant.Turbine.SteamTurbine_Basic_NoFeedHeat
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_SmallCycle_NoFeedHeat
        CS(electric_demand=sum1.y))
      annotation (Placement(transformation(extent={{108,-84},{146,-42}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{166,-10},{186,10}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{110,64},{130,84}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      amplitude=20.14e6,
      rising=100,
      width=7800,
      falling=100,
      period=20000,
      offset=0,
      startTime=14000)
      annotation (Placement(transformation(extent={{68,48},{88,68}})));
    Modelica.Blocks.Sources.Constant const(k=47.5e6)
      annotation (Placement(transformation(extent={{18,68},{38,88}})));
    Modelica.Blocks.Sources.CombiTimeTable demand_BOP(
      tableOnFile=true,
      startTime=0,
      tableName="BOP",
      timeScale=timeScale,
      fileName=fileName)
      annotation (Placement(transformation(extent={{-96,50},{-76,70}})));
    Modelica.Blocks.Math.Sum sum1
      annotation (Placement(transformation(extent={{138,34},{158,54}})));
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
    connect(add.y, sum1.u[1]) annotation (Line(points={{131,74},{136,74},{136,58},
            {130,58},{130,44},{136,44}}, color={0,0,127}));
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
  end SMR_SHS_Test_Config_Independent_2_Mikk;

  model SMR_SHS_Test_Config_Peaking_SmallTanks
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
    BalanceOfPlant.Turbine.SteamTurbine_OpenFeedHeat_DivertPowerControl_PowerBoostLoop
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PowerBoostLoop_DivertPowerControl
        CS(electric_demand=sum1.y))
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TempControl_SmallTanks
        CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
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
        charge_pump_m_flow_nominal=100,
        charge_pump_constantRPM=3000,
        disvalve_m_flow_nom=250,
        disvalve_dp_nominal=100000,
        chvalve_m_flow_nom=900,
        chvalve_dp_nominal=100000),
      redeclare package Storage_Medium =
          NHES.Media.Hitec.Hitec,
      m_flow_min=0.1,
      tank_height=11.7,
      Steam_Output_Temp=stateSensor6.temperature.T)
      annotation (Placement(transformation(extent={{-22,-76},{18,-36}})));

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
      amplitude=-20e6,
      f=1/20000,
      offset=48e6,
      startTime=12000)
      annotation (Placement(transformation(extent={{-26,72},{-6,92}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=41e6,
      rising=100,
      width=8000,
      falling=100,
      period=16000,
      offset=26e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{20,72},{40,92}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      amplitude=-20.58e6,
      rising=100,
      width=9800,
      falling=100,
      period=20000,
      offset=47e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{64,84},{84,104}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid2(
      amplitude=20.14e6,
      rising=100,
      width=7800,
      falling=100,
      period=20000,
      offset=0,
      startTime=14000)
      annotation (Placement(transformation(extent={{94,96},{114,116}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{118,58},{138,78}})));
    Modelica.Blocks.Math.Sum sum1
      annotation (Placement(transformation(extent={{136,88},{156,108}})));
    Modelica.Blocks.Sources.CombiTimeTable demand_BOP(
      tableOnFile=true,
      startTime=0,
      tableName="BOP",
      timeScale=timeScale,
      fileName=fileName)
      annotation (Placement(transformation(extent={{-80,62},{-60,82}})));
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
      annotation (Line(points={{-24,-68},{-21.6,-68.4}}, color={0,127,255}));
    connect(stateSensor4.port_a, EM.port_b3[1]) annotation (Line(points={{-38,-68},
            {-38,-24},{16,-24},{16,-18}}, color={0,127,255}));
    connect(stateDisplay4.statePort, stateSensor4.statePort) annotation (Line(
          points={{-76,-94.16},{-76,-100},{-30.965,-100},{-30.965,-67.96}}, color=
           {0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
        Line(points={{-21.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
    connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
          points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
        Line(points={{18,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
    connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
          points={{55.035,-67.96},{55.035,-74},{56,-74},{56,-82},{72,-82},{72,-96.16}},
                                                                      color={0,0,0}));
    connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
          points={{57.95,-54.975},{62,-54.975},{62,-50},{78,-50},{78,-44.16}},
                          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
        Line(points={{17.6,-44.4},{42,-44.4},{42,-55},{48,-55}},          color={0,
            127,255}));
    connect(stateSensor6.port_b, intermediate_Rankine_Cycle_TESUC.port_a2)
      annotation (Line(points={{62,-68},{108,-68},{108,13.6},{101.6,13.6}}, color=
           {0,127,255}));
    connect(stateSensor7.port_a, intermediate_Rankine_Cycle_TESUC.port_b1)
      annotation (Line(points={{68,-55},{68,-54},{106,-54},{106,-10.4},{101.6,-10.4}},
          color={0,127,255}));
    connect(stateSensor5.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
      annotation (Line(points={{30,-30},{69.2,-30},{69.2,-19.2}}, color={0,127,255}));
    connect(trapezoid2.y, add.u2) annotation (Line(points={{115,106},{120,106},{
            120,82},{108,82},{108,62},{116,62}},
                       color={0,0,127}));
    connect(trapezoid1.y, add.u1) annotation (Line(points={{85,94},{90,94},{90,78},
            {110,78},{110,74},{116,74}},
                       color={0,0,127}));
    connect(add.y, sum1.u[1]) annotation (Line(points={{139,68},{144,68},{144,84},
            {128,84},{128,98},{134,98}}, color={0,0,127}));
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
  end SMR_SHS_Test_Config_Peaking_SmallTanks;

  model SMR_SHS_Test_Config_Independent_SmallTanks
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
    BalanceOfPlant.Turbine.SteamTurbine_OpenFeedHeat_DivertPowerControl
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_DivertPowerControl
        CS(electric_demand=sum1.y, Overall_Power=sensorW.W))
      annotation (Placement(transformation(extent={{50,-20},{90,20}})));
    SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)
      annotation (Placement(transformation(extent={{98,-22},{138,22}})));
    ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
        53303300, BOP_capacity(displayUnit="MW") = 1165000000)
      annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
    Modelica.Blocks.Sources.Constant delayStart(k=0)
      annotation (Placement(transformation(extent={{-62,78},{-42,98}})));
    SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
      W_nominal_BOP(displayUnit="MW") = 50000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Nominal_50_timeSeries.txt"))
      annotation (Placement(transformation(extent={{158,60},{198,100}})));

    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TempControl_SmallTanks
        CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
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
        disvalve_m_flow_nom=900,
        disvalve_dp_nominal=100000,
        chvalve_m_flow_nom=900,
        charge_pump_m_flow_nominal=100,
        disvalve_m_flow_nom=250,
        disvalve_dp_nominal=100000,
        chvalve_dp_nominal=100000),
      redeclare package Storage_Medium =
          NHES.Media.Hitec.Hitec,
      m_flow_min=0.1,
      tank_height=11.7,
      Steam_Output_Temp=stateSensor6.temperature.T)
      annotation (Placement(transformation(extent={{-16,-76},{24,-36}})));

    Fluid.Sensors.stateDisplay stateDisplay1
      annotation (Placement(transformation(extent={{-52,28},{-6,58}})));
    Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-38,2},{-24,20}})));
    Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{32,0},{46,18}})));
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
      amplitude=-20.58e6,
      rising=100,
      width=9800,
      falling=100,
      period=20000,
      offset=47e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{66,112},{86,132}})));
    BalanceOfPlant.Turbine.SteamTurbine_Basic_NoFeedHeat
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_SmallCycle_NoFeedHeat
        CS(electric_demand=sum1.y))
      annotation (Placement(transformation(extent={{108,-84},{146,-42}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{142,-6},{156,6}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{108,96},{128,116}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      amplitude=20.14e6,
      rising=100,
      width=7800,
      falling=100,
      period=20000,
      offset=0,
      startTime=14000)
      annotation (Placement(transformation(extent={{66,76},{86,96}})));

    Modelica.Blocks.Sources.Constant const(k=47.5e6)
      annotation (Placement(transformation(extent={{18,68},{38,88}})));
    Modelica.Blocks.Sources.CombiTimeTable demand_BOP(
      tableOnFile=true,
      startTime=0,
      tableName="BOP",
      timeScale=timeScale,
      fileName=fileName)
      annotation (Placement(transformation(extent={{-98,112},{-78,132}})));
    Modelica.Blocks.Math.Sum sum1
      annotation (Placement(transformation(extent={{134,102},{154,122}})));
  equation

    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{28,-6},{36,-6},{36,-8},{50,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{90,0},{98,0},{98,-1.1}},               color={255,
            0,0}));
    connect(SMR_Taveprogram.port_b, stateSensor1.port_a) annotation (Line(points={{
            -51.0909,12.7692},{-51.0909,11},{-38,11}},  color={0,127,255}));
    connect(stateSensor1.port_b, EM.port_a1) annotation (Line(points={{-24,11},{-22,
            11},{-22,12},{-16,12},{-16,10},{-12,10}}, color={0,127,255}));
    connect(stateSensor1.statePort, stateDisplay1.statePort) annotation (Line(
          points={{-30.965,11.045},{-22,11.045},{-22,14},{-20,14},{-20,24},{-29,24},
            {-29,39.1}}, color={0,0,0}));
    connect(EM.port_b2, stateSensor2.port_a) annotation (Line(points={{28,10},{32,
            10},{32,9}},                        color={0,127,255}));
    connect(stateSensor2.port_b, intermediate_Rankine_Cycle_TESUC.port_a)
      annotation (Line(points={{46,9},{48,9},{48,8},{50,8}},          color={0,127,
            255}));
    connect(stateSensor2.statePort, stateDisplay2.statePort) annotation (Line(
          points={{39.035,9.045},{39.035,37.1},{47,37.1}}, color={0,0,0}));
    connect(SMR_Taveprogram.port_a, stateSensor3.port_b) annotation (Line(points={{
            -51.0909,-1.44615},{-46,-1.44615},{-46,-6},{-40,-6}},  color={0,127,255}));
    connect(stateSensor3.port_a, EM.port_b1)
      annotation (Line(points={{-26,-6},{-12,-6}}, color={0,127,255}));
    connect(stateDisplay3.statePort, stateSensor3.statePort) annotation (Line(
          points={{-76,-44.16},{-76,-50},{-44,-50},{-44,-12},{-33.035,-12},{-33.035,
            -5.96}}, color={0,0,0}));
    connect(stateSensor4.port_b, two_Tank_SHS_System_NTU.port_ch_a)
      annotation (Line(points={{-24,-68},{-15.6,-68.4}}, color={0,127,255}));
    connect(stateSensor4.port_a, EM.port_b3[1]) annotation (Line(points={{-38,-68},
            {-38,-24},{16,-24},{16,-18}}, color={0,127,255}));
    connect(stateDisplay4.statePort, stateSensor4.statePort) annotation (Line(
          points={{-76,-94.16},{-76,-100},{-30.965,-100},{-30.965,-67.96}}, color=
           {0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
        Line(points={{-15.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
    connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
          points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
        Line(points={{24,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
    connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
          points={{55.035,-67.96},{55.035,-74},{56,-74},{56,-82},{72,-82},{72,-96.16}},
                                                                      color={0,0,0}));
    connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
          points={{57.95,-54.975},{62,-54.975},{62,-50},{78,-50},{78,-44.16}},
                          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
        Line(points={{23.6,-44.4},{42,-44.4},{42,-55},{48,-55}},          color={0,
            127,255}));
    connect(stateSensor5.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
      annotation (Line(points={{30,-30},{57.2,-30},{57.2,-19.2}}, color={0,127,255}));
    connect(stateSensor6.port_b,
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_a)
      annotation (Line(points={{62,-68},{100,-68},{100,-60},{102,-60},{102,-56},{
            108,-56},{108,-54.6}},
                               color={0,127,255}));
    connect(stateSensor7.port_a,
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_b)
      annotation (Line(points={{68,-55},{68,-71.4},{108,-71.4}}, color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.portElec_b,
      SY.port_a[2]) annotation (Line(points={{146,-63},{144,-63},{144,-28},{94,
            -28},{94,0},{98,0},{98,1.1}},
                                  color={255,0,0}));
    connect(SY.port_Grid, sensorW.port_a)
      annotation (Line(points={{138,0},{142,0}}, color={255,0,0}));
    connect(sensorW.port_b, EG.portElec_a)
      annotation (Line(points={{156,0},{160,0}}, color={255,0,0}));
    connect(trapezoid.y, add.u1) annotation (Line(points={{87,122},{87,118},{100,
            118},{100,112},{106,112}},
                           color={0,0,127}));
    connect(trapezoid1.y, add.u2) annotation (Line(points={{87,86},{100,86},{100,
            100},{106,100}},
                           color={0,0,127}));
    connect(add.y, sum1.u[1]) annotation (Line(points={{129,106},{128,106},{128,
            92},{98,92},{98,118},{132,118},{132,112}},
                                         color={0,0,127}));
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
  end SMR_SHS_Test_Config_Independent_SmallTanks;

  model SMR_SHS_Test_Config_Independent_2
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
    BalanceOfPlant.Turbine.SteamTurbine_OpenFeedHeat_DivertPowerControl
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_DivertPowerControl
        CS(electric_demand=sum1.y, Overall_Power=sensorW.W))
      annotation (Placement(transformation(extent={{50,-20},{90,20}})));
    SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)
      annotation (Placement(transformation(extent={{98,-22},{138,22}})));
    ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
        53303300, BOP_capacity(displayUnit="MW") = 1165000000)
      annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
    Modelica.Blocks.Sources.Constant delayStart(k=0)
      annotation (Placement(transformation(extent={{-62,78},{-42,98}})));
    SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
      W_nominal_BOP(displayUnit="MW") = 50000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Nominal_50_timeSeries.txt"))
      annotation (Placement(transformation(extent={{158,60},{198,100}})));
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI_TempControl_2
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TempControl_4
        CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        ht_level_max=1000,
        ht_area=100,
        ht_surface_pressure=120000,
        hot_tank_init_temp=513.15,
        cold_tank_level_max=1000,
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
        chvalve_m_flow_nom=50,
        chvalve_dp_nominal=100000),
      redeclare package Storage_Medium =
          NHES.Media.Hitec.Hitec,
      m_flow_min=0.1,
      tank_height=1000,
      Steam_Output_Temp=stateSensor6.temperature.T)
      annotation (Placement(transformation(extent={{-18,-76},{22,-36}})));

    Fluid.Sensors.stateDisplay stateDisplay1
      annotation (Placement(transformation(extent={{-52,28},{-6,58}})));
    Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-38,2},{-24,20}})));
    Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{32,0},{46,18}})));
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
      amplitude=-20.58e6,
      rising=100,
      width=9800,
      falling=100,
      period=20000,
      offset=47e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{66,112},{86,132}})));
    BalanceOfPlant.Turbine.SteamTurbine_Basic_NoFeedHeat
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_SmallCycle_NoFeedHeat
        CS(electric_demand=sum1.y))
      annotation (Placement(transformation(extent={{108,-84},{146,-42}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{142,-6},{156,6}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{108,96},{128,116}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      amplitude=20.14e6,
      rising=100,
      width=7800,
      falling=100,
      period=20000,
      offset=0,
      startTime=14000)
      annotation (Placement(transformation(extent={{66,76},{86,96}})));
    Modelica.Blocks.Sources.Constant const(k=47.5e6)
      annotation (Placement(transformation(extent={{18,68},{38,88}})));
    Modelica.Blocks.Sources.CombiTimeTable demand_BOP(
      tableOnFile=true,
      startTime=0,
      tableName="BOP",
      timeScale=timeScale,
      fileName=fileName)
      annotation (Placement(transformation(extent={{-98,112},{-78,132}})));
    Modelica.Blocks.Math.Sum sum1
      annotation (Placement(transformation(extent={{134,102},{154,122}})));
  equation

    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{28,-6},{36,-6},{36,-8},{50,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{90,0},{98,0},{98,-1.1}},               color={255,
            0,0}));
    connect(SMR_Taveprogram.port_b, stateSensor1.port_a) annotation (Line(points={{
            -51.0909,12.7692},{-51.0909,11},{-38,11}},  color={0,127,255}));
    connect(stateSensor1.port_b, EM.port_a1) annotation (Line(points={{-24,11},{-22,
            11},{-22,12},{-16,12},{-16,10},{-12,10}}, color={0,127,255}));
    connect(stateSensor1.statePort, stateDisplay1.statePort) annotation (Line(
          points={{-30.965,11.045},{-22,11.045},{-22,14},{-20,14},{-20,24},{-29,24},
            {-29,39.1}}, color={0,0,0}));
    connect(EM.port_b2, stateSensor2.port_a) annotation (Line(points={{28,10},{32,
            10},{32,9}},                        color={0,127,255}));
    connect(stateSensor2.port_b, intermediate_Rankine_Cycle_TESUC.port_a)
      annotation (Line(points={{46,9},{48,9},{48,8},{50,8}},          color={0,127,
            255}));
    connect(stateSensor2.statePort, stateDisplay2.statePort) annotation (Line(
          points={{39.035,9.045},{39.035,37.1},{47,37.1}}, color={0,0,0}));
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
      annotation (Line(points={{30,-30},{57.2,-30},{57.2,-19.2}}, color={0,127,255}));
    connect(stateSensor6.port_b,
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_a)
      annotation (Line(points={{62,-68},{100,-68},{100,-60},{102,-60},{102,-56},{
            108,-56},{108,-54.6}},
                               color={0,127,255}));
    connect(stateSensor7.port_a,
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_b)
      annotation (Line(points={{68,-55},{68,-71.4},{108,-71.4}}, color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.portElec_b,
      SY.port_a[2]) annotation (Line(points={{146,-63},{144,-63},{144,-28},{94,
            -28},{94,0},{98,0},{98,1.1}},
                                  color={255,0,0}));
    connect(SY.port_Grid, sensorW.port_a)
      annotation (Line(points={{138,0},{142,0}}, color={255,0,0}));
    connect(sensorW.port_b, EG.portElec_a)
      annotation (Line(points={{156,0},{160,0}}, color={255,0,0}));
    connect(trapezoid.y, add.u1) annotation (Line(points={{87,122},{87,118},{100,
            118},{100,112},{106,112}},
                           color={0,0,127}));
    connect(trapezoid1.y, add.u2) annotation (Line(points={{87,86},{100,86},{100,
            100},{106,100}},
                           color={0,0,127}));
    connect(add.y, sum1.u[1]) annotation (Line(points={{129,106},{128,106},{128,
            92},{98,92},{98,118},{132,118},{132,112}},
                                         color={0,0,127}));
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

  model SMR_SHS_Test_Config_Peaking_ImpControl_2_Mikk
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
    BalanceOfPlant.Turbine.SteamTurbine_OpenFeedHeat_DivertPowerControl_PowerBoostLoop
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PowerBoostLoop_DivertPowerControl
        CS(electric_demand=sum1.y))
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI_TempControl_2
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TempControl_5
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
        DHX_NTU=20,
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
      amplitude=-20e6,
      f=1/20000,
      offset=48e6,
      startTime=12000)
      annotation (Placement(transformation(extent={{-26,72},{-6,92}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=41e6,
      rising=100,
      width=8000,
      falling=100,
      period=16000,
      offset=26e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{20,72},{40,92}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      amplitude=-20.58e6,
      rising=100,
      width=9800,
      falling=100,
      period=20000,
      offset=47e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{64,84},{84,104}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid2(
      amplitude=20.14e6,
      rising=100,
      width=7800,
      falling=100,
      period=20000,
      offset=0,
      startTime=14000)
      annotation (Placement(transformation(extent={{94,96},{114,116}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{118,58},{138,78}})));
    Modelica.Blocks.Math.Sum sum1
      annotation (Placement(transformation(extent={{136,88},{156,108}})));
    Modelica.Blocks.Sources.CombiTimeTable demand_BOP(
      tableOnFile=true,
      startTime=0,
      tableName="BOP",
      timeScale=timeScale,
      fileName=fileName)
      annotation (Placement(transformation(extent={{-80,62},{-60,82}})));
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
    connect(trapezoid2.y, add.u2) annotation (Line(points={{115,106},{120,106},{
            120,82},{108,82},{108,62},{116,62}},
                       color={0,0,127}));
    connect(trapezoid1.y, add.u1) annotation (Line(points={{85,94},{90,94},{90,78},
            {110,78},{110,74},{116,74}},
                       color={0,0,127}));
    connect(add.y, sum1.u[1]) annotation (Line(points={{139,68},{144,68},{144,84},
            {128,84},{128,98},{134,98}}, color={0,0,127}));
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
  end SMR_SHS_Test_Config_Peaking_ImpControl_2_Mikk;

  model SMR_SHS_Test_Config_Peaking_ImpControl_3
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
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_3
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC_ImpControl_3
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI_TempControl_2
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TempControl_2
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
      amplitude=30e6,
      f=1/20000,
      offset=40e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{-26,72},{-6,92}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=41e6,
      rising=100,
      width=8000,
      falling=100,
      period=16000,
      offset=26e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{20,72},{40,92}})));
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
        StopTime=200000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_SHS_Test_Config_Peaking_ImpControl_3;

  model SMR_SHS_Test_Config_Independent
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
            intermediate_Rankine_Cycle_TESUC.powerSensor.power, W_Setpoint=
            trapezoid.y),
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
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_1_Independent
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC_1_intermediate
        CS(electric_demand=trapezoid.y))
      annotation (Placement(transformation(extent={{62,-20},{102,20}})));
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI_TempControl_2
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TempControl_2
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
      amplitude=30e6,
      f=1/20000,
      offset=40e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{-26,72},{-6,92}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=41e6,
      rising=100,
      width=8000,
      falling=100,
      period=16000,
      offset=26e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{20,72},{40,92}})));
    BalanceOfPlant.Turbine.SteamTurbine_Basic_NoFeedHeat
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle
        CS(electric_demand=trapezoid.y))
      annotation (Placement(transformation(extent={{108,-84},{146,-42}})));
  equation

    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{28,-6},{44,-6},{44,-8},{62,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{102,0},{108,0},{108,-1.1},{112,-1.1}}, color={255,
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
      annotation (Line(points={{30,-30},{69.2,-30},{69.2,-19.2}}, color={0,127,255}));
    connect(stateSensor6.port_b,
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_a)
      annotation (Line(points={{62,-68},{100,-68},{100,-60},{102,-60},{102,-50},{
            108,-50},{108,-54.6}},
                               color={0,127,255}));
    connect(stateSensor7.port_a,
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_b)
      annotation (Line(points={{68,-55},{68,-71.4},{108,-71.4}}, color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.portElec_b,
      SY.port_a[2]) annotation (Line(points={{146,-63},{152,-63},{152,-26},{108,
            -26},{108,1.1},{112,1.1}},
                                  color={255,0,0}));
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
  end SMR_SHS_Test_Config_Independent;

  model SMR_SHS_Test_Config_Peaking_ImpControl_2
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
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_3_Peaking_IC_2
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC_ImpControl_2
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI_TempControl_2
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TempControl_2
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
        DHX_NTU=10,
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
      amplitude=30e6,
      f=1/20000,
      offset=40e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{-26,72},{-6,92}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=41e6,
      rising=100,
      width=8000,
      falling=100,
      period=16000,
      offset=26e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{20,72},{40,92}})));
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
        StopTime=200000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_SHS_Test_Config_Peaking_ImpControl_2;

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
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_3_Peaking_IC
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC_ImpControl
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
        ht_surface_pressure=120000,
        hot_tank_init_temp=513.15,
        cold_tank_level_max=100,
        cold_tank_area=100,
        ct_surface_pressure=120000,
        cold_tank_init_temp=453.15,
        m_flow_ch_min=0.1,
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

  model SMR_SHS_Test_Config_Peaking_TempControl
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
            intermediate_Rankine_Cycle_TESUC.powerSensor.power, W_Setpoint=48e6),
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
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_3_Peaking
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC
        CS) annotation (Placement(transformation(extent={{62,-20},{102,20}})));
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
        ht_area=100,
        hot_tank_init_temp=513.15,
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
        disvalve_m_flow_nom=100,
        chvalve_m_flow_nom=200),
      redeclare package Storage_Medium =
          NHES.Media.Hitec.Hitec,
      m_flow_min=0.1,
      tank_height=15,
      Steam_Output_Temp=stateSensor6.temperature.T)
      annotation (Placement(transformation(extent={{-20,-76},{20,-36}})));

    TRANSFORM.Fluid.Valves.ValveLinear SHS_Throttle(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=450000,
      m_flow_nominal=60) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={46,-30})));
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
    Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
      amplitude=0.25,
      rising=30,
      falling=30,
      offset=0.008)
      annotation (Placement(transformation(extent={{32,-24},{42,-14}})));
    TRANSFORM.Fluid.Valves.ValveLinear SHS_Throttle_CoolSide(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=100000,
      m_flow_nominal=30) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={90,-58})));
    Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid1(
      amplitude=-0.069,
      rising=30,
      falling=30,
      offset=0.07)
      annotation (Placement(transformation(extent={{136,-46},{126,-36}})));
  equation
      two_Tank_SHS_System_NTU.Charging_Trigger = triggeredTrapezoid.u;
      two_Tank_SHS_System_NTU.Charging_Trigger = triggeredTrapezoid1.u;
    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{28,-6},{44,-6},{44,-8},{62,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{102,0},{108,0},{108,0},{112,0}},       color={255,
            0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{152,0},{160,0}}, color={255,0,0}));
    connect(SHS_Throttle.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
      annotation (Line(points={{52,-30},{69.2,-30},{69.2,-19.2}},
          color={0,127,255}));
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
    connect(stateSensor5.port_b, SHS_Throttle.port_a)
      annotation (Line(points={{30,-30},{40,-30}}, color={0,127,255}));
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
    connect(triggeredTrapezoid.y, SHS_Throttle.opening) annotation (Line(points={{42.5,
            -19},{46,-19},{46,-25.2}},      color={0,0,127}));
    connect(stateSensor7.port_a, SHS_Throttle_CoolSide.port_a) annotation (Line(
          points={{68,-55},{76,-55},{76,-58},{84,-58}}, color={0,127,255}));
    connect(SHS_Throttle_CoolSide.port_b, intermediate_Rankine_Cycle_TESUC.port_b1)
      annotation (Line(points={{96,-58},{104,-58},{104,-24},{106,-24},{106,-10.4},
            {101.6,-10.4}}, color={0,127,255}));
    connect(stateSensor6.port_b, intermediate_Rankine_Cycle_TESUC.port_a2)
      annotation (Line(points={{62,-68},{108,-68},{108,13.6},{101.6,13.6}}, color=
           {0,127,255}));
    connect(SHS_Throttle_CoolSide.opening, triggeredTrapezoid1.y) annotation (
        Line(points={{90,-53.2},{90,-50},{118,-50},{118,-41},{125.5,-41}}, color={
            0,0,127}));
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
        Interval=5,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_SHS_Test_Config_Peaking_TempControl;

  model SMR_SHS_Test_Config_Peaking
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
            intermediate_Rankine_Cycle_TESUC.powerSensor.power, W_Setpoint=48e6),
      port_a_nominal(
        m_flow=67.07,
        T(displayUnit="degC") = 422.05,
        p=3447380))
      annotation (Placement(transformation(extent={{-102,-28},{-52,28}})));

    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=SMR_Taveprogram.port_b_nominal.p,
        h=SMR_Taveprogram.port_b_nominal.h,
        m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
            SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h),
      port_b3_nominal_m_flow={-0.67},
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-12,-18},{28,22}})));
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_3_Peaking
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC
        CS) annotation (Placement(transformation(extent={{62,-20},{102,20}})));
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI
      two_Tank_SHS_System_NTU(
      redeclare NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        ht_area=100,
        hot_tank_init_temp=553.15,
        cold_tank_area=100,
        cold_tank_init_temp=473.15,
        m_flow_ch_min=0.1,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4")),
      m_flow_min=2.5,
      tank_height=15,
      Produced_steam_flow=intermediate_Rankine_Cycle_TESUC.port_a2.m_flow)
      annotation (Placement(transformation(extent={{-20,-76},{20,-36}})));

    TRANSFORM.Fluid.Valves.ValveLinear SHS_Throttle(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1000000,
      m_flow_nominal=30) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={48,-30})));
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
      annotation (Placement(transformation(extent={{52,-104},{96,-72}})));
    Fluid.Sensors.stateDisplay stateDisplay7
      annotation (Placement(transformation(extent={{64,-56},{108,-24}})));
    Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{48,-76},{62,-60}})));
    Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{96,-76},{82,-60}})));
    Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
      amplitude=0.1,
      rising=30,
      falling=30,
      offset=0.015)
      annotation (Placement(transformation(extent={{32,-22},{42,-12}})));
    TRANSFORM.Fluid.Valves.ValveLinear SHS_Throttle_CoolSide(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=100000,
      m_flow_nominal=30) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={110,-68})));
    Modelica.Blocks.Sources.Constant const(k=0.07)
      annotation (Placement(transformation(extent={{146,-66},{134,-54}})));
  equation
      two_Tank_SHS_System_NTU.Charging_Trigger = triggeredTrapezoid.u;
    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{28,-6},{44,-6},{44,-8},{62,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{102,0},{108,0},{108,0},{112,0}},       color={255,
            0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{152,0},{160,0}}, color={255,0,0}));
    connect(SHS_Throttle.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
      annotation (Line(points={{54,-30},{69.2,-30},{69.2,-19.2}},
          color={0,127,255}));
    connect(SMR_Taveprogram.port_b, stateSensor1.port_a) annotation (Line(points={{
            -51.0909,10.7692},{-51.0909,11},{-38,11}},  color={0,127,255}));
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
    connect(SMR_Taveprogram.port_a, stateSensor3.port_b) annotation (Line(points={
            {-51.0909,-3.44615},{-46,-3.44615},{-46,-6},{-40,-6}}, color={0,127,255}));
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
    connect(stateSensor5.port_b, SHS_Throttle.port_a)
      annotation (Line(points={{30,-30},{42,-30}}, color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
        Line(points={{-19.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
    connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
          points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
        Line(points={{20,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
    connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
          points={{55.035,-67.96},{55.035,-54},{86,-54},{86,-44.16}}, color={0,0,0}));
    connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
          points={{88.965,-67.96},{88,-67.96},{88,-78},{100,-78},{100,-98},{74,-98},
            {74,-92.16}}, color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
        Line(points={{19.6,-44.4},{38,-44.4},{38,-74},{82,-74},{82,-68}}, color={0,
            127,255}));
    connect(triggeredTrapezoid.y, SHS_Throttle.opening) annotation (Line(points={{42.5,
            -17},{48,-17},{48,-25.2}},      color={0,0,127}));
    connect(stateSensor7.port_a, SHS_Throttle_CoolSide.port_a)
      annotation (Line(points={{96,-68},{104,-68}}, color={0,127,255}));
    connect(SHS_Throttle_CoolSide.port_b, intermediate_Rankine_Cycle_TESUC.port_b1)
      annotation (Line(points={{116,-68},{124,-68},{124,-28},{108,-28},{108,-10.4},
            {101.6,-10.4}}, color={0,127,255}));
    connect(stateSensor6.port_b, intermediate_Rankine_Cycle_TESUC.port_a2)
      annotation (Line(points={{62,-68},{62,-58},{110,-58},{110,13.6},{101.6,13.6}},
          color={0,127,255}));
    connect(SHS_Throttle_CoolSide.opening, const.y) annotation (Line(points={{110,
            -63.2},{110,-60},{133.4,-60}}, color={0,0,127}));
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
        Interval=5,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_SHS_Test_Config_Peaking;

  model SMR_SHS_Test_6
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
            intermediate_Rankine_Cycle_TESUC.powerSensor.power, W_Setpoint=48e6),
      port_a_nominal(
        m_flow=67.07,
        T(displayUnit="degC") = 422.05,
        p=3447380))
      annotation (Placement(transformation(extent={{-102,-28},{-52,28}})));

    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=SMR_Taveprogram.port_b_nominal.p,
        h=SMR_Taveprogram.port_b_nominal.h,
        m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
            SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h),
      port_b3_nominal_m_flow={-0.67},
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-12,-18},{28,22}})));
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_2
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TESUC CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        ht_area=100,
        hot_tank_init_temp=573.15,
        cold_tank_area=100,
        cold_tank_init_temp=373.15,
        m_flow_ch_min=0.1,
        DHX_NTU=20,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4"),
        DHX_p_start_shell=1200000,
        DHX_Q_init=1e6),
      m_flow_min=2.5,
      tank_height=15,
      Produced_steam_flow=intermediate_Rankine_Cycle_TESUC_SmallCycle.port_a.m_flow)
      annotation (Placement(transformation(extent={{-20,-76},{20,-36}})));

    TRANSFORM.Fluid.Valves.ValveLinear SHS_Throttle(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1000000,
      m_flow_nominal=30) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={50,-30})));
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_SmallCycle_Pressure
      intermediate_Rankine_Cycle_TESUC_SmallCycle(
      port_a_nominal(
        p=1200000,
        h=2e6,
        m_flow=20),
      port_b_nominal(
        p=1300000,
        h=1e6,
        m_flow=-20),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_6_Pressure
        CS,
      port_a_start(
        p=1100000,
        h=2e6,
        m_flow=20),
      port_b_start(
        p=1200000,
        h=1e6,
        m_flow=-20))
      annotation (Placement(transformation(extent={{112,-80},{152,-40}})));
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
      annotation (Placement(transformation(extent={{52,-104},{96,-72}})));
    Fluid.Sensors.stateDisplay stateDisplay7
      annotation (Placement(transformation(extent={{64,-56},{108,-24}})));
    Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{48,-76},{62,-60}})));
    Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{96,-76},{82,-60}})));
    Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
      amplitude=0.1,
      rising=30,
      falling=30,
      offset=0.015)
      annotation (Placement(transformation(extent={{34,-22},{44,-12}})));
  equation
      two_Tank_SHS_System_NTU.Charging_Trigger = triggeredTrapezoid.u;
    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{28,-6},{44,-6},{44,-8},{62,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{102,0},{108,0},{108,-1.1},{112,-1.1}}, color={255,
            0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{152,0},{160,0}}, color={255,0,0}));
    connect(SHS_Throttle.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
      annotation (Line(points={{56,-30},{69.2,-30},{69.2,-19.2}},
          color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC_SmallCycle.portElec_b, SY.port_a[2])
      annotation (Line(points={{152,-60},{158,-60},{158,-26},{108,-26},{108,1.1},
            {112,1.1}}, color={255,0,0}));
    connect(SMR_Taveprogram.port_b, stateSensor1.port_a) annotation (Line(points={{
            -51.0909,10.7692},{-51.0909,11},{-38,11}},  color={0,127,255}));
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
    connect(SMR_Taveprogram.port_a, stateSensor3.port_b) annotation (Line(points={
            {-51.0909,-3.44615},{-46,-3.44615},{-46,-6},{-40,-6}}, color={0,127,255}));
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
    connect(stateSensor5.port_b, SHS_Throttle.port_a)
      annotation (Line(points={{30,-30},{44,-30}}, color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
        Line(points={{-19.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
    connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
          points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
        Line(points={{20,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
    connect(stateSensor6.port_b, intermediate_Rankine_Cycle_TESUC_SmallCycle.port_a)
      annotation (Line(points={{62,-68},{64,-68},{64,-52},{112,-52}}, color={0,
            127,255}));
    connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
          points={{55.035,-67.96},{55.035,-54},{86,-54},{86,-44.16}}, color={0,0,0}));
    connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
          points={{88.965,-67.96},{88,-67.96},{88,-78},{100,-78},{100,-98},{74,-98},
            {74,-92.16}}, color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
        Line(points={{19.6,-44.4},{38,-44.4},{38,-74},{82,-74},{82,-68}}, color={0,
            127,255}));
    connect(stateSensor7.port_a, intermediate_Rankine_Cycle_TESUC_SmallCycle.port_b)
      annotation (Line(points={{96,-68},{112,-68}}, color={0,127,255}));
    connect(triggeredTrapezoid.y, SHS_Throttle.opening) annotation (Line(points={{
            44.5,-17},{50,-17},{50,-25.2}}, color={0,0,127}));
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
        StopTime=200,
        Interval=2,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_SHS_Test_6;

  model SMR_SHS_Test_4_NewSHS_NewCS
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
            intermediate_Rankine_Cycle_TESUC.powerSensor.power, W_Setpoint=SC.W_totalSetpoint_BOP),
      port_a_nominal(
        m_flow=67.07,
        T(displayUnit="degC") = 422.05,
        p=3447380))
      annotation (Placement(transformation(extent={{-102,-28},{-52,28}})));

    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=SMR_Taveprogram.port_b_nominal.p,
        h=SMR_Taveprogram.port_b_nominal.h,
        m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
            SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h),
      port_b3_nominal_m_flow={-0.67},
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-12,-18},{28,22}})));
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_2
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC
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
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Basic_TESUC CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        ht_area=100,
        cold_tank_area=100,
        m_flow_ch_min=0.1,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4")),
      m_flow_min=2.5,
      tank_height=15,
      Power_Demand=0.0,
      T_Steam=463.15)
      annotation (Placement(transformation(extent={{-20,-76},{20,-36}})));

    TRANSFORM.Fluid.Valves.ValveLinear SHS_Throttle(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1000000,
      m_flow_nominal=30) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={50,-30})));
    Modelica.Blocks.Sources.Constant const(k=0.015)
      annotation (Placement(transformation(extent={{38,-22},{48,-12}})));
    BalanceOfPlant.Turbine.ObsoleteRankines.SteamTurbine_L1_boundaries_no_heat
      BOP1(
      port_a_nominal(
        p=1200000,
        h=2e6,
        m_flow=20),
      port_b_nominal(
        p=1300000,
        h=1e6,
        m_flow=-20),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
        CS(
        delayStartTCV=100,
        p_nominal=1200000,
        W_totalSetpoint=60e6),
      p_condenser=8000,
      p_reservoir=1200000,
      nPorts_a3=1)
      annotation (Placement(transformation(extent={{112,-78},{152,-38}})));
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
      annotation (Placement(transformation(extent={{52,-104},{96,-72}})));
    Fluid.Sensors.stateDisplay stateDisplay7
      annotation (Placement(transformation(extent={{64,-56},{108,-24}})));
    Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{48,-76},{62,-60}})));
    Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{96,-76},{82,-60}})));
  equation
    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{28,-6},{44,-6},{44,-8},{62,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{102,0},{108,0},{108,-1.1},{112,-1.1}}, color={255,
            0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{152,0},{160,0}}, color={255,0,0}));
    connect(const.y, SHS_Throttle.opening)
      annotation (Line(points={{48.5,-17},{50,-17},{50,-25.2}},
                                                            color={0,0,127}));
    connect(SHS_Throttle.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
      annotation (Line(points={{56,-30},{69.2,-30},{69.2,-19.2}},
          color={0,127,255}));
    connect(BOP1.portElec_b, SY.port_a[2])
      annotation (Line(points={{152,-58},{158,-58},{158,-26},{108,-26},{108,1.1},{
            112,1.1}},                                         color={255,0,0}));
    connect(SMR_Taveprogram.port_b, stateSensor1.port_a) annotation (Line(points={{
            -51.0909,10.7692},{-51.0909,11},{-38,11}},  color={0,127,255}));
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
    connect(SMR_Taveprogram.port_a, stateSensor3.port_b) annotation (Line(points={
            {-51.0909,-3.44615},{-46,-3.44615},{-46,-6},{-40,-6}}, color={0,127,255}));
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
    connect(stateSensor5.port_b, SHS_Throttle.port_a)
      annotation (Line(points={{30,-30},{44,-30}}, color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
        Line(points={{-19.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
    connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
          points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
        Line(points={{20,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
    connect(stateSensor6.port_b, BOP1.port_a) annotation (Line(points={{62,-68},{64,
            -68},{64,-50},{112,-50}}, color={0,127,255}));
    connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
          points={{55.035,-67.96},{55.035,-54},{86,-54},{86,-44.16}}, color={0,0,0}));
    connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
          points={{88.965,-67.96},{88,-67.96},{88,-78},{100,-78},{100,-98},{74,-98},
            {74,-92.16}}, color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
        Line(points={{19.6,-44.4},{38,-44.4},{38,-74},{82,-74},{82,-68}}, color={0,
            127,255}));
    connect(stateSensor7.port_a, BOP1.port_b) annotation (Line(points={{96,-68},{112,
            -68},{112,-66}}, color={0,127,255}));
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
        __Dymola_NumberOfIntervals=1000,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_SHS_Test_4_NewSHS_NewCS;

  model SMR_SHS_Test_4_Mikk
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
            intermediate_Rankine_Cycle_TESUC.powerSensor.power, W_Setpoint=SC.W_totalSetpoint_BOP),
      port_a_nominal(
        m_flow=67.07,
        T(displayUnit="degC") = 422.05,
        p=3447380))
      annotation (Placement(transformation(extent={{-102,-28},{-52,28}})));

    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=SMR_Taveprogram.port_b_nominal.p,
        h=SMR_Taveprogram.port_b_nominal.h,
        m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
            SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h),
      port_b3_nominal_m_flow={-0.67},
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-12,-18},{28,22}})));
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_2
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI two_Tank_SHS_System_NTU(
      redeclare NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        ht_area=100,
        cold_tank_area=100,
        m_flow_ch_min=0.1,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4")),
      m_flow_min=2.5,
      tank_height=15,
      Produced_steam_flow=20)
      annotation (Placement(transformation(extent={{-20,-76},{20,-36}})));

    TRANSFORM.Fluid.Valves.ValveLinear SHS_Throttle(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1000000,
      m_flow_nominal=30) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={50,-30})));
    Modelica.Blocks.Sources.Constant const(k=0.015)
      annotation (Placement(transformation(extent={{38,-22},{48,-12}})));
    BalanceOfPlant.Turbine.ObsoleteRankines.SteamTurbine_L1_boundaries_no_heat
      BOP1(
      port_a_nominal(
        p=1200000,
        h=2e6,
        m_flow=20),
      port_b_nominal(
        p=1300000,
        h=1e6,
        m_flow=-20),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
        CS(
        delayStartTCV=100,
        p_nominal=1200000,
        W_totalSetpoint=60e6),
      p_condenser=8000,
      p_reservoir=1200000,
      nPorts_a3=1)
      annotation (Placement(transformation(extent={{112,-78},{152,-38}})));
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
      annotation (Placement(transformation(extent={{52,-104},{96,-72}})));
    Fluid.Sensors.stateDisplay stateDisplay7
      annotation (Placement(transformation(extent={{64,-56},{108,-24}})));
    Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{48,-76},{62,-60}})));
    Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{96,-76},{82,-60}})));
  equation
    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{28,-6},{44,-6},{44,-8},{62,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{102,0},{108,0},{108,-1.1},{112,-1.1}}, color={255,
            0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{152,0},{160,0}}, color={255,0,0}));
    connect(const.y, SHS_Throttle.opening)
      annotation (Line(points={{48.5,-17},{50,-17},{50,-25.2}},
                                                            color={0,0,127}));
    connect(SHS_Throttle.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
      annotation (Line(points={{56,-30},{69.2,-30},{69.2,-19.2}},
          color={0,127,255}));
    connect(BOP1.portElec_b, SY.port_a[2])
      annotation (Line(points={{152,-58},{158,-58},{158,-26},{108,-26},{108,1.1},{
            112,1.1}},                                         color={255,0,0}));
    connect(SMR_Taveprogram.port_b, stateSensor1.port_a) annotation (Line(points={{
            -51.0909,10.7692},{-51.0909,11},{-38,11}},  color={0,127,255}));
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
    connect(SMR_Taveprogram.port_a, stateSensor3.port_b) annotation (Line(points={
            {-51.0909,-3.44615},{-46,-3.44615},{-46,-6},{-40,-6}}, color={0,127,255}));
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
    connect(stateSensor5.port_b, SHS_Throttle.port_a)
      annotation (Line(points={{30,-30},{44,-30}}, color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
        Line(points={{-19.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
    connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
          points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
        Line(points={{20,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
    connect(stateSensor6.port_b, BOP1.port_a) annotation (Line(points={{62,-68},{64,
            -68},{64,-50},{112,-50}}, color={0,127,255}));
    connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
          points={{55.035,-67.96},{55.035,-54},{86,-54},{86,-44.16}}, color={0,0,0}));
    connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
          points={{88.965,-67.96},{88,-67.96},{88,-78},{100,-78},{100,-98},{74,-98},
            {74,-92.16}}, color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
        Line(points={{19.6,-44.4},{38,-44.4},{38,-74},{82,-74},{82,-68}}, color={0,
            127,255}));
    connect(stateSensor7.port_a, BOP1.port_b) annotation (Line(points={{96,-68},{112,
            -68},{112,-66}}, color={0,127,255}));
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
        __Dymola_NumberOfIntervals=1000,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_SHS_Test_4_Mikk;

  model SMR_SHS_Test_5
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
            intermediate_Rankine_Cycle_TESUC.powerSensor.power, W_Setpoint=48e6),
      port_a_nominal(
        m_flow=67.07,
        T(displayUnit="degC") = 422.05,
        p=3447380))
      annotation (Placement(transformation(extent={{-102,-28},{-52,28}})));

    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=SMR_Taveprogram.port_b_nominal.p,
        h=SMR_Taveprogram.port_b_nominal.h,
        m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
            SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h),
      port_b3_nominal_m_flow={-0.67},
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-12,-18},{28,22}})));
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_2
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TESUC CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        ht_area=100,
        hot_tank_init_temp=573.15,
        cold_tank_area=100,
        cold_tank_init_temp=373.15,
        m_flow_ch_min=0.1,
        DHX_NTU=20,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4"),
        DHX_p_start_shell=1200000,
        DHX_Q_init=1e6),
      m_flow_min=2.5,
      tank_height=15,
      Produced_steam_flow=intermediate_Rankine_Cycle_TESUC_SmallCycle.port_a.m_flow)
      annotation (Placement(transformation(extent={{-20,-76},{20,-36}})));

    TRANSFORM.Fluid.Valves.ValveLinear SHS_Throttle(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1000000,
      m_flow_nominal=30) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={50,-30})));
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_SmallCycle
      intermediate_Rankine_Cycle_TESUC_SmallCycle(
      port_a_nominal(
        p=1200000,
        h=2e6,
        m_flow=20),
      port_b_nominal(
        p=1300000,
        h=1e6,
        m_flow=-20),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_6
        CS,
      port_a_start(
        p=1100000,
        h=2e6,
        m_flow=20),
      port_b_start(
        p=1200000,
        h=1e6,
        m_flow=-20))
      annotation (Placement(transformation(extent={{112,-80},{152,-40}})));
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
      annotation (Placement(transformation(extent={{52,-104},{96,-72}})));
    Fluid.Sensors.stateDisplay stateDisplay7
      annotation (Placement(transformation(extent={{64,-56},{108,-24}})));
    Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{48,-76},{62,-60}})));
    Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{96,-76},{82,-60}})));
    Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
      amplitude=0.1,
      rising=30,
      falling=30,
      offset=0.015)
      annotation (Placement(transformation(extent={{34,-22},{44,-12}})));
  equation
      two_Tank_SHS_System_NTU.Charging_Trigger = triggeredTrapezoid.u;
    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{28,-6},{44,-6},{44,-8},{62,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{102,0},{108,0},{108,-1.1},{112,-1.1}}, color={255,
            0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{152,0},{160,0}}, color={255,0,0}));
    connect(SHS_Throttle.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
      annotation (Line(points={{56,-30},{69.2,-30},{69.2,-19.2}},
          color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC_SmallCycle.portElec_b, SY.port_a[2])
      annotation (Line(points={{152,-60},{158,-60},{158,-26},{108,-26},{108,1.1},
            {112,1.1}}, color={255,0,0}));
    connect(SMR_Taveprogram.port_b, stateSensor1.port_a) annotation (Line(points={{
            -51.0909,10.7692},{-51.0909,11},{-38,11}},  color={0,127,255}));
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
    connect(SMR_Taveprogram.port_a, stateSensor3.port_b) annotation (Line(points={
            {-51.0909,-3.44615},{-46,-3.44615},{-46,-6},{-40,-6}}, color={0,127,255}));
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
    connect(stateSensor5.port_b, SHS_Throttle.port_a)
      annotation (Line(points={{30,-30},{44,-30}}, color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
        Line(points={{-19.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
    connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
          points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
        Line(points={{20,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
    connect(stateSensor6.port_b, intermediate_Rankine_Cycle_TESUC_SmallCycle.port_a)
      annotation (Line(points={{62,-68},{64,-68},{64,-52},{112,-52}}, color={0,
            127,255}));
    connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
          points={{55.035,-67.96},{55.035,-54},{86,-54},{86,-44.16}}, color={0,0,0}));
    connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
          points={{88.965,-67.96},{88,-67.96},{88,-78},{100,-78},{100,-98},{74,-98},
            {74,-92.16}}, color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
        Line(points={{19.6,-44.4},{38,-44.4},{38,-74},{82,-74},{82,-68}}, color={0,
            127,255}));
    connect(stateSensor7.port_a, intermediate_Rankine_Cycle_TESUC_SmallCycle.port_b)
      annotation (Line(points={{96,-68},{112,-68}}, color={0,127,255}));
    connect(triggeredTrapezoid.y, SHS_Throttle.opening) annotation (Line(points={{
            44.5,-17},{50,-17},{50,-25.2}}, color={0,0,127}));
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
        StopTime=200,
        Interval=2,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_SHS_Test_5;

  model SMR_SHS_Test_4
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
            intermediate_Rankine_Cycle_TESUC.powerSensor.power, W_Setpoint=48e6),
      port_a_nominal(
        m_flow=67.07,
        T(displayUnit="degC") = 422.05,
        p=3447380))
      annotation (Placement(transformation(extent={{-102,-28},{-52,28}})));

    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=SMR_Taveprogram.port_b_nominal.p,
        h=SMR_Taveprogram.port_b_nominal.h,
        m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
            SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h),
      port_b3_nominal_m_flow={-0.67},
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-12,-18},{28,22}})));
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_2
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_TESUC
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TESUC CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        ht_area=100,
        cold_tank_area=100,
        m_flow_ch_min=0.1,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4")),
      m_flow_min=2.5,
      tank_height=15,
      Produced_steam_flow=26)
      annotation (Placement(transformation(extent={{-20,-76},{20,-36}})));

    TRANSFORM.Fluid.Valves.ValveLinear SHS_Throttle(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1000000,
      m_flow_nominal=30) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={50,-30})));
    BalanceOfPlant.Turbine.ObsoleteRankines.SteamTurbine_L1_boundaries_no_heat
      BOP(
      port_a_nominal(
        p=1200000,
        h=2e6,
        m_flow=20),
      port_b_nominal(
        p=1300000,
        h=1e6,
        m_flow=-20),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
        CS(p_nominal=1200000, W_totalSetpoint=50))
      annotation (Placement(transformation(extent={{112,-80},{152,-40}})));
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
      annotation (Placement(transformation(extent={{52,-104},{96,-72}})));
    Fluid.Sensors.stateDisplay stateDisplay7
      annotation (Placement(transformation(extent={{64,-56},{108,-24}})));
    Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{48,-76},{62,-60}})));
    Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{96,-76},{82,-60}})));
    Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
      amplitude=0.1,
      rising=30,
      falling=30,
      offset=0.015)
      annotation (Placement(transformation(extent={{34,-22},{44,-12}})));
  equation
      two_Tank_SHS_System_NTU.Charging_Trigger = triggeredTrapezoid.u;
    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{28,-6},{44,-6},{44,-8},{62,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{102,0},{108,0},{108,-1.1},{112,-1.1}}, color={255,
            0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{152,0},{160,0}}, color={255,0,0}));
    connect(SHS_Throttle.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
      annotation (Line(points={{56,-30},{69.2,-30},{69.2,-19.2}},
          color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[2]) annotation (Line(points={{152,-60},{158,
            -60},{158,-26},{108,-26},{108,1.1},{112,1.1}}, color={255,0,0}));
    connect(SMR_Taveprogram.port_b, stateSensor1.port_a) annotation (Line(points={{
            -51.0909,10.7692},{-51.0909,11},{-38,11}},  color={0,127,255}));
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
    connect(SMR_Taveprogram.port_a, stateSensor3.port_b) annotation (Line(points={
            {-51.0909,-3.44615},{-46,-3.44615},{-46,-6},{-40,-6}}, color={0,127,255}));
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
    connect(stateSensor5.port_b, SHS_Throttle.port_a)
      annotation (Line(points={{30,-30},{44,-30}}, color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
        Line(points={{-19.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
    connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
          points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
        Line(points={{20,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
    connect(stateSensor6.port_b, BOP.port_a) annotation (Line(points={{62,-68},{
            64,-68},{64,-52},{112,-52}}, color={0,127,255}));
    connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
          points={{55.035,-67.96},{55.035,-54},{86,-54},{86,-44.16}}, color={0,0,0}));
    connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
          points={{88.965,-67.96},{88,-67.96},{88,-78},{100,-78},{100,-98},{74,-98},
            {74,-92.16}}, color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
        Line(points={{19.6,-44.4},{38,-44.4},{38,-74},{82,-74},{82,-68}}, color={0,
            127,255}));
    connect(stateSensor7.port_a, BOP.port_b)
      annotation (Line(points={{96,-68},{112,-68}}, color={0,127,255}));
    connect(triggeredTrapezoid.y, SHS_Throttle.opening) annotation (Line(points={{
            44.5,-17},{50,-17},{50,-25.2}}, color={0,0,127}));
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
        __Dymola_NumberOfIntervals=1000,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_SHS_Test_4;

  model SMR_highfidelity_Intermediate_TESUC
    "High Fidelity Natural Circulation Model based on NuScale reactor. Hot channel calcs, pressurizer, and beginning of cycle reactivity feedback"
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   Real demandChange=
   min(1.05,
   max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
       + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
       0.5));
    PrimaryHeatSystem.SMR_Generic.Components.SMR_High_fidelity_no_pump
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
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC
      intermediate_Rankine_Cycle_TESUC(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_5
        CS) annotation (Placement(transformation(extent={{42,-20},{82,20}})));
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
    connect(EM.port_b2, intermediate_Rankine_Cycle_TESUC.port_a)
      annotation (Line(points={{20,8},{42,8}}, color={0,127,255}));
    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{20,-8},{42,-8}}, color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
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
  end SMR_highfidelity_Intermediate_TESUC;

  model SMR_SHS_Test_3
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
            intermediate_Rankine_Cycle_TESUC.powerSensor.power, W_Setpoint=SC.W_totalSetpoint_BOP),
      port_a_nominal(
        m_flow=67.07,
        T(displayUnit="degC") = 422.05,
        p=3447380))
      annotation (Placement(transformation(extent={{-102,-28},{-52,28}})));

    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=SMR_Taveprogram.port_b_nominal.p,
        h=SMR_Taveprogram.port_b_nominal.h,
        m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
            SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h),
      port_b3_nominal_m_flow={-0.67},
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-12,-18},{28,22}})));
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI two_Tank_SHS_System_NTU(
      redeclare NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        ht_area=100,
        cold_tank_area=100,
        m_flow_ch_min=0.1,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4")),
      m_flow_min=2.5,
      tank_height=15,
      Produced_steam_flow=20)
      annotation (Placement(transformation(extent={{-20,-76},{20,-36}})));

    TRANSFORM.Fluid.Valves.ValveLinear SHS_Throttle(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=1000000,
      m_flow_nominal=30) annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={50,-30})));
    Modelica.Blocks.Sources.Constant const(k=0.015)
      annotation (Placement(transformation(extent={{38,-22},{48,-12}})));
    BalanceOfPlant.Turbine.ObsoleteRankines.SteamTurbine_L1_boundaries_no_heat
      BOP1(
      port_a_nominal(
        p=1200000,
        h=2e6,
        m_flow=20),
      port_b_nominal(
        p=1300000,
        h=1e6,
        m_flow=-20),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
        CS(
        delayStartTCV=100,
        p_nominal=1200000,
        W_totalSetpoint=60e6),
      p_condenser=8000,
      p_reservoir=1200000,
      nPorts_a3=1)
      annotation (Placement(transformation(extent={{112,-78},{152,-38}})));
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
      annotation (Placement(transformation(extent={{52,-104},{96,-72}})));
    Fluid.Sensors.stateDisplay stateDisplay7
      annotation (Placement(transformation(extent={{64,-56},{108,-24}})));
    Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{48,-76},{62,-60}})));
    Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{96,-76},{82,-60}})));
  equation
    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{28,-6},{44,-6},{44,-8},{62,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{102,0},{108,0},{108,-1.1},{112,-1.1}}, color={255,
            0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{152,0},{160,0}}, color={255,0,0}));
    connect(const.y, SHS_Throttle.opening)
      annotation (Line(points={{48.5,-17},{50,-17},{50,-25.2}},
                                                            color={0,0,127}));
    connect(SHS_Throttle.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
      annotation (Line(points={{56,-30},{69.2,-30},{69.2,-19.2}},
          color={0,127,255}));
    connect(BOP1.portElec_b, SY.port_a[2])
      annotation (Line(points={{152,-58},{158,-58},{158,-26},{108,-26},{108,1.1},{
            112,1.1}},                                         color={255,0,0}));
    connect(SMR_Taveprogram.port_b, stateSensor1.port_a) annotation (Line(points={{
            -51.0909,10.7692},{-51.0909,11},{-38,11}},  color={0,127,255}));
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
    connect(SMR_Taveprogram.port_a, stateSensor3.port_b) annotation (Line(points={
            {-51.0909,-3.44615},{-46,-3.44615},{-46,-6},{-40,-6}}, color={0,127,255}));
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
    connect(stateSensor5.port_b, SHS_Throttle.port_a)
      annotation (Line(points={{30,-30},{44,-30}}, color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
        Line(points={{-19.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
    connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
          points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
        Line(points={{20,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
    connect(stateSensor6.port_b, BOP1.port_a) annotation (Line(points={{62,-68},{64,
            -68},{64,-50},{112,-50}}, color={0,127,255}));
    connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
          points={{55.035,-67.96},{55.035,-54},{86,-54},{86,-44.16}}, color={0,0,0}));
    connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
          points={{88.965,-67.96},{88,-67.96},{88,-78},{100,-78},{100,-98},{74,-98},
            {74,-92.16}}, color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
        Line(points={{19.6,-44.4},{38,-44.4},{38,-74},{82,-74},{82,-68}}, color={0,
            127,255}));
    connect(stateSensor7.port_a, BOP1.port_b) annotation (Line(points={{96,-68},{112,
            -68},{112,-66}}, color={0,127,255}));
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
        __Dymola_NumberOfIntervals=1000,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_SHS_Test_3;

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
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC
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
    BalanceOfPlant.Turbine.ObsoleteRankines.Intermediate_Rankine_Cycle_TESUC_SmallCycle
      intermediate_Rankine_Cycle_TESUC1(
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.ObsoleteCS.CS_IntermediateControl_PID_6
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

  model SMR_SHS_Test
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
          W_Setpoint=SC.W_totalSetpoint_BOP),
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
      port_b3_nominal_m_flow={-33},
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
        Nominal_Power(displayUnit="MW") = 160000000))
      annotation (Placement(transformation(extent={{64,-20},{104,20}})));
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
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU
      two_Tank_SHS_System_NTU(
      redeclare NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03 CS,
      redeclare replaceable EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        cold_tank_init_temp=453.15,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4"),
        DHX_p_start_shell=200000), Produced_steam_flow=10)
      annotation (Placement(transformation(extent={{-20,-78},{20,-38}})));
    TRANSFORM.Fluid.Valves.ValveLinear TCV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow_start=400,
      dp_nominal=500000,
      m_flow_nominal=33) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={40,-32})));
    Modelica.Blocks.Sources.Constant const(k=0.5)
      annotation (Placement(transformation(extent={{2,36},{22,56}})));
    BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP1(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
        CS(
        delayStartTCV=100,
        p_nominal=1200000,
        W_totalSetpoint=192e3),
      nPorts_a3=1)
      annotation (Placement(transformation(extent={{64,-78},{104,-38}})));
  equation
    connect(SMR_Taveprogram.port_b, EM.port_a1) annotation (Line(points={{
            -35.0909,12.7692},{-30,12.7692},{-30,8},{-20,8}}, color={0,127,255}));
    connect(SMR_Taveprogram.port_a, EM.port_b1) annotation (Line(points={{-35.0909,
            -1.44615},{-30,-1.44615},{-30,-8},{-20,-8}}, color={0,127,255}));
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{20,8},{64,8}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{20,-8},{64,-8}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1])
      annotation (Line(points={{104,0},{108,0},{108,-1.1},{112,-1.1}},
                                                color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{152,0},{160,0}}, color={255,0,0}));
    connect(EM.port_b3[1], two_Tank_SHS_System_NTU.port_ch_a) annotation (Line(
          points={{8,-20},{8,-32},{-40,-32},{-40,-70.4},{-19.6,-70.4}}, color={0,
            127,255}));
    connect(TCV.port_a, two_Tank_SHS_System_NTU.port_ch_b) annotation (Line(
          points={{32,-32},{16,-32},{16,-34},{-26,-34},{-26,-47.2},{-19.6,-47.2}},
          color={0,127,255}));
    connect(const.y, TCV.opening)
      annotation (Line(points={{23,46},{40,46},{40,-25.6}}, color={0,0,127}));
    connect(TCV.port_b, BOP.port_b) annotation (Line(points={{48,-32},{50,-32},{
            50,-8},{64,-8}}, color={0,127,255}));
    connect(BOP1.portElec_b, SY.port_a[2]) annotation (Line(points={{104,-58},{
            110,-58},{110,-26},{108,-26},{108,1.1},{112,1.1}}, color={255,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, BOP1.port_b) annotation (Line(
          points={{19.6,-46.4},{32,-46.4},{32,-66},{64,-66}}, color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, BOP1.port_a) annotation (Line(
          points={{20,-70.4},{36,-70.4},{36,-70},{48,-70},{48,-50},{64,-50}},
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
        __Dymola_NumberOfIntervals=360,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SMR_SHS_Test;

  model SMR_SHS_Independent "Nuscale SMR with two tank independent heat system"
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   Real demandChange=
   min(1.05,
   max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
       + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
       0.5));
    PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
      nuScale_Tave_enthalpy_Pressurizer_CR(
      port_a_nominal(
        m_flow=90,
        T(displayUnit="degC") = 421.15,
        p=3447380),
      port_b_nominal(
        T(displayUnit="degC") = 579.75,
        h=2997670,
        p=3447380),
      redeclare NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy
        CS(T_SG_exit=579.15, Q_nom=200),
      redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-92,-24},{-38,34}})));
    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.p,
        h=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.h,
        m_flow=-nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.m_flow),
        port_b1_nominal(p=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.p,
          h=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.h),
      port_b3_nominal_m_flow={-33},
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-12,-20},{28,20}})));
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
        W_totalSetpoint=26e6),
      nPorts_a3=1)
      annotation (Placement(transformation(extent={{40,-20},{80,20}})));
    SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)
      annotation (Placement(transformation(extent={{100,-22},{140,22}})));
    ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
        53303300, BOP_capacity(displayUnit="MW") = 60000000)
      annotation (Placement(transformation(extent={{-98,82},{-78,102}})));
    Modelica.Blocks.Sources.Constant delayStart(k=100)
      annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
    SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
      W_nominal_BOP(displayUnit="MW") = 60000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Uprate_timeSeries.txt"))
      annotation (Placement(transformation(extent={{158,60},{198,100}})));
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU
      two_Tank_SHS_System_NTU(redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4"),
        DHX_p_start_shell=500000), Produced_steam_flow=10)
      annotation (Placement(transformation(extent={{-20,-76},{20,-36}})));
    BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP1(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        BalanceOfPlant.Turbine.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
        CS(
        delayStartTCV=100,
        p_nominal=1200000,
        W_totalSetpoint=192e3),
      nPorts_a3=1)
      annotation (Placement(transformation(extent={{42,-74},{82,-34}})));
  equation
    connect(nuScale_Tave_enthalpy_Pressurizer_CR.port_b, EM.port_a1) annotation (
        Line(points={{-37.0182,16.1538},{-30,16.1538},{-30,8},{-12,8}}, color={0,
            127,255}));
    connect(nuScale_Tave_enthalpy_Pressurizer_CR.port_a, EM.port_b1) annotation (
        Line(points={{-37.0182,1.43077},{-30,1.43077},{-30,-8},{-12,-8}},
          color={0,127,255}));
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{28,8},{40,8}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{28,-8},{40,-8}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1])
      annotation (Line(points={{80,0},{92,0},{92,-1.1},{100,-1.1}},
                                                color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{140,0},{160,0}}, color={255,0,0}));
    connect(BOP1.portElec_b, SY.port_a[2]) annotation (Line(points={{82,-54},{88,
            -54},{88,1.1},{100,1.1}}, color={255,0,0}));
    connect(two_Tank_SHS_System_NTU.port_ch_a, EM.port_b3[1]) annotation (Line(
          points={{-19.6,-68.4},{-32,-68.4},{-32,-26},{16,-26},{16,-20}}, color={
            0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, BOP.port_a3[1]) annotation (Line(
          points={{-19.6,-45.2},{-24,-45.2},{-24,-28},{52,-28},{52,-20}}, color={
            0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, BOP1.port_b) annotation (Line(
          points={{19.6,-44.4},{26,-44.4},{26,-62},{42,-62}}, color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, BOP1.port_a) annotation (Line(
          points={{20,-68.4},{28,-68.4},{28,-66},{36,-66},{36,-46},{42,-46}},
          color={0,127,255}));
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
  end SMR_SHS_Independent;

  model HTGR_Case_01_IndependentBOP_2
    "TES use case demonstration of a NuScale-style LWR operating within an energy arbitrage IES, storing and dispensing energy on demand from a two tank molten salt energy storage system nominally using HITEC salt to store heat."
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

    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=SMR_Taveprogram.port_b_nominal.p,
        h=SMR_Taveprogram.port_b_nominal.h,
        m_flow=-SMR_Taveprogram.port_b_nominal.m_flow), port_b1_nominal(p=
            SMR_Taveprogram.port_a_nominal.p, h=SMR_Taveprogram.port_a_nominal.h),
      port_b3_nominal_m_flow={-0.67},
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-10,-18},{30,22}})));
    BalanceOfPlant.Turbine.SteamTurbine_OpenFeedHeat_DivertPowerControl
      intermediate_Rankine_Cycle_TESUC(
      redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.TESTurbine
        data(
        p_in_nominal=15000000,
        p_condensor=8000,
        V_FeedwaterMixVolume=25,
        V_Header=10,
        valve_TCV_mflow=67,
        valve_TCV_dp_nominal=100000,
        valve_SHS_mflow=30,
        valve_SHS_dp_nominal=600000,
        valve_TCV_LPT_mflow=30,
        valve_TCV_LPT_dp_nominal=10000,
        InternalBypassValve_mflow_small=0,
        InternalBypassValve_p_spring=15000000,
        InternalBypassValve_K(unit="1/(m.kg)") = 40,
        InternalBypassValve_tau(unit="1/s"),
        HPT_p_exit_nominal=700000,
        HPT_T_in_nominal=579.15,
        HPT_nominal_mflow=67,
        HPT_efficiency=1,
        LPT_p_in_nominal=700000,
        LPT_p_exit_nominal=7000,
        LPT_T_in_nominal=523.15,
        LPT_nominal_mflow=20,
        LPT_efficiency=1,
        firstfeedpump_p_nominal=5500000,
        secondfeedpump_p_nominal=10000000,
        MainFeedHeater_K_tube(unit="1/m4"),
        MainFeedHeater_K_shell(unit="1/m4"),
        BypassFeedHeater_K_tube(unit="1/m4"),
        BypassFeedHeater_K_shell(unit="1/m4")),
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_DivertPowerControl
        CS(
        electric_demand=sum1.y,
        Overall_Power=sensorW.W,
        data(p_steam=15000000, p_steam_vent=16000000)))
      annotation (Placement(transformation(extent={{50,-20},{90,20}})));
    SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)
      annotation (Placement(transformation(extent={{98,-22},{138,22}})));
    ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
        53303300, BOP_capacity(displayUnit="MW") = 1165000000)
      annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
    Modelica.Blocks.Sources.Constant delayStart(k=0)
      annotation (Placement(transformation(extent={{-62,78},{-42,98}})));
    SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
      W_nominal_BOP(displayUnit="MW") = 50000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Nominal_50_timeSeries.txt"))
      annotation (Placement(transformation(extent={{158,60},{198,100}})));

    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU_GMI_TempControl_SmallTanks
      two_Tank_SHS_System_NTU(
      redeclare
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.CS_Boiler_03_GMI_TempControl_SmallTanks
        CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
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
      redeclare package Storage_Medium =
          NHES.Media.Hitec.Hitec,
      m_flow_min=0.1,
      tank_height=11.7,
      Steam_Output_Temp=stateSensor6.temperature.T)
      annotation (Placement(transformation(extent={{-16,-76},{24,-36}})));

    Fluid.Sensors.stateDisplay stateDisplay1
      annotation (Placement(transformation(extent={{-52,28},{-6,58}})));
    Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-38,2},{-24,20}})));
    Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{32,0},{46,18}})));
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
      amplitude=-20.58e6,
      rising=100,
      width=9800,
      falling=100,
      period=20000,
      offset=47e6,
      startTime=2000)
      annotation (Placement(transformation(extent={{66,112},{86,132}})));
    BalanceOfPlant.Turbine.SteamTurbine_Basic_NoFeedHeat
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_SmallCycle_NoFeedHeat
        CS(electric_demand=sum1.y))
      annotation (Placement(transformation(extent={{106,-86},{144,-44}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{142,-6},{156,6}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{108,96},{128,116}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      amplitude=20.14e6,
      rising=100,
      width=7800,
      falling=100,
      period=20000,
      offset=0,
      startTime=14000)
      annotation (Placement(transformation(extent={{66,76},{86,96}})));

    Modelica.Blocks.Sources.Constant const(k=47.5e6)
      annotation (Placement(transformation(extent={{18,68},{38,88}})));
    Modelica.Blocks.Sources.CombiTimeTable demand_BOP(
      tableOnFile=true,
      startTime=0,
      tableName="BOP",
      timeScale=timeScale,
      fileName=fileName)
      annotation (Placement(transformation(extent={{-98,112},{-78,132}})));
    Modelica.Blocks.Math.Sum sum1
      annotation (Placement(transformation(extent={{134,102},{154,122}})));
    PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop
                                           hTGR_PebbleBed_Primary_Loop(redeclare
        PrimaryHeatSystem.HTGR.HTGR_Rankine.CS_Rankine_Primary CS(data(
            T_Rx_Exit_Ref=579.15, P_Steam_Ref=3400000)))
      annotation (Placement(transformation(extent={{-100,-22},{-52,24}})));
  equation

    connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
      annotation (Line(points={{30,-6},{36,-6},{36,-8},{50,-8}},
                                                 color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
      annotation (Line(points={{90,0},{98,0},{98,-1.1}},               color={255,
            0,0}));
    connect(stateSensor1.port_b, EM.port_a1) annotation (Line(points={{-24,11},{
            -22,11},{-22,12},{-16,12},{-16,10},{-10,10}},
                                                      color={0,127,255}));
    connect(stateSensor1.statePort, stateDisplay1.statePort) annotation (Line(
          points={{-30.965,11.045},{-22,11.045},{-22,14},{-20,14},{-20,24},{-29,24},
            {-29,39.1}}, color={0,0,0}));
    connect(EM.port_b2, stateSensor2.port_a) annotation (Line(points={{30,10},{32,
            10},{32,9}},                        color={0,127,255}));
    connect(stateSensor2.port_b, intermediate_Rankine_Cycle_TESUC.port_a)
      annotation (Line(points={{46,9},{48,9},{48,8},{50,8}},          color={0,127,
            255}));
    connect(stateSensor2.statePort, stateDisplay2.statePort) annotation (Line(
          points={{39.035,9.045},{39.035,37.1},{47,37.1}}, color={0,0,0}));
    connect(stateSensor3.port_a, EM.port_b1)
      annotation (Line(points={{-26,-6},{-10,-6}}, color={0,127,255}));
    connect(stateDisplay3.statePort, stateSensor3.statePort) annotation (Line(
          points={{-76,-44.16},{-76,-50},{-44,-50},{-44,-12},{-33.035,-12},{-33.035,
            -5.96}}, color={0,0,0}));
    connect(stateSensor4.port_b, two_Tank_SHS_System_NTU.port_ch_a)
      annotation (Line(points={{-24,-68},{-15.6,-68.4}}, color={0,127,255}));
    connect(stateSensor4.port_a, EM.port_b3[1]) annotation (Line(points={{-38,-68},
            {-38,-24},{18,-24},{18,-18}}, color={0,127,255}));
    connect(stateDisplay4.statePort, stateSensor4.statePort) annotation (Line(
          points={{-76,-94.16},{-76,-100},{-30.965,-100},{-30.965,-67.96}}, color=
           {0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, stateSensor5.port_a) annotation (
        Line(points={{-15.6,-45.2},{-24,-45.2},{-24,-30},{16,-30}}, color={0,127,255}));
    connect(stateDisplay5.statePort, stateSensor5.statePort) annotation (Line(
          points={{4,-94.16},{4,-100},{32,-100},{32,-34},{23.035,-34},{23.035,-29.96}},
          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, stateSensor6.port_a) annotation (
        Line(points={{24,-68.4},{48,-68.4},{48,-68}}, color={0,127,255}));
    connect(stateSensor6.statePort, stateDisplay7.statePort) annotation (Line(
          points={{55.035,-67.96},{55.035,-74},{56,-74},{56,-82},{72,-82},{72,-96.16}},
                                                                      color={0,0,0}));
    connect(stateSensor7.statePort, stateDisplay6.statePort) annotation (Line(
          points={{57.95,-54.975},{62,-54.975},{62,-50},{78,-50},{78,-44.16}},
                          color={0,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, stateSensor7.port_b) annotation (
        Line(points={{23.6,-44.4},{42,-44.4},{42,-55},{48,-55}},          color={0,
            127,255}));
    connect(stateSensor5.port_b, intermediate_Rankine_Cycle_TESUC.port_a1)
      annotation (Line(points={{30,-30},{57.2,-30},{57.2,-19.2}}, color={0,127,255}));
    connect(stateSensor6.port_b,
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_a)
      annotation (Line(points={{62,-68},{100,-68},{100,-60},{102,-60},{102,-56},{106,
            -56},{106,-56.6}}, color={0,127,255}));
    connect(stateSensor7.port_a,
      intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_b)
      annotation (Line(points={{68,-55},{68,-73.4},{106,-73.4}}, color={0,127,255}));
    connect(intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.portElec_b,
      SY.port_a[2]) annotation (Line(points={{144,-65},{144,-28},{94,-28},{94,0},{
            98,0},{98,1.1}},      color={255,0,0}));
    connect(SY.port_Grid, sensorW.port_a)
      annotation (Line(points={{138,0},{142,0}}, color={255,0,0}));
    connect(sensorW.port_b, EG.portElec_a)
      annotation (Line(points={{156,0},{160,0}}, color={255,0,0}));
    connect(trapezoid.y, add.u1) annotation (Line(points={{87,122},{87,118},{100,
            118},{100,112},{106,112}},
                           color={0,0,127}));
    connect(trapezoid1.y, add.u2) annotation (Line(points={{87,86},{100,86},{100,
            100},{106,100}},
                           color={0,0,127}));
    connect(add.y, sum1.u[1]) annotation (Line(points={{129,106},{128,106},{128,
            92},{98,92},{98,118},{132,118},{132,112}},
                                         color={0,0,127}));
    connect(hTGR_PebbleBed_Primary_Loop.port_b, stateSensor1.port_a)
      annotation (Line(points={{-52.72,12.27},{-38,11}}, color={0,127,255}));
    connect(hTGR_PebbleBed_Primary_Loop.port_a, stateSensor3.port_b)
      annotation (Line(points={{-52.72,-6.59},{-40,-6}}, color={0,127,255}));
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
  end HTGR_Case_01_IndependentBOP_2;
end ObsoleteTESUseCaseExamples;
