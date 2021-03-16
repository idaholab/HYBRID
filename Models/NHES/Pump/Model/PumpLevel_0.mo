within NHES.Pump.Model;
model PumpLevel_0 "Prescribed speed centrifigual pump"
  replaceable package WaterMedium = Modelica.Media.Water.StandardWater;
  import      Modelica.Units.SI;
  import Modelica.Constants.*;
  import Modelica.Units.Conversions.*;
  constant Real MINUTE2SEC=from_minute(1) "minutes to seconds";
  constant Real pi1Optimal=0.0156079 "Optimal value of pi1 (see ANL Report)";
  parameter Boolean usePowerCharacteristic=false;
  parameter SI.VolumeFlowRate q1=0
    "Flow rate for the first point in curve fitting";
  parameter SI.VolumeFlowRate q2=0.05
    "Flow rate for the second point in curve fitting";
  parameter SI.VolumeFlowRate q3=0.1
    "Flow rate for the third point in curve fitting";
  parameter SI.VolumeFlowRate q_nom[3]={q1,q2,q3} "Nominal volume flow rates";
  parameter SI.Height h1=Functions.FeedWaterFlowHead(
      q1,
      coeffFlow_nom,
      ND0) "head for the first point in curve fitting";
  parameter SI.Height h2=Functions.FeedWaterFlowHead(
      q2,
      coeffFlow_nom,
      ND0) "head for the second point in curve fitting";
  parameter SI.Height h3=Functions.FeedWaterFlowHead(
      q3,
      coeffFlow_nom,
      ND0) "head for the third point in curve fitting";
  parameter SI.Height head_nom[3]={h1,h2,h3} "Nominal heads";
  parameter SI.Power W1=Functions.FeedWaterFlowPower(
      q1,
      coeffPower_nom,
      ND0) "Power for the first point in curve fitting";
  parameter SI.Power W2=Functions.FeedWaterFlowPower(
      q2,
      coeffPower_nom,
      ND0) "Power for the second point in curve fitting";
  parameter SI.Power W3=Functions.FeedWaterFlowPower(
      q3,
      coeffPower_nom,
      ND0) "Power for the third point in curve fitting";
  parameter SI.Power W_nom[3]={W1,W2,W3} "Nominal Power for single pump";
  parameter Integer Np0=2 "Nominal number of pumps in parallel";
  parameter Integer NStage=14 "Number of Stages";
  parameter SI.Volume V1=0.1 "One Pump Internal Volume";
  parameter SI.Volume V=V1*NStage "Pump Internal Volume";
  //parameter SI.Volume V=0 "Pump Internal Volume";
  parameter SI.Density rho0=918 "Nominal density";
  parameter Real eta0=0.494869 "Nominal Efficiency";
  parameter Modelica.Units.NonSI.AngularVelocity_rpm n0=1800 "Nominal rpm";
  parameter SI.Diameter D=((nominalFlow/Np0/rho0)/((n0/MINUTE2SEC)*pi1Optimal))
      ^0.333333 "Pump Diameter";
  parameter Real NDg0=(n0/MINUTE2SEC*D)^2/g_n
    "N^2D^2/g, N is rpm, D is diameter";
  parameter Real ND0=n0/MINUTE2SEC*D^3 "ND^3, N is rpm, D is diameter";
  //parameter Real N2D2=(n0/MINUTE2SEC*D)^2;
  parameter Real N3D5=(n0/MINUTE2SEC)^3*D^5;
  parameter Real coeffFlow_nom=NStage*NDg0;
  parameter Real coeffPower_nom=NStage*rho0*N3D5/eta0 "Shaft Power";
  parameter SI.Pressure nominalOutletPressure=17600000
    "Nominal outlet pressure";
  parameter SI.Pressure nominalInletPressure=2800000 "Nominal inlet pressure";
  parameter SI.MassFlowRate nominalFlow=171.2 "Total nominal mass flow rate";
  parameter SI.SpecificEnthalpy hstart=1e5
    "Fluid Specific Enthalpy Start Value"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean SSInit=false "Steady-state initialization"
    annotation (Dialog(tab="Initialization"));

  replaceable function flowFunc =
      ThermoPower.Functions.PumpCharacteristics.quadraticFlow (q_nom=q_nom,
        head_nom=head_nom);

  replaceable function powerFunc =
      ThermoPower.Functions.PumpCharacteristics.quadraticPower (q_nom=q_nom,
        W_nom=W_nom);

  replaceable function pumpEfficiency =
      ThermoPower.Functions.PumpCharacteristics.constantEfficiency (eta_nom=
          eta0);

  ThermoPower.Water.FlangeA inlet(redeclare package Medium = WaterMedium)
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}, rotation=
           0)));
  ThermoPower.Water.FlangeB outlet(redeclare package Medium = WaterMedium)
    annotation (Placement(transformation(extent={{80,-20},{120,20}}, rotation=0)));
  ThermoPower.Water.Pump feedWaterPump(
    redeclare package Medium = WaterMedium,
    redeclare function flowCharacteristic = flowFunc,
    redeclare function powerCharacteristic = powerFunc,
    redeclare function efficiencyCharacteristic = pumpEfficiency,
    n0=n0,
    hstart=hstart,
    Np0=Np0,
    rho0=rho0,
    V=V,
    initOpt=if SSInit then ThermoPower.Choices.Init.Options.steadyState else
        ThermoPower.Choices.Init.Options.noInit,
    dp0=nominalOutletPressure - nominalInletPressure,
    wstart=nominalFlow,
    w0=nominalFlow,
    usePowerCharacteristic=usePowerCharacteristic) annotation (Placement(
        transformation(extent={{-40,-24},{0,16}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput pumpSpeed_rpm annotation (Placement(
        transformation(extent={{-92,40},{-52,80}}, rotation=0),
        iconTransformation(extent={{-92,40},{-52,80}})));

  inner ThermoPower.System system
    annotation (Placement(transformation(extent={{80,76},{100,96}})));
equation
  connect(inlet, feedWaterPump.infl) annotation (Line(
      points={{-100,0},{-67,0},{-36,0}},
      thickness=0.5,
      color={0,0,255}));
  connect(pumpSpeed_rpm, feedWaterPump.in_n) annotation (Line(points={{-72,60},
          {-25.2,60},{-25.2,12}}, color={0,0,127}));
  connect(outlet, feedWaterPump.outfl) annotation (Line(
      points={{100,0},{10,0},{10,10},{-8,10}},
      thickness=0.5,
      color={0,0,255}));
  annotation (Icon(graphics={
        Polygon(
          points={{-60,-54},{-92,-96},{84,-96},{58,-54},{-60,-54}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,-118},{100,-144}},
          lineColor={0,0,255},
          textString="%name"),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere),
        Polygon(
          points={{-40,40},{-40,-40},{50,0},{-40,40}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255})}));
end PumpLevel_0;
