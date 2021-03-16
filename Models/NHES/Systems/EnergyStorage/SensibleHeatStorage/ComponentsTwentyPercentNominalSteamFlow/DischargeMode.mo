within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
model DischargeMode
  DischargeTube2_fullhookup
                 BoilerTubeSide(
    Q_TES(start=3.4),
    P_Boiler(fixed=false, start=200),
    TbarB(start=415),
    m_tes2(start=0.001),
    T_Boilerexit(start=394, fixed=true),
    Wnominal=1000,
    Wpeakdesign=200,
    dPumpFCV2=48000,
    A_FCV2=6,
    Ltube=55,
    ntubes=80000,
    KFCV2line=50)
    annotation (Placement(transformation(extent={{-18,-2},{2,18}})));
  PotBoilerValves Boiler
    annotation (Placement(transformation(extent={{38,-2},{58,18}})));
  Modelica.Blocks.Continuous.LimPID PIDFCV2(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=0.007*3600,
    Ti=3.5,
    yMin=0.0001,
    y_start=0.0001)
    annotation (Placement(transformation(extent={{20,46},{34,60}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{16,34},{24,42}})));
  Ksolver ksolver(
    Kvalve=12,
    Avalve=0.34,
    tau=0.7238,
    deadband=0,
    b=0) annotation (Placement(transformation(extent={{70,46},{84,62}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0001)
    annotation (Placement(transformation(extent={{44,48},{56,60}})));
  Modelica.Blocks.Interfaces.RealOutput T_CT
    annotation (Placement(transformation(extent={{100,14},{120,36}})));
  Modelica.Blocks.Interfaces.RealOutput m_tes2
    annotation (Placement(transformation(extent={{100,-8},{120,12}})));
  Modelica.Blocks.Interfaces.RealInput T_HT
    annotation (Placement(transformation(extent={{-126,34},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput H_CT
    annotation (Placement(transformation(extent={{-126,10},{-100,36}})));
  Modelica.Blocks.Interfaces.RealInput Demand
    annotation (Placement(transformation(extent={{-126,-32},{-100,-6}})));
  Electrical.Interfaces.ElectricalPowerPort_b portElec_b annotation (
      Placement(transformation(extent={{94,-74},{114,-54}}),
        iconTransformation(extent={{-168,-102},{-148,-82}})));
equation
  connect(BoilerTubeSide.Q_TES, Boiler.Q_TES) annotation (Line(points={{3,4.6},
          {26,4.6},{26,8.9},{36.9,8.9}}, color={0,0,127}));
  connect(Boiler.m_LPT, BoilerTubeSide.m_LPT) annotation (Line(points={{59,
          8.2},{62,8.2},{62,-6},{-24,-6},{-24,3.4},{-19.2,3.4}}, color={0,0,
          127}));
  connect(Boiler.P_Boiler, BoilerTubeSide.P_Boiler) annotation (Line(points={
          {59,9.8},{64,9.8},{64,-8},{-26,-8},{-26,5.6},{-19.2,5.6}}, color={0,
          0,127}));
  connect(const.y, PIDFCV2.u_m)
    annotation (Line(points={{24.4,38},{27,38},{27,44.6}}, color={0,0,127}));
  connect(PIDFCV2.y, firstOrder.u) annotation (Line(points={{34.7,53},{38.35,
          53},{38.35,54},{42.8,54}}, color={0,0,127}));
  connect(BoilerTubeSide.FCV2Error, PIDFCV2.u_s) annotation (Line(points={{3,
          7.4},{8,7.4},{8,53},{18.6,53}}, color={0,0,127}));
  connect(firstOrder.y, ksolver.Valve_Position) annotation (Line(points={{
          56.6,54},{62,54},{62,54.64},{68.46,54.64}}, color={0,0,127}));
  connect(ksolver.KACV, BoilerTubeSide.KFCV2) annotation (Line(points={{84.91,
          55.04},{88,55.04},{88,68},{-17.1,68},{-17.1,19.1}}, color={0,0,127}));
  connect(BoilerTubeSide.m_tes2, m_tes2) annotation (Line(points={{3,11},{12,
          11},{12,20},{88,20},{88,2},{110,2}}, color={0,0,127}));
  connect(BoilerTubeSide.T_CT, T_CT) annotation (Line(points={{3,14.4},{10,
          14.4},{10,25},{110,25}}, color={0,0,127}));
  connect(H_CT, BoilerTubeSide.H_CT) annotation (Line(points={{-113,23},{-98,
          23},{-98,8.4},{-19.2,8.4}}, color={0,0,127}));
  connect(T_HT, BoilerTubeSide.T_HT) annotation (Line(points={{-113,47},{-90,
          47},{-90,10.8},{-19.2,10.8}}, color={0,0,127}));
  connect(Demand, BoilerTubeSide.Relativedemand) annotation (Line(points={{
          -113,-19},{-94,-19},{-94,1},{-19.2,1}}, color={0,0,127}));
  connect(BoilerTubeSide.portElec_b, portElec_b) annotation (Line(points={{
          -23.8,-0.6},{-23.8,-64},{104,-64}}, color={255,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DischargeMode;
