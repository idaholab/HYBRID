within NHES.Systems.PrimaryHeatSystem.HTGR;
model Nuclear_loop_HTGR
  //Modelica.Units.SI.Power Q_Recup;
    package Medium = HTGR.BaseClasses.He_HighT;
    Modelica.Units.SI.Power Q_gen;
    Real cycle_eff;
  TRANSFORM.Fluid.Volumes.SimpleVolume Core_Outlet(
    redeclare package Medium = Medium,
    p_start=5920000,
    T_start=1123.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-96,-28})));
  GasTurbine.Turbine.Turbine      turbine(
    redeclare package Medium = Medium,
    pstart_out=1990000,
    Tstart_in=1123.15,
    Tstart_out=751.15,
    eta0=0.93,
    PR0=2.975,
    w0=296) annotation (Placement(transformation(extent={{-88,-30},{-24,16}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                     nTU_HX_SinglePhase(
    NTU=10,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    redeclare package Shell_medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    V_Tube=0.1,
    V_Shell=0.1,
    V_buffers=0.1,
    p_start_tube=1990000,
    h_start_tube_inlet=2307e3,
    h_start_tube_outlet=3600e3,
    p_start_shell=6040000,
    h_start_shell_inlet=3600e3,
    h_start_shell_outlet=2700e3,
    dp_init_tube=30000,
    dp_init_shell=40000,
    Q_init=-100000000,
    Cr_init=0.8,
    m_start_tube=296.1,
    m_start_shell=296.1)
    annotation (Placement(transformation(extent={{20,-4},{0,16}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={36,26})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Precooler(
    redeclare package Medium = Medium,
    p_start=5920000,
    T_start=1123.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={6,48})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary3(use_port=
        false, T=306.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-18,48})));
  GasTurbine.Compressor.Compressor      compressor(
    redeclare package Medium = Medium,
    pstart_in=1930000,
    Tstart_in=306.15,
    Tstart_out=396.15,
    eta0=0.91,
    PR0=1.77,
    w0=300) annotation (Placement(transformation(extent={{22,66},{66,98}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                       transportDelayPipe(
    redeclare package Medium = Medium,
    crossArea=1,
    length=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={66,48})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Intercooler(
    redeclare package Medium = Medium,
    p_start=3420000,
    T_start=308.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={66,-12})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary4(use_port=
        false, T=308.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={106,-12})));
  GasTurbine.Compressor.Compressor      compressor1(
    redeclare package Medium = Medium,
    pstart_in=1930000,
    Tstart_in=306.15,
    Tstart_out=396.15,
    eta0=0.91,
    PR0=1.77,
    w0=300) annotation (Placement(transformation(extent={{-32,23},{32,-23}},
        rotation=270,
        origin={82,-53})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                       transportDelayPipe1(
    redeclare package Medium = Medium,
    crossArea=1,
    length=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={24,-26})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
    springBallValve(
    redeclare package Medium = BaseClasses.He_HighT,
    p_spring=1930000,
    K=50000,
    opening_init=0.)
    annotation (Placement(transformation(extent={{-22,60},{-42,80}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
    redeclare package Medium = BaseClasses.He_HighT,
    p=1930000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-82,60},{-62,80}})));
  TRANSFORM.Fluid.Sensors.Temperature Core_Outlet_T(redeclare package Medium =
        BaseClasses.He_HighT) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-108,-66})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Inlet_T(redeclare package
      Medium = BaseClasses.He_HighT) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-8,-38})));

  Nuclear.CoreSubchannels.Regions_3_CHF_EPRI_with_hotchannel core(
    redeclare package Material_2 = TRANSFORM.Media.Solids.Helium,
    redeclare package Material_3 = TRANSFORM.Media.Solids.ZrNb_E125,
    Q_fission_input=600000000,
    alpha_fuel=-1e-6,
    alpha_coolant=-1e-6,
    p_b_start(displayUnit="Pa"),
    Q_nominal=600000000,
    SigmaF_start=26,
    T_start_1=data.T_avg + 400,
    T_start_2=data.T_avg + 130,
    T_start_3=data.T_avg + 30,
    p_a_start(displayUnit="Pa") = dataInitial.p_start_pressurizer,
    T_a_start(displayUnit="K") = data.T_cold,
    T_b_start(displayUnit="K") = data.T_hot,
    m_flow_a_start=data.m_flow,
    exposeState_a=false,
    exposeState_b=false,
    Ts_start(displayUnit="degC") = dataInitial.T_start_core_coolantSubchannel,
    ps_start=dataInitial.p_start_core_coolantSubchannel,
    Ts_start_1(displayUnit="K") = dataInitial.Ts_start_core_fuelModel_region_1,
    Ts_start_2(displayUnit="K") = dataInitial.Ts_start_core_fuelModel_region_2,
    Ts_start_3(displayUnit="K") = dataInitial.Ts_start_core_fuelModel_region_3,
    fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare record Data_DH =
        TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
    redeclare record Data_FP =
        TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
    redeclare package Material_1 = TRANSFORM.Media.Solids.UO2,
    rho_input=CR.y,
    redeclare package Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    SF_start_power={0.2,0.3,0.3,0.2},
    nParallel=data.nAssembly,
    redeclare model Geometry =
        TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
        (
        width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
        rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
            data.r_outer_fuelRod},
        length=data.length_core,
        nPins=data.nRodFuel_assembly,
        nPins_nonFuel=data.nRodNonFuel_assembly,
        angle=1.5707963267949),
    toggle_ReactivityFP=false,
    Q_shape={0.00921016,0.022452442,0.029926363,0.035801439,0.040191759,0.04361119,
        0.045088573,0.046395024,0.049471251,0.050548587,0.05122695,0.051676198,0.051725935,
        0.048691804,0.051083234,0.050675546,0.049468838,0.047862888,0.045913065,
        0.041222844,0.038816801,0.035268536,0.029550046,0.022746578,0.011373949},
    Fh=1.4,
    n_hot=25,
    Teffref_fuel=948.15,
    Teffref_coolant=923.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-46,-62})));

              SMR_Generic.Components.Data.Data_GenericModule_NuScale
                          data(
    Q_total=600000000,
    Q_total_el=60000000,
    T_hot=586.85,
    m_flow=637.1,
    nAssembly=37)
    annotation (Placement(transformation(extent={{-146,36},{-130,52}})));
  SMR_Generic.Components.Data.DataInitial_NS
                      dataInitial(
    p_start_core_coolantSubchannel(displayUnit="Pa") = {12903247.0,12898190.0,12893307.0,
      12888614.0},
    T_start_core_coolantSubchannel(displayUnit="K") = {540.2313,558.79364,576.1813,
      586.9483},
    h_start_STHX_tube={957542.44,1226821.5,1475077.8,1743775.2,2041209.8,2374421.2,
        2749133.0,2919464.0,2980839.5,3004198.5},
    T_start_STHX_shell(displayUnit="K") = {585.6959,583.2033,576.07135,560.9657,
      554.01654,547.5736,541.4915,535.5601,527.6039,516.3904},
    Ts_start_core_fuelModel_region_1=[735.3177,865.1219,884.5617,785.37634; 705.33734,
        814.50995,833.0326,753.8575; 620.802,676.6141,692.713,665.06805],
    Ts_start_core_fuelModel_region_2=[620.8022,676.6141,692.713,665.06805; 584.4808,
        623.8399,640.4899,629.82477; 547.5703,569.67633,586.9591,594.09796],
    Ts_start_core_fuelModel_region_3=[547.5703,569.67633,586.9591,594.09796; 543.7788,
        564.05676,581.3935,590.4041; 540.2313,558.79364,576.1813,586.9483],
    T_start_STHX_tubeWall(displayUnit="K") = [511.0002,523.26855,531.58636,537.2081,
      542.85175,548.7496,555.07025,573.4225,582.2541,585.3353; 516.3904,527.6039,
      535.5601,541.4915,547.5736,554.01654,560.9657,576.07135,583.2033,585.6959],
    p_start_pressurizer(displayUnit="Pa") = 12807852,
    p_start_pressurizer_tee(displayUnit="Pa") = 12807852,
    T_start_pressurizer_tee(displayUnit="K") = 586.90674)
    annotation (Placement(transformation(extent={{-92,36},{-72,56}})));

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-8,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-144,-40},{-124,-20}})));
  Modelica.Blocks.Sources.Constant const1(k=850 + 273.15)
    annotation (Placement(transformation(extent={{-182,-42},{-162,-22}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                     nTU_HX_SinglePhase1(
    NTU=1,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium = BaseClasses.He_HighT,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=3,
    V_Shell=3,
    V_buffers=1,
    p_start_tube=5920000,
    h_start_tube_inlet=3600e3,
    h_start_tube_outlet=2900e3,
    p_start_shell=1000000,
    h_start_shell_inlet=600e3,
    h_start_shell_outlet=1000e3,
    dp_init_tube=30000,
    dp_init_shell=40000,
    Q_init=-100000000,
    Cr_init=0.8,
    m_start_tube=296.1,
    m_start_shell=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-74,22})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=1,
    T=373.15,
    nPorts=1) annotation (Placement(transformation(extent={{-68,38},{-48,58}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=1500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-186,12},{-166,32}})));
equation
 // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
 Q_gen = turbine.Wt - compressor.Wc - compressor1.Wc;
 cycle_eff = Q_gen / core.Q_total.y;
  connect(Precooler.port_a, sensor_T.port_b) annotation (Line(points={{6,42},{4,
          42},{4,34},{20,34},{20,40},{36,40},{36,36}},
                                                color={0,127,255}));
  connect(Precooler.heatPort, boundary3.port)
    annotation (Line(points={{0,48},{-8,48}}, color={191,0,0}));
  connect(compressor.outlet,transportDelayPipe. port_a) annotation (Line(points={{57.2,
          94.8},{57.2,94},{66,94},{66,58}},                  color={0,127,255}));
  connect(Precooler.port_b, compressor.inlet) annotation (Line(points={{6,54},{
          6,94},{30.8,94},{30.8,94.8}}, color={0,127,255}));
  connect(Intercooler.heatPort, boundary4.port)
    annotation (Line(points={{72,-12},{96,-12}},       color={191,0,0}));
  connect(compressor1.outlet, transportDelayPipe1.port_a) annotation (Line(
        points={{63.6,-72.2},{24,-72.2},{24,-36}},                   color={0,
          127,255}));
  connect(Intercooler.port_b, compressor1.inlet) annotation (Line(points={{66,-18},
          {66,-33.8},{63.6,-33.8}},     color={0,127,255}));
  connect(springBallValve.port_b,boundary5. ports[1])
    annotation (Line(points={{-42,70},{-62,70}},          color={0,127,255}));
  connect(springBallValve.port_a, Precooler.port_b) annotation (Line(points={{
          -22,70},{-6,70},{-6,72},{6,72},{6,54}}, color={0,127,255}));
  connect(nTU_HX_SinglePhase.Shell_in, transportDelayPipe1.port_b) annotation (
      Line(points={{20,4},{24,4},{24,-16}},                   color={0,127,255}));
  connect(Core_Outlet_T.port, Core_Outlet.port_a) annotation (Line(points={{-108,
          -76},{-108,-80},{-94,-80},{-94,-42},{-96,-42},{-96,-34}},
                                               color={0,127,255}));
  connect(nTU_HX_SinglePhase.Shell_out, Core_Inlet_T.port_a) annotation (Line(
        points={{0,4},{-8,4},{-8,2},{-10,2},{-10,-28},{-8,-28}}, color={0,127,255}));
  connect(turbine.outlet, nTU_HX_SinglePhase.Tube_in) annotation (Line(points={{
          -36.8,11.4},{-36.8,20},{-6,20},{-6,10},{0,10}}, color={0,127,255}));
  connect(nTU_HX_SinglePhase.Tube_out, sensor_T.port_a)
    annotation (Line(points={{20,10},{36,10},{36,16}}, color={0,127,255}));
  connect(transportDelayPipe.port_b, Intercooler.port_a)
    annotation (Line(points={{66,38},{66,-6}}, color={0,127,255}));
  connect(Core_Inlet_T.port_b, core.port_a) annotation (Line(points={{-8,-48},{-8,
          -60},{-36,-60},{-36,-62}}, color={0,127,255}));
  connect(core.port_b, Core_Outlet.port_a) annotation (Line(points={{-56,-62},{-82,
          -62},{-82,-60},{-100,-60},{-100,-34},{-96,-34}}, color={0,127,255}));
  connect(const1.y, CR.u_s) annotation (Line(points={{-161,-32},{-154,-32},{
          -154,-30},{-146,-30}}, color={0,0,127}));
  connect(Core_Outlet_T.T, CR.u_m) annotation (Line(points={{-114,-66},{-134,
          -66},{-134,-42}}, color={0,0,127}));
  connect(nTU_HX_SinglePhase1.Shell_out, boundary1.ports[1])
    annotation (Line(points={{-84,24},{-84,22},{-166,22}}, color={0,127,255}));
  connect(boundary2.ports[1], nTU_HX_SinglePhase1.Shell_in) annotation (Line(
        points={{-48,48},{-34,48},{-34,24},{-64,24}}, color={0,127,255}));
  connect(Core_Outlet.port_b, nTU_HX_SinglePhase1.Tube_in) annotation (Line(
        points={{-96,-22},{-98,-22},{-98,-20},{-114,-20},{-114,16},{-84,16},{
          -84,18}}, color={0,127,255}));
  connect(nTU_HX_SinglePhase1.Tube_out, turbine.inlet) annotation (Line(points=
          {{-64,18},{-60,18},{-60,16},{-54,16},{-54,8},{-75.2,8},{-75.2,11.4}},
        color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=591,
      __Dymola_Algorithm="Esdirk45a"));
end Nuclear_loop_HTGR;
