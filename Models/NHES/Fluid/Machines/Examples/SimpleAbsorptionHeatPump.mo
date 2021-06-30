within NHES.Fluid.Machines.Examples;
model SimpleAbsorptionHeatPump
inner Modelica.Fluid.System system(
  energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
  momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
  m_flow_start=175,
  p_start(displayUnit="kPa") = 1000000,
  T_start=298.15)
  annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
  prescribedTemperature
  annotation (Placement(transformation(extent={{50,-80},{30,-60}})));
Modelica.Blocks.Sources.Constant const(k=25)
  annotation (Placement(transformation(extent={{80,-80},{60,-60}})));
Vessels.Absorber absorber_1(
  redeclare package Medium_v =
      Media.TwoPhaseMixtures.LithiumBromideWater.LithiumBromideWater_pTX,
  redeclare package Medium_sol =
      Media.TwoPhaseMixtures.LithiumBromideWater.LithiumBromideWater_pTX,
  D_pool(displayUnit="mm") = 0.4,
  d_sol(
    fixed=true,
    displayUnit="kg/m3",
    start=1717),
  m_sol(start=20, fixed=true),
  X_sol(start=0.5938, fixed=false),
  T_sat_sol(start=298.15, fixed=false))
  annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
Modelica.Fluid.Sources.MassFlowSource_T boundary1(
  redeclare package Medium =
      Media.TwoPhaseMixtures.LithiumBromideWater.LithiumBromideWater_pTX,
  use_m_flow_in=false,
  use_T_in=false,
  m_flow=15.59,
  T=623.15,
  X={0,1},
  nPorts=1)
  annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=0,
      origin={-50,-50})));
Modelica.Fluid.Machines.ControlledPump pump(
  redeclare package Medium =
     Media.TwoPhaseMixtures.LithiumBromideWater.LithiumBromideWater_pTX,
  p_a_start(displayUnit="kPa") = 285,
  p_b_start(displayUnit="kPa") = 1239000,
  m_flow_start=171.8,
  redeclare function flowCharacteristic =
      Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.linearFlow (
       V_flow_nominal={0.01,0.1008}, head_nominal={74.1,74.08}),
  redeclare function efficiencyCharacteristic =
      Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
        (
       eta_nominal=0.99),
  V(displayUnit="l") = 0.001,
  energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  T_start=298.15,
  X_start={0.5938,1 - 0.5938},
  p_a_nominal(displayUnit="Pa") = 285,
  p_b_nominal(displayUnit="kPa") = 1239000,
  m_flow_nominal=171.8,
  control_m_flow=true) annotation (Placement(transformation(
      extent={{-10,10},{10,-10}},
      rotation=90,
      origin={-10,-10})));
Modelica.Fluid.Valves.ValveIncompressible valveIncompressible(
  redeclare package Medium =
      Media.TwoPhaseMixtures.LithiumBromideWater.LithiumBromideWater_pTX,
  dp_start(displayUnit="kPa") = 1239 - 0.285,
  m_flow_start=156.21,
  CvData=Modelica.Fluid.Types.CvTypes.Cv,
  Cv=137.1,
  dp_nominal(displayUnit="kPa") = 1239000 - 285,
  m_flow_nominal=156.21,
  filteredOpening=false,
  redeclare function valveCharacteristic =
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.one)
  annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=270,
      origin={30,-10})));
HeatExchangers.Generic_HXs.recuperator_simple recuperator_simple1
  annotation (Placement(transformation(extent={{0,20},{20,40}})));
Vessels.Desorber desorber_1(
  D_pool(displayUnit="mm") = 0.4,
  m_sol(start=20),
  d_sol(displayUnit="kg/m3", start=1750),
  X_sol(start=0.653),
  T_sat_sol(start=545.65))
  annotation (Placement(transformation(extent={{0,50},{20,70}})));
Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
  prescribedTemperature1
  annotation (Placement(transformation(extent={{50,70},{30,90}})));
Modelica.Blocks.Sources.Constant const2(k=272.5)
  annotation (Placement(transformation(extent={{80,70},{60,90}})));
Modelica.Fluid.Sources.MassFlowSource_T boundary3(
  redeclare package Medium =
      Media.TwoPhaseMixtures.LithiumBromideWater.LithiumBromideWater_pTX,
  use_m_flow_in=false,
  use_T_in=false,
  m_flow=-15.59,
  T=528.45,
  X={0,1},
  nPorts=1)
  annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=0,
      origin={-50,60})));
Modelica.Blocks.Sources.Constant const1(k=1)
  annotation (Placement(transformation(extent={{70,-20},{50,0}})));
equation
connect(const.y, prescribedTemperature.T)
  annotation (Line(points={{59,-70},{52,-70}},   color={0,0,127}));
connect(prescribedTemperature.port, absorber_1.port_Q) annotation (
   Line(points={{30,-70},{10,-70},{10,-60}},  color={191,0,0}));
connect(recuperator_simple1.port_ho, valveIncompressible.port_a)
  annotation (Line(points={{16,20},{16,10},{30,10},{30,0}},  color={0,127,
        255}));
connect(pump.port_b, recuperator_simple1.port_ci) annotation (Line(points={{-10,0},
        {-10,10},{4,10},{4,20}},          color={0,127,255}));
connect(desorber_1.port_a, recuperator_simple1.port_co)
  annotation (Line(points={{4,50},{4,40}}, color={0,127,255}));
connect(desorber_1.port_b, recuperator_simple1.port_hi)
  annotation (Line(points={{16,50},{16,40}}, color={0,127,255}));
connect(desorber_1.port_Q, prescribedTemperature1.port)
  annotation (Line(points={{10,70},{10,80},{30,80}},
      color={191,0,0}));
connect(prescribedTemperature1.T, const2.y)
  annotation (Line(points={{52,80},{59,80}}, color={0,0,127}));
connect(boundary3.ports[1], desorber_1.port_v)
  annotation (Line(points={{-40,60},{0,60}}, color={0,127,255}));
connect(boundary1.ports[1], absorber_1.port_v)
  annotation (Line(points={{-40,-50},{0,-50}}, color={0,127,255}));
connect(valveIncompressible.opening, const1.y)
  annotation (Line(points={{38,-10},{49,-10}},
                                           color={0,0,127}));
connect(pump.port_a, absorber_1.port_b) annotation (Line(points={{
        -10,-20},{-10,-30},{4,-30},{4,-40}}, color={0,127,255}));
connect(absorber_1.port_a, valveIncompressible.port_b) annotation (
   Line(points={{16,-40},{16,-30},{30,-30},{30,-20}}, color={0,127,255}));
annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
      coordinateSystem(preserveAspectRatio=false)),
  experiment(
    StopTime=1000,
    __Dymola_NumberOfIntervals=10000,
    Tolerance=1e-06,
    __Dymola_Algorithm="Esdirk45a"));
end SimpleAbsorptionHeatPump;
