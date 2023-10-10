within NHES.Desalination.MEE.Single_Effect.Water_Models;
model Single_Effect_W
  "Single effect evaporator for desalination, this model uses a constant Heat transfer correlations to calculate a UA for multipal nodes, for both sides of the heat exchager, Brine=Water"

  parameter Modelica.Units.SI.AbsolutePressure Psys=1e5 "Evaporator System Pressure";

  parameter Modelica.Units.SI.Mass S_start=20 "Init Solute Mass"  annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.PressureDifference dP=10
                                                   "Tube Side Pressure Drop"
                                                                            annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Volume V=1 "Effect Volume";
  parameter Modelica.Units.SI.Area A=1 "Effect Cross Sectional Area";
  parameter Real KV=-0.03  "Level Control Valve PI Controler Gain";

  parameter Modelica.Units.SI.Area Ax=1e4;
  parameter Modelica.Units.SI.Diameter Do=0.01;
  parameter Modelica.Units.SI.Thickness th=0.001;
  parameter Modelica.Units.SI.AbsolutePressure pT
                                                 "Init Tube pressure";

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow Brine_Inlet_Port(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State Brine_Outlet_Port(redeclare
      package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State Steam_Outlet_Port(redeclare
      package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    Brine_Outlet_Resistance(redeclare package Medium =
        Modelica.Media.Water.StandardWater, R=5)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    Steam_Outlet_Resistance(R=1)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,46})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
    Brine_inlet_Resistance(redeclare package Medium =
        Modelica.Media.Water.StandardWater, R=5)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  TRANSFORM.Controls.LimPID         PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=KV,
    Ti=100,
    Td=10,
    yMax=1,
    yMin=0,
    wp=1,
    wd=1) annotation (Placement(transformation(extent={{-44,76},{-64,96}})));
  Modelica.Blocks.Sources.RealExpression Level_Set(y=0.5) annotation (Placement(transformation(extent={{-14,74},
            {-34,94}})));
  MEE.Components.Evaporator_Water_SHP Evaporator_Water_SHP(
    p_start=Psys,
    S_start=S_start,
    V=V,
    A=A) annotation (Placement(transformation(extent={{20,-20},{-20,20}})));
  Modelica.Blocks.Interfaces.RealInput Cs_In
    annotation (Placement(transformation(extent={{110,10},{90,30}}), iconTransformation(extent={{110,10},{90,30}})));
  Modelica.Blocks.Interfaces.RealOutput Cs_Out annotation (Placement(transformation(extent={{-100,10},{-120,30}})));
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
    dP=100) annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_intlet_Resistance(
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_Outlet_Resistance(
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
    annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  NHES.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=1000,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
equation
  connect(Brine_Inlet_Port, Brine_Inlet_Port)
    annotation (Line(points={{100,0},{100,0}}, color={0,127,255}));
  connect(Brine_inlet_Resistance.port_b, Brine_Inlet_Port)
    annotation (Line(points={{67,0},{100,0}}, color={0,127,255}));
  connect(Level_Set.y, PID.u_s) annotation (Line(points={{-35,84},{-38,84},{-38,
          86},{-42,86}},                                                     color={0,0,127}));
  connect(Cs_In, Evaporator_Water_SHP.Cs_in) annotation (Line(points={{100,
          20},{30,20},{30,6},{18,6}}, color={0,0,127}));
  connect(Evaporator_Water_SHP.Cs_out, Cs_Out) annotation (Line(points={{-22,
          6},{-30,6},{-30,20},{-110,20}}, color={0,0,127}));
  connect(Evaporator_Water_SHP.RelLevel, PID.u_m) annotation (Line(points={{-22,14},
          {-22,62},{-54,62},{-54,74}},          color={0,0,127}));
  connect(Evaporator_Water_SHP.Brine_Inlet_port, Brine_inlet_Resistance.port_a)
    annotation (Line(points={{20,0},{53,0}}, color={0,127,255}));
  connect(Evaporator_Water_SHP.Brine_Outlet_port, Brine_Outlet_Resistance.port_b)
    annotation (Line(points={{-20,0},{-33,0}}, color={0,127,255}));
  connect(Evaporator_Water_SHP.steam_port, Steam_Outlet_Resistance.port_a)
    annotation (Line(points={{0,20},{-4.44089e-16,39}}, color={0,127,255}));
  connect(Tube_Inlet,Tube_Inlet)
    annotation (Line(points={{-98,-40},{-98,-40}},   color={0,127,255}));
  connect(sEE_Tube_Side.Heat_Port, Evaporator_Water_SHP.Heat_Port)
    annotation (Line(points={{0,-30},{0,-20}}, color={191,0,0}));
  connect(Tube_intlet_Resistance.port_b, sEE_Tube_Side.Steam_Inlet_Port)
    annotation (Line(points={{-53,-40},{-20,-40}}, color={0,127,255}));
  connect(Tube_intlet_Resistance.port_a, Tube_Inlet)
    annotation (Line(points={{-67,-40},{-98,-40}}, color={0,127,255}));
  connect(sEE_Tube_Side.Liquid_Outlet_Port, Tube_Outlet_Resistance.port_a)
    annotation (Line(points={{20,-40},{53,-40}}, color={0,127,255}));
  connect(Tube_Outlet_Resistance.port_b, Tube_Outlet)
    annotation (Line(points={{67,-40},{102,-40}}, color={0,127,255}));
  connect(Steam_Outlet_Resistance.port_b, Steam_Outlet_Port) annotation (Line(
        points={{4.44089e-16,53},{4.44089e-16,76.5},{0,76.5},{0,100}}, color={0,
          127,255}));
  connect(valveLinear.opening, PID.y)
    annotation (Line(points={{-70,8},{-70,86},{-65,86}}, color={0,0,127}));
  connect(valveLinear.port_a, Brine_Outlet_Resistance.port_a)
    annotation (Line(points={{-60,0},{-47,0}}, color={0,127,255}));
  connect(Brine_Outlet_Port, valveLinear.port_b)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
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
          arrow={Arrow.None,Arrow.Filled})}));
end Single_Effect_W;
