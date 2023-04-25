within NHES.Systems.Examples.TES_Use_Case;
model HTGR_TES_RhC_2
  EnergyStorage.SHS_Two_Tank.Components.SHS2Tank_VN_SaltOut
    sHS2Tank_VN_SaltOut(
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
    redeclare EnergyStorage.SHS_Two_Tank.ControlSystems.CS_TES_VN2
                         CS(
       PID3(yMin=0.01), trapezoid(
        amplitude=-50,
        width=2750,
        period=2200,
        offset=236,
        startTime=1500),
      one1(k=500 + 273.15),
      PID2(yMin=0.01)),
    sensor_m_flow(p_start=3900000, T_start=T_start),
    CHX(T_start_shell_inlet=973.15, T_start_shell_outlet=973.15),
    hot_tank(T_start=773.15))
    annotation (Placement(transformation(extent={{-26,-28},{42,34}})));
  parameter Modelica.Units.SI.Temperature T_start=350+273.15
    "Temperature";
  NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop_HeOut
    hTGR_PebbleBed_Primary_Loop(
    redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems.CS_VN CS(
      PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.00001,
        Ti=10,
        k_s=-1,
        k_m=-1,
        Ni=0.0001,
        xi_start=40),
      const7(k=40),
      ramp(startTime=1000),
      const4(k=0),
      ramp1(offset=45, startTime=1000),
      const6(k=2e7)),
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
      nPebble=150000,
      Pebble_Surface_Init=773.15,
      Pebble_Center_Init=973.15))
    annotation (Placement(transformation(extent={{-164,-32},{-94,26}})));

  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{44,30},{64,50}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{78,150},{98,170}})));
  BalanceOfPlant.Turbine.Reheat_cycle_drumOFH_connectors_salt3
    reheat_cycle_drumOFH_connectors_salt3_1(
    pump(m_flow_nominal=200),
    steam_Drum(p_start=21000000, alphag_start=0.8),
    CS(delay3(Ti=10)),
    DHX(
      NTU=3.5,
      T_start_shell_inlet=633.15,
      T_start_shell_outlet=623.15,
      dp_general=10000,
      m_start_shell=200),
    const1(k=1),
    valveLinear(dp_nominal=5000),
    DHX2(use_T_start_shell=false),
    DHX3(
      T_start_shell_inlet=1023.15,
      T_start_shell_outlet=773.15,
      Q_init=1,
      m_start_shell=100,
      Tube(medium(T(start=750, fixed=true), p(start=800000, fixed=true)))),
    steamTurbine1(use_T_nominal=false, d_nominal(displayUnit="kg/m3") = 2.05),
    DHX1(Q_init=5000000),
    deaerator(level_start=7, p_start=800000))
    annotation (Placement(transformation(extent={{156,130},{254,210}})));
  Modelica.Fluid.Sources.Boundary_pT boundary6(
    redeclare package Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    p=200000,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{36,156},{56,176}})));

  Modelica.Fluid.Sources.Boundary_pT boundary7(
    redeclare package Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    p=200000,
    T=673.15,
    nPorts=1) annotation (Placement(transformation(extent={{46,228},{66,248}})));

  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    p=200000,
    T=1013.15,
    nPorts=1) annotation (Placement(transformation(extent={{44,256},{64,276}})));

  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    p=200000,
    T=1013.15,
    nPorts=1) annotation (Placement(transformation(extent={{-34,172},{-14,192}})));

  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT3(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-48,72},{-28,92}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT4(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-68,-12},{-48,8}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
    redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    p=200000,
    T=973.15,
    nPorts=2) annotation (Placement(transformation(extent={{-104,188},{-124,208}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary4(
    redeclare package Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    use_m_flow_in=true,
    m_flow=35,
    T=743.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-110,140},{-130,160}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT5(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{-178,232},{-158,252}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT6(redeclare package
      Medium = NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit)
    annotation (Placement(transformation(extent={{-228,210},{-208,230}})));
  Modelica.Blocks.Sources.Constant const1(k=700 + 273)
    annotation (Placement(transformation(extent={{-130,246},{-116,260}})));
  TRANSFORM.Controls.LimPID Pump_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.08,
    Ti=10,
    yb=0.01,
    yMax=70,
    yMin=5,
    wp=0.8,
    Ni=0.1,
    xi_start=35,
    y_start=0.01)
    annotation (Placement(transformation(extent={{-96,234},{-82,248}})));
  EnergyStorage.SHS_Two_Tank.Components.SHS2Tank_VN_SaltOut
    sHS2Tank_VN_SaltOut1(
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
      one1(k=700 + 273.15),
      PID2(yMin=0.01)),
    sensor_m_flow(p_start=3900000, T_start=T_start),
    CHX(T_start_shell_inlet=973.15, T_start_shell_outlet=973.15),
    hot_tank(T_start=773.15))
    annotation (Placement(transformation(extent={{-254,132},{-186,194}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT7(redeclare package
      Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-304,144},{-284,164}})));
equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 40;

  connect(hTGR_PebbleBed_Primary_Loop.port_a, sHS2Tank_VN_SaltOut.port_ch_b)
    annotation (Line(points={{-95.05,-12.57},{-34,-12.57},{-34,19.74},{-25.32,
          19.74}}, color={0,127,255}));
  connect(sensor_pT2.port, sHS2Tank_VN_SaltOut.port_dch_b) annotation (Line(
        points={{88,150},{88,-16},{42,-16},{42,-16.22}}, color={0,127,255}));
  connect(sensor_pT1.port, sHS2Tank_VN_SaltOut.port_dch_a) annotation (Line(
        points={{54,30},{50,30},{50,20.98},{41.32,20.98}}, color={0,127,255}));
  connect(reheat_cycle_drumOFH_connectors_salt3_1.HT_SH_out, boundary6.ports[1])
    annotation (Line(points={{156,170.471},{62,170.471},{62,166},{56,166}},
        color={0,127,255}));
  connect(reheat_cycle_drumOFH_connectors_salt3_1.HT_RH_out, boundary7.ports[1])
    annotation (Line(points={{156.467,191.176},{72,191.176},{72,238},{66,238}},
        color={0,127,255}));
  connect(boundary1.ports[1], reheat_cycle_drumOFH_connectors_salt3_1.HT_RH_in)
    annotation (Line(points={{64,266},{148,266},{148,207.176},{156.933,207.176}},
        color={0,127,255}));
  connect(boundary3.ports[1], reheat_cycle_drumOFH_connectors_salt3_1.HT_SH_in)
    annotation (Line(points={{-14,182},{71,182},{71,182.235},{156,182.235}},
        color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut.port_dch_b,
    reheat_cycle_drumOFH_connectors_salt3_1.LT_in) annotation (Line(points={{42,
          -16.22},{50,-16.22},{50,-16},{88,-16},{88,150.235},{156.467,150.235}},
        color={0,127,255}));
  connect(reheat_cycle_drumOFH_connectors_salt3_1.LT_out, sHS2Tank_VN_SaltOut.port_dch_a)
    annotation (Line(points={{156.467,132.824},{156.467,134},{102,134},{102,
          20.98},{41.32,20.98}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut.port_ch_a, sensor_pT3.port) annotation (Line(
        points={{-25.32,-16.22},{-38,-16.22},{-38,72}}, color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, sensor_pT4.port) annotation (Line(
        points={{-95.05,-12.57},{-76.525,-12.57},{-76.525,-12},{-58,-12}},
        color={0,127,255}));
  connect(const1.y,Pump_Speed. u_s) annotation (Line(points={{-115.3,253},{-102,
          253},{-102,241},{-97.4,241}},
                                color={0,0,127}));
  connect(sensor_pT6.T,Pump_Speed. u_m) annotation (Line(points={{-212,217.8},{
          -89,217.8},{-89,232.6}},                  color={0,0,127}));
  connect(Pump_Speed.y,boundary4. m_flow_in) annotation (Line(points={{-81.3,
          241},{-76,241},{-76,158},{-110,158}},
                                         color={0,0,127}));
  connect(boundary4.ports[1], sHS2Tank_VN_SaltOut1.port_dch_a) annotation (Line(
        points={{-130,150},{-176,150},{-176,180.98},{-186.68,180.98}}, color={0,
          127,255}));
  connect(sHS2Tank_VN_SaltOut1.port_dch_b, boundary2.ports[1]) annotation (Line(
        points={{-186,143.78},{-172,143.78},{-172,180},{-124,180},{-124,197}},
        color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, sHS2Tank_VN_SaltOut1.port_ch_a)
    annotation (Line(points={{-95.05,11.21},{-96,11.21},{-96,46},{-294,46},{
          -294,143.78},{-253.32,143.78}}, color={0,127,255}));
  connect(sHS2Tank_VN_SaltOut1.port_ch_b, sHS2Tank_VN_SaltOut.port_ch_a)
    annotation (Line(points={{-253.32,179.74},{-282,179.74},{-282,64},{-38,64},
          {-38,-16.22},{-25.32,-16.22}}, color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, sensor_pT7.port) annotation (Line(
        points={{-95.05,11.21},{-96,11.21},{-96,46},{-294,46},{-294,144}},
        color={0,127,255}));
  connect(sensor_pT5.port, sHS2Tank_VN_SaltOut1.port_dch_a) annotation (Line(
        points={{-168,232},{-168,180.98},{-186.68,180.98}}, color={0,127,255}));
  connect(sensor_pT6.port, boundary2.ports[2]) annotation (Line(points={{-218,
          210},{-172,210},{-172,199},{-124,199}}, color={0,127,255}));
  annotation (                    experiment(
      StopTime=10000,
      Tolerance=0.005,
      __Dymola_Algorithm="Esdirk34a"));
end HTGR_TES_RhC_2;
