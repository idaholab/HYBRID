within NHES.Systems.BalanceOfPlant.RankineCycle;
package ControlSystems
  model CS_Dummy
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    Modelica.Blocks.Sources.Constant TCV_openingNominal(k=0.5)
      annotation (Placement(transformation(extent={{-10,10},{10,30}})));
    Modelica.Blocks.Sources.Constant BV_openingNominal(k=0.001)
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Modelica.Blocks.Sources.Constant TDV_openingNominal(k=0.5)
      annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
    Modelica.Blocks.Sources.Constant BV_TCV_openingNominal(k=0.001)
      annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  equation
    connect(actuatorBus.opening_TCV, TCV_openingNominal.y) annotation (
       Line(
        points={{30.1,-99.9},{30.1,20},{11,20}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.opening_BV, BV_openingNominal.y)
      annotation (Line(
        points={{30.1,-99.9},{30.1,-40},{11,-40}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.opening_TDV, TDV_openingNominal.y)
      annotation (Line(
        points={{30.1,-99.9},{30.1,-10},{11,-10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.opening_BV_TCV, BV_TCV_openingNominal.y)
      annotation (Line(
        points={{30.1,-99.9},{30.1,-70},{11,-70}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    annotation (defaultComponentName="CS",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CS_Dummy;

  model CS_UserDefined
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real opening_TCV=0.5
      "Valve opening" annotation(Dialog(group="Inputs"));
    input Real opening_TDV=0.5
      "Valve opening" annotation(Dialog(group="Inputs"));
    input Real opening_BV=0.001
      "Valve opening" annotation(Dialog(group="Inputs"));
    input Real opening_BV_TCV=0.001
      "Valve opening" annotation(Dialog(group="Inputs"));

    Modelica.Blocks.Sources.RealExpression TCV_opening(y=opening_TCV)
      annotation (Placement(transformation(extent={{-10,10},{10,30}})));
    Modelica.Blocks.Sources.RealExpression BV_opening(y=opening_BV)
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Modelica.Blocks.Sources.RealExpression TDV_opening(y=opening_TDV)
      annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
    Modelica.Blocks.Sources.RealExpression BV_TCV_opening(y=opening_BV_TCV)
      annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));

  equation
    connect(actuatorBus.opening_TCV, TCV_opening.y)
      annotation (Line(
        points={{30.1,-99.9},{30.1,20},{11,20}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.opening_BV, BV_opening.y) annotation (
        Line(
        points={{30.1,-99.9},{30.1,-40},{11,-40}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.opening_TDV, TDV_opening.y)
      annotation (Line(
        points={{30.1,-99.9},{30.1,-10},{11,-10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.opening_BV_TCV, BV_TCV_opening.y)
      annotation (Line(
        points={{30.1,-99.9},{30.1,-70},{11,-70}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    annotation (defaultComponentName="CS",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CS_UserDefined;

  model CS_PressureAndPowerControl
    extends BaseClasses.Partial_ControlSystem;

    parameter SI.Time delayStartTCV = 300 "Delay start of TCV control";
    parameter SI.Time delayStartBV = delayStartTCV "Delay start of BV control";

    parameter SI.Pressure p_nominal "Nominal steam turbine pressure";

    parameter Real TCV_opening_nominal = 0.5 "Nominal opening of TCV - controls power";
    parameter Real BV_opening_nominal = 0.001 "Nominal opening of BV - controls pressure";

    input SI.Power W_totalSetpoint "Total setpoint power from BOP" annotation(Dialog(group="Inputs"));

    Modelica.Blocks.Sources.Constant TCV_openingNominal(k=TCV_opening_nominal)
      annotation (Placement(transformation(extent={{-180,150},{-160,170}})));
    Modelica.Blocks.Logical.Switch switch_BV
      annotation (Placement(transformation(extent={{40,12},{60,32}})));
    Modelica.Blocks.Sources.Constant BV_openingNominal(k=BV_opening_nominal)
      annotation (Placement(transformation(extent={{-180,-40},{-160,-20}})));
    Modelica.Blocks.Logical.Greater greater5
      annotation (Placement(transformation(extent={{-140,210},{-120,190}})));
    Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
    Modelica.Blocks.Sources.Constant valvedelay(k=delayStartTCV)
      annotation (Placement(transformation(extent={{-180,210},{-160,230}})));
    TRANSFORM.Controls.LimPID
                         PID_TCV_opening(
      yMax=1 -TCV_openingNominal.k,
      yMin=-TCV_openingNominal.k + 0.0001,
      k_s=0.25e-8,
      k_m=0.25e-8,
      controllerType=Modelica.Blocks.Types.SimpleController.PI)
             annotation (Placement(transformation(extent={{-60,220},{-40,240}})));
    Modelica.Blocks.Logical.Switch switch_W_setpoint
      annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
    Modelica.Blocks.Logical.Switch switch_TCV_setpoint
      annotation (Placement(transformation(extent={{40,212},{60,232}})));
    Modelica.Blocks.Sources.Constant TCV_diffopeningNominal(k=0)
      annotation (Placement(transformation(extent={{0,190},{20,210}})));
    Modelica.Blocks.Math.Add TCV_opening
      annotation (Placement(transformation(extent={{80,170},{100,190}})));
    Modelica.Blocks.Sources.Constant p_Nominal(k=p_nominal)
      annotation (Placement(transformation(extent={{-180,-10},{-160,10}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint
      annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
    Modelica.Blocks.Sources.Constant valvedelayBV(k=delayStartBV)
      annotation (Placement(transformation(extent={{-180,20},{-160,40}})));
    Modelica.Blocks.Logical.Greater greater1
      annotation (Placement(transformation(extent={{-140,20},{-120,0}})));
    TRANSFORM.Controls.LimPID PID_BV_opening(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1 - BV_openingNominal.k,
      yMin=-BV_openingNominal.k + 0.0001,
      k=-1,
      k_s=1/p_nominal,
      k_m=1/p_nominal)
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Math.Add BV_opening
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    Modelica.Blocks.Sources.Constant BV_diffopeningNominal(k=0)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Blocks.Sources.RealExpression W_totalSetpoint_BOP(y=W_totalSetpoint)
      annotation (Placement(transformation(extent={{-140,220},{-120,240}})));
  equation

    connect(clock.y, greater5.u1) annotation (Line(points={{-159,70},{-150,70},{-150,
            200},{-142,200}},
                            color={0,0,127}));
    connect(valvedelay.y, greater5.u2) annotation (Line(points={{-159,220},{-150,220},
            {-150,208},{-142,208}},
                                  color={0,0,127}));
    connect(greater5.y,switch_W_setpoint. u2)
      annotation (Line(points={{-119,200},{-102,200}},
                                                     color={255,0,255}));
    connect(TCV_diffopeningNominal.y, switch_TCV_setpoint.u3) annotation (Line(
          points={{21,200},{30,200},{30,214},{38,214}},
                                                    color={0,0,127}));
    connect(switch_TCV_setpoint.u1,PID_TCV_opening. y)
      annotation (Line(points={{38,230},{-39,230}},     color={0,0,127}));
    connect(switch_TCV_setpoint.u2,switch_W_setpoint. u2) annotation (Line(points={{38,222},
            {-30,222},{-30,184},{-108,184},{-108,200},{-102,200}},
          color={255,0,255}));
    connect(switch_TCV_setpoint.y,TCV_opening. u1) annotation (Line(points={{61,222},
            {70,222},{70,186},{78,186}},  color={0,0,127}));
    connect(TCV_openingNominal.y,TCV_opening. u2) annotation (Line(points={{-159,160},
            {20,160},{20,174},{78,174}},
                                      color={0,0,127}));
    connect(actuatorBus.opening_TCV, TCV_opening.y)
      annotation (Line(
        points={{30.1,-99.9},{160,-99.9},{160,180},{101,180}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_total,switch_W_setpoint. u1) annotation (Line(
        points={{-29.9,-99.9},{-110,-99.9},{-110,208},{-102,208}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(valvedelayBV.y, greater1.u2) annotation (Line(points={{-159,30},{-146,
            30},{-146,18},{-142,18}}, color={0,0,127}));
    connect(greater1.y, switch_P_setpoint.u2)
      annotation (Line(points={{-119,10},{-102,10}},   color={255,0,255}));
    connect(sensorBus.p_inlet_steamTurbine, switch_P_setpoint.u1)
      annotation (Line(
        points={{-29.9,-99.9},{-110,-99.9},{-110,18},{-102,18}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(p_Nominal.y, switch_P_setpoint.u3) annotation (Line(points={{-159,0},
            {-156,0},{-156,-14},{-114,-14},{-114,2},{-102,2}},       color={0,0,127}));
    connect(switch_P_setpoint.y, PID_BV_opening.u_m) annotation (Line(points={{-79,
            10},{-64,10},{-64,18},{-50,18}}, color={0,0,127}));
    connect(PID_BV_opening.u_s, switch_P_setpoint.u3) annotation (Line(points={{-62,
            30},{-114,30},{-114,2},{-102,2}}, color={0,0,127}));
    connect(greater1.u1, greater5.u1) annotation (Line(points={{-142,10},{-150,10},
            {-150,200},{-142,200}},
                                  color={0,0,127}));
    connect(BV_openingNominal.y, BV_opening.u2) annotation (Line(points={{-159,-30},
            {30,-30},{30,-6},{78,-6}}, color={0,0,127}));
    connect(switch_BV.y, BV_opening.u1)
      annotation (Line(points={{61,22},{70,22},{70,6},{78,6}}, color={0,0,127}));
    connect(PID_BV_opening.y, switch_BV.u1)
      annotation (Line(points={{-39,30},{38,30}}, color={0,0,127}));
    connect(switch_BV.u2, switch_P_setpoint.u2) annotation (Line(points={{38,22},{
            -30,22},{-30,-16},{-106,-16},{-106,10},{-102,10}}, color={255,0,255}));
    connect(BV_diffopeningNominal.y, switch_BV.u3)
      annotation (Line(points={{21,0},{30,0},{30,14},{38,14}}, color={0,0,127}));
    connect(switch_W_setpoint.y, PID_TCV_opening.u_m)
      annotation (Line(points={{-79,200},{-50,200},{-50,218}},
                                                            color={0,0,127}));
    connect(actuatorBus.opening_BV, BV_opening.y) annotation (
        Line(
        points={{30.1,-99.9},{160,-99.9},{160,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(W_totalSetpoint_BOP.y, PID_TCV_opening.u_s)
      annotation (Line(points={{-119,230},{-62,230}}, color={0,0,127}));
    connect(switch_W_setpoint.u3, PID_TCV_opening.u_s) annotation (Line(points={{
            -102,192},{-114,192},{-114,230},{-62,230}}, color={0,0,127}));
  annotation (defaultComponentName="EM_CS",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                     Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{160,260}})));
  end CS_PressureAndPowerControl;

  model CS_InputSetpoint
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    Modelica.Blocks.Math.Gain Q_normal_gain(k=0.25e-8)
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Modelica.Blocks.Math.Gain Q_normal_gain1(k=0.25e-8) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={10,-10})));
    TRANSFORM.Controls.LimPID
                         PID_TCV_opening(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1,
      yMin=-1,
      k=0.1,
      Ti=95) annotation (Placement(transformation(extent={{20,20},{40,40}})));
    Modelica.Blocks.Logical.Switch switch_Q_setpoint
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    Modelica.Blocks.Sources.Constant TCV_opening_nominal(k=0.5)
      annotation (Placement(transformation(extent={{20,80},{40,100}})));
    Modelica.Blocks.Math.Add TCV_opening
      annotation (Placement(transformation(extent={{100,60},{120,80}})));
    Modelica.Blocks.Sources.ContinuousClock clock
      annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
    Modelica.Blocks.Sources.Constant TCVDelay(k=delayStartTCV)
      annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
    Modelica.Blocks.Logical.Less less
      annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
    parameter SI.Time delayStartTCV=100 "Delay TCV control";
    Modelica.Blocks.Logical.Switch switch_Q_setpoint1
      annotation (Placement(transformation(extent={{64,20},{84,40}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{20,50},{40,70}})));
  equation
    connect(switch_Q_setpoint.y, Q_normal_gain1.u)
      annotation (Line(points={{-39,-10},{-2,-10}}, color={0,0,127}));
    connect(Q_normal_gain1.y, PID_TCV_opening.u_m)
      annotation (Line(points={{21,-10},{30,-10},{30,18}}, color={0,0,127}));
    connect(TCV_opening_nominal.y, TCV_opening.u1) annotation (Line(points={{41,90},
            {50,90},{50,76},{98,76}}, color={0,0,127}));
    connect(Q_normal_gain.y, PID_TCV_opening.u_s)
      annotation (Line(points={{1,30},{18,30}}, color={0,0,127}));
    connect(clock.y, less.u1) annotation (Line(points={{-119,10},{-110,10},{-110,
            -10},{-102,-10}}, color={0,0,127}));
    connect(TCVDelay.y, less.u2) annotation (Line(points={{-119,-30},{-110,-30},{-110,
            -18},{-102,-18}}, color={0,0,127}));
    connect(less.y, switch_Q_setpoint.u2) annotation (Line(points={{-79,-10},{-70,
            -10},{-62,-10}}, color={255,0,255}));
    connect(PID_TCV_opening.y, switch_Q_setpoint1.u3) annotation (Line(points={{
            41,30},{50,30},{50,22},{62,22}}, color={0,0,127}));
    connect(switch_Q_setpoint1.u2, switch_Q_setpoint.u2) annotation (Line(points=
            {{62,30},{52,30},{52,10},{-68,10},{-68,-10},{-62,-10}}, color={255,0,
            255}));
    connect(switch_Q_setpoint1.y, TCV_opening.u2) annotation (Line(points={{85,30},
            {90,30},{90,64},{98,64}}, color={0,0,127}));
    connect(const.y, switch_Q_setpoint1.u1) annotation (Line(points={{41,60},{50,
            60},{50,38},{62,38}}, color={0,0,127}));
    connect(sensorBus.W_totalSetpoint, Q_normal_gain.u) annotation (
        Line(
        points={{-29.9,-99.9},{-52,-99.9},{-72,-99.9},{-72,30},{-22,30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_total, switch_Q_setpoint.u3) annotation (Line(
        points={{-29.9,-99.9},{-72,-99.9},{-72,-18},{-62,-18}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_totalSetpoint, switch_Q_setpoint.u1)
      annotation (Line(
        points={{-29.9,-99.9},{-52,-99.9},{-72,-99.9},{-72,-2},{-62,-2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.opening_TCV, TCV_opening.y) annotation (Line(
        points={{30.1,-99.9},{116,-99.9},{200,-99.9},{200,70},{121,70}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    annotation (defaultComponentName="CS",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                       Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,
              140}})));
  end CS_InputSetpoint;

  model CS_OTSG_Pressure
    extends BaseClasses.Partial_ControlSystem;

    parameter SI.Time delayStartTCV = 300 "Delay start of TCV control";
    parameter SI.Time delayStartBV = delayStartTCV "Delay start of BV control";

    parameter SI.Pressure p_nominal "Nominal steam turbine pressure";
    //parameter SI.Pressure

    parameter Real TCV_opening_nominal = 0.5 "Nominal opening of TCV - controls power";
    parameter Real BV_opening_nominal = 0.001 "Nominal opening of BV - controls pressure";

    input SI.Power W_totalSetpoint "Total setpoint power from BOP" annotation(Dialog(group="Inputs"));
    //input SI.Power W_totalSetpoint "Total setpoint power from BOP" annotation(Dialog(group="Inputs"));
    input SI.Power Reactor_Power "Reactor Power Level" annotation(Dialog(group="Inputs"));
    input SI.Power Nominal_Power "Nominal Power Level" annotation(Dialog(group="Inputs"));
    Modelica.Blocks.Sources.Constant TCV_openingNominal(k=TCV_opening_nominal)
      annotation (Placement(transformation(extent={{-180,150},{-160,170}})));
    Modelica.Blocks.Logical.Switch switch_BV
      annotation (Placement(transformation(extent={{40,12},{60,32}})));
    Modelica.Blocks.Sources.Constant BV_openingNominal(k=BV_opening_nominal)
      annotation (Placement(transformation(extent={{-180,-40},{-160,-20}})));
    Modelica.Blocks.Logical.Greater greater5
      annotation (Placement(transformation(extent={{-140,210},{-120,190}})));
    Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
    Modelica.Blocks.Sources.Constant valvedelay(k=delayStartTCV)
      annotation (Placement(transformation(extent={{-180,210},{-160,230}})));
    TRANSFORM.Controls.LimPID
                         PID_TCV_opening(
      yMax=1 -TCV_openingNominal.k,
      yMin=-TCV_openingNominal.k + 0.0001,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k_s=0.25e-7,
      k_m=0.25e-7)
             annotation (Placement(transformation(extent={{-60,220},{-40,240}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV
      annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
    Modelica.Blocks.Logical.Switch switch_TCV_setpoint
      annotation (Placement(transformation(extent={{40,212},{60,232}})));
    Modelica.Blocks.Sources.Constant TCV_diffopeningNominal(k=0)
      annotation (Placement(transformation(extent={{0,190},{20,210}})));
    Modelica.Blocks.Math.Add TCV_opening
      annotation (Placement(transformation(extent={{80,170},{100,190}})));
    Modelica.Blocks.Sources.Constant p_Nominal(k=p_nominal)
      annotation (Placement(transformation(extent={{-180,-10},{-160,10}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint
      annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
    Modelica.Blocks.Sources.Constant valvedelayBV(k=delayStartBV)
      annotation (Placement(transformation(extent={{-180,24},{-160,44}})));
    Modelica.Blocks.Logical.Greater greater1
      annotation (Placement(transformation(extent={{-140,20},{-120,0}})));
    TRANSFORM.Controls.LimPID PID_BV_opening(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1 - BV_openingNominal.k,
      yMin=-BV_openingNominal.k + 0.0001,
      k=-1,
      k_s=1/p_nominal,
      k_m=1/p_nominal)
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Math.Add BV_opening
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    Modelica.Blocks.Sources.Constant BV_diffopeningNominal(k=0)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Blocks.Sources.Constant p_Nominal1(k=p_nominal)
      annotation (Placement(transformation(extent={{-146,230},{-126,250}})));
  equation

    connect(clock.y, greater5.u1) annotation (Line(points={{-159,70},{-150,70},{-150,
            200},{-142,200}},
                            color={0,0,127}));
    connect(valvedelay.y, greater5.u2) annotation (Line(points={{-159,220},{-150,220},
            {-150,208},{-142,208}},
                                  color={0,0,127}));
    connect(greater5.y, switch_P_setpoint_TCV.u2)
      annotation (Line(points={{-119,200},{-102,200}}, color={255,0,255}));
    connect(TCV_diffopeningNominal.y, switch_TCV_setpoint.u3) annotation (Line(
          points={{21,200},{30,200},{30,214},{38,214}},
                                                    color={0,0,127}));
    connect(switch_TCV_setpoint.u1,PID_TCV_opening. y)
      annotation (Line(points={{38,230},{-39,230}},     color={0,0,127}));
    connect(switch_TCV_setpoint.u2, switch_P_setpoint_TCV.u2) annotation (Line(
          points={{38,222},{-30,222},{-30,184},{-108,184},{-108,200},{-102,200}},
          color={255,0,255}));
    connect(switch_TCV_setpoint.y,TCV_opening. u1) annotation (Line(points={{61,222},
            {70,222},{70,186},{78,186}},  color={0,0,127}));
    connect(TCV_openingNominal.y,TCV_opening. u2) annotation (Line(points={{-159,160},
            {20,160},{20,174},{78,174}},
                                      color={0,0,127}));
    connect(actuatorBus.opening_TCV, TCV_opening.y)
      annotation (Line(
        points={{30.1,-99.9},{160,-99.9},{160,180},{101,180}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(valvedelayBV.y, greater1.u2) annotation (Line(points={{-159,34},{-146,
            34},{-146,18},{-142,18}}, color={0,0,127}));
    connect(greater1.y, switch_P_setpoint.u2)
      annotation (Line(points={{-119,10},{-102,10}},   color={255,0,255}));
    connect(p_Nominal.y, switch_P_setpoint.u3) annotation (Line(points={{-159,0},
            {-156,0},{-156,-14},{-114,-14},{-114,2},{-102,2}},       color={0,0,127}));
    connect(switch_P_setpoint.y, PID_BV_opening.u_m) annotation (Line(points={{-79,
            10},{-64,10},{-64,18},{-50,18}}, color={0,0,127}));
    connect(PID_BV_opening.u_s, switch_P_setpoint.u3) annotation (Line(points={{-62,
            30},{-114,30},{-114,2},{-102,2}}, color={0,0,127}));
    connect(greater1.u1, greater5.u1) annotation (Line(points={{-142,10},{-150,10},
            {-150,200},{-142,200}},
                                  color={0,0,127}));
    connect(BV_openingNominal.y, BV_opening.u2) annotation (Line(points={{-159,-30},
            {30,-30},{30,-6},{78,-6}}, color={0,0,127}));
    connect(switch_BV.y, BV_opening.u1)
      annotation (Line(points={{61,22},{70,22},{70,6},{78,6}}, color={0,0,127}));
    connect(PID_BV_opening.y, switch_BV.u1)
      annotation (Line(points={{-39,30},{38,30}}, color={0,0,127}));
    connect(switch_BV.u2, switch_P_setpoint.u2) annotation (Line(points={{38,22},{
            -30,22},{-30,-16},{-106,-16},{-106,10},{-102,10}}, color={255,0,255}));
    connect(BV_diffopeningNominal.y, switch_BV.u3)
      annotation (Line(points={{21,0},{30,0},{30,14},{38,14}}, color={0,0,127}));
    connect(actuatorBus.opening_BV, BV_opening.y) annotation (
        Line(
        points={{30.1,-99.9},{160,-99.9},{160,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.p_inlet_steamTurbine, switch_P_setpoint_TCV.u1) annotation (
       Line(
        points={{-29.9,-99.9},{-110,-99.9},{-110,208},{-102,208}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(p_Nominal.y, switch_P_setpoint.u1) annotation (Line(points={{-159,0},
            {-142,0},{-142,-6},{-116,-6},{-116,18},{-102,18}}, color={0,0,127}));
    connect(p_Nominal1.y, switch_P_setpoint_TCV.u3) annotation (Line(points={{
            -125,240},{-114,240},{-114,192},{-102,192}}, color={0,0,127}));
    connect(p_Nominal1.y, PID_TCV_opening.u_m) annotation (Line(points={{-125,240},
            {-82,240},{-82,224},{-64,224},{-64,206},{-50,206},{-50,218}}, color={
            0,0,127}));
    connect(switch_P_setpoint_TCV.y, PID_TCV_opening.u_s) annotation (Line(points=
           {{-79,200},{-72,200},{-72,230},{-62,230}}, color={0,0,127}));
  annotation (defaultComponentName="EM_CS",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                     Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{160,260}})));
  end CS_OTSG_Pressure;

  model CS_OTSG_Power_Control
    extends BaseClasses.Partial_ControlSystem;

    parameter SI.Time delayStartTCV = 300 "Delay start of TCV control";
    parameter SI.Time delayStartBV = delayStartTCV "Delay start of BV control";

    parameter SI.Pressure p_overpressure = 100e5 "OverPressure steam turbine pressure";
    parameter SI.Pressure p_nominal = 50e5 "Nominal steam pressure";

    parameter Real TCV_opening_nominal = 0.5 "Nominal opening of TCV - controls power";
    parameter Real BV_opening_nominal = 0.001 "Nominal opening of BV - controls pressure";

    input SI.Power W_totalSetpoint "Total setpoint power from BOP" annotation(Dialog(group="Inputs"));
    input SI.Power Reactor_Power "Reactor Power Level" annotation(Dialog(group="Inputs"));
    input SI.Power Nominal_Power "Nominal Power Level" annotation(Dialog(group="Inputs"));
    Modelica.Blocks.Sources.Constant TCV_openingNominal(k=TCV_opening_nominal)
      annotation (Placement(transformation(extent={{-180,150},{-160,170}})));
    Modelica.Blocks.Logical.Switch switch_BV
      annotation (Placement(transformation(extent={{40,12},{60,32}})));
    Modelica.Blocks.Sources.Constant BV_openingNominal(k=BV_opening_nominal)
      annotation (Placement(transformation(extent={{-180,-82},{-160,-62}})));
    Modelica.Blocks.Logical.Greater greater5
      annotation (Placement(transformation(extent={{-140,210},{-120,190}})));
    Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
    Modelica.Blocks.Sources.Constant valvedelay(k=delayStartTCV)
      annotation (Placement(transformation(extent={{-180,210},{-160,230}})));
    TRANSFORM.Controls.LimPID
                         PID_TCV_opening(
      yMax=1 -TCV_openingNominal.k,
      yMin=-TCV_openingNominal.k + 0.0001,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k_s=0.25e-8,
      k_m=0.25e-8)
             annotation (Placement(transformation(extent={{-60,220},{-40,240}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV
      annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
    Modelica.Blocks.Logical.Switch switch_TCV_setpoint
      annotation (Placement(transformation(extent={{40,212},{60,232}})));
    Modelica.Blocks.Sources.Constant TCV_diffopeningNominal(k=0)
      annotation (Placement(transformation(extent={{0,190},{20,210}})));
    Modelica.Blocks.Math.Add TCV_opening
      annotation (Placement(transformation(extent={{80,170},{100,190}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint
      annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
    Modelica.Blocks.Sources.Constant valvedelayBV(k=delayStartBV)
      annotation (Placement(transformation(extent={{-180,20},{-160,40}})));
    Modelica.Blocks.Logical.Greater greater1
      annotation (Placement(transformation(extent={{-140,20},{-120,0}})));
    TRANSFORM.Controls.LimPID PID_BV_opening(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1 - BV_openingNominal.k,
      yMin=-BV_openingNominal.k + 0.0001,
      k=1,
      Ti=10,
      k_s=1/(12.5*160e6),
      k_m=1/(12.5*160e6))
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Math.Add BV_opening
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    Modelica.Blocks.Sources.Constant BV_diffopeningNominal(k=0)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Blocks.Sources.RealExpression
                                     Power_Nominal(y=Nominal_Power)
      annotation (Placement(transformation(extent={{-180,-22},{-160,-2}})));
    Modelica.Blocks.Sources.RealExpression Power_Level(y=Reactor_Power)
      annotation (Placement(transformation(extent={{-180,-40},{-160,-20}})));
    Modelica.Blocks.Sources.Constant p_Nominal1(k=p_nominal)
      annotation (Placement(transformation(extent={{-138,220},{-118,240}})));
  equation

    connect(clock.y, greater5.u1) annotation (Line(points={{-159,70},{-150,70},{-150,
            200},{-142,200}},
                            color={0,0,127}));
    connect(valvedelay.y, greater5.u2) annotation (Line(points={{-159,220},{-150,220},
            {-150,208},{-142,208}},
                                  color={0,0,127}));
    connect(greater5.y, switch_P_setpoint_TCV.u2)
      annotation (Line(points={{-119,200},{-102,200}}, color={255,0,255}));
    connect(TCV_diffopeningNominal.y, switch_TCV_setpoint.u3) annotation (Line(
          points={{21,200},{30,200},{30,214},{38,214}},
                                                    color={0,0,127}));
    connect(switch_TCV_setpoint.u1,PID_TCV_opening. y)
      annotation (Line(points={{38,230},{-39,230}},     color={0,0,127}));
    connect(switch_TCV_setpoint.u2, switch_P_setpoint_TCV.u2) annotation (Line(
          points={{38,222},{-30,222},{-30,184},{-108,184},{-108,200},{-102,200}},
          color={255,0,255}));
    connect(switch_TCV_setpoint.y,TCV_opening. u1) annotation (Line(points={{61,222},
            {70,222},{70,186},{78,186}},  color={0,0,127}));
    connect(TCV_openingNominal.y,TCV_opening. u2) annotation (Line(points={{-159,160},
            {20,160},{20,174},{78,174}},
                                      color={0,0,127}));
    connect(actuatorBus.opening_TCV, TCV_opening.y)
      annotation (Line(
        points={{30.1,-99.9},{160,-99.9},{160,180},{101,180}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(valvedelayBV.y, greater1.u2) annotation (Line(points={{-159,30},{-146,
            30},{-146,18},{-142,18}}, color={0,0,127}));
    connect(greater1.y, switch_P_setpoint.u2)
      annotation (Line(points={{-119,10},{-102,10}},   color={255,0,255}));
    connect(switch_P_setpoint.y, PID_BV_opening.u_m) annotation (Line(points={{-79,
            10},{-64,10},{-64,18},{-50,18}}, color={0,0,127}));
    connect(greater1.u1, greater5.u1) annotation (Line(points={{-142,10},{-150,10},
            {-150,200},{-142,200}},
                                  color={0,0,127}));
    connect(BV_openingNominal.y, BV_opening.u2) annotation (Line(points={{-159,-72},
            {30,-72},{30,-6},{78,-6}}, color={0,0,127}));
    connect(switch_BV.y, BV_opening.u1)
      annotation (Line(points={{61,22},{70,22},{70,6},{78,6}}, color={0,0,127}));
    connect(PID_BV_opening.y, switch_BV.u1)
      annotation (Line(points={{-39,30},{38,30}}, color={0,0,127}));
    connect(switch_BV.u2, switch_P_setpoint.u2) annotation (Line(points={{38,22},{
            -30,22},{-30,-16},{-106,-16},{-106,10},{-102,10}}, color={255,0,255}));
    connect(BV_diffopeningNominal.y, switch_BV.u3)
      annotation (Line(points={{21,0},{30,0},{30,14},{38,14}}, color={0,0,127}));
    connect(actuatorBus.opening_BV, BV_opening.y) annotation (
        Line(
        points={{30.1,-99.9},{160,-99.9},{160,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_total, switch_P_setpoint_TCV.u1) annotation (Line(
        points={{-29.9,-99.9},{-110,-99.9},{-110,208},{-102,208}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(switch_P_setpoint_TCV.y, PID_TCV_opening.u_m)
      annotation (Line(points={{-79,200},{-50,200},{-50,218}}, color={0,0,127}));
    connect(Power_Nominal.y, PID_BV_opening.u_s) annotation (Line(points={{-159,-12},
            {-114,-12},{-114,30},{-62,30}}, color={0,0,127}));
    connect(Power_Level.y, switch_P_setpoint.u1) annotation (Line(points={{-159,
            -30},{-132,-30},{-132,-28},{-108,-28},{-108,18},{-102,18}}, color={0,
            0,127}));
    connect(Power_Nominal.y, switch_P_setpoint.u3) annotation (Line(points={{-159,
            -12},{-112,-12},{-112,2},{-102,2}}, color={0,0,127}));
    connect(p_Nominal1.y, PID_TCV_opening.u_s)
      annotation (Line(points={{-117,230},{-62,230}}, color={0,0,127}));
    connect(p_Nominal1.y, switch_P_setpoint_TCV.u3) annotation (Line(points={{
            -117,230},{-114,230},{-114,192},{-102,192}}, color={0,0,127}));
  annotation (defaultComponentName="EM_CS",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                     Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{160,260}})));
  end CS_OTSG_Power_Control;

  model CS_OTSG_TCV_Pressure_TBV_Power_Control
    extends BaseClasses.Partial_ControlSystem;

    parameter SI.Time delayStartTCV = 300 "Delay start of TCV control";
    parameter SI.Time delayStartBV = delayStartTCV "Delay start of BV control";

    parameter SI.Pressure p_nominal "Steam Pressure";
    //parameter SI.Pressure

    parameter Real TCV_opening_nominal = 0.5 "Nominal opening of TCV - controls power";
    parameter Real BV_opening_nominal = 0.001 "Nominal opening of BV - controls pressure";

    input SI.Power W_totalSetpoint "Total setpoint power from BOP" annotation(Dialog(group="Inputs"));

    Modelica.Blocks.Sources.Constant TCV_openingNominal(k=TCV_opening_nominal)
      annotation (Placement(transformation(extent={{-180,150},{-160,170}})));
    Modelica.Blocks.Logical.Switch switch_BV
      annotation (Placement(transformation(extent={{40,12},{60,32}})));
    Modelica.Blocks.Sources.Constant BV_openingNominal(k=BV_opening_nominal)
      annotation (Placement(transformation(extent={{-180,-82},{-160,-62}})));
    Modelica.Blocks.Logical.Greater greater5
      annotation (Placement(transformation(extent={{-140,210},{-120,190}})));
    Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
    Modelica.Blocks.Sources.Constant valvedelay(k=delayStartTCV)
      annotation (Placement(transformation(extent={{-180,210},{-160,230}})));
    TRANSFORM.Controls.LimPID
                         PID_TCV_opening(
      yMax=1 -TCV_openingNominal.k,
      yMin=-TCV_openingNominal.k + 0.0001,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k_s=0.25e-8,
      k_m=0.25e-8)
             annotation (Placement(transformation(extent={{-60,240},{-40,220}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV
      annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
    Modelica.Blocks.Logical.Switch switch_TCV_setpoint
      annotation (Placement(transformation(extent={{40,212},{60,232}})));
    Modelica.Blocks.Sources.Constant TCV_diffopeningNominal(k=0)
      annotation (Placement(transformation(extent={{0,190},{20,210}})));
    Modelica.Blocks.Math.Add TCV_opening
      annotation (Placement(transformation(extent={{80,170},{100,190}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint
      annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
    Modelica.Blocks.Sources.Constant valvedelayBV(k=delayStartBV)
      annotation (Placement(transformation(extent={{-180,20},{-160,40}})));
    Modelica.Blocks.Logical.Greater greater1
      annotation (Placement(transformation(extent={{-140,20},{-120,0}})));
    TRANSFORM.Controls.LimPID PID_BV_opening(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1 - BV_openingNominal.k,
      yMin=-BV_openingNominal.k + 0.0001,
      Ti=10,
      k_s=1/(12.5*160e6),
      k_m=1/(12.5*160e6),
      k=-1)
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Math.Add BV_opening
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    Modelica.Blocks.Sources.Constant BV_diffopeningNominal(k=0)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Blocks.Sources.RealExpression
                                     Power_Nominal(y=W_totalSetpoint)
      annotation (Placement(transformation(extent={{-180,-22},{-160,-2}})));
    Modelica.Blocks.Sources.Constant p_Nominal1(k=p_nominal)
      annotation (Placement(transformation(extent={{-138,220},{-118,240}})));
  equation

    connect(clock.y, greater5.u1) annotation (Line(points={{-159,70},{-150,70},{-150,
            200},{-142,200}},
                            color={0,0,127}));
    connect(valvedelay.y, greater5.u2) annotation (Line(points={{-159,220},{-150,220},
            {-150,208},{-142,208}},
                                  color={0,0,127}));
    connect(greater5.y, switch_P_setpoint_TCV.u2)
      annotation (Line(points={{-119,200},{-102,200}}, color={255,0,255}));
    connect(TCV_diffopeningNominal.y, switch_TCV_setpoint.u3) annotation (Line(
          points={{21,200},{30,200},{30,214},{38,214}},
                                                    color={0,0,127}));
    connect(switch_TCV_setpoint.u1,PID_TCV_opening. y)
      annotation (Line(points={{38,230},{-39,230}},     color={0,0,127}));
    connect(switch_TCV_setpoint.u2, switch_P_setpoint_TCV.u2) annotation (Line(
          points={{38,222},{-30,222},{-30,184},{-108,184},{-108,200},{-102,200}},
          color={255,0,255}));
    connect(switch_TCV_setpoint.y,TCV_opening. u1) annotation (Line(points={{61,222},
            {70,222},{70,186},{78,186}},  color={0,0,127}));
    connect(TCV_openingNominal.y,TCV_opening. u2) annotation (Line(points={{-159,
            160},{0,160},{0,174},{78,174}},
                                      color={0,0,127}));
    connect(actuatorBus.opening_TCV, TCV_opening.y)
      annotation (Line(
        points={{30.1,-99.9},{160,-99.9},{160,180},{101,180}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(valvedelayBV.y, greater1.u2) annotation (Line(points={{-159,30},{-146,
            30},{-146,18},{-142,18}}, color={0,0,127}));
    connect(greater1.y, switch_P_setpoint.u2)
      annotation (Line(points={{-119,10},{-102,10}},   color={255,0,255}));
    connect(switch_P_setpoint.y, PID_BV_opening.u_m) annotation (Line(points={{-79,
            10},{-64,10},{-64,18},{-50,18}}, color={0,0,127}));
    connect(greater1.u1, greater5.u1) annotation (Line(points={{-142,10},{-150,10},
            {-150,200},{-142,200}},
                                  color={0,0,127}));
    connect(BV_openingNominal.y, BV_opening.u2) annotation (Line(points={{-159,-72},
            {30,-72},{30,-6},{78,-6}}, color={0,0,127}));
    connect(switch_BV.y, BV_opening.u1)
      annotation (Line(points={{61,22},{70,22},{70,6},{78,6}}, color={0,0,127}));
    connect(PID_BV_opening.y, switch_BV.u1)
      annotation (Line(points={{-39,30},{38,30}}, color={0,0,127}));
    connect(switch_BV.u2, switch_P_setpoint.u2) annotation (Line(points={{38,22},{
            -30,22},{-30,-16},{-106,-16},{-106,10},{-102,10}}, color={255,0,255}));
    connect(BV_diffopeningNominal.y, switch_BV.u3)
      annotation (Line(points={{21,0},{30,0},{30,14},{38,14}}, color={0,0,127}));
    connect(actuatorBus.opening_BV, BV_opening.y) annotation (
        Line(
        points={{30.1,-99.9},{160,-99.9},{160,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Power_Nominal.y, PID_BV_opening.u_s) annotation (Line(points={{-159,-12},
            {-114,-12},{-114,30},{-62,30}}, color={0,0,127}));
    connect(Power_Nominal.y, switch_P_setpoint.u3) annotation (Line(points={{-159,
            -12},{-112,-12},{-112,2},{-102,2}}, color={0,0,127}));
    connect(p_Nominal1.y, switch_P_setpoint_TCV.u3) annotation (Line(points={{-117,
            230},{-114,230},{-114,192},{-102,192}}, color={0,0,127}));
    connect(sensorBus.W_total, switch_P_setpoint.u1) annotation (Line(
        points={{-29.9,-99.9},{-110,-99.9},{-110,18},{-102,18}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.p_inlet_steamTurbine, switch_P_setpoint_TCV.u1) annotation (
       Line(
        points={{-29.9,-99.9},{-110,-99.9},{-110,208},{-102,208}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(p_Nominal1.y, PID_TCV_opening.u_m) annotation (Line(points={{-117,230},
            {-84,230},{-84,248},{-50,248},{-50,242}}, color={0,0,127}));
    connect(switch_P_setpoint_TCV.y, PID_TCV_opening.u_s) annotation (Line(points=
           {{-79,200},{-72,200},{-72,230},{-62,230}}, color={0,0,127}));
  annotation (defaultComponentName="EM_CS",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                     Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{160,260}})));
  end CS_OTSG_TCV_Pressure_TBV_Power_Control;

  model ED_Dummy

    extends BaseClasses.Partial_EventDriver;

    extends NHES.Icons.DummyIcon;

  equation

  annotation(defaultComponentName="PHS_CS");
  end ED_Dummy;

  model CS_Rankine_Xe100_Based_Secondary

    extends BaseClasses.Partial_ControlSystem;

    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-2,
      Ti=30,
      yMax=750,
      yMin=-1000,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-40,16},{-20,36}})));
    Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
      annotation (Placement(transformation(extent={{-72,16},{-52,36}})));
    Modelica.Blocks.Sources.Constant const4(k=1500)
      annotation (Placement(transformation(extent={{-16,34},{-8,42}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{0,22},{20,42}})));
    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-5,
      Ti=15,
      yMax=1 - 1e-6,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-64,-72},{-44,-52}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-94,-72},{-74,-52}})));
    TRANSFORM.Controls.LimPID TCV_Position(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-9,
      Ti=5,
      yMax=0,
      yMin=-1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-56,-18},{-36,-38}})));
    Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{-86,-38},{-66,-18}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-28,-44},{-20,-36}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-10,-44},{10,-24}})));
    Modelica.Blocks.Sources.Constant const8(k=1e-6)
      annotation (Placement(transformation(extent={{-34,-78},{-26,-70}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-10,-78},{10,-58}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-34,-66},{-26,-58}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-80,52},{-60,72}})));
    Data.HTGR_Rankine
                    data
      annotation (Placement(transformation(extent={{-98,-4},{-78,16}})));
  equation

    connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{-51,26},{-42,26}},
                                color={0,0,127}));
    connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
        points={{-30,-100},{-104,-100},{-104,-8},{-30,-8},{-30,14}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const4.y, add.u1) annotation (Line(points={{-7.6,38},{-2,38}},
                                     color={0,0,127}));
    connect(FWCP_Speed.y, add.u2) annotation (Line(points={{-19,26},{-2,26}},
                      color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,32},{21,32}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const5.y, Turb_Divert_Valve.u_s)
      annotation (Line(points={{-73,-62},{-66,-62}},   color={0,0,127}));
    connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
        points={{-30,-100},{-54,-100},{-54,-74}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const6.y, TCV_Position.u_s)
      annotation (Line(points={{-65,-28},{-58,-28}},   color={0,0,127}));
    connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
        points={{-30,-100},{-104,-100},{-104,-8},{-46,-8},{-46,-16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y, add1.u2) annotation (Line(points={{-19.6,-40},{-12,-40}},
                                        color={0,0,127}));
    connect(TCV_Position.y, add1.u1) annotation (Line(points={{-35,-28},{-12,-28}},
                                                    color={0,0,127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-68},{11,-68}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add2.u2, const8.y) annotation (Line(points={{-12,-74},{-25.6,-74}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1, timer.y) annotation (Line(points={{-12,-62},{-25.44,-62}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-43,-62},{-34.8,
            -62}},                                                     color={0,0,
            127}));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-59,62},{-42,62}},   color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-104,-100},{-104,44},{-30,44},{-30,50}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,62},{-19,62}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-32},{28,-32},{28,-34},{11,-34}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics));
  end CS_Rankine_Xe100_Based_Secondary;

  model CS_SteamTurbine_L2_PressurePowerFeedtemp
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand_int = data.Q_Nom;

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-3,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0.05,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,-58},{-38,-38}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=5e-7,
      Ti=30,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.05,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand_int)
      annotation (Placement(transformation(extent={{-94,-6},{-80,6}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
    Modelica.Blocks.Sources.Constant const8(k=0)
      annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
    replaceable Data.Turbine_2_Setpoints data(
      p_steam=3500000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=40e6,
      T_Feedwater=421.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{-78,-22},{-64,-8}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-7,
      Ti=10,
      yMax=250,
      yMin=-72,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    Modelica.Blocks.Sources.Constant const4(k=72.1)
      annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{2,36},{22,56}})));
    Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{2,74},{22,94}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-60,-48}},
                                                       color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-48,-100},{-48,-60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                        color={0,0,127}));
    connect(TCV_Power.y, add1.u1)
      annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
    connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-37,-48},{-36,
            -48},{-36,-40},{-32.8,-40}},                               color={0,0,
            127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-46},{13,-46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-18},{13,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,84},{23,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y, FWCP_Speed.u_s)
      annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
    connect(FWCP_Speed.y, add.u2)
      annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,46},{23,46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const.y, TCV_Power.u_s) annotation (Line(points={{-63.3,-15},{-56,-15},
            {-56,-12},{-52,-12}}, color={0,0,127}));
  end CS_SteamTurbine_L2_PressurePowerFeedtemp;

  model CS_PowerBoostLoop_DivertPowerControl
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand
    annotation(Dialog(tab="General"));

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-4,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-62,-116},{-42,-136}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-104,-136},{-84,-116}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-8,
      Ti=1,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,-28},{-38,-48}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand)
      annotation (Placement(transformation(extent={{96,-32},{110,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-128},{-24,-120}})));
    replaceable Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=52e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15,
      m_flow_reactor=67.3)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const3(k=data.m_flow_reactor)
      annotation (Placement(transformation(extent={{-96,62},{-76,82}})));
    TRANSFORM.Controls.LimPID FWCP_mflow(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=20,
      Td=0.1,
      yMax=1250,
      yMin=-750,
      wp=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-66,62},{-46,82}})));
    Modelica.Blocks.Sources.Constant const4(k=1200)
      annotation (Placement(transformation(extent={{-40,80},{-32,88}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-24,68},{-4,88}})));
    Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{10,158},{30,178}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-58,134},{-38,154}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-98,134},{-78,154}})));
    Modelica.Blocks.Math.Add         add5
      annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
    TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-4e-9,
      Ti=1,
      k_s=1,
      k_m=1,
      yMax=1 - 0.015,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{152,-78},{132,-98}})));
    Modelica.Blocks.Sources.Constant const10(k=0.015)
      annotation (Placement(transformation(extent={{152,-122},{144,-114}})));
    Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
      annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
    Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
    Modelica.Blocks.Sources.Constant const12(k=data.Q_Nom + 0.001e6)
      annotation (Placement(transformation(extent={{140,-84},{164,-60}})));
    Modelica.Blocks.Sources.Constant const11(k=0.01)
      annotation (Placement(transformation(extent={{156,32},{148,40}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{128,42},{108,62}})));
    Modelica.Blocks.Math.Add         add7
      annotation (Placement(transformation(extent={{116,90},{96,110}})));
    Modelica.Blocks.Sources.Constant const15(k=0.01)
      annotation (Placement(transformation(extent={{140,80},{132,88}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter(max=1 - 0.001)
      annotation (Placement(transformation(extent={{156,48},{136,68}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter1(max=1 - 0.01)
      annotation (Placement(transformation(extent={{160,96},{140,116}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression1(y=electric_demand)
      annotation (Placement(transformation(extent={{88,16},{102,28}})));
    TRANSFORM.Controls.LimPID TCV_SHS(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-9,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{186,48},{166,68}})));
    TRANSFORM.Controls.LimPID Discharge_OnOFF(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-9,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{206,96},{186,116}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-83,-126},{-64,-126}}, color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-52,-100},{-52,-114}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,add1. u2) annotation (Line(points={{-25.6,-50},{-18,-50}},
                                        color={0,0,127}));
    connect(TCV_Power.y, add1.u1)
      annotation (Line(points={{-37,-38},{-18,-38}}, color={0,0,127}));
    connect(add2.u2,const8. y) annotation (Line(points={{-10,-136},{-23.6,-136}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1,timer. y) annotation (Line(points={{-10,-124},{-23.44,-124}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-126},{
            -36,-126},{-36,-124},{-32.8,-124}},                        color={0,0,
            127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-130},{13,-130}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-44},{5,-44}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,118},{31,118},{31,168}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y,FWCP_mflow. u_s)
      annotation (Line(points={{-75,72},{-68,72}}, color={0,0,127}));
    connect(FWCP_mflow.y, add.u2)
      annotation (Line(points={{-45,72},{-26,72}},
                                                 color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-31.6,84},{-26,84}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,78},{-3,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-77,144},{-60,144}},
                                                   color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,108},{-48,108},{-48,132}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,128},{-30,128},{-30,144},{-37,144}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(add5.u1, Charge_OnOff_Throttle.y)
      annotation (Line(points={{114,-90},{114,-88},{131,-88}},
                                                   color={0,0,127}));
    connect(add5.u2, const10.y) annotation (Line(points={{114,-102},{118,-102},{
            118,-118},{143.6,-118}},
                              color={0,0,127}));
    connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
        points={{30,-100},{30,-96},{91,-96}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, TCV_Power.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,-12},{-48,-12},{-48,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(TCV_Power.u_s, const1.y)
      annotation (Line(points={{-60,-38},{-71,-38}}, color={0,0,127}));
    connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,46},{-56,46},{-56,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Power, min1.u2) annotation (Line(
        points={{-30,-100},{-30,-74},{90,-74},{90,-76}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(min1.u1, const6.y)
      annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
    connect(Charge_OnOff_Throttle.u_m, min1.y) annotation (Line(points={{142,-76},
            {142,-66},{113,-66},{113,-70}}, color={0,0,127}));
    connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
            -26},{160,-64},{172,-64}}, color={0,0,127}));
    connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
            {238,-70},{238,-88},{154,-88}}, color={0,0,127}));
    connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
            -72},{165.2,-72}}, color={0,0,127}));
    connect(const11.y,add4. u2) annotation (Line(points={{147.6,36},{140,36},{140,
            46},{130,46}},
                     color={0,0,127}));
    connect(actuatorBus.TCV_SHS,add4. y) annotation (Line(
        points={{30,-100},{30,52},{107,52}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add7.u2,const15. y) annotation (Line(points={{118,94},{122,94},{122,
            88},{131.6,88},{131.6,84}}, color={0,0,127}));
    connect(actuatorBus.Discharge_OnOff_Throttle,add7. y) annotation (Line(
        points={{30,-100},{30,100},{95,100}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(minMaxFilter1.y,add7. u1)
      annotation (Line(points={{138.6,106},{118,106}},
                                                     color={0,0,127}));
    connect(add4.u1,minMaxFilter. y)
      annotation (Line(points={{130,58},{134.6,58}}, color={0,0,127}));
    connect(minMaxFilter.u,TCV_SHS. y)
      annotation (Line(points={{158,58},{165,58}}, color={0,0,127}));
    connect(sensorBus.Power,TCV_SHS. u_m) annotation (Line(
        points={{-30,-100},{-30,-10},{176,-10},{176,46}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression1.y, TCV_SHS.u_s) annotation (Line(points={{102.7,22},{
            192,22},{192,58},{188,58}}, color={0,0,127}));
    connect(minMaxFilter1.u,Discharge_OnOFF. y)
      annotation (Line(points={{162,106},{185,106}},
                                                   color={0,0,127}));
    connect(sensorBus.Power,Discharge_OnOFF. u_m) annotation (Line(
        points={{-30,-100},{-30,-10},{206,-10},{206,80},{196,80},{196,94}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression1.y, Discharge_OnOFF.u_s) annotation (Line(points={{
            102.7,22},{226,22},{226,106},{208,106}}, color={0,0,127}));
    annotation (Diagram(graphics={Text(
            extent={{-70,-142},{-20,-160}},
            textColor={28,108,200},
            textString="Feedwater")}));
  end CS_PowerBoostLoop_DivertPowerControl;

  model CS_DivertPowerControl
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand
    annotation(Dialog(tab="General"));
    input Real Overall_Power
    annotation(Dialog(tab="General"));

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-4,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-62,-116},{-42,-136}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-104,-136},{-84,-116}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-8,
      Ti=1,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,-28},{-38,-48}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand)
      annotation (Placement(transformation(extent={{96,-32},{110,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-128},{-24,-120}})));
    replaceable Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=48.57e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15,
      m_flow_reactor=67.3)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const3(k=data.m_flow_reactor)
      annotation (Placement(transformation(extent={{-96,62},{-76,82}})));
    TRANSFORM.Controls.LimPID FWCP_mflow(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=20,
      Td=0.1,
      yMax=1250,
      yMin=-750,
      wp=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-66,62},{-46,82}})));
    Modelica.Blocks.Sources.Constant const4(k=1200)
      annotation (Placement(transformation(extent={{-40,80},{-32,88}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-24,68},{-4,88}})));
    Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{10,158},{30,178}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-58,134},{-38,154}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-98,134},{-78,154}})));
    Modelica.Blocks.Math.Add         add5
      annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
    TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-4e-7,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - 0.015,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{152,-78},{132,-98}})));
    Modelica.Blocks.Sources.Constant const10(k=0.015)
      annotation (Placement(transformation(extent={{152,-122},{144,-114}})));
    Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
      annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
    Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
    Modelica.Blocks.Sources.Constant const12(k=data.Q_Nom + 0.001e6)
      annotation (Placement(transformation(extent={{116,-58},{140,-34}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression1(y=Overall_Power)
      annotation (Placement(transformation(extent={{80,24},{94,36}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-83,-126},{-64,-126}}, color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-52,-100},{-52,-114}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,add1. u2) annotation (Line(points={{-25.6,-50},{-18,-50}},
                                        color={0,0,127}));
    connect(TCV_Power.y, add1.u1)
      annotation (Line(points={{-37,-38},{-18,-38}}, color={0,0,127}));
    connect(add2.u2,const8. y) annotation (Line(points={{-10,-136},{-23.6,-136}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1,timer. y) annotation (Line(points={{-10,-124},{-23.44,-124}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-126},{
            -36,-126},{-36,-124},{-32.8,-124}},                        color={0,0,
            127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-130},{13,-130}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-44},{5,-44}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,118},{31,118},{31,168}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y,FWCP_mflow. u_s)
      annotation (Line(points={{-75,72},{-68,72}}, color={0,0,127}));
    connect(FWCP_mflow.y, add.u2)
      annotation (Line(points={{-45,72},{-26,72}},
                                                 color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-31.6,84},{-26,84}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,78},{-3,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-77,144},{-60,144}},
                                                   color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,108},{-48,108},{-48,132}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,128},{-30,128},{-30,144},{-37,144}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(add5.u1, Charge_OnOff_Throttle.y)
      annotation (Line(points={{114,-90},{114,-88},{131,-88}},
                                                   color={0,0,127}));
    connect(add5.u2, const10.y) annotation (Line(points={{114,-102},{118,-102},{
            118,-118},{143.6,-118}},
                              color={0,0,127}));
    connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
        points={{30,-100},{30,-96},{91,-96}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, TCV_Power.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,-12},{-48,-12},{-48,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(TCV_Power.u_s, const1.y)
      annotation (Line(points={{-60,-38},{-71,-38}}, color={0,0,127}));
    connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,46},{-56,46},{-56,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(min1.u1, const6.y)
      annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
    connect(Charge_OnOff_Throttle.u_m, min1.y) annotation (Line(points={{142,-76},
            {142,-66},{113,-66},{113,-70}}, color={0,0,127}));
    connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
            -26},{160,-64},{172,-64}}, color={0,0,127}));
    connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
            {238,-70},{238,-88},{154,-88}}, color={0,0,127}));
    connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
            -46},{141.2,-46}}, color={0,0,127}));
    connect(realExpression1.y, min1.u2) annotation (Line(points={{94.7,30},{98,30},
            {98,-16},{84,-16},{84,-76},{90,-76}}, color={0,0,127}));
    annotation (Diagram(graphics={Text(
            extent={{-70,-142},{-20,-160}},
            textColor={28,108,200},
            textString="Feedwater")}));
  end CS_DivertPowerControl;

  model CS_SmallCycle_NoFeedHeat
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand
    annotation(Dialog(tab="General"));

    replaceable Data.TES_Setpoints data(
      p_steam=1200000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=48.57e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-4,
      Ti=5,
      Td=0.1,
      yMax=2500,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,62},{-38,82}})));
    Modelica.Blocks.Sources.Constant const4(k=100)
      annotation (Placement(transformation(extent={{-32,80},{-24,88}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-16,68},{4,88}})));
    Modelica.Blocks.Sources.Constant const11(k=0.001)
      annotation (Placement(transformation(extent={{134,-10},{126,-2}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{106,0},{86,20}})));
    Modelica.Blocks.Math.Add         add7
      annotation (Placement(transformation(extent={{94,48},{74,68}})));
    Modelica.Blocks.Sources.Constant const15(k=0.01)
      annotation (Placement(transformation(extent={{118,38},{110,46}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter(max=1 - 0.001)
      annotation (Placement(transformation(extent={{134,6},{114,26}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter1(max=1 - 0.01)
      annotation (Placement(transformation(extent={{138,54},{118,74}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand - data.Q_Nom)
      annotation (Placement(transformation(extent={{66,-26},{80,-14}})));
    TRANSFORM.Controls.LimPID TCV_SHS(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-9,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{164,6},{144,26}})));
    TRANSFORM.Controls.LimPID Discharge_OnOFF(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-9,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{184,54},{164,74}})));
  equation
    connect(sensorBus.Steam_Pressure,FWCP_Speed. u_m) annotation (Line(
        points={{-30,-100},{-118,-100},{-118,40},{-48,40},{-48,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(const3.y,FWCP_Speed. u_s)
      annotation (Line(points={{-69,72},{-60,72}}, color={0,0,127}));
    connect(FWCP_Speed.y,add. u2)
      annotation (Line(points={{-37,72},{-18,72}},
                                                 color={0,0,127}));
    connect(const4.y,add. u1)
      annotation (Line(points={{-23.6,84},{-18,84}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
        points={{30,-100},{30,78},{5,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const11.y,add4. u2) annotation (Line(points={{125.6,-6},{118,-6},{118,
            4},{108,4}},
                     color={0,0,127}));
    connect(actuatorBus.TCV_SHS,add4. y) annotation (Line(
        points={{30,-100},{30,10},{85,10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add7.u2,const15. y) annotation (Line(points={{96,52},{100,52},{100,46},
            {109.6,46},{109.6,42}},     color={0,0,127}));
    connect(actuatorBus.Discharge_OnOff_Throttle,add7. y) annotation (Line(
        points={{30,-100},{30,58},{73,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(minMaxFilter1.y,add7. u1)
      annotation (Line(points={{116.6,64},{96,64}},  color={0,0,127}));
    connect(add4.u1,minMaxFilter. y)
      annotation (Line(points={{108,16},{112.6,16}}, color={0,0,127}));
    connect(minMaxFilter.u, TCV_SHS.y)
      annotation (Line(points={{136,16},{143,16}}, color={0,0,127}));
    connect(sensorBus.Power, TCV_SHS.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{154,-52},{154,4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, TCV_SHS.u_s) annotation (Line(points={{80.7,-20},{
            170,-20},{170,16},{166,16}}, color={0,0,127}));
    connect(minMaxFilter1.u, Discharge_OnOFF.y)
      annotation (Line(points={{140,64},{163,64}}, color={0,0,127}));
    connect(sensorBus.Power, Discharge_OnOFF.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{184,-52},{184,38},{174,38},{174,52}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, Discharge_OnOFF.u_s) annotation (Line(points={{80.7,
            -20},{204,-20},{204,64},{186,64}}, color={0,0,127}));
  end CS_SmallCycle_NoFeedHeat;

  model CS_OTSG_TCV_Pressure_TBV_Power_Control_Intermediate
    extends BaseClasses.Partial_ControlSystem;

    parameter SI.Time delayStartTCV = 300 "Delay start of TCV control";
    parameter SI.Time delayStartBV = delayStartTCV "Delay start of BV control";

    parameter SI.Pressure p_nominal "Steam Pressure";
    //parameter SI.Pressure

    parameter Real TCV_opening_nominal = 0.5 "Nominal opening of TCV - controls power";
    parameter Real BV_opening_nominal = 0.001 "Nominal opening of BV - controls pressure";

    input SI.Power W_totalSetpoint "Total setpoint power from BOP" annotation(Dialog(group="Inputs"));

    Modelica.Blocks.Sources.Constant TCV_openingNominal(k=TCV_opening_nominal)
      annotation (Placement(transformation(extent={{-180,150},{-160,170}})));
    Modelica.Blocks.Logical.Switch switch_BV
      annotation (Placement(transformation(extent={{40,12},{60,32}})));
    Modelica.Blocks.Sources.Constant BV_openingNominal(k=BV_opening_nominal)
      annotation (Placement(transformation(extent={{-180,-82},{-160,-62}})));
    Modelica.Blocks.Logical.Greater greater5
      annotation (Placement(transformation(extent={{-140,210},{-120,190}})));
    Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
    Modelica.Blocks.Sources.Constant valvedelay(k=delayStartTCV)
      annotation (Placement(transformation(extent={{-180,210},{-160,230}})));
    TRANSFORM.Controls.LimPID
                         PID_TCV_opening(
      yMax=1 -TCV_openingNominal.k,
      yMin=-TCV_openingNominal.k + 0.0001,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k_s=0.25e-8,
      k_m=0.25e-8)
             annotation (Placement(transformation(extent={{-60,240},{-40,220}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV
      annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
    Modelica.Blocks.Logical.Switch switch_TCV_setpoint
      annotation (Placement(transformation(extent={{40,212},{60,232}})));
    Modelica.Blocks.Sources.Constant TCV_diffopeningNominal(k=0)
      annotation (Placement(transformation(extent={{0,190},{20,210}})));
    Modelica.Blocks.Math.Add TCV_opening
      annotation (Placement(transformation(extent={{80,170},{100,190}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint
      annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
    Modelica.Blocks.Sources.Constant valvedelayBV(k=delayStartBV)
      annotation (Placement(transformation(extent={{-180,20},{-160,40}})));
    Modelica.Blocks.Logical.Greater greater1
      annotation (Placement(transformation(extent={{-140,20},{-120,0}})));
    TRANSFORM.Controls.LimPID PID_BV_opening(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=1 - BV_openingNominal.k,
      yMin=-BV_openingNominal.k + 0.0001,
      Ti=10,
      k_s=1/(12.5*160e6),
      k_m=1/(12.5*160e6),
      k=-1)
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Math.Add BV_opening
      annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    Modelica.Blocks.Sources.Constant BV_diffopeningNominal(k=0)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Blocks.Sources.RealExpression
                                     Power_Nominal(y=W_totalSetpoint)
      annotation (Placement(transformation(extent={{-180,-22},{-160,-2}})));
    Modelica.Blocks.Sources.Constant p_Nominal1(k=p_nominal)
      annotation (Placement(transformation(extent={{-138,220},{-118,240}})));
    Modelica.Blocks.Sources.Constant const5(k=421.15)
      annotation (Placement(transformation(extent={{-82,98},{-62,118}})));
    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-5,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=1e-3,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-50,98},{-30,118}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-22,110},{-14,118}})));
    Modelica.Blocks.Sources.Constant const8(k=0)
      annotation (Placement(transformation(extent={{-22,98},{-14,106}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{2,98},{22,118}})));
  equation

    connect(clock.y, greater5.u1) annotation (Line(points={{-159,70},{-150,70},{-150,
            200},{-142,200}},
                            color={0,0,127}));
    connect(valvedelay.y, greater5.u2) annotation (Line(points={{-159,220},{-150,220},
            {-150,208},{-142,208}},
                                  color={0,0,127}));
    connect(greater5.y, switch_P_setpoint_TCV.u2)
      annotation (Line(points={{-119,200},{-102,200}}, color={255,0,255}));
    connect(TCV_diffopeningNominal.y, switch_TCV_setpoint.u3) annotation (Line(
          points={{21,200},{30,200},{30,214},{38,214}},
                                                    color={0,0,127}));
    connect(switch_TCV_setpoint.u1,PID_TCV_opening. y)
      annotation (Line(points={{38,230},{-39,230}},     color={0,0,127}));
    connect(switch_TCV_setpoint.u2, switch_P_setpoint_TCV.u2) annotation (Line(
          points={{38,222},{-30,222},{-30,184},{-108,184},{-108,200},{-102,200}},
          color={255,0,255}));
    connect(switch_TCV_setpoint.y,TCV_opening. u1) annotation (Line(points={{61,222},
            {70,222},{70,186},{78,186}},  color={0,0,127}));
    connect(TCV_openingNominal.y,TCV_opening. u2) annotation (Line(points={{-159,
            160},{0,160},{0,174},{78,174}},
                                      color={0,0,127}));
    connect(actuatorBus.opening_TCV, TCV_opening.y)
      annotation (Line(
        points={{30.1,-99.9},{160,-99.9},{160,180},{101,180}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(valvedelayBV.y, greater1.u2) annotation (Line(points={{-159,30},{-146,
            30},{-146,18},{-142,18}}, color={0,0,127}));
    connect(greater1.y, switch_P_setpoint.u2)
      annotation (Line(points={{-119,10},{-102,10}},   color={255,0,255}));
    connect(switch_P_setpoint.y, PID_BV_opening.u_m) annotation (Line(points={{-79,
            10},{-64,10},{-64,18},{-50,18}}, color={0,0,127}));
    connect(greater1.u1, greater5.u1) annotation (Line(points={{-142,10},{-150,10},
            {-150,200},{-142,200}},
                                  color={0,0,127}));
    connect(BV_openingNominal.y, BV_opening.u2) annotation (Line(points={{-159,-72},
            {30,-72},{30,-6},{78,-6}}, color={0,0,127}));
    connect(switch_BV.y, BV_opening.u1)
      annotation (Line(points={{61,22},{70,22},{70,6},{78,6}}, color={0,0,127}));
    connect(PID_BV_opening.y, switch_BV.u1)
      annotation (Line(points={{-39,30},{38,30}}, color={0,0,127}));
    connect(switch_BV.u2, switch_P_setpoint.u2) annotation (Line(points={{38,22},{
            -30,22},{-30,-16},{-106,-16},{-106,10},{-102,10}}, color={255,0,255}));
    connect(BV_diffopeningNominal.y, switch_BV.u3)
      annotation (Line(points={{21,0},{30,0},{30,14},{38,14}}, color={0,0,127}));
    connect(actuatorBus.opening_BV, BV_opening.y) annotation (
        Line(
        points={{30.1,-99.9},{160,-99.9},{160,0},{101,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Power_Nominal.y, PID_BV_opening.u_s) annotation (Line(points={{-159,-12},
            {-114,-12},{-114,30},{-62,30}}, color={0,0,127}));
    connect(Power_Nominal.y, switch_P_setpoint.u3) annotation (Line(points={{-159,
            -12},{-112,-12},{-112,2},{-102,2}}, color={0,0,127}));
    connect(p_Nominal1.y, switch_P_setpoint_TCV.u3) annotation (Line(points={{-117,
            230},{-114,230},{-114,192},{-102,192}}, color={0,0,127}));
    connect(sensorBus.W_total, switch_P_setpoint.u1) annotation (Line(
        points={{-29.9,-99.9},{-110,-99.9},{-110,18},{-102,18}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.p_inlet_steamTurbine, switch_P_setpoint_TCV.u1) annotation (
       Line(
        points={{-29.9,-99.9},{-110,-99.9},{-110,208},{-102,208}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(p_Nominal1.y, PID_TCV_opening.u_m) annotation (Line(points={{-117,230},
            {-84,230},{-84,248},{-50,248},{-50,242}}, color={0,0,127}));
    connect(switch_P_setpoint_TCV.y, PID_TCV_opening.u_s) annotation (Line(points=
           {{-79,200},{-72,200},{-72,230},{-62,230}}, color={0,0,127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{160,-100},{160,108},{23,108}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const5.y, Turb_Divert_Valve.u_s)
      annotation (Line(points={{-61,108},{-52,108}}, color={0,0,127}));
    connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-29,108},{-26,
            108},{-26,112},{-22.8,112},{-22.8,114}}, color={0,0,127}));
    connect(timer.y, add2.u1) annotation (Line(points={{-13.44,114},{-12,114},{
            -12,124},{0,124},{0,114}}, color={0,0,127}));
    connect(const8.y, add2.u2) annotation (Line(points={{-13.6,102},{-12,102},{
            -12,92},{0,92},{0,102}}, color={0,0,127}));
  annotation (defaultComponentName="EM_CS",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                     Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{160,260}})));
  end CS_OTSG_TCV_Pressure_TBV_Power_Control_Intermediate;

  package ObsoleteCS
    model CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle_AR
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand
      annotation(Dialog(tab="General"));

      Data.TES_Setpoints data(
        p_steam=1200000,
        p_steam_vent=15000000,
        T_Steam_Ref=579.75,
        Q_Nom=42e6,
        T_Feedwater=421.15,
        T_SHS_Return=491.15)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
        annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-4,
        Ti=5,
        Td=0.1,
        yMax=2500,
        yMin=0,
        wd=1,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-58,62},{-38,82}})));
      Modelica.Blocks.Sources.Constant const4(k=100)
        annotation (Placement(transformation(extent={{-32,80},{-24,88}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{-16,68},{4,88}})));
      Modelica.Blocks.Sources.Constant const11(k=0.001)
        annotation (Placement(transformation(extent={{134,-10},{126,-2}})));
      Modelica.Blocks.Math.Add         add4
        annotation (Placement(transformation(extent={{106,0},{86,20}})));
      Modelica.Blocks.Math.Add         add7
        annotation (Placement(transformation(extent={{94,48},{74,68}})));
      Modelica.Blocks.Sources.Constant const15(k=0.01)
        annotation (Placement(transformation(extent={{118,38},{110,46}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0)
        annotation (Placement(transformation(extent={{218,8},{238,28}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
        PI_DFV(
        k=5,
        Ti=30,
        k_s=5e-9,
        k_m=5e-9)
        annotation (Placement(transformation(extent={{178,54},{158,74}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
        PI_DCV1(
        k=5,
        Ti=30,
        k_s=5e-9,
        k_m=5e-9)
        annotation (Placement(transformation(extent={{164,6},{144,26}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        minMaxFilter(max=1 - 0.001)
        annotation (Placement(transformation(extent={{134,6},{114,26}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        minMaxFilter1(max=1 - 0.01)
        annotation (Placement(transformation(extent={{138,54},{118,74}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand - data.Q_Nom)
        annotation (Placement(transformation(extent={{66,-24},{80,-12}})));
    equation
      connect(sensorBus.Steam_Pressure,FWCP_Speed. u_m) annotation (Line(
          points={{-30,-100},{-118,-100},{-118,40},{-48,40},{-48,60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(const3.y,FWCP_Speed. u_s)
        annotation (Line(points={{-69,72},{-60,72}}, color={0,0,127}));
      connect(FWCP_Speed.y,add. u2)
        annotation (Line(points={{-37,72},{-18,72}},
                                                   color={0,0,127}));
      connect(const4.y,add. u1)
        annotation (Line(points={{-23.6,84},{-18,84}},
                                                    color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
          points={{30,-100},{30,78},{5,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const11.y,add4. u2) annotation (Line(points={{125.6,-6},{118,-6},{118,
              4},{108,4}},
                       color={0,0,127}));
      connect(actuatorBus.TCV_SHS,add4. y) annotation (Line(
          points={{30,-100},{30,10},{85,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(add7.u2,const15. y) annotation (Line(points={{96,52},{100,52},{100,46},
              {109.6,46},{109.6,42}},     color={0,0,127}));
      connect(actuatorBus.Discharge_OnOff_Throttle,add7. y) annotation (Line(
          points={{30,-100},{30,58},{73,58}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(realExpression.y,greaterThreshold. u) annotation (Line(points={{80.7,
              -18},{202,-18},{202,18},{216,18}}, color={0,0,127}));
      connect(greaterThreshold.y,PI_DFV. k_in) annotation (Line(points={{239,18},{
              272,18},{272,14},{298,14},{298,72},{180,72}}, color={255,0,255}));
      connect(PI_DFV.u_s, realExpression.y) annotation (Line(points={{180,64},{188,
              64},{188,-18},{80.7,-18}},  color={0,0,127}));
      connect(sensorBus.Power,PI_DFV. u_m) annotation (Line(
          points={{-30,-100},{-30,-52},{172,-52},{172,52},{168,52}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power,PI_DCV1. u_m) annotation (Line(
          points={{-30,-100},{-30,-52},{166,-52},{166,-6},{154,-6},{154,4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(realExpression.y,PI_DCV1. u_s) annotation (Line(points={{80.7,-18},{
              166,-18},{166,16}}, color={0,0,127}));
      connect(greaterThreshold.y,PI_DCV1. k_in) annotation (Line(points={{239,18},{
              282,18},{282,38},{166,38},{166,24}}, color={255,0,255}));
      connect(PI_DFV.y,minMaxFilter1. u)
        annotation (Line(points={{157,64},{140,64}}, color={0,0,127}));
      connect(minMaxFilter1.y,add7. u1)
        annotation (Line(points={{116.6,64},{96,64}},  color={0,0,127}));
      connect(add4.u1,minMaxFilter. y)
        annotation (Line(points={{108,16},{112.6,16}}, color={0,0,127}));
      connect(minMaxFilter.u,PI_DCV1. y)
        annotation (Line(points={{136,16},{143,16}}, color={0,0,127}));
    end CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle_AR;

    model CS_IntermediateControl_PID_TESUC_ImpControl_2_Mikk
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand
      annotation(Dialog(tab="General"));

      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-4,
        Ti=5,
        Td=0.1,
        yMax=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-62,-116},{-42,-136}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-104,-136},{-84,-116}})));
      TRANSFORM.Controls.LimPID TCV_Power(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-8,
        Ti=1,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.0001,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-58,-28},{-38,-48}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand)
        annotation (Placement(transformation(extent={{96,-32},{110,-20}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
      Modelica.Blocks.Sources.Constant const8(k=0.015)
        annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2) annotation (Placement(transformation(extent={{
                -32,-128},{-24,-120}})));
      Data.TES_Setpoints data(
        p_steam=3398000,
        p_steam_vent=15000000,
        T_Steam_Ref=579.75,
        Q_Nom=46.5e6,
        T_Feedwater=421.15,
        T_SHS_Return=491.15)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Constant const3(k=67.3)
        annotation (Placement(transformation(extent={{-96,62},{-76,82}})));
      TRANSFORM.Controls.LimPID FWCP_mflow(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.1,
        Ti=20,
        Td=0.1,
        yMax=1250,
        yMin=-750,
        wp=0,
        wd=1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-66,62},{-46,82}})));
      Modelica.Blocks.Sources.Constant const4(k=1200)
        annotation (Placement(transformation(extent={{-40,80},{-32,88}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{-24,68},{-4,88}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{10,158},{30,178}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-58,134},{-38,154}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-98,134},{-78,154}})));
      Modelica.Blocks.Sources.Constant const11(k=0.001)
        annotation (Placement(transformation(extent={{156,-10},{148,-2}})));
      Modelica.Blocks.Math.Add         add4
        annotation (Placement(transformation(extent={{128,0},{108,20}})));
      Modelica.Blocks.Math.Add         add5
        annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
      TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-4e-9,
        Ti=1,
        k_s=1,
        k_m=1,
        yMax=1 - 0.015,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{152,-78},{132,-98}})));
      Modelica.Blocks.Sources.Constant const10(k=0.015)
        annotation (Placement(transformation(extent={{152,-122},{144,-114}})));
      Modelica.Blocks.Math.Add         add7
        annotation (Placement(transformation(extent={{116,48},{96,68}})));
      Modelica.Blocks.Sources.Constant const15(k=0.01)
        annotation (Placement(transformation(extent={{140,38},{132,46}})));
      Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
        annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=48e6)
        annotation (Placement(transformation(extent={{240,8},{260,28}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
        PI_DFV(
        k=10,
        Ti=25,
        k_s=5e-9,
        k_m=5e-9)
        annotation (Placement(transformation(extent={{200,54},{180,74}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
        PI_DCV1(
        k=10,
        Ti=25,
        k_s=5e-9,
        k_m=5e-9)
        annotation (Placement(transformation(extent={{186,6},{166,26}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        minMaxFilter(max=1 - 0.001)
        annotation (Placement(transformation(extent={{156,6},{136,26}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        minMaxFilter1(max=1 - 0.01)
        annotation (Placement(transformation(extent={{160,54},{140,74}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
      Modelica.Blocks.Sources.Constant const6(k=48e6)
        annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
      Modelica.Blocks.Sources.Constant const12(k=48.001e6)
        annotation (Placement(transformation(extent={{140,-84},{164,-60}})));
    equation
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-83,-126},{-64,-126}}, color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-52,-100},{-52,-114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-25.6,-50},{-18,-50}},
                                          color={0,0,127}));
      connect(TCV_Power.y, add1.u1)
        annotation (Line(points={{-37,-38},{-18,-38}}, color={0,0,127}));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-136},{-23.6,-136}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-124},{-23.44,-124}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-126},{
              -36,-126},{-36,-124},{-32.8,-124}},                        color={0,0,
              127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,-130},{13,-130}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-44},{5,-44}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_BV, const2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,118},{31,118},{31,168}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const3.y,FWCP_mflow. u_s)
        annotation (Line(points={{-75,72},{-68,72}}, color={0,0,127}));
      connect(FWCP_mflow.y, add.u2)
        annotation (Line(points={{-45,72},{-26,72}},
                                                   color={0,0,127}));
      connect(const4.y, add.u1)
        annotation (Line(points={{-31.6,84},{-26,84}},
                                                    color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,78},{-3,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-77,144},{-60,144}},
                                                     color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-120,-100},{-120,108},{-48,108},{-48,132}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,128},{-30,128},{-30,144},{-37,144}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const11.y, add4.u2) annotation (Line(points={{147.6,-6},{140,-6},{140,
              4},{130,4}},
                       color={0,0,127}));
      connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
          points={{30,-100},{30,10},{107,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(add5.u1, Charge_OnOff_Throttle.y)
        annotation (Line(points={{114,-90},{114,-88},{131,-88}},
                                                     color={0,0,127}));
      connect(add5.u2, const10.y) annotation (Line(points={{114,-102},{118,-102},{
              118,-118},{143.6,-118}},
                                color={0,0,127}));
      connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
          points={{30,-100},{30,-96},{91,-96}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
              46},{131.6,46},{131.6,42}}, color={0,0,127}));
      connect(actuatorBus.Discharge_OnOff_Throttle, add7.y) annotation (Line(
          points={{30,-100},{30,58},{95,58}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, TCV_Power.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{-48,-12},{-48,-26}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(TCV_Power.u_s, const1.y)
        annotation (Line(points={{-60,-38},{-71,-38}}, color={0,0,127}));
      connect(realExpression.y, greaterThreshold.u) annotation (Line(points={{110.7,
              -26},{224,-26},{224,18},{238,18}}, color={0,0,127}));
      connect(greaterThreshold.y, PI_DFV.k_in) annotation (Line(points={{261,18},{
              294,18},{294,14},{320,14},{320,72},{202,72}}, color={255,0,255}));
      connect(PI_DFV.u_s, realExpression.y) annotation (Line(points={{202,64},{210,
              64},{210,-26},{110.7,-26}}, color={0,0,127}));
      connect(sensorBus.Power, PI_DFV.u_m) annotation (Line(
          points={{-30,-100},{-30,-52},{194,-52},{194,52},{190,52}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, PI_DCV1.u_m) annotation (Line(
          points={{-30,-100},{-30,-52},{186,-52},{186,-6},{176,-6},{176,4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(realExpression.y, PI_DCV1.u_s) annotation (Line(points={{110.7,-26},{
              188,-26},{188,16}}, color={0,0,127}));
      connect(greaterThreshold.y, PI_DCV1.k_in) annotation (Line(points={{261,18},{
              304,18},{304,38},{188,38},{188,24}}, color={255,0,255}));
      connect(PI_DFV.y, minMaxFilter1.u)
        annotation (Line(points={{179,64},{162,64}}, color={0,0,127}));
      connect(minMaxFilter1.y, add7.u1)
        annotation (Line(points={{138.6,64},{118,64}}, color={0,0,127}));
      connect(add4.u1, minMaxFilter.y)
        annotation (Line(points={{130,16},{134.6,16}}, color={0,0,127}));
      connect(minMaxFilter.u, PI_DCV1.y)
        annotation (Line(points={{158,16},{165,16}}, color={0,0,127}));
      connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
          points={{-30,-100},{-120,-100},{-120,46},{-56,46},{-56,60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, min1.u2) annotation (Line(
          points={{-30,-100},{-30,-74},{90,-74},{90,-76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(min1.u1, const6.y)
        annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
      connect(Charge_OnOff_Throttle.u_m, min1.y) annotation (Line(points={{142,-76},
              {142,-66},{113,-66},{113,-70}}, color={0,0,127}));
      connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
              -26},{160,-64},{172,-64}}, color={0,0,127}));
      connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
              {238,-70},{238,-88},{154,-88}}, color={0,0,127}));
      connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
              -72},{165.2,-72}}, color={0,0,127}));
      annotation (Diagram(graphics={Text(
              extent={{-70,-142},{-20,-160}},
              textColor={28,108,200},
              textString="Feedwater")}));
    end CS_IntermediateControl_PID_TESUC_ImpControl_2_Mikk;

    model CS_IntermediateControl_PID_TESUC_ImpControl_3
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand
      annotation(Dialog(tab="General"));

      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-4,
        Ti=5,
        Td=0.1,
        yMax=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
      TRANSFORM.Controls.LimPID TCV_Power(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.0001,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand)
        annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.Constant const8(k=0.015)
        annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
      Data.TES_Setpoints data(
        p_steam=3398000,
        p_steam_vent=15000000,
        T_Steam_Ref=579.75,
        Q_Nom=46.5e6,
        T_Feedwater=421.15,
        T_SHS_Return=491.15)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=-10e6,
        rising=720,
        width=7200,
        falling=720,
        period=18000,
        nperiod=-2,
        offset=45e6,
        startTime=20000)
        annotation (Placement(transformation(extent={{68,74},{82,88}})));
      Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
        annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
      TRANSFORM.Controls.LimPID FWCP_mflow(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-4,
        Ti=30,
        Td=0.1,
        yMax=8000,
        yMin=-1450,
        wd=1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Sources.Constant const4(k=1500)
        annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{2,36},{22,56}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{2,74},{22,94}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
      TRANSFORM.Controls.LimPID MFlow_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-6,
        Ti=5,
        Td=0.1,
        yMax=0,
        yMin=-1,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-46,-80},{-34,-68}})));
      Modelica.Blocks.Sources.Constant const1(k=data.m_flow_reactor)
        annotation (Placement(transformation(extent={{-92,-88},{-72,-68}})));
      Modelica.Blocks.Sources.Constant const6(k=1)
        annotation (Placement(transformation(extent={{-26,-84},{-18,-76}})));
      Modelica.Blocks.Math.Add         add3
        annotation (Placement(transformation(extent={{-2,-84},{18,-64}})));
      TRANSFORM.Controls.LimPID SHS_TCV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.001,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{98,28},{78,8}})));
      Modelica.Blocks.Sources.Constant const11(k=1)
        annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
      Modelica.Blocks.Math.Add         add4
        annotation (Placement(transformation(extent={{62,0},{42,20}})));
      Modelica.Blocks.Math.Add         add5
        annotation (Placement(transformation(extent={{58,-76},{38,-56}})));
      TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=1 - 0.015,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{90,-50},{70,-70}})));
      Modelica.Blocks.Sources.Constant const10(k=0.015)
        annotation (Placement(transformation(extent={{82,-86},{74,-78}})));
      Modelica.Blocks.Math.Add add6
        annotation (Placement(transformation(extent={{134,-68},{114,-48}})));
      Modelica.Blocks.Sources.Constant const12(k=-data.Q_Nom)
        annotation (Placement(transformation(extent={{178,-74},{158,-54}})));
      Modelica.Blocks.Sources.Constant const13(k=0)
        annotation (Placement(transformation(extent={{98,-32},{90,-24}})));
      Modelica.Blocks.Math.Add         add7
        annotation (Placement(transformation(extent={{116,48},{96,68}})));
      TRANSFORM.Controls.LimPID Discharge_OnOff_Throttle(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.25e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=1 - 0.01,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{152,74},{132,54}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{156,92},{148,100}})));
      Modelica.Blocks.Sources.Constant const15(k=0.01)
        annotation (Placement(transformation(extent={{140,38},{132,46}})));
      Modelica.Blocks.Math.Add add8(k1=-1)
        annotation (Placement(transformation(extent={{192,56},{172,76}})));
      Modelica.Blocks.Sources.Constant const16(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{236,50},{216,70}})));
    equation
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                         color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-50,-100},{-50,-60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                          color={0,0,127}));
      connect(TCV_Power.y, add1.u1)
        annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
              -48},{-36,-40},{-32.8,-40}},                               color={0,0,
              127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,-46},{13,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-18},{13,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Steam_Pressure,FWCP_mflow. u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.opening_BV, const2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,84},{23,84}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const3.y,FWCP_mflow. u_s)
        annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
      connect(FWCP_mflow.y, add.u2)
        annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
      connect(const4.y, add.u1)
        annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,46},{23,46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const1.y, MFlow_Valve.u_s) annotation (Line(points={{-71,-78},{-64,-78},
              {-64,-70},{-56,-70},{-56,-74},{-47.2,-74}}, color={0,0,127}));
      connect(MFlow_Valve.y, add3.u1) annotation (Line(points={{-33.4,-74},{-32,-74},
              {-32,-72},{-10,-72},{-10,-68},{-4,-68}}, color={0,0,127}));
      connect(const6.y, add3.u2) annotation (Line(points={{-17.6,-80},{-16,-80},{-16,
              -76},{-8,-76},{-8,-86},{-4,-86},{-4,-80}}, color={0,0,127}));
      connect(sensorBus.Power, SHS_TCV.u_m) annotation (Line(
          points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(SHS_TCV.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
              {64,16}}, color={0,0,127}));
      connect(const11.y, add4.u2) annotation (Line(points={{77.6,-6},{70,-6},{70,4},
              {64,4}}, color={0,0,127}));
      connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
          points={{30,-100},{30,10},{41,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(realExpression.y, SHS_TCV.u_s) annotation (Line(points={{128.7,-26},{
              134,-26},{134,16},{100,16},{100,18}}, color={0,0,127}));
      connect(realExpression.y, TCV_Power.u_s) annotation (Line(points={{128.7,-26},
              {132,-26},{132,-38},{54,-38},{54,-2},{20,-2},{20,4},{-60,4},{-60,-12},
              {-52,-12}}, color={0,0,127}));
      connect(add5.u1, Charge_OnOff_Throttle.y)
        annotation (Line(points={{60,-60},{69,-60}}, color={0,0,127}));
      connect(add5.u2, const10.y) annotation (Line(points={{60,-72},{66,-72},{66,
              -82},{73.6,-82}}, color={0,0,127}));
      connect(Charge_OnOff_Throttle.u_s, add6.y) annotation (Line(points={{92,-60},
              {104,-60},{104,-58},{113,-58}}, color={0,0,127}));
      connect(realExpression.y, add6.u1) annotation (Line(points={{128.7,-26},{146,
              -26},{146,-52},{136,-52}}, color={0,0,127}));
      connect(add6.u2, const12.y)
        annotation (Line(points={{136,-64},{157,-64}}, color={0,0,127}));
      connect(const13.y, Charge_OnOff_Throttle.u_m)
        annotation (Line(points={{89.6,-28},{80,-28},{80,-48}}, color={0,0,127}));
      connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
          points={{30,-100},{30,-66},{37,-66}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add7.u1, Discharge_OnOff_Throttle.y)
        annotation (Line(points={{118,64},{131,64}}, color={0,0,127}));
      connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
              46},{131.6,46},{131.6,42}}, color={0,0,127}));
      connect(Discharge_OnOff_Throttle.u_s, add8.y) annotation (Line(points={{154,
              64},{161,64},{161,66},{171,66}}, color={0,0,127}));
      connect(Discharge_OnOff_Throttle.u_m, const14.y)
        annotation (Line(points={{142,76},{142,96},{147.6,96}}, color={0,0,127}));
      connect(add8.u2, const16.y)
        annotation (Line(points={{194,60},{215,60}}, color={0,0,127}));
      connect(realExpression.y, add8.u1) annotation (Line(points={{128.7,-26},{174,
              -26},{174,-18},{206,-18},{206,72},{194,72}}, color={0,0,127}));
      connect(actuatorBus.Discharge_OnOff_Throttle, add7.y) annotation (Line(
          points={{30,-100},{30,58},{95,58}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Reactor_mflow, MFlow_Valve.u_m) annotation (Line(
          points={{-30,-100},{-30,-86},{-40,-86},{-40,-81.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Reactor_mflow, add3.y) annotation (Line(
          points={{30,-100},{30,-74},{19,-74}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
    end CS_IntermediateControl_PID_TESUC_ImpControl_3;

    model CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand
      annotation(Dialog(tab="General"));

      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand)
        annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
      Data.TES_Setpoints data(
        p_steam=1200000,
        p_steam_vent=15000000,
        T_Steam_Ref=579.75,
        Q_Nom=46.5e6,
        T_Feedwater=421.15,
        T_SHS_Return=491.15)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=-10e6,
        rising=720,
        width=7200,
        falling=720,
        period=18000,
        nperiod=-2,
        offset=45e6,
        startTime=20000)
        annotation (Placement(transformation(extent={{68,74},{82,88}})));
      TRANSFORM.Controls.LimPID SHS_TCV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.005,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{98,28},{78,8}})));
      Modelica.Blocks.Sources.Constant const11(k=1)
        annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
      Modelica.Blocks.Math.Add         add4
        annotation (Placement(transformation(extent={{62,0},{42,20}})));
      Modelica.Blocks.Math.Add         add7
        annotation (Placement(transformation(extent={{116,48},{96,68}})));
      TRANSFORM.Controls.LimPID Discharge_OnOff_Throttle(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.5e-9,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=1 - 0.01,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{152,74},{132,54}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{156,92},{148,100}})));
      Modelica.Blocks.Sources.Constant const15(k=0.01)
        annotation (Placement(transformation(extent={{140,38},{132,46}})));
      Modelica.Blocks.Math.Add add8(k1=-1)
        annotation (Placement(transformation(extent={{192,56},{172,76}})));
      Modelica.Blocks.Sources.Constant const16(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{236,50},{216,70}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression1(y=electric_demand - data.Q_Nom)
        annotation (Placement(transformation(extent={{166,12},{152,24}})));
      Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
        annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-4,
        Ti=5,
        Td=0.1,
        yMax=2500,
        yMin=0,
        wd=1,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-58,62},{-38,82}})));
      Modelica.Blocks.Sources.Constant const4(k=100)
        annotation (Placement(transformation(extent={{-32,80},{-24,88}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{-16,68},{4,88}})));
    equation
      connect(sensorBus.Power, SHS_TCV.u_m) annotation (Line(
          points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(SHS_TCV.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
              {64,16}}, color={0,0,127}));
      connect(const11.y, add4.u2) annotation (Line(points={{77.6,-6},{70,-6},{70,4},
              {64,4}}, color={0,0,127}));
      connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
          points={{30,-100},{30,10},{41,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(add7.u1, Discharge_OnOff_Throttle.y)
        annotation (Line(points={{118,64},{131,64}}, color={0,0,127}));
      connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
              46},{131.6,46},{131.6,42}}, color={0,0,127}));
      connect(Discharge_OnOff_Throttle.u_s, add8.y) annotation (Line(points={{154,
              64},{161,64},{161,66},{171,66}}, color={0,0,127}));
      connect(Discharge_OnOff_Throttle.u_m, const14.y)
        annotation (Line(points={{142,76},{142,96},{147.6,96}}, color={0,0,127}));
      connect(add8.u2, const16.y)
        annotation (Line(points={{194,60},{215,60}}, color={0,0,127}));
      connect(realExpression.y, add8.u1) annotation (Line(points={{128.7,-26},{174,
              -26},{174,-18},{206,-18},{206,72},{194,72}}, color={0,0,127}));
      connect(actuatorBus.Discharge_OnOff_Throttle, add7.y) annotation (Line(
          points={{30,-100},{30,58},{95,58}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(realExpression1.y, SHS_TCV.u_s)
        annotation (Line(points={{151.3,18},{100,18}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure,FWCP_Speed. u_m) annotation (Line(
          points={{-30,-100},{-118,-100},{-118,40},{-48,40},{-48,60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(const3.y,FWCP_Speed. u_s)
        annotation (Line(points={{-69,72},{-60,72}}, color={0,0,127}));
      connect(FWCP_Speed.y,add. u2)
        annotation (Line(points={{-37,72},{-18,72}},
                                                   color={0,0,127}));
      connect(const4.y,add. u1)
        annotation (Line(points={{-23.6,84},{-18,84}},
                                                    color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
          points={{30,-100},{30,78},{5,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end CS_IntermediateControl_PID_TESUC_1_Intermediate_SmallCycle;

    model CS_IntermediateControl_PID_TESUC_1_intermediate
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand
      annotation(Dialog(tab="General"));

      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-4,
        Ti=5,
        Td=0.1,
        yMax=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
      TRANSFORM.Controls.LimPID TCV_Power(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.0001,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand)
        annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.Constant const8(k=0.015)
        annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
      Data.TES_Setpoints data(
        p_steam=3398000,
        p_steam_vent=15000000,
        T_Steam_Ref=579.75,
        Q_Nom=46.5e6,
        T_Feedwater=421.15,
        T_SHS_Return=491.15)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=-10e6,
        rising=720,
        width=7200,
        falling=720,
        period=18000,
        nperiod=-2,
        offset=45e6,
        startTime=20000)
        annotation (Placement(transformation(extent={{68,74},{82,88}})));
      Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
        annotation (Placement(transformation(extent={{-72,30},{-52,50}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PID,
        k=2.5e-5,
        Ti=20,
        Td=0.1,
        yMax=250,
        yMin=-67,
        wp=0,
        wd=1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Sources.Constant const4(k=67)
        annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{2,36},{22,56}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{2,74},{22,94}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
      TRANSFORM.Controls.LimPID SHS_TCV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.001,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{98,28},{78,8}})));
      Modelica.Blocks.Sources.Constant const11(k=1)
        annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
      Modelica.Blocks.Math.Add         add4
        annotation (Placement(transformation(extent={{62,0},{42,20}})));
      Modelica.Blocks.Math.Add         add5
        annotation (Placement(transformation(extent={{58,-76},{38,-56}})));
      TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-9,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=1 - 0.015,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{90,-50},{70,-70}})));
      Modelica.Blocks.Sources.Constant const10(k=0.015)
        annotation (Placement(transformation(extent={{82,-86},{74,-78}})));
      Modelica.Blocks.Math.Add add6
        annotation (Placement(transformation(extent={{134,-68},{114,-48}})));
      Modelica.Blocks.Sources.Constant const12(k=-data.Q_Nom)
        annotation (Placement(transformation(extent={{178,-74},{158,-54}})));
      Modelica.Blocks.Sources.Constant const13(k=0)
        annotation (Placement(transformation(extent={{98,-32},{90,-24}})));
      Modelica.Blocks.Math.Add         add7
        annotation (Placement(transformation(extent={{116,48},{96,68}})));
      TRANSFORM.Controls.LimPID Discharge_OnOff_Throttle(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.5e-9,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=1 - 0.01,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{152,74},{132,54}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{156,92},{148,100}})));
      Modelica.Blocks.Sources.Constant const15(k=0.01)
        annotation (Placement(transformation(extent={{140,38},{132,46}})));
      Modelica.Blocks.Math.Add add8(k1=-1)
        annotation (Placement(transformation(extent={{192,56},{172,76}})));
      Modelica.Blocks.Sources.Constant const16(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{236,50},{216,70}})));
    equation
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                         color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-50,-100},{-50,-60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                          color={0,0,127}));
      connect(TCV_Power.y, add1.u1)
        annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
              -48},{-36,-40},{-32.8,-40}},                               color={0,0,
              127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,-46},{13,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-18},{13,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.opening_BV, const2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,84},{23,84}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const3.y, FWCP_Speed.u_s)
        annotation (Line(points={{-51,40},{-42,40}}, color={0,0,127}));
      connect(FWCP_Speed.y, add.u2)
        annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
      connect(const4.y, add.u1)
        annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,46},{23,46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Power, SHS_TCV.u_m) annotation (Line(
          points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(SHS_TCV.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
              {64,16}}, color={0,0,127}));
      connect(const11.y, add4.u2) annotation (Line(points={{77.6,-6},{70,-6},{70,4},
              {64,4}}, color={0,0,127}));
      connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
          points={{30,-100},{30,10},{41,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(realExpression.y, SHS_TCV.u_s) annotation (Line(points={{128.7,-26},{
              134,-26},{134,16},{100,16},{100,18}}, color={0,0,127}));
      connect(realExpression.y, TCV_Power.u_s) annotation (Line(points={{128.7,-26},
              {132,-26},{132,-38},{54,-38},{54,-2},{20,-2},{20,4},{-60,4},{-60,-12},
              {-52,-12}}, color={0,0,127}));
      connect(add5.u1, Charge_OnOff_Throttle.y)
        annotation (Line(points={{60,-60},{69,-60}}, color={0,0,127}));
      connect(add5.u2, const10.y) annotation (Line(points={{60,-72},{66,-72},{66,
              -82},{73.6,-82}}, color={0,0,127}));
      connect(Charge_OnOff_Throttle.u_s, add6.y) annotation (Line(points={{92,-60},
              {104,-60},{104,-58},{113,-58}}, color={0,0,127}));
      connect(realExpression.y, add6.u1) annotation (Line(points={{128.7,-26},{146,
              -26},{146,-52},{136,-52}}, color={0,0,127}));
      connect(add6.u2, const12.y)
        annotation (Line(points={{136,-64},{157,-64}}, color={0,0,127}));
      connect(const13.y, Charge_OnOff_Throttle.u_m)
        annotation (Line(points={{89.6,-28},{80,-28},{80,-48}}, color={0,0,127}));
      connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
          points={{30,-100},{30,-66},{37,-66}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add7.u1, Discharge_OnOff_Throttle.y)
        annotation (Line(points={{118,64},{131,64}}, color={0,0,127}));
      connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
              46},{131.6,46},{131.6,42}}, color={0,0,127}));
      connect(Discharge_OnOff_Throttle.u_s, add8.y) annotation (Line(points={{154,
              64},{161,64},{161,66},{171,66}}, color={0,0,127}));
      connect(Discharge_OnOff_Throttle.u_m, const14.y)
        annotation (Line(points={{142,76},{142,96},{147.6,96}}, color={0,0,127}));
      connect(add8.u2, const16.y)
        annotation (Line(points={{194,60},{215,60}}, color={0,0,127}));
      connect(realExpression.y, add8.u1) annotation (Line(points={{128.7,-26},{174,
              -26},{174,-18},{206,-18},{206,72},{194,72}}, color={0,0,127}));
      connect(actuatorBus.Discharge_OnOff_Throttle, add7.y) annotation (Line(
          points={{30,-100},{30,58},{95,58}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
    end CS_IntermediateControl_PID_TESUC_1_intermediate;

    model CS_IntermediateControl_PID_TESUC_ImpControl_2
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand
      annotation(Dialog(tab="General"));

      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-4,
        Ti=5,
        Td=0.1,
        yMax=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
      TRANSFORM.Controls.LimPID TCV_Power(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.0001,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand)
        annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.Constant const8(k=0.015)
        annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
      Data.TES_Setpoints data(
        p_steam=3398000,
        p_steam_vent=15000000,
        T_Steam_Ref=579.75,
        Q_Nom=46.5e6,
        T_Feedwater=421.15,
        T_SHS_Return=491.15)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=-10e6,
        rising=720,
        width=7200,
        falling=720,
        period=18000,
        nperiod=-2,
        offset=45e6,
        startTime=20000)
        annotation (Placement(transformation(extent={{68,74},{82,88}})));
      Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
        annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
      TRANSFORM.Controls.LimPID FWCP_mflow(
        controllerType=Modelica.Blocks.Types.SimpleController.PID,
        k=2.5e-5,
        Ti=20,
        Td=0.1,
        yMax=250,
        yMin=-67,
        wp=0,
        wd=1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Sources.Constant const4(k=67)
        annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{2,36},{22,56}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{2,74},{22,94}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
      TRANSFORM.Controls.LimPID SHS_Pump_MFR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-3,
        Ti=5,
        Td=0.1,
        yMax=100,
        yMin=-19.9,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-46,-80},{-34,-68}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_SHS_Return)
        annotation (Placement(transformation(extent={{-92,-88},{-72,-68}})));
      Modelica.Blocks.Sources.Constant const6(k=20)
        annotation (Placement(transformation(extent={{-26,-84},{-18,-76}})));
      Modelica.Blocks.Math.Add         add3
        annotation (Placement(transformation(extent={{-2,-84},{18,-64}})));
      TRANSFORM.Controls.LimPID SHS_TCV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.001,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{98,28},{78,8}})));
      Modelica.Blocks.Sources.Constant const11(k=1)
        annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
      Modelica.Blocks.Math.Add         add4
        annotation (Placement(transformation(extent={{62,0},{42,20}})));
      Modelica.Blocks.Math.Add         add5
        annotation (Placement(transformation(extent={{58,-76},{38,-56}})));
      TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-9,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=1 - 0.015,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{90,-50},{70,-70}})));
      Modelica.Blocks.Sources.Constant const10(k=0.015)
        annotation (Placement(transformation(extent={{82,-86},{74,-78}})));
      Modelica.Blocks.Math.Add add6
        annotation (Placement(transformation(extent={{134,-68},{114,-48}})));
      Modelica.Blocks.Sources.Constant const12(k=-data.Q_Nom)
        annotation (Placement(transformation(extent={{178,-74},{158,-54}})));
      Modelica.Blocks.Sources.Constant const13(k=0)
        annotation (Placement(transformation(extent={{98,-32},{90,-24}})));
      Modelica.Blocks.Math.Add         add7
        annotation (Placement(transformation(extent={{116,48},{96,68}})));
      TRANSFORM.Controls.LimPID Discharge_OnOff_Throttle(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.5e-9,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=1 - 0.01,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{152,74},{132,54}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{156,92},{148,100}})));
      Modelica.Blocks.Sources.Constant const15(k=0.01)
        annotation (Placement(transformation(extent={{140,38},{132,46}})));
      Modelica.Blocks.Math.Add add8(k1=-1)
        annotation (Placement(transformation(extent={{192,56},{172,76}})));
      Modelica.Blocks.Sources.Constant const16(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{236,50},{216,70}})));
    equation
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                         color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-50,-100},{-50,-60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                          color={0,0,127}));
      connect(TCV_Power.y, add1.u1)
        annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
              -48},{-36,-40},{-32.8,-40}},                               color={0,0,
              127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,-46},{13,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-18},{13,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Steam_Pressure,FWCP_mflow. u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.opening_BV, const2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,84},{23,84}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const3.y,FWCP_mflow. u_s)
        annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
      connect(FWCP_mflow.y, add.u2)
        annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
      connect(const4.y, add.u1)
        annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,46},{23,46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.SHS_Return_T, SHS_Pump_MFR.u_m) annotation (Line(
          points={{-30,-100},{-40,-100},{-40,-81.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(const1.y, SHS_Pump_MFR.u_s) annotation (Line(points={{-71,-78},{-56,-78},
              {-56,-74},{-47.2,-74}}, color={0,0,127}));
      connect(SHS_Pump_MFR.y, add3.u1) annotation (Line(points={{-33.4,-74},{-32,-74},
              {-32,-72},{-10,-72},{-10,-68},{-4,-68}}, color={0,0,127}));
      connect(const6.y, add3.u2) annotation (Line(points={{-17.6,-80},{-16,-80},{-16,
              -76},{-8,-76},{-8,-86},{-4,-86},{-4,-80}}, color={0,0,127}));
      connect(sensorBus.Power, SHS_TCV.u_m) annotation (Line(
          points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(SHS_TCV.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
              {64,16}}, color={0,0,127}));
      connect(const11.y, add4.u2) annotation (Line(points={{77.6,-6},{70,-6},{70,4},
              {64,4}}, color={0,0,127}));
      connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
          points={{30,-100},{30,10},{41,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(realExpression.y, SHS_TCV.u_s) annotation (Line(points={{128.7,-26},{
              134,-26},{134,16},{100,16},{100,18}}, color={0,0,127}));
      connect(realExpression.y, TCV_Power.u_s) annotation (Line(points={{128.7,-26},
              {132,-26},{132,-38},{54,-38},{54,-2},{20,-2},{20,4},{-60,4},{-60,-12},
              {-52,-12}}, color={0,0,127}));
      connect(add5.u1, Charge_OnOff_Throttle.y)
        annotation (Line(points={{60,-60},{69,-60}}, color={0,0,127}));
      connect(add5.u2, const10.y) annotation (Line(points={{60,-72},{66,-72},{66,
              -82},{73.6,-82}}, color={0,0,127}));
      connect(Charge_OnOff_Throttle.u_s, add6.y) annotation (Line(points={{92,-60},
              {104,-60},{104,-58},{113,-58}}, color={0,0,127}));
      connect(realExpression.y, add6.u1) annotation (Line(points={{128.7,-26},{146,
              -26},{146,-52},{136,-52}}, color={0,0,127}));
      connect(add6.u2, const12.y)
        annotation (Line(points={{136,-64},{157,-64}}, color={0,0,127}));
      connect(const13.y, Charge_OnOff_Throttle.u_m)
        annotation (Line(points={{89.6,-28},{80,-28},{80,-48}}, color={0,0,127}));
      connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
          points={{30,-100},{30,-66},{37,-66}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add7.u1, Discharge_OnOff_Throttle.y)
        annotation (Line(points={{118,64},{131,64}}, color={0,0,127}));
      connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
              46},{131.6,46},{131.6,42}}, color={0,0,127}));
      connect(Discharge_OnOff_Throttle.u_s, add8.y) annotation (Line(points={{154,
              64},{161,64},{161,66},{171,66}}, color={0,0,127}));
      connect(Discharge_OnOff_Throttle.u_m, const14.y)
        annotation (Line(points={{142,76},{142,96},{147.6,96}}, color={0,0,127}));
      connect(add8.u2, const16.y)
        annotation (Line(points={{194,60},{215,60}}, color={0,0,127}));
      connect(realExpression.y, add8.u1) annotation (Line(points={{128.7,-26},{174,
              -26},{174,-18},{206,-18},{206,72},{194,72}}, color={0,0,127}));
      connect(actuatorBus.Discharge_OnOff_Throttle, add7.y) annotation (Line(
          points={{30,-100},{30,58},{95,58}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
    end CS_IntermediateControl_PID_TESUC_ImpControl_2;

    model CS_IntermediateControl_PID_TESUC_ImpControl
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand
      annotation(Dialog(tab="General"));

      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-4,
        Ti=5,
        Td=0.1,
        yMax=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
      TRANSFORM.Controls.LimPID TCV_Power(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.0001,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand)
        annotation (Placement(transformation(extent={{114,-32},{128,-20}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.Constant const8(k=0.015)
        annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
      Data.TES_Setpoints data(
        p_steam=3398000,
        p_steam_vent=15000000,
        T_Steam_Ref=579.75,
        Q_Nom=40e6,
        T_Feedwater=421.15,
        T_SHS_Return=491.15)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=-10e6,
        rising=720,
        width=7200,
        falling=720,
        period=18000,
        nperiod=-2,
        offset=45e6,
        startTime=20000)
        annotation (Placement(transformation(extent={{68,74},{82,88}})));
      Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
        annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-7,
        Ti=20,
        yMax=250,
        yMin=-72,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Sources.Constant const4(k=72.1)
        annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{2,36},{22,56}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{2,74},{22,94}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
      TRANSFORM.Controls.LimPID SHS_Pump_MFR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-3,
        Ti=5,
        Td=0.1,
        yMax=100,
        yMin=-19.9,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-46,-80},{-34,-68}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_SHS_Return)
        annotation (Placement(transformation(extent={{-92,-88},{-72,-68}})));
      Modelica.Blocks.Sources.Constant const6(k=20)
        annotation (Placement(transformation(extent={{-26,-84},{-18,-76}})));
      Modelica.Blocks.Math.Add         add3
        annotation (Placement(transformation(extent={{-2,-84},{18,-64}})));
      TRANSFORM.Controls.LimPID SHS_TCV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.0001,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{98,28},{78,8}})));
      Modelica.Blocks.Sources.Constant const11(k=1)
        annotation (Placement(transformation(extent={{86,-10},{78,-2}})));
      Modelica.Blocks.Math.Add         add4
        annotation (Placement(transformation(extent={{62,0},{42,20}})));
      Modelica.Blocks.Math.Add         add5
        annotation (Placement(transformation(extent={{58,-76},{38,-56}})));
      TRANSFORM.Controls.LimPID SHS_Throttle(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=1 - 0.015,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{90,-50},{70,-70}})));
      Modelica.Blocks.Sources.Constant const10(k=0.015)
        annotation (Placement(transformation(extent={{82,-86},{74,-78}})));
      Modelica.Blocks.Math.Add add6
        annotation (Placement(transformation(extent={{134,-68},{114,-48}})));
      Modelica.Blocks.Sources.Constant const12(k=-data.Q_Nom)
        annotation (Placement(transformation(extent={{178,-74},{158,-54}})));
      Modelica.Blocks.Sources.Constant const13(k=0)
        annotation (Placement(transformation(extent={{98,-32},{90,-24}})));
      Modelica.Blocks.Math.Add         add7
        annotation (Placement(transformation(extent={{116,48},{96,68}})));
      TRANSFORM.Controls.LimPID Discharge_MassFlow(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-2e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-18,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{150,74},{130,54}})));
      Modelica.Blocks.Sources.Constant const14(k=0)
        annotation (Placement(transformation(extent={{156,92},{148,100}})));
      Modelica.Blocks.Sources.Constant const15(k=20)
        annotation (Placement(transformation(extent={{140,38},{132,46}})));
      Modelica.Blocks.Math.Add add8(k1=-1)
        annotation (Placement(transformation(extent={{192,56},{172,76}})));
      Modelica.Blocks.Sources.Constant const16(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{236,50},{216,70}})));
    equation
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                         color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-50,-100},{-50,-60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                          color={0,0,127}));
      connect(TCV_Power.y, add1.u1)
        annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
              -48},{-36,-40},{-32.8,-40}},                               color={0,0,
              127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,-46},{13,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-18},{13,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.opening_BV, const2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,84},{23,84}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const3.y, FWCP_Speed.u_s)
        annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
      connect(FWCP_Speed.y, add.u2)
        annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
      connect(const4.y, add.u1)
        annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,46},{23,46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.SHS_Return_T, SHS_Pump_MFR.u_m) annotation (Line(
          points={{-30,-100},{-40,-100},{-40,-81.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(const1.y, SHS_Pump_MFR.u_s) annotation (Line(points={{-71,-78},{-56,-78},
              {-56,-74},{-47.2,-74}}, color={0,0,127}));
      connect(SHS_Pump_MFR.y, add3.u1) annotation (Line(points={{-33.4,-74},{-32,-74},
              {-32,-72},{-10,-72},{-10,-68},{-4,-68}}, color={0,0,127}));
      connect(const6.y, add3.u2) annotation (Line(points={{-17.6,-80},{-16,-80},{-16,
              -76},{-8,-76},{-8,-86},{-4,-86},{-4,-80}}, color={0,0,127}));
      connect(sensorBus.Power, SHS_TCV.u_m) annotation (Line(
          points={{-30,-100},{106,-100},{106,36},{88,36},{88,30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(SHS_TCV.y, add4.u1) annotation (Line(points={{77,18},{70,18},{70,16},
              {64,16}}, color={0,0,127}));
      connect(const11.y, add4.u2) annotation (Line(points={{77.6,-6},{70,-6},{70,4},
              {64,4}}, color={0,0,127}));
      connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
          points={{30,-100},{30,10},{41,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(realExpression.y, SHS_TCV.u_s) annotation (Line(points={{128.7,-26},{
              134,-26},{134,16},{100,16},{100,18}}, color={0,0,127}));
      connect(realExpression.y, TCV_Power.u_s) annotation (Line(points={{128.7,-26},
              {132,-26},{132,-38},{54,-38},{54,-2},{20,-2},{20,4},{-60,4},{-60,-12},
              {-52,-12}}, color={0,0,127}));
      connect(add5.u1, SHS_Throttle.y)
        annotation (Line(points={{60,-60},{69,-60}}, color={0,0,127}));
      connect(add5.u2, const10.y) annotation (Line(points={{60,-72},{66,-72},{66,
              -82},{73.6,-82}}, color={0,0,127}));
      connect(SHS_Throttle.u_s, add6.y) annotation (Line(points={{92,-60},{104,-60},
              {104,-58},{113,-58}}, color={0,0,127}));
      connect(realExpression.y, add6.u1) annotation (Line(points={{128.7,-26},{146,
              -26},{146,-52},{136,-52}}, color={0,0,127}));
      connect(add6.u2, const12.y)
        annotation (Line(points={{136,-64},{157,-64}}, color={0,0,127}));
      connect(const13.y, SHS_Throttle.u_m)
        annotation (Line(points={{89.6,-28},{80,-28},{80,-48}}, color={0,0,127}));
      connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
          points={{30,-100},{30,-66},{37,-66}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.condensor_pump, add7.y) annotation (Line(
          points={{30,-100},{30,58},{95,58}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(add7.u1, Discharge_MassFlow.y)
        annotation (Line(points={{118,64},{129,64}}, color={0,0,127}));
      connect(add7.u2, const15.y) annotation (Line(points={{118,52},{122,52},{122,
              46},{131.6,46},{131.6,42}}, color={0,0,127}));
      connect(Discharge_MassFlow.u_s, add8.y) annotation (Line(points={{152,64},{
              161,64},{161,66},{171,66}}, color={0,0,127}));
      connect(Discharge_MassFlow.u_m, const14.y)
        annotation (Line(points={{140,76},{140,96},{147.6,96}}, color={0,0,127}));
      connect(add8.u2, const16.y)
        annotation (Line(points={{194,60},{215,60}}, color={0,0,127}));
      connect(realExpression.y, add8.u1) annotation (Line(points={{128.7,-26},{174,
              -26},{174,-18},{206,-18},{206,72},{194,72}}, color={0,0,127}));
    end CS_IntermediateControl_PID_TESUC_ImpControl;

    model CS_IntermediateControl_PID_6_Pressure
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand_int = data.Q_Nom;

      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-4,
        Ti=60,
        Td=0.1,
        yMax=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
      TRANSFORM.Controls.LimPID TCV_Power(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.0001,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand_int)
        annotation (Placement(transformation(extent={{-94,-6},{-80,6}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.Constant const8(k=0)
        annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
      Data.TES_Setpoints data(
        p_steam(displayUnit="Pa") = 1197000,
        p_steam_vent(displayUnit="Pa") = 15000000,
        T_Steam_Ref=491.15,
        Q_Nom=18.57e6,
        T_Feedwater=309.9)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{62,-12},{82,8}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=-10e6,
        rising=720,
        width=7200,
        falling=720,
        period=18000,
        nperiod=-2,
        offset=45e6,
        startTime=20000)
        annotation (Placement(transformation(extent={{-92,-22},{-78,-8}})));
      Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
        annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5,
        Ti=5,
        yMax=100,
        yMin=-12,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Sources.Constant const4(k=12e5)
        annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{2,36},{22,56}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{2,74},{22,94}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
    equation
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                         color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-50,-100},{-50,-60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                          color={0,0,127}));
      connect(TCV_Power.y, add1.u1)
        annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
              -48},{-36,-40},{-32.8,-40}},                               color={0,0,
              127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,-46},{13,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-18},{13,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.opening_BV, const2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,84},{23,84}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const3.y, FWCP_Speed.u_s)
        annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
      connect(FWCP_Speed.y, add.u2)
        annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
      connect(const4.y, add.u1)
        annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,46},{23,46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(TCV_Power.u_s, const.y) annotation (Line(points={{-52,-12},{-58,-12},
              {-58,4},{50,4},{50,18},{88,18},{88,-2},{83,-2}}, color={0,0,127}));
    end CS_IntermediateControl_PID_6_Pressure;

    model CS_IntermediateControl_PID_TESUC
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand_int = data.Q_Nom;

      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-4,
        Ti=5,
        Td=0.1,
        yMax=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
      TRANSFORM.Controls.LimPID TCV_Power(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.0001,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand_int)
        annotation (Placement(transformation(extent={{-94,-6},{-80,6}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.Constant const8(k=0.015)
        annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
      Data.TES_Setpoints data(
        p_steam=3398000,
        p_steam_vent=15000000,
        T_Steam_Ref=579.75,
        Q_Nom=67.38e6,
        T_Feedwater=421.15)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{62,-12},{82,8}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=-10e6,
        rising=720,
        width=7200,
        falling=720,
        period=18000,
        nperiod=-2,
        offset=45e6,
        startTime=20000)
        annotation (Placement(transformation(extent={{-92,-22},{-78,-8}})));
      Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
        annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-7,
        Ti=20,
        yMax=250,
        yMin=-72,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Sources.Constant const4(k=72.1)
        annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{2,36},{22,56}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{2,74},{22,94}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
    equation
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                         color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-50,-100},{-50,-60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                          color={0,0,127}));
      connect(TCV_Power.y, add1.u1)
        annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
              -48},{-36,-40},{-32.8,-40}},                               color={0,0,
              127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,-46},{13,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-18},{13,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.opening_BV, const2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,84},{23,84}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const3.y, FWCP_Speed.u_s)
        annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
      connect(FWCP_Speed.y, add.u2)
        annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
      connect(const4.y, add.u1)
        annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,46},{23,46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const.y, TCV_Power.u_s) annotation (Line(points={{83,-2},{88,-2},{88,
              14},{-14,14},{-14,4},{-60,4},{-60,-12},{-52,-12}}, color={0,0,127}));
    end CS_IntermediateControl_PID_TESUC;

    model CS_IntermediateControl_PID_6
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand_int = data.Q_Nom;

      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-4,
        Ti=60,
        Td=0.1,
        yMax=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
      TRANSFORM.Controls.LimPID TCV_Power(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.0001,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand_int)
        annotation (Placement(transformation(extent={{-94,-6},{-80,6}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.Constant const8(k=0)
        annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Data.TES_Setpoints data(
        p_steam(displayUnit="bar") = 3400000,
        p_steam_vent(displayUnit="Pa") = 15000000,
        T_Steam_Ref=579.15,
        Q_Nom=30e6,
        T_Feedwater=323.15)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{62,-12},{82,8}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=-10e6,
        rising=720,
        width=7200,
        falling=720,
        period=18000,
        nperiod=-2,
        offset=45e6,
        startTime=20000)
        annotation (Placement(transformation(extent={{-92,-22},{-78,-8}})));
      Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
        annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-5,
        Ti=20,
        yMax=250,
        yMin=-20,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Sources.Constant const4(k=200)
        annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{2,36},{22,56}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{2,74},{22,94}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
    equation
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                         color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-50,-100},{-50,-60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                          color={0,0,127}));
      connect(TCV_Power.y, add1.u1)
        annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                             color=
              {0,0,127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,-46},{13,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-18},{13,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.opening_BV, const2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,84},{23,84}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const3.y, FWCP_Speed.u_s)
        annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
      connect(FWCP_Speed.y, add.u2)
        annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
      connect(const4.y, add.u1)
        annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,46},{23,46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(TCV_Power.u_s, const.y) annotation (Line(points={{-52,-12},{-58,-12},
              {-58,4},{50,4},{50,18},{88,18},{88,-2},{83,-2}}, color={0,0,127}));
      connect(Turb_Divert_Valve.y, add2.u1)
        annotation (Line(points={{-39,-48},{-39,-40},{-10,-40}}, color={0,0,127}));
    end CS_IntermediateControl_PID_6;

    model CS_IntermediateControl_PID_5
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand_int = data.Q_Nom;

      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-4,
        Ti=60,
        Td=0.1,
        yMax=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
      TRANSFORM.Controls.LimPID TCV_Power(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-8,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.0001,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand_int)
        annotation (Placement(transformation(extent={{-94,-6},{-80,6}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.Constant const8(k=0)
        annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
      Data.TES_Setpoints data(
        p_steam=3500000,
        p_steam_vent=15000000,
        T_Steam_Ref=579.75,
        Q_Nom=60e6,
        T_Feedwater=421.15)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{62,-12},{82,8}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=-10e6,
        rising=720,
        width=7200,
        falling=720,
        period=18000,
        nperiod=-2,
        offset=45e6,
        startTime=20000)
        annotation (Placement(transformation(extent={{-92,-22},{-78,-8}})));
      Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
        annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2.5e-7,
        Ti=20,
        yMax=250,
        yMin=-72,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Sources.Constant const4(k=72.1)
        annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{2,36},{22,56}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{2,74},{22,94}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
    equation
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-71,-46},{-66,-46},{-66,-48},{-62,-48}},
                                                         color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-50,-100},{-50,-60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                          color={0,0,127}));
      connect(TCV_Power.y, add1.u1)
        annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-48},{-36,
              -48},{-36,-40},{-32.8,-40}},                               color={0,0,
              127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,-46},{13,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-18},{13,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Steam_Pressure, FWCP_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-30,8},{-30,28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.opening_BV, const2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,84},{23,84}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const3.y, FWCP_Speed.u_s)
        annotation (Line(points={{-49,40},{-42,40}}, color={0,0,127}));
      connect(FWCP_Speed.y, add.u2)
        annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
      connect(const4.y, add.u1)
        annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,46},{23,46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(TCV_Power.u_s, const.y) annotation (Line(points={{-52,-12},{-58,-12},
              {-58,4},{50,4},{50,18},{88,18},{88,-2},{83,-2}}, color={0,0,127}));
    end CS_IntermediateControl_PID_5;

    model CS_IntermediateControl_PID_3
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1,
        Ti=15,
        yMax=750,
        yMin=-1500,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-38,32},{-18,52}})));
      Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
        annotation (Placement(transformation(extent={{-70,32},{-50,52}})));
      Modelica.Blocks.Sources.Constant const4(k=1500)
        annotation (Placement(transformation(extent={{-14,50},{-6,58}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{2,38},{22,58}})));
      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-5,
        Ti=5,
        Td=0.1,
        yMax=1,
        yMin=1e-3,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-60,-56},{-40,-36}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
      TRANSFORM.Controls.LimPID TCV_Position(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-9,
        Ti=5,
        yMax=0,
        yMin=-1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-54,-2},{-34,-22}})));
      Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{-84,-22},{-64,-2}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.Constant const8(k=0)
        annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-9,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,68},{-18,88}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-78,68},{-58,88}})));
      Fluid.Intermediate_Rankine data(
        p_steam_vent=3600000,
        T_Steam_Ref=579.75,
        Q_Nom=60e6,
        T_Feedwater=421.15)
        annotation (Placement(transformation(extent={{-96,12},{-76,32}})));
      Modelica.Blocks.Math.Add         add3
        annotation (Placement(transformation(extent={{-8,-82},{12,-62}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{-32,-82},{-24,-74}})));
      TRANSFORM.Controls.LimPID CondensorBalance(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-2,
        Ti=15,
        yMax=2000,
        yMin=-2000,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500,
        y_start=0)
        annotation (Placement(transformation(extent={{-86,-90},{-66,-70}})));
    equation
      connect(const3.y,FWCP_Speed. u_s) annotation (Line(points={{-49,42},{-40,42}},
                                  color={0,0,127}));
      connect(sensorBus.Steam_Temperature,FWCP_Speed. u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-28,8},{-28,30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const4.y,add. u1) annotation (Line(points={{-5.6,54},{0,54}},
                                       color={0,0,127}));
      connect(FWCP_Speed.y,add. u2) annotation (Line(points={{-17,42},{0,42}},
                        color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
          points={{30,-100},{30,48},{23,48}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-71,-46},{-62,-46}},   color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-50,-100},{-50,-58}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const6.y,TCV_Position. u_s)
        annotation (Line(points={{-63,-12},{-56,-12}},   color={0,0,127}));
      connect(sensorBus.Power,TCV_Position. u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-44,8},{-44,0}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                          color={0,0,127}));
      connect(TCV_Position.y,add1. u1) annotation (Line(points={{-33,-12},{-10,-12}},
                                                      color={0,0,127}));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-39,-46},{-36,
              -46},{-36,-40},{-32.8,-40}},                               color={0,0,
              127}));
      connect(const9.y,PI_TBV. u_s)
        annotation (Line(points={{-57,78},{-40,78}},   color={0,0,127}));
      connect(sensorBus.Steam_Pressure,PI_TBV. u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,60},{-28,60},{-28,66}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.opening_TCV,add1. y) annotation (Line(
          points={{30.1,-99.9},{30.1,-16},{30,-16},{30,-18},{13,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(CondensorBalance.u_m, sensorBus.Condensor_Output_mflow) annotation (
          Line(points={{-76,-92},{-76,-100},{-30,-100}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(CondensorBalance.u_s, sensorBus.Condensor_Input_mflow) annotation (
          Line(points={{-88,-80},{-100,-80},{-100,-100},{-30,-100}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(CondensorBalance.y, add3.u1) annotation (Line(points={{-65,-80},{-54,
              -80},{-54,-66},{-10,-66}}, color={0,0,127}));
      connect(const1.y, add3.u2)
        annotation (Line(points={{-23.6,-78},{-10,-78}}, color={0,0,127}));
      connect(add3.y, actuatorBus.CondensorFlow) annotation (Line(points={{13,-72},
              {30,-72},{30,-100}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,-46},{13,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_BV, PI_TBV.y) annotation (Line(
          points={{30.1,-99.9},{30.1,78},{-17,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end CS_IntermediateControl_PID_3;

    model CS_IntermediateControl_PID_2
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-2,
        Ti=30,
        yMax=750,
        yMin=-1000,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-38,32},{-18,52}})));
      Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
        annotation (Placement(transformation(extent={{-70,32},{-50,52}})));
      Modelica.Blocks.Sources.Constant const4(k=1500)
        annotation (Placement(transformation(extent={{-14,50},{-6,58}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{2,38},{22,58}})));
      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-5,
        Ti=15,
        yMax=1 - 1e-6,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-62,-56},{-42,-36}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
      TRANSFORM.Controls.LimPID TCV_Position(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-9,
        Ti=5,
        yMax=0,
        yMin=-1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-54,-2},{-34,-22}})));
      Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{-84,-22},{-64,-2}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.Constant const8(k=1e-6)
        annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,68},{-18,88}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-78,68},{-58,88}})));
      Fluid.Intermediate_Rankine data
        annotation (Placement(transformation(extent={{-96,12},{-76,32}})));
      Modelica.Blocks.Sources.Constant ExternalDivertValve(k=1)
        annotation (Placement(transformation(extent={{80,-28},{60,-8}})));
      Modelica.Blocks.Sources.Constant Volume_pump(k=200)
        annotation (Placement(transformation(extent={{80,14},{60,34}})));
      Modelica.Blocks.Math.Add         add3
        annotation (Placement(transformation(extent={{-8,-82},{12,-62}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{-32,-82},{-24,-74}})));
      TRANSFORM.Controls.LimPID Turb_Divert_Valve1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-2,
        Ti=15,
        yMax=200,
        yMin=-200,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-86,-90},{-66,-70}})));
    equation
      connect(const3.y,FWCP_Speed. u_s) annotation (Line(points={{-49,42},{-40,42}},
                                  color={0,0,127}));
      connect(sensorBus.Steam_Temperature,FWCP_Speed. u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-28,8},{-28,30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const4.y,add. u1) annotation (Line(points={{-5.6,54},{0,54}},
                                       color={0,0,127}));
      connect(FWCP_Speed.y,add. u2) annotation (Line(points={{-17,42},{0,42}},
                        color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
          points={{30,-100},{30,48},{23,48}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-71,-46},{-64,-46}},   color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-52,-100},{-52,-58}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const6.y,TCV_Position. u_s)
        annotation (Line(points={{-63,-12},{-56,-12}},   color={0,0,127}));
      connect(sensorBus.Power,TCV_Position. u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-44,8},{-44,0}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                          color={0,0,127}));
      connect(TCV_Position.y,add1. u1) annotation (Line(points={{-33,-12},{-10,-12}},
                                                      color={0,0,127}));
      connect(actuatorBus.Divert_Valve_Position,add2. y) annotation (Line(
          points={{30,-100},{30,-46},{13,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-46},{-36,
              -46},{-36,-40},{-32.8,-40}},                               color={0,0,
              127}));
      connect(const9.y,PI_TBV. u_s)
        annotation (Line(points={{-57,78},{-40,78}},   color={0,0,127}));
      connect(sensorBus.Steam_Pressure,PI_TBV. u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,60},{-28,60},{-28,66}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.TBV,PI_TBV. y) annotation (Line(
          points={{30,-100},{30,78},{-17,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.opening_TCV,add1. y) annotation (Line(
          points={{30.1,-99.9},{30.1,-16},{30,-16},{30,-18},{13,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(ExternalDivertValve.y, actuatorBus.opening_BV) annotation (Line(
            points={{59,-18},{30.1,-18},{30.1,-99.9}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(Volume_pump.y, actuatorBus.Volume_Pump) annotation (Line(points={{59,24},
              {30,24},{30,-100}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(Turb_Divert_Valve1.u_m, sensorBus.Condensor_Output_mflow) annotation (
         Line(points={{-76,-92},{-76,-100},{-30,-100}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(Turb_Divert_Valve1.u_s, sensorBus.Condensor_Input_mflow) annotation (
          Line(points={{-88,-80},{-100,-80},{-100,-100},{-30,-100}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(Turb_Divert_Valve1.y, add3.u1) annotation (Line(points={{-65,-80},{
              -54,-80},{-54,-66},{-10,-66}}, color={0,0,127}));
      connect(const1.y, add3.u2)
        annotation (Line(points={{-23.6,-78},{-10,-78}}, color={0,0,127}));
      connect(add3.y, actuatorBus.CondensorFlow) annotation (Line(points={{13,-72},
              {30,-72},{30,-100}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    end CS_IntermediateControl_PID_2;

    model CS_IntermediateControl_PID
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-2,
        Ti=30,
        yMax=750,
        yMin=-1000,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-38,32},{-18,52}})));
      Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
        annotation (Placement(transformation(extent={{-70,32},{-50,52}})));
      Modelica.Blocks.Sources.Constant const4(k=1500)
        annotation (Placement(transformation(extent={{-14,50},{-6,58}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{2,38},{22,58}})));
      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-5,
        Ti=15,
        yMax=1 - 1e-6,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-62,-56},{-42,-36}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
      TRANSFORM.Controls.LimPID TCV_Position(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-9,
        Ti=5,
        yMax=0,
        yMin=-1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-54,-2},{-34,-22}})));
      Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{-84,-22},{-64,-2}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
      Modelica.Blocks.Sources.Constant const8(k=1e-6)
        annotation (Placement(transformation(extent={{-32,-62},{-24,-54}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-62},{12,-42}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-32,-50},{-24,-42}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,68},{-18,88}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-78,68},{-58,88}})));
      Fluid.Intermediate_Rankine data
        annotation (Placement(transformation(extent={{-96,12},{-76,32}})));
      Modelica.Blocks.Sources.Constant ExternalDivertValve(k=1e-6)
        annotation (Placement(transformation(extent={{80,-28},{60,-8}})));
      Modelica.Blocks.Sources.Constant Volume_pump(k=200)
        annotation (Placement(transformation(extent={{80,14},{60,34}})));
    equation
      connect(const3.y,FWCP_Speed. u_s) annotation (Line(points={{-49,42},{-40,42}},
                                  color={0,0,127}));
      connect(sensorBus.Steam_Temperature,FWCP_Speed. u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-28,8},{-28,30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const4.y,add. u1) annotation (Line(points={{-5.6,54},{0,54}},
                                       color={0,0,127}));
      connect(FWCP_Speed.y,add. u2) annotation (Line(points={{-17,42},{0,42}},
                        color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
          points={{30,-100},{30,48},{23,48}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-71,-46},{-64,-46}},   color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-52,-100},{-52,-58}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const6.y,TCV_Position. u_s)
        annotation (Line(points={{-63,-12},{-56,-12}},   color={0,0,127}));
      connect(sensorBus.Power,TCV_Position. u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,8},{-44,8},{-44,0}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                          color={0,0,127}));
      connect(TCV_Position.y,add1. u1) annotation (Line(points={{-33,-12},{-10,-12}},
                                                      color={0,0,127}));
      connect(actuatorBus.Divert_Valve_Position,add2. y) annotation (Line(
          points={{30,-100},{30,-52},{13,-52}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-58},{-23.6,-58}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-46},{-23.44,-46}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-46},{-32.8,
              -46}},                                                     color={0,0,
              127}));
      connect(const9.y,PI_TBV. u_s)
        annotation (Line(points={{-57,78},{-40,78}},   color={0,0,127}));
      connect(sensorBus.Steam_Pressure,PI_TBV. u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,60},{-28,60},{-28,66}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.TBV,PI_TBV. y) annotation (Line(
          points={{30,-100},{30,78},{-17,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.opening_TCV,add1. y) annotation (Line(
          points={{30.1,-99.9},{30.1,-16},{30,-16},{30,-18},{13,-18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(ExternalDivertValve.y, actuatorBus.opening_BV) annotation (Line(
            points={{59,-18},{30.1,-18},{30.1,-99.9}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(Volume_pump.y, actuatorBus.Volume_Pump) annotation (Line(points={{59,24},
              {30,24},{30,-100}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
    end CS_IntermediateControl_PID;

    model CS_IntermediateControl
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      Modelica.Blocks.Sources.Constant TCV_openingNominal(k=0.5)
        annotation (Placement(transformation(extent={{-10,10},{10,30}})));
      Modelica.Blocks.Sources.Constant Feed_Pump_Speed(k=2500)
        annotation (Placement(transformation(extent={{72,42},{52,62}})));
      Modelica.Blocks.Sources.Constant Divert_Valve_Position(k=0.1)
        annotation (Placement(transformation(extent={{-10,42},{10,62}})));
      Modelica.Blocks.Sources.Pulse pulse(
        amplitude=0,
        period=50,
        offset=0.001,
        startTime=20)
        annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));
      Modelica.Blocks.Sources.Constant Feed_Pump_dp(k=18)
        annotation (Placement(transformation(extent={{72,-6},{52,14}})));
      Modelica.Blocks.Sources.Constant TBV(k=0)
        annotation (Placement(transformation(extent={{72,-46},{52,-26}})));
    equation
      connect(actuatorBus.opening_TCV, TCV_openingNominal.y) annotation (
         Line(
          points={{30.1,-99.9},{30.1,20},{11,20}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Divert_Valve_Position, Divert_Valve_Position.y)
        annotation (Line(
          points={{30,-100},{30,52},{11,52}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Feed_Pump_Speed, Feed_Pump_Speed.y)
        annotation (Line(
          points={{30,-100},{30,52},{51,52}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(pulse.y, actuatorBus.opening_BV) annotation (Line(points={{11,-32},{30.1,
              -32},{30.1,-99.9}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(Feed_Pump_dp.y, actuatorBus.condensor_pump) annotation (Line(points={
              {51,4},{30,4},{30,-100}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(TBV.y, actuatorBus.TBV) annotation (Line(points={{51,-36},{30,-36},{
              30,-100}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
    end CS_IntermediateControl;

    model CS_DirectCoupling
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      input Real electric_demand_large
      annotation(Dialog(tab="General"));

      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-4,
        Ti=5,
        Td=0.1,
        yMax=1,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-62,-116},{-42,-136}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-104,-136},{-84,-116}})));
      TRANSFORM.Controls.LimPID TCV_Power(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-8,
        Ti=1,
        k_s=1,
        k_m=1,
        yMax=0,
        yMin=-1 + 0.0001,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-58,-28},{-38,-48}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=electric_demand_large)
        annotation (Placement(transformation(extent={{96,-32},{110,-20}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
      Modelica.Blocks.Sources.Constant const8(k=0.015)
        annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
      Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2) annotation (Placement(transformation(extent={{
                -32,-128},{-24,-120}})));
      replaceable Data.TES_Setpoints data(
        p_steam=3398000,
        p_steam_vent=15000000,
        T_Steam_Ref=579.75,
        Q_Nom=48.57e6,
        T_Feedwater=421.15,
        T_SHS_Return=491.15,
        m_flow_reactor=67.3)
        annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
      Modelica.Blocks.Sources.Constant const3(k=data.m_flow_reactor)
        annotation (Placement(transformation(extent={{-96,62},{-76,82}})));
      TRANSFORM.Controls.LimPID FWCP_mflow(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.1,
        Ti=20,
        Td=0.1,
        yMax=1250,
        yMin=-750,
        wp=0,
        wd=1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-66,62},{-46,82}})));
      Modelica.Blocks.Sources.Constant const4(k=1200)
        annotation (Placement(transformation(extent={{-40,80},{-32,88}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{-24,68},{-4,88}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{10,158},{30,178}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-58,134},{-38,154}})));
      Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
        annotation (Placement(transformation(extent={{-98,134},{-78,154}})));
      Modelica.Blocks.Math.Add         add5
        annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
      TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-4e-7,
        Ti=5,
        k_s=1,
        k_m=1,
        yMax=1 - 0.015,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{152,-78},{132,-98}})));
      Modelica.Blocks.Sources.Constant const10(k=0.015)
        annotation (Placement(transformation(extent={{152,-122},{144,-114}})));
      Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
        annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
      Modelica.Blocks.Math.Min min1
        annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
      Modelica.Blocks.Math.Min min2
        annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
      Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
      Modelica.Blocks.Sources.Constant const12(k=data.Q_Nom + 0.001e6)
        annotation (Placement(transformation(extent={{116,-58},{140,-34}})));
    equation
      connect(const5.y,Turb_Divert_Valve. u_s)
        annotation (Line(points={{-83,-126},{-64,-126}}, color={0,0,127}));
      connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
          points={{-30,-100},{-52,-100},{-52,-114}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y,add1. u2) annotation (Line(points={{-25.6,-50},{-18,-50}},
                                          color={0,0,127}));
      connect(TCV_Power.y, add1.u1)
        annotation (Line(points={{-37,-38},{-18,-38}}, color={0,0,127}));
      connect(add2.u2,const8. y) annotation (Line(points={{-10,-136},{-23.6,-136}},
                                                                             color=
              {0,0,127}));
      connect(add2.u1,timer. y) annotation (Line(points={{-10,-124},{-23.44,-124}},
                                                                    color={0,0,127}));
      connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-126},{
              -36,-126},{-36,-124},{-32.8,-124}},                        color={0,0,
              127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,-130},{13,-130}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-44},{5,-44}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.opening_BV, const2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,118},{31,118},{31,168}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const3.y,FWCP_mflow. u_s)
        annotation (Line(points={{-75,72},{-68,72}}, color={0,0,127}));
      connect(FWCP_mflow.y, add.u2)
        annotation (Line(points={{-45,72},{-26,72}},
                                                   color={0,0,127}));
      connect(const4.y, add.u1)
        annotation (Line(points={{-31.6,84},{-26,84}},
                                                    color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,78},{-3,78}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-77,144},{-60,144}},
                                                     color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-120,-100},{-120,108},{-48,108},{-48,132}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,128},{-30,128},{-30,144},{-37,144}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(add5.u1, Charge_OnOff_Throttle.y)
        annotation (Line(points={{114,-90},{114,-88},{131,-88}},
                                                     color={0,0,127}));
      connect(add5.u2, const10.y) annotation (Line(points={{114,-102},{118,-102},{
              118,-118},{143.6,-118}},
                                color={0,0,127}));
      connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
          points={{30,-100},{30,-96},{91,-96}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, TCV_Power.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{-48,-12},{-48,-26}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(TCV_Power.u_s, const1.y)
        annotation (Line(points={{-60,-38},{-71,-38}}, color={0,0,127}));
      connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
          points={{-30,-100},{-120,-100},{-120,46},{-56,46},{-56,60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(min1.u1, const6.y)
        annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
      connect(Charge_OnOff_Throttle.u_m, min1.y) annotation (Line(points={{142,-76},
              {142,-66},{113,-66},{113,-70}}, color={0,0,127}));
      connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
              -26},{160,-64},{172,-64}}, color={0,0,127}));
      connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
              {238,-70},{238,-88},{154,-88}}, color={0,0,127}));
      connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
              -46},{141.2,-46}}, color={0,0,127}));
      connect(sensorBus.Power, min1.u2) annotation (Line(
          points={{-30,-100},{-30,-84},{84,-84},{84,-76},{90,-76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      annotation (Diagram(graphics={Text(
              extent={{-70,-142},{-20,-160}},
              textColor={28,108,200},
              textString="Feedwater")}));
    end CS_DirectCoupling;
  end ObsoleteCS;

  model CS_DivertPowerControl_Argonne
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand_large
    annotation(Dialog(tab="General"));

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-4,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-62,-116},{-42,-136}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-104,-136},{-84,-116}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-8,
      Ti=1,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,-28},{-38,-48}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand_large)
      annotation (Placement(transformation(extent={{96,-32},{110,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-128},{-24,-120}})));
    replaceable Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=48.57e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15,
      m_flow_reactor=67.3)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const3(k=data.m_flow_reactor)
      annotation (Placement(transformation(extent={{-96,62},{-76,82}})));
    TRANSFORM.Controls.LimPID FWCP_mflow(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=20,
      Td=0.1,
      yMax=1250,
      yMin=-750,
      wp=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-66,62},{-46,82}})));
    Modelica.Blocks.Sources.Constant const4(k=1200)
      annotation (Placement(transformation(extent={{-40,80},{-32,88}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-24,68},{-4,88}})));
    Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{10,158},{30,178}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-58,134},{-38,154}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-98,134},{-78,154}})));
    Modelica.Blocks.Math.Add         add5
      annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
    TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-4e-7,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - 0.015,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{152,-78},{132,-98}})));
    Modelica.Blocks.Sources.Constant const10(k=0.015)
      annotation (Placement(transformation(extent={{152,-122},{144,-114}})));
    Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
      annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
    Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
    Modelica.Blocks.Sources.Constant const12(k=data.Q_Nom + 0.001e6)
      annotation (Placement(transformation(extent={{116,-58},{140,-34}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-83,-126},{-64,-126}}, color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-52,-100},{-52,-114}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,add1. u2) annotation (Line(points={{-25.6,-50},{-18,-50}},
                                        color={0,0,127}));
    connect(TCV_Power.y, add1.u1)
      annotation (Line(points={{-37,-38},{-18,-38}}, color={0,0,127}));
    connect(add2.u2,const8. y) annotation (Line(points={{-10,-136},{-23.6,-136}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1,timer. y) annotation (Line(points={{-10,-124},{-23.44,-124}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-126},{
            -36,-126},{-36,-124},{-32.8,-124}},                        color={0,0,
            127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-130},{13,-130}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-44},{5,-44}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,118},{31,118},{31,168}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y,FWCP_mflow. u_s)
      annotation (Line(points={{-75,72},{-68,72}}, color={0,0,127}));
    connect(FWCP_mflow.y, add.u2)
      annotation (Line(points={{-45,72},{-26,72}},
                                                 color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-31.6,84},{-26,84}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,78},{-3,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-77,144},{-60,144}},
                                                   color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,108},{-48,108},{-48,132}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,128},{-30,128},{-30,144},{-37,144}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(add5.u1, Charge_OnOff_Throttle.y)
      annotation (Line(points={{114,-90},{114,-88},{131,-88}},
                                                   color={0,0,127}));
    connect(add5.u2, const10.y) annotation (Line(points={{114,-102},{118,-102},{
            118,-118},{143.6,-118}},
                              color={0,0,127}));
    connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
        points={{30,-100},{30,-96},{91,-96}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, TCV_Power.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,-12},{-48,-12},{-48,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(TCV_Power.u_s, const1.y)
      annotation (Line(points={{-60,-38},{-71,-38}}, color={0,0,127}));
    connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,46},{-56,46},{-56,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(min1.u1, const6.y)
      annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
    connect(Charge_OnOff_Throttle.u_m, min1.y) annotation (Line(points={{142,-76},
            {142,-66},{113,-66},{113,-70}}, color={0,0,127}));
    connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
            -26},{160,-64},{172,-64}}, color={0,0,127}));
    connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
            {238,-70},{238,-88},{154,-88}}, color={0,0,127}));
    connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
            -46},{141.2,-46}}, color={0,0,127}));
    connect(sensorBus.Power, min1.u2) annotation (Line(
        points={{-30,-100},{-30,-84},{84,-84},{84,-76},{90,-76}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Diagram(graphics={Text(
            extent={{-70,-142},{-20,-160}},
            textColor={28,108,200},
            textString="Feedwater")}));
  end CS_DivertPowerControl_Argonne;

  model CS_SmallCycle_NoFeedHeat_Argonne
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand_TES
    annotation(Dialog(tab="General"));

    replaceable Data.TES_Setpoints data(
      p_steam=1200000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=48.57e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-4,
      Ti=5,
      Td=0.1,
      yMax=2500,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,62},{-38,82}})));
    Modelica.Blocks.Sources.Constant const4(k=100)
      annotation (Placement(transformation(extent={{-32,80},{-24,88}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-16,68},{4,88}})));
    Modelica.Blocks.Sources.Constant const11(k=0.001)
      annotation (Placement(transformation(extent={{134,-10},{126,-2}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{106,0},{86,20}})));
    Modelica.Blocks.Math.Add         add7
      annotation (Placement(transformation(extent={{94,48},{74,68}})));
    Modelica.Blocks.Sources.Constant const15(k=0.01)
      annotation (Placement(transformation(extent={{118,38},{110,46}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter(max=1 - 0.001)
      annotation (Placement(transformation(extent={{134,6},{114,26}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter1(max=1 - 0.01)
      annotation (Placement(transformation(extent={{138,54},{118,74}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand_TES)
      annotation (Placement(transformation(extent={{66,-26},{80,-14}})));
    TRANSFORM.Controls.LimPID TCV_SHS(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-9,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{164,6},{144,26}})));
    TRANSFORM.Controls.LimPID Discharge_OnOFF(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-9,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{184,54},{164,74}})));
  equation
    connect(sensorBus.Steam_Pressure,FWCP_Speed. u_m) annotation (Line(
        points={{-30,-100},{-118,-100},{-118,40},{-48,40},{-48,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(const3.y,FWCP_Speed. u_s)
      annotation (Line(points={{-69,72},{-60,72}}, color={0,0,127}));
    connect(FWCP_Speed.y,add. u2)
      annotation (Line(points={{-37,72},{-18,72}},
                                                 color={0,0,127}));
    connect(const4.y,add. u1)
      annotation (Line(points={{-23.6,84},{-18,84}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
        points={{30,-100},{30,78},{5,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const11.y,add4. u2) annotation (Line(points={{125.6,-6},{118,-6},{118,
            4},{108,4}},
                     color={0,0,127}));
    connect(actuatorBus.TCV_SHS,add4. y) annotation (Line(
        points={{30,-100},{30,10},{85,10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add7.u2,const15. y) annotation (Line(points={{96,52},{100,52},{100,46},
            {109.6,46},{109.6,42}},     color={0,0,127}));
    connect(actuatorBus.Discharge_OnOff_Throttle,add7. y) annotation (Line(
        points={{30,-100},{30,58},{73,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(minMaxFilter1.y,add7. u1)
      annotation (Line(points={{116.6,64},{96,64}},  color={0,0,127}));
    connect(add4.u1,minMaxFilter. y)
      annotation (Line(points={{108,16},{112.6,16}}, color={0,0,127}));
    connect(minMaxFilter.u, TCV_SHS.y)
      annotation (Line(points={{136,16},{143,16}}, color={0,0,127}));
    connect(sensorBus.Power, TCV_SHS.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{154,-52},{154,4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, TCV_SHS.u_s) annotation (Line(points={{80.7,-20},{
            170,-20},{170,16},{166,16}}, color={0,0,127}));
    connect(minMaxFilter1.u, Discharge_OnOFF.y)
      annotation (Line(points={{140,64},{163,64}}, color={0,0,127}));
    connect(sensorBus.Power, Discharge_OnOFF.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{184,-52},{184,38},{174,38},{174,52}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, Discharge_OnOFF.u_s) annotation (Line(points={{80.7,
            -20},{204,-20},{204,64},{186,64}}, color={0,0,127}));
  end CS_SmallCycle_NoFeedHeat_Argonne;

  model CS_DivertPowerControl_HTGR
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand
    annotation(Dialog(tab="General"));
    input Real Overall_Power
    annotation(Dialog(tab="General"));

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-5,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-62,-116},{-42,-136}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-104,-136},{-84,-116}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-6,
      Ti=10,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,-28},{-38,-48}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand)
      annotation (Placement(transformation(extent={{96,-32},{110,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-128},{-24,-120}})));
    replaceable Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=48.57e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15,
      m_flow_reactor=67.3)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const3(k=data.m_flow_reactor)
      annotation (Placement(transformation(extent={{-96,62},{-76,82}})));
    TRANSFORM.Controls.LimPID FWCP_mflow(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=20,
      Td=0.1,
      yMax=3000,
      yMin=-750,
      wd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-66,62},{-46,82}})));
    Modelica.Blocks.Sources.Constant const4(k=1200)
      annotation (Placement(transformation(extent={{-40,80},{-32,88}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-24,68},{-4,88}})));
    Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{10,158},{30,178}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-58,134},{-38,154}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-98,134},{-78,154}})));
    Modelica.Blocks.Math.Add         add5
      annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
    TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=20,
      Td=0.01,
      k_s=1,
      k_m=1,
      yMax=1 - 0.015,
      yMin=0,
      wp=1,
      wd=0.1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{152,-78},{132,-98}})));
    Modelica.Blocks.Sources.Constant const10(k=0.015)
      annotation (Placement(transformation(extent={{152,-122},{144,-114}})));
    Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
      annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
    Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
    Modelica.Blocks.Sources.Constant const12(k=data.Q_Nom + 0.001e6)
      annotation (Placement(transformation(extent={{116,-58},{140,-34}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression1(y=Overall_Power)
      annotation (Placement(transformation(extent={{80,24},{94,36}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-83,-126},{-64,-126}}, color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-52,-100},{-52,-114}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,add1. u2) annotation (Line(points={{-25.6,-50},{-18,-50}},
                                        color={0,0,127}));
    connect(TCV_Power.y, add1.u1)
      annotation (Line(points={{-37,-38},{-18,-38}}, color={0,0,127}));
    connect(add2.u2,const8. y) annotation (Line(points={{-10,-136},{-23.6,-136}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1,timer. y) annotation (Line(points={{-10,-124},{-23.44,-124}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-126},{
            -36,-126},{-36,-124},{-32.8,-124}},                        color={0,0,
            127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-130},{13,-130}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-44},{5,-44}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,118},{31,118},{31,168}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y,FWCP_mflow. u_s)
      annotation (Line(points={{-75,72},{-68,72}}, color={0,0,127}));
    connect(FWCP_mflow.y, add.u2)
      annotation (Line(points={{-45,72},{-26,72}},
                                                 color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-31.6,84},{-26,84}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,78},{-3,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-77,144},{-60,144}},
                                                   color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,108},{-48,108},{-48,132}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,128},{-30,128},{-30,144},{-37,144}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(add5.u1, Charge_OnOff_Throttle.y)
      annotation (Line(points={{114,-90},{114,-88},{131,-88}},
                                                   color={0,0,127}));
    connect(add5.u2, const10.y) annotation (Line(points={{114,-102},{118,-102},{
            118,-118},{143.6,-118}},
                              color={0,0,127}));
    connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
        points={{30,-100},{30,-96},{91,-96}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, TCV_Power.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,-12},{-48,-12},{-48,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(TCV_Power.u_s, const1.y)
      annotation (Line(points={{-60,-38},{-71,-38}}, color={0,0,127}));
    connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,46},{-56,46},{-56,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(min1.u1, const6.y)
      annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
    connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
            -26},{160,-64},{172,-64}}, color={0,0,127}));
    connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
            {238,-70},{238,-88},{154,-88}}, color={0,0,127}));
    connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
            -46},{141.2,-46}}, color={0,0,127}));
    connect(min1.u2, const6.y) annotation (Line(points={{90,-76},{80,-76},{80,-64},
            {75.2,-64}}, color={0,0,127}));
    connect(sensorBus.Power, Charge_OnOff_Throttle.u_m) annotation (Line(
        points={{-30,-100},{-28,-100},{-28,-70},{142,-70},{142,-76}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Diagram(graphics={Text(
            extent={{-70,-142},{-20,-160}},
            textColor={28,108,200},
            textString="Feedwater")}));
  end CS_DivertPowerControl_HTGR;

  model CS_DivertPowerControl_HTGR_3
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand
    annotation(Dialog(tab="General"));
    input Real Overall_Power
    annotation(Dialog(tab="General"));

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-5,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-62,-116},{-42,-136}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-104,-136},{-84,-116}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-6,
      Ti=10,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.01,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,-28},{-38,-48}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand)
      annotation (Placement(transformation(extent={{96,-32},{110,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-128},{-24,-120}})));
    replaceable Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=48.57e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15,
      m_flow_reactor=67.3)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const3(k=data.m_flow_reactor)
      annotation (Placement(transformation(extent={{-96,62},{-76,82}})));
    TRANSFORM.Controls.LimPID FWCP_mflow(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=20,
      Td=0.1,
      yMax=3000,
      yMin=-750,
      wd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-66,62},{-46,82}})));
    Modelica.Blocks.Sources.Constant const4(k=1200)
      annotation (Placement(transformation(extent={{-40,80},{-32,88}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-24,68},{-4,88}})));
    Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{10,158},{30,178}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-58,134},{-38,154}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-98,134},{-78,154}})));
    Modelica.Blocks.Math.Add         add5
      annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
    TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=20,
      Td=0.01,
      k_s=1,
      k_m=1,
      yMax=1 - 0.015,
      yMin=0,
      wp=1,
      wd=0.1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{152,-78},{132,-98}})));
    Modelica.Blocks.Sources.Constant const10(k=0.015)
      annotation (Placement(transformation(extent={{152,-122},{144,-114}})));
    Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
      annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
    Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
    Modelica.Blocks.Sources.Constant const12(k=data.Q_Nom + 0.001e6)
      annotation (Placement(transformation(extent={{116,-58},{140,-34}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression1(y=Overall_Power)
      annotation (Placement(transformation(extent={{80,24},{94,36}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-83,-126},{-64,-126}}, color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-52,-100},{-52,-114}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,add1. u2) annotation (Line(points={{-25.6,-50},{-18,-50}},
                                        color={0,0,127}));
    connect(TCV_Power.y, add1.u1)
      annotation (Line(points={{-37,-38},{-18,-38}}, color={0,0,127}));
    connect(add2.u2,const8. y) annotation (Line(points={{-10,-136},{-23.6,-136}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1,timer. y) annotation (Line(points={{-10,-124},{-23.44,-124}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-126},{
            -36,-126},{-36,-124},{-32.8,-124}},                        color={0,0,
            127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-130},{13,-130}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-44},{5,-44}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,118},{31,118},{31,168}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y,FWCP_mflow. u_s)
      annotation (Line(points={{-75,72},{-68,72}}, color={0,0,127}));
    connect(FWCP_mflow.y, add.u2)
      annotation (Line(points={{-45,72},{-26,72}},
                                                 color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-31.6,84},{-26,84}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,78},{-3,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-77,144},{-60,144}},
                                                   color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,108},{-48,108},{-48,132}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,128},{-30,128},{-30,144},{-37,144}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(add5.u1, Charge_OnOff_Throttle.y)
      annotation (Line(points={{114,-90},{114,-88},{131,-88}},
                                                   color={0,0,127}));
    connect(add5.u2, const10.y) annotation (Line(points={{114,-102},{118,-102},{
            118,-118},{143.6,-118}},
                              color={0,0,127}));
    connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
        points={{30,-100},{30,-96},{91,-96}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, TCV_Power.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,-12},{-48,-12},{-48,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(TCV_Power.u_s, const1.y)
      annotation (Line(points={{-60,-38},{-71,-38}}, color={0,0,127}));
    connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,46},{-56,46},{-56,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(min1.u1, const6.y)
      annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
    connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
            -26},{160,-64},{172,-64}}, color={0,0,127}));
    connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
            {238,-70},{238,-88},{154,-88}}, color={0,0,127}));
    connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
            -46},{141.2,-46}}, color={0,0,127}));
    connect(min1.u2, const6.y) annotation (Line(points={{90,-76},{80,-76},{80,-64},
            {75.2,-64}}, color={0,0,127}));
    connect(sensorBus.Power, Charge_OnOff_Throttle.u_m) annotation (Line(
        points={{-30,-100},{-28,-100},{-28,-70},{142,-70},{142,-76}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Diagram(graphics={Text(
            extent={{-70,-142},{-20,-160}},
            textColor={28,108,200},
            textString="Feedwater")}));
  end CS_DivertPowerControl_HTGR_3;

  model CS_PowerBoostLoop_DivertPowerControl_HTGR
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand
    annotation(Dialog(tab="General"));

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-4,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-62,-116},{-42,-136}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-104,-136},{-84,-116}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-6,
      Ti=10,
      k_s=1,
      k_m=1,
      yMax=0,
      yMin=-1 + 0.0001,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,-28},{-38,-48}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand)
      annotation (Placement(transformation(extent={{96,-32},{110,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-128},{-24,-120}})));
    replaceable Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=52e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15,
      m_flow_reactor=67.3)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const3(k=data.m_flow_reactor)
      annotation (Placement(transformation(extent={{-96,62},{-76,82}})));
    TRANSFORM.Controls.LimPID FWCP_mflow(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=20,
      Td=0.1,
      yMax=1250,
      yMin=-750,
      wp=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-66,62},{-46,82}})));
    Modelica.Blocks.Sources.Constant const4(k=1200)
      annotation (Placement(transformation(extent={{-40,80},{-32,88}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-24,68},{-4,88}})));
    Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{10,158},{30,178}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-58,134},{-38,154}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-98,134},{-78,154}})));
    Modelica.Blocks.Math.Add         add5
      annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
    TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-4e-9,
      Ti=1,
      k_s=1,
      k_m=1,
      yMax=1 - 0.015,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{152,-78},{132,-98}})));
    Modelica.Blocks.Sources.Constant const10(k=0.015)
      annotation (Placement(transformation(extent={{152,-122},{144,-114}})));
    Modelica.Blocks.Sources.Constant const1(k=data.p_steam)
      annotation (Placement(transformation(extent={{-92,-48},{-72,-28}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{174,-80},{194,-60}})));
    Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
    Modelica.Blocks.Sources.Constant const12(k=data.Q_Nom + 0.001e6)
      annotation (Placement(transformation(extent={{140,-84},{164,-60}})));
    Modelica.Blocks.Sources.Constant const11(k=0.01)
      annotation (Placement(transformation(extent={{156,32},{148,40}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{128,42},{108,62}})));
    Modelica.Blocks.Math.Add         add7
      annotation (Placement(transformation(extent={{116,90},{96,110}})));
    Modelica.Blocks.Sources.Constant const15(k=0.01)
      annotation (Placement(transformation(extent={{140,80},{132,88}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter(max=1 - 0.001)
      annotation (Placement(transformation(extent={{156,48},{136,68}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter1(max=1 - 0.01)
      annotation (Placement(transformation(extent={{160,96},{140,116}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression1(y=electric_demand)
      annotation (Placement(transformation(extent={{88,16},{102,28}})));
    TRANSFORM.Controls.LimPID TCV_SHS(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-9,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{186,48},{166,68}})));
    TRANSFORM.Controls.LimPID Discharge_OnOFF(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-9,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{206,96},{186,116}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-83,-126},{-64,-126}}, color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-52,-100},{-52,-114}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,add1. u2) annotation (Line(points={{-25.6,-50},{-18,-50}},
                                        color={0,0,127}));
    connect(TCV_Power.y, add1.u1)
      annotation (Line(points={{-37,-38},{-18,-38}}, color={0,0,127}));
    connect(add2.u2,const8. y) annotation (Line(points={{-10,-136},{-23.6,-136}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1,timer. y) annotation (Line(points={{-10,-124},{-23.44,-124}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-126},{
            -36,-126},{-36,-124},{-32.8,-124}},                        color={0,0,
            127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-130},{13,-130}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-44},{5,-44}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,118},{31,118},{31,168}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y,FWCP_mflow. u_s)
      annotation (Line(points={{-75,72},{-68,72}}, color={0,0,127}));
    connect(FWCP_mflow.y, add.u2)
      annotation (Line(points={{-45,72},{-26,72}},
                                                 color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-31.6,84},{-26,84}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,78},{-3,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-77,144},{-60,144}},
                                                   color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,108},{-48,108},{-48,132}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,128},{-30,128},{-30,144},{-37,144}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(add5.u1, Charge_OnOff_Throttle.y)
      annotation (Line(points={{114,-90},{114,-88},{131,-88}},
                                                   color={0,0,127}));
    connect(add5.u2, const10.y) annotation (Line(points={{114,-102},{118,-102},{
            118,-118},{143.6,-118}},
                              color={0,0,127}));
    connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
        points={{30,-100},{30,-96},{91,-96}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, TCV_Power.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,-12},{-48,-12},{-48,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(TCV_Power.u_s, const1.y)
      annotation (Line(points={{-60,-38},{-71,-38}}, color={0,0,127}));
    connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,46},{-56,46},{-56,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Power, min1.u2) annotation (Line(
        points={{-30,-100},{-30,-74},{90,-74},{90,-76}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(min1.u1, const6.y)
      annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
    connect(Charge_OnOff_Throttle.u_m, min1.y) annotation (Line(points={{142,-76},
            {142,-66},{113,-66},{113,-70}}, color={0,0,127}));
    connect(realExpression.y, min2.u1) annotation (Line(points={{110.7,-26},{160,
            -26},{160,-64},{172,-64}}, color={0,0,127}));
    connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{195,-70},
            {238,-70},{238,-88},{154,-88}}, color={0,0,127}));
    connect(min2.u2, const12.y) annotation (Line(points={{172,-76},{168,-76},{168,
            -72},{165.2,-72}}, color={0,0,127}));
    connect(const11.y,add4. u2) annotation (Line(points={{147.6,36},{140,36},{140,
            46},{130,46}},
                     color={0,0,127}));
    connect(actuatorBus.TCV_SHS,add4. y) annotation (Line(
        points={{30,-100},{30,52},{107,52}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add7.u2,const15. y) annotation (Line(points={{118,94},{122,94},{122,
            88},{131.6,88},{131.6,84}}, color={0,0,127}));
    connect(actuatorBus.Discharge_OnOff_Throttle,add7. y) annotation (Line(
        points={{30,-100},{30,100},{95,100}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(minMaxFilter1.y,add7. u1)
      annotation (Line(points={{138.6,106},{118,106}},
                                                     color={0,0,127}));
    connect(add4.u1,minMaxFilter. y)
      annotation (Line(points={{130,58},{134.6,58}}, color={0,0,127}));
    connect(minMaxFilter.u,TCV_SHS. y)
      annotation (Line(points={{158,58},{165,58}}, color={0,0,127}));
    connect(sensorBus.Power,TCV_SHS. u_m) annotation (Line(
        points={{-30,-100},{-30,-10},{176,-10},{176,46}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression1.y, TCV_SHS.u_s) annotation (Line(points={{102.7,22},{
            192,22},{192,58},{188,58}}, color={0,0,127}));
    connect(minMaxFilter1.u,Discharge_OnOFF. y)
      annotation (Line(points={{162,106},{185,106}},
                                                   color={0,0,127}));
    connect(sensorBus.Power,Discharge_OnOFF. u_m) annotation (Line(
        points={{-30,-100},{-30,-10},{206,-10},{206,80},{196,80},{196,94}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression1.y, Discharge_OnOFF.u_s) annotation (Line(points={{
            102.7,22},{226,22},{226,106},{208,106}}, color={0,0,127}));
    annotation (Diagram(graphics={Text(
            extent={{-70,-142},{-20,-160}},
            textColor={28,108,200},
            textString="Feedwater")}));
  end CS_PowerBoostLoop_DivertPowerControl_HTGR;

  model CS_SmallCycle_NoFeedHeat_HTGR
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand_TES
    annotation(Dialog(tab="General"));

    replaceable Data.TES_Setpoints data(
      p_steam=1200000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=48.57e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-4,
      Ti=5,
      Td=0.1,
      yMax=2500,
      yMin=-1000,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,62},{-38,82}})));
    Modelica.Blocks.Sources.Constant const4(k=100)
      annotation (Placement(transformation(extent={{-32,80},{-24,88}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-16,68},{4,88}})));
    Modelica.Blocks.Sources.Constant const11(k=0.001)
      annotation (Placement(transformation(extent={{134,-10},{126,-2}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{106,0},{86,20}})));
    Modelica.Blocks.Math.Add         add7
      annotation (Placement(transformation(extent={{94,48},{74,68}})));
    Modelica.Blocks.Sources.Constant const15(k=0.01)
      annotation (Placement(transformation(extent={{118,38},{110,46}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter(max=1 - 0.001)
      annotation (Placement(transformation(extent={{134,6},{114,26}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter1(max=1 - 0.01)
      annotation (Placement(transformation(extent={{138,54},{118,74}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand_TES)
      annotation (Placement(transformation(extent={{66,-26},{80,-14}})));
    TRANSFORM.Controls.LimPID TCV_SHS(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-9,
      Ti=15,
      Td=0.1,
      yMax=1,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{164,6},{144,26}})));
    TRANSFORM.Controls.LimPID Discharge_OnOFF(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2.5e-9,
      Ti=15,
      Td=0.1,
      yMax=1,
      yMin=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{184,54},{164,74}})));
  equation
    connect(sensorBus.Steam_Pressure,FWCP_Speed. u_m) annotation (Line(
        points={{-30,-100},{-118,-100},{-118,40},{-48,40},{-48,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(const3.y,FWCP_Speed. u_s)
      annotation (Line(points={{-69,72},{-60,72}}, color={0,0,127}));
    connect(FWCP_Speed.y,add. u2)
      annotation (Line(points={{-37,72},{-18,72}},
                                                 color={0,0,127}));
    connect(const4.y,add. u1)
      annotation (Line(points={{-23.6,84},{-18,84}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed,add. y) annotation (Line(
        points={{30,-100},{30,78},{5,78}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const11.y,add4. u2) annotation (Line(points={{125.6,-6},{118,-6},{118,
            4},{108,4}},
                     color={0,0,127}));
    connect(actuatorBus.TCV_SHS,add4. y) annotation (Line(
        points={{30,-100},{30,10},{85,10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add7.u2,const15. y) annotation (Line(points={{96,52},{100,52},{100,46},
            {109.6,46},{109.6,42}},     color={0,0,127}));
    connect(actuatorBus.Discharge_OnOff_Throttle,add7. y) annotation (Line(
        points={{30,-100},{30,58},{73,58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(minMaxFilter1.y,add7. u1)
      annotation (Line(points={{116.6,64},{96,64}},  color={0,0,127}));
    connect(add4.u1,minMaxFilter. y)
      annotation (Line(points={{108,16},{112.6,16}}, color={0,0,127}));
    connect(minMaxFilter.u, TCV_SHS.y)
      annotation (Line(points={{136,16},{143,16}}, color={0,0,127}));
    connect(sensorBus.Power, TCV_SHS.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{154,-52},{154,4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, TCV_SHS.u_s) annotation (Line(points={{80.7,-20},{
            170,-20},{170,16},{166,16}}, color={0,0,127}));
    connect(minMaxFilter1.u, Discharge_OnOFF.y)
      annotation (Line(points={{140,64},{163,64}}, color={0,0,127}));
    connect(sensorBus.Power, Discharge_OnOFF.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{184,-52},{184,38},{174,38},{174,52}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, Discharge_OnOFF.u_s) annotation (Line(points={{80.7,
            -20},{204,-20},{204,64},{186,64}}, color={0,0,127}));
  end CS_SmallCycle_NoFeedHeat_HTGR;

  model CS_SteamTurbine_L2_PressurePowerFeedtemp_HTGR
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand_int = data.Q_Nom;

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-7,
      Ti=15,
      Td=0.1,
      yMax=0.9,
      yMin=-0.0935,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-54,-60},{-34,-40}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-92,-56},{-72,-36}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-11,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=0.95,
      yMin=-0.04,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-50,-2},{-30,-22}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand_int)
      annotation (Placement(transformation(extent={{-94,-6},{-80,6}})));
    Modelica.Blocks.Sources.Constant const7(k=0.01)
      annotation (Placement(transformation(extent={{-26,-28},{-18,-20}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-8,-28},{12,-8}})));
    Modelica.Blocks.Sources.Constant const8(k=0.1)
      annotation (Placement(transformation(extent={{-32,-56},{-24,-48}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-56},{12,-36}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-44},{-24,-36}})));
    replaceable Data.Turbine_2_Setpoints data(
      p_steam=3500000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=40e6,
      T_Feedwater=421.15)
      annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
    Modelica.Blocks.Sources.Constant const(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{-78,-22},{-64,-8}})));
    Modelica.Blocks.Sources.Constant const3(k=540 + 273.15)
      annotation (Placement(transformation(extent={{-180,44},{-160,64}})));
    TRANSFORM.Controls.LimPID FWCP_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-2,
      Ti=120,
      Td=1,
      yMax=3000,
      yMin=-1500,
      wp=1,
      wd=0.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    Modelica.Blocks.Sources.Constant const4(k=2800)
      annotation (Placement(transformation(extent={{-14,48},{-6,56}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{2,36},{22,56}})));
    Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{2,74},{22,94}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-38,72},{-18,92}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-78,72},{-58,92}})));
    Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-222,-2},{-202,18}})));
    Modelica.Blocks.Sources.Constant valvedelay(k=0)
      annotation (Placement(transformation(extent={{-218,34},{-198,54}})));
    Modelica.Blocks.Logical.Greater greater5
      annotation (Placement(transformation(extent={{-178,34},{-158,14}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV
      annotation (Placement(transformation(extent={{-138,14},{-118,34}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-71,-46},{-66,-46},{-66,-50},{-56,-50}},
                                                       color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-44,-100},{-44,-62}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,8},{-40,8},{-40,0}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,add1. u2) annotation (Line(points={{-17.6,-24},{-10,-24}},
                                        color={0,0,127}));
    connect(TCV_Power.y, add1.u1)
      annotation (Line(points={{-29,-12},{-10,-12}}, color={0,0,127}));
    connect(add2.u2,const8. y) annotation (Line(points={{-10,-52},{-23.6,-52}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1,timer. y) annotation (Line(points={{-10,-40},{-23.44,-40}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-33,-50},{-36,
            -50},{-36,-40},{-32.8,-40}},                               color={0,0,
            127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-46},{13,-46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-18},{13,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,84},{23,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y, FWCP_Speed.u_s)
      annotation (Line(points={{-159,54},{-50,54},{-50,40},{-42,40}},
                                                   color={0,0,127}));
    connect(FWCP_Speed.y, add.u2)
      annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-5.6,52},{0,52}}, color={0,0,127}));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-57,82},{-40,82}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-100,-100},{-100,62},{-28,62},{-28,70}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,66},{-10,66},{-10,82},{-17,82}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const.y, TCV_Power.u_s) annotation (Line(points={{-63.3,-15},{-56,-15},
            {-56,-12},{-52,-12}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,46},{23,46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(valvedelay.y,greater5. u2) annotation (Line(points={{-197,44},{-188,
            44},{-188,32},{-180,32}},
                                  color={0,0,127}));
    connect(clock.y,greater5. u1) annotation (Line(points={{-201,8},{-188,8},{
            -188,24},{-180,24}},
                            color={0,0,127}));
    connect(greater5.y,switch_P_setpoint_TCV. u2)
      annotation (Line(points={{-157,24},{-140,24}},   color={255,0,255}));
    connect(const3.y, switch_P_setpoint_TCV.u3) annotation (Line(points={{-159,54},
            {-154,54},{-154,16},{-140,16}}, color={0,0,127}));
    connect(switch_P_setpoint_TCV.y, FWCP_Speed.u_m) annotation (Line(points={{
            -117,24},{-110,24},{-110,42},{-62,42},{-62,20},{-30,20},{-30,28}},
          color={0,0,127}));
    connect(sensorBus.Steam_Temperature, switch_P_setpoint_TCV.u1) annotation (
        Line(
        points={{-30,-100},{-150,-100},{-150,32},{-140,32}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
  end CS_SteamTurbine_L2_PressurePowerFeedtemp_HTGR;

  model CS_Rankine_Xe100_Based_Secondary_TransientControl

    extends BaseClasses.Partial_ControlSystem;

    Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
      annotation (Placement(transformation(extent={{-72,16},{-52,36}})));
    Modelica.Blocks.Sources.Constant const4(k=1200)
      annotation (Placement(transformation(extent={{42,72},{50,80}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{64,60},{84,80}})));
    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-5,
      Ti=15,
      yMax=1 - 1e-6,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-64,-72},{-44,-52}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-94,-72},{-74,-52}})));
    TRANSFORM.Controls.LimPID TCV_Position(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-9,
      Ti=5,
      yMax=0,
      yMin=-1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-56,-18},{-36,-38}})));
    Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{-86,-38},{-66,-18}})));
    Modelica.Blocks.Sources.Constant const7(k=1)
      annotation (Placement(transformation(extent={{-28,-44},{-20,-36}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-10,-44},{10,-24}})));
    Modelica.Blocks.Sources.Constant const8(k=1e-6)
      annotation (Placement(transformation(extent={{-34,-78},{-26,-70}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-10,-78},{10,-58}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-34,-66},{-26,-58}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-80,52},{-60,72}})));
    Data.HTGR_Rankine
                    data(p_steam_vent=15000000, Q_Nom=44e6)
      annotation (Placement(transformation(extent={{-98,-4},{-78,16}})));
    Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{44,-44},{64,-24}})));
    Modelica.Blocks.Sources.Constant valvedelay(k=1e6)
      annotation (Placement(transformation(extent={{48,-8},{68,12}})));
    Modelica.Blocks.Logical.Greater greater5
      annotation (Placement(transformation(extent={{88,-8},{108,-28}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV
      annotation (Placement(transformation(extent={{128,-28},{148,-8}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      amplitude=-0.00740122,
      rising=780,
      width=1020,
      falling=780,
      period=3600,
      nperiod=1,
      offset=0.0098683,
      startTime=1e6 + 900)
      annotation (Placement(transformation(extent={{88,16},{108,36}})));
    Modelica.Blocks.Sources.ContinuousClock clock2(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-174,104},{-154,124}})));
    SupportComponents.VarLimVarK_PID PID(
      use_k_in=true,
      use_lowlim_in=true,
      use_uplim_in=true,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      with_FF=true,
      k=-5e-1,
      Ti=30) annotation (Placement(transformation(extent={{-4,16},{16,36}})));
    Modelica.Blocks.Sources.Constant valvedelay2(k=6e5)
      annotation (Placement(transformation(extent={{-170,140},{-150,160}})));
    Modelica.Blocks.Logical.Greater greater2
      annotation (Placement(transformation(extent={{-130,140},{-110,120}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV1
      annotation (Placement(transformation(extent={{-90,120},{-70,140}})));
    Modelica.Blocks.Sources.Constant const1(k=-280)
      annotation (Placement(transformation(extent={{-122,150},{-114,158}})));
    Modelica.Blocks.Sources.Constant const2(k=-150)
      annotation (Placement(transformation(extent={{-124,96},{-116,104}})));
    Modelica.Blocks.Sources.Constant const10(k=5000)
      annotation (Placement(transformation(extent={{-64,154},{-56,162}})));
    Modelica.Blocks.Sources.Constant const11(k=-1e-1)
      annotation (Placement(transformation(extent={{-120,182},{-112,190}})));
    Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-170,188},{-150,208}})));
    Modelica.Blocks.Sources.Constant valvedelay1(k=8.5e5)
      annotation (Placement(transformation(extent={{-166,224},{-146,244}})));
    Modelica.Blocks.Logical.Greater greater1
      annotation (Placement(transformation(extent={{-126,224},{-106,204}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV2
      annotation (Placement(transformation(extent={{-86,204},{-66,224}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=-0.5e-1,
      duration=1e5,
      offset=-1e-1,
      startTime=8.7e5)
      annotation (Placement(transformation(extent={{-124,244},{-104,264}})));
    Modelica.Blocks.Sources.Trapezoid trapezoid1(
      amplitude=-280,
      rising=780,
      width=1020,
      falling=780,
      period=3600,
      nperiod=1,
      offset=0,
      startTime=1e6 + 900)
      annotation (Placement(transformation(extent={{-150,20},{-130,40}})));
  equation

    connect(const4.y, add.u1) annotation (Line(points={{50.4,76},{62,76}},
                                     color={0,0,127}));
    connect(const5.y, Turb_Divert_Valve.u_s)
      annotation (Line(points={{-73,-62},{-66,-62}},   color={0,0,127}));
    connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
        points={{-30,-100},{-54,-100},{-54,-74}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const6.y, TCV_Position.u_s)
      annotation (Line(points={{-65,-28},{-58,-28}},   color={0,0,127}));
    connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
        points={{-30,-100},{-104,-100},{-104,-8},{-46,-8},{-46,-16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y, add1.u2) annotation (Line(points={{-19.6,-40},{-12,-40}},
                                        color={0,0,127}));
    connect(TCV_Position.y, add1.u1) annotation (Line(points={{-35,-28},{-12,-28}},
                                                    color={0,0,127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-68},{11,-68}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add2.u2, const8.y) annotation (Line(points={{-12,-74},{-25.6,-74}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1, timer.y) annotation (Line(points={{-12,-62},{-25.44,-62}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-43,-62},{-34.8,
            -62}},                                                     color={0,0,
            127}));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-59,62},{-42,62}},   color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-104,-100},{-104,44},{-30,44},{-30,50}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,62},{-19,62}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(clock.y, greater5.u1) annotation (Line(points={{65,-34},{80,-34},{80,
            -18},{86,-18}}, color={0,0,127}));
    connect(valvedelay.y, greater5.u2) annotation (Line(points={{69,2},{80,2},{80,
            -10},{86,-10}}, color={0,0,127}));
    connect(greater5.y, switch_P_setpoint_TCV.u2)
      annotation (Line(points={{109,-18},{126,-18}}, color={255,0,255}));
    connect(add1.y, switch_P_setpoint_TCV.u3) annotation (Line(points={{11,-34},{
            18,-34},{18,-56},{122,-56},{122,-26},{126,-26}}, color={0,0,127}));
    connect(actuatorBus.opening_TCV, switch_P_setpoint_TCV.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-62},{158,-62},{158,-18},{149,-18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(trapezoid.y, switch_P_setpoint_TCV.u1) annotation (Line(points={{109,
            26},{118,26},{118,-10},{126,-10}}, color={0,0,127}));
    connect(clock2.y, greater2.u1) annotation (Line(points={{-153,114},{-138,114},
            {-138,130},{-132,130}}, color={0,0,127}));
    connect(valvedelay2.y, greater2.u2) annotation (Line(points={{-149,150},{-138,
            150},{-138,138},{-132,138}}, color={0,0,127}));
    connect(greater2.y, switch_P_setpoint_TCV1.u2)
      annotation (Line(points={{-109,130},{-92,130}}, color={255,0,255}));
    connect(const2.y, switch_P_setpoint_TCV1.u3) annotation (Line(points={{-115.6,
            100},{-110,100},{-110,118},{-92,118},{-92,122}}, color={0,0,127}));
    connect(const1.y, switch_P_setpoint_TCV1.u1) annotation (Line(points={{-113.6,
            154},{-98,154},{-98,138},{-92,138}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,50},{92,50},{92,70},{85,70}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const10.y, PID.upperlim) annotation (Line(points={{-55.6,158},{-24,
            158},{-24,140},{-12,140},{-12,37},{0,37}},      color={0,0,127}));
    connect(switch_P_setpoint_TCV1.y, PID.lowerlim) annotation (Line(points={{-69,130},
            {-36,130},{-36,124},{-6,124},{-6,50},{-14,50},{-14,37},{6,37}},
          color={0,0,127}));
    connect(sensorBus.Steam_Temperature, PID.u_m) annotation (Line(
        points={{-30,-100},{-104,-100},{-104,-8},{6,-8},{6,14}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(const3.y, PID.u_s)
      annotation (Line(points={{-51,26},{-6,26}}, color={0,0,127}));
    connect(PID.y, add.u2) annotation (Line(points={{17,26},{34,26},{34,34},{48,
            34},{48,64},{62,64}}, color={0,0,127}));
    connect(clock1.y, greater1.u1) annotation (Line(points={{-149,198},{-134,198},
            {-134,214},{-128,214}}, color={0,0,127}));
    connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-145,234},{-134,
            234},{-134,222},{-128,222}}, color={0,0,127}));
    connect(greater1.y, switch_P_setpoint_TCV2.u2)
      annotation (Line(points={{-105,214},{-88,214}}, color={255,0,255}));
    connect(const11.y, switch_P_setpoint_TCV2.u3) annotation (Line(points={{
            -111.6,186},{-104,186},{-104,188},{-98,188},{-98,206},{-88,206}},
          color={0,0,127}));
    connect(switch_P_setpoint_TCV2.y, PID.prop_k) annotation (Line(points={{-65,214},
            {-48,214},{-48,212},{-16,212},{-16,37.4},{13.4,37.4}},    color={0,0,
            127}));
    connect(ramp.y, switch_P_setpoint_TCV2.u1) annotation (Line(points={{-103,254},
            {-96,254},{-96,222},{-88,222}}, color={0,0,127}));
    connect(trapezoid1.y, PID.u_ff) annotation (Line(points={{-129,30},{-78,30},{
            -78,40},{-12,40},{-12,34},{-6,34}}, color={0,0,127}));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics));
  end CS_Rankine_Xe100_Based_Secondary_TransientControl;

  model CS_threeStagedTurbine_HTGR

    extends BaseClasses.Partial_ControlSystem;

    Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
      annotation (Placement(transformation(extent={{-22,16},{-2,36}})));
    Modelica.Blocks.Sources.Constant const4(k=1200)
      annotation (Placement(transformation(extent={{54,86},{74,106}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{80,80},{100,100}})));
    TRANSFORM.Controls.LimPID LTV2_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-5,
      Ti=15,
      yMax=1 - 1e-6,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{20,-68},{42,-46}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-14,-68},{8,-46}})));
    TRANSFORM.Controls.LimPID TCV_Position(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-3e-9,
      Ti=360,
      yMax=0,
      yMin=-1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{26,-14},{46,-34}})));
    Modelica.Blocks.Sources.Constant const8(k=1e-6)
      annotation (Placement(transformation(extent={{58,-88},{70,-76}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{80,-74},{100,-54}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{58,-64},{70,-50}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=500,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{80,40},{100,60}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{54,40},{74,60}})));
    Data.HTGR_Rankine
                    data(
      p_steam_vent=14000000,
      T_Steam_Ref=788.15,                       Q_Nom=44e6)
      annotation (Placement(transformation(extent={{-98,82},{-78,102}})));
    Modelica.Blocks.Sources.ContinuousClock clock2(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-318,40},{-298,60}})));
    Modelica.Blocks.Sources.Constant valvedelay2(k=6e5)
      annotation (Placement(transformation(extent={{-318,74},{-298,94}})));
    Modelica.Blocks.Logical.Greater greater2
      annotation (Placement(transformation(extent={{-278,74},{-258,54}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV1
      annotation (Placement(transformation(extent={{-238,54},{-218,74}})));
    Modelica.Blocks.Sources.Constant const1(k=-150)
      annotation (Placement(transformation(extent={{-278,80},{-258,100}})));
    Modelica.Blocks.Sources.Constant const2(k=-150)
      annotation (Placement(transformation(extent={{-278,24},{-258,44}})));
    Modelica.Blocks.Sources.Constant const10(k=5000)
      annotation (Placement(transformation(extent={{-278,-12},{-260,6}})));
    SupportComponents.VarLimVarK_PID PID(
      use_k_in=true,
      use_lowlim_in=true,
      use_uplim_in=true,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      with_FF=true,
      k=-5e-1,
      Ti=30) annotation (Placement(transformation(extent={{18,16},{38,36}})));
    Modelica.Blocks.Sources.Constant const11(k=-1e-1)
      annotation (Placement(transformation(extent={{-278,-114},{-258,-94}})));
    Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-318,-96},{-298,-76}})));
    Modelica.Blocks.Sources.Constant valvedelay1(k=8.5e5)
      annotation (Placement(transformation(extent={{-318,-64},{-298,-44}})));
    Modelica.Blocks.Logical.Greater greater1
      annotation (Placement(transformation(extent={{-278,-64},{-258,-84}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV2
      annotation (Placement(transformation(extent={{-238,-84},{-218,-64}})));
    Modelica.Blocks.Sources.Constant
                                 const(k=-1e-1)
      annotation (Placement(transformation(extent={{-278,-56},{-258,-36}})));
    TRANSFORM.Controls.LimPID LTV1_Divert_Valve1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-8,
      Ti=300,
      yMax=1 - 1e-6,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=0.2)
      annotation (Placement(transformation(extent={{-40,110},{-20,130}})));
    Modelica.Blocks.Sources.Trapezoid trap_LTV1bypass_power(
      amplitude=-16e6,
      rising=7200,
      width=3600,
      falling=7200,
      period=21600,
      nperiod=-1,
      offset=44e6,
      startTime=1e4)
      annotation (Placement(transformation(extent={{-72,110},{-52,130}})));
    Modelica.Blocks.Sources.Constant const12(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-278,122},{-260,140}})));
    Modelica.Blocks.Sources.Constant valvedelay3(k=1e5)
      annotation (Placement(transformation(extent={{-318,176},{-298,196}})));
    Modelica.Blocks.Sources.ContinuousClock clock3(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-318,136},{-298,156}})));
    Modelica.Blocks.Logical.Greater greater3
      annotation (Placement(transformation(extent={{-278,176},{-258,156}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV3
      annotation (Placement(transformation(extent={{-238,156},{-218,176}})));
    Modelica.Blocks.Sources.Constant valvedelay4(k=14e6)
      annotation (Placement(transformation(extent={{-278,190},{-258,210}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
    Modelica.Blocks.Sources.Constant const7(k=1.0)
      annotation (Placement(transformation(extent={{58,-42},{70,-30}})));
    Modelica.Blocks.Sources.Constant constant_0(k=0)
      annotation (Placement(transformation(extent={{-22,46},{-2,66}})));
    TRANSFORM.Blocks.RealExpression Q_balance
      annotation (Placement(transformation(extent={{-100,54},{-76,66}})));
    TRANSFORM.Blocks.RealExpression W_balance
      annotation (Placement(transformation(extent={{-100,44},{-76,56}})));
    TRANSFORM.Blocks.RealExpression Temp_Feedwater
      "Total electricity generated"
      annotation (Placement(transformation(extent={{-100,4},{-76,16}})));
    TRANSFORM.Blocks.RealExpression Press_Steam "Total electricity generated"
      annotation (Placement(transformation(extent={{-100,-6},{-76,6}})));
    TRANSFORM.Blocks.RealExpression Temp_Steam "Total electricity generated"
      annotation (Placement(transformation(extent={{-100,-18},{-76,-6}})));
    TRANSFORM.Blocks.RealExpression ElectricalPower
      "Total electricity generated"
      annotation (Placement(transformation(extent={{-100,-28},{-76,-16}})));
    TRANSFORM.Blocks.RealExpression massflow_LTV
      annotation (Placement(transformation(extent={{-100,-38},{-76,-26}})));
    TRANSFORM.Blocks.RealExpression Control_1
      annotation (Placement(transformation(extent={{-206,156},{-170,176}})));
    Modelica.Blocks.Sources.RealExpression Control_Input_1_output(y=Control_1.y)
      annotation (Placement(transformation(extent={{-14,-36},{12,-12}})));
    TRANSFORM.Blocks.RealExpression Control_2
      annotation (Placement(transformation(extent={{-206,54},{-170,74}})));
    Modelica.Blocks.Sources.RealExpression Contro2_out(y=Control_2.y)
      annotation (Placement(transformation(extent={{-58,170},{-18,188}})));
    TRANSFORM.Blocks.RealExpression Control_3
      annotation (Placement(transformation(extent={{-206,-14},{-170,6}})));
    Modelica.Blocks.Sources.RealExpression Contro3_out(y=Control_3.y)
      annotation (Placement(transformation(extent={{-58,152},{-18,170}})));
    TRANSFORM.Blocks.RealExpression Control_4
      annotation (Placement(transformation(extent={{-206,-84},{-170,-64}})));
    Modelica.Blocks.Sources.RealExpression Contro4_out(y=Control_4.y)
      annotation (Placement(transformation(extent={{-58,134},{-18,154}})));
  equation

    connect(const5.y,LTV2_Divert_Valve. u_s)
      annotation (Line(points={{9.1,-57},{17.8,-57}},  color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,LTV2_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-30,-80},{30,-80},{30,-70.2},{31,-70.2}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{120,-100},{120,-64},{101,-64}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add2.u2, const8.y) annotation (Line(points={{78,-70},{70.6,-70},{
            70.6,-82}},                                                    color=
            {0,0,127}));
    connect(add2.u1, timer.y) annotation (Line(points={{78,-58},{78,-57},{
            70.84,-57}},                                          color={0,0,127}));
    connect(LTV2_Divert_Valve.y, timer.u) annotation (Line(points={{43.1,-57},
            {56.8,-57}},                                               color={0,0,
            127}));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{75,50},{78,50}},     color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-30,0},{90,0},{90,38}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{120,-100},{120,50},{101,50}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(clock2.y, greater2.u1) annotation (Line(points={{-297,50},{-288,
            50},{-288,64},{-280,64}},
                                    color={0,0,127}));
    connect(valvedelay2.y, greater2.u2) annotation (Line(points={{-297,84},{
            -288,84},{-288,72},{-280,72}},
                                         color={0,0,127}));
    connect(greater2.y, switch_P_setpoint_TCV1.u2)
      annotation (Line(points={{-257,64},{-240,64}},  color={255,0,255}));
    connect(const2.y, switch_P_setpoint_TCV1.u3) annotation (Line(points={{-257,34},
            {-248,34},{-248,56},{-240,56}},                  color={0,0,127}));
    connect(const1.y, switch_P_setpoint_TCV1.u1) annotation (Line(points={{-257,90},
            {-248,90},{-248,72},{-240,72}},      color={0,0,127}));
    connect(const3.y, PID.u_s)
      annotation (Line(points={{-1,26},{16,26}},  color={0,0,127}));
    connect(clock1.y, greater1.u1) annotation (Line(points={{-297,-86},{-288,
            -86},{-288,-74},{-280,-74}},
                                    color={0,0,127}));
    connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-297,-54},{
            -288,-54},{-288,-66},{-280,-66}},
                                         color={0,0,127}));
    connect(greater1.y, switch_P_setpoint_TCV2.u2)
      annotation (Line(points={{-257,-74},{-240,-74}},color={255,0,255}));
    connect(const11.y, switch_P_setpoint_TCV2.u3) annotation (Line(points={{-257,
            -104},{-248,-104},{-248,-82},{-240,-82}},
          color={0,0,127}));
    connect(const.y, switch_P_setpoint_TCV2.u1) annotation (Line(points={{-257,
            -46},{-248,-46},{-248,-66},{-240,-66}},
                                                 color={0,0,127}));
    connect(sensorBus.Power, LTV1_Divert_Valve1.u_m) annotation (Line(
        points={{-30,-100},{-30,108}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(valvedelay3.y, greater3.u2) annotation (Line(points={{-297,186},{
            -288,186},{-288,174},{-280,174}},
                                        color={0,0,127}));
    connect(clock3.y, greater3.u1) annotation (Line(points={{-297,146},{-290,
            146},{-290,166},{-280,166}},
                                    color={0,0,127}));
    connect(const12.y, switch_P_setpoint_TCV3.u3) annotation (Line(points={{-259.1,
            131},{-248,131},{-248,158},{-240,158}},        color={0,0,127}));
    connect(greater3.y, switch_P_setpoint_TCV3.u2)
      annotation (Line(points={{-257,166},{-240,166}}, color={255,0,255}));
    connect(valvedelay4.y, switch_P_setpoint_TCV3.u1) annotation (Line(points={{-257,
            200},{-248,200},{-248,174},{-240,174}},  color={0,0,127}));
    connect(TCV_Position.y, add1.u1)
      annotation (Line(points={{47,-24},{78,-24}},   color={0,0,127}));
    connect(const7.y, add1.u2)
      annotation (Line(points={{70.6,-36},{78,-36}},   color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{75,96},{75,97.5},{78,97.5},{78,96}},
                                                   color={0,0,127}));
    connect(trap_LTV1bypass_power.y, LTV1_Divert_Valve1.u_s)
      annotation (Line(points={{-51,120},{-42,120}},      color={0,0,127}));
    connect(constant_0.y, PID.u_ff) annotation (Line(points={{-1,56},{8,56},{
            8,34},{16,34}},                      color={0,0,127}));
    connect(PID.y, add.u2) annotation (Line(points={{39,26},{48,26},{48,84},{
            78,84}}, color={0,0,127}));
    connect(sensorBus.Q_balance, Q_balance.u) annotation (Line(
        points={{-29.9,-99.9},{-30,-99.9},{-30,-100},{-120,-100},{-120,60},{
            -102.4,60}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_balance, W_balance.u) annotation (Line(
        points={{-29.9,-99.9},{-120,-99.9},{-120,50},{-102.4,50}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Feedwater_Temp, Temp_Feedwater.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,10},{-102.4,10}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, Press_Steam.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,0},{-102.4,0}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Temperature, Temp_Steam.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,-12},{-102.4,-12}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Power, ElectricalPower.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,-22},{-102.4,-22}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(switch_P_setpoint_TCV3.y, Control_1.u)
      annotation (Line(points={{-217,166},{-209.6,166}}, color={0,0,127}));
    connect(Control_Input_1_output.y, TCV_Position.u_s)
      annotation (Line(points={{13.3,-24},{24,-24}}, color={0,0,127}));
    connect(sensorBus.massflow_LPTv, massflow_LTV.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,-32},{-102.4,-32}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(switch_P_setpoint_TCV1.y, Control_2.u)
      annotation (Line(points={{-217,64},{-209.6,64}}, color={0,0,127}));
    connect(Contro2_out.y, PID.lowerlim) annotation (Line(points={{-16,179},{
            28,179},{28,37}}, color={0,0,127}));
    connect(const10.y, Control_3.u) annotation (Line(points={{-259.1,-3},{
            -259.1,-4},{-209.6,-4}}, color={0,0,127}));
    connect(Contro3_out.y, PID.upperlim) annotation (Line(points={{-16,161},{
            22,161},{22,37}}, color={0,0,127}));
    connect(switch_P_setpoint_TCV2.y, Control_4.u)
      annotation (Line(points={{-217,-74},{-209.6,-74}}, color={0,0,127}));
    connect(PID.prop_k, Contro4_out.y) annotation (Line(points={{35.4,37.4},{
            35.4,122},{36,122},{36,144},{-16,144}}, color={0,0,127}));
    connect(sensorBus.Steam_Temperature, PID.u_m) annotation (Line(
        points={{-30,-100},{-30,6},{28,6},{28,14}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, TCV_Position.u_m) annotation (Line(
        points={{-30,-100},{-30,0},{36,0},{36,-12}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{120,-99.9},{120,-30},{101,-30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{120,-100},{120,90},{101,90}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.openingLPTv, LTV1_Divert_Valve1.y) annotation (Line(
        points={{30,-100},{120,-100},{120,120},{-19,120}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics));
  end CS_threeStagedTurbine_HTGR;

  model CS_DivertPowerControl_ANL_v2
    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand_large
    annotation(Dialog(tab="General"));

    TRANSFORM.Controls.LimPID Turb_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=2e-4,
      Ti=5,
      Td=0.1,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-62,-116},{-42,-136}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-104,-136},{-84,-116}})));
    TRANSFORM.Controls.LimPID TCV_Power(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-9,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - const7.k,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-58,-28},{-38,-48}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand_large)
      annotation (Placement(transformation(extent={{54,-8},{68,4}})));
    Modelica.Blocks.Sources.Constant const7(k=5e-3)
      annotation (Placement(transformation(extent={{-34,-54},{-26,-46}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
    Modelica.Blocks.Sources.Constant const8(k=0.015)
      annotation (Placement(transformation(extent={{-32,-140},{-24,-132}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-8,-140},{12,-120}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-32,-128},{-24,-120}})));
    replaceable NHES.Systems.BalanceOfPlant.RankineCycle.Data.TES_Setpoints data(
      p_steam=3398000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=48.57e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15,
      m_flow_reactor=67.3)
      annotation (Placement(transformation(extent={{78,78},{98,98}})));
    Modelica.Blocks.Sources.Constant const3(k=data.m_flow_reactor)
      annotation (Placement(transformation(extent={{-96,34},{-76,54}})));
    TRANSFORM.Controls.LimPID FWCP_mflow(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=20,
      Td=0.1,
      yMax=1250,
      yMin=-750,
      wp=0,
      wd=1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-66,34},{-46,54}})));
    Modelica.Blocks.Sources.Constant const4(k=1200)
      annotation (Placement(transformation(extent={{-40,52},{-32,60}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{-24,40},{-4,60}})));
    Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{10,74},{30,94}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=15,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-58,74},{-38,94}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-98,74},{-78,94}})));
    Modelica.Blocks.Math.Add         add5
      annotation (Placement(transformation(extent={{112,-106},{92,-86}})));
    TRANSFORM.Controls.LimPID Charge_OnOff_Throttle(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-4e-7,
      Ti=5,
      k_s=1,
      k_m=1,
      yMax=1 - 0.015,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{146,-78},{126,-98}})));
    Modelica.Blocks.Sources.Constant const10(k=0.015)
      annotation (Placement(transformation(extent={{138,-122},{130,-114}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
    Modelica.Blocks.Math.Min min2
      annotation (Placement(transformation(extent={{90,-18},{110,2}})));
    Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
      annotation (Placement(transformation(extent={{50,-76},{74,-52}})));
    Modelica.Blocks.Sources.Constant const12(k=data.Q_Nom + 0.001e6)
      annotation (Placement(transformation(extent={{54,-34},{78,-10}})));
  equation
    connect(const5.y,Turb_Divert_Valve. u_s)
      annotation (Line(points={{-83,-126},{-64,-126}}, color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,Turb_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-52,-100},{-52,-114}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(const7.y,add1. u2) annotation (Line(points={{-25.6,-50},{-18,-50}},
                                        color={0,0,127}));
    connect(TCV_Power.y, add1.u1)
      annotation (Line(points={{-37,-38},{-18,-38}}, color={0,0,127}));
    connect(add2.u2,const8. y) annotation (Line(points={{-10,-136},{-23.6,-136}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1,timer. y) annotation (Line(points={{-10,-124},{-23.44,-124}},
                                                                  color={0,0,127}));
    connect(Turb_Divert_Valve.y,timer. u) annotation (Line(points={{-41,-126},{
            -36,-126},{-36,-124},{-32.8,-124}},                        color={0,0,
            127}));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-130},{13,-130}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-44},{5,-44}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.opening_BV, const2.y) annotation (Line(
        points={{30.1,-99.9},{30.1,58},{31,58},{31,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const3.y,FWCP_mflow. u_s)
      annotation (Line(points={{-75,44},{-68,44}}, color={0,0,127}));
    connect(FWCP_mflow.y, add.u2)
      annotation (Line(points={{-45,44},{-26,44}},
                                                 color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{-31.6,56},{-26,56}},
                                                  color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,50},{-3,50}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-77,84},{-60,84}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,62},{-48,62},{-48,72}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,68},{-30,68},{-30,84},{-37,84}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(add5.u1, Charge_OnOff_Throttle.y)
      annotation (Line(points={{114,-90},{114,-88},{125,-88}},
                                                   color={0,0,127}));
    connect(add5.u2, const10.y) annotation (Line(points={{114,-102},{118,-102},
            {118,-118},{129.6,-118}},
                              color={0,0,127}));
    connect(actuatorBus.SHS_throttle, add5.y) annotation (Line(
        points={{30,-100},{30,-96},{91,-96}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Condensor_Output_mflow, FWCP_mflow.u_m) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,18},{-56,18},{-56,32}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(min1.u1, const6.y)
      annotation (Line(points={{90,-64},{75.2,-64}}, color={0,0,127}));
    connect(Charge_OnOff_Throttle.u_m, min1.y) annotation (Line(points={{136,-76},
            {136,-70},{113,-70}},           color={0,0,127}));
    connect(realExpression.y, min2.u1) annotation (Line(points={{68.7,-2},{88,
            -2}},                      color={0,0,127}));
    connect(min2.y, Charge_OnOff_Throttle.u_s) annotation (Line(points={{111,-8},
            {148,-8},{148,-88}},            color={0,0,127}));
    connect(min2.u2, const12.y) annotation (Line(points={{88,-14},{79.2,-14},
            {79.2,-22}},       color={0,0,127}));
    connect(sensorBus.Power, min1.u2) annotation (Line(
        points={{-30,-100},{-30,-84},{84,-84},{84,-76},{90,-76}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(min2.y, TCV_Power.u_s) annotation (Line(points={{111,-8},{114,-8},
            {114,-38},{8,-38},{8,-18},{-66,-18},{-66,-38},{-60,-38}}, color={
            0,0,127}));
    connect(sensorBus.Power, TCV_Power.u_m) annotation (Line(
        points={{-30,-100},{-30,-58},{-24,-58},{-24,-52},{-22,-52},{-22,-36},
            {-32,-36},{-32,-20},{-48,-20},{-48,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (Diagram(graphics={Text(
            extent={{-70,-142},{-20,-160}},
            textColor={28,108,200},
            textString="Feedwater")}));
  end CS_DivertPowerControl_ANL_v2;

  model CS_NoFeedHeat_mFlow_Control

    // Modified from CS_SmallCycle_NoFeedHeat_Argonne

    extends
      NHES.Systems.BalanceOfPlant.RankineCycle.BaseClasses.Partial_ControlSystem;

    extends NHES.Icons.DummyIcon;

    input Real electric_demand_large
    annotation(Dialog(tab="General"));

    replaceable NHES.Systems.BalanceOfPlant.RankineCycle.Data.TES_Setpoints data(
      p_steam=1200000,
      p_steam_vent=15000000,
      T_Steam_Ref=579.75,
      Q_Nom=48.57e6,
      T_Feedwater=421.15,
      T_SHS_Return=491.15)
      annotation (Placement(transformation(extent={{64,42},{78,56}})));
    Modelica.Blocks.Sources.Constant const3(k=data.p_steam)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    TRANSFORM.Controls.LimPID FWP_mFlow(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-7,
      Ti=5,
      Td=0.1,
      yMax=50,
      yMin=0.9,
      wd=1,
      initType=Modelica.Blocks.Types.Init.NoInit,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-28,14},{-8,34}})));
    Modelica.Blocks.Sources.Constant const4(k=0)
      annotation (Placement(transformation(extent={{-14,44},{-6,52}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{20,20},{40,40}})));
    Modelica.Blocks.Sources.Constant const11(k=1e-4)
      annotation (Placement(transformation(extent={{-4,-56},{4,-48}})));
    Modelica.Blocks.Math.Add         add4
      annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter(min=0, max=1)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    Modelica.Blocks.Sources.RealExpression
                                     realExpression(y=electric_demand_large)
      annotation (Placement(transformation(extent={{-74,18},{-60,30}})));
    TRANSFORM.Controls.LimPID TCV_SHS(
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=-1e-9,
      Ti=1,
      Td=0.1,
      yMax=1 - const11.k,
      yMin=0,
      wd=1,
      Ni=0.9,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  equation
    connect(FWP_mFlow.y, add.u2)
      annotation (Line(points={{-7,24},{18,24}}, color={0,0,127}));
    connect(const4.y,add. u1)
      annotation (Line(points={{-5.6,48},{12,48},{12,36},{18,36}},
                                                  color={0,0,127}));
    connect(const11.y,add4. u2) annotation (Line(points={{4.4,-52},{12,-52},{
            12,-36},{18,-36}},
                     color={0,0,127}));
    connect(add4.u1,minMaxFilter. y)
      annotation (Line(points={{18,-24},{8,-24},{8,-30},{1.4,-30}},
                                                     color={0,0,127}));
    connect(minMaxFilter.u, TCV_SHS.y)
      annotation (Line(points={{-22,-30},{-29,-30}},
                                                   color={0,0,127}));
    connect(realExpression.y, FWP_mFlow.u_s)
      annotation (Line(points={{-59.3,24},{-30,24}}, color={0,0,127}));
    connect(sensorBus.Power, FWP_mFlow.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{-86,-70},{-86,12},{-18,12}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(const3.y, TCV_SHS.u_s)
      annotation (Line(points={{-59,-30},{-52,-30}}, color={0,0,127}));
    connect(sensorBus.Steam_Pressure, TCV_SHS.u_m) annotation (Line(
        points={{-30,-100},{-30,-50},{-40,-50},{-40,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.TCV_SHS, add4.y) annotation (Line(
        points={{30,-100},{30,-70},{48,-70},{48,-30},{41,-30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.Feed_Pump_mFlow, add.y) annotation (Line(
        points={{30,-100},{30,-72},{50,-72},{50,30},{41,30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (
      Diagram(coordinateSystem(extent={{-100,-100},{100,60}})),
      Icon(coordinateSystem(extent={{-100,-100},{100,60}})),
      experiment(
        StopTime=200,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"));
  end CS_NoFeedHeat_mFlow_Control;

  model CS_threeStagedTurbine_HTGR_JY

    extends BaseClasses.Partial_ControlSystem;

    Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
      annotation (Placement(transformation(extent={{-72,16},{-52,36}})));
    Modelica.Blocks.Sources.Constant const4(k=1200)
      annotation (Placement(transformation(extent={{42,72},{50,80}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{64,60},{84,80}})));
    TRANSFORM.Controls.LimPID LTV2_Divert_Valve(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-5,
      Ti=15,
      yMax=1 - 1e-6,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-64,-72},{-44,-52}})));
    Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
      annotation (Placement(transformation(extent={{-94,-72},{-74,-52}})));
    TRANSFORM.Controls.LimPID TCV_Position(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-3e-9,
      Ti=360,
      yMax=0,
      yMin=-1,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=1500)
      annotation (Placement(transformation(extent={{-56,-18},{-36,-38}})));
    Modelica.Blocks.Sources.Constant const8(k=1e-6)
      annotation (Placement(transformation(extent={{-34,-78},{-26,-70}})));
    Modelica.Blocks.Math.Add         add2
      annotation (Placement(transformation(extent={{-10,-78},{10,-58}})));
    Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer timer(
        Start_Time=1e-2)
      annotation (Placement(transformation(extent={{-34,-66},{-26,-58}})));
    TRANSFORM.Controls.LimPID PI_TBV(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-5e-7,
      Ti=500,
      yMax=1.0,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
    Modelica.Blocks.Sources.Constant const9(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-148,54},{-132,70}})));
    Data.HTGR_Rankine
                    data(
      p_steam_vent=14000000,
      T_Steam_Ref=788.15,                       Q_Nom=44e6)
      annotation (Placement(transformation(extent={{-98,-4},{-78,16}})));
    Modelica.Blocks.Sources.ContinuousClock clock2(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-174,146},{-154,166}})));
    Modelica.Blocks.Sources.Constant valvedelay2(k=6e5)
      annotation (Placement(transformation(extent={{-170,182},{-150,202}})));
    Modelica.Blocks.Logical.Greater greater2
      annotation (Placement(transformation(extent={{-130,182},{-110,162}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV1
      annotation (Placement(transformation(extent={{-90,162},{-70,182}})));
    Modelica.Blocks.Sources.Constant const1(k=-150)
      annotation (Placement(transformation(extent={{-122,192},{-114,200}})));
    Modelica.Blocks.Sources.Constant const2(k=-150)
      annotation (Placement(transformation(extent={{-124,138},{-116,146}})));
    Modelica.Blocks.Sources.Constant const10(k=5000)
      annotation (Placement(transformation(extent={{-64,196},{-56,204}})));
    SupportComponents.VarLimVarK_PID PID(
      use_k_in=true,
      use_lowlim_in=true,
      use_uplim_in=true,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      with_FF=true,
      k=-5e-1,
      Ti=30) annotation (Placement(transformation(extent={{-4,16},{16,36}})));
    Modelica.Blocks.Sources.Constant const11(k=-1e-1)
      annotation (Placement(transformation(extent={{-120,224},{-112,232}})));
    Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-170,230},{-150,250}})));
    Modelica.Blocks.Sources.Constant valvedelay1(k=8.5e5)
      annotation (Placement(transformation(extent={{-166,266},{-146,286}})));
    Modelica.Blocks.Logical.Greater greater1
      annotation (Placement(transformation(extent={{-126,266},{-106,246}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV2
      annotation (Placement(transformation(extent={{-86,246},{-66,266}})));
    Modelica.Blocks.Sources.Constant
                                 const(k=-1e-1)
      annotation (Placement(transformation(extent={{-124,286},{-104,306}})));
    TRANSFORM.Controls.LimPID LTV1_Divert_Valve1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-1e-8,
      Ti=300,
      yMax=1 - 1e-6,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialState,
      xi_start=0.2)
      annotation (Placement(transformation(extent={{-56,112},{-40,128}})));
    Modelica.Blocks.Sources.Constant const_LTV1bypass_power(k=44e6)
      annotation (Placement(transformation(extent={{-148,86},{-132,102}})));
    Modelica.Blocks.Sources.Trapezoid trap_LTV1bypass_massflow(
      amplitude=30,
      rising=5e4,
      width=5e4,
      falling=5e4,
      period=20e4,
      nperiod=-1,
      offset=15,
      startTime=1e5 + 900)
      annotation (Placement(transformation(extent={{-202,112},{-186,128}})));
    Modelica.Blocks.Sources.Ramp ramp_LTV1bypass_massflow(
      height=-15,
      duration=5e4,
      offset=15,
      startTime=1e5 + 900)
      annotation (Placement(transformation(extent={{-202,62},{-186,78}})));
    Modelica.Blocks.Sources.Constant const_LTV1bypass_massflow(k=30)
      annotation (Placement(transformation(extent={{-202,86},{-186,102}})));
    Modelica.Blocks.Sources.Trapezoid trap_LTV1bypass_power(
      amplitude=-16e6,
      rising=7200,
      width=3600,
      falling=7200,
      period=21600,
      nperiod=-1,
      offset=44e6,
      startTime=1e4)
      annotation (Placement(transformation(extent={{-150,112},{-134,128}})));
    Modelica.Blocks.Sources.Constant RPM_TEST(k=1000)
      annotation (Placement(transformation(extent={{42,90},{50,98}})));
    Modelica.Blocks.Sources.Constant const12(k=data.p_steam_vent)
      annotation (Placement(transformation(extent={{-196,-72},{-178,-54}})));
    Modelica.Blocks.Sources.Constant valvedelay3(k=1e5)
      annotation (Placement(transformation(extent={{-236,-18},{-216,2}})));
    Modelica.Blocks.Sources.ContinuousClock clock3(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-236,-58},{-216,-38}})));
    Modelica.Blocks.Logical.Greater greater3
      annotation (Placement(transformation(extent={{-196,-18},{-176,-38}})));
    Modelica.Blocks.Logical.Switch switch_P_setpoint_TCV3
      annotation (Placement(transformation(extent={{-156,-38},{-136,-18}})));
    Modelica.Blocks.Sources.Constant valvedelay4(k=14e6)
      annotation (Placement(transformation(extent={{-196,-4},{-176,16}})));
    Modelica.Blocks.Math.Add         add1
      annotation (Placement(transformation(extent={{-10,-44},{10,-24}})));
    Modelica.Blocks.Sources.Constant const7(k=1.0)
      annotation (Placement(transformation(extent={{-28,-44},{-20,-36}})));
    Modelica.Blocks.Sources.Constant constant_0(k=0)
      annotation (Placement(transformation(extent={{-144,24},{-128,40}})));
  equation

    connect(const5.y,LTV2_Divert_Valve. u_s)
      annotation (Line(points={{-73,-62},{-66,-62}},   color={0,0,127}));
    connect(sensorBus.Feedwater_Temp,LTV2_Divert_Valve. u_m) annotation (Line(
        points={{-30,-100},{-54,-100},{-54,-74}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
        points={{30,-100},{30,-68},{11,-68}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(add2.u2, const8.y) annotation (Line(points={{-12,-74},{-25.6,-74}},
                                                                           color=
            {0,0,127}));
    connect(add2.u1, timer.y) annotation (Line(points={{-12,-62},{-25.44,-62}},
                                                                  color={0,0,127}));
    connect(LTV2_Divert_Valve.y, timer.u) annotation (Line(points={{-43,-62},{-34.8,
            -62}},                                                     color={0,0,
            127}));
    connect(const9.y, PI_TBV.u_s)
      annotation (Line(points={{-131.2,62},{-42,62}},color={0,0,127}));
    connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
        points={{-30,-100},{-104,-100},{-104,44},{-30,44},{-30,50}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
        points={{30,-100},{30,62},{-19,62}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(clock2.y, greater2.u1) annotation (Line(points={{-153,156},{-138,156},
            {-138,172},{-132,172}}, color={0,0,127}));
    connect(valvedelay2.y, greater2.u2) annotation (Line(points={{-149,192},{-138,
            192},{-138,180},{-132,180}}, color={0,0,127}));
    connect(greater2.y, switch_P_setpoint_TCV1.u2)
      annotation (Line(points={{-109,172},{-92,172}}, color={255,0,255}));
    connect(const2.y, switch_P_setpoint_TCV1.u3) annotation (Line(points={{-115.6,
            142},{-110,142},{-110,160},{-92,160},{-92,164}}, color={0,0,127}));
    connect(const1.y, switch_P_setpoint_TCV1.u1) annotation (Line(points={{-113.6,
            196},{-98,196},{-98,180},{-92,180}}, color={0,0,127}));
    connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
        points={{30,-100},{30,50},{92,50},{92,70},{85,70}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const10.y, PID.upperlim) annotation (Line(points={{-55.6,200},{0,200},
            {0,37}},                                        color={0,0,127}));
    connect(switch_P_setpoint_TCV1.y, PID.lowerlim) annotation (Line(points={{-69,172},
            {6,172},{6,37}},
          color={0,0,127}));
    connect(sensorBus.Steam_Temperature, PID.u_m) annotation (Line(
        points={{-30,-100},{-104,-100},{-104,-8},{6,-8},{6,14}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(const3.y, PID.u_s)
      annotation (Line(points={{-51,26},{-6,26}}, color={0,0,127}));
    connect(PID.y, add.u2) annotation (Line(points={{17,26},{34,26},{34,34},{48,
            34},{48,64},{62,64}}, color={0,0,127}));
    connect(clock1.y, greater1.u1) annotation (Line(points={{-149,240},{-134,240},
            {-134,256},{-128,256}}, color={0,0,127}));
    connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-145,276},{-134,
            276},{-134,264},{-128,264}}, color={0,0,127}));
    connect(greater1.y, switch_P_setpoint_TCV2.u2)
      annotation (Line(points={{-105,256},{-88,256}}, color={255,0,255}));
    connect(const11.y, switch_P_setpoint_TCV2.u3) annotation (Line(points={{-111.6,
            228},{-104,228},{-104,230},{-98,230},{-98,248},{-88,248}},
          color={0,0,127}));
    connect(switch_P_setpoint_TCV2.y, PID.prop_k) annotation (Line(points={{-65,256},
            {14,256},{14,37.4},{13.4,37.4}},                          color={0,0,
            127}));
    connect(const.y, switch_P_setpoint_TCV2.u1) annotation (Line(points={{-103,
            296},{-96,296},{-96,264},{-88,264}}, color={0,0,127}));
    connect(actuatorBus.openingLPTv,LTV1_Divert_Valve1. y) annotation (Line(
        points={{30,-100},{120,-100},{120,120},{-39.2,120}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.Power, LTV1_Divert_Valve1.u_m) annotation (Line(
        points={{-30,-100},{-104,-100},{-104,100},{-48,100},{-48,110.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.Steam_Pressure, TCV_Position.u_m) annotation (Line(
        points={{-30,-100},{-104,-100},{-104,-10},{-46,-10},{-46,-16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(valvedelay3.y, greater3.u2) annotation (Line(points={{-215,-8},{-212,
            -8},{-212,-20},{-198,-20}}, color={0,0,127}));
    connect(clock3.y, greater3.u1) annotation (Line(points={{-215,-48},{-212,-48},
            {-212,-28},{-198,-28}}, color={0,0,127}));
    connect(const12.y, switch_P_setpoint_TCV3.u3) annotation (Line(points={{
            -177.1,-63},{-166,-63},{-166,-36},{-158,-36}}, color={0,0,127}));
    connect(greater3.y, switch_P_setpoint_TCV3.u2)
      annotation (Line(points={{-175,-28},{-158,-28}}, color={255,0,255}));
    connect(valvedelay4.y, switch_P_setpoint_TCV3.u1) annotation (Line(points={{
            -175,6},{-166,6},{-166,-20},{-158,-20}}, color={0,0,127}));
    connect(switch_P_setpoint_TCV3.y, TCV_Position.u_s)
      annotation (Line(points={{-135,-28},{-58,-28}}, color={0,0,127}));
    connect(TCV_Position.y, add1.u1)
      annotation (Line(points={{-35,-28},{-12,-28}}, color={0,0,127}));
    connect(const7.y, add1.u2)
      annotation (Line(points={{-19.6,-40},{-12,-40}}, color={0,0,127}));
    connect(const4.y, add.u1)
      annotation (Line(points={{50.4,76},{62,76}}, color={0,0,127}));
    connect(trap_LTV1bypass_power.y, LTV1_Divert_Valve1.u_s)
      annotation (Line(points={{-133.2,120},{-57.6,120}}, color={0,0,127}));
    connect(actuatorBus.opening_TCV, add1.y) annotation (Line(
        points={{30.1,-99.9},{30.1,-34},{11,-34}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(constant_0.y, PID.u_ff) annotation (Line(points={{-127.2,32},{-76,32},
            {-76,40},{-14,40},{-14,34},{-6,34}}, color={0,0,127}));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics));
  end CS_threeStagedTurbine_HTGR_JY;
end ControlSystems;
