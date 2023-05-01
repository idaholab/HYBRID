within NHES.Systems.Examples.TES_Use_Case;
model HTGR_TES_RhC_6a2
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
      hot_tank_init_temp=623.15,
      cold_tank_init_temp=623.15,
      disvalve_m_flow_nom=300,
      chvalve_m_flow_nom=703),
    redeclare EnergyStorage.SHS_Two_Tank.ControlSystems.CS_TES_VN2b
                         CS(
      one1(k=500 + 273.15),
      PID2(yMin=0.01)),
    sensor_m_flow(p_start=3900000, T_start=T_start),
    CHX(
      NTU=16,
      T_start_shell_inlet=973.15,
      T_start_shell_outlet=973.15),
    hot_tank(T_start=773.15))
    annotation (Placement(transformation(extent={{-26,-30},{42,32}})));
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
      const6(k=1.1e8),
      data(Q_Nom=2e8)),
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
      nPebble=120000,
      Pebble_Surface_Init=773.15,
      Pebble_Center_Init=973.15,
      Q_nominal=80000000))
    annotation (Placement(transformation(extent={{-164,-32},{-94,26}})));

  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{44,30},{64,50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{78,28},{98,48}})));
  BalanceOfPlant.Turbine.Reheat_cycle_drumOFH_connectors_salt3
    reheat_cycle_drumOFH_connectors_salt3a(
    pump(m_flow_nominal=200),
    steam_Drum(p_start=21500000, alphag_start=0.8),
    CS(delay3(Ti=10), PartialAdmission(Ti=200)),
    DHX(
      NTU=3.2,
      T_start_shell_inlet=633.15,
      T_start_shell_outlet=623.15,
      dp_general=10000,
      m_start_shell=200),
    const1(k=0.5),
    valveLinear(dp_nominal=5000),
    DHX2(
      NTU=2.4,
      use_T_start_shell=true,
      T_start_shell_outlet=773.15),
    DHX3(
      NTU=1.8,
      T_start_shell_inlet=1023.15,
      T_start_shell_outlet=673.15,
      Q_init=1,
      m_start_shell=100,
      Tube(medium(T(start=750, fixed=true), p(start=800000, fixed=true)))),
    steamTurbine1(use_T_nominal=false, d_nominal(displayUnit="kg/m3") = 2.05),
    DHX1(Q_init=5000000),
    deaerator(level_start=7, p_start=800000),
    const3(k=210),
    ramp(height=-0.2,
         offset=0.2))
    annotation (Placement(transformation(extent={{222,6},{320,86}})));
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
      hot_tank_init_temp=973.15,
      cold_tank_init_temp=743.15,
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
      NTU=18,
      T_start_shell_inlet=973.15,
      T_start_shell_outlet=973.15),
    hot_tank(T_start=773.15),
    one1(k=0.05),
    Charging_bypass(dp_nominal=200000, m_flow_nominal=30))
    annotation (Placement(transformation(extent={{-16,64},{52,126}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT7(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-106,48},{-86,68}})));
  Modelica.Blocks.Sources.RealExpression Reactor_Q(y=
        hTGR_PebbleBed_Primary_Loop.Thermal_Power.y)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-134,-50},{-122,-38}})));
  Modelica.Blocks.Sources.RealExpression Cycle_Q_in(y=
        reheat_cycle_drumOFH_connectors_salt3a.Q_in.y)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-136,-66},{-124,-54}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT8(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{210,106},{230,126}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT9(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{196,104},{216,124}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT10(redeclare package
      Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{174,132},{194,152}})));
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
        origin={166,69})));
  Modelica.Blocks.Sources.RealExpression dLevel(y=-sHS2Tank_VN_SaltOuta.hot_tank.level
         + sHS2Tank_VN_SaltOut3_1.hot_tank.level)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-140,94},{-128,106}})));
  TRANSFORM.Controls.LimPID PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1.1e-2,
    Ti=500,
    yMax=1.0,
    yMin=0.0,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-118,110},{-110,118}})));
  Fluid.Valves.ValveLinear      Charging_bypass(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    allowFlowReversal=true,
    dp_nominal=50000,
    m_flow_nominal=200)                     annotation (Placement(
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
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  TRANSFORM.Controls.LimPID PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-8,
    Ti=250,
    yMax=1.0,
    yMin=0.0,
    y_start=0.0)
    annotation (Placement(transformation(extent={{90,212},{98,220}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=-40000000,
    rising=1000,
    width=23500,
    falling=1000,
    period=27500,
    offset=62000000,
    startTime=13500)
    annotation (Placement(transformation(extent={{-88,236},{-76,248}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    Discharging_Valve_Position(min=1e-4) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={136,226})));
  Modelica.Blocks.Sources.Constant one2(k=12000000)
    annotation (Placement(transformation(extent={{-76,212},{-70,218}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-50,
    duration=500,
    offset=200,
    startTime=5000)
    annotation (Placement(transformation(extent={{148,300},{160,312}})));
  Modelica.Blocks.Sources.RealExpression Power(y=
        reheat_cycle_drumOFH_connectors_salt3a.powerSensor.power)
    annotation (Placement(transformation(extent={{-6,150},{14,170}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{-48,262},{-40,270}})));
  Modelica.Blocks.Sources.Constant one3(k=-0.25)
    annotation (Placement(transformation(extent={{-44,276},{-38,282}})));
  Modelica.Blocks.Sources.Constant one4(k=1.25)
    annotation (Placement(transformation(extent={{-66,260},{-60,266}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-28,270},{-22,276}})));
  Modelica.Blocks.Sources.RealExpression Level_min_H(y=sHS2Tank_VN_SaltOuta.hot_tank.level)
    annotation (Placement(transformation(extent={{-88,268},{-72,284}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{-92,184},{-84,192}})));
  Modelica.Blocks.Sources.Constant one5(k=-0.25)
    annotation (Placement(transformation(extent={{-88,198},{-82,204}})));
  Modelica.Blocks.Sources.Constant one6(k=1.25)
    annotation (Placement(transformation(extent={{-110,182},{-104,188}})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{-72,192},{-66,198}})));
  Modelica.Blocks.Sources.RealExpression Level_min_C(y=sHS2Tank_VN_SaltOuta.cold_tank.level)
    annotation (Placement(transformation(extent={{-132,190},{-116,206}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-4,220},{4,212}})));
  Modelica.Blocks.Sources.Constant one7(k=2)
    annotation (Placement(transformation(extent={{-56,202},{-50,208}})));
  Modelica.Blocks.Math.Add add3(k2=-1)
    annotation (Placement(transformation(extent={{-46,190},{-40,196}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{28,226},{38,216}})));
  Modelica.Blocks.Math.Product product3
    annotation (Placement(transformation(extent={{-32,188},{-24,196}})));
  Modelica.Blocks.Math.Min min3
    annotation (Placement(transformation(extent={{22,254},{30,262}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{74,238},{86,250}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=
        sHS2Tank_VN_SaltOuta.hot_tank.level < sHS2Tank_VN_SaltOuta.cold_tank.level)
    annotation (Placement(transformation(extent={{28,234},{44,248}})));
  Modelica.Blocks.Sources.Constant one8(k=65000000)
    annotation (Placement(transformation(extent={{-58,304},{-52,310}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{2,280},{10,272}})));
equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 40;
    Discharging_Valve_Position.y =sHS2Tank_VN_SaltOuta.Discharging_Valve.opening;
  connect(hTGR_PebbleBed_Primary_Loop.port_a, sHS2Tank_VN_SaltOuta.port_ch_b)
    annotation (Line(points={{-95.05,-12.57},{-34,-12.57},{-34,17.74},{-25.32,
          17.74}},
        color={0,127,255}));

  connect(sensor_pT2.port, sHS2Tank_VN_SaltOuta.port_dch_b) annotation (Line(
        points={{88,28},{88,-18.22},{42,-18.22}}, color={0,127,255}));
  connect(sensor_pT1.port, sHS2Tank_VN_SaltOuta.port_dch_a) annotation (Line(
        points={{54,30},{50,30},{50,18.98},{41.32,18.98}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOuta.port_dch_b,
    reheat_cycle_drumOFH_connectors_salt3a.LT_in) annotation (Line(points={{42,
          -18.22},{88,-18.22},{88,18},{218,18},{218,26.2353},{222.467,26.2353}},
                                                                         color={
          0,127,255}));
  connect(reheat_cycle_drumOFH_connectors_salt3a.LT_out, sHS2Tank_VN_SaltOuta.port_dch_a)
    annotation (Line(points={{222.467,8.82353},{52,8.82353},{52,18.98},{41.32,
          18.98}},
        color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, sensor_pT4.port) annotation (Line(
        points={{-95.05,-12.57},{-76.525,-12.57},{-76.525,-12},{-58,-12}},
        color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, sensor_pT7.port) annotation (Line(
        points={{-95.05,11.21},{-96,11.21},{-96,48}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_b,
    reheat_cycle_drumOFH_connectors_salt3a.HT_RH_in) annotation (Line(points={{52,
          75.78},{52,76},{200,76},{200,83.1765},{222.933,83.1765}}, color={0,127,
          255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_b, sensor_pT6.port) annotation (Line(
        points={{52,75.78},{61,75.78},{61,76},{70,76}}, color={0,127,255}));
  connect(reheat_cycle_drumOFH_connectors_salt3a.HT_SH_in,
    sHS2Tank_VN_SaltOut3_1.port_dch_b) annotation (Line(points={{222,58.2353},{
          200,58.2353},{200,76},{52,76},{52,75.78}},
                                                 color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_ch_b, sensor_pT3.port) annotation (Line(
        points={{-15.32,111.74},{-21.66,111.74},{-21.66,112},{-28,112}}, color=
          {0,127,255}));
  connect(sensor_pT5.port, sHS2Tank_VN_SaltOut3_1.port_dch_a) annotation (Line(
        points={{76,128},{76,112.98},{51.32,112.98}}, color={0,127,255}));
  connect(sensor_pT8.port, reheat_cycle_drumOFH_connectors_salt3a.HT_RH_in)
    annotation (Line(points={{220,106},{220,94},{222.933,94},{222.933,83.1765}},
        color={0,127,255}));
  connect(sensor_pT9.port, reheat_cycle_drumOFH_connectors_salt3a.HT_SH_in)
    annotation (Line(points={{206,104},{208,104},{208,94},{210,94},{210,58.2353},
          {222,58.2353}}, color={0,127,255}));
  connect(sensor_pT10.port, reheat_cycle_drumOFH_connectors_salt3a.HT_RH_out)
    annotation (Line(points={{184,132},{184,67.1765},{222.467,67.1765}}, color={
          0,127,255}));
  connect(sensor_pT11.port, reheat_cycle_drumOFH_connectors_salt3a.HT_SH_out)
    annotation (Line(points={{170,130},{170,124},{176,124},{176,46.4706},{222,
          46.4706}},
        color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_a, volume.port_b) annotation (Line(
        points={{51.32,112.98},{114,112.98},{114,114},{124,114}}, color={0,127,
          255}));
  connect(sensor_pT11.port, R_entry1.port_b) annotation (Line(points={{170,130},
          {170,124},{176,124},{176.2,49}}, color={0,127,255}));
  connect(R_entry1.port_a, volume.port_a) annotation (Line(points={{167.8,49},{
          136,49},{136,114}}, color={0,127,255}));
  connect(volume.port_a, R_entry2.port_a) annotation (Line(points={{136,114},{
          142,114},{142,106},{158,106},{158,69.1765},{161.8,69}}, color={0,127,
          255}));
  connect(R_entry2.port_b, reheat_cycle_drumOFH_connectors_salt3a.HT_RH_out)
    annotation (Line(points={{170.2,69},{199.334,69},{199.334,67.1765},{222.467,
          67.1765}}, color={0,127,255}));
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
      Line(points={{-54.4,47},{-24,47},{-24,66.48},{-16.68,66.48}}, color={0,
          127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_ch_b, resistance1.port_b) annotation (
      Line(points={{-15.32,111.74},{-22,111.74},{-22,98.6},{-42,98.6}}, color={
          0,127,255}));
  connect(resistance1.port_a, sHS2Tank_VN_SaltOuta.port_ch_a) annotation (Line(
        points={{-42,87.4},{-42,-18.22},{-25.32,-18.22}}, color={0,127,255}));
  connect(Charging_bypass.port_b, sHS2Tank_VN_SaltOuta.port_ch_a) annotation (
      Line(points={{-54,75},{-48,75},{-48,76},{-42,76},{-42,-18.22},{-25.32,
          -18.22}},
        color={0,127,255}));
  connect(sensor_pT12.port, sHS2Tank_VN_SaltOuta.port_ch_a) annotation (Line(
        points={{-50,-50},{-50,-56},{-32,-56},{-32,-24},{-34,-24},{-34,-18.22},
          {-25.32,-18.22}},color={0,127,255}));
  connect(Power.y, PID3.u_m)
    annotation (Line(points={{15,160},{94,160},{94,211.2}},
                                                          color={0,0,127}));
  connect(one3.y,add1. u1) annotation (Line(points={{-37.7,279},{-34,279},{-34,
          274.8},{-28.6,274.8}},                                  color={0,0,
          127}));
  connect(min1.y,add1. u2) annotation (Line(points={{-39.6,266},{-34,266},{-34,
          271.2},{-28.6,271.2}},                             color={0,0,127}));
  connect(one4.y,min1. u2) annotation (Line(points={{-59.7,263},{-54.25,263},{
          -54.25,263.6},{-48.8,263.6}},
                                 color={0,0,127}));
  connect(Level_min_H.y, min1.u1) annotation (Line(points={{-71.2,276},{-52,276},
          {-52,268.4},{-48.8,268.4}}, color={0,0,127}));
  connect(one5.y,add2. u1) annotation (Line(points={{-81.7,201},{-78,201},{-78,
          196.8},{-72.6,196.8}},                                  color={0,0,
          127}));
  connect(min2.y,add2. u2) annotation (Line(points={{-83.6,188},{-78,188},{-78,
          193.2},{-72.6,193.2}},                             color={0,0,127}));
  connect(one6.y,min2. u2) annotation (Line(points={{-103.7,185},{-98.25,185},{
          -98.25,185.6},{-92.8,185.6}},
                                 color={0,0,127}));
  connect(Level_min_C.y, min2.u1) annotation (Line(points={{-115.2,198},{-96,
          198},{-96,190.4},{-92.8,190.4}}, color={0,0,127}));
  connect(one7.y, add3.u1) annotation (Line(points={{-49.7,205},{-49.7,200},{
          -46.6,200},{-46.6,194.8}}, color={0,0,127}));
  connect(add2.y, add3.u2) annotation (Line(points={{-65.7,195},{-52,195},{-52,
          191.2},{-46.6,191.2}}, color={0,0,127}));
  connect(PID3.y, Discharging_Valve_Position.u) annotation (Line(points={{98.4,
          216},{116,216},{116,226},{124,226}}, color={0,0,127}));
  connect(product2.y, max1.u1)
    annotation (Line(points={{4.4,216},{4.4,218},{27,218}}, color={0,0,127}));
  connect(one2.y, product2.u2) annotation (Line(points={{-69.7,215},{-68,215},{
          -68,218.4},{-4.8,218.4}}, color={0,0,127}));
  connect(trapezoid.y, max1.u2) annotation (Line(points={{-75.4,242},{20,242},{
          20,224},{27,224}}, color={0,0,127}));
  connect(add3.y, product3.u2) annotation (Line(points={{-39.7,193},{-38,193},{
          -38,189.6},{-32.8,189.6}}, color={0,0,127}));
  connect(product3.u1, add3.y) annotation (Line(points={{-32.8,194.4},{-36.25,
          194.4},{-36.25,193},{-39.7,193}}, color={0,0,127}));
  connect(product3.y, product2.u1) annotation (Line(points={{-23.6,192},{-10,
          192},{-10,213.6},{-4.8,213.6}}, color={0,0,127}));
  connect(min3.u2, trapezoid.y) annotation (Line(points={{21.2,255.6},{20,255.6},
          {20,242},{-75.4,242}}, color={0,0,127}));
  connect(booleanExpression.y, switch1.u2) annotation (Line(points={{44.8,241},
          {44.8,244},{72.8,244}}, color={255,0,255}));
  connect(max1.y, switch1.u3) annotation (Line(points={{38.5,221},{72.8,221},{
          72.8,239.2}}, color={0,0,127}));
  connect(switch1.y, PID3.u_s) annotation (Line(points={{86.6,244},{90,244},{90,
          224},{86,224},{86,216},{89.2,216}}, color={0,0,127}));
  connect(add1.y, product1.u1) annotation (Line(points={{-21.7,273},{-10.25,273},
          {-10.25,273.6},{1.2,273.6}}, color={0,0,127}));
  connect(one8.y, product1.u2) annotation (Line(points={{-51.7,307},{-4,307},{
          -4,278.4},{1.2,278.4}}, color={0,0,127}));
  connect(product1.y, min3.u1) annotation (Line(points={{10.4,276},{16,276},{16,
          260.4},{21.2,260.4}}, color={0,0,127}));
  connect(min3.y, switch1.u1) annotation (Line(points={{30.4,258},{72.8,258},{
          72.8,248.8}}, color={0,0,127}));
  annotation (                    experiment(
      StopTime=25000,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Esdirk34a"));
end HTGR_TES_RhC_6a2;
