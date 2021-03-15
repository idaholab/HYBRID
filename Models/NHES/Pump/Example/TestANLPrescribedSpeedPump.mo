within NHES.Pump.Example;
model TestANLPrescribedSpeedPump
  extends Modelica.Icons.Example;
  import ThermoPower;
  package FluidMedium = ThermoPower.Water.StandardWater;

  ThermoPower.Water.SinkPressure
              sinkToEcLP_p(h=2.440e5, p0=719000) annotation (Placement(
        transformation(extent={{60,-20},{80,0}}, rotation=0)));
  ThermoPower.Water.SourcePressure
                sourceShLP(
    redeclare package Medium = FluidMedium,
    h=1.43495e5,
    p0=5398.2)   annotation (Placement(transformation(
        origin={-70,-10},
        extent={{10,10},{-10,-10}},
        rotation=180)));
public
  Modelica.Blocks.Sources.Ramp flowRate(
    duration=100,
    offset=89.9,
    startTime=500,
    height=0) annotation (Placement(transformation(extent={{70,28},{52,46}},
          rotation=0)));
  ThermoPower.PowerPlants.Control.PID pIDController(
    CSmin=500,
    PVmin=-1,
    PVmax=1,
    CSmax=2500,
    Ti=200,
    Kp=4,
    steadyStateInit=true) annotation (Placement(transformation(
        origin={22,36},
        extent={{-10,10},{10,-10}},
        rotation=180)));
public
  Model.PumpLevel_0 pump(
    redeclare package WaterMedium = FluidMedium,
    nominalFlow=89.8,
    n0=1500,
    SSInit=true,
    rho0=1000,
    Np0=1,
    NStage=1,
    D=0.613,
    hstart=1e5,
    usePowerCharacteristic=true,
    nominalOutletPressure=719048,
    nominalInletPressure=5398.2) annotation (Placement(transformation(
        origin={-10,-10},
        extent={{10,10},{-10,-10}},
        rotation=180)));
    //feedWaterPump(redeclare function efficiencyCharacteristic =
     //ThermoPower.Functions.PumpCharacteristics.constantEfficiency (eta_nom=0.6)),

  ThermoPower.Water.SensW feed_w(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(
        origin={26,-6},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    y_start=1512,
    T=1,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (
      Placement(transformation(extent={{-4,26},{-24,46}}, rotation=0)));
  inner ThermoPower.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(flowRate.y, pIDController.SP) annotation (Line(points={{51.1,37},{42,
          37},{42,40},{32,40}}, color={0,0,127}));
  connect(feed_w.inlet, pump.outlet) annotation (Line(
      points={{20,-10},{0,-10}},
      thickness=0.5,
      color={0,0,255}));
  connect(sourceShLP.flange, pump.inlet) annotation (Line(
      points={{-60,-10},{-20,-10}},
      thickness=0.5,
      color={0,0,255}));
  connect(feed_w.outlet, sinkToEcLP_p.flange) annotation (Line(
      points={{32,-10},{60,-10}},
      thickness=0.5,
      color={0,0,255}));
  connect(pIDController.PV, feed_w.w) annotation (Line(points={{32,32},{
          40,32},{40,-8.88178e-016},{34,-8.88178e-016}}, color={0,0,127}));
  connect(pIDController.CS, firstOrder.u)
    annotation (Line(points={{12,36},{-2,36}}, color={0,0,127}));
  connect(firstOrder.y, pump.pumpSpeed_rpm) annotation (Line(points={{-25,
          36},{-40,36},{-40,-4},{-17.2,-4}}, color={0,0,127}));
end TestANLPrescribedSpeedPump;
