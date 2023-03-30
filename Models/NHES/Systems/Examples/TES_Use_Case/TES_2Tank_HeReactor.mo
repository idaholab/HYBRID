within NHES.Systems.Examples.TES_Use_Case;
model TES_2Tank_HeReactor
  EnergyStorage.SHS_Two_Tank.Components.SHS2Tank_VNWorkingnew
    sHS2Tank_VNWorkingnew(
    redeclare package Storage_Medium =
        NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt,
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
        amplitude=550,
        width=750,
        period=2200),
      one1(k=540 + 273.15),
      PID2(yMin=0.01)),
    sensor_m_flow(p_start=3900000, T_start=T_start),
    CHX(T_start_shell_inlet=973.15, T_start_shell_outlet=973.15))
    annotation (Placement(transformation(extent={{-24,-28},{44,34}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10000000,
    T=373.15,
    nPorts=1) annotation (Placement(transformation(extent={{112,16},{92,36}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=35,
    T=473.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{108,-32},{88,-12}})));
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
    annotation (Placement(transformation(extent={{68,-10},{88,10}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT2(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{66,26},{86,46}})));
equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 40;

  connect(boundary3.ports[1], sHS2Tank_VNWorkingnew.port_dch_a) annotation (
      Line(points={{88,-22},{54,-22},{54,20.98},{43.32,20.98}}, color={0,127,
          255}));
  connect(boundary2.ports[1], sHS2Tank_VNWorkingnew.port_dch_b) annotation (
      Line(points={{92,26},{58,26},{58,14},{52,14},{52,-16.22},{44,-16.22}},
        color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, sHS2Tank_VNWorkingnew.port_ch_b)
    annotation (Line(points={{-95.05,-12.57},{-34,-12.57},{-34,19.74},{-23.32,
          19.74}}, color={0,127,255}));
  connect(sHS2Tank_VNWorkingnew.port_ch_a, hTGR_PebbleBed_Primary_Loop.port_b)
    annotation (Line(points={{-23.32,-16.22},{-38,-16.22},{-38,11.21},{-95.05,
          11.21}}, color={0,127,255}));
  connect(sensor_pT2.port, sHS2Tank_VNWorkingnew.port_dch_b) annotation (Line(
        points={{76,26},{76,24},{58,24},{58,14},{52,14},{52,-16.22},{44,-16.22}},
        color={0,127,255}));
  connect(sensor_pT1.port, sHS2Tank_VNWorkingnew.port_dch_a) annotation (Line(
        points={{78,-10},{78,-12},{54,-12},{54,20.98},{43.32,20.98}}, color={0,
          127,255}));
  annotation (                    experiment(StopTime=10000, __Dymola_Algorithm
        ="Esdirk34a"));
end TES_2Tank_HeReactor;
