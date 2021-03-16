within NHES.HydrogenTurbine.PowerPlant.Examples;
model H2
  import GasTurbine =
         NHES.HydrogenTurbine;
  extends Modelica.Icons.Example;

  // Speed/load controller setting
  parameter Real KG(unit="1") = 30 "Gain for speed governor";
  parameter SI.Time TG = 1.5 "Speed governor time constant";

  // Rotor acceleration controller setting
  parameter SI.Time T_rotorAccel = 1/100
    "Rotor accelaration control time constant";
  parameter Real rotorAccel_max_pu(unit="1") = 1.2
    "Upper limit on the rotor acceleration integrator";
  parameter Real rotorAccel_min_pu(unit="1") = wf_pu_min
    "Lower limit on the rotor acceleration integrator";

  // Fuel system controller setting
  parameter SI.Time TV = 0.04 "Valve positoner time constant";
  parameter SI.Time TF = 0.26 "Fuel system time constant";
  parameter Real wf_pu_max( unit="1") = 1.5 "Upper limit on wf_pu";
  parameter Real wf_pu_min(unit="1") = (GTunit.w_min/GTunit.w0_comb-fuelCtrl.K6)/(1-fuelCtrl.K6)
    "Lower limit on wf_pu";

  // Air flow (by varying IGV angle) controller setting
  parameter SI.Time TW = 250/GTunit.Te0 "Air flow control time constant";
  parameter Real IGVangleRamp_max_pu(unit="1") = 0.016
    "Maximum change allowed in IGV angle";
  parameter Real IGVangleRamp_min_pu(unit="1") = -0.016
    "Minimum change allowed in IGV angle";
  parameter Real IGVangle_max_pu(unit="1") = 1 "Upper limit on IGV angle";
  parameter Real IGVangle_min_pu(unit="1") = 55.9929545605466/airSourceW.thetaIGV0
    "Lower limit on IGV angle";

  // Tf controller setting
  parameter SI.Time T_Tf = 60 "Tf control time constant";
  parameter Real Tr_max_pu(unit="1") = 1 + 0.01 "Rated Te upper limit";
  parameter Real Tr_min_pu(unit="1") = 0.958 + 0.01 "Rated Te lower limit";

  // Te controller setting
  parameter SI.Time T_Te = 3.3 "Te controller time constant";
  parameter SI.Time TI_Te = 250/GTunit.Te0 "Integration rate for Te control";
  parameter Real Te_max_pu(unit="1") = 1.1 "Upper limit on Te";
  parameter Real Te_min_pu(unit="1") = 0 "Lower limit on Te";

  GasTurbine.PowerPlant.GasTurbineUnit GTunit(
    V=0.125,
    pstart_comp_in=system.p_ambient,
    Tstart_comp_in=system.T_ambient,
    PR0=13,
    w0_comp=108.408,
    w0_turb=110.681076,
    Tstart_comp_out=640.036,
    Tstart_turb_out=787.62,
    Tstart_comb=1340.378)
    annotation (Placement(transformation(extent={{2,-14},{30,14}})));
  Modelica.Fluid.Sources.MassFlowSource_T SourceFuel(
    use_m_flow_in=true,
    redeclare package Medium = Media.Hydrogen,
     m_flow=2,
    nPorts=1,
    T=303.15)  annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=270,
        origin={16,60})));
  Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
    p=system.p_ambient,
    redeclare package Medium = Media.FlueGas,
    use_p_in=true,
    nPorts=1)           annotation (Placement(transformation(extent={{88,52},
            {72,68}},
                  rotation=0)));
  inner Modelica.Fluid.System
                           system(allowFlowReversal=false, T_ambient=
        288.15)
    annotation (Placement(transformation(extent={{100,-120},{120,-100}})));

  Compressor.AirSourceW airSourceW(
    redeclare package Medium = Media.Air,
    use_in_thetaIGV=true,
    use_in_T=false,
    use_in_X=false,
    use_in_N=true)
    annotation (Placement(transformation(extent={{-22,-4},{-6,12}})));
  GasTurbine.PowerPlant.Blocks.FuelControlSystem fuelCtrl(
    K6=GTunit.w_noLoad/GTunit.w0_comb,
    TV=TV,
    TF=TF)
    annotation (Placement(transformation(extent={{-28,72},{-10,90}})));
  Modelica.Blocks.Math.Gain wf(k=2.273076)
    annotation (Placement(transformation(extent={{-2,78},{4,84}})));
  Modelica.Mechanics.Rotational.Components.Inertia Inertia(
    a(start=0),
    J=GTunit.J,
    phi(start=GTunit.phi_start, displayUnit="rad"),
    w(start=GTunit.N0, fixed=true))
    annotation (Placement(transformation(extent={{54,-8},{70,8}})));
  Modelica.Blocks.Sources.RealExpression pExh_out_cal(y=system.p_ambient*
        (1 + GTunit.w0_comb/GTunit.compressor.w0)/(1 +
        GTunit.combChamber.wf/GTunit.compressor.w))
    annotation (Placement(transformation(extent={{-6,-8},{6,8}},
        rotation=0,
        origin={80,80})));
  GasTurbine.PowerPlant.ElectricGenerator electricGenerator(initOpt=
        GasTurbine.Utilities.OptionsInit.noInit)
    annotation (Placement(transformation(extent={{74,-8},{90,8}})));
  Sources.PrescribedLoad elecLoad
    annotation (Placement(transformation(extent={{120,-10},{140,10}})));
  Modelica.Blocks.Sources.Ramp loadSignal1(
    duration=0,
    offset=35*1e6,
    startTime=10,
    height=-3.5*1e6*5) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={146,56})));
  Sensors.FrequencySensor frequencySensor annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=-90,
        origin={96,22})));
  Modelica.Blocks.Math.Gain f_pu(k=1/(GTunit.Nrpm0*electricGenerator.Np/
        120), y(unit="1"))
              annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={96,56})));
  Modelica.Blocks.Math.Feedback FB_f
    annotation (Placement(transformation(extent={{104,96},{88,112}})));
  Modelica.Blocks.Sources.RealExpression f_pu_sp(y=1)
    "Frequency set point (pu)" annotation (Placement(transformation(
        extent={{6,-8},{-6,8}},
        rotation=0,
        origin={114,104})));

  Modelica.Blocks.Nonlinear.Limiter limiter_VCE(
    uMin=wf_pu_min,
    uMax=wf_pu_max,
    u(start=1))
    annotation (Placement(transformation(extent={{-76,70},{-60,86}})));
  GasTurbine.PowerPlant.Blocks.LowValueSelector_threeInputs LVS(LVS1(
        switch(u2(start=true))), LVS2(switch(u2(start=true))))
    "Low value selector"
    annotation (Placement(transformation(extent={{-106,68},{-86,88}})));
  Modelica.Blocks.Math.Product wf_pu_ctrl annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-45,81})));

  Modelica.Blocks.Continuous.PI speedLoadCtrl(
    T=TG,
    y_start=1,
    x_start=1/speedLoadCtrl.k,
    k=KG,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{0,96},{-16,112}})));
  Modelica.Blocks.Math.Feedback FB_Tf
    annotation (Placement(transformation(extent={{48,-92},{32,-108}})));
  Modelica.Blocks.Math.Gain Te_pu(k=1/GTunit.Te0, y(unit="1"))
                                                  annotation (Placement(
        transformation(
        extent={{4,4},{-4,-4}},
        rotation=90,
        origin={20,-44})));
  Modelica.Blocks.Math.Gain Tf_pu(k=1/GTunit.Tf0, y(unit="1"))
              annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={40,-44})));
  Modelica.Blocks.Sources.RealExpression Tf_pu_sp(y=1)
    "Frequency set point (pu)" annotation (Placement(transformation(
        extent={{6,-8},{-6,8}},
        rotation=0,
        origin={60,-100})));

  GasTurbine.PowerPlant.Blocks.TempTransducer tempTransducer(y_start=
        0.958)
    annotation (Placement(transformation(extent={{2,-78},{-18,-58}})));
  Modelica.Blocks.Math.Feedback FB_Te annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=-90,
        origin={-48,-68})));
  Modelica.Blocks.Math.Feedback FB_w annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-48,-20})));
  Modelica.Blocks.Sources.RealExpression Tr_offset(y=0.01)
    "Frequency set point (pu)" annotation (Placement(transformation(
        extent={{6,-8},{-6,8}},
        rotation=0,
        origin={-26,-20})));

  GasTurbine.PowerPlant.Blocks.LimI_antiWindup TfCtrl(
    T=T_Tf,
    y_max=Tr_max_pu,
    y_min=Tr_min_pu,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=tempTransducer.y_start + 0.01)
    annotation (Placement(transformation(extent={{0,-108},{-16,-92}})));
  GasTurbine.PowerPlant.Blocks.LimI_antiWindup wAirCtrl(
    T=TW,
    y_max=IGVangle_max_pu,
    y_min=IGVangle_min_pu,
    uRamp_max=IGVangleRamp_max_pu,
    uRamp_min=IGVangleRamp_min_pu,
    y_start=1,
    initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{-60,12},{-44,28}})));

  Modelica.Blocks.Math.Gain IGVangle(k=airSourceW.thetaIGV0, y(unit="deg"))
                                                     annotation (Placement(
        transformation(
        extent={{4,4},{-4,-4}},
        rotation=180,
        origin={-30,20})));
  GasTurbine.PowerPlant.Blocks.LimPI_antiWindup TeCtrl(
    T=T_Te,
    TI=TI_Te,
    y_max=Te_max_pu,
    y_min=Te_min_pu,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=1.1,
    add1(y(start=1.1)))
    annotation (Placement(transformation(extent={{-72,-56},{-88,-40}})));

  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={128,16})));
  Modelica.Blocks.Sources.Ramp loadSignal2(
    duration=0,
    offset=0,
    startTime=40,
    height=3.5*1e6*3.1)        annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={146,32})));
  Modelica.Blocks.Continuous.Derivative dNpu_dt(
    k=1,
    y_start=0,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start=dNpu_dt.y_start/dNpu_dt.k) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-20,44})));
  Modelica.Mechanics.Rotational.Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{34,8},{50,-8}})));
  Modelica.Blocks.Math.Gain N_pu(k=1/GTunit.N0, y(unit="1")) annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={48,34})));
  Sensors.PowerSensor elecLoadrSensor
    annotation (Placement(transformation(extent={{98,8},{114,-8}})));
  Modelica.Blocks.Sources.RealExpression RotorAccelLimit_pu(y=0.01)
    "Frequency set point (pu)" annotation (Placement(transformation(
        extent={{6,-8},{-6,8}},
        rotation=0,
        origin={-18,62})));
  GasTurbine.PowerPlant.Blocks.LimI_antiWindup rotorAccelCtrl(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0,
    y_max=rotorAccel_max_pu,
    y_min=rotorAccel_min_pu,
    T=T_rotorAccel)
    annotation (Placement(transformation(extent={{-64,40},{-80,56}})));
  Modelica.Blocks.Math.Add FB_rotorAccel(k2=-1) annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={-46,48})));

  Modelica.Fluid.Sensors.MassFlowRate mExhaust(redeclare package Medium =
        Media.FlueGas)
    annotation (Placement(transformation(extent={{52,52},{68,68}})));
  Modelica.Fluid.Sensors.MassFractions X_CO2(redeclare package Medium =
        Media.FlueGas,             substanceName="Carbondioxide")
    annotation (Placement(transformation(extent={{26,60},{42,76}})));
  Modelica.Fluid.Sensors.MassFlowRate mNatGas(redeclare package Medium =
        Media.Hydrogen)               annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=90,
        origin={16,32})));
  Modelica.Blocks.Math.Product mCO2(y(unit="kg/s")) annotation (Placement(
        transformation(
        extent={{5,-5},{-5,5}},
        rotation=-90,
        origin={57,87})));
equation

  connect(GTunit.air_in, airSourceW.flange) annotation (Line(points={{3.4,4.2},{
          -6,4.2},{-6,4}},                       color={0,127,255}));
  connect(electricGenerator.shaft, Inertia.flange_b)
    annotation (Line(points={{75.6,0},{75.6,0},{70,0}},
                                                    color={0,0,0}));
  connect(frequencySensor.elecPort, electricGenerator.powerGeneration)
    annotation (Line(points={{96,14},{96,14},{96,0},{88.4,0}},   color={0,
          127,255}));
  connect(frequencySensor.f, f_pu.u)
    annotation (Line(points={{96,30.16},{96,40},{96,51.2}},
                                                    color={0,0,127}));
  connect(FB_f.u2, f_pu.y)
    annotation (Line(points={{96,97.6},{96,82},{96,60.4}},   color={0,0,127}));
  connect(limiter_VCE.u, LVS.y)
    annotation (Line(points={{-77.6,78},{-87,78}}, color={0,0,127}));
  connect(limiter_VCE.y, wf_pu_ctrl.u2) annotation (Line(points={{-59.2,78},
          {-59.2,78},{-51,78}}, color={0,0,127}));
  connect(fuelCtrl.wf_pu, wf.u)
    annotation (Line(points={{-10.9,81},{-2.6,81}},
                                                 color={0,0,127}));
  connect(fuelCtrl.VCE, wf_pu_ctrl.y)
    annotation (Line(points={{-27.1,81},{-39.5,81}}, color={0,0,127}));
  connect(wf.y, SourceFuel.m_flow_in)
    annotation (Line(points={{4.3,81},{9.6,81},{9.6,68}},    color={0,0,127}));
  connect(FB_f.y, speedLoadCtrl.u)
    annotation (Line(points={{88.8,104},{88.8,104},{1.6,104}},
                                                  color={0,0,127}));
  connect(speedLoadCtrl.y, LVS.Fd) annotation (Line(points={{-16.8,104},{
          -110,104},{-110,83},{-105,83}},
                              color={0,0,127}));
  connect(GTunit.Tf, Tf_pu.u) annotation (Line(points={{26.08,-8.12},{26.08,-20},
          {26,-20},{40,-20},{40,-39.2}},
                               color={0,0,127}));
  connect(Tf_pu.y, FB_Tf.u2)
    annotation (Line(points={{40,-48.4},{40,-93.6}}, color={0,0,127}));
  connect(Tf_pu_sp.y, FB_Tf.u1) annotation (Line(points={{53.4,-100},{50,-100},{
          46.4,-100}},
                 color={0,0,127}));
  connect(GTunit.Te, Te_pu.u) annotation (Line(points={{19.92,-4.76},{19.92,-4.76},
          {19.92,-39.2},{20,-39.2}},
                                   color={0,0,127}));
  connect(Te_pu.y, tempTransducer.Te_pu) annotation (Line(points={{20,-48.4},
          {20,-48.4},{20,-68},{1,-68}},
                                   color={0,0,127}));
  connect(tempTransducer.Te_mes_pu, FB_Te.u2)
    annotation (Line(points={{-17,-68},{-17,-68},{-41.6,-68}},
                                                    color={0,0,127}));
  connect(Tr_offset.y, FB_w.u1)
    annotation (Line(points={{-32.6,-20},{-32.6,-20},{-41.6,-20}},
                                                       color={0,0,127}));
  connect(TfCtrl.y, FB_Te.u1) annotation (Line(points={{-16.8,-100},{-48,-100},
          {-48,-74.4}},
                   color={0,0,127}));
  connect(wAirCtrl.y, IGVangle.u) annotation (Line(points={{-43.2,20},{-43.2,20},
          {-34.8,20}},            color={0,0,127}));
  connect(IGVangle.y, airSourceW.in_thetaIGV) annotation (Line(points={{-25.6,20},
          {-19.92,20},{-19.92,9.6}},   color={0,0,127}));
  connect(FB_Te.y, FB_w.u2) annotation (Line(points={{-48,-60.8},{-48,-60.8},
          {-48,-26.4}},
                   color={0,0,127}));
  connect(wAirCtrl.u, FB_w.y) annotation (Line(points={{-61.6,20},{-70,20},
          {-70,-20},{-55.2,-20}},
                             color={0,0,127}));
  connect(TeCtrl.u, FB_Te.y) annotation (Line(points={{-70.4,-48},{-48,-48},
          {-48,-60.8}},      color={0,0,127}));
  connect(elecLoad.powerConsumption, add.y)
    annotation (Line(points={{128,3},{128,9.4}}, color={0,0,127}));
  connect(loadSignal1.y, add.u2) annotation (Line(points={{137.2,56},{124.4,
          56},{124.4,23.2}}, color={0,0,127}));
  connect(loadSignal2.y, add.u1) annotation (Line(points={{137.2,32},{131.6,32},
          {131.6,23.2}},           color={0,0,127}));
  connect(f_pu_sp.y, FB_f.u1)
    annotation (Line(points={{107.4,104},{102.4,104}}, color={0,0,127}));
  connect(Inertia.flange_a, multiSensor.flange_b)
    annotation (Line(points={{54,0},{54,0},{50,0}}, color={0,0,0}));
  connect(multiSensor.flange_a, GTunit.shaft)
    annotation (Line(points={{34,0},{34,0},{30,0}}, color={0,0,0}));
  connect(multiSensor.w, N_pu.u) annotation (Line(points={{46.8,8.8},{46.8,
          20},{48,20},{48,29.2}},
                             color={0,0,127}));
  connect(airSourceW.in_N, N_pu.u) annotation (Line(points={{-11.28,9.6},{
          -11.28,20},{48,20},{48,29.2}},
                                  color={0,0,127}));
  connect(FB_Tf.y, TfCtrl.u)
    annotation (Line(points={{32.8,-100},{1.6,-100}}, color={0,0,127}));
  connect(electricGenerator.powerGeneration,elecLoadrSensor. port_a)
    annotation (Line(points={{88.4,0},{88.4,0},{98,0}}, color={0,127,255}));
  connect(elecLoadrSensor.port_b, elecLoad.load) annotation (Line(points={{114,
          0.16},{117,0.16},{117,0},{120,0}}, color={0,127,255}));
  connect(dNpu_dt.u, wf_pu_ctrl.u1) annotation (Line(points={{-10.4,44},{6,
          44},{48,44},{48,92},{-54,92},{-54,84},{-51,84}}, color={0,0,127}));
  connect(dNpu_dt.y, FB_rotorAccel.u2) annotation (Line(points={{-28.8,44},
          {-38.8,44},{-38.8,44.4}}, color={0,0,127}));
  connect(TeCtrl.y, LVS.Tctrl) annotation (Line(points={{-88.8,-48},{-110,
          -48},{-110,73},{-105,73}},
                               color={0,0,127}));
  connect(rotorAccelCtrl.y, LVS.rotorAccelCtrl)
    annotation (Line(points={{-80.8,48},{-96,48},{-96,69}}, color={0,0,127}));
  connect(RotorAccelLimit_pu.y, FB_rotorAccel.u1) annotation (Line(points=
         {{-24.6,62},{-32,62},{-32,51.6},{-38.8,51.6}}, color={0,0,127}));
  connect(rotorAccelCtrl.u, FB_rotorAccel.y)
    annotation (Line(points={{-62.4,48},{-52.6,48}}, color={0,0,127}));
  connect(pExh_out_cal.y, SinkExhaustGas.p_in) annotation (Line(points={{86.6,
          80},{92,80},{92,66.4},{89.6,66.4}}, color={0,0,127}));
  connect(N_pu.y, wf_pu_ctrl.u1) annotation (Line(points={{48,38.4},{48,92},
          {-54,92},{-54,84},{-51,84}}, color={0,0,127}));
  connect(SourceFuel.ports[1], mNatGas.port_a)
    annotation (Line(points={{16,52},{16,40}}, color={0,127,255}));
  connect(mNatGas.port_b, GTunit.fuel_in)
    annotation (Line(points={{16,24},{16,9.8}}, color={0,127,255}));
  connect(GTunit.exhaust_out, mExhaust.port_a) annotation (Line(points={{28.6,
          4.2},{28.6,60},{52,60}}, color={0,127,255}));
  connect(mExhaust.port_b, SinkExhaustGas.ports[1])
    annotation (Line(points={{68,60},{72,60}}, color={0,127,255}));
  connect(GTunit.exhaust_out, X_CO2.port) annotation (Line(points={{28.6,4.2},
          {28.6,60},{34,60}}, color={0,127,255}));
  connect(mExhaust.m_flow, mCO2.u1)
    annotation (Line(points={{60,68.8},{60,81}}, color={0,0,127}));
  connect(X_CO2.Xi, mCO2.u2) annotation (Line(points={{42.8,68},{54,68},{54,
          81}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -120},{120,120}})),
    experiment(StopTime=80, Interval=0.1),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-120,-120},{120,120}})));
end H2;
