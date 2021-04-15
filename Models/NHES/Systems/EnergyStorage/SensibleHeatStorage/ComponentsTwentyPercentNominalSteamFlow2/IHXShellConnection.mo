within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2;
model IHXShellConnection

  input Real port_a_h_outflow annotation(Dialog(group="Inputs"));
  input Real port_a_p annotation(Dialog(group="Inputs"));
  input Real port_b_p annotation(Dialog(group="Inputs"));

  TESTBVcontroller_fullhookup
                   TESErrorCalculator(TESSetpointfrac={0,0.1875,0.4375,0.6875},
      PeakSteamflowPercent=20,
    Nominal_Load=1000)
    annotation (Placement(transformation(extent={{-168,-16},{-148,4}})));
  Modelica.Blocks.Continuous.LimPID PIDTESTBV2(
    yMax=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ni=0.9,
    xi_start=0,
    yMin=0.00001,
    y_start=0.00001,
    Ti=0.0125/0.005,
    k=0.0125*5)
    annotation (Placement(transformation(extent={{-90,12},{-70,32}})));
  Modelica.Blocks.Continuous.LimPID PIDTESTBV3(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    Ti=0.0125/0.005,
    yMin=0.00001,
    y_start=0.00001,
    k=0.0125*5)
    annotation (Placement(transformation(extent={{-90,-48},{-70,-28}})));
  Modelica.Blocks.Continuous.LimPID PIDTESTBV4(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    Ti=0.0125/0.005,
    yMin=0.00001,
    y_start=0.00001,
    k=0.0125*5)
    annotation (Placement(transformation(extent={{-90,-104},{-70,-84}})));
  Modelica.Blocks.Continuous.LimPID PIDTESTBV1(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    Ti=0.0125/0.005,
    yMin=0.00001,
    y_start=0.00001,
    k=0.0125*5)
    annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
  Modelica.Blocks.Sources.Constant Dummy1(k=0)
    annotation (Placement(transformation(extent={{-100,52},{-92,60}})));
  Modelica.Blocks.Sources.Constant Dummy4(
                                         k=0)
    annotation (Placement(transformation(extent={{-102,-122},{-94,-114}})));
  Modelica.Blocks.Sources.Constant Dummy3(
                                         k=0)
    annotation (Placement(transformation(extent={{-102,-64},{-94,-56}})));
  Modelica.Blocks.Sources.Constant Dummy2(
                                         k=0)
    annotation (Placement(transformation(extent={{-102,-6},{-94,2}})));
  Ksolver KTESTBV4(
    tau=0.7238,
    deadband=0,
    b=0,
    Kvalve=4.8,
    Avalve=0.394)
    annotation (Placement(transformation(extent={{-20,-104},{0,-84}})));
  Ksolver KTESTBV3(
    tau=0.7238,
    deadband=0,
    b=0,
    Kvalve=4.8,
    Avalve=0.394)
    annotation (Placement(transformation(extent={{-18,-46},{2,-26}})));
  Ksolver KTESTBV2(
    tau=0.7238,
    deadband=0,
    b=0,
    Kvalve=4.8,
    Avalve=0.394)
    annotation (Placement(transformation(extent={{-20,16},{0,36}})));
  Ksolver KTESTBV1(
    tau=0.7238,
    deadband=0,
    b=0,
    Kvalve=4.8,
    Avalve=0.394)
    annotation (Placement(transformation(extent={{-22,72},{-2,92}})));
  IHXShell2 IHX(
    KTESTBVline=32.9,
    P_IHX_LB=950,
    Ahw=138.54,
    A_ACV=0.5,
    port_a_h_outflow=port_a_h_outflow,
    port_a_p=port_a_p,
    port_b_p=port_b_p,
    V_IHX=12500,
    P_IHX_UB=980,
    A_TESTBV1=0.9,
    A_TESTBV2=0.9,
    A_TESTBV3=0.9,
    A_TESTBV4=0.9)
    annotation (Placement(transformation(extent={{22,0},{54,32}})));
  Modelica.Blocks.Continuous.LimPID PIDPRV(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=0.05*3600,
    Ti=50,
    yMin=0.00001,
    y_start=0.00001)
    annotation (Placement(transformation(extent={{40,-86},{60,-66}})));
  Modelica.Blocks.Sources.Constant const1(
                                         k=0)
    annotation (Placement(transformation(extent={{28,-106},{40,-94}})));
  Ksolver ksolver1(
    tau=0.7238,
    deadband=0,
    b=0,
    Kvalve=10,
    Avalve=0.5)
    annotation (Placement(transformation(extent={{88,-86},{108,-66}})));
  Modelica.Blocks.Continuous.LimPID PIDACV(
    yMax=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=0.007*3600,
    Ti=3.5,
    yMin=0.00001,
    y_start=0.00001)
    annotation (Placement(transformation(extent={{132,42},{152,62}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{122,20},{134,32}})));
  Ksolver ksolver(
    Kvalve=12,
    Avalve=0.34,
    tau=0.7238,
    deadband=0,
    b=0) annotation (Placement(transformation(extent={{186,44},{206,64}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.00001)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.00001)
    annotation (Placement(transformation(extent={{-56,12},{-36,32}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.00001)
    annotation (Placement(transformation(extent={{-58,-46},{-38,-26}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder3(
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.00001)
    annotation (Placement(transformation(extent={{-58,-104},{-38,-84}})));
  Modelica.Blocks.Interfaces.RealInput Q_IHX
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput P_IHX
    annotation (Placement(transformation(extent={{102,-44},{122,-24}})));
  Modelica.Blocks.Interfaces.RealOutput mbypass
    annotation (Placement(transformation(extent={{102,-22},{122,-2}})));
  Modelica.Blocks.Interfaces.RealInput Reactor_Demand
    annotation (Placement(transformation(extent={{-140,74},{-100,114}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder4(
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.00001)
    annotation (Placement(transformation(extent={{162,46},{176,60}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder5(
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.00001)
    annotation (Placement(transformation(extent={{70,-80},{80,-70}})));
equation
  connect(TESErrorCalculator.FlowErr4, PIDTESTBV4.u_s) annotation (Line(
        points={{-147,-3.8},{-147,-94},{-92,-94}}, color={0,0,127}));
  connect(TESErrorCalculator.FlowErr3, PIDTESTBV3.u_s) annotation (Line(
        points={{-147,-1.6},{-119.5,-1.6},{-119.5,-38},{-92,-38}}, color={0,0,
          127}));
  connect(TESErrorCalculator.FlowErr2, PIDTESTBV2.u_s) annotation (Line(
        points={{-147,0.4},{-120.5,0.4},{-120.5,22},{-92,22}}, color={0,0,127}));
  connect(Dummy4.y, PIDTESTBV4.u_m) annotation (Line(points={{-93.6,-118},{
          -80,-118},{-80,-106}}, color={0,0,127}));
  connect(Dummy2.y, PIDTESTBV2.u_m) annotation (Line(points={{-93.6,-2},{-80,
          -2},{-80,10}}, color={0,0,127}));
  connect(Dummy3.y, PIDTESTBV3.u_m) annotation (Line(points={{-93.6,-60},{-80,
          -60},{-80,-50}}, color={0,0,127}));
  connect(Dummy1.y, PIDTESTBV1.u_m) annotation (Line(points={{-91.6,56},{-78,
          56},{-78,68}}, color={0,0,127}));
  connect(TESErrorCalculator.FlowErr1, PIDTESTBV1.u_s) annotation (Line(
        points={{-147,2.6},{-147,80},{-90,80}}, color={0,0,127}));
  connect(KTESTBV1.KACV, IHX.KTESTBV1) annotation (Line(points={{-0.7,83.3},{
          -0.7,82},{6,82},{6,24},{20.72,24},{20.72,23.68}},     color={0,0,
          127}));
  connect(KTESTBV2.KACV, IHX.KTESTBV2) annotation (Line(points={{1.3,27.3},{
          7.65,27.3},{7.65,26.24},{20.72,26.24}},     color={0,0,127}));
  connect(KTESTBV3.KACV, IHX.KTESTBV3) annotation (Line(points={{3.3,-34.7},{
          6,-34.7},{6,28.8},{20.72,28.8}},     color={0,0,127}));
  connect(KTESTBV4.KACV, IHX.KTESTBV4) annotation (Line(points={{1.3,-92.7},{
          6,-92.7},{6,30},{20.72,30},{20.72,31.04}},    color={0,0,127}));
  connect(IHX.m_tbv, TESErrorCalculator.m_TBV) annotation (Line(points={{56.24,
          20.16},{64,20.16},{64,136},{-188,136},{-188,-9.9},{-169.5,-9.9}},
                  color={0,0,127}));
  connect(const1.y, PIDPRV.u_m) annotation (Line(points={{40.6,-100},{50,-100},
          {50,-88}}, color={0,0,127}));
  connect(IHX.PRVError, PIDPRV.u_s) annotation (Line(points={{56.24,14.08},{
          64,14.08},{64,-58},{32,-58},{32,-76},{38,-76}}, color={0,0,127}));
  connect(ksolver1.KACV, IHX.KPRV) annotation (Line(points={{109.3,-74.7},{
          114,-74.7},{114,-126},{10,-126},{10,16},{20.4,16}},
                                                        color={0,0,127}));
  connect(const.y, PIDACV.u_m) annotation (Line(points={{134.6,26},{142,26},{
          142,40}}, color={0,0,127}));
  connect(IHX.ACVError, PIDACV.u_s) annotation (Line(points={{56.08,3.36},{
          96.65,3.36},{96.65,52},{130,52}}, color={0,0,127}));
  connect(ksolver.KACV, IHX.KACV) annotation (Line(points={{207.3,55.3},{208,
          55.3},{208,74},{14,74},{14,12},{20.24,12}},color={0,0,127}));
  connect(PIDTESTBV1.y, firstOrder.u)
    annotation (Line(points={{-67,80},{-62,80}}, color={0,0,127}));
  connect(PIDTESTBV2.y, firstOrder1.u)
    annotation (Line(points={{-69,22},{-58,22}}, color={0,0,127}));
  connect(PIDTESTBV3.y, firstOrder2.u) annotation (Line(points={{-69,-38},{
          -64,-38},{-64,-36},{-60,-36}}, color={0,0,127}));
  connect(PIDTESTBV4.y, firstOrder3.u) annotation (Line(points={{-69,-94},{
          -66,-94},{-66,-94},{-60,-94}}, color={0,0,127}));
  connect(firstOrder3.y, KTESTBV4.Valve_Position) annotation (Line(points={{
          -37,-94},{-30,-94},{-30,-93.2},{-22.2,-93.2}}, color={0,0,127}));
  connect(firstOrder2.y, KTESTBV3.Valve_Position) annotation (Line(points={{
          -37,-36},{-28,-36},{-28,-35.2},{-20.2,-35.2}}, color={0,0,127}));
  connect(firstOrder1.y, KTESTBV2.Valve_Position) annotation (Line(points={{-35,22},
          {-30,22},{-30,26.8},{-22.2,26.8}},         color={0,0,127}));
  connect(firstOrder.y, KTESTBV1.Valve_Position) annotation (Line(points={{-39,80},
          {-32,80},{-32,82.8},{-24.2,82.8}},         color={0,0,127}));
  connect(firstOrder.y, TESErrorCalculator.TESTBVPosition1) annotation (Line(
        points={{-39,80},{-32,80},{-32,130},{-186,130},{-186,-0.1},{-169.3,
          -0.1}}, color={0,0,127}));
  connect(firstOrder1.y, TESErrorCalculator.TESTBVPosition2) annotation (Line(
        points={{-35,22},{-32,22},{-32,132},{-186,132},{-186,-2.5},{-169.3,
          -2.5}}, color={0,0,127}));
  connect(firstOrder2.y, TESErrorCalculator.TESTBVPosition3) annotation (Line(
        points={{-37,-36},{-32,-36},{-32,134},{-186,134},{-186,-4.9},{-169.3,
          -4.9}}, color={0,0,127}));
  connect(firstOrder3.y, TESErrorCalculator.TESTBVPosition4) annotation (Line(
        points={{-37,-94},{-32,-94},{-32,138},{-190,138},{-190,-7.3},{-169.3,
          -7.3}}, color={0,0,127}));
  connect(firstOrder.y, IHX.TESTBVPosition1) annotation (Line(points={{-39,80},
          {-28,80},{-28,100},{23.28,100},{23.28,33.28}}, color={0,0,127}));
  connect(firstOrder1.y, IHX.TESTBVPosition2) annotation (Line(points={{-35,22},
          {-30,22},{-30,50},{26.16,50},{26.16,33.28}},     color={0,0,127}));
  connect(firstOrder2.y, IHX.TESTBVPosition3) annotation (Line(points={{-37,
          -36},{-30,-36},{-30,50},{29.36,50},{29.36,33.28}}, color={0,0,127}));
  connect(firstOrder3.y, IHX.TESTBVPosition4) annotation (Line(points={{-37,
          -94},{-30,-94},{-30,50},{32.56,50},{32.56,33.6}}, color={0,0,127}));
  connect(Q_IHX, IHX.Q_IHX) annotation (Line(points={{-120,-80},{-98,-80},{
          -98,-104},{-136,-104},{-136,8.16},{20.56,8.16}}, color={0,0,127}));
  connect(IHX.P_IHX, P_IHX) annotation (Line(points={{56.24,8.64},{56.24,8},{
          82,8},{82,-34},{112,-34}}, color={0,0,127}));
  connect(IHX.m_tbv, mbypass) annotation (Line(points={{56.24,20.16},{64,
          20.16},{64,-12},{112,-12}}, color={0,0,127}));
  connect(mbypass, mbypass)
    annotation (Line(points={{112,-12},{112,-12}}, color={0,0,127}));
  connect(Reactor_Demand, TESErrorCalculator.Demand) annotation (Line(points=
          {{-120,94},{-96,94},{-96,112},{-194,112},{-194,2.1},{-169.3,2.1}},
        color={0,0,127}));
  connect(PIDACV.y, firstOrder4.u) annotation (Line(points={{153,52},{156,52},
          {156,53},{160.6,53}}, color={0,0,127}));
  connect(firstOrder4.y, ksolver.Valve_Position) annotation (Line(points={{
          176.7,53},{179.35,53},{179.35,54.8},{183.8,54.8}}, color={0,0,127}));
  connect(PIDACV.y, IHX.ACVPosition) annotation (Line(points={{153,52},{154,
          52},{154,80},{35.44,80},{35.44,33.6}}, color={0,0,127}));
  connect(ksolver1.Valve_Position, firstOrder5.y) annotation (Line(points={{
          85.8,-75.2},{84,-75.2},{84,-75},{80.5,-75}}, color={0,0,127}));
  connect(PIDPRV.y, firstOrder5.u) annotation (Line(points={{61,-76},{66,-76},
          {66,-75},{69,-75}}, color={0,0,127}));
  connect(firstOrder5.y, IHX.PRVPosition) annotation (Line(points={{80.5,-75},
          {82,-75},{82,-90},{16,-90},{16,18.88},{20.72,18.88}}, color={0,0,
          127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IHXShellConnection;
