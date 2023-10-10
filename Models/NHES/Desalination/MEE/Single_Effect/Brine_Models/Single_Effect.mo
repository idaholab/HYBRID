within NHES.Desalination.MEE.Single_Effect.Brine_Models;
model Single_Effect
  "Single effect evaporator for desalination, uses heat transfer correlations to calc heat exchange"

  parameter Modelica.Units.SI.Volume V=1 annotation(Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Area A=1 annotation(Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Temperature Tsys=350 "Evaporator T" annotation(Dialog(group="Evaporator Initialization"));
  parameter Modelica.Units.SI.MassFlowRate m_brine_out=1 "Nominal mass flow rate in brine exit valve"  annotation(Dialog(group="Valve"));
  parameter Modelica.Units.SI.AbsolutePressure dp=0.001e5
                                                         "Nominal pressure drop across the brine exit valve" annotation(Dialog(group="Valve"));
  parameter Modelica.Units.SI.Area Ax=1e4 annotation(Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Diameter Do=0.05 annotation(Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Thickness th=0.007 annotation(Dialog(group="Geometry"));
  parameter Modelica.Units.SI.AbsolutePressure pT=1e5 "Init Tube pressure"  annotation(Dialog(group="Heat Exchanger Initialization"));
  parameter Real KV=-0.03 annotation(Dialog(group="PID Control"));
  parameter Modelica.Units.SI.Time Ti=0.75 "Time constant of Integrator block"  annotation(Dialog(group="PID Control"));
  parameter Modelica.Units.SI.ThermalConductivity k=83
    "Thermal Conductivity of the Cladding"  annotation(Dialog(group="Geometry"));
  parameter Integer nV=5 "Number of Nodes in HX"  annotation(Dialog(group="Geometry"));

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow Brine_Inlet_Port(redeclare package
      Medium =         NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State Brine_Outlet_Port(redeclare
      package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State Steam_Outlet_Port(redeclare
      package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    Steam_Outlet_Resistance(R=1)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,46})));
  TRANSFORM.Controls.LimPID         PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=KV,
    Ti=Ti,
    Td=10,
    yMax=1,
    yMin=0,
    wp=1,
    wd=1) annotation (Placement(transformation(extent={{-32,54},{-52,74}})));
  Modelica.Blocks.Sources.RealExpression Level_Set(y=0.5) annotation (Placement(transformation(extent={{-4,54},{-24,74}})));
  MEE.Components.Evaporator_Brine_SHP Evaporator(
    redeclare package MediumB = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
    p_start=100000,
    T_st=Tsys,
    V=V,
    A=A) annotation (Placement(transformation(extent={{20,-20},{-20,20}})));

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tube_Inlet(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-108,-50},{-88,-30}}), iconTransformation(extent={{-108,
            -50},{-88,-30}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{92,-50},{112,-30}}), iconTransformation(extent={{92,-50},
            {112,-30}})));
  MEE.Components.SEE_Tube_Side_FilmBoiling sEE_Tube_Side(
    p_start=pT,
    Ax=Ax,
    Do=Do,
    th=th,
    k=k,
    nV=nV) annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_intlet_Resistance(
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_Outlet_Resistance(
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
    annotation (Placement(transformation(extent={{52,-50},{72,-30}})));
  NHES.Fluid.Valves.ValveLinear
                           valveLinear(
    redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
    dp_nominal=dp,
    m_flow_nominal=m_brine_out)
    annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));

equation

  connect(Brine_Inlet_Port, Brine_Inlet_Port)
    annotation (Line(points={{100,0},{100,0}}, color={0,127,255},
      thickness=0.5));
  connect(Level_Set.y, PID.u_s) annotation (Line(points={{-25,64},{-30,64}}, color={0,0,127},
      thickness=0.5));
  connect(Evaporator.RelLevel, PID.u_m) annotation (Line(points={{-22,14},{-42,14},
          {-42,52}},                   color={0,0,127},
      thickness=0.5));
  connect(Evaporator.steam_port, Steam_Outlet_Resistance.port_a)
    annotation (Line(points={{0,20},{-4.44089e-16,39}}, color={0,127,255},
      thickness=0.5));
  connect(Tube_Inlet,Tube_Inlet)
    annotation (Line(points={{-98,-40},{-98,-40}},   color={0,127,255},
      thickness=0.5));
  connect(sEE_Tube_Side.Steam_Inlet_Port, Tube_intlet_Resistance.port_b)
    annotation (Line(points={{-20,-40},{-53,-40}}, color={0,127,255},
      thickness=0.5));
  connect(Tube_Inlet, Tube_intlet_Resistance.port_a)
    annotation (Line(points={{-98,-40},{-67,-40}}, color={0,127,255},
      thickness=0.5));
  connect(sEE_Tube_Side.Liquid_Outlet_Port, Tube_Outlet_Resistance.port_a)
    annotation (Line(points={{20,-40},{55,-40}}, color={0,127,255},
      thickness=0.5));
  connect(Tube_Outlet, Tube_Outlet_Resistance.port_b)
    annotation (Line(points={{102,-40},{69,-40}}, color={0,127,255},
      thickness=0.5));
  connect(Evaporator.Brine_Inlet_port, Brine_Inlet_Port) annotation (Line(
        points={{20,0},{100,0}},               color={0,127,255},
      thickness=0.5));
  connect(sEE_Tube_Side.Heat_Port, Evaporator.Heat_Port)
    annotation (Line(points={{0,-30},{0,-20}}, color={191,0,0},
      thickness=0.5));
  connect(valveLinear.opening, PID.y) annotation (Line(points={{-60,8},{-60,64},{-53,64}},
                                       color={0,0,127},
      thickness=0.5));
  connect(Brine_Outlet_Port, valveLinear.port_b)
    annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255},
      thickness=0.5));
  connect(Evaporator.Brine_Outlet_port, valveLinear.port_a) annotation (Line(
        points={{-20,0},{-50,0}},                 color={0,127,255},
      thickness=0.5));
  connect(Steam_Outlet_Resistance.port_b, Steam_Outlet_Port) annotation (Line(
        points={{4.44089e-16,53},{4.44089e-16,76.5},{0,76.5},{0,100}}, color={0,127,255},
      thickness=0.5));
  annotation (Icon(graphics={
        Ellipse(
          extent={{-60,60},{60,100}},
          lineColor={0,0,0},
          startAngle=0,
          endAngle=360,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Ellipse(
          extent={{-60,-100},{60,-60}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,80},{60,28}},
          lineColor={164,189,255},
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,26},{-8,40}},
          lineThickness=1,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-4,26},{38,40}},
          lineThickness=1,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{38,26},{60,30}},
          lineThickness=1,
          fillColor={164,189,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          closure=EllipseClosure.Chord),
        Ellipse(
          extent={{-60,26},{-42,30}},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-60,28},{-50,30},{-30,26},{-6,28},{-4,28},{20,26},{28,28},{56,26},{60,28}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1),
        Line(
          points={{-60,80},{-60,-80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,-80}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{60,80},{60,-80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-70,-40},{-50,-40},{-50,-20},{-30,-60},{-30,-40},{-10,-40},{-10,-20},{10,-60},{10,-40},{30,-40}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{30,-40},{30,-20},{50,-60},{50,-40},{70,-40}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-100,-40},{-78,-40},{-60,-40}},
          color={0,0,0},
          thickness=1,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{90,-40},{70,-40}},
          color={0,0,0},
          thickness=1,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{90,0},{60,0}},
          color={28,108,200},
          thickness=1,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-60,0},{-90,0}},
          color={28,108,200},
          thickness=1,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-58,80},{58,60}},
          textColor={0,0,0},
          textString="%name")}),              Diagram(graphics={Polygon(
            points={{4,-44},{-2,-42},{4,-44}}, lineColor={28,108,200})}));
end Single_Effect;
