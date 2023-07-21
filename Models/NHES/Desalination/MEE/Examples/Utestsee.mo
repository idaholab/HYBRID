within NHES.Desalination.MEE.Examples;
model Utestsee "Test of a single effect with constant"

  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph cond_out(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    use_h_in=true,
    m_flow=1,
    h=2706.9e3,
    nPorts=1) annotation (Placement(transformation(extent={{-100,-10},{-80,
            10}})));

  Components.SEE_Tube_Side_Ue          sEE_Tube_Side_Ue(Ax=20)
    annotation (Placement(transformation(extent={{-42,-38},{38,42}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=inleth)
    annotation (Placement(transformation(extent={{-194,4},{-174,24}})));
  parameter Modelica.Blocks.Interfaces.RealOutput inleth=2706e3
    "Value of Real output";
  Modelica.Blocks.Sources.RealExpression
                               realExpression1(y=mdot)
    annotation (Placement(transformation(extent={{-194,-32},{-174,-12}})));

  parameter SI.MassFlowRate mdot=1 "Heat Transfer Area (Outside Tube Area)";
  Components.Evaporator_Brine_SHP_ss evaporator_Brine_SHP_ss(
    p=100000,
    T_st=363.15,
    h_b_in=900e3,
    Cs_in=0.03,
    Cs_out=0.1)
    annotation (Placement(transformation(extent={{-52,54},{28,134}})));
  Components.SEE_Tube_Side_Ue_portless sEE_Tube_Side_Ue_portless(
    Ax=10,
    h_input=evaporator_Brine_SHP_ss.h_steam,
    m_flow_input=-evaporator_Brine_SHP_ss.m_steam,
    p_input=100000)
    annotation (Placement(transformation(extent={{70,36},{90,56}})));
  Components.Evaporator_Brine_SHP_ss evaporator_Brine_SHP_ss1(
    p=70000,
    T_st=363.15,
    h_b_in=900e3,
    Cs_in=0.03,
    Cs_out=0.1)
    annotation (Placement(transformation(extent={{84,88},{132,136}})));
equation
  connect(realExpression.y, Tube_Inlet.h_in) annotation (Line(points={{-173,
          14},{-110,14},{-110,4},{-102,4}}, color={0,0,127}));
  connect(realExpression1.y, Tube_Inlet.m_flow_in) annotation (Line(points=
          {{-173,-22},{-112,-22},{-112,16},{-100,16},{-100,8}}, color={0,0,
          127}));
  connect(Tube_Inlet.ports[1], sEE_Tube_Side_Ue.port_a)
    annotation (Line(points={{-80,0},{-62,0},{-62,2},{-42,2}},
                                               color={0,127,255}));
  connect(sEE_Tube_Side_Ue.port_b, cond_out.ports[1])
    annotation (Line(points={{38,2},{60,2},{60,0},{80,0}},
                                             color={0,127,255}));
  connect(evaporator_Brine_SHP_ss.Heat_Port, sEE_Tube_Side_Ue.heat_port)
    annotation (Line(points={{-12,54},{-12,46},{-2,46},{-2,26}}, color={191,0,0}));
  connect(sEE_Tube_Side_Ue_portless.heat_port, evaporator_Brine_SHP_ss1.Heat_Port)
    annotation (Line(points={{80,52},{80,80},{108,80},{108,88}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),                               graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    experiment(
      StopTime=500,
      Interval=0.5,
      __Dymola_Algorithm="Esdirk45a"));
end Utestsee;
