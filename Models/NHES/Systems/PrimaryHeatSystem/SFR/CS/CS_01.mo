within NHES.Systems.PrimaryHeatSystem.SFR.CS;
model CS_01

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID CR(k=5e-6, initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-20,-36},{0,-16}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=741.483)
    annotation (Placement(transformation(extent={{-56,-36},{-36,-16}})));
  Modelica.Blocks.Sources.Constant
                            CR1(k=1500)
    annotation (Placement(transformation(extent={{-20,2},{0,22}})));
  TRANSFORM.Controls.LimPID PCPs(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=5,
    yMax=1500,
    yMin=-1000,
    initType=Modelica.Blocks.Types.Init.InitialOutput) "Primary coolant pumps"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=2550)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{14,20},{34,40}})));
  TRANSFORM.Blocks.RealExpression IHX_Outlet_Temperature
    annotation (Placement(transformation(extent={{-52,-2},{-32,18}})));
equation

  connect(CR.u_s,realExpression. y)
    annotation (Line(points={{-22,-26},{-35,-26}},
                                               color={0,0,127}));
  connect(sensorBus.Core_Outlet_Temp, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-44},{-10,-44},{-10,-38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{30,-26},{1,-26}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PCPs.u_s, realExpression1.y)
    annotation (Line(points={{-22,50},{-39,50}}, color={0,0,127}));
  connect(CR1.y, add.u2)
    annotation (Line(points={{1,12},{6,12},{6,24},{12,24}}, color={0,0,127}));
  connect(PCPs.y, add.u1)
    annotation (Line(points={{1,50},{6,50},{6,36},{12,36}}, color={0,0,127}));
  connect(actuatorBus.Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{30,8},{48,8},{48,28},{35,28},{35,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.PrimaryMassFlow, PCPs.u_m) annotation (Line(
      points={{-30,-100},{-82,-100},{-82,30},{-10,30},{-10,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.IHX_Outlet_Temp, IHX_Outlet_Temperature.u) annotation (Line(
      points={{-30,-100},{-82,-100},{-82,8},{-54,8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_01;
