within NHES.Electrolysis.Electrolyzers;
model ControlledSOEC_integratedWithHTSEplant_FY17
  "SOEC with its regulatory control scheme"
  import      Modelica.Units.SI;
  import NHES.Electrolysis;
  import NHES;
  extends Electrolysis.Icons.Electrolyzer;

  parameter Integer numCells_perVessel
    "Total number of cells per vessel";
  parameter Integer numVessels=1 "Number of online vessels per system";

  parameter Electrolysis.Utilities.OptionsInit.Temp initOpt = Electrolysis.Utilities.OptionsInit.noInit
    "Initialization option for a SOEC stack" annotation (Dialog(tab="Initialization", group="SOEC stack"));
  parameter Modelica.Blocks.Types.Init initType_cathodeFCV=Modelica.Blocks.Types.Init.NoInit
    "Initialization option for SUfactor control (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation (Dialog(tab="Initialization", group="Cathode stream"));
  parameter Modelica.Blocks.Types.Init initType_anodeFCV=Modelica.Blocks.Types.Init.NoInit
    "Initialization option for TC_out control (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation (Dialog(tab="Initialization", group="Anode stream"));
  parameter Modelica.Blocks.Types.Init initType_cathodePCV=Modelica.Blocks.Types.Init.NoInit
    "Initialization option for pCathode control (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(tab="Initialization", group="Cathode stream"));
  parameter Modelica.Blocks.Types.Init initType_anodePCV=Modelica.Blocks.Types.Init.NoInit
    "Initialization option for pAnode control (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(tab="Initialization", group="Anode stream"));

  parameter Real cathodeFCV_valveOpening_start(unit="1") = 0.8
    "Initial or guess value of the flow control valve opening" annotation (Dialog(tab="Initialization", group="Cathode stream"));
  parameter Real anodeFCV_valveOpening_start(unit="1") = 0.3
    "Initial or guess value of the flow control valve opening" annotation (Dialog(tab="Initialization", group="Anode stream"));
  parameter Real cathodePCV_valveOpening_start(unit="1") = 0.4
    "Initial or guess value of the pressure control valve opening" annotation (Dialog(tab="Initialization", group="Cathode stream"));
  parameter Real anodePCV_valveOpening_start(unit="1") = 0.25
    "Initial or guess value of the pressure control valve opening" annotation (Dialog(tab="Initialization", group="Anode stream"));

  parameter Real wCathode_in_start = 4.540415
    "Initial or guess value of state for wCathode_in" annotation (Dialog(tab="Initialization", group="Cathode stream"));
  parameter Real wCathode_out_start = 1.35415
    "Initial or guess value of state for wCathode_out" annotation (Dialog(tab="Initialization", group="Cathode stream"));
  parameter Real wAnode_in_start = 23.27855
    "Initial or guess value of state for wAnode_in" annotation (Dialog(tab="Initialization", group="Anode stream"));
  final parameter Real wAnode_out_start = wCathode_in_start + wAnode_in_start - wCathode_out_start
    "Initial or guess value of state for wAnode_out";

  parameter Real FBctrl_SUfactor_k(unit="1") = 0.00423 "Gain"  annotation (Dialog(tab="General", group="SU factor controller"));
  parameter SI.Time FBctrl_SUfactor_T(start=1) = 1.168021981 "Time constant"  annotation (Dialog(tab="General", group="SU factor controller"));
  parameter Real FBctrl_TC_out_k(unit="1") = (1/36.8)*4 "Gain"  annotation (Dialog(tab="General", group="TC_out controller"));
  parameter SI.Time FBctrl_TC_out_T(start=1) = 228 "Time constant"  annotation (Dialog(tab="General", group="TC_out controller"));
  parameter Real FBctrl_pCathode_k(unit="1") = (1/277000)*5 "Gain" annotation (Dialog(tab="General", group="pCathode controller"));
  parameter SI.Time FBctrl_pCathode_T(start=1) = 2.028030065 "Time constant"  annotation (Dialog(tab="General", group="pCathode controller"));
  parameter Real FBctrl_pAnode_k(unit="1") = 0.000010539629 "Gain" annotation (Dialog(tab="General", group="pAnode controller"));
  parameter SI.Time FBctrl_pAnode_T(start=1) = 3.44 "Time constant"  annotation (Dialog(tab="General", group="pAnode controller"));

  Modelica.Blocks.Nonlinear.Limiter limiter_wCathode_in(
    uMin=0.05,
    u(start=cathodeFCV_valveOpening_start),
    uMax=1)                                    annotation (Placement(transformation(extent={{-22,68},
            {-6,84}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_wAnode_in(
    u(start=anodeFCV_valveOpening_start),
    uMax=1,
    uMin=0.05)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-40,-80})));
  NHES.Electrolysis.Electrolyzers.BaseClasses.SOEC
                                              SOECstack(
    numVessels=numVessels,
    numCells_perVessel=numCells_perVessel,
    initOpt=initOpt,
    TCin(start=SOECstack.TCstartIn_K),
    wstartCathodeIn=wCathode_in_start/numVessels,
    wstartCathodeOut=wCathode_out_start/numVessels,
    wstartAnodeIn=wAnode_in_start/numVessels)
    annotation (Placement(transformation(extent={{-24,2},{-2,24}})));

  Electrolysis.Sensors.TempSensorWithThermowell TCoutSensor(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=750 + 273.15,
    tau=13) annotation (Placement(transformation(extent={{2,12},{18,-4}})));

  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas, allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-70,6},{-50,26}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowOut(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas, allowFlowReversal=false)
    annotation (Placement(transformation(extent={{30,8},{50,28}})));
  Modelica.Blocks.Sources.Ramp TCout_set(
    duration=0,
    height=0,
    startTime=0,
    offset=750 + 273.15,
    y(displayUnit="degC", unit="K"))
                 annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={12,-40})));
  Modelica.Fluid.Interfaces.FluidPort_a ctrlCathodeIn(redeclare package Medium =
               Electrolysis.Media.Electrolysis.CathodeGas) annotation (
      Placement(transformation(extent={{-110,50},{-90,70}}),
        iconTransformation(extent={{-84,20},{-64,40}})));
  Modelica.Blocks.Interfaces.RealOutput c_wCathode annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,60})));
  Modelica.Blocks.Interfaces.RealOutput c_wAnodeIn annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-28,-74})));
  Modelica.Blocks.Interfaces.RealOutput c_pCathode annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={64,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,60})));
  Modelica.Fluid.Interfaces.FluidPort_b ctrlAnodeOut(redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air, p(start=SOECstack.pstartAnodeAvg)) annotation (Placement(
        transformation(extent={{90,-70},{110,-50}}), iconTransformation(
          extent={{64,-44},{84,-24}})));
  Modelica.Fluid.Interfaces.FluidPort_b ctrlCathodeOut(redeclare package Medium =
               Electrolysis.Media.Electrolysis.CathodeGas) annotation (
      Placement(transformation(extent={{90,50},{110,70}}), iconTransformation(
          extent={{64,40},{84,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a ctrlAnodeIn(redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air) annotation (Placement(
        transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(
          extent={{-84,-64},{-64,-44}})));

  NHES.Electrolysis.Interfaces.ElectricalPowerPort_a ctrlElectricalLoad
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-86,-20},{-66,0}})));

  NHES.Electrolysis.Controllers.FFcontroller_SU FFctrl_SU(initialOutput=
        0.908085*5)
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  Modelica.Blocks.Sources.Constant yH2in_set(k=0.1)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=-90,
        origin={20,32})));
  Modelica.Blocks.Sources.Constant SUfactor_set(k=80)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=90,
        origin={20,88})));
  Modelica.Blocks.Continuous.PI FBctrl_SUfactor(
    initType=initType_cathodeFCV,
    k=FBctrl_SUfactor_k,
    T=FBctrl_SUfactor_T,
    x_start=cathodeFCV_valveOpening_start/FBctrl_SUfactor.k,
    y_start=cathodeFCV_valveOpening_start)
    annotation (Placement(transformation(extent={{-48,68},{-32,84}})));
  Modelica.Blocks.Math.Feedback feedback_wC_in annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=-90,
        origin={-60,60})));
  Modelica.Blocks.Math.Feedback feedback_TC_out annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-14,-40})));
  Modelica.Blocks.Continuous.PI FBctrl_TC_out(
    initType=initType_anodeFCV,
    y_start=anodeFCV_valveOpening_start,
    x_start=anodeFCV_valveOpening_start/FBctrl_TC_out.k,
    k=FBctrl_TC_out_k,
    T=FBctrl_TC_out_T,
    x(start=FBctrl_TC_out.x_start))
    annotation (Placement(transformation(extent={{-32,-48},{-48,-32}})));

  Modelica.Fluid.Sensors.Pressure pCathode(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={64,40})));
  Modelica.Blocks.Interfaces.RealOutput c_pAnode annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={12,-74})));
  Modelica.Fluid.Sensors.Pressure pAnode(redeclare package Medium =
        Electrolysis.Media.Electrolysis.AnodeGas_air) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,-30})));
  Modelica.Blocks.Continuous.LimPID FBctrl_pCathode(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.05,
    yMax=1,
    k=FBctrl_pCathode_k,
    Ti=FBctrl_pCathode_T,
    y(start=cathodePCV_valveOpening_start),
    xi_start=cathodePCV_valveOpening_start/FBctrl_pCathode.k,
    gainPID(y(start=cathodePCV_valveOpening_start)),
    y_start=cathodePCV_valveOpening_start,
    initType=initType_cathodePCV)   annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={64,84})));
  Modelica.Blocks.Sources.Ramp pCathode_set(
    duration=0,
    height=0,
    startTime=0,
    y(unit="Pa", displayUnit="MPa"),
    offset=19.64*1e5) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={88,84})));
  Modelica.Blocks.Continuous.LimPID FBctrl_pAnode(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=FBctrl_pAnode_k,
    Ti=FBctrl_pAnode_T,
    y(start=anodePCV_valveOpening_start),
    xi_start=anodePCV_valveOpening_start/FBctrl_pCathode.k,
    gainPID(y(start=anodePCV_valveOpening_start)),
    y_start=anodePCV_valveOpening_start,
    initType=initType_anodePCV,
    yMin=0.05,
    yMax=1)                                             annotation (
      Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={40,-72})));
  Modelica.Blocks.Sources.Ramp pAnode_set(
    duration=0,
    height=0,
    startTime=0,
    y(unit="Pa", displayUnit="MPa"),
    offset=19.64*1e5) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={68,-72})));
equation
  connect(FFctrl_SU.u_s_SUfactor, SUfactor_set.y) annotation (Line(points={{20,69},
          {20,79.2}},                  color={0,0,127}));
  connect(FFctrl_SU.u_s_yH2in, yH2in_set.y) annotation (Line(points={{20,51},
          {20,40.8}},             color={0,0,127}));
  connect(ctrlCathodeIn,cathodeFlowIn. port_a) annotation (Line(points={{-100,60},
          {-80,60},{-80,16},{-70,16}},          color={0,127,255}));
  connect(cathodeFlowIn.port_b, SOECstack.cathodeFlangeIn) annotation (Line(
        points={{-50,16},{-21.14,16},{-21.14,16.3}}, color={0,127,255}));
  connect(SOECstack.cathodeFlangeOut, cathodeFlowOut.port_a) annotation (Line(
        points={{-4.86,18.5},{30,18.5},{30,18}},color={0,127,255}));
  connect(FFctrl_SU.u_m, cathodeFlowOut.m_flow)
    annotation (Line(points={{29,60},{40,60},{40,29}}, color={0,0,127}));
  connect(feedback_wC_in.u2, FFctrl_SU.y) annotation (Line(points={{-53.6,
          60},{-53.6,60},{11,60}},
                              color={0,0,127}));
  connect(cathodeFlowIn.m_flow, feedback_wC_in.u1) annotation (Line(points={{-60,27},
          {-60,40},{-60,53.6}},           color={0,0,127}));
  connect(FBctrl_TC_out.u, feedback_TC_out.y) annotation (Line(points={{-30.4,
          -40},{-30.4,-40},{-21.2,-40}},color={0,0,127}));
  connect(cathodeFlowOut.port_b, ctrlCathodeOut) annotation (Line(points={{50,18},
          {80,18},{80,60},{100,60}},        color={0,127,255}));
  connect(limiter_wCathode_in.y, c_wCathode)
    annotation (Line(points={{-5.2,76},{0,76},{0,110}}, color={0,0,127}));
  connect(feedback_TC_out.u1, TCout_set.y) annotation (Line(points={{-7.6,
          -40},{-7.6,-40},{3.2,-40}},
                                 color={0,0,127}));
  connect(FBctrl_TC_out.y, limiter_wAnode_in.u) annotation (Line(points={{-48.8,
          -40},{-60,-40},{-60,-80},{-49.6,-80}}, color={0,0,127}));
  connect(limiter_wAnode_in.y, c_wAnodeIn)
    annotation (Line(points={{-31.2,-80},{0,-80},{0,-110}},color={0,0,127}));
  connect(ctrlAnodeIn, SOECstack.anodeFlangeIn) annotation (Line(points={{-100,
          -60},{-80,-60},{-80,-10},{-30,-10},{-30,7.06},{-21.14,7.06}},
        color={0,127,255}));
  connect(SOECstack.anodeFlangeOut, ctrlAnodeOut) annotation (Line(points={{-4.86,
          9.26},{-4.86,10},{0,10},{0,-10},{80,-10},{80,-60},{100,-60}},
                 color={0,127,255}));
  connect(ctrlElectricalLoad, SOECstack.electricalLoad) annotation (Line(
        points={{-100,0},{-40,0},{-40,11.9},{-21.36,11.9}}, color={255,0,0}));
  connect(c_pCathode, c_pCathode)
    annotation (Line(points={{64,110},{64,110}}, color={0,0,127}));
  connect(FBctrl_pCathode.u_m, pCathode_set.y) annotation (Line(points={{
          73.6,84},{73.6,84},{79.2,84}}, color={0,0,127}));
  connect(pCathode.p, FBctrl_pCathode.u_s)
    annotation (Line(points={{64,51},{64,74.4}}, color={0,0,127}));
  connect(FBctrl_pCathode.y, c_pCathode) annotation (Line(points={{64,92.8},
          {64,92.8},{64,110}}, color={0,0,127}));
  connect(pCathode.port, ctrlCathodeOut) annotation (Line(points={{74,40},{
          80,40},{80,60},{100,60}}, color={0,127,255}));
  connect(c_pAnode, FBctrl_pAnode.y) annotation (Line(points={{40,-110},{40,
          -98},{40,-80.8}}, color={0,0,127}));
  connect(FBctrl_pAnode.u_s, pAnode.p)
    annotation (Line(points={{40,-62.4},{40,-41}}, color={0,0,127}));
  connect(pAnode_set.y, FBctrl_pAnode.u_m)
    annotation (Line(points={{59.2,-72},{49.6,-72}}, color={0,0,127}));
  connect(TCoutSensor.port, SOECstack.cathodeFlangeOut) annotation (Line(
        points={{10,12},{10,12},{10,18.5},{-4.86,18.5}}, color={0,127,255}));
  connect(TCoutSensor.y, feedback_TC_out.u2) annotation (Line(points={{10,-3.2},
          {10,-20},{-14,-20},{-14,-33.6}},       color={0,0,127}));
  connect(pAnode.port, ctrlAnodeOut) annotation (Line(points={{50,-30},{80,
          -30},{80,-60},{100,-60}}, color={0,127,255}));
  connect(feedback_wC_in.y, FBctrl_SUfactor.u) annotation (Line(points={{-60,67.2},
          {-60,76},{-49.6,76}}, color={0,0,127}));
  connect(FBctrl_SUfactor.y, limiter_wCathode_in.u)
    annotation (Line(points={{-31.2,76},{-23.6,76}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=3500, Interval=1),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={
        Line(
          points={{36,30},{-46,30}},
          color={0,0,0},
          arrow={Arrow.Open,Arrow.None}),
        Line(points={{-56,20},{-56,14},{-56,10},{-76,10},{-76,-4}}, color={0,0,0}),
        Line(points={{-80,-4},{-72,-4}}, color={0,0,0}),
        Line(points={{-84,-8},{-68,-8}}, color={0,0,0}),
        Line(points={{-80,-12},{-72,-12}}, color={0,0,0}),
        Line(points={{-84,-16},{-68,-16}}, color={0,0,0}),
        Line(points={{-76,-16},{-76,-20},{-76,-30},{-56,-30},{-56,-40}}, color={
              0,0,0}),
        Line(
          points={{36,-54},{-46,-54}},
          color={0,0,0},
          arrow={Arrow.Open,Arrow.None})}));
end ControlledSOEC_integratedWithHTSEplant_FY17;
