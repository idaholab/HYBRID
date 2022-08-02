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

      model Single_Effect_UA_W
        "Single effect evaporator for desalination, this model uses a constant UA value across the heat exchanger and assumes Brine=Water"

        parameter Modelica.Units.SI.AbsolutePressure Psys=1e5 "Evaporator System Pressure";
        parameter Modelica.Units.SI.ThermalConductance UA=1e5
                                                             "Constant UA value for the effect";
        parameter Modelica.Units.SI.Mass S_start=20 "Init Solute Mass"  annotation (Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.PressureDifference dP=10
                                                         "Tube Side Pressure Drop"
                                                                                  annotation (Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.Volume V=1 "Effect Volume";
        parameter Modelica.Units.SI.Area A=1 "Effect Cross Sectional Area";
        parameter Real KP=-40 "Pump PI Controler Gain";
        parameter Modelica.Units.SI.MassFlowRate Pumplimit=5 "Max Pump Flow Rate";

        Fluid.Valves.Pressure_Control_Valve       PCV(
          P_sys=Psys,
          Delay_Opening=0.82,
          Delay_Time=0.1)
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
          k=KP,
          Ti=100,
          Td=10,
          yMax=Pumplimit,
          yMin=0,
          wp=1,
          wd=1) annotation (Placement(transformation(extent={{-44,74},{-64,94}})));
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
        NHES.Desalination.MEE.Components.SEE_Tube_Side_UA sEE_Tube_Side(
            redeclare package Medium = Modelica.Media.Water.StandardWater, UA=UA)
          annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_intlet_Resistance(
            redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
          annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_Outlet_Resistance(
            redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
          annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
      equation
        connect(Brine_Inlet_Port, Brine_Inlet_Port)
          annotation (Line(points={{100,0},{100,0}}, color={0,127,255}));
        connect(Brine_inlet_Resistance.port_b, Brine_Inlet_Port)
          annotation (Line(points={{67,0},{100,0}}, color={0,127,255}));
        connect(Level_Set.y, PID.u_s) annotation (Line(points={{-35,84},{-42,84}}, color={0,0,127}));
        connect(Cs_In, Evaporator_Water_SHP.Cs_in) annotation (Line(points={{100,
                20},{30,20},{30,6},{18,6}}, color={0,0,127}));
        connect(Evaporator_Water_SHP.Cs_out, Cs_Out) annotation (Line(points={{-22,
                6},{-30,6},{-30,20},{-110,20}}, color={0,0,127}));
        connect(Evaporator_Water_SHP.RelLevel, PID.u_m) annotation (Line(points={
                {-22,14},{-22,62},{-54,62},{-54,72}}, color={0,0,127}));
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
          annotation (Line(points={{-70,7.3},{-70,84},{-65,84}}, color={0,0,127}));
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
      end Single_Effect_UA_W;

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

        Fluid.Valves.Pressure_Control_Valve       PCV(
          P_sys=Psys,
          Nominal_dp=2000,
          Nominal_Flow=1,
          Delay_Time=0) annotation (Placement(transformation(
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


        parameter Modelica.Units.SI.Mass S_start=20  annotation (Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.Temperature Tsys=350 "Evaporator T";
        parameter Modelica.Units.SI.Volume V=1;
        parameter Modelica.Units.SI.Area A=1;
        parameter Real KV=-0.03;
        parameter Modelica.Units.SI.Area Ax=1e4;
        parameter Modelica.Units.SI.Diameter Do=0.05;
        parameter Modelica.Units.SI.Thickness th=0.007;
        parameter Modelica.Units.SI.AbsolutePressure pT
                                                       "Init Tube pressure";

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Brine_Inlet_Port(redeclare
            package
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
          Ti=0.75,
          Td=10,
          yMax=1,
          yMin=0,
          wp=1,
          wd=1) annotation (Placement(transformation(extent={{-46,70},{-66,90}})));
        Modelica.Blocks.Sources.RealExpression Level_Set(y=0.5) annotation (Placement(transformation(extent={{-14,70},
                  {-34,90}})));
        Components.Evaporator_Brine_SHP Evaporator(
          redeclare package MediumB = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
          p_start=100000,
          T_st=Tsys,
          V=V,
          A=A) annotation (Placement(transformation(extent={{20,-18},{-20,22}})));

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tube_Inlet(redeclare package Medium =
              Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{-108,-50},{-88,-30}}), iconTransformation(extent={{-108,
                  -50},{-88,-30}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare
            package
            Medium = Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{92,-50},{112,-30}}), iconTransformation(extent={{92,-50},
                  {112,-30}})));
        NHES.Desalination.MEE.Components.SEE_Tube_Side_FilmBoiling
                                                                 sEE_Tube_Side(
          p_start=pT,
          Ax=Ax,
          Do=Do,
          th=th,
          k=83)
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
          dp_nominal=1000,
          m_flow_nominal=1)
          annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));

      equation
        connect(Brine_Inlet_Port, Brine_Inlet_Port)
          annotation (Line(points={{100,0},{100,0}}, color={0,127,255}));
        connect(Level_Set.y, PID.u_s) annotation (Line(points={{-35,80},{-44,80}}, color={0,0,127}));
        connect(Evaporator.RelLevel, PID.u_m) annotation (Line(points={{-22,16},
                {-26,16},{-26,50},{-56,50},{-56,68}},
                                             color={0,0,127}));
        connect(Evaporator.steam_port, Steam_Outlet_Resistance.port_a)
          annotation (Line(points={{0,22},{-4.44089e-16,39}}, color={0,127,255}));
        connect(Tube_Inlet,Tube_Inlet)
          annotation (Line(points={{-98,-40},{-98,-40}},   color={0,127,255}));
        connect(sEE_Tube_Side.Steam_Inlet_Port, Tube_intlet_Resistance.port_b)
          annotation (Line(points={{-20,-40},{-53,-40}}, color={0,127,255}));
        connect(Tube_Inlet, Tube_intlet_Resistance.port_a)
          annotation (Line(points={{-98,-40},{-67,-40}}, color={0,127,255}));
        connect(sEE_Tube_Side.Liquid_Outlet_Port, Tube_Outlet_Resistance.port_a)
          annotation (Line(points={{20,-40},{55,-40}}, color={0,127,255}));
        connect(Tube_Outlet, Tube_Outlet_Resistance.port_b)
          annotation (Line(points={{102,-40},{69,-40}}, color={0,127,255}));
        connect(Evaporator.Brine_Inlet_port, Brine_Inlet_Port) annotation (Line(
              points={{20,2},{60,2},{60,0},{100,0}}, color={0,127,255}));
        connect(sEE_Tube_Side.Heat_Port, Evaporator.Heat_Port)
          annotation (Line(points={{0,-30},{0,-18}}, color={191,0,0}));
        connect(valveLinear.opening, PID.y) annotation (Line(points={{-60,8},{
                -60,64},{-72,64},{-72,80},{-67,80}},
                                             color={0,0,127}));
        connect(Brine_Outlet_Port, valveLinear.port_b)
          annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));
        connect(Evaporator.Brine_Outlet_port, valveLinear.port_a) annotation (Line(
              points={{-20,2},{-36,2},{-36,0},{-50,0}}, color={0,127,255}));
        connect(Steam_Outlet_Resistance.port_b, Steam_Outlet_Port) annotation (Line(
              points={{4.44089e-16,53},{4.44089e-16,76.5},{0,76.5},{0,100}}, color={0,
                127,255}));
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
      end Single_Effect;

      model Single_Effect_UA
        "Single effect evaporator for desalination, this model uses a constant UA value across the heat exchanger"

        parameter Modelica.Units.SI.AbsolutePressure Psys=1e5;
        parameter Modelica.Units.SI.Mass S_start=20  annotation (Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.Volume V=1;
        parameter Modelica.Units.SI.Area A=1;
        parameter Real KV=-0.03;
        parameter Modelica.Units.SI.Area Ax=1e4;
        parameter Modelica.Units.SI.Diameter Do=0.01;
        parameter Modelica.Units.SI.Thickness th=0.001;
        parameter Modelica.Units.SI.AbsolutePressure pT
                                                       "Init Tube pressure";
                                                       parameter SI.Temperature Tsys;

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Brine_Inlet_Port(redeclare
            package
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
          Ti=0.75,
          Td=10,
          yMax=1,
          yMin=0,
          wp=1,
          wd=1) annotation (Placement(transformation(extent={{-44,68},{-64,88}})));
        Modelica.Blocks.Sources.RealExpression Level_Set(y=0.5) annotation (Placement(transformation(extent={{-14,70},
                  {-34,90}})));
        Components.Evaporator_Brine_SHP Evaporator(
          redeclare package MediumB = NHES.Media.SeaWater (ThermoStates=
                  Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
          p_start=Psys,
          T_st=Tsys,
          V=V,
          A=A)
          annotation (Placement(transformation(extent={{20,-22},{-20,18}})));

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tube_Inlet(redeclare package Medium =
              Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{-108,-50},{-88,-30}}), iconTransformation(extent={{-108,
                  -50},{-88,-30}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare
            package
            Medium = Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{92,-50},{112,-30}}), iconTransformation(extent={{92,-50},
                  {112,-30}})));
        Components.SEE_Tube_Side_UA                              sEE_Tube_Side
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
          dp_nominal=1000,
          m_flow_nominal=1)
          annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));

      equation
        connect(Brine_Inlet_Port, Brine_Inlet_Port)
          annotation (Line(points={{100,0},{100,0}}, color={0,127,255}));
        connect(Level_Set.y, PID.u_s) annotation (Line(points={{-35,80},{-38,80},{-38,
                78},{-42,78}},                                                     color={0,0,127}));
        connect(Evaporator.RelLevel, PID.u_m) annotation (Line(points={{-22,12},
                {-26,12},{-26,50},{-54,50},{-54,66}}, color={0,0,127}));
        connect(Evaporator.steam_port, Steam_Outlet_Resistance.port_a)
          annotation (Line(points={{0,18},{-4.44089e-16,39}}, color={0,127,255}));
        connect(Tube_Inlet,Tube_Inlet)
          annotation (Line(points={{-98,-40},{-98,-40}},   color={0,127,255}));
        connect(sEE_Tube_Side.Steam_Inlet_Port, Tube_intlet_Resistance.port_b)
          annotation (Line(points={{-20,-40},{-53,-40}}, color={0,127,255}));
        connect(Tube_Inlet, Tube_intlet_Resistance.port_a)
          annotation (Line(points={{-98,-40},{-67,-40}}, color={0,127,255}));
        connect(sEE_Tube_Side.Liquid_Outlet_Port, Tube_Outlet_Resistance.port_a)
          annotation (Line(points={{20,-40},{55,-40}}, color={0,127,255}));
        connect(Tube_Outlet, Tube_Outlet_Resistance.port_b)
          annotation (Line(points={{102,-40},{69,-40}}, color={0,127,255}));
        connect(Evaporator.Brine_Inlet_port, Brine_Inlet_Port) annotation (Line(
              points={{20,-2},{60,-2},{60,0},{100,0}}, color={0,127,255}));
        connect(sEE_Tube_Side.Heat_Port, Evaporator.Heat_Port)
          annotation (Line(points={{0,-30},{0,-22}}, color={191,0,0}));
        connect(Steam_Outlet_Resistance.port_b, Steam_Outlet_Port) annotation (Line(
              points={{4.44089e-16,53},{4.44089e-16,76.5},{0,76.5},{0,100}}, color={0,
                127,255}));
        connect(valveLinear.opening, PID.y) annotation (Line(points={{-60,8},{-60,64},
                {-72,64},{-72,78},{-65,78}}, color={0,0,127}));
        connect(Brine_Outlet_Port, valveLinear.port_b)
          annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));
        connect(Evaporator.Brine_Outlet_port, valveLinear.port_a) annotation (
            Line(points={{-20,-2},{-36,-2},{-36,0},{-50,0}}, color={0,127,255}));
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
      end Single_Effect_UA;

      model Single_Effect_FullCond
        "Single effect evaporator for desalination, this model assumes the water in the tube leaves fully condensed"

        parameter Modelica.Units.SI.AbsolutePressure Psys=1e5;
        parameter Modelica.Units.SI.Mass S_start=20  annotation (Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.Volume V=1;
        parameter Modelica.Units.SI.Area A=1;
        parameter Real KV=-0.03;
        parameter Modelica.Units.SI.Area Ax=1e4;
        parameter Modelica.Units.SI.Diameter Do=0.01;
        parameter Modelica.Units.SI.Thickness th=0.001;
        parameter Modelica.Units.SI.AbsolutePressure pT
                                                       "Init Tube pressure";
                                                       parameter SI.Temperature Tsys;

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Brine_Inlet_Port(redeclare
            package
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
          Ti=0.75,
          Td=10,
          yMax=1,
          yMin=0,
          wp=1,
          wd=1) annotation (Placement(transformation(extent={{-44,68},{-64,88}})));
        Modelica.Blocks.Sources.RealExpression Level_Set(y=0.5) annotation (Placement(transformation(extent={{-14,70},
                  {-34,90}})));
        Components.Evaporator_Brine_SHP Evaporator(
          redeclare package MediumB = NHES.Media.SeaWater (ThermoStates=
                  Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
          p_start=Psys,
          T_st=Tsys,
          V=V,
          A=A)
          annotation (Placement(transformation(extent={{20,-20},{-20,20}})));

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tube_Inlet(redeclare package Medium =
              Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{-108,-50},{-88,-30}}), iconTransformation(extent={{-108,
                  -50},{-88,-30}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare
            package
            Medium = Modelica.Media.Water.StandardWater)
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
          dp_nominal=1000,
          m_flow_nominal=1)
          annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));

      equation
        connect(Brine_Inlet_Port, Brine_Inlet_Port)
          annotation (Line(points={{100,0},{100,0}}, color={0,127,255}));
        connect(Level_Set.y, PID.u_s) annotation (Line(points={{-35,80},{-38,80},{-38,
                78},{-42,78}},                                                     color={0,0,127}));
        connect(Evaporator.RelLevel, PID.u_m) annotation (Line(points={{-22,14},
                {-26,14},{-26,50},{-54,50},{-54,66}}, color={0,0,127}));
        connect(Evaporator.steam_port, Steam_Outlet_Resistance.port_a)
          annotation (Line(points={{0,20},{-4.44089e-16,39}}, color={0,127,255}));
        connect(Tube_Inlet,Tube_Inlet)
          annotation (Line(points={{-98,-40},{-98,-40}},   color={0,127,255}));
        connect(sEE_Tube_Side.Steam_Inlet_Port, Tube_intlet_Resistance.port_b)
          annotation (Line(points={{-20,-40},{-53,-40}}, color={0,127,255}));
        connect(Tube_Inlet, Tube_intlet_Resistance.port_a)
          annotation (Line(points={{-98,-40},{-67,-40}}, color={0,127,255}));
        connect(sEE_Tube_Side.Liquid_Outlet_Port, Tube_Outlet_Resistance.port_a)
          annotation (Line(points={{20,-40},{55,-40}}, color={0,127,255}));
        connect(Tube_Outlet, Tube_Outlet_Resistance.port_b)
          annotation (Line(points={{102,-40},{69,-40}}, color={0,127,255}));
        connect(Evaporator.Brine_Inlet_port, Brine_Inlet_Port)
          annotation (Line(points={{20,0},{100,0}}, color={0,127,255}));
        connect(sEE_Tube_Side.Heat_Port, Evaporator.Heat_Port)
          annotation (Line(points={{0,-30},{0,-20}}, color={191,0,0}));
        connect(Steam_Outlet_Resistance.port_b, Steam_Outlet_Port) annotation (Line(
              points={{4.44089e-16,53},{4.44089e-16,76.5},{0,76.5},{0,100}}, color={0,
                127,255}));
        connect(valveLinear.opening, PID.y) annotation (Line(points={{-60,8},{-60,64},
                {-72,64},{-72,78},{-65,78}}, color={0,0,127}));
        connect(Brine_Outlet_Port, valveLinear.port_b)
          annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));
        connect(Evaporator.Brine_Outlet_port, valveLinear.port_a)
          annotation (Line(points={{-20,0},{-50,0}}, color={0,127,255}));
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
      end Single_Effect_FullCond;

      model Single_Effect_Flashing
        "Single effect evaporator for desalination, uses heat transfer correlations to calc heat exchange"

        parameter Modelica.Units.SI.Mass S_start=20  annotation (Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.Temperature Tsys=350 "Evaporator T";
        parameter Modelica.Units.SI.Volume V=1;
        parameter Modelica.Units.SI.Area A=1;
        parameter Real KV=-0.03;
        parameter Modelica.Units.SI.Area Ax=1e4;
        parameter Modelica.Units.SI.Diameter Do=0.05;
        parameter Modelica.Units.SI.Thickness th=0.007;
        parameter Modelica.Units.SI.AbsolutePressure pT
                                                       "Init Tube pressure";

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Brine_Inlet_Port(redeclare
            package
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
          Ti=0.75,
          Td=10,
          yMax=1,
          yMin=0,
          wp=1,
          wd=1) annotation (Placement(transformation(extent={{-46,70},{-66,90}})));
        Modelica.Blocks.Sources.RealExpression Level_Set(y=0.5) annotation (Placement(transformation(extent={{-14,70},
                  {-34,90}})));
        NHES.Desalination.MEE.Components.Evaporator_Brine_Flash Evaporator(
          redeclare package MediumB = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
          p_start=100000,
          T_st=Tsys,
          V=V,
          A=A) annotation (Placement(transformation(extent={{20,-20},{-20,20}})));

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tube_Inlet(redeclare package Medium =
              Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{-108,-50},{-88,-30}}), iconTransformation(extent={{-108,
                  -50},{-88,-30}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare
            package
            Medium = Modelica.Media.Water.StandardWater)
          annotation (Placement(transformation(extent={{92,-50},{112,-30}}), iconTransformation(extent={{92,-50},
                  {112,-30}})));
        NHES.Desalination.MEE.Components.SEE_Tube_Side_FilmBoiling sEE_Tube_Side(
          p_start=pT,
          Ax=Ax,
          Do=Do,
          th=th,
          k=83) annotation (Placement(transformation(extent={{-20,-60},{20,
                  -20}})));
        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_intlet_Resistance(
            redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
          annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
        TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Tube_Outlet_Resistance(
            redeclare package Medium = Modelica.Media.Water.StandardWater, R=5)
          annotation (Placement(transformation(extent={{52,-50},{72,-30}})));
        NHES.Fluid.Valves.ValveLinear
                                 valveLinear(
          redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
          dp_nominal=1000,
          m_flow_nominal=1)
          annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow BrineCon_Inlet_Port(
            redeclare package Medium = NHES.Media.SeaWater (ThermoStates=
                  Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
          annotation (Placement(transformation(extent={{90,-90},{110,-70}}),
              iconTransformation(extent={{-10,-110},{10,-90}})));
      equation
        connect(Brine_Inlet_Port, Brine_Inlet_Port)
          annotation (Line(points={{100,0},{100,0}}, color={0,127,255}));
        connect(Level_Set.y, PID.u_s) annotation (Line(points={{-35,80},{-44,80}}, color={0,0,127}));
        connect(Evaporator.RelLevel, PID.u_m) annotation (Line(points={{-22,14},
                {-26,14},{-26,50},{-56,50},{-56,68}},
                                             color={0,0,127}));
        connect(Evaporator.steam_port, Steam_Outlet_Resistance.port_a)
          annotation (Line(points={{0,20},{-4.44089e-16,39}}, color={0,127,255}));
        connect(Tube_Inlet,Tube_Inlet)
          annotation (Line(points={{-98,-40},{-98,-40}},   color={0,127,255}));
        connect(sEE_Tube_Side.Steam_Inlet_Port, Tube_intlet_Resistance.port_b)
          annotation (Line(points={{-20,-40},{-53,-40}}, color={0,127,255}));
        connect(Tube_Inlet, Tube_intlet_Resistance.port_a)
          annotation (Line(points={{-98,-40},{-67,-40}}, color={0,127,255}));
        connect(sEE_Tube_Side.Liquid_Outlet_Port, Tube_Outlet_Resistance.port_a)
          annotation (Line(points={{20,-40},{55,-40}}, color={0,127,255}));
        connect(Tube_Outlet, Tube_Outlet_Resistance.port_b)
          annotation (Line(points={{102,-40},{69,-40}}, color={0,127,255}));
        connect(Evaporator.Brine_Inlet_port, Brine_Inlet_Port) annotation (Line(
              points={{20,0},{100,0}},               color={0,127,255}));
        connect(sEE_Tube_Side.Heat_Port, Evaporator.Heat_Port)
          annotation (Line(points={{0,-30},{0,-20}}, color={191,0,0}));
        connect(valveLinear.opening, PID.y) annotation (Line(points={{-60,8},{
                -60,64},{-72,64},{-72,80},{-67,80}},
                                             color={0,0,127}));
        connect(Evaporator.Brine_Outlet_port, valveLinear.port_a) annotation (Line(
              points={{-20,0},{-50,0}},                 color={0,127,255}));
        connect(Steam_Outlet_Resistance.port_b, Steam_Outlet_Port) annotation (Line(
              points={{4.44089e-16,53},{4.44089e-16,76.5},{0,76.5},{0,100}}, color={0,
                127,255}));
        connect(valveLinear.port_b, Brine_Outlet_Port)
          annotation (Line(points={{-70,0},{-100,0}}, color={0,127,255}));
        connect(BrineCon_Inlet_Port, Evaporator.BrineCon_Inlet_port)
          annotation (Line(points={{100,-80},{42,-80},{42,-16},{20,-16}}, color=
               {0,127,255}));
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
      end Single_Effect_Flashing;
    end Brine_Models;
  end Single_Effect;

  package Components "Components used in SEE and MEE models"
    model SEE_Tube_Side_UA "Consatant UA tube side HX for SEE"
      import Modelica.Fluid.Types.Dynamics;
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Medium.SaturationProperties  sat;
      parameter Modelica.Units.SI.ThermalConductance UA=1e5;
      parameter Modelica.Units.SI.PressureDifference dP=10;
      Modelica.Units.SI.AbsolutePressure p;
      Modelica.Units.SI.SpecificEnthalpy h_g;
      Modelica.Units.SI.SpecificEnthalpy h_in;
      Modelica.Units.SI.SpecificEnthalpy h_out;
      Modelica.Units.SI.MassFlowRate mdot;
      Modelica.Units.SI.HeatFlowRate Qhx;
      Modelica.Units.SI.TemperatureDifference dT;
      Modelica.Units.SI.Temperature Ts;

      TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow Heat_Port
        annotation (Placement(transformation(extent={{-10,40},{10,60}}),
            iconTransformation(extent={{-10,40},{10,60}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow Steam_Inlet_Port
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State Liquid_Outlet_Port
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    equation

      sat.psat = p;
      sat.Tsat = Medium.saturationTemperature(p);
      h_g = Medium.dewEnthalpy(sat);

      h_out=h_in-Qhx/mdot;

      Liquid_Outlet_Port.p = p-(mdot/abs(mdot))*dP;
      Liquid_Outlet_Port.h_outflow=h_out;
     - mdot=Liquid_Outlet_Port.m_flow;

      Steam_Inlet_Port.p = p;
      mdot=Steam_Inlet_Port.m_flow;
      Steam_Inlet_Port.h_outflow = h_g;
      h_in =inStream(Steam_Inlet_Port.h_outflow);
      Ts=Heat_Port.T;
      dT=Ts-sat.Tsat;
      Qhx=-UA*dT;
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
    end SEE_Tube_Side_UA;

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
      Modelica.Units.SI.SpecificEnthalpy h_in;
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
      parameter Real RelLevel_start=0.5 "Initial Level" annotation(Dialog(tab="Initialization"));

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
      Modelica.Units.SI.MassFlowRate m_steam
                                            "(start=1)";
      Modelica.Units.SI.Density rho_g;
      Modelica.Units.SI.Density rho_b;
      Modelica.Units.SI.Mass Mm(start=Mm_start);
      Modelica.Units.SI.Mass Mg;
      Modelica.Units.SI.Mass M;
      Modelica.Units.SI.Mass Sa;
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
      Modelica.Units.SI.MassFraction Cs_out(start=Cs_in, fixed=true);
      Modelica.Units.SI.Temperature T(start=T_st,fixed=true);
      Modelica.Units.SI.SpecificEnergy chemp;
      Modelica.Units.SI.SpecificGibbsFreeEnergy gW;

      Modelica.Blocks.Interfaces.RealOutput RelLevel( start=RelLevel_start, fixed=true, quantity="Relative Level")
        annotation (Placement(transformation(extent={{100,60},{120,80}}),
            iconTransformation(extent={{100,60},{120,80}})));
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
      rum=(1-alphag)*rub+alphag*rug;

      M=Mg+Mm;
      Mg=Vg*rho_g;
      Mm=Vm*((1-alphag)*rho_b+alphag*rho_g);
      E=Vm*rum+Vg*rug;
      Sa= Vm*(1-alphag)*rho_b*Cs_out;
      V=Vg+Vm;
      m_T=alphag*rho_g*velg*A;
      velg=(1.41*3.28084/(1-alphag))*(sigma*9.81*(rho_b-rho_g)/(rho_b^2))^0.25;

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
      parameter SI.Volume V2=2 "Volume of Side 2";
      parameter SI.Temperature T2Start= 310.15;
      parameter SI.AbsolutePressure p2Start=1e5;
      parameter SI.MassFraction [:] X2Start=
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
        parameter SI.Time startTime=100;
        parameter SI.MassFlowRate msteamStart=1;
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

    model TCV
      import Modelica.Units.SI;
      import Modelica.Fluid.Types.Dynamics;
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Medium.ThermodynamicState Ptherm;
      Medium.ThermodynamicState Etherm;
      Medium.ThermodynamicState Ctherm;

      parameter SI.Area A1=0.5;
      parameter SI.Area A2=0.5;
      parameter SI.Area A3=1;
      SI.AbsolutePressure Pp(start=3e5);
      parameter SI.AbsolutePressure Pe=5e3 "Vaccum Pressure";
      SI.AbsolutePressure Pc(start=1.5e5);
      SI.MassFlowRate mp;
      SI.MassFlowRate me;
      SI.MassFlowRate mc;
      SI.Velocity U1;
      SI.Velocity U2;
      SI.Velocity U3;
      SI.SpecificEnthalpy hp;
      SI.SpecificEnthalpy he;
      SI.SpecificEnthalpy hc;
      SI.Density rhop;
      SI.Density rhoe;
      SI.Density rhoc;

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow  primarysteam(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{170,-10},{190,10}}),
            iconTransformation(extent={{170,-10},{190,10}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State mixturesteam(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-190,-8},{-170,12}}),
            iconTransformation(extent={{-190,-8},{-170,12}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow  secondarysteam(redeclare
          package Medium =
                   Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{120,-70},{140,-50}}),
            iconTransformation(extent={{120,-70},{140,-50}})));
    equation
      Ptherm=Medium.setState_ph(Pp,hp);
      Etherm=Medium.setState_ph(Pe,he);
      Ctherm=Medium.setState_ph(Pc,hc);
      rhop=Medium.density(Ptherm);
      rhoe=Medium.density(Etherm);
      rhoc=Medium.density(Ctherm);
      mp=rhop*A1*U1;
      me=rhoe*A2*U2;
      mc=rhoc*A3*U3;
      mp+me+mc=0;
      mp*hp+me*he+mc*hc=0;
      Pp*A1+mp*U1+Pe*A2+me*U2-Pc*A3+mc*U3=0;

      //ports
      mp=primarysteam.m_flow;
      me=secondarysteam.m_flow;
      mc=mixturesteam.m_flow;
      hp=actualStream(primarysteam.h_outflow);
      primarysteam.h_outflow=hp;
      he=actualStream(secondarysteam.h_outflow);
      secondarysteam.h_outflow=he;
      hc=mixturesteam.h_outflow;
      Pp=primarysteam.p;
      Pe=secondarysteam.p;
      Pc=mixturesteam.p;
      annotation (Icon(coordinateSystem(extent={{-180,-60},{180,60}}), graphics={
            Rectangle(
              extent={{100,-40},{160,40}},
              lineColor={0,0,0},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{166,20},{138,-20}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{120,-28},{140,-48}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{100,-16},{-160,-40},{-160,40},{100,16},{100,-16}},
              lineColor={0,0,0},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-64,68},{64,46}},
              textColor={0,0,0},
              textString="%name"),
            Rectangle(
              extent={{146,6},{166,-6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{146,-6},{126,0},{146,6},{146,-6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{128,-14},{-12,-22},{-12,22},{128,14},{128,-14}},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None)}),                           Diagram(
            coordinateSystem(extent={{-180,-60},{180,60}})));
    end TCV;

    model Evaporator_Brine_Flash
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
      parameter Real RelLevel_start=0.5 "Initial Level" annotation(Dialog(tab="Initialization"));

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
      Modelica.Units.SI.SpecificEnthalpy h_con;
      Modelica.Units.SI.SpecificEnthalpy h_steam;
      Modelica.Units.SI.MassFlowRate m_T;
      Modelica.Units.SI.MassFlowRate m_b_in;
      Modelica.Units.SI.MassFlowRate m_b_out;
      Modelica.Units.SI.MassFlowRate m_b_con;
      Modelica.Units.SI.MassFlowRate m_steam
                                            "(start=1)";
      Modelica.Units.SI.Density rho_g;
      Modelica.Units.SI.Density rho_b;
      Modelica.Units.SI.Mass Mm(start=Mm_start);
      Modelica.Units.SI.Mass Mg;
      Modelica.Units.SI.Mass M;
      Modelica.Units.SI.Mass Sa;
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
      Modelica.Units.SI.MassFraction [2] Xcon;
      Modelica.Units.SI.MassFraction [2] Xo;
      Modelica.Units.SI.MassFraction Cs_in;
      Modelica.Units.SI.MassFraction Cs_out(start=Cs_in, fixed=true);
      Modelica.Units.SI.MassFraction Cs_con(start=Cs_in, fixed=true);
      Modelica.Units.SI.Temperature T(start=T_st,fixed=true);
      Modelica.Units.SI.SpecificEnergy chemp;
      Modelica.Units.SI.SpecificGibbsFreeEnergy gW;

      Modelica.Blocks.Interfaces.RealOutput RelLevel( start=RelLevel_start, fixed=true, quantity="Relative Level")
        annotation (Placement(transformation(extent={{100,60},{120,80}}),
            iconTransformation(extent={{100,60},{120,80}})));
      Modelica.Fluid.Interfaces.FluidPort_a BrineCon_Inlet_port(
        p(start=p_start),
        redeclare package Medium = MediumB (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
        annotation (Placement(transformation(extent={{-110,-90},{-90,-70}}),
            iconTransformation(extent={{-110,-90},{-90,-70}})));

    equation
      der(Mg)=m_T+m_steam;
      der(Mm)=m_b_con+m_b_in+m_b_out-m_T;
      der(E)=m_b_con*h_con+m_steam*h_steam + m_b_in*h_b_in + m_b_out*h_b_out + Qhx;
      der(Sa)=m_b_con*Cs_con+m_b_in*Cs_in+m_b_out*Cs_out;

    //Definitions  & Stae Eqs
      bstate=MediumB.setState_pTX(p,T,Xo);
      h_b_out=MediumB.specificEnthalpy(bstate);
      rho_b=MediumB.density(bstate);
      u_b=MediumB.specificInternalEnergy(bstate);
      chemp=MediumB.mu_pTX(p,T,Xo);

      Xin[2]=Cs_in;
      Xcon[2]=Cs_con;
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
      rum=(1-alphag)*rub+alphag*rug;

      M=Mg+Mm;
      Mg=Vg*rho_g;
      Mm=Vm*((1-alphag)*rho_b+alphag*rho_g);
      E=Vm*rum+Vg*rug;
      Sa= Vm*(1-alphag)*rho_b*Cs_out;
      V=Vg+Vm;
      m_T=alphag*rho_g*velg*A;
      velg=(1.41*3.28084/(1-alphag))*(sigma*9.81*(rho_b-rho_g)/(rho_b^2))^0.25;

     // m_b_out=h_f;
      level=Vm/A;
      RelLevel=level/(V/A);

      Brine_Inlet_port.p = p;
      BrineCon_Inlet_port.p=p;
      m_b_in=Brine_Inlet_port.m_flow;
      m_b_con=BrineCon_Inlet_port.m_flow;
      h_b_in =inStream(Brine_Inlet_port.h_outflow);
      h_con =inStream(BrineCon_Inlet_port.h_outflow);
      Xin=inStream(Brine_Inlet_port.Xi_outflow);
      Xcon=inStream(BrineCon_Inlet_port.Xi_outflow);
      Brine_Inlet_port.h_outflow = inStream(Brine_Outlet_port.h_outflow);
      Brine_Inlet_port.Xi_outflow = inStream(Brine_Outlet_port.Xi_outflow);
      BrineCon_Inlet_port.h_outflow = inStream(Brine_Outlet_port.h_outflow);
      BrineCon_Inlet_port.Xi_outflow = inStream(Brine_Outlet_port.Xi_outflow);

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
              points={{60,0},{90,0}},
              color={28,108,200},
              thickness=1,
              arrow={Arrow.None,Arrow.Filled}),
            Line(
              points={{-90,0},{-60,0}},
              color={28,108,200},
              thickness=1,
              arrow={Arrow.None,Arrow.Filled}),
            Line(
              points={{-90,-80},{-60,-80}},
              color={28,108,200},
              thickness=1,
              arrow={Arrow.None,Arrow.Filled})}));
    end Evaporator_Brine_Flash;

    model TVC
      import Modelica.Units.SI;
      import Modelica.Fluid.Types.Dynamics;
      replaceable package Medium = Modelica.Media.Water.StandardWater;

      SI.AbsolutePressure Pp(start=3e5);
      parameter SI.AbsolutePressure Pe=5e3 "Vaccum Pressure";
      SI.AbsolutePressure Pc(start=1.5e5);
      SI.MassFlowRate mp;
      SI.MassFlowRate me;
      SI.MassFlowRate mc;
      SI.SpecificEnthalpy hp;
      SI.SpecificEnthalpy he;
      SI.SpecificEnthalpy hc;
      Real MR;
      Real CR;
      Real ER(start=15);

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow  primarysteam(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State mixturesteam(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow  secondarysteam(redeclare
          package Medium =
                   Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    equation
      //bals
      mp+me+mc=0;
      mp*hp+me*he+mc*hc=0;
      //ratios
      MR=mp/me;
      CR=Pc/Pe;
      ER=Pp/Pe;
      if ER<10 then
        MR=-1.61061763080868 + 11.0331387899116 * log(CR) +13.5281254171601/ER-
        14.9338191429307*(log(CR)^2)-34.4397376531113/(ER^2)-48.4767172051364 *
        log(CR)/ER+ 6.46223679313751*(log(CR)^3)+29.9699902855834/(ER^3)+
        70.8113406477665* (log(CR)/(ER^2))+ 46.9590107717394*(log(CR)^2)/ER;
      elseif ER<100 then
        MR=-3.20842210618164 + 3.93335312452389 *CR + 27.2360043794853/ER
        -1.19206948677452 *(CR^2)-141.423288255019/(ER^2)-22.5455184193569
        *CR/ER +0.125812687624122 *(CR^3)+348.506574704109/(ER^3)+41.7960967174647
        *CR/(ER^2)+6.43992939366982 *(CR^2)/ER;
      else
        MR=-1.93422581403321 + 2.152523807931* CR +113.490932154749/ER
        -0.522221061154973* (CR^2)-14735.9653361836/(ER^2)-31.8519701023059*
        CR/ER +0.047506773195604*(CR^3)+900786.044551787/(ER^3)-495.581541338594*
        CR/(ER^2)+10.0251265889018 *(CR^2)/ER;
      end if;

      //ports
      mp=primarysteam.m_flow;
      me=secondarysteam.m_flow;
      mc=mixturesteam.m_flow;
      hp=actualStream(primarysteam.h_outflow);
      primarysteam.h_outflow=hp;
      he=actualStream(secondarysteam.h_outflow);
      secondarysteam.h_outflow=he;
      hc=mixturesteam.h_outflow;
      Pp=primarysteam.p;
      Pe=secondarysteam.p;
      Pc=mixturesteam.p;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end TVC;
  end Components;

  package Examples

    model Single_Effect_UA_Test "Test of a single effect with constant UA"

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1) annotation (Placement(transformation(extent={{-80,-10},{-60,
                10}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1.5,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1) annotation (Placement(transformation(extent={{80,60},{60,80}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=0.08) annotation (Placement(transformation(extent={{80,14},
                {60,34}})));
      NHES.Desalination.MEE.Single_Effect.Water_Models.Single_Effect_UA_W
        sEE_mkUA(
        Psys=70000,
        UA=2.3847e5,
        V=0.5,
        A=1,
        KP=-40)
        annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1,
        h=2725.9e3,
        nPorts=1) annotation (Placement(transformation(extent={{-80,-40},{-60,
                -20}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{82,-40},{62,-20}})));
    equation
      connect(sEE_mkUA.Brine_Outlet_Port, Brine_Oulet.ports[1]) annotation (
          Line(points={{-30,0},{-60,0}},          color={0,127,255}));
      connect(Brine_Inlet.ports[1], sEE_mkUA.Brine_Inlet_Port) annotation (Line(
            points={{60,0},{30,0}},                 color={0,127,255}));
      connect(sEE_mkUA.Cs_In, realExpression.y) annotation (Line(points={{30,6},{
              54,6},{54,24},{59,24}},                 color={0,0,127}));
      connect(Steam_Exit.ports[1], sEE_mkUA.Steam_Outlet_Port)
        annotation (Line(points={{60,70},{0,70},{0,30}},   color={0,127,255}));
      connect(Tube_Inlet.ports[1], sEE_mkUA.Tube_Inlet) annotation (Line(points={{-60,-30},
              {-40,-30},{-40,-12},{-29.4,-12}},              color={0,127,255}));
      connect(Brine_Oulet1.ports[1], sEE_mkUA.Tube_Outlet) annotation (Line(
            points={{62,-30},{40,-30},{40,-12},{30.6,-12}},    color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=1000,
          Interval=0.1,
          __Dymola_Algorithm="Esdirk45a"));
    end Single_Effect_UA_Test;

    model Single_Effect_FC_Test
      "Test of single effect with full condensing model"

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1) annotation (Placement(transformation(extent={{-92,8},{-72,28}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1.5,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{84,0},{64,20}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1) annotation (Placement(transformation(extent={{82,62},{62,82}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=0.08) annotation (Placement(transformation(extent={{84,26},{64,46}})));
      NHES.Desalination.MEE.Single_Effect.Water_Models.Single_Effect_FullCond_W
        sEE_mk6_1(
        Psys=70000,
        V=0.5,
        A=1,
        KP=-40,
        Pumplimit=2)
        annotation (Placement(transformation(extent={{-34,-26},{28,36}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1,
        h=2725.9e3,
        nPorts=1) annotation (Placement(transformation(extent={{-70,-46},{-50,-26}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{78,-38},{58,-18}})));
    equation
      connect(sEE_mk6_1.Brine_Outlet_Port, Brine_Oulet.ports[1])
        annotation (Line(points={{-34,5},{-72,5},{-72,18}}, color={0,127,255}));
      connect(Brine_Inlet.ports[1], sEE_mk6_1.Brine_Inlet_Port) annotation (Line(
            points={{64,10},{47,10},{47,5},{28,5}}, color={0,127,255}));
      connect(sEE_mk6_1.Cs_In, realExpression.y) annotation (Line(points={{28,11.2},
              {28,14},{58,14},{58,36},{63,36}},       color={0,0,127}));
      connect(Steam_Exit.ports[1], sEE_mk6_1.Steam_Outlet_Port)
        annotation (Line(points={{62,72},{-3,72},{-3,36}}, color={0,127,255}));
      connect(Tube_Inlet.ports[1], sEE_mk6_1.Tube_Inlet) annotation (Line(points={{-50,-36},
              {-40,-36},{-40,-7.4},{-33.38,-7.4}},            color={0,127,255}));
      connect(Brine_Oulet1.ports[1], sEE_mk6_1.Tube_Outlet) annotation (Line(
            points={{58,-28},{34,-28},{34,-7.4},{28.62,-7.4}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=1000,
          Interval=0.1,
          __Dymola_Algorithm="Esdirk45a"));
    end Single_Effect_FC_Test;

    model Single_Effect_H_Test "Test of a single effect with constant UA"

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1) annotation (Placement(transformation(extent={{-80,-10},{-60,
                10}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=70000,
        nPorts=1) annotation (Placement(transformation(extent={{80,54},{60,74}})));
      Single_Effect.Water_Models.Single_Effect_W sEE_mkUA(
        Psys=70000,
        V=0.5,
        A=1,
        KV=-0.03)
        annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1,
        h=2725.9e3,
        nPorts=1) annotation (Placement(transformation(extent={{-82,-42},{-62,
                -22}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{80,-42},{60,-22}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1.5,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{82,-10},{62,10}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=0.08)
                                                                    annotation (Placement(transformation(extent={{92,12},
                {72,32}})));
    equation
      connect(sEE_mkUA.Brine_Outlet_Port, Brine_Oulet.ports[1]) annotation (
          Line(points={{-30,0},{-60,0}},          color={0,127,255}));
      connect(Tube_Inlet.ports[1], sEE_mkUA.Tube_Inlet) annotation (Line(points={{-62,-32},
              {-42,-32},{-42,-12},{-29.4,-12}},              color={0,127,255}));
      connect(Brine_Oulet1.ports[1], sEE_mkUA.Tube_Outlet) annotation (Line(
            points={{60,-32},{38,-32},{38,-12},{30.6,-12}},    color={0,127,255}));
      connect(realExpression1.y, sEE_mkUA.Cs_In) annotation (Line(points={{71,
              22},{36,22},{36,6},{30,6}}, color={0,0,127}));
      connect(Brine_Inlet1.ports[1], sEE_mkUA.Brine_Inlet_Port)
        annotation (Line(points={{62,0},{30,0}}, color={0,127,255}));
      connect(sEE_mkUA.Steam_Outlet_Port, Steam_Exit.ports[1])
        annotation (Line(points={{0,30},{0,64},{60,64}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=1000,
          Interval=0.1,
          __Dymola_Algorithm="Esdirk45a"));
    end Single_Effect_H_Test;

    model MEE_Water_Test "Test of a single effect with constant UA"

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=8) annotation (Placement(transformation(extent={{-444,-112},{
                -422,-92}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=35000,
        nPorts=1) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={350,60})));

      Single_Effect.Water_Models.Single_Effect_W sEE_mkUA(
        Psys=100000,
        V=0.5,
        A=1,
        KV=-0.03,
        Ax=2.68e4,
        pT=100000)
        annotation (Placement(transformation(extent={{-380,-30},{-320,30}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1,
        h=2725.9e3,
        nPorts=1) annotation (Placement(transformation(extent={{-410,-22},{-390,
                -2}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        nPorts=1) annotation (Placement(transformation(extent={{-340,-60},{-320,
                -40}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=4,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{400,40},{380,60}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=0.08)
                                                                    annotation (Placement(transformation(extent={{442,70},
                {422,90}})));
      Single_Effect.Water_Models.Single_Effect_W sEE_mkUA1(
        Psys=70000,
        V=0.5,
        A=1,
        KV=-0.03,
        Ax=1.27e5,
        pT=70000)
        annotation (Placement(transformation(extent={{-280,-30},{-220,30}})));
      Single_Effect.Water_Models.Single_Effect_W sEE_mkUA2(
        Psys=70000,
        V=0.5,
        A=1,
        KV=-0.03,
        Ax=1.15e5,
        pT=65000)
        annotation (Placement(transformation(extent={{-180,-30},{-120,30}})));
      Single_Effect.Water_Models.Single_Effect_W sEE_mkUA3(
        Psys=70000,
        V=0.5,
        A=1,
        KV=-0.03,
        Ax=1.05e5,
        pT=60000)
        annotation (Placement(transformation(extent={{-80,-30},{-20,30}})));
      Single_Effect.Water_Models.Single_Effect_W sEE_mkUA4(
        Psys=70000,
        V=0.5,
        A=1,
        KV=-0.03,
        Ax=9.6e4,
        pT=55000)
        annotation (Placement(transformation(extent={{20,-30},{80,30}})));
      Single_Effect.Water_Models.Single_Effect_W sEE_mkUA5(
        Psys=70000,
        V=0.5,
        A=1,
        KV=-0.03,
        Ax=8.8e4,
        pT=50000)
        annotation (Placement(transformation(extent={{120,-30},{180,30}})));
      Single_Effect.Water_Models.Single_Effect_W sEE_mkUA6(
        Psys=70000,
        V=0.5,
        A=1,
        KV=-0.05,
        Ax=8.2e4,
        pT=45000)
        annotation (Placement(transformation(extent={{218,-30},{278,30}})));
      Single_Effect.Water_Models.Single_Effect_W sEE_mkUA7(
        Psys=70000,
        V=0.5,
        A=1,
        KV=-0.07,
        Ax=7.3e4,
        pT=40000)
        annotation (Placement(transformation(extent={{320,-30},{380,30}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=70000,
        nPorts=1) annotation (Placement(transformation(extent={{-240,-60},{-220,
                -40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=65000,
        nPorts=1) annotation (Placement(transformation(extent={{-140,-60},{-120,
                -40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet4(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=60000,
        nPorts=1) annotation (Placement(transformation(extent={{-40,-60},{-20,
                -40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet5(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=55000,
        nPorts=1) annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet6(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=50000,
        nPorts=1) annotation (Placement(transformation(extent={{160,-60},{180,
                -40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet7(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=45000,
        nPorts=1) annotation (Placement(transformation(extent={{260,-60},{280,
                -40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet8(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=40000,
        nPorts=1) annotation (Placement(transformation(extent={{358,-60},{378,
                -40}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=4,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{320,40},{300,60}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=4,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{220,40},{200,60}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet4(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=4,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{120,42},{100,62}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet5(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=4,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{20,40},{0,60}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet6(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=4,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{-80,38},{-100,
                58}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet7(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=4,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{-180,40},{-200,
                60}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet8(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=4,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{-280,40},{-300,
                60}})));
    equation
      connect(sEE_mkUA.Brine_Outlet_Port, Brine_Oulet.ports[1]) annotation (
          Line(points={{-380,0},{-416,0},{-416,-103.75},{-422,-103.75}},
                                                  color={0,127,255}));
      connect(Tube_Inlet.ports[1], sEE_mkUA.Tube_Inlet) annotation (Line(points={{-390,
              -12},{-379.4,-12}},                            color={0,127,255}));
      connect(Brine_Oulet1.ports[1], sEE_mkUA.Tube_Outlet) annotation (Line(
            points={{-320,-50},{-310,-50},{-310,-12},{-319.4,-12}},
                                                               color={0,127,255}));
      connect(sEE_mkUA.Steam_Outlet_Port, sEE_mkUA1.Tube_Inlet) annotation (
          Line(points={{-350,30},{-350,36},{-290,36},{-290,-12},{-279.4,-12}},
            color={0,127,255}));
      connect(sEE_mkUA1.Steam_Outlet_Port, sEE_mkUA2.Tube_Inlet) annotation (
          Line(points={{-250,30},{-250,36},{-190,36},{-190,-12},{-179.4,-12}},
            color={0,127,255}));
      connect(sEE_mkUA2.Steam_Outlet_Port, sEE_mkUA3.Tube_Inlet) annotation (
          Line(points={{-150,30},{-150,36},{-90,36},{-90,-12},{-79.4,-12}},
            color={0,127,255}));
      connect(sEE_mkUA3.Steam_Outlet_Port, sEE_mkUA4.Tube_Inlet) annotation (
          Line(points={{-50,30},{-50,36},{10,36},{10,-12},{20.6,-12}}, color={0,
              127,255}));
      connect(sEE_mkUA4.Steam_Outlet_Port, sEE_mkUA5.Tube_Inlet) annotation (
          Line(points={{50,30},{50,36},{110,36},{110,-12},{120.6,-12}}, color={
              0,127,255}));
      connect(sEE_mkUA5.Steam_Outlet_Port, sEE_mkUA6.Tube_Inlet) annotation (
          Line(points={{150,30},{150,36},{210,36},{210,-12},{218.6,-12}}, color=
             {0,127,255}));
      connect(sEE_mkUA6.Steam_Outlet_Port, sEE_mkUA7.Tube_Inlet) annotation (
          Line(points={{248,30},{248,36},{310,36},{310,-12},{320.6,-12}}, color=
             {0,127,255}));
      connect(sEE_mkUA1.Brine_Outlet_Port, Brine_Oulet.ports[2]) annotation (
          Line(points={{-280,0},{-306,0},{-306,-100},{-382,-100},{-382,-103.25},
              {-422,-103.25}},                                           color=
              {0,127,255}));
      connect(Brine_Oulet.ports[3], sEE_mkUA2.Brine_Outlet_Port) annotation (
          Line(points={{-422,-102.75},{-306,-102.75},{-306,-102},{-188,-102},{
              -188,-100},{-208,-100},{-208,0},{-180,0}},                 color=
              {0,127,255}));
      connect(sEE_mkUA3.Brine_Outlet_Port, Brine_Oulet.ports[4]) annotation (
          Line(points={{-80,0},{-102,0},{-102,-100},{-174,-100},{-174,-102.25},
              {-422,-102.25}},color={0,127,255}));
      connect(sEE_mkUA4.Brine_Outlet_Port, Brine_Oulet.ports[5]) annotation (
          Line(points={{20,0},{6,0},{6,-100},{-166,-100},{-166,-101.75},{-422,
              -101.75}}, color={0,127,255}));
      connect(sEE_mkUA5.Brine_Outlet_Port, Brine_Oulet.ports[6]) annotation (
          Line(points={{120,0},{102,0},{102,-100},{-170,-100},{-170,-101.25},{
              -422,-101.25}}, color={0,127,255}));
      connect(sEE_mkUA6.Brine_Outlet_Port, Brine_Oulet.ports[7]) annotation (
          Line(points={{218,0},{206,0},{206,-100},{-166,-100},{-166,-100.75},{
              -422,-100.75}},                       color={0,127,255}));
      connect(sEE_mkUA7.Brine_Outlet_Port, Brine_Oulet.ports[8]) annotation (
          Line(points={{320,0},{292,0},{292,-100.25},{-422,-100.25}},
            color={0,127,255}));
      connect(realExpression1.y, sEE_mkUA7.Cs_In) annotation (Line(points={{421,80},
              {406,80},{406,6},{380,6}},     color={0,0,127}));
      connect(sEE_mkUA6.Cs_In, realExpression1.y) annotation (Line(points={{278,6},
              {284,6},{284,80},{421,80}},    color={0,0,127}));
      connect(realExpression1.y, sEE_mkUA5.Cs_In) annotation (Line(points={{421,80},
              {184,80},{184,6},{180,6}},                       color={0,0,127}));
      connect(sEE_mkUA4.Cs_In, realExpression1.y) annotation (Line(points={{80,6},{
              86,6},{86,80},{421,80}},     color={0,0,127}));
      connect(realExpression1.y, sEE_mkUA3.Cs_In) annotation (Line(points={{421,80},
              {-16,80},{-16,6},{-20,6}},                       color={0,0,127}));
      connect(sEE_mkUA2.Cs_In, realExpression1.y) annotation (Line(points={{-120,6},
              {-110,6},{-110,80},{421,80}},         color={0,0,127}));
      connect(realExpression1.y, sEE_mkUA1.Cs_In) annotation (Line(points={{421,80},
              {-214,80},{-214,6},{-220,6}},                         color={0,0,
              127}));
      connect(sEE_mkUA.Cs_In, realExpression1.y) annotation (Line(points={{-320,6},
              {-310,6},{-310,80},{421,80}},    color={0,0,127}));
      connect(sEE_mkUA1.Tube_Outlet, Brine_Oulet2.ports[1]) annotation (Line(
            points={{-219.4,-12},{-212,-12},{-212,-50},{-220,-50}}, color={0,
              127,255}));
      connect(sEE_mkUA2.Tube_Outlet, Brine_Oulet3.ports[1]) annotation (Line(
            points={{-119.4,-12},{-112,-12},{-112,-50},{-120,-50}}, color={0,
              127,255}));
      connect(sEE_mkUA3.Tube_Outlet, Brine_Oulet4.ports[1]) annotation (Line(
            points={{-19.4,-12},{-12,-12},{-12,-50},{-20,-50}},
                                                            color={0,127,255}));
      connect(sEE_mkUA4.Tube_Outlet, Brine_Oulet5.ports[1]) annotation (Line(
            points={{80.6,-12},{86,-12},{86,-50},{80,-50}}, color={0,127,255}));
      connect(sEE_mkUA5.Tube_Outlet, Brine_Oulet6.ports[1]) annotation (Line(
            points={{180.6,-12},{186,-12},{186,-50},{180,-50}}, color={0,127,
              255}));
      connect(sEE_mkUA6.Tube_Outlet, Brine_Oulet7.ports[1]) annotation (Line(
            points={{278.6,-12},{288,-12},{288,-50},{280,-50}}, color={0,127,
              255}));
      connect(sEE_mkUA7.Tube_Outlet, Brine_Oulet8.ports[1]) annotation (Line(
            points={{380.6,-12},{386,-12},{386,-50},{378,-50}}, color={0,127,
              255}));
      connect(sEE_mkUA7.Steam_Outlet_Port, Steam_Exit.ports[1]) annotation (
          Line(points={{350,30},{350,50}},            color={0,127,255}));
      connect(sEE_mkUA.Brine_Inlet_Port, Brine_Inlet8.ports[1]) annotation (
          Line(points={{-320,0},{-308,0},{-308,50},{-300,50}},
                    color={0,127,255}));
      connect(sEE_mkUA2.Brine_Inlet_Port, Brine_Inlet6.ports[1]) annotation (
          Line(points={{-120,0},{-108,0},{-108,48},{-100,48}}, color={0,127,255}));
      connect(sEE_mkUA3.Brine_Inlet_Port, Brine_Inlet5.ports[1]) annotation (
          Line(points={{-20,0},{-10,0},{-10,48},{-6,48},{-6,50},{0,50}},
                        color={0,127,255}));
      connect(sEE_mkUA4.Brine_Inlet_Port, Brine_Inlet4.ports[1]) annotation (
          Line(points={{80,0},{92,0},{92,52},{100,52}}, color={0,127,255}));
      connect(sEE_mkUA5.Brine_Inlet_Port, Brine_Inlet3.ports[1]) annotation (
          Line(points={{180,0},{190,0},{190,50},{200,50}}, color={0,127,255}));
      connect(sEE_mkUA6.Brine_Inlet_Port, Brine_Inlet2.ports[1]) annotation (
          Line(points={{278,0},{290,0},{290,50},{300,50}}, color={0,127,255}));
      connect(sEE_mkUA7.Brine_Inlet_Port, Brine_Inlet1.ports[1]) annotation (
          Line(points={{380,0},{386,0},{386,38},{374,38},{374,50},{380,50}},
                                                           color={0,127,255}));
      connect(Brine_Inlet7.ports[1], sEE_mkUA1.Brine_Inlet_Port) annotation (
          Line(points={{-200,50},{-210,50},{-210,0},{-220,0}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{
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
          StopTime=100,
          Interval=0.5,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_Water_Test;

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
        Psys=70000,
        V=0.5,
        A=1,
        Ax=2.68e4,
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

    model Single_Effect_Brine "Test of a single effect with constant UA"

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1) annotation (Placement(transformation(extent={{78,50},{58,70}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1,
        h=2725.9e3,
        nPorts=1) annotation (Placement(transformation(extent={{-62,-48},{-42,
                -28}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1) annotation (Placement(transformation(extent={{70,-48},{50,-28}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=1)
        annotation (Placement(transformation(extent={{-64,-8},{-44,12}})));

      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        use_m_flow_in=false,
        use_X_in=false,
        m_flow=4,
        T=353.15,
        X={0.92,0.08},
        nPorts=1)
        annotation (Placement(transformation(extent={{76,-8},{56,12}})));

      Single_Effect.Brine_Models.Single_Effect single_Effect(
        Tsys=358.15,
        V=0.5,
        A=1,
        Ax=2.68e4,
        pT=100000)
        annotation (Placement(transformation(extent={{-20,-42},{38,16}})));
    equation
      connect(Tube_Inlet1.ports[1], single_Effect.Tube_Inlet) annotation (Line(
            points={{-42,-38},{-26,-38},{-26,-24.6},{-19.42,-24.6}}, color={0,
              127,255}));
      connect(boundary.ports[1], single_Effect.Brine_Outlet_Port) annotation (
          Line(points={{-44,2},{-26,2},{-26,-13},{-20,-13}}, color={0,127,255}));
      connect(boundary1.ports[1], single_Effect.Brine_Inlet_Port) annotation (
          Line(points={{56,2},{46,2},{46,-13},{38,-13}}, color={0,127,255}));
      connect(Brine_Oulet2.ports[1], single_Effect.Tube_Outlet) annotation (
          Line(points={{50,-38},{42,-38},{42,-28},{44,-28},{44,-24.6},{38.58,
              -24.6}}, color={0,127,255}));
      connect(single_Effect.Steam_Outlet_Port, Steam_Exit1.ports[1])
        annotation (Line(points={{9,16},{8,16},{8,60},{58,60}}, color={0,127,
              255}));
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
    end Single_Effect_Brine;

    model MEE_Brine_Test "Test of a MEE"
      parameter SI.MassFlowRate m_steam_in=2;
      parameter SI.MassFraction Xin= 0.08;
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        m_flow=m_steam_in,
        h=2725.9e3,
        nPorts=1) annotation (Placement(transformation(extent={{-158,34},{-138,54}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Water_Outlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=150000,
        nPorts=1) annotation (Placement(transformation(extent={{-164,-24},{-144,
                -4}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Condensate_Out(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-162,-96},{-140,-76}})));

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet10(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{134,-24},{112,
                -4}})));

      Multiple_Effect.MEE_PF8 mEE_PF8_1(redeclare
          NHES.Desalination.MEE.ControlSystems.CS_TemperatureControlSystem CS)
        annotation (Placement(transformation(extent={{-60,-44},{48,64}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Source(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        use_X_in=true,
        p=100000,
        T=303.15,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{104,20},{82,40}})));

      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-108,30},{-88,50}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-106,-92},{-86,-72}})));
      Components.GOR gOR(msteamStart=m_steam_in)
        annotation (Placement(transformation(extent={{-88,-46},{-68,-26}})));
      Modelica.Blocks.Sources.Constant const(k=m_steam_in)
        annotation (Placement(transformation(extent={{-184,90},{-168,74}})));
      Modelica.Blocks.Math.Add add(k1=-1)
        annotation (Placement(transformation(extent={{170,8},{150,28}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=1)
        annotation (Placement(transformation(extent={{214,2},{194,22}})));
      Modelica.Blocks.Sources.Constant const1(k=Xin)
        annotation (Placement(transformation(extent={{222,64},{206,48}})));
    equation
      connect(Brine_Oulet10.ports[1], mEE_PF8_1.Saltwater_Reject_Oulet)
        annotation (Line(points={{112,-14},{80,-14},{80,-11.6},{48,-11.6}},
            color={0,127,255}));
      connect(Brine_Source.ports[1], mEE_PF8_1.Saltwater_Input) annotation (
          Line(points={{82,30},{65,30},{65,31.6},{48,31.6}}, color={0,127,255}));
      connect(Water_Outlet.ports[1], mEE_PF8_1.Water_Outlet) annotation (Line(
            points={{-144,-14},{-102,-14},{-102,-11.6},{-60,-11.6}}, color={0,
              127,255}));
      connect(sensor_m_flow1.port_b, mEE_PF8_1.Condensate_Oulet) annotation (Line(
            points={{-86,-82},{-6,-82},{-6,-42.92}}, color={0,127,255}));
      connect(sensor_m_flow1.port_a, Condensate_Out.ports[1]) annotation (Line(
            points={{-106,-82},{-132,-82},{-132,-86},{-140,-86}}, color={0,127,255}));
      connect(sensor_m_flow.port_a, Tube_Inlet.ports[1]) annotation (Line(points={{-108,40},
              {-134,40},{-134,44},{-138,44}},     color={0,127,255}));
      connect(sensor_m_flow.port_b, mEE_PF8_1.Steam_Input) annotation (Line(points={{-88,40},
              {-70,40},{-70,31.6},{-60,31.6}},          color={0,127,255}));
      connect(sensor_m_flow.m_flow, gOR.SteamFlow) annotation (Line(points={{-98,43.6},
              {-98,52},{-110,52},{-110,-18},{-94,-18},{-94,-31},{-88,-31}}, color={0,
              0,127}));
      connect(sensor_m_flow1.m_flow, gOR.CondFlow) annotation (Line(points={{-96,-78.4},
              {-96,-41},{-88,-41}}, color={0,0,127}));
      connect(const.y, Tube_Inlet.m_flow_in) annotation (Line(points={{-167.2,82},{-164,
              82},{-164,52},{-158,52}}, color={0,0,127}));
      connect(realExpression.y,add. u2)
        annotation (Line(points={{193,12},{172,12}},   color={0,0,127}));
      connect(add.y, Brine_Source.X_in[1]) annotation (Line(points={{149,18},{114,18},
              {114,26},{106.2,26}}, color={0,0,127}));
      connect(const1.y, add.u1) annotation (Line(points={{205.2,56},{178,56},{178,24},
              {172,24}}, color={0,0,127}));
      connect(const1.y, Brine_Source.X_in[2]) annotation (Line(points={{205.2,56},{178,
              56},{178,34},{114,34},{114,26},{106.2,26}}, color={0,0,127}));
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
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-120},
                {180,120}})),
        experiment(
          StopTime=200,
          Interval=0.5,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_Brine_Test;

    model MEE_Brine_Test_FC "Test of a MEE"
      parameter SI.MassFlowRate m_steam_in=2;
      parameter SI.MassFraction Xin= 0.08;
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        m_flow=m_steam_in,
        h=2725.9e3,
        nPorts=1) annotation (Placement(transformation(extent={{-158,34},{-138,54}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Water_Outlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=150000,
        nPorts=1) annotation (Placement(transformation(extent={{-164,-24},{-144,
                -4}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Condensate_Out(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-162,-96},{-140,-76}})));

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet10(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{134,-24},{112,
                -4}})));

      Multiple_Effect.MEE_PF8_FC
                              mEE_PF8_FC(redeclare
          NHES.Desalination.MEE.ControlSystems.CS_PressureControlSystem CS)
        annotation (Placement(transformation(extent={{-60,-48},{48,60}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Source(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        use_X_in=true,
        p=100000,
        h=1.5e5,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{104,22},{82,42}})));

      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-108,30},{-88,50}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-106,-92},{-86,-72}})));
      Components.GOR gOR(msteamStart=m_steam_in)
        annotation (Placement(transformation(extent={{-88,-46},{-68,-26}})));
      Modelica.Blocks.Sources.Constant const(k=m_steam_in)
        annotation (Placement(transformation(extent={{-184,90},{-168,74}})));
      Modelica.Blocks.Math.Add add(k1=-1)
        annotation (Placement(transformation(extent={{170,8},{150,28}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=1)
        annotation (Placement(transformation(extent={{214,2},{194,22}})));
      Modelica.Blocks.Sources.Constant const1(k=Xin)
        annotation (Placement(transformation(extent={{222,64},{206,48}})));
    equation
      connect(Brine_Oulet10.ports[1], mEE_PF8_FC.Saltwater_Reject_Oulet)
        annotation (Line(points={{112,-14},{80,-14},{80,-15.6},{48,-15.6}},
            color={0,127,255}));
      connect(Brine_Source.ports[1], mEE_PF8_FC.Saltwater_Input) annotation (
          Line(points={{82,32},{65,32},{65,27.6},{48,27.6}}, color={0,127,255}));
      connect(Water_Outlet.ports[1], mEE_PF8_FC.Water_Outlet) annotation (Line(
            points={{-144,-14},{-102,-14},{-102,-15.6},{-60,-15.6}}, color={0,
              127,255}));
      connect(sensor_m_flow1.port_b, mEE_PF8_FC.Condensate_Oulet) annotation (
          Line(points={{-86,-82},{-6,-82},{-6,-46.92}}, color={0,127,255}));
      connect(sensor_m_flow1.port_a, Condensate_Out.ports[1]) annotation (Line(
            points={{-106,-82},{-132,-82},{-132,-86},{-140,-86}}, color={0,127,255}));
      connect(sensor_m_flow.port_a, Tube_Inlet.ports[1]) annotation (Line(points={{-108,40},
              {-134,40},{-134,44},{-138,44}},     color={0,127,255}));
      connect(sensor_m_flow.port_b, mEE_PF8_FC.Steam_Input) annotation (Line(
            points={{-88,40},{-70,40},{-70,27.6},{-60,27.6}}, color={0,127,255}));
      connect(sensor_m_flow.m_flow, gOR.SteamFlow) annotation (Line(points={{-98,43.6},
              {-98,52},{-110,52},{-110,-18},{-94,-18},{-94,-31},{-88,-31}}, color={0,
              0,127}));
      connect(sensor_m_flow1.m_flow, gOR.CondFlow) annotation (Line(points={{-96,-78.4},
              {-96,-41},{-88,-41}}, color={0,0,127}));
      connect(const.y, Tube_Inlet.m_flow_in) annotation (Line(points={{-167.2,82},{-164,
              82},{-164,52},{-158,52}}, color={0,0,127}));
      connect(realExpression.y,add. u2)
        annotation (Line(points={{193,12},{172,12}},   color={0,0,127}));
      connect(add.y, Brine_Source.X_in[1]) annotation (Line(points={{149,18},{
              114,18},{114,28},{106.2,28}},
                                    color={0,0,127}));
      connect(const1.y, add.u1) annotation (Line(points={{205.2,56},{178,56},{178,24},
              {172,24}}, color={0,0,127}));
      connect(const1.y, Brine_Source.X_in[2]) annotation (Line(points={{205.2,
              56},{178,56},{178,34},{114,34},{114,28},{106.2,28}},
                                                          color={0,0,127}));
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
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-120},
                {180,120}})),
        experiment(
          StopTime=300,
          Interval=1,
          __Dymola_Algorithm="Esdirk45a"));
    end MEE_Brine_Test_FC;
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




       annotation (defaultComponentName="actuatorSubBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput;

    expandable connector SignalSubBus_SensorOutput

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;
      SI.Temperature T1set;
      SI.Temperature T2set;
      SI.Temperature T3set;
      SI.Temperature T4set;
      SI.Temperature T5set;
      SI.Temperature T6set;
      SI.Temperature T7set;
      SI.Temperature T8set;

      SI.Temperature T1;
      SI.Temperature T2;
      SI.Temperature T3;
      SI.Temperature T4;
      SI.Temperature T5;
      SI.Temperature T6;
      SI.Temperature T7;
      SI.Temperature T8;

      SI.Pressure p1set;
      SI.Pressure p2set;
      SI.Pressure p3set;
      SI.Pressure p4set;
      SI.Pressure p5set;
      SI.Pressure p6set;
      SI.Pressure p7set;
      SI.Pressure p8set;

      SI.Pressure p1;
      SI.Pressure p2;
      SI.Pressure p3;
      SI.Pressure p4;
      SI.Pressure p5;
      SI.Pressure p6;
      SI.Pressure p7;
      SI.Pressure p8;


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
                100}})),
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

      Modelica.Fluid.Interfaces.FluidPort_a Steam_Input(redeclare package Medium =
            Water, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
        "Input Steam for the first effect" annotation (Placement(transformation(
              extent={{-568,30},{-548,50}}), iconTransformation(extent={{-90,50},
                {-110,30}})));

      Modelica.Fluid.Interfaces.FluidPort_b Water_Outlet(redeclare package Medium =
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
  end BaseClasses;

  package Multiple_Effect

    model MEE_PF8
        extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Dummy CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare Data.MEE_Data data);





      Single_Effect.Brine_Models.Single_Effect effect1(
        Tsys=data.T1 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax1,
        Do(displayUnit="m"),
        pT=data.PS)
        annotation (Placement(transformation(extent={{-388,-78},{-328,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect2(
        Tsys=data.T2 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax2,
        pT=95000)
        annotation (Placement(transformation(extent={{-288,-78},{-228,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect3(
        Tsys=data.T3 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax3,
        pT=90000)
        annotation (Placement(transformation(extent={{-184,-76},{-124,-16}})));
      Single_Effect.Brine_Models.Single_Effect effect4(
        Tsys=data.T4 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax4,
        pT=85000)
        annotation (Placement(transformation(extent={{-84,-78},{-24,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect5(
        Tsys=data.T5 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax5,
        pT=80000)
        annotation (Placement(transformation(extent={{14,-78},{74,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect6(
        Tsys=data.T6 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax6,
        pT=75000)
        annotation (Placement(transformation(extent={{114,-78},{174,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect7(
        Tsys=data.T7 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax7,
        pT=70000)
        annotation (Placement(transformation(extent={{212,-76},{272,-16}})));
      Single_Effect.Brine_Models.Single_Effect effect8(
        Tsys=data.T8 + 5,
        V=0.5,
        A=1,
        KV=-0.5,
        Ax=data.Ax8,
        pT=65000)
        annotation (Placement(transformation(extent={{314,-78},{374,-18}})));
      TRANSFORM.Fluid.Valves.ValveLinear CV1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-224,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=10000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-126,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-26,-100})));
      TRANSFORM.Fluid.Valves.ValveLinear CV4(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={74,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV5(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={174,-96})));
      TRANSFORM.Fluid.Valves.ValveLinear CV6(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={274,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV7(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={374,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV8(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=1000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={446,-100})));
      Modelica.Blocks.Sources.RealExpression T1_set(y=data.T1)
        annotation (Placement(transformation(extent={{-266,126},{-246,146}})));
      Modelica.Blocks.Sources.RealExpression T2_set(y=data.T2)
        annotation (Placement(transformation(extent={{-266,106},{-246,126}})));
      Modelica.Blocks.Sources.RealExpression T8_set(y=data.T8)
        annotation (Placement(transformation(extent={{-226,66},{-206,86}})));
      Modelica.Blocks.Sources.RealExpression T3_set(y=data.T3)
        annotation (Placement(transformation(extent={{-266,86},{-246,106}})));
      Modelica.Blocks.Sources.RealExpression T4_set(y=data.T4)
        annotation (Placement(transformation(extent={{-266,66},{-246,86}})));
      Modelica.Blocks.Sources.RealExpression T5_set(y=data.T5)
        annotation (Placement(transformation(extent={{-226,126},{-206,146}})));
      Modelica.Blocks.Sources.RealExpression T6_set(y=data.T6)
        annotation (Placement(transformation(extent={{-226,106},{-206,126}})));
      Modelica.Blocks.Sources.RealExpression T7_set(y=data.T7)
        annotation (Placement(transformation(extent={{-226,86},{-206,106}})));
      Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-364,6},{-344,26}})));
      Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-268,4},{-248,24}})));
      Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-164,6},{-144,26}})));
      Modelica.Fluid.Sensors.Temperature temperature4(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-64,4},{-44,24}})));
      Modelica.Fluid.Sensors.Temperature temperature5(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{44,2},{64,22}})));
      Modelica.Fluid.Sensors.Temperature temperature6(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{138,2},{158,22}})));
      Modelica.Fluid.Sensors.Temperature temperature7(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{232,2},{252,22}})));
      Modelica.Fluid.Sensors.Temperature temperature8(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{334,4},{354,24}})));
      Fluid.Valves.FCV BrineFCV1(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m1,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-310,30})));

      Fluid.Valves.FCV BrineFCV2(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m2,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-210,30})));

      Fluid.Valves.FCV BrineFCV3(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m3,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-110,30})));

      Fluid.Valves.FCV BrineFCV4(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m4,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-10,30})));

      Fluid.Valves.FCV FCV5(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m5,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,30})));

      Fluid.Valves.FCV BrineFCV6(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m6,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={190,30})));

      Fluid.Valves.FCV BrineFCV7(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m7,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={290,30})));

      Fluid.Valves.FCV BrineFCV8(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m8,
        dp_nom=1000,
        k=-1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={388,30})));

      Components.PreHeater preHeater(redeclare package Medium_1 =
            Modelica.Media.Water.StandardWater, redeclare package Medium_2 =
            NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
        annotation (Placement(transformation(extent={{460,20},{500,60}})));
    equation
      connect(effect1.Steam_Outlet_Port,effect2. Tube_Inlet) annotation (Line(
            points={{-358,-18},{-358,-12},{-296,-12},{-296,-60},{-287.4,-60}},
            color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,effect3. Tube_Inlet) annotation (Line(
            points={{-258,-18},{-258,-12},{-196,-12},{-196,-58},{-183.4,-58}},
            color={0,127,255}));
      connect(effect3.Steam_Outlet_Port,effect4. Tube_Inlet) annotation (Line(
            points={{-154,-16},{-154,-10},{-96,-10},{-96,-60},{-83.4,-60}},
                                                               color={0,127,255}));
      connect(effect4.Steam_Outlet_Port,effect5. Tube_Inlet) annotation (Line(
            points={{-54,-18},{-54,-10},{0,-10},{0,-60},{14.6,-60}},
                     color={0,127,255}));
      connect(effect5.Steam_Outlet_Port,effect6. Tube_Inlet) annotation (Line(
            points={{44,-18},{44,-12},{96,-12},{96,-60},{114.6,-60}},
                     color={0,127,255}));
      connect(effect6.Steam_Outlet_Port,effect7. Tube_Inlet) annotation (Line(
            points={{144,-18},{144,-12},{204,-12},{204,-58},{212.6,-58}},
                                                                       color={0,
              127,255}));
      connect(effect7.Steam_Outlet_Port,effect8. Tube_Inlet) annotation (Line(
            points={{242,-16},{242,-12},{304,-12},{304,-60},{314.6,-60}},
                                                                       color={0,
              127,255}));
      connect(effect2.Tube_Outlet,CV1. port_a) annotation (Line(points={{-227.4,
              -60},{-224,-60},{-224,-88}}, color={0,127,255}));
      connect(CV7.port_a,effect8. Tube_Outlet) annotation (Line(points={{374,-88},
              {374,-60},{374.6,-60}},      color={0,127,255}));
      connect(CV6.port_a,effect7. Tube_Outlet) annotation (Line(points={{274,-88},
              {274,-58},{272.6,-58}},      color={0,127,255}));
      connect(CV5.port_a,effect6. Tube_Outlet) annotation (Line(points={{174,-86},
              {174,-60},{174.6,-60}},      color={0,127,255}));
      connect(CV4.port_a,effect5. Tube_Outlet) annotation (Line(points={{74,-88},
              {74,-60},{74.6,-60}},          color={0,127,255}));
      connect(CV3.port_a,effect4. Tube_Outlet) annotation (Line(points={{-26,-90},
              {-26,-60},{-23.4,-60}},      color={0,127,255}));
      connect(CV2.port_a,effect3. Tube_Outlet) annotation (Line(points={{-126,
              -88},{-126,-58},{-123.4,-58}}, color={0,127,255}));
      connect(effect1.Steam_Outlet_Port,temperature1. port)
        annotation (Line(points={{-358,-18},{-358,-6},{-354,-6},{-354,6}},
                                                       color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,temperature2. port) annotation (Line(
            points={{-258,-18},{-258,4}},                     color={0,127,255}));
      connect(effect3.Steam_Outlet_Port,temperature3. port) annotation (Line(
            points={{-154,-16},{-154,6}},                     color={0,127,255}));
      connect(effect4.Steam_Outlet_Port,temperature4. port)
        annotation (Line(points={{-54,-18},{-54,4}}, color={0,127,255}));
      connect(effect5.Steam_Outlet_Port,temperature5. port) annotation (Line(
            points={{44,-18},{44,-8},{54,-8},{54,2}}, color={0,127,255}));
      connect(effect6.Steam_Outlet_Port,temperature6. port) annotation (Line(
            points={{144,-18},{144,-4},{148,-4},{148,2}}, color={0,127,255}));
      connect(effect7.Steam_Outlet_Port,temperature7. port)
        annotation (Line(points={{242,-16},{242,2}}, color={0,127,255}));
      connect(effect8.Steam_Outlet_Port,temperature8. port) annotation (Line(
            points={{344,-18},{344,4}},                   color={0,127,255}));
      connect(sensorBus.T1set, T1_set.y) annotation (Line(
          points={{-29.9,100.1},{-112,100.1},{-112,100},{-196,100},{-196,60},{
              -240,60},{-240,136},{-245,136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T2set, T2_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,116},{
              -245,116}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T4set, T4_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,76},{
              -245,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T5set, T5_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,136},{-205,136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T6set, T6_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,116},{-205,116}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T8set, T8_set.y) annotation (Line(
          points={{-29.9,100.1},{-29.9,100},{-196,100},{-196,76},{-205,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T3set, T3_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,96},{
              -245,96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T7set, T7_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,96},{-205,96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(BrineFCV8.port_b, effect8.Brine_Inlet_Port) annotation (Line(
            points={{388,20},{388,-48},{374,-48}},          color={0,127,255}));
      connect(BrineFCV7.port_b, effect7.Brine_Inlet_Port) annotation (Line(
            points={{290,20},{288,20},{288,-46},{272,-46}}, color={0,127,255}));
      connect(BrineFCV6.port_b, effect6.Brine_Inlet_Port) annotation (Line(
            points={{190,20},{188,20},{188,-48},{174,-48}}, color={0,127,255}));
      connect(FCV5.port_b, effect5.Brine_Inlet_Port) annotation (Line(points={{
              90,20},{88,20},{88,-48},{74,-48}}, color={0,127,255}));
      connect(BrineFCV4.port_b, effect4.Brine_Inlet_Port) annotation (Line(
            points={{-10,20},{-10,-48},{-24,-48}}, color={0,127,255}));
      connect(BrineFCV3.port_b, effect3.Brine_Inlet_Port) annotation (Line(
            points={{-110,20},{-110,-46},{-124,-46}}, color={0,127,255}));
      connect(BrineFCV2.port_b, effect2.Brine_Inlet_Port) annotation (Line(
            points={{-210,20},{-210,-48},{-228,-48}}, color={0,127,255}));
      connect(BrineFCV1.port_b, effect1.Brine_Inlet_Port) annotation (Line(
            points={{-310,20},{-310,-48},{-328,-48}}, color={0,127,255}));
      connect(effect1.Tube_Outlet, Water_Outlet) annotation (Line(points={{
              -327.4,-60},{-324,-60},{-324,-92},{-550,-92},{-550,-40},{-558,-40}},
            color={0,127,255}));
      connect(effect1.Tube_Inlet, Steam_Input) annotation (Line(points={{-387.4,
              -60},{-540,-60},{-540,40},{-558,40}}, color={0,127,255}));
      connect(sensorBus.T1, temperature1.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-347,50},{-347,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T2, temperature2.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-251,50},{-251,14}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T3, temperature3.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-147,50},{-147,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T4, temperature4.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-47,50},{-47,14}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T5, temperature5.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{61,50},{61,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T6, temperature6.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{156,50},{156,12},{155,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T7, temperature7.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{249,50},{249,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T8, temperature8.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{370,50},{370,14},{351,14}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV1_opening, CV1.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-200,-114},{-200,-98},{
              -216,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV2_opening, CV2.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-106,-114},{-106,-98},{
              -118,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV3_opening, CV3.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-8,-114},{-8,-100},{-18,
              -100}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV4_opening, CV4.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{96,-114},{96,-98},{82,
              -98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV5_opening, CV5.opening) annotation (Line(
          points={{30.1,100.1},{226,100.1},{226,100},{422,100},{422,-114},{200,
              -114},{200,-96},{182,-96}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV6_opening, CV6.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{296,-114},{296,-98},{282,
              -98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV7_opening, CV7.opening) annotation (Line(
          points={{30.1,100.1},{420,100.1},{420,102},{422,102},{422,-104},{402,-104},
              {402,-98},{382,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(CV1.port_b, Condensate_Oulet) annotation (Line(points={{-224,-108},
              {-224,-140},{-558,-140}}, color={0,127,255}));
      connect(CV2.port_b, Condensate_Oulet) annotation (Line(points={{-126,-108},
              {-126,-140},{-558,-140}}, color={0,127,255}));
      connect(CV3.port_b, Condensate_Oulet) annotation (Line(points={{-26,-110},
              {-26,-140},{-558,-140}}, color={0,127,255}));
      connect(CV4.port_b, Condensate_Oulet) annotation (Line(points={{74,-108},
              {74,-140},{-558,-140}}, color={0,127,255}));
      connect(CV5.port_b, Condensate_Oulet) annotation (Line(points={{174,-106},
              {174,-140},{-558,-140}}, color={0,127,255}));
      connect(CV6.port_b, Condensate_Oulet) annotation (Line(points={{274,-108},
              {274,-140},{-558,-140}}, color={0,127,255}));
      connect(CV7.port_b, Condensate_Oulet) annotation (Line(points={{374,-108},
              {374,-140},{-558,-140}}, color={0,127,255}));
      connect(effect2.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-288,-48},{-288,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect8.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{314,-48},{314,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect7.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{212,-46},{212,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect6.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{114,-48},{114,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect5.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{14,-48},{14,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect4.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-84,-48},{-84,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect3.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-184,-46},{-184,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect1.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-388,-48},{-388,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(BrineFCV7.port_a, BrineFCV8.port_a)
        annotation (Line(points={{290,40},{388,40}}, color={0,127,255}));
      connect(BrineFCV7.port_a, BrineFCV6.port_a)
        annotation (Line(points={{290,40},{190,40}}, color={0,127,255}));
      connect(BrineFCV6.port_a, FCV5.port_a)
        annotation (Line(points={{190,40},{90,40}}, color={0,127,255}));
      connect(FCV5.port_a, BrineFCV4.port_a)
        annotation (Line(points={{90,40},{-10,40}}, color={0,127,255}));
      connect(BrineFCV4.port_a, BrineFCV3.port_a)
        annotation (Line(points={{-10,40},{-110,40}}, color={0,127,255}));
      connect(BrineFCV3.port_a, BrineFCV2.port_a)
        annotation (Line(points={{-110,40},{-210,40}}, color={0,127,255}));
      connect(BrineFCV2.port_a, BrineFCV1.port_a)
        annotation (Line(points={{-210,40},{-310,40}}, color={0,127,255}));
      connect(CV8.port_b, Condensate_Oulet) annotation (Line(points={{446,-110},{446,
              -140},{-558,-140}},                            color={0,127,255}));
      connect(effect8.Steam_Outlet_Port, preHeater.port_a1) annotation (Line(
            points={{344,-18},{344,-14},{440,-14},{440,64},{478,64},{478,62},{
              480,62},{480,60}}, color={0,127,255}));
      connect(preHeater.port_b1, CV8.port_a) annotation (Line(points={{480.1,
              20.2},{480,20.2},{480,-30},{446,-30},{446,-90}}, color={0,127,255}));
      connect(preHeater.port_a2, Saltwater_Input)
        annotation (Line(points={{500.2,40},{560,40}}, color={0,127,255}));
      connect(preHeater.port_b2, BrineFCV8.port_a)
        annotation (Line(points={{460,40},{388,40}}, color={0,127,255}));
      connect(actuatorBus.CV8_opening, CV8.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-68},{466,-68},{466,-100},{454,
              -100}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (                                                   Diagram(
            coordinateSystem(preserveAspectRatio=false)), Icon(graphics={Text(
              extent={{-38,74},{38,42}},
              textColor={0,0,0},
              textString="%name
"), Bitmap(extent={{-90,-82},{90,58}}, fileName=
                  "modelica://NHES/Resources/Images/Desalination/MEE_Icon.png")}));
    end MEE_PF8;

    model MEE_PF8_FC
        extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Dummy CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare Data.MEE_Data data);

      Single_Effect.Brine_Models.Single_Effect_FullCond
                                               effect1(
        Tsys=data.T1 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax1,
        Do(displayUnit="m"),
        pT=data.PS)
        annotation (Placement(transformation(extent={{-388,-76},{-328,-16}})));
      Single_Effect.Brine_Models.Single_Effect_FullCond
                                               effect2(
        Tsys=data.T2 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax2,
        pT=95000)
        annotation (Placement(transformation(extent={{-288,-78},{-228,-18}})));
      Single_Effect.Brine_Models.Single_Effect_FullCond
                                               effect3(
        Tsys=data.T3 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax3,
        pT=90000)
        annotation (Placement(transformation(extent={{-184,-76},{-124,-16}})));
      Single_Effect.Brine_Models.Single_Effect_FullCond
                                               effect4(
        Tsys=data.T4 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax4,
        pT=85000)
        annotation (Placement(transformation(extent={{-84,-78},{-24,-18}})));
      Single_Effect.Brine_Models.Single_Effect_FullCond
                                               effect5(
        Tsys=data.T5 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax5,
        pT=80000)
        annotation (Placement(transformation(extent={{14,-78},{74,-18}})));
      Single_Effect.Brine_Models.Single_Effect_FullCond
                                               effect6(
        Tsys=data.T6 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax6,
        pT=75000)
        annotation (Placement(transformation(extent={{114,-78},{174,-18}})));
      Single_Effect.Brine_Models.Single_Effect_FullCond
                                               effect7(
        Tsys=data.T7 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax7,
        pT=70000)
        annotation (Placement(transformation(extent={{212,-76},{272,-16}})));
      Single_Effect.Brine_Models.Single_Effect_FullCond
                                               effect8(
        Tsys=data.T8 + 5,
        V=0.5,
        A=1,
        KV=-0.5,
        Ax=data.Ax8,
        pT=65000)
        annotation (Placement(transformation(extent={{314,-78},{374,-18}})));
      TRANSFORM.Fluid.Valves.ValveLinear CV1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-224,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=10000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-126,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-26,-100})));
      TRANSFORM.Fluid.Valves.ValveLinear CV4(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={74,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV5(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={174,-96})));
      TRANSFORM.Fluid.Valves.ValveLinear CV6(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={274,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV7(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={374,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV8(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=1000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={446,-100})));
      Modelica.Blocks.Sources.RealExpression T1_set(y=data.T1)
        annotation (Placement(transformation(extent={{-266,126},{-246,146}})));
      Modelica.Blocks.Sources.RealExpression T2_set(y=data.T2)
        annotation (Placement(transformation(extent={{-266,106},{-246,126}})));
      Modelica.Blocks.Sources.RealExpression T8_set(y=data.T8)
        annotation (Placement(transformation(extent={{-226,66},{-206,86}})));
      Modelica.Blocks.Sources.RealExpression T3_set(y=data.T3)
        annotation (Placement(transformation(extent={{-266,86},{-246,106}})));
      Modelica.Blocks.Sources.RealExpression T4_set(y=data.T4)
        annotation (Placement(transformation(extent={{-266,66},{-246,86}})));
      Modelica.Blocks.Sources.RealExpression T5_set(y=data.T5)
        annotation (Placement(transformation(extent={{-226,126},{-206,146}})));
      Modelica.Blocks.Sources.RealExpression T6_set(y=data.T6)
        annotation (Placement(transformation(extent={{-226,106},{-206,126}})));
      Modelica.Blocks.Sources.RealExpression T7_set(y=data.T7)
        annotation (Placement(transformation(extent={{-226,86},{-206,106}})));
      Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-364,6},{-344,26}})));
      Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-268,4},{-248,24}})));
      Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-164,6},{-144,26}})));
      Modelica.Fluid.Sensors.Temperature temperature4(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-64,4},{-44,24}})));
      Modelica.Fluid.Sensors.Temperature temperature5(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{44,2},{64,22}})));
      Modelica.Fluid.Sensors.Temperature temperature6(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{138,2},{158,22}})));
      Modelica.Fluid.Sensors.Temperature temperature7(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{232,2},{252,22}})));
      Modelica.Fluid.Sensors.Temperature temperature8(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{334,4},{354,24}})));
      Fluid.Valves.FCV BrineFCV1(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m1,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-310,30})));

      Fluid.Valves.FCV BrineFCV2(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m2,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-210,30})));

      Fluid.Valves.FCV BrineFCV3(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m3,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-110,30})));

      Fluid.Valves.FCV BrineFCV4(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m4,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-10,30})));

      Fluid.Valves.FCV FCV5(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m5,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,30})));

      Fluid.Valves.FCV BrineFCV6(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m6,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={190,30})));

      Fluid.Valves.FCV BrineFCV7(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m7,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={290,30})));

      Fluid.Valves.FCV BrineFCV8(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m8,
        dp_nom=1000,
        k=-1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={388,30})));

      Components.PreHeater preHeater(redeclare package Medium_1 =
            Modelica.Media.Water.StandardWater, redeclare package Medium_2 =
            NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
        annotation (Placement(transformation(extent={{460,20},{500,60}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure1
        annotation (Placement(transformation(extent={{-392,22},{-372,42}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure2
        annotation (Placement(transformation(extent={{-284,-4},{-264,16}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure3
        annotation (Placement(transformation(extent={{-182,12},{-162,32}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure4
        annotation (Placement(transformation(extent={{-78,-4},{-58,16}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure5
        annotation (Placement(transformation(extent={{16,-4},{36,16}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure6
        annotation (Placement(transformation(extent={{116,2},{136,22}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure7
        annotation (Placement(transformation(extent={{208,-2},{228,18}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure8
        annotation (Placement(transformation(extent={{320,-8},{340,12}})));
      Modelica.Blocks.Sources.RealExpression P1_set(y=data.P1)
        annotation (Placement(transformation(extent={{-370,126},{-350,146}})));
      Modelica.Blocks.Sources.RealExpression P2_set(y=data.P2)
        annotation (Placement(transformation(extent={{-370,106},{-350,126}})));
      Modelica.Blocks.Sources.RealExpression P8_set(y=data.P8)
        annotation (Placement(transformation(extent={{-330,66},{-310,86}})));
      Modelica.Blocks.Sources.RealExpression P3_set(y=data.P3)
        annotation (Placement(transformation(extent={{-370,86},{-350,106}})));
      Modelica.Blocks.Sources.RealExpression P4_set(y=data.P4)
        annotation (Placement(transformation(extent={{-370,66},{-350,86}})));
      Modelica.Blocks.Sources.RealExpression P5_set(y=data.P5)
        annotation (Placement(transformation(extent={{-330,126},{-310,146}})));
      Modelica.Blocks.Sources.RealExpression P6_set(y=data.P6)
        annotation (Placement(transformation(extent={{-330,106},{-310,126}})));
      Modelica.Blocks.Sources.RealExpression P7_set(y=data.P7)
        annotation (Placement(transformation(extent={{-330,86},{-310,106}})));
    equation
      connect(effect1.Steam_Outlet_Port,effect2. Tube_Inlet) annotation (Line(
            points={{-358,-16},{-358,-12},{-296,-12},{-296,-60},{-287.4,-60}},
            color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,effect3. Tube_Inlet) annotation (Line(
            points={{-258,-18},{-258,-12},{-196,-12},{-196,-58},{-183.4,-58}},
            color={0,127,255}));
      connect(effect3.Steam_Outlet_Port,effect4. Tube_Inlet) annotation (Line(
            points={{-154,-16},{-154,-10},{-96,-10},{-96,-60},{-83.4,-60}},
                                                               color={0,127,255}));
      connect(effect4.Steam_Outlet_Port,effect5. Tube_Inlet) annotation (Line(
            points={{-54,-18},{-54,-10},{0,-10},{0,-60},{14.6,-60}},
                     color={0,127,255}));
      connect(effect5.Steam_Outlet_Port,effect6. Tube_Inlet) annotation (Line(
            points={{44,-18},{44,-12},{96,-12},{96,-60},{114.6,-60}},
                     color={0,127,255}));
      connect(effect6.Steam_Outlet_Port,effect7. Tube_Inlet) annotation (Line(
            points={{144,-18},{144,-12},{204,-12},{204,-58},{212.6,-58}},
                                                                       color={0,
              127,255}));
      connect(effect7.Steam_Outlet_Port,effect8. Tube_Inlet) annotation (Line(
            points={{242,-16},{242,-12},{304,-12},{304,-60},{314.6,-60}},
                                                                       color={0,
              127,255}));
      connect(effect2.Tube_Outlet,CV1. port_a) annotation (Line(points={{-227.4,
              -60},{-224,-60},{-224,-88}}, color={0,127,255}));
      connect(CV7.port_a,effect8. Tube_Outlet) annotation (Line(points={{374,-88},
              {374,-60},{374.6,-60}},      color={0,127,255}));
      connect(CV6.port_a,effect7. Tube_Outlet) annotation (Line(points={{274,-88},
              {274,-58},{272.6,-58}},      color={0,127,255}));
      connect(CV5.port_a,effect6. Tube_Outlet) annotation (Line(points={{174,-86},
              {174,-60},{174.6,-60}},      color={0,127,255}));
      connect(CV4.port_a,effect5. Tube_Outlet) annotation (Line(points={{74,-88},
              {74,-60},{74.6,-60}},          color={0,127,255}));
      connect(CV3.port_a,effect4. Tube_Outlet) annotation (Line(points={{-26,-90},
              {-26,-60},{-23.4,-60}},      color={0,127,255}));
      connect(CV2.port_a,effect3. Tube_Outlet) annotation (Line(points={{-126,
              -88},{-126,-58},{-123.4,-58}}, color={0,127,255}));
      connect(effect1.Steam_Outlet_Port,temperature1. port)
        annotation (Line(points={{-358,-16},{-358,-6},{-354,-6},{-354,6}},
                                                       color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,temperature2. port) annotation (Line(
            points={{-258,-18},{-258,4}},                     color={0,127,255}));
      connect(effect3.Steam_Outlet_Port,temperature3. port) annotation (Line(
            points={{-154,-16},{-154,6}},                     color={0,127,255}));
      connect(effect4.Steam_Outlet_Port,temperature4. port)
        annotation (Line(points={{-54,-18},{-54,4}}, color={0,127,255}));
      connect(effect5.Steam_Outlet_Port,temperature5. port) annotation (Line(
            points={{44,-18},{44,-8},{54,-8},{54,2}}, color={0,127,255}));
      connect(effect6.Steam_Outlet_Port,temperature6. port) annotation (Line(
            points={{144,-18},{144,-4},{148,-4},{148,2}}, color={0,127,255}));
      connect(effect7.Steam_Outlet_Port,temperature7. port)
        annotation (Line(points={{242,-16},{242,2}}, color={0,127,255}));
      connect(effect8.Steam_Outlet_Port,temperature8. port) annotation (Line(
            points={{344,-18},{344,4}},                   color={0,127,255}));
      connect(sensorBus.T1set, T1_set.y) annotation (Line(
          points={{-29.9,100.1},{-112,100.1},{-112,100},{-196,100},{-196,60},{
              -240,60},{-240,136},{-245,136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T2set, T2_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,116},{
              -245,116}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T4set, T4_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,76},{
              -245,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T5set, T5_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,136},{-205,136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T6set, T6_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,116},{-205,116}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T8set, T8_set.y) annotation (Line(
          points={{-29.9,100.1},{-29.9,100},{-196,100},{-196,76},{-205,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T3set, T3_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,96},{
              -245,96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T7set, T7_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,96},{-205,96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(BrineFCV8.port_b, effect8.Brine_Inlet_Port) annotation (Line(
            points={{388,20},{388,-48},{374,-48}},          color={0,127,255}));
      connect(BrineFCV7.port_b, effect7.Brine_Inlet_Port) annotation (Line(
            points={{290,20},{288,20},{288,-46},{272,-46}}, color={0,127,255}));
      connect(BrineFCV6.port_b, effect6.Brine_Inlet_Port) annotation (Line(
            points={{190,20},{188,20},{188,-48},{174,-48}}, color={0,127,255}));
      connect(FCV5.port_b, effect5.Brine_Inlet_Port) annotation (Line(points={{
              90,20},{88,20},{88,-48},{74,-48}}, color={0,127,255}));
      connect(BrineFCV4.port_b, effect4.Brine_Inlet_Port) annotation (Line(
            points={{-10,20},{-10,-48},{-24,-48}}, color={0,127,255}));
      connect(BrineFCV3.port_b, effect3.Brine_Inlet_Port) annotation (Line(
            points={{-110,20},{-110,-46},{-124,-46}}, color={0,127,255}));
      connect(BrineFCV2.port_b, effect2.Brine_Inlet_Port) annotation (Line(
            points={{-210,20},{-210,-48},{-228,-48}}, color={0,127,255}));
      connect(BrineFCV1.port_b, effect1.Brine_Inlet_Port) annotation (Line(
            points={{-310,20},{-310,-46},{-328,-46}}, color={0,127,255}));
      connect(effect1.Tube_Outlet, Water_Outlet) annotation (Line(points={{-327.4,
              -58},{-324,-58},{-324,-92},{-550,-92},{-550,-40},{-558,-40}},
            color={0,127,255}));
      connect(effect1.Tube_Inlet, Steam_Input) annotation (Line(points={{-387.4,
              -58},{-540,-58},{-540,40},{-558,40}}, color={0,127,255}));
      connect(sensorBus.T1, temperature1.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-347,50},{-347,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T2, temperature2.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-251,50},{-251,14}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T3, temperature3.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-147,50},{-147,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T4, temperature4.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-47,50},{-47,14}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T5, temperature5.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{61,50},{61,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T6, temperature6.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{156,50},{156,12},{155,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T7, temperature7.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{249,50},{249,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T8, temperature8.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{370,50},{370,14},{351,14}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV1_opening, CV1.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-200,-114},{-200,-98},{
              -216,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV2_opening, CV2.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-106,-114},{-106,-98},{
              -118,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV3_opening, CV3.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-8,-114},{-8,-100},{-18,
              -100}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV4_opening, CV4.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{96,-114},{96,-98},{82,
              -98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV5_opening, CV5.opening) annotation (Line(
          points={{30.1,100.1},{226,100.1},{226,100},{422,100},{422,-114},{200,
              -114},{200,-96},{182,-96}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV6_opening, CV6.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{296,-114},{296,-98},{282,
              -98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV7_opening, CV7.opening) annotation (Line(
          points={{30.1,100.1},{420,100.1},{420,102},{422,102},{422,-104},{402,-104},
              {402,-98},{382,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(CV1.port_b, Condensate_Oulet) annotation (Line(points={{-224,-108},
              {-224,-140},{-558,-140}}, color={0,127,255}));
      connect(CV2.port_b, Condensate_Oulet) annotation (Line(points={{-126,-108},
              {-126,-140},{-558,-140}}, color={0,127,255}));
      connect(CV3.port_b, Condensate_Oulet) annotation (Line(points={{-26,-110},
              {-26,-140},{-558,-140}}, color={0,127,255}));
      connect(CV4.port_b, Condensate_Oulet) annotation (Line(points={{74,-108},
              {74,-140},{-558,-140}}, color={0,127,255}));
      connect(CV5.port_b, Condensate_Oulet) annotation (Line(points={{174,-106},
              {174,-140},{-558,-140}}, color={0,127,255}));
      connect(CV6.port_b, Condensate_Oulet) annotation (Line(points={{274,-108},
              {274,-140},{-558,-140}}, color={0,127,255}));
      connect(CV7.port_b, Condensate_Oulet) annotation (Line(points={{374,-108},
              {374,-140},{-558,-140}}, color={0,127,255}));
      connect(effect2.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-288,-48},{-288,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect8.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{314,-48},{314,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect7.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{212,-46},{212,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect6.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{114,-48},{114,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect5.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{14,-48},{14,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect4.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-84,-48},{-84,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect3.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-184,-46},{-184,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect1.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-388,-46},{-388,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(BrineFCV7.port_a, BrineFCV8.port_a)
        annotation (Line(points={{290,40},{388,40}}, color={0,127,255}));
      connect(BrineFCV7.port_a, BrineFCV6.port_a)
        annotation (Line(points={{290,40},{190,40}}, color={0,127,255}));
      connect(BrineFCV6.port_a, FCV5.port_a)
        annotation (Line(points={{190,40},{90,40}}, color={0,127,255}));
      connect(FCV5.port_a, BrineFCV4.port_a)
        annotation (Line(points={{90,40},{-10,40}}, color={0,127,255}));
      connect(BrineFCV4.port_a, BrineFCV3.port_a)
        annotation (Line(points={{-10,40},{-110,40}}, color={0,127,255}));
      connect(BrineFCV3.port_a, BrineFCV2.port_a)
        annotation (Line(points={{-110,40},{-210,40}}, color={0,127,255}));
      connect(BrineFCV2.port_a, BrineFCV1.port_a)
        annotation (Line(points={{-210,40},{-310,40}}, color={0,127,255}));
      connect(CV8.port_b, Condensate_Oulet) annotation (Line(points={{446,-110},{446,
              -140},{-558,-140}},                            color={0,127,255}));
      connect(effect8.Steam_Outlet_Port, preHeater.port_a1) annotation (Line(
            points={{344,-18},{344,-14},{440,-14},{440,64},{478,64},{478,62},{
              480,62},{480,60}}, color={0,127,255}));
      connect(preHeater.port_b1, CV8.port_a) annotation (Line(points={{480.1,
              20.2},{480,20.2},{480,-30},{446,-30},{446,-90}}, color={0,127,255}));
      connect(preHeater.port_a2, Saltwater_Input)
        annotation (Line(points={{500.2,40},{560,40}}, color={0,127,255}));
      connect(preHeater.port_b2, BrineFCV8.port_a)
        annotation (Line(points={{460,40},{388,40}}, color={0,127,255}));
      connect(actuatorBus.CV8_opening, CV8.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-68},{466,-68},{466,-100},{454,
              -100}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(pressure1.port, effect1.Steam_Outlet_Port) annotation (Line(
            points={{-382,22},{-382,-4},{-358,-4},{-358,-16}}, color={0,127,255}));
      connect(pressure2.port, effect2.Steam_Outlet_Port) annotation (Line(
            points={{-274,-4},{-274,-18},{-258,-18}}, color={0,127,255}));
      connect(pressure3.port, effect3.Steam_Outlet_Port) annotation (Line(
            points={{-172,12},{-172,-4},{-154,-4},{-154,-16}}, color={0,127,255}));
      connect(pressure4.port, effect4.Steam_Outlet_Port) annotation (Line(
            points={{-68,-4},{-68,-18},{-54,-18}}, color={0,127,255}));
      connect(pressure5.port, effect5.Steam_Outlet_Port) annotation (Line(
            points={{26,-4},{26,-18},{44,-18}}, color={0,127,255}));
      connect(pressure6.port, effect6.Steam_Outlet_Port) annotation (Line(
            points={{126,2},{126,-4},{144,-4},{144,-18}}, color={0,127,255}));
      connect(pressure7.port, effect7.Steam_Outlet_Port) annotation (Line(
            points={{218,-2},{228,-2},{228,-16},{242,-16}}, color={0,127,255}));
      connect(pressure8.port, effect8.Steam_Outlet_Port) annotation (Line(
            points={{330,-8},{336,-8},{336,-18},{344,-18}}, color={0,127,255}));
      connect(sensorBus.p1set, P1_set.y) annotation (Line(
          points={{-29.9,100.1},{-236,100.1},{-236,152},{-336,152},{-336,136},{
              -349,136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p2set, P2_set.y) annotation (Line(
          points={{-29.9,100.1},{-300,100.1},{-300,56},{-336,56},{-336,116},{
              -349,116}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p3set, P3_set.y) annotation (Line(
          points={{-29.9,100.1},{-29.9,96},{-349,96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p4set, P4_set.y) annotation (Line(
          points={{-29.9,100.1},{-29.9,52},{-340,52},{-340,76},{-349,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p5set, P5_set.y) annotation (Line(
          points={{-29.9,100.1},{-296,100.1},{-296,136},{-309,136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p6set, P6_set.y) annotation (Line(
          points={{-29.9,100.1},{-300,100.1},{-300,116},{-309,116}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p7set, P7_set.y) annotation (Line(
          points={{-29.9,100.1},{-29.9,96},{-309,96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p8set, P8_set.y) annotation (Line(
          points={{-29.9,100.1},{-29.9,60},{-192,60},{-192,56},{-296,56},{-296,
              76},{-309,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p1, pressure1.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,44},{-360,44},{-360,32},{-376,32}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p2, pressure2.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,44},{-268,44},{-268,32},{-292,32},{-292,
              6},{-268,6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p3, pressure3.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,44},{-188,44},{-188,22},{-166,22}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p4, pressure4.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,6},{-62,6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p5, pressure5.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,8},{8,8},{8,24},{32,24},{32,6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p6, pressure6.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,44},{132,44},{132,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p7, pressure7.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,44},{224,44},{224,8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p8, pressure8.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,44},{336,44},{336,32},{308,32},{308,2},{
              336,2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      annotation (                                                   Diagram(
            coordinateSystem(preserveAspectRatio=false)), Icon(graphics={Text(
              extent={{-38,74},{38,42}},
              textColor={0,0,0},
              textString="%name
"), Bitmap(extent={{-90,-82},{90,58}}, fileName=
                  "modelica://NHES/Resources/Images/Desalination/MEE_Icon.png")}));
    end MEE_PF8_FC;

    model MEE_PF6
        extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Dummy CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare Data.MEE_Data data);

      Single_Effect.Brine_Models.Single_Effect effect1(
        Tsys=data.T1 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax1,
        Do(displayUnit="m"),
        pT=data.PS)
        annotation (Placement(transformation(extent={{-388,-78},{-328,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect2(
        Tsys=data.T2 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax2,
        pT=95000)
        annotation (Placement(transformation(extent={{-288,-78},{-228,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect3(
        Tsys=data.T3 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax3,
        pT=90000)
        annotation (Placement(transformation(extent={{-184,-76},{-124,-16}})));
      Single_Effect.Brine_Models.Single_Effect effect4(
        Tsys=data.T4 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax4,
        pT=85000)
        annotation (Placement(transformation(extent={{-84,-78},{-24,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect5(
        Tsys=data.T5 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax5,
        pT=80000)
        annotation (Placement(transformation(extent={{14,-78},{74,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect6(
        Tsys=data.T6 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax6,
        pT=75000)
        annotation (Placement(transformation(extent={{114,-78},{174,-18}})));
      TRANSFORM.Fluid.Valves.ValveLinear CV1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-224,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=10000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-126,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-26,-100})));
      TRANSFORM.Fluid.Valves.ValveLinear CV4(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={74,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV5(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={174,-96})));
      TRANSFORM.Fluid.Valves.ValveLinear CV6(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=1000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={446,-100})));
      Modelica.Blocks.Sources.RealExpression T1_set(y=data.T1)
        annotation (Placement(transformation(extent={{-266,126},{-246,146}})));
      Modelica.Blocks.Sources.RealExpression T2_set(y=data.T2)
        annotation (Placement(transformation(extent={{-266,106},{-246,126}})));
      Modelica.Blocks.Sources.RealExpression T8_set(y=data.T8)
        annotation (Placement(transformation(extent={{-226,66},{-206,86}})));
      Modelica.Blocks.Sources.RealExpression T3_set(y=data.T3)
        annotation (Placement(transformation(extent={{-266,86},{-246,106}})));
      Modelica.Blocks.Sources.RealExpression T4_set(y=data.T4)
        annotation (Placement(transformation(extent={{-266,66},{-246,86}})));
      Modelica.Blocks.Sources.RealExpression T5_set(y=data.T5)
        annotation (Placement(transformation(extent={{-226,126},{-206,146}})));
      Modelica.Blocks.Sources.RealExpression T6_set(y=data.T6)
        annotation (Placement(transformation(extent={{-226,106},{-206,126}})));
      Modelica.Blocks.Sources.RealExpression T7_set(y=data.T7)
        annotation (Placement(transformation(extent={{-226,86},{-206,106}})));
      Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-364,6},{-344,26}})));
      Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-268,4},{-248,24}})));
      Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-164,6},{-144,26}})));
      Modelica.Fluid.Sensors.Temperature temperature4(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-64,4},{-44,24}})));
      Modelica.Fluid.Sensors.Temperature temperature5(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{44,2},{64,22}})));
      Modelica.Fluid.Sensors.Temperature temperature6(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{138,2},{158,22}})));
      Fluid.Valves.FCV BrineFCV1(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m1,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-310,30})));

      Fluid.Valves.FCV BrineFCV2(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m2,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-210,30})));

      Fluid.Valves.FCV BrineFCV3(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m3,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-110,30})));

      Fluid.Valves.FCV BrineFCV4(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m4,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-10,30})));

      Fluid.Valves.FCV FCV5(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m5,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,30})));

      Fluid.Valves.FCV BrineFCV6(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m6,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={190,30})));

      Components.PreHeater preHeater(redeclare package Medium_1 =
            Modelica.Media.Water.StandardWater, redeclare package Medium_2 =
            NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
        annotation (Placement(transformation(extent={{460,20},{500,60}})));
    equation
      connect(effect1.Steam_Outlet_Port,effect2. Tube_Inlet) annotation (Line(
            points={{-358,-18},{-358,-12},{-296,-12},{-296,-60},{-287.4,-60}},
            color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,effect3. Tube_Inlet) annotation (Line(
            points={{-258,-18},{-258,-12},{-196,-12},{-196,-58},{-183.4,-58}},
            color={0,127,255}));
      connect(effect3.Steam_Outlet_Port,effect4. Tube_Inlet) annotation (Line(
            points={{-154,-16},{-154,-10},{-96,-10},{-96,-60},{-83.4,-60}},
                                                               color={0,127,255}));
      connect(effect4.Steam_Outlet_Port,effect5. Tube_Inlet) annotation (Line(
            points={{-54,-18},{-54,-10},{0,-10},{0,-60},{14.6,-60}},
                     color={0,127,255}));
      connect(effect5.Steam_Outlet_Port,effect6. Tube_Inlet) annotation (Line(
            points={{44,-18},{44,-12},{96,-12},{96,-60},{114.6,-60}},
                     color={0,127,255}));
      connect(effect2.Tube_Outlet,CV1. port_a) annotation (Line(points={{-227.4,
              -60},{-224,-60},{-224,-88}}, color={0,127,255}));
      connect(CV5.port_a,effect6. Tube_Outlet) annotation (Line(points={{174,-86},
              {174,-60},{174.6,-60}},      color={0,127,255}));
      connect(CV4.port_a,effect5. Tube_Outlet) annotation (Line(points={{74,-88},
              {74,-60},{74.6,-60}},          color={0,127,255}));
      connect(CV3.port_a,effect4. Tube_Outlet) annotation (Line(points={{-26,-90},
              {-26,-60},{-23.4,-60}},      color={0,127,255}));
      connect(CV2.port_a,effect3. Tube_Outlet) annotation (Line(points={{-126,
              -88},{-126,-58},{-123.4,-58}}, color={0,127,255}));
      connect(effect1.Steam_Outlet_Port,temperature1. port)
        annotation (Line(points={{-358,-18},{-358,-6},{-354,-6},{-354,6}},
                                                       color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,temperature2. port) annotation (Line(
            points={{-258,-18},{-258,4}},                     color={0,127,255}));
      connect(effect3.Steam_Outlet_Port,temperature3. port) annotation (Line(
            points={{-154,-16},{-154,6}},                     color={0,127,255}));
      connect(effect4.Steam_Outlet_Port,temperature4. port)
        annotation (Line(points={{-54,-18},{-54,4}}, color={0,127,255}));
      connect(effect5.Steam_Outlet_Port,temperature5. port) annotation (Line(
            points={{44,-18},{44,-8},{54,-8},{54,2}}, color={0,127,255}));
      connect(effect6.Steam_Outlet_Port,temperature6. port) annotation (Line(
            points={{144,-18},{144,-4},{148,-4},{148,2}}, color={0,127,255}));
      connect(sensorBus.T1set, T1_set.y) annotation (Line(
          points={{-29.9,100.1},{-112,100.1},{-112,100},{-196,100},{-196,60},{
              -240,60},{-240,136},{-245,136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T2set, T2_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,116},{
              -245,116}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T4set, T4_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,76},{
              -245,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T5set, T5_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,136},{-205,136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T6set, T6_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,116},{-205,116}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T8set, T8_set.y) annotation (Line(
          points={{-29.9,100.1},{-29.9,100},{-196,100},{-196,76},{-205,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T3set, T3_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,96},{
              -245,96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T7set, T7_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,96},{-205,96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(BrineFCV6.port_b, effect6.Brine_Inlet_Port) annotation (Line(
            points={{190,20},{188,20},{188,-48},{174,-48}}, color={0,127,255}));
      connect(FCV5.port_b, effect5.Brine_Inlet_Port) annotation (Line(points={{
              90,20},{88,20},{88,-48},{74,-48}}, color={0,127,255}));
      connect(BrineFCV4.port_b, effect4.Brine_Inlet_Port) annotation (Line(
            points={{-10,20},{-10,-48},{-24,-48}}, color={0,127,255}));
      connect(BrineFCV3.port_b, effect3.Brine_Inlet_Port) annotation (Line(
            points={{-110,20},{-110,-46},{-124,-46}}, color={0,127,255}));
      connect(BrineFCV2.port_b, effect2.Brine_Inlet_Port) annotation (Line(
            points={{-210,20},{-210,-48},{-228,-48}}, color={0,127,255}));
      connect(BrineFCV1.port_b, effect1.Brine_Inlet_Port) annotation (Line(
            points={{-310,20},{-310,-48},{-328,-48}}, color={0,127,255}));
      connect(effect1.Tube_Outlet, Water_Outlet) annotation (Line(points={{
              -327.4,-60},{-324,-60},{-324,-92},{-550,-92},{-550,-40},{-558,-40}},
            color={0,127,255}));
      connect(effect1.Tube_Inlet, Steam_Input) annotation (Line(points={{-387.4,
              -60},{-540,-60},{-540,40},{-558,40}}, color={0,127,255}));
      connect(sensorBus.T1, temperature1.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-347,50},{-347,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T2, temperature2.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-251,50},{-251,14}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T3, temperature3.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-147,50},{-147,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T4, temperature4.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-47,50},{-47,14}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T5, temperature5.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{61,50},{61,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T6, temperature6.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{156,50},{156,12},{155,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV1_opening, CV1.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-200,-114},{-200,-98},{
              -216,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV2_opening, CV2.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-106,-114},{-106,-98},{
              -118,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV3_opening, CV3.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-8,-114},{-8,-100},{-18,
              -100}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV4_opening, CV4.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{96,-114},{96,-98},{82,
              -98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV5_opening, CV5.opening) annotation (Line(
          points={{30.1,100.1},{226,100.1},{226,100},{422,100},{422,-114},{200,
              -114},{200,-96},{182,-96}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(CV1.port_b, Condensate_Oulet) annotation (Line(points={{-224,-108},
              {-224,-140},{-558,-140}}, color={0,127,255}));
      connect(CV2.port_b, Condensate_Oulet) annotation (Line(points={{-126,-108},
              {-126,-140},{-558,-140}}, color={0,127,255}));
      connect(CV3.port_b, Condensate_Oulet) annotation (Line(points={{-26,-110},
              {-26,-140},{-558,-140}}, color={0,127,255}));
      connect(CV4.port_b, Condensate_Oulet) annotation (Line(points={{74,-108},
              {74,-140},{-558,-140}}, color={0,127,255}));
      connect(CV5.port_b, Condensate_Oulet) annotation (Line(points={{174,-106},
              {174,-140},{-558,-140}}, color={0,127,255}));
      connect(effect2.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-288,-48},{-288,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect6.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{114,-48},{114,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect5.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{14,-48},{14,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect4.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-84,-48},{-84,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect3.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-184,-46},{-184,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect1.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-388,-48},{-388,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(BrineFCV6.port_a, FCV5.port_a)
        annotation (Line(points={{190,40},{90,40}}, color={0,127,255}));
      connect(FCV5.port_a, BrineFCV4.port_a)
        annotation (Line(points={{90,40},{-10,40}}, color={0,127,255}));
      connect(BrineFCV4.port_a, BrineFCV3.port_a)
        annotation (Line(points={{-10,40},{-110,40}}, color={0,127,255}));
      connect(BrineFCV3.port_a, BrineFCV2.port_a)
        annotation (Line(points={{-110,40},{-210,40}}, color={0,127,255}));
      connect(BrineFCV2.port_a, BrineFCV1.port_a)
        annotation (Line(points={{-210,40},{-310,40}}, color={0,127,255}));
      connect(CV6.port_b, Condensate_Oulet) annotation (Line(points={{446,-110},{446,
              -140},{-558,-140}},                            color={0,127,255}));
      connect(preHeater.port_b1,CV6. port_a) annotation (Line(points={{480.1,
              20.2},{480,20.2},{480,-30},{446,-30},{446,-90}}, color={0,127,255}));
      connect(preHeater.port_a2, Saltwater_Input)
        annotation (Line(points={{500.2,40},{560,40}}, color={0,127,255}));
      connect(effect6.Steam_Outlet_Port, preHeater.port_a1) annotation (Line(
            points={{144,-18},{144,-12},{444,-12},{444,72},{480,72},{480,60}},
            color={0,127,255}));
      connect(preHeater.port_b2, BrineFCV6.port_a) annotation (Line(points={{
              460,40},{208,40},{208,48},{190,48},{190,40}}, color={0,127,255}));
      connect(actuatorBus.CV6_opening, CV6.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-32},{464,-32},{464,-100},{454,
              -100}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      annotation (                                                   Diagram(
            coordinateSystem(preserveAspectRatio=false)), Icon(graphics={Text(
              extent={{-38,74},{38,42}},
              textColor={0,0,0},
              textString="%name
"), Bitmap(extent={{-90,-82},{90,58}}, fileName=
                  "modelica://NHES/Resources/Images/Desalination/MEE_Icon.png")}));
    end MEE_PF6;

    model MEE_PF3
        extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Dummy CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare Data.MEE_Data data);

      Single_Effect.Brine_Models.Single_Effect effect1(
        Tsys=data.T1 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax1,
        Do(displayUnit="m"),
        pT=data.PS)
        annotation (Placement(transformation(extent={{-388,-78},{-328,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect2(
        Tsys=data.T2 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax2,
        pT=95000)
        annotation (Placement(transformation(extent={{-288,-78},{-228,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect3(
        Tsys=data.T3 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax3,
        pT=90000)
        annotation (Placement(transformation(extent={{-184,-76},{-124,-16}})));
      TRANSFORM.Fluid.Valves.ValveLinear CV1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-224,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=10000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-126,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=1000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={446,-100})));
      Modelica.Blocks.Sources.RealExpression T1_set(y=data.T1)
        annotation (Placement(transformation(extent={{-266,126},{-246,146}})));
      Modelica.Blocks.Sources.RealExpression T2_set(y=data.T2)
        annotation (Placement(transformation(extent={{-266,106},{-246,126}})));
      Modelica.Blocks.Sources.RealExpression T8_set(y=data.T8)
        annotation (Placement(transformation(extent={{-226,66},{-206,86}})));
      Modelica.Blocks.Sources.RealExpression T3_set(y=data.T3)
        annotation (Placement(transformation(extent={{-266,86},{-246,106}})));
      Modelica.Blocks.Sources.RealExpression T4_set(y=data.T4)
        annotation (Placement(transformation(extent={{-266,66},{-246,86}})));
      Modelica.Blocks.Sources.RealExpression T5_set(y=data.T5)
        annotation (Placement(transformation(extent={{-226,126},{-206,146}})));
      Modelica.Blocks.Sources.RealExpression T6_set(y=data.T6)
        annotation (Placement(transformation(extent={{-226,106},{-206,126}})));
      Modelica.Blocks.Sources.RealExpression T7_set(y=data.T7)
        annotation (Placement(transformation(extent={{-226,86},{-206,106}})));
      Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-364,6},{-344,26}})));
      Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-268,4},{-248,24}})));
      Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-164,6},{-144,26}})));
      Fluid.Valves.FCV BrineFCV1(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m1,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-310,30})));

      Fluid.Valves.FCV BrineFCV2(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m2,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-210,30})));

      Fluid.Valves.FCV BrineFCV3(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m3,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-110,30})));

      Components.PreHeater preHeater(redeclare package Medium_1 =
            Modelica.Media.Water.StandardWater, redeclare package Medium_2 =
            NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
        annotation (Placement(transformation(extent={{460,20},{500,60}})));
    equation
      connect(effect1.Steam_Outlet_Port,effect2. Tube_Inlet) annotation (Line(
            points={{-358,-18},{-358,-12},{-296,-12},{-296,-60},{-287.4,-60}},
            color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,effect3. Tube_Inlet) annotation (Line(
            points={{-258,-18},{-258,-12},{-196,-12},{-196,-58},{-183.4,-58}},
            color={0,127,255}));
      connect(effect2.Tube_Outlet,CV1. port_a) annotation (Line(points={{-227.4,
              -60},{-224,-60},{-224,-88}}, color={0,127,255}));
      connect(CV2.port_a,effect3. Tube_Outlet) annotation (Line(points={{-126,
              -88},{-126,-58},{-123.4,-58}}, color={0,127,255}));
      connect(effect1.Steam_Outlet_Port,temperature1. port)
        annotation (Line(points={{-358,-18},{-358,-6},{-354,-6},{-354,6}},
                                                       color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,temperature2. port) annotation (Line(
            points={{-258,-18},{-258,4}},                     color={0,127,255}));
      connect(effect3.Steam_Outlet_Port,temperature3. port) annotation (Line(
            points={{-154,-16},{-154,6}},                     color={0,127,255}));
      connect(sensorBus.T1set, T1_set.y) annotation (Line(
          points={{-29.9,100.1},{-112,100.1},{-112,100},{-196,100},{-196,60},{
              -240,60},{-240,136},{-245,136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T2set, T2_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,116},{
              -245,116}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T4set, T4_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,76},{
              -245,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T5set, T5_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,136},{-205,136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T6set, T6_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,116},{-205,116}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T8set, T8_set.y) annotation (Line(
          points={{-29.9,100.1},{-29.9,100},{-196,100},{-196,76},{-205,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T3set, T3_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,60},{-240,60},{-240,96},{
              -245,96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T7set, T7_set.y) annotation (Line(
          points={{-29.9,100.1},{-196,100.1},{-196,96},{-205,96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(BrineFCV3.port_b, effect3.Brine_Inlet_Port) annotation (Line(
            points={{-110,20},{-110,-46},{-124,-46}}, color={0,127,255}));
      connect(BrineFCV2.port_b, effect2.Brine_Inlet_Port) annotation (Line(
            points={{-210,20},{-210,-48},{-228,-48}}, color={0,127,255}));
      connect(BrineFCV1.port_b, effect1.Brine_Inlet_Port) annotation (Line(
            points={{-310,20},{-310,-48},{-328,-48}}, color={0,127,255}));
      connect(effect1.Tube_Outlet, Water_Outlet) annotation (Line(points={{
              -327.4,-60},{-324,-60},{-324,-92},{-550,-92},{-550,-40},{-558,-40}},
            color={0,127,255}));
      connect(effect1.Tube_Inlet, Steam_Input) annotation (Line(points={{-387.4,
              -60},{-540,-60},{-540,40},{-558,40}}, color={0,127,255}));
      connect(sensorBus.T1, temperature1.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-347,50},{-347,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T2, temperature2.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-251,50},{-251,14}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T3, temperature3.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,50},{-147,50},{-147,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV1_opening, CV1.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-200,-114},{-200,-98},{
              -216,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV2_opening, CV2.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-106,-114},{-106,-98},{
              -118,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(CV1.port_b, Condensate_Oulet) annotation (Line(points={{-224,-108},
              {-224,-140},{-558,-140}}, color={0,127,255}));
      connect(CV2.port_b, Condensate_Oulet) annotation (Line(points={{-126,-108},
              {-126,-140},{-558,-140}}, color={0,127,255}));
      connect(effect2.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-288,-48},{-288,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect3.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-184,-46},{-184,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect1.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-388,-48},{-388,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(BrineFCV3.port_a, BrineFCV2.port_a)
        annotation (Line(points={{-110,40},{-210,40}}, color={0,127,255}));
      connect(BrineFCV2.port_a, BrineFCV1.port_a)
        annotation (Line(points={{-210,40},{-310,40}}, color={0,127,255}));
      connect(CV3.port_b, Condensate_Oulet) annotation (Line(points={{446,-110},
              {446,-140},{-558,-140}}, color={0,127,255}));
      connect(preHeater.port_b1, CV3.port_a) annotation (Line(points={{480.1,
              20.2},{480,20.2},{480,-30},{446,-30},{446,-90}}, color={0,127,255}));
      connect(preHeater.port_a2, Saltwater_Input)
        annotation (Line(points={{500.2,40},{560,40}}, color={0,127,255}));
      connect(effect3.Steam_Outlet_Port, preHeater.port_a1) annotation (Line(
            points={{-154,-16},{-154,-4},{444,-4},{444,72},{480,72},{480,60}},
            color={0,127,255}));
      connect(preHeater.port_b2, BrineFCV3.port_a) annotation (Line(points={{
              460,40},{-32,40},{-32,52},{-110,52},{-110,40}}, color={0,127,255}));
      connect(actuatorBus.CV3_opening, CV3.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-58},{476,-58},{476,-100},{454,
              -100}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (                                                   Diagram(
            coordinateSystem(preserveAspectRatio=false)), Icon(graphics={Text(
              extent={{-38,74},{38,42}},
              textColor={0,0,0},
              textString="%name
"), Bitmap(extent={{-90,-82},{90,58}}, fileName=
                  "modelica://NHES/Resources/Images/Desalination/MEE_Icon.png")}));
    end MEE_PF3;

    model MEETVC7
      extends NHES.Desalination.MEE.BaseClasses.Partial_SubSystem_A(
        redeclare replaceable NHES.Desalination.MEE.ControlSystems.CS_Dummy CS,
        redeclare replaceable NHES.Desalination.MEE.ControlSystems.ED_Dummy ED,
        redeclare NHES.Desalination.MEE.Data.MEE7_Data data);

      NHES.Desalination.MEE.Single_Effect.Brine_Models.Single_Effect effect1(
        Tsys=data.T1 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax1,
        Do(displayUnit="m"),
        pT=data.PS)
        annotation (Placement(transformation(extent={{-386,-80},{-326,-20}})));
      NHES.Desalination.MEE.Single_Effect.Brine_Models.Single_Effect_Flashing effect2(
        Tsys=data.T2 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax2,
        pT=95000)
        annotation (Placement(transformation(extent={{-288,-78},{-228,-18}})));
      NHES.Desalination.MEE.Single_Effect.Brine_Models.Single_Effect_Flashing effect3(
        Tsys=data.T3 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax3,
        pT=90000)
        annotation (Placement(transformation(extent={{-184,-76},{-124,-16}})));
      NHES.Desalination.MEE.Single_Effect.Brine_Models.Single_Effect_Flashing effect4(
        Tsys=data.T4 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax4,
        pT=85000)
        annotation (Placement(transformation(extent={{-84,-78},{-24,-18}})));
      NHES.Desalination.MEE.Single_Effect.Brine_Models.Single_Effect_Flashing effect5(
        Tsys=data.T5 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax5,
        pT=80000) annotation (Placement(transformation(extent={{12,-76},{72,-16}})));
      NHES.Desalination.MEE.Single_Effect.Brine_Models.Single_Effect_Flashing effect6(
        Tsys=data.T6 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax6,
        pT=75000)
        annotation (Placement(transformation(extent={{114,-78},{174,-18}})));
      NHES.Desalination.MEE.Single_Effect.Brine_Models.Single_Effect_Flashing effect7(
        Tsys=data.T7 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax7,
        pT=70000)
        annotation (Placement(transformation(extent={{212,-76},{272,-16}})));
      TRANSFORM.Fluid.Valves.ValveLinear CV1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-224,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=10000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-126,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-26,-100})));
      TRANSFORM.Fluid.Valves.ValveLinear CV4(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={74,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV5(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={174,-96})));
      TRANSFORM.Fluid.Valves.ValveLinear CV6(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={274,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV7(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=1000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={350,-98})));
      Modelica.Blocks.Sources.RealExpression T1_set(y=data.T1)
        annotation (Placement(transformation(extent={{-176,162},{-156,182}})));
      Modelica.Blocks.Sources.RealExpression T2_set(y=data.T2)
        annotation (Placement(transformation(extent={{-176,152},{-156,172}})));
      Modelica.Blocks.Sources.RealExpression T3_set(y=data.T3)
        annotation (Placement(transformation(extent={{-176,142},{-156,162}})));
      Modelica.Blocks.Sources.RealExpression T4_set(y=data.T4)
        annotation (Placement(transformation(extent={{-176,132},{-156,152}})));
      Modelica.Blocks.Sources.RealExpression T5_set(y=data.T5)
        annotation (Placement(transformation(extent={{-136,162},{-116,182}})));
      Modelica.Blocks.Sources.RealExpression T6_set(y=data.T6)
        annotation (Placement(transformation(extent={{-136,152},{-116,172}})));
      Modelica.Blocks.Sources.RealExpression T7_set(y=data.T7)
        annotation (Placement(transformation(extent={{-136,142},{-116,162}})));
      Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-364,6},{-344,26}})));
      Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-268,4},{-248,24}})));
      Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-164,6},{-144,26}})));
      Modelica.Fluid.Sensors.Temperature temperature4(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-64,4},{-44,24}})));
      Modelica.Fluid.Sensors.Temperature temperature5(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{44,2},{64,22}})));
      Modelica.Fluid.Sensors.Temperature temperature6(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{138,2},{158,22}})));
      Modelica.Fluid.Sensors.Temperature temperature7(redeclare package Medium
          = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{232,2},{252,22}})));
      NHES.Fluid.Valves.FCV BrineFCV1(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=
                Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m1,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-310,30})));

      NHES.Fluid.Valves.FCV BrineFCV2(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=
                Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m2,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-210,28})));

      NHES.Fluid.Valves.FCV BrineFCV3(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=
                Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m3,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-110,30})));

      NHES.Fluid.Valves.FCV BrineFCV4(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=
                Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m4,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-10,30})));

      NHES.Fluid.Valves.FCV FCV5(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=
                Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m5,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,30})));

      NHES.Fluid.Valves.FCV BrineFCV6(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=
                Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m6,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={190,30})));

      NHES.Fluid.Valves.FCV BrineFCV7(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=
                Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m7,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={290,30})));

      NHES.Desalination.MEE.Components.PreHeater preHeater(redeclare package
          Medium_1 = Modelica.Media.Water.StandardWater, redeclare package
          Medium_2 =
            NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
        annotation (Placement(transformation(extent={{330,-66},{370,-26}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure1
        annotation (Placement(transformation(extent={{-392,22},{-372,42}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure2
        annotation (Placement(transformation(extent={{-284,-4},{-264,16}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure3
        annotation (Placement(transformation(extent={{-182,12},{-162,32}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure4
        annotation (Placement(transformation(extent={{-78,-4},{-58,16}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure5
        annotation (Placement(transformation(extent={{6,-4},{26,16}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure6
        annotation (Placement(transformation(extent={{116,2},{136,22}})));
      TRANSFORM.Fluid.Sensors.Pressure pressure7
        annotation (Placement(transformation(extent={{208,-2},{228,18}})));
      Modelica.Blocks.Sources.RealExpression P1_set(y=data.P1)
        annotation (Placement(transformation(extent={{-256,162},{-236,182}})));
      Modelica.Blocks.Sources.RealExpression P2_set(y=data.P2)
        annotation (Placement(transformation(extent={{-256,152},{-236,172}})));
      Modelica.Blocks.Sources.RealExpression P3_set(y=data.P3)
        annotation (Placement(transformation(extent={{-256,142},{-236,162}})));
      Modelica.Blocks.Sources.RealExpression P4_set(y=data.P4)
        annotation (Placement(transformation(extent={{-256,132},{-236,152}})));
      Modelica.Blocks.Sources.RealExpression P5_set(y=data.P5)
        annotation (Placement(transformation(extent={{-216,162},{-196,182}})));
      Modelica.Blocks.Sources.RealExpression P6_set(y=data.P6)
        annotation (Placement(transformation(extent={{-216,152},{-196,172}})));
      Modelica.Blocks.Sources.RealExpression P7_set(y=data.P7)
        annotation (Placement(transformation(extent={{-216,142},{-196,162}})));
      NHES.Desalination.MEE.Components.TCV TVC(Pe=10000)
        annotation (Placement(transformation(extent={{-20,56},{52,80}})));
      Modelica.Blocks.Sources.RealExpression MP_set(y=data.MP)
        annotation (Placement(transformation(extent={{-216,132},{-196,152}})));
      TRANSFORM.Fluid.Valves.ValveLinear CVM(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-318,-98})));
      NHES.Desalination.MEE.Components.TCV tCV1(
        Pp(start=100000),
        Pe=10000,
        Pc(start=80000))
        annotation (Placement(transformation(extent={{416,46},{368,62}})));
      TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=10000,
        m_flow_nominal=1)
        annotation (Placement(transformation(extent={{326,28},{346,48}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow
        annotation (Placement(transformation(extent={{-244,68},{-224,88}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1
        annotation (Placement(transformation(extent={{190,60},{170,80}})));
      TRANSFORM.Fluid.Sensors.Pressure sensor_p
        annotation (Placement(transformation(extent={{-296,-76},{-316,-56}})));
      TRANSFORM.Fluid.Valves.ValveLinear valveLinear1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=10000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={42,18})));
      Modelica.Blocks.Sources.RealExpression nM_set(y=data.mM)
        annotation (Placement(transformation(extent={{-136,132},{-116,152}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate mE
        annotation (Placement(transformation(extent={{472,48},{452,68}})));
    equation
      connect(effect1.Steam_Outlet_Port,effect2. Tube_Inlet) annotation (Line(
            points={{-356,-20},{-356,-12},{-296,-12},{-296,-60},{-287.4,-60}},
            color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,effect3. Tube_Inlet) annotation (Line(
            points={{-258,-18},{-258,-12},{-196,-12},{-196,-58},{-183.4,-58}},
            color={0,127,255}));
      connect(effect3.Steam_Outlet_Port,effect4. Tube_Inlet) annotation (Line(
            points={{-154,-16},{-154,-10},{-96,-10},{-96,-60},{-83.4,-60}},
                                                               color={0,127,255}));
      connect(effect4.Steam_Outlet_Port,effect5. Tube_Inlet) annotation (Line(
            points={{-54,-18},{-54,-10},{0,-10},{0,-58},{12.6,-58}},
                     color={0,127,255}));
      connect(effect5.Steam_Outlet_Port,effect6. Tube_Inlet) annotation (Line(
            points={{42,-16},{42,-12},{96,-12},{96,-60},{114.6,-60}},
                     color={0,127,255}));
      connect(effect6.Steam_Outlet_Port,effect7. Tube_Inlet) annotation (Line(
            points={{144,-18},{144,-12},{204,-12},{204,-58},{212.6,-58}},
                                                                       color={0,
              127,255}));
      connect(effect2.Tube_Outlet,CV1. port_a) annotation (Line(points={{-227.4,
              -60},{-224,-60},{-224,-88}}, color={0,127,255}));
      connect(CV6.port_a,effect7. Tube_Outlet) annotation (Line(points={{274,-88},
              {274,-58},{272.6,-58}},      color={0,127,255}));
      connect(CV5.port_a,effect6. Tube_Outlet) annotation (Line(points={{174,-86},
              {174,-60},{174.6,-60}},      color={0,127,255}));
      connect(CV4.port_a,effect5. Tube_Outlet) annotation (Line(points={{74,-88},
              {74,-58},{72.6,-58}},          color={0,127,255}));
      connect(CV3.port_a,effect4. Tube_Outlet) annotation (Line(points={{-26,-90},
              {-26,-60},{-23.4,-60}},      color={0,127,255}));
      connect(CV2.port_a,effect3. Tube_Outlet) annotation (Line(points={{-126,
              -88},{-126,-58},{-123.4,-58}}, color={0,127,255}));
      connect(effect1.Steam_Outlet_Port,temperature1. port)
        annotation (Line(points={{-356,-20},{-356,-6},{-354,-6},{-354,6}},
                                                       color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,temperature2. port) annotation (Line(
            points={{-258,-18},{-258,4}},                     color={0,127,255}));
      connect(effect3.Steam_Outlet_Port,temperature3. port) annotation (Line(
            points={{-154,-16},{-154,6}},                     color={0,127,255}));
      connect(effect4.Steam_Outlet_Port,temperature4. port)
        annotation (Line(points={{-54,-18},{-54,4}}, color={0,127,255}));
      connect(effect5.Steam_Outlet_Port,temperature5. port) annotation (Line(
            points={{42,-16},{42,-12},{70,-12},{70,-2}},
                                                      color={0,127,255}));
      connect(effect6.Steam_Outlet_Port,temperature6. port) annotation (Line(
            points={{144,-18},{144,-4},{148,-4},{148,2}}, color={0,127,255}));
      connect(effect7.Steam_Outlet_Port,temperature7. port)
        annotation (Line(points={{242,-16},{242,2}}, color={0,127,255}));
      connect(sensorBus.T1set, T1_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-150,180},{-150,172},{
              -155,172}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T2set, T2_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-150,180},{-150,162},{
              -155,162}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T4set, T4_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-150,180},{-150,142},{
              -155,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T5set, T5_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-106,180},{-106,172},{
              -115,172}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T6set, T6_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-106,180},{-106,162},{
              -115,162}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T3set, T3_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-150,180},{-150,152},{
              -155,152}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T7set, T7_set.y) annotation (Line(
          points={{-29.9,100.1},{-29.9,104},{-30,104},{-30,180},{-106,180},{
              -106,152},{-115,152}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(BrineFCV7.port_b, effect7.Brine_Inlet_Port) annotation (Line(
            points={{290,20},{288,20},{288,-46},{272,-46}}, color={0,127,255}));
      connect(BrineFCV6.port_b, effect6.Brine_Inlet_Port) annotation (Line(
            points={{190,20},{188,20},{188,-48},{174,-48}}, color={0,127,255}));
      connect(FCV5.port_b, effect5.Brine_Inlet_Port) annotation (Line(points={{90,20},
              {88,20},{88,-46},{72,-46}},        color={0,127,255}));
      connect(BrineFCV4.port_b, effect4.Brine_Inlet_Port) annotation (Line(
            points={{-10,20},{-10,-48},{-24,-48}}, color={0,127,255}));
      connect(BrineFCV3.port_b, effect3.Brine_Inlet_Port) annotation (Line(
            points={{-110,20},{-110,-46},{-124,-46}}, color={0,127,255}));
      connect(BrineFCV2.port_b, effect2.Brine_Inlet_Port) annotation (Line(
            points={{-210,18},{-210,-48},{-228,-48}}, color={0,127,255}));
      connect(BrineFCV1.port_b, effect1.Brine_Inlet_Port) annotation (Line(
            points={{-310,20},{-310,-50},{-326,-50}}, color={0,127,255}));
      connect(sensorBus.T1, temperature1.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,100},{-30,100},{-30,52},{-347,52},{-347,
              16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T2, temperature2.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,102},{-30,102},{-30,52},{-251,52},{-251,
              14}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T3, temperature3.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,98},{-30,98},{-30,52},{-147,52},{-147,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T4, temperature4.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,100},{-30,100},{-30,52},{-47,52},{-47,14}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T5, temperature5.T) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,52},{62,52},{62,8},{63,8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T6, temperature6.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,52},{156,52},{156,12},{155,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T7, temperature7.T) annotation (Line(
          points={{-29.9,100.1},{-29.9,52},{250,52},{250,32},{249,32},{249,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV1_opening, CV1.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-200,-114},{-200,-98},{
              -216,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV2_opening, CV2.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-106,-114},{-106,-98},{
              -118,-98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV3_opening, CV3.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{-8,-114},{-8,-100},{-18,
              -100}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV4_opening, CV4.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{96,-114},{96,-98},{82,
              -98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV5_opening, CV5.opening) annotation (Line(
          points={{30.1,100.1},{30,100.1},{30,100},{422,100},{422,-114},{200,
              -114},{200,-96},{182,-96}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV6_opening, CV6.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{296,-114},{296,-98},{282,
              -98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(CV1.port_b, Condensate_Oulet) annotation (Line(points={{-224,-108},
              {-224,-140},{-558,-140}}, color={0,127,255}));
      connect(CV2.port_b, Condensate_Oulet) annotation (Line(points={{-126,-108},
              {-126,-140},{-558,-140}}, color={0,127,255}));
      connect(CV3.port_b, Condensate_Oulet) annotation (Line(points={{-26,-110},
              {-26,-140},{-558,-140}}, color={0,127,255}));
      connect(CV4.port_b, Condensate_Oulet) annotation (Line(points={{74,-108},
              {74,-140},{-558,-140}}, color={0,127,255}));
      connect(CV5.port_b, Condensate_Oulet) annotation (Line(points={{174,-106},
              {174,-140},{-558,-140}}, color={0,127,255}));
      connect(CV6.port_b, Condensate_Oulet) annotation (Line(points={{274,-108},
              {274,-140},{-558,-140}}, color={0,127,255}));
      connect(BrineFCV6.port_a, FCV5.port_a)
        annotation (Line(points={{190,40},{90,40}}, color={0,127,255}));
      connect(BrineFCV4.port_a, BrineFCV3.port_a)
        annotation (Line(points={{-10,40},{-110,40}}, color={0,127,255}));
      connect(BrineFCV3.port_a, BrineFCV2.port_a)
        annotation (Line(points={{-110,40},{-160,40},{-160,38},{-210,38}},
                                                       color={0,127,255}));
      connect(BrineFCV2.port_a, BrineFCV1.port_a)
        annotation (Line(points={{-210,38},{-260,38},{-260,40},{-310,40}},
                                                       color={0,127,255}));
      connect(CV7.port_b, Condensate_Oulet) annotation (Line(points={{350,-108},
              {348,-108},{348,-140},{-558,-140}}, color={0,127,255}));
      connect(preHeater.port_b1, CV7.port_a) annotation (Line(points={{350.1,
              -65.8},{350.1,-76.9},{350,-76.9},{350,-88}}, color={0,127,255}));
      connect(pressure1.port, effect1.Steam_Outlet_Port) annotation (Line(
            points={{-382,22},{-382,-4},{-356,-4},{-356,-20}}, color={0,127,255}));
      connect(pressure2.port, effect2.Steam_Outlet_Port) annotation (Line(
            points={{-274,-4},{-274,-18},{-258,-18}}, color={0,127,255}));
      connect(pressure3.port, effect3.Steam_Outlet_Port) annotation (Line(
            points={{-172,12},{-172,-4},{-154,-4},{-154,-16}}, color={0,127,255}));
      connect(pressure4.port, effect4.Steam_Outlet_Port) annotation (Line(
            points={{-68,-4},{-68,-18},{-54,-18}}, color={0,127,255}));
      connect(pressure5.port, effect5.Steam_Outlet_Port) annotation (Line(
            points={{16,-4},{16,-16},{42,-16}}, color={0,127,255}));
      connect(pressure6.port, effect6.Steam_Outlet_Port) annotation (Line(
            points={{126,2},{126,-4},{144,-4},{144,-18}}, color={0,127,255}));
      connect(pressure7.port, effect7.Steam_Outlet_Port) annotation (Line(
            points={{218,-2},{228,-2},{228,-16},{242,-16}}, color={0,127,255}));
      connect(sensorBus.p1set, P1_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-222,180},{-222,172},{
              -235,172}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p2set, P2_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-222,180},{-222,162},{
              -235,162}},
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      annotation (                                                   Diagram(
            coordinateSystem(preserveAspectRatio=false)), Icon(graphics={Text(
              extent={{-38,74},{38,42}},
              textColor={0,0,0},
              textString="%name
"), Bitmap(extent={{-90,-82},{90,58}}, fileName=
                  "modelica://NHES/Resources/Images/Desalination/MEE_Icon.png")}));
    end MEE_PF6;

    model MEE_PF3
        extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Dummy CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare Data.MEE_Data data);

      Single_Effect.Brine_Models.Single_Effect effect1(
        Tsys=data.T1 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax1,
        Do(displayUnit="m"),
        pT=data.PS)
        annotation (Placement(transformation(extent={{-388,-78},{-328,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect2(
        Tsys=data.T2 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax2,
        pT=95000)
        annotation (Placement(transformation(extent={{-288,-78},{-228,-18}})));
      Single_Effect.Brine_Models.Single_Effect effect3(
        Tsys=data.T3 + 5,
        V=0.5,
        A=1,
        KV=-0.35,
        Ax=data.Ax3,
        pT=90000)
        annotation (Placement(transformation(extent={{-184,-76},{-124,-16}})));
      TRANSFORM.Fluid.Valves.ValveLinear CV1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=3000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-224,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=10000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-126,-98})));
      TRANSFORM.Fluid.Valves.ValveLinear CV3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=1000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={446,-100})));
      Modelica.Blocks.Sources.RealExpression T1_set(y=data.T1)
        annotation (Placement(transformation(extent={{-266,126},{-246,146}})));
      Modelica.Blocks.Sources.RealExpression T2_set(y=data.T2)
        annotation (Placement(transformation(extent={{-266,106},{-246,126}})));
      Modelica.Blocks.Sources.RealExpression T8_set(y=data.T8)
        annotation (Placement(transformation(extent={{-226,66},{-206,86}})));
      Modelica.Blocks.Sources.RealExpression T3_set(y=data.T3)
        annotation (Placement(transformation(extent={{-266,86},{-246,106}})));
      Modelica.Blocks.Sources.RealExpression T4_set(y=data.T4)
        annotation (Placement(transformation(extent={{-266,66},{-246,86}})));
      Modelica.Blocks.Sources.RealExpression T5_set(y=data.T5)
        annotation (Placement(transformation(extent={{-226,126},{-206,146}})));
      Modelica.Blocks.Sources.RealExpression T6_set(y=data.T6)
        annotation (Placement(transformation(extent={{-226,106},{-206,126}})));
      Modelica.Blocks.Sources.RealExpression T7_set(y=data.T7)
        annotation (Placement(transformation(extent={{-226,86},{-206,106}})));
      Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-364,6},{-344,26}})));
      Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-268,4},{-248,24}})));
      Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-164,6},{-144,26}})));
      Fluid.Valves.FCV BrineFCV1(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m1,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-310,30})));

      Fluid.Valves.FCV BrineFCV2(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m2,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-210,30})));

      Fluid.Valves.FCV BrineFCV3(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        m_target=data.m3,
        dp_nom=1000) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-110,30})));

      Components.PreHeater preHeater(redeclare package Medium_1 =
            Modelica.Media.Water.StandardWater, redeclare package Medium_2 =
            NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
        annotation (Placement(transformation(extent={{458,6},{498,46}})));
    equation
      connect(effect1.Steam_Outlet_Port,effect2. Tube_Inlet) annotation (Line(
            points={{-358,-18},{-358,-12},{-296,-12},{-296,-60},{-287.4,-60}},
            color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,effect3. Tube_Inlet) annotation (Line(
            points={{-258,-18},{-258,-12},{-196,-12},{-196,-58},{-183.4,-58}},
            color={0,127,255}));
      connect(effect2.Tube_Outlet,CV1. port_a) annotation (Line(points={{-227.4,
              -60},{-224,-60},{-224,-88}}, color={0,127,255}));
      connect(CV2.port_a,effect3. Tube_Outlet) annotation (Line(points={{-126,
              -88},{-126,-58},{-123.4,-58}}, color={0,127,255}));
      connect(effect1.Steam_Outlet_Port,temperature1. port)
        annotation (Line(points={{-358,-18},{-358,-6},{-354,-6},{-354,6}},
                                                       color={0,127,255}));
      connect(effect2.Steam_Outlet_Port,temperature2. port) annotation (Line(
            points={{-258,-18},{-258,4}},                     color={0,127,255}));
      connect(effect3.Steam_Outlet_Port,temperature3. port) annotation (Line(
            points={{-154,-16},{-154,6}},                     color={0,127,255}));
      connect(sensorBus.T1set, T1_set.y) annotation (Line(
          points={{-29.9,100.1},{-112,100.1},{-112,100},{-196,100},{-196,60},{
              -240,60},{-240,136},{-245,136}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p3set, P3_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-222,180},{-222,152},{
              -235,152}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p4set, P4_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-222,180},{-222,142},{
              -235,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p5set, P5_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-182,180},{-182,172},{
              -195,172}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p6set, P6_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-182,180},{-182,162},{
              -195,162}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p7set, P7_set.y) annotation (Line(
          points={{-29.9,100.1},{-30,100.1},{-30,180},{-182,180},{-182,152},{
              -195,152}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p1, pressure1.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,100},{-30,100},{-30,52},{-360,52},{-360,
              32},{-376,32}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p2, pressure2.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,96},{-30,96},{-30,52},{-268,52},{-268,6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p3, pressure3.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,100},{-30,100},{-30,52},{-166,52},{-166,
              22}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p4, pressure4.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,98},{-30,98},{-30,52},{-60,52},{-60,6},{
              -62,6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p5, pressure5.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,100},{-30,100},{-30,52},{22,52},{22,6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p6, pressure6.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,52},{132,52},{132,12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p7, pressure7.p) annotation (Line(
          points={{-29.9,100.1},{-29.9,52},{224,52},{224,8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV7_opening, CV7.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-114},{368,-114},{368,-98},{358,
              -98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(effect7.Steam_Outlet_Port, preHeater.port_a1) annotation (Line(
            points={{242,-16},{240,-16},{240,-8},{260,-8},{260,-4},{350,-4},{
              350,-26}}, color={0,127,255}));
      connect(sensorBus.MPset, MP_set.y) annotation (Line(
          points={{-30,100},{-30,180},{-182,180},{-182,142},{-195,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(effect1.Tube_Outlet, CVM.port_a) annotation (Line(points={{-325.4,
              -62},{-318,-62},{-318,-88}}, color={0,127,255}));
      connect(CVM.port_b, Condensate_Oulet) annotation (Line(points={{-318,-108},
              {-318,-140},{-558,-140}}, color={0,127,255}));
      connect(actuatorBus.MCV_opening, CVM.opening) annotation (Line(
          points={{30,100},{422,100},{422,-112},{-294,-112},{-294,-98},{-310,
              -98}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(effect1.Brine_Outlet_Port, effect2.BrineCon_Inlet_Port)
        annotation (Line(points={{-386,-50},{-392,-50},{-392,-84},{-258,-84},{
              -258,-78}}, color={0,127,255}));
      connect(effect2.Brine_Outlet_Port, effect3.BrineCon_Inlet_Port)
        annotation (Line(points={{-288,-48},{-288,-86},{-154,-86},{-154,-76}},
            color={0,127,255}));
      connect(effect3.Brine_Outlet_Port, effect4.BrineCon_Inlet_Port)
        annotation (Line(points={{-184,-46},{-184,-84},{-54,-84},{-54,-78}},
            color={0,127,255}));
      connect(effect4.Brine_Outlet_Port, effect5.BrineCon_Inlet_Port)
        annotation (Line(points={{-84,-48},{-86,-48},{-86,-86},{42,-86},{42,-76}},
            color={0,127,255}));
      connect(effect5.Brine_Outlet_Port, effect6.BrineCon_Inlet_Port)
        annotation (Line(points={{12,-46},{12,-84},{144,-84},{144,-78}}, color=
              {0,127,255}));
      connect(effect6.Brine_Outlet_Port, effect7.BrineCon_Inlet_Port)
        annotation (Line(points={{114,-48},{114,-86},{242,-86},{242,-76}},
            color={0,127,255}));
      connect(Steam_Input, tCV1.primarysteam) annotation (Line(points={{-558,40},
              {-558,116},{412,116},{412,70},{352,70},{352,54},{368,54}},color={
              0,127,255}));
      connect(valveLinear.port_b, tCV1.secondarysteam) annotation (Line(points={{346,38},
              {360,38},{360,46},{374.667,46}},           color={0,127,255}));
      connect(effect7.Steam_Outlet_Port, valveLinear.port_a) annotation (Line(
            points={{242,-16},{240,-16},{240,-8},{260,-8},{260,-4},{316,-4},{
              316,38},{326,38}}, color={0,127,255}));
      connect(effect6.Steam_Outlet_Port, valveLinear.port_a) annotation (Line(
            points={{144,-18},{144,-12},{232,-12},{232,-4},{240,-4},{240,-8},{
              260,-8},{260,-4},{316,-4},{316,38},{326,38}}, color={0,127,255}));
      connect(effect5.Steam_Outlet_Port, valveLinear.port_a) annotation (Line(
            points={{42,-16},{42,-12},{136,-12},{136,-4},{184,-4},{184,-12},{
              232,-12},{232,-4},{240,-4},{240,-8},{260,-8},{260,-4},{316,-4},{
              316,38},{326,38}}, color={0,127,255}));
      connect(sensor_m_flow.port_b,TVC. mixturesteam) annotation (Line(points={{-224,78},
              {-224,76},{-60,76},{-60,68.4},{-20,68.4}},           color={0,127,
              255}));
      connect(sensor_m_flow.port_a, effect1.Tube_Inlet) annotation (Line(points=
             {{-244,78},{-426,78},{-426,-62},{-385.4,-62}}, color={0,127,255}));
      connect(Steam_Input, sensor_m_flow1.port_a) annotation (Line(points={{-558,40},
              {-558,116},{412,116},{412,70},{190,70}},     color={0,127,255}));
      connect(sensor_m_flow1.port_b,TVC. primarysteam)
        annotation (Line(points={{170,70},{112,70},{112,68},{52,68}},
                                                    color={0,127,255}));
      connect(sensorBus.mTVC, sensor_m_flow.m_flow) annotation (Line(
          points={{-30,100},{-234,100},{-234,81.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(CVM.port_a, sensor_p.port) annotation (Line(points={{-318,-88},{
              -318,-76},{-306,-76}}, color={0,127,255}));
      connect(sensorBus.MP, sensor_p.p) annotation (Line(
          points={{-30,100},{-30,52},{-312,52},{-312,-66}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(valveLinear1.port_a, effect5.Steam_Outlet_Port)
        annotation (Line(points={{42,8},{42,-16}}, color={0,127,255}));
      connect(valveLinear1.port_b,TVC. secondarysteam)
        annotation (Line(points={{42,28},{42,56}}, color={0,127,255}));
      connect(actuatorBus.TCVCV_opening, valveLinear1.opening) annotation (Line(
          points={{30,100},{58,100},{58,18},{50,18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(Saltwater_Input, preHeater.port_a2) annotation (Line(points={{560,
              40},{502,40},{502,-46},{370.2,-46}}, color={0,127,255}));
      connect(BrineFCV7.port_a, BrineFCV6.port_a)
        annotation (Line(points={{290,40},{190,40}}, color={0,127,255}));
      connect(preHeater.port_b2, BrineFCV7.port_a) annotation (Line(points={{
              330,-46},{316,-46},{316,0},{308,0},{308,40},{290,40}}, color={0,
              127,255}));
      connect(FCV5.port_a, BrineFCV4.port_a)
        annotation (Line(points={{90,40},{-10,40}}, color={0,127,255}));
      connect(effect7.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{212,-46},{200,-46},{200,-70},{536,-70},{536,-40},{560,
              -40}}, color={0,127,255}));
      connect(sensorBus.mMset, nM_set.y) annotation (Line(
          points={{-30,100},{-30,180},{-106,180},{-106,142},{-115,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(tCV1.mixturesteam, mE.port_b) annotation (Line(points={{416,
              54.2667},{416,58},{452,58}}, color={0,127,255}));
      connect(mE.port_a, Water_Outlet) annotation (Line(points={{472,58},{472,
              56},{536,56},{536,-40},{-558,-40}},
                                               color={0,127,255}));
      connect(sensorBus.mE, mE.m_flow) annotation (Line(
          points={{-30,100},{462,100},{462,61.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.ECV_opening, valveLinear.opening) annotation (Line(
          points={{30,100},{336,100},{336,46}},
      connect(CV1.port_b, Condensate_Oulet) annotation (Line(points={{-224,-108},
              {-224,-140},{-558,-140}}, color={0,127,255}));
      connect(CV2.port_b, Condensate_Oulet) annotation (Line(points={{-126,-108},
              {-126,-140},{-558,-140}}, color={0,127,255}));
      connect(effect2.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-288,-48},{-288,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect3.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-184,-46},{-184,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(effect1.Brine_Outlet_Port, Saltwater_Reject_Oulet) annotation (
          Line(points={{-388,-48},{-388,-128},{530,-128},{530,-40},{560,-40}},
            color={0,127,255}));
      connect(BrineFCV3.port_a, BrineFCV2.port_a)
        annotation (Line(points={{-110,40},{-210,40}}, color={0,127,255}));
      connect(BrineFCV2.port_a, BrineFCV1.port_a)
        annotation (Line(points={{-210,40},{-310,40}}, color={0,127,255}));
      connect(CV3.port_b, Condensate_Oulet) annotation (Line(points={{446,-110},
              {446,-140},{-558,-140}}, color={0,127,255}));
      connect(preHeater.port_b1, CV3.port_a) annotation (Line(points={{478.1,
              6.2},{476,6.2},{476,-52},{446,-52},{446,-90}},   color={0,127,255}));
      connect(preHeater.port_a2, Saltwater_Input)
        annotation (Line(points={{498.2,26},{498.2,24},{536,24},{536,40},{560,
              40}},                                    color={0,127,255}));
      connect(effect3.Steam_Outlet_Port, preHeater.port_a1) annotation (Line(
            points={{-154,-16},{-154,-4},{428,-4},{428,46},{478,46}},
            color={0,127,255}));
      connect(preHeater.port_b2, BrineFCV3.port_a) annotation (Line(points={{458,26},
              {-88,26},{-88,52},{-110,52},{-110,40}},         color={0,127,255}));
      connect(actuatorBus.CV3_opening, CV3.opening) annotation (Line(
          points={{30.1,100.1},{422,100.1},{422,-58},{476,-58},{476,-100},{454,
              -100}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.mM, sensor_m_flow1.m_flow) annotation (Line(
          points={{-30,100},{76,100},{76,102},{180,102},{180,73.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      annotation (                                                   Diagram(
            coordinateSystem(preserveAspectRatio=false)), Icon(graphics={Text(
              extent={{-38,70},{38,38}},
              textColor={0,0,0},
              textString="%name
"), Bitmap(extent={{-90,-82},{90,58}}, fileName="modelica://NHES/Resources/Images/Desalination/MEE_Icon.png")}));
    end MEETVC7;
  end Multiple_Effect;

  package Data
    model MEE_Data
      extends BaseClasses.Record_Data;
      parameter Integer nE(max=16)=8   "Number of Effects";

      //Temperatures
      parameter Modelica.Units.SI.AbsolutePressure PS=1e5 "Steam Supply Pressure";
      parameter Modelica.Units.SI.Temperature T1=353 "Effect #1 Temperature"
      annotation (Dialog(tab="Temperatures"));
      parameter Modelica.Units.SI.Temperature T2=353-1*(80-55)/nE "Effect #2 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>1));
      parameter Modelica.Units.SI.Temperature T3=353-2*(80-55)/nE "Effect #3 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>2));
      parameter Modelica.Units.SI.Temperature T4=353-3*(80-55)/nE "Effect #4 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>3));
      parameter Modelica.Units.SI.Temperature T5=353-4*(80-55)/nE "Effect #5 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>4));
      parameter Modelica.Units.SI.Temperature T6=353-5*(80-55)/nE "Effect #6 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>5));
      parameter Modelica.Units.SI.Temperature T7=353-6*(80-55)/nE "Effect #7 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>6));
      parameter Modelica.Units.SI.Temperature T8=353-7*(80-55)/nE "Effect #8 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>7));
      parameter Modelica.Units.SI.Temperature T9=353-8*(80-55)/nE "Effect #9 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>8));
      parameter Modelica.Units.SI.Temperature T10=353-9*(80-55)/nE "Effect #10 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>9));
      parameter Modelica.Units.SI.Temperature T11=353-10*(80-55)/nE "Effect #11 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>10));
      parameter Modelica.Units.SI.Temperature T12=353-11*(80-55)/nE "Effect #12 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>11));
      parameter Modelica.Units.SI.Temperature T13=353-12*(80-55)/nE "Effect #13 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>12));
      parameter Modelica.Units.SI.Temperature T14=353-13*(80-55)/nE "Effect #14 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>13));
      parameter Modelica.Units.SI.Temperature T15=353-14*(80-55)/nE "Effect #15 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>14));
      parameter Modelica.Units.SI.Temperature T16=353-15*(80-55)/nE "Effect #16 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>15));

      parameter Modelica.Units.SI.Pressure P1=353 "Effect #1 Pressure"
      annotation (Dialog(tab="Pressures"));
      parameter Modelica.Units.SI.Pressure P2=0.7e5
                                                  -1*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #2 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>1));
      parameter Modelica.Units.SI.Pressure P3=0.7e5
                                                  -2*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #3 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>2));
      parameter Modelica.Units.SI.Pressure P4=0.7e5
                                                  -3*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #4 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>3));
      parameter Modelica.Units.SI.Pressure P5=0.7e5
                                                  -4*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #5 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>4));
      parameter Modelica.Units.SI.Pressure P6=0.7e5
                                                  -5*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #6 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>5));
      parameter Modelica.Units.SI.Pressure P7=0.7e5
                                                  -6*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #7 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>6));
      parameter Modelica.Units.SI.Pressure P8=0.7e5
                                                  -7*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #8 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>7));
      parameter Modelica.Units.SI.Pressure P9=0.7e5
                                                  -8*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #9 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>8));
      parameter Modelica.Units.SI.Pressure P10=0.7e5
                                                   -9*((0.7e5
                                                            -0.15e5))
                                                                    /nE "Effect #10 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>9));
      parameter Modelica.Units.SI.Pressure P11=0.7e5
                                                   -10*((0.7e5
                                                             -0.15e5))
                                                                     /nE "Effect #11 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>10));
      parameter Modelica.Units.SI.Pressure P12=0.7e5
                                                   -11*((0.7e5
                                                             -0.15e5))
                                                                     /nE "Effect #12 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>11));
      parameter Modelica.Units.SI.Pressure P13=0.7e5
                                                   -12*((0.7e5
                                                             -0.15e5))
                                                                     /nE "Effect #13 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>12));
      parameter Modelica.Units.SI.Pressure P14=0.7e5
                                                   -13*((0.7e5
                                                             -0.15e5))
                                                                     /nE "Effect #14 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>13));
      parameter Modelica.Units.SI.Pressure P15=0.7e5
                                                   -14*((0.7e5
                                                             -0.15e5))
                                                                     /nE "Effect #15 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>14));
      parameter Modelica.Units.SI.Pressure P16=0.7e5
                                                   -15*((0.7e5
                                                             -0.15e5))
                                                                     /nE "Effect #16 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>15));

      //Heat Transfer Area
      parameter Modelica.Units.SI.Area Ax1=3.26e4 "Effect #1 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area"));
      parameter Modelica.Units.SI.Area Ax2=1e6 "Effect #2 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>1));
      parameter Modelica.Units.SI.Area Ax3=5e5 "Effect #3 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>2));
      parameter Modelica.Units.SI.Area Ax4=3.1e5 "Effect #4 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>3));
      parameter Modelica.Units.SI.Area Ax5=2e5 "Effect #5 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>4));
      parameter Modelica.Units.SI.Area Ax6=8.8e4 "Effect #6 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>5));
      parameter Modelica.Units.SI.Area Ax7=8.2e4 "Effect #7 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>6));
      parameter Modelica.Units.SI.Area Ax8=7.3e4 "Effect #8 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>7));
      parameter Modelica.Units.SI.Area Ax9=1e4 "Effect #9 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>8));
      parameter Modelica.Units.SI.Area Ax10=1e4 "Effect #10 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>9));
      parameter Modelica.Units.SI.Area Ax11=1e4 "Effect #11 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>10));
      parameter Modelica.Units.SI.Area Ax12=1e4 "Effect #12 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>11));
      parameter Modelica.Units.SI.Area Ax13=1e4 "Effect #13 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>12));
      parameter Modelica.Units.SI.Area Ax14=1e4 "Effect #14 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>13));
      parameter Modelica.Units.SI.Area Ax15=1e4 "Effect #15 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>14));
      parameter Modelica.Units.SI.Area Ax16=1e4 "Effect #16 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>15));

      //Brine Flow Rate
      parameter Modelica.Units.SI.MassFlowRate m1=4 "Effect #1 Brine Flow"
      annotation (Dialog(tab="Brine Flow"));
      parameter Modelica.Units.SI.MassFlowRate m2=4 "Effect #2 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>1));
      parameter Modelica.Units.SI.MassFlowRate m3=4 "Effect #3 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>2));
      parameter Modelica.Units.SI.MassFlowRate m4=4 "Effect #4 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>3));
      parameter Modelica.Units.SI.MassFlowRate m5=4 "Effect #5 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>4));
      parameter Modelica.Units.SI.MassFlowRate m6=4 "Effect #6 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>5));
      parameter Modelica.Units.SI.MassFlowRate m7=4 "Effect #7 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>6));
      parameter Modelica.Units.SI.MassFlowRate m8=4 "Effect #8 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>7));
      parameter Modelica.Units.SI.MassFlowRate m9=4 "Effect #9 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>8));
      parameter Modelica.Units.SI.MassFlowRate m10=4 "Effect #10 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>9));
      parameter Modelica.Units.SI.MassFlowRate m11=4 "Effect #11 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>10));
      parameter Modelica.Units.SI.MassFlowRate m12=4 "Effect #12 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>11));
      parameter Modelica.Units.SI.MassFlowRate m13=4 "Effect #13 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>12));
      parameter Modelica.Units.SI.MassFlowRate m14=4 "Effect #14 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>13));
      parameter Modelica.Units.SI.MassFlowRate m15=4 "Effect #15 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>14));
      parameter Modelica.Units.SI.MassFlowRate m16=4 "Effect #16 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>15));




      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end MEE_Data;

    model MEE7_Data
      extends NHES.Desalination.MEE.BaseClasses.Record_Data;
      parameter Integer nE(max=16)=8   "Number of Effects";

      //Temperatures
      parameter Modelica.Units.SI.AbsolutePressure PS=1e5 "Steam Supply Pressure";
      parameter Modelica.Units.SI.Temperature T1=353 "Effect #1 Temperature"
      annotation (Dialog(tab="Temperatures"));
      parameter Modelica.Units.SI.Temperature T2=353-1*(80-55)/nE "Effect #2 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>1));
      parameter Modelica.Units.SI.Temperature T3=353-2*(80-55)/nE "Effect #3 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>2));
      parameter Modelica.Units.SI.Temperature T4=353-3*(80-55)/nE "Effect #4 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>3));
      parameter Modelica.Units.SI.Temperature T5=353-4*(80-55)/nE "Effect #5 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>4));
      parameter Modelica.Units.SI.Temperature T6=353-5*(80-55)/nE "Effect #6 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>5));
      parameter Modelica.Units.SI.Temperature T7=353-6*(80-55)/nE "Effect #7 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>6));
      parameter Modelica.Units.SI.Temperature T8=353-7*(80-55)/nE "Effect #8 Temperature"
      annotation (Dialog(tab="Temperatures",enable=nE>7));

      parameter Modelica.Units.SI.Pressure P1=353 "Effect #1 Pressure"
      annotation (Dialog(tab="Pressures"));
      parameter Modelica.Units.SI.Pressure P2=0.7e5
                                                  -1*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #2 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>1));
      parameter Modelica.Units.SI.Pressure P3=0.7e5
                                                  -2*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #3 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>2));
      parameter Modelica.Units.SI.Pressure P4=0.7e5
                                                  -3*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #4 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>3));
      parameter Modelica.Units.SI.Pressure P5=0.7e5
                                                  -4*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #5 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>4));
      parameter Modelica.Units.SI.Pressure P6=0.7e5
                                                  -5*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #6 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>5));
      parameter Modelica.Units.SI.Pressure P7=0.7e5
                                                  -6*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #7 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>6));
      parameter Modelica.Units.SI.Pressure P8=0.7e5
                                                  -7*((0.7e5
                                                           -0.15e5))
                                                                   /nE "Effect #8 Pressure"
      annotation (Dialog(tab="Pressures",enable=nE>7));
      //Heat Transfer Area
      parameter Modelica.Units.SI.Area Ax1=3.26e4 "Effect #1 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area"));
      parameter Modelica.Units.SI.Area Ax2=1e6 "Effect #2 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>1));
      parameter Modelica.Units.SI.Area Ax3=5e5 "Effect #3 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>2));
      parameter Modelica.Units.SI.Area Ax4=3.1e5 "Effect #4 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>3));
      parameter Modelica.Units.SI.Area Ax5=2e5 "Effect #5 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>4));
      parameter Modelica.Units.SI.Area Ax6=8.8e4 "Effect #6 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>5));
      parameter Modelica.Units.SI.Area Ax7=8.2e4 "Effect #7 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>6));
      parameter Modelica.Units.SI.Area Ax8=7.3e4 "Effect #8 Heat Transfer Area"
      annotation (Dialog(tab="Heat Transfer Area",enable=nE>7));

      //Brine Flow Rate
      parameter Modelica.Units.SI.MassFlowRate m1=4 "Effect #1 Brine Flow"
      annotation (Dialog(tab="Brine Flow"));
      parameter Modelica.Units.SI.MassFlowRate m2=4 "Effect #2 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>1));
      parameter Modelica.Units.SI.MassFlowRate m3=4 "Effect #3 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>2));
      parameter Modelica.Units.SI.MassFlowRate m4=4 "Effect #4 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>3));
      parameter Modelica.Units.SI.MassFlowRate m5=4 "Effect #5 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>4));
      parameter Modelica.Units.SI.MassFlowRate m6=4 "Effect #6 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>5));
      parameter Modelica.Units.SI.MassFlowRate m7=4 "Effect #7 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>6));
      parameter Modelica.Units.SI.MassFlowRate m8=4 "Effect #8 Brine Flow"
      annotation (Dialog(tab="Brine Flow",enable=nE>7));

     parameter Modelica.Units.SI.AbsolutePressure MP=2e5;
     parameter Modelica.Units.SI.MassFlowRate mM=2;

      annotation (Dialog(tab="Temperatures",enable=nE>15),
                  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end MEE7_Data;
  end Data;

  package ControlSystems
    model CS_TemperatureControlSystem

      extends BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      TRANSFORM.Controls.LimPID PID4(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,62},{0,82}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      TRANSFORM.Controls.LimPID PID6(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      TRANSFORM.Controls.LimPID PID7(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      TRANSFORM.Controls.LimPID PID8(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.6,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
    equation
      connect(sensorBus.T1set, PID1.u_s) annotation (Line(
          points={{-29.9,-99.9},{-30,-99.9},{-30,-50},{-22,-50}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T2set, PID2.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-10},{-22,-10}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T3set, PID3.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,30},{-22,30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T4set, PID4.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,72},{-22,72}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T5set, PID5.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-62},{-70,-62},{-70,-30},{-62,-30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T6set, PID6.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-62},{-70,-62},{-70,10},{-62,10}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T7set, PID7.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-62},{-70,-62},{-70,50},{-62,50}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T8set, PID8.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-62},{-70,-62},{-70,90},{-62,90}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T1, PID1.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-68},{-10,-68},{-10,-62}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T2, PID2.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-62},{-30,-62},{-30,-28},{-10,-28},{-10,
              -22}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T3, PID3.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,12},{-10,12},{-10,18}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T4, PID4.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,52},{-10,52},{-10,60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T5, PID5.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-50},{-50,-50},{-50,-42}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T6, PID6.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-8},{-50,-8},{-50,-2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T7, PID7.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,32},{-50,32},{-50,38}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T8, PID8.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,72},{-50,72},{-50,78}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV1_opening, PID1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-50},{1,-50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV2_opening, PID2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-10},{1,-10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV3_opening, PID3.y) annotation (Line(
          points={{30.1,-99.9},{30.1,30},{1,30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV4_opening, PID4.y) annotation (Line(
          points={{30.1,-99.9},{30.1,72},{1,72}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV5_opening, PID5.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-30},{-39,-30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV6_opening, PID6.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-48},{30,-48},{30,10},{-39,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV7_opening, PID7.y) annotation (Line(
          points={{30.1,-99.9},{30.1,50},{-39,50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV8_opening, PID8.y) annotation (Line(
          points={{30.1,-99.9},{30.1,90},{-39,90}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));
    end CS_TemperatureControlSystem;

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

    model CS_PressureControlSystem

      extends BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      TRANSFORM.Controls.LimPID PID4(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,62},{0,82}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      TRANSFORM.Controls.LimPID PID6(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      TRANSFORM.Controls.LimPID PID7(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      TRANSFORM.Controls.LimPID PID8(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.6,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
    equation
      connect(actuatorBus.CV1_opening, PID1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-50},{1,-50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV2_opening, PID2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-10},{1,-10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV3_opening, PID3.y) annotation (Line(
          points={{30.1,-99.9},{30.1,30},{1,30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV4_opening, PID4.y) annotation (Line(
          points={{30.1,-99.9},{30.1,72},{1,72}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV5_opening, PID5.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-30},{-39,-30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV6_opening, PID6.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-48},{30,-48},{30,10},{-39,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV7_opening, PID7.y) annotation (Line(
          points={{30.1,-99.9},{30.1,50},{-39,50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV8_opening, PID8.y) annotation (Line(
          points={{30.1,-99.9},{30.1,90},{-39,90}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.p1set, PID1.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-50},{-22,-50}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p2set, PID2.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-10},{-22,-10}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p3set, PID3.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,30},{-22,30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p4set, PID4.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,72},{-22,72}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p5set, PID5.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-60},{-68,-60},{-68,-30},{-62,-30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p6set, PID6.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-60},{-68,-60},{-68,10},{-62,10}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p7set, PID7.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-60},{-68,-60},{-68,50},{-62,50}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p8set, PID8.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-60},{-68,-60},{-68,90},{-62,90}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p1, PID1.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-68},{-10,-68},{-10,-62}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p2, PID2.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-28},{-10,-28},{-10,-22}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p3, PID3.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,12},{-10,12},{-10,18}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p4, PID4.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,54},{-10,54},{-10,60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p5, PID5.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-60},{-50,-60},{-50,-42}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p6, PID6.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-60},{-68,-60},{-68,-10},{-50,-10},{-50,
              -2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.p7, PID7.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-60},{-68,-60},{-68,30},{-50,30},{-50,38}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));

      connect(sensorBus.p8, PID8.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-60},{-68,-60},{-68,72},{-50,72},{-50,78}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));
    end CS_PressureControlSystem;

    model CS_TemperatureControlSystemMEETCV7

      extends NHES.Desalination.MEE.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID PID1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
      TRANSFORM.Controls.LimPID PID3(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      TRANSFORM.Controls.LimPID PID4(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-20,62},{0,82}})));
      TRANSFORM.Controls.LimPID PID5(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      TRANSFORM.Controls.LimPID PID6(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      TRANSFORM.Controls.LimPID PID7(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      TRANSFORM.Controls.LimPID PID8(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.6,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
      TRANSFORM.Controls.LimPID PID9(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      TRANSFORM.Controls.LimPID PID10(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.3,
        yMax=1,
        yMin=0)   annotation (Placement(transformation(extent={{60,-20},{80,0}})));
    equation
      connect(sensorBus.T1set, PID1.u_s) annotation (Line(
          points={{-29.9,-99.9},{-30,-99.9},{-30,-50},{-22,-50}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T2set, PID2.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-10},{-22,-10}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T3set, PID3.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,30},{-22,30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T4set, PID4.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,72},{-22,72}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T5set, PID5.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-62},{-70,-62},{-70,-30},{-62,-30}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T6set, PID6.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-62},{-70,-62},{-70,10},{-62,10}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T7set, PID7.u_s) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-62},{-70,-62},{-70,50},{-62,50}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T1, PID1.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-68},{-10,-68},{-10,-62}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T2, PID2.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-62},{-30,-62},{-30,-28},{-10,-28},{-10,
              -22}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T3, PID3.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,12},{-10,12},{-10,18}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T4, PID4.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,52},{-10,52},{-10,60}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T5, PID5.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-50},{-50,-50},{-50,-42}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T6, PID6.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,-8},{-50,-8},{-50,-2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.T7, PID7.u_m) annotation (Line(
          points={{-29.9,-99.9},{-29.9,32},{-50,32},{-50,38}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CV1_opening, PID1.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-50},{1,-50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV2_opening, PID2.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-10},{1,-10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV3_opening, PID3.y) annotation (Line(
          points={{30.1,-99.9},{30.1,30},{1,30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV4_opening, PID4.y) annotation (Line(
          points={{30.1,-99.9},{30.1,72},{1,72}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV5_opening, PID5.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-30},{-39,-30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV6_opening, PID6.y) annotation (Line(
          points={{30.1,-99.9},{30.1,-48},{30,-48},{30,10},{-39,10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CV7_opening, PID7.y) annotation (Line(
          points={{30.1,-99.9},{30.1,50},{-39,50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.MPset, PID8.u_s) annotation (Line(
          points={{-30,-100},{-30,-62},{-70,-62},{-70,90},{-62,90}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.MP, PID8.u_m) annotation (Line(
          points={{-30,-100},{-30,72},{-50,72},{-50,78}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.MCV_opening, PID8.y) annotation (Line(
          points={{30,-100},{30,90},{-39,90}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.mTVC, PID9.u_m) annotation (Line(
          points={{-30,-100},{-30,-68},{70,-68},{70,-62}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.TCVCV_opening, PID9.y) annotation (Line(
          points={{30,-100},{30,-76},{90,-76},{90,-50},{81,-50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.mMset, PID9.u_s) annotation (Line(
          points={{-30,-100},{-30,-68},{48,-68},{48,-50},{58,-50}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.mM, PID10.u_s) annotation (Line(
          points={{-30,-100},{-30,-68},{48,-68},{48,-10},{58,-10}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.mE, PID10.u_m) annotation (Line(
          points={{-30,-100},{-30,-68},{48,-68},{48,-28},{70,-28},{70,-22}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));

      connect(actuatorBus.ECV_opening, PID10.y) annotation (Line(
          points={{30,-100},{30,-76},{90,-76},{90,-10},{81,-10}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));
    end CS_TemperatureControlSystemMEETCV7;
  end ControlSystems;

end MEE;
