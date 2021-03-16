within NHES.Electrolysis.Electrolyzers;
model ControlledSOEC "SOEC with its regulatory control scheme"
  import NHES.Electrolysis;
  extends Electrolysis.Icons.Electrolyzer;

  parameter Integer numCells_perVessel "Total number of cells per vessel []";
  parameter Integer numVessels=1 "Number of online vessels per system []";
//  parameter Modelica.SIunits.Time settlingTau = 0.2
//    "Time constant of a SOEC stack w.r.t. power consumption change";

  Electrolysis.Electrolyzers.BaseClasses.SOEC SOECstack(
    numVessels=numVessels,
    numCells_perVessel=numCells_perVessel,
    initOpt=Electrolysis.Utilities.OptionsInit.steadyState)
    annotation (Placement(transformation(extent={{-18,2},{4,24}})));

  Electrolysis.Sensors.TempSensorWithThermowell TCoutSensor(
    redeclare package Medium = Electrolysis.Media.Electrolysis.CathodeGas,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=750 + 273.15,
    tau=13) annotation (Placement(transformation(extent={{50,-2},{70,-22}})));

  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowIn(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas, allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-68,6},{-48,26}})));
  Modelica.Fluid.Sensors.MassFlowRate cathodeFlowOut(redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas, allowFlowReversal=false)
    annotation (Placement(transformation(extent={{24,8},{44,28}})));
  Modelica.Blocks.Sources.Ramp TCout_set(
    duration=0,
    height=0,
    startTime=0,
    offset=750 + 273.15,
    y(displayUnit="degC", unit="K"))
                 annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=-90,
        origin={80,-80})));
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
        Electrolysis.Media.Electrolysis.AnodeGas_air) annotation (Placement(
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

  Electrolysis.Controllers.FFcontroller_SU FFctrl_SU(initialOutput=0.908085*5)
    annotation (Placement(transformation(extent={{-22,38},{-2,58}})));
  Modelica.Blocks.Sources.Constant yH2in_set(k=0.1)
    annotation (Placement(transformation(extent={{18,26},{4,40}})));
  Modelica.Blocks.Sources.Constant SUfactor_set(k=80)
    annotation (Placement(transformation(extent={{18,56},{4,70}})));
  Modelica.Blocks.Continuous.PI FBctrl_SUfactor(
    k=1,
    T=8,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start=4.484668581/FBctrl_SUfactor.k,
    y_start=4.484668581)
    annotation (Placement(transformation(extent={{-38,64},{-22,80}})));
  Modelica.Blocks.Math.Feedback feedback_wC_in annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={-58,48})));
  Modelica.Blocks.Math.Feedback feedback_TC_out annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,-62})));
  Modelica.Blocks.Continuous.PI FBctrl_TC_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=4.65587*5,
    k=0.01,
    T=5,
    x_start=4.65587*5/FBctrl_TC_out.k)
    annotation (Placement(transformation(extent={{38,-70},{22,-54}})));
  Electrolysis.Interfaces.ElectricalPowerPort_a ctrlElectricalLoad annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-86,-20},{-66,0}})));
equation
  connect(FFctrl_SU.u_s_SUfactor, SUfactor_set.y) annotation (Line(points={
          {-12,57},{-12,63},{3.3,63}}, color={0,0,127}));
  connect(FFctrl_SU.u_s_yH2in, yH2in_set.y) annotation (Line(points={{-12,
          39},{-12,33},{3.3,33}}, color={0,0,127}));
  connect(ctrlCathodeIn,cathodeFlowIn. port_a) annotation (Line(points={{
          -100,60},{-80,60},{-80,16},{-68,16}}, color={0,127,255}));
  connect(cathodeFlowIn.port_b, SOECstack.cathodeFlangeIn) annotation (Line(
        points={{-48,16},{-15.14,16},{-15.14,16.3}}, color={0,127,255}));
  connect(SOECstack.cathodeFlangeOut, cathodeFlowOut.port_a) annotation (Line(
        points={{1.14,18.5},{24,18.5},{24,18}}, color={0,127,255}));
  connect(FFctrl_SU.u_m, cathodeFlowOut.m_flow)
    annotation (Line(points={{-3,48},{34,48},{34,29}}, color={0,0,127}));
  connect(ctrlAnodeIn, SOECstack.anodeFlangeIn) annotation (Line(points={{-100,-60},
          {-80,-60},{-80,-32},{-30,-32},{-30,7.06},{-15.14,7.06}}, color={0,127,
          255}));
  connect(SOECstack.anodeFlangeOut, ctrlAnodeOut) annotation (Line(points={{1.14,
          9.26},{14,9.26},{14,-32},{80,-32},{80,-60},{100,-60}}, color={0,127,255}));
  connect(feedback_wC_in.y, FBctrl_SUfactor.u) annotation (Line(points={{-58,57},
          {-58,72},{-39.6,72}},         color={0,0,127}));
  connect(feedback_wC_in.u2, FFctrl_SU.y) annotation (Line(points={{-50,48},
          {-21,48}},          color={0,0,127}));
  connect(cathodeFlowIn.m_flow, feedback_wC_in.u1) annotation (Line(points=
          {{-58,27},{-58,33.5},{-58,40}}, color={0,0,127}));
  connect(feedback_TC_out.u1, TCout_set.y) annotation (Line(points={{68,-62},
          {80,-62},{80,-71.2}}, color={0,0,127}));
  connect(FBctrl_SUfactor.y, c_wCathode)
    annotation (Line(points={{-21.2,72},{0,72},{0,100}}, color={0,0,127}));
  connect(feedback_TC_out.y, FBctrl_TC_out.u) annotation (Line(points={{51,-62},
          {44,-62},{39.6,-62}},        color={0,0,127}));
  connect(FBctrl_TC_out.y, c_wAnodeIn) annotation (Line(points={{21.2,-62},
          {0,-62},{0,-98}}, color={0,0,127}));
  connect(cathodeFlowOut.port_b, ctrlCathodeOut) annotation (Line(points={{
          44,18},{80,18},{80,60},{100,60}}, color={0,127,255}));
  connect(TCoutSensor.port, cathodeFlowOut.port_b)
    annotation (Line(points={{60,-2},{60,18},{44,18}}, color={0,127,255}));
  connect(TCoutSensor.y, feedback_TC_out.u2)
    annotation (Line(points={{60,-21},{60,-54}}, color={0,0,127}));
  connect(ctrlAnodeOut, ctrlAnodeOut) annotation (Line(points={{100,-60},{
          100,-58},{100,-60}}, color={0,127,255}));
  connect(ctrlElectricalLoad, SOECstack.electricalLoad) annotation (Line(
        points={{-100,0},{-40,0},{-40,11.9},{-15.36,11.9}}, color={255,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=3500, Interval=1),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
         graphics={
        Line(points={{-56,20},{-56,14},{-56,10},{-76,10},{-76,-4}}, color={0,0,0}),
        Line(points={{-80,-4},{-72,-4}}, color={0,0,0}),
        Line(points={{-84,-8},{-68,-8}}, color={0,0,0}),
        Line(points={{-80,-12},{-72,-12}}, color={0,0,0}),
        Line(points={{-84,-16},{-68,-16}}, color={0,0,0}),
        Line(points={{-76,-16},{-76,-20},{-76,-30},{-56,-30},{-56,-40}}, color={
              0,0,0})}));
end ControlledSOEC;
