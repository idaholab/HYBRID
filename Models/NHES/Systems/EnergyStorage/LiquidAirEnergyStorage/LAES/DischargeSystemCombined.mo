within NHES.Systems.EnergyStorage.LiquidAirEnergyStorage.LAES;
package DischargeSystemCombined
  extends Modelica.Icons.ExamplesPackage;

  model Cold_air_loop "Test to show Expansion from a Liquid Air system works"
    import LAES_INL =
           NHES.Systems.EnergyStorage.LiquidAirEnergyStorage;
    extends Modelica.Icons.Example;

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p=100000,
      T(displayUnit="K") = 288,
      nPorts=1) annotation (Placement(transformation(extent={{72,-12},{52,8}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      use_m_flow_in=false,
      m_flow=90.81,
      T=561.15,
      nPorts=1) annotation (Placement(transformation(extent={{-96,-12},{-76,8}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(Q_flow(
          displayUnit="MW") = 2000000)
      annotation (Placement(transformation(extent={{-36,6},{-16,26}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{26,12},{46,32}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
        momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance1(redeclare
        package Medium = LAES_INL.LAES.Media.AirCoolProp,               dp0=10000)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-40,-2})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium = LAES_INL.LAES.Media.AirCoolProp)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={18,-2})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = Media.AirCoolProp,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{-20,8},{0,-12}})));
  equation
    connect(resistance1.port_b, volume.port_a)
      annotation (Line(points={{-33,-2},{-16,-2}}, color={0,127,255}));
    connect(volume.port_b, sensor_m_flow1.port_a)
      annotation (Line(points={{-4,-2},{8,-2}}, color={0,127,255}));
    connect(sensor_m_flow1.port_b, boundary.ports[1])
      annotation (Line(points={{28,-2},{52,-2}}, color={0,127,255}));
    connect(boundary1.ports[1], resistance1.port_a)
      annotation (Line(points={{-76,-2},{-47,-2}}, color={0,127,255}));
    connect(boundary2.port, volume.heatPort)
      annotation (Line(points={{-16,16},{-10,16},{-10,4}}, color={191,0,0}));
    connect(sensor_m_flow1.port_b, sensor_T2.port)
      annotation (Line(points={{28,-2},{36,-2},{36,12}}, color={0,127,255}));
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
  end Cold_air_loop;

  model Discharge_Trainplusoil
    "Test to show Expansion from a Liquid Air system works"
    import LAES_INL =
           NHES.Systems.EnergyStorage.LiquidAirEnergyStorage;
    extends Modelica.Icons.Example;

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p=100000,
      T=78.15,
      nPorts=1) annotation (Placement(transformation(extent={{-78,14},{-58,34}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      m_flow=-201,
      h=1e5,
      nPorts=1) annotation (Placement(transformation(extent={{130,-54},{110,-34}})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster pump(redeclare package Medium
        = LAES_INL.LAES.Media.AirCoolProp, p_nominal=7500000)
      annotation (Placement(transformation(extent={{-38,14},{-18,34}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-18,34},{2,54}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
          Media.AirCoolProp, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
      annotation (Placement(transformation(extent={{-14,14},{6,-6}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume evaporator(
      redeclare package Medium = Media.AirCoolProp,
      p_start=pump.p_nominal,
      T_start=75.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{2,36},{22,16}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(use_port=
          true, Q_flow(displayUnit="MW") = 15000000)
      annotation (Placement(transformation(extent={{-12,48},{8,68}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume recuperator(
      redeclare package Medium = Media.AirCoolProp,
      p_start=evaporator.p_start,
      T_start=evaporator.T_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{28,36},{48,16}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary3(use_port=
          true, Q_flow(displayUnit="MW") = 15000000)
      annotation (Placement(transformation(extent={{12,62},{32,82}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{16,34},{36,54}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T3(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{48,34},{68,54}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume superheater(
      redeclare package Medium = Media.AirCoolProp,
      p_start=evaporator.p_start,
      T_start=evaporator.T_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{66,36},{86,16}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary4(use_port=
          true, Q_flow(displayUnit="MW") = 15000000)
      annotation (Placement(transformation(extent={{52,58},{72,78}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T4(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{82,34},{102,54}})));
    Modelica.Blocks.Sources.RealExpression dischargeheaters(y=53e6)
      annotation (Placement(transformation(extent={{-66,104},{-46,124}})));
    NHES.GasTurbine.Turbine.Turbine turbine(
      redeclare package Medium = Media.AirCoolProp,
      eta0=0.70,
      PR0=3.6,
      w0=201) annotation (Placement(transformation(extent={{-74,-62},{-54,-42}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T5(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-56,-50},{-36,-70}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
          Media.AirCoolProp, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
      annotation (Placement(transformation(extent={{-56,-40},{-36,-20}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume superheater1(
      redeclare package Medium = Media.AirCoolProp,
      p_start=evaporator.p_start,
      T_start=evaporator.T_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{-40,-54},{-20,-34}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary5(use_port=
          false, Q_flow(displayUnit="MW") = 15000000)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-29,-67})));
    NHES.GasTurbine.Turbine.Turbine turbine1(
      redeclare package Medium = Media.AirCoolProp,
      eta0=0.70,
      PR0=3.6,
      w0=201) annotation (Placement(transformation(extent={{-6,-62},{14,-42}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T6(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-20,-58},{0,-78}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p2(
      redeclare package Medium = Media.AirCoolProp,
      precision=3,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
      annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T7(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{10,-54},{30,-74}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume superheater2(
      redeclare package Medium = Media.AirCoolProp,
      p_start=evaporator.p_start,
      T_start=evaporator.T_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{30,-54},{50,-34}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary6(use_port=
          false, Q_flow(displayUnit="MW") = 15000000)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={41,-67})));
    NHES.GasTurbine.Turbine.Turbine turbine2(
      redeclare package Medium = Media.AirCoolProp,
      eta0=0.70,
      PR0=3.6,
      w0=201) annotation (Placement(transformation(extent={{64,-62},{84,-42}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T9(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{50,-58},{70,-78}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p3(
      redeclare package Medium = Media.AirCoolProp,
      precision=3,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
      annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T10(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{80,-54},{100,-74}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T8(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(extent={{178,92},{198,72}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary7(use_port=
          true, Q_flow(displayUnit="MW") = -2000000)
      annotation (Placement(transformation(extent={{242,218},{262,238}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary8(use_port=
          true, Q_flow(displayUnit="MW") = -2000000)
      annotation (Placement(transformation(extent={{242,46},{262,66}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T11(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{292,220},{312,240}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T12(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{292,68},{312,48}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=200000,
      p_b_start=190000,
      m_flow_start=90)
      annotation (Placement(transformation(extent={{168,124},{188,144}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=180000,
      p_b_start=170000,
      m_flow_start=90)
      annotation (Placement(transformation(extent={{314,124},{334,144}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          useUpstreamScheme=false,
          dp_nominal=1000,
          m_flow_nominal=90),
      p_a_start=190000,
      p_b_start=180000,
      m_flow_start=30,
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{254,190},{274,210}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=190000,
      p_b_start=180000,
      m_flow_start=30,
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{258,84},{278,64}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
        momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
      annotation (Placement(transformation(extent={{-80,438},{-60,458}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=
          10000)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={308,94})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={238,74})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary9(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      use_T_in=false,
      m_flow=90,
      T(displayUnit="K") = 644,
      nPorts=1)
      annotation (Placement(transformation(extent={{124,124},{144,144}})));
    TRANSFORM.Fluid.Volumes.ExpansionTank Cold_Tank(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      A=10,
      allowFlowReversal=true,
      p_start=system.p_start,
      level_start=5)
      annotation (Placement(transformation(extent={{368,184},{386,202}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary10(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      use_T_in=true,
      m_flow=90,
      T=288.15,
      nPorts=1) annotation (Placement(transformation(extent={{336,164},{356,184}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary11(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      p=100000,
      T(displayUnit="K") = 288,
      nPorts=1) annotation (Placement(transformation(extent={{424,124},{404,144}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T13(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{360,140},{340,160}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={364,134})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary12(use_port=
          true, Q_flow(displayUnit="MW") = -2000000)
      annotation (Placement(transformation(extent={{238,106},{258,126}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe4(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=190000,
      p_b_start=180000,
      m_flow_start=30,
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{254,144},{274,124}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={226,134})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={228,200})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance1(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=
          10000)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={290,134})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance2(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=
          10000)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={308,172})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T14(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{268,128},{288,108}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T15(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(extent={{10,310},{30,290}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary13(Q_flow(
          displayUnit="MW") = 2000000)
      annotation (Placement(transformation(extent={{74,414},{94,434}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary14(Q_flow(
          displayUnit="MW") = 2000000)
      annotation (Placement(transformation(extent={{74,268},{94,288}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T16(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{122,416},{142,436}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T17(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{124,304},{144,284}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe5(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=200000,
      p_b_start=190000,
      m_flow_start=90)
      annotation (Placement(transformation(extent={{24,342},{44,362}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe6(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=180000,
      p_b_start=170000,
      m_flow_start=90)
      annotation (Placement(transformation(extent={{146,342},{166,362}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe7(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          useUpstreamScheme=false,
          dp_nominal=1000,
          m_flow_nominal=90),
      p_a_start=190000,
      p_b_start=180000,
      m_flow_start=45,
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{90,386},{110,406}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe8(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=190000,
      p_b_start=180000,
      m_flow_start=45,
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{90,320},{110,300}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance3(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=
          10000)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={140,330})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance4(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=
          10000)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={50,382})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow4(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={70,310})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow5(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={140,380})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary15(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      m_flow=90,
      T=288.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-10,342},{10,362}})));
    TRANSFORM.Fluid.Volumes.ExpansionTank Hot_Tank(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      A=10,
      allowFlowReversal=true,
      p_start=system.p_start,
      level_start=5)
      annotation (Placement(transformation(extent={{200,402},{220,422}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary16(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      use_T_in=true,
      m_flow=90,
      T=288.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{168,382},{188,402}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary17(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      p=100000,
      T(displayUnit="K") = 288,
      nPorts=1) annotation (Placement(transformation(extent={{242,342},{222,362}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T18(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{192,358},{172,378}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow6(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={196,352})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary18(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      use_T_in=false,
      m_flow=-90,
      T=288.15,
      nPorts=1) annotation (Placement(transformation(extent={{266,384},{246,404}})));
    Modelica.Blocks.Sources.RealExpression HotTankDemand(y=-274)
      annotation (Placement(transformation(extent={{306,384},{286,404}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=-HotTankDemand.y)
      annotation (Placement(transformation(extent={{84,132},{104,152}})));
    Modelica.Blocks.Sources.RealExpression ColdTankDemand(y=-274)
      annotation (Placement(transformation(extent={{314,202},{334,222}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary19(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      use_T_in=false,
      m_flow=-90,
      T=288.15,
      nPorts=1) annotation (Placement(transformation(extent={{346,206},{366,226}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=-ColdTankDemand.y)
      annotation (Placement(transformation(extent={{-36,368},{-16,388}})));
    Modelica.Blocks.Sources.RealExpression dischargeheater_match(y=-
          dischargeheaters.y)
      annotation (Placement(transformation(extent={{166,158},{186,178}})));
  equation
    connect(boundary.ports[1], pump.port_a)
      annotation (Line(points={{-58,24},{-38,24}}, color={0,127,255}));
    connect(sensor_T1.port, pump.port_b)
      annotation (Line(points={{-8,34},{-8,24},{-18,24}},   color={0,127,255}));
    connect(pump.port_b, sensor_p.port)
      annotation (Line(points={{-18,24},{-4,24},{-4,14}},   color={0,127,255}));
    connect(boundary2.port, evaporator.heatPort)
      annotation (Line(points={{8,58},{12,58},{12,32}},   color={191,0,0}));
    connect(pump.port_b, evaporator.port_a) annotation (Line(points={{-18,24},{
            -2,24},{-2,26},{6,26}},     color={0,127,255}));
    connect(boundary3.port, recuperator.heatPort)
      annotation (Line(points={{32,72},{38,72},{38,32}}, color={191,0,0}));
    connect(evaporator.port_b, recuperator.port_a)
      annotation (Line(points={{18,26},{32,26}}, color={0,127,255}));
    connect(sensor_T3.port, recuperator.port_b)
      annotation (Line(points={{58,34},{58,26},{44,26}}, color={0,127,255}));
    connect(sensor_T2.port, evaporator.port_b)
      annotation (Line(points={{26,34},{26,26},{18,26}},
                                                      color={0,127,255}));
    connect(boundary4.port, superheater.heatPort)
      annotation (Line(points={{72,68},{76,68},{76,32}}, color={191,0,0}));
    connect(recuperator.port_b, superheater.port_a)
      annotation (Line(points={{44,26},{70,26}}, color={0,127,255}));
    connect(sensor_T4.port, superheater.port_b)
      annotation (Line(points={{92,34},{92,26},{82,26}}, color={0,127,255}));
    connect(dischargeheaters.y, boundary2.Q_flow_ext) annotation (Line(points={
            {-45,114},{-16,114},{-16,72},{-6,72},{-6,58}}, color={0,0,127}));
    connect(dischargeheaters.y, boundary3.Q_flow_ext) annotation (Line(points={
            {-45,114},{8,114},{8,80},{18,80},{18,72}}, color={0,0,127}));
    connect(dischargeheaters.y, boundary4.Q_flow_ext) annotation (Line(points={
            {-45,114},{8,114},{8,88},{44,88},{44,68},{58,68}}, color={0,0,127}));
    connect(superheater.port_b, turbine.inlet) annotation (Line(points={{82,26},
            {82,-16},{-76,-16},{-76,-44},{-70,-44}},
                                                  color={0,127,255}));
    connect(turbine.outlet, sensor_T5.port) annotation (Line(points={{-58,-44},
            {-46,-44},{-46,-50}},color={0,127,255}));
    connect(sensor_p1.port, turbine.outlet) annotation (Line(points={{-46,-40},
            {-46,-44},{-58,-44}},color={0,127,255}));
    connect(turbine.outlet, superheater1.port_a)
      annotation (Line(points={{-58,-44},{-36,-44}}, color={0,127,255}));
    connect(boundary5.port, superheater1.heatPort)
      annotation (Line(points={{-29,-60},{-30,-60},{-30,-50}}, color={191,0,0}));
    connect(superheater1.port_b, turbine1.inlet)
      annotation (Line(points={{-24,-44},{-2,-44}},  color={0,127,255}));
    connect(superheater1.port_b, sensor_T6.port) annotation (Line(points={{-24,-44},
            {-10,-44},{-10,-58}},      color={0,127,255}));
    connect(turbine1.outlet, sensor_p2.port)
      annotation (Line(points={{10,-44},{20,-44},{20,-40}},
                                                          color={0,127,255}));
    connect(sensor_p2.port, sensor_T7.port)
      annotation (Line(points={{20,-40},{20,-54}},
                                                 color={0,127,255}));
    connect(boundary6.port, superheater2.heatPort)
      annotation (Line(points={{41,-60},{40,-60},{40,-50}}, color={191,0,0}));
    connect(superheater2.port_b, turbine2.inlet)
      annotation (Line(points={{46,-44},{68,-44}}, color={0,127,255}));
    connect(superheater2.port_b, sensor_T9.port)
      annotation (Line(points={{46,-44},{60,-44},{60,-58}}, color={0,127,255}));
    connect(turbine2.outlet, sensor_p3.port)
      annotation (Line(points={{80,-44},{90,-44},{90,-40}}, color={0,127,255}));
    connect(sensor_p3.port, sensor_T10.port)
      annotation (Line(points={{90,-40},{90,-54}}, color={0,127,255}));
    connect(turbine1.outlet, superheater2.port_a)
      annotation (Line(points={{10,-44},{34,-44}}, color={0,127,255}));
    connect(turbine2.outlet, boundary1.ports[1])
      annotation (Line(points={{80,-44},{110,-44}},color={0,127,255}));
    connect(pipe2.port_b, sensor_T11.port) annotation (Line(points={{274,200},{
            302,200},{302,220}}, color={0,127,255}));
    connect(pipe3.port_b, sensor_T12.port) annotation (Line(points={{278,74},{
            302,74},{302,68}}, color={0,127,255}));
    connect(boundary7.port,pipe2. heatPorts[1]) annotation (Line(points={{262,228},
            {266,228},{266,212},{264.1,212},{264.1,204.4}},
                                                    color={191,0,0}));
    connect(boundary8.port,pipe3. heatPorts[1]) annotation (Line(points={{262,56},
            {268.1,56},{268.1,69.6}},
                                    color={191,0,0}));
    connect(pipe3.port_b,resistance. port_a)
      annotation (Line(points={{278,74},{308,74},{308,87}}, color={0,127,255}));
    connect(resistance.port_b,pipe1. port_a)
      annotation (Line(points={{308,101},{308,134},{314,134}},
                                                          color={0,127,255}));
    connect(sensor_m_flow.port_b,pipe3. port_a)
      annotation (Line(points={{248,74},{258,74}},   color={0,127,255}));
    connect(pipe.port_a, boundary9.ports[1])
      annotation (Line(points={{168,134},{144,134}}, color={0,127,255}));
    connect(pipe1.port_b, sensor_T13.port) annotation (Line(points={{334,134},{
            348,134},{348,140},{350,140}}, color={0,127,255}));
    connect(sensor_T13.T, boundary10.T_in) annotation (Line(points={{344,150},{
            328,150},{328,178},{334,178}}, color={0,0,127}));
    connect(pipe1.port_b,sensor_m_flow2. port_a)
      annotation (Line(points={{334,134},{354,134}},
                                                 color={0,127,255}));
    connect(sensor_m_flow2.port_b, boundary11.ports[1])
      annotation (Line(points={{374,134},{404,134}}, color={0,127,255}));
    connect(sensor_m_flow2.m_flow, boundary10.m_flow_in) annotation (Line(
          points={{364,137.6},{364,164},{322,164},{322,182},{336,182}}, color={
            0,0,127}));
    connect(boundary12.port, pipe4.heatPorts[1]) annotation (Line(points={{258,
            116},{264.1,116},{264.1,129.6}}, color={191,0,0}));
    connect(pipe.port_b,sensor_m_flow. port_a) annotation (Line(points={{188,134},
            {202,134},{202,74},{228,74}},  color={0,127,255}));
    connect(pipe.port_b,sensor_m_flow3. port_a)
      annotation (Line(points={{188,134},{216,134}},
                                                   color={0,127,255}));
    connect(sensor_m_flow3.port_b,pipe4. port_a)
      annotation (Line(points={{236,134},{254,134}},
                                                   color={0,127,255}));
    connect(sensor_m_flow1.port_b,pipe2. port_a)
      annotation (Line(points={{238,200},{254,200}},
                                                   color={0,127,255}));
    connect(pipe.port_b,sensor_m_flow1. port_a) annotation (Line(points={{188,134},
            {202,134},{202,200},{218,200}},
                                         color={0,127,255}));
    connect(pipe2.port_b,resistance2. port_a)
      annotation (Line(points={{274,200},{308,200},{308,179}},
                                                        color={0,127,255}));
    connect(resistance2.port_b,pipe1. port_a)
      annotation (Line(points={{308,165},{308,134},{314,134}},
                                                         color={0,127,255}));
    connect(sensor_T8.port,pipe. port_b) annotation (Line(points={{188,92},{188,
            120},{202,120},{202,134},{188,134}},
                                               color={0,127,255}));
    connect(sensor_T14.port, pipe4.port_b) annotation (Line(points={{278,128},{
            278,134},{274,134}}, color={0,127,255}));
    connect(pipe4.port_b,resistance1. port_a)
      annotation (Line(points={{274,134},{283,134}},
                                                color={0,127,255}));
    connect(resistance1.port_b,pipe1. port_a)
      annotation (Line(points={{297,134},{314,134}},
                                                 color={0,127,255}));
    connect(pipe7.port_b, sensor_T16.port) annotation (Line(points={{110,396},{
            132,396},{132,416}}, color={0,127,255}));
    connect(pipe8.port_b, sensor_T17.port) annotation (Line(points={{110,310},{
            134,310},{134,304}}, color={0,127,255}));
    connect(sensor_T15.port, pipe5.port_b) annotation (Line(points={{20,310},{
            20,318},{50,318},{50,352},{44,352}}, color={0,127,255}));
    connect(boundary13.port, pipe7.heatPorts[1]) annotation (Line(points={{94,
            424},{100,424},{100,410},{100.1,410},{100.1,400.4}}, color={191,0,0}));
    connect(boundary14.port, pipe8.heatPorts[1]) annotation (Line(points={{94,
            278},{100.1,278},{100.1,305.6}}, color={191,0,0}));
    connect(pipe5.port_b,resistance4. port_a) annotation (Line(points={{44,352},
            {50,352},{50,375}},     color={0,127,255}));
    connect(resistance4.port_b,pipe7. port_a) annotation (Line(points={{50,389},
            {50,396},{90,396}},     color={0,127,255}));
    connect(pipe8.port_b,resistance3. port_a) annotation (Line(points={{110,310},
            {140,310},{140,323}},   color={0,127,255}));
    connect(resistance3.port_b,pipe6. port_a) annotation (Line(points={{140,337},
            {140,352},{146,352}},   color={0,127,255}));
    connect(pipe7.port_b,sensor_m_flow5. port_a) annotation (Line(points={{110,396},
            {140,396},{140,390}},        color={0,127,255}));
    connect(sensor_m_flow5.port_b,pipe6. port_a) annotation (Line(points={{140,370},
            {140,352},{146,352}},        color={0,127,255}));
    connect(pipe5.port_b,sensor_m_flow4. port_a) annotation (Line(points={{44,352},
            {50,352},{50,310},{60,310}},            color={0,127,255}));
    connect(sensor_m_flow4.port_b,pipe8. port_a)
      annotation (Line(points={{80,310},{90,310}},     color={0,127,255}));
    connect(pipe5.port_a, boundary15.ports[1])
      annotation (Line(points={{24,352},{10,352}}, color={0,127,255}));
    connect(pipe6.port_b, sensor_T18.port) annotation (Line(points={{166,352},{
            180,352},{180,358},{182,358}}, color={0,127,255}));
    connect(sensor_T18.T, boundary16.T_in) annotation (Line(points={{176,368},{
            160,368},{160,396},{166,396}}, color={0,0,127}));
    connect(pipe6.port_b,sensor_m_flow6. port_a)
      annotation (Line(points={{166,352},{186,352}}, color={0,127,255}));
    connect(sensor_m_flow6.port_b,boundary17. ports[1])
      annotation (Line(points={{206,352},{222,352}}, color={0,127,255}));
    connect(sensor_m_flow6.m_flow, boundary16.m_flow_in) annotation (Line(
          points={{196,355.6},{196,382},{154,382},{154,400},{168,400}}, color={
            0,0,127}));
    connect(boundary16.ports[1], Hot_Tank.port_a) annotation (Line(points={{188,
            392},{200,392},{200,406},{203,406}}, color={0,127,255}));
    connect(boundary18.ports[1],Hot_Tank. port_b) annotation (Line(points={{246,394},
            {222,394},{222,406},{217,406}},      color={0,127,255}));
    connect(realExpression1.y, boundary9.m_flow_in)
      annotation (Line(points={{105,142},{124,142}}, color={0,0,127}));
    connect(HotTankDemand.y,boundary18. m_flow_in) annotation (Line(points={{285,394},
            {276,394},{276,402},{266,402}},   color={0,0,127}));
    connect(boundary10.ports[1], Cold_Tank.port_a) annotation (Line(points={{
            356,174},{364,174},{364,187.6},{370.7,187.6}}, color={0,127,255}));
    connect(Cold_Tank.port_b,boundary19. ports[1]) annotation (Line(points={{383.3,
            187.6},{390,187.6},{390,216},{366,216}},  color={0,127,255}));
    connect(ColdTankDemand.y,boundary19. m_flow_in) annotation (Line(points={{335,212},
            {338,212},{338,224},{346,224}},
                                          color={0,0,127}));
    connect(boundary15.m_flow_in, realExpression2.y) annotation (Line(points={{
            -10,360},{-10,370},{-8,370},{-8,378},{-15,378}}, color={0,0,127}));
    connect(dischargeheater_match.y, boundary7.Q_flow_ext) annotation (Line(
          points={{187,168},{192,168},{192,228},{248,228}}, color={0,0,127}));
    connect(dischargeheater_match.y, boundary12.Q_flow_ext) annotation (Line(
          points={{187,168},{192,168},{192,116},{244,116}}, color={0,0,127}));
    connect(dischargeheater_match.y, boundary8.Q_flow_ext) annotation (Line(
          points={{187,168},{192,168},{192,56},{248,56}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              420,460}}), graphics={
          Text(
            extent={{276,262},{342,254}},
            textColor={28,108,200},
            textString="Hot Oil Loop",
            textStyle={TextStyle.Bold,TextStyle.UnderLine}),
          Text(
            extent={{-60,144},{6,136}},
            textColor={28,108,200},
            textStyle={TextStyle.Bold,TextStyle.UnderLine},
            textString="LAES Discharge Loop"),
          Text(
            extent={{90,454},{156,446}},
            textColor={28,108,200},
            textStyle={TextStyle.Bold,TextStyle.UnderLine},
            textString="Cold Oil Loop")}),
      experiment(
        StopTime=18000,
        Interval=100,
        __Dymola_Algorithm="Esdirk45a"),
      __Dymola_experimentSetupOutput(events=false),
      Documentation(info="<html>
<p>Assuming a Large tank. As the surface area to volume ratio increases the more temperature loss there will be. </p>
<p>Height = 14.6m</p>
<p>Radius = 0.436m </p>
<p>Insulation = 0.204m; ~8in</p>
<p>Wall thickness = 0.051 m</p>
</html>"),
      Icon(coordinateSystem(extent={{-100,-100},{420,460}})));
  end Discharge_Trainplusoil;

  model Discharge_Trainplusoil_connected
    "Test to show Expansion from a Liquid Air system works"
    import LAES_INL =
           NHES.Systems.EnergyStorage.LiquidAirEnergyStorage;
    extends Modelica.Icons.Example;

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p=100000,
      T=78.15,
      nPorts=1) annotation (Placement(transformation(extent={{42,8},{62,28}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      m_flow=-201,
      h=1e5,
      nPorts=1) annotation (Placement(transformation(extent={{250,-60},{230,-40}})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster pump(redeclare package Medium
        = LAES_INL.LAES.Media.AirCoolProp, p_nominal=7500000)
      annotation (Placement(transformation(extent={{82,8},{102,28}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{102,28},{122,48}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
          Media.AirCoolProp, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
      annotation (Placement(transformation(extent={{106,8},{126,-12}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume evaporator(
      redeclare package Medium = Media.AirCoolProp,
      p_start=pump.p_nominal,
      T_start=75.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{122,30},{142,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(use_port=
          true, Q_flow(displayUnit="MW") = 15000000)
      annotation (Placement(transformation(extent={{108,42},{128,62}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume recuperator(
      redeclare package Medium = Media.AirCoolProp,
      p_start=evaporator.p_start,
      T_start=evaporator.T_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{148,30},{168,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary3(use_port=
          true, Q_flow(displayUnit="MW") = 15000000)
      annotation (Placement(transformation(extent={{132,56},{152,76}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{136,28},{156,48}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T3(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{168,28},{188,48}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume superheater(
      redeclare package Medium = Media.AirCoolProp,
      p_start=evaporator.p_start,
      T_start=evaporator.T_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{186,30},{206,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary4(use_port=
          true, Q_flow(displayUnit="MW") = 15000000)
      annotation (Placement(transformation(extent={{172,52},{192,72}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T4(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{202,28},{222,48}})));
    Modelica.Blocks.Sources.RealExpression dischargeheaters(y=53e6)
      annotation (Placement(transformation(extent={{54,98},{74,118}})));
    NHES.GasTurbine.Turbine.Turbine turbine(
      redeclare package Medium = Media.AirCoolProp,
      eta0=0.70,
      PR0=3.6,
      w0=201) annotation (Placement(transformation(extent={{46,-68},{66,-48}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T5(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{64,-56},{84,-76}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
          Media.AirCoolProp, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
      annotation (Placement(transformation(extent={{64,-46},{84,-26}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume superheater1(
      redeclare package Medium = Media.AirCoolProp,
      p_start=evaporator.p_start,
      T_start=evaporator.T_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary5(use_port=
          false, Q_flow(displayUnit="MW") = 15000000)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={91,-73})));
    NHES.GasTurbine.Turbine.Turbine turbine1(
      redeclare package Medium = Media.AirCoolProp,
      eta0=0.70,
      PR0=3.6,
      w0=201) annotation (Placement(transformation(extent={{114,-68},{134,-48}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T6(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{100,-64},{120,-84}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p2(
      redeclare package Medium = Media.AirCoolProp,
      precision=3,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
      annotation (Placement(transformation(extent={{130,-46},{150,-26}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T7(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{130,-60},{150,-80}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume superheater2(
      redeclare package Medium = Media.AirCoolProp,
      p_start=evaporator.p_start,
      T_start=evaporator.T_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{150,-60},{170,-40}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary6(use_port=
          false, Q_flow(displayUnit="MW") = 15000000)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={161,-73})));
    NHES.GasTurbine.Turbine.Turbine turbine2(
      redeclare package Medium = Media.AirCoolProp,
      eta0=0.70,
      PR0=3.6,
      w0=201) annotation (Placement(transformation(extent={{184,-68},{204,-48}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T9(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{170,-64},{190,-84}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p3(
      redeclare package Medium = Media.AirCoolProp,
      precision=3,
      redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
      annotation (Placement(transformation(extent={{200,-46},{220,-26}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T10(redeclare package Medium =
          Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{200,-60},{220,-80}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T8(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(extent={{192,264},{212,244}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary7(use_port=
          true, Q_flow(displayUnit="MW") = -2000000)
      annotation (Placement(transformation(extent={{256,390},{276,410}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary8(use_port=
          true, Q_flow(displayUnit="MW") = -2000000)
      annotation (Placement(transformation(extent={{256,218},{276,238}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T11(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{306,392},{326,412}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T12(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{306,240},{326,220}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=200000,
      p_b_start=190000,
      m_flow_start=90)
      annotation (Placement(transformation(extent={{182,296},{202,316}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe1(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=180000,
      p_b_start=170000,
      m_flow_start=90)
      annotation (Placement(transformation(extent={{328,296},{348,316}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe2(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          useUpstreamScheme=false,
          dp_nominal=1000,
          m_flow_nominal=90),
      p_a_start=190000,
      p_b_start=180000,
      m_flow_start=30,
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{268,362},{288,382}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe3(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=190000,
      p_b_start=180000,
      m_flow_start=30,
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{272,256},{292,236}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
        momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
      annotation (Placement(transformation(extent={{-80,438},{-60,458}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=
          10000)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={322,266})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={252,246})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary9(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      use_T_in=false,
      m_flow=90,
      T(displayUnit="K") = 644,
      nPorts=1)
      annotation (Placement(transformation(extent={{150,296},{170,316}})));
    TRANSFORM.Fluid.Volumes.ExpansionTank Cold_Tank(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      A=10,
      allowFlowReversal=true,
      p_start=system.p_start,
      level_start=5)
      annotation (Placement(transformation(extent={{382,356},{400,374}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary10(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      use_T_in=true,
      m_flow=90,
      T=288.15,
      nPorts=1) annotation (Placement(transformation(extent={{350,336},{370,356}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary11(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      p=100000,
      T(displayUnit="K") = 288,
      nPorts=1) annotation (Placement(transformation(extent={{438,296},{418,316}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T13(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{374,312},{354,332}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={378,306})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary12(use_port=
          true, Q_flow(displayUnit="MW") = -2000000)
      annotation (Placement(transformation(extent={{252,278},{272,298}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe4(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=190000,
      p_b_start=180000,
      m_flow_start=30,
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{268,316},{288,296}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={240,306})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={242,372})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance1(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=
          10000)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={304,306})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance2(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=
          10000)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={322,344})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T14(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{282,300},{302,280}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T15(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(extent={{-200,284},{-180,264}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary13(Q_flow(
          displayUnit="MW") = 2000000)
      annotation (Placement(transformation(extent={{-136,388},{-116,408}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary14(Q_flow(
          displayUnit="MW") = 2000000)
      annotation (Placement(transformation(extent={{-136,242},{-116,262}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T16(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-88,390},{-68,410}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T17(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-86,278},{-66,258}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe5(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=200000,
      p_b_start=190000,
      m_flow_start=90)
      annotation (Placement(transformation(extent={{-186,316},{-166,336}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe6(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=180000,
      p_b_start=170000,
      m_flow_start=90)
      annotation (Placement(transformation(extent={{-64,316},{-44,336}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe7(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          useUpstreamScheme=false,
          dp_nominal=1000,
          m_flow_nominal=90),
      p_a_start=190000,
      p_b_start=180000,
      m_flow_start=45,
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{-120,360},{-100,380}})));
    Modelica.Fluid.Pipes.DynamicPipe pipe8(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      length=1,
      diameter=0.05,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=1000, m_flow_nominal=90),
      p_a_start=190000,
      p_b_start=180000,
      m_flow_start=45,
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{-120,294},{-100,274}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance3(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=
          10000)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-70,304})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance4(redeclare
        package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, dp0=
          10000)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-160,356})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow4(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-140,284})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow5(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-70,354})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary15(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      m_flow=90,
      T=288.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-220,316},{-200,336}})));
    TRANSFORM.Fluid.Volumes.ExpansionTank Hot_Tank(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      A=10,
      allowFlowReversal=true,
      p_start=system.p_start,
      level_start=5)
      annotation (Placement(transformation(extent={{-10,376},{10,396}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary16(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      use_T_in=true,
      m_flow=90,
      T=288.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-42,356},{-22,376}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary17(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      p=100000,
      T(displayUnit="K") = 288,
      nPorts=1) annotation (Placement(transformation(extent={{32,316},{12,336}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T18(redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-18,332},{-38,352}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow6(redeclare package
        Medium = TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-14,326})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary18(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      use_T_in=false,
      m_flow=-90,
      T=288.15,
      nPorts=1) annotation (Placement(transformation(extent={{56,358},{36,378}})));
    Modelica.Blocks.Sources.RealExpression HotTankDemand(y=-274)
      annotation (Placement(transformation(extent={{96,358},{76,378}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=-HotTankDemand.y)
      annotation (Placement(transformation(extent={{112,264},{132,284}})));
    Modelica.Blocks.Sources.RealExpression ColdTankDemand(y=-274)
      annotation (Placement(transformation(extent={{328,374},{348,394}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary19(
      redeclare package Medium =
          TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
      use_m_flow_in=true,
      use_T_in=false,
      m_flow=-90,
      T=288.15,
      nPorts=1) annotation (Placement(transformation(extent={{360,378},{380,398}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=-ColdTankDemand.y)
      annotation (Placement(transformation(extent={{-246,342},{-226,362}})));
    Modelica.Blocks.Sources.RealExpression dischargeheater_match(y=-
          dischargeheaters.y)
      annotation (Placement(transformation(extent={{180,330},{200,350}})));
    NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase nTU_HX_SinglePhase
      annotation (Placement(transformation(extent={{-66,142},{-46,162}})));
  equation
    connect(boundary.ports[1], pump.port_a)
      annotation (Line(points={{62,18},{82,18}},   color={0,127,255}));
    connect(sensor_T1.port, pump.port_b)
      annotation (Line(points={{112,28},{112,18},{102,18}}, color={0,127,255}));
    connect(pump.port_b, sensor_p.port)
      annotation (Line(points={{102,18},{116,18},{116,8}},  color={0,127,255}));
    connect(boundary2.port, evaporator.heatPort)
      annotation (Line(points={{128,52},{132,52},{132,26}},
                                                          color={191,0,0}));
    connect(pump.port_b, evaporator.port_a) annotation (Line(points={{102,18},{
            118,18},{118,20},{126,20}}, color={0,127,255}));
    connect(boundary3.port, recuperator.heatPort)
      annotation (Line(points={{152,66},{158,66},{158,26}}, color={191,0,0}));
    connect(evaporator.port_b, recuperator.port_a)
      annotation (Line(points={{138,20},{152,20}}, color={0,127,255}));
    connect(sensor_T3.port, recuperator.port_b) annotation (Line(points={{178,
            28},{178,20},{164,20}}, color={0,127,255}));
    connect(sensor_T2.port, evaporator.port_b)
      annotation (Line(points={{146,28},{146,20},{138,20}},
                                                      color={0,127,255}));
    connect(boundary4.port, superheater.heatPort)
      annotation (Line(points={{192,62},{196,62},{196,26}},
                                                         color={191,0,0}));
    connect(recuperator.port_b, superheater.port_a)
      annotation (Line(points={{164,20},{190,20}}, color={0,127,255}));
    connect(sensor_T4.port, superheater.port_b)
      annotation (Line(points={{212,28},{212,20},{202,20}},
                                                         color={0,127,255}));
    connect(dischargeheaters.y, boundary2.Q_flow_ext) annotation (Line(points={
            {75,108},{104,108},{104,66},{114,66},{114,52}}, color={0,0,127}));
    connect(dischargeheaters.y, boundary3.Q_flow_ext) annotation (Line(points={
            {75,108},{128,108},{128,74},{138,74},{138,66}}, color={0,0,127}));
    connect(dischargeheaters.y, boundary4.Q_flow_ext) annotation (Line(points={
            {75,108},{128,108},{128,82},{164,82},{164,62},{178,62}}, color={0,0,
            127}));
    connect(superheater.port_b, turbine.inlet) annotation (Line(points={{202,20},
            {202,-22},{44,-22},{44,-50},{50,-50}},color={0,127,255}));
    connect(turbine.outlet, sensor_T5.port) annotation (Line(points={{62,-50},{
            74,-50},{74,-56}},   color={0,127,255}));
    connect(sensor_p1.port, turbine.outlet) annotation (Line(points={{74,-46},{
            74,-50},{62,-50}},   color={0,127,255}));
    connect(turbine.outlet, superheater1.port_a)
      annotation (Line(points={{62,-50},{84,-50}},   color={0,127,255}));
    connect(boundary5.port, superheater1.heatPort)
      annotation (Line(points={{91,-66},{90,-66},{90,-56}},    color={191,0,0}));
    connect(superheater1.port_b, turbine1.inlet)
      annotation (Line(points={{96,-50},{118,-50}},  color={0,127,255}));
    connect(superheater1.port_b, sensor_T6.port) annotation (Line(points={{96,-50},
            {110,-50},{110,-64}},      color={0,127,255}));
    connect(turbine1.outlet, sensor_p2.port)
      annotation (Line(points={{130,-50},{140,-50},{140,-46}},
                                                          color={0,127,255}));
    connect(sensor_p2.port, sensor_T7.port)
      annotation (Line(points={{140,-46},{140,-60}},
                                                 color={0,127,255}));
    connect(boundary6.port, superheater2.heatPort)
      annotation (Line(points={{161,-66},{160,-66},{160,-56}},
                                                            color={191,0,0}));
    connect(superheater2.port_b, turbine2.inlet)
      annotation (Line(points={{166,-50},{188,-50}},
                                                   color={0,127,255}));
    connect(superheater2.port_b, sensor_T9.port)
      annotation (Line(points={{166,-50},{180,-50},{180,-64}},
                                                            color={0,127,255}));
    connect(turbine2.outlet, sensor_p3.port)
      annotation (Line(points={{200,-50},{210,-50},{210,-46}},
                                                            color={0,127,255}));
    connect(sensor_p3.port, sensor_T10.port)
      annotation (Line(points={{210,-46},{210,-60}},
                                                   color={0,127,255}));
    connect(turbine1.outlet, superheater2.port_a)
      annotation (Line(points={{130,-50},{154,-50}},
                                                   color={0,127,255}));
    connect(turbine2.outlet, boundary1.ports[1])
      annotation (Line(points={{200,-50},{230,-50}},
                                                   color={0,127,255}));
    connect(pipe2.port_b, sensor_T11.port) annotation (Line(points={{288,372},{
            316,372},{316,392}}, color={0,127,255}));
    connect(pipe3.port_b, sensor_T12.port) annotation (Line(points={{292,246},{
            316,246},{316,240}}, color={0,127,255}));
    connect(boundary7.port,pipe2. heatPorts[1]) annotation (Line(points={{276,400},
            {280,400},{280,384},{278.1,384},{278.1,376.4}},
                                                    color={191,0,0}));
    connect(boundary8.port,pipe3. heatPorts[1]) annotation (Line(points={{276,228},
            {282.1,228},{282.1,241.6}},
                                    color={191,0,0}));
    connect(pipe3.port_b,resistance. port_a)
      annotation (Line(points={{292,246},{322,246},{322,259}},
                                                            color={0,127,255}));
    connect(resistance.port_b,pipe1. port_a)
      annotation (Line(points={{322,273},{322,306},{328,306}},
                                                          color={0,127,255}));
    connect(sensor_m_flow.port_b,pipe3. port_a)
      annotation (Line(points={{262,246},{272,246}}, color={0,127,255}));
    connect(pipe.port_a, boundary9.ports[1])
      annotation (Line(points={{182,306},{170,306}}, color={0,127,255}));
    connect(pipe1.port_b, sensor_T13.port) annotation (Line(points={{348,306},{
            362,306},{362,312},{364,312}}, color={0,127,255}));
    connect(sensor_T13.T, boundary10.T_in) annotation (Line(points={{358,322},{
            342,322},{342,350},{348,350}}, color={0,0,127}));
    connect(pipe1.port_b,sensor_m_flow2. port_a)
      annotation (Line(points={{348,306},{368,306}},
                                                 color={0,127,255}));
    connect(sensor_m_flow2.port_b, boundary11.ports[1])
      annotation (Line(points={{388,306},{418,306}}, color={0,127,255}));
    connect(sensor_m_flow2.m_flow, boundary10.m_flow_in) annotation (Line(
          points={{378,309.6},{378,336},{336,336},{336,354},{350,354}}, color={
            0,0,127}));
    connect(boundary12.port, pipe4.heatPorts[1]) annotation (Line(points={{272,
            288},{278.1,288},{278.1,301.6}}, color={191,0,0}));
    connect(pipe.port_b,sensor_m_flow. port_a) annotation (Line(points={{202,306},
            {216,306},{216,246},{242,246}},color={0,127,255}));
    connect(pipe.port_b,sensor_m_flow3. port_a)
      annotation (Line(points={{202,306},{230,306}},
                                                   color={0,127,255}));
    connect(sensor_m_flow3.port_b,pipe4. port_a)
      annotation (Line(points={{250,306},{268,306}},
                                                   color={0,127,255}));
    connect(sensor_m_flow1.port_b,pipe2. port_a)
      annotation (Line(points={{252,372},{268,372}},
                                                   color={0,127,255}));
    connect(pipe.port_b,sensor_m_flow1. port_a) annotation (Line(points={{202,306},
            {216,306},{216,372},{232,372}},
                                         color={0,127,255}));
    connect(pipe2.port_b,resistance2. port_a)
      annotation (Line(points={{288,372},{322,372},{322,351}},
                                                        color={0,127,255}));
    connect(resistance2.port_b,pipe1. port_a)
      annotation (Line(points={{322,337},{322,306},{328,306}},
                                                         color={0,127,255}));
    connect(sensor_T8.port,pipe. port_b) annotation (Line(points={{202,264},{
            202,292},{216,292},{216,306},{202,306}},
                                               color={0,127,255}));
    connect(sensor_T14.port, pipe4.port_b) annotation (Line(points={{292,300},{
            292,306},{288,306}}, color={0,127,255}));
    connect(pipe4.port_b,resistance1. port_a)
      annotation (Line(points={{288,306},{297,306}},
                                                color={0,127,255}));
    connect(resistance1.port_b,pipe1. port_a)
      annotation (Line(points={{311,306},{328,306}},
                                                 color={0,127,255}));
    connect(pipe7.port_b, sensor_T16.port) annotation (Line(points={{-100,370},
            {-78,370},{-78,390}}, color={0,127,255}));
    connect(pipe8.port_b, sensor_T17.port) annotation (Line(points={{-100,284},
            {-76,284},{-76,278}}, color={0,127,255}));
    connect(sensor_T15.port, pipe5.port_b) annotation (Line(points={{-190,284},
            {-190,292},{-160,292},{-160,326},{-166,326}}, color={0,127,255}));
    connect(boundary13.port, pipe7.heatPorts[1]) annotation (Line(points={{-116,
            398},{-110,398},{-110,384},{-109.9,384},{-109.9,374.4}}, color={191,
            0,0}));
    connect(boundary14.port, pipe8.heatPorts[1]) annotation (Line(points={{-116,
            252},{-109.9,252},{-109.9,279.6}}, color={191,0,0}));
    connect(pipe5.port_b,resistance4. port_a) annotation (Line(points={{-166,
            326},{-160,326},{-160,349}},
                                    color={0,127,255}));
    connect(resistance4.port_b,pipe7. port_a) annotation (Line(points={{-160,
            363},{-160,370},{-120,370}},
                                    color={0,127,255}));
    connect(pipe8.port_b,resistance3. port_a) annotation (Line(points={{-100,
            284},{-70,284},{-70,297}},
                                    color={0,127,255}));
    connect(resistance3.port_b,pipe6. port_a) annotation (Line(points={{-70,311},
            {-70,326},{-64,326}},   color={0,127,255}));
    connect(pipe7.port_b,sensor_m_flow5. port_a) annotation (Line(points={{-100,
            370},{-70,370},{-70,364}},   color={0,127,255}));
    connect(sensor_m_flow5.port_b,pipe6. port_a) annotation (Line(points={{-70,344},
            {-70,326},{-64,326}},        color={0,127,255}));
    connect(pipe5.port_b,sensor_m_flow4. port_a) annotation (Line(points={{-166,
            326},{-160,326},{-160,284},{-150,284}}, color={0,127,255}));
    connect(sensor_m_flow4.port_b,pipe8. port_a)
      annotation (Line(points={{-130,284},{-120,284}}, color={0,127,255}));
    connect(pipe5.port_a, boundary15.ports[1])
      annotation (Line(points={{-186,326},{-200,326}}, color={0,127,255}));
    connect(pipe6.port_b, sensor_T18.port) annotation (Line(points={{-44,326},{
            -30,326},{-30,332},{-28,332}}, color={0,127,255}));
    connect(sensor_T18.T, boundary16.T_in) annotation (Line(points={{-34,342},{
            -50,342},{-50,370},{-44,370}}, color={0,0,127}));
    connect(pipe6.port_b,sensor_m_flow6. port_a)
      annotation (Line(points={{-44,326},{-24,326}}, color={0,127,255}));
    connect(sensor_m_flow6.port_b,boundary17. ports[1])
      annotation (Line(points={{-4,326},{12,326}},   color={0,127,255}));
    connect(sensor_m_flow6.m_flow, boundary16.m_flow_in) annotation (Line(
          points={{-14,329.6},{-14,356},{-56,356},{-56,374},{-42,374}}, color={
            0,0,127}));
    connect(boundary16.ports[1], Hot_Tank.port_a) annotation (Line(points={{-22,
            366},{-10,366},{-10,380},{-7,380}}, color={0,127,255}));
    connect(boundary18.ports[1],Hot_Tank. port_b) annotation (Line(points={{36,368},
            {12,368},{12,380},{7,380}},          color={0,127,255}));
    connect(realExpression1.y, boundary9.m_flow_in) annotation (Line(points={{
            133,274},{144,274},{144,288},{140,288},{140,324},{150,324},{150,314}},
          color={0,0,127}));
    connect(HotTankDemand.y,boundary18. m_flow_in) annotation (Line(points={{75,368},
            {66,368},{66,376},{56,376}},      color={0,0,127}));
    connect(boundary10.ports[1], Cold_Tank.port_a) annotation (Line(points={{
            370,346},{378,346},{378,359.6},{384.7,359.6}}, color={0,127,255}));
    connect(Cold_Tank.port_b,boundary19. ports[1]) annotation (Line(points={{397.3,
            359.6},{404,359.6},{404,388},{380,388}},  color={0,127,255}));
    connect(ColdTankDemand.y,boundary19. m_flow_in) annotation (Line(points={{349,384},
            {352,384},{352,396},{360,396}},
                                          color={0,0,127}));
    connect(boundary15.m_flow_in, realExpression2.y) annotation (Line(points={{
            -220,334},{-220,344},{-218,344},{-218,352},{-225,352}}, color={0,0,
            127}));
    connect(dischargeheater_match.y, boundary7.Q_flow_ext) annotation (Line(
          points={{201,340},{206,340},{206,400},{262,400}}, color={0,0,127}));
    connect(dischargeheater_match.y, boundary12.Q_flow_ext) annotation (Line(
          points={{201,340},{206,340},{206,288},{258,288}}, color={0,0,127}));
    connect(dischargeheater_match.y, boundary8.Q_flow_ext) annotation (Line(
          points={{201,340},{206,340},{206,228},{262,228}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              420,460}}), graphics={
          Text(
            extent={{290,434},{356,426}},
            textColor={28,108,200},
            textString="Hot Oil Loop",
            textStyle={TextStyle.Bold,TextStyle.UnderLine}),
          Text(
            extent={{60,138},{126,130}},
            textColor={28,108,200},
            textStyle={TextStyle.Bold,TextStyle.UnderLine},
            textString="LAES Discharge Loop"),
          Text(
            extent={{-120,428},{-54,420}},
            textColor={28,108,200},
            textStyle={TextStyle.Bold,TextStyle.UnderLine},
            textString="Cold Oil Loop"),
          Rectangle(
            extent={{-270,472},{478,200}},
            lineColor={0,140,72},
            lineThickness=1),
          Text(
            extent={{14,492},{120,476}},
            textColor={0,140,72},
            textString="Oil Loop",
            textStyle={TextStyle.Bold,TextStyle.UnderLine})}),
      experiment(
        StopTime=18000,
        Interval=100,
        __Dymola_Algorithm="Esdirk45a"),
      __Dymola_experimentSetupOutput(events=false),
      Documentation(info="<html>
<p>Assuming a Large tank. As the surface area to volume ratio increases the more temperature loss there will be. </p>
<p>Height = 14.6m</p>
<p>Radius = 0.436m </p>
<p>Insulation = 0.204m; ~8in</p>
<p>Wall thickness = 0.051 m</p>
</html>"),
      Icon(coordinateSystem(extent={{-100,-100},{420,460}})));
  end Discharge_Trainplusoil_connected;
end DischargeSystemCombined;
