within NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems;
model CS_Basic_Transient_Example
  "Example running 10% ramps for two out of four hours."

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-8,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-40,-64},{-20,-44}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-72,-64},{-52,-44}})));
  Data.CS_HTGR_Pebble_BraytonCycle data(T_Rx_Exit_Ref=1123.15)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  TRANSFORM.Blocks.RealExpression Core_M_Flow
    annotation (Placement(transformation(extent={{-4,-90},{8,-76}})));
  TRANSFORM.Controls.LimPID Mass_Flow_Cont(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-8,
    Ti=15,
    yMax=200,
    yMin=-280,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=-54e6,
    rising=300,
    width=6900,
    falling=300,
    period=14400,
    offset=540e6,
    startTime=3600)
    annotation (Placement(transformation(extent={{-76,-10},{-56,10}})));
  Modelica.Blocks.Sources.Constant const2(k=300)
    annotation (Placement(transformation(extent={{-40,22},{-20,42}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{2,10},{22,30}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-51,-54},{-42,-54}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{30,-54},{-19,-54}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, Core_M_Flow.u) annotation (Line(
      points={{-30,-100},{-30,-83},{-5.2,-83}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(trapezoid.y,Mass_Flow_Cont. u_s) annotation (Line(points={{-55,0},{
          -42,0}},                       color={0,0,127}));
  connect(Mass_Flow_Cont.y,add. u2) annotation (Line(points={{-19,0},{-6,0},{-6,
          14},{0,14}},          color={0,0,127}));
  connect(const2.y,add. u1) annotation (Line(points={{-19,32},{-6,32},{-6,26},{
          0,26}},     color={0,0,127}));
  connect(sensorBus.Turbine_Power, Mass_Flow_Cont.u_m) annotation (Line(
      points={{-30,-100},{-100,-100},{-100,-18},{-30,-18},{-30,-12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, add.y) annotation (Line(
      points={{30,-100},{30,20},{23,20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    Documentation(info="<html>
<p>The default Brayton system control only moves control rods to control core outlet temperature. In more complicated systems, it is expected that additional controls may be needed. </p>
</html>"));
end CS_Basic_Transient_Example;
