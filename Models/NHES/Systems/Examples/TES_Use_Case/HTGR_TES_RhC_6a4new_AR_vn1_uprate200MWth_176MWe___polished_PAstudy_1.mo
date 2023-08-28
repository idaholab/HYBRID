within NHES.Systems.Examples.TES_Use_Case;
model HTGR_TES_RhC_6a4new_AR_vn1_uprate200MWth_176MWe___polished_PAstudy_1
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
    annotation (Placement(transformation(extent={{78,-12},{98,8}})));
  BalanceOfPlant.Turbine.Reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1
    reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1(
    pump(m_flow_nominal=200),
    steam_Drum(
      p_start=21200000,
      alphag_start=0.5,
      V_drum=30*2.8,
      A_drum=15*2.8),
    CS(
      PartialAdmission(k=-2.0e-7, Ti=80),
      FWH_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-2,
        Ti=12000,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=0),
      const9(k=273.15 + 165),
      delay3(Ti=0.1),
      CondPumpSpeed(
        k=13,
        Ti=500,
        yMax=80*2.5),
      timer1(Start_Time=1),
      PID(
        controllerType=Modelica.Blocks.Types.SimpleController.P,
        k=-2100*0.8,
        Ti=0.1,    yMax=120*2.8,
        yMin=5),
      SH_mflow(
        k=-5.6,
        Ti=200,yMax=120*2.5),
      PID2(
        k=-0.8,
           Ti=250,
           yMax=120*2.5),
      const10(k=6),
      PartialAdmission1(k=-0.1e-5, Ti=1e2),
      delay1(Ti=120)),
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
      K_tube=10,
      T_start_shell_inlet=1023.15,
      T_start_shell_outlet=673.15,
      Q_init=1,
      m_start_shell=100,
      Tube(medium(T(start=750, fixed=true), p(start=800000, fixed=true)))),
    steamTurbine1(
      m_flow_nominal=2.0*46,
      p_inlet_nominal=810000,
      use_T_nominal=false,
      d_nominal(displayUnit="kg/m3") = 2.05),
    DHX1(
      NTU=8,
      K_tube=20,
      V_Tube=15,
      V_Shell=15,
         Q_init=2.5*5000000),
    deaerator(level_start=8, p_start=800000),
    const3(k=1.1*210),
    ramp(height=-0.2, offset=0.2),
    steamTurbine(
      m_flow_nominal=2.085*57,
      p_outlet_nominal=810000,
      T_nominal=823.15),
    LPT_Bypass(dp_nominal=99999.99999999999*(8/8), m_flow_nominal=2.5*50/2.5),
    condenser(V_total=2.5*1000),
    valveLinear(m_flow_nominal=50*0.5),
    const2(k=5000),
    delay3(Ti=1000))
    annotation (Placement(transformation(extent={{160,-16},{284,86}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT3(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-38,112},{-18,132}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT4(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-68,-12},{-48,8}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT5(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{66,114},{86,134}})));
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
        reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.Q_in.y)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{226,88},{238,100}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT8(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{180,86},{200,106}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT9(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{156,86},{176,106}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT10(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{130,86},{150,106}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT11(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{110,86},{130,106}})));
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
        origin={92,114})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_entry1(R=1,
      redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(
        extent={{6,-7},{-6,7}},
        rotation=180,
        origin={110,33})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance R_entry2(R=1,
      redeclare package Medium =
        Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(
        extent={{6,-7},{-6,7}},
        rotation=180,
        origin={110,51})));
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
    k=2.1e-7,
    Ti=50,
    yMax=1.0,
    yMin=0.0,
    y_start=0.0)
    annotation (Placement(transformation(extent={{128,176},{136,184}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=-30e6,
    rising=1200,
    width=15500,
    falling=1200,
    period=32500,
    offset=80e6,
    startTime=11500)
    annotation (Placement(transformation(extent={{-50,200},{-38,212}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    Discharging_Valve_Position(min=1e-4, max=1)
                                         annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={174,190})));
  Modelica.Blocks.Sources.Constant MinLoad(k=15000000)
    annotation (Placement(transformation(extent={{-38,176},{-32,182}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-50,
    duration=500,
    offset=200,
    startTime=5000)
    annotation (Placement(transformation(extent={{234,308},{246,320}})));
  Modelica.Blocks.Sources.RealExpression Power(y=
        reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.powerSensor.power -
        reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.pump_SimpleMassFlow1.W
         - reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.pump_SimpleMassFlow2.W)
    annotation (Placement(transformation(extent={{60,142},{80,162}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{-10,226},{-2,234}})));
  Modelica.Blocks.Sources.Constant one3(k=-0.25)
    annotation (Placement(transformation(extent={{-6,240},{0,246}})));
  Modelica.Blocks.Sources.Constant one4(k=1.25)
    annotation (Placement(transformation(extent={{-28,224},{-22,230}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{10,234},{16,240}})));
  Modelica.Blocks.Sources.RealExpression Level_min_H(y=sHS2Tank_VN_SaltOuta.hot_tank.level)
    annotation (Placement(transformation(extent={{-50,232},{-34,248}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{-54,148},{-46,156}})));
  Modelica.Blocks.Sources.Constant one5(k=-1.7)
    annotation (Placement(transformation(extent={{-50,162},{-44,168}})));
  Modelica.Blocks.Sources.Constant one6(k=2.7)
    annotation (Placement(transformation(extent={{-72,146},{-66,152}})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{-34,156},{-28,162}})));
  Modelica.Blocks.Sources.RealExpression Level_min_C(y=sHS2Tank_VN_SaltOuta.cold_tank.level)
    annotation (Placement(transformation(extent={{-94,154},{-78,170}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{34,184},{42,176}})));
  Modelica.Blocks.Sources.Constant one7(k=2)
    annotation (Placement(transformation(extent={{-18,166},{-12,172}})));
  Modelica.Blocks.Math.Add add3(k2=-1)
    annotation (Placement(transformation(extent={{-8,154},{-2,160}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{66,190},{76,180}})));
  Modelica.Blocks.Math.Product product3
    annotation (Placement(transformation(extent={{6,152},{14,160}})));
  Modelica.Blocks.Math.Min min3
    annotation (Placement(transformation(extent={{60,218},{68,226}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{112,202},{124,214}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=
        sHS2Tank_VN_SaltOuta.hot_tank.level < sHS2Tank_VN_SaltOuta.cold_tank.level)
    annotation (Placement(transformation(extent={{66,198},{82,212}})));
  Modelica.Blocks.Sources.Constant MaxLoad(k=176e6)
    annotation (Placement(transformation(extent={{-12,250},{-6,256}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{40,244},{48,236}})));
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
    table=[0,80000000; 54000,80000000; 55200,174923757.6; 56400,174923757.6;
        57600,871993.1625; 60000,871993.1625; 61200,871993.1591; 63600,
        871993.1591; 64800,76256848.35; 67200,76256848.35; 68400,87493000;
        70800,87493000; 72000,174923757.6; 74400,174923757.6; 75600,871993.1581;
        78000,871993.1581; 79200,76968720.64; 81600,76968720.64; 82800,
        139599082.6; 85200,139599082.6; 86400,174923757.6; 88800,174923757.6;
        90000,174923757.6; 92400,174923757.6; 93600,174923757.6; 96000,
        174923757.6; 97200,87493000; 99600,87493000; 100800,871993.1594; 103200,
        871993.1594; 104400,871993.1591; 106800,871993.1591; 108000,87492999.86;
        110400,87492999.86; 111600,871993.1672; 114000,871993.1672; 115200,
        146508203.4; 117600,146508203.4; 118800,174923757.6; 121200,174923757.6;
        122400,174923757.6; 124800,174923757.6; 126000,87493000.02; 128400,
        87493000.02; 129600,871993.1595; 132000,871993.1595; 133200,87493000;
        135600,87493000; 136800,165451906.2; 139200,165451906.2; 140400,
        871993.1592; 142800,871993.1592; 144000,87493000; 146400,87493000;
        147600,165451906.2; 150000,165451906.2; 151200,871993.1588; 153600,
        871993.1588; 154800,74121242; 157200,74121242; 158400,174923757.6;
        160800,174923757.6; 162000,871993.1587; 164400,871993.1587; 165600,
        871993.1592; 168000,871993.1592; 169200,871993.1599; 171600,871993.1599;
        172800,871993.1597; 175200,871993.1597; 176400,174923757.6; 178800,
        174923757.6; 180000,76968720.63; 182400,76968720.63; 183600,871993.1588;
        186000,871993.1588; 187200,174923757.6; 189600,174923757.6; 190800,
        174923757.6; 193200,174923757.6; 194400,139599082.6; 196800,139599082.6;
        198000,174923757.6; 200400,174923757.6; 201600,87493000; 204000,
        87493000; 205200,66444441.23; 207600,66444441.23; 208800,871993.189;
        211200,871993.189; 212400,87493000; 214800,87493000; 216000,871993.16;
        218400,871993.16; 219600,174923757.6; 222000,174923757.6; 223200,
        174923757.6; 225600,174923757.6; 226800,174923757.6; 229200,174923757.6;
        230400,871993.1625; 232800,871993.1625; 234000,871993.1591; 236400,
        871993.1591; 237600,76256848.35; 240000,76256848.35; 241200,87493000;
        243600,87493000; 244800,174923757.6; 247200,174923757.6; 248400,
        871993.1581; 250800,871993.1581; 252000,76968720.64; 254400,76968720.64;
        255600,139599082.6; 258000,139599082.6; 259200,174923757.6; 261600,
        174923757.6; 262800,174923757.6; 265200,174923757.6; 266400,174923757.6;
        268800,174923757.6; 270000,87493000; 272400,87493000; 273600,
        871993.1594; 276000,871993.1594; 277200,871993.1591; 279600,871993.1591;
        280800,87492999.86; 283200,87492999.86; 284400,871993.1672; 286800,
        871993.1672; 288000,146508203.4; 290400,146508203.4; 291600,174923757.6;
        294000,174923757.6; 295200,174923757.6; 297600,174923757.6; 298800,
        87493000.02; 301200,87493000.02; 302400,871993.1595; 304800,871993.1595;
        306000,87493000; 308400,87493000; 309600,165451906.2; 312000,
        165451906.2; 313200,871993.1592; 600000,871993.1592],
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    startTime=0,
    tableName="BOP",
    timeScale=1,
    fileName=
        "C:/Users/NOVOV/projects/HYBRID/Models/NHES/Resources/Data/RAVEN/timeSeriesDataVN.txt",
    shiftTime=0)
    annotation (Placement(transformation(extent={{-160,204},{-140,224}})));

  Modelica.Blocks.Math.Max MinLoadLimit
    annotation (Placement(transformation(extent={{-106,226},{-96,216}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=95e6,
    rising=1200,
    width=12500,
    falling=1200,
    period=32500,
    offset=0,
    startTime=20500)
    annotation (Placement(transformation(extent={{-72,214},{-60,226}})));
  Modelica.Blocks.Math.Add add4
    annotation (Placement(transformation(extent={{-24,208},{-18,214}})));
equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 40;
    Discharging_Valve_Position.y =sHS2Tank_VN_SaltOuta.Discharging_Valve.opening;
  connect(hTGR_PebbleBed_Primary_Loop.port_a, sHS2Tank_VN_SaltOuta.port_ch_b)
    annotation (Line(points={{-95.05,-12.57},{-34,-12.57},{-34,17.74},{-27.32,
          17.74}},
        color={0,127,255}));

  connect(sensor_pT2.port, sHS2Tank_VN_SaltOuta.port_dch_b) annotation (Line(
        points={{88,-12},{88,-18.22},{40,-18.22}},color={0,127,255}));
  connect(sensor_pT1.port, sHS2Tank_VN_SaltOuta.port_dch_a) annotation (Line(
        points={{54,30},{50,30},{50,18.98},{39.32,18.98}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOuta.port_dch_b,
    reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.LT_in) annotation (Line(
        points={{40,-18.22},{40,-18},{176,-18},{176,14},{194.634,14},{194.634,
          15.025}}, color={0,127,255}));
  connect(reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.LT_out,
    sHS2Tank_VN_SaltOuta.port_dch_a) annotation (Line(points={{194.634,-0.7},{
          194.634,0},{98,0},{98,18.98},{39.32,18.98}}, color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, sensor_pT4.port) annotation (Line(
        points={{-95.05,-12.57},{-76.525,-12.57},{-76.525,-12},{-58,-12}},
        color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, sensor_pT7.port) annotation (Line(
        points={{-95.05,11.21},{-96,11.21},{-96,48}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_b,
    reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.HT_RH_in) annotation (
      Line(points={{56,77.78},{56,76},{150,76},{150,66},{194,66},{194,66.45},{
          195.062,66.45}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_b, sensor_pT6.port) annotation (Line(
        points={{56,77.78},{61,77.78},{61,76},{70,76}}, color={0,127,255}));
  connect(reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.HT_SH_in,
    sHS2Tank_VN_SaltOut3_1.port_dch_b) annotation (Line(points={{194.207,43.925},
          {152,43.925},{152,44},{150,44},{150,76},{56,76},{56,77.78}}, color={0,
          127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_ch_b, sensor_pT3.port) annotation (Line(
        points={{-11.32,113.74},{-21.66,113.74},{-21.66,112},{-28,112}}, color=
          {0,127,255}));
  connect(sensor_pT5.port, sHS2Tank_VN_SaltOut3_1.port_dch_a) annotation (Line(
        points={{76,114},{76,114.98},{55.32,114.98}}, color={0,127,255}));
  connect(sensor_pT8.port, reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.HT_RH_in)
    annotation (Line(points={{190,86},{190,66},{195.062,66},{195.062,66.45}},
        color={0,127,255}));
  connect(sensor_pT9.port, reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.HT_SH_in)
    annotation (Line(points={{166,86},{166,43.925},{194.207,43.925}}, color={0,
          127,255}));
  connect(sensor_pT10.port, reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.HT_RH_out)
    annotation (Line(points={{140,86},{140,52},{194.634,52}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_a, volume.port_b) annotation (Line(
        points={{55.32,114.98},{86,114.98},{86,114}},             color={0,127,
          255}));
  connect(R_entry1.port_a, volume.port_a) annotation (Line(points={{105.8,33},{
          102,33},{102,114},{98,114}},
                              color={0,127,255}));
  connect(volume.port_a, R_entry2.port_a) annotation (Line(points={{98,114},{
          102,114},{102,52},{106,52},{106,51},{105.8,51}},        color={0,127,
          255}));
  connect(R_entry2.port_b, reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.HT_RH_out)
    annotation (Line(points={{114.2,51},{130,51},{130,52},{194.634,52}}, color=
          {0,127,255}));
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
  connect(one3.y,add1. u1) annotation (Line(points={{0.3,243},{4,243},{4,238.8},
          {9.4,238.8}},                                           color={0,0,
          127}));
  connect(min1.y,add1. u2) annotation (Line(points={{-1.6,230},{4,230},{4,235.2},
          {9.4,235.2}},                                      color={0,0,127}));
  connect(one4.y,min1. u2) annotation (Line(points={{-21.7,227},{-16.25,227},{
          -16.25,227.6},{-10.8,227.6}},
                                 color={0,0,127}));
  connect(Level_min_H.y, min1.u1) annotation (Line(points={{-33.2,240},{-14,240},
          {-14,232.4},{-10.8,232.4}}, color={0,0,127}));
  connect(one5.y,add2. u1) annotation (Line(points={{-43.7,165},{-40,165},{-40,
          160.8},{-34.6,160.8}},                                  color={0,0,
          127}));
  connect(min2.y,add2. u2) annotation (Line(points={{-45.6,152},{-40,152},{-40,
          157.2},{-34.6,157.2}},                             color={0,0,127}));
  connect(one6.y,min2. u2) annotation (Line(points={{-65.7,149},{-60.25,149},{
          -60.25,149.6},{-54.8,149.6}},
                                 color={0,0,127}));
  connect(Level_min_C.y, min2.u1) annotation (Line(points={{-77.2,162},{-58,162},
          {-58,154.4},{-54.8,154.4}},      color={0,0,127}));
  connect(one7.y, add3.u1) annotation (Line(points={{-11.7,169},{-11.7,164},{
          -8.6,164},{-8.6,158.8}},   color={0,0,127}));
  connect(add2.y, add3.u2) annotation (Line(points={{-27.7,159},{-14,159},{-14,
          155.2},{-8.6,155.2}},  color={0,0,127}));
  connect(PID3.y, Discharging_Valve_Position.u) annotation (Line(points={{136.4,
          180},{154,180},{154,190},{162,190}}, color={0,0,127}));
  connect(product2.y, max1.u1)
    annotation (Line(points={{42.4,180},{42.4,182},{65,182}},
                                                            color={0,0,127}));
  connect(MinLoad.y, product2.u2) annotation (Line(points={{-31.7,179},{-31.7,
          182.4},{33.2,182.4}},  color={0,0,127}));
  connect(add3.y, product3.u2) annotation (Line(points={{-1.7,157},{0,157},{0,
          153.6},{5.2,153.6}},       color={0,0,127}));
  connect(product3.u1, add3.y) annotation (Line(points={{5.2,158.4},{1.75,158.4},
          {1.75,157},{-1.7,157}},           color={0,0,127}));
  connect(product3.y, product2.u1) annotation (Line(points={{14.4,156},{28,156},
          {28,177.6},{33.2,177.6}},       color={0,0,127}));
  connect(booleanExpression.y, switch1.u2) annotation (Line(points={{82.8,205},
          {82.8,208},{110.8,208}},color={255,0,255}));
  connect(max1.y, switch1.u3) annotation (Line(points={{76.5,185},{110.8,185},{
          110.8,203.2}},color={0,0,127}));
  connect(switch1.y, PID3.u_s) annotation (Line(points={{124.6,208},{128,208},{
          128,188},{124,188},{124,180},{127.2,180}},
                                              color={0,0,127}));
  connect(add1.y, product1.u1) annotation (Line(points={{16.3,237},{27.75,237},
          {27.75,237.6},{39.2,237.6}}, color={0,0,127}));
  connect(MaxLoad.y, product1.u2) annotation (Line(points={{-5.7,253},{34,253},
          {34,242.4},{39.2,242.4}},   color={0,0,127}));
  connect(product1.y, min3.u1) annotation (Line(points={{48.4,240},{54,240},{54,
          224.4},{59.2,224.4}}, color={0,0,127}));
  connect(min3.y, switch1.u1) annotation (Line(points={{68.4,222},{110.8,222},{
          110.8,212.8}},color={0,0,127}));
  connect(Power.y, PID3.u_m) annotation (Line(points={{81,152},{116,152},{116,
          170},{132,170},{132,175.2}},
                                color={0,0,127}));
  connect(MinLoad.y, MinLoadLimit.u1) annotation (Line(points={{-31.7,179},{-30,
          179},{-30,182},{-28,182},{-28,194},{-112,194},{-112,218},{-107,218}},
        color={0,0,127}));
  connect(demand_BOP1.y[1], MinLoadLimit.u2) annotation (Line(points={{-139,214},
          {-118,214},{-118,224},{-107,224}}, color={0,0,127}));
  connect(R_entry1.port_b, reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.HT_SH_out)
    annotation (Line(points={{114.2,33},{116,33.3},{194.207,33.3}}, color={0,
          127,255}));
  connect(sensor_pT11.port, reheat_cycle_drumOFH_Toutctr_AR_vn3_polished_PA1_1.HT_SH_out)
    annotation (Line(points={{120,86},{120,33.3},{194.207,33.3}}, color={0,127,
          255}));
  connect(max1.u2, add4.y) annotation (Line(points={{65,188},{-12,188},{-12,211},
          {-17.7,211}}, color={0,0,127}));
  connect(min3.u2, add4.y) annotation (Line(points={{59.2,219.6},{-17.7,219.6},
          {-17.7,211}}, color={0,0,127}));
  connect(trapezoid.y, add4.u2) annotation (Line(points={{-37.4,206},{-30,206},
          {-30,209.2},{-24.6,209.2}}, color={0,0,127}));
  connect(trapezoid1.y, add4.u1) annotation (Line(points={{-59.4,220},{-28,220},
          {-28,212.8},{-24.6,212.8}}, color={0,0,127}));
  annotation (                    experiment(
      StopTime=100000,
      Interval=1,
      __Dymola_Algorithm="Esdirk45a"),
    Diagram(coordinateSystem(extent={{-180,-100},{320,260}})),
    Icon(coordinateSystem(extent={{-180,-100},{320,260}})),
    conversion(noneFromVersion=""));
end HTGR_TES_RhC_6a4new_AR_vn1_uprate200MWth_176MWe___polished_PAstudy_1;
