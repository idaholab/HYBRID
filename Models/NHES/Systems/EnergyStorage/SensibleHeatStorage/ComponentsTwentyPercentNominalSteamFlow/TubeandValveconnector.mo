within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
model TubeandValveconnector
  IHXTubeSide2 iHXtubeside(
    m_tes(start=5),
    Q_IHX(start=100),
    T_IHXexit(start=495),
    T_setpoint=510,
    T_HT(start=510),
    Tube_height=44,
    ntubes=50000,
    A_FCV=6,
    dPump1=50000,
    KFCVline=50,
    Mfillgas_CT=5.73e4,
    Mfillgas_HT=5.73e4,
    H_HT(start=27.5),
    H_CT(start=27.5))
    annotation (Placement(transformation(extent={{-52,2},{-32,22}})));
  Modelica.Blocks.Continuous.LimPID PIDFCV(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    Ti=3.5,
    k=0.007*3600,
    y_start=0.0001,
    yMin=0.0001) annotation (Placement(transformation(extent={{-4,6},{16,26}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-14,-20},{-2,-8}})));
  Ksolver ksolver(
    Kvalve=12,
    Avalve=0.34,
    tau=0.7238,
    deadband=0,
    b=0) annotation (Placement(transformation(extent={{62,8},{78,26}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0001,
    T=1)
    annotation (Placement(transformation(extent={{32,8},{48,24}})));
  Modelica.Blocks.Interfaces.RealInput P_IHX
    annotation (Placement(transformation(extent={{-118,2},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Q_IHX
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealInput mbypass
    annotation (Placement(transformation(extent={{-118,20},{-100,38}})));
  Modelica.Blocks.Interfaces.RealOutput T_HT
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput H_CT
    annotation (Placement(transformation(extent={{100,78},{120,98}})));
  Modelica.Blocks.Interfaces.RealInput T_CT
    annotation (Placement(transformation(extent={{-118,48},{-100,66}})));
  Modelica.Blocks.Interfaces.RealInput m_tes2
    annotation (Placement(transformation(extent={{-118,74},{-100,92}})));
equation
  connect(const.y,PIDFCV. u_m) annotation (Line(points={{-1.4,-14},{6,-14},{6,
          4}},      color={0,0,127}));
  connect(iHXtubeside.FlowErr, PIDFCV.u_s) annotation (Line(points={{-31,14.6},
          {-17.5,14.6},{-17.5,16},{-6,16}}, color={0,0,127}));
  connect(PIDFCV.y, firstOrder.u)
    annotation (Line(points={{17,16},{30.4,16}}, color={0,0,127}));
  connect(firstOrder.y, ksolver.Valve_Position) annotation (Line(points={{
          48.8,16},{56,16},{56,17.72},{60.24,17.72}}, color={0,0,127}));
  connect(ksolver.KACV, iHXtubeside.KFCV) annotation (Line(points={{79.04,
          18.17},{82,18.17},{82,34},{-66,34},{-66,11},{-53.4,11}}, color={0,0,
          127}));
  connect(P_IHX, iHXtubeside.P_IHX) annotation (Line(points={{-109,11},{-80,
          11},{-80,6.1},{-53.3,6.1}}, color={0,0,127}));
  connect(iHXtubeside.Q_IHX, Q_IHX) annotation (Line(points={{-31,8.6},{-26,
          8.6},{-26,8},{-20,8},{-20,-30},{110,-30}}, color={0,0,127}));
  connect(mbypass, iHXtubeside.mbypass) annotation (Line(points={{-109,29},{
          -82,29},{-82,8.7},{-53.3,8.7}}, color={0,0,127}));
  connect(iHXtubeside.T_HT, T_HT) annotation (Line(points={{-31,17},{-16,17},
          {-16,60},{110,60}}, color={0,0,127}));
  connect(iHXtubeside.H_CT, H_CT) annotation (Line(points={{-31,11.6},{-28,
          11.6},{-28,88},{110,88}}, color={0,0,127}));
  connect(m_tes2, iHXtubeside.m_tes2) annotation (Line(points={{-109,83},{-70,
          83},{-70,20.2},{-53.4,20.2}}, color={0,0,127}));
  connect(T_CT, iHXtubeside.T_CT) annotation (Line(points={{-109,57},{-74,57},
          {-74,17.6},{-53.4,17.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TubeandValveconnector;
