within NHES.Systems.EnergyStorage.LAES.LAES;
package Charging
  extends Modelica.Icons.ExamplesPackage;

  model Liquification_Test "Test to show Liquification works across a JT Valve"
    import LAES_INL =
           NHES.Systems.EnergyStorage.LAES;
    extends Modelica.Icons.Example;

    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p=2000000,
      h=0.1e3,
      nPorts=1) annotation (Placement(transformation(extent={{-92,-16},{-72,4}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{30,2},{50,22}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      m_flow=-1,
      h=1e5,
      nPorts=1) annotation (Placement(transformation(extent={{94,-16},{74,4}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare
        package Medium = LAES_INL.LAES.Media.AirCoolProp,
                                                 dp0=1900000)
      annotation (Placement(transformation(extent={{-8,-16},{12,4}})));
  equation
    connect(boundary.ports[1], resistance.port_a)
      annotation (Line(points={{-72,-6},{-5,-6}}, color={0,127,255}));
    connect(resistance.port_b, boundary1.ports[1])
      annotation (Line(points={{9,-6},{74,-6}}, color={0,127,255}));
    connect(sensor_T1.port, resistance.port_b)
      annotation (Line(points={{40,2},{40,-6},{9,-6}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
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
</html>"));
  end Liquification_Test;

  model Liquifier_separation_test
    "Test to show how much liquification occurs JT valve and separation test"
    import LAES_INL =
           NHES.Systems.EnergyStorage.LAES;
    extends Modelica.Icons.Example;

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      use_T_in=true,
      p=19100000,
      nPorts=2) annotation (Placement(transformation(extent={{-92,-16},{-72,4}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-34,0},{-14,20}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare
        package Medium = LAES_INL.LAES.Media.AirCoolProp,
                                                 dp0=19000000)
      annotation (Placement(transformation(extent={{-56,-16},{-36,4}})));
    Components.VapourLiquidSeparator vapourLiquidSeparator(redeclare package
        Medium = LAES_INL.LAES.Media.AirCoolProp)
      annotation (Placement(transformation(extent={{6,-10},{26,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p=100000,
      h=0.1e3,
      nPorts=1) annotation (Placement(transformation(extent={{98,10},{78,30}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{26,32},{46,52}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T3(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{24,-30},{44,-50}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary3(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      m_flow=-1,
      h=1e5,
      nPorts=1) annotation (Placement(transformation(extent={{98,-34},{78,-14}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = LAES_INL.LAES.Media.AirCoolProp,
                                  precision=3)
      annotation (Placement(transformation(extent={{54,-34},{74,-14}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium = LAES_INL.LAES.Media.AirCoolProp,
                                  precision=3)
      annotation (Placement(transformation(extent={{46,8},{72,30}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=0.15*sine.offset,
      f=0.15,
      offset=153.15,
      startTime=60)
      annotation (Placement(transformation(extent={{-136,-2},{-116,18}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T4(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-70,8},{-50,28}})));
  equation
    connect(boundary.ports[1], resistance.port_a)
      annotation (Line(points={{-72,-4},{-72,-6},{-53,-6}}, color={0,127,255}));
    connect(sensor_T1.port, resistance.port_b)
      annotation (Line(points={{-24,0},{-24,-6},{-39,-6}}, color={0,127,255}));
    connect(resistance.port_b, vapourLiquidSeparator.MixIn) annotation (Line(
          points={{-39,-6},{-8,-6},{-8,2},{6,2}}, color={0,127,255}));
    connect(sensor_T2.port, vapourLiquidSeparator.VaporOut)
      annotation (Line(points={{36,32},{36,6},{26,6}}, color={0,127,255}));
    connect(sensor_T3.port, vapourLiquidSeparator.LiquidOut)
      annotation (Line(points={{34,-30},{34,-6},{26,-6}}, color={0,127,255}));
    connect(vapourLiquidSeparator.LiquidOut, sensor_m_flow.port_a) annotation (
        Line(points={{26,-6},{34,-6},{34,-24},{54,-24}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, boundary3.ports[1])
      annotation (Line(points={{74,-24},{78,-24}}, color={0,127,255}));
    connect(vapourLiquidSeparator.VaporOut, sensor_m_flow1.port_a) annotation (
        Line(points={{26,6},{36,6},{36,19},{46,19}}, color={0,127,255}));
    connect(sensor_m_flow1.port_b, boundary1.ports[1]) annotation (Line(points={{
            72,19},{76,19},{76,20},{78,20}}, color={0,127,255}));
    connect(sensor_T4.port, boundary.ports[2])
      annotation (Line(points={{-60,8},{-60,-8},{-72,-8}}, color={0,127,255}));
    connect(sine.y, boundary.T_in) annotation (Line(points={{-115,8},{-102,8},{
            -102,-2},{-94,-2}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      experiment(
        StopTime=300,
        __Dymola_NumberOfIntervals=1000,
        __Dymola_Algorithm="Esdirk45a"),
      __Dymola_experimentSetupOutput(events=false),
      Documentation(info="<html>
<p>Assuming a Large tank. As the surface area to volume ratio increases the more temperature loss there will be. </p>
<p>Height = 14.6m</p>
<p>Radius = 0.436m </p>
<p>Insulation = 0.204m; ~8in</p>
<p>Wall thickness = 0.051 m</p>
</html>"));
  end Liquifier_separation_test;

  model Liquifier_compression_test
    "Test to show how much liquification occurs JT valve and separation test"
    import LAES_INL =
           NHES.Systems.EnergyStorage.LAES;
    extends Modelica.Icons.Example;

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      use_T_in=false,
      p=109000,
      T=286.1,
      nPorts=1)
      annotation (Placement(transformation(extent={{-128,20},{-108,40}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-30,-54},{-10,-34}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare
        package Medium = LAES_INL.LAES.Media.AirCoolProp,
                                                 dp0=19000000)
      annotation (Placement(transformation(extent={{-52,-70},{-32,-50}})));
    Components.VapourLiquidSeparator vapourLiquidSeparator(redeclare package
        Medium = LAES_INL.LAES.Media.AirCoolProp)
      annotation (Placement(transformation(extent={{10,-64},{30,-44}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p=100000,
      h=0.1e3,
      nPorts=1)
      annotation (Placement(transformation(extent={{102,-44},{82,-24}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{28,-32},{48,-12}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T3(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{28,-84},{48,-104}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary3(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      m_flow=-72.86,
      h=1e5,
      nPorts=1)
      annotation (Placement(transformation(extent={{102,-88},{82,-68}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = LAES_INL.LAES.Media.AirCoolProp,
                                  precision=3)
      annotation (Placement(transformation(extent={{58,-88},{78,-68}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium = LAES_INL.LAES.Media.AirCoolProp,
                                  precision=3)
      annotation (Placement(transformation(extent={{50,-46},{76,-24}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=0.15*sine.offset,
      f=0.15,
      offset=153.15,
      startTime=60)
      annotation (Placement(transformation(extent={{-162,24},{-142,44}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T4(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-2,70},{18,90}})));
    NHES.GasTurbine.Compressor.Compressor compressor(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      explicitIsentropicEnthalpy=false,
      pstart_in=109000,
      Tstart_in=boundary.T,
      Tstart_out=677.15,
      PR0=13.1,
      w0=92.33) annotation (Placement(transformation(extent={{-90,36},{-70,56}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p_start=compressor.pstart_out,
      T_start=compressor.Tstart_out,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{-72,76},{-52,56}})));
    NHES.GasTurbine.Compressor.Compressor compressor1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      explicitIsentropicEnthalpy=false,
      pstart_in=compressor.pstart_out,
      Tstart_in=298.15,
      Tstart_out=707.15,
      PR0=13.1,
      w0=92.33) annotation (Placement(transformation(extent={{-54,38},{-34,58}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p_start=compressor1.pstart_out,
      T_start=compressor1.Tstart_out,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{-32,74},{-12,54}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(
        Q_flow(displayUnit="MW") = -38000000)
      annotation (Placement(transformation(extent={{-92,76},{-72,96}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary4(
        Q_flow(displayUnit="MW") = -45000000)
      annotation (Placement(transformation(extent={{-50,76},{-30,96}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary5(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      use_T_in=false,
      p=19100000,
      T(displayUnit="K") = 153.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-84,-68},{-64,-48}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary6(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      m_flow=-92.33,
      h=1e5,
      nPorts=1) annotation (Placement(transformation(extent={{42,58},{22,78}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T5(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-68,30},{-48,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T6(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-28,46},{-8,26}})));
  equation
    connect(sensor_T1.port, resistance.port_b) annotation (Line(points={{-20,-54},
            {-20,-60},{-35,-60}}, color={0,127,255}));
    connect(resistance.port_b, vapourLiquidSeparator.MixIn) annotation (Line(
          points={{-35,-60},{-4,-60},{-4,-52},{10,-52}}, color={0,127,255}));
    connect(sensor_T2.port, vapourLiquidSeparator.VaporOut)
      annotation (Line(points={{38,-32},{38,-48},{30,-48}}, color={0,127,255}));
    connect(sensor_T3.port, vapourLiquidSeparator.LiquidOut)
      annotation (Line(points={{38,-84},{38,-60},{30,-60}}, color={0,127,255}));
    connect(vapourLiquidSeparator.LiquidOut, sensor_m_flow.port_a) annotation (
        Line(points={{30,-60},{38,-60},{38,-78},{58,-78}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, boundary3.ports[1])
      annotation (Line(points={{78,-78},{82,-78}}, color={0,127,255}));
    connect(vapourLiquidSeparator.VaporOut, sensor_m_flow1.port_a) annotation (
        Line(points={{30,-48},{40,-48},{40,-35},{50,-35}}, color={0,127,255}));
    connect(sensor_m_flow1.port_b, boundary1.ports[1])
      annotation (Line(points={{76,-35},{82,-34}}, color={0,127,255}));
    connect(boundary.ports[1], compressor.inlet) annotation (Line(points={{-108,
            30},{-94,30},{-94,60},{-86,60},{-86,54}}, color={0,127,255}));
    connect(compressor.outlet, volume.port_a) annotation (Line(points={{-74,54},{
            -72,54},{-72,66},{-68,66}}, color={0,127,255}));
    connect(volume.port_b, compressor1.inlet)
      annotation (Line(points={{-56,66},{-50,66},{-50,56}}, color={0,127,255}));
    connect(compressor1.outlet, volume1.port_a)
      annotation (Line(points={{-38,56},{-38,64},{-28,64}}, color={0,127,255}));
    connect(boundary4.port, volume1.heatPort)
      annotation (Line(points={{-30,86},{-22,86},{-22,70}}, color={191,0,0}));
    connect(boundary2.port, volume.heatPort)
      annotation (Line(points={{-72,86},{-62,86},{-62,72}}, color={191,0,0}));
    connect(sensor_T4.port, volume1.port_b)
      annotation (Line(points={{8,70},{8,64},{-16,64}}, color={0,127,255}));
    connect(boundary5.ports[1], resistance.port_a) annotation (Line(points={{-64,
            -58},{-56,-58},{-56,-60},{-49,-60}}, color={0,127,255}));
    connect(volume1.port_b, boundary6.ports[1]) annotation (Line(points={{-16,64},
            {-6,64},{-6,58},{18,58},{18,68},{22,68}}, color={0,127,255}));
    connect(sensor_T6.port, compressor1.outlet) annotation (Line(points={{-18,46},
            {-28,46},{-28,56},{-38,56}}, color={0,127,255}));
    connect(sensor_T5.port, compressor.outlet) annotation (Line(points={{-58,30},
            {-58,34},{-68,34},{-68,50},{-72,50},{-72,54},{-74,54}}, color={0,127,
            255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      experiment(
        StopTime=300,
        __Dymola_NumberOfIntervals=1000,
        __Dymola_Algorithm="Esdirk45a"),
      __Dymola_experimentSetupOutput(events=false),
      Documentation(info="<html>
<p>Assuming a Large tank. As the surface area to volume ratio increases the more temperature loss there will be. </p>
<p>Height = 14.6m</p>
<p>Radius = 0.436m </p>
<p>Insulation = 0.204m; ~8in</p>
<p>Wall thickness = 0.051 m</p>
</html>"));
  end Liquifier_compression_test;

  model Liquifier_compression_test2
    "Test to show how much liquification occurs JT valve and separation test"
    import LAES_INL =
           NHES.Systems.EnergyStorage.LAES;
    extends Modelica.Icons.Example;

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      use_T_in=false,
      p=109000,
      T=286.1,
      nPorts=1)
      annotation (Placement(transformation(extent={{-128,20},{-108,40}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-30,-54},{-10,-34}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare
        package Medium = LAES_INL.LAES.Media.AirCoolProp,
                                                 dp0=18600000)
      annotation (Placement(transformation(extent={{-52,-70},{-32,-50}})));
    Components.VapourLiquidSeparator vapourLiquidSeparator(redeclare package
        Medium = LAES_INL.LAES.Media.AirCoolProp)
      annotation (Placement(transformation(extent={{10,-64},{30,-44}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p=100000,
      h=0.1e3,
      nPorts=1)
      annotation (Placement(transformation(extent={{102,-44},{82,-24}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{28,-32},{48,-12}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T3(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{28,-84},{48,-104}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary3(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      m_flow=-72.86,
      h=1e5,
      nPorts=1)
      annotation (Placement(transformation(extent={{102,-88},{82,-68}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = LAES_INL.LAES.Media.AirCoolProp,
                                  precision=3)
      annotation (Placement(transformation(extent={{58,-88},{78,-68}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium = LAES_INL.LAES.Media.AirCoolProp,
                                  precision=3)
      annotation (Placement(transformation(extent={{50,-46},{76,-24}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=0.15*sine.offset,
      f=0.15,
      offset=153.15,
      startTime=60)
      annotation (Placement(transformation(extent={{-162,24},{-142,44}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T4(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-2,70},{18,90}})));
    NHES.GasTurbine.Compressor.Compressor compressor(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      explicitIsentropicEnthalpy=false,
      pstart_in=109000,
      Tstart_in=boundary.T,
      Tstart_out=677.15,
      PR0=13.1,
      w0=92.33) annotation (Placement(transformation(extent={{-90,36},{-70,56}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p_start=compressor.pstart_out,
      T_start=compressor.Tstart_out,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{-72,76},{-52,56}})));
    NHES.GasTurbine.Compressor.Compressor compressor1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      explicitIsentropicEnthalpy=false,
      pstart_in=compressor.pstart_out,
      Tstart_in=298.15,
      Tstart_out=707.15,
      PR0=13.1,
      w0=92.33) annotation (Placement(transformation(extent={{-54,38},{-34,58}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p_start=compressor1.pstart_out,
      T_start=compressor1.Tstart_out,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{-32,74},{-12,54}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(
        Q_flow(displayUnit="MW") = -38000000)
      annotation (Placement(transformation(extent={{-92,76},{-72,96}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary4(
        Q_flow(displayUnit="MW") = -45000000)
      annotation (Placement(transformation(extent={{-50,76},{-30,96}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary5(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      use_p_in=true,
      use_T_in=true,
      p=19100000,
      T(displayUnit="K") = 153.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-84,-68},{-64,-48}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary6(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      m_flow=-92.33,
      h=1e5,
      nPorts=1) annotation (Placement(transformation(extent={{42,58},{22,78}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T5(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-68,30},{-48,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T6(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-28,46},{-8,26}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=volume1.port_b.p)
      annotation (Placement(transformation(extent={{-120,-46},{-100,-26}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=sensor_T4.T)
      annotation (Placement(transformation(extent={{-122,-68},{-102,-48}})));
  equation
    connect(sensor_T1.port, resistance.port_b) annotation (Line(points={{-20,-54},
            {-20,-60},{-35,-60}}, color={0,127,255}));
    connect(resistance.port_b, vapourLiquidSeparator.MixIn) annotation (Line(
          points={{-35,-60},{-4,-60},{-4,-52},{10,-52}}, color={0,127,255}));
    connect(sensor_T2.port, vapourLiquidSeparator.VaporOut)
      annotation (Line(points={{38,-32},{38,-48},{30,-48}}, color={0,127,255}));
    connect(sensor_T3.port, vapourLiquidSeparator.LiquidOut)
      annotation (Line(points={{38,-84},{38,-60},{30,-60}}, color={0,127,255}));
    connect(vapourLiquidSeparator.LiquidOut, sensor_m_flow.port_a) annotation (
        Line(points={{30,-60},{38,-60},{38,-78},{58,-78}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, boundary3.ports[1])
      annotation (Line(points={{78,-78},{82,-78}}, color={0,127,255}));
    connect(vapourLiquidSeparator.VaporOut, sensor_m_flow1.port_a) annotation (
        Line(points={{30,-48},{40,-48},{40,-35},{50,-35}}, color={0,127,255}));
    connect(sensor_m_flow1.port_b, boundary1.ports[1])
      annotation (Line(points={{76,-35},{82,-34}}, color={0,127,255}));
    connect(boundary.ports[1], compressor.inlet) annotation (Line(points={{-108,
            30},{-94,30},{-94,60},{-86,60},{-86,54}}, color={0,127,255}));
    connect(compressor.outlet, volume.port_a) annotation (Line(points={{-74,54},{
            -72,54},{-72,66},{-68,66}}, color={0,127,255}));
    connect(volume.port_b, compressor1.inlet)
      annotation (Line(points={{-56,66},{-50,66},{-50,56}}, color={0,127,255}));
    connect(compressor1.outlet, volume1.port_a)
      annotation (Line(points={{-38,56},{-38,64},{-28,64}}, color={0,127,255}));
    connect(boundary4.port, volume1.heatPort)
      annotation (Line(points={{-30,86},{-22,86},{-22,70}}, color={191,0,0}));
    connect(boundary2.port, volume.heatPort)
      annotation (Line(points={{-72,86},{-62,86},{-62,72}}, color={191,0,0}));
    connect(sensor_T4.port, volume1.port_b)
      annotation (Line(points={{8,70},{8,64},{-16,64}}, color={0,127,255}));
    connect(boundary5.ports[1], resistance.port_a) annotation (Line(points={{-64,
            -58},{-56,-58},{-56,-60},{-49,-60}}, color={0,127,255}));
    connect(volume1.port_b, boundary6.ports[1]) annotation (Line(points={{-16,64},
            {-6,64},{-6,58},{18,58},{18,68},{22,68}}, color={0,127,255}));
    connect(sensor_T6.port, compressor1.outlet) annotation (Line(points={{-18,46},
            {-28,46},{-28,56},{-38,56}}, color={0,127,255}));
    connect(sensor_T5.port, compressor.outlet) annotation (Line(points={{-58,30},
            {-58,34},{-68,34},{-68,50},{-72,50},{-72,54},{-74,54}}, color={0,127,
            255}));
    connect(realExpression1.y, boundary5.T_in) annotation (Line(points={{-101,-58},
            {-94,-58},{-94,-54},{-86,-54}}, color={0,0,127}));
    connect(realExpression.y, boundary5.p_in) annotation (Line(points={{-99,-36},
            {-92,-36},{-92,-50},{-86,-50}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      experiment(
        StopTime=300,
        __Dymola_NumberOfIntervals=1000,
        __Dymola_Algorithm="Esdirk45a"),
      __Dymola_experimentSetupOutput(events=false),
      Documentation(info="<html>
<p>Assuming a Large tank. As the surface area to volume ratio increases the more temperature loss there will be. </p>
<p>Height = 14.6m</p>
<p>Radius = 0.436m </p>
<p>Insulation = 0.204m; ~8in</p>
<p>Wall thickness = 0.051 m</p>
</html>"));
  end Liquifier_compression_test2;

  model Liquifier_compression_separation_test
    "Test to show how much liquification occurs JT valve and separation test"
    import LAES_INL =
           NHES.Systems.EnergyStorage.LAES;
    extends Modelica.Icons.Example;

    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = LAES.Media.AirCoolProp,
      use_T_in=false,
      p=109000,
      T=286.1,
      nPorts=1)
      annotation (Placement(transformation(extent={{-128,20},{-108,40}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
          LAES.Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-30,-54},{-10,-34}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare
        package Medium = LAES.Media.AirCoolProp, dp0=18600000)
      annotation (Placement(transformation(extent={{-54,-70},{-34,-50}})));
    Components.VapourLiquidSeparator vapourLiquidSeparator(redeclare package
        Medium = LAES.Media.AirCoolProp, p_start=100000)
      annotation (Placement(transformation(extent={{10,-64},{30,-44}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
      redeclare package Medium = LAES.Media.AirCoolProp,
      p=100000,
      h=0.1e3,
      nPorts=1)
      annotation (Placement(transformation(extent={{102,-44},{82,-24}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
          LAES.Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{28,-32},{48,-12}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T3(redeclare package Medium =
          LAES.Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{28,-84},{48,-104}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary3(
      redeclare package Medium = LAES.Media.AirCoolProp,
      m_flow=-72.86,
      h=1e5,
      nPorts=1)
      annotation (Placement(transformation(extent={{102,-88},{82,-68}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = LAES.Media.AirCoolProp, precision=3)
      annotation (Placement(transformation(extent={{58,-88},{78,-68}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          LAES.Media.AirCoolProp, precision=3)
      annotation (Placement(transformation(extent={{50,-46},{76,-24}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=0.15*sine.offset,
      f=0.15,
      offset=153.15,
      startTime=60)
      annotation (Placement(transformation(extent={{-162,24},{-142,44}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T4(redeclare package Medium =
          LAES.Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-2,70},{18,90}})));
    NHES.GasTurbine.Compressor.Compressor compressor(
      redeclare package Medium = LAES.Media.AirCoolProp,
      explicitIsentropicEnthalpy=false,
      pstart_in=109000,
      Tstart_in=boundary.T,
      Tstart_out=677.15,
      eta0=0.95,
      PR0=13.1,
      w0=92.33) annotation (Placement(transformation(extent={{-90,36},{-70,56}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = LAES.Media.AirCoolProp,
      p_start=compressor.pstart_out,
      T_start=compressor.Tstart_out,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{-72,76},{-52,56}})));
    NHES.GasTurbine.Compressor.Compressor compressor1(
      redeclare package Medium = LAES.Media.AirCoolProp,
      explicitIsentropicEnthalpy=false,
      pstart_in=compressor.pstart_out,
      Tstart_in=298.15,
      Tstart_out=707.15,
      eta0=0.95,
      PR0=13.1,
      w0=92.33) annotation (Placement(transformation(extent={{-54,38},{-34,58}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = LAES.Media.AirCoolProp,
      p_start=compressor1.pstart_out,
      T_start=compressor1.Tstart_out,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{-32,74},{-12,54}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(
        Q_flow(displayUnit="MW") = -38000000)
      annotation (Placement(transformation(extent={{-92,76},{-72,96}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary4(
        Q_flow(displayUnit="MW") = -48000000)
      annotation (Placement(transformation(extent={{-50,76},{-30,96}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T5(redeclare package Medium =
          LAES.Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-68,30},{-48,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T6(redeclare package Medium =
          LAES.Media.AirCoolProp, allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-28,46},{-8,26}})));
  equation
    connect(sensor_T1.port, resistance.port_b) annotation (Line(points={{-20,-54},
            {-20,-60},{-37,-60}}, color={0,127,255}));
    connect(resistance.port_b, vapourLiquidSeparator.MixIn) annotation (Line(
          points={{-37,-60},{-4,-60},{-4,-52},{10,-52}}, color={0,127,255}));
    connect(sensor_T2.port, vapourLiquidSeparator.VaporOut)
      annotation (Line(points={{38,-32},{38,-48},{30,-48}}, color={0,127,255}));
    connect(sensor_T3.port, vapourLiquidSeparator.LiquidOut)
      annotation (Line(points={{38,-84},{38,-60},{30,-60}}, color={0,127,255}));
    connect(vapourLiquidSeparator.LiquidOut, sensor_m_flow.port_a) annotation (
        Line(points={{30,-60},{38,-60},{38,-78},{58,-78}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, boundary3.ports[1])
      annotation (Line(points={{78,-78},{82,-78}}, color={0,127,255}));
    connect(vapourLiquidSeparator.VaporOut, sensor_m_flow1.port_a) annotation (
        Line(points={{30,-48},{40,-48},{40,-35},{50,-35}}, color={0,127,255}));
    connect(sensor_m_flow1.port_b, boundary1.ports[1])
      annotation (Line(points={{76,-35},{82,-34}}, color={0,127,255}));
    connect(boundary.ports[1], compressor.inlet) annotation (Line(points={{-108,
            30},{-94,30},{-94,60},{-86,60},{-86,54}}, color={0,127,255}));
    connect(compressor.outlet, volume.port_a) annotation (Line(points={{-74,54},{
            -72,54},{-72,66},{-68,66}}, color={0,127,255}));
    connect(volume.port_b, compressor1.inlet)
      annotation (Line(points={{-56,66},{-50,66},{-50,56}}, color={0,127,255}));
    connect(compressor1.outlet, volume1.port_a)
      annotation (Line(points={{-38,56},{-38,64},{-28,64}}, color={0,127,255}));
    connect(boundary4.port, volume1.heatPort)
      annotation (Line(points={{-30,86},{-22,86},{-22,70}}, color={191,0,0}));
    connect(boundary2.port, volume.heatPort)
      annotation (Line(points={{-72,86},{-62,86},{-62,72}}, color={191,0,0}));
    connect(sensor_T4.port, volume1.port_b)
      annotation (Line(points={{8,70},{8,64},{-16,64}}, color={0,127,255}));
    connect(sensor_T6.port, compressor1.outlet) annotation (Line(points={{-18,46},
            {-28,46},{-28,56},{-38,56}}, color={0,127,255}));
    connect(sensor_T5.port, compressor.outlet) annotation (Line(points={{-58,30},
            {-58,34},{-68,34},{-68,50},{-72,50},{-72,54},{-74,54}}, color={0,127,
            255}));
    connect(volume1.port_b, resistance.port_a) annotation (Line(points={{-16,64},
            {-6,64},{-6,62},{0,62},{0,-16},{-68,-16},{-68,-60},{-51,-60}},
          color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      experiment(
        StopTime=300,
        __Dymola_NumberOfIntervals=1000,
        __Dymola_Algorithm="Esdirk45a"),
      __Dymola_experimentSetupOutput(events=false),
      Documentation(info="<html>
<p>Assuming a Large tank. As the surface area to volume ratio increases the more temperature loss there will be. </p>
<p>Height = 14.6m</p>
<p>Radius = 0.436m </p>
<p>Insulation = 0.204m; ~8in</p>
<p>Wall thickness = 0.051 m</p>
</html>"));
  end Liquifier_compression_separation_test;

  model Liquifier_compression_separation_test2
    "Test to show how much liquification occurs JT valve and separation test"
    import LAES_INL =
           NHES.Systems.EnergyStorage.LAES;
    extends Modelica.Icons.Example;

    TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-30,-54},{-10,-34}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(redeclare
        package Medium = LAES_INL.LAES.Media.AirCoolProp,
                                                 dp0=18600000)
      annotation (Placement(transformation(extent={{-52,-70},{-32,-50}})));
    Components.VapourLiquidSeparator vapourLiquidSeparator(redeclare package
        Medium = LAES_INL.LAES.Media.AirCoolProp)
      annotation (Placement(transformation(extent={{10,-64},{30,-44}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p=100000,
      h=0.1e3,
      nPorts=1)
      annotation (Placement(transformation(extent={{102,-44},{82,-24}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T2(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{28,-32},{48,-12}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T3(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{28,-84},{48,-104}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = LAES_INL.LAES.Media.AirCoolProp,
                                  precision=3)
      annotation (Placement(transformation(extent={{58,-88},{78,-68}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium = LAES_INL.LAES.Media.AirCoolProp,
                                  precision=3)
      annotation (Placement(transformation(extent={{50,-46},{76,-24}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=0.15*sine.offset,
      f=0.15,
      offset=153.15,
      startTime=60)
      annotation (Placement(transformation(extent={{-162,24},{-142,44}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T4(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-2,70},{18,90}})));
    NHES.GasTurbine.Compressor.Compressor compressor(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      explicitIsentropicEnthalpy=false,
      pstart_in=109000,
      Tstart_in=boundary5.T,
      Tstart_out=677.15,
      PR0=13.1,
      w0=92.33) annotation (Placement(transformation(extent={{-90,36},{-70,56}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p_start=compressor.pstart_out,
      T_start=compressor.Tstart_out,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{-72,76},{-52,56}})));
    NHES.GasTurbine.Compressor.Compressor compressor1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      explicitIsentropicEnthalpy=false,
      pstart_in=compressor.pstart_out,
      Tstart_in=298.15,
      Tstart_out=707.15,
      PR0=13.1,
      w0=92.33) annotation (Placement(transformation(extent={{-54,38},{-34,58}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p_start=compressor1.pstart_out,
      T_start=compressor1.Tstart_out,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0),
      use_HeatPort=true)
      annotation (Placement(transformation(extent={{-32,74},{-12,54}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary2(
        Q_flow(displayUnit="MW") = -38000000)
      annotation (Placement(transformation(extent={{-92,76},{-72,96}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary4(
        Q_flow(displayUnit="MW") = -45000000)
      annotation (Placement(transformation(extent={{-50,76},{-30,96}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T5(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-68,30},{-48,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T6(redeclare package Medium =
          LAES_INL.LAES.Media.AirCoolProp,
                                  allowFlowReversal=true)
      annotation (Placement(transformation(extent={{-28,46},{-8,26}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary5(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      m_flow=92.33,
      T=286.1,
      nPorts=1)
      annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary6(
      redeclare package Medium = LAES_INL.LAES.Media.AirCoolProp,
      p=100000,
      h=0.1e3,
      nPorts=1)
      annotation (Placement(transformation(extent={{104,-88},{84,-68}})));
  equation
    connect(sensor_T1.port, resistance.port_b) annotation (Line(points={{-20,-54},
            {-20,-60},{-35,-60}}, color={0,127,255}));
    connect(resistance.port_b, vapourLiquidSeparator.MixIn) annotation (Line(
          points={{-35,-60},{-4,-60},{-4,-52},{10,-52}}, color={0,127,255}));
    connect(sensor_T2.port, vapourLiquidSeparator.VaporOut)
      annotation (Line(points={{38,-32},{38,-48},{30,-48}}, color={0,127,255}));
    connect(sensor_T3.port, vapourLiquidSeparator.LiquidOut)
      annotation (Line(points={{38,-84},{38,-60},{30,-60}}, color={0,127,255}));
    connect(vapourLiquidSeparator.LiquidOut, sensor_m_flow.port_a) annotation (
        Line(points={{30,-60},{38,-60},{38,-78},{58,-78}}, color={0,127,255}));
    connect(vapourLiquidSeparator.VaporOut, sensor_m_flow1.port_a) annotation (
        Line(points={{30,-48},{40,-48},{40,-35},{50,-35}}, color={0,127,255}));
    connect(sensor_m_flow1.port_b, boundary1.ports[1])
      annotation (Line(points={{76,-35},{82,-34}}, color={0,127,255}));
    connect(compressor.outlet, volume.port_a) annotation (Line(points={{-74,54},{
            -72,54},{-72,66},{-68,66}}, color={0,127,255}));
    connect(volume.port_b, compressor1.inlet)
      annotation (Line(points={{-56,66},{-50,66},{-50,56}}, color={0,127,255}));
    connect(compressor1.outlet, volume1.port_a)
      annotation (Line(points={{-38,56},{-38,64},{-28,64}}, color={0,127,255}));
    connect(boundary4.port, volume1.heatPort)
      annotation (Line(points={{-30,86},{-22,86},{-22,70}}, color={191,0,0}));
    connect(boundary2.port, volume.heatPort)
      annotation (Line(points={{-72,86},{-62,86},{-62,72}}, color={191,0,0}));
    connect(sensor_T4.port, volume1.port_b)
      annotation (Line(points={{8,70},{8,64},{-16,64}}, color={0,127,255}));
    connect(sensor_T6.port, compressor1.outlet) annotation (Line(points={{-18,46},
            {-28,46},{-28,56},{-38,56}}, color={0,127,255}));
    connect(sensor_T5.port, compressor.outlet) annotation (Line(points={{-58,30},
            {-58,34},{-68,34},{-68,50},{-72,50},{-72,54},{-74,54}}, color={0,127,
            255}));
    connect(volume1.port_b, resistance.port_a) annotation (Line(points={{-16,64},
            {-2,64},{-2,-24},{-62,-24},{-62,-60},{-49,-60}}, color={0,127,255}));
    connect(boundary5.ports[1], compressor.inlet) annotation (Line(points={{
            -100,30},{-96,30},{-96,54},{-86,54}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, boundary6.ports[1])
      annotation (Line(points={{78,-78},{84,-78}}, color={0,127,255}));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      experiment(
        StopTime=300,
        __Dymola_NumberOfIntervals=1000,
        __Dymola_Algorithm="Esdirk45a"),
      __Dymola_experimentSetupOutput(events=false),
      Documentation(info="<html>
<p>Assuming a Large tank. As the surface area to volume ratio increases the more temperature loss there will be. </p>
<p>Height = 14.6m</p>
<p>Radius = 0.436m </p>
<p>Insulation = 0.204m; ~8in</p>
<p>Wall thickness = 0.051 m</p>
</html>"));
  end Liquifier_compression_separation_test2;
end Charging;
