within NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS;
model CS_Dummy

  extends BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  Modelica.Blocks.Sources.Constant ControlRod_Reactivity(k=0)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.Constant Other_Reactivity(k=0)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Sources.Constant S_external(k=0)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Blocks.Sources.Constant speedPump(k=1500)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Sources.Constant Q_flow_liquidHeater(k=0)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Blocks.Sources.Constant m_feed_pump(k=0)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  TRANSFORM.Blocks.RealExpression Q_balance
    annotation (Placement(transformation(extent={{-60,78},{-40,98}})));
  TRANSFORM.Blocks.RealExpression W_balance
    annotation (Placement(transformation(extent={{-60,64},{-40,84}})));
  TRANSFORM.Blocks.RealExpression m_flowconsumption
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  TRANSFORM.Blocks.RealExpression Q_total
    annotation (Placement(transformation(extent={{-60,34},{-40,54}})));
  TRANSFORM.Blocks.RealExpression T_Core_Inlet
    annotation (Placement(transformation(extent={{-60,18},{-40,38}})));
  TRANSFORM.Blocks.RealExpression T_Core_Outlet
    annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
  TRANSFORM.Blocks.RealExpression SG_Inlet_enthalpy
    annotation (Placement(transformation(extent={{-60,-32},{-40,-12}})));
  TRANSFORM.Blocks.RealExpression p_pressurizer
    annotation (Placement(transformation(extent={{-60,-16},{-40,4}})));
  TRANSFORM.Blocks.RealExpression T_SG_Exit
    annotation (Placement(transformation(extent={{-60,-64},{-40,-44}})));
  TRANSFORM.Blocks.RealExpression Feedwater_mass_flow
    annotation (Placement(transformation(extent={{-60,-78},{-40,-58}})));
  TRANSFORM.Blocks.RealExpression SG_Outlet_Enthalpy
    annotation (Placement(transformation(extent={{-60,-48},{-40,-28}})));
equation

  connect(actuatorBus.speedPump, speedPump.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,-52},{30.1,-40},{11,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Q_flow_liquidHeater, Q_flow_liquidHeater.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,-70},{11,-70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.reactivity_ControlRod, ControlRod_Reactivity.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,50},{11,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.reactivity_Other, Other_Reactivity.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,8},{30.1,20},{11,20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Q_S_External, S_external.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,-10},{11,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.mfeedpump, m_feed_pump.y) annotation (Line(
      points={{30,-100},{30,80},{11,80}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
      points={{-29.9,-99.9},{-30,-99.9},{-30,-100},{-92,-100},{-92,88},{-62,88}},

      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_balance, W_balance.u) annotation (Line(
      points={{-29.9,-99.9},{-30,-99.9},{-30,-100},{-92,-100},{-92,74},{-62,74}},

      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_fuelConsumption, m_flowconsumption.u) annotation (
      Line(
      points={{-29.9,-99.9},{-29.9,-100},{-92,-100},{-92,60},{-62,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Q_total, Q_total.u) annotation (Line(
      points={{-29.9,-99.9},{-64,-99.9},{-64,-100},{-92,-100},{-92,44},{-62,44}},

      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_Core_Inlet, T_Core_Inlet.u) annotation (Line(
      points={{-29.9,-99.9},{-92,-99.9},{-92,28},{-62,28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_Core_Outlet, T_Core_Outlet.u) annotation (Line(
      points={{-29.9,-99.9},{-92,-99.9},{-92,12},{-62,12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.p_pressurizer, p_pressurizer.u) annotation (Line(
      points={{-29.9,-99.9},{-30,-99.9},{-30,-100},{-92,-100},{-92,-6},{-62,-6}},

      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SG_Inlet_Enthalpy, SG_Inlet_enthalpy.u) annotation (Line(
      points={{-30,-100},{-92,-100},{-92,-22},{-62,-22}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.SG_Outlet_enthalpy, SG_Outlet_Enthalpy.u) annotation (Line(
      points={{-30,-100},{-92,-100},{-92,-38},{-62,-38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_exit_SG, T_SG_Exit.u) annotation (Line(
      points={{-30,-100},{-92,-100},{-92,-54},{-62,-54}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.secondary_side_massflow, Feedwater_mass_flow.u) annotation
    (Line(
      points={{-30,-100},{-92,-100},{-92,-68},{-62,-68}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="PHS_CS");
end CS_Dummy;
