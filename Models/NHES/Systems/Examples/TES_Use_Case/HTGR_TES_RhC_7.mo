within NHES.Systems.Examples.TES_Use_Case;
model HTGR_TES_RhC_7
  EnergyStorage.SHS_Two_Tank.Components.SHS2Tank_VN_SaltOut_LT2
    sHS2Tank_VN_SaltOut_LT2_1(
    redeclare package Storage_Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    redeclare package Charging_Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    m_flow_min=0.1,
    Steam_Output_Temp=773.15,
    volume(T_start=773.15),
    discharge_pump(T_start=773.15 - 50),
    charge_pump(T_start=T_start),
    data(
      hot_tank_init_temp=623.15,
      cold_tank_init_temp=623.15,
      disvalve_m_flow_nom=300,
      chvalve_m_flow_nom=703),
    redeclare EnergyStorage.SHS_Two_Tank.ControlSystems.CS_TES_VN3
                         CS(
                        trapezoid(
        amplitude=-50,
        width=2750,
        period=2200,
        offset=200,
        startTime=5e3),
      one1(k=500 + 273.15),
      PID2(yMin=0.01),
      one8(k=273.15 + 238)),
    sensor_m_flow(p_start=3900000, T_start=T_start),
    CHX(T_start_shell_inlet=973.15, T_start_shell_outlet=973.15),
    hot_tank(T_start=773.15 - 50))
    annotation (Placement(transformation(extent={{-26,-28},{42,34}})));
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
      const6(k=1.5e8),
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
      nPebble=220000,
      Pebble_Surface_Init=773.15,
      Pebble_Center_Init=973.15))
    annotation (Placement(transformation(extent={{-164,-32},{-94,26}})));

  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{44,30},{64,50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{78,28},{98,48}})));
  BalanceOfPlant.Turbine.RH_cycle_drumOFH_salt_TCV rH_cycle_drumOFH_salt_TCV2_1(
    pump(m_flow_nominal=200),
    steam_Drum(p_start=19500000, alphag_start=0.85),
    CS(delay3(Ti=10), PartialAdmission(yMin=0.99)),
    DHX(
      NTU=3.5,
      T_start_shell_inlet=633.15,
      T_start_shell_outlet=623.15,
      dp_general=10000,
      m_start_shell=200),
    const1(k=0),
    valveLinear(dp_nominal=3000),
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
    steamTurbine1(
      m_flow_nominal=49,
      use_T_nominal=false,
      d_nominal(displayUnit="kg/m3") = 2.05),
    DHX1(
      p_start_tube=19000000,
      T_start_shell_inlet=723.15,
      Q_init=5000000),
    deaerator(level_start=7, p_start=800000),
    const3(k=210),
    const4(k=1),
    TCV(dp_nominal=50000),
    condenser(V_total=25),
    steamTurbine(m_flow_nominal=65),
    ramp(height=-0.99))
    annotation (Placement(transformation(extent={{228,8},{326,88}})));
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
    Steam_Output_Temp=973.15,
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
      one1(k=740 + 273.15),
      PID2(yMin=0.01)),
    sensor_m_flow(p_start=3900000, T_start=T_start),
    CHX(T_start_shell_inlet=973.15, T_start_shell_outlet=973.15),
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
        rH_cycle_drumOFH_salt_TCV2_1.Q_in.y)
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
  Modelica.Blocks.Sources.RealExpression dLevel(y=-sHS2Tank_VN_SaltOut_LT2_1.hot_tank.level
         + sHS2Tank_VN_SaltOut3_1.hot_tank.level)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{-140,94},{-128,106}})));
  TRANSFORM.Controls.LimPID PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1.5e-2,
    Ti=15,
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
equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 40;

  connect(hTGR_PebbleBed_Primary_Loop.port_a, sHS2Tank_VN_SaltOut_LT2_1.port_ch_b)
    annotation (Line(points={{-95.05,-12.57},{-34,-12.57},{-34,19.74},{-25.32,
          19.74}}, color={0,127,255}));
  connect(sensor_pT2.port, sHS2Tank_VN_SaltOut_LT2_1.port_dch_b) annotation (
      Line(points={{88,28},{88,-16.22},{42,-16.22}}, color={0,127,255}));
  connect(sensor_pT1.port, sHS2Tank_VN_SaltOut_LT2_1.port_dch_a) annotation (
      Line(points={{54,30},{50,30},{50,20.98},{41.32,20.98}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut_LT2_1.port_dch_b, rH_cycle_drumOFH_salt_TCV2_1.LT_in)
    annotation (Line(points={{42,-16.22},{88,-16.22},{88,18},{218,18},{218,
          28.2353},{228.467,28.2353}}, color={0,127,255}));
  connect(rH_cycle_drumOFH_salt_TCV2_1.LT_out, sHS2Tank_VN_SaltOut_LT2_1.port_dch_a)
    annotation (Line(points={{228.467,10.8235},{52,10.8235},{52,20.98},{41.32,
          20.98}}, color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, sensor_pT4.port) annotation (Line(
        points={{-95.05,-12.57},{-76.525,-12.57},{-76.525,-12},{-58,-12}},
        color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, sensor_pT7.port) annotation (Line(
        points={{-95.05,11.21},{-96,11.21},{-96,48}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_b, rH_cycle_drumOFH_salt_TCV2_1.HT_RH_in)
    annotation (Line(points={{52,75.78},{52,76},{200,76},{200,85.1765},{228.933,
          85.1765}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_b, sensor_pT6.port) annotation (Line(
        points={{52,75.78},{61,75.78},{61,76},{70,76}}, color={0,127,255}));
  connect(rH_cycle_drumOFH_salt_TCV2_1.HT_SH_in, sHS2Tank_VN_SaltOut3_1.port_dch_b)
    annotation (Line(points={{228,60.2353},{200,60.2353},{200,76},{52,76},{52,
          75.78}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_ch_b, sensor_pT3.port) annotation (Line(
        points={{-15.32,111.74},{-21.66,111.74},{-21.66,112},{-28,112}}, color=
          {0,127,255}));
  connect(sensor_pT5.port, sHS2Tank_VN_SaltOut3_1.port_dch_a) annotation (Line(
        points={{76,128},{76,112.98},{51.32,112.98}}, color={0,127,255}));
  connect(sensor_pT8.port, rH_cycle_drumOFH_salt_TCV2_1.HT_RH_in) annotation (
      Line(points={{220,106},{220,94},{228.933,94},{228.933,85.1765}}, color={0,
          127,255}));
  connect(sensor_pT9.port, rH_cycle_drumOFH_salt_TCV2_1.HT_SH_in) annotation (
      Line(points={{206,104},{208,104},{208,94},{210,94},{210,60.2353},{228,
          60.2353}}, color={0,127,255}));
  connect(sensor_pT10.port, rH_cycle_drumOFH_salt_TCV2_1.HT_RH_out) annotation (
     Line(points={{184,132},{184,69.1765},{228.467,69.1765}}, color={0,127,255}));
  connect(sensor_pT11.port, rH_cycle_drumOFH_salt_TCV2_1.HT_SH_out) annotation (
     Line(points={{170,130},{170,124},{176,124},{176,48.4706},{228,48.4706}},
        color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut3_1.port_dch_a, volume.port_b) annotation (Line(
        points={{51.32,112.98},{114,112.98},{114,114},{124,114}}, color={0,127,
          255}));
  connect(sensor_pT11.port, R_entry1.port_b) annotation (Line(points={{170,130},
          {170,124},{176,124},{176.2,49}}, color={0,127,255}));
  connect(R_entry1.port_a, volume.port_a) annotation (Line(points={{167.8,49},{
          162,49},{162,50},{158,50},{158,114},{136,114}}, color={0,127,255}));
  connect(volume.port_a, R_entry2.port_a) annotation (Line(points={{136,114},{
          158,114},{158,69},{161.8,69}}, color={0,127,255}));
  connect(R_entry2.port_b, rH_cycle_drumOFH_salt_TCV2_1.HT_RH_out) annotation (
      Line(points={{170.2,69},{199.334,69},{199.334,69.1765},{228.467,69.1765}},
        color={0,127,255}));
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
  connect(resistance1.port_a, sHS2Tank_VN_SaltOut_LT2_1.port_ch_a) annotation (
      Line(points={{-42,87.4},{-42,-16.22},{-25.32,-16.22}}, color={0,127,255}));
  connect(Charging_bypass.port_b, sHS2Tank_VN_SaltOut_LT2_1.port_ch_a)
    annotation (Line(points={{-54,75},{-48,75},{-48,76},{-42,76},{-42,-16.22},{
          -25.32,-16.22}}, color={0,127,255}));
  connect(sensor_pT12.port, sHS2Tank_VN_SaltOut_LT2_1.port_ch_a) annotation (
      Line(points={{-50,-50},{-50,-56},{-32,-56},{-32,-24},{-34,-24},{-34,
          -16.22},{-25.32,-16.22}}, color={0,127,255}));
  annotation (                    experiment(
      StopTime=10000,
      Tolerance=0.005,
      __Dymola_Algorithm="Esdirk34a"));
end HTGR_TES_RhC_7;
