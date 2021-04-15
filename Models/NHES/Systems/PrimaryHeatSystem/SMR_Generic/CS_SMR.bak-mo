within NHES.Systems.PrimaryHeatSystem.SMR_Generic;
model CS_SMR

  extends BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=300)
    annotation (Placement(transformation(extent={{-194,62},{-174,82}})));
  Modelica.Blocks.Logical.Greater greater5
    annotation (Placement(transformation(extent={{-154,102},{-134,82}})));
  Modelica.Blocks.Sources.Constant delay_CR(k=0)
    annotation (Placement(transformation(extent={{-194,102},{-174,122}})));
  Modelica.Blocks.Sources.RealExpression
                                   T_avg_nominal(y=data.Q_total)    "576"
    annotation (Placement(transformation(extent={{-50,110},{-30,130}})));
  TRANSFORM.Controls.LimPID PID_CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    Ti=5,
    k_s=1/data.Q_total,
    k_m=1/data.Q_total)
    annotation (Placement(transformation(extent={{30,130},{50,110}})));
  Modelica.Blocks.Logical.Switch switch_CR
    annotation (Placement(transformation(extent={{-10,130},{10,150}})));
  GenericModular_PWR.Data.Data_GenericModule data(length_steamGenerator_tube=
        36) annotation (Placement(transformation(extent={{74,142},{90,158}})));
equation

  connect(delay_CR.y,greater5. u2) annotation (Line(points={{-173,112},{-168,
          112},{-168,100},{-156,100}},
                                color={0,0,127}));
  connect(clock.y,greater5. u1) annotation (Line(points={{-173,72},{-168,72},
          {-168,92},{-156,92}},   color={0,0,127}));
  connect(T_avg_nominal.y,switch_CR. u3) annotation (Line(points={{-29,120},{-20,
          120},{-20,132},{-12,132}}, color={0,0,127}));
  connect(T_avg_nominal.y,PID_CR. u_s)
    annotation (Line(points={{-29,120},{28,120}}, color={0,0,127}));
  connect(switch_CR.y,PID_CR. u_m)
    annotation (Line(points={{11,140},{40,140},{40,132}}, color={0,0,127}));
  connect(greater5.y, switch_CR.u2) annotation (Line(points={{-133,92},{-100,
          92},{-100,140},{-12,140}}, color={255,0,255}));
  connect(actuatorBus.reactivity_ControlRod, PID_CR.y) annotation (Line(
      points={{30.1,-99.9},{100,-99.9},{100,120},{51,120}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Q_total, switch_CR.u1) annotation (Line(
      points={{-29.9,-99.9},{-200,-99.9},{-200,148},{-12,148}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="PHS_CS",
    Diagram(coordinateSystem(extent={{-200,-100},{100,160}})),
    Icon(coordinateSystem(extent={{-200,-100},{100,160}})));
end CS_SMR;
