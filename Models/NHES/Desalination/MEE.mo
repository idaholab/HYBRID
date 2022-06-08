within NHES.Desalination;
package MEE "Multi Effect Evaporators"
  package Single_Effect "Single effect evaporators"
    model Single_Effect_UA
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
      TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
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
    end Single_Effect_UA;

    model Single_Effect_Full_Cond
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
      TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_Outlet(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
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
    end Single_Effect_Full_Cond;

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
      parameter Modelica.Units.SI.PressureDifference dP=10;
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

      Liquid_Outlet_Port.p = p-(mdot/abs(mdot))*dP;
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
      MediumW.AbsolutePressure p(start=p_start, fixed=true);
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
  end Components;

  package Examples

    model Single_Effect_UA_Test "Test of a single effect with constant UA"

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1) annotation (Placement(transformation(extent={{-92,8},{-72,28}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=1.5,
        h=350500,
        nPorts=1) annotation (Placement(transformation(extent={{82,0},{62,20}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1) annotation (Placement(transformation(extent={{82,62},{62,82}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=0.08) annotation (Placement(transformation(extent={{84,26},{64,46}})));
      NHES.Desalination.MEE.Single_Effect.Single_Effect_UA sEE_mkUA(
        Psys=70000,
        UA=2.3847e5,
        V=0.5,
        A=1,
        KP=-40)
        annotation (Placement(transformation(extent={{-34,-28},{28,34}})));
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
      connect(sEE_mkUA.Brine_Outlet_Port, Brine_Oulet.ports[1]) annotation (
          Line(points={{-34,3},{-72,3},{-72,18}}, color={0,127,255}));
      connect(Brine_Inlet.ports[1], sEE_mkUA.Brine_Inlet_Port) annotation (Line(
            points={{62,10},{47,10},{47,3},{28,3}}, color={0,127,255}));
      connect(sEE_mkUA.Cs_In, realExpression.y) annotation (Line(points={{28,9.2},
              {28,14},{58,14},{58,36},{63,36}},       color={0,0,127}));
      connect(Steam_Exit.ports[1], sEE_mkUA.Steam_Outlet_Port)
        annotation (Line(points={{62,72},{-3,72},{-3,34}}, color={0,127,255}));
      connect(Tube_Inlet.ports[1], sEE_mkUA.Tube_Inlet) annotation (Line(points={{-50,-36},
              {-40,-36},{-40,-9.4},{-33.38,-9.4}},           color={0,127,255}));
      connect(Brine_Oulet1.ports[1], sEE_mkUA.Tube_Outlet) annotation (Line(
            points={{58,-28},{34,-28},{34,-9.4},{28.62,-9.4}}, color={0,127,255}));
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
      NHES.Desalination.MEE.Single_Effect.Single_Effect_Full_Cond sEE_mk6_1(
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
end MEE;
