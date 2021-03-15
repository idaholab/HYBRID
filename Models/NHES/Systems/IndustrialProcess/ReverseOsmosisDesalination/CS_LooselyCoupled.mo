within NHES.Systems.IndustrialProcess.ReverseOsmosisDesalination;
model CS_LooselyCoupled
  extends
    NHES.Systems.IndustrialProcess.ReverseOsmosisDesalination.BaseClasses.Partial_ControlSystem;

  parameter Real delayStart=5000 "Time to start tracking power profiles";
  parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
  parameter SI.Power W_IP_nom(displayUnit="MW") = 49.8e6
    "Nominal electrical power consumption in the IP";
  final parameter SI.Power W_IP_max(displayUnit="MW") = W_IP_nom*1.05
    "Maximum electrical power consumption in the IP";
  final parameter SI.Power W_IP_min(displayUnit="MW") = W_IP_nom/3
    "Minimum electrical power consumption in the IP";

  parameter Integer NoPumps = 45 "Number of pumps";
  parameter Real Power_RO_percent = 75 "Percent power consumption for the RO";
  parameter Real Power_Pretreatment_percent = 8 "Percent power consumption for the pretreatment";
  final parameter Real Power_RO_fraction = Power_RO_percent/(Power_RO_percent + Power_Pretreatment_percent) "Fraction of power consumption due to the RO";

  input SI.Power W_totalSetpoint "Total setpoint power" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
                   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={70,30})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=delayStart)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Sources.Constant W_IP_nominal(k=W_IP_nom)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Math.Gain scaler(k=1/capacityScaler)
    annotation (Placement(transformation(extent={{-14,4},{-2,16}})));
  Modelica.Blocks.Math.Gain scaler_Power_RO(k=Power_RO_fraction)
    annotation (Placement(transformation(extent={{-46,-26},{-34,-14}})));
  Modelica.Blocks.Math.Gain scaler_load_per_pump(k=1/NoPumps)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-8,-20})));
  Modelica.Blocks.Continuous.LimPID FBctrl_W_pump(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.0125318684948903,
    xi_start=FBctrl_W_pump.y_start/FBctrl_W_pump.k,
    y_start=9736.677,
    gainPID(y(start=FBctrl_W_pump.y_start)),
    yMax=12500,
    yMin=1250,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    Ti=8.60505190607221) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,-20})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_IP(y=W_totalSetpoint)
    annotation (Placement(transformation(extent={{-96,-10},{-76,10}})));
equation

  connect(lessThreshold.y, switch.u2)
    annotation (Line(points={{-29,30},{18,30}},   color={255,0,255}));
  connect(clock.y, lessThreshold.u)
    annotation (Line(points={{-69,30},{-58,30},{-52,30}},    color={0,0,127}));
  connect(W_IP_nominal.y, switch.u1) annotation (Line(points={{1,50},{10,50},{
          10,38},{18,38}},   color={0,0,127}));
  connect(scaler.y, switch.u3) annotation (Line(points={{-1.4,10},{10,10},{10,
          22},{18,22}},   color={0,0,127}));
  connect(switch.y, limiter_W_IP.u)
    annotation (Line(points={{41,30},{49.5,30},{58,30}}, color={0,0,127}));
  connect(scaler_Power_RO.y,scaler_load_per_pump. u)
    annotation (Line(points={{-33.4,-20},{-33.4,-20},{-15.2,-20}},
                                                            color={0,0,127}));
  connect(scaler_load_per_pump.y,FBctrl_W_pump. u_s)
    annotation (Line(points={{-1.4,-20},{18,-20}},    color={0,0,127}));
  connect(limiter_W_IP.y, scaler_Power_RO.u) annotation (Line(points={{81,30},{
          90,30},{90,0},{-60,0},{-60,-20},{-47.2,-20}}, color={0,0,127}));
  connect(sensorBus.W_RO_per_pump, FBctrl_W_pump.u_m) annotation (
      Line(
      points={{-30,-100},{-100,-100},{-100,-60},{30,-60},{30,-32}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.subBus_IP.RO.Voltage_IP, FBctrl_W_pump.y) annotation (
      Line(
      points={{30,-100},{66,-100},{100,-100},{100,-20},{41,-20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(W_totalSetpoint_IP.y, scaler.u) annotation (Line(points={{-75,0},{-68,
          0},{-68,10},{-15.2,10}}, color={0,0,127}));
annotation(defaultComponentName="CS");
end CS_LooselyCoupled;
