within NHES.Systems.PrimaryHeatSystem.SMR_Generic;
model CS_SMR_Tave

  extends BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

 input SI.Power W_turbine "Turbine Output" annotation(Dialog(group="Inputs"));
 input SI.Power W_Setpoint "Turbine Setpoint" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=300)
    annotation (Placement(transformation(extent={{-194,22},{-174,42}})));
  Modelica.Blocks.Logical.Greater greater5
    annotation (Placement(transformation(extent={{-154,62},{-134,42}})));
  Modelica.Blocks.Sources.Constant delay_CR(k=0)
    annotation (Placement(transformation(extent={{-194,62},{-174,82}})));
  Modelica.Blocks.Sources.RealExpression
                                   T_avg_nominal(y=data.T_avg) "576"
    annotation (Placement(transformation(extent={{-50,110},{-30,130}})));
  TRANSFORM.Controls.LimPID PID_CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    Ti=5,
    k_s=1000*1/data.Q_total,
    k_m=1000*1/data.Q_total)
    annotation (Placement(transformation(extent={{30,130},{50,110}})));
  Modelica.Blocks.Logical.Switch switch_CR
    annotation (Placement(transformation(extent={{-10,130},{10,150}})));
  GenericModular_PWR.Data.Data_GenericModule data(length_steamGenerator_tube=
        36, T_avg=556.15)
    annotation (Placement(transformation(extent={{74,142},{90,158}})));
  Modelica.Blocks.Math.Add Sum_Hot_and_Cold_Leg
    annotation (Placement(transformation(extent={{-182,144},{-162,164}})));
  Modelica.Blocks.Math.Division T_Ave
    annotation (Placement(transformation(extent={{-142,138},{-122,158}})));
  Modelica.Blocks.Sources.Constant Dividebytwo(k=2)
    annotation (Placement(transformation(extent={{-174,114},{-154,134}})));
  TRANSFORM.Controls.LimPID PID_FeedPump(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=15,
    yMax=72.0,
    yMin=34.0,
    y_start=67,
    k=0.0001,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    xi_start=1.0,
    k_s=1/72,
    k_m=1/72)
    annotation (Placement(transformation(extent={{26,-4},{46,-24}})));
  Modelica.Blocks.Sources.RealExpression Demand(y=W_Setpoint) "576"
    annotation (Placement(transformation(extent={{-82,-42},{-62,-22}})));
  Modelica.Blocks.Sources.RealExpression Feed_Flow_Via_Power(y=W_turbine)
    annotation (Placement(transformation(extent={{-74,20},{-54,40}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{-156,-30},{-136,-10}})));
  Modelica.Blocks.Sources.Constant delay_Feed(k=0)
    annotation (Placement(transformation(extent={{-192,-50},{-172,-30}})));
  Modelica.Blocks.Logical.Switch switch_CR1
    annotation (Placement(transformation(extent={{-36,-10},{-16,-30}})));
equation

  connect(delay_CR.y,greater5. u2) annotation (Line(points={{-173,72},{-168,72},
          {-168,60},{-156,60}}, color={0,0,127}));
  connect(clock.y,greater5. u1) annotation (Line(points={{-173,32},{-168,32},{-168,
          52},{-156,52}},         color={0,0,127}));
  connect(T_avg_nominal.y,switch_CR. u3) annotation (Line(points={{-29,120},{-20,
          120},{-20,132},{-12,132}}, color={0,0,127}));
  connect(T_avg_nominal.y,PID_CR. u_s)
    annotation (Line(points={{-29,120},{28,120}}, color={0,0,127}));
  connect(switch_CR.y,PID_CR. u_m)
    annotation (Line(points={{11,140},{40,140},{40,132}}, color={0,0,127}));
  connect(greater5.y, switch_CR.u2) annotation (Line(points={{-133,52},{-100,52},
          {-100,140},{-12,140}},     color={255,0,255}));
  connect(actuatorBus.reactivity_ControlRod, PID_CR.y) annotation (Line(
      points={{30.1,-99.9},{100,-99.9},{100,120},{51,120}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Dividebytwo.y, T_Ave.u2) annotation (Line(points={{-153,124},{-150,124},
          {-150,142},{-144,142}}, color={0,0,127}));
  connect(Sum_Hot_and_Cold_Leg.y, T_Ave.u1)
    annotation (Line(points={{-161,154},{-144,154}}, color={0,0,127}));
  connect(T_Ave.y, switch_CR.u1)
    annotation (Line(points={{-121,148},{-12,148}}, color={0,0,127}));
  connect(sensorBus.T_Core_Inlet, Sum_Hot_and_Cold_Leg.u1) annotation (Line(
      points={{-29.9,-99.9},{-200,-99.9},{-200,160},{-184,160}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_Core_Outlet, Sum_Hot_and_Cold_Leg.u2) annotation (Line(
      points={{-29.9,-99.9},{-200,-99.9},{-200,148},{-184,148}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.mfeedpump, PID_FeedPump.y) annotation (Line(
      points={{30,-100},{100,-100},{100,-14},{47,-14}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Feed_Flow_Via_Power.y, PID_FeedPump.u_m)
    annotation (Line(points={{-53,30},{36,30},{36,-2}},color={0,0,127}));
  connect(delay_Feed.y, greater1.u2) annotation (Line(points={{-171,-40},{
          -164,-40},{-164,-28},{-158,-28}}, color={0,0,127}));
  connect(clock.y, greater1.u1) annotation (Line(points={{-173,32},{-168,32},
          {-168,-20},{-158,-20}}, color={0,0,127}));
  connect(greater1.y, switch_CR1.u2)
    annotation (Line(points={{-135,-20},{-38,-20}}, color={255,0,255}));
  connect(Demand.y, switch_CR1.u1) annotation (Line(points={{-61,-32},{-50,
          -32},{-50,-28},{-38,-28}}, color={0,0,127}));
  connect(switch_CR1.y, PID_FeedPump.u_s) annotation (Line(points={{-15,-20},
          {-2,-20},{-2,-14},{24,-14}}, color={0,0,127}));
  connect(Feed_Flow_Via_Power.y, switch_CR1.u3) annotation (Line(points={{-53,
          30},{-44,30},{-44,-12},{-38,-12}}, color={0,0,127}));
annotation(defaultComponentName="PHS_CS",
    Diagram(coordinateSystem(extent={{-200,-100},{140,200}})),
    Icon(coordinateSystem(extent={{-200,-100},{140,200}})));
end CS_SMR_Tave;
