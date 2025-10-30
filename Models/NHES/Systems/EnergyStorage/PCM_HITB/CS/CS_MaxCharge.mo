within NHES.Systems.EnergyStorage.PCM_HITB.CS;
model CS_MaxCharge

  extends BaseClasses.Partial_ControlSystem;

  Data.Data_CS data
    annotation (Placement(transformation(extent={{80,82},{100,102}})));
  Modelica.Blocks.Sources.CombiTimeTable signal_position_upper(table=[0,0;
        120000,0; 121000,0; 125000,0; 432000,0])
    annotation (Placement(transformation(extent={{-28,56},{-8,76}})));
  Modelica.Blocks.Sources.CombiTimeTable signal_position_lower(table=[0,0;
        120000,0; 121000,0; 125000,0; 432000,0])
    annotation (Placement(transformation(extent={{-28,-36},{-8,-16}})));
  TRANSFORM.Controls.LimPID HT_Upper(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=data.Q_HT_HP,
    yMin=0.0) annotation (Placement(transformation(extent={{-16,96},{4,116}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Control_Set_Upper(table=[0,673.15;
        105500,673.15; 105600,673.15; 125000,673.15; 125500,673.15; 432000,
        673.15])
    annotation (Placement(transformation(extent={{-48,96},{-28,116}})));
  TRANSFORM.Controls.LimPID Q_Vessel_HT(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    Ti=300,
    Td=0.5,
    yMax=data.Q_PCM_HT_Max/2,
    yMin=0,
    wp=50,
    wd=1,
    Ni=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    xd_start=0,
    y_start=data.Q_PCM_HT_Max/4)
    annotation (Placement(transformation(extent={{-22,16},{-2,36}})));
  Modelica.Blocks.Sources.Ramp           T_Vessel_Measure1(
    height=400 - 30,
    duration=14400,
    offset=273.15 + 30,
    startTime=10)
    annotation (Placement(transformation(extent={{-70,16},{-50,36}})));
  TRANSFORM.Controls.LimPID HT_Lower(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=data.Q_HT_HP,
    yMin=0.0)
    annotation (Placement(transformation(extent={{-28,-66},{-8,-46}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Control_Set_Lower(table=[0,728;
        105500,728; 105600,728; 125000,728; 125500,728; 432000,728])
    annotation (Placement(transformation(extent={{-76,-66},{-56,-46}})));
equation

  connect(T_Vessel_Measure1.y,Q_Vessel_HT. u_s)
    annotation (Line(points={{-49,26},{-24,26}}, color={0,0,127}));
  connect(HT_Control_Set_Upper.y[1],HT_Upper. u_s) annotation (Line(points={{-27,106},
          {-18,106}},                          color={0,0,127}));
  connect(HT_Control_Set_Lower.y[1],HT_Lower. u_s) annotation (Line(points={{-55,-56},
          {-30,-56}},                             color={0,0,127}));
  connect(actuatorBus.Lower_Heat_Tape_Power, HT_Lower.y) annotation (Line(
      points={{30,-100},{30,-56},{-7,-56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Pipe_Position, signal_position_lower.y[1])
    annotation (Line(
      points={{30,-100},{30,-28},{-7,-28},{-7,-26}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Vessel_Heat_Tape_Power, Q_Vessel_HT.y) annotation (Line(
      points={{30,-100},{30,26},{-1,26}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Pipe_Position, signal_position_upper.y[1])
    annotation (Line(
      points={{30,-100},{30,-76},{28,-76},{28,66},{-7,66}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Tape_Power, HT_Upper.y) annotation (Line(
      points={{30,-100},{30,106},{5,106}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HT_Lower.u_m) annotation (Line(
      points={{-30,-100},{-30,-76},{-18,-76},{-18,-68}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, Q_Vessel_HT.u_m) annotation (Line(
      points={{-30,-100},{-112,-100},{-112,0},{-12,0},{-12,14}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HT_Upper.u_m) annotation (Line(
      points={{-30,-100},{-112,-100},{-112,84},{-6,84},{-6,94}},
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
          textString="Total Comparison")}));
end CS_MaxCharge;
