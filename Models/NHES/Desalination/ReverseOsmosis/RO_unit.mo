within NHES.Desalination.ReverseOsmosis;
model RO_unit
  extends NHES.Desalination.Icons.RO_unit;

  outer Modelica.Fluid.System system "System wide properties";
  replaceable package Medium =
      NHES.Desalination.Media.BrineProp.BrineDriesner
    constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model" annotation (choicesAllMatching=true);
   parameter Boolean allowFlowReversal = system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction (feedFlange -> retentateFlange & feedFlange -> permeateFlange)" annotation(Dialog(tab = "Assumptions"));
   parameter Integer NoVesselUnits_per_pump = 111
    "Number of RO vessel units per pump";

  Real SaltRejection "Salt rejection [%]";
  Real OverallRecoveryRatio "Overall recovery ratio [%]";
  Real RecoveryRatio_Stage1 "Recovery ratio for stage1 [%]";
  Real RecoveryRatio_Stage2 "Recovery ratio for stage2 [%]";
  NHES.Desalination.Types.solvent_flux_L_m2hr Jv_avg_L_m2hr(min = 0)
    "Average solvent flux [L/(m2.hr)]";
  NHES.Desalination.Types.solvent_flux_gfd Jv_avg_gfd(min = 0)
    "Average solvent flux [gal/(ft2.day)]";
  NHES.Desalination.Types.VolumeFlowRate_m3_hr Qp_total_m3_hr
    "Total volumetric permeate flow rate [m3/hr]";

  MembraneElements VesselsStage1(initOpt=Desalination.Utilities.Options.steadyState)
    annotation (Placement(transformation(extent={{-42,26},{-18,50}})));

  MembraneElements VesselsStage2(initOpt=Desalination.Utilities.Options.steadyState,
    Tf_start_K(displayUnit="degC") = 298.5436,
    Xif_NaCl_start=0.00671314,
    Xip_NaCl_start=0.000119863,
    wf_start=2.26915,
    Pf_start=1553150,
    Pr_start=1486890,
    Osmotic_Pstart_Pa=909321,
    Re_b_start=129.56,
    Tr_start_K=298.7475,
    Xir_NaCl_start=0.0123956,
    wr_start=1.21876,
    Lv_b_start=9.27769e-12)
    annotation (Placement(transformation(extent={{18,26},{42,50}})));
  Fluid.Pipes.parallelFlow nFlow_feed( nParallel=NoVesselUnits_per_pump,
      redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,40})));
  Fluid.Pipes.parallelFlow nFlow_retentate(
                                       nParallel=NoVesselUnits_per_pump,
      redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,40})));
  Modelica.Fluid.Fittings.TeeJunctionVolume flowJoin(
    use_T_start=true,
    V=1600,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    port_2(p(start=101325, fixed=true)),
    redeclare package Medium = Medium,
    p_start=101325,
    T_start=298.45) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-14,0})));

  Fluid.Pipes.parallelFlow nFlow_permeate(
                                       nParallel=NoVesselUnits_per_pump,
      redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-50})));
  Modelica.Fluid.Interfaces.FluidPort_a feedFlange(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-120,30},{-100,50}}),
        iconTransformation(extent={{-120,30},{-100,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b retentateFlange(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{100,30},{120,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b permeateFlange(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-120},{10,-100}}),
        iconTransformation(extent={{-10,-120},{10,-100}})));
equation
  SaltRejection = (1 - permeateFlange.Xi_outflow[1] / ((feedFlange.Xi_outflow[1]+retentateFlange.Xi_outflow[1])/2))*100;
  OverallRecoveryRatio = Qp_total_m3_hr / VesselsStage1.Qf * 100;
  RecoveryRatio_Stage1 = VesselsStage1.Qp / VesselsStage1.Qf * 100;
  RecoveryRatio_Stage2 = VesselsStage2.Qp / VesselsStage2.Qf * 100;
  assert(OverallRecoveryRatio >= 0 and OverallRecoveryRatio <= 100, "The RO model does not support flow reversal");
  assert(RecoveryRatio_Stage1 >= 0 and RecoveryRatio_Stage1 <= 100, "The RO model does not support flow reversal");
  assert(RecoveryRatio_Stage2 >= 0 and RecoveryRatio_Stage2 <= 100, "The RO model does not support flow reversal");

  Jv_avg_L_m2hr = (VesselsStage1.Jv_b + VesselsStage2.Jv_b)/2 * 1000*3600;
  Jv_avg_gfd = Jv_avg_L_m2hr*(0.3048^2)*24*0.264172;
  Qp_total_m3_hr = -flowJoin.port_2.m_flow*3600 / flowJoin.medium.d;

  connect(VesselsStage1.RetentateFlange, VesselsStage2.FeedFlange)
    annotation (Line(points={{-19.2,39.92},{19.2,39.92}}, color={0,127,255}));
  connect(nFlow_feed.port_b, VesselsStage1.FeedFlange) annotation (Line(points={{-60,40},
          {-40.8,40},{-40.8,39.92}},                                color={0,127,
          255}));
  connect(nFlow_retentate.port_b, VesselsStage2.RetentateFlange) annotation (
      Line(points={{60,40},{40.8,40},{40.8,39.92}},          color={0,127,255}));
  connect(VesselsStage1.PermeateFlange, flowJoin.port_1) annotation (Line(
        points={{-30,29.6},{-30,29.6},{-30,0},{-24,0}},       color={0,127,255}));
  connect(VesselsStage2.PermeateFlange, flowJoin.port_3) annotation (Line(
        points={{30,29.6},{30,20},{-14,20},{-14,10}},     color={0,127,255}));
  connect(flowJoin.port_2, nFlow_permeate.port_b)
    annotation (Line(points={{-4,0},{4.44089e-016,0},{4.44089e-016,-40}},
                                                        color={0,127,255}));
  connect(nFlow_feed.port_a, feedFlange)
    annotation (Line(points={{-80,40},{-110,40}}, color={0,127,255}));
  connect(nFlow_retentate.port_a, retentateFlange)
    annotation (Line(points={{80,40},{110,40}}, color={0,127,255}));
  connect(permeateFlange, nFlow_permeate.port_a)
    annotation (Line(points={{0,-110},{0,-60},{-6.66134e-016,-60}},
                                                         color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Text(
          extent={{-150,20},{150,-20}},
          lineColor={0,0,255},
          textString="%name",
          origin={0,111},
          rotation=0)}),                                         Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=100,
      Interval=0.1,
      Tolerance=1e-008,
      __Dymola_Algorithm="Esdirk45a"));
end RO_unit;
