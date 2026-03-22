within NHES.Systems.EnergyStorage.PCM_HITB.CS;
model CS_Calibrate2

  extends BaseClasses.Partial_ControlSystem;

  Data.Data_CS data
    annotation (Placement(transformation(extent={{72,70},{92,90}})));
  Modelica.Blocks.Sources.CombiTimeTable signal_position_lower(table=[0,0;
        120000,0; 121000,0; 125000,0; 432000,0])
    annotation (Placement(transformation(extent={{-28,-86},{-8,-66}})));
  Modelica.Blocks.Logical.Switch HP_Switch1
    annotation (Placement(transformation(extent={{-54,-66},{-34,-46}})));
  Modelica.Blocks.Sources.BooleanStep       booleanStep1(startTime=13000,
      startValue=true)
    annotation (Placement(transformation(extent={{-100,-66},{-80,-46}})));
  TRANSFORM.Controls.LimPID HT_Lower(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=data.Q_HT_HP,
    yMin=0.0)
    annotation (Placement(transformation(extent={{-2,-46},{18,-66}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Control_Set_Lower(table=[0,373.15;
        11300,373.15; 105600,373.15; 125000,373.15; 125500,373.15; 432000,
        373.15])
    annotation (Placement(transformation(extent={{-100,-98},{-80,-78}})));
  Modelica.Blocks.Sources.CombiTimeTable signal_position_upper(table=[0,0;
        120000,0; 121000,0; 125000,0; 432000,0])
    annotation (Placement(transformation(extent={{-26,44},{-6,64}})));
  Modelica.Blocks.Logical.Switch HP_Switch
    annotation (Placement(transformation(extent={{-48,74},{-28,94}})));
  Modelica.Blocks.Sources.BooleanStep       booleanStep(startTime=991300,
      startValue=true)
    annotation (Placement(transformation(extent={{-98,74},{-78,94}})));
  TRANSFORM.Controls.LimPID HT_Upper(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=data.Q_HT_HP,
    yMin=0.0) annotation (Placement(transformation(extent={{-12,96},{8,76}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Control_Set_Upper(table=[0,273.15;
        105500,273.15; 105600,273.15; 125000,373.15; 125500,373.15; 432000,
        373.15])
    annotation (Placement(transformation(extent={{-88,36},{-68,56}})));
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
    annotation (Placement(transformation(extent={{-40,2},{-20,22}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure1(y=273.15)
    annotation (Placement(transformation(extent={{-76,-2},{-56,18}})));
equation

  connect(booleanStep1.y,HP_Switch1. u2)
    annotation (Line(points={{-79,-56},{-56,-56}},
                                                 color={255,0,255}));
  connect(HT_Control_Set_Lower.y[1],HP_Switch1. u3) annotation (Line(points={{-79,-88},
          {-64,-88},{-64,-64},{-56,-64}},                       color={0,0,127}));
  connect(HP_Switch1.y,HT_Lower. u_s) annotation (Line(points={{-33,-56},{-4,
          -56}},                                   color={0,0,127}));
  connect(booleanStep.y,HP_Switch. u2)
    annotation (Line(points={{-77,84},{-50,84}},
                                              color={255,0,255}));
  connect(HT_Control_Set_Upper.y[1],HP_Switch. u3) annotation (Line(points={{-67,46},
          {-58,46},{-58,76},{-50,76}},                    color={0,0,127}));
  connect(HP_Switch.y,HT_Upper. u_s) annotation (Line(points={{-27,84},{-26,86},
          {-14,86}},                       color={0,0,127}));
  connect(T_Vessel_Measure1.y,Q_Vessel_HT. u_s)
    annotation (Line(points={{-55,8},{-48,8},{-48,12},{-42,12}},
                                                 color={0,0,127}));
  connect(sensorBus.T_PCM, Q_Vessel_HT.u_m) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-34},{-30,-34},{-30,0}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HT_Lower.u_m) annotation (Line(
      points={{-30,-100},{-136,-100},{-136,-34},{8,-34},{8,-44}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HP_Switch1.u1) annotation (Line(
      points={{-30,-100},{-136,-100},{-136,-34},{-68,-34},{-68,-48},{-56,-48}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HT_Upper.u_m) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-34},{-138,-34},{-138,110},{-2,110},
          {-2,98}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_PCM, HP_Switch.u1) annotation (Line(
      points={{-30,-100},{-104,-100},{-104,-34},{-138,-34},{-138,110},{-58,110},
          {-58,92},{-50,92}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Tape_Power, HT_Lower.y) annotation (Line(
      points={{30,-100},{30,-56},{19,-56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Pipe_Position, signal_position_lower.y[1])
    annotation (Line(
      points={{30,-100},{30,-76},{-7,-76}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Pipe_Position, signal_position_upper.y[1])
    annotation (Line(
      points={{30,-100},{30,54},{-5,54}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Tape_Power, HT_Upper.y) annotation (Line(
      points={{30,-100},{30,86},{9,86}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Vessel_Heat_Tape_Power, Q_Vessel_HT.y) annotation (Line(
      points={{30,-100},{30,-6},{-16,-6},{-16,12},{-19,12}},
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
          textString="Calibrate 2")}));
end CS_Calibrate2;
