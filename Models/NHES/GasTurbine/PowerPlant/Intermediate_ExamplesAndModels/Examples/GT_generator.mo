within NHES.GasTurbine.PowerPlant.Intermediate_ExamplesAndModels.Examples;
model GT_generator
  import NHES.GasTurbine;
  extends Modelica.Icons.Example;

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
    annotation (Placement(transformation(extent={{-14,-14},{14,14}})));
  Modelica.Fluid.Sources.MassFlowSource_T SourceFuel(
    use_m_flow_in=true,
    redeclare package Medium = NHES.Media.NaturalGas,
     m_flow=2,
    nPorts=1,
    T=303.15)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-24,40})));
  Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
    p=system.p_ambient,
    redeclare package Medium = NHES.Media.FlueGas,
    nPorts=1,
    use_p_in=true)      annotation (Placement(transformation(extent={{50,30},
            {30,50}},
                  rotation=0)));
  inner Modelica.Fluid.System
                           system(allowFlowReversal=false, T_ambient=
        288.15)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  Compressor.AirSourceW airSourceW(
    redeclare package Medium = NHES.Media.Air,
    use_in_thetaIGV=true,
    use_in_T=false,
    use_in_X=false,
    use_in_N=true)
    annotation (Placement(transformation(extent={{-70,14},{-50,-6}})));
  Modelica.Blocks.Sources.Ramp Nsignal(
    duration=0,
    startTime=10,
    height=-GTunit.N0/10*3*0,
    offset=GTunit.N0)
    annotation (Placement(transformation(extent={{-26,-30},{-46,-10}})));
  Modelica.Blocks.Sources.Ramp IGVangle(
    duration=0,
    offset=85,
    startTime=10,
    height=(55.9929545605466 - 85)*0)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  GasTurbine.PowerPlant.Blocks.FuelControlSystem fuelCtrl(K6=GTunit.w_noLoad
        /GTunit.w0_comb)
    annotation (Placement(transformation(extent={{-74,38},{-54,58}})));
  Modelica.Blocks.Math.Gain wf_actual(k=2.273076)
    annotation (Placement(transformation(extent={{-48,44},{-40,52}})));
  Modelica.Blocks.Sources.Ramp Fd(
    duration=0,
    offset=1,
    startTime=10,
    height=-0.1)
    annotation (Placement(transformation(extent={{-100,38},{-80,58}})));
  Modelica.Mechanics.Rotational.Components.Inertia Inertia(
    a(start=0),
    J=GTunit.J,
    phi(
      start=GTunit.phi_start,
      displayUnit="rad",
      fixed=true),
    w(start=GTunit.N0, fixed=true))
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.RealExpression pExh_out_cal(y=system.p_ambient*
        (1 + GTunit.w0_comb/GTunit.compressor.w0)/(1 +
        GTunit.combChamber.wf/GTunit.compressor.w))
    annotation (Placement(transformation(extent={{30,50},{50,70}})));
  GasTurbine.PowerPlant.ElectricGenerator electricGenerator(initOpt=
        GasTurbine.Utilities.OptionsInit.noInit)
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Sources.PrescribedLoad prescribedLoad
    annotation (Placement(transformation(extent={{84,-10},{104,10}})));
  Modelica.Blocks.Sources.Ramp loadSignal(
    duration=0,
    offset=35*1e6,
    startTime=10,
    height=(31.4704 - 35)*1e6) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,30})));
  Sensors.FrequencySensor frequencySensor annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={74,-18})));
  Modelica.Blocks.Math.Gain f_pu(k=1/(GTunit.Nrpm0*electricGenerator.Np/
        120)) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={74,-38})));
equation
  connect(SourceFuel.ports[1], GTunit.fuel_in) annotation (Line(points={{
          -14,40},{1.77636e-015,40},{1.77636e-015,9.8}}, color={0,127,255}));

  connect(Nsignal.y, airSourceW.in_N) annotation (Line(points={{-47,-20},
          {-56.6,-20},{-56.6,-3}}, color={0,0,127}));
  connect(IGVangle.y, airSourceW.in_thetaIGV) annotation (Line(points={{-79,
          -20},{-67.4,-20},{-67.4,-3}}, color={0,0,127}));
  connect(wf_actual.u,fuelCtrl. wf_pu)
    annotation (Line(points={{-48.8,48},{-52,48},{-55,48}},
                                                   color={0,0,127}));
  connect(Fd.y,fuelCtrl. VCE)
    annotation (Line(points={{-79,48},{-76,48},{-73,48}},
                                                 color={0,0,127}));
  connect(SinkExhaustGas.ports[1], GTunit.exhaust_out) annotation (Line(
        points={{30,40},{12.6,40},{12.6,4.2}}, color={0,127,255}));
  connect(GTunit.air_in, airSourceW.flange) annotation (Line(points={{
          -12.6,4.2},{-34,4.2},{-34,4},{-50,4}}, color={0,127,255}));
  connect(wf_actual.y, SourceFuel.m_flow_in)
    annotation (Line(points={{-39.6,48},{-34,48}}, color={0,0,127}));
  connect(pExh_out_cal.y, SinkExhaustGas.p_in) annotation (Line(points={{51,60},
          {60,60},{60,48},{52,48}},        color={0,0,127}));
  connect(Inertia.flange_a, GTunit.shaft)
    annotation (Line(points={{20,0},{18,0},{14,0}}, color={0,0,0}));
  connect(loadSignal.y, prescribedLoad.powerConsumption)
    annotation (Line(points={{99,30},{92,30},{92,3}}, color={0,0,127}));
  connect(electricGenerator.shaft, Inertia.flange_b)
    annotation (Line(points={{48,0},{48,0},{40,0}}, color={0,0,0}));
  connect(electricGenerator.powerGeneration, prescribedLoad.load)
    annotation (Line(points={{64,0},{64,0},{84,0}}, color={0,127,255}));
  connect(frequencySensor.elecPort, electricGenerator.powerGeneration)
    annotation (Line(points={{74,-10},{74,-10},{74,-6},{74,0},{64,0}},
        color={0,127,255}));
  connect(frequencySensor.f, f_pu.u)
    annotation (Line(points={{74,-26.16},{74,-33.2}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=50, Interval=0.1),
    __Dymola_experimentSetupOutput);
end GT_generator;
