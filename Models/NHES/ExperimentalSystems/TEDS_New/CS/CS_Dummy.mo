within NHES.ExperimentalSystems.TEDS_New.CS;
model CS_Dummy
  "Dummy connections showing all input and output connections, should not be used in simulation"

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Blocks.RealExpression charging_flow_rate
    annotation (Placement(transformation(extent={{-80,56},{-56,78}})));
  TRANSFORM.Blocks.RealExpression T_charge_outlet
    annotation (Placement(transformation(extent={{-80,42},{-56,62}})));
  TRANSFORM.Blocks.RealExpression T_charge_inlet
    annotation (Placement(transformation(extent={{-80,28},{-56,48}})));
  TRANSFORM.Blocks.RealExpression BOP_mass_flow
    annotation (Placement(transformation(extent={{-82,-86},{-58,-66}})));
  Modelica.Blocks.Sources.RealExpression valve_4_opening(y=0.1)
    annotation (Placement(transformation(extent={{0,-10},{24,12}})));
  Modelica.Blocks.Sources.RealExpression valve_2_opening(y=0.25)
    annotation (Placement(transformation(extent={{0,-46},{24,-24}})));
  Modelica.Blocks.Sources.RealExpression valve_1_opening(y=0.1)
    annotation (Placement(transformation(extent={{0,-64},{24,-42}})));
  Modelica.Blocks.Sources.RealExpression valve_3_opening(y=0.0)
    annotation (Placement(transformation(extent={{0,-30},{24,-8}})));
  Modelica.Blocks.Sources.RealExpression valve_5_opening(y=0.0)
    annotation (Placement(transformation(extent={{0,8},{24,30}})));
  Modelica.Blocks.Sources.RealExpression valve_6_opening(y=1.0)
    annotation (Placement(transformation(extent={{0,24},{24,46}})));
  TRANSFORM.Blocks.RealExpression discharging_flow_rate
    annotation (Placement(transformation(extent={{-80,10},{-56,32}})));
  TRANSFORM.Blocks.RealExpression T_discharge_outlet
    annotation (Placement(transformation(extent={{-80,-6},{-56,14}})));
  TRANSFORM.Blocks.RealExpression T_discharge_inlet
    annotation (Placement(transformation(extent={{-80,-20},{-56,0}})));
  TRANSFORM.Blocks.RealExpression chiller_mass_flow
    annotation (Placement(transformation(extent={{-80,-70},{-56,-50}})));
  TRANSFORM.Blocks.RealExpression heater_power_in
    annotation (Placement(transformation(extent={{-82,-52},{-58,-32}})));
  TRANSFORM.Blocks.RealExpression heater_flow_rate
    annotation (Placement(transformation(extent={{-80,-36},{-56,-16}})));
  Modelica.Blocks.Sources.RealExpression pump_outlet_pressure(y=121325)
    annotation (Placement(transformation(extent={{0,40},{24,62}})));
  Modelica.Blocks.Sources.RealExpression heater_power_out(y=200e3)
    annotation (Placement(transformation(extent={{0,56},{24,78}})));
  TRANSFORM.Blocks.RealExpression chromolox_exit_temperature
    annotation (Placement(transformation(extent={{-80,72},{-56,94}})));
  TRANSFORM.Blocks.RealExpression pump_inlet_pressure
    annotation (Placement(transformation(extent={{-80,-102},{-56,-82}})));
equation

  connect(actuatorBus.valve_1_opening, valve_1_opening.y) annotation (Line(
      points={{30,-100},{30,-54},{28,-54},{28,-53},{25.2,-53}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_2_opening, valve_2_opening.y) annotation (Line(
      points={{30,-100},{30,-35},{25.2,-35}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_3_opening, valve_3_opening.y) annotation (Line(
      points={{30,-100},{30,-19},{25.2,-19}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_4_opening, valve_4_opening.y) annotation (Line(
      points={{30,-100},{30,1},{25.2,1}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_5_opening, valve_5_opening.y) annotation (Line(
      points={{30,-100},{30,19},{25.2,19}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.valve_6_opening, valve_6_opening.y) annotation (Line(
      points={{30,-100},{30,35},{25.2,35}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.BOP_mass_flow, BOP_mass_flow.u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-76},{-84.4,-76}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_charge_inlet, T_charge_inlet.u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,38},{-82.4,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_charge_outlet, T_charge_outlet.u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,52},{-82.4,52}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.charging_flow_rate, charging_flow_rate.u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,67},{-82.4,67}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.T_discharge_inlet, T_discharge_inlet.u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-8},{-82.4,-8},{-82.4,-10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_discharge_outlet, T_discharge_outlet.u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,4},{-82.4,4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.discharging_flow_rate, discharging_flow_rate.u) annotation (
     Line(
      points={{-30,-100},{-104,-100},{-104,21},{-82.4,21}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.chiller_mass_flow, chiller_mass_flow.u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-60},{-82.4,-60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.heater_flow_rate, heater_flow_rate.u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-26},{-82.4,-26}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.heater_input, heater_power_in.u) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-42},{-84.4,-42}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.pump_dp, pump_outlet_pressure.y) annotation (Line(
      points={{30,-100},{30,51},{25.2,51}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.heater_power, heater_power_out.y) annotation (Line(
      points={{30,-100},{30,67},{25.2,67}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_Chromolox_Exit, chromolox_exit_temperature.u) annotation
    (Line(
      points={{-30,-100},{-104,-100},{-104,84},{-94,84},{-94,83},{-82.4,83}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.pump_inlet_pressure, pump_inlet_pressure.u) annotation (
      Line(
      points={{-30,-100},{-104,-100},{-104,-92},{-82.4,-92}},
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
end CS_Dummy;
