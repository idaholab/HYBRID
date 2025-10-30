within NHES.Systems.EnergyStorage.PCM_HITB.CS;
model CS_Dummy

  extends BaseClasses.Partial_ControlSystem;

  Data.Data_CS data
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.Constant       signal_position_upper(k=0.0)
    annotation (Placement(transformation(extent={{-8,74},{12,94}})));
  Modelica.Blocks.Sources.Trapezoid      HT_Upper(
    amplitude=data.Q_HT_HP,
    rising=900,
    width=20700,
    falling=900,
    period=43200,
    startTime=23400)
    annotation (Placement(transformation(extent={{-10,42},{10,62}})));
  Modelica.Blocks.Sources.Constant       signal_position_lower(k=1.0)
    annotation (Placement(transformation(extent={{-10,-32},{10,-12}})));
  Modelica.Blocks.Sources.Trapezoid      HT_Lower(
    amplitude=data.Q_HT_HP,
    rising=900,
    width=20700,
    falling=900,
    period=43200,
    startTime=18000)
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Blocks.Sources.Trapezoid      Q_Vessel_HT(
    amplitude=data.Q_PCM_HT_Max/2,
    rising=900,
    width=35100,
    falling=900,
    period=86400,
    startTime=3600)
    annotation (Placement(transformation(extent={{-10,4},{10,24}})));
  TRANSFORM.Blocks.RealExpression T_PCM
    annotation (Placement(transformation(extent={{-72,-16},{-52,4}})));
equation

  connect(sensorBus.T_PCM,T_PCM. u) annotation (Line(
      points={{-30,-100},{-60,-100},{-60,-82},{-96,-82},{-96,-6},{-74,-6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Pipe_Position, signal_position_lower.y)
    annotation (Line(
      points={{30,-100},{30,-76},{-14,-76},{-14,-36},{18,-36},{18,-22},{11,-22}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Pipe_Position, signal_position_upper.y)
    annotation (Line(
      points={{30,-100},{30,84},{13,84}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Tape_Power, HT_Upper.y) annotation (Line(
      points={{30,-100},{30,52},{11,52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Vessel_Heat_Tape_Power, Q_Vessel_HT.y) annotation (Line(
      points={{30,-100},{30,14},{11,14}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Tape_Power, HT_Lower.y) annotation (Line(
      points={{30,-100},{32,-100},{32,-60},{11,-60}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS");
end CS_Dummy;
