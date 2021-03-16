within NHES.GasTurbine.PowerPlant.Intermediate_ExamplesAndModels.Examples;
model GT_fuelSystem_droopCtrl
  import NHES.GasTurbine;
  extends Modelica.Icons.Example;

  // Speed/load controller setting
  parameter Real droop(unit="1") = 4 "Droop setting in percent";
  parameter Real KD(unit="1") = 100/droop "Gain for load/speed controller";
  parameter SI.Time TG = 0.05 "Speed governor time constant";

  // Fuel system controller setting
  parameter SI.Time TV=0.04 "Valve positoner time constant";
  parameter SI.Time TF=0.26 "Fuel system time constant";
  parameter Real wf_pu_max( unit="1") = 1.5 "Upper limit on wf_pu";
  parameter Real wf_pu_min(unit="1") = (GTunit.w_min/GTunit.w0_comb-fuelCtrl.K6)/(1-fuelCtrl.K6)
    "Lower limit on wf_pu";

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
    redeclare package Medium = NHES.Media.NaturalGas,
     m_flow=2,
    nPorts=1,
    T=303.15)  annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={16,28})));
  Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
    p=system.p_ambient,
    redeclare package Medium = NHES.Media.FlueGas,
    nPorts=1,
    use_p_in=true)      annotation (Placement(transformation(extent={{52,14},{40,
            26}}, rotation=0)));
  inner Modelica.Fluid.System
                           system(allowFlowReversal=false, T_ambient=
        288.15)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));

  Compressor.AirSourceW airSourceW(
    redeclare package Medium = NHES.Media.Air,
    use_in_thetaIGV=true,
    use_in_T=false,
    use_in_X=false,
    use_in_N=true)
    annotation (Placement(transformation(extent={{-52,12},{-36,-4}})));
  Modelica.Blocks.Sources.Ramp Nsignal(
    duration=0,
    startTime=10,
    height=-GTunit.N0/10*3*0,
    offset=GTunit.N0)
    annotation (Placement(transformation(extent={{-16,-26},{-32,-10}})));
  Modelica.Blocks.Sources.Ramp IGVangle(
    duration=0,
    offset=85,
    startTime=10,
    height=(55.9929545605466 - 85)*0)
    annotation (Placement(transformation(extent={{-76,-26},{-60,-10}})));
  GasTurbine.PowerPlant.Blocks.FuelControlSystem fuelCtrl(
    K6=GTunit.w_noLoad/GTunit.w0_comb,
    TV=TV,
    TF=TF)
    annotation (Placement(transformation(extent={{-16,42},{2,60}})));
  Modelica.Blocks.Math.Gain wf_actual(k=2.273076)
    annotation (Placement(transformation(extent={{10,48},{16,54}})));
  Modelica.Blocks.Sources.Ramp Tc(
    duration=0,
    startTime=10,
    height=0,
    offset=10)
    annotation (Placement(transformation(extent={{-114,36},{-100,50}})));
  Modelica.Mechanics.Rotational.Components.Inertia Inertia(
    a(start=0),
    J=GTunit.J,
    phi(start=GTunit.phi_start, displayUnit="rad"),
    w(start=GTunit.N0, fixed=true))
    annotation (Placement(transformation(extent={{36,-8},{52,8}})));
  Modelica.Blocks.Sources.RealExpression pExh_out_cal(y=system.p_ambient*
        (1 + GTunit.w0_comb/GTunit.compressor.w0)/(1 +
        GTunit.combChamber.wf/GTunit.compressor.w))
    annotation (Placement(transformation(extent={{6,-8},{-6,8}},
        rotation=90,
        origin={60,46})));
  GasTurbine.PowerPlant.ElectricGenerator electricGenerator(initOpt=
        GasTurbine.Utilities.OptionsInit.noInit)
    annotation (Placement(transformation(extent={{54,-8},{70,8}})));
  Sources.PrescribedLoad elecLoad
    annotation (Placement(transformation(extent={{102,-10},{122,10}})));
  Modelica.Blocks.Sources.Ramp loadSignal(
    duration=0,
    offset=35*1e6,
    startTime=10,
    height=(31.5 - 35)*1e6)    annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={126,18})));
  Sensors.FrequencySensor frequencySensor annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=-90,
        origin={76,20})));
  Modelica.Blocks.Math.Gain f_pu(k=1/(GTunit.Nrpm0*electricGenerator.Np/
        120)) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={76,44})));
  GasTurbine.PowerPlant.Intermediate_ExamplesAndModels.Feedback_droopCtrl
    feedback
    annotation (Placement(transformation(extent={{68,68},{84,84}})));
  Modelica.Blocks.Sources.RealExpression VL_DSP(y=droop/100) "Load reference"
    annotation (Placement(transformation(extent={{100,68},{88,84}})));
  Modelica.Blocks.Sources.RealExpression fsp_pu(y=1) "Frequency set point (pu)"
    annotation (Placement(transformation(
        extent={{6,-8},{-6,8}},
        rotation=90,
        origin={76,94})));
  Modelica.Blocks.Continuous.FirstOrder speedLoadCtrl(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=1,
    k=KD,
    T=TG) annotation (Placement(transformation(extent={{0,68},{-16,84}})));

  Modelica.Blocks.Nonlinear.Limiter limiter(uMin=wf_pu_min, uMax=wf_pu_max)
    annotation (Placement(transformation(extent={{-60,40},{-44,56}})));
  GasTurbine.PowerPlant.Blocks.LowValueSelector_twoInputs LVS
    "Low value selector"
    annotation (Placement(transformation(extent={{-88,38},{-68,58}})));
  Modelica.Blocks.Math.Product prod annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-29,51})));

equation
  connect(SourceFuel.ports[1], GTunit.fuel_in) annotation (Line(points={{16,20},
          {16,20},{16,9.8}},                             color={0,127,255}));

  connect(Nsignal.y, airSourceW.in_N) annotation (Line(points={{-32.8,-18},{-41.28,
          -18},{-41.28,-1.6}},     color={0,0,127}));
  connect(IGVangle.y, airSourceW.in_thetaIGV) annotation (Line(points={{-59.2,-18},
          {-49.92,-18},{-49.92,-1.6}},  color={0,0,127}));
  connect(SinkExhaustGas.ports[1], GTunit.exhaust_out) annotation (Line(
        points={{40,20},{36,20},{28.6,20},{28.6,12},{28.6,8},{28.6,4.2}},
                                               color={0,127,255}));
  connect(GTunit.air_in, airSourceW.flange) annotation (Line(points={{3.4,4.2},{
          -8,4.2},{-8,4},{-36,4}},               color={0,127,255}));
  connect(Inertia.flange_a, GTunit.shaft)
    annotation (Line(points={{36,0},{36,0},{30,0}}, color={0,0,0}));
  connect(loadSignal.y, elecLoad.powerConsumption)
    annotation (Line(points={{117.2,18},{110,18},{110,3}}, color={0,0,127}));
  connect(electricGenerator.shaft, Inertia.flange_b)
    annotation (Line(points={{55.6,0},{55.6,0},{52,0}},
                                                    color={0,0,0}));
  connect(electricGenerator.powerGeneration, elecLoad.load)
    annotation (Line(points={{68.4,0},{68.4,0},{102,0}}, color={0,127,255}));
  connect(frequencySensor.elecPort, electricGenerator.powerGeneration)
    annotation (Line(points={{76,14},{76,14},{76,0},{68.4,0}},   color={0,
          127,255}));
  connect(frequencySensor.f, f_pu.u)
    annotation (Line(points={{76,26.12},{76,36},{76,39.2}},
                                                    color={0,0,127}));
  connect(feedback.u2, f_pu.y)
    annotation (Line(points={{76,69.6},{76,64},{76,48.4}}, color={0,0,127}));
  connect(fsp_pu.y, feedback.u3)
    annotation (Line(points={{76,87.4},{76,82.4}}, color={0,0,127}));
  connect(VL_DSP.y, feedback.u1)
    annotation (Line(points={{87.4,76},{87.4,76},{82.4,76}}, color={0,0,127}));
  connect(feedback.y, speedLoadCtrl.u)
    annotation (Line(points={{68.8,76},{68.8,76},{1.6,76}}, color={0,0,127}));
  connect(SinkExhaustGas.p_in, pExh_out_cal.y) annotation (Line(points={{53.2,24.8},
          {58,24.8},{60,24.8},{60,39.4}}, color={0,0,127}));
  connect(limiter.u, LVS.y)
    annotation (Line(points={{-61.6,48},{-69,48}}, color={0,0,127}));
  connect(speedLoadCtrl.y, LVS.Fd) annotation (Line(points={{-16.8,76},{-92,76},
          {-92,53},{-87,53}}, color={0,0,127}));
  connect(limiter.y, prod.u2)
    annotation (Line(points={{-43.2,48},{-40,48},{-35,48}}, color={0,0,127}));
  connect(fuelCtrl.wf_pu, wf_actual.u)
    annotation (Line(points={{1.1,51},{9.4,51}}, color={0,0,127}));
  connect(fuelCtrl.VCE, prod.y) annotation (Line(points={{-15.1,51},{-20,51},{-23.5,
          51}}, color={0,0,127}));
  connect(wf_actual.y, SourceFuel.m_flow_in)
    annotation (Line(points={{16.3,51},{22.4,51},{22.4,36}}, color={0,0,127}));
  connect(prod.u1, f_pu.y) annotation (Line(points={{-35,54},{-40,54},{-40,60},{
          76,60},{76,48.4}}, color={0,0,127}));
  connect(LVS.Tctrl, Tc.y) annotation (Line(points={{-87,43},{-92,43},{
          -92,43},{-99.3,43}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=50, Interval=0.1),
    __Dymola_experimentSetupOutput);
end GT_fuelSystem_droopCtrl;
