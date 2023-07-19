within NHES.Systems.EnergyStorage.SensibleHeatStorage;
package ControlSystems
  model CS_Typical_Summer_Day

    extends BaseClasses.Partial_ControlSystem;

    Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,100; 3600,
          100; 7200,88.63; 10800,83.26; 14400,76.54; 18000,73.86; 21600,76.55;
          25200,85.51; 28800,87.59; 32400,86.62; 36000,86.32; 39600,93.37; 43200,
          93.09; 46800,96.5; 50400,97.78; 54000,100.15; 57600,102.24; 61200,
          105.44; 64800,107.97; 68400,115.02; 72000,116.83; 75600,112.8; 79200,
          111.46; 82800,102.06; 86400,95.34; 90000,91.31; 93600,88.63])
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    TRANSFORM.Blocks.RealExpression Q_balance
      annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
    TRANSFORM.Blocks.RealExpression W_balance
      annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
  equation

    connect(actuatorBus.Demand, ReactorDemandSimulator.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-98},{120,-98},{120,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_balance, W_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,28},{-102.4,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="ES_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Typical_Summer_Day;

  model CS_5PercentNominal
    Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,100; 3600,
          81.9; 7200,76.9; 10800,70.7; 14400,68.2; 18000,70.7; 21600,84.38; 25200,
          93.06; 28800,95.5; 32400,96.78; 36000,101.75; 39600,102.99; 43200,
          106.71; 46800,107.95; 50400,109.2; 54000,110.43; 57600,112.9; 61200,
          111.67; 64800,109.195; 68400,107.95; 72000,104.23; 75600,103; 79200,
          94.3; 82800,88.1; 86400,84.37; 90000,81.9; 93600,100])
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));

    extends BaseClasses.Partial_ControlSystem;

    TRANSFORM.Blocks.RealExpression Q_balance
      annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
    TRANSFORM.Blocks.RealExpression W_balance
      annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
  equation

    connect(actuatorBus.Demand, ReactorDemandSimulator.y) annotation (Line(
        points={{30.1,-99.9},{122,-99.9},{122,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_balance, W_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,28},{-102.4,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="ES_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_5PercentNominal;

  model CS_20PercentNominal
    Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,100; 3600,
          100; 7200,95; 10800,85; 14400,80; 18000,80; 21600,80; 25200,80; 28800,
          95; 32400,100; 36000,105; 39600,115; 43200,120; 46800,120; 50400,120;
          54000,120; 57600,120; 61200,115; 64800,105; 68400,110; 72000,100; 75600,
          105; 79200,95; 82800,100; 86400,115; 90000,100; 93600,100; 97200,120;
          100800,120; 104400,120; 108000,120; 111600,120])
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));

    extends BaseClasses.Partial_ControlSystem;

    TRANSFORM.Blocks.RealExpression Q_balance
      annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
    TRANSFORM.Blocks.RealExpression W_balance
      annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
  equation

    connect(actuatorBus.Demand, ReactorDemandSimulator.y) annotation (Line(
        points={{30.1,-99.9},{120,-99.9},{120,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_balance, W_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,28},{-102.4,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="ES_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_20PercentNominal;

  model CS_BOPSetpoint

    extends BaseClasses.Partial_ControlSystem;

    parameter SI.Power Q_nominal "Nominal power for BOP for zero flow to energy storage";
    input SI.Power W_totalSetpoint "Total setpoint power from BOP from SC" annotation(Dialog(group="Inputs"));

    Modelica.Blocks.Math.Gain gain(k=100)
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    Modelica.Blocks.Math.Division division
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    Modelica.Blocks.Sources.Constant const(k=Q_nominal)
      annotation (Placement(transformation(extent={{6,-16},{26,4}})));
    Modelica.Blocks.Sources.RealExpression W_totalSetpoint_BOP(y=W_totalSetpoint)
      annotation (Placement(transformation(extent={{4,10},{24,30}})));
    TRANSFORM.Blocks.RealExpression Q_balance
      annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
    TRANSFORM.Blocks.RealExpression W_balance
      annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
  equation

    connect(division.y, gain.u)
      annotation (Line(points={{61,0},{78,0}},    color={0,0,127}));
    connect(actuatorBus.Demand, gain.y) annotation (
       Line(
        points={{30.1,-99.9},{120,-99.9},{120,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const.y, division.u2) annotation (Line(points={{27,-6},{38,-6}},
                             color={0,0,127}));
    connect(W_totalSetpoint_BOP.y, division.u1)
      annotation (Line(points={{25,20},{32,20},{32,6},{38,6}},
                                                     color={0,0,127}));
    connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_balance, W_balance.u) annotation (Line(
        points={{-30,-100},{-36,-100},{-36,-98},{-120,-98},{-120,28},{-102.4,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

  annotation(defaultComponentName="ES_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_BOPSetpoint;

  model CS_Default

    extends BaseClasses.Partial_ControlSystem;

    input Real u = 100 annotation(Dialog(group="Inputs"));

    Modelica.Blocks.Sources.RealExpression Demand(y=u)
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    TRANSFORM.Blocks.RealExpression Q_balance
      annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
    TRANSFORM.Blocks.RealExpression W_balance
      annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
  equation

    connect(actuatorBus.Demand, Demand.y)
      annotation (Line(
        points={{30.1,-99.9},{120,-99.9},{120,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_balance, W_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,28},{-102.4,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="ES_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Default;

  model CS_Setpoint

    extends BaseClasses.Partial_ControlSystem;

    parameter SI.Power Q_nominal "Nominal power for BOP for zero flow to energy storage";

    input SI.Power W_totalSetpoint "Total setpoint power from SC" annotation(Dialog(group="Inputs"));

    Modelica.Blocks.Math.Gain gain(k=100)
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    Modelica.Blocks.Math.Division division
      annotation (Placement(transformation(extent={{48,-10},{68,10}})));
    Modelica.Blocks.Sources.Constant const(k=Q_nominal)
      annotation (Placement(transformation(extent={{16,-16},{36,4}})));
    Modelica.Blocks.Sources.RealExpression W_totalSetpoint_ES(y=W_totalSetpoint)
      annotation (Placement(transformation(extent={{16,4},{36,24}})));
    TRANSFORM.Blocks.RealExpression Q_balance
      annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
    TRANSFORM.Blocks.RealExpression W_balance
      annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
  equation

    connect(division.y, gain.u)
      annotation (Line(points={{69,0},{78,0}},    color={0,0,127}));
    connect(actuatorBus.Demand, gain.y) annotation (
       Line(
        points={{30.1,-99.9},{120,-99.9},{120,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(W_totalSetpoint_ES.y, division.u1)
      annotation (Line(points={{37,14},{42,14},{42,6},{46,6}},
                                                     color={0,0,127}));
    connect(division.u2, const.y)
      annotation (Line(points={{46,-6},{37,-6}}, color={0,0,127}));
    connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_balance, W_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,28},{-102.4,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="ES_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Setpoint;

  model CS_TextRead

    extends BaseClasses.Partial_ControlSystem;

    //parameter SI.Power Q_nominal "Nominal power for BOP for zero flow to energy storage";
    input SI.Power W_totalSetpoint "Total setpoint power from SC" annotation(Dialog(group="Inputs"));

    Modelica.Blocks.Math.Gain gain(k=1)
      annotation (Placement(transformation(extent={{78,-10},{98,10}})));
    Modelica.Blocks.Sources.RealExpression W_totalSetpoint_ES(y=W_totalSetpoint)
      annotation (Placement(transformation(extent={{28,-10},{48,10}})));
    TRANSFORM.Blocks.RealExpression Q_balance
      annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
    TRANSFORM.Blocks.RealExpression W_balance
      annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
  equation

    connect(actuatorBus.Demand, gain.y) annotation (
       Line(
        points={{30.1,-99.9},{30.1,-98},{120,-98},{120,0},{99,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(W_totalSetpoint_ES.y, gain.u)
      annotation (Line(points={{49,0},{76,0}},   color={0,0,127}));
    connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
        points={{-30,-100},{-30,-98},{-32,-98},{-32,-100},{-120,-100},{-120,40},
            {-102.4,40}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_balance, W_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,28},{-102.4,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="ES_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_TextRead;

  model CS_20PercentNominal_2
    Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,-64491675.7;
          3600,-101392394.116; 7200,-57351374.5056; 10800,-70313172.8728; 14400,-78991527.836;
          18000,-27459855.0136; 21600,0; 25200,0; 28800,55574670.3912; 32400,
          118856922.395; 36000,133776778.5; 39600,200000000.0; 43200,200000000.0;
          46800,91791628.7136; 50400,0; 54000,0; 57600,0; 61200,0; 64800,0; 68400,
          0; 72000,0; 75600,0; 79200,0; 82800,-181977103.043; 86400,115; 90000,
          100; 93600,100; 97200,120; 100800,120; 104400,120; 108000,120; 111600,
          120])
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));

    extends BaseClasses.Partial_ControlSystem;

    TRANSFORM.Blocks.RealExpression Q_balance
      annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
    TRANSFORM.Blocks.RealExpression W_balance
      annotation (Placement(transformation(extent={{-100,22},{-76,34}})));
  equation

    connect(actuatorBus.Demand, ReactorDemandSimulator.y) annotation (Line(
        points={{30.1,-99.9},{120,-99.9},{120,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_balance, W_balance.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,28},{-102.4,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="ES_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_20PercentNominal_2;

  model ED_Dummy

    extends EnergyStorage.SensibleHeatStorage.BaseClasses.Partial_EventDriver;

    extends NHES.Icons.DummyIcon;

  equation

  annotation(defaultComponentName="PHS_CS");
  end ED_Dummy;
end ControlSystems;
