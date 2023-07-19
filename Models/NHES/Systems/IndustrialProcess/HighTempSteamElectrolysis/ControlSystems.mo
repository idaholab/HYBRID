within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis;
package ControlSystems
  model CS_TightlyCoupled_PowerCtrl
    extends
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

    parameter SI.Power W_IP_nom(displayUnit="MW") = 51.1454e6
      "Nominal electrical power consumption in the IP";
    final parameter SI.Power W_IP_max(displayUnit="MW") = W_IP_nom*1.05
      "Maximum electrical power consumption in the IP";
    parameter SI.Power W_IP_min(displayUnit="MW") = 20.9561e6
      "Minimum electrical power consumption in the IP";
  Modelica.Blocks.Math.Feedback feedback_TNOut_cathodeGas annotation (Placement(
          transformation(
          extent={{12,-12},{-12,12}},
          rotation=180,
          origin={-40,0})));
    Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
      startTime=100,
      height=0,
      duration=0,
      offset=283.4 + 273.15,
      y(displayUnit="degC", unit="K")) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-70,30})));
    Modelica.Blocks.Continuous.PI FBctrl_TNOut_cathodeGas(
      k=8000,
      T=8,
      y(start=51.1454e6),
      initType=Modelica.Blocks.Types.Init.InitialState,
      x_start=FBctrl_TNOut_cathodeGas.y_start/FBctrl_TNOut_cathodeGas.k,
      y_start=51.1454e6)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
      annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={50,0})));
  equation
    connect(feedback_TNOut_cathodeGas.y, FBctrl_TNOut_cathodeGas.u) annotation (
        Line(points={{-29.2,-1.33227e-015},{-29.2,0},{-2,0}}, color={0,0,127}));
    connect(FBctrl_TNOut_cathodeGas.y, limiter_W_IP.u) annotation (Line(points={{21,
            0},{21,1.55431e-015},{38,1.55431e-015}}, color={0,0,127}));

    connect(TNOut_cathodeGas_set.y, feedback_TNOut_cathodeGas.u2)
      annotation (Line(points={{-59,30},{-40,30},{-40,9.6}}, color={0,0,127}));
    connect(sensorBus.TNOut_cathodeGas, feedback_TNOut_cathodeGas.u1)
      annotation (Line(
        points={{-30,-100},{-100,-100},{-100,0},{-49.6,0}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.subBus_IP.HTSE.W_IP, limiter_W_IP.y) annotation (Line(
        points={{30,-100},{100,-100},{100,0},{61,0}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
  annotation(defaultComponentName="CS");
  end CS_TightlyCoupled_PowerCtrl;

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

  model CS_TightlyCoupled_SteamFlowCtrl_FY17
    extends
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

    parameter Real delayStart=5000 "Time to start tracking power profiles";
    parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
    parameter SI.Power W_IP_nom(displayUnit="MW") = 53.3033e6
      "Nominal electrical power consumption in the IP";
    final parameter SI.Power W_IP_max(displayUnit="MW") = W_IP_nom*1.05
      "Maximum electrical power consumption in the IP";
    parameter SI.Power W_IP_min(displayUnit="MW") = 24.0292e6
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
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y(start=FBctrl_TNOut_anodeGas.y_start),
      gainPID(y(start=FBctrl_TNOut_anodeGas.y_start)),
      k=(1/120.25)*1.5,
      Ti=75.9592150676623,
      xi_start=FBctrl_TNOut_anodeGas.y_start/FBctrl_TNOut_anodeGas.k,
      y_start=0.4) annotation (Placement(transformation(
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
      k=1/252.35*1.5,
      xi_start=FBctrl_TNOut_cathodeGas.y_start/FBctrl_TNOut_cathodeGas.k,
      gainPID(y(start=FBctrl_TNOut_cathodeGas.y_start)),
      y(start=FBctrl_TNOut_cathodeGas.y_start),
      Ti=159.966330063206,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y_start=0.9,
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
  end CS_TightlyCoupled_SteamFlowCtrl_FY17;

  model CS_TightlyCoupled_SteamFlowCtrl_stepInput
    extends
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

    parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
    parameter SI.Power W_IP_nom(displayUnit="MW") = 51.1454e6
      "Nominal electrical power consumption in the IP";
    final parameter SI.Power W_IP_max(displayUnit="MW") = W_IP_nom*1.05
      "Maximum electrical power consumption in the IP";
    parameter SI.Power W_IP_min(displayUnit="MW") = 20.9561e6
      "Minimum electrical power consumption in the IP";

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
          origin={30,-40})));
    Modelica.Blocks.Math.Gain scaler(k=1/capacityScaler)
      annotation (Placement(transformation(extent={{-12,-46},{0,-34}})));
    Modelica.Blocks.Sources.Ramp W_IP_setPoint(
      duration=0,
      startTime=100,
      offset=(9.10627*1e6*5 + 5613820)*capacityScaler,
      height=(-1.929*1e6*5*1 + 310530*0 + 454300*1 + 108120*0 - 1254074*0)*
          capacityScaler)
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
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
        points={{30,-100},{64,-100},{100,-100},{100,-40},{41,-40}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(scaler.y, limiter_W_IP.u)
      annotation (Line(points={{0.6,-40},{0.6,-40},{18,-40}}, color={0,0,127}));
    connect(W_IP_setPoint.y, scaler.u)
      annotation (Line(points={{-39,-40},{-13.2,-40}}, color={0,0,127}));
  annotation(defaultComponentName="CS");
  end CS_TightlyCoupled_SteamFlowCtrl_stepInput;

  model CS_TightlyCoupled_SteamFlowCtrl_stepInput_FY17
    extends
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

    parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
    parameter SI.Power W_IP_nom(displayUnit="MW") = 53.3033e6
      "Nominal electrical power consumption in the IP";
    final parameter SI.Power W_IP_max(displayUnit="MW") = W_IP_nom*1.05
      "Maximum electrical power consumption in the IP";
    parameter SI.Power W_IP_min(displayUnit="MW") = 24.0292e6
      "Minimum electrical power consumption in the IP";

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
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y(start=FBctrl_TNOut_anodeGas.y_start),
      gainPID(y(start=FBctrl_TNOut_anodeGas.y_start)),
      k=(1/120.25)*1.5,
      Ti=75.9592150676623,
      xi_start=FBctrl_TNOut_anodeGas.y_start/FBctrl_TNOut_anodeGas.k,
      y_start=0.4) annotation (Placement(transformation(
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
      k=1/252.35*1.5,
      xi_start=FBctrl_TNOut_cathodeGas.y_start/FBctrl_TNOut_cathodeGas.k,
      gainPID(y(start=FBctrl_TNOut_cathodeGas.y_start)),
      y(start=FBctrl_TNOut_cathodeGas.y_start),
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y_start=0.9,
      Ti=159.966330063206,
      yMin=0.05) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-10,20})));
    Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
                     annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={30,-40})));
    Modelica.Blocks.Math.Gain scaler(k=1/capacityScaler)
      annotation (Placement(transformation(extent={{-12,-46},{0,-34}})));
    Modelica.Blocks.Sources.Ramp W_IP_setPoint(
      duration=0,
      startTime=100,
      height=(-1.929*1e6*5*1 + 1613748*1 + 1658789.33*0 - 339049.79*0)*
          capacityScaler,
      offset=(9.10627*1e6*5 + 7771944.2)*capacityScaler)
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
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
        points={{30,-100},{64,-100},{100,-100},{100,-40},{41,-40}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(scaler.y, limiter_W_IP.u)
      annotation (Line(points={{0.6,-40},{0.6,-40},{18,-40}}, color={0,0,127}));
    connect(W_IP_setPoint.y, scaler.u)
      annotation (Line(points={{-39,-40},{-13.2,-40}}, color={0,0,127}));
  annotation(defaultComponentName="CS");
  end CS_TightlyCoupled_SteamFlowCtrl_stepInput_FY17;

  model CS_LooselyCoupled
    extends
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

    parameter Real delayStart=5000 "Time to start tracking power profiles";
    parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
    parameter SI.Power W_IP_nom(displayUnit="MW") = 69.62449e6
      "Nominal electrical power consumption in the IP";
    final parameter SI.Power W_IP_max(displayUnit="MW") = W_IP_nom*1.05
      "Maximum electrical power consumption in the IP";
    parameter SI.Power W_IP_min(displayUnit="MW") = 31.777966e6
      "Minimum electrical power consumption in the IP";

    input SI.Power W_totalSetpoint "Total setpoint power" annotation(Dialog(group="Inputs"));

    Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
                     annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={70,0})));
    Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=delayStart)
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
    Modelica.Blocks.Logical.Switch switch
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    Modelica.Blocks.Sources.Constant W_IP_nominal(k=W_IP_nom)
      annotation (Placement(transformation(extent={{-20,10},{0,30}})));
    Modelica.Blocks.Math.Gain scaler(k=1/capacityScaler)
      annotation (Placement(transformation(extent={{-14,-26},{-2,-14}})));
    Modelica.Blocks.Sources.RealExpression W_totalSetpoint_IP(y=W_totalSetpoint)
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  equation

    connect(actuatorBus.subBus_IP.HTSE.W_IP, limiter_W_IP.y) annotation (Line(
        points={{30,-100},{64,-100},{100,-100},{100,-1.33227e-15},{81,-1.33227e-15}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(limiter_W_IP.u, switch.y)
      annotation (Line(points={{58,0},{58,0},{41,0}},       color={0,0,127}));
    connect(lessThreshold.y, switch.u2)
      annotation (Line(points={{-29,0},{18,0}},     color={255,0,255}));
    connect(clock.y, lessThreshold.u)
      annotation (Line(points={{-69,0},{-58,0},{-52,0}},       color={0,0,127}));
    connect(W_IP_nominal.y, switch.u1) annotation (Line(points={{1,20},{10,20},{10,
            8},{18,8}},        color={0,0,127}));
    connect(scaler.y, switch.u3) annotation (Line(points={{-1.4,-20},{10,-20},{10,
            -8},{18,-8}},   color={0,0,127}));
    connect(W_totalSetpoint_IP.y, scaler.u) annotation (Line(points={{-39,-40},{
            -28,-40},{-28,-20},{-15.2,-20}}, color={0,0,127}));
  annotation(defaultComponentName="CS");
  end CS_LooselyCoupled;

  model CS_LooselyCoupled_stepInput
    extends
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

    parameter Real capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
    parameter SI.Power W_IP_nom(displayUnit="MW") = 69.62449e6
      "Nominal electrical power consumption in the IP";
    final parameter SI.Power W_IP_max(displayUnit="MW") = W_IP_nom*1.05
      "Maximum electrical power consumption in the IP";
    parameter SI.Power W_IP_min(displayUnit="MW") = 31.777966e6
      "Minimum electrical power consumption in the IP";

    Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
                     annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={30,0})));
    Modelica.Blocks.Math.Gain scaler(k=1/capacityScaler)
      annotation (Placement(transformation(extent={{-12,-6},{0,6}})));
    Modelica.Blocks.Sources.Ramp W_IP_setPoint(
      duration=0,
      startTime=100,
      offset=(9.10627*1e6*5 + 24093140)*capacityScaler,
      height=(-1.929*1e6*5*1 - 291560*1 - 3037180*0 - 8911524*0)*capacityScaler)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  equation

    connect(actuatorBus.subBus_IP.HTSE.W_IP, limiter_W_IP.y) annotation (Line(
        points={{30,-100},{64,-100},{100,-100},{100,-1.33227e-15},{41,
            -1.33227e-15}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(scaler.y, limiter_W_IP.u)
      annotation (Line(points={{0.6,0},{0.6,0},{18,0}},       color={0,0,127}));
    connect(W_IP_setPoint.y, scaler.u)
      annotation (Line(points={{-39,0},{-13.2,0}},     color={0,0,127}));
  annotation(defaultComponentName="CS");
  end CS_LooselyCoupled_stepInput;

  model CS_Dummy
    extends
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

    extends Icons.DummyIcon;
  annotation(defaultComponentName="CS");
  end CS_Dummy;

  model ED_Dummy

    extends
      IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_EventDriver;

    extends NHES.Icons.DummyIcon;

  equation

  annotation(defaultComponentName="PHS_CS");
  end ED_Dummy;
end ControlSystems;
