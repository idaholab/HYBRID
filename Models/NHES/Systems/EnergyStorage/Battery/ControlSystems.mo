within NHES.Systems.EnergyStorage.Battery;
package ControlSystems
  model CS_InputSetpoint
    extends BaseClasses.Partial_ControlSystem;

    input SI.Power W_totalSetpoint "Total setpoint power from SC" annotation(Dialog(group="Inputs"));

    Modelica.Blocks.Math.Gain gain(k=-1)
      "Reverse control signal to match notation of setpoint signals"
      annotation (Placement(transformation(extent={{76,-10},{96,10}})));
    Modelica.Blocks.Sources.RealExpression W_totalSetpoint_SC(y=W_totalSetpoint)
      annotation (Placement(transformation(extent={{24,-10},{44,10}})));
    TRANSFORM.Blocks.RealExpression Q_balance
      annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
    TRANSFORM.Blocks.RealExpression W_balance
      annotation (Placement(transformation(extent={{-100,24},{-76,36}})));
  equation

    connect(actuatorBus.W_setPoint, gain.y) annotation (Line(
        points={{30.1,-99.9},{120,-99.9},{120,0},{97,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(W_totalSetpoint_SC.y, gain.u)
      annotation (Line(points={{45,0},{74,0}},   color={0,0,127}));
    connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
        points={{-29.9,-99.9},{-30,-99.9},{-30,-100},{-120,-100},{-120,40},{
            -102.4,40}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_balance, W_balance.u) annotation (Line(
        points={{-29.9,-99.9},{-120,-99.9},{-120,30},{-102.4,30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="ES_CS", Icon(graphics={Text(
            extent={{-48,16},{50,-12}},
            lineColor={28,108,200},
            lineThickness=1,
            textString="Battery")}));
  end CS_InputSetpoint;

  model CS_Dummy
    extends BaseClasses.Partial_ControlSystem;

    extends Icons.DummyIcon;

  public
    Modelica.Blocks.Sources.Constant W_setPoint(k=20e6)
      annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  equation

    connect(actuatorBus.W_setPoint, W_setPoint.y) annotation (
        Line(
        points={{30.1,-99.9},{30.1,-99.9},{30.1,-50},{11,-50}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="ES_CS");
  end CS_Dummy;

  model ED_Dummy

    extends EnergyStorage.Battery.BaseClasses.Partial_EventDriver;

    extends NHES.Icons.DummyIcon;

  equation

  annotation(defaultComponentName="PHS_CS");
  end ED_Dummy;
end ControlSystems;
