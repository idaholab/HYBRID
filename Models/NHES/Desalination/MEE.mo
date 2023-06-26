within NHES.Desalination;
package MEE "Multi Effect Evaporators"

  package Single_Effect "Single effect evaporators"

    package Water_Models
      "These models assume brine has the same properties of water."
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

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Brine_Inlet_Port(redeclare
            package Medium =
                     Modelica.Media.Water.StandardWater)
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
        Components.Evaporator_Water_SHP Evaporator_Water_SHP(
          p_start=Psys,
          S_start=S_start,
          V=V,
          A=A) annotation (Placement(transformation(extent={{20,-20},{-20,20}})));
        Modelica.Blocks.Interfaces.RealInput Cs_In
          annotation (Placement(transformation(extent={{110,10},{90,30}}), iconTransformation(extent={{110,10},{90,30}})));
        Modelica.Blocks.Interfaces.RealOutput Cs_Out annotation (Placement(transformation(extent={{-100,10},{-120,30}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tube_Inlet(redeclare package
            Medium =
              Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{-108,-50},{-88,-30}}), iconTransformation(extent={{-108,
                  -50},{-88,-30}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare
            package Medium =
                     Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{92,-50},{112,-30}}), iconTransformation(extent={{92,-50},
                  {112,-30}})));
        Components.SEE_Tube_Side_FilmBoiling              sEE_Tube_Side(
          p_start=pT,
          Ax=Ax,
          Do=Do,
          th=th,
          dP=100)
          annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_intlet_Resistance(
            redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
          annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_Outlet_Resistance(
            redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
          annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
        Fluid.Valves.ValveLinear valveLinear(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          dp_nominal=1000,                                    m_flow_nominal=1)
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

      model Single_Effect_FullCond_W
        "Single effect evaporator for desalination, this model assumes the water in the tube leaves fully condensed, and Brine=Water"

        parameter Modelica.Units.SI.AbsolutePressure Psys=1e5;
        parameter Modelica.Units.SI.Mass S_start=20  annotation (Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.Volume V=1;
        parameter Modelica.Units.SI.Area A=1;
        parameter Real KP=-40;
        parameter Modelica.Units.SI.MassFlowRate Pumplimit "Pump flow rate limit";
        parameter Modelica.Units.SI.PressureDifference dP=10
          "Tube Side Pressure Drop"
                                   annotation (Dialog(tab="Initialization"));

        NHES.Fluid.Valves.PressureCV              PCV(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          Use_input=false,
          Pressure_target=Psys,
          m_flow_nominal=1,
          dp_nominal(displayUnit="Pa") = 2000)
                        annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=90,
              origin={0,78})));

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Brine_Inlet_Port(redeclare
            package Medium =
                     Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_State Brine_Outlet_Port(redeclare
            package Medium = Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_State Steam_Outlet_Port(redeclare
            package Medium = Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{-10,90},{10,110}})));
        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
          Brine_Outlet_Resistance(R=5)
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
          Steam_Outlet_Resistance(R=1)       annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,46})));
        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance
          Brine_inlet_Resistance(R=5)
          annotation (Placement(transformation(extent={{50,-10},{70,10}})));
        TRANSFORM.Controls.LimPID         PID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=KP,
          Ti=2,
          Td=10,
          yMax=Pumplimit,
          yMin=0,
          wp=1,
          wd=1) annotation (Placement(transformation(extent={{-44,70},{-64,90}})));
        Modelica.Blocks.Sources.RealExpression Level_Set(y=0.5) annotation (Placement(transformation(extent={{-14,70},
                  {-34,90}})));
        Components.Evaporator_Water_SHP Evaporator_Water_SHP(
          p_start=1.1*Psys,
          S_start=S_start,
          V=V,
          A=A) annotation (Placement(transformation(extent={{20,-20},{-20,20}})));
        Modelica.Blocks.Interfaces.RealInput Cs_In
          annotation (Placement(transformation(extent={{110,10},{90,30}}), iconTransformation(extent={{110,10},{90,30}})));
        Modelica.Blocks.Interfaces.RealOutput Cs_Out annotation (Placement(transformation(extent={{-100,10},{-120,30}})));
        TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(
          redeclare package Medium = Modelica.Media.Water.StandardWater,
          use_input=true,
          m_flow_nominal=0.1) annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tube_Inlet(redeclare package
            Medium =
              Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{-108,-50},{-88,-30}}), iconTransformation(extent={{-108,
                  -50},{-88,-30}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare
            package Medium =
                     Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{92,-50},{112,-30}}), iconTransformation(extent={{92,-50},
                  {112,-30}})));
        Components.SEE_Tube_Side_Full_Cond sEE_Tube_Side(dP=dP)
          annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_intlet_Resistance(
            redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
          annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_Outlet_Resistance(
            redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
          annotation (Placement(transformation(extent={{52,-50},{72,-30}})));
      equation
        connect(Brine_Inlet_Port, Brine_Inlet_Port)
          annotation (Line(points={{100,0},{100,0}}, color={0,127,255}));
        connect(Brine_inlet_Resistance.port_b, Brine_Inlet_Port)
          annotation (Line(points={{67,0},{100,0}}, color={0,127,255}));
        connect(Level_Set.y, PID.u_s) annotation (Line(points={{-35,80},{-42,80}}, color={0,0,127}));
        connect(Cs_In, Evaporator_Water_SHP.Cs_in) annotation (Line(points={{100,
                20},{30,20},{30,6},{18,6}}, color={0,0,127}));
        connect(Evaporator_Water_SHP.Cs_out, Cs_Out) annotation (Line(points={{-22,
                6},{-30,6},{-30,20},{-110,20}}, color={0,0,127}));
        connect(Evaporator_Water_SHP.RelLevel, PID.u_m) annotation (Line(points={
                {-22,14},{-26,14},{-26,50},{-54,50},{-54,68}}, color={0,0,127}));
        connect(Evaporator_Water_SHP.Brine_Inlet_port, Brine_inlet_Resistance.port_a)
          annotation (Line(points={{20,0},{53,0}}, color={0,127,255}));
        connect(Evaporator_Water_SHP.Brine_Outlet_port, Brine_Outlet_Resistance.port_b)
          annotation (Line(points={{-20,0},{-33,0}}, color={0,127,255}));
        connect(pump.port_a, Brine_Outlet_Resistance.port_a) annotation (Line(points={{-60,0},{-47,0}}, color={0,127,255}));
        connect(pump.port_b, Brine_Outlet_Port) annotation (Line(points={{-80,0},{-100,0}}, color={0,127,255}));
        connect(Evaporator_Water_SHP.steam_port, Steam_Outlet_Resistance.port_a)
          annotation (Line(points={{0,20},{-4.44089e-16,39}}, color={0,127,255}));
        connect(Steam_Outlet_Resistance.port_b, PCV.port_a) annotation (Line(points={{4.44089e-16,53},{-6.10623e-16,68}}, color={0,127,255}));
        connect(PCV.port_b, Steam_Outlet_Port) annotation (Line(points={{6.10623e-16,88},{0,100}}, color={0,127,255}));
        connect(pump.in_m_flow, PID.y)
          annotation (Line(points={{-70,7.3},{-70,80},{-65,80}}, color={0,0,127}));
        connect(Tube_Inlet,Tube_Inlet)
          annotation (Line(points={{-98,-40},{-98,-40}},   color={0,127,255}));
        connect(sEE_Tube_Side.Heat_Port, Evaporator_Water_SHP.Heat_Port)
          annotation (Line(points={{0,-30},{0,-20}}, color={191,0,0}));
        connect(sEE_Tube_Side.Steam_Inlet_Port, Tube_intlet_Resistance.port_b)
          annotation (Line(points={{-20,-40},{-53,-40}}, color={0,127,255}));
        connect(Tube_Inlet, Tube_intlet_Resistance.port_a)
          annotation (Line(points={{-98,-40},{-67,-40}}, color={0,127,255}));
        connect(sEE_Tube_Side.Liquid_Outlet_Port, Tube_Outlet_Resistance.port_a)
          annotation (Line(points={{20,-40},{55,-40}}, color={0,127,255}));
        connect(Tube_Outlet, Tube_Outlet_Resistance.port_b)
          annotation (Line(points={{102,-40},{69,-40}}, color={0,127,255}));
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
      end Single_Effect_FullCond_W;
    end Water_Models;

    package Brine_Models "These models use the SeaWater Media Package"
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

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Brine_Inlet_Port(redeclare
            package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
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
        Components.Evaporator_Brine_SHP Evaporator(
          redeclare package MediumB = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
          p_start=100000,
          T_st=Tsys,
          V=V,
          A=A) annotation (Placement(transformation(extent={{20,-20},{-20,20}})));

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tube_Inlet(redeclare package
            Medium =
              Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{-108,-50},{-88,-30}}), iconTransformation(extent={{-108,
                  -50},{-88,-30}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare
            package Medium =
                     Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{92,-50},{112,-30}}), iconTransformation(extent={{92,-50},
                  {112,-30}})));
        Components.SEE_Tube_Side_FilmBoiling                     sEE_Tube_Side(
          p_start=pT,
          Ax=Ax,
          Do=Do,
          th=th,
          k=k,
          nV=nV)
          annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
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

      model Single_Effect_FC
        "Single effect evaporator for desalination, assumes full condensing of the steam"
        parameter Modelica.Units.SI.Volume V=1 annotation(Dialog(group="Geometry"));
        parameter Modelica.Units.SI.Area A=1 annotation(Dialog(group="Geometry"));
        parameter Modelica.Units.SI.Temperature Tsys=350 "Evaporator T" annotation(Dialog(group="Evaporator Initialization"));
        parameter Modelica.Units.SI.MassFlowRate m_brine_out=1 "Nominal mass flow rate in brine exit valve"  annotation(Dialog(group="Valve"));
        parameter Modelica.Units.SI.AbsolutePressure dp=0.001e5
                                                               "Nominal pressure drop across the brine exit valve" annotation(Dialog(group="Valve"));
        parameter Real KV=-0.03 annotation(Dialog(group="PID Control"));
        parameter Modelica.Units.SI.Time Ti=0.75 "Time constant of Integrator block"  annotation(Dialog(group="PID Control"));

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Brine_Inlet_Port(redeclare
            package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
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
        Controls.LimOffsetPID             PID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=KV,
          Ti=Ti,
          Td=10,
          yMax=1,
          yMin=0,
          wp=1,
          wd=1,
          offset=0)
                annotation (Placement(transformation(extent={{-32,54},{-52,74}})));
        Modelica.Blocks.Sources.RealExpression Level_Set(y=0.5) annotation (Placement(transformation(extent={{-4,54},{-24,74}})));
        Components.Evaporator_Brine_SHP Evaporator(
          redeclare package MediumB = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
          p_start=p_start,
          T_st=Tsys,
          V=V,
          A=A) annotation (Placement(transformation(extent={{20,-20},{-20,20}})));

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tube_Inlet(redeclare package
            Medium =
              Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{-108,-50},{-88,-30}}), iconTransformation(extent={{-108,
                  -50},{-88,-30}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare
            package Medium =
                     Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{92,-50},{112,-30}}), iconTransformation(extent={{92,-50},
                  {112,-30}})));
        Components.SEE_Tube_Side_Full_Cond                       sEE_Tube_Side
          annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
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

        parameter SI.Pressure p_start=100000 "Initial pressure";
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
                textString="%name")}));
      end Single_Effect_FC;

      model Single_Effect_pool
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

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Brine_Inlet_Port(redeclare
            package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
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
        Components.Evaporator_Brine_SHP Evaporator(
          redeclare package MediumB = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
          p_start=100000,
          T_st=Tsys,
          V=V,
          A=A) annotation (Placement(transformation(extent={{20,-20},{-20,20}})));

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tube_Inlet(redeclare package
            Medium =
              Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{-108,-50},{-88,-30}}), iconTransformation(extent={{-108,
                  -50},{-88,-30}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare
            package Medium =
                     Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{92,-50},{112,-30}}), iconTransformation(extent={{92,-50},
                  {112,-30}})));
        Components.SEE_Tube_Side_PoolBoiling                     sEE_Tube_Side(
          p_start=pT,
          Ax=Ax,
          Do=Do,
          th=th,
          k=k,
          nV=nV)
          annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
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
      end Single_Effect_pool;
    end Brine_Models;
  end Single_Effect;

  package Components "Components used in SEE and MEE models"

    model SEE_Tube_Side_Full_Cond
      "Tube side of a single effect, assume the water leaves fully condensed"
      import Modelica.Fluid.Types.Dynamics;
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Medium.SaturationProperties  sat;
      Modelica.Units.SI.AbsolutePressure p;
      Modelica.Units.SI.SpecificEnthalpy h_g;
      Modelica.Units.SI.SpecificEnthalpy h_f;
      Modelica.Units.SI.SpecificEnthalpy h_in;
      Modelica.Units.SI.SpecificEnthalpy h_out;
      Modelica.Units.SI.MassFlowRate mdot(start=mstart);
      Modelica.Units.SI.HeatFlowRate Qhx;
      parameter Modelica.Units.SI.MassFlowRate mstart=1;

      TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow Heat_Port
        annotation (Placement(transformation(extent={{-10,40},{10,60}}),
            iconTransformation(extent={{-10,40},{10,60}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow Steam_Inlet_Port(
      redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State Liquid_Outlet_Port(
      redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    equation

      sat.psat = p;
      sat.Tsat = Medium.saturationTemperature(p);
      h_f = Medium.bubbleEnthalpy(sat);
      h_g = Medium.dewEnthalpy(sat);

      h_out=h_f;

      Liquid_Outlet_Port.p = p;

      Liquid_Outlet_Port.h_outflow=h_out;
     - mdot=Liquid_Outlet_Port.m_flow;

      Steam_Inlet_Port.p = p;
      mdot=Steam_Inlet_Port.m_flow;
      Steam_Inlet_Port.h_outflow = h_g;
      h_in =inStream(Steam_Inlet_Port.h_outflow);

      Qhx=(h_in-h_f)*mdot;
      Qhx =-Heat_Port.Q_flow;

     annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-90,40},{90,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor=DynamicSelect({0,127,255}, if showColors then dynColor else {0,127,255})),
            Polygon(
              points={{68,40},{-90,42},{-90,-40},{-56,-38},{-50,-22},{-30,-12},{
                  -26,0},{-16,4},{0,20},{68,40}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-90,42},{90,34}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Backward),
            Rectangle(
              extent={{-90,-32},{90,-40}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Backward)}),                  Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SEE_Tube_Side_Full_Cond;

    model Evaporator_Water_SHP
      "Evaporator for desalinaition, this model has a single heat port and assumes Brine=Water;"

      import Modelica.Fluid.Types.Dynamics;

    replaceable package MediumW = Modelica.Media.Water.StandardWater;

      MediumW.ThermodynamicState liquidState "Thermodynamic state of the liquid";
      MediumW.ThermodynamicState vapourState "Thermodynamic state of the vapour";
      MediumW.ThermodynamicState MixState "Thermodynamic state of brine mix";
      MediumW.SaturationProperties sat;
      outer Modelica.Fluid.System system "System properties";
    // Initialization
      parameter Modelica.Units.SI.Pressure p_start=103e5 "Initial pressure"
        annotation (Dialog(tab="Initialization"));

      parameter Modelica.Units.SI.Mass S_start=40 "Initial Salt Mass"
        annotation (Dialog(tab="Initialization"));
      parameter Real RelLevel_start=0.5 "Initial Level" annotation(Dialog(tab="Initialization"));
      parameter MediumW.SpecificEnthalpy h_f_start=MediumW.bubbleEnthalpy(MediumW.setSat_p(
          p_start)) "Liquid enthalpy start value"    annotation (Dialog(tab="Initialization"));
      parameter MediumW.SpecificEnthalpy h_g_start=MediumW.dewEnthalpy(MediumW.setSat_p(
          p_start)) "Vapour enthalpy start value"    annotation (Dialog(tab="Initialization"));

     /* Assumptions */
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restrics to design direction"
      annotation(Dialog(tab="Assumptions"));

      Modelica.Fluid.Interfaces.FluidPort_a Brine_Inlet_port(
        p(start=p_start),
        redeclare package Medium = MediumW,
        m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
            iconTransformation(extent={{-110,-10},{-90,10}})));

     Modelica.Fluid.Interfaces.FluidPort_b Brine_Outlet_port(
        p(start=p_start),
        redeclare package Medium = MediumW,
        m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{90,-10},{110,10}}),
            iconTransformation(extent={{90,-10},{110,10}})));

    Modelica.Fluid.Interfaces.FluidPort_b steam_port(
        p(start=p_start),
        redeclare package Medium = MediumW,
        m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{-10,90},{10,110}}),
            iconTransformation(extent={{-10,90},{10,110}})));

     Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Heat_Port
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

      parameter Modelica.Units.SI.Volume V;
      parameter Modelica.Units.SI.Area A;
      Modelica.Units.SI.Height level;

      Real alphag;
      MediumW.AbsolutePressure p(start=p_start);
      MediumW.SpecificEnthalpy h_g( start=h_g_start, stateSelect=StateSelect.prefer)
        "Specific enthalpy of sat vapour";
      MediumW.SpecificEnthalpy h_f( start=h_f_start, stateSelect=StateSelect.prefer)
        "Specific enthalpy of sat vapour";
      Modelica.Units.SI.SpecificEnthalpy h_b_in;
      Modelica.Units.SI.SpecificEnthalpy h_b_out;
      Modelica.Units.SI.SpecificEnthalpy h_steam;
      Modelica.Units.SI.MassFlowRate m_T;
      Modelica.Units.SI.MassFlowRate m_b_in;
      Modelica.Units.SI.MassFlowRate m_b_out;
      Modelica.Units.SI.MassFlowRate m_steam;
      Modelica.Units.SI.Density rho_g;
      Modelica.Units.SI.Density rho_b;
      Modelica.Units.SI.Density rho_f;
      Modelica.Units.SI.Mass Mm;
      Modelica.Units.SI.Mass Mg;
      Modelica.Units.SI.Mass M;
      Modelica.Units.SI.Mass S(start=S_start);
      Modelica.Units.SI.Energy E;
      Modelica.Units.SI.SpecificInternalEnergy u_g;
      Modelica.Units.SI.SpecificInternalEnergy u_b;
      Modelica.Units.SI.Power Qhx;
      Modelica.Units.SI.Volume Vg;
      Modelica.Units.SI.Volume Vm;
      Modelica.Units.SI.Velocity velg;
      Modelica.Units.SI.SurfaceTension sigma;

      Modelica.Blocks.Interfaces.RealOutput RelLevel( start=RelLevel_start, fixed=true, quantity="Relative Level")
        annotation (Placement(transformation(extent={{100,60},{120,80}}),
            iconTransformation(extent={{100,60},{120,80}})));
      Modelica.Blocks.Interfaces.RealOutput Cs_out annotation (Placement(transformation(extent={{100,20},{120,40}}), iconTransformation(extent={{100,20},
                {120,40}})));
      Modelica.Blocks.Interfaces.RealInput Cs_in
        annotation (Placement(transformation(extent={{-90,10},{-110,30}}), iconTransformation(extent={{-100,20},{-80,40}})));
    equation
      der(Mg)=m_T+m_steam;
      der(Mm)=m_b_in+m_b_out-m_T;

      der(E)=m_steam*h_steam + m_b_in*h_b_in + m_b_out*h_b_out + Qhx;
      der(S)=m_b_in*Cs_in+m_b_out*Cs_out;

    //Definitions  & Stae Eqs
      MixState= MediumW.setState_phX(p, h_b_out);
      u_b= MediumW.specificInternalEnergy(MixState);
      rho_b = MediumW.density(MixState);

      liquidState = MediumW.setState_phX(p, h_f);
      rho_f = MediumW.density(liquidState);
      vapourState = MediumW.setState_phX(p, h_g);
      rho_g = MediumW.density(vapourState);
      sat.psat = p;
      sat.Tsat = MediumW.saturationTemperature(p);
      h_f = MediumW.bubbleEnthalpy(sat);
      h_g = MediumW.dewEnthalpy(sat);
      h_b_out=h_f;
      u_g= MediumW.specificInternalEnergy(vapourState);
      sigma=MediumW.surfaceTension(sat);
      M=Mg+Mm;
      Mg=Vg*rho_g;
      Mm=Vm*((1-alphag)*rho_b+alphag*rho_g);
      E=Vm*((1-alphag)*(rho_b*u_b)+alphag*rho_g*u_g)+Vg*rho_g*u_g;
      S= Vm*(1-alphag)*rho_f*Cs_out;
      V=Vg+Vm;
      m_T=alphag*rho_g*velg*A;
      velg=(1.41*3.28084/(1-alphag))*(sigma*9.81*(rho_f-rho_g)/(rho_f^2))^0.25;

     // m_b_out=h_f;
      level=Vm/A;
      RelLevel=level/(V/A);

      Brine_Inlet_port.p = p;
      m_b_in=Brine_Inlet_port.m_flow;
      Brine_Inlet_port.h_outflow=h_f;
      h_b_in =inStream(Brine_Inlet_port.h_outflow);

      Brine_Outlet_port.p = p;
      m_b_out=Brine_Outlet_port.m_flow;
      Brine_Outlet_port.h_outflow=h_b_out;

      steam_port.p = p;
      m_steam=steam_port.m_flow;
      steam_port.h_outflow = h_g;
      h_steam=h_g;
      Heat_Port.T=sat.Tsat;
      Qhx =Heat_Port.Q_flow
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));

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
              points={{60,80},{60,-80}},
              color={0,0,0},
              thickness=0.5),
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
    end Evaporator_Water_SHP;

    model SEE_Tube_Side_FilmBoiling
     import Modelica.Fluid.Types.Dynamics;

    replaceable package MediumT = Modelica.Media.Water.StandardWater;
    replaceable package MediumS = Modelica.Media.Water.StandardWater;
    MediumS.SaturationProperties  satS;
    MediumT.SaturationProperties  satT;
    MediumT.ThermodynamicState LiT;
    MediumT.ThermodynamicState VaT;
    MediumS.ThermodynamicState LiS;
    MediumS.ThermodynamicState VaS;
    parameter Modelica.Units.SI.AbsolutePressure p_start=1e5 "tube side pressure start";
    parameter Modelica.Units.SI.MassFlowRate m_start=1 "start mass flow rate";
    parameter Modelica.Units.SI.Area Ax=1e4
                                           "Heat Transfer Area (Outside Tube Area)";
    parameter Modelica.Units.SI.Diameter Do=0.01
                                                "Outer Diameter of the Tubes";
    parameter Modelica.Units.SI.Thickness th=0.001
                                                  "Thickness of the Cladding";
    parameter Modelica.Units.SI.PressureDifference dP=10
                                                        "Pressure Drop across the tubes";
    parameter Modelica.Units.SI.ThermalConductivity k=0.01
                                                          "Thermal Conductivity of the Cladding";
    parameter Integer nV=5 "Number of Nodes";

    parameter Modelica.Units.SI.SpecificEnthalpy hinstart=MediumT.dewEnthalpy(MediumT.setSat_p(p_start));
    //2000e3;
    //
    parameter Modelica.Units.SI.SpecificEnthalpy houtstart=MediumT.bubbleEnthalpy(MediumT.setSat_p(p_start));
    //400e3;
    //
    parameter Modelica.Units.SI.SpecificEnthalpy hstart[:]=linspace(
                                                           hinstart,
                                                           houtstart,nV);
    parameter Modelica.Units.SI.Temperature TwTst=MediumT.saturationTemperature((p_start))-3;
    parameter Modelica.Units.SI.Temperature TwSst=MediumS.saturationTemperature(max((p_start-0.3e5),1e4))+3;
    parameter Modelica.Units.SI.Temperature TwTstart[:]=linspace(TwTst,TwTst,nV);
    parameter Modelica.Units.SI.Temperature TwSstart[:]=linspace(TwSst,TwSst,nV);

      Modelica.Units.SI.Area Axt;
      Modelica.Units.SI.AbsolutePressure pT(start=p_start);
      Modelica.Units.SI.AbsolutePressure pS;
      Modelica.Units.SI.SpecificEnthalpy h_gT;
      Modelica.Units.SI.SpecificEnthalpy h_in(start=hinstart);
      Modelica.Units.SI.SpecificEnthalpy h_out[nV](start=hstart);
      Modelica.Units.SI.MassFlowRate mdot;
      Modelica.Units.SI.HeatFlowRate Qhx[nV];
      Modelica.Units.SI.HeatFlowRate Q;
      Modelica.Units.SI.CoefficientOfHeatTransfer ho[nV];
      Modelica.Units.SI.CoefficientOfHeatTransfer hi[nV];
      Modelica.Units.SI.Diameter Di;
      Modelica.Units.SI.Area Axi;
      Modelica.Units.SI.ThermalConductivity kT;
      Modelica.Units.SI.ThermalConductivity kS;
      Modelica.Units.SI.ThermalConductivity lamT;
      Modelica.Units.SI.DynamicViscosity mufT;
      Modelica.Units.SI.DynamicViscosity mugT;
      Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cpT;
      Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cpS;
      Modelica.Units.SI.Density rhofT;
      Modelica.Units.SI.Density rhogT;
      Modelica.Units.SI.Density rhofS;
      Modelica.Units.SI.Density rhogS;
      Modelica.Units.SI.SpecificEnthalpy hfT;
      Modelica.Units.SI.SpecificEnthalpy hgT;
      Modelica.Units.SI.SpecificEnthalpy hfS;
      Modelica.Units.SI.SpecificEnthalpy hgS;
      Modelica.Units.SI.SpecificEnthalpy hfgT;
      Modelica.Units.SI.Temperature TwT[nV](start=TwTstart);
      Modelica.Units.SI.Temperature TwS[nV](start=TwSstart);
      Modelica.Units.SI.Temperature TS;
      Modelica.Units.SI.Temperature TsT[nV];
      Real Pr;

      TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow Heat_Port
        annotation (Placement(transformation(extent={{-10,40},{10,60}}),
            iconTransformation(extent={{-10,40},{10,60}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow Steam_Inlet_Port(
      p(start=p_start),
      redeclare package Medium = MediumT)
        annotation (
        Placement(transformation(extent={{-110,-10},{-90,10}})));

      TRANSFORM.Fluid.Interfaces.FluidPort_State Liquid_Outlet_Port(
      p(start=p_start-dP),
      redeclare package Medium = MediumT)
        annotation (
        Placement(transformation(extent={{90,-10},{110,10}})));

    //initial equation
    //  for i in 1:nV loop
    //    h_out[i]=hstart;
    //  end for;

    algorithm
      Axt:=Ax/nV;
      Di:=Do - 2*th;
      Axi:=Axt*Di/Do;
    equation
      //Tube Side
      satT.psat = pT;
      satT.Tsat = MediumT.saturationTemperature(pT);
      h_gT = MediumT.dewEnthalpy(satT);
      kT= MediumT.thermalConductivity(VaT);
      LiT=MediumT.setBubbleState(satT);
      VaT=MediumT.setDewState(satT);
      mufT= MediumT.dynamicViscosity(LiT);
      mugT= MediumT.dynamicViscosity(VaT);
      lamT= MediumT.thermalConductivity(LiT);
      cpT= MediumT.specificHeatCapacityCp(LiT);
      rhogT=MediumT.density(VaT);
      rhofT=MediumT.density(LiT);
      hfT=MediumT.specificEnthalpy(LiT);
      hgT=MediumT.specificEnthalpy(VaT);
      hfgT=hgT-hfT;
      for i in 1:nV loop
      TsT[i]=MediumT.temperature_ph(pT,h_out[i]);
      hi[i]=TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.Condensation.alpha_NusseltTheory_Condensation(
          Di,kT,rhofT,mufT,lamT,cpT,rhogT,mugT,hfgT,TsT[i],satT.Tsat,TwT[i]);
      Qhx[i]=hi[i]*Axi*(TsT[i]-TwT[i]);
      end for;

      //Shell Side
      TS=satS.Tsat;
      satS.psat= MediumS.saturationPressure(TS);
      pS=satS.psat;
      LiS=MediumS.setBubbleState(satS);
      VaS=MediumS.setDewState(satS);
      hfS=MediumS.specificEnthalpy(LiS);
      hgS=MediumS.specificEnthalpy(VaS);
      rhogS=MediumS.density(VaS);
      rhofS=MediumS.density(LiS);
      kS=MediumS.thermalConductivity(VaS);
      cpS=MediumS.specificHeatCapacityCp(VaS);
      Pr=MediumS.prandtlNumber(VaS);
      for i in 1:nV loop
      ho[i]=NHES.Fluid.ClosureModels.HeatTransfer.alpha_Bromley_Film_Boiling(TwS[i],TS,hgS,hfS,rhogS,rhofS,kS,cpS,Pr,Do);
      Qhx[i]=ho[i]*Axt*(TwS[i]-TS);
      end for;

      //Clading
      for i in 1:nV loop
      Qhx[i]=2*k*Axt/(Do*log(Do/Di))*(TwT[i]-TwS[i]);
      end for;
     // Total HT
     if mdot>1e-8 then
     h_out[1]=h_in-Qhx[1]/mdot;
     else
     h_out[1]=h_in;
     end if;
     if mdot>1e-8 then
     for i in 2:nV loop
         h_out[i]=h_out[i-1]-Qhx[i]/mdot;
     end for;
      else
       for i in 2:nV loop
         h_out[i]=h_out[i-1];
     end for;
     end if;

      Q=sum(Qhx);
      //Connectors
      Liquid_Outlet_Port.p = pT-dP;
      Liquid_Outlet_Port.h_outflow=h_out[nV];
     - mdot=Liquid_Outlet_Port.m_flow;

      Steam_Inlet_Port.p = pT;
      mdot=Steam_Inlet_Port.m_flow;
      Steam_Inlet_Port.h_outflow = h_gT;
      h_in =inStream(Steam_Inlet_Port.h_outflow);
      TS=Heat_Port.T;
      Q =-Heat_Port.Q_flow;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-90,40},{90,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor=DynamicSelect({0,127,255}, if showColors then dynColor
                   else {0,127,255})),
            Polygon(
              points={{68,40},{-90,42},{-90,-40},{-56,-38},{-50,-22},{-30,-12},{-26,
                  0},{-16,4},{0,20},{68,40}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-90,42},{90,34}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Backward),
            Rectangle(
              extent={{-90,-32},{90,-40}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Backward),
            Text(
              extent={{-100,-40},{100,-60}},
              textColor={28,108,200},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end SEE_Tube_Side_FilmBoiling;

    model Evaporator_Brine_SHP
      "Evaporator for desalinaition, this model has a single heat port and use SeaWater Media Package;"

      import Modelica.Fluid.Types.Dynamics;

    replaceable package MediumW = Modelica.Media.Water.StandardWater;
    replaceable package MediumB = NHES.Media.SeaWater;

      MediumW.ThermodynamicState vapourState "Thermodynamic state of the vapour";
      MediumW.SaturationProperties sat;
      MediumB.ThermodynamicState bstate "Thermodynamic state of the brine";

      outer Modelica.Fluid.System system "System properties";
    // Initialization
      parameter Modelica.Units.SI.Pressure p_start=103e5 "Initial pressure"
        annotation (Dialog(tab="Initialization"));
      parameter Modelica.Units.SI.Mass Mm_start=20 "Initial Mixure Mass"
        annotation (Dialog(tab="Initialization"));
      parameter Real RelLevel_start=0.5 "Initial Level"
        annotation(Dialog(tab="Initialization"));

     /* Assumptions */
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restrics to design direction"
      annotation(Dialog(tab="Assumptions"));

      Modelica.Fluid.Interfaces.FluidPort_a Brine_Inlet_port(
        p(start=p_start),
        redeclare package Medium = MediumB (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
            iconTransformation(extent={{-110,-10},{-90,10}})));

     Modelica.Fluid.Interfaces.FluidPort_b Brine_Outlet_port(
        p(start=p_start),
        redeclare package Medium = MediumB (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{90,-10},{110,10}}),
            iconTransformation(extent={{90,-10},{110,10}})));

    Modelica.Fluid.Interfaces.FluidPort_b steam_port(
        p(start=p_start),
        redeclare package Medium = MediumW,
        m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{-10,90},{10,110}}),
            iconTransformation(extent={{-10,90},{10,110}})));

     Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Heat_Port
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      parameter Modelica.Units.SI.Temperature T_st=300 "init temp";
      parameter Modelica.Units.SI.Volume V;
      parameter Modelica.Units.SI.Area A;
      Modelica.Units.SI.Height level;

      Real alphag
                 "(start=0.5)";
      MediumW.AbsolutePressure p;
      //(start=p_start, fixed=true);
      Modelica.Units.SI.SpecificEnthalpy h_b_in;
      Modelica.Units.SI.SpecificEnthalpy h_b_out;
      Modelica.Units.SI.SpecificEnthalpy h_steam;
      Modelica.Units.SI.MassFlowRate m_T;
      Modelica.Units.SI.MassFlowRate m_b_in;
      Modelica.Units.SI.MassFlowRate m_b_out;
      Modelica.Units.SI.MassFlowRate m_steam(start=1);
      Modelica.Units.SI.Density rho_g;
      Modelica.Units.SI.Density rho_b;
      Modelica.Units.SI.Mass Mm(start=Mm_start);
      Modelica.Units.SI.Mass Mg;
      Modelica.Units.SI.Mass M;
      Modelica.Units.SI.Mass Sa;
      //(start=0.01,fixed=true);
      Modelica.Units.SI.Energy E;
      Modelica.Units.SI.SpecificInternalEnergy u_g;
      Modelica.Units.SI.SpecificInternalEnergy u_b;
      Modelica.Units.SI.Power Qhx;
      Modelica.Units.SI.Volume Vg;
      Modelica.Units.SI.Volume Vm;
      Modelica.Units.SI.Velocity velg;
      Modelica.Units.SI.SurfaceTension sigma;
      Modelica.Units.SI.EnergyDensity rub;
      Modelica.Units.SI.EnergyDensity rug;
      Modelica.Units.SI.EnergyDensity rum;
      Modelica.Units.SI.MassFraction [2] Xin;
      Modelica.Units.SI.MassFraction [2] Xo;
      Modelica.Units.SI.MassFraction Cs_in;
      Modelica.Units.SI.MassFraction Cs_out(start=Cs_in,fixed=true);
      Modelica.Units.SI.Temperature T(start=T_st,fixed=true);
      Modelica.Units.SI.SpecificEnergy chemp;
      Modelica.Units.SI.SpecificGibbsFreeEnergy gW;

      Modelica.Blocks.Interfaces.RealOutput RelLevel( start=RelLevel_start, fixed=true, quantity="Relative Level")
        annotation (Placement(transformation(extent={{100,60},{120,80}}),
            iconTransformation(extent={{100,60},{120,80}})));
    initial equation
      //0=m_steam+m_b_in+m_b_out;
      //10=m_steam*h_steam + m_b_in*h_b_in + m_b_out*h_b_out + Qhx;
      //0=m_b_in*Cs_in+m_b_out*Cs_out;
    equation
      der(Mg)=m_T+m_steam;
      der(Mm)=m_b_in+m_b_out-m_T;
      der(E)=m_steam*h_steam + m_b_in*h_b_in + m_b_out*h_b_out + Qhx;
      der(Sa)=m_b_in*Cs_in+m_b_out*Cs_out;

    //Definitions  & Stae Eqs
      bstate=MediumB.setState_pTX(p,T,Xo);
      h_b_out=MediumB.specificEnthalpy(bstate);
      rho_b=MediumB.density(bstate);
      u_b=MediumB.specificInternalEnergy(bstate);
      chemp=MediumB.mu_pTX(p,T,Xo);

      Xin[2]=Cs_in;
      Xo[2]=Cs_out;
      Xo[1]=1-Cs_out;

      h_steam=MediumW.specificEnthalpy(vapourState);
      gW=MediumW.specificGibbsEnergy(vapourState);
      vapourState = MediumW.setState_pT(p, T);
      rho_g = MediumW.density(vapourState);
      u_g= MediumW.specificInternalEnergy(vapourState);

      gW=chemp;

      sat.psat = p;
      sat.Tsat = MediumW.saturationTemperature(p);
      sigma=MediumW.surfaceTension(sat);

      rug=rho_g*u_g;
      rub=rho_b*u_b;

      rum=(1-min(alphag,1))*rub+min(alphag,1)*rug;

      M=Mg+Mm;
      Mg=Vg*rho_g;
      Mm=Vm*((1-min(alphag,1))*rho_b+min(alphag,1)*rho_g);
      E=Vm*rum+Vg*rug;
      Sa= Vm*(1-min(alphag,1))*rho_b*Cs_out;
      V=Vg+Vm;
      m_T=min(alphag,1)*rho_g*velg*A;
      velg=(1.41*3.28084/(1-alphag))*(sigma*9.81*(rho_b-rho_g)/(rho_b^2))^0.25;
      //assert(alphag>=0 and alphag<=1,"alphag must be btween 0 and 1");

     // m_b_out=h_f;
      level=Vm/A;
      RelLevel=level/(V/A);

      Brine_Inlet_port.p = p;
      m_b_in=Brine_Inlet_port.m_flow;
      h_b_in =inStream(Brine_Inlet_port.h_outflow);
      Xin=inStream(Brine_Inlet_port.Xi_outflow);
      Brine_Inlet_port.h_outflow = inStream(Brine_Outlet_port.h_outflow);
      Brine_Inlet_port.Xi_outflow = inStream(Brine_Outlet_port.Xi_outflow);

      Brine_Outlet_port.p = p;
      m_b_out=Brine_Outlet_port.m_flow;
      Brine_Outlet_port.h_outflow=h_b_out;
      Brine_Outlet_port.Xi_outflow=Xo;

      steam_port.p = p;
      m_steam=steam_port.m_flow;
      steam_port.h_outflow = h_steam;

      Heat_Port.T=T;
      Qhx =Heat_Port.Q_flow
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));

        annotation (Dialog(tab="Initialization"),
                  Icon(graphics={
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
              points={{60,80},{60,-80}},
              color={0,0,0},
              thickness=0.5),
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
    end Evaporator_Brine_SHP;

    model PreHeater
      replaceable package Medium_1 = Modelica.Media.Interfaces.PartialMedium
      annotation (__Dymola_choicesAllMatching=true);
      replaceable package Medium_2 = Modelica.Media.Interfaces.PartialMedium
      annotation (__Dymola_choicesAllMatching=true);
      parameter Modelica.Units.SI.Volume V2=2 "Volume of Modelica.Units.SIde 2";
      parameter Modelica.Units.SI.Temperature T2Start= 310.15;
      parameter Modelica.Units.SI.AbsolutePressure p2Start=1e5;
      parameter Modelica.Units.SI.MassFraction [:] X2Start=
                                           {0.92,
                                                0.08};

      TRANSFORM.Fluid.Volumes.SimpleVolume volume2_1(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p_start=p2Start,
        T_start=T2Start,
        X_start=X2Start,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=V2/5),
        use_HeatPort=true)
        annotation (Placement(transformation(extent={{-10,-50},{10,-70}})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a1(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-110,50},{-90,70}}),
            iconTransformation(extent={{-10,90},{10,110}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b1(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{90,50},{110,70}}),
            iconTransformation(extent={{-10,-110},{11,-88}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a2(redeclare package
          Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
        annotation (Placement(transformation(extent={{90,-70},{110,-50}}),
            iconTransformation(extent={{91,-10},{111,10}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b2(redeclare package
          Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
        annotation (Placement(transformation(extent={{-110,-70},{-90,-50}}),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      PreheaterTube    preheaterTube(   redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(
            extent={{-40,-40},{40,40}},
            rotation=180,
            origin={0,60})));
    equation
      connect(volume2_1.port_b, port_a2)
        annotation (Line(points={{6,-60},{100,-60}}, color={0,127,255}));
      connect(port_a1, preheaterTube.Liquid_Outlet_Port) annotation (Line(points={{-100,60},
              {-40,60}},                       color={0,127,255}));
      connect(preheaterTube.Steam_Inlet_Port, port_b1)
        annotation (Line(points={{40,60},{100,60}},        color={0,127,255}));
      connect(preheaterTube.Heat_Port, volume2_1.heatPort) annotation (Line(points={{
              -2.22045e-15,40},{-2.22045e-15,-7},{0,-7},{0,-54}},          color={191,
              0,0}));
      connect(port_a2, port_a2)
        annotation (Line(points={{100,-60},{100,-60}}, color={0,127,255}));
      connect(port_b2, volume2_1.port_a)
        annotation (Line(points={{-100,-60},{-6,-60}}, color={0,127,255}));
      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid,
              radius=20),
            Line(
              points={{0,100},{0,40},{40,20},{-40,-22},{0,-40},{0,-100}},
              color={238,46,47},
              thickness=1),
            Line(
              points={{0,100},{0,40},{40,20},{-40,-22},{0,-40},{0,-100}},
              color={0,0,0},
              thickness=1,
              rotation=90),
            Text(
              extent={{-78,160},{80,120}},
              textColor={0,0,0},
              textString="%name
")}));
    end PreHeater;

    model PreheaterTube
      "Tube side of a single effect, assume the water leaves fully condensed"
      import Modelica.Fluid.Types.Dynamics;
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Medium.SaturationProperties  sat;
      Modelica.Units.SI.AbsolutePressure p;
      Modelica.Units.SI.SpecificEnthalpy h_g;
      Modelica.Units.SI.SpecificEnthalpy h_f;
      Modelica.Units.SI.SpecificEnthalpy h_in;
      Modelica.Units.SI.SpecificEnthalpy h_out;
      Modelica.Units.SI.MassFlowRate mdot;
      Modelica.Units.SI.HeatFlowRate Qhx;

      TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow Heat_Port
        annotation (Placement(transformation(extent={{-10,40},{10,60}}),
            iconTransformation(extent={{-10,40},{10,60}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow Steam_Inlet_Port(
      redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State Liquid_Outlet_Port(
      redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    equation

      sat.psat = p;
      sat.Tsat = Medium.saturationTemperature(p);
      h_f = Medium.bubbleEnthalpy(sat);
      h_g = Medium.dewEnthalpy(sat);

      h_out=h_f;

      Liquid_Outlet_Port.p = p;
      Liquid_Outlet_Port.h_outflow=h_out;
     - mdot=Liquid_Outlet_Port.m_flow;

      Steam_Inlet_Port.p = p;
      mdot=Steam_Inlet_Port.m_flow;
      Steam_Inlet_Port.h_outflow = h_g;
      h_in =inStream(Steam_Inlet_Port.h_outflow);

      Qhx=(h_in-h_f)*mdot;
      Qhx =Heat_Port.Q_flow;

     annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-90,40},{90,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor=DynamicSelect({0,127,255}, if showColors then dynColor else {0,127,255})),
            Polygon(
              points={{68,40},{-90,42},{-90,-40},{-56,-38},{-50,-22},{-30,-12},{
                  -26,0},{-16,4},{0,20},{68,40}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-90,42},{90,34}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Backward),
            Rectangle(
              extent={{-90,-32},{90,-40}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Backward)}),                  Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end PreheaterTube;

    model GOR
      Modelica.Blocks.Continuous.Integrator integrator1(use_reset=true)
        annotation (Placement(transformation(extent={{-40,-40},{-20,-60}})));
      Modelica.Blocks.Continuous.Integrator SteamMass(use_reset=true, y_start=
            msteamStart)
        annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
      Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=startTime)
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
      Modelica.Blocks.Interfaces.RealInput SteamFlow
        annotation (Placement(transformation(extent={{-120,30},{-80,70}})));
      Modelica.Blocks.Interfaces.RealInput CondFlow
        annotation (Placement(transformation(extent={{-120,-70},{-80,-30}})));
      Modelica.Blocks.Math.Division TotalGORdiv
        annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
      Modelica.Blocks.Math.Division ContinuousGORdiv
        annotation (Placement(transformation(extent={{40,20},{60,40}})));
        parameter Modelica.Units.SI.Time startTime=100;
        parameter Modelica.Units.SI.MassFlowRate msteamStart=1;
      Modelica.Blocks.Math.Gain gain(k=-1)
        annotation (Placement(transformation(extent={{-72,-60},{-52,-40}})));
      Modelica.Blocks.Interfaces.RealOutput ContinuousGOR
        annotation (Placement(transformation(extent={{100,20},{120,40}})));
      Modelica.Blocks.Interfaces.RealOutput TotalGOR
        annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
    equation
      connect(booleanStep.y, SteamMass.reset)
        annotation (Line(points={{-79,0},{-24,0},{-24,38}}, color={255,0,255}));
      connect(booleanStep.y, integrator1.reset)
        annotation (Line(points={{-79,0},{-24,0},{-24,-38}}, color={255,0,255}));
      connect(SteamFlow, SteamMass.u)
        annotation (Line(points={{-100,50},{-42,50}}, color={0,0,127}));
      connect(SteamMass.y, TotalGORdiv.u2) annotation (Line(points={{-19,50},{
              -12,50},{-12,-28},{30,-28},{30,-36},{38,-36}}, color={0,0,127}));
      connect(integrator1.y, TotalGORdiv.u1) annotation (Line(points={{-19,-50},
              {28,-50},{28,-24},{38,-24}}, color={0,0,127}));
      connect(SteamFlow, ContinuousGORdiv.u2) annotation (Line(points={{-100,50},
              {-48,50},{-48,24},{38,24}}, color={0,0,127}));
      connect(CondFlow, gain.u)
        annotation (Line(points={{-100,-50},{-74,-50}}, color={0,0,127}));
      connect(gain.y, integrator1.u)
        annotation (Line(points={{-51,-50},{-42,-50}}, color={0,0,127}));
      connect(gain.y, ContinuousGORdiv.u1) annotation (Line(points={{-51,-50},{
              -48,-50},{-48,10},{0,10},{0,36},{38,36}}, color={0,0,127}));
      connect(ContinuousGORdiv.y, ContinuousGOR)
        annotation (Line(points={{61,30},{110,30}}, color={0,0,127}));
      connect(TotalGOR, TotalGOR)
        annotation (Line(points={{110,-30},{110,-30}}, color={0,0,127}));
      connect(TotalGORdiv.y, TotalGOR)
        annotation (Line(points={{61,-30},{110,-30}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end GOR;

    model SEE_Tube_Side_PoolBoiling
     import Modelica.Fluid.Types.Dynamics;

    replaceable package MediumT = Modelica.Media.Water.StandardWater;
    replaceable package MediumS = Modelica.Media.Water.StandardWater;
    MediumS.SaturationProperties  satS;
    MediumT.SaturationProperties  satT;
    MediumT.ThermodynamicState LiT;
    MediumT.ThermodynamicState VaT;
    MediumS.ThermodynamicState LiS;
    MediumS.ThermodynamicState VaS;
    parameter Modelica.Units.SI.AbsolutePressure p_start=1e5  "tube side pressure start";
    parameter Modelica.Units.SI.MassFlowRate m_start=1 "start mass flow rate";
    parameter Modelica.Units.SI.Area Ax=1e4
                                           "Heat Transfer Area (Outside Tube Area)";
    parameter Modelica.Units.SI.Diameter Do=0.01
                                                "Outer Diameter of the Tubes";
    parameter Modelica.Units.SI.Thickness th=0.001
                                                  "Thickness of the Cladding";
    parameter Modelica.Units.SI.PressureDifference dP=10
                                                        "Pressure Drop across the tubes";
    parameter Modelica.Units.SI.ThermalConductivity k=0.01
                                                          "Thermal Conductivity of the Cladding";
    parameter Integer nV=5 "Number of Nodes";

    parameter Modelica.Units.SI.SpecificEnthalpy hinstart=MediumT.dewEnthalpy(MediumT.setSat_p(p_start));
    //2000e3;
    //
    parameter Modelica.Units.SI.SpecificEnthalpy houtstart=MediumT.bubbleEnthalpy(MediumT.setSat_p(p_start));
    //400e3;
    //
    parameter Modelica.Units.SI.SpecificEnthalpy hstart[:]=linspace(
                                                           hinstart,
                                                           houtstart,nV);
    parameter Modelica.Units.SI.Temperature TwTst=MediumT.saturationTemperature((p_start))-3;
    parameter Modelica.Units.SI.Temperature TwSst=MediumS.saturationTemperature(max((p_start-0.3e5),1e4))+3;
    parameter Modelica.Units.SI.Temperature TwTstart[:]=linspace(TwTst,TwTst,nV);
    parameter Modelica.Units.SI.Temperature TwSstart[:]=linspace(TwSst,TwSst,nV);

      Modelica.Units.SI.Area Axt;
      Modelica.Units.SI.AbsolutePressure pT(start=p_start);
      Modelica.Units.SI.AbsolutePressure pS;
      Modelica.Units.SI.AbsolutePressure Pcr;
      Modelica.Units.SI.SpecificEnthalpy h_gT;
      Modelica.Units.SI.SpecificEnthalpy h_in(start=hinstart);
      Modelica.Units.SI.SpecificEnthalpy h_out[nV](start=hstart);
      Modelica.Units.SI.MassFlowRate mdot;
      Modelica.Units.SI.HeatFlowRate Qhx[nV];
      Modelica.Units.SI.HeatFlowRate Q;
      //Modelica.Units.SI.CoefficientOfHeatTransfer ho[nV];
      Modelica.Units.SI.CoefficientOfHeatTransfer hi[nV];
      Modelica.Units.SI.Diameter Di;
      Modelica.Units.SI.Area Axi;
      Modelica.Units.SI.ThermalConductivity kT;
      Modelica.Units.SI.ThermalConductivity kS;
      Modelica.Units.SI.ThermalConductivity lamT;
      Modelica.Units.SI.DynamicViscosity mufT;
      Modelica.Units.SI.DynamicViscosity mugT;
      Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cpT;
      Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cpS;
      Modelica.Units.SI.Density rhofT;
      Modelica.Units.SI.Density rhogT;
      Modelica.Units.SI.Density rhofS;
      Modelica.Units.SI.Density rhogS;
      Modelica.Units.SI.SpecificEnthalpy hfT;
      Modelica.Units.SI.SpecificEnthalpy hgT;
      Modelica.Units.SI.SpecificEnthalpy hfS;
      Modelica.Units.SI.SpecificEnthalpy hgS;
      Modelica.Units.SI.SpecificEnthalpy hfgT;
      Modelica.Units.SI.Temperature TwT[nV](start=TwTstart);
      Modelica.Units.SI.Temperature TwS[nV](start=TwSstart);
      Modelica.Units.SI.Temperature TS;
      Modelica.Units.SI.Temperature TsT[nV];
      Real PrT;
      Real PrS;
      Modelica.Units.SI.Diameter ls;
      Modelica.Units.SI.Thickness delta[nV];
      Modelica.Units.SI.DynamicViscosity muS;
      Modelica.Units.SI.SurfaceTension sigma;

      TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow Heat_Port
        annotation (Placement(transformation(extent={{-10,40},{10,60}}),
            iconTransformation(extent={{-10,40},{10,60}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow Steam_Inlet_Port(
      p(start=p_start),
      redeclare package Medium = MediumT)
        annotation (
        Placement(transformation(extent={{-110,-10},{-90,10}})));

      TRANSFORM.Fluid.Interfaces.FluidPort_State Liquid_Outlet_Port(
      p(start=p_start-dP),
      redeclare package Medium = MediumT)
        annotation (
        Placement(transformation(extent={{90,-10},{110,10}})));

    //initial equation
    //  for i in 1:nV loop
    //    h_out[i]=hstart;
    //  end for;

    algorithm
      Axt:=Ax/nV;
      Di:=Do - 2*th;
      Axi:=Axt*Di/Do;
    equation
      //Tube Side


      satT.psat = pT;
      satT.Tsat = MediumT.saturationTemperature(pT);
      h_gT = MediumT.dewEnthalpy(satT);
      kT= MediumT.thermalConductivity(VaT);
      LiT=MediumT.setBubbleState(satT);
      VaT=MediumT.setDewState(satT);
      mufT= MediumT.dynamicViscosity(LiT);
      mugT= MediumT.dynamicViscosity(VaT);
      lamT= MediumT.thermalConductivity(LiT);
      cpT= MediumT.specificHeatCapacityCp(LiT);
      rhogT=MediumT.density(VaT);
      rhofT=MediumT.density(LiT);
      hfT=MediumT.specificEnthalpy(LiT);
      hgT=MediumT.specificEnthalpy(VaT);
      PrT=MediumT.prandtlNumber(LiT);
      hfgT=hgT-hfT;


      //Shell Side
      TS=satS.Tsat;
      satS.psat= MediumS.saturationPressure(TS);
      pS=satS.psat;
      LiS=MediumS.setBubbleState(satS);
      VaS=MediumS.setDewState(satS);
      hfS=MediumS.specificEnthalpy(LiS);
      hgS=MediumS.specificEnthalpy(VaS);
      rhogS=MediumS.density(VaS);
      rhofS=MediumS.density(LiS);
      kS=MediumS.thermalConductivity(LiS);
      Pcr=220e5;
      sigma=MediumS.surfaceTension(satS);
      ls=sqrt((sigma/(rhofS-rhogS))*Modelica.Constants.g_n);
      muS=MediumS.dynamicViscosity(LiS);
      cpS= MediumS.specificHeatCapacityCp(LiT);
      PrS=MediumS.prandtlNumber(LiT);

      //Clading


      for i in 1:nV loop
      TsT[i]=MediumT.temperature_ph(pT,h_out[i]);

      hi[i]=NHES.Fluid.ClosureModels.HeatTransfer.alpha_Nusselt_Cond_horizontal_tubes( TwT[i],satT.Tsat,hgT,hfT,rhogT,rhofT,lamT,cpT,PrT,Di);
      //hi[i]=TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.Condensation.alpha_NusseltTheory_Condensation(
        //  Di,kT,rhofT,mufT,lamT,cpT,rhogT,mugT,hfgT,TsT[i],satT.Tsat,TwT[i]);
      Qhx[i]=hi[i]*Axi*(TsT[i]-TwT[i]);
      //delta[i]=1;
      delta[i]=(kS*(TwS[i]-TS)*Axt/(Qhx[i]));
      //Qhx[i]=((3.36e-5)*((ls/delta[i])^1.18)*((pS/Pcr)^(-0.58))
              //*((pS*ls/(muS*(hgS-hfS)^0.5))^0.406)*(muS*(hgS-hfS)*Axt/ls));
      Qhx[i]=Axt*((cpS*(TwS[i]-TS)/((hgS-hfS)*(PrS*0.01)))^3)*muS*(hgS-hfS)*
            ((Modelica.Constants.g_n*(rhofS-rhogS)/sigma)^0.5);
      Qhx[i]=2*k*Axt/(Do*log(Do/Di))*(TwT[i]-TwS[i]);

      end for;



     // Total HT
     if mdot>1e-8 then
     h_out[1]=h_in-Qhx[1]/mdot;
     else
     h_out[1]=h_in;
     end if;
     if mdot>1e-8 then
     for i in 2:nV loop
         h_out[i]=h_out[i-1]-Qhx[i]/mdot;
     end for;
      else
       for i in 2:nV loop
         h_out[i]=h_out[i-1];
     end for;
     end if;

      Q=sum(Qhx);
      //Connectors
      Liquid_Outlet_Port.p = pT-dP;
      Liquid_Outlet_Port.h_outflow=h_out[nV];
     - mdot=Liquid_Outlet_Port.m_flow;

      Steam_Inlet_Port.p = pT;
      mdot=Steam_Inlet_Port.m_flow;
      Steam_Inlet_Port.h_outflow = h_gT;
      h_in =inStream(Steam_Inlet_Port.h_outflow);
      TS=Heat_Port.T;
      Q =-Heat_Port.Q_flow;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-90,40},{90,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor=DynamicSelect({0,127,255}, if showColors then dynColor
                   else {0,127,255})),
            Polygon(
              points={{68,40},{-90,42},{-90,-40},{-56,-38},{-50,-22},{-30,-12},{-26,
                  0},{-16,4},{0,20},{68,40}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-90,42},{90,34}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Backward),
            Rectangle(
              extent={{-90,-32},{90,-40}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Backward),
            Text(
              extent={{-100,-40},{100,-60}},
              textColor={28,108,200},
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end SEE_Tube_Side_PoolBoiling;

    model Evaporator_Brine_SHP_ss
      "Evaporator for desalinaition, this model has a single heat port and use SeaWater Media Package;"

      import Modelica.Fluid.Types.Dynamics;

    replaceable package MediumW = Modelica.Media.Water.StandardWater;
    replaceable package MediumB = NHES.Media.SeaWater;

      MediumW.ThermodynamicState vapourState "Thermodynamic state of the vapour";
      MediumB.ThermodynamicState bstate "Thermodynamic state of the brine";

      outer Modelica.Fluid.System system "System properties";
    // Initialization
      parameter Modelica.Units.SI.Pressure p=0.5e5
                                                  "system pressure";


     /* Assumptions */
      parameter Boolean allowFlowReversal=system.allowFlowReversal
        "= true to allow flow reversal, false restrics to design direction"
      annotation(Dialog(tab="Assumptions"));

     Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Heat_Port
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      parameter Modelica.Units.SI.Temperature T_st=300 "init temp";
      parameter Modelica.Units.SI.SpecificEnthalpy h_b_in=300e3;
      Modelica.Units.SI.SpecificEnthalpy h_b_out;
      Modelica.Units.SI.SpecificEnthalpy h_steam;
      Modelica.Units.SI.MassFlowRate m_b_in;
      Modelica.Units.SI.MassFlowRate m_b_out;
      Modelica.Units.SI.MassFlowRate m_steam;
      Modelica.Units.SI.Power Qhx;
      Modelica.Units.SI.MassFraction [2] Xin;
      Modelica.Units.SI.MassFraction [2] Xo;
      parameter Modelica.Units.SI.MassFraction Cs_in=0.08;
      parameter Modelica.Units.SI.MassFraction Cs_out=0.1;
      Modelica.Units.SI.Temperature T(start=T_st);
      Modelica.Units.SI.SpecificEnergy chemp;
      Modelica.Units.SI.SpecificGibbsFreeEnergy gW;

    equation

      0=m_b_in+m_b_out+m_steam;
      Cs_out=Cs_in*abs(m_b_in/m_b_out);
      //-m_steam=Qhx/(h_steam-h_b_out);
      0=Qhx+h_steam*m_steam+h_b_in*m_b_in+h_b_out*m_b_out;
    //Definitions  & Stae Eqs
      bstate=MediumB.setState_pTX(p,T,Xo);
      h_b_out=MediumB.specificEnthalpy(bstate);
      chemp=MediumB.mu_pTX(p,T,Xo);
      Xin[1]=1-Cs_in;
      Xin[2]=Cs_in;
      Xo[2]=Cs_out;
      Xo[1]=1-Cs_out;

      h_steam=MediumW.specificEnthalpy(vapourState);
      gW=MediumW.specificGibbsEnergy(vapourState);
      vapourState = MediumW.setState_pT(p, T);


      gW=chemp;




      Heat_Port.T=T_st;
      Qhx =Heat_Port.Q_flow;
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
              points={{60,80},{60,-80}},
              color={0,0,0},
              thickness=0.5),
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
    end Evaporator_Brine_SHP_ss;
  end Components;

  package Examples

    model Single_Effect_Diff "Test of a single effect with constant UA"

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1) annotation (Placement(transformation(extent={{-120,-10},{-100,
                10}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=70000,
        nPorts=1) annotation (Placement(transformation(extent={{22,50},{2,70}})));
      Single_Effect.Water_Models.Single_Effect_W sEE_mkUA(
        Psys=70000,
        V=0.5,
        A=1,
        KV=-0.03,
        Ax=2.68e4,
        pT=100000)
        annotation (Placement(transformation(extent={{-80,-30},{-20,30}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1.5,
        h=2725.9e3,
        nPorts=1) annotation (Placement(transformation(extent={{-120,-50},{-100,
                -30}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{22,-48},{2,-28}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=4,
        h=335000,
        nPorts=1) annotation (Placement(transformation(extent={{20,-12},{0,8}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=0.08)
                                                                    annotation (Placement(transformation(extent={{20,8},{
                0,28}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=70000,
        nPorts=1) annotation (Placement(transformation(extent={{182,48},{162,68}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1,
        h=2725.9e3,
        nPorts=1) annotation (Placement(transformation(extent={{42,-50},{62,-30}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{182,-50},{162,
                -30}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=1)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));

      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        use_m_flow_in=false,
        use_X_in=false,
        m_flow=4,
        T=353.15,
        X={0.92,0.08},
        nPorts=1)
        annotation (Placement(transformation(extent={{180,-10},{160,10}})));

      Single_Effect.Brine_Models.Single_Effect single_Effect(
        V=0.5,
        A=1,
        Ax=2e4,
        pT=100000)
        annotation (Placement(transformation(extent={{72,-30},{130,28}})));
    equation
      connect(sEE_mkUA.Brine_Outlet_Port, Brine_Oulet.ports[1]) annotation (
          Line(points={{-80,0},{-100,0}},         color={0,127,255}));
      connect(Tube_Inlet.ports[1], sEE_mkUA.Tube_Inlet) annotation (Line(points={{-100,
              -40},{-88,-40},{-88,-12},{-79.4,-12}},         color={0,127,255}));
      connect(Brine_Oulet1.ports[1], sEE_mkUA.Tube_Outlet) annotation (Line(
            points={{2,-38},{-10,-38},{-10,-12},{-19.4,-12}},  color={0,127,255}));
      connect(realExpression1.y, sEE_mkUA.Cs_In) annotation (Line(points={{-1,18},
              {-12,18},{-12,6},{-20,6}},       color={0,0,127}));
      connect(Brine_Inlet1.ports[1], sEE_mkUA.Brine_Inlet_Port) annotation (
          Line(points={{0,-2},{-10,-2},{-10,0},{-20,0}},     color={0,127,255}));
      connect(sEE_mkUA.Steam_Outlet_Port, Steam_Exit.ports[1]) annotation (Line(
            points={{-50,30},{-50,60},{2,60}}, color={0,127,255}));
      connect(single_Effect.Brine_Inlet_Port, boundary1.ports[1]) annotation (
          Line(points={{130,-1},{146,-1},{146,0},{160,0}}, color={0,127,255}));
      connect(single_Effect.Steam_Outlet_Port, Steam_Exit1.ports[1])
        annotation (Line(points={{101,28},{102,28},{102,58},{162,58}}, color={0,
              127,255}));
      connect(single_Effect.Brine_Outlet_Port, boundary.ports[1]) annotation (
          Line(points={{72,-1},{66,-1},{66,4},{60,4},{60,0}}, color={0,127,255}));
      connect(single_Effect.Tube_Inlet, Tube_Inlet1.ports[1]) annotation (Line(
            points={{72.58,-12.6},{64,-12.6},{64,-26},{66,-26},{66,-40},{62,-40}},
            color={0,127,255}));
      connect(single_Effect.Tube_Outlet, Brine_Oulet2.ports[1]) annotation (
          Line(points={{130.58,-12.6},{148.29,-12.6},{148.29,-40},{162,-40}},
            color={0,127,255}));
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
    end Single_Effect_Diff;

    model MEE_FC_test "Test of a multi effect with full condensing"

      Multiple_Effect.MEE_FC mEE_FCwPH(
        redeclare replaceable Data.MEE_Data data(
          nE=8,
          use_preheater=false,
          T_b_in=298.15,
          T_h=353.15,
          p_h=70000,
          use_flowrates=false,
          X_nom=0.09),
        Brine_Source(X={0.99,0.01}),
        PCV(
          ValvePos_start=0.7,
          init_time=10,
          PID_k=-0.5e-6),
        SCV(dp_nominal=100000))
        annotation (Placement(transformation(extent={{-56,-46},{44,54}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1,
        T=398.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Steam_Exit(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=5000,
        T=328.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-26},{80,-6}})));
    equation
      connect(Tube_Inlet.ports[1], mEE_FCwPH.port_a_steam)
        annotation (Line(points={{-80,24},{-56,24}}, color={0,127,255}));
      connect(mEE_FCwPH.port_b_liquid_return, Liquid_Return.ports[1])
        annotation (Line(points={{-56,-16},{-80,-16}}, color={0,127,255}));
      connect(mEE_FCwPH.port_b_liquid_cond, Steam_Exit.ports[1])
        annotation (Line(points={{44,-16},{80,-16}}, color={0,127,255}));
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
          StopTime=2000,
          Interval=50,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_FC_test;

    model MEE_HX_test "Test of a multi effect with heat transfer correlations"

      Multiple_Effect.MEE_HX mEE_HXw(redeclare replaceable Data.MEE_Data data(
          nE=3,
          p_h=90000,
          use_flowrates=false,
          Axnom=1e4,
          pTsys={200000,100000,500000}))
        annotation (Placement(transformation(extent={{-54,-46},{46,54}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=true,
        p=10000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1,
        T=398.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Steam_Exit(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=5000,
        T=328.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-26},{80,-6}})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=1.9e5,
        duration=100,
        offset=0.1e5,
        startTime=5)
        annotation (Placement(transformation(extent={{-194,-32},{-174,-12}})));
    equation
      connect(Tube_Inlet.ports[1], mEE_HXw.port_a_steam)
        annotation (Line(points={{-80,24},{-54,24}}, color={0,127,255}));
      connect(mEE_HXw.port_b_liquid_return, Liquid_Return.ports[1])
        annotation (Line(points={{-54,-16},{-80,-16}}, color={0,127,255}));
      connect(mEE_HXw.port_b_liquid_cond, Steam_Exit.ports[1])
        annotation (Line(points={{46,-16},{80,-16}}, color={0,127,255}));
      connect(ramp.y, Liquid_Return.p_in) annotation (Line(points={{-173,-22},{
              -112,-22},{-112,-8},{-102,-8}}, color={0,0,127}));
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
          StopTime=2000,
          Interval=5,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_HX_test;

    model Single_Effect_pool "Test of a single effect with constant UA"

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=70000,
        nPorts=1) annotation (Placement(transformation(extent={{-6,38},{-26,58}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1,
        h=2725.9e3,
        nPorts=1) annotation (Placement(transformation(extent={{-146,-60},{-126,
                -40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{-6,-60},{-26,
                -40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=1)
        annotation (Placement(transformation(extent={{-148,-20},{-128,0}})));

      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        use_m_flow_in=false,
        use_X_in=false,
        m_flow=4,
        T=353.15,
        X={0.92,0.08},
        nPorts=1)
        annotation (Placement(transformation(extent={{-8,-20},{-28,0}})));

      Single_Effect.Brine_Models.Single_Effect_pool
                                               single_Effect_pool(
        V=50,
        A=1,
        Ax=2e4,
        pT=100000)
        annotation (Placement(transformation(extent={{-114,-40},{-56,18}})));
    equation
      connect(single_Effect_pool.Brine_Inlet_Port, boundary3.ports[1])
        annotation (Line(points={{-56,-11},{-43,-11},{-43,-10},{-28,-10}},
            color={0,127,255}));
      connect(single_Effect_pool.Steam_Outlet_Port, Steam_Exit2.ports[1])
        annotation (Line(points={{-85,18},{-88,18},{-88,48},{-26,48}}, color={0,
              127,255}));
      connect(single_Effect_pool.Brine_Outlet_Port, boundary2.ports[1])
        annotation (Line(points={{-114,-11},{-122,-11},{-122,-10},{-128,-10}},
            color={0,127,255}));
      connect(single_Effect_pool.Tube_Inlet, Tube_Inlet2.ports[1]) annotation (
          Line(points={{-113.42,-22.6},{-124,-22.6},{-124,-36},{-122,-36},{-122,
              -50},{-126,-50}}, color={0,127,255}));
      connect(single_Effect_pool.Tube_Outlet, Brine_Oulet1.ports[1])
        annotation (Line(points={{-55.42,-22.6},{-32,-22.6},{-32,-50},{-26,-50}},
            color={0,127,255}));
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
    end Single_Effect_pool;

    model MEE_pool "Test of a multi effect with heat transfer correlations"

      Multiple_Effect.MEE_PB mEE_PB(
        redeclare replaceable Data.MEE_Data data(
          nE=3,
          p_h=90000,
          use_flowrates=false,
          Vnom=15,
          Axnom=1e4,
          pTsys={200000,100000,500000}),
        Effect(Evaporator(Mm_start=25)),
        SCV(
          ValvePos_start=0.5,
          init_time=50,
          PID_k=-3))
        annotation (Placement(transformation(extent={{-54,-46},{46,54}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=true,
        p=10000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1,
        T=398.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Steam_Exit(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=5000,
        T=328.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-26},{80,-6}})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=1.9e5,
        duration=100,
        offset=0.1e5,
        startTime=5)
        annotation (Placement(transformation(extent={{-194,-32},{-174,-12}})));
    equation
      connect(Tube_Inlet.ports[1], mEE_PB.port_a_steam)
        annotation (Line(points={{-80,24},{-54,24}}, color={0,127,255}));
      connect(mEE_PB.port_b_liquid_return, Liquid_Return.ports[1])
        annotation (Line(points={{-54,-16},{-80,-16}}, color={0,127,255}));
      connect(mEE_PB.port_b_liquid_cond, Steam_Exit.ports[1])
        annotation (Line(points={{46,-16},{80,-16}}, color={0,127,255}));
      connect(ramp.y, Liquid_Return.p_in) annotation (Line(points={{-173,-22},{
              -112,-22},{-112,-8},{-102,-8}}, color={0,0,127}));
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
          StopTime=2000,
          Interval=5,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_pool;

    model MEE_FC_test2 "Test of a multi effect with full condensing"

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=4,
        T=398.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
      Multiple_Effect.MEE_FC mEE_FCwPH(
        redeclare replaceable Data.MEE_Data data(
          nE=8,
          use_preheater=true,
          T_b_in=298.15,
          T_h=353.15,
          p_h=70000,
          use_flowrates=false,
          X_nom=0.09),
        Brine_Source(X={0.99,0.01}),
        PCV(
          ValvePos_start=0.9,
          init_time=1,
          PID_k=-1e-4,
          m_flow_nominal=8),
        SCV(PID_k=-5, m_flow_nominal=16),
        Effect(m_brine_out=1, KV=-0.1))
        annotation (Placement(transformation(extent={{-34,-30},{46,50}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Purified_Water(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=5000,
        T=328.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{78,-16},{58,4}})));
    equation
      connect(mEE_FCwPH.port_b_liquid_cond, Purified_Water.ports[1])
        annotation (Line(points={{46,-6},{58,-6}}, color={0,127,255}));
      connect(Tube_Inlet.ports[1], mEE_FCwPH.port_a_steam) annotation (Line(
            points={{-80,24},{-42,24},{-42,26},{-34,26}}, color={0,127,255}));
      connect(Liquid_Return.ports[1], mEE_FCwPH.port_b_liquid_return)
        annotation (Line(points={{-80,-16},{-44,-16},{-44,-6},{-34,-6}}, color=
              {0,127,255}));
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
          StopTime=200,
          Interval=10,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_FC_test2;

    model MEE_FC_test3 "Test of a multi effect with full condensing"

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        m_flow=1,
        T=398.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
      Multiple_Effect.MEE_FC mEE_FCwPH(
        redeclare replaceable Data.MEE_Data data(
          nE=8,
          use_preheater=true,
          T_b_in=298.15,
          T_h=353.15,
          p_h=70000,
          use_flowrates=false,
          X_nom=0.09),
        Brine_Source(X={0.99,0.01}),
        PCV(
          ValvePos_start=0.9,
          init_time=1,
          PID_k=-1e-4,
          m_flow_nominal=8),
        SCV(PID_k=-5, m_flow_nominal=16),
        Effect(m_brine_out=1, KV=-0.1))
        annotation (Placement(transformation(extent={{-34,-30},{46,50}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Purified_Water(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=5000,
        T=328.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{78,-16},{58,4}})));
      Modelica.Blocks.Sources.Step step(offset=1, startTime=3000)
        annotation (Placement(transformation(extent={{-160,20},{-140,40}})));
    equation
      connect(mEE_FCwPH.port_b_liquid_cond, Purified_Water.ports[1])
        annotation (Line(points={{46,-6},{58,-6}}, color={0,127,255}));
      connect(Tube_Inlet.ports[1], mEE_FCwPH.port_a_steam) annotation (Line(
            points={{-80,24},{-42,24},{-42,26},{-34,26}}, color={0,127,255}));
      connect(Liquid_Return.ports[1], mEE_FCwPH.port_b_liquid_return)
        annotation (Line(points={{-80,-16},{-44,-16},{-44,-6},{-34,-6}}, color=
              {0,127,255}));
      connect(step.y, Tube_Inlet.m_flow_in) annotation (Line(points={{-139,30},
              {-139,32},{-100,32}}, color={0,0,127}));
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
          StopTime=5000,
          Interval=10,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_FC_test3;

    model SHP_ss_test "Test of a single effect with constant UA"

      Components.Evaporator_Brine_SHP_ss evaporator_Brine_SHP_ss
        annotation (Placement(transformation(extent={{-44,-32},{44,56}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary(
          Q_flow=1000000)
        annotation (Placement(transformation(extent={{-94,-70},{-74,-50}})));
    equation
      connect(boundary.port, evaporator_Brine_SHP_ss.Heat_Port)
        annotation (Line(points={{-74,-60},{0,-60},{0,-32}}, color={191,0,0}));
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
    end SHP_ss_test;

    model MEE_ss_test "Test of a single effect with constant UA"

      Multiple_Effect.MEE_FC_ss mEE_FC_ss_delay(
                                          redeclare replaceable Data.MEE_Data
          data(nE=12, T_b_in=333.15), Cs_in=0.01)
        annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow=5,
        T=396.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-120,22},{-100,42}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-120,-38},{-100,-18}})));
    equation
      connect(boundary1.ports[1], mEE_FC_ss_delay.port_b) annotation (Line(
            points={{-100,-28},{-50,-28},{-50,-24},{-40,-24}}, color={0,127,255}));
      connect(mEE_FC_ss_delay.port_a, boundary.ports[1]) annotation (Line(
            points={{-40,24},{-94,24},{-94,32},{-100,32}}, color={0,127,255}));
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
    end MEE_ss_test;

    model boilingTest "Test of a single effect with constant UA"

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

      Components.SEE_Tube_Side_PoolBoiling sEE_Tube_Side_PoolBoiling(Ax=0.5e4)
        annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
        boundary(T=343.15)
        annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
      Modelica.Blocks.Sources.RealExpression
                                       realExpression(y=inleth)
        annotation (Placement(transformation(extent={{-194,4},{-174,24}})));
      parameter Modelica.Blocks.Interfaces.RealOutput inleth=2706e3
        "Value of Real output";
      Modelica.Blocks.Sources.Ramp ramp(
        height=0.4,
        duration=10,
        offset=1,
        startTime=350)
        annotation (Placement(transformation(extent={{-194,-32},{-174,-12}})));
    equation
      connect(Tube_Inlet.ports[1], sEE_Tube_Side_PoolBoiling.Steam_Inlet_Port)
        annotation (Line(points={{-80,0},{-40,0}}, color={0,127,255}));
      connect(boundary.port, sEE_Tube_Side_PoolBoiling.Heat_Port)
        annotation (Line(points={{-40,70},{0,70},{0,20}}, color={191,0,0}));
      connect(sEE_Tube_Side_PoolBoiling.Liquid_Outlet_Port, cond_out.ports[1])
        annotation (Line(points={{40,0},{80,0}}, color={0,127,255}));
      connect(realExpression.y, Tube_Inlet.h_in) annotation (Line(points={{-173,
              14},{-110,14},{-110,4},{-102,4}}, color={0,0,127}));
      connect(ramp.y, Tube_Inlet.m_flow_in) annotation (Line(points={{-173,-22},
              {-112,-22},{-112,16},{-100,16},{-100,8}}, color={0,0,127}));
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
    end boilingTest;

    model MEE_ss_test_delay "Test of a single effect with constant UA"

      Multiple_Effect.MEE_FC_ss_delay
                                mEE_FC_ss_delay(
                                          redeclare replaceable Data.MEE_Data
          data(nE=12, T_b_in=333.15), Cs_in=0.01,
        firstOrder(y_start=4))
        annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        m_flow=5,
        T=396.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-120,22},{-100,42}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-120,-38},{-100,-18}})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=2,
        duration=10,
        offset=5,
        startTime=350)
        annotation (Placement(transformation(extent={{-190,26},{-170,46}})));
    equation
      connect(boundary1.ports[1], mEE_FC_ss_delay.port_b) annotation (Line(
            points={{-100,-28},{-50,-28},{-50,-24},{-40,-24}}, color={0,127,255}));
      connect(mEE_FC_ss_delay.port_a, boundary.ports[1]) annotation (Line(
            points={{-40,24},{-94,24},{-94,32},{-100,32}}, color={0,127,255}));
      connect(ramp.y, boundary.m_flow_in) annotation (Line(points={{-169,36},{
              -130,36},{-130,40},{-120,40}}, color={0,0,127}));
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
    end MEE_ss_test_delay;
    annotation (Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100,-100},{100,100}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100,-100},{100,100}},
            radius=25.0),
          Polygon(
            origin={8,14},
            lineColor={78,138,73},
            fillColor={78,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
  end Examples;

  package BaseClasses
    partial model Record_Data

      extends Modelica.Icons.Record;

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_Data;

    expandable connector SignalSubBus_ActuatorInput

      extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

       Real CV1_opening;
       Real CV2_opening;
       Real CV3_opening;
       Real CV4_opening;
       Real CV5_opening;
       Real CV6_opening;
       Real CV7_opening;
       Real CV8_opening;
       Real ECV_opening;
       Real MCV_opening;
       Real TCVCV_opening;

       annotation (defaultComponentName="actuatorSubBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput;

    expandable connector SignalSubBus_SensorOutput

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;
      Modelica.Units.SI.Temperature T1set;
      Modelica.Units.SI.Temperature T2set;
      Modelica.Units.SI.Temperature T3set;
      Modelica.Units.SI.Temperature T4set;
      Modelica.Units.SI.Temperature T5set;
      Modelica.Units.SI.Temperature T6set;
      Modelica.Units.SI.Temperature T7set;
      Modelica.Units.SI.Temperature T8set;

      Modelica.Units.SI.Temperature T1;
      Modelica.Units.SI.Temperature T2;
      Modelica.Units.SI.Temperature T3;
      Modelica.Units.SI.Temperature T4;
      Modelica.Units.SI.Temperature T5;
      Modelica.Units.SI.Temperature T6;
      Modelica.Units.SI.Temperature T7;
      Modelica.Units.SI.Temperature T8;

      Modelica.Units.SI.Pressure p1set;
      Modelica.Units.SI.Pressure p2set;
      Modelica.Units.SI.Pressure p3set;
      Modelica.Units.SI.Pressure p4set;
      Modelica.Units.SI.Pressure p5set;
      Modelica.Units.SI.Pressure p6set;
      Modelica.Units.SI.Pressure p7set;
      Modelica.Units.SI.Pressure p8set;

      Modelica.Units.SI.Pressure p1;
      Modelica.Units.SI.Pressure p2;
      Modelica.Units.SI.Pressure p3;
      Modelica.Units.SI.Pressure p4;
      Modelica.Units.SI.Pressure p5;
      Modelica.Units.SI.Pressure p6;
      Modelica.Units.SI.Pressure p7;
      Modelica.Units.SI.Pressure p8;

      annotation (defaultComponentName="sensorSubBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_SensorOutput;

    partial model Partial_ControlSystem

      extends NHES.Systems.BaseClasses.Partial_ControlSystem;

      SignalSubBus_ActuatorInput actuatorBus annotation (Placement(
            transformation(extent={{10,-120},{50,-80}}), iconTransformation(
              extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput sensorBus annotation (Placement(
            transformation(extent={{-50,-120},{-10,-80}}), iconTransformation(
              extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));

    end Partial_ControlSystem;

    partial model Partial_SubSystem
      import NHES;

      extends NHES.Systems.BaseClasses.Partial_SubSystem;

      extends Record_SubSystem;

      replaceable
        Partial_ControlSystem CS
        annotation (choicesAllMatching=true, Placement(transformation(extent={{-18,122},
                {-2,138}})));
      replaceable
        Partial_EventDriver ED
        annotation (choicesAllMatching=true, Placement(transformation(extent={{2,122},
                {18,138}})));
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
          points={{30,100},{-7.6,100},{-7.6,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, ED.actuatorBus) annotation (Line(
          points={{30,100},{20,100},{12.4,100},{12.4,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      annotation (
        defaultComponentName="BOP",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics={
            Ellipse(
              extent={{-88,12},{-48,32}},
              lineColor={0,0,0},
              startAngle=0,
              endAngle=360,
              fillColor={164,189,255},
              fillPattern=FillPattern.Solid,
              lineThickness=0.5),
            Ellipse(
              extent={{-88,-28},{-48,-8}},
              lineColor={0,0,0},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              lineThickness=0.5),
            Rectangle(
              extent={{-88,22},{-48,-18}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-88,22},{-48,8}},
              lineColor={164,189,255},
              fillColor={164,189,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-54,6},{-50,10}},
              lineThickness=1,
              fillColor={164,189,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0},
              closure=EllipseClosure.Chord),
            Ellipse(
              extent={{-88,4},{-82,10}},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Line(
              points={{-88,22},{-88,-18}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-48,22},{-48,-18}},
              color={0,0,0},
              thickness=0.5),
            Ellipse(
              extent={{-74,4},{-66,10}},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Ellipse(
              extent={{-62,4},{-54,10}},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Line(
              points={{-54,6},{-50,6}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{-88,8},{-84,10},{-78,6},{-70,10},{-66,8},{-62,8},{-56,10},
                  {-54,6},{-48,8}},
              color={0,0,0},
              smooth=Smooth.Bezier,
              thickness=1),
            Ellipse(
              extent={{-20,12},{20,32}},
              lineColor={0,0,0},
              startAngle=0,
              endAngle=360,
              fillColor={164,189,255},
              fillPattern=FillPattern.Solid,
              lineThickness=0.5),
            Ellipse(
              extent={{-20,-28},{20,-8}},
              lineColor={0,0,0},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              lineThickness=0.5),
            Rectangle(
              extent={{-20,22},{20,-18}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,22},{20,8}},
              lineColor={164,189,255},
              fillColor={164,189,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{14,6},{18,10}},
              lineThickness=1,
              fillColor={164,189,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0},
              closure=EllipseClosure.Chord),
            Ellipse(
              extent={{-20,4},{-14,10}},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Line(
              points={{-20,22},{-20,-18}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{20,22},{20,-18}},
              color={0,0,0},
              thickness=0.5),
            Ellipse(
              extent={{-6,4},{2,10}},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Ellipse(
              extent={{6,4},{14,10}},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Line(
              points={{14,6},{18,6}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{-20,8},{-16,10},{-10,6},{-2,10},{2,8},{6,8},{12,10},{14,
                  6},{20,8}},
              color={0,0,0},
              smooth=Smooth.Bezier,
              thickness=1),
            Ellipse(
              extent={{48,12},{88,32}},
              lineColor={0,0,0},
              startAngle=0,
              endAngle=360,
              fillColor={164,189,255},
              fillPattern=FillPattern.Solid,
              lineThickness=0.5),
            Ellipse(
              extent={{48,-28},{88,-8}},
              lineColor={0,0,0},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              lineThickness=0.5),
            Rectangle(
              extent={{48,22},{88,-18}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{48,22},{88,8}},
              lineColor={164,189,255},
              fillColor={164,189,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{82,6},{86,10}},
              lineThickness=1,
              fillColor={164,189,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0},
              closure=EllipseClosure.Chord),
            Ellipse(
              extent={{48,4},{54,10}},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Line(
              points={{48,22},{48,-18}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{88,22},{88,-18}},
              color={0,0,0},
              thickness=0.5),
            Ellipse(
              extent={{62,4},{70,10}},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Ellipse(
              extent={{74,4},{82,10}},
              lineThickness=1,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Line(
              points={{82,6},{86,6}},
              color={28,108,200},
              thickness=1),
            Line(
              points={{48,8},{52,10},{58,6},{66,10},{70,8},{74,8},{80,10},{82,6},
                  {88,8}},
              color={0,0,0},
              smooth=Smooth.Bezier,
              thickness=1),
            Line(
              points={{94,54},{-68,54},{-68,40}},
              color={0,0,0},
              thickness=1,
              arrow={Arrow.None,Arrow.Open}),
            Line(
              points={{68,54},{68,40}},
              color={0,0,0},
              thickness=1,
              arrow={Arrow.None,Arrow.Open}),
            Line(
              points={{0,54},{0,40}},
              color={0,0,0},
              thickness=1,
              arrow={Arrow.None,Arrow.Open}),
            Line(
              points={{-48,16},{-34,16},{-34,-4},{-22,-4}},
              color={0,0,0},
              thickness=1,
              arrow={Arrow.None,Arrow.Open}),
            Line(
              points={{20,14},{34,14},{34,-6},{46,-6}},
              color={0,0,0},
              thickness=1,
              arrow={Arrow.None,Arrow.Open}),
            Text(
              extent={{-76,28},{-58,10}},
              textColor={0,0,0},
              textString="1"),
            Text(
              extent={{-10,28},{8,10}},
              textColor={0,0,0},
              textString="2"),
            Text(
              extent={{60,28},{78,10}},
              textColor={0,0,0},
              textString="nE")}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,140}})));
    end Partial_SubSystem;

    partial record Record_SubSystem

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem;

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

    partial model Partial_SubSystem_A

      import Modelica.Constants;

      extends Partial_SubSystem;
      //extends Record_SubSystem_A;
        replaceable package Water = Modelica.Media.Water.StandardWater constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
        annotation (choicesAllMatching=true);
      replaceable package Brine = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX) constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
        annotation (choicesAllMatching=true);

      Modelica.Fluid.Interfaces.FluidPort_a Steam_Input(redeclare package
          Medium =
            Water, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
        "Input Steam for the first effect" annotation (Placement(transformation(
              extent={{-568,30},{-548,50}}), iconTransformation(extent={{-90,50},
                {-110,30}})));

      Modelica.Fluid.Interfaces.FluidPort_b Water_Outlet(redeclare package
          Medium =
            Water, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
        "Output of condensed steam used in the first effect" annotation (Placement(
            transformation(extent={{-568,-50},{-548,-30}}), iconTransformation(
              extent={{-90,-30},{-110,-50}})));

      Modelica.Fluid.Interfaces.FluidPort_b Condensate_Oulet(redeclare package
          Medium = Water, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
        "Outlet of desalinated water" annotation (Placement(transformation(extent={{
                -568,-150},{-548,-130}}), iconTransformation(extent={{-10,-108},{10,
                -88}})));

      Modelica.Fluid.Interfaces.FluidPort_a Saltwater_Input(redeclare package
          Medium = Brine, m_flow(min=if allowFlowReversal then -
              Constants.inf else 0)) "Source of saltwater" annotation (Placement(
            transformation(extent={{550,30},{570,50}}), iconTransformation(extent={{90,30},
                {110,50}})));
      Modelica.Fluid.Interfaces.FluidPort_b Saltwater_Reject_Oulet(redeclare
          package Medium = Brine, m_flow(max=if
              allowFlowReversal then +Constants.inf else 0))
        "Oulet for rejected Saltwater" annotation (Placement(transformation(extent={
                {550,-50},{570,-30}}), iconTransformation(extent={{90,-50},{110,
                -30}})));

      parameter Boolean allowFlowReversal= true
        "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);

      annotation (
        defaultComponentName="MEE",
        Icon(coordinateSystem(                           extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-560,-140},{560,
                180}})));

    end Partial_SubSystem_A;

    partial record Record_SubSystem_A

      extends Record_SubSystem;

      replaceable package Water = Modelica.Media.Water.StandardWater constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
        annotation (choicesAllMatching=true);
      replaceable package Brine = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX) constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
        annotation (choicesAllMatching=true);

      /* Nominal Conditions */
      parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_nominal(
          redeclare package Medium = Water, h=Water.specificEnthalpy(
            Water.setState_pT(port_a_nominal.p, port_a_nominal.T))) "port_a"
        annotation (Dialog(tab="Nominal Conditions"));
      parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_nominal(
          redeclare package Medium = Water, h=Water.specificEnthalpy(
            Water.setState_pT(port_b_nominal.p, port_b_nominal.T)),
        m_flow=-port_a_nominal.m_flow) "port_b"
        annotation (Dialog(tab="Nominal Conditions"));
      parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b2_nominal(
          redeclare package Medium = Water, h=Water.specificEnthalpy(
            Water.setState_pT(port_b2_nominal.p, port_b2_nominal.T)),
        m_flow=-port_a_nominal.m_flow) "port_b"
        annotation (Dialog(tab="Nominal Conditions"));

      parameter NHES.Systems.BaseClasses.Record_fluidPortsX port_a1_nominal(
          redeclare package Medium = Brine, h=Brine.specificEnthalpy(
            Brine.setState_pTX(port_a1_nominal.p, port_a1_nominal.T,
            port_a1_nominal.X))) "port_a"
        annotation (Dialog(tab="Nominal Conditions"));
      parameter NHES.Systems.BaseClasses.Record_fluidPortsX port_b1_nominal(
        redeclare package Medium = Brine,
        h=Brine.specificEnthalpy(Brine.setState_pTX(port_b1_nominal.p,
            port_b1_nominal.T,port_b1_nominal.X)),
        m_flow=-port_a_nominal.m_flow) "port_b"
        annotation (Dialog(tab="Nominal Conditions"));

      /* Initialization */
      parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_start(
        redeclare package Medium = Water,
        p=port_a_nominal.p,
        T=port_a_nominal.T,
        h=Water.specificEnthalpy(Water.setState_pT(port_a_start.p, port_a_start.T)),
        m_flow=port_a_nominal.m_flow) "port_a"
        annotation (Dialog(tab="Initialization"));

      parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_start(
        redeclare package Medium = Water,
        p=port_b_nominal.p,
        T=port_b_nominal.T,
        h=Water.specificEnthalpy(Water.setState_pT(port_b_start.p, port_b_start.T)),
        m_flow=-port_a_start.m_flow) "port_b"
        annotation (Dialog(tab="Initialization"));

         parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b2_start(
        redeclare package Medium = Water,
        p=port_b2_nominal.p,
        T=port_b2_nominal.T,
        h=Water.specificEnthalpy(Water.setState_pT(port_b2_start.p, port_b2_start.T)),
        m_flow=-port_a_start.m_flow) "port_b"
        annotation (Dialog(tab="Initialization"));

          parameter NHES.Systems.BaseClasses.Record_fluidPortsX port_a1_start(
        redeclare package Medium = Brine,
        p=port_a1_nominal.p,
        T=port_a1_nominal.T,
        X=port_a1_nominal.X,
        h=Brine.specificEnthalpy(Brine.setState_pTX(port_a1_start.p, port_a1_start.T,port_a1_start.X)),
        m_flow=port_a_nominal.m_flow) "port_a"
        annotation (Dialog(tab="Initialization"));

      parameter NHES.Systems.BaseClasses.Record_fluidPortsX port_b1_start(
        redeclare package Medium = Brine,
        p=port_b1_nominal.p,
        T=port_b1_nominal.T,
        X=port_b1_nominal.X,
        h=Brine.specificEnthalpy(Brine.setState_pTX(port_b1_start.p, port_b1_start.T,port_b1_start.X)),
        m_flow=-port_a_start.m_flow) "port_b"
        annotation (Dialog(tab="Initialization"));

      /* Assumptions */
      parameter Boolean allowFlowReversal= true
        "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem_A;

    expandable connector SignalSubBus_ActuatorInput3

      extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

       Real CV1_opening;
       Real CV2_opening;
       Real CV3_opening;

       annotation (defaultComponentName="actuatorSubBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput3;

    expandable connector SignalSubBus_SensorOutput3

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;
      SI.Temperature T1set;
      SI.Temperature T2set;
      SI.Temperature T3set;

      SI.Temperature T1;
      SI.Temperature T2;
      SI.Temperature T3;

      annotation (defaultComponentName="sensorSubBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_SensorOutput3;

    partial model Partial_SubSystem_A3

      import Modelica.Constants;

      extends Partial_SubSystem3;
      //extends Record_SubSystem_A;
        replaceable package Water = Modelica.Media.Water.StandardWater constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
        annotation (choicesAllMatching=true);
      replaceable package Brine = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX) constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
        annotation (choicesAllMatching=true);

      Modelica.Fluid.Interfaces.FluidPort_a Steam_Input(redeclare package
          Medium =
            Water, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
        "Input Steam for the first effect" annotation (Placement(transformation(
              extent={{-568,30},{-548,50}}), iconTransformation(extent={{-90,50},
                {-110,30}})));

      Modelica.Fluid.Interfaces.FluidPort_b Water_Outlet(redeclare package
          Medium =
            Water, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
        "Output of condensed steam used in the first effect" annotation (Placement(
            transformation(extent={{-568,-50},{-548,-30}}), iconTransformation(
              extent={{-90,-30},{-110,-50}})));

      Modelica.Fluid.Interfaces.FluidPort_b Condensate_Oulet(redeclare package
          Medium = Water, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
        "Outlet of desalinated water" annotation (Placement(transformation(extent={{
                -568,-150},{-548,-130}}), iconTransformation(extent={{-10,-108},{10,
                -88}})));

      Modelica.Fluid.Interfaces.FluidPort_a Saltwater_Input(redeclare package
          Medium = Brine, m_flow(min=if allowFlowReversal then -
              Constants.inf else 0)) "Source of saltwater" annotation (Placement(
            transformation(extent={{550,30},{570,50}}), iconTransformation(extent={{90,30},
                {110,50}})));
      Modelica.Fluid.Interfaces.FluidPort_b Saltwater_Reject_Oulet(redeclare
          package Medium = Brine, m_flow(max=if
              allowFlowReversal then +Constants.inf else 0))
        "Oulet for rejected Saltwater" annotation (Placement(transformation(extent={
                {550,-50},{570,-30}}), iconTransformation(extent={{90,-50},{110,
                -30}})));

      parameter Boolean allowFlowReversal= true
        "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);

      annotation (
        defaultComponentName="MEE",
        Icon(coordinateSystem(                           extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-560,-140},{560,
                180}})));

    end Partial_SubSystem_A3;

    partial model Partial_SubSystem3
      import NHES;

      extends NHES.Systems.BaseClasses.Partial_SubSystem;

      extends Record_SubSystem;

      replaceable
        Partial_ControlSystem CS
        annotation (choicesAllMatching=true, Placement(transformation(extent={{-18,122},
                {-2,138}})));
      replaceable
        Partial_EventDriver ED
        annotation (choicesAllMatching=true, Placement(transformation(extent={{2,122},
                {18,138}})));
      replaceable Record_Data data
        annotation (Placement(transformation(extent={{42,122},{58,138}})));

      NHES.Desalination.MEE.BaseClasses.SignalSubBus_ActuatorInput3
                                 actuatorBus
        annotation (Placement(transformation(extent={{10,80},{50,120}}),
            iconTransformation(extent={{10,80},{50,120}})));
      NHES.Desalination.MEE.BaseClasses.SignalSubBus_SensorOutput3
                                sensorBus
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
          points={{30,100},{-7.6,100},{-7.6,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, ED.actuatorBus) annotation (Line(
          points={{30,100},{20,100},{12.4,100},{12.4,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      annotation (
        defaultComponentName="BOP",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,140}})));
    end Partial_SubSystem3;

    partial model Partial_ControlSystem3

      extends NHES.Systems.BaseClasses.Partial_ControlSystem;

      SignalSubBus_ActuatorInput3 actuatorBus
                                             annotation (Placement(
            transformation(extent={{10,-120},{50,-80}}), iconTransformation(
              extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput3 sensorBus
                                          annotation (Placement(
            transformation(extent={{-50,-120},{-10,-80}}), iconTransformation(
              extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));

    end Partial_ControlSystem3;

    package Choices
      type EvaporatorType = enumeration(
          FC                               "Full Condensing",
          UA   "Constant UA",
          HX   "Heat Transfer Correlations") "Enumeration defining Evaporator Types"
                                                     annotation (Evaluate=true);
    end Choices;
  end BaseClasses;

  package Multiple_Effect

    model MEE_FC "Multi-Effect Evaporator"
      extends BaseClasses.Partial_SubSystem(redeclare replaceable ControlSystems.CS_Dummy CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare replaceable Data.MEE_Data data);

      Single_Effect.Brine_Models.Single_Effect_FC Effect[data.nE](
        V={1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8},                      Tsys=
            data.Tsys,
        KV=-0.035,     p_start=data.psys)
                       annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

      NHES.Fluid.Valves.PressureCV PCV[data.nE](
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        Use_input=false,
        Pressure_target=data.psys,
        ValvePos_start=0.5,
        init_time=0,
        PID_k=-1e-6,
        PID_Ti=2,
        m_flow_nominal=2,
        dp_nominal=(data.psys - fill(0.1e5, data.nE))*0.6)
        annotation (Placement(transformation(extent={{34,-50},{54,-30}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance inlet_res[1](R=1)
        annotation (Placement(transformation(extent={{-78,30},{-58,50}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance return_res[1](R=1)
        annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow
        annotation (Placement(transformation(extent={{-64,-30},{-84,-50}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1
        annotation (Placement(transformation(extent={{90,-30},{70,-50}})));
      Components.GOR gOR
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,-70})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_return(
          redeclare package Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_steam(redeclare package
          Medium =         Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_cond(
          redeclare package Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
      TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling
        multiPort_nonScaling(redeclare package Medium =
            Modelica.Media.Water.StandardWater, nPorts_b=data.nE)
        annotation (Placement(transformation(extent={{66,-50},{58,-30}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Source(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=200000,
        T=data.T_b_in,
        X={0.92,0.08},
        nPorts=data.nE)
                   annotation (Placement(transformation(extent={{100,30},{80,
                50}})));

      NHES.Fluid.Valves.FlowCV  FCV[data.nE](
        redeclare package Medium = NHES.Media.SeaWater,
        Use_input=false,
        FlowRate_target=data.msys,
        m_flow_nominal=data.msys) if data.use_flowrates
        annotation (Placement(transformation(extent={{66,30},{46,50}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Dump(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=data.nE)
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

      NHES.Fluid.Valves.LevelCV SCV[data.nE](
        redeclare package Medium = NHES.Media.SeaWater,
        Use_input=false,
        Level_target=data.Xsys,
        PID_k=-1,
        m_flow_nominal=4,
        dp_nominal=10000) if not data.use_flowrates
        annotation (Placement(transformation(extent={{66,56},{46,76}})));
      Modelica.Blocks.Sources.RealExpression X[data.nE](y=Effect.Evaporator.Cs_out) if not data.use_flowrates
        annotation (Placement(transformation(extent={{100,78},{80,98}})));
      Components.PreHeater preHeater(redeclare package Medium_1 =
            Modelica.Media.Water.StandardWater, redeclare package Medium_2 =
            NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
                                     if data.use_preheater
        annotation (Placement(transformation(extent={{-10,60},{10,80}})));
      TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling multiPort_preheater(
          redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
          nPorts_b=data.nE) if data.use_preheater
        annotation (Placement(transformation(extent={{-24,60},{-32,80}})));
    equation
      connect(PCV[1:data.nE - 1].port_a, Effect[2:data.nE].Tube_Outlet) annotation (Line(
            points={{34,-40},{30,-40},{30,-8},{20,-8}},     color={0,127,255}));

      if data.use_preheater then
        connect(Effect[data.nE].Steam_Outlet_Port,preHeater.port_a1);
        connect(preHeater.port_b1,PCV[data.nE].port_a);
        else
        connect(Effect[data.nE].Steam_Outlet_Port, PCV[data.nE].port_a) annotation (Line(points={{0,20},{
              0,28},{30,28},{30,-40},{34,-40}},         color={0,127,255}));
      end if;
      connect(inlet_res[1].port_b, Effect[1].Tube_Inlet) annotation (Line(points={{-61,40},
              {-28,40},{-28,-8},{-19.6,-8}},         color={0,127,255}));
      connect(return_res[1].port_b, Effect[1].Tube_Outlet) annotation (Line(points={{-43,-40},
              {30,-40},{30,-8},{20.4,-8}},             color={0,127,255}));
      connect(return_res[1].port_a, sensor_m_flow.port_a)
        annotation (Line(points={{-57,-40},{-64,-40}}, color={0,127,255}));
      connect(sensor_m_flow1.m_flow, gOR.CondFlow) annotation (Line(points={{80,
              -43.6},{80,-54},{6,-54},{6,-60},{5,-60}},
                                                   color={0,0,127}));
      connect(gOR.SteamFlow, sensor_m_flow.m_flow) annotation (Line(points={{-5,-60},
              {-5,-54},{-74,-54},{-74,-43.6}},                            color={0,0,
              127}));
      connect(inlet_res[1].port_a, port_a_steam)
        annotation (Line(points={{-75,40},{-100,40}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, port_b_liquid_return)
        annotation (Line(points={{-84,-40},{-100,-40}}, color={0,127,255}));
      connect(sensor_m_flow1.port_a, port_b_liquid_cond)
        annotation (Line(points={{90,-40},{100,-40}}, color={0,127,255}));
      connect(multiPort_nonScaling.ports_b, PCV.port_b)
        annotation (Line(points={{58,-40},{54,-40}}, color={0,127,255}));
      connect(multiPort_nonScaling.port_a, sensor_m_flow1.port_b)
        annotation (Line(points={{66,-40},{70,-40}}, color={0,127,255}));

        if data.use_flowrates then

          if data.use_preheater then
        connect(FCV.port_b, Effect.Brine_Inlet_Port);
        connect(Brine_Source.ports[1],  preHeater.port_a2);
        connect(multiPort_preheater.ports_b,   FCV.port_a);
        else
      connect(FCV.port_b, Effect.Brine_Inlet_Port)
        annotation (Line(points={{46,40},{30,40},{30,0},{20,0}},color={0,127,255}));
      connect(Brine_Source.ports, FCV.port_a)
        annotation (Line(points={{80,40},{66,40}}, color={0,127,255}));
          end if;

        else

          if data.use_preheater then
        connect(SCV.port_b, Effect.Brine_Inlet_Port);
        connect(Brine_Source.ports[1],   preHeater.port_a2);
        connect(multiPort_preheater.ports_b,   SCV.port_a);
        else
      connect(SCV.port_b, Effect.Brine_Inlet_Port)
        annotation (Line(points={{46,66},{30,66},{30,0},{20,0}},color={0,127,255}));
      connect(Brine_Source.ports, SCV.port_a)
        annotation (Line(points={{80,40},{74,40},{74,66},{66,66}},color={0,127,255}));
        end if;
        end if;

      connect(Effect.Brine_Outlet_Port, Brine_Dump.ports)
        annotation (Line(points={{-20,0},{-80,0}}, color={0,127,255}));

      connect(Effect[2:data.nE].Tube_Inlet, Effect[1:data.nE - 1].Steam_Outlet_Port)
        annotation (Line(points={{-20,-8},{-28,-8},{-28,28},{0,28},{0,20}}, color={0,
              127,255}));
      connect(X.y, SCV.level_input)
        annotation (Line(points={{79,88},{64,88},{64,74}}, color={0,0,127}));
      connect(multiPort_preheater.port_a, preHeater.port_b2)
        annotation (Line(points={{-24,70},{-10,70}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
              extent={{-94,94},{94,32}},
              textColor={28,108,200},
              textString="%data.nE Effect MEE
")}),   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})),
        experiment(
          StopTime=500,
          Interval=5,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_FC;

    model MEE_HX "Multi-Effect Evaporator"
      extends BaseClasses.Partial_SubSystem(redeclare replaceable ControlSystems.CS_Dummy CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare replaceable Data.MEE_Data data);

      Single_Effect.Brine_Models.Single_Effect    Effect[data.nE](
        V=data.Vsys,
        A=data.Asys,                                              Tsys=
            data.Tsys,
        m_brine_out=data.m_brine_outsys,
        dp=data.dpsys,
        Ax=data.Axsys,
        Do=data.Dosys,
        th=data.thsys,
        pT=data.pTsys,
        KV=data.KVsys,
        Ti=data.Tisys,
        k=data.ksys,
        nV=data.nVsys) annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

      NHES.Fluid.Valves.PressureCV PCV[data.nE](
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        Use_input=false,
        Pressure_target=data.psys,
        ValvePos_start=0.5,
        init_time=0,
        PID_k=-1e-6,
        PID_Ti=2,
        m_flow_nominal=2,
        dp_nominal=data.psys - fill(0.1, data.nE))
        annotation (Placement(transformation(extent={{34,-50},{54,-30}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance inlet_res[1](R=1)
        annotation (Placement(transformation(extent={{-78,30},{-58,50}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance return_res[1](R=1)
        annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow
        annotation (Placement(transformation(extent={{-64,-30},{-84,-50}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1
        annotation (Placement(transformation(extent={{90,-30},{70,-50}})));
      Components.GOR gOR
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,-70})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_return(
          redeclare package Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_steam(redeclare package
          Medium =         Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_cond(
          redeclare package Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
      TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling
        multiPort_nonScaling(redeclare package Medium =
            Modelica.Media.Water.StandardWater, nPorts_b=data.nE)
        annotation (Placement(transformation(extent={{66,-50},{58,-30}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Source(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=200000,
        T=data.T_b_in,
        X={0.92,0.08},
        nPorts=data.nE)
                   annotation (Placement(transformation(extent={{100,30},{80,
                50}})));

      NHES.Fluid.Valves.FlowCV  FCV[data.nE](
        redeclare package Medium = NHES.Media.SeaWater,
        Use_input=false,
        FlowRate_target=data.msys,
        m_flow_nominal=data.msys) if data.use_flowrates
        annotation (Placement(transformation(extent={{66,30},{46,50}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Dump(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=data.nE)
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

      NHES.Fluid.Valves.LevelCV SCV[data.nE](
        redeclare package Medium = NHES.Media.SeaWater,
        Use_input=false,
        Level_target=data.Xsys,
        PID_k=-1,
        m_flow_nominal=4) if not data.use_flowrates
        annotation (Placement(transformation(extent={{66,56},{46,76}})));
      Modelica.Blocks.Sources.RealExpression X[data.nE](y=Effect.Evaporator.Cs_out) if not data.use_flowrates
        annotation (Placement(transformation(extent={{100,76},{80,96}})));
      Components.PreHeater preHeater(redeclare package Medium_1 =
            Modelica.Media.Water.StandardWater, redeclare package Medium_2 =
            NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
                                     if data.use_preheater
        annotation (Placement(transformation(extent={{-10,60},{10,80}})));
      TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling multiPort_preheater(
          redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
          nPorts_b=data.nE) if data.use_preheater
        annotation (Placement(transformation(extent={{-24,60},{-32,80}})));
    equation
      connect(PCV[1:data.nE - 1].port_a, Effect[2:data.nE].Tube_Outlet) annotation (Line(
            points={{34,-40},{30,-40},{30,-8},{20,-8}},     color={0,127,255}));

      if data.use_preheater then
        connect(Effect[data.nE].Steam_Outlet_Port,preHeater.port_a1);
        connect(preHeater.port_b1,PCV[data.nE].port_a);
        else
        connect(Effect[data.nE].Steam_Outlet_Port, PCV[data.nE].port_a) annotation (Line(points={{0,20},{
              0,28},{30,28},{30,-40},{34,-40}},         color={0,127,255}));
      end if;
      connect(inlet_res[1].port_b, Effect[1].Tube_Inlet) annotation (Line(points={{-61,40},
              {-28,40},{-28,-8},{-19.6,-8}},         color={0,127,255}));
      connect(return_res[1].port_b, Effect[1].Tube_Outlet) annotation (Line(points={{-43,-40},
              {30,-40},{30,-8},{20.4,-8}},             color={0,127,255}));
      connect(return_res[1].port_a, sensor_m_flow.port_a)
        annotation (Line(points={{-57,-40},{-64,-40}}, color={0,127,255}));
      connect(sensor_m_flow1.m_flow, gOR.CondFlow) annotation (Line(points={{80,
              -43.6},{80,-54},{6,-54},{6,-60},{5,-60}},
                                                   color={0,0,127}));
      connect(gOR.SteamFlow, sensor_m_flow.m_flow) annotation (Line(points={{-5,-60},
              {-5,-54},{-74,-54},{-74,-43.6}},                            color={0,0,
              127}));
      connect(inlet_res[1].port_a, port_a_steam)
        annotation (Line(points={{-75,40},{-100,40}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, port_b_liquid_return)
        annotation (Line(points={{-84,-40},{-100,-40}}, color={0,127,255}));
      connect(sensor_m_flow1.port_a, port_b_liquid_cond)
        annotation (Line(points={{90,-40},{100,-40}}, color={0,127,255}));
      connect(multiPort_nonScaling.ports_b, PCV.port_b)
        annotation (Line(points={{58,-40},{54,-40}}, color={0,127,255}));
      connect(multiPort_nonScaling.port_a, sensor_m_flow1.port_b)
        annotation (Line(points={{66,-40},{70,-40}}, color={0,127,255}));

        if data.use_flowrates then

          if data.use_preheater then
        connect(FCV.port_b, Effect.Brine_Inlet_Port);
        connect(Brine_Source.ports[1],  preHeater.port_a2);
        connect(multiPort_preheater.ports_b,   FCV.port_a);
        else
      connect(FCV.port_b, Effect.Brine_Inlet_Port)
        annotation (Line(points={{46,40},{30,40},{30,0},{20,0}},color={0,127,255}));
      connect(Brine_Source.ports, FCV.port_a)
        annotation (Line(points={{80,40},{66,40}}, color={0,127,255}));
          end if;

        else

          if data.use_preheater then
        connect(SCV.port_b, Effect.Brine_Inlet_Port);
        connect(Brine_Source.ports[1],   preHeater.port_a2);
        connect(multiPort_preheater.ports_b,   SCV.port_a);
        else
      connect(SCV.port_b, Effect.Brine_Inlet_Port)
        annotation (Line(points={{46,66},{30,66},{30,0},{20,0}},color={0,127,255}));
      connect(Brine_Source.ports, SCV.port_a)
        annotation (Line(points={{80,40},{74,40},{74,66},{66,66}},color={0,127,255}));
        end if;
        end if;

      connect(Effect.Brine_Outlet_Port, Brine_Dump.ports)
        annotation (Line(points={{-20,0},{-80,0}}, color={0,127,255}));

      connect(Effect[2:data.nE].Tube_Inlet, Effect[1:data.nE - 1].Steam_Outlet_Port)
        annotation (Line(points={{-20,-8},{-28,-8},{-28,28},{0,28},{0,20}}, color={0,
              127,255}));
      connect(X.y, SCV.level_input)
        annotation (Line(points={{79,86},{64,86},{64,74}}, color={0,0,127}));
      connect(multiPort_preheater.port_a, preHeater.port_b2)
        annotation (Line(points={{-24,70},{-10,70}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
              extent={{-94,94},{94,32}},
              textColor={28,108,200},
              textString="%data.nE Effect MEE
")}),   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})),
        experiment(
          StopTime=500,
          Interval=5,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_HX;

    model MEE_PB "Multi-Effect Evaporator"
      extends BaseClasses.Partial_SubSystem(redeclare replaceable ControlSystems.CS_Dummy CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare replaceable Data.MEE_Data data);

      Single_Effect.Brine_Models.Single_Effect_pool
                                                  Effect[data.nE](
        V=data.Vsys,
        A=data.Asys,                                              Tsys=
            data.Tsys,
        m_brine_out=data.m_brine_outsys,
        dp=data.dpsys,
        Ax=data.Axsys,
        Do=data.Dosys,
        th=data.thsys,
        pT=data.pTsys,
        KV=data.KVsys,
        Ti=data.Tisys,
        k=data.ksys,
        nV=data.nVsys) annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

      NHES.Fluid.Valves.PressureCV PCV[data.nE](
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        Use_input=false,
        Pressure_target=data.psys,
        ValvePos_start=0.5,
        init_time=0,
        PID_k=-1e-6,
        PID_Ti=2,
        m_flow_nominal=2,
        dp_nominal=data.psys - fill(0.1, data.nE))
        annotation (Placement(transformation(extent={{34,-50},{54,-30}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance inlet_res[1](R=1)
        annotation (Placement(transformation(extent={{-78,30},{-58,50}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance return_res[1](R=1)
        annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow
        annotation (Placement(transformation(extent={{-64,-30},{-84,-50}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1
        annotation (Placement(transformation(extent={{90,-30},{70,-50}})));
      Components.GOR gOR
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,-70})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_return(
          redeclare package Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_steam(redeclare package
          Medium =         Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_cond(
          redeclare package Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
      TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling
        multiPort_nonScaling(redeclare package Medium =
            Modelica.Media.Water.StandardWater, nPorts_b=data.nE)
        annotation (Placement(transformation(extent={{66,-50},{58,-30}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Source(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=200000,
        T=data.T_b_in,
        X={0.92,0.08},
        nPorts=data.nE)
                   annotation (Placement(transformation(extent={{100,30},{80,
                50}})));

      NHES.Fluid.Valves.FlowCV  FCV[data.nE](
        redeclare package Medium = NHES.Media.SeaWater,
        Use_input=false,
        FlowRate_target=data.msys,
        m_flow_nominal=data.msys) if data.use_flowrates
        annotation (Placement(transformation(extent={{66,30},{46,50}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Dump(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=data.nE)
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

      NHES.Fluid.Valves.LevelCV SCV[data.nE](
        redeclare package Medium = NHES.Media.SeaWater,
        Use_input=false,
        Level_target=data.Xsys,
        PID_k=-1,
        m_flow_nominal=4) if not data.use_flowrates
        annotation (Placement(transformation(extent={{66,56},{46,76}})));
      Modelica.Blocks.Sources.RealExpression X[data.nE](y=Effect.Evaporator.Cs_out) if not data.use_flowrates
        annotation (Placement(transformation(extent={{100,76},{80,96}})));
      Components.PreHeater preHeater(redeclare package Medium_1 =
            Modelica.Media.Water.StandardWater, redeclare package Medium_2 =
            NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
                                     if data.use_preheater
        annotation (Placement(transformation(extent={{-10,60},{10,80}})));
      TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling multiPort_preheater(
          redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
          nPorts_b=data.nE) if data.use_preheater
        annotation (Placement(transformation(extent={{-24,60},{-32,80}})));
    equation
      connect(PCV[1:data.nE - 1].port_a, Effect[2:data.nE].Tube_Outlet) annotation (Line(
            points={{34,-40},{30,-40},{30,-8},{20,-8}},     color={0,127,255}));

      if data.use_preheater then
        connect(Effect[data.nE].Steam_Outlet_Port,preHeater.port_a1);
        connect(preHeater.port_b1,PCV[data.nE].port_a);
        else
        connect(Effect[data.nE].Steam_Outlet_Port, PCV[data.nE].port_a) annotation (Line(points={{0,20},{
              0,28},{30,28},{30,-40},{34,-40}},         color={0,127,255}));
      end if;
      connect(inlet_res[1].port_b, Effect[1].Tube_Inlet) annotation (Line(points={{-61,40},
              {-28,40},{-28,-8},{-19.6,-8}},         color={0,127,255}));
      connect(return_res[1].port_b, Effect[1].Tube_Outlet) annotation (Line(points={{-43,-40},
              {30,-40},{30,-8},{20.4,-8}},             color={0,127,255}));
      connect(return_res[1].port_a, sensor_m_flow.port_a)
        annotation (Line(points={{-57,-40},{-64,-40}}, color={0,127,255}));
      connect(sensor_m_flow1.m_flow, gOR.CondFlow) annotation (Line(points={{80,
              -43.6},{80,-54},{6,-54},{6,-60},{5,-60}},
                                                   color={0,0,127}));
      connect(gOR.SteamFlow, sensor_m_flow.m_flow) annotation (Line(points={{-5,-60},
              {-5,-54},{-74,-54},{-74,-43.6}},                            color={0,0,
              127}));
      connect(inlet_res[1].port_a, port_a_steam)
        annotation (Line(points={{-75,40},{-100,40}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, port_b_liquid_return)
        annotation (Line(points={{-84,-40},{-100,-40}}, color={0,127,255}));
      connect(sensor_m_flow1.port_a, port_b_liquid_cond)
        annotation (Line(points={{90,-40},{100,-40}}, color={0,127,255}));
      connect(multiPort_nonScaling.ports_b, PCV.port_b)
        annotation (Line(points={{58,-40},{54,-40}}, color={0,127,255}));
      connect(multiPort_nonScaling.port_a, sensor_m_flow1.port_b)
        annotation (Line(points={{66,-40},{70,-40}}, color={0,127,255}));

        if data.use_flowrates then

          if data.use_preheater then
        connect(FCV.port_b, Effect.Brine_Inlet_Port);
        connect(Brine_Source.ports[1],  preHeater.port_a2);
        connect(multiPort_preheater.ports_b,   FCV.port_a);
        else
      connect(FCV.port_b, Effect.Brine_Inlet_Port)
        annotation (Line(points={{46,40},{30,40},{30,0},{20,0}},color={0,127,255}));
      connect(Brine_Source.ports, FCV.port_a)
        annotation (Line(points={{80,40},{66,40}}, color={0,127,255}));
          end if;

        else

          if data.use_preheater then
        connect(SCV.port_b, Effect.Brine_Inlet_Port);
        connect(Brine_Source.ports[1],   preHeater.port_a2);
        connect(multiPort_preheater.ports_b,   SCV.port_a);
        else
      connect(SCV.port_b, Effect.Brine_Inlet_Port)
        annotation (Line(points={{46,66},{30,66},{30,0},{20,0}},color={0,127,255}));
      connect(Brine_Source.ports, SCV.port_a)
        annotation (Line(points={{80,40},{74,40},{74,66},{66,66}},color={0,127,255}));
        end if;
        end if;

      connect(Effect.Brine_Outlet_Port, Brine_Dump.ports)
        annotation (Line(points={{-20,0},{-80,0}}, color={0,127,255}));

      connect(Effect[2:data.nE].Tube_Inlet, Effect[1:data.nE - 1].Steam_Outlet_Port)
        annotation (Line(points={{-20,-8},{-28,-8},{-28,28},{0,28},{0,20}}, color={0,
              127,255}));
      connect(X.y, SCV.level_input)
        annotation (Line(points={{79,86},{64,86},{64,74}}, color={0,0,127}));
      connect(multiPort_preheater.port_a, preHeater.port_b2)
        annotation (Line(points={{-24,70},{-10,70}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
              extent={{-94,94},{94,32}},
              textColor={28,108,200},
              textString="%data.nE Effect MEE
")}),   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})),
        experiment(
          StopTime=500,
          Interval=5,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_PB;

    model MEE_FC_ss "Multi-Effect Evaporator"
      extends BaseClasses.Partial_SubSystem(redeclare replaceable ControlSystems.CS_Dummy CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare replaceable Data.MEE_Data data);

      Medium.SaturationProperties [data.nE] sat;
      Components.Evaporator_Brine_SHP_ss evaporator_Brine_SHP_ss[data.nE](
        p=data.psys,
        T_st=data.Tsys,
        h_b_in=NHES.Media.SeaWater.specificEnthalpy_pTX(
            1e5,
            data.T_b_in,
            Xin),
        Cs_in=Cs_in,
        Cs_out=data.Xsys)
        annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary[data.nE](
         use_port=true, Q_flow=1000000)
        annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
      parameter SI.MassFraction Cs_in=0.08;
      parameter SI.AbsolutePressure p_innom=2e5;

      SI.SpecificEnthalpy [data.nE] h_innom;
      SI.SpecificEnthalpy [data.nE] h_outnom;
      parameter SI.MassFraction [2] Xin={(1-Cs_in),Cs_in};
      SI.SpecificEnthalpy [data.nE] h_in;
      SI.SpecificEnthalpy [data.nE] h_out;
      SI.Molality [data.nE-1] m;
      SI.TemperatureDifference [data.nE-1] dTbpe;
      SI.Power [data.nE] Q;
      SI.MassFlowRate Cond_out;
      Real GOR;

      Modelica.Blocks.Sources.RealExpression heat_in[data.nE](y=Q)
        annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
      replaceable package Medium = Modelica.Media.Water.StandardWater
        annotation (choicesAllMatching=true);
    equation

      //First stage
      port_a.m_flow=-port_b.m_flow;
      port_a.p=port_b.p;
      sat[1].psat=p_innom;
      sat[1].Tsat= Medium.saturationTemperature(p_innom);
      h_in[1]=inStream(port_a.h_outflow);
      h_innom[1]=Medium.dewEnthalpy(sat[1]);

      //Other stages
      m=data.Xsys[1:data.nE-1]./(0.05844);
      dTbpe=1.024.*m;
      sat[2:data.nE].psat = data.psys[2:data.nE];
      sat[2:data.nE].Tsat = Medium.saturationTemperature(data.psys[1:data.nE-1]);
      h_innom[2:data.nE]=Medium.specificEnthalpy_pT(data.psys[1:data.nE-1],(sat[1:data.nE-1].Tsat+dTbpe));
      h_in[2:data.nE]=evaporator_Brine_SHP_ss[1:data.nE-1].h_steam;

      //hout and Qs
      h_outnom=Medium.bubbleEnthalpy(sat);
      for i in 1:data.nE loop
        if h_in[i]>h_innom[i] then
        h_out[i]=h_in[i]-(h_innom[i]-h_outnom[i])-sqrt(abs(h_in[i]-h_innom[i]));
        else
        h_out[i]= h_outnom[i];
        end if;
      end for;
      Q[1]=port_a.m_flow*(h_in[1]-h_out[1]);
      Q[2:data.nE]=-evaporator_Brine_SHP_ss[1:data.nE-1].m_steam.*(h_in[2:data.nE]-h_out[2:data.nE]);
      port_a.h_outflow=inStream(port_b.h_outflow);
      port_b.h_outflow=h_out[1];

      Cond_out=abs(sum(evaporator_Brine_SHP_ss.m_steam));
      GOR=abs(Cond_out/port_a.m_flow);




    connect(boundary.port, evaporator_Brine_SHP_ss.Heat_Port)
        annotation (Line(points={{-20,-70},{0,-70},{0,-40}}, color={191,0,0}));


      connect(heat_in.y, boundary.Q_flow_ext)
        annotation (Line(points={{-59,-70},{-34,-70}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
              extent={{-94,94},{94,32}},
              textColor={28,108,200},
              textString="%data.nE Effect MEE
")}),   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})),
        experiment(
          StopTime=500,
          Interval=5,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_FC_ss;

    model MEE_FC_ss_delay "Multi-Effect Evaporator"
      extends BaseClasses.Partial_SubSystem(redeclare replaceable ControlSystems.CS_Dummy CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare replaceable Data.MEE_Data data);

      Medium.SaturationProperties [data.nE] sat;
      Components.Evaporator_Brine_SHP_ss evaporator_Brine_SHP_ss[data.nE](
        p=data.psys,
        T_st=data.Tsys,
        h_b_in=NHES.Media.SeaWater.specificEnthalpy_pTX(
            1e5,
            data.T_b_in,
            Xin),
        Cs_in=Cs_in,
        Cs_out=data.Xsys)
        annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary[data.nE](
         use_port=true, Q_flow=1000000)
        annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
      parameter SI.MassFraction Cs_in=0.08;
      parameter SI.AbsolutePressure p_innom=2e5;

      SI.SpecificEnthalpy [data.nE] h_innom;
      SI.SpecificEnthalpy [data.nE] h_outnom;
      parameter SI.MassFraction [2] Xin={(1-Cs_in),Cs_in};
      SI.SpecificEnthalpy [data.nE] h_in;
      SI.SpecificEnthalpy [data.nE] h_out;
      SI.Molality [data.nE-1] m;
      SI.TemperatureDifference [data.nE-1] dTbpe;
      SI.Power [data.nE] Q;
      SI.MassFlowRate Cond_out;
      Real GOR;

      Modelica.Blocks.Sources.RealExpression heat_in[data.nE](y=Q)
        annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
      replaceable package Medium = Modelica.Media.Water.StandardWater
        annotation (choicesAllMatching=true);
      Modelica.Blocks.Sources.RealExpression steamflow[data.nE - 1](y=-
            evaporator_Brine_SHP_ss[1:data.nE - 1].m_steam)
        annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder[data.nE - 1](T=tau)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      parameter SI.Time tau=5 "Time Constant";
      Modelica.Blocks.Sources.RealExpression steament[data.nE - 1](y=
            evaporator_Brine_SHP_ss[1:data.nE - 1].h_steam)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
      Modelica.Blocks.Continuous.FirstOrder firstOrder1[data.nE - 1](T=tau)
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
    equation

      //First stage
      port_a.m_flow=-port_b.m_flow;
      port_a.p=port_b.p;
      sat[1].psat=p_innom;
      sat[1].Tsat= Medium.saturationTemperature(p_innom);
      h_in[1]=inStream(port_a.h_outflow);
      h_innom[1]=Medium.dewEnthalpy(sat[1]);

      //Other stages
      m=data.Xsys[1:data.nE-1]./(0.05844);
      dTbpe=1.024.*m;
      sat[2:data.nE].psat = data.psys[2:data.nE];
      sat[2:data.nE].Tsat = Medium.saturationTemperature(data.psys[1:data.nE-1]);
      h_innom[2:data.nE]=Medium.specificEnthalpy_pT(data.psys[1:data.nE-1],(sat[1:data.nE-1].Tsat+dTbpe));
      //h_in[2:data.nE]=evaporator_Brine_SHP_ss[1:data.nE-1].h_steam;
      h_in[2:data.nE]=firstOrder1.y;


      //hout and Qs
      h_outnom=Medium.bubbleEnthalpy(sat);
      for i in 1:data.nE loop
        if h_in[i]>h_innom[i] then
        h_out[i]=h_in[i]-(h_innom[i]-h_outnom[i])-sqrt(abs(h_in[i]-h_innom[i]));
        else
        h_out[i]= h_outnom[i];
        end if;
      end for;
      Q[1]=port_a.m_flow*(h_in[1]-h_out[1]);
      //Q[2:data.nE]=-evaporator_Brine_SHP_ss[1:data.nE-1].m_steam.*(h_in[2:data.nE]-h_out[2:data.nE]);
      Q[2:data.nE]=firstOrder.y.*(h_in[2:data.nE]-h_out[2:data.nE]);
      port_a.h_outflow=inStream(port_b.h_outflow);
      port_b.h_outflow=h_out[1];

      Cond_out=abs(sum(evaporator_Brine_SHP_ss.m_steam));
      GOR=abs(Cond_out/port_a.m_flow);

    connect(boundary.port, evaporator_Brine_SHP_ss.Heat_Port)
        annotation (Line(points={{-20,-70},{0,-70},{0,-40}}, color={191,0,0}));

      connect(heat_in.y, boundary.Q_flow_ext)
        annotation (Line(points={{-59,-70},{-34,-70}}, color={0,0,127}));
      connect(steamflow.y, firstOrder.u)
        annotation (Line(points={{-79,30},{-62,30}}, color={0,0,127}));
      connect(steament.y, firstOrder1.u)
        annotation (Line(points={{-79,-30},{-62,-30}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
              extent={{-94,94},{94,32}},
              textColor={28,108,200},
              textString="%data.nE Effect MEE
")}),   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})),
        experiment(
          StopTime=500,
          Interval=5,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_FC_ss_delay;
  end Multiple_Effect;

  package Data
    model MEE_Data
      extends BaseClasses.Record_Data;
      parameter Integer nE= 6 "Number of Effects";
      parameter Boolean use_preheater=false;

      //Temperatures
      parameter Modelica.Units.SI.Temperature T_b_in= 302.15 "Brine Inlet Temperature" annotation(Dialog(group="Temperatures"));
      parameter Modelica.Units.SI.Temperature T_h=363.15 "First effect Temperature" annotation(Dialog(group="Temperatures"));
      parameter Modelica.Units.SI.Temperature T_l=323.15 "Last effect Temperature" annotation(Dialog(group="Temperatures"));
      parameter Modelica.Units.SI.Temperature Tsys[:]=linspace(T_h,T_l,nE)  "All effects Temperatures" annotation(Dialog(group="Temperatures"));

      //Pressures
      parameter Modelica.Units.SI.Pressure p_h=1e5 "First effect Pressure" annotation(Dialog(group="Pressures"));
      parameter Modelica.Units.SI.Pressure p_l=0.3e5
                                                    "Last effect Pressure" annotation(Dialog(group="Pressures"));
      parameter Modelica.Units.SI.Pressure psys[:]=linspace(p_h,p_l,nE)  "All effects Pressures" annotation(Dialog(group="Pressures"));

      //Flow Rates and Salinity Control
      parameter Boolean use_flowrates= true "if true use set input flowrates else in salinity control"  annotation(Dialog(group="Flow Control"));
      parameter Modelica.Units.SI.MassFlowRate m_h=4 "First effect mass flows" annotation(Dialog(group="Flow Control",enable=use_flowrates));
      parameter Modelica.Units.SI.MassFlowRate m_l=4 "Last effect mass flows" annotation(Dialog(group="Flow Control",enable=use_flowrates));
      parameter Modelica.Units.SI.MassFlowRate msys[:]=linspace(m_h,m_l,nE)  "All effects mass flows" annotation(Dialog(group="Flow Control",enable=use_flowrates));
      parameter Modelica.Units.SI.MassFraction X_nom=0.11
                                                       "Nominal effect salinity" annotation(Dialog(group="Flow Control",enable= not use_flowrates));

      parameter Modelica.Units.SI.MassFraction Xsys[:]=fill(X_nom,nE)  "All effects salinity" annotation(Dialog(group="Flow Control",enable= not use_flowrates));

      parameter Modelica.Units.SI.Volume Vnom=1  annotation(Dialog(tab="Geometry"));
      parameter Modelica.Units.SI.Volume Vsys[:]=fill(Vnom,nE)  annotation(Dialog(tab="Geometry"));
      parameter Modelica.Units.SI.Area Anom=1  annotation(Dialog(tab="Geometry"));
      parameter Modelica.Units.SI.Area Asys[:]=fill(Anom,nE)  annotation(Dialog(tab="Geometry"));
      parameter Modelica.Units.SI.Area Axnom=1e4  annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
      parameter Modelica.Units.SI.Area Axsys[:]=fill(Axnom,nE) annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
      parameter Modelica.Units.SI.Diameter Donom=0.05 annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
      parameter Modelica.Units.SI.Diameter Dosys[:]=fill(Donom,nE) annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
      parameter Modelica.Units.SI.Thickness thnom=0.007 annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
      parameter Modelica.Units.SI.Thickness thsys[:]=fill(thnom,nE) annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
      parameter Modelica.Units.SI.ThermalConductivity knom=83
        "Thermal Conductivity of the Cladding" annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
      parameter Modelica.Units.SI.ThermalConductivity ksys[:]=fill(knom,nE)
        "Thermal Conductivity of the Cladding" annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
      parameter Integer nVnom=5 "Number of Nodes in HX" annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
      parameter Integer nVsys[:]=fill(nVnom,nE) "Number of Nodes in HX" annotation(Dialog(tab="Geometry", group="Heat Exchanger"));
      parameter Modelica.Units.SI.MassFlowRate m_brine_outnom=1
        "Nominal mass flow rate in brine exit valve" annotation(Dialog(group="Brine Valve"));
        parameter Modelica.Units.SI.MassFlowRate m_brine_outsys[:]=fill(m_brine_outnom,nE)
        "Nominal mass flow rate in brine exit valve" annotation(Dialog(group="Brine Valve"));
      parameter Modelica.Units.SI.AbsolutePressure dpnom=0.001e5
        "Nominal pressure drop across the brine exit valve" annotation(Dialog(group="Brine Valve"));
      parameter Modelica.Units.SI.AbsolutePressure dpsys[:]=fill(dpnom,nE)
        "Nominal pressure drop across the brine exit valve" annotation(Dialog(group="Brine Valve"));
      parameter Modelica.Units.SI.AbsolutePressure pTnom=1e5 "Init Tube pressure" annotation(Dialog(group="Tube Initailization"));
      parameter Modelica.Units.SI.AbsolutePressure pTsys[:]=fill(pTnom,nE) "Init Tube pressure"  annotation(Dialog(group="Tube Initailization"));
      parameter Real KVnom=-0.03 "Gain of PID in brine valve controller"  annotation(Dialog(group="Brine Valve"));
      parameter Real KVsys[:]=fill(KVnom,nE)
                                            "Gain of PID in brine valve controller"  annotation(Dialog(group="Brine Valve"));
      parameter Modelica.Units.SI.Time Tinom=0.75
        "Time constant of Integrator block" annotation(Dialog(group="Brine Valve"));
      parameter Modelica.Units.SI.Time Tisys[:]=fill(Tinom,nE)
        "Time constant of Integrator block" annotation(Dialog(group="Brine Valve"));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end MEE_Data;

  end Data;

  package ControlSystems

    model CS_Dummy
      extends BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      Modelica.Blocks.Sources.Constant const(k=0.55)
        annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      Modelica.Blocks.Sources.Constant const1(k=0.6)
        annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
      Modelica.Blocks.Sources.Constant const2(k=0.65)
        annotation (Placement(transformation(extent={{-18,-40},{2,-20}})));
      Modelica.Blocks.Sources.Constant const3(k=0.7)
        annotation (Placement(transformation(extent={{0,-20},{20,0}})));
      Modelica.Blocks.Sources.Constant const4(k=0.75)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      Modelica.Blocks.Sources.Constant const5(k=0.8)
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      Modelica.Blocks.Sources.Constant const6(k=0.85)
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Modelica.Blocks.Sources.Constant const7(k=0.9)
        annotation (Placement(transformation(extent={{0,60},{20,80}})));
    equation
      connect(actuatorBus.CV2_opening, const1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-50},{21,-50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV3_opening, const2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-30},{3,-30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV4_opening, const3.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-10},{21,-10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV5_opening, const4.y) annotation (Line(
          points={{30.1,-99.9},{30.1,10},{1,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV6_opening, const5.y) annotation (Line(
          points={{30.1,-99.9},{30.1,30},{21,30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV7_opening, const6.y) annotation (Line(
          points={{30.1,-99.9},{30.1,50},{1,50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV8_opening, const7.y) annotation (Line(
          points={{30.1,-99.9},{30.1,70},{21,70}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV1_opening, const.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-70},{1,-70}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      annotation (defaultComponentName="CS",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end CS_Dummy;

    model ED_Dummy

      extends Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_EventDriver;

      extends NHES.Icons.DummyIcon;

    equation

    annotation(defaultComponentName="PHS_CS");
    end ED_Dummy;

  end ControlSystems;
end MEE;
