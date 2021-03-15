within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model SteamTurbine_L1_FMU_adaptor
  import NHES;
  extends Modelica.Icons.Example;
  replaceable package Medium=Modelica.Media.Water.StandardWater;
  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries         BOP(
    redeclare package Medium = Medium,
    nPorts_a3=1,
    port_a_nominal(
      m_flow=67,
      p=3470000,
      h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
    port_b_nominal(p=1000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
          318.95)),
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.CS_OTSG_TCV_Pressure_TBV_Power_Control
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
<p>Note: I am not sure I have the adaptors right. But it works. May need to flip the adaptors.</p>
</html>"));
end SteamTurbine_L1_FMU_adaptor;
