within NHES.Systems.BalanceOfPlant.Turbine;
model IdealTurbine

  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable CS_Dummy CS,
    redeclare replaceable ED_Dummy ED,
    Q_balance(y=nParallel*condenser.Q_total),
    W_balance(y=-port_b.m_flow/800*(port_b.p - condenser.p)/0.8),
    port_a_nominal(
      p=5.55e6,
      T=591,
      m_flow=493.7058), port_b_nominal(p=1e6, T=318.95),
    redeclare Data.IdealTurbine data);

  parameter Real nParallel=8 "# of turbines in parallel";
  final parameter SI.MassFlowRate m_flow_nominal_perTurbine=port_a_nominal.m_flow
      /nParallel "Mass flow rate per turbine"
    annotation (Dialog(group="Nominal Conditions"));
  final parameter SI.MassFlowRate m_flow_start_perTurbine=port_a_start.m_flow/
      nParallel "Mass flow rate per turbine"
    annotation (Dialog(tab="Initialization"));

  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{16,10},{36,-10}})));
  ThermoPower.Water.Header toValve(
    redeclare package Medium = Medium,
    V=0.001,
    FluidPhaseStart=ThermoPower.Choices.FluidPhase.FluidPhases.Steam,
    pstart=port_a_start.p,
    hstart=port_a_start.h,
    Tmstart=port_a_start.T) "Small volume for proper model structure"
    annotation (Placement(transformation(extent={{-56,36},{-48,44}})));
  inner NHES.Fluid.System_TP system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Valves.ValveCompressible TCV(
    redeclare package Medium = Medium,
    opening_nominal=0.5,
    rho_nominal=Medium.density(Medium.setState_phX(
        port_a_nominal.p,
        port_a_nominal.h,
        {1})),
    m_flow_nominal=m_flow_nominal_perTurbine,
    p_nominal=port_a_nominal.p,
    dp_start=TCV.dp_nominal,
    m_flow_start=m_flow_start_perTurbine,
    dp_nominal=160000)
    annotation (Placement(transformation(extent={{-38,33},{-24,47}})));
  NHES.Fluid.Pipes.parallelFlow nFlow_down(redeclare package Medium = Medium,
      nParallel=nParallel)
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  NHES.Fluid.Pipes.parallelFlow nFlow_up(redeclare package Medium = Medium,
      nParallel=nParallel)
    annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
  NHES.Electrical.parallelElecPower nFlow_ElecPower(nParallel=nParallel)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  NHES.Fluid.Machines.SteamTurbineStodola steamTurbine(
    p_b_start=condenser.p,
    redeclare package Medium = Medium,
    p_a_start=port_a_start.p - TCV.dp_start,
    T_a_start=port_a_start.T,
    m_flow_start=m_flow_start_perTurbine,
    m_flow_nominal=m_flow_nominal_perTurbine,
    p_in_nominal=port_a_nominal.p,
    T_nominal=port_a_nominal.T,
    T_b_start=318.95)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  NHES.Fluid.Vessels.IdealCondenser condenser(redeclare package Medium = Medium,
      p=10000)
    annotation (Placement(transformation(extent={{17,-50},{37,-30}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal_perTurbine) annotation (Placement(
        transformation(
        extent={{-4.5,4.5},{4.5,-4.5}},
        rotation=-90,
        origin={-17.5,21.5})));
  NHES.Electrical.Generator generator1
    annotation (Placement(transformation(extent={{44,-10},{64,10}})));
  ThermoPower.Water.ThroughMassFlow pump(w0=m_flow_nominal_perTurbine,
      use_in_w0=true)
    annotation (Placement(transformation(extent={{-20,-50},{-40,-30}})));

  Modelica.Blocks.Math.Gain gain(k=nParallel) annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={18,26})));
equation
  connect(port_a, nFlow_down.port_a)
    annotation (Line(points={{-100,40},{-90,40}}, color={0,127,255}));
  connect(nFlow_down.port_b, toValve.inlet)
    annotation (Line(points={{-70,40},{-56.04,40}}, color={0,127,255}));
  connect(nFlow_up.port_a, port_b)
    annotation (Line(points={{-90,-40},{-100,-40}}, color={0,127,255}));
  connect(portElec_b, nFlow_ElecPower.singleFlow)
    annotation (Line(points={{100,0},{96,0},{90,0}}, color={255,0,0}));
  connect(toValve.outlet, TCV.port_a)
    annotation (Line(points={{-48,40},{-48,40},{-38,40}}, color={0,0,255}));
  connect(steamTurbine.shaft_b, powerSensor.flange_a)
    annotation (Line(points={{10,0},{16,0}}, color={0,0,0}));
  connect(steamTurbine.portLP, condenser.port_a) annotation (Line(points={{7,-10},
          {7,-20},{20,-20},{20,-30}}, color={0,127,255}));
  connect(TCV.port_b, massFlowRate.port_a) annotation (Line(points={{-24,40},{-17.5,
          40},{-17.5,26}}, color={0,127,255}));
  connect(massFlowRate.port_b, steamTurbine.portHP) annotation (Line(points={{-17.5,
          17},{-17.5,6},{-10,6}}, color={0,127,255}));
  connect(generator1.portElec, nFlow_ElecPower.parallelFlow)
    annotation (Line(points={{64,0},{70,0}}, color={255,0,0}));
  connect(generator1.shaft_a, powerSensor.flange_b)
    annotation (Line(points={{44,0},{44,0},{36,0}}, color={0,0,0}));
  connect(condenser.port_b, pump.inlet) annotation (Line(points={{27,-50},{27,-50},
          {27,-60},{0,-60},{0,-40},{-20,-40}}, color={0,127,255}));
  connect(nFlow_up.port_b, pump.outlet)
    annotation (Line(points={{-70,-40},{-40,-40}}, color={0,127,255}));
  connect(massFlowRate.m_flow, pump.in_w0) annotation (Line(points={{-22.45,21.5},
          {-26,21.5},{-26,-34}}, color={0,0,127}));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (
      Line(
      points={{30.1,100.1},{16,100.1},{0,100.1},{0,60},{-31,60},{-31,45.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(gain.u, powerSensor.power)
    annotation (Line(points={{18,21.2},{18,11}}, color={0,0,127}));
  connect(sensorBus.W_total, gain.y) annotation (Line(
      points={{-29.9,100.1},{18,100.1},{18,30.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (defaultComponentName="BOP", Icon(graphics={
        Rectangle(
          extent={{-0.578156,2.1722},{23.1262,-2.1722}},
          lineColor={0,0,0},
          origin={27.4218,-39.8278},
          rotation=180,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-1.81332,3},{66.1869,-3}},
          lineColor={0,0,0},
          origin={-14.1867,-1},
          rotation=0,
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.373344,2},{13.6267,-2}},
          lineColor={0,0,0},
          origin={24.3733,-56},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.4,3},{15.5,-3}},
          lineColor={0,0,0},
          origin={36.4272,-29},
          rotation=0,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-14,46},{12,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-64,46},{-16,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-24,49},{-6,31}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Ellipse(
          extent={{-13,49},{-17,31}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={162,162,0}),
        Rectangle(
          extent={{-24,63},{-6,61}},
          lineColor={0,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-14,49},{-16,61}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-16,3},{16,-3}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={10,30},
          rotation=-90),
        Polygon(
          points={{6,16},{6,-14},{36,-32},{36,36},{6,16}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-1.81329,5},{66.1867,-5}},
          lineColor={0,0,0},
          origin={-62.1867,-41},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Line(points={{10,-42}}, color={0,0,0}),
        Rectangle(
          extent={{-0.43805,2.7864},{15.9886,-2.7864}},
          lineColor={0,0,0},
          origin={49.2136,-41.9886},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Text(
          extent={{15,-8},{25,6}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Polygon(
          points={{4,-44},{0,-48},{16,-48},{12,-44},{4,-44}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Ellipse(
          extent={{2,-34},{14,-46}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{9,-37},{9,-43},{5,-40},{9,-37}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Ellipse(
          extent={{50,12},{78,-14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{59,-8},{69,6}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="G"),
        Rectangle(
          extent={{-0.487802,2},{19.5122,-2}},
          lineColor={0,0,0},
          origin={26,-38.4878},
          rotation=-90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{36,-42},{64,-68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{45,-62},{55,-48}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="C"),
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Ideal Turbine")}));
end IdealTurbine;
