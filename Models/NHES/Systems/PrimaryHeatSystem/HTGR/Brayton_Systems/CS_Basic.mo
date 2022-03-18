within NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems;
model CS_Basic

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-8,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-40,-64},{-20,-44}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-72,-64},{-52,-44}})));
  Data.Data_CS data(T_Rx_Exit_Ref=1123.15)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  Modelica.Blocks.Sources.RealExpression PR_Compressor(y=0)
    "total thermal power"
    annotation (Placement(transformation(extent={{-4,-100},{8,-88}})));
  TRANSFORM.Blocks.RealExpression Core_M_Flow
    annotation (Placement(transformation(extent={{-4,-90},{8,-76}})));
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
  connect(actuatorBus.PR_Compressor, PR_Compressor.y) annotation (Line(
      points={{30,-100},{20,-100},{20,-94},{8.6,-94}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, Core_M_Flow.u) annotation (Line(
      points={{-30,-100},{-30,-83},{-5.2,-83}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    Documentation(info="<html>
<p>The default Brayton system control only moves control rods to control core outlet temperature. In more complicated systems, it is expected that additional controls may be needed. </p>
</html>"));
end CS_Basic;
