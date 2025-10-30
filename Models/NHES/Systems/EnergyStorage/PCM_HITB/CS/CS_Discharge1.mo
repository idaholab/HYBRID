within NHES.Systems.EnergyStorage.PCM_HITB.CS;
model CS_Discharge1

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.CombiTimeTable signal_position_upper(table=[0,1;
        120000,1; 121000,1; 125000,1; 432000,1])
    annotation (Placement(transformation(extent={{-32,72},{-12,92}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Upper(table=[0,0; 105500,0; 105600,
        0; 125000,0; 125500,0; 432000,0])
    annotation (Placement(transformation(extent={{-32,46},{-12,66}})));
  Modelica.Blocks.Sources.CombiTimeTable signal_position_lower(table=[0,1; 1,1;
        121000,1; 125000,1; 432000,1])
    annotation (Placement(transformation(extent={{-34,-46},{-14,-26}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Lower(table=[0,0; 105500,0; 105600,
        0; 125000,0; 125500,0; 432000,0])
    annotation (Placement(transformation(extent={{-34,-72},{-14,-52}})));
  Modelica.Blocks.Sources.CombiTimeTable Q_Vessel_HT(table=[0,0; 1,0; 121000,0;
        125000,0; 432000,0])
    annotation (Placement(transformation(extent={{-34,2},{-14,22}})));
  TRANSFORM.Blocks.RealExpression T_PCM
    annotation (Placement(transformation(extent={{-78,-32},{-58,-12}})));
  Data.Data_CS data
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation

  connect(actuatorBus.Vessel_Heat_Tape_Power, Q_Vessel_HT.y[1]) annotation (
      Line(
      points={{30,-100},{30,12},{-13,12}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.Lower_Heat_Pipe_Position, signal_position_lower.y[1])
    annotation (Line(
      points={{30,-100},{30,-36},{-13,-36}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Tape_Power, HT_Lower.y[1]) annotation (Line(
      points={{30,-100},{30,-62},{-13,-62}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Tape_Power, HT_Upper.y[1]) annotation (Line(
      points={{30,-100},{30,56},{-11,56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Pipe_Position, signal_position_upper.y[1])
    annotation (Line(
      points={{30,-100},{30,82},{-11,82}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, T_PCM.u) annotation (Line(
      points={{-30,-100},{-66,-100},{-66,-98},{-102,-98},{-102,-22},{-80,-22}},
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
          textString="Discharge 1")}));
end CS_Discharge1;
