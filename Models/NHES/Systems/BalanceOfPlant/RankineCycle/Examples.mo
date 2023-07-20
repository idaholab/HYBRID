within NHES.Systems.BalanceOfPlant.RankineCycle;
package Examples
  extends Modelica.Icons.ExamplesPackage;

  package Example_FMU_construction
    model SteamTurbine_L1_FMU
      import NHES;
      extends Modelica.Icons.Example;
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries
        BOP(
        nPorts_a3=1,
        port_a_nominal(
          m_flow=67,
          p=3470000,
          h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
        port_b_nominal(p=1000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
              318.95)),
        redeclare
          NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
          CS(
          delayStartTCV=20,
          p_nominal=3447400,
          W_totalSetpoint=BOP_Demand))
        annotation (Placement(transformation(extent={{-18,-30},{42,30}})));
      TRANSFORM.Electrical.Sources.FrequencySource
                                         sinkElec(use_port=false,
                                                  f=60)
        annotation (Placement(transformation(extent={{90,-10},{70,10}})));
      Modelica.Fluid.Sources.Boundary_pT sink(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        use_T_in=false,
        nPorts=1,
        p(displayUnit="MPa") = BOP.port_b_nominal.p,
        T(displayUnit="K") = BOP.port_b_nominal.T)
        annotation (Placement(transformation(extent={{-88,-2},{-68,-22}})));
      Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-40,-22},{-60,-2}})));
      Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
      Fluid.Sensors.stateDisplay stateDisplay
        annotation (Placement(transformation(extent={{-72,-52},{-28,-22}})));
      Fluid.Sensors.stateDisplay stateDisplay1
        annotation (Placement(transformation(extent={{-72,20},{-28,50}})));
      Modelica.Fluid.Sources.MassFlowSource_h source1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nPorts=1,
        use_m_flow_in=false,
        h=3e6)
        annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
      Modelica.Fluid.Sources.MassFlowSource_h source(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        use_h_in=true,
        nPorts=1)
        annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
      Modelica.Blocks.Interfaces.RealInput Enthalpy
        annotation (Placement(transformation(extent={{-140,-8},{-100,32}})));
      Modelica.Blocks.Interfaces.RealInput mass_flow
        annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
      Modelica.Blocks.Interfaces.RealOutput enthalpy_out
        annotation (Placement(transformation(extent={{-100,-58},{-124,-34}})));
      Modelica.Blocks.Interfaces.RealOutput pressure_out
        annotation (Placement(transformation(extent={{-100,-92},{-124,-68}})));
      Modelica.Blocks.Interfaces.RealOutput Power
        annotation (Placement(transformation(extent={{100,48},{124,72}})));
      Modelica.Blocks.Interfaces.RealOutput freq
        annotation (Placement(transformation(extent={{100,8},{124,32}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=BOP.port_b.h_outflow)
        annotation (Placement(transformation(extent={{-64,-72},{-84,-52}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=BOP.port_b.p)
        annotation (Placement(transformation(extent={{-64,-90},{-84,-70}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=BOP.portElec_b.W)
        annotation (Placement(transformation(extent={{62,50},{82,70}})));
      Modelica.Blocks.Sources.RealExpression realExpression3(y=BOP.portElec_b.f)
        annotation (Placement(transformation(extent={{64,18},{84,38}})));
      Modelica.Blocks.Sources.RealExpression realExpression4(y=BOP.port_a.p)
        annotation (Placement(transformation(extent={{-66,60},{-86,80}})));
      Modelica.Blocks.Interfaces.RealOutput port_inlet_pressure
        "This is a feedback of the pressure going into the balance of plant"
        annotation (Placement(transformation(extent={{-100,60},{-124,84}})));
      Modelica.Blocks.Interfaces.RealInput BOP_Demand annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
    equation

      connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
            points={{-50,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
      connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
            points={{-50,-40.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
      connect(sink.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-12},
              {-64,-12},{-60,-12}}, color={0,127,255}));
      connect(stateSensor.port_a, BOP.port_b)
        annotation (Line(points={{-40,-12},{-18,-12}}, color={0,127,255}));
      connect(stateSensor1.port_b, BOP.port_a)
        annotation (Line(points={{-40,12},{-18,12}}, color={0,127,255}));
      connect(source1.ports[1], BOP.port_a3[1]) annotation (Line(points={{-20,-80},
              {0,-80},{0,-30}},     color={0,127,255}));
      connect(source.ports[1], stateSensor1.port_a)
        annotation (Line(points={{-68,12},{-60,12}}, color={0,127,255}));
      connect(BOP.portElec_b, sinkElec.port)
        annotation (Line(points={{42,0},{70,0}}, color={255,0,0}));
      connect(Enthalpy, source.h_in) annotation (Line(points={{-120,12},{-96,12},{
              -96,16},{-90,16}}, color={0,0,127}));
      connect(realExpression.y, enthalpy_out) annotation (Line(points={{-85,-62},{
              -92,-62},{-92,-46},{-112,-46}}, color={0,0,127}));
      connect(realExpression1.y, pressure_out)
        annotation (Line(points={{-85,-80},{-112,-80}}, color={0,0,127}));
      connect(realExpression2.y, Power)
        annotation (Line(points={{83,60},{112,60}}, color={0,0,127}));
      connect(realExpression3.y, freq) annotation (Line(points={{85,28},{88,28},{88,
              20},{112,20}}, color={0,0,127}));
      connect(mass_flow, source.m_flow_in) annotation (Line(points={{-120,40},{-96,
              40},{-96,20},{-88,20}}, color={0,0,127}));
      connect(realExpression4.y, port_inlet_pressure) annotation (Line(points={{-87,
              70},{-94,70},{-94,72},{-112,72}}, color={0,0,127}));
      annotation (experiment(
          StopTime=1000,
          __Dymola_NumberOfIntervals=1000,
          __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Created by: Konor Frick </p>
<p>Date: 9/28/2020</p>
<p>Adaptation of the balance of plant model to become an FMI/FMU. This model can be exported as in either model exchange or co-simulation mode. </p>
<p>Reference: K. Frick, A. Alfonsi, C. Rabiti. &quot;Flexible Modelica/RAVEN Framework for IES&quot;. Idaho National Laboratory. INL/EXT-20-00419.</p>
</html>"));
    end SteamTurbine_L1_FMU;

    model SteamTurbine_L1_FMU_adaptor
      import NHES;
      extends Modelica.Icons.Example;
      replaceable package Medium=Modelica.Media.Water.StandardWater;
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries
        BOP(
        redeclare package Medium = Medium,
        nPorts_a3=1,
        port_a_nominal(
          m_flow=67,
          p=3470000,
          h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
        port_b_nominal(p=1000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
              318.95)),
        redeclare
          NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
          CS(
          delayStartTCV=20,
          p_nominal=3447400,
          W_totalSetpoint=BOP_Demand))
        annotation (Placement(transformation(extent={{-18,-30},{42,30}})));
      TRANSFORM.Electrical.Sources.FrequencySource
                                         sinkElec(use_port=false,
                                                  f=60)
        annotation (Placement(transformation(extent={{90,-10},{70,10}})));
      Modelica.Fluid.Sources.MassFlowSource_h source1(
        redeclare package Medium = Medium,
        nPorts=1,
        use_m_flow_in=false,
        h=3e6)
        annotation (Placement(transformation(extent={{56,-66},{36,-46}})));
      Modelica.Blocks.Interfaces.RealOutput Power
        annotation (Placement(transformation(extent={{100,48},{124,72}})));
      Modelica.Blocks.Interfaces.RealOutput freq
        annotation (Placement(transformation(extent={{100,8},{124,32}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=BOP.portElec_b.W)
        annotation (Placement(transformation(extent={{62,50},{82,70}})));
      Modelica.Blocks.Sources.RealExpression realExpression3(y=BOP.portElec_b.f)
        annotation (Placement(transformation(extent={{64,18},{84,38}})));
      Modelica.Blocks.Interfaces.RealInput BOP_Demand annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.MassFlowToPressure
        massFlowToPressure(redeclare package Medium = Medium,
                           p_atm=BOP.port_b_nominal.p)
        annotation (Placement(transformation(extent={{10,-26},{-10,26}},
            rotation=90,
            origin={-18,-68})));
      NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.PressureToMassFlow
        pressureToMassFlow(redeclare package Medium = Medium,
                           p_atm=BOP.port_a_nominal.p)
        annotation (Placement(transformation(extent={{-70,-20},{-50,32}})));
      Modelica.Blocks.Interfaces.RealInput C_in_port_a[size(pressureToMassFlow.C_in,
        1)] "Prescribed mass fractions" annotation (Placement(transformation(extent=
               {{-118,-100},{-100,-82}}), iconTransformation(extent={{-118,-100},{-100,
                -82}})));
      Modelica.Blocks.Interfaces.RealInput X_in_port_a[size(pressureToMassFlow.X_in,
        1)] "Prescribed mass fractions" annotation (Placement(transformation(extent=
               {{-118,-58},{-100,-40}}), iconTransformation(extent={{-118,-58},{-100,
                -40}})));
      Modelica.Blocks.Interfaces.RealInput h_in_port_a
        "Prescribed specific enthalpy" annotation (Placement(transformation(extent=
                {{-118,-78},{-100,-60}}), iconTransformation(extent={{-118,-78},{-100,
                -60}})));
      Modelica.Blocks.Interfaces.RealInput p_in_port_a "Prescribed pressure"
        annotation (Placement(transformation(extent={{-118,-38},{-100,-20}}),
            iconTransformation(extent={{-118,-38},{-100,-20}})));
      Modelica.Blocks.Interfaces.RealInput m_in_port_b "Prescribed pressure"
        annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=90,
            origin={-78,-108}), iconTransformation(
            extent={{-8,-8},{8,8}},
            rotation=90,
            origin={-94,-108})));
      Modelica.Blocks.Interfaces.RealInput h_in_port_b "Prescribed pressure"
        annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=90,
            origin={-58,-108}), iconTransformation(
            extent={{-8,-8},{8,8}},
            rotation=90,
            origin={-74,-108})));
      Modelica.Blocks.Interfaces.RealInput X_in_port_b[size(massFlowToPressure.X_in,
        1)] "Prescribed mass fractions" annotation (Placement(transformation(
            extent={{-9,-9},{9,9}},
            rotation=90,
            origin={-39,-109}), iconTransformation(
            extent={{-8,-8},{8,8}},
            rotation=90,
            origin={-56,-108})));
      Modelica.Blocks.Interfaces.RealInput C_in_port_b[size(massFlowToPressure.C_in,
        1)] "Prescribed mass fractions" annotation (Placement(transformation(
            extent={{-9,-9},{9,9}},
            rotation=90,
            origin={-23,-109}), iconTransformation(
            extent={{-8,-8},{8,8}},
            rotation=90,
            origin={-34,-108})));
      Modelica.Blocks.Interfaces.RealOutput m_flow_out_port_a annotation (Placement(
            transformation(extent={{-100,42},{-124,66}}), iconTransformation(extent=
               {{-100,42},{-124,66}})));
      Modelica.Blocks.Interfaces.RealOutput X_out_port_a[size(pressureToMassFlow.X_out,
        1)] "Prescribed traces" annotation (Placement(transformation(extent={{-100,
                70},{-124,94}}), iconTransformation(extent={{-100,70},{-124,94}})));
      Modelica.Blocks.Interfaces.RealOutput h_out_port_a annotation (Placement(
            transformation(extent={{-100,12},{-124,36}}), iconTransformation(extent=
               {{-100,12},{-124,36}})));
      Modelica.Blocks.Interfaces.RealOutput C_out_port_a[size(pressureToMassFlow.C_out,
        1)] "Prescribed Mass Fractions" annotation (Placement(transformation(extent=
               {{-100,-4},{-124,20}}), iconTransformation(extent={{-100,-4},{-124,
                20}})));
      Modelica.Blocks.Interfaces.RealOutput p_out_port_b annotation (Placement(
            transformation(
            extent={{-12,-12},{12,12}},
            rotation=-90,
            origin={8,-112}), iconTransformation(
            extent={{12,-12},{-12,12}},
            rotation=90,
            origin={32,-112})));
      Modelica.Blocks.Interfaces.RealOutput h_out_port_b annotation (Placement(
            transformation(
            extent={{-12,-12},{12,12}},
            rotation=-90,
            origin={30,-112}), iconTransformation(
            extent={{12,-12},{-12,12}},
            rotation=90,
            origin={4,-112})));
      Modelica.Blocks.Interfaces.RealOutput C_out_port_b[size(massFlowToPressure.C_out,
        1)] "Prescribed Flows" annotation (Placement(transformation(
            extent={{12,-12},{-12,12}},
            rotation=90,
            origin={92,-112}), iconTransformation(
            extent={{12,-12},{-12,12}},
            rotation=90,
            origin={60,-112})));
      Modelica.Blocks.Interfaces.RealOutput X_out_port_b[size(massFlowToPressure.X_out,
        1)] "Prescribed Traces" annotation (Placement(transformation(
            extent={{12,-12},{-12,12}},
            rotation=90,
            origin={60,-112}), iconTransformation(
            extent={{12,-12},{-12,12}},
            rotation=90,
            origin={88,-112})));
    equation

      connect(source1.ports[1], BOP.port_a3[1]) annotation (Line(points={{36,-56},{
              0,-56},{0,-30}},      color={0,127,255}));
      connect(BOP.portElec_b, sinkElec.port)
        annotation (Line(points={{42,0},{70,0}}, color={255,0,0}));
      connect(realExpression2.y, Power)
        annotation (Line(points={{83,60},{112,60}}, color={0,0,127}));
      connect(realExpression3.y, freq) annotation (Line(points={{85,28},{88,28},{88,
              20},{112,20}}, color={0,0,127}));
      connect(BOP.port_b, massFlowToPressure.fluidPort) annotation (Line(points={{-18,-12},
              {-34,-12},{-34,-44},{-18,-44},{-18,-58}},color={0,127,255}));
      connect(BOP.port_a, pressureToMassFlow.fluidPort) annotation (Line(points={{-18,12},
              {-48,12},{-48,6.2},{-49.8,6.2}},           color={0,127,255}));
      connect(pressureToMassFlow.C_in, C_in_port_a) annotation (Line(points={{-72,-18},
              {-72,-91},{-109,-91}}, color={0,0,127}));
      connect(pressureToMassFlow.p_in, p_in_port_a) annotation (Line(points={{-72,0},
              {-102,0},{-102,-29},{-109,-29}}, color={0,0,127}));
      connect(m_in_port_b, massFlowToPressure.m_flow_in) annotation (Line(points={{
              -78,-108},{-78,-98},{-42,-98},{-42,-80}}, color={0,0,127}));
      connect(pressureToMassFlow.h_out, h_out_port_a)
        annotation (Line(points={{-72,24},{-112,24}}, color={0,0,127}));
      connect(C_in_port_b, massFlowToPressure.C_in) annotation (Line(points={{-23,-109},
              {-23,-100},{-24,-100},{-24,-80}}, color={0,0,127}));
      connect(X_in_port_b, massFlowToPressure.X_in) annotation (Line(points={{-39,-109},
              {-39,-98},{-30,-98},{-30,-80}}, color={0,0,127}));
      connect(h_in_port_b, massFlowToPressure.h_in) annotation (Line(points={{-58,-108},
              {-58,-100},{-36,-100},{-36,-80}}, color={0,0,127}));
      connect(X_in_port_a, pressureToMassFlow.X_in) annotation (Line(points={{-109,
              -49},{-96,-49},{-96,-12},{-72,-12}}, color={0,0,127}));
      connect(h_in_port_a, pressureToMassFlow.h_in) annotation (Line(points={{-109,
              -69},{-96,-69},{-96,-6},{-72,-6}}, color={0,0,127}));
      connect(pressureToMassFlow.C_out, C_out_port_a) annotation (Line(points={{-72,
              12},{-86,12},{-86,8},{-112,8}}, color={0,0,127}));
      connect(pressureToMassFlow.m_flow_out, m_flow_out_port_a) annotation (Line(
            points={{-72,30},{-90,30},{-90,54},{-112,54}}, color={0,0,127}));
      connect(massFlowToPressure.p_out, p_out_port_b) annotation (Line(points={{-12,
              -80},{-12,-94},{8,-94},{8,-112}}, color={0,0,127}));
      connect(massFlowToPressure.h_out, h_out_port_b) annotation (Line(points={{-6,
              -80},{-6,-94},{30,-94},{30,-112}}, color={0,0,127}));
      connect(X_out_port_b, massFlowToPressure.X_out) annotation (Line(points={{60,
              -112},{60,-94},{0,-94},{0,-80}}, color={0,0,127}));
      connect(C_out_port_b, massFlowToPressure.C_out) annotation (Line(points={{92,
              -112},{92,-94},{6,-94},{6,-80}}, color={0,0,127}));
      connect(pressureToMassFlow.X_out, X_out_port_a) annotation (Line(points={{-72,
              18},{-80,18},{-80,82},{-112,82}}, color={0,0,127}));
      annotation (experiment(
          StopTime=1000,
          __Dymola_NumberOfIntervals=1000,
          __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Created by: Konor Frick </p>
<p>Date: 10/28/2020</p>
<p>Creation of FMU/FMU using the FMI Utility adaptor system.  This unit can be exported as an FMI/FMU in either model exchange or co-simulation mode.</p>
<p>Reference: K Frick, A. Alfonsi, C. Rabiti, S. Bragg-Sitton. &quot;Development of the IES Plug and Play Framework&quot;. Idaho National Laboratory. INL/EXT-21-62050.</p>
</html>"));
    end SteamTurbine_L1_FMU_adaptor;
  end Example_FMU_construction;

  model SteamTurbine_L1_boundaries_Test_a
    import NHES;
    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries
      BOP(
      nPorts_a3=1,
      port_a3_nominal_m_flow={10},
      port_a_nominal(
        m_flow=493.7058,
        p=5550000,
        h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
      port_b_nominal(p=1000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
            318.95)),
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_PressureAndPowerControl
        CS(p_nominal=BOP.port_a_nominal.p, W_totalSetpoint=sine.y))
      annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
    TRANSFORM.Electrical.Sources.FrequencySource
                                       sinkElec(f=60)
      annotation (Placement(transformation(extent={{90,-10},{70,10}})));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      p(displayUnit="MPa") = BOP.port_b_nominal.p,
      T(displayUnit="K") = BOP.port_b_nominal.T)
      annotation (Placement(transformation(extent={{-88,-2},{-68,-22}})));
    Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-40,-22},{-60,-2}})));
    Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
    Fluid.Sensors.stateDisplay stateDisplay
      annotation (Placement(transformation(extent={{-72,-60},{-28,-30}})));
    Fluid.Sensors.stateDisplay stateDisplay1
      annotation (Placement(transformation(extent={{-72,20},{-28,50}})));
    Modelica.Fluid.Sources.MassFlowSource_h source1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      use_m_flow_in=false,
      m_flow=10,
      h=3e6)
      annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
    Modelica.Fluid.Sources.Boundary_ph      source(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      p=BOP.port_a_nominal.p,
      h=BOP.port_a_nominal.h,
      use_p_in=true)
      annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
    Modelica.Blocks.Sources.Sine sine(
      f=1/200,
      offset=4e8,
      startTime=350,
      amplitude=2e8)
      annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
    Modelica.Blocks.Sources.Pulse pulse(
      period=100,
      startTime=10,
      offset=BOP.port_a_nominal.p,
      amplitude=0.5*BOP.port_a_nominal.p)
      annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  equation

    connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
          points={{-50,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
    connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
          points={{-50,-48.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
    connect(sink.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-12},
            {-64,-12},{-60,-12}}, color={0,127,255}));
    connect(stateSensor.port_a, BOP.port_b)
      annotation (Line(points={{-40,-12},{-30,-12}}, color={0,127,255}));
    connect(stateSensor1.port_b, BOP.port_a)
      annotation (Line(points={{-40,12},{-30,12}}, color={0,127,255}));
    connect(source1.ports[1], BOP.port_a3[1]) annotation (Line(points={{-20,-80},
            {-12,-80},{-12,-30}}, color={0,127,255}));
    connect(source.ports[1], stateSensor1.port_a)
      annotation (Line(points={{-68,12},{-60,12}}, color={0,127,255}));
    connect(pulse.y, source.p_in)
      annotation (Line(points={{-99,20},{-90,20}}, color={0,0,127}));
    connect(BOP.portElec_b, sinkElec.port)
      annotation (Line(points={{30,0},{70,0}}, color={255,0,0}));
    annotation (experiment(StopTime=500));
  end SteamTurbine_L1_boundaries_Test_a;

  model SteamTurbine_L1_boundaries_Test_b
    import NHES;
    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries
      BOP(
      nPorts_a3=1,
      port_a3_nominal_m_flow={10},
      port_a_nominal(
        m_flow=493.7058,
        p=5550000,
        h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
      port_b_nominal(p=1000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
            318.95)),
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_PressureAndPowerControl
        CS(p_nominal=BOP.port_a_nominal.p, W_totalSetpoint=sine.y))
      annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
    TRANSFORM.Electrical.Sources.FrequencySource
                                       sinkElec(f=60)
      annotation (Placement(transformation(extent={{90,-10},{70,10}})));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      p(displayUnit="MPa") = BOP.port_b_nominal.p,
      T(displayUnit="K") = BOP.port_b_nominal.T)
      annotation (Placement(transformation(extent={{-88,-2},{-68,-22}})));
    Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-40,-22},{-60,-2}})));
    Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
    Fluid.Sensors.stateDisplay stateDisplay
      annotation (Placement(transformation(extent={{-72,-60},{-28,-30}})));
    Fluid.Sensors.stateDisplay stateDisplay1
      annotation (Placement(transformation(extent={{-72,20},{-28,50}})));
    Modelica.Fluid.Sources.MassFlowSource_h source1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      use_m_flow_in=false,
      m_flow=10,
      h=3e6)
      annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
    Modelica.Blocks.Sources.Sine sine(
      f=1/200,
      offset=4e8,
      startTime=350,
      amplitude=2e8)
      annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
    Modelica.Fluid.Sources.MassFlowSource_T source(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      m_flow=BOP.port_a_nominal.m_flow,
      T(displayUnit="K") = BOP.port_a_nominal.T,
      use_m_flow_in=true)
      annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
    Modelica.Blocks.Sources.Pulse pulse(
      period=100,
      startTime=10,
      offset=BOP.port_a_nominal.m_flow,
      amplitude=0.8*BOP.port_a_nominal.m_flow)
      annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  equation

    connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
          points={{-50,31.1},{-50,31.1},{-50,12.05},{-49.95,12.05}}, color={0,0,0}));
    connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
          points={{-50,-48.9},{-50,-11.95},{-50.05,-11.95}}, color={0,0,0}));
    connect(sink.ports[1], stateSensor.port_b) annotation (Line(points={{-68,-12},
            {-64,-12},{-60,-12}}, color={0,127,255}));
    connect(stateSensor.port_a, BOP.port_b)
      annotation (Line(points={{-40,-12},{-30,-12}}, color={0,127,255}));
    connect(stateSensor1.port_b, BOP.port_a)
      annotation (Line(points={{-40,12},{-30,12}}, color={0,127,255}));
    connect(source1.ports[1], BOP.port_a3[1]) annotation (Line(points={{-20,-80},
            {-12,-80},{-12,-30}}, color={0,127,255}));
    connect(source.ports[1], stateSensor1.port_a)
      annotation (Line(points={{-68,12},{-60,12}}, color={0,127,255}));
    connect(pulse.y, source.m_flow_in)
      annotation (Line(points={{-99,20},{-88,20}}, color={0,0,127}));
    connect(BOP.portElec_b, sinkElec.port)
      annotation (Line(points={{30,0},{70,0}}, color={255,0,0}));
    annotation (experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000));
  end SteamTurbine_L1_boundaries_Test_b;

  model SteamTurbine_L2_ClosedFeedHeat_Test_a
    import NHES;

    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_L2_ClosedFeedHeat
      BOP(
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp
        CS(data(Q_Nom=45e6)),
      redeclare replaceable Data.Turbine_2 data(
        V_tee=50,
        valve_TCV_mflow=150,
        valve_TCV_dp_nominal=100000,
        valve_TBV_mflow=4,
        valve_TBV_dp_nominal=2000000,
        InternalBypassValve_p_spring=6500000,
        InternalBypassValve_K(unit="1/(m.kg)"),
        InternalBypassValve_tau(unit="1/s"),
        MainFeedHeater_K_tube(unit="1/m4"),
        MainFeedHeater_K_shell(unit="1/m4"),
        BypassFeedHeater_K_tube(unit="1/m4"),
        BypassFeedHeater_K_shell(unit="1/m4")),
      port_a_nominal(
        m_flow=67,
        p=3400000,
        h=3e6),
      port_b_nominal(p=3500000, h=1e6),
      init(
        tee_p_start=800000,
        moisturesep_p_start=700000,
        FeedwaterMixVolume_p_start=100000,
        HPT_T_b_start=578.15,
        MainFeedHeater_p_start_shell=100000,
        MainFeedHeater_h_start_shell_inlet=2e6,
        MainFeedHeater_h_start_shell_outlet=1.8e6,
        MainFeedHeater_dp_init_shell=90000,
        MainFeedHeater_m_start_tube=67,
        MainFeedHeater_m_start_shell=67,
        BypassFeedHeater_h_start_tube_inlet=1.1e6,
        BypassFeedHeater_h_start_tube_outlet=1.2e6,
        BypassFeedHeater_m_start_tube=67,
        BypassFeedHeater_m_start_shell=4))
      annotation (Placement(transformation(extent={{0,-30},{60,30}})));
    TRANSFORM.Electrical.Sources.FrequencySource
                                       sinkElec(f=60)
      annotation (Placement(transformation(extent={{90,-10},{70,10}})));
    Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-18,-22},{-38,-2}})));
    Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-38,2},{-18,22}})));
    Fluid.Sensors.stateDisplay stateDisplay
      annotation (Placement(transformation(extent={{-52,-60},{-8,-30}})));
    Fluid.Sensors.stateDisplay stateDisplay1
      annotation (Placement(transformation(extent={{-52,30},{-6,60}})));
    Modelica.Blocks.Sources.Sine sine(
      f=1/200,
      offset=4e8,
      startTime=350,
      amplitude=2e8)
      annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
    NHES.Fluid.Pipes.StraightPipe_withWall pipe(
      redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      p_a_start=3400000,
      p_b_start=3500000,
      use_Ts_start=false,
      T_a_start=421.15,
      T_b_start=579.15,
      h_a_start=3.6e6,
      h_b_start=1.2e6,
      m_flow_a_start=67,
      length=10,
      diameter=1,
      redeclare package Wall_Material = NHES.Media.Solids.SS316,
      th_wall=0.001) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-60,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary(use_port=
          true, Q_flow=500e6)
      annotation (Placement(transformation(extent={{-96,-10},{-76,10}})));
    Modelica.Blocks.Sources.Pulse pulse(
      amplitude=10e6,
      period=5000,
      offset=170e6,
      startTime=3000)
      annotation (Placement(transformation(extent={{-118,-10},{-98,10}})));
  equation

    connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
          points={{-29,41.1},{-29,30},{-28,30},{-28,14},{-27.95,14},{-27.95,12.05}},
                                                                     color={0,0,0}));
    connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
          points={{-30,-48.9},{-30,-32},{-28,-32},{-28,-11.95},{-28.05,-11.95}},
                                                             color={0,0,0}));
    connect(stateSensor.port_a, BOP.port_b)
      annotation (Line(points={{-18,-12},{0,-12}},   color={0,127,255}));
    connect(stateSensor1.port_b, BOP.port_a)
      annotation (Line(points={{-18,12},{0,12}},   color={0,127,255}));
    connect(BOP.portElec_b, sinkElec.port)
      annotation (Line(points={{60,0},{70,0}}, color={255,0,0}));
    connect(stateSensor.port_b, pipe.port_a) annotation (Line(points={{-38,-12},{-46,
            -12},{-46,-14},{-60,-14},{-60,-10}}, color={0,127,255}));
    connect(pipe.port_b, stateSensor1.port_a)
      annotation (Line(points={{-60,10},{-60,12},{-38,12}}, color={0,127,255}));
    connect(boundary.port, pipe.heatPorts[1])
      annotation (Line(points={{-76,0},{-64.4,0},{-64.4,0.1}}, color={191,0,0}));
    connect(pulse.y, boundary.Q_flow_ext)
      annotation (Line(points={{-97,0},{-90,0}}, color={0,0,127}));
    annotation (experiment(
        StopTime=300,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"));
  end SteamTurbine_L2_ClosedFeedHeat_Test_a;

  model SteamTurbine_L2_ClosedFeedHeat_Test_b
    import NHES;

    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_L2_ClosedFeedHeat
      BOP(
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_SteamTurbine_L2_PressurePowerFeedtemp
        CS,
      redeclare replaceable Data.Turbine_2 data(
        V_tee=50,
        valve_TCV_mflow=150,
        valve_TCV_dp_nominal=100000,
        valve_TBV_mflow=4,
        valve_TBV_dp_nominal=2000000,
        InternalBypassValve_p_spring=6500000,
        InternalBypassValve_K(unit="1/(m.kg)"),
        InternalBypassValve_tau(unit="1/s"),
        MainFeedHeater_K_tube(unit="1/m4"),
        MainFeedHeater_K_shell(unit="1/m4"),
        BypassFeedHeater_K_tube(unit="1/m4"),
        BypassFeedHeater_K_shell(unit="1/m4")),
      port_a_nominal(
        m_flow=67,
        p=3400000,
        h=3e6),
      port_b_nominal(p=3500000, h=1e6),
      init(
        tee_p_start=800000,
        moisturesep_p_start=700000,
        FeedwaterMixVolume_p_start=100000,
        HPT_T_b_start=578.15,
        MainFeedHeater_p_start_shell=100000,
        MainFeedHeater_h_start_shell_inlet=2e6,
        MainFeedHeater_h_start_shell_outlet=1.8e6,
        MainFeedHeater_dp_init_shell=90000,
        MainFeedHeater_m_start_tube=67,
        MainFeedHeater_m_start_shell=67,
        BypassFeedHeater_h_start_tube_inlet=1.1e6,
        BypassFeedHeater_h_start_tube_outlet=1.2e6,
        BypassFeedHeater_m_start_tube=67,
        BypassFeedHeater_m_start_shell=4))
      annotation (Placement(transformation(extent={{0,-30},{60,30}})));
    TRANSFORM.Electrical.Sources.FrequencySource
                                       sinkElec(f=60)
      annotation (Placement(transformation(extent={{90,-10},{70,10}})));
    Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-18,-22},{-38,-2}})));
    Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-38,2},{-18,22}})));
    Fluid.Sensors.stateDisplay stateDisplay
      annotation (Placement(transformation(extent={{-52,-60},{-8,-30}})));
    Fluid.Sensors.stateDisplay stateDisplay1
      annotation (Placement(transformation(extent={{-52,30},{-6,60}})));
    Modelica.Blocks.Sources.Sine sine(
      f=1/200,
      offset=4e8,
      startTime=350,
      amplitude=2e8)
      annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      nPorts=1,
      p(displayUnit="bar") = 3400000,
      T(displayUnit="degC") = 579.15)
      annotation (Placement(transformation(extent={{-80,22},{-60,2}})));
    Modelica.Fluid.Sources.Boundary_pT sink1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      nPorts=1,
      p(displayUnit="bar") = 3400000,
      T(displayUnit="degC") = 421.15)
      annotation (Placement(transformation(extent={{-80,-6},{-60,-26}})));
  equation

    connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
          points={{-29,41.1},{-29,30},{-28,30},{-28,14},{-27.95,14},{-27.95,12.05}},
                                                                     color={0,0,0}));
    connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
          points={{-30,-48.9},{-30,-32},{-28,-32},{-28,-11.95},{-28.05,-11.95}},
                                                             color={0,0,0}));
    connect(stateSensor.port_a, BOP.port_b)
      annotation (Line(points={{-18,-12},{0,-12}},   color={0,127,255}));
    connect(stateSensor1.port_b, BOP.port_a)
      annotation (Line(points={{-18,12},{0,12}},   color={0,127,255}));
    connect(BOP.portElec_b, sinkElec.port)
      annotation (Line(points={{60,0},{70,0}}, color={255,0,0}));
    connect(sink.ports[1], stateSensor1.port_a)
      annotation (Line(points={{-60,12},{-38,12}}, color={0,127,255}));
    connect(sink1.ports[1], stateSensor.port_b) annotation (Line(points={{-60,-16},
            {-44,-16},{-44,-12},{-38,-12}}, color={0,127,255}));
    annotation (experiment(
        StopTime=300,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"));
  end SteamTurbine_L2_ClosedFeedHeat_Test_b;

  model SteamTurbine_OpenFeedHeat_DivertPowerControl_Test
    "TES use case demonstration of a NuScale-style LWR operating within an energy arbitrage IES, storing and dispensing energy on demand from a two tank molten salt energy storage system nominally using HITEC salt to store heat."
   // parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   // parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   parameter Modelica.Units.SI.Time timeScale=60*60
      "Time scale of first table column";
   parameter String fileName=Modelica.Utilities.Files.loadResource(
      "modelica://NHES/Resources/Data/RAVEN/DMM_Dissertation_Demand.txt")
    "File where matrix is stored";
      replaceable package Storage_Medium =
        TRANSFORM.Media.Fluids.Therminol_66.TableBasedTherminol66 constrainedby
      Modelica.Media.Interfaces.PartialMedium                                                                           annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);

      replaceable package Charging_Medium =
        Modelica.Media.Water.StandardWater                                     constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab="General",
          group="Mediums"), choicesAllMatching=true);

      replaceable package Discharging_Medium =
        Modelica.Media.Water.StandardWater                                          constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (Dialog(tab="General",
          group="Mediums"), choicesAllMatching=true);

  //  Real demandChange=
  //  min(1.05,
  //  max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
  //      + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
  //      0.5));

    NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
      annotation (Placement(transformation(extent={{60,38},{100,82}})));
    NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{120,40},{160,80}})));
    NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(
          displayUnit="MW") = 53303300, BOP_capacity(displayUnit="MW")=
        1165000000)
      annotation (Placement(transformation(extent={{100,-62},{120,-42}})));
    NHES.Systems.SupervisoryControl.InputSetpointData SC(
      delayStart=0,
      W_nominal_BOP(displayUnit="MW") = 50000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Nominal_50_timeSeries.txt"))
      annotation (Placement(transformation(extent={{120,-62},{160,-22}})));

    TRANSFORM.Electrical.Sensors.PowerSensor sensorW
      annotation (Placement(transformation(extent={{104,54},{116,66}})));

    NHES.Fluid.Sensors.stateSensor stateSensor5(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{30,22},{44,38}})));
    NHES.Systems.EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(
      port_a1_nominal(
        p(displayUnit="Pa") = 3.398e6,
        h=2.99767e6,
        m_flow=67.07),
      port_b1_nominal(p=3447380, h=629361),
      port_b3_nominal_m_flow={-0.67},
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-60,40},{-20,80}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_OpenFeedHeat_DivertPowerControl
      BOP(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_DivertPowerControl_ANL_v2
        CS(electric_demand_large=MW_W_Gain_BOP.y, data(Q_Nom=49e6)))
      annotation (Placement(transformation(extent={{6,40},{46,80}})));
    NHES.Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-80,60},{-66,76}})));
    NHES.Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-14,60},{0,76}})));
    NHES.Fluid.Sensors.stateSensor stateSensor3(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-66,44},{-80,60}})));
    Modelica.Fluid.Sources.Boundary_pT sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      nPorts=1,
      p(displayUnit="bar") = 3400000,
      T(displayUnit="degC") = 421.15)
      annotation (Placement(transformation(extent={{-120,60},{-104,44}})));
    Modelica.Fluid.Sources.MassFlowSource_T SteamSource(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=67.53,
      T(displayUnit="K") = 581.24,
      nPorts=1)
      annotation (Placement(transformation(extent={{-120,58},{-100,78}})));
    NHES.Fluid.Sensors.stateSensor stateSensor4(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-20,22},{-6,38}})));
    Modelica.Fluid.Sources.MassFlowSource_h Storage_Med_Source(
      redeclare package Medium = Storage_Medium,
      use_m_flow_in=false,
      m_flow=400,
      h=257097,
      nPorts=1) annotation (Placement(transformation(extent={{80,2},{60,22}})));
    Modelica.Fluid.Sources.Boundary_pT Oil_Sink(
      redeclare package Medium = Storage_Medium,
      use_p_in=false,
      p(displayUnit="bar") = 130000,
      T(displayUnit="degC") = 523.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-40,20},{-24,4}})));
    NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                                        CHX(
      shell_av_b=true,
      use_derQ=true,
      tau=1,
      NTU=20,
      K_tube=1000,
      K_shell=1000,
      redeclare package Tube_medium = Storage_Medium,
      redeclare package Shell_medium = Charging_Medium,
      V_Tube=10,
      V_Shell=25,
      use_T_start_tube=true,
      T_start_tube_inlet=573.15,
      T_start_tube_outlet=573.15,
      dp_init_tube=20000,
      Q_init=1)          annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={14,16})));
    NHES.Fluid.Sensors.stateSensor stateSensor6(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{50,4},{36,20}})));
    NHES.Fluid.Sensors.stateSensor stateSensor7(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-6,4},{-20,20}})));
    Modelica.Blocks.Sources.Pulse pulse_BOP(
      period=7200,
      offset=17,
      startTime=2500,
      amplitude=10)
      annotation (Placement(transformation(extent={{-106,4},{-94,16}})));
    Modelica.Blocks.Math.Add add_BOP
      annotation (Placement(transformation(extent={{-86,10},{-66,30}})));
    Modelica.Blocks.Math.Gain MW_W_Gain_BOP(k=1e6)
      annotation (Placement(transformation(extent={{-58,14},{-46,26}})));
    Modelica.Blocks.Interfaces.RealInput BOP_Demand_MW annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=0,
          origin={-106,26}), iconTransformation(extent={{-120,48},{-96,72}})));
    Modelica.Blocks.Interfaces.RealOutput BOP_Electric_Power
      annotation (Placement(transformation(extent={{112,16},{128,32}}),
          iconTransformation(extent={{128,68},{152,92}})));
    Modelica.Blocks.Interfaces.RealOutput BOP_Turbine_Pressure
      annotation (Placement(transformation(extent={{112,0},{128,16}}),
          iconTransformation(extent={{128,44},{152,68}})));
  equation
     BOP_Electric_Power = BOP.sensorW.W;
     BOP_Turbine_Pressure = BOP.HPT.portHP.p;

    connect(SY.port_Grid, sensorW.port_a)
      annotation (Line(points={{100,60},{104,60}},
                                                 color={255,0,0}));
    connect(sensorW.port_b, EG.portElec_a)
      annotation (Line(points={{116,60},{120,60}},
                                                 color={255,0,0}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{-20,52},{6,52}}, color={0,127,255}));
    connect(EM.port_b2,stateSensor2. port_a) annotation (Line(points={{-20,68},
            {-14,68}},                          color={0,127,255}));
    connect(stateSensor2.port_b, BOP.port_a)
      annotation (Line(points={{1.77636e-15,68},{6,68}}, color={0,127,255}));
    connect(EM.port_a1,stateSensor1. port_b)
      annotation (Line(points={{-60,68},{-66,68}}, color={0,127,255}));
    connect(EM.port_b1,stateSensor3. port_a)
      annotation (Line(points={{-60,52},{-66,52}}, color={0,127,255}));
    connect(stateSensor3.port_b,sink. ports[1]) annotation (Line(points={{-80,52},
            {-104,52}},                       color={0,127,255}));
    connect(SteamSource.ports[1],stateSensor1. port_a) annotation (Line(
          points={{-100,68},{-80,68}},                   color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1])
      annotation (Line(points={{46,60},{60,60}}, color={255,0,0}));
    connect(EM.port_b3[1], stateSensor4.port_a) annotation (Line(points={{-32,40},
            {-32,30},{-20,30}},                       color={0,127,255}));
    connect(BOP.port_a1, stateSensor5.port_b) annotation (Line(points={{13.2,40.8},
            {34,40.8},{34,34},{50,34},{50,30},{44,30}},       color={0,127,
            255}));
    connect(stateSensor4.port_b, CHX.Shell_in) annotation (Line(points={{-6,30},{0,
            30},{0,18},{4,18}},         color={0,127,255}));
    connect(CHX.Shell_out, stateSensor5.port_a) annotation (Line(points={{24,18},{
            26,18},{26,30},{30,30}},
                                  color={0,127,255}));
    connect(CHX.Tube_in, stateSensor6.port_b)
      annotation (Line(points={{24,12},{36,12}},  color={0,127,255}));
    connect(Storage_Med_Source.ports[1], stateSensor6.port_a)
      annotation (Line(points={{60,12},{50,12}}, color={0,127,255}));
    connect(CHX.Tube_out, stateSensor7.port_a)
      annotation (Line(points={{4,12},{-6,12}},      color={0,127,255}));
    connect(stateSensor7.port_b, Oil_Sink.ports[1])
      annotation (Line(points={{-20,12},{-24,12}},   color={0,127,255}));
    connect(add_BOP.y,MW_W_Gain_BOP. u)
      annotation (Line(points={{-65,20},{-59.2,20}}, color={0,0,127}));
    connect(BOP_Demand_MW,add_BOP. u1) annotation (Line(points={{-106,26},{-88,26}},
                                  color={0,0,127}));
    connect(pulse_BOP.y,add_BOP. u2) annotation (Line(points={{-93.4,10},{-88,10},
            {-88,14}},            color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
              -60},{160,100}}),  graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-54,-102},{146,98}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{16,62},{116,2},{16,-58},{16,62}})}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-120,-60},{160,100}})),
      experiment(
        StopTime=5000,
        Interval=10,
        Tolerance=1e-06,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>NuScale style reactor system. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: Frick, Konor L. Status Report on the NuScale Module Developed in the Modelica Framework. United States: N. p., 2019. Web. doi:10.2172/1569288.</p>
</html>"),
      __Dymola_experimentSetupOutput(events=false));
  end SteamTurbine_OpenFeedHeat_DivertPowerControl_Test;

end Examples;
