within NHES.Systems;
package DistrictHeating

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model Test
      extends Modelica.Icons.Example;

      DH_loop changeMe
        annotation (Placement(transformation(extent={{-40,-42},{40,38}})));

      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})),
        experiment(
          StopTime=100,
          __Dymola_NumberOfIntervals=100,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput);
    end Test;
  end Examples;

  model DH_loop

    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable NHES.Systems.DistrictHeating.CS.CS_Tlow  CS(Tlow_set=
            data.T_low),
      redeclare replaceable NHES.Systems.DistrictHeating.CS.ED_Dummy ED,
      redeclare Data.Data_Dummy data);
      input Modelica.Units.SI.Power HeatDemand annotation(Dialog(group="Inputs"));

    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase HeatingPlant(
      NTU=data.NTU,
      K_tube=1,
      K_shell=1,
      redeclare package Tube_medium = Medium,
      redeclare package Shell_medium = Medium,
      V_Tube=data.V_Tube_HX,
      V_Shell=data.V_Shell_HX,
      p_start_tube=data.p,
      use_T_start_tube=true,
      T_start_tube_inlet=318.15,
      T_start_tube_outlet=373.15,
      p_start_shell=data.p,
      use_T_start_shell=true,
      T_start_shell_inlet=398.15,
      T_start_shell_outlet=373.15,
      dp_init_tube=1000,
      dp_init_shell=1000,
      m_start_tube=2,
      m_start_shell=2) annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-60,0})));
    TRANSFORM.Fluid.Sensors.Temperature T_high_supply(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-18,34},{-38,54}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume HeatSink(
      redeclare package Medium = Medium,
      p_start=data.p,
      T_start=data.T_low,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_sink),
      use_HeatPort=true) annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={40,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow heat_sink(use_port=
          true)
      annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow circ_pump(
      redeclare package Medium = Medium,
      use_input=true,
      m_flow_nominal=4) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-52,-46})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressure_reg(
      redeclare package Medium = Medium,
      p=data.p,
      T=data.T_low,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
    TRANSFORM.Fluid.Sensors.Temperature T_low_supply(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-40,-36},{-20,-16}})));
    TRANSFORM.Fluid.Sensors.Temperature T_steam_in(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-66,34},{-86,54}})));
    TRANSFORM.Fluid.Sensors.Temperature T_cond_out(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-70,-40},{-90,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=HeatDemand)
      annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
    replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);

  equation

    connect(heat_sink.port, HeatSink.heatPort) annotation (Line(points={{60,-70},{
            66,-70},{66,-6.66134e-16},{52,-6.66134e-16}}, color={191,0,0}));
    connect(HeatingPlant.Shell_in, port_a)
      annotation (Line(points={{-64,20},{-64,60},{-100,60}}, color={0,127,255}));
    connect(HeatingPlant.Shell_out, port_b) annotation (Line(points={{-64,-20},{-64,
            -60},{-100,-60}}, color={0,127,255}));
    connect(circ_pump.port_b, HeatingPlant.Tube_in)
      annotation (Line(points={{-52,-36},{-52,-20}}, color={0,127,255}));
    connect(circ_pump.port_a, HeatSink.port_b) annotation (Line(points={{-52,-56},
            {-52,-60},{40,-60},{40,-12}}, color={0,127,255}));
    connect(HeatingPlant.Tube_out, HeatSink.port_a) annotation (Line(points={{-52,
            20},{-52,60},{40,60},{40,12}}, color={0,127,255}));
    connect(T_high_supply.port, HeatingPlant.Tube_out) annotation (Line(points={{-28,
            34},{-28,32},{-52,32},{-52,20}}, color={0,127,255}));
    connect(T_low_supply.port, HeatingPlant.Tube_in) annotation (Line(points={{-30,-36},
            {-52,-36},{-52,-20}},                color={0,127,255}));
    connect(sensorBus.T_low, T_low_supply.T) annotation (Line(
        points={{-30,100},{-30,92},{92,92},{92,-26},{-24,-26}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(T_steam_in.port, HeatingPlant.Shell_in) annotation (Line(points={{-76,
            34},{-76,30},{-64,30},{-64,20}}, color={0,127,255}));
    connect(T_cond_out.port, HeatingPlant.Shell_out) annotation (Line(points={{-80,
            -40},{-80,-42},{-64,-42},{-64,-20}}, color={0,127,255}));
    connect(circ_pump.port_a, Pressure_reg.ports[1]) annotation (Line(points={{-52,
            -56},{-52,-90},{-80,-90}}, color={0,127,255}));
    connect(realExpression.y, heat_sink.Q_flow_ext)
      annotation (Line(points={{1,-70},{46,-70}}, color={0,0,127}));
    connect(actuatorBus.Pump_speed, circ_pump.in_m_flow) annotation (Line(
        points={{30,100},{100,100},{100,-46},{-44.7,-46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (
      defaultComponentName="DistrictHeating",
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              140}})),
      Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={2,13,224},
            pattern=LinePattern.None,
            origin={-54,-51},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={2,13,224},
            pattern=LinePattern.None,
            origin={-14,-51},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={2,13,224},
            pattern=LinePattern.None,
            origin={26,-51},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={2,13,224},
            pattern=LinePattern.None,
            origin={58,-39},
            rotation=180),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={2,13,224},
            pattern=LinePattern.None,
            origin={60,23},
            rotation=180),
          Rectangle(
            extent={{50,34},{70,36}},
            fillPattern=FillPattern.Solid,
            fillColor={238,46,47},
            pattern=LinePattern.None),
          Rectangle(
            extent={{50,-28},{70,-26}},
            fillPattern=FillPattern.Solid,
            fillColor={238,46,47},
            pattern=LinePattern.None),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={238,46,47},
            pattern=LinePattern.None,
            origin={-68,-49},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={238,46,47},
            pattern=LinePattern.None,
            origin={-68,49},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={238,46,47},
            pattern=LinePattern.None,
            origin={-28,49},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={238,46,47},
            pattern=LinePattern.None,
            origin={12,49},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={238,46,47},
            pattern=LinePattern.None,
            origin={-28,-49},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={238,46,47},
            pattern=LinePattern.None,
            origin={12,-49},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={2,13,224},
            pattern=LinePattern.None,
            origin={-54,-51},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={2,13,224},
            pattern=LinePattern.None,
            origin={-14,-51},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={2,13,224},
            pattern=LinePattern.None,
            origin={26,-51},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={2,13,224},
            pattern=LinePattern.None,
            origin={-54,49},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={2,13,224},
            pattern=LinePattern.None,
            origin={-14,49},
            rotation=90),
          Rectangle(
            extent={{-10,-1},{10,1}},
            fillPattern=FillPattern.Solid,
            fillColor={2,13,224},
            pattern=LinePattern.None,
            origin={26,49},
            rotation=90),
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="%name"),
          Rectangle(
            extent={{-94,58},{-74,62}},
            fillPattern=FillPattern.Solid,
            fillColor={238,46,47},
            pattern=LinePattern.None),
          Rectangle(
            extent={{-74,58},{-54,62}},
            fillPattern=FillPattern.Solid,
            fillColor={255,45,17},
            pattern=LinePattern.None),
          Rectangle(
            extent={{-54,58},{-34,62}},
            fillPattern=FillPattern.Solid,
            fillColor={255,79,25},
            pattern=LinePattern.None),
          Rectangle(
            extent={{-34,58},{-14,62}},
            fillPattern=FillPattern.Solid,
            fillColor={255,107,33},
            pattern=LinePattern.None),
          Rectangle(
            extent={{-14,58},{6,62}},
            fillPattern=FillPattern.Solid,
            fillColor={255,125,39},
            pattern=LinePattern.None),
          Rectangle(
            extent={{26,58},{46,62}},
            fillPattern=FillPattern.Solid,
            fillColor={255,178,53},
            pattern=LinePattern.None),
          Rectangle(
            extent={{6,58},{26,62}},
            fillPattern=FillPattern.Solid,
            fillColor={255,157,44},
            pattern=LinePattern.None),
          Rectangle(
            extent={{-94,-62},{-74,-58}},
            fillPattern=FillPattern.Solid,
            fillColor={2,14,238},
            pattern=LinePattern.None),
          Rectangle(
            extent={{-74,-62},{-54,-58}},
            fillPattern=FillPattern.Solid,
            fillColor={24,59,255},
            pattern=LinePattern.None),
          Rectangle(
            extent={{-54,-62},{-34,-58}},
            fillPattern=FillPattern.Solid,
            fillColor={43,107,255},
            pattern=LinePattern.None),
          Rectangle(
            extent={{-34,-62},{-14,-58}},
            fillPattern=FillPattern.Solid,
            fillColor={46,140,255},
            pattern=LinePattern.None),
          Rectangle(
            extent={{-14,-62},{6,-58}},
            fillPattern=FillPattern.Solid,
            fillColor={42,152,255},
            pattern=LinePattern.None),
          Rectangle(
            extent={{26,-62},{46,-58}},
            fillPattern=FillPattern.Solid,
            fillColor={51,190,255},
            pattern=LinePattern.None),
          Rectangle(
            extent={{6,-62},{26,-58}},
            fillPattern=FillPattern.Solid,
            fillColor={46,171,255},
            pattern=LinePattern.None),
          Rectangle(
            extent={{46,62},{50,-62}},
            fillPattern=FillPattern.Solid,
            fillColor={247,255,93},
            pattern=LinePattern.None),
          Rectangle(
            extent={{-72,18},{-52,38}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={184,92,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-58,18},{-62,28}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-48,36},{-76,36},{-62,48},{-48,36}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-32,18},{-12,38}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={184,92,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-18,18},{-22,28}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-8,36},{-36,36},{-22,48},{-8,36}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{8,18},{28,38}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={184,92,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{22,18},{18,28}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{32,36},{4,36},{18,48},{32,36}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-72,-42},{-52,-22}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={184,92,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-58,-42},{-62,-32}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-48,-24},{-76,-24},{-62,-12},{-48,-24}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-32,-42},{-12,-22}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={184,92,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-18,-42},{-22,-32}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-8,-24},{-36,-24},{-22,-12},{-8,-24}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{8,-42},{28,-22}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={184,92,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{22,-42},{18,-32}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{32,-24},{4,-24},{18,-12},{32,-24}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{58,18},{88,52}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={150,150,150},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{84,18},{80,24}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{78,22},{76,24}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{74,22},{72,24}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{70,22},{68,24}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{66,22},{64,24}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{62,22},{60,24}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{78,30},{76,32}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{74,30},{72,32}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{70,30},{68,32}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{66,30},{64,32}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{62,30},{60,32}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{86,30},{84,32}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{82,30},{80,32}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{78,38},{76,40}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{74,38},{72,40}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{70,38},{68,40}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{66,38},{64,40}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{62,38},{60,40}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{86,38},{84,40}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{82,38},{80,40}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{78,46},{76,48}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{74,46},{72,48}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{70,46},{68,48}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{66,46},{64,48}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{62,46},{60,48}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{86,46},{84,48}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{82,46},{80,48}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{90,52},{56,54}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={68,68,68},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{58,-44},{88,-10}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={150,150,150},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{84,-44},{80,-38}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{78,-40},{76,-38}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{74,-40},{72,-38}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{70,-40},{68,-38}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{66,-40},{64,-38}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{62,-40},{60,-38}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{78,-32},{76,-30}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{74,-32},{72,-30}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{70,-32},{68,-30}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{66,-32},{64,-30}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{62,-32},{60,-30}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{86,-32},{84,-30}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{82,-32},{80,-30}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{78,-24},{76,-22}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{74,-24},{72,-22}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{70,-24},{68,-22}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{66,-24},{64,-22}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{62,-24},{60,-22}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{86,-24},{84,-22}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{82,-24},{80,-22}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{78,-16},{76,-14}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{74,-16},{72,-14}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{70,-16},{68,-14}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{66,-16},{64,-14}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{62,-16},{60,-14}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{86,-16},{84,-14}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{82,-16},{80,-14}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{90,-10},{56,-8}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillColor={68,68,68},
            fillPattern=FillPattern.CrossDiag)}));
  end DH_loop;

  package Components

  end Components;

  package CS "Control systems package"
    model CS_Dummy

      extends BaseClasses.Partial_ControlSystem;

    equation

    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Dummy;

    model ED_Dummy

      extends BaseClasses.Partial_EventDriver;

    equation

    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end ED_Dummy;

    model CS_Tlow

      extends BaseClasses.Partial_ControlSystem;

      Controls.LimOffsetPID      PID(
        k=0.01,
        Ti=200,
        yMax=60,
        yMin=0.5,
        offset=10,
        delayTime=10000,
        init_output=10)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=Tlow_set)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      parameter Modelica.Units.SI.Temperature Tlow_set=273.15 + 45
        "Value of Real output";
    equation

      connect(PID.u_s,realExpression2. y)
        annotation (Line(points={{-12,0},{-29,0}},   color={0,0,127}));
      connect(sensorBus.T_low, PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-22},{0,-22},{0,-12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.Pump_speed, PID.y) annotation (Line(
          points={{30,-100},{30,0},{11,0}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Tlow;
  end CS;

  package Data

    model Data_Dummy

      extends BaseClasses.Record_Data;
      parameter Real NTU=24 "Characteristic NTU of HX";
      parameter SI.Volume V_Tube_HX=1 "Total tube-side volume";
      parameter SI.Volume V_Shell_HX=0.1 "Total shell-side volume";
      parameter Modelica.Media.Interfaces.Types.AbsolutePressure p=200000
        "Fixed value of pressure";
      parameter Modelica.Media.Interfaces.Types.Temperature T_low=318.15
        "Fixed value of temperature";
      parameter SI.Volume V_sink=10 "Volume";
      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_Dummy;
  end Data;

  package BaseClasses
    extends TRANSFORM.Icons.BasesPackage;

    partial model Partial_SubSystem

      extends NHES.Systems.BaseClasses.Partial_SubSystem;

      extends Record_SubSystem;

      replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
          Placement(transformation(extent={{-18,122},{-2,138}})));
      replaceable Partial_EventDriver ED annotation (choicesAllMatching=true,
          Placement(transformation(extent={{2,122},{18,138}})));
      replaceable Record_Data data
        annotation (Placement(transformation(extent={{42,122},{58,138}})));

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,80},{50,120}}),
            iconTransformation(extent={{10,80},{50,120}})));
      SignalSubBus_SensorOutput sensorBus
        annotation (Placement(transformation(extent={{-50,80},{-10,120}}),
            iconTransformation(extent={{-50,80},{-10,120}})));

    equation
      connect(sensorBus, ED.sensorBus) annotation (Line(
          points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus, CS.sensorBus) annotation (Line(
          points={{-30,100},{-12.4,100},{-12.4,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, CS.actuatorBus) annotation (Line(
          points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, ED.actuatorBus) annotation (Line(
          points={{30,100},{20,100},{12.4,100},{12.4,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      annotation (
        defaultComponentName="changeMe",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,140}})));
    end Partial_SubSystem;

    partial model Partial_SubSystem_A

      extends Partial_SubSystem;

      extends Record_SubSystem_A;

      annotation (
        defaultComponentName="changeMe",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                140}})));
    end Partial_SubSystem_A;

    partial model Record_Data

      extends Modelica.Icons.Record;

      annotation (defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_Data;

    partial record Record_SubSystem

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem;

    partial record Record_SubSystem_A

      extends Record_SubSystem;

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem_A;

    partial model Partial_ControlSystem

      extends NHES.Systems.BaseClasses.Partial_ControlSystem;

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
            iconTransformation(extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput sensorBus
        annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
            iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));

    end Partial_ControlSystem;

    partial model Partial_EventDriver

      extends NHES.Systems.BaseClasses.Partial_EventDriver;

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
            iconTransformation(extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput sensorBus
        annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
            iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="ED",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})));

    end Partial_EventDriver;

    expandable connector SignalSubBus_ActuatorInput

      extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

      annotation (defaultComponentName="actuatorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput;

    expandable connector SignalSubBus_SensorOutput

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

      annotation (defaultComponentName="sensorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_SensorOutput;
  end BaseClasses;
end DistrictHeating;
