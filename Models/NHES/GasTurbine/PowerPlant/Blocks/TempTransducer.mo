within NHES.GasTurbine.PowerPlant.Blocks;
block TempTransducer "Temperature transducer"

  parameter Real K_RS1 = 0.15 "Gain of radiation shield";
  final parameter Real K_RS2 = 1- K_RS1 "Gain of radiation shield";
  parameter Modelica.Units.SI.Time T_RS=12.2 "Radiation shield time constant";
  parameter Modelica.Units.SI.Time T_TC=1.7 "Thermocouple time constant";
  parameter Real y_start
    "Initial or guess value of output for measured Te (= state)" annotation (Dialog(tab="Initialization", group="Thermocouple"));

  Modelica.Blocks.Interfaces.RealInput Te_pu( unit="1") annotation (Placement(
        transformation(extent={{-100,-10},{-80,10}}), iconTransformation(extent=
           {{-100,-10},{-80,10}})));
  Modelica.Blocks.Interfaces.RealOutput Te_mes_pu(unit="1") annotation (
      Placement(transformation(extent={{80,-10},{100,10}}), iconTransformation(
          extent={{80,-10},{100,10}})));
  Modelica.Blocks.Math.Add add(k1=1, k2=1)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Continuous.FirstOrder RadiationShield1(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    k=K_RS1,
    T=T_RS,
    y_start=Thermocouple.y_start*RadiationShield1.k)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  Modelica.Blocks.Math.Gain RadiationShield2(k=K_RS2)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Blocks.Continuous.FirstOrder Thermocouple(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=T_TC,
    y_start=y_start)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));

equation
  connect(Te_pu, RadiationShield2.u) annotation (Line(points={{-90,0},{-70,0},{-70,
          20},{-52,20}}, color={0,0,127}));
  connect(RadiationShield1.u, Te_pu) annotation (Line(points={{-52,-20},{-70,-20},
          {-70,0},{-90,0}}, color={0,0,127}));
  connect(RadiationShield2.y, add.u1) annotation (Line(points={{-29,20},{-14,20},
          {-14,6},{-2,6}}, color={0,0,127}));
  connect(RadiationShield1.y, add.u2) annotation (Line(points={{-29,-20},{-14,-20},
          {-14,-6},{-2,-6}}, color={0,0,127}));
  connect(Thermocouple.u, add.y)
    annotation (Line(points={{38,0},{21,0}}, color={0,0,127}));
  connect(Thermocouple.y, Te_mes_pu)
    annotation (Line(points={{61,0},{90,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
          Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),                           Text(
            extent={{-74,-26},{74,26}},
            textString="%name",
            lineColor={0,0,255},
          origin={0,2},
          rotation=0)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end TempTransducer;
