within NHES.Systems.BalanceOfPlant.Turbine;
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
