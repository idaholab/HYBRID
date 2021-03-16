within NHES.Pump.Model;
model PumpLevel_1 "Centrifugal Pump"
  replaceable package WaterMedium = Modelica.Media.Water.StandardWater;
  import      Modelica.Units.SI;
  import Modelica.Constants.*;
  import Modelica.Units.Conversions.*;
  constant Real MINUTE2SEC=from_minute(1) "minutes to seconds";
  constant Real pi1Optimal=0.0156079 "Optimal value of pi1 (see ANL Report)";
  constant Real pi1Max=0.0324477 "Maximum Pi1 allowed";
  constant Real pi1Min=0.000116884 "Minimum Pi1 allowed";
  parameter Boolean usePowerCharacteristic=false;
  parameter Integer Np0=2 "Nominal number of pumps in parallel";
  parameter Integer NStage=14 "Number of Stages";
  parameter SI.Volume V1=0.1 "One Pump Internal Volume";
  parameter SI.Volume V=V1*NStage "Pump Internal Volume";
  parameter SI.Density rho0=918 "Nominal density";
  parameter Modelica.Units.NonSI.AngularVelocity_rpm n0=1800 "Nominal rpm";
  parameter SI.Diameter D=((nominalFlow/Np0/rho0)/((n0/MINUTE2SEC)*pi1Optimal))
      ^0.333333 "Pump Diameter";
  parameter Real NDg0=(n0/MINUTE2SEC*D)^2/g_n
    "N^2D^2/g, N is rpm, D is diameter";
  parameter Real ND0=n0/MINUTE2SEC*D^3 "ND^3, N is rpm, D is diameter";
  parameter SI.Pressure nominalOutletPressure=17600000
    "Nominal outlet pressure";
  parameter SI.Pressure nominalInletPressure=2800000 "Nominal inlet pressure";
  parameter SI.MassFlowRate nominalFlow=171.2 "Total nominal mass flow rate";
  parameter SI.SpecificEnthalpy hstart=1e5
    "Fluid Specific Enthalpy Start Value"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean SSInit=false "Steady-state initialization"
    annotation (Dialog(tab="Initialization"));

  SI.Power powerOutput "power output from pump";
  SI.Power powerInput "power input to pump";
  Real pi1 "nonDimensional Coeff";
  Real pi2;
  Real pi3;
  Real anl_eta "Pump coefficiency calculated by curve fitting";
  Real specificSpeed "pump specific speed";
  Real N60D3;
  Real N3D5;
  Real coeffFlow;
  Real coeffPower;
  Real ND;
  Real pi1_nom "nominal pi1";
  //powerOutput, powerInput, pi1, pi2, pi3, and anl_eta are for debugging
  replaceable function flowFunc = Functions.FeedWaterFlowHead (coeff=coeffFlow,
        N60D3=N60D3);

  replaceable function powerFunc = Functions.FeedWaterFlowPower (coeff=
          coeffPower, N60D3=N60D3);

  replaceable function pumpEfficiency = Functions.FeedWaterPumpEfficiency (
        N60D3=N60D3);

  ThermoPower.Water.FlangeA inlet(redeclare package Medium = WaterMedium)
    annotation (Placement(transformation(extent={{-100,-20},{-64,16}}, rotation=
           0)));
  ThermoPower.Water.FlangeB outlet(redeclare package Medium = WaterMedium)
    annotation (Placement(transformation(extent={{64,-18},{100,18}}, rotation=0)));

  BaseClasses.ANLPump feedWaterPump(
    redeclare package Medium = WaterMedium,
    redeclare function flowCharacteristic = flowFunc,
    redeclare function powerCharacteristic = powerFunc,
    redeclare function efficiencyCharacteristic = pumpEfficiency,
    n0=n0,
    NStage=NStage,
    D=D,
    ND0=ND0,
    NDg0=NDg0,
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
        transformation(extent={{-42,-22},{-2,18}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput pumpSpeed_rpm annotation (Placement(
        transformation(extent={{-92,40},{-52,80}}, rotation=0),
        iconTransformation(extent={{-92,40},{-52,80}})));

  inner ThermoPower.System system
    annotation (Placement(transformation(extent={{80,78},{100,98}})));
equation
  pi1_nom = (nominalFlow/Np0/rho0)/((n0/MINUTE2SEC)*D^3);
  assert(pi1_nom < pi1Max and pi1_nom > pi1Min,
    "Pump design is out of the allowable range");
  //If pi1_nom is out range, pump head becomes negative
  ND = feedWaterPump.n/MINUTE2SEC*D;
  coeffFlow = NStage*ND^2/g_n;
  N60D3 = feedWaterPump.n/MINUTE2SEC*D^3;
  N3D5 = (feedWaterPump.n/MINUTE2SEC)^3*D^5;
  coeffPower = NStage*rho0*N3D5/pumpEfficiency(q_flow=feedWaterPump.q_single,
    N60D3=N60D3);
  pi1 = feedWaterPump.q_single/(feedWaterPump.n/MINUTE2SEC)/D^3;
  pi2 = g_n*feedWaterPump.head/NStage/(feedWaterPump.n/MINUTE2SEC)^2/D^2;
  pi3 = pi1*pi2;
  specificSpeed = (pi1^2*g_n^3/pi2^3)^0.25;
  anl_eta = Functions.ANLPumpEfficiency(pi1);
  powerOutput = feedWaterPump.rho*g_n*feedWaterPump.q*feedWaterPump.head;
  powerInput = powerOutput/feedWaterPump.eta;
  connect(inlet, feedWaterPump.infl) annotation (Line(
      points={{-82,-2},{-38,-2},{-38,2}},
      thickness=0.5,
      color={0,0,255}));
  connect(pumpSpeed_rpm, feedWaterPump.in_n) annotation (Line(points={{-72,60},
          {-27.2,60},{-27.2,14}},color={0,0,127}));
  connect(outlet, feedWaterPump.outfl) annotation (Line(
      points={{82,0},{10,0},{10,12},{-10,12}},
      thickness=0.5,
      color={0,0,255}));
  annotation (Icon(graphics={
        Polygon(
          points={{-58,-56},{-84,-92},{86,-94},{58,-56},{-58,-56}},
          lineColor={28,108,200},
          fillPattern=FillPattern.Sphere,
          fillColor={0,0,255}),
        Text(
          extent={{-100,-118},{100,-144}},
          lineColor={0,0,255},
          textString="%name"),
        Ellipse(
          extent={{-78,80},{80,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,0}),
        Polygon(
          points={{-40,40},{-40,-40},{50,0},{-40,40}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255})}));
end PumpLevel_1;
