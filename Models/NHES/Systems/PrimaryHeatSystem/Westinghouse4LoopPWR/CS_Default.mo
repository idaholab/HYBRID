within NHES.Systems.PrimaryHeatSystem.Westinghouse4LoopPWR;
model CS_Default

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
annotation(defaultComponentName="PHS_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="CS: Basic/Default")}));
end CS_Default;
