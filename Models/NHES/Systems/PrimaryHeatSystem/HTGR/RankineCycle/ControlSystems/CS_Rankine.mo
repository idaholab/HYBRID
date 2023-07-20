within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Rankine

  extends RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-7,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{80,40},{100,20}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Data.CS_HTGR_Pebble_RankineCycle data(T_Rx_Exit_Ref=1023.15, m_flow_nom=
        300)
    annotation (Placement(transformation(extent={{-98,84},{-84,98}})));
  TRANSFORM.Controls.LimPID     CR1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-2,
    Ti=15,
    yMin=50,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{80,90},{100,70}})));
  Modelica.Blocks.Sources.Constant const2(k=data.m_flow_nom)
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  TRANSFORM.Blocks.RealExpression coreOutlet_temp
    annotation (Placement(transformation(extent={{-100,54},{-76,66}})));
  TRANSFORM.Blocks.RealExpression core_massflow
    annotation (Placement(transformation(extent={{-100,14},{-76,26}})));
  Modelica.Blocks.Sources.RealExpression divertValve_position(y=0)
    annotation (Placement(transformation(extent={{76,-36},{100,-24}})));
  Modelica.Blocks.Sources.RealExpression feedPump_speed(y=0)
    annotation (Placement(transformation(extent={{76,-46},{100,-34}})));
  Modelica.Blocks.Sources.RealExpression TBV_position(y=0)
    annotation (Placement(transformation(extent={{76,-56},{100,-44}})));
  Modelica.Blocks.Sources.RealExpression TCV_position(y=0)
    annotation (Placement(transformation(extent={{76,-66},{100,-54}})));
  Modelica.Blocks.Sources.RealExpression feedWaterPump_mass(y=0)
    annotation (Placement(transformation(extent={{76,-76},{100,-64}})));
equation

  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{124,-100},{124,30},{101,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_T, coreOutlet_temp.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,60},{-102.4,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, core_massflow.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,20},{-102.4,20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Mass_Flow, CR1.u_m) annotation (Line(
      points={{-30,-100},{-30,100},{90,100},{90,92}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,50},{90,50},{90,42}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, CR1.y) annotation (Line(
      points={{30,-100},{124,-100},{124,80},{101,80}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const1.y, CR.u_s)
    annotation (Line(points={{61,30},{78,30}}, color={0,0,127}));
  connect(const2.y, CR1.u_s)
    annotation (Line(points={{61,80},{78,80}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine;
