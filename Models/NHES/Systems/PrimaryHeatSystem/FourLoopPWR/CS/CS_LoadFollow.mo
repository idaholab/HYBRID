within NHES.Systems.PrimaryHeatSystem.FourLoopPWR.CS;
model CS_LoadFollow "Core: Tavg | Boiler Level: dT_avg | Load Follow"

  extends BaseClasses.Partial_ControlSystem;

  parameter SI.Time delayStart_SGpump=0 "Delay SG recirc pump control";
  parameter SI.Time delayStart_CR=0 "Delay control rod reactivity control";
  parameter SI.Time delayStart_PZRheater=0 "Delay pressurizer heater control";
  input Real demandChange "Demand change from nominal. 1.0 = nominal power" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-108,60},{-88,80}})));
  Modelica.Blocks.Logical.Greater greater5
    annotation (Placement(transformation(extent={{-68,100},{-48,80}})));
  Modelica.Blocks.Sources.Constant delay_CR(k=delayStart_CR)
    annotation (Placement(transformation(extent={{-108,100},{-88,120}})));
  Modelica.Blocks.Sources.RealExpression
                                   T_avg_nominal(y=if time > 1000 then
        demandChange*data.Q_total_th else data.Q_total_th)          "576"
    annotation (Placement(transformation(extent={{-24,110},{-4,130}})));
  TRANSFORM.Controls.LimPID PID_CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    Ti=5,
    k_s=1/data.Q_total_th,
    k_m=1/data.Q_total_th)
    annotation (Placement(transformation(extent={{56,130},{76,110}})));
  Modelica.Blocks.Logical.Switch switch_CR
    annotation (Placement(transformation(extent={{16,130},{36,150}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=15.0e6, uHigh=15.5e6)
    annotation (Placement(transformation(extent={{48,-40},{68,-20}})));
  Modelica.Blocks.Logical.Switch switch_liquidHeater
    annotation (Placement(transformation(extent={{160,-40},{180,-20}})));
  Modelica.Blocks.Sources.Constant Q_liquidHeater(k=150e4)
    "heat to liquid heater"
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Blocks.Sources.Constant zeroheat(k=0)
    annotation (Placement(transformation(extent={{80,-71},{100,-51}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  Modelica.Blocks.Logical.Switch switch_Q_total1
    annotation (Placement(transformation(extent={{120,-20},{140,0}})));
  Data.Data_Basic data
    annotation (Placement(transformation(extent={{-10,-88},{10,-68}})));
  Modelica.Blocks.Sources.Constant
                            const(k=1625)
    annotation (Placement(transformation(extent={{30,40},{50,20}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{-68,-20},{-48,0}})));
  Modelica.Blocks.Sources.Constant delay_PZRheater(k=delayStart_PZRheater)
    annotation (Placement(transformation(extent={{-108,-40},{-88,-20}})));
  Modelica.Blocks.Math.Gain FWpump(k=1)
    annotation (Placement(transformation(extent={{180,-90},{200,-70}})));
  Modelica.Blocks.Sources.Constant PHSpump(k=data.m_flow_nominal)
    annotation (Placement(transformation(extent={{140,160},{160,180}})));
  TRANSFORM.Blocks.RealExpression Q_balance
    annotation (Placement(transformation(extent={{-160,86},{-140,106}})));
  TRANSFORM.Blocks.RealExpression W_balance
    annotation (Placement(transformation(extent={{-160,68},{-140,88}})));
  TRANSFORM.Blocks.RealExpression m_flowFuelConsumption
    annotation (Placement(transformation(extent={{-160,54},{-140,74}})));
  TRANSFORM.Blocks.RealExpression T_core_inlet
    annotation (Placement(transformation(extent={{-160,22},{-140,42}})));
  TRANSFORM.Blocks.RealExpression T_core_outlet
    annotation (Placement(transformation(extent={{-162,8},{-142,28}})));
  TRANSFORM.Blocks.RealExpression m_flow_feedwater
    annotation (Placement(transformation(extent={{-162,-38},{-142,-18}})));
  TRANSFORM.Blocks.RealExpression level_drum
    annotation (Placement(transformation(extent={{-162,-56},{-142,-36}})));
equation

  connect(delay_CR.y, greater5.u2) annotation (Line(points={{-87,110},{-82,110},
          {-82,98},{-70,98}},   color={0,0,127}));
  connect(clock.y, greater5.u1) annotation (Line(points={{-87,70},{-82,70},{-82,
          90},{-70,90}},          color={0,0,127}));

  connect(T_avg_nominal.y, switch_CR.u3) annotation (Line(points={{-3,120},{6,120},
          {6,132},{14,132}},         color={0,0,127}));
  connect(hysteresis.y, not1.u)
    annotation (Line(points={{69,-30},{78,-30}}, color={255,0,255}));
  connect(not1.y, switch_liquidHeater.u2) annotation (Line(points={{101,-30},{158,
          -30}},               color={255,0,255}));
  connect(Q_liquidHeater.y, switch_Q_total1.u1) annotation (Line(points={{101,10},
          {108,10},{108,-2},{118,-2}},         color={0,0,127}));
  connect(zeroheat.y, switch_liquidHeater.u3) annotation (Line(points={{101,-61},
          {141,-61},{141,-38},{158,-38}}, color={0,0,127}));
  connect(zeroheat.y, switch_Q_total1.u3) annotation (Line(points={{101,-61},{110,
          -61},{110,-18},{118,-18}},     color={0,0,127}));
  connect(switch_Q_total1.y, switch_liquidHeater.u1) annotation (Line(points={{141,-10},
          {150,-10},{150,-22},{158,-22}},          color={0,0,127}));
  connect(sensorBus.p_pressurizer, hysteresis.u) annotation (Line(
      points={{-29.9,-99.9},{-29.9,-30},{46,-30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Q_flow_liquidHeater, switch_liquidHeater.y)
    annotation (Line(
      points={{30.1,-99.9},{280,-99.9},{280,-30},{181,-30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(greater5.y, switch_CR.u2) annotation (Line(points={{-47,90},{-36,90},{
          -36,140},{14,140}},  color={255,0,255}));
  connect(T_avg_nominal.y, PID_CR.u_s)
    annotation (Line(points={{-3,120},{54,120}},  color={0,0,127}));
  connect(switch_CR.y, PID_CR.u_m)
    annotation (Line(points={{37,140},{66,140},{66,132}}, color={0,0,127}));
  connect(actuatorBus.reactivity_ControlRod, PID_CR.y) annotation (Line(
      points={{30.1,-99.9},{280,-99.9},{280,120},{77,120}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.SGpump_m_flow, const.y) annotation (
      Line(
      points={{30.1,-99.9},{280,-99.9},{280,30},{51,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(delay_PZRheater.y, greater1.u2) annotation (Line(points={{-87,-30},{-78,
          -30},{-78,-18},{-70,-18}},   color={0,0,127}));
  connect(clock.y, greater1.u1) annotation (Line(points={{-87,70},{-82,70},{-82,
          -10},{-70,-10}},  color={0,0,127}));
  connect(greater1.y, switch_Q_total1.u2) annotation (Line(points={{-47,-10},{118,
          -10}},                     color={255,0,255}));
  connect(sensorBus.m_flow_boilerDrum, FWpump.u) annotation (Line(
      points={{-29.9,-99.9},{14,-99.9},{14,-80},{178,-80}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.FWpump_m_flow, FWpump.y) annotation (Line(
      points={{30.1,-99.9},{280,-99.9},{280,-80},{201,-80}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PHSpump_m_flow, PHSpump.y) annotation (
      Line(
      points={{30.1,-99.9},{280,-99.9},{280,170},{161,170}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Q_total, switch_CR.u1) annotation (Line(
      points={{-29.9,-99.9},{-180,-99.9},{-180,148},{14,148}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.level_drum, level_drum.u) annotation (Line(
      points={{-29.9,-99.9},{26,-99.9},{26,-100},{-180,-100},{-180,-46},{-164,-46}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.m_flow_feedWater, m_flow_feedwater.u) annotation (Line(
      points={{-29.9,-99.9},{26,-99.9},{26,-100},{-180,-100},{-180,-28},{-164,-28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.T_Core_Outlet, T_core_outlet.u) annotation (Line(
      points={{-29.9,-99.9},{26,-99.9},{26,-100},{-180,-100},{-180,18},{-164,18}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.T_Core_Inlet, T_core_inlet.u) annotation (Line(
      points={{-29.9,-99.9},{-29.9,-100},{-180,-100},{-180,32},{-162,32}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_fuelConsumption, m_flowFuelConsumption.u)
    annotation (Line(
      points={{-29.9,-99.9},{26,-99.9},{26,-100},{-180,-100},{-180,64},{-162,64}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.W_balance, W_balance.u) annotation (Line(
      points={{-29.9,-99.9},{26,-99.9},{26,-100},{-180,-100},{-180,78},{-162,78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
      points={{-29.9,-99.9},{-180,-99.9},{-180,96},{-162,96}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="PHS_CS", Icon(coordinateSystem(extent={{-100,-100},
            {100,100}}),                       graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="CS: Tavg/CR/Pressure with start lag")}),
    Diagram(coordinateSystem(extent={{-180,-100},{280,200}})));
end CS_LoadFollow;
