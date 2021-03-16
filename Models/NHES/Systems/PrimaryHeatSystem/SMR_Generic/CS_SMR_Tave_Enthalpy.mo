within NHES.Systems.PrimaryHeatSystem.SMR_Generic;
model CS_SMR_Tave_Enthalpy

  extends BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

 //input SI.Power W_turbine "Turbine Output" annotation(Dialog(group="Inputs"));
// input SI.SpecificEnthalpy SG_exit_enthalpy "SG SetPoint [J/kg]" annotation(Dialog(group="Inputs"));

 input SI.Temperature T_SG_exit=306 "SG SetPoint [J/kg]" annotation(Dialog(group="Inputs"));
 input SI.Power Q_nom=160e6
                     "Demand Change from nominal 1.0=nominal power" annotation(Dialog(group="Inputs"));
 input Real demand= 1.0 "Demand Change from nominal 1.0=nominal power" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-194,22},{-174,42}})));
  Modelica.Blocks.Logical.Greater greater5
    annotation (Placement(transformation(extent={{-154,62},{-134,42}})));
  Modelica.Blocks.Sources.Constant delay_CR(k=0)
    annotation (Placement(transformation(extent={{-194,62},{-174,82}})));
  Modelica.Blocks.Sources.RealExpression
                                   T_avg_nominal(y=data.T_avg - (1 - demand)*
        23.1*0.0)
    "576"
    annotation (Placement(transformation(extent={{-96,104},{-76,124}})));
  TRANSFORM.Controls.LimPID PID_CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    Ti=5,
    k_s=1000*1/data.Q_total,
    k_m=1000*1/data.Q_total)
    annotation (Placement(transformation(extent={{52,92},{72,72}})));
  Modelica.Blocks.Logical.Switch switch_CR
    annotation (Placement(transformation(extent={{-66,142},{-46,162}})));
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
    y_start=67,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    xi_start=1.0,
    k_s=1/72,
    k_m=1/72,
    Ti=5,
    yMax=500.0,
    yMin=5,
    k=0.001) annotation (Placement(transformation(extent={{26,-4},{46,-24}})));
  Modelica.Blocks.Sources.RealExpression SG_Exit_temp(y=T_SG_exit) "306"
    annotation (Placement(transformation(extent={{-82,-48},{-62,-28}})));
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
  connect(T_avg_nominal.y,switch_CR. u3) annotation (Line(points={{-75,114},{-70,
          114},{-70,144},{-68,144}}, color={0,0,127}));
  connect(T_avg_nominal.y,PID_CR. u_s)
    annotation (Line(points={{-75,114},{-2,114},{-2,82},{50,82}},
                                                  color={0,0,127}));
  connect(switch_CR.y,PID_CR. u_m)
    annotation (Line(points={{-45,152},{62,152},{62,94}}, color={0,0,127}));
  connect(greater5.y, switch_CR.u2) annotation (Line(points={{-133,52},{-100,52},
          {-100,152},{-68,152}},     color={255,0,255}));
  connect(actuatorBus.reactivity_ControlRod, PID_CR.y) annotation (Line(
      points={{30.1,-99.9},{100,-99.9},{100,82},{73,82}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Dividebytwo.y, T_Ave.u2) annotation (Line(points={{-153,124},{-150,124},
          {-150,142},{-144,142}}, color={0,0,127}));
  connect(Sum_Hot_and_Cold_Leg.y, T_Ave.u1)
    annotation (Line(points={{-161,154},{-144,154}}, color={0,0,127}));
  connect(T_Ave.y, switch_CR.u1)
    annotation (Line(points={{-121,148},{-86,148},{-86,160},{-68,160}},
                                                    color={0,0,127}));
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
  connect(delay_Feed.y, greater1.u2) annotation (Line(points={{-171,-40},{
          -164,-40},{-164,-28},{-158,-28}}, color={0,0,127}));
  connect(clock.y, greater1.u1) annotation (Line(points={{-173,32},{-168,32},
          {-168,-20},{-158,-20}}, color={0,0,127}));
  connect(greater1.y, switch_CR1.u2)
    annotation (Line(points={{-135,-20},{-38,-20}}, color={255,0,255}));
  connect(SG_Exit_temp.y, switch_CR1.u1) annotation (Line(points={{-61,-38},{-50,
          -38},{-50,-28},{-38,-28}}, color={0,0,127}));
  connect(switch_CR1.y, PID_FeedPump.u_m) annotation (Line(points={{-15,-20},{-6,
          -20},{-6,-18},{2,-18},{2,6},{36,6},{36,-2}}, color={0,0,127}));

  connect(sensorBus.T_exit_SG, switch_CR1.u3) annotation (Line(
      points={{-30,-100},{-98,-100},{-98,-12},{-38,-12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_exit_SG, PID_FeedPump.u_s) annotation (Line(
      points={{-30,-100},{-46,-100},{-46,-50},{16,-50},{16,-14},{24,-14}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="PHS_CS",
    Diagram(coordinateSystem(extent={{-200,-100},{140,200}})),
    Icon(coordinateSystem(extent={{-200,-100},{140,200}})));
end CS_SMR_Tave_Enthalpy;
