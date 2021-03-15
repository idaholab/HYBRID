within NHES.GasTurbine.PowerPlant.Blocks;
block FuelControlSystem "Fuel control system"

  parameter Modelica.Units.SI.Time TV=0.04 "Valve positoner time constant";
  parameter Modelica.Units.SI.Time TF=0.26 "Fuel system time constant";
  parameter Real K6 = 0.105961261304065 "Fuel valve lower limit";
  final parameter Real K3 = 1 - K6 "Ratio of fuel adjustment";
  final parameter Real Kf = 0 "Fuel system external feedback constant";

  Modelica.Blocks.Interfaces.RealInput VCE(unit="1") annotation (Placement(transformation(
          extent={{-100,-10},{-80,10}}), iconTransformation(extent={{-100,-10},{
            -80,10}})));
  Modelica.Blocks.Interfaces.RealOutput wf_pu( unit="1") annotation (Placement(
        transformation(extent={{80,-10},{100,10}}), iconTransformation(extent={{80,-10},
            {100,10}})));
  Modelica.Blocks.Continuous.FirstOrder ValvePositioner(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=1,
    T=TV)
    annotation (Placement(transformation(extent={{8,-10},{28,10}})));

  Modelica.Blocks.Continuous.FirstOrder FuelSystem(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=1,
    T=TF) annotation (Placement(transformation(extent={{40,-10},{60,10}})));

  Modelica.Blocks.Math.Add3 add(
    k3=-1,
    k1=1,
    k2=1) annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));
  Modelica.Blocks.Math.Gain FuelAdjustment(k=K3)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Constant FuelValveMin(k=K6)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

  Modelica.Blocks.Math.Gain ExternalFeedback(k=Kf)
    annotation (Placement(transformation(extent={{28,-50},{8,-30}})));

equation
  connect(FuelAdjustment.y, add.u2)
    annotation (Line(points={{-39,0},{-28,0}}, color={0,0,127}));
  connect(VCE, FuelAdjustment.u)
    annotation (Line(points={{-90,0},{-62,0}}, color={0,0,127}));
  connect(FuelValveMin.y, add.u1) annotation (Line(points={{-39,30},{-34,30},{-34,
          8},{-28,8}}, color={0,0,127}));
  connect(ExternalFeedback.y, add.u3) annotation (Line(points={{7,-40},{-34,-40},
          {-34,-8},{-28,-8}}, color={0,0,127}));
  connect(add.y, ValvePositioner.u)
    annotation (Line(points={{-5,0},{6,0}}, color={0,0,127}));
  connect(ValvePositioner.y, FuelSystem.u)
    annotation (Line(points={{29,0},{38,0}}, color={0,0,127}));
  connect(FuelSystem.y, wf_pu)
    annotation (Line(points={{61,0},{90,0}}, color={0,0,127}));
  connect(FuelSystem.y, ExternalFeedback.u) annotation (Line(points={{61,0},{70,
          0},{70,-40},{30,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                                                        graphics={
          Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),                           Text(
            extent={{-74,-26},{74,26}},
            textString="%name",
            lineColor={0,0,255},
          origin={0,2},
          rotation=0)}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end FuelControlSystem;
