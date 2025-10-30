within NHES.Systems.EnergyStorage.PCM_HITB.CS;
model CS_Discharge2

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.CombiTimeTable signal_position_upper(table=[0,0.5;
        120000,0.5; 121000,0.5; 125000,0.5; 432000,0.5])
    annotation (Placement(transformation(extent={{-50,86},{-30,106}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Upper_Table(table=[0,0; 105500,0;
        105600,0; 125000,0; 125500,0; 432000,0])
    annotation (Placement(transformation(extent={{-50,58},{-30,78}})));
  Modelica.Blocks.Sources.CombiTimeTable signal_position_lower(table=[0,1; 1,1;
        121000,1; 125000,1; 432000,1])
    annotation (Placement(transformation(extent={{-48,-8},{-28,12}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Lower_Table(table=[0,0; 105500,0;
        105600,0; 125000,0; 125500,0; 432000,0])
    annotation (Placement(transformation(extent={{-48,-38},{-28,-18}})));
  Modelica.Blocks.Sources.Ramp Q_Vessel_HT(
    height=0,
    duration=12000,
    offset=0,
    startTime=3000)
    annotation (Placement(transformation(extent={{-48,26},{-28,46}})));
  TRANSFORM.Blocks.RealExpression T_PCM
    annotation (Placement(transformation(extent={{-84,-24},{-64,-4}})));
  Data.Data_CS data
    annotation (Placement(transformation(extent={{78,80},{98,100}})));
equation

  connect(actuatorBus.Lower_Heat_Pipe_Position, signal_position_lower.y[1])
    annotation (Line(
      points={{30,-100},{30,0},{28,0},{28,2},{-27,2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Pipe_Position, signal_position_upper.y[1])
    annotation (Line(
      points={{30,-100},{30,96},{-29,96}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Tape_Power, HT_Lower_Table.y[1]) annotation (
      Line(
      points={{30,-100},{30,-28},{-27,-28}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Vessel_Heat_Tape_Power, Q_Vessel_HT.y) annotation (Line(
      points={{30,-100},{30,36},{-27,36}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Tape_Power, HT_Upper_Table.y[1]) annotation (
      Line(
      points={{30,-100},{30,68},{-29,68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, T_PCM.u) annotation (Line(
      points={{-30,-100},{-30,-42},{-96,-42},{-96,-14},{-86,-14}},
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
          textString="Discharge 2")}));
end CS_Discharge2;
