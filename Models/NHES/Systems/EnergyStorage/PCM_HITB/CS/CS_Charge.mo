within NHES.Systems.EnergyStorage.PCM_HITB.CS;
model CS_Charge

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.CombiTimeTable signal_position_lower(table=[0,0;
        120000,0; 121000,0; 125000,0; 432000,0])
    annotation (Placement(transformation(extent={{-24,-18},{-4,2}})));
  Modelica.Blocks.Logical.Switch HP_Switch1
    annotation (Placement(transformation(extent={{-66,-52},{-46,-32}})));
  TRANSFORM.Controls.LimPID HT_Lower(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=data.Q_HT_HP,
    yMin=0.0)
    annotation (Placement(transformation(extent={{-26,-52},{-6,-32}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Control_Set_Lower(table=[0,728;
        105500,728; 105600,728; 125000,728; 125500,728; 432000,728])
    annotation (Placement(transformation(extent={{-118,-76},{-98,-56}})));
  Modelica.Blocks.Logical.Switch HP_Switch
    annotation (Placement(transformation(extent={{-54,104},{-34,124}})));
  Modelica.Blocks.Sources.BooleanStep       booleanStep(startTime=85000,
      startValue=true)
    annotation (Placement(transformation(extent={{-104,122},{-84,142}})));
  TRANSFORM.Controls.LimPID HT_Upper(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=data.Q_HT_HP,
    yMin=0.0) annotation (Placement(transformation(extent={{-16,106},{4,126}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Control_Set_Upper(table=[0,728.15;
        105500,728; 105600,728; 125000,728; 125500,728; 432000,728])
    annotation (Placement(transformation(extent={{-104,96},{-84,116}})));
  TRANSFORM.Controls.LimPID Q_Vessel_HT(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    Ti=300,
    Td=0.5,
    yMax=data.Q_PCM_HT_Max/2,
    yMin=0,
    wp=50,
    wd=5,
    Ni=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    xd_start=0,
    y_start=400)
    annotation (Placement(transformation(extent={{-24,24},{-4,44}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure1(y=673.15)
    annotation (Placement(transformation(extent={{-72,24},{-52,44}})));
  Modelica.Blocks.Sources.CombiTimeTable signal_position_upper(table=[0,0;
        120000,0; 121000,0; 125000,0; 432000,0])
    annotation (Placement(transformation(extent={{-24,58},{-4,78}})));
  Modelica.Blocks.Sources.BooleanStep       booleanStep1(startTime=85000,
      startValue=true)
    annotation (Placement(transformation(extent={{-118,-52},{-98,-32}})));
  Data.Data_CS data
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation

  connect(booleanStep1.y,HP_Switch1. u2)
    annotation (Line(points={{-97,-42},{-68,-42}},
                                                 color={255,0,255}));
  connect(HT_Control_Set_Lower.y[1],HP_Switch1. u3) annotation (Line(points={{-97,-66},
          {-76,-66},{-76,-50},{-68,-50}},                       color={0,0,127}));
  connect(HP_Switch1.y,HT_Lower. u_s) annotation (Line(points={{-45,-42},{-28,
          -42}},                                   color={0,0,127}));
  connect(booleanStep.y,HP_Switch. u2)
    annotation (Line(points={{-83,132},{-72,132},{-72,114},{-56,114}},
                                              color={255,0,255}));
  connect(T_Vessel_Measure1.y,Q_Vessel_HT. u_s)
    annotation (Line(points={{-51,34},{-26,34}}, color={0,0,127}));
  connect(HT_Control_Set_Upper.y[1],HP_Switch. u3) annotation (Line(points={{-83,106},
          {-56,106}},                                     color={0,0,127}));
  connect(HP_Switch.y,HT_Upper. u_s) annotation (Line(points={{-33,114},{-32,
          116},{-18,116}},                 color={0,0,127}));
  connect(sensorBus.T_PCM, HT_Lower.u_m) annotation (Line(
      points={{-30,-100},{-30,-70},{-16,-70},{-16,-54}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, Q_Vessel_HT.u_m) annotation (Line(
      points={{-30,-100},{-142,-100},{-142,12},{-14,12},{-14,22}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HT_Upper.u_m) annotation (Line(
      points={{-30,-100},{-142,-100},{-142,92},{-6,92},{-6,104}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Tape_Power, HT_Lower.y) annotation (Line(
      points={{30,-100},{28,-100},{28,-40},{26,-40},{26,-42},{-5,-42}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Pipe_Position, signal_position_lower.y[1])
    annotation (Line(
      points={{30,-100},{28,-100},{28,-8},{-3,-8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Vessel_Heat_Tape_Power, Q_Vessel_HT.y) annotation (Line(
      points={{30,-100},{28,-100},{28,32},{-3,32},{-3,34}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Pipe_Position, signal_position_upper.y[1])
    annotation (Line(
      points={{30,-100},{28,-100},{28,74},{26,74},{26,68},{-3,68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Tape_Power, HT_Upper.y) annotation (Line(
      points={{30,-100},{28,-100},{28,116},{5,116}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HP_Switch1.u1) annotation (Line(
      points={{-30,-100},{-142,-100},{-142,-18},{-78,-18},{-78,-34},{-68,-34}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HP_Switch.u1) annotation (Line(
      points={{-30,-100},{-142,-100},{-142,156},{-68,156},{-68,122},{-56,122}},
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
          textString="Maximum Charge")}));
end CS_Charge;
