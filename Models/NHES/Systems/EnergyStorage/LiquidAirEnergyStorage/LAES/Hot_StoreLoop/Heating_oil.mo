within NHES.Systems.EnergyStorage.LiquidAirEnergyStorage.LAES.Hot_StoreLoop;
model Heating_oil "Test to show Expansion from a Liquid Air system works"
  import LAES_INL =
         NHES.Systems.EnergyStorage.LiquidAirEnergyStorage;
  extends Modelica.Icons.Example;

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p=100000,
    T(displayUnit="K") = 288,
    nPorts=1) annotation (Placement(transformation(extent={{104,-12},{84,8}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_m_flow_in=false,
    m_flow=90.81,
    T=561.15,
    nPorts=1) annotation (Placement(transformation(extent={{-102,-12},{-82,8}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-90,-44},{-70,-64}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(Q_flow(
        displayUnit="MW") = 2000000)
    annotation (Placement(transformation(extent={{-24,60},{-4,80}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary3(Q_flow(
        displayUnit="MW") = 2000000)
    annotation (Placement(transformation(extent={{-26,-86},{-6,-66}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      allowFlowReversal=false)
    annotation (Placement(transformation(extent={{22,62},{42,82}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T3(redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      allowFlowReversal=false)
    annotation (Placement(transformation(extent={{24,-50},{44,-70}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.05,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=1000, m_flow_nominal=90),
    m_flow_start=90)
    annotation (Placement(transformation(extent={{-72,-12},{-52,8}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.05,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=1000, m_flow_nominal=90),
    m_flow_start=90)
    annotation (Placement(transformation(extent={{56,-12},{76,8}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.05,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=1000, m_flow_nominal=90),
    m_flow_start=45,
    use_HeatTransfer=true)
    annotation (Placement(transformation(extent={{-10,32},{10,52}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe3(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    length=1,
    diameter=0.05,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=1000, m_flow_nominal=90),
    m_flow_start=45,
    use_HeatTransfer=true)
    annotation (Placement(transformation(extent={{-10,-34},{10,-54}})));
  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=10000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-24})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance1(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=10000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,28})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-44})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium
      = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,26})));
equation
  connect(boundary1.ports[1], pipe.port_a)
    annotation (Line(points={{-82,-2},{-72,-2}}, color={0,127,255}));
  connect(pipe2.port_b, sensor_T2.port)
    annotation (Line(points={{10,42},{32,42},{32,62}}, color={0,127,255}));
  connect(pipe3.port_b, sensor_T3.port)
    annotation (Line(points={{10,-44},{34,-44},{34,-50}}, color={0,127,255}));
  connect(pipe1.port_b, boundary.ports[1])
    annotation (Line(points={{76,-2},{84,-2}}, color={0,127,255}));
  connect(sensor_T1.port, pipe.port_b) annotation (Line(points={{-80,-44},{-80,
          -36},{-50,-36},{-50,-6},{-52,-6},{-52,-2}}, color={0,127,255}));
  connect(boundary2.port, pipe2.heatPorts[1]) annotation (Line(points={{-4,70},
          {2,70},{2,56},{0.1,56},{0.1,46.4}}, color={191,0,0}));
  connect(boundary3.port, pipe3.heatPorts[1]) annotation (Line(points={{-6,-76},
          {0.1,-76},{0.1,-48.4}}, color={191,0,0}));
  connect(pipe.port_b, resistance1.port_a)
    annotation (Line(points={{-52,-2},{-50,-2},{-50,21}}, color={0,127,255}));
  connect(resistance1.port_b, pipe2.port_a)
    annotation (Line(points={{-50,35},{-50,42},{-10,42}}, color={0,127,255}));
  connect(pipe3.port_b, resistance.port_a)
    annotation (Line(points={{10,-44},{40,-44},{40,-31}}, color={0,127,255}));
  connect(resistance.port_b, pipe1.port_a)
    annotation (Line(points={{40,-17},{40,-2},{56,-2}}, color={0,127,255}));
  connect(pipe2.port_b, sensor_m_flow1.port_a)
    annotation (Line(points={{10,42},{40,42},{40,36}}, color={0,127,255}));
  connect(sensor_m_flow1.port_b, pipe1.port_a)
    annotation (Line(points={{40,16},{40,-2},{56,-2}}, color={0,127,255}));
  connect(pipe.port_b, sensor_m_flow.port_a) annotation (Line(points={{-52,-2},
          {-50,-2},{-50,-44},{-40,-44}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, pipe3.port_a)
    annotation (Line(points={{-20,-44},{-10,-44}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=360,
      Interval=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p>Assuming a Large tank. As the surface area to volume ratio increases the more temperature loss there will be. </p>
<p>Height = 14.6m</p>
<p>Radius = 0.436m </p>
<p>Insulation = 0.204m; ~8in</p>
<p>Wall thickness = 0.051 m</p>
</html>"));
end Heating_oil;
