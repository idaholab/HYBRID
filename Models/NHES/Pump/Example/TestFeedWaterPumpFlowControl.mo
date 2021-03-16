within NHES.Pump.Example;
model TestFeedWaterPumpFlowControl
  extends Modelica.Icons.Example;
  //thermopower.powerplants.HRSG.TestsControl.TestPumpControl
  import ThermoPower;
  package FluidMedium = ThermoPower.Water.StandardWater;

  ThermoPower.Water.SinkPressure sinkP(             h=6.43e5, p0=17600000)
                                                              annotation (
      Placement(transformation(extent={{68,-26},{92,-2}},rotation=0)));
  ThermoPower.Water.SourcePressure sourceP(
    redeclare package Medium = ThermoPower.Water.StandardWater,
    h=6.33e5,
    p0=2800000)
              annotation (Placement(transformation(
        origin={-74,-14},
        extent={{14,14},{-14,-14}},
        rotation=180)));
public
  Modelica.Blocks.Sources.Constant
                               pumpMassFlowRate(k=171.2)
                  annotation (Placement(transformation(extent={{78,24},{54,48}},
          rotation=0)));
  ThermoPower.PowerPlants.Control.PID pIDController(
    PVmin=-1,
    PVmax=1,
    CSmax=2500,
    Ti=200,
    Kp=4,
    steadyStateInit=true,
    CSmin=500) annotation (Placement(transformation(
        origin={21,37},
        extent={{-13,13},{13,-13}},
        rotation=180)));
public
  Model.PumpLevel_1 pump(SSInit=true, usePowerCharacteristic=true) annotation (
      Placement(transformation(
        origin={-16,-14},
        extent={{14,14},{-14,-14}},
        rotation=180)));

  ThermoPower.Water.SensW feed_water(redeclare package Medium =
        ThermoPower.Water.StandardWater) annotation (Placement(transformation(
        origin={24,-8},
        extent={{16,16},{-16,-16}},
        rotation=180)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    T=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=1500) annotation (Placement(transformation(extent={{-10,26},{-34,50}},
          rotation=0)));
  inner ThermoPower.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(pumpMassFlowRate.y, pIDController.SP) annotation (Line(points={{52.8,
          36},{42,36},{42,42.2},{34,42.2}}, color={0,0,127}));
  connect(feed_water.inlet, pump.outlet) annotation (Line(
      points={{14.4,-14.4},{10,-14.4},{10,-14},{-4.52,-14}},
      thickness=0.5,
      color={0,0,255}));
  connect(sourceP.flange, pump.inlet) annotation (Line(
      points={{-60,-14},{-27.48,-14},{-27.48,-14.28}},
      thickness=0.5,
      color={0,0,255}));
  connect(pIDController.PV, feed_water.w) annotation (Line(points={{34,31.8},{
          40,31.8},{40,1.6},{36.8,1.6}}, color={0,0,127}));
  connect(pIDController.CS, firstOrder.u)
    annotation (Line(points={{8,37},{2,38},{-7.6,38}}, color={0,0,127}));
  connect(firstOrder.y, pump.pumpSpeed_rpm) annotation (Line(points={{-35.2,38},
          {-40,38},{-40,-5.6},{-26.08,-5.6}}, color={0,0,127}));
  connect(feed_water.outlet, sinkP.flange) annotation (Line(
      points={{33.6,-14.4},{49.8,-14.4},{49.8,-14},{68,-14}},
      color={0,0,255},
      thickness=0.5));
end TestFeedWaterPumpFlowControl;
