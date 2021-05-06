within NHES.Electrolysis.Electrolyzers;
model ControlledSOEC_integratedWithHTSEplant_updateLogTerm
  "SOEC with its regulatory control scheme"
  import NHES.Electrolysis;
  extends Electrolysis.Icons.Electrolyzer;

  parameter Integer numCells_perVessel "Total number of cells per vessel []";
  parameter Integer numVessels=1 "Number of online vessels per system []";

  parameter Electrolysis.Utilities.OptionsInit.Temp initOpt = Electrolysis.Utilities.OptionsInit.noInit
    "Initialisation option for a SOEC stack" annotation (Dialog(tab="Initialisation", group="SOEC stack"));
  Modelica.Blocks.Nonlinear.Limiter limiter_wCathode_in(uMax=FBctrl_SUfactor.y_start
        *1.1, uMin=FBctrl_SUfactor.y_start*0.1)
                                               annotation (Placement(transformation(extent={{-24,68},{-8,84}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_wAnode_in(uMin=5.47193, uMax=76.63)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-20,-80})));
  parameter Modelica.Blocks.Types.Init initType_wCathode_in=Modelica.Blocks.Types.Init.NoInit
    "Initialisation option for steam utilization factor control (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                                                                                        annotation (Dialog(tab="Initialisation", group="Cathode gas supply"));
  parameter Modelica.Blocks.Types.Init initType_wAnode_in=Modelica.Blocks.Types.Init.NoInit
    "Initialisation option for TC_out control (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                                                                                        annotation (Dialog(tab="Initialisation", group="Anode gas supply"));
  parameter Real wCathode_in_start = 4.484668581
    "Initial or guess value of state for wCathode_in" annotation (Dialog(tab="Initialisation", group="Cathode gas supply"));
  parameter Real wAnode_in_start = 4.65587*5
    "Initial or guess value of state for wAnode_in" annotation (Dialog(tab="Initialisation", group="Anode gas supply"));
  parameter Real FBctrl_SUfactor_k=0.8 "Gain"  annotation (Dialog(tab="General", group="SU factor controller"));
  parameter Real FBctrl_SUfactor_T=16 "Time constant"  annotation (Dialog(tab="General", group="SU factor controller"));
  parameter Real FBctrl_TC_out_k=0.008 "Gain"  annotation (Dialog(tab="General", group="TC_out controller"));
  parameter Real FBctrl_TC_out_T=8 "Time constant"  annotation (Dialog(tab="General", group="TC_out controller"));

  Electrolysis.Electrolyzers.BaseClasses.SOEC_updateLogTerm
                                              SOECstack(
    numVessels=numVessels,
    numCells_perVessel=numCells_perVessel,
    initOpt=initOpt,
    TCin(start=SOECstack.TCstartIn_K))
    annotation (Placement(transformation(extent={{-18,2},{4,24}})));

  Electrolysis.Sensors.TempSensorWithThermowell TCoutSensor(
    redeclare package Medium = Electrolysis.Media.Electrolysis.CathodeGas,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=750 + 273.15,
    tau=13) annotation (Placement(transformation(extent={{60,6},{80,-14}})));

  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas, allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-68,6},{-48,26}})));
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
        origin={48,-52})));
  Modelica.Fluid.Interfaces.FluidPort_a ctrlCathodeIn(redeclare package Medium =
               Electrolysis.Media.Electrolysis.CathodeGas) annotation (
      Placement(transformation(extent={{-110,50},{-90,70}}),
        iconTransformation(extent={{-84,20},{-64,40}})));
  Modelica.Blocks.Interfaces.RealOutput c_wCathode annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,60})));
  Modelica.Blocks.Interfaces.RealOutput c_wAnodeIn annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-98}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-8,-74})));
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

  Electrolysis.Interfaces.ElectricalPowerPort_a ctrlElectricalLoad annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-86,-20},{-66,0}})));

/*          
  Modelica.Blocks.Interfaces.RealInput powerSetPoint_W(  final quantity="Power",
                                           final unit="W",
                                           min = 0,
                                           displayUnit="MW") annotation (Placement(
        transformation(extent={{-116,-6},{-94,16}}),  iconTransformation(extent={{-104,
            -20},{-84,0}})));
*/

  Electrolysis.Controllers.FFcontroller_SU FFctrl_SU(initialOutput=0.908085*5)
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
    y_start=wCathode_in_start,
    initType=initType_wCathode_in,
    x_start=wCathode_in_start/FBctrl_SUfactor.k,
    k=FBctrl_SUfactor_k,
    T=FBctrl_SUfactor_T)
    annotation (Placement(transformation(extent={{-48,68},{-32,84}})));
  Modelica.Blocks.Math.Feedback feedback_wC_in annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=-90,
        origin={-58,60})));
  Modelica.Blocks.Math.Feedback feedback_TC_out annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={20,-52})));
  Modelica.Blocks.Continuous.PI FBctrl_TC_out(
    initType=initType_wAnode_in,
    y_start=wAnode_in_start,
    x_start=wAnode_in_start/FBctrl_TC_out.k,
    k=FBctrl_TC_out_k,
    T=FBctrl_TC_out_T)
    annotation (Placement(transformation(extent={{-12,-60},{-28,-44}})));

equation
  connect(FFctrl_SU.u_s_SUfactor, SUfactor_set.y) annotation (Line(points={{20,69},
          {20,79.2}},                  color={0,0,127}));
  connect(FFctrl_SU.u_s_yH2in, yH2in_set.y) annotation (Line(points={{20,51},
          {20,40.8}},             color={0,0,127}));
  connect(ctrlCathodeIn,cathodeFlowIn. port_a) annotation (Line(points={{
          -100,60},{-80,60},{-80,16},{-68,16}}, color={0,127,255}));
  connect(cathodeFlowIn.port_b, SOECstack.cathodeFlangeIn) annotation (Line(
        points={{-48,16},{-15.14,16},{-15.14,16.3}}, color={0,127,255}));
  connect(SOECstack.cathodeFlangeOut, cathodeFlowOut.port_a) annotation (Line(
        points={{1.14,18.5},{30,18.5},{30,18}}, color={0,127,255}));
  connect(FFctrl_SU.u_m, cathodeFlowOut.m_flow)
    annotation (Line(points={{29,60},{40,60},{40,29}}, color={0,0,127}));
  connect(feedback_wC_in.y, FBctrl_SUfactor.u) annotation (Line(points={{-58,67.2},
          {-58,76},{-49.6,76}},         color={0,0,127}));
  connect(feedback_wC_in.u2, FFctrl_SU.y) annotation (Line(points={{-51.6,60},{-51.6,
          60},{11,60}},       color={0,0,127}));
  connect(cathodeFlowIn.m_flow, feedback_wC_in.u1) annotation (Line(points={{-58,27},
          {-58,40},{-58,53.6}},           color={0,0,127}));
  connect(FBctrl_TC_out.u, feedback_TC_out.y) annotation (Line(points={{-10.4,-52},
          {-10.4,-52},{12.8,-52}},      color={0,0,127}));
  connect(cathodeFlowOut.port_b, ctrlCathodeOut) annotation (Line(points={{50,18},
          {80,18},{80,60},{100,60}},        color={0,127,255}));
  connect(TCoutSensor.port, cathodeFlowOut.port_b)
    annotation (Line(points={{70,6},{70,18},{50,18}}, color={0,127,255}));
  connect(FBctrl_SUfactor.y, limiter_wCathode_in.u)
    annotation (Line(points={{-31.2,76},{-25.6,76}}, color={0,0,127}));
  connect(limiter_wCathode_in.y, c_wCathode)
    annotation (Line(points={{-7.2,76},{0,76},{0,100}}, color={0,0,127}));
  connect(feedback_TC_out.u1, TCout_set.y) annotation (Line(points={{26.4,-52},{
          26.4,-52},{39.2,-52}}, color={0,0,127}));
  connect(TCoutSensor.y, feedback_TC_out.u2) annotation (Line(points={{70,-13},
          {70,-30},{20,-30},{20,-45.6}},color={0,0,127}));
  connect(FBctrl_TC_out.y, limiter_wAnode_in.u) annotation (Line(points={{-28.8,
          -52},{-40,-52},{-40,-80},{-29.6,-80}}, color={0,0,127}));
  connect(limiter_wAnode_in.y, c_wAnodeIn)
    annotation (Line(points={{-11.2,-80},{0,-80},{0,-98}}, color={0,0,127}));
  connect(ctrlAnodeIn, SOECstack.anodeFlangeIn) annotation (Line(points={{
          -100,-60},{-80,-60},{-80,-10},{-30,-10},{-30,7.06},{-15.14,7.06}},
        color={0,127,255}));
  connect(SOECstack.anodeFlangeOut, ctrlAnodeOut) annotation (Line(points={
          {1.14,9.26},{8,9.26},{20,9.26},{20,-10},{60,-10},{60,-60},{100,
          -60}}, color={0,127,255}));
  connect(ctrlElectricalLoad, SOECstack.electricalLoad) annotation (Line(
        points={{-100,0},{-40,0},{-40,11.9},{-15.36,11.9}}, color={255,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=3500, Interval=1),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={
        Line(points={{-56,20},{-56,14},{-56,10},{-76,10},{-76,-4}}, color={0,0,0}),
        Line(points={{-80,-4},{-72,-4}}, color={0,0,0}),
        Line(points={{-84,-8},{-68,-8}}, color={0,0,0}),
        Line(points={{-80,-12},{-72,-12}}, color={0,0,0}),
        Line(points={{-84,-16},{-68,-16}}, color={0,0,0}),
        Line(points={{-76,-16},{-76,-20},{-76,-30},{-56,-30},{-56,-40}}, color={
              0,0,0})}));
end ControlledSOEC_integratedWithHTSEplant_updateLogTerm;
