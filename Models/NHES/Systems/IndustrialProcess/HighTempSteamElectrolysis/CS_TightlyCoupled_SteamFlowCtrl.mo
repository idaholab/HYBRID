within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis;
model CS_TightlyCoupled_SteamFlowCtrl
  extends
    NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

  parameter Real delayStart=5000 "Time to start tracking power profiles";
  parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
  parameter SI.Power W_IP_nom(displayUnit="MW") = 51.1454e6
    "Nominal electrical power consumption in the IP";
  final parameter SI.Power W_IP_max(displayUnit="MW") = W_IP_nom*1.05
    "Maximum electrical power consumption in the IP";
  parameter SI.Power W_IP_min(displayUnit="MW") = 20.9561e6
    "Minimum electrical power consumption in the IP";

  input SI.Power W_totalSetpoint "Total setpoint power" annotation(Dialog(group="Inputs"));

  Modelica.Blocks.Sources.Ramp TNOut_anodeGas_set(
    offset=259 + 273.15,
    height=0,
    duration=0,
    y(displayUnit="degC", unit="K"),
    startTime=0)  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,70})));
  Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_anodeGas(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0.05,
    xi_start=0.5/FBctrl_TNOut_anodeGas.k,
    y_start=0.5,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    k=(1/223.36)*5,
    Ti=47.1571789477849,
    y(start=FBctrl_TNOut_anodeGas.y_start),
    gainPID(y(start=FBctrl_TNOut_anodeGas.y_start))) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,70})));
  Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    offset=283.4 + 273.15,
    y(displayUnit="degC", unit="K"))
                  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,20})));
  Modelica.Blocks.Continuous.LimPID FBctrl_TNOut_cathodeGas(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    k=1/252.35*1.5,
    xi_start=FBctrl_TNOut_cathodeGas.y_start/FBctrl_TNOut_cathodeGas.k,
    gainPID(y(start=FBctrl_TNOut_cathodeGas.y_start)),
    y_start=0.85,
    y(start=FBctrl_TNOut_cathodeGas.y_start),
    Ti=159.9663300632,
    yMin=0.75) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,20})));
  Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
                   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={70,-40})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=delayStart)
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Blocks.Sources.Constant W_IP_nominal(k=W_IP_nom)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Blocks.Math.Gain scaler(k=1/capacityScaler)
    annotation (Placement(transformation(extent={{-14,-66},{-2,-54}})));
  Modelica.Blocks.Sources.RealExpression W_totalSetpoint_IP(y=W_totalSetpoint)
    annotation (Placement(transformation(extent={{-60,-82},{-40,-62}})));
equation

  connect(FBctrl_TNOut_anodeGas.u_s,TNOut_anodeGas_set. y)
    annotation (Line(points={{-22,70},{-22,70},{-39,70}},color={0,0,127}));
  connect(TNOut_cathodeGas_set.y, FBctrl_TNOut_cathodeGas.u_s)
    annotation (Line(points={{-39,20},{-39,20},{-22,20}},color={0,0,127}));
  connect(sensorBus.TNOut_anodeGas, FBctrl_TNOut_anodeGas.u_m)
    annotation (Line(
      points={{-30,-100},{-100,-100},{-100,50},{-10,50},{-10,58}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.TNOut_cathodeGas, FBctrl_TNOut_cathodeGas.u_m)
    annotation (Line(
      points={{-30,-100},{-30,-100},{-30,-100},{-100,-100},{-100,0},{-10,0},{-10,
          8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.subBus_IP.HTSE.TNOut_anodeGas, FBctrl_TNOut_anodeGas.y)
    annotation (Line(
      points={{30,-100},{100,-100},{100,70},{1,70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.subBus_IP.HTSE.TNOut_cathodeGas, FBctrl_TNOut_cathodeGas.y)
    annotation (Line(
      points={{30,-100},{30,-100},{100,-100},{100,20},{1,20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.subBus_IP.HTSE.W_IP, limiter_W_IP.y) annotation (Line(
      points={{30,-100},{64,-100},{100,-100},{100,-40},{81,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(limiter_W_IP.u, switch.y)
    annotation (Line(points={{58,-40},{58,-40},{41,-40}}, color={0,0,127}));
  connect(lessThreshold.y, switch.u2)
    annotation (Line(points={{-29,-40},{18,-40}}, color={255,0,255}));
  connect(clock.y, lessThreshold.u)
    annotation (Line(points={{-69,-40},{-58,-40},{-52,-40}}, color={0,0,127}));
  connect(W_IP_nominal.y, switch.u1) annotation (Line(points={{1,-20},{10,-20},{
          10,-32},{18,-32}}, color={0,0,127}));
  connect(scaler.y, switch.u3) annotation (Line(points={{-1.4,-60},{10,-60},{10,
          -48},{18,-48}}, color={0,0,127}));
  connect(W_totalSetpoint_IP.y, scaler.u) annotation (Line(points={{-39,-72},{-26,
          -72},{-26,-60},{-15.2,-60}}, color={0,0,127}));
annotation(defaultComponentName="CS");
end CS_TightlyCoupled_SteamFlowCtrl;
