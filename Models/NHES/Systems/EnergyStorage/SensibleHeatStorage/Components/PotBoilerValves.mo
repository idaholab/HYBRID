within NHES.Systems.EnergyStorage.SensibleHeatStorage.Components;
model PotBoilerValves
  PotBoiler Boiler(
    dPumpFDCV=32000,
    Level_ref=40,
    V_Boiler=4500,
    AxBoiler=90,
    P_Boiler(fixed=true),
    alphag_boiler(start=0.2),
    A_TCV=3)
    annotation (Placement(transformation(extent={{-16,-2},{4,18}})));
  Modelica.Blocks.Continuous.LimPID PIDFDCV(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=0.007*3600,
    Ti=3.5,
    yMin=0.0001,
    y_start=0.0001)
    annotation (Placement(transformation(extent={{18,38},{32,52}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{14,26},{22,34}})));
  Ksolver ksolver(
    Kvalve=12,
    Avalve=0.34,
    tau=0.7238,
    deadband=0,
    b=0) annotation (Placement(transformation(extent={{68,38},{82,54}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0001)
    annotation (Placement(transformation(extent={{42,40},{54,52}})));
  Modelica.Blocks.Continuous.LimPID PIDTCV(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=0.007*3600,
    Ti=3.5,
    yMin=0.0001,
    y_start=0.0001)
    annotation (Placement(transformation(extent={{14,-28},{28,-14}})));
  Modelica.Blocks.Sources.Constant const1(
                                         k=0)
    annotation (Placement(transformation(extent={{10,-40},{18,-32}})));
  Ksolver ksolver1(
    Kvalve=12,
    Avalve=0.34,
    tau=0.7238,
    deadband=0,
    b=0) annotation (Placement(transformation(extent={{64,-28},{78,-12}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0001)
    annotation (Placement(transformation(extent={{38,-26},{50,-14}})));
  Modelica.Blocks.Interfaces.RealInput Q_TES
    annotation (Placement(transformation(extent={{-122,-2},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput P_Boiler
    annotation (Placement(transformation(extent={{100,8},{120,28}})));
  Modelica.Blocks.Interfaces.RealOutput m_LPT
    annotation (Placement(transformation(extent={{100,-8},{120,12}})));
equation
  connect(const.y, PIDFDCV.u_m)
    annotation (Line(points={{22.4,30},{25,30},{25,36.6}}, color={0,0,127}));
  connect(PIDFDCV.y, firstOrder.u) annotation (Line(points={{32.7,45},{36.35,
          45},{36.35,46},{40.8,46}}, color={0,0,127}));
  connect(firstOrder.y, ksolver.Valve_Position) annotation (Line(points={{
          54.6,46},{60,46},{60,46.64},{66.46,46.64}}, color={0,0,127}));
  connect(const1.y, PIDTCV.u_m) annotation (Line(points={{18.4,-36},{21,-36},
          {21,-29.4}}, color={0,0,127}));
  connect(Boiler.TCVError, PIDTCV.u_s) annotation (Line(points={{5,14.4},{8,
          14.4},{8,-21},{12.6,-21}}, color={0,0,127}));
  connect(Boiler.FDCVError, PIDFDCV.u_s) annotation (Line(points={{5,10},{10,
          10},{10,45},{16.6,45}}, color={0,0,127}));
  connect(ksolver1.KACV, Boiler.K_TCV) annotation (Line(points={{78.91,-18.96},
          {84,-18.96},{84,-52},{-30,-52},{-30,5},{-17.6,5}}, color={0,0,127}));
  connect(ksolver.KACV, Boiler.KFDCV) annotation (Line(points={{82.91,47.04},
          {88,47.04},{88,58},{-30,58},{-30,13.8},{-17.6,13.8}}, color={0,0,
          127}));
  connect(PIDTCV.y, firstOrder1.u) annotation (Line(points={{28.7,-21},{32.35,
          -21},{32.35,-20},{36.8,-20}}, color={0,0,127}));
  connect(firstOrder1.y, ksolver1.Valve_Position) annotation (Line(points={{
          50.6,-20},{56,-20},{56,-19.36},{62.46,-19.36}}, color={0,0,127}));
  connect(Q_TES, Boiler.Q_TES) annotation (Line(points={{-111,9},{-17.6,9},{
          -17.6,9.2}}, color={0,0,127}));
  connect(Boiler.m_LPT, m_LPT)
    annotation (Line(points={{5,4},{10,4},{10,2},{110,2}}, color={0,0,127}));
  connect(Boiler.P_Boiler, P_Boiler) annotation (Line(points={{5,6.4},{12,6.4},
          {12,18},{110,18}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PotBoilerValves;
