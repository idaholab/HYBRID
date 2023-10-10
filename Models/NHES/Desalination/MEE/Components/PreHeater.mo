within NHES.Desalination.MEE.Components;
model PreHeater
  replaceable package Medium_1 =
      Modelica.Media.Interfaces.PartialMedium
  annotation (__Dymola_choicesAllMatching=true);
  replaceable package Medium_2 =
      Modelica.Media.Interfaces.PartialMedium
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

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a1(redeclare package Medium =
               Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}}),
        iconTransformation(extent={{-10,90},{10,110}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b1(redeclare package Medium =
               Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{90,50},{110,70}}),
        iconTransformation(extent={{-10,-110},{11,-88}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a2(redeclare package Medium =
               NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
    annotation (Placement(transformation(extent={{90,-70},{110,-50}}),
        iconTransformation(extent={{91,-10},{111,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b2(redeclare package Medium =
               NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
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
")}), Documentation(info="<html>
<p>Heat exchanger that allow heat from to be transfered to salt water.</p>
<p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023 </p>
</html>"));
end PreHeater;
