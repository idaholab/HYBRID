within NHES.Systems.EnergyManifold.SteamManifold;
model CS_InputSetpoint
  extends BaseClasses.Partial_ControlSystem;

  parameter SI.Time delayStartTDV = 300 "Delay start of TDV control";

  input SI.Power W_totalSetpoint "Total setpoint power from SC" annotation(Dialog(group="Inputs"));
  input SI.Power W_total "Total power from BOP" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Sources.Constant TDV_openingNominal(k=0.8)
    annotation (Placement(transformation(extent={{-160,0},{-140,20}})));
  Modelica.Blocks.Sources.Constant IPDV_openingNominal(k=0.5)
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Logical.Switch switch_BPDV
    annotation (Placement(transformation(extent={{120,-52},{140,-32}})));
  Modelica.Blocks.Logical.Less lessThreshold_BPDV
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Modelica.Blocks.Math.Feedback feedback_BPDV "set BPDV based on TDV"
    annotation (Placement(transformation(extent={{52,-4},{72,-24}})));
  Modelica.Blocks.Sources.Constant BPDV_openingNominal(k=0.001)
    annotation (Placement(transformation(extent={{-160,-60},{-140,-40}})));
  Modelica.Blocks.Math.Max BPDV_opening
    annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  Modelica.Blocks.Logical.Greater greater5
    annotation (Placement(transformation(extent={{-140,60},{-120,40}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-180,30},{-160,50}})));
  Modelica.Blocks.Sources.Constant valvedelay(k=delayStartTDV)
    annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
  Modelica.Blocks.Math.Gain W_normal_gain_setpoint(k=0.25e-8)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Math.Gain W_normal_gain_measured(k=0.25e-8) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,50})));
  TRANSFORM.Controls.LimPID
                       PID_TDV_opening(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=10,
    yMax=1 - TDV_openingNominal.k,
    yMin=-TDV_openingNominal.k + 0.0001)
           annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Modelica.Blocks.Logical.Switch switch_W_setpoint
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Logical.Switch switch_TDV_setpoint
    annotation (Placement(transformation(extent={{40,62},{60,82}})));
  Modelica.Blocks.Sources.Constant dopenNominal(k=0)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Math.Add TDV_opening
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  Modelica.Blocks.Sources.RealExpression W_total_BOP(y=W_total)
    annotation (Placement(transformation(extent={{-140,56},{-120,76}})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_SC(y=W_totalSetpoint)
    annotation (Placement(transformation(extent={{-140,70},{-120,90}})));
equation

  connect(lessThreshold_BPDV.y, switch_BPDV.u2) annotation (Line(points={{51,-30},
          {68,-30},{68,-42},{118,-42}}, color={255,0,255}));
  connect(BPDV_opening.y, switch_BPDV.u1) annotation (Line(points={{101,-20},{
          110,-20},{110,-34},{118,-34}}, color={0,0,127}));

  connect(BPDV_opening.u2, switch_BPDV.u3) annotation (Line(points={{78,-26},{
          60,-26},{60,-50},{118,-50}}, color={0,0,127}));
  connect(feedback_BPDV.y, BPDV_opening.u1)
    annotation (Line(points={{71,-14},{78,-14}}, color={0,0,127}));
  connect(clock.y, greater5.u1) annotation (Line(points={{-159,40},{-150,40},{-150,
          50},{-142,50}}, color={0,0,127}));
  connect(valvedelay.y, greater5.u2) annotation (Line(points={{-159,70},{-150,70},
          {-150,58},{-142,58}}, color={0,0,127}));
  connect(greater5.y,switch_W_setpoint. u2)
    annotation (Line(points={{-119,50},{-102,50}}, color={255,0,255}));
  connect(switch_W_setpoint.y,W_normal_gain_measured. u)
    annotation (Line(points={{-79,50},{-62,50}}, color={0,0,127}));
  connect(W_normal_gain_setpoint.y, PID_TDV_opening.u_s)
    annotation (Line(points={{-39,80},{-22,80}}, color={0,0,127}));
  connect(W_normal_gain_measured.y, PID_TDV_opening.u_m)
    annotation (Line(points={{-39,50},{-10,50},{-10,68}}, color={0,0,127}));
  connect(dopenNominal.y, switch_TDV_setpoint.u3) annotation (Line(points={{21,
          50},{30,50},{30,64},{38,64}}, color={0,0,127}));
  connect(switch_TDV_setpoint.u1, PID_TDV_opening.y)
    annotation (Line(points={{38,80},{20,80},{1,80}}, color={0,0,127}));
  connect(switch_TDV_setpoint.u2,switch_W_setpoint. u2) annotation (Line(points=
         {{38,72},{24,72},{24,66},{-6,66},{-6,34},{-108,34},{-108,50},{-102,50}},
        color={255,0,255}));
  connect(switch_TDV_setpoint.y, TDV_opening.u1) annotation (Line(points={{61,
          72},{70,72},{70,36},{78,36}}, color={0,0,127}));
  connect(TDV_openingNominal.y, TDV_opening.u2) annotation (Line(points={{-139,10},
          {40,10},{40,24},{78,24}}, color={0,0,127}));
  connect(TDV_opening.y, feedback_BPDV.u2) annotation (Line(points={{101,30},{
          110,30},{110,0},{62,0},{62,-6}}, color={0,0,127}));
  connect(BPDV_openingNominal.y, switch_BPDV.u3)
    annotation (Line(points={{-139,-50},{-139,-50},{118,-50}},
                                                            color={0,0,127}));
  connect(feedback_BPDV.u1, TDV_opening.u2) annotation (Line(points={{54,-14},{
          40,-14},{40,10},{40,24},{78,24}}, color={0,0,127}));
  connect(lessThreshold_BPDV.u1, feedback_BPDV.u2) annotation (Line(points={{28,
          -30},{20,-30},{20,0},{62,0},{62,-6}}, color={0,0,127}));
  connect(lessThreshold_BPDV.u2, TDV_opening.u2) annotation (Line(points={{28,
          -38},{16,-38},{16,10},{40,10},{40,24},{78,24}}, color={0,0,127}));
  connect(actuatorBus.opening_TDV, TDV_opening.y) annotation (Line(
      points={{30.1,-99.9},{160,-99.9},{160,30},{101,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BPDV, switch_BPDV.y) annotation (Line(
      points={{30.1,-99.9},{160,-99.9},{160,-42},{141,-42}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_IPDV, IPDV_openingNominal.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{160,-99.9},{160,-80},{121,-80}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(W_normal_gain_setpoint.u, W_totalSetpoint_SC.y)
    annotation (Line(points={{-62,80},{-119,80}}, color={0,0,127}));
  connect(switch_W_setpoint.u3, W_totalSetpoint_SC.y) annotation (Line(points={{-102,42},{-112,
          42},{-112,80},{-119,80}}, color={0,0,127}));
  connect(switch_W_setpoint.u1, W_total_BOP.y) annotation (Line(points={{-102,
          58},{-110,58},{-110,66},{-119,66}}, color={0,0,127}));
annotation (defaultComponentName="EM_CS",
Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{160,100}})));
end CS_InputSetpoint;
