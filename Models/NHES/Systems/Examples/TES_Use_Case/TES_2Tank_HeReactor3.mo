within NHES.Systems.Examples.TES_Use_Case;
model TES_2Tank_HeReactor3
  EnergyStorage.SHS_Two_Tank.Components.SHS2Tank_VNWorkingnew
    sHS2Tank_VNWorkingnew(
    redeclare package Storage_Medium =
        NHES.Media.SolarSalt.ConstPropLiquidSolarSalt_NoLimit,
    redeclare package Charging_Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    m_flow_min=0.1,
    Steam_Output_Temp=723.15,                               DHX(shell_av_b=true),
    volume(T_start=T_start),
    discharge_pump(T_start=T_start),
    charge_pump(T_start=T_start),
    data(
      hot_tank_init_temp=623.15,
      cold_tank_init_temp=623.15,
      disvalve_m_flow_nom=1000,
      chvalve_m_flow_nom=703),
    redeclare EnergyStorage.SHS_Two_Tank.ControlSystems.CS_TES_VN2
                         CS(
       PID3(yMin=0.01), trapezoid(
        amplitude=-300,
        width=750,
        period=2200,
        offset=550,
        startTime=1500),
      one1(k=500 + 273.15),
      PID2(yMin=0.01)),
    sensor_m_flow(p_start=3900000, T_start=T_start),
    CHX(T_start_shell_inlet=973.15, T_start_shell_outlet=973.15))
    annotation (Placement(transformation(extent={{-24,-28},{44,34}})));
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
      ramp1(offset=45, startTime=1000)),
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
    core(Pebble_Surface_Init=773.15, Pebble_Center_Init=973.15))
    annotation (Placement(transformation(extent={{-164,-32},{-94,26}})));

  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT1(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{78,-68},{98,-48}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{96,18},{116,38}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{252,-4},{232,16}})));
  BalanceOfPlant.Turbine.SteamTurbine_L2_OpenFeedHeat_VN              BOP1(
    redeclare BalanceOfPlant.Turbine.ControlSystems.CS_SteamTurbine_L2_OFWH_VN
      CS(data(Q_Nom=45e6)),
    redeclare replaceable BalanceOfPlant.Turbine.Data.Turbine_2 data(
      p_steam=10000000,
      p_in_nominal=10000000,
      V_tee=50,
      valve_TCV_mflow=150,
      valve_TCV_dp_nominal=100000,
      valve_TBV_mflow=4,
      valve_TBV_dp_nominal=2000000,
      InternalBypassValve_p_spring=6500000,
      InternalBypassValve_K(unit="1/(m.kg)"),
      InternalBypassValve_tau(unit="1/s"),
      HPT_T_in_nominal=673.15,
      HPT_nominal_mflow=55,
      LPT_nominal_mflow=50,
      MainFeedHeater_K_tube(unit="1/m4"),
      MainFeedHeater_K_shell(unit="1/m4"),
      BypassFeedHeater_K_tube(unit="1/m4"),
      BypassFeedHeater_K_shell(unit="1/m4")),
    port_a_nominal(
      m_flow=20,
      p=10000000,
      h=3.1e6),
    port_b_nominal(p=10200000, h=1e6),
    init(
      tee_p_start=800000,
      moisturesep_p_start=700000,
      FeedwaterMixVolume_p_start=100000,
      HPT_T_b_start=578.15,
      MainFeedHeater_p_start_shell=100000,
      MainFeedHeater_h_start_shell_inlet=2e6,
      MainFeedHeater_h_start_shell_outlet=1.8e6,
      MainFeedHeater_dp_init_shell=90000,
      MainFeedHeater_m_start_tube=67,
      MainFeedHeater_m_start_shell=67,
      BypassFeedHeater_h_start_tube_inlet=1.1e6,
      BypassFeedHeater_h_start_tube_outlet=1.2e6,
      BypassFeedHeater_m_start_tube=67,
      BypassFeedHeater_m_start_shell=4),
    deaerator(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      p_start=200000),
    Pump_Speed(yMax=100),
    LPT(use_NominalInlet=true))
    annotation (Placement(transformation(extent={{124,-26},{184,34}})));
equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 40;

  connect(hTGR_PebbleBed_Primary_Loop.port_a, sHS2Tank_VNWorkingnew.port_ch_b)
    annotation (Line(points={{-95.05,-12.57},{-34,-12.57},{-34,19.74},{-23.32,
          19.74}}, color={0,127,255}));
  connect(sHS2Tank_VNWorkingnew.port_ch_a, hTGR_PebbleBed_Primary_Loop.port_b)
    annotation (Line(points={{-23.32,-16.22},{-38,-16.22},{-38,11.21},{-95.05,
          11.21}}, color={0,127,255}));
  connect(sensor_pT2.port, sHS2Tank_VNWorkingnew.port_dch_b) annotation (Line(
        points={{106,18},{52,18},{52,-16.22},{44,-16.22}},
        color={0,127,255}));
  connect(sensor_pT1.port, sHS2Tank_VNWorkingnew.port_dch_a) annotation (Line(
        points={{88,-68},{88,-74},{108,-74},{108,-10},{54,-10},{54,20.98},{
          43.32,20.98}},                                              color={0,
          127,255}));
  connect(BOP1.port_a, sensor_pT2.port)
    annotation (Line(points={{124,16},{124,18},{106,18}}, color={0,127,255}));
  connect(BOP1.port_b, sHS2Tank_VNWorkingnew.port_dch_a) annotation (Line(
        points={{124,-8},{116,-8},{116,-10},{54,-10},{54,20.98},{43.32,20.98}},
        color={0,127,255}));
  connect(BOP1.portElec_b, sinkElec.port) annotation (Line(points={{184,4},{186,
          4},{186,6},{232,6}}, color={255,0,0}));
  annotation (                    experiment(StopTime=10000, __Dymola_Algorithm
        ="Esdirk34a"));
end TES_2Tank_HeReactor3;
