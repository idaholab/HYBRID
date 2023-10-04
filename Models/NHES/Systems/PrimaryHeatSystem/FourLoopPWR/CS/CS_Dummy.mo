within NHES.Systems.PrimaryHeatSystem.FourLoopPWR.CS;
model CS_Dummy

  extends BaseClasses.Partial_ControlSystem;

  input Real u_CR = 0 annotation(Dialog(group="Inputs"));
  input SI.MassFlowRate u_fwpump = data.m_flow_shellSide_total annotation(Dialog(group="Inputs"));
  input SI.Power u_qflow_liqheater = 0 annotation(Dialog(group="Inputs"));
  input SI.AngularVelocity u_sgpump = 1625 annotation(Dialog(group="Inputs"));
  input SI.MassFlowRate u_PHSm_flow = data.m_flow_nominal annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Sources.RealExpression
                                   ControlRod_Reactivity(y=u_CR)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.RealExpression
                                   Q_flow_liquidHeater(y=u_qflow_liqheater)
    annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));
  Modelica.Blocks.Sources.RealExpression
                                   sgpump(y=u_sgpump)
  annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Sources.RealExpression
                                   FWpump(y=u_fwpump)
  annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
Data.Data_Basic data
  annotation (Placement(transformation(extent={{-10,-88},{10,-68}})));
  Modelica.Blocks.Sources.RealExpression PHSpump(y=u_PHSm_flow)
    annotation (Placement(transformation(extent={{-10,-62},{10,-42}})));
  TRANSFORM.Blocks.RealExpression Q_balance
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  TRANSFORM.Blocks.RealExpression W_balance
    annotation (Placement(transformation(extent={{-40,42},{-20,62}})));
  TRANSFORM.Blocks.RealExpression m_flowFuelConsumption
    annotation (Placement(transformation(extent={{-40,28},{-20,48}})));
  TRANSFORM.Blocks.RealExpression Q_total
    annotation (Placement(transformation(extent={{-42,12},{-22,32}})));
  TRANSFORM.Blocks.RealExpression T_core_inlet
    annotation (Placement(transformation(extent={{-40,-4},{-20,16}})));
  TRANSFORM.Blocks.RealExpression T_core_outlet
    annotation (Placement(transformation(extent={{-42,-18},{-22,2}})));
  TRANSFORM.Blocks.RealExpression p_pressurizer
    annotation (Placement(transformation(extent={{-42,-32},{-22,-12}})));
  TRANSFORM.Blocks.RealExpression m_flowBoilderDrum
    annotation (Placement(transformation(extent={{-42,-48},{-22,-28}})));
  TRANSFORM.Blocks.RealExpression m_flow_feedwater
    annotation (Placement(transformation(extent={{-42,-64},{-22,-44}})));
  TRANSFORM.Blocks.RealExpression level_drum
    annotation (Placement(transformation(extent={{-42,-82},{-22,-62}})));
equation

connect(actuatorBus.reactivity_ControlRod,
  ControlRod_Reactivity.y) annotation (Line(
    points={{30.1,-99.9},{30.1,50},{11,50}},
    color={111,216,99},
    pattern=LinePattern.Dash,
    thickness=0.5));
connect(actuatorBus.SGpump_m_flow, sgpump.y) annotation (
    Line(
    points={{30.1,-99.9},{30.1,20},{11,20}},
    color={111,216,99},
    pattern=LinePattern.Dash,
    thickness=0.5));
connect(actuatorBus.FWpump_m_flow, FWpump.y) annotation (
    Line(
    points={{30.1,-99.9},{30.1,-10},{11,-10}},
    color={111,216,99},
    pattern=LinePattern.Dash,
    thickness=0.5));
connect(actuatorBus.Q_flow_liquidHeater,
  Q_flow_liquidHeater.y) annotation (Line(
    points={{30.1,-99.9},{30.1,-32},{11,-32}},
    color={111,216,99},
    pattern=LinePattern.Dash,
    thickness=0.5));
  connect(actuatorBus.PHSpump_m_flow, PHSpump.y) annotation (
      Line(
      points={{30.1,-99.9},{30.1,-52},{11,-52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
      points={{-29.9,-99.9},{-102,-99.9},{-102,70},{-42,70}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_balance, W_balance.u) annotation (Line(
      points={{-29.9,-99.9},{-102,-99.9},{-102,52},{-42,52}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_fuelConsumption, m_flowFuelConsumption.u)
    annotation (Line(
      points={{-29.9,-99.9},{-102,-99.9},{-102,38},{-42,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Q_total, Q_total.u) annotation (Line(
      points={{-29.9,-99.9},{-102,-99.9},{-102,22},{-44,22}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_Core_Inlet, T_core_inlet.u) annotation (Line(
      points={{-29.9,-99.9},{-102,-99.9},{-102,6},{-42,6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_Core_Outlet, T_core_outlet.u) annotation (Line(
      points={{-29.9,-99.9},{-102,-99.9},{-102,-8},{-44,-8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_pressurizer, p_pressurizer.u) annotation (Line(
      points={{-29.9,-99.9},{-102,-99.9},{-102,-22},{-44,-22}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_boilerDrum, m_flowBoilderDrum.u) annotation (Line(
      points={{-29.9,-99.9},{-102,-99.9},{-102,-38},{-44,-38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_feedWater, m_flow_feedwater.u) annotation (Line(
      points={{-29.9,-99.9},{-102,-99.9},{-102,-54},{-44,-54}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.level_drum, level_drum.u) annotation (Line(
      points={{-29.9,-99.9},{-102,-99.9},{-102,-72},{-44,-72}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="PHS_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="CS: Basic/Default")}));
end CS_Dummy;
