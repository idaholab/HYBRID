within NHES.Desalination.MEE.Components;
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
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Gain Output Ratio (GOR) calculator</p>
<p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023 </p>
</html>"));
end GOR;
