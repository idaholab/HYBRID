within NHES.Systems.EnergyStorage.PCM_HITB.CS;
model CS_Calibrate1

  extends BaseClasses.Partial_ControlSystem;

  Modelica.Blocks.Sources.CombiTimeTable signal_position_upper(table=[0,0;
        120000,0; 121000,0; 125000,0; 432000,0])
    annotation (Placement(transformation(extent={{-22,80},{-2,100}})));
  Modelica.Blocks.Sources.CombiTimeTable signal_position_lower(table=[0,0;
        120000,0; 121000,0; 125000,0; 432000,0])
    annotation (Placement(transformation(extent={{-16,-38},{4,-18}})));
  Modelica.Blocks.Logical.Switch HP_Switch
    annotation (Placement(transformation(extent={{-56,32},{-36,52}})));
  Modelica.Blocks.Sources.BooleanStep       booleanStep(startTime=991300,
      startValue=true)
    annotation (Placement(transformation(extent={{-106,50},{-86,70}})));
  TRANSFORM.Controls.LimPID HT_Upper(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=data.Q_HT_HP,
    yMin=0.0) annotation (Placement(transformation(extent={{-14,54},{6,34}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Control_Set_Upper(table=[0,733.15;
        105500,733.15; 105600,733.15; 125000,733.15; 125500,733.15; 432000,
        733.15])
    annotation (Placement(transformation(extent={{-106,20},{-86,40}})));
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
    y_start=0)
    annotation (Placement(transformation(extent={{-54,-6},{-34,14}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure1(y=673.15)
    annotation (Placement(transformation(extent={{-92,-6},{-72,14}})));
  Modelica.Blocks.Logical.Switch HP_Switch1
    annotation (Placement(transformation(extent={{-64,-68},{-44,-48}})));
  Modelica.Blocks.Sources.BooleanStep       booleanStep1(startTime=91300,
      startValue=true)
    annotation (Placement(transformation(extent={{-114,-66},{-94,-46}})));
  TRANSFORM.Controls.LimPID HT_Lower(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=data.Q_HT_HP,
    yMin=0.0)
    annotation (Placement(transformation(extent={{-16,-68},{4,-48}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Control_Set_Lower(table=[0,733.15;
        105500,733.15; 105600,733.15; 125000,733.15; 125500,733.15; 432000,
        73315])
    annotation (Placement(transformation(extent={{-118,-96},{-98,-76}})));
  Data.Data_CS data
    annotation (Placement(transformation(extent={{62,70},{82,90}})));
equation

  connect(booleanStep.y,HP_Switch. u2)
    annotation (Line(points={{-85,60},{-68,60},{-68,42},{-58,42}},
                                              color={255,0,255}));
  connect(T_Vessel_Measure1.y,Q_Vessel_HT. u_s)
    annotation (Line(points={{-71,4},{-56,4}},   color={0,0,127}));
  connect(HT_Control_Set_Upper.y[1],HP_Switch. u3) annotation (Line(points={{-85,30},
          {-72,30},{-72,34},{-58,34}},                    color={0,0,127}));
  connect(HP_Switch.y,HT_Upper. u_s) annotation (Line(points={{-35,42},{-26,42},
          {-26,44},{-16,44}},              color={0,0,127}));
  connect(booleanStep1.y,HP_Switch1. u2)
    annotation (Line(points={{-93,-56},{-74,-56},{-74,-58},{-66,-58}},
                                                 color={255,0,255}));
  connect(HT_Control_Set_Lower.y[1],HP_Switch1. u3) annotation (Line(points={{-97,-86},
          {-74,-86},{-74,-66},{-66,-66}},                       color={0,0,127}));
  connect(HP_Switch1.y,HT_Lower. u_s) annotation (Line(points={{-43,-58},{-18,
          -58}},                                   color={0,0,127}));
  connect(sensorBus.T_PCM, HT_Lower.u_m) annotation (Line(
      points={{-30,-100},{-54,-100},{-54,-78},{-6,-78},{-6,-70}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HP_Switch1.u1) annotation (Line(
      points={{-30,-100},{-128,-100},{-128,-30},{-84,-30},{-84,-40},{-66,-40},{
          -66,-50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, Q_Vessel_HT.u_m) annotation (Line(
      points={{-30,-100},{-128,-100},{-128,-30},{-44,-30},{-44,-8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HT_Upper.u_m) annotation (Line(
      points={{-30,-100},{-128,-100},{-128,74},{-4,74},{-4,56}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HP_Switch.u1) annotation (Line(
      points={{-30,-100},{-30,-78},{-54,-78},{-54,-100},{-128,-100},{-128,74},{
          -62,74},{-62,50},{-58,50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Tape_Power, HT_Lower.y) annotation (Line(
      points={{30,-100},{30,-76},{12,-76},{12,-58},{5,-58}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Pipe_Position, signal_position_lower.y[1])
    annotation (Line(
      points={{30,-100},{30,-28},{5,-28}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Vessel_Heat_Tape_Power, Q_Vessel_HT.y) annotation (Line(
      points={{30,-100},{30,4},{-33,4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Pipe_Position, signal_position_upper.y[1])
    annotation (Line(
      points={{30,-100},{30,90},{-1,90}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Tape_Power, HT_Upper.y) annotation (Line(
      points={{30,-100},{30,44},{7,44}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Calibrate 1")}));
end CS_Calibrate1;
