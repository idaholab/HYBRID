within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis;
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
