within NHES.Systems.Examples.TES_Use_Case;
model HTGR_Case_01_IndependentBOP_Uprated200MW_Wpumps
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

  EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(
    port_a1_nominal(
      p=14000000,
      h=2e6,
      m_flow=50),
    port_b1_nominal(p=14100000, h=2e6),
    port_b3_nominal_m_flow={-0.67},
    nPorts_b3=1)
    annotation (Placement(transformation(extent={{-12,-18},{28,22}})));
  BalanceOfPlant.Turbine.HTGR_RankineCycles.SteamTurbine_OpenFeedHeat_DivertPowerControl_HTGR_AR1
    intermediate_Rankine_Cycle_TESUC(
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.TESTurbine
      data(
      p_in_nominal=14000000,
      p_condensor=7000,
      V_condensor=10000,
      V_FeedwaterMixVolume=25,
      V_Header=10,
      valve_TCV_mflow=100,
      valve_TCV_dp_nominal=500000,
      valve_SHS_mflow=45,
      valve_SHS_dp_nominal=1000000,
      valve_TCV_LPT_mflow=30,
      valve_TCV_LPT_dp_nominal=10000,
      InternalBypassValve_mflow_small=0,
      InternalBypassValve_p_spring=20000000,
      InternalBypassValve_K(unit="1/(m.kg)") = 40,
      InternalBypassValve_tau(unit="1/s"),
      HPT_p_exit_nominal=5000000,
      HPT_T_in_nominal=838.15,
      HPT_nominal_mflow=62,
      HPT_efficiency=0.97,
      LPT_p_in_nominal=5000000,
      LPT_p_exit_nominal=7000,
      LPT_T_in_nominal=673.15,
      LPT_nominal_mflow=120,
      LPT_efficiency=0.97,
      firstfeedpump_p_nominal=11000000,
      secondfeedpump_p_nominal=5500000,
      controlledfeedpump_mflow_nominal=45,
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
      BalanceOfPlant.Turbine.ControlSystems.CS_DivertPowerControl_HTGR_3VNb_AR1
      CS(
      electric_demand=sum1.y,
      Overall_Power=sensorW.W,
      m_required=m_req.y,
      data(
        p_steam=16500000,
        T_Steam_Ref=838.15,
        Q_Nom=48e6,
        T_Feedwater=466.15,
        p_steam_vent=18500000,
        m_flow_reactor=50)),
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.Data.IntermediateTurbineInitialisation
      init(
      FeedwaterMixVolume_p_start=3000000,
      FeedwaterMixVolume_h_start=2e6,
      InternalBypassValve_dp_start=3500000,
      InternalBypassValve_mflow_start=0.1,
      HPT_p_a_start=3000000,
      HPT_p_b_start=10000,
      HPT_T_a_start=523.15,
      HPT_T_b_start=333.15),
    const(k=0.0001),
    firstfeedpump(allowFlowReversal=true))
    annotation (Placement(transformation(extent={{52,-18},{92,22}})));
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

  EnergyStorage.SHS_Two_Tank.Components.Two_Tank_SHS_System_BestModel
    two_Tank_SHS_System_NTU(
    redeclare
      NHES.Systems.EnergyStorage.SHS_Two_Tank.ControlSystems.CS_BestExample CS(
      data(hot_tank_ref_temp=673.15, cold_tank_ref_temp=533.15),
      one8(k=+273.15 + 260),
      one1(k=273.15 + 400),
      PID1(yMin=-20),
      PID5(yMin=0),
      PID2(yMin=0),
      Charging_Valve_Position_MinMax(min=0.000001),
      one7(k=0)),
    redeclare replaceable NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_SHS
      data(
      ht_level_max=11.7,
      ht_area=10*3390,
      ht_surface_pressure=120000,
      hot_tank_init_temp=673.15,
      cold_tank_level_max=11.7,
      cold_tank_area=10*3390,
      ct_surface_pressure=120000,
      cold_tank_init_temp=533.15,
      m_flow_ch_min=0.1,
      DHX_NTU=2*20,
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
    m_flow_min=0.1,
    tank_height=11.7,
    Steam_Output_Temp=stateSensor6.temperature.T,
    hysteresis(uLow=-1, uHigh=15))
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
    amplitude=-37.52e6,
    rising=100,
    width=9800,
    falling=100,
    period=20000,
    offset=86.24e6,
    startTime=4e5 + 2000)
    annotation (Placement(transformation(extent={{-232,256},{-212,276}})));
  BalanceOfPlant.Turbine.SteamTurbine_Basic_NoFeedHeat_AR1
    intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle(
    port_a_nominal(
      p=EM.port_b2_nominal.p,
      h=EM.port_b2_nominal.h,
      m_flow=-EM.port_b2_nominal.m_flow),
    port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_SmallCycle_NoFeedHeat_AR1
      CS(
      electric_demand=sum1.y,
      data(
        p_steam=10500000,
        T_Steam_Ref=668.15,
        Q_Nom=86.24e6),
      FWCP_Speed(yMax=3500),
      const15(k=0.005),
      minMaxFilter1(max=1 - 0.005),
      const11(k=0.0005),
      minMaxFilter(max=1 - 0.0005)),
    firstfeedpump1(m_flow_start=5),
    init(
      HPT_p_a_start=1500000,
      HPT_T_b_start=313.15,
      LPT_T_a_start=443.15,
      LPT_T_b_start=323.15),
    data(
      T_Steam_Ref=663.15,
      p_steam=10500000,
      p_in_nominal=10500000,
      valve_TCV_mflow=100,
      valve_SHS_dp_nominal=1500000,
      valve_TCV_LPT_dp_nominal=70000,
      LPT_p_in_nominal=10000000,
      LPT_T_in_nominal=668.15,
      LPT_nominal_mflow=42))
    annotation (Placement(transformation(extent={{104,-84},{142,-42}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{142,-6},{156,6}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{-190,240},{-170,260}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=31.84e6,
    rising=100,
    width=7800 + 5000,
    falling=100,
    period=20000,
    offset=0,
    startTime=4e5 + 14000)
    annotation (Placement(transformation(extent={{-232,218},{-212,238}})));

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
    annotation (Placement(transformation(extent={{-102,256},{-82,276}})));
  PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop_TESUC_AR1
    hTGR_PebbleBed_Primary_Loop_TESUC_AR1_1(redeclare
      PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems.CS_Rankine_PrimaryVNa_AR1
      CS(data(T_Rx_Exit_Ref=1023.15, P_Steam_Ref=16500000), const3(k=203e6)),
      STHX(nParallel=4))
    annotation (Placement(transformation(extent={{-106,-22},{-58,24}})));
  Modelica.Blocks.Sources.RealExpression m_req(y=
        hTGR_PebbleBed_Primary_Loop_TESUC_AR1_1.core.Q_total.y/(1295088 -
        stateSensor3.specificEnthalpy.h_out))
    annotation (Placement(transformation(extent={{-112,158},{-92,178}})));
  Modelica.Blocks.Sources.Constant MinPower(k=12000000)
    annotation (Placement(transformation(extent={{-22,216},{-16,222}})));
  Modelica.Blocks.Sources.RealExpression Power(y=sensorW.W - (
        intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.firstfeedpump1.W
         + intermediate_Rankine_Cycle_TESUC.pump_SimpleMassFlow1.W +
        intermediate_Rankine_Cycle_TESUC.W_1stpump.y))
    annotation (Placement(transformation(extent={{96,184},{116,204}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{6,266},{14,274}})));
  Modelica.Blocks.Sources.Constant one3(k=-0.25)
    annotation (Placement(transformation(extent={{10,280},{16,286}})));
  Modelica.Blocks.Sources.Constant one4(k=1.25)
    annotation (Placement(transformation(extent={{-12,264},{-6,270}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{26,274},{32,280}})));
  Modelica.Blocks.Sources.RealExpression Level_min_H(y=two_Tank_SHS_System_NTU.hot_tank.level)
    annotation (Placement(transformation(extent={{-34,272},{-18,288}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{-38,188},{-30,196}})));
  Modelica.Blocks.Sources.Constant one5(k=-0.25)
    annotation (Placement(transformation(extent={{-34,202},{-28,208}})));
  Modelica.Blocks.Sources.Constant one6(k=1.25)
    annotation (Placement(transformation(extent={{-56,186},{-50,192}})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{-18,196},{-12,202}})));
  Modelica.Blocks.Sources.RealExpression Level_min_C(y=two_Tank_SHS_System_NTU.cold_tank.level)
    annotation (Placement(transformation(extent={{-78,194},{-62,210}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{50,224},{58,216}})));
  Modelica.Blocks.Sources.Constant one7(k=2)
    annotation (Placement(transformation(extent={{-2,206},{4,212}})));
  Modelica.Blocks.Math.Add add3(k2=-1)
    annotation (Placement(transformation(extent={{8,194},{14,200}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{82,230},{92,220}})));
  Modelica.Blocks.Math.Product product3
    annotation (Placement(transformation(extent={{22,192},{30,200}})));
  Modelica.Blocks.Math.Min min3
    annotation (Placement(transformation(extent={{76,258},{84,266}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{128,242},{140,254}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=
        two_Tank_SHS_System_NTU.hot_tank.level < two_Tank_SHS_System_NTU.cold_tank.level)
    annotation (Placement(transformation(extent={{82,238},{98,252}})));
  Modelica.Blocks.Sources.Constant MaxPower(k=1.25e8)
    annotation (Placement(transformation(extent={{4,290},{10,296}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{56,284},{64,276}})));
  Modelica.Blocks.Sources.CombiTimeTable demand_BOP2(
    tableOnFile=false,
    table=[0,86e6; 604400,86e6; 605000,42756000.42; 608000,42756000.42; 608600,
        42756000.42; 611600,42756000.42; 612200,42756000.42; 615200,42756000.42;
        615800,125383981.3; 618800,125383981.3; 619400,42756000.42; 622400,
        42756000.42; 623000,125383981.3; 626000,125383981.3; 626600,125383981.3;
        629600,125383981.3; 630200,125383981.3; 633200,125383981.3; 633800,
        42756000.43; 636800,42756000.43; 637400,42756000.43; 640400,42756000.43;
        641000,125383981.3; 644000,125383981.3; 644600,42756000.42; 647600,
        42756000.42; 648200,42756000.42; 651200,42756000.42; 651800,125383981.3;
        654800,125383981.3; 655400,42756000.42; 658400,42756000.42; 659000,
        125383981.3; 662000,125383981.3; 662600,85260000.85; 665600,85260000.85;
        666200,125383981.2; 669200,125383981.2; 669800,101909712.5; 672800,
        101909712.5; 673400,85260000.86; 676400,85260000.86; 677000,85260000.85;
        680000,85260000.85; 680600,42756000.42; 683600,42756000.42; 684200,
        125383981.3; 687200,125383981.3; 687800,85260000.85; 690800,85260000.85],
    startTime=0,
    tableName="BOP",
    timeScale=1,
    fileName=
        "C:/Users/NOVOV/projects/HYBRID/Models/NHES/Resources/Data/RAVEN/timeSeriesDataVN.txt",
    shiftTime=0)
    annotation (Placement(transformation(extent={{-96,228},{-76,248}})));

  Modelica.Blocks.Sources.RealExpression Qin_main(y=
        intermediate_Rankine_Cycle_TESUC.TCV.m_flow*(stateSensor2.specificEnthalpy.h_out
         - intermediate_Rankine_Cycle_TESUC.firstfeedpump.port_b.h_outflow))
    annotation (Placement(transformation(extent={{94,160},{114,180}})));
  Modelica.Blocks.Sources.RealExpression Qin_dedic(y=
        intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_a.m_flow
        *(stateSensor6.specificEnthalpy.h_out -
        intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.firstfeedpump1.port_b.h_outflow))
    annotation (Placement(transformation(extent={{94,132},{114,152}})));
  Modelica.Blocks.Sources.RealExpression Pwr_main(y=
        intermediate_Rankine_Cycle_TESUC.sensorW.W)
    annotation (Placement(transformation(extent={{144,184},{164,204}})));
  Modelica.Blocks.Sources.RealExpression Pwr_dedic(y=
        intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.sensorW.W)
    annotation (Placement(transformation(extent={{180,184},{200,204}})));
  Modelica.Blocks.Sources.RealExpression eta_t(y=Power.y/(Qin_dedic.y +
        Qin_main.y))
    annotation (Placement(transformation(extent={{226,188},{246,208}})));
  Modelica.Blocks.Sources.RealExpression eta_main(y=Pwr_main.y/(Qin_main.y))
    annotation (Placement(transformation(extent={{224,164},{244,184}})));
  Modelica.Blocks.Sources.RealExpression eta_dedic(y=Pwr_dedic.y/(Qin_dedic.y))
    annotation (Placement(transformation(extent={{226,138},{246,158}})));
  Modelica.Blocks.Math.Add         add4
    annotation (Placement(transformation(extent={{-150,254},{-130,274}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid2(
    amplitude=0,
    rising=1000,
    width=0 + 5000,
    falling=1000,
    period=20000,
    offset=0,
    startTime=3e5 + 8e4 - 5000)
    annotation (Placement(transformation(extent={{-204,310},{-184,330}})));
  Modelica.Blocks.Math.Product product4
    annotation (Placement(transformation(extent={{34,258},{42,250}})));
  Modelica.Blocks.Sources.Constant MinPower1(k=1)
    annotation (Placement(transformation(extent={{-38,250},{-32,256}})));
  Modelica.Blocks.Sources.RealExpression Wpumps(y=(
        intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.firstfeedpump1.W
         + intermediate_Rankine_Cycle_TESUC.pump_SimpleMassFlow1.W +
        intermediate_Rankine_Cycle_TESUC.W_1stpump.y))
    annotation (Placement(transformation(extent={{50,116},{70,136}})));
equation
  hTGR_PebbleBed_Primary_Loop_TESUC_AR1_1.input_steam_pressure =
    intermediate_Rankine_Cycle_TESUC.sensor_p.p;

  connect(EM.port_a2, intermediate_Rankine_Cycle_TESUC.port_b)
    annotation (Line(points={{28,-6},{52,-6}}, color={0,127,255}));
  connect(intermediate_Rankine_Cycle_TESUC.portElec_b, SY.port_a[1])
    annotation (Line(points={{92,2},{98,2},{98,-0.55}},              color={255,
          0,0}));
  connect(stateSensor1.port_b, EM.port_a1) annotation (Line(points={{-24,11},{-22,
          11},{-22,12},{-16,12},{-16,10},{-12,10}}, color={0,127,255}));
  connect(stateSensor1.statePort, stateDisplay1.statePort) annotation (Line(
        points={{-30.965,11.045},{-22,11.045},{-22,14},{-20,14},{-20,24},{-29,24},
          {-29,39.1}}, color={0,0,0}));
  connect(EM.port_b2, stateSensor2.port_a) annotation (Line(points={{28,10},{32,
          10},{32,9}},                        color={0,127,255}));
  connect(stateSensor2.port_b, intermediate_Rankine_Cycle_TESUC.port_a)
    annotation (Line(points={{46,9},{48,9},{48,10},{52,10}},        color={0,127,
          255}));
  connect(stateSensor2.statePort, stateDisplay2.statePort) annotation (Line(
        points={{39.035,9.045},{39.035,37.1},{47,37.1}}, color={0,0,0}));
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
    annotation (Line(points={{30,-30},{59.2,-30},{59.2,-17.2}}, color={0,127,255}));
  connect(stateSensor6.port_b,
    intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_a)
    annotation (Line(points={{62,-68},{100,-68},{100,-60},{102,-60},{102,-56},{
          104,-56},{104,-54.6}},
                             color={0,127,255}));
  connect(stateSensor7.port_a,
    intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.port_b)
    annotation (Line(points={{68,-55},{68,-71.4},{104,-71.4}}, color={0,127,255}));
  connect(intermediate_Rankine_Cycle_TESUC_1_Independent_SmallCycle.portElec_b,
    SY.port_a[2]) annotation (Line(points={{142,-63},{142,-28},{94,-28},{94,0},{
          98,0},{98,0.55}},     color={255,0,0}));
  connect(SY.port_Grid, sensorW.port_a)
    annotation (Line(points={{138,0},{142,0}}, color={255,0,0}));
  connect(sensorW.port_b, EG.portElec_a)
    annotation (Line(points={{156,0},{160,0}}, color={255,0,0}));
  connect(trapezoid.y, add.u1) annotation (Line(points={{-211,266},{-211,262},{
          -198,262},{-198,256},{-192,256}},
                         color={0,0,127}));
  connect(trapezoid1.y, add.u2) annotation (Line(points={{-211,228},{-198,228},
          {-198,244},{-192,244}},
                         color={0,0,127}));
  connect(hTGR_PebbleBed_Primary_Loop_TESUC_AR1_1.port_b, stateSensor1.port_a)
    annotation (Line(points={{-58.72,12.27},{-47.36,12.27},{-47.36,11},{-38,11}},
        color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop_TESUC_AR1_1.port_a, stateSensor3.port_b)
    annotation (Line(points={{-58.72,-6.59},{-48.36,-6.59},{-48.36,-6},{-40,-6}},
        color={0,127,255}));
  connect(one3.y,add1. u1) annotation (Line(points={{16.3,283},{20,283},{20,
          278.8},{25.4,278.8}},                                   color={0,0,
          127}));
  connect(min1.y,add1. u2) annotation (Line(points={{14.4,270},{20,270},{20,
          275.2},{25.4,275.2}},                              color={0,0,127}));
  connect(one4.y,min1. u2) annotation (Line(points={{-5.7,267},{-0.25,267},{
          -0.25,267.6},{5.2,267.6}},
                                 color={0,0,127}));
  connect(Level_min_H.y,min1. u1) annotation (Line(points={{-17.2,280},{2,280},
          {2,272.4},{5.2,272.4}},     color={0,0,127}));
  connect(one5.y,add2. u1) annotation (Line(points={{-27.7,205},{-24,205},{-24,
          200.8},{-18.6,200.8}},                                  color={0,0,
          127}));
  connect(min2.y,add2. u2) annotation (Line(points={{-29.6,192},{-24,192},{-24,
          197.2},{-18.6,197.2}},                             color={0,0,127}));
  connect(Level_min_C.y,min2. u1) annotation (Line(points={{-61.2,202},{-42,202},
          {-42,194.4},{-38.8,194.4}},      color={0,0,127}));
  connect(one7.y,add3. u1) annotation (Line(points={{4.3,209},{4.3,204},{7.4,
          204},{7.4,198.8}},         color={0,0,127}));
  connect(add2.y,add3. u2) annotation (Line(points={{-11.7,199},{2,199},{2,
          195.2},{7.4,195.2}},   color={0,0,127}));
  connect(product2.y,max1. u1)
    annotation (Line(points={{58.4,220},{58.4,222},{81,222}},
                                                            color={0,0,127}));
  connect(MinPower.y, product2.u2) annotation (Line(points={{-15.7,219},{-15.7,
          222.4},{49.2,222.4}}, color={0,0,127}));
  connect(add3.y,product3. u2) annotation (Line(points={{14.3,197},{16,197},{16,
          193.6},{21.2,193.6}},      color={0,0,127}));
  connect(product3.u1,add3. y) annotation (Line(points={{21.2,198.4},{17.75,
          198.4},{17.75,197},{14.3,197}},   color={0,0,127}));
  connect(product3.y,product2. u1) annotation (Line(points={{30.4,196},{44,196},
          {44,217.6},{49.2,217.6}},       color={0,0,127}));
  connect(booleanExpression.y,switch1. u2) annotation (Line(points={{98.8,245},
          {98.8,248},{126.8,248}},color={255,0,255}));
  connect(max1.y,switch1. u3) annotation (Line(points={{92.5,225},{126.8,225},{
          126.8,243.2}},color={0,0,127}));
  connect(add1.y,product1. u1) annotation (Line(points={{32.3,277},{43.75,277},
          {43.75,277.6},{55.2,277.6}}, color={0,0,127}));
  connect(MaxPower.y, product1.u2) annotation (Line(points={{10.3,293},{50,293},
          {50,282.4},{55.2,282.4}}, color={0,0,127}));
  connect(product1.y,min3. u1) annotation (Line(points={{64.4,280},{70,280},{70,
          264.4},{75.2,264.4}}, color={0,0,127}));
  connect(min3.y,switch1. u1) annotation (Line(points={{84.4,262},{126.8,262},{
          126.8,252.8}},color={0,0,127}));
  connect(one6.y, min2.u2) annotation (Line(points={{-49.7,189},{-49.7,190},{
          -38,190},{-38,189.6},{-38.8,189.6}}, color={0,0,127}));
  connect(add.y, add4.u2) annotation (Line(points={{-169,250},{-169,248},{-152,
          248},{-152,258}}, color={0,0,127}));
  connect(trapezoid2.y, add4.u1) annotation (Line(points={{-183,320},{-183,286},
          {-152,286},{-152,270}}, color={0,0,127}));
  connect(MinPower1.y, product4.u2) annotation (Line(points={{-31.7,253},{30,
          253},{30,256.4},{33.2,256.4}}, color={0,0,127}));
  connect(min3.u2, product4.y) annotation (Line(points={{75.2,259.6},{48,259.6},
          {48,254},{42.4,254}}, color={0,0,127}));
  connect(max1.u2, product4.y) annotation (Line(points={{81,228},{48,228},{48,
          254},{42.4,254}}, color={0,0,127}));
  connect(demand_BOP2.y[1], product4.u1) annotation (Line(points={{-75,238},{28,
          238},{28,251.6},{33.2,251.6}}, color={0,0,127}));
  connect(demand_BOP2.y[1], sum1.u[1]) annotation (Line(points={{-75,238},{-70,
          238},{-70,282},{-112,282},{-112,266},{-104,266}}, color={0,0,127}));
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
      StopTime=2000000,
      Interval=10,
      Tolerance=0.001,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
    __Dymola_experimentSetupOutput(events=false),
    conversion(noneFromVersion=""));
end HTGR_Case_01_IndependentBOP_Uprated200MW_Wpumps;
