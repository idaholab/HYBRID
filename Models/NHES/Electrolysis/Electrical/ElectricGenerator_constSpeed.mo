within NHES.Electrolysis.Electrical;
model ElectricGenerator_constSpeed

  parameter SI.AngularVelocity w_fixed "Fixed speed";

  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (Placement(
        transformation(extent={{-94,-14},{-66,14}}, rotation=0),
        iconTransformation(extent={{-90,-10},{-70,10}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constSpeed(w_fixed=
        w_fixed, useSupport=false) annotation (Placement(transformation(extent={
            {-40,-10},{-60,10}}, rotation=0)));
  Sources.PrescribedPowerFlow electricGenerator
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Electrolysis.Interfaces.ElectricalPowerPort_b powerGeneration annotation (
     Placement(transformation(extent={{66,-14},{94,14}}, rotation=0),
        iconTransformation(extent={{70,-10},{90,10}})));

  Modelica.Blocks.Interfaces.RealInput W_GT( final unit="W", displayUnit="MW") annotation (Placement(
        transformation(extent={{16,-16},{-16,16}},
        rotation=90,
        origin={0,76}),                            iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={0,62})));
equation
  connect(shaft, constSpeed.flange)
    annotation (Line(points={{-80,0},{-70,0},{-60,0}}, color={0,0,0}));
  connect(electricGenerator.port_b, powerGeneration) annotation (Line(
      points={{60,0},{60,0},{80,0}},
      color={255,0,0},
      thickness=0.5));
  connect(W_GT, electricGenerator.P_flow)
    annotation (Line(points={{0,76},{0,0},{42,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                   Rectangle(
              extent={{-80,8},{-48,-8}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),Ellipse(
              extent={{50,-50},{-50,50}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Line(
          points={{50,0},{70,0}},
          color={255,0,0},
          thickness=0.5),Text(
              extent={{-26,26},{28,-26}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
          textStyle={TextStyle.UnderLine},
          textString="G"),
                   Text(
          extent={{-128,-58},{128,-98}},
          lineColor={0,0,255},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ElectricGenerator_constSpeed;
