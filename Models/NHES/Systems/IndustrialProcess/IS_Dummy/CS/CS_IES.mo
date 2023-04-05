within NHES.Systems.IndustrialProcess.IS_Dummy.CS;
model CS_IES

  extends BaseClasses.Partial_ControlSystem;

  input Real demand annotation(Dialog(tab="General"));

  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.5)
            annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
  Modelica.Blocks.Sources.RealExpression Demand_block(y=demand)
    annotation (Placement(transformation(extent={{-88,-6},{-68,14}})));
equation

  connect(actuatorBus.ValveOpening, PID.y) annotation (Line(
      points={{30,-100},{30,0},{5,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.m_flow, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-22},{-6,-22},{-6,-12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Demand_block.y, PID.u_s) annotation (Line(points={{-67,4},{-28,4},{
          -28,0},{-18,0}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_IES;
