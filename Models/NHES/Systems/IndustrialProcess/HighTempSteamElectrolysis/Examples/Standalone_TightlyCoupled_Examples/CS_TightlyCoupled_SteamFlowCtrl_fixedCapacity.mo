within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Examples.Standalone_TightlyCoupled_Examples;
model CS_TightlyCoupled_SteamFlowCtrl_fixedCapacity
  extends
    NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.BaseClasses.Partial_ControlSystem;

  parameter Real IP_capacityScaler = 1 "Scaler that sizes the capacity of the overall system";
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
        origin={-50,50})));
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
        origin={-10,50})));
  Modelica.Blocks.Sources.Ramp TNOut_cathodeGas_set(
    duration=0,
    height=0,
    startTime=0,
    offset=283.4 + 273.15,
    y(displayUnit="degC", unit="K"))
                  annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,0})));
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
        origin={-10,0})));
  Modelica.Blocks.Nonlinear.Limiter limiter_W_IP(uMax=W_IP_max, uMin=W_IP_min)
                   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={30,-50})));
equation

  connect(FBctrl_TNOut_anodeGas.u_s,TNOut_anodeGas_set. y)
    annotation (Line(points={{-22,50},{-22,50},{-39,50}},color={0,0,127}));
  connect(TNOut_cathodeGas_set.y, FBctrl_TNOut_cathodeGas.u_s)
    annotation (Line(points={{-39,-1.33227e-015},{-39,0},{-22,0}},
                                                         color={0,0,127}));
  connect(sensorBus.TNOut_anodeGas, FBctrl_TNOut_anodeGas.u_m)
    annotation (Line(
      points={{-29.9,-99.9},{-100,-99.9},{-100,30},{-10,30},{-10,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.TNOut_cathodeGas, FBctrl_TNOut_cathodeGas.u_m)
    annotation (Line(
      points={{-29.9,-99.9},{-30,-99.9},{-30,-100},{-100,-100},{-100,-20},{-10,
          -20},{-10,-12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.subBus_IP.HTSE.TNOut_anodeGas, FBctrl_TNOut_anodeGas.y)
    annotation (Line(
      points={{30.1,-99.9},{100,-99.9},{100,50},{1,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.subBus_IP.HTSE.TNOut_cathodeGas, FBctrl_TNOut_cathodeGas.y)
    annotation (Line(
      points={{30.1,-99.9},{30.1,-100},{100,-100},{100,0},{1,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.subBus_IP.HTSE.W_IP, limiter_W_IP.y) annotation (Line(
      points={{30.1,-99.9},{64,-99.9},{100,-99.9},{100,-50},{41,-50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_totalSetpoint, limiter_W_IP.u) annotation (
     Line(
      points={{-29.9,-99.9},{-100,-99.9},{-100,-50},{18,-50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="CS");
end CS_TightlyCoupled_SteamFlowCtrl_fixedCapacity;
