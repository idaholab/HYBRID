within NHES.Systems.Examples.TES_Use_Case;
model HTGR_TES_RhC_6a4new_AR_vn1_uprate200MWth_176MWe_
  EnergyStorage.SHS_Two_Tank.Components.SHS2Tank_VN_SaltOuta
    sHS2Tank_VN_SaltOuta(
    redeclare package Storage_Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    redeclare package Charging_Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    m_flow_min=0.1,
    Steam_Output_Temp=773.15,
    volume(T_start=773.15),
    discharge_pump(T_start=773.15),
    charge_pump(T_start=T_start),
    data(
      ht_area=10*100,
      hot_tank_init_temp=773.15,
      cold_tank_area=10*100,
      cold_tank_init_temp=523.15,
      discharge_pump_m_flow_nominal=25,
      charge_pump_m_flow_nominal=25,
      disvalve_m_flow_nom=300,
      chvalve_m_flow_nom=703),
    redeclare EnergyStorage.SHS_Two_Tank.ControlSystems.CS_TES_VN2b
                         CS(one1(k=500 + 273.15 - 0),
      PID2(
        k=-0.05e-3,
        Ti=1100,
           yMin=0.01,
        Ni=10)),
    sensor_m_flow(p_start=3900000, T_start=T_start),
    CHX(
      NTU=16,
      T_start_shell_inlet=973.15,
      T_start_shell_outlet=973.15))
    annotation (Placement(transformation(extent={{-28,-30},{40,32}})));
  parameter Modelica.Units.SI.Temperature T_start=350+273.15
    "Temperature";
  NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop_HeOut
    hTGR_PebbleBed_Primary_Loop(
    redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems.CS_VN CS(
      PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.000001,
        Ti=10,
        k_s=-1,
        k_m=-1,
        Ni=0.0001,
        xi_start=40),
      const7(k=40),
      ramp(startTime=1000),
      const4(k=0),
      ramp1(offset=45, startTime=1000),
      const6(k=203.6e6),
      data(Q_Nom=6e7, Q_RX_Therm_Nom=30e6)),
    sensor_T1(p_start=3900000, T_start=T_start),
    sensor_m_flow(p_start=4000000, T_start=T_start),
    Primary_PRV(m_flow_start=2e-2),
    sensor_T(p_start=4000000, T_start=1023.15),
    dataInitial(
      P_Core_Inlet=4100000,
      P_Core_Outlet=4000000,
      T_Core_Inlet=773.15,
      T_Core_Outlet=823.15,
      T_Fuel_Center_Init=973.15),
    pump(use_input=true, m_flow_nominal=45),
    core(
      nPebble=2.545*80000,
      Pebble_Surface_Init=773.15,
      Pebble_Center_Init=973.15,
      Q_nominal=203600000,
      Q_fission_input=203600000),
    data(nPebble=2.5*80000))
    annotation (Placement(transformation(extent={{-164,-32},{-94,26}})));

  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{44,30},{64,50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{78,28},{98,48}})));
  BalanceOfPlant.Turbine.Reheat_cycle_drumOFH_Toutctr_AR_vn2
    reheat_cycle_drumOFH_Toutctr_AR_vn2_1(
    pump(m_flow_nominal=200),
    steam_Drum(
      p_start=21000000,
      alphag_start=0.5,
      V_drum=30*2.8,
      A_drum=15*2.8),
    CS(
      PartialAdmission(Ti=200),
      FWH_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-2,
        Ti=10000,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=0),
      const9(k=273.15 + 165),
      delay3(Ti=0.1),
      CondPumpSpeed(
        k=15,
        Ti=500,
        yMax=80*2.5),
      timer1(Start_Time=1),
      PID(yMax=120*2.5),
      SH_mflow(yMax=120*2.5),
      PID2(yMax=120*2.5),
      const10(k=6)),
    DHX(
      NTU=3.2,
      K_tube=200,
      K_shell=700,
      use_T_start_tube=true,
      T_start_tube_inlet=438.15,
      T_start_shell_inlet=633.15,
      T_start_shell_outlet=523.15,
      dp_general=10000,
      m_start_shell=200),
    const1(k=0.5),
    DHX2(
      NTU=2.4,
      use_T_start_shell=true,
      T_start_shell_outlet=773.15,
      Q_init=2.5*50000000),
    DHX3(
      NTU=1.9,
      T_start_shell_inlet=1023.15,
      T_start_shell_outlet=673.15,
      Q_init=1,
      m_start_shell=100,
      Tube(medium(T(start=750, fixed=true), p(start=800000, fixed=true)))),
    steamTurbine1(
      m_flow_nominal=2.85*46,
      use_T_nominal=false,
      d_nominal(displayUnit="kg/m3") = 2.05),
    DHX1(NTU=6,
         Q_init=2.5*5000000),
    deaerator(level_start=8, p_start=800000),
    const3(k=1.1*210),
    ramp(height=-0.2, offset=0.2),
    steamTurbine(
      m_flow_nominal=2.85*57,
      p_outlet_nominal=850000,
      T_nominal=823.15),
    LPT_Bypass(dp_nominal=800000, m_flow_nominal=2.5*50),
    PartialAdmission(
      k=-1e-4,
      Ti=1000,
      xi_start=0),
    condenser(V_total=2.5*1000),
    const7(k=8.5e5),
    valveLinear(m_flow_nominal=50*0.5))
    annotation (Placement(transformation(extent={{226,6},{324,86}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT3(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-38,112},{-18,132}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT4(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-68,-12},{-48,8}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT5(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{66,128},{86,148}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT6(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{60,76},{80,96}})));
  EnergyStorage.SHS_Two_Tank.Components.SHS2Tank_VN_SaltOut3
    sHS2Tank_VN_SaltOut3_1(
    redeclare package Storage_Medium =
        Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    redeclare package Charging_Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    m_flow_min=0.1,
    Steam_Output_Temp=773.15,
    volume(T_start=773.15),
    discharge_pump(T_start=773.15),
    charge_pump(T_start=T_start),
    data(
      ht_level_max=15,
      ht_area=10*100,
      hot_tank_init_temp=973.15,
      cold_tank_level_max=15,
      cold_tank_area=10*100,
      cold_tank_init_temp=753.15,
      discharge_pump_m_flow_nominal=25,
      charge_pump_m_flow_nominal=25,
      disvalve_m_flow_nom=300,
      chvalve_m_flow_nom=703),
    redeclare EnergyStorage.SHS_Two_Tank.ControlSystems.CS_TES_VN2 CS(
      PID3(yMin=0.01),
      trapezoid(
        amplitude=-50,
        width=2750,
        period=2200,
        offset=236,
        startTime=1500),
      one1(k=730 + 273.15),
      PID2(yMin=0.01)),
    sensor_m_flow(p_start=3900000, T_start=T_start),
    CHX(
      NTU=18 + 2,
      T_start_shell_inlet=973.15,
      T_start_shell_outlet=973.15),
    hot_tank(T_start=973.15),
    one1(k=0.01),
    Charging_bypass(dp_nominal=200000, m_flow_nominal=30))
    annotation (Placement(transformation(extent={{-12,66},{56,128}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT7(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-106,48},{-86,68}})));
  Modelica.Blocks.Sources.RealExpression Reactor_Q(y=
        hTGR_PebbleBed_Primary_Loop.Thermal_Power.y)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-142,36},{-130,48}})));
  Modelica.Blocks.Sources.RealExpression Cycle_Q_in(y=
        reheat_cycle_drumOFH_Toutctr_AR_vn2_1.Q_in.y)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{266,88},{278,100}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT8(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{210,106},{230,126}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT9(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{196,104},{216,124}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT10(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{182,130},{202,150}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT11(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{160,130},{180,150}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume     volume(
    p_start=200000,
    T_start=773.15,
    redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=3))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={130,114})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_entry1(R=1,
      redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(
        extent={{6,-7},{-6,7}},
        rotation=180,
        origin={172,49})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_entry2(R=1,
      redeclare package Medium =
        Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(
        extent={{6,-7},{-6,7}},
        rotation=180,
        origin={168,63})));
  Modelica.Blocks.Sources.RealExpression dLevel(y=-sHS2Tank_VN_SaltOuta.hot_tank.level
         + sHS2Tank_VN_SaltOut3_1.hot_tank.level)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-140,94},{-128,106}})));
  TRANSFORM.Controls.LimPID PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=-5.1e-2,
    Ti=5000,
    yMax=1.0,
    yMin=0.005,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-118,110},{-110,118}})));
  Fluid.Valves.ValveLinear      Charging_bypass(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    allowFlowReversal=true,
    dp_nominal=50000,
    m_flow_nominal=100)                     annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-61,75})));
  Modelica.Blocks.Sources.Constant one1(k=0)
    annotation (Placement(transformation(extent={{-146,112},{-140,118}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, R=10)
    annotation (Placement(transformation(extent={{-68,38},{-52,56}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He, R=10)
    annotation (Placement(transformation(extent={{-8,-9},{8,9}},
        rotation=90,
        origin={-42,93})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT12(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-68,-40},{-48,-20}})));
  TRANSFORM.Controls.LimPID PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=1000,
    yMax=1.0,
    yMin=0.0,
    y_start=0.0)
    annotation (Placement(transformation(extent={{72,174},{80,182}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=-40000000,
    rising=1500,
    width=0.75*23500,
    falling=1000,
    period=27500,
    offset=62000000,
    startTime=13500)
    annotation (Placement(transformation(extent={{-106,198},{-94,210}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    Discharging_Valve_Position(min=1e-4) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={118,188})));
  Modelica.Blocks.Sources.Constant MinLoad(k=12000000)
    annotation (Placement(transformation(extent={{-94,174},{-88,180}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-50,
    duration=500,
    offset=200,
    startTime=5000)
    annotation (Placement(transformation(extent={{234,308},{246,320}})));
  Modelica.Blocks.Sources.RealExpression Power(y=
        reheat_cycle_drumOFH_Toutctr_AR_vn2_1.powerSensor.power -
        reheat_cycle_drumOFH_Toutctr_AR_vn2_1.pump_SimpleMassFlow1.W -
        reheat_cycle_drumOFH_Toutctr_AR_vn2_1.pump_SimpleMassFlow2.W)
    annotation (Placement(transformation(extent={{4,140},{24,160}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{-66,224},{-58,232}})));
  Modelica.Blocks.Sources.Constant one3(k=-0.25)
    annotation (Placement(transformation(extent={{-62,238},{-56,244}})));
  Modelica.Blocks.Sources.Constant one4(k=1.25)
    annotation (Placement(transformation(extent={{-84,222},{-78,228}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-46,232},{-40,238}})));
  Modelica.Blocks.Sources.RealExpression Level_min_H(y=sHS2Tank_VN_SaltOuta.hot_tank.level)
    annotation (Placement(transformation(extent={{-106,230},{-90,246}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{-110,146},{-102,154}})));
  Modelica.Blocks.Sources.Constant one5(k=-1.7)
    annotation (Placement(transformation(extent={{-106,160},{-100,166}})));
  Modelica.Blocks.Sources.Constant one6(k=2.7)
    annotation (Placement(transformation(extent={{-128,144},{-122,150}})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{-90,154},{-84,160}})));
  Modelica.Blocks.Sources.RealExpression Level_min_C(y=sHS2Tank_VN_SaltOuta.cold_tank.level)
    annotation (Placement(transformation(extent={{-150,152},{-134,168}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-22,182},{-14,174}})));
  Modelica.Blocks.Sources.Constant one7(k=2)
    annotation (Placement(transformation(extent={{-74,164},{-68,170}})));
  Modelica.Blocks.Math.Add add3(k2=-1)
    annotation (Placement(transformation(extent={{-64,152},{-58,158}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{10,188},{20,178}})));
  Modelica.Blocks.Math.Product product3
    annotation (Placement(transformation(extent={{-50,150},{-42,158}})));
  Modelica.Blocks.Math.Min min3
    annotation (Placement(transformation(extent={{4,216},{12,224}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{56,200},{68,212}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=
        sHS2Tank_VN_SaltOuta.hot_tank.level < sHS2Tank_VN_SaltOuta.cold_tank.level)
    annotation (Placement(transformation(extent={{10,196},{26,210}})));
  Modelica.Blocks.Sources.Constant MaxLoad(k=176e6)
    annotation (Placement(transformation(extent={{-68,248},{-62,254}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-16,242},{-8,234}})));
  Modelica.Blocks.Sources.CombiTimeTable demand_BOP(
    tableOnFile=false,
    table=[0,30544557.89; 2700,30544557.89; 3600,19544557.89; 6300,19544557.89;
        7200,16260259.26; 9900,16260259.26; 10800,62000000; 13500,62000000;
        14400,32046919.05; 17100,32046919.05; 18000,16260259.26; 20700,
        16260259.26; 21600,16260259.26; 24300,16260259.26; 25200,30339037.58;
        27900,30339037.58; 28800,32046919.05; 31500,32046919.05; 32400,62000000;
        35100,62000000; 36000,16260259.26; 38700,16260259.26; 39600,16260259.26;
        42300,16260259.26; 43200,60462906.67; 45900,60462906.67; 46800,
        30339037.57; 49500,30339037.57; 50400,16260259.26; 53100,16260259.26;
        54000,16260259.26; 56700,16260259.26; 57600,32046919.05; 60300,
        32046919.05; 61200,32046919.05; 63900,32046919.05; 64800,62000000;
        67500,62000000; 68400,16260259.26; 71100,16260259.26; 72000,16260259.26;
        74700,16260259.26; 75600,60462906.67; 78300,60462906.67; 79200,
        32046919.05; 81900,32046919.05; 82800,16260259.26; 85500,16260259.26;
        86400,46254912.86; 89100,46254912.86; 90000,46254912.86; 140000,
        46254912.86; 140500,20000000.00; 150000,20000000.00],
    startTime=0,
    tableName="BOP",
    timeScale=1,
    fileName="C:/Users/NOVOV/projects/HYBRID/Models/NHES/Resources/Data/RAVEN/timeSeriesDataVN.txt",
    shiftTime=0)
    annotation (Placement(transformation(extent={{-196,268},{-176,288}})));

  Modelica.Blocks.Sources.CombiTimeTable demand_BOP1(
    tableOnFile=false,
    table=[0,48000000; 23400,48000000; 24400,19544557; 27100,19544557; 28000,
        19544557.89; 30700,19544557.89; 31600,16260259.26; 34300,16260259.26;
        35200,62000000; 37900,62000000; 38800,32046919.05; 41500,32046919.05;
        42400,16260259.26; 45100,16260259.26; 46000,16260259.26; 48700,
        16260259.26; 49600,30339037.58; 52300,30339037.58; 53200,32046919.05;
        55900,32046919.05; 56800,62000000; 59500,62000000; 60400,16260259.26;
        63100,16260259.26; 64000,16260259.26; 66700,16260259.26; 67600,
        60462906.67; 70300,60462906.67; 71200,30339037.57; 73900,30339037.57;
        74800,16260259.26; 77500,16260259.26; 78400,16260259.26; 81100,
        16260259.26; 82000,32046919.05; 84700,32046919.05; 85600,32046919.05;
        88300,32046919.05; 89200,62000000; 91900,62000000; 92800,16260259.26;
        95500,16260259.26; 96400,16260259.26; 99100,16260259.26; 100000,
        60462906.67; 102700,60462906.67; 103600,32046919.05; 106300,32046919.05;
        107200,16260259.26; 109900,16260259.26; 110800,46254912.86; 113500,
        46254912.86; 114400,30254912.86; 124400,30254912.86],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    startTime=0,
    tableName="BOP",
    timeScale=1,
    fileName=
        "C:/Users/NOVOV/projects/HYBRID/Models/NHES/Resources/Data/RAVEN/timeSeriesDataVN.txt",
    shiftTime=0)
    annotation (Placement(transformation(extent={{-216,202},{-196,222}})));

  Modelica.Blocks.Sources.Constant MaxLoad1(k=2.8387)
    annotation (Placement(transformation(extent={{-84,206},{-78,212}})));
  Modelica.Blocks.Math.Product product4
    annotation (Placement(transformation(extent={{-66,208},{-58,200}})));
equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 40;
    Discharging_Valve_Position.y =sHS2Tank_VN_SaltOuta.Discharging_Valve.opening;
  connect(hTGR_PebbleBed_Primary_Loop.port_a, sHS2Tank_VN_SaltOuta.port_ch_b)
    annotation (Line(points={{-95.05,-12.57},{-34,-12.57},{-34,17.74},{-27.32,
          17.74}},
        color={0,127,255}));

  connect(sensor_pT2.port, sHS2Tank_VN_SaltOuta.port_dch_b) annotation (Line(
        points={{88,28},{88,-18.22},{40,-18.22}}, color={0,127,255}));
  connect(sensor_pT1.port, sHS2Tank_VN_SaltOuta.port_dch_a) annotation (Line(
        points={{54,30},{50,30},{50,18.98},{39.32,18.98}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOuta.port_dch_b,
    reheat_cycle_drumOFH_Toutctr_AR_vn2_1.LT_in) annotation (Line(points={{40,
          -18.22},{218,-18.22},{218,30.3333},{253.372,30.3333}}, color={0,127,
          255}));
  connect(reheat_cycle_drumOFH_Toutctr_AR_vn2_1.LT_out, sHS2Tank_VN_SaltOuta.port_dch_a)
    annotation (Line(points={{253.372,18},{52,18},{52,18.98},{39.32,18.98}},
        color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, sensor_pT4.port) annotation (Line(
        points={{-95.05,-12.57},{-76.525,-12.57},{-76.525,-12},{-58,-12}},
        color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, sensor_pT7.port) annotation (Line(
        points={{-95.05,11.21},{-96,11.21},{-96,48}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_b,
    reheat_cycle_drumOFH_Toutctr_AR_vn2_1.HT_RH_in) annotation (Line(points={{56,
          77.78},{56,76},{200,76},{200,70.6667},{253.71,70.6667}},    color={0,
          127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_b, sensor_pT6.port) annotation (Line(
        points={{56,77.78},{61,77.78},{61,76},{70,76}}, color={0,127,255}));
  connect(reheat_cycle_drumOFH_Toutctr_AR_vn2_1.HT_SH_in,
    sHS2Tank_VN_SaltOut3_1.port_dch_b) annotation (Line(points={{253.034,53},{
          200,53},{200,76},{56,76},{56,77.78}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_ch_b, sensor_pT3.port) annotation (Line(
        points={{-11.32,113.74},{-21.66,113.74},{-21.66,112},{-28,112}}, color=
          {0,127,255}));
  connect(sensor_pT5.port, sHS2Tank_VN_SaltOut3_1.port_dch_a) annotation (Line(
        points={{76,128},{76,114.98},{55.32,114.98}}, color={0,127,255}));
  connect(sensor_pT8.port, reheat_cycle_drumOFH_Toutctr_AR_vn2_1.HT_RH_in)
    annotation (Line(points={{220,106},{220,94},{253.71,94},{253.71,70.6667}},
        color={0,127,255}));
  connect(sensor_pT9.port, reheat_cycle_drumOFH_Toutctr_AR_vn2_1.HT_SH_in)
    annotation (Line(points={{206,104},{208,104},{208,94},{210,94},{210,53},{
          253.034,53}}, color={0,127,255}));
  connect(sensor_pT10.port, reheat_cycle_drumOFH_Toutctr_AR_vn2_1.HT_RH_out)
    annotation (Line(points={{192,130},{192,59.3333},{253.372,59.3333}}, color=
          {0,127,255}));
  connect(sensor_pT11.port, reheat_cycle_drumOFH_Toutctr_AR_vn2_1.HT_SH_out)
    annotation (Line(points={{170,130},{170,124},{176,124},{176,44.6667},{
          253.034,44.6667}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_a, volume.port_b) annotation (Line(
        points={{55.32,114.98},{114,114.98},{114,114},{124,114}}, color={0,127,
          255}));
  connect(sensor_pT11.port, R_entry1.port_b) annotation (Line(points={{170,130},
          {170,124},{176,124},{176.2,49}}, color={0,127,255}));
  connect(R_entry1.port_a, volume.port_a) annotation (Line(points={{167.8,49},{
          136,49},{136,114}}, color={0,127,255}));
  connect(volume.port_a, R_entry2.port_a) annotation (Line(points={{136,114},{
          142,114},{142,106},{158,106},{158,63},{163.8,63}},      color={0,127,
          255}));
  connect(R_entry2.port_b, reheat_cycle_drumOFH_Toutctr_AR_vn2_1.HT_RH_out)
    annotation (Line(points={{172.2,63},{192,63},{192,68},{208,68},{208,59.3333},
          {253.372,59.3333}}, color={0,127,255}));
  connect(dLevel.y, PID2.u_m) annotation (Line(points={{-127.4,100},{-114,100},
          {-114,109.2}}, color={0,0,127}));
  connect(one1.y, PID2.u_s) annotation (Line(points={{-139.7,115},{-138,115},{
          -138,114},{-118.8,114}}, color={0,0,127}));
  connect(Charging_bypass.opening, PID2.y) annotation (Line(points={{-61,80.6},
          {-62,80.6},{-62,114},{-109.6,114}}, color={0,0,127}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, Charging_bypass.port_a)
    annotation (Line(points={{-95.05,11.21},{-95.05,46},{-74,46},{-74,75},{-68,
          75}}, color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, resistance2.port_a) annotation (
      Line(points={{-95.05,11.21},{-95.05,46},{-74,46},{-74,47},{-65.6,47}},
        color={0,127,255}));
  connect(resistance2.port_b, sHS2Tank_VN_SaltOut3_1.port_ch_a) annotation (
      Line(points={{-54.4,47},{-24,47},{-24,68.48},{-12.68,68.48}}, color={0,
          127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_ch_b, resistance1.port_b) annotation (
      Line(points={{-11.32,113.74},{-22,113.74},{-22,98.6},{-42,98.6}}, color={
          0,127,255}));
  connect(resistance1.port_a, sHS2Tank_VN_SaltOuta.port_ch_a) annotation (Line(
        points={{-42,87.4},{-42,-18.22},{-27.32,-18.22}}, color={0,127,255}));
  connect(Charging_bypass.port_b, sHS2Tank_VN_SaltOuta.port_ch_a) annotation (
      Line(points={{-54,75},{-48,75},{-48,76},{-42,76},{-42,-18.22},{-27.32,
          -18.22}},
        color={0,127,255}));
  connect(sensor_pT12.port, sHS2Tank_VN_SaltOuta.port_ch_a) annotation (Line(
        points={{-58,-40},{-58,-42},{-40,-42},{-40,-18.22},{-27.32,-18.22}},
                           color={0,127,255}));
  connect(one3.y,add1. u1) annotation (Line(points={{-55.7,241},{-52,241},{-52,
          236.8},{-46.6,236.8}},                                  color={0,0,
          127}));
  connect(min1.y,add1. u2) annotation (Line(points={{-57.6,228},{-52,228},{-52,
          233.2},{-46.6,233.2}},                             color={0,0,127}));
  connect(one4.y,min1. u2) annotation (Line(points={{-77.7,225},{-72.25,225},{
          -72.25,225.6},{-66.8,225.6}},
                                 color={0,0,127}));
  connect(Level_min_H.y, min1.u1) annotation (Line(points={{-89.2,238},{-70,238},
          {-70,230.4},{-66.8,230.4}}, color={0,0,127}));
  connect(one5.y,add2. u1) annotation (Line(points={{-99.7,163},{-96,163},{-96,
          158.8},{-90.6,158.8}},                                  color={0,0,
          127}));
  connect(min2.y,add2. u2) annotation (Line(points={{-101.6,150},{-96,150},{-96,
          155.2},{-90.6,155.2}},                             color={0,0,127}));
  connect(one6.y,min2. u2) annotation (Line(points={{-121.7,147},{-116.25,147},
          {-116.25,147.6},{-110.8,147.6}},
                                 color={0,0,127}));
  connect(Level_min_C.y, min2.u1) annotation (Line(points={{-133.2,160},{-114,
          160},{-114,152.4},{-110.8,152.4}},
                                           color={0,0,127}));
  connect(one7.y, add3.u1) annotation (Line(points={{-67.7,167},{-67.7,162},{
          -64.6,162},{-64.6,156.8}}, color={0,0,127}));
  connect(add2.y, add3.u2) annotation (Line(points={{-83.7,157},{-70,157},{-70,
          153.2},{-64.6,153.2}}, color={0,0,127}));
  connect(PID3.y, Discharging_Valve_Position.u) annotation (Line(points={{80.4,
          178},{98,178},{98,188},{106,188}},   color={0,0,127}));
  connect(product2.y, max1.u1)
    annotation (Line(points={{-13.6,178},{-13.6,180},{9,180}},
                                                            color={0,0,127}));
  connect(MinLoad.y, product2.u2) annotation (Line(points={{-87.7,177},{-87.7,
          180.4},{-22.8,180.4}}, color={0,0,127}));
  connect(add3.y, product3.u2) annotation (Line(points={{-57.7,155},{-56,155},{
          -56,151.6},{-50.8,151.6}}, color={0,0,127}));
  connect(product3.u1, add3.y) annotation (Line(points={{-50.8,156.4},{-54.25,
          156.4},{-54.25,155},{-57.7,155}}, color={0,0,127}));
  connect(product3.y, product2.u1) annotation (Line(points={{-41.6,154},{-28,
          154},{-28,175.6},{-22.8,175.6}},color={0,0,127}));
  connect(booleanExpression.y, switch1.u2) annotation (Line(points={{26.8,203},
          {26.8,206},{54.8,206}}, color={255,0,255}));
  connect(max1.y, switch1.u3) annotation (Line(points={{20.5,183},{54.8,183},{
          54.8,201.2}}, color={0,0,127}));
  connect(switch1.y, PID3.u_s) annotation (Line(points={{68.6,206},{72,206},{72,
          186},{68,186},{68,178},{71.2,178}}, color={0,0,127}));
  connect(add1.y, product1.u1) annotation (Line(points={{-39.7,235},{-28.25,235},
          {-28.25,235.6},{-16.8,235.6}},
                                       color={0,0,127}));
  connect(MaxLoad.y, product1.u2) annotation (Line(points={{-61.7,251},{-22,251},
          {-22,240.4},{-16.8,240.4}}, color={0,0,127}));
  connect(product1.y, min3.u1) annotation (Line(points={{-7.6,238},{-2,238},{-2,
          222.4},{3.2,222.4}},  color={0,0,127}));
  connect(min3.y, switch1.u1) annotation (Line(points={{12.4,220},{54.8,220},{
          54.8,210.8}}, color={0,0,127}));
  connect(Power.y, PID3.u_m) annotation (Line(points={{25,150},{60,150},{60,168},
          {76,168},{76,173.2}}, color={0,0,127}));
  connect(MaxLoad1.y, product4.u2) annotation (Line(points={{-77.7,209},{-77.7,
          210},{-74,210},{-74,206.4},{-66.8,206.4}}, color={0,0,127}));
  connect(trapezoid.y, product4.u1) annotation (Line(points={{-93.4,204},{-88,
          204},{-88,201.6},{-66.8,201.6}}, color={0,0,127}));
  connect(product4.y, min3.u2) annotation (Line(points={{-57.6,204},{3.2,204},{
          3.2,217.6}}, color={0,0,127}));
  connect(product4.y, max1.u2) annotation (Line(points={{-57.6,204},{4,204},{4,
          186},{9,186}}, color={0,0,127}));
  annotation (                    experiment(
      StopTime=100000,
      Interval=1,
      __Dymola_Algorithm="Esdirk45a"),
    Diagram(coordinateSystem(extent={{-180,-100},{320,260}})),
    Icon(coordinateSystem(extent={{-180,-100},{320,260}})),
    conversion(noneFromVersion=""));
end HTGR_TES_RhC_6a4new_AR_vn1_uprate200MWth_176MWe_;
