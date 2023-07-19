within NHES.Systems.IndustrialProcess.HeaderTurbineCombo;
package Models
  model StepDownTurbines

    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.Data_Dummy data,
      replaceable package Medium = Modelica.Media.Water.StandardWater,
      port_a_nominal(
        p=data.p_HP,
        h=data.h_HP,
        m_flow=data.m_flow_total),
      port_b_nominal(
        p=data.p_LP,
        h=data.h_LP,
        m_flow=-data.m_flow_LP));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_inlet(
        redeclare package Medium = Medium, R=1*p_units/data.m_flow_total)
      annotation (Placement(transformation(extent={{-94,30},{-74,50}})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_outlet(
        redeclare package Medium = Medium, R=1*p_units/data.m_flow_total)
      annotation (Placement(transformation(extent={{-60,-50},{-80,-30}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW_HP
      annotation (Placement(transformation(extent={{70,-10},{90,10}})));
    TRANSFORM.Electrical.PowerConverters.Generator generator_HP(J=0)
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume_HP(
      nPorts_b=2,
      redeclare package Medium = Medium,
      p_start=data.p_HP,
      T_start=data.T_HP,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      use_HeatPort=true,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T sink_HP(
      redeclare package Medium = Medium,
      T=data.T_HP,
      nPorts=1,
      m_flow=-data.m_flow_HP_toProcess,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{0,50},{-20,70}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume_IP(
      nPorts_a=1,
      redeclare package Medium = Medium,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      p_start=data.p_IP,
      T_start=data.T_IP,
      nPorts_b=2)
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T sink_IP(
      redeclare package Medium = Medium,
      T=data.T_IP,
      nPorts=1,
      m_flow=-data.m_flow_IP_toProcess,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{40,50},{20,70}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume_LP(
      nPorts_a=1,
      redeclare package Medium = Medium,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      p_start=data.p_LP,
      T_start=data.T_LP,
      nPorts_b=2)
      annotation (Placement(transformation(extent={{30,30},{50,50}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T sink_LP(
      redeclare package Medium = Medium,
      T=data.T_LP,
      nPorts=1,
      m_flow=-data.m_flow_LP_toProcess,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{80,50},{60,70}})));
    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine_HP(
      redeclare package Medium = Medium,
      p_a_start=data.p_HP,
      p_b_start=data.p_IP,
      T_a_start=data.T_HP,
      T_b_start=data.T_IP,
      m_flow_start=data.m_flow_HP)
      annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine_IP(
      redeclare package Medium = Medium,
      p_a_start=data.p_IP,
      p_b_start=data.p_LP,
      T_a_start=data.T_IP,
      T_b_start=data.T_LP,
      m_flow_start=data.m_flow_IP)
      annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary(T=
          volume_HP.T_start)
      annotation (Placement(transformation(extent={{-80,8},{-60,28}})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster pump_PressureBooster(redeclare
        package Medium = Modelica.Media.Water.StandardWater, p_nominal=volume_HP.p_start)
      annotation (Placement(transformation(extent={{-76,50},{-56,70}})));
  protected
    final parameter SI.Pressure p_units = 1;

  equation

    connect(sensorW_HP.port_b, portElec) annotation (Line(points={{90,0},{100,0}},
                              color={255,0,0}));
    connect(port_a, resistance_inlet.port_a)
      annotation (Line(points={{-100,40},{-91,40}}, color={0,127,255}));
    connect(port_b, resistance_outlet.port_b)
      annotation (Line(points={{-100,-40},{-77,-40}}, color={0,127,255}));
    connect(generator_HP.port, sensorW_HP.port_a)
      annotation (Line(points={{60,0},{70,0}}, color={255,0,0}));
    connect(steamTurbine_HP.portHP, volume_HP.port_b[1]) annotation (Line(points=
            {{-30,6},{-36,6},{-36,39.5},{-44,39.5}}, color={0,127,255}));
    connect(volume_IP.port_a[1], steamTurbine_HP.portLP)
      annotation (Line(points={{-6,40},{-10,40},{-10,6}}, color={0,127,255}));
    connect(sink_HP.ports[1],volume_HP. port_b[2]) annotation (Line(points={{-20,60},
            {-36,60},{-36,40.5},{-44,40.5}}, color={0,127,255}));
    connect(volume_LP.port_a[1], steamTurbine_IP.portLP)
      annotation (Line(points={{34,40},{30,40},{30,6}}, color={0,127,255}));
    connect(steamTurbine_IP.portHP, volume_IP.port_b[1])
      annotation (Line(points={{10,6},{10,39.5},{6,39.5}}, color={0,127,255}));
    connect(sink_IP.ports[1], volume_IP.port_b[2]) annotation (Line(points={{20,
            60},{10,60},{10,40.5},{6,40.5}}, color={0,127,255}));
    connect(volume_LP.port_b[1], resistance_outlet.port_a) annotation (Line(
          points={{46,39.5},{64,39.5},{64,-40},{-63,-40}}, color={0,127,255}));
    connect(sink_LP.ports[1], volume_LP.port_b[2]) annotation (Line(points={{60,
            60},{52,60},{52,40.5},{46,40.5}}, color={0,127,255}));
    connect(steamTurbine_IP.shaft_b, generator_HP.shaft)
      annotation (Line(points={{30,0},{40,0}}, color={0,0,0}));
    connect(steamTurbine_HP.shaft_b, steamTurbine_IP.shaft_a)
      annotation (Line(points={{-10,0},{10,0}}, color={0,0,0}));
    connect(boundary.port, volume_HP.heatPort)
      annotation (Line(points={{-60,18},{-50,18},{-50,34}}, color={191,0,0}));
    connect(resistance_inlet.port_b, pump_PressureBooster.port_a)
      annotation (Line(points={{-77,40},{-76,40},{-76,60}}, color={0,127,255}));
    connect(pump_PressureBooster.port_b, volume_HP.port_a[1])
      annotation (Line(points={{-56,60},{-56,40}}, color={0,127,255}));
    connect(actuatorBus.m_flow_HP_toProcess, sink_HP.m_flow_in) annotation (Line(
        points={{30.1,100.1},{12,100.1},{12,68},{0,68}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.m_flow_IP_toProcess, sink_IP.m_flow_in) annotation (Line(
        points={{30.1,100.1},{52,100.1},{52,68},{40,68}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.m_flow_LP_toProcess, sink_LP.m_flow_in) annotation (Line(
        points={{30.1,100.1},{90,100.1},{90,68},{80,68}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    annotation (
      defaultComponentName="IP",
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{140,
              140}})),
      Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-27,2},{27,-2}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={32,-27},
            rotation=90),
          Rectangle(
            extent={{-13,2},{13,-2}},
            lineColor={0,0,0},
            fillColor={245,245,0},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={6,-13},
            rotation=90),
          Rectangle(
            extent={{-21,2},{21,-2}},
            lineColor={0,0,0},
            fillColor={245,245,0},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={16,-3},
            rotation=90),
          Rectangle(
            extent={{-12,22},{4,18}},
            lineColor={0,0,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{14,22},{30,18}},
            lineColor={0,0,0},
            fillColor={245,245,0},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-21,2},{21,-2}},
            lineColor={0,0,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={-10,-3},
            rotation=90),
          Rectangle(
            extent={{-13,2},{13,-2}},
            lineColor={0,0,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={-20,-13},
            rotation=90),
          Rectangle(
            extent={{-13,2},{13,-2}},
            lineColor={0,0,0},
            fillColor={238,46,47},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={-50,31},
            rotation=90),
          Rectangle(
            extent={{-52,22},{-26,18}},
            lineColor={0,0,0},
            fillColor={238,46,47},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-74,52},{-40,46}},
            lineColor={0,0,0},
            fillColor={238,46,47},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-15,2},{15,-2}},
            lineColor={0,0,0},
            fillColor={245,245,0},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={2,-35},
            rotation=45),
          Rectangle(
            extent={{-15,2},{15,-2}},
            lineColor={0,0,0},
            fillColor={255,128,0},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={-22,-33},
            rotation=45),
          Rectangle(
            extent={{-2.23995,3},{81.7603,-3}},
            lineColor={0,0,0},
            origin={-33.7603,11},
            rotation=0,
            fillColor={135,135,135},
            fillPattern=FillPattern.HorizontalCylinder),
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Headers + Turbines"),
          Polygon(
            points={{-32,18},{-32,4},{-18,-4},{-18,28},{-32,18}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-6,18},{-6,4},{8,-4},{8,28},{-6,18}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{20,18},{20,4},{34,-4},{34,28},{20,18}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{48,24},{76,-2}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{57,4},{67,18}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="G"),
          Ellipse(
            extent={{-6,-16},{-26,-36}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Sphere),
          Rectangle(
            extent={{-50,60},{-16,56}},
            lineColor={0,0,0},
            fillColor={238,46,47},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{20,-16},{0,-36}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Sphere),
          Ellipse(
            extent={{-38,60},{-58,40}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Sphere),
          Rectangle(
            extent={{-53.5,2.5},{53.5,-2.5}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={-19.5,-55.5},
            rotation=180)}),
      experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000));
  end StepDownTurbines;

  model StepDownTurbines_standAlone

    extends BaseClasses.Partial_SubSystem(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.Data_Dummy data);

      package Medium = Modelica.Media.Water.StandardWater;
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Medium,
      p=data.p_HP,
      T=data.T_HP,
      nPorts=1)
      annotation (Placement(transformation(extent={{-150,30},{-130,50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
      redeclare package Medium = Medium,
      p=data.p_LP,
      T=data.T_LP,
      nPorts=1)
      annotation (Placement(transformation(extent={{-150,-50},{-130,-30}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_inlet(
        redeclare package Medium = Medium, R=1*p_units/data.m_flow_total)
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume_HP(
      nPorts_a=1,
      nPorts_b=2,
      redeclare package Medium = Medium,
      p_start=data.p_HP,
      T_start=data.T_HP,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1))
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T sink_HP(
        redeclare package Medium = Medium,
      m_flow=data.m_flow_HP_toProcess,
      T=data.T_HP,
      nPorts=1)
      annotation (Placement(transformation(extent={{0,50},{-20,70}})));

    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
      redeclare package Medium = Medium,
      p_a_start=data.p_HP,
      p_b_start=data.p_IP,
      T_a_start=data.T_HP,
      T_b_start=data.T_IP,
      m_flow_start=data.m_flow_HP)
      annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{14,-36},{34,-16}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume_IP(
      nPorts_a=1,
      redeclare package Medium = Medium,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      p_start=data.p_IP,
      T_start=data.T_IP,
      nPorts_b=2)
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));
    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine1(
      redeclare package Medium = Medium,
      p_a_start=data.p_IP,
      p_b_start=data.p_LP,
      T_a_start=data.T_IP,
      T_b_start=data.T_LP,
      m_flow_start=data.m_flow_IP)
      annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator1
      annotation (Placement(transformation(extent={{46,-10},{66,10}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T sink_IP(
      redeclare package Medium = Medium,
      m_flow=data.m_flow_IP_toProcess,
      T=data.T_IP,
      nPorts=1)
      annotation (Placement(transformation(extent={{40,50},{20,70}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume_LP(
      nPorts_a=1,
      redeclare package Medium = Medium,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      p_start=data.p_LP,
      T_start=data.T_LP,
      nPorts_b=2)
      annotation (Placement(transformation(extent={{30,30},{50,50}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_outlet(
        redeclare package Medium = Medium, R=1*p_units/data.m_flow_total)
      annotation (Placement(transformation(extent={{-60,-50},{-80,-30}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T sink_LP(
      redeclare package Medium = Medium,
      m_flow=data.m_flow_LP_toProcess,
      T=data.T_LP,
      nPorts=1)
      annotation (Placement(transformation(extent={{80,50},{60,70}})));
  protected
    final parameter SI.Pressure p_units = 1;

  equation

    connect(boundary.ports[1], resistance_inlet.port_a)
      annotation (Line(points={{-130,40},{-77,40}}, color={0,127,255}));
    connect(resistance_inlet.port_b, volume_HP.port_a[1])
      annotation (Line(points={{-63,40},{-56,40}}, color={0,127,255}));
    connect(steamTurbine.portHP, volume_HP.port_b[1]) annotation (Line(points={{-30,6},
            {-36,6},{-36,39.5},{-44,39.5}},      color={0,127,255}));
    connect(steamTurbine.shaft_b, generator.shaft) annotation (Line(points={{-10,0},
            {-6,0},{-6,-26.1},{13.9,-26.1}},color={0,0,0}));
    connect(volume_IP.port_a[1], steamTurbine.portLP)
      annotation (Line(points={{-6,40},{-10,40},{-10,6}},    color={0,127,255}));
    connect(steamTurbine1.shaft_b, generator1.shaft) annotation (Line(points={{30,0},{
            44,0},{44,-0.1},{45.9,-0.1}},           color={0,0,0}));
    connect(sink_HP.ports[1], volume_HP.port_b[2]) annotation (Line(points={{-20,60},
            {-36,60},{-36,40.5},{-44,40.5}}, color={0,127,255}));
    connect(volume_LP.port_a[1], steamTurbine1.portLP)
      annotation (Line(points={{34,40},{30,40},{30,6}},     color={0,127,255}));
    connect(boundary1.ports[1], resistance_outlet.port_b)
      annotation (Line(points={{-130,-40},{-77,-40}}, color={0,127,255}));
    connect(steamTurbine1.portHP, volume_IP.port_b[1])
      annotation (Line(points={{10,6},{10,39.5},{6,39.5}}, color={0,127,255}));
    connect(sink_IP.ports[1], volume_IP.port_b[2]) annotation (Line(points={{20,
            60},{10,60},{10,40.5},{6,40.5}}, color={0,127,255}));
    connect(volume_LP.port_b[1], resistance_outlet.port_a) annotation (Line(
          points={{46,39.5},{52,39.5},{52,-40},{-63,-40}}, color={0,127,255}));
    connect(sink_LP.ports[1], volume_LP.port_b[2]) annotation (Line(points={{60,
            60},{52,60},{52,40.5},{46,40.5}}, color={0,127,255}));
    annotation (
      defaultComponentName="IP",
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              140}})),
      Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}),
      experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000));
  end StepDownTurbines_standAlone;

  model StepDownTurbine

    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.Data_Dummy data,
      replaceable package Medium = Modelica.Media.Water.StandardWater,
      port_b_nominal(m_flow=-(port_a_nominal.m_flow - m_flow_nominal_toProcess)));

  parameter SI.MassFlowRate m_flow_nominal_toProcess = 0.1*port_a_nominal.m_flow "Nominal flow rate to process from steam header";

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_port_a(
        redeclare package Medium = Medium, R=1*p_units/port_a_nominal.m_flow)
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume_header(
      nPorts_a=1,
      nPorts_b=2,
      redeclare package Medium = Medium,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      p_start=port_a_start.p,
      use_T_start=false,
      h_start=port_a_start.h)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T sink(
      redeclare package Medium = Medium,
      nPorts=1,
      m_flow=-m_flow_nominal_toProcess)
                annotation (Placement(transformation(extent={{-10,40},{-30,60}})));

    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
      redeclare package Medium = Medium,
      use_T_start=false,
      h_a_start=port_a_start.h,
      h_b_start=port_b_start.h,
      m_flow_start=port_a_start.m_flow - m_flow_nominal_toProcess,
      p_a_start=port_a_start.p,
      p_b_start=port_b_start.p)
      annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume_turbine(
      nPorts_a=1,
      redeclare package Medium = Medium,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      p_start=port_b_start.p,
      use_T_start=false,
      h_start=port_b_start.h,
      nPorts_b=1)
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_port_b(
        redeclare package Medium = Medium, R=1*p_units/abs(port_b_nominal.m_flow))
      annotation (Placement(transformation(extent={{-60,-50},{-80,-30}})));
    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    TRANSFORM.Electrical.PowerConverters.Generator generator(J=1000)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  protected
    final parameter SI.Pressure p_units = 1;

  equation

    connect(resistance_port_a.port_b, volume_header.port_a[1])
      annotation (Line(points={{-63,40},{-56,40}}, color={0,127,255}));
    connect(steamTurbine.portHP, volume_header.port_b[1]) annotation (Line(points=
           {{-30,6},{-36,6},{-36,39.5},{-44,39.5}}, color={0,127,255}));
    connect(volume_turbine.port_a[1], steamTurbine.portLP) annotation (Line(
          points={{-6,-30},{-10,-30},{-10,6}},   color={0,127,255}));
    connect(sink.ports[1], volume_header.port_b[2]) annotation (Line(points={{-30,
            50},{-36,50},{-36,40.5},{-44,40.5}}, color={0,127,255}));
    connect(steamTurbine.shaft_b, generator.shaft)
      annotation (Line(points={{-10,0},{0,0}}, color={0,0,0}));
    connect(generator.port, sensorW.port_a)
      annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
    connect(port_a, resistance_port_a.port_a)
      annotation (Line(points={{-100,40},{-77,40}}, color={0,127,255}));
    connect(port_b, resistance_port_b.port_b)
      annotation (Line(points={{-100,-40},{-77,-40}}, color={0,127,255}));
    connect(sensorW.port_b, portElec)
      annotation (Line(points={{60,0},{100,0}}, color={255,0,0}));
    connect(volume_turbine.port_b[1], resistance_port_b.port_a) annotation (Line(
          points={{6,-30},{10,-30},{10,-40},{-63,-40}}, color={0,127,255}));
    annotation (
      defaultComponentName="IP",
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              140}})),
      Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            extent={{50,12},{78,-14}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-32,54},{2,48}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-14,3},{14,-3}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={10,27},
            rotation=90),
          Rectangle(
            extent={{-22,42},{12,36}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Header + Step Down Turbine"),
          Text(
            extent={{59,-8},{69,6}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="G"),
          Rectangle(
            extent={{-1.81332,3},{66.1869,-3}},
            lineColor={0,0,0},
            origin={-14.1867,-1},
            rotation=0,
            fillColor={135,135,135},
            fillPattern=FillPattern.HorizontalCylinder),
          Polygon(
            points={{6,16},{6,-14},{36,-32},{36,36},{6,16}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{15,-8},{25,6}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="T"),
          Rectangle(
            extent={{-0.4,3},{15.5,-3}},
            lineColor={0,0,0},
            origin={36.4272,-29},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-82,46},{-34,34}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-18,54},{-46,26}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Sphere),
          Rectangle(
            extent={{-3.37009,3},{130.603,-3}},
            lineColor={0,0,0},
            origin={-78.6031,-41},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.465408,2.7136},{18.0346,-2.7136}},
            lineColor={0,0,0},
            origin={50.7136,-43.5346},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder)}),
      experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000));
  end StepDownTurbine;
end Models;
